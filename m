Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVFTUXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVFTUXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVFTUVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:21:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:25502 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261475AbVFTUSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:18:38 -0400
Subject: PATCH: ide-generic, allow for capture of other unsupported devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119298578.3325.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 21:16:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ide-generic driver gives you DMA at bios tuned speed so can actually
run a lot of unsupported devices quite well. It has a pci table so that
it doesn't grab disks owned by other drivers but no way to override
this. The patch adds an option ide-generic-all which makes the driver
grab everything going that is IDE class.

The diff is messy because I put the special case as case 0 to make the
if conditional and long term maintenance easier. 

This has been in Fedora for some time.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/pci/generic.c linux-2.6.12/drivers/ide/pci/generic.c
--- linux.vanilla-2.6.12/drivers/ide/pci/generic.c	2005-06-19 11:21:23.000000000 +0100
+++ linux-2.6.12/drivers/ide/pci/generic.c	2005-06-20 20:57:19.000000000 +0100
@@ -39,6 +39,17 @@
 
 #include <asm/io.h>
 
+static int ide_generic_all;		/* Set to claim all devices */
+
+static int __init ide_generic_all_on(char *unused)
+{
+	ide_generic_all = 1;
+	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
+	return 1;
+}
+
+__setup("all-generic-ide", ide_generic_all_on);
+
 static void __devinit init_hwif_generic (ide_hwif_t *hwif)
 {
 	switch(hwif->pci_dev->device) {
@@ -78,79 +89,85 @@
 
 static ide_pci_device_t generic_chipsets[] __devinitdata = {
 	{	/* 0 */
+		.name		= "Unknown",
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
 		.name		= "NS87410",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.bootable	= ON_BOARD,
-        },{	/* 1 */
+        },{	/* 2 */
 		.name		= "SAMURAI",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 2 */
+	},{	/* 3 */
 		.name		= "HT6565",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 3 */
+	},{	/* 4 */
 		.name		= "UM8673F",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 4 */
+	},{	/* 5 */
 		.name		= "UM8886A",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 5 */
+	},{	/* 6 */
 		.name		= "UM8886BF",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 6 */
+	},{	/* 7 */
 		.name		= "HINT_IDE",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 7 */
+	},{	/* 8 */
 		.name		= "VIA_IDE",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 8 */
+	},{	/* 9 */
 		.name		= "OPTI621V",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 9 */
+	},{	/* 10 */
 		.name		= "VIA8237SATA",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
-	},{	/* 10 */
+	},{	/* 11 */
 		.name 		= "Piccolo0102",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 11 */
+	},{	/* 12 */
 		.name 		= "Piccolo0103",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
-	},{	/* 12 */
+	},{	/* 13 */
 		.name 		= "Piccolo0105",
 		.init_hwif	= init_hwif_generic,
 		.channels	= 2,
@@ -174,6 +191,10 @@
 	u16 command;
 	int ret = -ENODEV;
 
+	/* Don't use the generic entry unless instructed to do so */
+	if (id->driver_data == 0 && ide_generic_all == 0)
+			goto out;
+
 	if (dev->vendor == PCI_VENDOR_ID_UMC &&
 	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
@@ -195,21 +216,23 @@
 }
 
 static struct pci_device_id generic_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886A,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886BF,        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
-	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
-	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
+	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
+	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886A,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
+	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886BF,        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
+	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
+	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
+	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 #endif
-	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
-	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
-	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
+	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
+	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, generic_pci_tbl);

