Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVFTUzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVFTUzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVFTUzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:55:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30622 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262639AbVFTUli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:41:38 -0400
Subject: PATCH: it8212 backport for Bartlomiej IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119299939.3279.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 21:39:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lets you throw out the iteraid stuff that has ended up back in due
to stupid goings on in the IDE world. Its the same heavily tested code
shipped in Fedora/Red Hat products but without the other dependancies on
the Bartlomiej IDE layer.

Pre-requisite: the ide-disk patch I sent to handle pure LBA devices.

Obviously you lose things like hot unplug with the Bartlomiej IDE layer
at the moment but that won't matter to most users.

The patch does the following
- Add IT8211/12 to pci_ids.h
- Add Makefile/Kconfig entry
- Add it8212 driver

No core IDE code is touched by this diff

Signed-off-by: Alan Cox <alan@redhat.com>
Embedded system testing and the ability to force raid mode off by David
Howells

Made possible by the ite reference code, documentation and also several
clarifications and pieces of assistance provided by ITE themselves

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/Kconfig linux-2.6.12/drivers/ide/Kconfig
--- linux.vanilla-2.6.12/drivers/ide/Kconfig	2005-06-19 11:30:47.000000000 +0100
+++ linux-2.6.12/drivers/ide/Kconfig	2005-06-20 21:24:36.762827768 +0100
@@ -606,6 +606,12 @@
 	  <http://www.ite.com.tw/ia/brief_it8172bsp.htm>; picture of the
 	  board at <http://www.mvista.com/partners/semiconductor/ite.html>.
 
+config BLK_DEV_IT821X
+	tristate "IT821X IDE support"
+	help
+	  This driver adds support for the ITE 8211 IDE controller and the
+	  IT 8212 IDE RAID controller in both RAID and pass-through mode. 
+
 config BLK_DEV_NS87415
 	tristate "NS87415 chipset support"
 	help
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/pci/hpt366.c linux-2.6.12/drivers/ide/pci/hpt366.c
--- linux.vanilla-2.6.12/drivers/ide/pci/hpt366.c	2005-06-19 11:21:23.000000000 +0100
+++ linux-2.6.12/drivers/ide/pci/hpt366.c	2005-06-20 20:56:49.000000000 +0100
@@ -10,6 +10,11 @@
  * donation of an ABit BP6 mainboard, processor, and memory acellerated
  * development and support.
  *
+ *
+ * Highpoint have their own driver (source except for the raid part)
+ * available from http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz
+ * This may be useful to anyone wanting to work on the mainstream hpt IDE.
+ *
  * Note that final HPT370 support was done by force extraction of GPL.
  *
  * - add function for getting/setting power status of drive
@@ -446,44 +451,29 @@
 #define F_LOW_PCI_50	0x2d
 #define F_LOW_PCI_66	0x42
 
-/* FIXME: compare with driver's code before removing */
-#if 0
-		if (hpt_minimum_revision(dev, 3)) {
-			u8 cbl;
-			cbl = inb(iobase + 0x7b);
-			outb(cbl | 1, iobase + 0x7b);
-			outb(cbl & ~1, iobase + 0x7b);
-			cbl = inb(iobase + 0x7a);
-			p += sprintf(p, "Cable:          ATA-%d"
-					"                          ATA-%d\n",
-				(cbl & 0x02) ? 33 : 66,
-				(cbl & 0x01) ? 33 : 66);
-			p += sprintf(p, "\n");
-		}
-		{
-			u8 c2, c3;
-			/* older revs don't have these registers mapped 
-			 * into io space */
-			pci_read_config_byte(dev, 0x43, &c0);
-			pci_read_config_byte(dev, 0x47, &c1);
-			pci_read_config_byte(dev, 0x4b, &c2);
-			pci_read_config_byte(dev, 0x4f, &c3);
-
-			p += sprintf(p, "Mode:           %s             %s"
-					"           %s              %s\n",
-				(c0 & 0x10) ? "UDMA" : (c0 & 0x20) ? "DMA " : 
-					(c0 & 0x80) ? "PIO " : "off ",
-				(c1 & 0x10) ? "UDMA" : (c1 & 0x20) ? "DMA " :
-					(c1 & 0x80) ? "PIO " : "off ",
-				(c2 & 0x10) ? "UDMA" : (c2 & 0x20) ? "DMA " :
-					(c2 & 0x80) ? "PIO " : "off ",
-				(c3 & 0x10) ? "UDMA" : (c3 & 0x20) ? "DMA " :
-					(c3 & 0x80) ? "PIO " : "off ");
-		}
-	}
-#endif
+/*
+ *	Hold all the highpoint quirks and revision information in one
+ *	place.
+ */
+ 
+struct hpt_info
+{
+	u8 max_mode;		/* Speeds allowed */
+	int revision;		/* Chipset revision */
+	int flags;		/* Chipset properties */
+#define PLL_MODE	1
+#define IS_372N		2
+				/* Speed table */
+	struct chipset_bus_clock_list_entry *speed;
+};
 
-static u32 hpt_revision (struct pci_dev *dev)
+/*
+ *	This wants fixing so that we do everything not by classrev
+ *	(which breaks on the newest chips) but by creating an
+ *	enumeration of chip variants and using that
+ */
+ 
+static __devinit u32 hpt_revision (struct pci_dev *dev)
 {
 	u32 class_rev;
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
@@ -507,37 +497,33 @@
 	return class_rev;
 }
 
-static u32 hpt_minimum_revision (struct pci_dev *dev, int revision)
-{
-	unsigned int class_rev = hpt_revision(dev);
-	revision--;
-	return ((int) (class_rev > revision) ? 1 : 0);
-}
-
 static int check_in_drive_lists(ide_drive_t *drive, const char **list);
 
 static u8 hpt3xx_ratemask (ide_drive_t *drive)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct hpt_info *info	= ide_get_hwifdata(hwif);
 	u8 mode			= 0;
 
-	if (hpt_minimum_revision(dev, 8)) {		/* HPT374 */
+	/* FIXME: TODO - move this to set info->mode once at boot */
+	
+	if (info->revision >= 8) {		/* HPT374 */
 		mode = (HPT374_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (hpt_minimum_revision(dev, 7)) {	/* HPT371 */
+	} else if (info->revision >= 7) {	/* HPT371 */
 		mode = (HPT371_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (hpt_minimum_revision(dev, 6)) {	/* HPT302 */
+	} else if (info->revision >= 6) {	/* HPT302 */
 		mode = (HPT302_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (hpt_minimum_revision(dev, 5)) {	/* HPT372 */
+	} else if (info->revision >= 5) {	/* HPT372 */
 		mode = (HPT372_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (hpt_minimum_revision(dev, 4)) {	/* HPT370A */
+	} else if (info->revision >= 4) {	/* HPT370A */
 		mode = (HPT370_ALLOW_ATA100_5) ? 3 : 2;
-	} else if (hpt_minimum_revision(dev, 3)) {	/* HPT370 */
+	} else if (info->revision >= 3) {	/* HPT370 */
 		mode = (HPT370_ALLOW_ATA100_5) ? 3 : 2;
 		mode = (check_in_drive_lists(drive, bad_ata33)) ? 0 : mode;
 	} else {				/* HPT366 and HPT368 */
 		mode = (check_in_drive_lists(drive, bad_ata33)) ? 0 : 2;
 	}
-	if (!eighty_ninty_three(drive) && (mode))
+	if (!eighty_ninty_three(drive) && mode)
 		mode = min(mode, (u8)1);
 	return mode;
 }
@@ -549,7 +535,8 @@
  
 static u8 hpt3xx_ratefilter (ide_drive_t *drive, u8 speed)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct hpt_info *info	= ide_get_hwifdata(hwif);
 	u8 mode			= hpt3xx_ratemask(drive);
 
 	if (drive->media != ide_disk)
@@ -561,7 +548,7 @@
 			break;
 		case 0x03:
 			speed = min(speed, (u8)XFER_UDMA_5);
-			if (hpt_minimum_revision(dev, 5))
+			if (info->revision >= 5)
 				break;
 			if (check_in_drive_lists(drive, bad_ata100_5))
 				speed = min(speed, (u8)XFER_UDMA_4);
@@ -571,7 +558,7 @@
 	/*
 	 * CHECK ME, Does this need to be set to 5 ??
 	 */
-			if (hpt_minimum_revision(dev, 3))
+			if (info->revision >= 3)
 				break;
 			if ((check_in_drive_lists(drive, bad_ata66_4)) ||
 			    (!(HPT366_ALLOW_ATA66_4)))
@@ -585,7 +572,7 @@
 	/*
 	 * CHECK ME, Does this need to be set to 5 ??
 	 */
-			if (hpt_minimum_revision(dev, 3))
+			if (info->revision >= 3)
 				break;
 			if (check_in_drive_lists(drive, bad_ata33))
 				speed = min(speed, (u8)XFER_MW_DMA_2);
@@ -624,11 +611,12 @@
 
 static int hpt36x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct pci_dev *dev	= hwif->pci_dev;
+	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 	u8 speed		= hpt3xx_ratefilter(drive, xferspeed);
-//	u8 speed		= ide_rate_filter(hpt3xx_ratemask(drive), xferspeed);
 	u8 regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
-	u8 regfast		= (HWIF(drive)->channel) ? 0x55 : 0x51;
+	u8 regfast		= (hwif->channel) ? 0x55 : 0x51;
 	u8 drive_fast		= 0;
 	u32 reg1 = 0, reg2	= 0;
 
@@ -636,16 +624,11 @@
 	 * Disable the "fast interrupt" prediction.
 	 */
 	pci_read_config_byte(dev, regfast, &drive_fast);
-#if 0
-	if (drive_fast & 0x02)
-		pci_write_config_byte(dev, regfast, drive_fast & ~0x20);
-#else
 	if (drive_fast & 0x80)
 		pci_write_config_byte(dev, regfast, drive_fast & ~0x80);
-#endif
 
-	reg2 = pci_bus_clock_list(speed,
-		(struct chipset_bus_clock_list_entry *) pci_get_drvdata(dev));
+	reg2 = pci_bus_clock_list(speed, info->speed);
+
 	/*
 	 * Disable on-chip PIO FIFO/buffer
 	 *  (to avoid problems handling I/O errors later)
@@ -665,10 +648,11 @@
 
 static int hpt370_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
-	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct pci_dev *dev = hwif->pci_dev;
+	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 	u8 speed	= hpt3xx_ratefilter(drive, xferspeed);
-//	u8 speed	= ide_rate_filter(hpt3xx_ratemask(drive), xferspeed);
-	u8 regfast	= (HWIF(drive)->channel) ? 0x55 : 0x51;
+	u8 regfast	= (drive->hwif->channel) ? 0x55 : 0x51;
 	u8 drive_pci	= 0x40 + (drive->dn * 4);
 	u8 new_fast	= 0, drive_fast = 0;
 	u32 list_conf	= 0, drive_conf = 0;
@@ -693,17 +677,13 @@
 	if (new_fast != drive_fast)
 		pci_write_config_byte(dev, regfast, new_fast);
 
-	list_conf = pci_bus_clock_list(speed, 
-				       (struct chipset_bus_clock_list_entry *)
-				       pci_get_drvdata(dev));
+	list_conf = pci_bus_clock_list(speed, info->speed);
 
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
 	
-	if (speed < XFER_MW_DMA_0) {
+	if (speed < XFER_MW_DMA_0)
 		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
-	}
-
 	pci_write_config_dword(dev, drive_pci, list_conf);
 
 	return ide_config_drive_speed(drive, speed);
@@ -711,10 +691,11 @@
 
 static int hpt372_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct pci_dev *dev	= hwif->pci_dev;
+	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 	u8 speed	= hpt3xx_ratefilter(drive, xferspeed);
-//	u8 speed	= ide_rate_filter(hpt3xx_ratemask(drive), xferspeed);
-	u8 regfast	= (HWIF(drive)->channel) ? 0x55 : 0x51;
+	u8 regfast	= (drive->hwif->channel) ? 0x55 : 0x51;
 	u8 drive_fast	= 0, drive_pci = 0x40 + (drive->dn * 4);
 	u32 list_conf	= 0, drive_conf = 0;
 	u32 conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
@@ -726,10 +707,8 @@
 	pci_read_config_byte(dev, regfast, &drive_fast);
 	drive_fast &= ~0x07;
 	pci_write_config_byte(dev, regfast, drive_fast);
-					
-	list_conf = pci_bus_clock_list(speed,
-			(struct chipset_bus_clock_list_entry *)
-					pci_get_drvdata(dev));
+
+	list_conf = pci_bus_clock_list(speed, info->speed);
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
 	if (speed < XFER_MW_DMA_0)
@@ -741,19 +720,14 @@
 
 static int hpt3xx_tune_chipset (ide_drive_t *drive, u8 speed)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= drive->hwif;
+	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 
-	if (hpt_minimum_revision(dev, 8))
+	if (info->revision >= 8)
 		return hpt372_tune_chipset(drive, speed); /* not a typo */
-#if 0
-	else if (hpt_minimum_revision(dev, 7))
-		hpt371_tune_chipset(drive, speed);
-	else if (hpt_minimum_revision(dev, 6))
-		hpt302_tune_chipset(drive, speed);
-#endif
-	else if (hpt_minimum_revision(dev, 5))
+	else if (info->revision >= 5)
 		return hpt372_tune_chipset(drive, speed);
-	else if (hpt_minimum_revision(dev, 3))
+	else if (info->revision >= 3)
 		return hpt370_tune_chipset(drive, speed);
 	else	/* hpt368: hpt_minimum_revision(dev, 2) */
 		return hpt36x_tune_chipset(drive, speed);
@@ -779,8 +753,14 @@
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
 	u8 speed = ide_dma_speed(drive, hpt3xx_ratemask(drive));
-
-	if (!(speed))
+	ide_hwif_t *hwif = drive->hwif;
+	struct hpt_info	*info	= ide_get_hwifdata(hwif);
+	
+	if (!speed)
+		return 0;
+		
+	/* If we don't have any timings we can't do a lot */
+	if (info->speed == NULL)
 		return 0;
 
 	(void) hpt3xx_tune_chipset(drive, speed);
@@ -794,7 +774,7 @@
 
 static void hpt3xx_intrproc (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
+	ide_hwif_t *hwif = drive->hwif;
 
 	if (drive->quirk_list)
 		return;
@@ -804,24 +784,26 @@
 
 static void hpt3xx_maskproc (ide_drive_t *drive, int mask)
 {
-	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif = drive->hwif;
+	struct hpt_info *info = ide_get_hwifdata(hwif);
+	struct pci_dev *dev = hwif->pci_dev;
 
 	if (drive->quirk_list) {
-		if (hpt_minimum_revision(dev,3)) {
+		if (info->revision >= 3) {
 			u8 reg5a = 0;
 			pci_read_config_byte(dev, 0x5a, &reg5a);
 			if (((reg5a & 0x10) >> 4) != mask)
 				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
 		} else {
 			if (mask) {
-				disable_irq(HWIF(drive)->irq);
+				disable_irq(hwif->irq);
 			} else {
-				enable_irq(HWIF(drive)->irq);
+				enable_irq(hwif->irq);
 			}
 		}
 	} else {
 		if (IDE_CONTROL_REG)
-			HWIF(drive)->OUTB(mask ? (drive->ctl | 2) :
+			hwif->OUTB(mask ? (drive->ctl | 2) :
 						 (drive->ctl & ~2),
 						 IDE_CONTROL_REG);
 	}
@@ -829,12 +811,12 @@
 
 static int hpt366_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
+	ide_hwif_t *hwif	= drive->hwif;
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
-	if (id && (id->capability & 1) && drive->autodma) {
+	if ((id->capability & 1) && drive->autodma) {
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
@@ -868,15 +850,6 @@
 		drive->name, __FUNCTION__, reg50h, reg52h, reg5ah);
 	if (reg5ah & 0x10)
 		pci_write_config_byte(dev, 0x5a, reg5ah & ~0x10);
-#if 0
-	/* how about we flush and reset, mmmkay? */
-	pci_write_config_byte(dev, 0x51, 0x1F);
-	/* fall through to a reset */
-	case dma_start:
-	case ide_dma_end:
-	/* reset the chips state over and over.. */
-	pci_write_config_byte(dev, 0x51, 0x13);
-#endif
 	return __ide_dma_lostirq(drive);
 }
 
@@ -919,7 +892,7 @@
 	u8 dma_stat = 0, dma_cmd = 0;
 
 	pci_read_config_byte(HWIF(drive)->pci_dev, reginfo, &bfifo);
-	printk("%s: %d bytes in FIFO\n", drive->name, bfifo);
+	printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name, bfifo);
 	hpt370_clear_engine(drive);
 	/* get dma command mode */
 	dma_cmd = hwif->INB(hwif->dma_command);
@@ -1047,15 +1020,6 @@
 
 static void hpt3xx_reset (ide_drive_t *drive)
 {
-#if 0
-	unsigned long high_16	= pci_resource_start(HWIF(drive)->pci_dev, 4);
-	u8 reset	= (HWIF(drive)->channel) ? 0x80 : 0x40;
-	u8 reg59h	= 0;
-
-	pci_read_config_byte(HWIF(drive)->pci_dev, 0x59, &reg59h);
-	pci_write_config_byte(HWIF(drive)->pci_dev, 0x59, reg59h|reset);
-	pci_write_config_byte(HWIF(drive)->pci_dev, 0x59, reg59h);
-#endif
 }
 
 static int hpt3xx_tristate (ide_drive_t * drive, int state)
@@ -1065,8 +1029,6 @@
 	u8 reg59h = 0, reset	= (hwif->channel) ? 0x80 : 0x40;
 	u8 regXXh = 0, state_reg= (hwif->channel) ? 0x57 : 0x53;
 
-//	hwif->bus_state = state;
-
 	pci_read_config_byte(dev, 0x59, &reg59h);
 	pci_read_config_byte(dev, state_reg, &regXXh);
 
@@ -1093,7 +1055,7 @@
 #define TRISTATE_BIT  0x8000
 static int hpt370_busproc(ide_drive_t * drive, int state)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
+	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 tristate = 0, resetmask = 0, bus_reg = 0;
 	u16 tri_reg;
@@ -1148,33 +1110,44 @@
 	return 0;
 }
 
-static int __devinit init_hpt37x(struct pci_dev *dev)
+static void __devinit hpt366_clocking(ide_hwif_t *hwif)
 {
+	u32 reg1	= 0;
+	struct hpt_info *info = ide_get_hwifdata(hwif);
+
+	pci_read_config_dword(hwif->pci_dev, 0x40, &reg1);
+
+	/* detect bus speed by looking at control reg timing: */
+	switch((reg1 >> 8) & 7) {
+		case 5:
+			info->speed = forty_base_hpt366;
+			break;
+		case 9:
+			info->speed = twenty_five_base_hpt366;
+			break;
+		case 7:
+		default:
+			info->speed = thirty_three_base_hpt366;
+			break;
+	}
+}
+
+static void __devinit hpt37x_clocking(ide_hwif_t *hwif)
+{
+	struct hpt_info *info = ide_get_hwifdata(hwif);
+	struct pci_dev *dev = hwif->pci_dev;
 	int adjust, i;
 	u16 freq;
 	u32 pll;
 	u8 reg5bh;
-	u8 reg5ah = 0;
-	unsigned long dmabase = pci_resource_start(dev, 4);
-	u8 did, rid;	
-	int is_372n = 0;
-	
-	pci_read_config_byte(dev, 0x5a, &reg5ah);
-	/* interrupt force enable */
-	pci_write_config_byte(dev, 0x5a, (reg5ah & ~0x10));
-
-	if(dmabase)
-	{
-		did = inb(dmabase + 0x22);
-		rid = inb(dmabase + 0x28);
 	
-		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
-			is_372n = 1;
-	}
-
 	/*
 	 * default to pci clock. make sure MA15/16 are set to output
-	 * to prevent drives having problems with 40-pin cables.
+	 * to prevent drives having problems with 40-pin cables. Needed
+	 * for some drives such as IBM-DTLA which will not enter ready
+	 * state on reset when PDIAG is a input.
+	 *
+	 * ToDo: should we set 0x21 when using PLL mode ?
 	 */
 	pci_write_config_byte(dev, 0x5b, 0x23);
 
@@ -1197,9 +1170,7 @@
 	 * Currently we always set up the PLL for the 372N
 	 */
 	 
-	pci_set_drvdata(dev, NULL);
-	
-	if(is_372n)
+	if(info->flags & IS_372N)
 	{
 		printk(KERN_INFO "hpt: HPT372N detected, using 372N timing.\n");
 		if(freq < 0x55)
@@ -1227,39 +1198,38 @@
 			pll = F_LOW_PCI_66;
 	
 		if (pll == F_LOW_PCI_33) {
-			if (hpt_minimum_revision(dev,8))
-				pci_set_drvdata(dev, (void *) thirty_three_base_hpt374);
-			else if (hpt_minimum_revision(dev,5))
-				pci_set_drvdata(dev, (void *) thirty_three_base_hpt372);
-			else if (hpt_minimum_revision(dev,4))
-				pci_set_drvdata(dev, (void *) thirty_three_base_hpt370a);
+			if (info->revision >= 8)
+				info->speed = thirty_three_base_hpt374;
+			else if (info->revision >= 5)
+				info->speed = thirty_three_base_hpt372;
+			else if (info->revision >= 4)
+				info->speed = thirty_three_base_hpt370a;
 			else
-				pci_set_drvdata(dev, (void *) thirty_three_base_hpt370);
-			printk("HPT37X: using 33MHz PCI clock\n");
+				info->speed = thirty_three_base_hpt370;
+			printk(KERN_DEBUG "HPT37X: using 33MHz PCI clock\n");
 		} else if (pll == F_LOW_PCI_40) {
 			/* Unsupported */
 		} else if (pll == F_LOW_PCI_50) {
-			if (hpt_minimum_revision(dev,8))
-				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
-			else if (hpt_minimum_revision(dev,5))
-				pci_set_drvdata(dev, (void *) fifty_base_hpt372);
-			else if (hpt_minimum_revision(dev,4))
-				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			if (info->revision >= 8)
+				info->speed = fifty_base_hpt370a;
+			else if (info->revision >= 5)
+				info->speed = fifty_base_hpt372;
+			else if (info->revision >= 4)
+				info->speed = fifty_base_hpt370a;
 			else
-				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
-			printk("HPT37X: using 50MHz PCI clock\n");
+				info->speed = fifty_base_hpt370a;
+			printk(KERN_DEBUG "HPT37X: using 50MHz PCI clock\n");
 		} else {
-			if (hpt_minimum_revision(dev,8))
-			{
+			if (info->revision >= 8) {
 				printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
 			}
-			else if (hpt_minimum_revision(dev,5))
-				pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
-			else if (hpt_minimum_revision(dev,4))
-				pci_set_drvdata(dev, (void *) sixty_six_base_hpt370a);
+			else if (info->revision >= 5)
+				info->speed = sixty_six_base_hpt372;
+			else if (info->revision >= 4)
+				info->speed = sixty_six_base_hpt370a;
 			else
-				pci_set_drvdata(dev, (void *) sixty_six_base_hpt370);
-			printk("HPT37X: using 66MHz PCI clock\n");
+				info->speed = sixty_six_base_hpt370;
+			printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
 		}
 	}
 	
@@ -1269,11 +1239,19 @@
 	 * result in slow reads when using a 33MHz PCI clock. we also
 	 * don't like to use the PLL because it will cause glitches
 	 * on PRST/SRST when the HPT state engine gets reset.
+	 *
+	 * ToDo: Use 66MHz PLL when ATA133 devices are present on a
+	 * 372 device so we can get ATA133 support
 	 */
-	if (pci_get_drvdata(dev)) 
+	if (info->speed) 
 		goto init_hpt37X_done;
+
+	info->flags |= PLL_MODE;
 	
 	/*
+	 * FIXME: make this work correctly, esp with 372N as per
+	 * reference driver code. 
+	 *
 	 * adjust PLL based upon PCI clock, enable it, and wait for
 	 * stabilization.
 	 */
@@ -1298,14 +1276,14 @@
 				pci_write_config_dword(dev, 0x5c, 
 						       pll & ~0x100);
 				pci_write_config_byte(dev, 0x5b, 0x21);
-				if (hpt_minimum_revision(dev,8))
-					pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
-				else if (hpt_minimum_revision(dev,5))
-					pci_set_drvdata(dev, (void *) fifty_base_hpt372);
-				else if (hpt_minimum_revision(dev,4))
-					pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+				if (info->revision >= 8)
+					info->speed = fifty_base_hpt370a;
+				else if (info->revision >= 5)
+					info->speed = fifty_base_hpt372;
+				else if (info->revision >= 4)
+					info->speed = fifty_base_hpt370a;
 				else
-					pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+					info->speed = fifty_base_hpt370a;
 				printk("HPT37X: using 50MHz internal PLL\n");
 				goto init_hpt37X_done;
 			}
@@ -1318,10 +1296,22 @@
 	} 
 
 init_hpt37X_done:
+	if (!info->speed)
+		printk(KERN_ERR "HPT37X%s: unknown bus timing [%d %d].\n", 
+			(info->flags & IS_372N)?"N":"", pll, freq);
 	/* reset state engine */
 	pci_write_config_byte(dev, 0x50, 0x37); 
 	pci_write_config_byte(dev, 0x54, 0x37); 
 	udelay(100);
+}
+
+static int __devinit init_hpt37x(struct pci_dev *dev)
+{
+	u8 reg5ah;
+	
+	pci_read_config_byte(dev, 0x5a, &reg5ah);
+	/* interrupt force enable */
+	pci_write_config_byte(dev, 0x5a, (reg5ah & ~0x10));
 	return 0;
 }
 
@@ -1338,59 +1328,27 @@
 		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
 	pci_read_config_dword(dev, 0x40, &reg1);
 									
-	/* detect bus speed by looking at control reg timing: */
-	switch((reg1 >> 8) & 7) {
-		case 5:
-			pci_set_drvdata(dev, (void *) forty_base_hpt366);
-			break;
-		case 9:
-			pci_set_drvdata(dev, (void *) twenty_five_base_hpt366);
-			break;
-		case 7:
-		default:
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt366);
-			break;
-	}
-
-	if (!pci_get_drvdata(dev))
-	{
-		printk(KERN_ERR "hpt366: unknown bus timing.\n");
-		pci_set_drvdata(dev, NULL);
-	}
 	return 0;
 }
 
 static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
 {
 	int ret = 0;
-	u8 test = 0;
-
+	/* FIXME: Not portable */
 	if (dev->resource[PCI_ROM_RESOURCE].start)
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 
-	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &test);
-	if (test != (L1_CACHE_BYTES / 4))
-		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
-			(L1_CACHE_BYTES / 4));
-
-	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &test);
-	if (test != 0x78)
-		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
-
-	pci_read_config_byte(dev, PCI_MIN_GNT, &test);
-	if (test != 0x08)
-		pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
-
-	pci_read_config_byte(dev, PCI_MAX_LAT, &test);
-	if (test != 0x08)
-		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
+	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
+	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	if (hpt_minimum_revision(dev, 3)) {
+	if (hpt_revision(dev) >= 3)
 		ret = init_hpt37x(dev);
-	} else {
-		ret =init_hpt366(dev);
-	}
+	else
+		ret = init_hpt366(dev);
+
 	if (ret)
 		return ret;
 
@@ -1400,27 +1358,16 @@
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev		= hwif->pci_dev;
+	struct hpt_info *info		= ide_get_hwifdata(hwif);
 	u8 ata66 = 0, regmask		= (hwif->channel) ? 0x01 : 0x02;
-	u8 did, rid;
-	unsigned long dmabase		= hwif->dma_base;
-	int is_372n = 0;
 	
-	if(dmabase)
-	{
-		did = inb(dmabase + 0x22);
-		rid = inb(dmabase + 0x28);
-	
-		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
-			is_372n = 1;
-	}
-		
 	hwif->tuneproc			= &hpt3xx_tune_drive;
 	hwif->speedproc			= &hpt3xx_tune_chipset;
 	hwif->quirkproc			= &hpt3xx_quirkproc;
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
 	
-	if(is_372n)
+	if(info->flags & IS_372N)
 		hwif->rw_disk = &hpt372n_rw_disk;
 
 	/*
@@ -1428,7 +1375,7 @@
 	 * address lines to access an external eeprom.  To read valid
 	 * cable detect state the pins must be enabled as inputs.
 	 */
-	if (hpt_minimum_revision(dev, 8) && PCI_FUNC(dev->devfn) & 1) {
+	if (info->revision >= 8 && (PCI_FUNC(dev->devfn) & 1)) {
 		/*
 		 * HPT374 PCI function 1
 		 * - set bit 15 of reg 0x52 to enable TCBLID as input
@@ -1443,7 +1390,7 @@
 		pci_read_config_byte(dev, 0x5a, &ata66);
 		pci_write_config_word(dev, 0x52, mcr3);
 		pci_write_config_word(dev, 0x56, mcr6);
-	} else if (hpt_minimum_revision(dev, 3)) {
+	} else if (info->revision >= 3) {
 		/*
 		 * HPT370/372 and 374 pcifn 0
 		 * - clear bit 0 of 0x5b to enable P/SCBLID as inputs
@@ -1470,7 +1417,7 @@
 		hwif->serialized = hwif->mate->serialized = 1;
 #endif
 
-	if (hpt_minimum_revision(dev,3)) {
+	if (info->revision >= 3) {
 		u8 reg5ah = 0;
 			pci_write_config_byte(dev, 0x5a, reg5ah & ~0x10);
 		/*
@@ -1480,8 +1427,7 @@
 		 */
 		hwif->resetproc	= &hpt3xx_reset;
 		hwif->busproc	= &hpt370_busproc;
-//		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-	} else if (hpt_minimum_revision(dev,2)) {
+	} else if (info->revision >= 2) {
 		hwif->resetproc	= &hpt3xx_reset;
 		hwif->busproc	= &hpt3xx_tristate;
 	} else {
@@ -1502,18 +1448,18 @@
 		hwif->udma_four = ((ata66 & regmask) ? 0 : 1);
 	hwif->ide_dma_check = &hpt366_config_drive_xfer_rate;
 
-	if (hpt_minimum_revision(dev,8)) {
+	if (info->revision >= 8) {
 		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	} else if (hpt_minimum_revision(dev,5)) {
+	} else if (info->revision >= 5) {
 		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	} else if (hpt_minimum_revision(dev,3)) {
+	} else if (info->revision >= 3) {
 		hwif->dma_start = &hpt370_ide_dma_start;
 		hwif->ide_dma_end = &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout = &hpt370_ide_dma_timeout;
 		hwif->ide_dma_lostirq = &hpt370_ide_dma_lostirq;
-	} else if (hpt_minimum_revision(dev,2))
+	} else if (info->revision >= 2)
 		hwif->ide_dma_lostirq = &hpt366_ide_dma_lostirq;
 	else
 		hwif->ide_dma_lostirq = &hpt366_ide_dma_lostirq;
@@ -1526,6 +1472,7 @@
 
 static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long dmabase)
 {
+	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 	u8 masterdma	= 0, slavedma = 0;
 	u8 dma_new	= 0, dma_old = 0;
 	u8 primary	= hwif->channel ? 0x4b : 0x43;
@@ -1535,8 +1482,7 @@
 	if (!dmabase)
 		return;
 		
-	if(pci_get_drvdata(hwif->pci_dev) == NULL)
-	{
+	if(info->speed == NULL) {
 		printk(KERN_WARNING "hpt: no known IDE timings, disabling DMA.\n");
 		return;
 	}
@@ -1559,6 +1505,40 @@
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
+/*
+ *	We "borrow" this hook in order to set the data structures
+ *	up early enough before dma or init_hwif calls are made.
+ */
+
+static void __devinit init_iops_hpt366(ide_hwif_t *hwif)
+{
+	struct hpt_info *info = kmalloc(sizeof(struct hpt_info), GFP_KERNEL);
+	unsigned long dmabase = pci_resource_start(hwif->pci_dev, 4);
+	u8 did, rid;
+	
+	if(info == NULL) {
+		printk(KERN_WARNING "hpt366: out of memory.\n");
+		return;
+	}	
+	memset(info, 0, sizeof(struct hpt_info));
+	ide_set_hwifdata(hwif, info);
+	
+	if(dmabase) {
+		did = inb(dmabase + 0x22);
+		rid = inb(dmabase + 0x28);
+	
+		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
+			info->flags |= IS_372N;
+	}
+	
+	info->revision = hpt_revision(hwif->pci_dev);
+	
+	if (info->revision >= 3)
+		hpt37x_clocking(hwif);
+	else
+		hpt366_clocking(hwif);
+}		
+
 static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
@@ -1646,6 +1626,7 @@
 		.name		= "HPT366",
 		.init_setup	= init_setup_hpt366,
 		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
@@ -1656,6 +1637,7 @@
 		.name		= "HPT372A",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
@@ -1665,6 +1647,7 @@
 		.name		= "HPT302",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
@@ -1674,6 +1657,7 @@
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
@@ -1683,6 +1667,7 @@
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
 		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,	/* 4 */
@@ -1692,6 +1677,7 @@
 		.name		= "HPT372N",
 		.init_setup	= init_setup_hpt37x,
 		.init_chipset	= init_chipset_hpt366,
+		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,	/* 4 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/pci/it821x.c linux-2.6.12/drivers/ide/pci/it821x.c
--- linux.vanilla-2.6.12/drivers/ide/pci/it821x.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12/drivers/ide/pci/it821x.c	2005-06-20 21:27:07.000000000 +0100
@@ -0,0 +1,812 @@
+
+/*
+ * linux/drivers/ide/pci/it821x.c		Version 0.09	December 2004
+ *
+ * Copyright (C) 2004		Red Hat <alan@redhat.com>
+ *
+ *  May be copied or modified under the terms of the GNU General Public License
+ *  Based in part on the ITE vendor provided SCSI driver.
+ *
+ *  Documentation available from
+ * 	http://www.ite.com.tw/pc/IT8212F_V04.pdf
+ *  Some other documents are NDA.
+ *
+ *  The ITE8212 isn't exactly a standard IDE controller. It has two
+ *  modes. In pass through mode then it is an IDE controller. In its smart
+ *  mode its actually quite a capable hardware raid controller disguised
+ *  as an IDE controller. Smart mode only understands DMA read/write and
+ *  identify, none of the fancier commands apply. The IT8211 is identical
+ *  in other respects but lacks the raid mode.
+ *
+ *  Errata:
+ *  o	Rev 0x10 also requires master/slave hold the same DMA timings and
+ *	cannot do ATAPI MWDMA. 
+ *  o	The identify data for raid volumes lacks CHS info (technically ok)
+ *	but also fails to set the LBA28 and other bits. We fix these in
+ *	the IDE probe quirk code.
+ *  o	If you write LBA48 sized I/O's (ie > 256 sector) in smart mode
+ *	raid then the controller firmware dies
+ *  o	Smart mode without RAID doesn't clear all the necessary identify
+ *	bits to reduce the command set to the one used
+ *
+ *  This has a few impacts on the driver
+ *  - In pass through mode we do all the work you would expect
+ *  - In smart mode the clocking set up is done by the controller generally
+ *    but we must watch the other limits and filter.
+ *  - There are a few extra vendor commands that actually talk to the
+ *    controller but only work PIO with no IRQ.
+ *
+ *  Vendor areas of the identify block in smart mode are used for the
+ *  timing and policy set up. Each HDD in raid mode also has a serial
+ *  block on the disk. The hardware extra commands are get/set chip status,
+ *  rebuild, get rebuild status.
+ *
+ *  In Linux the driver supports pass through mode as if the device was
+ *  just another IDE controller. If the smart mode is running then
+ *  volumes are managed by the controller firmware and each IDE "disk"
+ *  is a raid volume. Even more cute - the controller can do automated
+ *  hotplug and rebuild.
+ *
+ *  The pass through controller itself is a little demented. It has a
+ *  flaw that it has a single set of PIO/MWDMA timings per channel so
+ *  non UDMA devices restrict each others performance. It also has a
+ *  single clock source per channel so mixed UDMA100/133 performance
+ *  isn't perfect and we have to pick a clock. Thankfully none of this
+ *  matters in smart mode. ATAPI DMA is not currently supported.
+ *
+ *  It seems the smart mode is a win for RAID1/RAID10 but otherwise not.
+ *
+ *  TODO
+ *	-	ATAPI UDMA is ok but not MWDMA it seems
+ *	-	RAID configuration ioctls
+ *	-	Move to libata once it grows up
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+
+struct it821x_dev
+{
+	unsigned int smart:1,		/* Are we in smart raid mode */
+		timing10:1;		/* Rev 0x10 */
+	u8	clock_mode;		/* 0, ATA_50 or ATA_66 */
+	u8	want[2][2];		/* Mode/Pri log for master slave */
+	/* We need these for switching the clock when DMA goes on/off
+	   The high byte is the 66Mhz timing */
+	u16	pio[2];			/* Cached PIO values */
+	u16	mwdma[2];		/* Cached MWDMA values */
+	u16	udma[2];		/* Cached UDMA values (per drive) */
+};
+
+#define ATA_66		0
+#define ATA_50		1
+#define ATA_ANY		2
+
+#define UDMA_OFF	0
+#define MWDMA_OFF	0
+
+/*
+ *	We allow users to force the card into non raid mode without
+ *	flashing the alternative BIOS. This is also neccessary right now
+ *	for embedded platforms that cannot run a PC BIOS but are using this
+ *	device.
+ */
+ 
+static int it8212_noraid;
+
+/**
+ *	it821x_program	-	program the PIO/MWDMA registers
+ *	@drive: drive to tune
+ *
+ *	Program the PIO/MWDMA timing for this channel according to the
+ *	current clock.
+ */
+
+static void it821x_program(ide_drive_t *drive, u16 timing)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int channel = hwif->channel;
+	u8 conf;
+
+	/* Program PIO/MWDMA timing bits */
+	if(itdev->clock_mode == ATA_66)
+		conf = timing >> 8;
+	else	
+		conf = timing & 0xFF;
+	pci_write_config_byte(hwif->pci_dev, 0x54 + 4 * channel, conf);
+}
+
+/**
+ *	it821x_program_udma	-	program the UDMA registers
+ *	@drive: drive to tune
+ *
+ *	Program the UDMA timing for this drive according to the
+ *	current clock.
+ */
+
+static void it821x_program_udma(ide_drive_t *drive, u16 timing)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int channel = hwif->channel;
+	int unit = drive->select.b.unit;
+	u8 conf;
+	
+	/* Program UDMA timing bits */
+	if(itdev->clock_mode == ATA_66)
+		conf = timing >> 8;
+	else
+		conf = timing & 0xFF;
+	if(itdev->timing10 == 0)
+		pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel + unit, conf);
+	else {
+		pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel, conf);
+		pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel + 1, conf);
+	}
+}
+
+
+/**
+ *	it821x_clock_strategy
+ *	@hwif: hardware interface
+ *
+ *	Select between the 50 and 66Mhz base clocks to get the best
+ *	results for this interface.
+ */
+
+static void it821x_clock_strategy(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+
+	u8 unit = drive->select.b.unit;
+	ide_drive_t *pair = &hwif->drives[1-unit];
+
+	int clock, altclock;
+	u8 v;
+	int sel = 0;
+
+	if(itdev->want[0][0] > itdev->want[1][0]) {
+		clock = itdev->want[0][1];
+		altclock = itdev->want[1][1];
+	} else {
+		clock = itdev->want[1][1];
+		altclock = itdev->want[0][1];
+	}
+
+	/* Master doesn't care does the slave ? */
+	if(clock == ATA_ANY)
+		clock = altclock;
+		
+	/* Nobody cares - keep the same clock */
+	if(clock == ATA_ANY)
+		return;
+	/* No change */
+	if(clock == itdev->clock_mode)
+		return;
+		
+	/* Load this into the controller ? */
+	if(clock == ATA_66)
+		itdev->clock_mode = ATA_66;
+	else {
+		itdev->clock_mode = ATA_50;
+		sel = 1;
+	}
+	pci_read_config_byte(hwif->pci_dev, 0x50, &v);
+	v &= ~(1 << (1 + hwif->channel));
+	v |= sel << (1 + hwif->channel);
+	pci_write_config_byte(hwif->pci_dev, 0x50, v);
+	
+	/*
+	 *	Reprogram the UDMA/PIO of the pair drive for the switch
+	 *	MWDMA will be dealt with by the dma switcher
+	 */
+	if(pair && itdev->udma[1-unit] != UDMA_OFF) {
+		it821x_program_udma(pair, itdev->udma[1-unit]);
+		it821x_program(pair, itdev->pio[1-unit]);
+	}
+	/*
+	 *	Reprogram the UDMA/PIO of our drive for the switch.
+	 *	MWDMA will be dealt with by the dma switcher
+	 */
+	if(itdev->udma[unit] != UDMA_OFF) {
+		it821x_program_udma(drive, itdev->udma[unit]);
+		it821x_program(drive, itdev->pio[unit]);
+	}
+}
+
+/**
+ *	it821x_ratemask	-	Compute available modes
+ *	@drive: IDE drive
+ *
+ *	Compute the available speeds for the devices on the interface. This
+ *	is all modes to ATA133 clipped by drive cable setup.
+ */
+
+static u8 it821x_ratemask (ide_drive_t *drive)
+{
+	u8 mode	= 4;
+	if (!eighty_ninty_three(drive))
+		mode = min(mode, (u8)1);
+	return mode;
+}
+
+/**
+ *	it821x_tuneproc	-	tune a drive
+ *	@drive: drive to tune
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller. By the time we are called the mode has been
+ *	modified as neccessary to handle the absence of seperate
+ *	master/slave timers for MWDMA/PIO.
+ *
+ *	This code is only used in pass through mode.
+ */
+
+static void it821x_tuneproc (ide_drive_t *drive, byte mode_wanted)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	
+	/* Spec says 89 ref driver uses 88 */
+	static u16 pio[]	= { 0xAA88, 0xA382, 0xA181, 0x3332, 0x3121 };
+	static u8 pio_want[]    = { ATA_66, ATA_66, ATA_66, ATA_66, ATA_ANY };
+	
+	if(itdev->smart)
+		return;
+
+	/* We prefer 66Mhz clock for PIO 0-3, don't care for PIO4 */
+	itdev->want[unit][1] = pio_want[mode_wanted];
+	itdev->want[unit][0] = 1;	/* PIO is lowest priority */
+	itdev->pio[unit] = pio[mode_wanted];
+	it821x_clock_strategy(drive);
+	it821x_program(drive, itdev->pio[unit]);
+}
+
+/**
+ *	it821x_tune_mwdma	-	tune a channel for MWDMA
+ *	@drive: drive to set up
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller when doing MWDMA in pass through mode. The caller
+ *	must manage the whole lack of per device MWDMA/PIO timings and
+ *	the shared MWDMA/PIO timing register.
+ */
+
+static void it821x_tune_mwdma (ide_drive_t *drive, byte mode_wanted)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	struct it821x_dev *itdev = (void *)ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	int channel = hwif->channel;
+	u8 conf;
+	
+	static u16 dma[]	= { 0x8866, 0x3222, 0x3121 };
+	static u8 mwdma_want[]	= { ATA_ANY, ATA_66, ATA_ANY };
+	
+	itdev->want[unit][1] = mwdma_want[mode_wanted];
+	itdev->want[unit][0] = 2;	/* MWDMA is low priority */
+	itdev->mwdma[unit] = dma[mode_wanted];
+	itdev->udma[unit] = UDMA_OFF;
+	
+	/* UDMA bits off - Revision 0x10 do them in pairs */
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	if(itdev->timing10)
+		conf |= channel ? 0x60: 0x18;
+	else
+		conf |= 1 << (3 + 2 * channel + unit);
+	pci_write_config_byte(hwif->pci_dev, 0x50, conf);
+
+	it821x_clock_strategy(drive);
+	/* FIXME: do we need to program this ? */
+	/* it821x_program(drive, itdev->mwdma[unit]); */
+}
+
+/**
+ *	it821x_tune_udma	-	tune a channel for UDMA
+ *	@drive: drive to set up
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller when doing UDMA modes in pass through.
+ */
+
+static void it821x_tune_udma (ide_drive_t *drive, byte mode_wanted)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	int channel = hwif->channel;
+	u8 conf;
+
+	static u16 udma[]	= { 0x4433, 0x4231, 0x3121, 0x2121, 0x1111, 0x2211, 0x1111 };
+	static u8 udma_want[]	= { ATA_ANY, ATA_50, ATA_ANY, ATA_66, ATA_66, ATA_50, ATA_66 };
+	
+	itdev->want[unit][1] = udma_want[mode_wanted];
+	itdev->want[unit][0] = 3;	/* UDMA is high priority */
+	itdev->mwdma[unit] = MWDMA_OFF;
+	itdev->udma[unit] = udma[mode_wanted];
+	if(mode_wanted >= 5)
+		itdev->udma[unit] |= 0x8080;	/* UDMA 5/6 select on */
+		
+	/* UDMA on. Again revision 0x10 must do the pair */
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	if(itdev->timing10)
+		conf &= channel ? 0x9F: 0xE7;
+	else
+		conf &= ~ (1 << (3 + 2 * channel + unit));
+	pci_write_config_byte(hwif->pci_dev, 0x50, conf);
+
+	it821x_clock_strategy(drive);
+	it821x_program_udma(drive, itdev->udma[unit]);
+	
+}
+
+/**
+ *	config_it821x_chipset_for_pio	-	set drive timings
+ *	@drive: drive to tune
+ *	@speed we want
+ *
+ *	Compute the best pio mode we can for a given device. We must
+ *	pick a speed that does not cause problems with the other device
+ *	on the cable.
+ */
+
+static void config_it821x_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+{
+	u8 unit = drive->select.b.unit;
+	ide_hwif_t *hwif = drive->hwif;
+	ide_drive_t *pair = &hwif->drives[1-unit];
+	u8 speed = 0, set_pio	= ide_get_best_pio_mode(drive, 255, 5, NULL);
+	u8 pair_pio;
+	
+	/* We have to deal with this mess in pairs */
+	if(pair != NULL) {
+		pair_pio = ide_get_best_pio_mode(pair, 255, 5, NULL);
+		/* Trim PIO to the slowest of the master/slave */
+		if(pair_pio < set_pio)
+			set_pio = pair_pio;
+	}
+	it821x_tuneproc(drive, set_pio);
+	speed = XFER_PIO_0 + set_pio;
+	/* XXX - We trim to the lowest of the pair so the other drive
+	   will always be fine at this point until we do hotplug passthru */
+
+	if (set_speed)
+		(void) ide_config_drive_speed(drive, speed);
+}
+
+/**
+ *	it821x_dma_read	-	DMA hook
+ *	@drive: drive for DMA
+ *
+ *	The IT821x has a single timing register for MWDMA and for PIO
+ *	operations. As we flip back and forth we have to reload the
+ *	clock. In addition the rev 0x10 device only works if the same
+ *	timing value is loaded into the master and slave UDMA clock
+ * 	so we must also reload that.
+ *
+ *	FIXME: we could figure out in advance if we need to do reloads
+ */
+
+static void it821x_dma_start(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	if(itdev->mwdma[unit] != MWDMA_OFF)
+		it821x_program(drive, itdev->mwdma[unit]);
+	else if(itdev->udma[unit] != UDMA_OFF && itdev->timing10)
+		it821x_program_udma(drive, itdev->udma[unit]);
+	ide_dma_start(drive);
+}
+
+/**
+ *	it821x_dma_write	-	DMA hook
+ *	@drive: drive for DMA stop
+ *
+ *	The IT821x has a single timing register for MWDMA and for PIO
+ *	operations. As we flip back and forth we have to reload the
+ *	clock.
+ */
+
+static int it821x_dma_end(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	int unit = drive->select.b.unit;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int ret = __ide_dma_end(drive);
+	if(itdev->mwdma[unit] != MWDMA_OFF)
+		it821x_program(drive, itdev->pio[unit]);
+	return ret;
+}
+
+	
+/**
+ *	it821x_tune_chipset	-	set controller timings
+ *	@drive: Drive to set up
+ *	@xferspeed: speed we want to achieve
+ *
+ *	Tune the ITE chipset for the desired mode. If we can't achieve
+ *	the desired mode then tune for a lower one, but ultimately
+ *	make the thing work.
+ */
+
+static int it821x_tune_chipset (ide_drive_t *drive, byte xferspeed)
+{
+
+	ide_hwif_t *hwif	= drive->hwif;
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	u8 speed		= ide_rate_filter(it821x_ratemask(drive), xferspeed);
+
+	if(!itdev->smart) {
+		switch(speed) {
+			case XFER_PIO_4:
+			case XFER_PIO_3:
+			case XFER_PIO_2:
+			case XFER_PIO_1:
+			case XFER_PIO_0:
+				it821x_tuneproc(drive, (speed - XFER_PIO_0));
+				break;
+			/* MWDMA tuning is really hard because our MWDMA and PIO
+			   timings are kept in the same place. We can switch in the
+			   host dma on/off callbacks */
+			case XFER_MW_DMA_2:
+			case XFER_MW_DMA_1:
+			case XFER_MW_DMA_0:
+				it821x_tune_mwdma(drive, (speed - XFER_MW_DMA_0));
+				break;
+			case XFER_UDMA_6:
+			case XFER_UDMA_5:
+			case XFER_UDMA_4:
+			case XFER_UDMA_3:
+			case XFER_UDMA_2:
+			case XFER_UDMA_1:
+			case XFER_UDMA_0:
+				it821x_tune_udma(drive, (speed - XFER_UDMA_0));
+				break;
+			default:
+				return 1;
+		}
+	}
+	/*
+	 *	In smart mode the clocking is done by the host controller
+	 * 	snooping the mode we picked. The rest of it is not our problem
+	 */
+	return ide_config_drive_speed(drive, speed);
+}
+
+/**
+ *	config_chipset_for_dma	-	configure for DMA
+ *	@drive: drive to configure
+ *
+ *	Called by the IDE layer when it wants the timings set up.
+ */
+
+static int config_chipset_for_dma (ide_drive_t *drive)
+{
+	u8 speed	= ide_dma_speed(drive, it821x_ratemask(drive));
+
+	config_it821x_chipset_for_pio(drive, !speed);
+	it821x_tune_chipset(drive, speed);
+	return ide_dma_enable(drive);
+}
+
+/**
+ *	it821x_configure_drive_for_dma	-	set up for DMA transfers
+ *	@drive: drive we are going to set up
+ *
+ *	Set up the drive for DMA, tune the controller and drive as
+ *	required. If the drive isn't suitable for DMA or we hit
+ *	other problems then we will drop down to PIO and set up
+ *	PIO appropriately
+ */
+
+static int it821x_config_drive_for_dma (ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+
+	if (ide_use_dma(drive)) {
+		if (config_chipset_for_dma(drive))
+			return hwif->ide_dma_on(drive);
+	}
+	config_it821x_chipset_for_pio(drive, 1);
+	return hwif->ide_dma_off_quietly(drive);
+}
+
+/**
+ *	ata66_it821x	-	check for 80 pin cable
+ *	@hwif: interface to check
+ *
+ *	Check for the presence of an ATA66 capable cable on the
+ *	interface. Problematic as it seems some cards don't have
+ *	the needed logic onboard.
+ */
+
+static unsigned int __devinit ata66_it821x(ide_hwif_t *hwif)
+{
+	/* The reference driver also only does disk side */
+	return 1;
+}
+
+/**
+ *	it821x_fixup	-	post init callback
+ *	@hwif: interface
+ *
+ *	This callback is run after the drives have been probed but
+ *	before anything gets attached. It allows drivers to do any 
+ *	final tuning that is needed, or fixups to work around bugs.
+ */
+
+static void __devinit it821x_fixups(ide_hwif_t *hwif)
+{
+	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
+	int i;
+
+	if(!itdev->smart) {
+		/*
+		 *	If we are in pass through mode then not much
+		 *	needs to be done, but we do bother to clear the
+		 *	IRQ mask as we may well be in PIO (eg rev 0x10)
+		 *	for now and we know unmasking is safe on this chipset.
+		 */
+		for (i = 0; i < 2; i++) {
+			ide_drive_t *drive = &hwif->drives[i];
+			if(drive->present)
+				drive->unmask = 1;
+		}
+		return;
+	}
+	/*
+	 *	Perform fixups on smart mode. We need to "lose" some
+	 *	capabilities the firmware lacks but does not filter, and
+	 *	also patch up some capability bits that it forgets to set
+	 *	in RAID mode.
+	 */
+	
+	for(i = 0; i < 2; i++) {
+		ide_drive_t *drive = &hwif->drives[i];
+		struct hd_driveid *id;
+		u16 *idbits;
+		
+		if(!drive->present)
+			continue;
+		id = drive->id;
+		idbits = (u16 *)drive->id;
+		
+		/* Check for RAID v native */
+		if(strstr(id->model, "Integrated Technology Express")) {
+			/* In raid mode the ident block is slightly buggy
+			   We need to set the bits so that the IDE layer knows
+			   LBA28. LBA48 and DMA ar valid */
+			id->capability |= 3;		/* LBA28, DMA */
+			id->command_set_2 |= 0x0400;	/* LBA48 valid */
+			id->cfs_enable_2 |= 0x0400;	/* LBA48 on */
+			/* Reporting logic */
+			printk(KERN_INFO "%s: IT8212 %sRAID %d volume",
+				drive->name,
+				idbits[147] ? "Bootable ":"",
+				idbits[129]);
+				if(idbits[129] != 1)
+					printk("(%dK stripe)", idbits[146]);
+				printk(".\n");
+			/* Now the core code will have wrongly decided no DMA 
+			   so we need to fix this */
+			hwif->ide_dma_off_quietly(drive);
+#ifdef CONFIG_IDEDMA_ONLYDISK
+			if (drive->media == ide_disk)
+#endif
+				hwif->ide_dma_check(drive);
+		} else {
+			/* Non RAID volume. Fixups to stop the core code 
+			   doing unsupported things */
+			id->field_valid &= 1;
+			id->queue_depth = 0;
+			id->command_set_1 = 0;
+			id->command_set_2 &= 0xC400;
+			id->cfsse &= 0xC000;
+			id->cfs_enable_1 = 0;
+			id->cfs_enable_2 &= 0xC400;
+			id->csf_default &= 0xC000;
+			id->word127 = 0;
+			id->dlf = 0;
+			id->csfo = 0;
+			id->cfa_power = 0;
+			printk(KERN_INFO "%s: Performing identify fixups.\n",
+				drive->name);
+		}
+	}
+	
+}
+
+/**
+ *	init_hwif_it821x	-	set up hwif structs
+ *	@hwif: interface to set up
+ *
+ *	We do the basic set up of the interface structure. The IT8212
+ *	requires several custom handlers so we override the default
+ *	ide DMA handlers appropriately
+ */
+
+static void __devinit init_hwif_it821x(ide_hwif_t *hwif)
+{
+	struct it821x_dev *idev = kmalloc(sizeof(struct it821x_dev), GFP_KERNEL);
+	u8 conf;
+
+	if(idev == NULL) {
+		printk(KERN_ERR "it821x: out of memory, falling back to legacy behaviour.\n");
+		goto fallback;
+	}
+	memset(idev, 0, sizeof(struct it821x_dev));
+	ide_set_hwifdata(hwif, idev);
+
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	if(conf & 1) {
+		idev->smart = 1;
+		hwif->atapi_dma = 0;
+		/* Long I/O's although allowed in LBA48 space cause the
+		   onboard firmware to enter the twighlight zone */
+		hwif->rqsize = 256;
+	}
+
+	/* Pull the current clocks from 0x50 also */
+	if (conf & (1 << (1 + hwif->channel)))
+		idev->clock_mode = ATA_50;
+	else
+		idev->clock_mode = ATA_66;
+		
+	idev->want[0][1] = ATA_ANY;
+	idev->want[1][1] = ATA_ANY;
+		
+	/*
+	 *	Not in the docs but according to the reference driver
+	 *	this is neccessary. 
+	 */
+
+	pci_read_config_byte(hwif->pci_dev, 0x08, &conf);
+	if(conf == 0x10) {
+		idev->timing10 = 1;
+		hwif->atapi_dma = 0;
+		if(!idev->smart)
+			printk(KERN_WARNING "it821x: Revision 0x10, workarounds activated.\n");
+	}
+		
+	hwif->speedproc = &it821x_tune_chipset;
+	hwif->tuneproc	= &it821x_tuneproc;
+	
+	/* MWDMA/PIO clock switching for pass through mode */
+	if(!idev->smart) {
+		hwif->dma_start = &it821x_dma_start;
+		hwif->ide_dma_end = &it821x_dma_end;
+	}
+
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (!hwif->dma_base)
+		goto fallback;
+
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x07;
+
+	hwif->ide_dma_check = &it821x_config_drive_for_dma;
+	if (!(hwif->udma_four))
+		hwif->udma_four = ata66_it821x(hwif);
+
+	/*
+	 *	The BIOS often doesn't set up DMA on this controller
+	 *	so we always do it.
+	 */
+
+	hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+	return;
+fallback:
+	hwif->autodma = 0;
+	return;
+}
+
+static void __devinit it8212_disable_raid(struct pci_dev *dev)
+{
+	/* Reset local CPU, and set BIOS not ready */
+	pci_write_config_byte(dev, 0x5E, 0x01);
+
+	/* Set to bypass mode, and reset PCI bus */
+	pci_write_config_byte(dev, 0x50, 0x00);
+	pci_write_config_word(dev, PCI_COMMAND,
+			      PCI_COMMAND_PARITY | PCI_COMMAND_IO |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+	pci_write_config_word(dev, 0x40, 0xA0F3);
+
+	pci_write_config_dword(dev,0x4C, 0x02040204);
+	pci_write_config_byte(dev, 0x42, 0x36);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0);
+}
+
+static unsigned int __devinit init_chipset_it821x(struct pci_dev *dev, const char *name)
+{
+	u8 conf;
+	static char *mode[2] = { "pass through", "smart" };
+
+	/* Force the card into bypass mode if so requested */
+	if (it8212_noraid) {
+		printk(KERN_INFO "it8212: forcing bypass mode.\n");
+		it8212_disable_raid(dev);
+	}
+	pci_read_config_byte(dev, 0x50, &conf);
+	printk(KERN_INFO "it821x: controller in %s mode.\n", mode[conf & 1]);
+	return 0;
+}
+
+
+#define DECLARE_ITE_DEV(name_str)			\
+	{						\
+		.name		= name_str,		\
+		.init_chipset	= init_chipset_it821x,	\
+		.init_hwif	= init_hwif_it821x,	\
+		.channels	= 2,			\
+		.autodma	= AUTODMA,		\
+		.bootable	= ON_BOARD,		\
+		.fixup	 	= it821x_fixups		\
+	}
+
+static ide_pci_device_t it821x_chipsets[] __devinitdata = {
+	/* 0 */ DECLARE_ITE_DEV("IT8212"),
+};
+
+/**
+ *	it821x_init_one	-	pci layer discovery entry
+ *	@dev: PCI device
+ *	@id: ident table entry
+ *
+ *	Called by the PCI code when it finds an ITE821x controller.
+ *	We then use the IDE PCI generic helper to do most of the work.
+ */
+
+static int __devinit it821x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_setup_pci_device(dev, &it821x_chipsets[id->driver_data]);
+	return 0;
+}
+
+static struct pci_device_id it821x_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8211,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8212,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, it821x_pci_tbl);
+
+static struct pci_driver driver = {
+	.name		= "ITE821x IDE",
+	.id_table	= it821x_pci_tbl,
+	.probe		= it821x_init_one,
+};
+
+static int __init it821x_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+module_init(it821x_ide_init);
+
+module_param_named(noraid, it8212_noraid, int, S_IRUGO);
+MODULE_PARM_DESC(it8212_noraid, "Force card into bypass mode");
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("PCI driver module for the ITE 821x");
+MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/pci/Makefile linux-2.6.12/drivers/ide/pci/Makefile
--- linux.vanilla-2.6.12/drivers/ide/pci/Makefile	2005-06-19 11:21:23.000000000 +0100
+++ linux-2.6.12/drivers/ide/pci/Makefile	2005-06-20 20:41:44.000000000 +0100
@@ -12,6 +12,7 @@
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 #obj-$(CONFIG_BLK_DEV_HPT37X)		+= hpt37x.o
 obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
+obj-$(CONFIG_BLK_DEV_IT821X)		+= it821x.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
 obj-$(CONFIG_BLK_DEV_OPTI621)		+= opti621.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_OLD)	+= pdc202xx_old.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/include/linux/pci_ids.h linux-2.6.12/include/linux/pci_ids.h
--- linux.vanilla-2.6.12/include/linux/pci_ids.h	2005-06-19 11:30:59.000000000 +0100
+++ linux-2.6.12/include/linux/pci_ids.h	2005-06-20 21:25:36.400761424 +0100
@@ -1810,6 +1810,8 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
+#define PCI_DEVICE_ID_ITE_8211		0x8211
+#define PCI_DEVICE_ID_ITE_8212		0x8212
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 

