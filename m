Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSKGQd5>; Thu, 7 Nov 2002 11:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSKGQd5>; Thu, 7 Nov 2002 11:33:57 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:56336 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S261442AbSKGQds>; Thu, 7 Nov 2002 11:33:48 -0500
Date: Thu, 7 Nov 2002 17:40:09 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.5.46] IDE BIOS timings
Message-ID: <20021107164009.GL1737@tmathiasen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please accept the attached for 2.5.46.

It introduces a new boot parameter (eg. ide0=biostimings) that forces the
IDE driver to honour BIOS DMA/PIO timings. Sometimes the BIOS has a better
overview of how the IDE devices are connected/setup and some chipsets doesn't
support >ata66 speed detection.

The patch has been tested for quite a while on both PIIX and serverworks.

Torben

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide_bios-2.5.46.diff"

--- kernel/linux-2.5.46-clean/include/linux/ide.h	Mon Nov  4 16:30:22 2002
+++ linux-2.5.46/include/linux/ide.h	Thu Nov  7 03:19:15 2002
@@ -743,7 +743,8 @@
 	unsigned nice0		: 1;	/* give obvious excess bandwidth */
 	unsigned nice2		: 1;	/* give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
-	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
+	unsigned autotune	: 3;	/* 1=autotune, 2=noautotune, 
+					   3=biostimings, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
diff -ur kernel/linux-2.5.46-clean/drivers/ide/ide-dma.c linux-2.5.46/drivers/ide/ide-dma.c
--- kernel/linux-2.5.46-clean/drivers/ide/ide-dma.c	Mon Nov  4 16:30:29 2002
+++ linux-2.5.46/drivers/ide/ide-dma.c	Thu Nov  7 03:19:15 2002
@@ -1028,9 +1028,16 @@
 
 	if (hwif->chipset != ide_trm290) {
 		u8 dma_stat = hwif->INB(hwif->dma_status);
-		printk(", BIOS settings: %s:%s, %s:%s",
+		printk(", BIOS settings: %s:%s%s, %s:%s%s",
 		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
+		       hwif->drives[0].autotune == 3 ? " (used)" : "",
+		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio",
+		       hwif->drives[1].autotune == 3 ? " (used)" : "");
+
+		if (hwif->drives[0].autotune == 3)
+			hwif->drives[0].using_dma = (dma_stat & 0x20);
+		if (hwif->drives[1].autotune == 3)
+			hwif->drives[1].using_dma = (dma_stat & 0x40);
 	}
 	printk("\n");
 
diff -ur kernel/linux-2.5.46-clean/drivers/ide/ide-probe.c linux-2.5.46/drivers/ide/ide-probe.c
--- kernel/linux-2.5.46-clean/drivers/ide/ide-probe.c	Mon Nov  4 16:30:32 2002
+++ linux-2.5.46/drivers/ide/ide-probe.c	Thu Nov  7 03:19:15 2002
@@ -434,7 +434,7 @@
 		if (hwif->INB(IDE_STATUS_REG) == (BUSY_STAT|READY_STAT))
 			return 4;
 
-		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
+		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune < 2) {
 			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), "
 				"resetting drive\n", drive->name,
@@ -711,7 +711,7 @@
 			 * Move here to prevent module loading clashing.
 			 */
 	//		drive->autodma = hwif->autodma;
-			if ((drive->autotune != 2) && (hwif->ide_dma_check)) {
+			if ((drive->autotune < 2) && (hwif->ide_dma_check)) {
 				/*
 				 * Force DMAing for the beginning of the check.
 				 * Some chipsets appear to do interesting
diff -ur kernel/linux-2.5.46-clean/drivers/ide/ide.c linux-2.5.46/drivers/ide/ide.c
--- kernel/linux-2.5.46-clean/drivers/ide/ide.c	Mon Nov  4 16:30:16 2002
+++ linux-2.5.46/drivers/ide/ide.c	Thu Nov  7 03:19:15 2002
@@ -2621,7 +2621,8 @@
  *				Not fully supported by all chipset types,
  *				and quite likely to cause trouble with
  *				older/odd IDE drives.
- *
+ * "hdx=biostimings"	: driver will NOT attempt to tune interface speed 
+ * 				(DMA/PIO) but always honour BIOS timings.
  * "hdx=slow"		: insert a huge pause after each access to the data
  *				port. Should be used only as a last resort.
  *
@@ -2658,6 +2659,8 @@
  * "idex=noautotune"	: driver will NOT attempt to tune interface speed
  *				This is the default for most chipsets,
  *				except the cmd640.
+ * "idex=biostimings"	: driver will NOT attempt to tune interface speed 
+ * 				(DMA/PIO) but always honour BIOS timings.
  * "idex=serialize"	: do not overlap operations on idex and ide(x^1)
  * "idex=four"		: four drives on idex and ide(x^1) share same ports
  * "idex=reset"		: reset interface before first use
@@ -2733,7 +2736,8 @@
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "swapdata", "bswap", "flash",
-				"remap", "noremap", "scsi", NULL};
+				"remap", "noremap", "scsi", "biostimings",
+				NULL};
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -2804,6 +2808,9 @@
 				drive->scsi = 0;
 				goto bad_option;
 #endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+			case -15: /* "biostimings" */
+				drive->autotune = 3;
+				goto done;
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
 				drive->cyl	= drive->bios_cyl  = vals[0];
@@ -2841,9 +2848,10 @@
 		 * -8,-9,-10 : are reserved for future idex calls to ease the hardcoding.
 		 */
 		const char *ide_words[] = {
-			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata66",
-			"minus8", "minus9", "minus10",
-			"four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
+			"noprobe", "serialize", "autotune", "noautotune", 
+			"reset", "dma", "ata66", "minus8", "minus9", "minus10",
+			"four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", 
+			"umc8672", "ali14xx", "dc4030", "biostimings", NULL };
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
 		i = match_parm(&s[4], ide_words, vals, 3);
@@ -2862,6 +2870,10 @@
 		}
 
 		switch (i) {
+			case -19: /* "biostimings" */
+				hwif->drives[0].autotune = 3;
+				hwif->drives[1].autotune = 3;
+				goto done;
 #ifdef CONFIG_BLK_DEV_PDC4030
 			case -18: /* "dc4030" */
 			{
@@ -3211,7 +3223,7 @@
 	spin_lock(&drives_lock);
 	list_add(&drive->list, &driver->drives);
 	spin_unlock(&drives_lock);
-	if (drive->autotune != 2) {
+	if (drive->autotune < 2) {
 		/* DMA timings and setup moved to ide-probe.c */
 		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
 //			HWIF(drive)->ide_dma_off_quietly(drive);
diff -ur kernel/linux-2.5.46-clean/drivers/ide/setup-pci.c linux-2.5.46/drivers/ide/setup-pci.c
--- kernel/linux-2.5.46-clean/drivers/ide/setup-pci.c	Mon Nov  4 16:30:25 2002
+++ linux-2.5.46/drivers/ide/setup-pci.c	Thu Nov  7 03:19:15 2002
@@ -590,6 +590,7 @@
 	u32 port, at_least_one_hwif_enabled = 0, autodma = 0;
 	int pciirq = 0;
 	int tried_config = 0;
+	int drive0_tune, drive1_tune;
 	ata_index_t index;
 	u8 tmp = 0;
 	ide_hwif_t *hwif, *mate = NULL;
@@ -698,11 +699,20 @@
 		ide_hwif_setup_dma(dev, d, hwif);
 bypass_legacy_dma:
 #endif	/* CONFIG_BLK_DEV_IDEDMA */
+
+		drive0_tune = hwif->drives[0].autotune;
+		drive1_tune = hwif->drives[1].autotune;
+
 		if (d->init_hwif)
 			/* Call chipset-specific routine
 			 * for each enabled hwif
 			 */
 			d->init_hwif(hwif);
+		
+		if (drive0_tune == 3) /* biostimings */
+			hwif->drives[0].autotune = 3;
+		if (drive1_tune == 3)
+			hwif->drives[1].autotune = 3;
 
 		mate = hwif;
 		at_least_one_hwif_enabled = 1;

--x+6KMIRAuhnl3hBn--
