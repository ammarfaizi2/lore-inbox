Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRBFVpy>; Tue, 6 Feb 2001 16:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRBFVpp>; Tue, 6 Feb 2001 16:45:45 -0500
Received: from ensta.ensta.fr ([147.250.1.1]:3334 "EHLO ensta.ensta.fr")
	by vger.kernel.org with ESMTP id <S129759AbRBFVp3>;
	Tue, 6 Feb 2001 16:45:29 -0500
Date: Tue, 6 Feb 2001 22:44:51 +0100
From: Francois romieu <romieu@ensta.fr>
To: linux-kernel@vger.kernel.org
Cc: apdim@grecian.net
Subject: [PATCH] drivers/media/radio/radio-maxiradio.c - 2.4.1-ac4
Message-ID: <20010206224451.A24412@ensta.fr>
Reply-To: Francois romieu <romieu@cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14QEjh-0006Vq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uX-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
- pci_enable_device return value wasn't checked,
- unbalanced video_register_device if late failure in radio_install,
- request_region is now done on the whole resource size (if it's wrong, the
magic value "4" deserves a small comment imho),
- new pci interface beautification (may help the multi-devices case).
Test:
- it compiles great (TM)

Diff output is rather weird

--- linux-2.4.1-ac4.orig/drivers/media/radio/radio-maxiradio.c	Tue Feb  6 21:48:07 2001
+++ linux-2.4.1-ac4/drivers/media/radio/radio-maxiradio.c	Tue Feb  6 22:31:02 2001
@@ -308,80 +308,77 @@
 {
 }
 
-
-inline static __u16 radio_install(struct pci_dev *pcidev);
-
 MODULE_AUTHOR("Dimitromanolakis Apostolos, apdim@grecian.net");
 MODULE_DESCRIPTION("Radio driver for the Guillemot Maxi Radio FM2000 radio.");
 
 EXPORT_NO_SYMBOLS;
 
-void __exit maxiradio_radio_exit(void)
+static int __devinit maxiradio_init_one(struct pci_dev *pdev, struct pci_device_id *ent)
 {
-	video_unregister_device(&maxiradio_radio);
+	if(!request_region(pci_resource_start(pdev, 0),
+	                   pci_resource_len(pdev, 0), "Maxi Radio FM 2000")) {
+	        printk(KERN_ERR "radio-maxiradio: can't reserve I/O ports\n");
+	        goto err_out;
+	}
+	if (pci_enable_device(pdev))
+	        goto err_out_free_region;
 
-	release_region(radio_unit.io,4);
-}
+	radio_unit.io = pci_resource_start(pdev, 0);
+	init_MUTEX(&radio_unit.lock);
+	maxiradio_radio.priv = &radio_unit;
 
-int __init maxiradio_radio_init(void)
-{
-	struct pci_dev *pcidev = NULL;
-	int found;
-	
-	if(!pci_present())
-		return -ENODEV;
-	
-	found = 0;
-
-	pcidev = pci_find_device(PCI_VENDOR_ID_GUILLEMOT, 
-							PCI_DEVICE_ID_GUILLEMOT_MAXIRADIO,
-						  pcidev);
-							
-	found += radio_install(pcidev);
-		
-	if(found == 0) {
-		printk(KERN_INFO "radio-maxiradio: no devices found.\n");
-		return -ENODEV;
+	if(video_register_device(&maxiradio_radio, VFL_TYPE_RADIO)==-1) {
+	        printk("radio-maxiradio: can't register device!");
+	        goto err_out_free_region;
 	}
 
+
+	printk(KERN_INFO "radio-maxiradio: version "
+	       DRIVER_VERSION
+	       " time "
+	       __TIME__ "  "
+	       __DATE__
+	       "\n");
+
+	printk(KERN_INFO "radio-maxiradio: found Guillemot MAXI Radio device (io = 0x%x)\n",
+	       radio_unit.io);
 	return 0;
-}
 
-module_init(maxiradio_radio_init);
-module_exit(maxiradio_radio_exit);
+err_out_free_region:
+	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
+err_out:
+	return -ENODEV;
+}
 
-inline static __u16 radio_install(struct pci_dev *pcidev)
+static void __devexit maxiradio_remove_one(struct pci_dev *pdev)
 {
-	radio_unit.io = pcidev->resource[0].start;
+	video_unregister_device(&maxiradio_radio);
+	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
+}
 
-	pci_enable_device(pcidev);
-	maxiradio_radio.priv = &radio_unit;
-	init_MUTEX(&radio_unit.lock);
-	
-	if(video_register_device(&maxiradio_radio, VFL_TYPE_RADIO)==-1) {
-		printk("radio-maxiradio: can't register device!");
-			return 0;
-		}
-		
-		
-	printk(KERN_INFO "radio-maxiradio: version "
-	       DRIVER_VERSION 
-	       "\n");
-					 
-	printk(KERN_INFO 
-		"radio-maxiradio: found Guillemot MAXI Radio device (io = 0x%x)\n",
-		radio_unit.io
-		);
-
-
-	if(!request_region(radio_unit.io, 4, "Maxi Radio FM 2000"))
-		{
-			printk(KERN_ERR "radio-maxiradio: port 0x%x already in use\n",
-			radio_unit.io);
-			
-			return 0;
-		}
+static struct pci_device_id maxiradio_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_GUILLEMOT, PCI_DEVICE_ID_GUILLEMOT_MAXIRADIO,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0,}
+};
+MODULE_DEVICE_TABLE(pci, maxiradio_pci_tbl);
+
+static struct pci_driver maxiradio_driver = {
+	name:		"rqdio-maxiradio",
+	id_table:	maxiradio_pci_tbl,
+	probe:		maxiradio_init_one,
+	remove:		maxiradio_remove_one,
+};
+
+int __init maxiradio_radio_init(pdev)
+{
+	return pci_register_driver(&maxiradio_driver);
+}
 
-	return 1;
+void __exit maxiradio_radio_exit(void)
+{
+	pci_unregister_driver(&maxiradio_driver);
 }
 
+module_init(maxiradio_radio_init);
+module_exit(maxiradio_radio_exit);

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
