Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757149AbWK0QTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149AbWK0QTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbWK0QTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:19:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50570 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757149AbWK0QTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:19:39 -0500
Date: Mon, 27 Nov 2006 16:24:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hpt36x: Suspend/resume support
Message-ID: <20061127162415.7e1f290c@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another chipset which needs some reconfiguration after a resume. All the
chip setup is moved to a new function called in both setup and resume. 

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_hpt366.c linux-2.6.19-rc6-mm1/drivers/ata/pata_hpt366.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_hpt366.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_hpt366.c	2006-11-24 14:35:06.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.5.1"
+#define DRV_VERSION	"0.5.3"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -338,6 +338,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 /*
@@ -380,6 +382,27 @@
 };
 
 /**
+ *	hpt36x_init_chipset	-	common chip setup
+ *	@dev: PCI device
+ *
+ *	Perform the chip setup work that must be done at both init and
+ *	resume time
+ */
+
+static void hpt36x_init_chipset(struct pci_dev *dev)
+{
+	u8 drive_fast;
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
+	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
+	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
+
+	pci_read_config_byte(dev, 0x51, &drive_fast);
+	if (drive_fast & 0x80)
+		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
+}
+
+/**
  *	hpt36x_init_one		-	Initialise an HPT366/368
  *	@dev: PCI device
  *	@id: Entry in match table
@@ -414,7 +437,6 @@
 
 	u32 class_rev;
 	u32 reg1;
-	u8 drive_fast;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
@@ -424,14 +446,7 @@
 	if (class_rev > 2)
 			return -ENODEV;
 
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
-	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
-	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
-
-	pci_read_config_byte(dev, 0x51, &drive_fast);
-	if (drive_fast & 0x80)
-		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
+	hpt36x_init_chipset(dev);
 
 	pci_read_config_dword(dev, 0x40,  &reg1);
 
@@ -452,9 +467,15 @@
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
+static int hpt36x_reinit_one(struct pci_dev *dev)
+{
+	hpt36x_init_chipset(dev);
+	return ata_pci_device_resume(dev);
+}
+
+
 static const struct pci_device_id hpt36x[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
-
 	{ },
 };
 
@@ -462,7 +483,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= hpt36x,
 	.probe 		= hpt36x_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= hpt36x_reinit_one,
 };
 
 static int __init hpt36x_init(void)
@@ -470,13 +493,11 @@
 	return pci_register_driver(&hpt36x_pci_driver);
 }
 
-
 static void __exit hpt36x_exit(void)
 {
 	pci_unregister_driver(&hpt36x_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for the Highpoint HPT366/368");
 MODULE_LICENSE("GPL");
