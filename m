Return-Path: <linux-kernel-owner+w=401wt.eu-S1751597AbXALEWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXALEWx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXALEWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:22:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbXALEWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:22:51 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=RgFOItOBd748ngRno7GO/hhb+iVBMaVjKuaKYQ76Y+1nf6uMmvY6JP+IzM/aFbsYD7dkzhLbZXr3rL9VofUFTz9H2Fc2wMqNiifxAHl6F1d6ehNGGgXhgM2eC5PpYxPcMRD+ZD7BKc3zl4noriHkn+MyaD+3a5KMvqcEKhWFqH8=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:26:27 +0100
Message-Id: <20070112042627.28794.47002.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/19] ide: it8213 driver update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: it8213 driver update

* set ATAPI/IORDY/TIME bits correctly in it8213_tuneproc()
* fix UDMA/MWDMA/SWDMA masks in it8213_init_hwif()
* in it8213_tune_chipset() SWDMA2 mode should be used instead of MWDMA0
* backport various fixes from piix/slc90e66 drivers:
  - in it8213_tuneproc() the highest possible PIO mode is PIO4 (not PIO5)
  - clear ATAPI/IORDY/TIME bits before setting them also for slave device
  - use ->speedproc in it8213_config_drive_for_dma()
  - don't try to tune PIO in config_chipset_for_pio()
  - simplify is_slave calculation in it8213_tuneproc()
  - misc cleanups
* fix it8213_ratemask() and it8213_tuneproc() comments
* simplify it8213_init_hwif()
* remove init_chipset_it8213()
* add missing Copyrights and update MODULE_AUTHOR()
* CodingStyle cleanups
* remove dead code

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/it8213.c |  172 ++++++++++++++++++-----------------------------
 1 file changed, 66 insertions(+), 106 deletions(-)

Index: a/drivers/ide/pci/it8213.c
===================================================================
--- a.orig/drivers/ide/pci/it8213.c
+++ a/drivers/ide/pci/it8213.c
@@ -1,3 +1,11 @@
+/*
+ * ITE 8213 IDE driver
+ *
+ * Copyright (C) 2006 Jack Lee
+ * Copyright (C) 2006 Alan Cox
+ * Copyright (C) 2007 Bartlomiej Zolnierkiewicz
+ */
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -14,14 +22,14 @@
  *	@drive: IDE drive
  *
  *	Compute the available speeds for the devices on the interface. This
- *	is all modes to ATA100 clipped by drive cable setup.
+ *	is all modes to ATA133 clipped by drive cable setup.
  */
 
 static u8 it8213_ratemask (ide_drive_t *drive)
 {
 	u8 mode	= 4;
 	if (!eighty_ninty_three(drive))
-		mode = min(mode, (u8)1);
+		mode = min_t(u8, mode, 1);
 	return mode;
 }
 
@@ -62,55 +70,57 @@ static u8 it8213_dma_2_pio (u8 xfer_rate
 	}
 }
 
-static spinlock_t tune_lock = SPIN_LOCK_UNLOCKED;
-
 /*
  *	it8213_tuneproc	-	tune a drive
  *	@drive: drive to tune
- *	@mode_wanted: the target operating mode
- *
- *	Load the timing settings for this device mode into the
- *	controller. By the time we are called the mode has been
- *	modified as neccessary to handle the absence of seperate
- *	master/slave timers for MWDMA/PIO.
+ *	@pio: desired PIO mode
  *
- *	This code is only used in pass through mode.
+ *	Set the interface PIO mode.
  */
 
-static void it8213_tuneproc (ide_drive_t *drive,  u8 pio)
+static void it8213_tuneproc (ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	int is_slave		= (&hwif->drives[1] == drive);
+	int is_slave		= drive->dn & 1;
 	int master_port		= 0x40;
 	int slave_port		= 0x44;
 	unsigned long flags;
 	u16 master_data;
 	u8 slave_data;
+	static DEFINE_SPINLOCK(tune_lock);
+	int control = 0;
 
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
+	static const u8 timings[][2]= {
+					{ 0, 0 },
+					{ 0, 0 },
+					{ 1, 0 },
+					{ 2, 1 },
+					{ 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
 
 	spin_lock_irqsave(&tune_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
+
+	if (pio > 1)
+		control |= 1;	/* Programmable timing on */
+	if (drive->media != ide_disk)
+		control |= 4;	/* ATAPI */
+	if (pio > 2)
+		control |= 2;	/* IORDY */
 	if (is_slave) {
-		master_data = master_data | 0x4000;
+		master_data |=  0x4000;
+		master_data &= ~0x0070;
 		if (pio > 1)
-
-			master_data = master_data | 0x0070;
+			master_data = master_data | (control << 4);
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data = slave_data & 0xf0;
-		slave_data = slave_data | (((timings[pio][0] << 2) | (timings[pio][1]) << 0));
+		slave_data = slave_data | (timings[pio][0] << 2) | timings[pio][1];
 	} else {
-		master_data = master_data & 0xccf8;
+		master_data &= ~0x3307;
 		if (pio > 1)
-
-			master_data = master_data | 0x0007;
+			master_data = master_data | control;
 		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);
@@ -119,7 +129,6 @@ static void it8213_tuneproc (ide_drive_t
 	spin_unlock_irqrestore(&tune_lock, flags);
 }
 
-
 /**
  *	it8213_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
@@ -130,7 +139,7 @@ static void it8213_tuneproc (ide_drive_t
  *	make the thing work.
  */
 
-static int it8213_tune_chipset (ide_drive_t *drive, byte xferspeed)
+static int it8213_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -154,15 +163,15 @@ static int it8213_tune_chipset (ide_driv
 	switch(speed) {
 		case XFER_UDMA_6:
 		case XFER_UDMA_4:
-		case XFER_UDMA_2:u_speed = 2 << (drive->dn * 4); break;
+		case XFER_UDMA_2:	u_speed = 2 << (drive->dn * 4); break;
 		case XFER_UDMA_5:
 		case XFER_UDMA_3:
-		case XFER_UDMA_1:u_speed = 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:u_speed = 0 << (drive->dn * 4); break;
+		case XFER_UDMA_1:	u_speed = 1 << (drive->dn * 4); break;
+		case XFER_UDMA_0:	u_speed = 0 << (drive->dn * 4); break;
 			break;
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
+		case XFER_SW_DMA_2:
 			break;
 		case XFER_PIO_4:
 		case XFER_PIO_3:
@@ -174,8 +183,7 @@ static int it8213_tune_chipset (ide_driv
 			return -1;
 	}
 
-		if (speed >= XFER_UDMA_0)
-		{
+	if (speed >= XFER_UDMA_0) {
 		if (!(reg48 & u_flag))
 			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed >= XFER_UDMA_5) {
@@ -186,14 +194,12 @@ static int it8213_tune_chipset (ide_driv
 
 		if ((reg4a & a_speed) != u_speed)
 			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
-		if (speed > XFER_UDMA_2)
-		{
+		if (speed > XFER_UDMA_2) {
 			if (!(reg54 & v_flag))
 				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
-		} else /*if(speed >= XFER_UDMA_0)*/
-		{
+	} else {
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
 		if (reg4a & a_speed)
@@ -202,11 +208,10 @@ static int it8213_tune_chipset (ide_driv
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 		if (reg55 & w_flag)
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
-		}
+	}
 	it8213_tuneproc(drive, it8213_dma_2_pio(speed));
 	return ide_config_drive_speed(drive, speed);
-	}
-
+}
 
 /*
  *	config_chipset_for_dma	-	configure for DMA
@@ -217,48 +222,17 @@ static int it8213_tune_chipset (ide_driv
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
-	  u8 speed	= ide_dma_speed(drive, it8213_ratemask(drive));
+	u8 speed = ide_dma_speed(drive, it8213_ratemask(drive));
+
 	if (!speed)
-	{
-		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = it8213_dma_2_pio(XFER_PIO_0 + tspeed);
-	}
-//	config_it8213_chipset_for_pio(drive, !speed);
+		return 0;
+
 	it8213_tune_chipset(drive, speed);
+
 	return ide_dma_enable(drive);
 }
 
 /**
- *	config_it8213_chipset_for_pio	-	set drive timings
- *	@drive: drive to tune
- *	@speed we want
- *
- *	Compute the best pio mode we can for a given device. We must
- *	pick a speed that does not cause problems with the other device
- *	on the cable.
- */
-/*
-static void config_it8213_chipset_for_pio (ide_drive_t *drive, byte set_speed)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-//	u8 unit = drive->select.b.unit;
-	ide_hwif_t *hwif = drive->hwif;
-	ide_drive_t *pair = &hwif->drives[1-unit];
-	u8 speed = 0, set_pio	= ide_get_best_pio_mode(drive, 255, 5, NULL);
-	u8 pair_pio;
-
-	if(pair != NULL) {
-		pair_pio = ide_get_best_pio_mode(pair, 255, 5, NULL);
-		if(pair_pio < set_pio)
-			set_pio = pair_pio;
-	}
-	it8213_tuneproc(drive, set_pio);
-	speed = XFER_PIO_0 + set_pio;
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, speed);
-}
-*/
-/**
  *	it8213_configure_drive_for_dma	-	set up for DMA transfers
  *	@drive: drive we are going to set up
  *
@@ -270,26 +244,19 @@ static void config_it8213_chipset_for_pi
 
 static int it8213_config_drive_for_dma (ide_drive_t *drive)
 {
-//	ide_hwif_t *hwif	= drive->hwif;
-//	struct hd_driveid *id = drive->id;
-	ide_hwif_t *hwif	= HWIF(drive);
+	ide_hwif_t *hwif = drive->hwif;
+
 	if (ide_use_dma(drive)) {
 		if (config_chipset_for_dma(drive))
 			return hwif->ide_dma_on(drive);
 	}
-//	config_it8213_chipset_for_pio(drive, 1);
-	hwif->tuneproc(drive, 255);
- 	return hwif->ide_dma_off_quietly(drive);
-}
 
+	hwif->speedproc(drive, XFER_PIO_0
+			+ ide_get_best_pio_mode(drive, 255, 4, NULL));
 
-static unsigned int __devinit init_chipset_it8213(struct pci_dev *dev, const char *name)
-{
-	printk(KERN_INFO "it8213: controller in IDE mode.\n");
-	return 0;
+ 	return hwif->ide_dma_off_quietly(drive);
 }
 
-
 /**
  *	init_hwif_it8213	-	set up hwif structs
  *	@hwif: interface to set up
@@ -302,9 +269,6 @@ static unsigned int __devinit init_chips
 static void __devinit init_hwif_it8213(ide_hwif_t *hwif)
 {
 	u8 reg42h = 0, ata66 = 0;
-	u8 mask = 0x02;
-
-	hwif->atapi_dma = 1;
 
 	hwif->speedproc = &it8213_tune_chipset;
 	hwif->tuneproc	= &it8213_tuneproc;
@@ -315,19 +279,19 @@ static void __devinit init_hwif_it8213(i
 	hwif->drives[1].autotune = 1;
 
 	if (!hwif->dma_base)
-		goto fallback;
+		return;
+
 	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
+	hwif->ultra_mask = 0x3f;
+	hwif->mwdma_mask = 0x06;
+	hwif->swdma_mask = 0x04;
 
 	pci_read_config_byte(hwif->pci_dev, 0x42, &reg42h);
-	ata66 = (reg42h & mask) ? 0 : 1;
+	ata66 = (reg42h & 0x02) ? 0 : 1;
 
 	hwif->ide_dma_check = &it8213_config_drive_for_dma;
 	if (!(hwif->udma_four))
 		hwif->udma_four = ata66;
-//		hwif->udma_four = 0;
 
 	/*
 	 *	The BIOS often doesn't set up DMA on this controller
@@ -338,20 +302,15 @@ static void __devinit init_hwif_it8213(i
 
 	hwif->drives[0].autodma = hwif->autodma;
 	hwif->drives[1].autodma = hwif->autodma;
-	return;
-fallback:
-	hwif->autodma = 0;
-	return;
 }
 
 
 #define DECLARE_ITE_DEV(name_str)			\
 	{						\
 		.name		= name_str,		\
-		.init_chipset	= init_chipset_it8213,	\
 		.init_hwif	= init_hwif_it8213,	\
 		.channels	= 1,			\
-		.autodma		= AUTODMA,		\
+		.autodma	= AUTODMA,		\
 		.enablebits	= {{0x41,0x80,0x80}}, \
 		.bootable	= ON_BOARD,		\
 	}
@@ -393,10 +352,11 @@ static struct pci_driver driver = {
 
 static int __init it8213_ide_init(void)
 {
-	return ide_pci_register_driver(&driver); }
+	return ide_pci_register_driver(&driver);
+}
 
 module_init(it8213_ide_init);
 
-MODULE_AUTHOR("Jack and Alan Cox");		/* Update this */
+MODULE_AUTHOR("Jack Lee, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for the ITE 8213");
 MODULE_LICENSE("GPL");
