Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755990AbWKVRRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbWKVRRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbWKVRRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:17:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29087 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755990AbWKVRRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:17:33 -0500
Date: Wed, 22 Nov 2006 17:21:03 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_cs5530: suspend/resume support
Message-ID: <20061122172103.74054315@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 5530 needs various set up performing both at init time and resume
time. To keep the code clean the common setup code is moved into a new
function and called from both handlers.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cs5530.c linux-2.6.19-rc5-mm2/drivers/ata/pata_cs5530.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cs5530.c	2006-11-15 13:25:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_cs5530.c	2006-11-22 15:01:53.385334272 +0000
@@ -35,7 +35,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME	"pata_cs5530"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"0.7.1"
 
 /**
  *	cs5530_set_piomode		-	PIO setup
@@ -181,6 +181,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations cs5530_port_ops = {
@@ -238,38 +240,18 @@
 	return 0;
 }
 
+
 /**
- *	cs5530_init_one		-	Initialise a CS5530
- *	@dev: PCI device
- *	@id: Entry in match table
+ *	cs5530_init_chip	-	Chipset init
  *
- *	Install a driver for the newly found CS5530 companion chip. Most of
- *	this is just housekeeping. We have to set the chip up correctly and
- *	turn off various bits of emulation magic.
+ *	Perform the chip initialisation work that is shared between both
+ *	setup and resume paths
  */
-
-static int cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+ 
+static int cs5530_init_chip(void)
 {
-	int compiler_warning_pointless_fix;
-	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
-	static struct ata_port_info info = {
-		.sht = &cs5530_sht,
-		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
-		.pio_mask = 0x1f,
-		.mwdma_mask = 0x07,
-		.udma_mask = 0x07,
-		.port_ops = &cs5530_port_ops
-	};
-	/* The docking connector doesn't do UDMA, and it seems not MWDMA */
-	static struct ata_port_info info_palmax_secondary = {
-		.sht = &cs5530_sht,
-		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
-		.pio_mask = 0x1f,
-		.port_ops = &cs5530_port_ops
-	};
-	static struct ata_port_info *port_info[2] = { &info, &info };
+	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL, *dev = NULL;
 
-	dev = NULL;
 	while ((dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_ANY_ID, dev)) != NULL) {
 		switch (dev->device) {
 			case PCI_DEVICE_ID_CYRIX_PCI_MASTER:
@@ -290,7 +272,7 @@
 	}
 
 	pci_set_master(cs5530_0);
-	compiler_warning_pointless_fix = pci_set_mwi(cs5530_0);
+	pci_set_mwi(cs5530_0);
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
@@ -338,13 +320,7 @@
 
 	pci_dev_put(master_0);
 	pci_dev_put(cs5530_0);
-
-	if (cs5530_is_palmax())
-		port_info[1] = &info_palmax_secondary;
-
-	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, port_info, 2);
-
+	return 0;
 fail_put:
 	if (master_0)
 		pci_dev_put(master_0);
@@ -353,6 +329,53 @@
 	return -ENODEV;
 }
 
+/**
+ *	cs5530_init_one		-	Initialise a CS5530
+ *	@dev: PCI device
+ *	@id: Entry in match table
+ *
+ *	Install a driver for the newly found CS5530 companion chip. Most of
+ *	this is just housekeeping. We have to set the chip up correctly and
+ *	turn off various bits of emulation magic.
+ */
+
+static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	static struct ata_port_info info = {
+		.sht = &cs5530_sht,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
+		.udma_mask = 0x07,
+		.port_ops = &cs5530_port_ops
+	};
+	/* The docking connector doesn't do UDMA, and it seems not MWDMA */
+	static struct ata_port_info info_palmax_secondary = {
+		.sht = &cs5530_sht,
+		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
+		.pio_mask = 0x1f,
+		.port_ops = &cs5530_port_ops
+	};
+	static struct ata_port_info *port_info[2] = { &info, &info };
+	
+	/* Chip initialisation */
+	if (cs5530_init_chip())
+		return -ENODEV;
+		
+	if (cs5530_is_palmax())
+		port_info[1] = &info_palmax_secondary;
+
+	/* Now kick off ATA set up */
+	return ata_pci_init_one(pdev, port_info, 2);
+}
+
+static int cs5530_reinit_one(struct pci_dev *pdev)
+{
+	/* If we fail on resume we are doomed */
+	BUG_ON(cs5530_init_chip());
+	return ata_pci_device_resume(pdev);
+}
+	
 static const struct pci_device_id cs5530[] = {
 	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
 
@@ -363,7 +386,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= cs5530,
 	.probe 		= cs5530_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= cs5530_reinit_one,
 };
 
 static int __init cs5530_init(void)

