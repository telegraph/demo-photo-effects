//
//  ViewController.swift
//  Filter Demo
//
//  Created by Michael Baldock on 21/03/2019.
//  Copyright © 2019 Michael Baldock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let imageURL = URL(fileURLWithPath: "\(Bundle.main.bundlePath)/whitewalker.png")
  let posterizeLevelMaximum: Double = 20
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var posterizeSlider: UISlider!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    applyFilters()
  }

  @IBAction func applyFilters() {

    guard let originalImage = CIImage(contentsOf: imageURL),
          let posterizedImage = posterize(originalImage, atLevel: Double(posterizeSlider.value)) else {
      print("Something went wrong, unable to apply filter")
      return
    }

    let context = CIContext()
    let cgImage = context.createCGImage(posterizedImage, from: posterizedImage.extent)
    imageView.image = UIImage(cgImage: cgImage!)
  }

  func posterize(_ image:CIImage, atLevel level:Double) -> CIImage? {

    let posterizeFilter = CIFilter(name: "CIColorPosterize")
    posterizeFilter?.setValue(image, forKey: kCIInputImageKey)
    posterizeFilter?.setValue(NSNumber(value: level*posterizeLevelMaximum), forKey: "inputLevels")
    return posterizeFilter?.outputImage
  }

}

