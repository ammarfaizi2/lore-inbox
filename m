Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWFZNld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWFZNld (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWFZNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:41:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23261 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751222AbWFZNlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:41:31 -0400
Subject: PATCH: Housekeeping on IDE drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 14:57:30 +0100
Message-Id: <1151330250.27147.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move auto arrays to static (const). Clean up using PCI_DEVICE in places, remove unreachable junk and dead code.

Fix the serverworks cable detect logic (if ordering is wrong). Backport
from libata. Plenty of scope for more cleanup left.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/aec62xx.c linux-2.6.17/drivers/ide/pci/aec62xx.c
--- linux.vanilla-2.6.17/drivers/ide/pci/aec62xx.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/aec62xx.c	2006-06-26 13:52:13.309762408 +0100
@@ -22,7 +22,7 @@
 	u8 ultra_settings;
 };
 
-static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
+static const struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
 	{	XFER_UDMA_6,	0x31,	0x07	},
 	{	XFER_UDMA_5,	0x31,	0x06	},
 	{	XFER_UDMA_4,	0x31,	0x05	},
@@ -42,7 +42,7 @@
 	{	0,		0x00,	0x00	}
 };
 
-static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
+static const struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
 	{	XFER_UDMA_6,	0x41,	0x06	},
 	{	XFER_UDMA_5,	0x41,	0x05	},
 	{	XFER_UDMA_4,	0x41,	0x04	},
@@ -425,12 +425,12 @@
 	return d->init_setup(dev, d);
 }
 
-static struct pci_device_id aec62xx_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+static const struct pci_device_id aec62xx_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860), 1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R), 2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865), 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R), 4 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/cmd64x.c linux-2.6.17/drivers/ide/pci/cmd64x.c
--- linux.vanilla-2.6.17/drivers/ide/pci/cmd64x.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/cmd64x.c	2006-06-26 13:38:17.017898096 +0100
@@ -190,14 +190,6 @@
 #endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
 
 /*
- * Registers and masks for easy access by drive index:
- */
-#if 0
-static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
-static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
-#endif
-
-/*
  * This routine writes the prepared setup/active/recovery counts
  * for a drive into the cmd646 chipset registers to active them.
  */
@@ -606,13 +598,6 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-#ifdef __i386__
-	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
-	}
-#endif
-
 	switch(dev->device) {
 		case PCI_DEVICE_ID_CMD_643:
 			break;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/serverworks.c linux-2.6.17/drivers/ide/pci/serverworks.c
--- linux.vanilla-2.6.17/drivers/ide/pci/serverworks.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/serverworks.c	2006-06-26 13:27:00.993669400 +0100
@@ -123,11 +123,11 @@
 }
 static int svwks_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
-	u8 udma_modes[]		= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
-	u8 dma_modes[]		= { 0x77, 0x21, 0x20 };
-	u8 pio_modes[]		= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
-	u8 drive_pci[]		= { 0x41, 0x40, 0x43, 0x42 };
-	u8 drive_pci2[]		= { 0x45, 0x44, 0x47, 0x46 };
+	static const u8 udma_modes[]		= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
+	static const u8 dma_modes[]		= { 0x77, 0x21, 0x20 };
+	static const u8 pio_modes[]		= { 0x5d, 0x47, 0x34, 0x22, 0x20 };
+	static const u8 drive_pci[]		= { 0x41, 0x40, 0x43, 0x42 };
+	static const u8 drive_pci2[]		= { 0x45, 0x44, 0x47, 0x46 };
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -392,16 +392,6 @@
 			}
 			outb_p(0x06, 0x0c00);
 			dev->irq = inb_p(0x0c01);
-#if 0
-			printk("%s: device class (0x%04x)\n",
-				name, dev->class);
-			if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
-				dev->class &= ~0x000F0F00;
-		//		dev->class |= ~0x00000400;
-				dev->class |= ~0x00010100;
-				/**/
-			}
-#endif
 		} else {
 			struct pci_dev * findev = NULL;
 			u8 reg41 = 0;
@@ -452,7 +442,7 @@
 		pci_write_config_byte(dev, 0x5A, btr);
 	}
 
-	return (dev->irq) ? dev->irq : 0;
+	return dev->irq;
 }
 
 static unsigned int __devinit ata66_svwks_svwks (ide_hwif_t *hwif)
@@ -500,11 +490,6 @@
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
-	/* Per Specified Design by OEM, and ASIC Architect */
-	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
-	    (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2))
-		return 1;
-
 	/* Server Works */
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_SERVERWORKS)
 		return ata66_svwks_svwks (hwif);
@@ -517,10 +502,14 @@
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN)
 		return ata66_svwks_cobalt (hwif);
 
+	/* Per Specified Design by OEM, and ASIC Architect */
+	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
+	    (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2))
+		return 1;
+
 	return 0;
 }
 
-#undef CAN_SW_DMA
 static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
 	u8 dma_stat = 0;
@@ -537,9 +526,6 @@
 		hwif->ultra_mask = 0x3f;
 
 	hwif->mwdma_mask = 0x07;
-#ifdef CAN_SW_DMA
-	hwif->swdma_mask = 0x07;
-#endif /* CAN_SW_DMA */
 
 	hwif->autodma = 0;
 
@@ -562,8 +548,6 @@
 	hwif->drives[1].autodma = (dma_stat & 0x40);
 	hwif->drives[0].autotune = (!(dma_stat & 0x20));
 	hwif->drives[1].autotune = (!(dma_stat & 0x40));
-//	hwif->drives[0].autodma = hwif->autodma;
-//	hwif->drives[1].autodma = hwif->autodma;
 }
 
 /*
@@ -593,11 +577,6 @@
 		if (dev->resource[0].start == 0x01f1)
 			d->bootable = ON_BOARD;
 	}
-#if 0
-	if ((IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB6) &&
-             (!(PCI_FUNC(dev->devfn) & 1)))
-		d->autodma = AUTODMA;
-#endif
 
 	d->channels = ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
 			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
@@ -671,11 +650,11 @@
 }
 
 static struct pci_device_id svwks_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE), 1},
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE), 2},
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2), 3},
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE), 4},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/sl82c105.c linux-2.6.17/drivers/ide/pci/sl82c105.c
--- linux.vanilla-2.6.17/drivers/ide/pci/sl82c105.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/sl82c105.c	2006-06-26 13:23:15.532944640 +0100
@@ -447,7 +447,6 @@
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
 		       hwif->name, rev);
 	} else {
-#ifdef CONFIG_BLK_DEV_IDEDMA
 		dma_state |= 0x60;
 
 		hwif->atapi_dma = 1;
@@ -468,7 +467,6 @@
 
 		if (hwif->mate)
 			hwif->serialized = hwif->mate->serialized = 1;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 	}
 	hwif->OUTB(dma_state, hwif->dma_base + 2);
 }
@@ -489,7 +487,7 @@
 }
 
 static struct pci_device_id sl82c105_pci_tbl[] = {
-	{ PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105), 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sl82c105_pci_tbl);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/slc90e66.c linux-2.6.17/drivers/ide/pci/slc90e66.c
--- linux.vanilla-2.6.17/drivers/ide/pci/slc90e66.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/slc90e66.c	2006-06-26 13:21:20.696402448 +0100
@@ -72,7 +72,8 @@
 	u16 master_data;
 	u8 slave_data;
 				 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
+	static const u8 timings[][2]= {
+				    { 0, 0 },
 				    { 0, 0 },
 				    { 1, 0 },
 				    { 2, 1 },
@@ -119,7 +120,6 @@
 	pci_read_config_word(dev, 0x4a, &reg4a);
 
 	switch(speed) {
-#ifdef CONFIG_BLK_DEV_IDEDMA
 		case XFER_UDMA_4:	u_speed = 4 << (drive->dn * 4); break;
 		case XFER_UDMA_3:	u_speed = 3 << (drive->dn * 4); break;
 		case XFER_UDMA_2:	u_speed = 2 << (drive->dn * 4); break;
@@ -128,7 +128,6 @@
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:	break;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 		case XFER_PIO_4:
 		case XFER_PIO_3:
 		case XFER_PIO_2:
@@ -156,7 +155,6 @@
 	return (ide_config_drive_speed(drive, speed));
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 static int slc90e66_config_drive_for_dma (ide_drive_t *drive)
 {
 	u8 speed = ide_dma_speed(drive, slc90e66_ratemask(drive));
@@ -194,7 +192,6 @@
 	/* IORDY not supported */
 	return 0;
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
 {
@@ -222,7 +219,6 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-#ifdef CONFIG_BLK_DEV_IDEDMA 
 	if (!(hwif->udma_four))
 		/* bit[0(1)]: 0:80, 1:40 */
 		hwif->udma_four = (reg47 & mask) ? 0 : 1;
@@ -232,7 +228,6 @@
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
-#endif /* !CONFIG_BLK_DEV_IDEDMA */
 }
 
 static ide_pci_device_t slc90e66_chipset __devinitdata = {
@@ -250,7 +245,7 @@
 }
 
 static struct pci_device_id slc90e66_pci_tbl[] = {
-	{ PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1), 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);

