Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDSPgX>; Thu, 19 Apr 2001 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRDSPgD>; Thu, 19 Apr 2001 11:36:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:40454 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130038AbRDSPfv>;
	Thu, 19 Apr 2001 11:35:51 -0400
Date: Thu, 19 Apr 2001 17:35:02 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: [PATCH] drivers/sound/nm256_audio.c
Message-ID: <20010419173502.A13934@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This updates the nm256_audio driver to the 2.4 PCI API.

Patch is against 2.4.3-ac9, verified on Sony VAIO Laptop.

Ciao, Marcus

Index: drivers/sound/nm256_audio.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/nm256_audio.c,v
retrieving revision 1.1
diff -u -r1.1 nm256_audio.c
--- drivers/sound/nm256_audio.c	2001/04/17 14:50:30	1.1
+++ drivers/sound/nm256_audio.c	2001/04/19 15:28:43
@@ -15,6 +16,8 @@
  * Changes:
  * 11-10-2000	Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
  *		Added some __init
+ * 19-04-2001	Marcus Meissner <mm@caldera.de>
+ *		Ported to 2.4 PCI API.
  */
 
 #define __NO_VERSION__
@@ -49,8 +52,6 @@
 #define PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO 0x8005
 #define PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO 0x8006
 
-#define RSRCADDRESS(dev,num) ((dev)->resource[(num)].start)
-
 /* List of cards.  */
 static struct nm256_info *nmcard_list;
 
@@ -1042,6 +1043,9 @@
     struct pm_dev *pmdev;
     int x;
 
+    if (pci_enable_device(pcidev))
+	    return 0;
+
     card = kmalloc (sizeof (struct nm256_info), GFP_KERNEL);
     if (card == NULL) {
 	printk (KERN_ERR "NM256: out of memory!\n");
@@ -1055,7 +1059,7 @@
 
     /* Init the memory port info.  */
     for (x = 0; x < 2; x++) {
-	card->port[x].physaddr = RSRCADDRESS (pcidev, x);
+	card->port[x].physaddr = pci_resource_start (pcidev, x);
 	card->port[x].ptr = NULL;
 	card->port[x].start_offset = 0;
 	card->port[x].end_offset = 0;
@@ -1201,6 +1205,8 @@
 	}
     }
 
+    pci_set_drvdata(pcidev,card);
+
     /* Insert the card in the list.  */
     card->next_card = nmcard_list;
     nmcard_list = card;
@@ -1251,37 +1257,38 @@
     return 0;
 }
 
-/*
- * 	This loop walks the PCI configuration database and finds where
- *	the sound cards are.
- */
- 
-int __init
-init_nm256(void)
+static int __devinit
+nm256_probe(struct pci_dev *pcidev,const struct pci_device_id *pciid)
 {
-    struct pci_dev *pcidev = NULL;
-    int count = 0;
-
-    if(! pci_present())
-	return -ENODEV;
-
-    while((pcidev = pci_find_device(PCI_VENDOR_ID_NEOMAGIC,
-				    PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
-				    pcidev)) != NULL) {
-	count += nm256_install(pcidev, REV_NM256AV, "256AV");
-    }
-
-    while((pcidev = pci_find_device(PCI_VENDOR_ID_NEOMAGIC,
-				    PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
-				    pcidev)) != NULL) {
-	count += nm256_install(pcidev, REV_NM256ZX, "256ZX");
+    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO)
+	return nm256_install(pcidev, REV_NM256AV, "256AV");
+    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO)
+	return nm256_install(pcidev, REV_NM256ZX, "256ZX");
+    return -1; /* should not come here ... */
+}
+
+static void __devinit
+nm256_remove(struct pci_dev *pcidev) {
+    struct nm256_info *xcard = pci_get_drvdata(pcidev);
+    struct nm256_info *card,*next_card = NULL;
+
+    for (card = nmcard_list; card != NULL; card = next_card) {
+	next_card = card->next_card;
+	if (card == xcard) {
+	    stopPlay (card);
+	    stopRecord (card);
+	    if (card->has_irq)
+		free_irq (card->irq, card);
+	    nm256_release_ports (card);
+	    sound_unload_mixerdev (card->mixer_oss_dev);
+	    sound_unload_audiodev (card->dev[0]);
+	    sound_unload_audiodev (card->dev[1]);
+	    kfree (card);
+	    break;
+	}
     }
-
-    if (count == 0)
-	return -ENODEV;
-
-    printk (KERN_INFO "Done installing NM256 audio driver.\n");
-    return 0;
+    if (nmcard_list == card)
+    	nmcard_list = next_card;
 }
 
 /*
@@ -1639,9 +1646,21 @@
     local_qlen:		nm256_audio_local_qlen,
 };
 
-EXPORT_SYMBOL(init_nm256);
+static struct pci_device_id nm256_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, nm256_pci_tbl);
 
-static int loaded = 0;
+struct pci_driver nm256_pci_driver = {
+	name:"nm256_audio",
+	id_table:nm256_pci_tbl,
+	probe:nm256_probe,
+	remove:nm256_remove,
+};
 
 MODULE_PARM (usecache, "i");
 MODULE_PARM (buffertop, "i");
@@ -1650,37 +1669,13 @@
 
 static int __init do_init_nm256(void)
 {
-    nmcard_list = NULL;
-    printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1\n");
-
-    if (init_nm256 () == 0) {
-	loaded = 1;
-	return 0;
-    }
-    else
-	return -ENODEV;
+    printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1p\n");
+    return pci_module_init(&nm256_pci_driver);
 }
 
 static void __exit cleanup_nm256 (void)
 {
-    if (loaded) {
-	struct nm256_info *card;
-	struct nm256_info *next_card;
-
-	for (card = nmcard_list; card != NULL; card = next_card) {
-	    stopPlay (card);
-	    stopRecord (card);
-	    if (card->has_irq)
-		free_irq (card->irq, card);
-	    nm256_release_ports (card);
-	    sound_unload_mixerdev (card->mixer_oss_dev);
-	    sound_unload_audiodev (card->dev[0]);
-	    sound_unload_audiodev (card->dev[1]);
-	    next_card = card->next_card;
-	    kfree (card);
-	}
-	nmcard_list = NULL;
-    }
+    pci_unregister_driver(&nm256_pci_driver);
     pm_unregister_all (&handle_pm_event);
 }
 
