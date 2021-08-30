//
//  ViewController.swift
//  knobie3d
//
//  Created by Ugur Genc on 21.07.2021.
//

import UIKit
import SceneKit
import ARKit

//RECIPE CARD STRUCT

struct Recipe {
    var id = ""
    var name = ""
    var color = UIColor()
    var seasonality = 0.0
    var locality = 0.0
    var cost = 0.0
    var frugality = 0.0
    var seasonal_suggestion = ""
    var locality_suggestion = ""
    var cost_suggestion = ""
    var frugality_suggestion = ""
}

//HEX COLOR TO UICOLOR

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

//RECIPE CARD DATA

let recipe1 = Recipe(
    id: "recipe1",
    name: "Cinnamon Roll Pie",
    color: UIColor(rgb: 0xBE7B2B),
    seasonality: 3.2,
    locality: 4.1,
    cost: 5,
    frugality: 2.7,
    seasonal_suggestion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel metus sit amet nulla. Lorem ipsum dolor sit amet, consectetur.",
    locality_suggestion: "Ut vitae lorem vel ante lacinia tincidunt et at odio. Cras iaculis diam laoreet nisi blandit.",
    cost_suggestion: "Curabitur lobortis dignissim lectus, quis dignissim purus porta et. Vestibulum faucibus.",
    frugality_suggestion: "Fusce quis tristique sapien. Donec ac nibh in leo rutrum efficitur. Sed ac turpis ac arcu."
)

let recipe2 = Recipe(
    id: "recipe2",
    name: "Paella",
    color: UIColor(rgb: 0x24645C),
    seasonality: 1.4,
    locality: 5.2,
    cost: 4.6,
    frugality: 3,
    seasonal_suggestion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel metus sit amet nulla.",
    locality_suggestion: "Ut vitae lorem vel ante lacinia tincidunt et at odio. Cras iaculis diam laoreet nisi blandit.",
    cost_suggestion: "Curabitur lobortis dignissim lectus, quis dignissim purus porta et. Vestibulum faucibus.",
    frugality_suggestion: "Fusce quis tristique sapien. Donec ac nibh in leo rutrum efficitur. Sed ac turpis ac arcu."
)

let recipe3 = Recipe(
    id: "recipe3",
    name: "Grilled Lamb Cutlets with Pesto",
    color: UIColor(rgb: 0x54682E),
    seasonality: 5.0,
    locality: 3.0,
    cost: 4.0,
    frugality: 3.0,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe4 = Recipe(
    id: "recipe4",
    name: "Snapper Escovitch",
    color: UIColor(rgb: 0xD99A28),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe5 = Recipe(
    id: "recipe5",
    name: "Panna Cotta",
    color: UIColor(rgb: 0xAF4544),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe6 = Recipe(
    id: "recipe6",
    name: "Pork-Kimchi Dumplings Pancakes",
    color: UIColor(rgb: 0x3D4950),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe7 = Recipe(
    id: "recipe7",
    name: "Macarons with Honeycomb Ganache",
    color: UIColor(rgb: 0x721953),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe8 = Recipe(
    id: "recipe8",
    name: "Salmon Niçoise",
    color: UIColor(rgb: 0x412F70),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe9 = Recipe(
    id: "recipe9",
    name: "Beef Curry Stew",
    color: UIColor(rgb: 0x64B1D9),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipe10 = Recipe(
    id: "recipe10",
    name: "Grilled Salmon Kabobs",
    color: UIColor(rgb: 0x236331),
    seasonality: 5,
    locality: 3,
    cost: 4,
    frugality: 3,
    seasonal_suggestion: "",
    locality_suggestion: "",
    cost_suggestion: "",
    frugality_suggestion: ""
)

let recipes = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9, recipe10]

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        /* Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "RecipeCards", bundle: Bundle.main) {
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 20
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        let boxHeight = CGFloat(0.05)
        let boxWidth = CGFloat(0.05)
     
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let backgroundPlane = SCNPlane (width: 1000, height: 1000)
           // backgroundPlane.firstMaterial?.diffuse.contents = UIColor.black;
            
            
//            BÜYÜK İHTİMALLE  BU KUTULAR TEK BİR FONKSİYONDA YAPILABİLİRDİ AMA
//            MAALESEF BİLGİM YOK :D PROJE ZAMANI İÇİN UĞRAŞIYORUM.
            
//            HER BİR TAKİP EDİLEN KAR İÇİN 4 AYRI PUAN KUTU OLUŞTURUYORUZ.
//            SEASONALİTYY, LOCALİTY, COST VE FRUGALİTY KARTLARI
            let firstBox = SCNPlane(
                width: boxWidth,
                height: boxHeight)
            firstBox.cornerRadius = 0.003
            
            let secondBox = SCNPlane(
                width: boxWidth,
                height: boxHeight)
            secondBox.cornerRadius = 0.003
            
            let thirdBox = SCNPlane(
                width: boxWidth,
                height: boxHeight)
            thirdBox.cornerRadius = 0.003
            
            let forthBox = SCNPlane(
                width: boxWidth,
                height: boxHeight)
            forthBox.cornerRadius = 0.003

            let material = SCNMaterial()
            material.diffuse.contents = UIColor.white
            let pointMaterial = SCNMaterial()
            
            //OVERALL POINTS
            var seasonalityPoint = 0.0

            //TITLES
            
            let seasonalityTitle = SCNText(string: "Seasonality", extrusionDepth:  0.2)
            seasonalityTitle.materials = [material]
            seasonalityTitle.font = UIFont(name: "Helvetica", size: 7)!
            seasonalityTitle.alignmentMode = "center"
            seasonalityTitle.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 10.0))
            seasonalityTitle.isWrapped = true

            let localityTitle = SCNText(string: "Locality", extrusionDepth:  0.2)
            localityTitle.materials = [material]
            localityTitle.font = UIFont(name: "Helvetica", size: 6)!
            localityTitle.alignmentMode = "center"
            localityTitle.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 8.0))
            localityTitle.isWrapped = true

            let costTitle = SCNText(string: "Cost", extrusionDepth:  0.2)
            costTitle.materials = [material]
            costTitle.font = UIFont(name: "Helvetica", size: 6)!
            costTitle.alignmentMode = "center"
            costTitle.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 8.0))
            costTitle.isWrapped = true

            let frugalityTitle = SCNText(string: "Frugality", extrusionDepth:  0.2)
            frugalityTitle.materials = [material]
            frugalityTitle.font = UIFont(name: "Helvetica", size: 6)!
            frugalityTitle.alignmentMode = "center"
            frugalityTitle.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 8.0))
            frugalityTitle.isWrapped = true
            //POINTS
            
            
            
            //HER BİR KUTUNUN İÇİNE DE O TARİFİN DATASINDAN GELEN 4 FARKLI PUAN İÇİN TEXT NODEU OLUŞTURUYORUZ.
            let pointFontSize = 25
            
            let seasonalityText = SCNText(string: "", extrusionDepth: 0.2)
            material.diffuse.contents = UIColor.white
            seasonalityText.materials = [material]
            seasonalityText.font = UIFont(name: "Helvetica", size: CGFloat(pointFontSize))!
            seasonalityText.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 40.0))
            seasonalityText.isWrapped = true
            seasonalityText.alignmentMode = "center"
            seasonalityText.flatness = 0.01
            
            let localityText = SCNText(string: "", extrusionDepth:  0.2)
            material.diffuse.contents = UIColor.white
            localityText.materials = [material]
            localityText.font = UIFont(name: "Helvetica", size: CGFloat(pointFontSize))!
            localityText.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 40.0))
            localityText.isWrapped = true
            localityText.alignmentMode = "center"
            localityText.flatness = 0.01
            
            let costText = SCNText(string: "", extrusionDepth:  0.2)
            material.diffuse.contents = UIColor.white
            costText.materials = [material]
            costText.font = UIFont(name: "Helvetica", size: CGFloat(pointFontSize))!
            costText.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 40.0))
            costText.isWrapped = true
            costText.alignmentMode = "center"
            costText.flatness = 0.01

            
            let frugalityText = SCNText(string: "", extrusionDepth:  0.2)
            material.diffuse.contents = UIColor.white
            frugalityText.materials = [material]
            frugalityText.font = UIFont(name: "Helvetica", size: CGFloat(pointFontSize))!
            frugalityText.containerFrame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 40.0))
            frugalityText.isWrapped = true
            frugalityText.alignmentMode = "center"
            frugalityText.flatness = 0.01

            
            
//            BURADA RECİPENİN KENDİ RENGİ, PUANLARI VB GİBİ TANILMA İŞİ YAPIYORUZ.
            for recipe in recipes {
                if (imageAnchor.referenceImage.name == recipe.id)  {
                    
                    
//                    BURASI EN ÖNEMLİ PROJEDE EKSİK KISIM.
//                    ASAGIDA SEASONLİTY POINT DEĞİŞKENİ GÖRÜNEN KARTLARIN TOPLAMI OLSUN İSTİYORUZ.
                    
//                    ÖRNEĞİN EKRANDA 3 KART GÖRÜNÜYOR BUNLARIN SEASONALİTY
//                    PUANLARI 3-4-6 DİYELİM. TOPLAMDA 13 GÖSTERMEK İSTİYORUZ.
//                    ŞUANKİ HALDE, SON GÖRÜNTÜLENEN KARTIN PUANI GELİYOR
//                    VE TELEFONDA BAHSETTİĞİM GİBİ DE BİR KART GÖRÜNDÜKTEN SONRA
//                    BİR DAHA O FONKSİYON ÇALIŞMADIĞI İÇİN HESAPLAMA OLMUYOR.
                    
                    seasonalityPoint = seasonalityPoint + recipe.seasonality
                    print(seasonalityPoint)
                    
                    firstBox.firstMaterial?.diffuse.contents = recipe.color
                    secondBox.firstMaterial?.diffuse.contents = recipe.color
                    thirdBox.firstMaterial?.diffuse.contents = recipe.color
                    forthBox.firstMaterial?.diffuse.contents = recipe.color
                                                            
                    if (recipe.seasonality <= 2) {
                        firstBox.firstMaterial?.diffuse.contents = UIColor.red
                    }
                    if (recipe.locality <= 2) {
                        secondBox.firstMaterial?.diffuse.contents = UIColor.red
                    }
                    if (recipe.cost <= 2) {
                        thirdBox.firstMaterial?.diffuse.contents = UIColor.red
                    }
                    if (recipe.frugality <= 2) {
                        forthBox.firstMaterial?.diffuse.contents = UIColor.red
                    }
                    
                   
                    pointMaterial.diffuse.contents = recipe.color
                    seasonalityText.string = NSString(format: "%.1f", recipe.seasonality)
                    localityText.string = NSString(format: "%.1f", recipe.locality)
                    costText.string = NSString(format: "%.1f", recipe.cost)
                    frugalityText.string = NSString(format: "%.1f", recipe.frugality)
                    
                }
            }
            
            let rightLimit = Float(imageAnchor.referenceImage.physicalSize.width/1.2)
            let topLimit = -Float(imageAnchor.referenceImage.physicalSize.height / 2.3)
            let verticalShift = Float(boxHeight + boxHeight / 10);
            
            //TITLES IN AR // POSITIONING
            let seasonalityTitleNode = SCNNode()
            seasonalityTitleNode.eulerAngles.x = -.pi / 2
            seasonalityTitleNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            seasonalityTitleNode.geometry = seasonalityTitle
            seasonalityTitleNode.position.x = rightLimit - 0.02
            seasonalityTitleNode.position.z = topLimit - 0.013
            
            let localityTitleNode = SCNNode()
            localityTitleNode.eulerAngles.x = -.pi / 2
            localityTitleNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            localityTitleNode.geometry = localityTitle
            localityTitleNode.position.x = rightLimit - 0.02
            localityTitleNode.position.z = topLimit  + verticalShift - 0.013
            
            let costTitleNode = SCNNode()
            costTitleNode.eulerAngles.x = -.pi / 2
            costTitleNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            costTitleNode.geometry = costTitle
            costTitleNode.position.x = rightLimit - 0.02
            costTitleNode.position.z = topLimit + verticalShift * 2  - 0.013
            
            let frugalityTitleNode = SCNNode()
            frugalityTitleNode.eulerAngles.x = -.pi / 2
            frugalityTitleNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            frugalityTitleNode.geometry = frugalityTitle
            frugalityTitleNode.position.x = rightLimit - 0.02
            frugalityTitleNode.position.z = topLimit + verticalShift * 3 - 0.013
            
            //SUGGESTIONS IN AR
            
            let seasonalityNode = SCNNode()
            seasonalityNode.eulerAngles.x = -.pi / 2
            seasonalityNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            seasonalityNode.geometry = seasonalityText
            seasonalityNode.position.x = rightLimit - 0.02
            seasonalityNode.position.z = topLimit + 0.028
            
            let localityNode = SCNNode()
            localityNode.eulerAngles.x = -.pi / 2
            localityNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            localityNode.geometry = localityText
            localityNode.position.x = rightLimit - 0.02
            localityNode.position.z = topLimit + verticalShift + 0.028
            
            let costNode = SCNNode()
            costNode.eulerAngles.x = -.pi / 2
            costNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            costNode.geometry = costText
            costNode.position.x = rightLimit - 0.02
            costNode.position.z = topLimit + verticalShift * 2 + 0.028
            
            let frugalityNode = SCNNode()
            frugalityNode.eulerAngles.x = -.pi / 2
            frugalityNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
            frugalityNode.geometry = frugalityText
            frugalityNode.position.x = rightLimit - 0.02
            frugalityNode.position.z = topLimit + verticalShift * 3 + 0.028
            
            

            let firstNode = SCNNode(geometry: firstBox)
            firstNode.eulerAngles.x = -.pi / 2
            firstNode.position.x = rightLimit
            firstNode.position.z = topLimit

            
            let backgroundNode = SCNNode(geometry: backgroundPlane)
            backgroundNode.eulerAngles.x = -.pi / 2
            backgroundNode.position.x = 0
            backgroundNode.position.z = 0
            backgroundNode.position.y = -4

            let secondNode = SCNNode(geometry: secondBox)
            secondNode.eulerAngles.x = -.pi / 2
            secondNode.position.x = rightLimit
            secondNode.position.z = topLimit + verticalShift
            
            let thirdNode = SCNNode(geometry: thirdBox)
            thirdNode.eulerAngles.x = -.pi / 2
            thirdNode.position.x = rightLimit
            thirdNode.position.z = topLimit + verticalShift * 2

            let forthNode = SCNNode(geometry: forthBox)
            forthNode.eulerAngles.x = -.pi / 2
            forthNode.position.x = rightLimit
            forthNode.position.z = topLimit + verticalShift * 3
            
            node.addChildNode(seasonalityNode)
            node.addChildNode(localityNode)
            node.addChildNode(costNode)
            node.addChildNode(frugalityNode)
            node.addChildNode(backgroundNode)

            node.addChildNode(firstNode)
            node.addChildNode(secondNode)
            node.addChildNode(thirdNode)
            node.addChildNode(forthNode)
            
            node.addChildNode(seasonalityTitleNode)
            node.addChildNode(localityTitleNode)
            node.addChildNode(costTitleNode)
            node.addChildNode(frugalityTitleNode)
           
        }

        
        return node
    }
    
   
}
