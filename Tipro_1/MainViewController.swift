//
//  MainViewController.swift
//  Tipro_1
//
//  Created by soniclouds on 3/10/17.
//  Copyright © 2017 soniclouds. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
//MARK.................................VAR.....................
    var groupSize: Int = 1
    
    var currency = ["$"]
    var dollars = [String]()
    var cents = [String]()
    
    var venueImages = [#imageLiteral(resourceName: "restaurant_cocktails_1_blue"), #imageLiteral(resourceName: "delivery_1"), #imageLiteral(resourceName: "taxi_4")]
    // restaurant tip code
    var tipCode_Restaurant_minPercent = 0.15
    var tipCode_Restaurant_medPercent = 0.20
    var tipCode_Restaurant_maxPercent = 0.25
    // delivery tip code
    var tipCode_Delivery_minAmountInDollars = 2
    var tipCode_Delivery_medAmountInDollars = 5
    var tipCode_Delivery_minPercent = 0.15
    var tipCode_Delivery_medPercent = 0.20
    var tipCode_Delivery_maxPercent = 0.25
    // taxi tip code
    var tipCode_Taxi_minPercent = 0.10
    var tipCode_Taxi_medPercent = 0.18
    var tipCode_Taxi_maxPercent = 0.25
    
    var check = Bool()
    
    var selected_dollars = "0"
    var selected_cents = "00"
    
    var tipPercent = Double()
    
    var subtotal: String?
    
    var total: String?
    
    
    var groupSizes = [String]()
    
    
//MARK.................................FUNC....................
    
    // customize subTotalTextField
//    func custTF(){
//        let textField = subTotalTextField
//        let border = CALayer()
//        let width = CGFloat(0.3)
//        border.borderColor = UIColor.cyan.cgColor
//        border.opacity = 0.3
//        border.frame = CGRect(x: 0, y: (textField?.frame.size.height)! - width, width:  (textField?.frame.size.width)!, height: (textField?.frame.size.height)!)
//        
//        border.borderWidth = width
//        
//        textField?.layer.addSublayer(border)
//        textField?.layer.masksToBounds = true
//
//    }
    
    func setVenueButtons(){
        venuePickerButton.setImage(venueImages[0], for: .normal)
        venueCurrentButton.setImage(venueImages[0], for: .normal)
        venueOption_1.setImage(venueImages[1], for: .normal)
        venueOption_2.setImage(venueImages[2], for: .normal)
//        venueOption_3.setImage(images[3], for: .normal)
    }
    
    func calcTipPercent(){
        // if the selected venue is restaurant
        if venueImages[0] == #imageLiteral(resourceName: "restaurant_cocktails_1_blue") {
            // check which tip level level is visible
            if minTipLevelButton.isHidden == false {
                tipPercent = tipCode_Restaurant_minPercent
                tipSlider.value = Float(tipPercent)
            } else if medTipLevelButton.isHidden == false {
                tipPercent = tipCode_Restaurant_medPercent
                tipSlider.value = Float(tipPercent)
            } else if maxTipLevelButton.isHidden == false {
                tipPercent = tipCode_Restaurant_maxPercent
                tipSlider.value = Float(tipPercent)
            }
        }
        // if the selected venue is delivery
        if venueImages[0] == #imageLiteral(resourceName: "delivery_1") {
            // check which tip level level is visible
            if minTipLevelButton.isHidden == false {
                tipPercent = tipCode_Delivery_minPercent
                tipSlider.value = Float(tipPercent)
            } else if medTipLevelButton.isHidden == false {
                tipPercent = tipCode_Delivery_medPercent
                tipSlider.value = Float(tipPercent)
            } else if maxTipLevelButton.isHidden == false {
                tipPercent = tipCode_Delivery_maxPercent
                tipSlider.value = Float(tipPercent)
            }
        }
        // if venue is taxi
        if venueImages[0] == #imageLiteral(resourceName: "taxi_4") {
            // check which tip level level is visible
            if minTipLevelButton.isHidden == false {
                tipPercent = tipCode_Taxi_minPercent
                tipSlider.value = Float(tipPercent)
            } else if medTipLevelButton.isHidden == false {
                tipPercent = tipCode_Taxi_medPercent
                tipSlider.value = Float(tipPercent)
            } else if maxTipLevelButton.isHidden == false {
                tipPercent = tipCode_Taxi_maxPercent
                tipSlider.value = Float(tipPercent)
            }
        }
        check = false
        calculate()
    }
    
    func sortImagesArray(_ sender: UIButton) {
        var tempArray = [UIImage]()
        // get the tag
        var id = sender.tag
        // populate the new array
        var count = 0
        while count < venueImages.count {
            if id < venueImages.count {
                tempArray.append(self.venueImages[id])
                id += 1
            } else {
                id = 0
                tempArray.append(self.venueImages[id])
                id += 1
            }
            count += 1
        }
        venueImages = tempArray
        setVenueButtons()
    }
    
    // populate dollars array (all dollars up to 1,000)
    func dollarsGenerator () {
        for var i in 0..<1001 {
            dollars.append(String(i))
            i += 1
        }
    }
    // populate cents array (all cents up to 99)
    func centsGenerator () {
        for var i in 0..<100 {
            if i < 10 {
                var j = String(i)
                j = "0\(j)"
                cents.append(j)
                
            } else {
                cents.append(String(i))
            }
            i += 1
        }
    }
    // populate groupSize array
    func groupSizesGenerator(){
        for var i in 1..<50 {
            groupSizes.append(String(i))
            i += 1
        }
    }
    
    
    func changeTip(_ sender: UISlider) {
        let tipVal = lround(Double(sender.value * 100))
        print("sender value: ", sender.value)
        print ("tipVal: ", tipVal)
        tipPercent = Double(tipVal) / Double(100)
        print("tipPercent: ", tipPercent)
        calculate()
        if check == false {
            check = true
        }
    }
    func adjustTip(){
        
    }
    
    
    // concatenate subtotal string from picker values
    func concatSubtotal(){
        subtotal = "\(selected_dollars).\(selected_cents)"
    }
    
    func calculate(){
        tipSlider.minimumTrackTintColor = UIColor.cyan
        if groupSize == 1 {
            youPayLabel.text = "you pay"
        } else {
            youPayLabel.text = "each pays"
        }
        
        if sliderLabel.isHidden == true {
            sliderLabel.isHidden = false
        }
        if tipSlider.isHidden == true {
            tipSlider.isHidden = false
        }
        if youPayLabel.isHidden == true {
            youPayLabel.isHidden = false
        }
        if totalLabel.isHidden == true {
            totalLabel.isHidden = false
        }
        if tipLabel.isHidden == true {
            tipLabel.isHidden = false
        }
        if tipAmountLabel.isHidden == true {
            tipAmountLabel.isHidden = false
        }
//        if currencyPickerSmall.isHidden == true {
//            currencyPickerSmall.isHidden = false
//        }
//        if refreshButton.isHidden == true {
//            refreshButton.isHidden = false
//        }
        // check that we can access this variable
        print (groupSize)
        
        // get the current subtotal // turns the subtotal string into a number
        var subTotalDouble: Double = 0
        if subTotalTextField.text != "" {
            subTotalDouble = Double(subTotalTextField.text!)! // subtotal is a Double
        }
        
        // since I have all my data, calculate the tip amount and the grand total
        
        var tipAmount = Double()
        
        if venueImages[0] == #imageLiteral(resourceName: "delivery_1") {
            if subTotalDouble > 0 && subTotalDouble < 10 {
                if check == false {
                    tipSlider.minimumTrackTintColor = UIColor.gray
                    if minTipLevelButton.isHidden == false {
                        tipAmount = 2.00
                        tipPercent = Double(round((tipAmount / subTotalDouble) * 100) / 100)
                        print("tipPercent: ", tipPercent)
                        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                        tipSlider.value = Float(tipPercent)
                    }
                    if medTipLevelButton.isHidden == false {
                        tipAmount = 5.00
                        tipPercent = Double(round((tipAmount / subTotalDouble) * 100) / 100)
                        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                        tipSlider.value = Float(tipPercent)
                    }
                    if maxTipLevelButton.isHidden == false {
                        tipAmount = 10.00
                        tipPercent = Double(round((tipAmount / subTotalDouble) * 100) / 100)
                        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                        tipSlider.value = Float(tipPercent)
                    }
                } else {
                    tipAmount = (round((subTotalDouble * Double(tipPercent)) * 100)) / 100
                    sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                    tipSlider.value = Float(tipPercent)
                }
            } else {
                if check == false {
                    if minTipLevelButton.isHidden == false {
                        tipPercent = tipCode_Delivery_minPercent
                        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                        tipSlider.value = Float(tipPercent)
                        tipAmount = (round((subTotalDouble * Double(tipPercent)) * 100)) / 100
                    }
                    if medTipLevelButton.isHidden == false {
                        tipPercent = tipCode_Delivery_medPercent
                        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                        tipSlider.value = Float(tipPercent)
                        tipAmount = (round((subTotalDouble * Double(tipPercent)) * 100)) / 100
                    }
                    if maxTipLevelButton.isHidden == false {
                        tipPercent = tipCode_Delivery_maxPercent
                        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                        tipSlider.value = Float(tipPercent)
                        tipAmount = (round((subTotalDouble * Double(tipPercent)) * 100)) / 100
                    }
                } else {
                    tipAmount = (round((subTotalDouble * Double(tipPercent)) * 100)) / 100
                    sliderLabel.text = String(Int(tipPercent * 100)) + "%"
                    tipSlider.value = Float(tipPercent)
                }
            }
        } else {
            tipAmount = (round((subTotalDouble * Double(tipPercent)) * 100)) / 100
            sliderLabel.text = String(Int(tipPercent * 100)) + "%"
            tipSlider.value = Float(tipPercent)
        }

        let total = (subTotalDouble + tipAmount) / Double(groupSize)

        // now that we have our data, let's populate the screen!
        
        // update the tip amounts
        
        tipAmountLabel.text = String(format: "%.2f", tipAmount)

        // update the total amount
        
        totalLabel.text = String(format: "%.2f", total)

        if subtotal == "0.00" {
            sliderLabel.isHidden = true
            tipSlider.isHidden = true
            youPayLabel.isHidden = true
            totalLabel.isHidden = true
            tipLabel.isHidden = true
            tipAmountLabel.isHidden = true
            currencyPickerSmall.isHidden = true
            refreshButton.isHidden = true
            subTotalTextField.text = ""
        }
    }
    
    
//MARK.................................DELEGATE METHODS........
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == currencyPicker || pickerView == currencyPickerSmall {
            return 1
        } else if pickerView == dollarPicker {
            return dollars.count
        } else if pickerView == centsPicker {
            return cents.count
        } else {
            return groupSizes.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == currencyPicker {
            let pickerLabel = UILabel()
            pickerLabel.textColor = .cyan
            pickerLabel.textAlignment = .center
            pickerLabel.text = String(self.currency[row])
            pickerLabel.font = UIFont(name:"Helvetica", size: 35)
            return pickerLabel
        } else if pickerView == currencyPickerSmall {
            let pickerLabel = UILabel()
            pickerLabel.textColor = .cyan
            pickerLabel.textAlignment = .right
            pickerLabel.text = String(self.currency[row])
            pickerLabel.font = UIFont(name:"Helvetica", size: 12)
            return pickerLabel
        } else if pickerView == dollarPicker {
            let pickerLabel = UILabel()
            pickerLabel.textColor = .cyan
            pickerLabel.textAlignment = .center
            pickerLabel.text = String(self.dollars[row])
            pickerLabel.font = UIFont(name:"Helvetica", size: 45)
            return pickerLabel
        } else if pickerView == centsPicker {
            let pickerLabel = UILabel()
            pickerLabel.textColor = .cyan
            pickerLabel.textAlignment = .center
            pickerLabel.text = String(self.cents[row])
            pickerLabel.font = UIFont(name:"Helvetica", size: 45)
            return pickerLabel
        } else {
            let pickerLabel = UILabel()
            pickerLabel.textColor = .cyan
            pickerLabel.textAlignment = .left
            pickerLabel.text = String(self.groupSizes[row])
            pickerLabel.font = UIFont(name:"Helvetica Bold", size: 15)
            return pickerLabel
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 46.0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currencyPicker || pickerView == currencyPickerSmall {
            print(currency[row])
        } else if pickerView == dollarPicker {
            print(dollars[row])
            selected_dollars = dollars[row]
            concatSubtotal()
            subTotalTextField.text = subtotal
            calculate()
            print("subtotal: ", self.subtotal!)
        } else if pickerView == centsPicker {
            print(cents[row])
            selected_cents = cents[row]
            concatSubtotal()
            subTotalTextField.text = subtotal
            calculate()
            print("subtotal: ", self.subtotal!)
        } else {
            print(groupSizes[row])
            groupSize = Int(groupSizes[row])!
            calculate()
        }
    }
    
//MARK.................................OUT.....................
    
    @IBOutlet weak var minTipLevelButton: UIButton!
    @IBOutlet weak var medTipLevelButton: UIButton!
    @IBOutlet weak var maxTipLevelButton: UIButton!
    
    @IBOutlet weak var venuePickerButton: UIButton!
    @IBOutlet weak var venueCurrentButton: UIButton!
    
    @IBOutlet weak var venuePickerStackView: UIStackView!
    
    @IBOutlet weak var venueOption_1: UIButton!
    
    @IBOutlet weak var venueOption_2: UIButton!
    
    @IBOutlet weak var venueOption_3: UIButton!
    
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    
    
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var currencyPickerSmall: UIPickerView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var dollarPicker: UIPickerView!
    
    @IBOutlet weak var centsPicker: UIPickerView!
    
    @IBOutlet weak var groupSizePicker: UIPickerView!
    
    @IBOutlet weak var subTotalTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var youPayLabel: UILabel!
    
//    @IBOutlet weak var subTotalLabel: UILabel!

    
//MARK.................................ACT.....................
    
    @IBAction func tipLevelButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            medTipLevelButton.isHidden = true
            maxTipLevelButton.isHidden = false
            calcTipPercent()
        } else if sender.tag == 2 {
            maxTipLevelButton.isHidden = true
            minTipLevelButton.isHidden = false
            calcTipPercent()
        } else {
            minTipLevelButton.isHidden = true
            medTipLevelButton.isHidden = false
            calcTipPercent()
        }
    }
    
    @IBAction func venuePickerButtonPressed(_ sender: UIButton) {
        venuePickerStackView.isHidden = false
        venuePickerButton.isHidden = true
    }
    @IBAction func venueCurrentButtonPressed(_ sender: UIButton) {
        venuePickerStackView.isHidden = true
        venuePickerButton.isHidden = false
    }
    @IBAction func venueOptionButtonPressed(_ sender: UIButton) {
        sortImagesArray(sender)
        venuePickerStackView.isHidden = true
        venuePickerButton.isHidden = false
        calcTipPercent()
    }
  
    @IBAction func tipSlider(_ sender: UISlider) {
        sliderLabel.isHidden = false
        if tipSlider.minimumTrackTintColor == UIColor.gray {
            tipSlider.minimumTrackTintColor = UIColor.cyan
        }
        changeTip(sender)
    }
    
//MARK.................................UI LIFECYCLE...........
    override func viewDidLoad() {
        super.viewDidLoad()
        check = false
        
        venuePickerStackView.isHidden = true
        venuePickerButton.layer.cornerRadius = 10
        venueCurrentButton.layer.cornerRadius = 10
        venueOption_1.layer.cornerRadius = 10
        venueOption_2.layer.cornerRadius = 10
        venueOption_3.layer.cornerRadius = 10
        
//        custTF()
        setVenueButtons()
        calcTipPercent()
        
        sliderLabel.text = String(Int(tipPercent * 100)) + "%"
        tipSlider.value = Float(tipPercent)
        tipSlider.setThumbImage(#imageLiteral(resourceName: "blue_circle__small"), for: .normal)

        
        sliderLabel.isHidden = true
        tipSlider.isHidden = true
        youPayLabel.isHidden = true
        totalLabel.isHidden = true
        tipLabel.isHidden = true
        tipAmountLabel.isHidden = true
        
        currencyPickerSmall.isHidden = true
        refreshButton.isHidden = true
//        groupSizePicker.isHidden = true
        
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.cyan.cgColor
        circleView.layer.cornerRadius = 120
        
        groupSizesGenerator()
        dollarsGenerator()
        centsGenerator()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPickerSmall.delegate = self
        currencyPickerSmall.dataSource = self
        dollarPicker.delegate = self
        dollarPicker.dataSource = self
        centsPicker.delegate = self
        centsPicker.dataSource = self
        
        groupSizePicker.delegate = self
        groupSizePicker.dataSource = self
        
//        subTotalLabel.text = "0"
        groupSize = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

