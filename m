Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSE2RCO>; Wed, 29 May 2002 13:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSE2RCN>; Wed, 29 May 2002 13:02:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12040 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313558AbSE2RCI>; Wed, 29 May 2002 13:02:08 -0400
Message-ID: <3CF4FBE4.8080208@evision-ventures.com>
Date: Wed, 29 May 2002 18:03:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.18 IDE 75
In-Reply-To: <Pine.LNX.4.33.0205241902001.1537-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060007010003010807040607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060007010003010807040607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wed May 29 15:13:06 CEST 2002 ide-clean-75

- Comment out config_chipset_for_pio from hpt366 driver. It seems to hang on it
   and many people consistently reported that this may be necessary.
   Well apparently this host chip is forced to be in DMA read mode anyway
   and we where undoing this there.

- Apply small cosmetics to pdc202xx.c driver by Thierry Vignaud.
   His change log entries follow:

 > - factorize constants with PDC_CLOCK and UDMA_SPEED_FLAG macros and
 >   the init_high_16() static inline functions, thus removing floating
 >   constants in code
 > - remove unused variables and pci space read
 >
 > - kill useless code in pdc202xx_udma_irq_status() resulting in
 >   removing unused variable: the code does lots of tests to check what
 >   value to return but just always return the same exact value in all
 >   code paths!
 >   this also saves a few cpu & pci bus cyles by removing a useless read
 >   in pci space
 > - simplify #if/#else resulting in code duplication
 > - make init_pdc202xx clearer
 >
 > - remove duplicated initializations in config_drive_xfer_rate() and
 >   simplify code paths
 >   check in you mail inbox for the exact demonstrations (which didn't
 >   even alter resulting binary since gcc seems to optimize out most of
 >   this useless/obscuring stuff)

- Kill unused init_speed member from ata_device struct. Spotted by
   M.H.VanLeeuwen.


--------------060007010003010807040607
Content-Type: text/plain;
 name="ide-clean-75.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-75.diff"

diff -urN linux-2.5.18/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.18/drivers/ide/aec62xx.c	2002-05-28 17:15:53.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-05-29 18:14:27.000000000 +0200
@@ -123,8 +123,6 @@
 	else
 		aec_set_speed_new(drive->channel->pci_dev, drive->dn, &t);
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return 0;
diff -urN linux-2.5.18/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.18/drivers/ide/alim15x3.c	2002-05-29 18:51:29.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-05-29 18:13:50.000000000 +0200
@@ -377,8 +377,6 @@
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return ide_config_drive_speed(drive, speed);
diff -urN linux-2.5.18/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.18/drivers/ide/amd74xx.c	2002-05-29 18:51:29.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-05-29 18:13:50.000000000 +0200
@@ -251,8 +251,6 @@
 
 	amd_set_speed(drive->channel->pci_dev, drive->dn, &t);
 
-	if (!drive->init_speed)	
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return 0;
diff -urN linux-2.5.18/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.18/drivers/ide/cmd64x.c	2002-05-29 18:51:29.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-29 18:13:50.000000000 +0200
@@ -537,8 +537,6 @@
 	(void) pci_write_config_byte(dev, pciU, regU);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -657,8 +655,6 @@
 	pci_write_config_word(dev, dma_pci, multi);
 	pci_write_config_word(dev, udma_pci, ultra);
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return ide_config_drive_speed(drive, speed);
diff -urN linux-2.5.18/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.18/drivers/ide/hpt34x.c	2002-05-29 02:34:39.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-05-29 18:13:50.000000000 +0200
@@ -137,8 +137,6 @@
 		hi_speed, lo_speed, err);
 #endif
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 	return ide_config_drive_speed(drive, speed);
 }
diff -urN linux-2.5.18/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.18/drivers/ide/hpt366.c	2002-05-25 03:55:20.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-05-29 18:13:50.000000000 +0200
@@ -486,11 +486,10 @@
 static struct pci_dev *hpt_devs[HPT366_MAX_DEVS];
 static int n_hpt_devs;
 
-static u8 hpt366_proc = 0;
-
 static unsigned int hpt_min_rev(struct pci_dev *dev, int rev);
 
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
+static u8 hpt366_proc = 0;
 static int hpt366_get_info(char *, char **, off_t, int);
 extern int (*hpt366_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 
@@ -788,9 +787,6 @@
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
 		return -1;
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
-
 	if (hpt_min_rev(dev, 7)) {
 		hpt374_tune_chipset(drive, speed);
 	} else if (hpt_min_rev(dev, 5)) {
@@ -864,9 +860,6 @@
 	int map;
 	byte mode;
 
-	/* FIXME: remove this --bkz */
-	config_chipset_for_pio(drive);
-
 	if (drive->type != ATA_DISK)
 		return 0;
 
diff -urN linux-2.5.18/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.18/drivers/ide/icside.c	2002-05-29 02:34:39.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-05-29 18:13:50.000000000 +0200
@@ -362,9 +362,6 @@
 
 	drive->drive_data = cycle_time;
 
-	if (!drive->init_speed)
-		drive->init_speed = xfer_mode;
-
 	if (cycle_time && ide_config_drive_speed(drive, xfer_mode) == 0)
 		on = 1;
 	else
diff -urN linux-2.5.18/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.18/drivers/ide/ide-pmac.c	2002-05-25 03:55:29.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-29 18:13:50.000000000 +0200
@@ -1247,9 +1247,6 @@
 		return 0;
 	}
 
-	if (!drive->init_speed)
-		drive->init_speed = feature;
-
 	/* which drive is it ? */
 	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
@@ -1286,9 +1283,6 @@
 		return 0;
 	}
 
-	if (!drive->init_speed)
-		drive->init_speed = feature;
-
 	/* which drive is it ? */
 	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
diff -urN linux-2.5.18/drivers/ide/it8172.c linux/drivers/ide/it8172.c
--- linux-2.5.18/drivers/ide/it8172.c	2002-05-25 03:55:18.000000000 +0200
+++ linux/drivers/ide/it8172.c	2002-05-29 18:13:50.000000000 +0200
@@ -187,8 +187,6 @@
 
     it8172_tune_drive(drive, it8172_dma_2_pio(speed));
 
-    if (!drive->init_speed)
-	drive->init_speed = speed;
     err = ide_config_drive_speed(drive, speed);
     drive->current_speed = speed;
     return err;
diff -urN linux-2.5.18/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.18/drivers/ide/pdc202xx.c	2002-05-29 02:34:39.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-29 18:13:50.000000000 +0200
@@ -1,6 +1,6 @@
 /**** vi:set ts=8 sts=8 sw=8:************************************************
  *
- *  linux/drivers/ide/pdc202xx.c	Version 0.30	Mar. 18, 2000
+ *  linux/drivers/ide/pdc202xx.c	Version 0.30	May. 28, 2002
  *
  *  Copyright (C) 1998-2000	Andre Hedrick <andre@linux-ide.org>
  *  May be copied or modified under the terms of the GNU General Public License
@@ -61,6 +61,10 @@
 #define	IORDY_EN	0x20	/* PIO: IOREADY */
 #define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
 
+
+#define PDC_CLOCK(high_16) IN_BYTE(high_16 + 0x11)
+#define UDMA_SPEED_FLAG(high_16) IN_BYTE(high_16 + 0x001f)
+
 #if PDC202XX_DECODE_REGISTER_INFO
 
 struct pdc_bit_messages {
@@ -119,6 +123,13 @@
 }
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 
+
+static inline int init_high_16 (struct pci_dev *dev)
+{
+	return pci_resource_start(dev, 4);
+}
+
+
 int check_in_drive_lists(struct ata_device *drive)
 {
 	static const char *pdc_quirk_drives[] = {
@@ -172,7 +183,7 @@
 	struct pci_dev *dev = hwif->pci_dev;
 
 	unsigned int		drive_conf;
-	byte			drive_pci, AP, BP, CP, DP;
+	byte			drive_pci, AP, BP, CP;
 	byte			TA = 0, TB = 0, TC = 0;
 
 	if (drive->dn > 3)
@@ -187,7 +198,6 @@
 	pci_read_config_byte(dev, (drive_pci), &AP);
 	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
 	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
-	pci_read_config_byte(dev, (drive_pci)|0x03, &DP);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (speed >= XFER_SW_DMA_0) {
@@ -198,10 +208,9 @@
 			/* clear DMA modes of lower 8421 bits of C Register */
 			pci_write_config_byte(dev, (drive_pci)|0x02, CP & ~0x0F);
 		}
-	} else {
-#else
-	{
+	} else
 #endif /* CONFIG_BLK_DEV_IDEDMA */
+	{
 		if ((AP & 0x0F) || (BP & 0x07)) {
 			/* clear PIO modes of lower 8421 bits of A Register */
 			pci_write_config_byte(dev, (drive_pci), AP & ~0x0F);
@@ -242,10 +251,9 @@
         if (speed >= XFER_SW_DMA_0) {
 		pci_write_config_byte(dev, (drive_pci)|0x01, BP|TB);
 		pci_write_config_byte(dev, (drive_pci)|0x02, CP|TC);
-	} else {
-#else
-	{
+	} else
 #endif /* CONFIG_BLK_DEV_IDEDMA */
+	{
 		pci_write_config_byte(dev, (drive_pci), AP|TA);
 		pci_write_config_byte(dev, (drive_pci)|0x01, BP|TB);
 	}
@@ -269,8 +277,6 @@
 	printk(KERN_DEBUG "DP(%x)\n", DP);
 #endif
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 #if PDC202XX_DEBUG_DRIVE_INFO
@@ -300,7 +306,7 @@
 	unsigned long indexreg	= (hwif->dma_base + 1);
 	unsigned long datareg	= (hwif->dma_base + 3);
 #else
-	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
+	unsigned long high_16	= init_high_16(hwif->pci_dev);
 	unsigned long indexreg	= high_16 + (hwif->unit ? 0x09 : 0x01);
 	unsigned long datareg	= (indexreg + 2);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
@@ -394,8 +400,6 @@
 			;
 	}
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return ide_config_drive_speed(drive, speed);
@@ -427,7 +431,7 @@
 	struct ata_channel *hwif = drive->channel;
 	struct hd_driveid *mate_id = hwif->drives[!(drive->dn%2)].id;
 	struct pci_dev *dev	= hwif->pci_dev;
-	unsigned long high_16   = pci_resource_start(dev, 4);
+	unsigned long high_16   = init_high_16(dev);
 	unsigned long dma_base  = hwif->dma_base;
 	unsigned long indexreg	= dma_base + 1;
 	unsigned long datareg	= dma_base + 3;
@@ -458,7 +462,7 @@
 	}
 
 	if (!jumpbit)
-		CLKSPD = IN_BYTE(high_16 + 0x11);
+		CLKSPD = PDC_CLOCK(high_16);
 	/*
 	 * Set the control register to use the 66Mhz system
 	 * clock for UDMA 3/4 mode operation. If one drive on
@@ -568,12 +572,9 @@
 
 	if (id && (id->capability & 1) && hwif->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (udma_black_list(drive)) {
-			on = 0;
-			goto fast_ata_pio;
-		}
-		on = 0;
 		verbose = 0;
+		if (udma_black_list(drive))
+			goto no_dma_set;
 		if (id->field_valid & 4) {
 			if (id->dma_ultra & 0x007F) {
 				/* Force if Capable UltraDMA */
@@ -599,13 +600,8 @@
 			on = config_chipset_for_dma(drive, 0);
 			if (!on)
 				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
-		}
+		} else goto no_dma_set;
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
-fast_ata_pio:
-		on = 0;
-		verbose = 0;
 no_dma_set:
 		config_chipset_for_pio(drive, 5);
 	}
@@ -618,12 +614,12 @@
 static int pdc202xx_udma_start(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
-	unsigned long high_16 = pci_resource_start(ch->pci_dev, 4);
+	unsigned long high_16 = init_high_16(ch->pci_dev);
 	unsigned long atapi_reg = high_16 + (ch->unit ? 0x24 : 0x00);
 
 	if (drive->addressing) {
 		unsigned long word_count = 0;
-		u8 clock = IN_BYTE(high_16 + 0x11);
+		u8 clock = PDC_CLOCK(high_16);
 
 		outb(clock|(ch->unit ? 0x08 : 0x02), high_16 + 0x11);
 		word_count = (rq->nr_sectors << 8);
@@ -644,14 +640,14 @@
 int pdc202xx_udma_stop(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
-	unsigned long high_16 = pci_resource_start(ch->pci_dev, 4);
+	unsigned long high_16 = init_high_16(ch->pci_dev);
 	unsigned long atapi_reg	= high_16 + (ch->unit ? 0x24 : 0x00);
 	unsigned long dma_base = ch->dma_base;
 	u8 dma_stat, clock;
 
 	if (drive->addressing) {
 		outl(0, atapi_reg);	/* zero out extra */
-		clock = IN_BYTE(high_16 + 0x11);
+		clock = PDC_CLOCK(high_16);
 		OUT_BYTE(clock & ~(ch->unit ? 0x08:0x02), high_16 + 0x11);
 	}
 
@@ -667,22 +663,10 @@
 static int pdc202xx_udma_irq_status(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
-	unsigned long high_16 = pci_resource_start(ch->pci_dev, 4);
-	u8 dma_stat, sc1d;
+	u8 dma_stat;
 
 	dma_stat = IN_BYTE(ch->dma_base + 2);
 
-	sc1d = IN_BYTE(high_16 + 0x001d);
-	if (ch->unit) {
-		if ((sc1d & 0x50) == 0x50) goto somebody_else;
-		else if ((sc1d & 0x40) == 0x40)
-			return (dma_stat & 4) == 4;
-	} else {
-		if ((sc1d & 0x05) == 0x05) goto somebody_else;
-		else if ((sc1d & 0x04) == 0x04)
-			return (dma_stat & 4) == 4;
-	}
-somebody_else:
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
@@ -710,8 +694,8 @@
 
 void pdc202xx_reset(struct ata_device *drive)
 {
-	unsigned long high_16	= pci_resource_start(drive->channel->pci_dev, 4);
-	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
+	unsigned long high_16	= init_high_16(drive->channel->pci_dev);
+	byte udma_speed_flag	= UDMA_SPEED_FLAG(high_16);
 
 	set_reg_and_wait(udma_speed_flag | 0x10, high_16 + 0x001f, 100);
 	set_reg_and_wait(udma_speed_flag & ~0x10, high_16 + 0x001f, 2000);		/* 2 seconds ?! */
@@ -722,8 +706,8 @@
 /* FIXME: should be splited for old & new chipsets --bkz */
 static unsigned int __init pdc202xx_init_chipset(struct pci_dev *dev)
 {
-	unsigned long high_16	= pci_resource_start(dev, 4);
-	byte udma_speed_flag	= IN_BYTE(high_16 + 0x001f);
+	unsigned long high_16	= init_high_16(dev);
+	byte udma_speed_flag	= UDMA_SPEED_FLAG(high_16);
 	byte primary_mode	= IN_BYTE(high_16 + 0x001a);
 	byte secondary_mode	= IN_BYTE(high_16 + 0x001b);
 	byte newchip		= 0;
@@ -788,7 +772,7 @@
 	if (!(udma_speed_flag & 1)) {
 		printk("%s: FORCING BURST BIT 0x%02x -> 0x%02x ", dev->name, udma_speed_flag, (udma_speed_flag|1));
 		OUT_BYTE(udma_speed_flag|1, high_16 + 0x001f);
-		printk("%sCTIVE\n", (IN_BYTE(high_16 + 0x001f) & 1) ? "A" : "INA");
+		printk("%sCTIVE\n", (UDMA_SPEED_FLAG(high_16) & 1) ? "A" : "INA");
 	}
 #endif /* CONFIG_PDC202XX_BURST */
 
@@ -856,16 +840,13 @@
 		hwif->highmem = 1;
 		if (!noautodma)
 			hwif->autodma = 1;
-	} else {
+	} else
+#endif
+	{
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
 		hwif->autodma = 0;
 	}
-#else
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-	hwif->autodma = 0;
-#endif
 }
 
 
@@ -980,9 +961,8 @@
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(chipsets); ++i) {
+	for (i = 0; i < ARRAY_SIZE(chipsets); ++i)
 		ata_register_chipset(&chipsets[i]);
-	}
 
         return 0;
 }
diff -urN linux-2.5.18/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.18/drivers/ide/piix.c	2002-05-25 03:55:24.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-05-29 18:13:50.000000000 +0200
@@ -351,8 +351,6 @@
 
 	piix_set_speed(drive->channel->pci_dev, drive->dn, &t, umul);
 
-	if (!drive->init_speed)	
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return 0;
diff -urN linux-2.5.18/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.18/drivers/ide/serverworks.c	2002-05-29 18:51:29.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-29 18:13:51.000000000 +0200
@@ -357,8 +357,6 @@
 	pci_write_config_byte(dev, drive_pci3, ultra_timing);
 	pci_write_config_byte(dev, 0x54, ultra_enable);
 #endif
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return ide_config_drive_speed(drive, speed);
diff -urN linux-2.5.18/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.18/drivers/ide/via82cxxx.c	2002-05-25 03:55:23.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-05-29 18:13:50.000000000 +0200
@@ -332,8 +332,6 @@
 
 	via_set_speed(drive->channel->pci_dev, drive->dn, &t);
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
 	drive->current_speed = speed;
 
 	return 0;
diff -urN linux-2.5.18/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.18/include/linux/ide.h	2002-05-29 02:34:40.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-29 18:17:48.000000000 +0200
@@ -393,7 +393,6 @@
 	int		crc_count;	/* crc counter to reduce drive speed */
 	byte		quirk_list;	/* drive is considered quirky if set for a specific host */
 	byte		suspend_reset;	/* drive suspend mode flag, soft-reset recovers */
-	byte		init_speed;	/* transfer rate set at boot */
 	byte		current_speed;	/* current transfer rate set */
 	byte		dn;		/* now wide spread use */
 	byte		wcache;		/* status of write cache */

--------------060007010003010807040607--

