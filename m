Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSKENA3>; Tue, 5 Nov 2002 08:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264845AbSKENA3>; Tue, 5 Nov 2002 08:00:29 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:33803 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S264842AbSKENA0>; Tue, 5 Nov 2002 08:00:26 -0500
Date: Tue, 5 Nov 2002 14:06:38 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] BIOS ide timings (2.4.20pre10-ac2)
Message-ID: <20021105130638.GE1015@tmathiasen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Alan,

Please consider applying the attached patch. As my previous patch against
2.4.20rc1 it enables the IDE layer to honour BIOS IDE timings. I decided
against cleaning up the autotune/noautotune feature in the same go, as it would
require too many changes for the chipset drivers (they seem to deal with this
quite differently). This new patch just uses the drive->autotune placeholder
for a new kernel parameter (eg. ide0=biostimings). Chipset drivers are not able
to override this boot parameter.

At some point we might consider rewriting the autotune stuff, and make the
guidelines somewhat clearer for the chipset drivers.

Tested with PIIX and serverworks.

Patch is against 2.4.20pre10-ac2 which is the latest I could find. Let me know
if I should port it against another kernel tree.

Cheers,
Torben


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide_bios-2.4.20p10-ac2.diff"

--- tmp/linux-2.4.20pre10-ac2/include/linux/ide.h	2002-11-05 06:14:27.000000000 -0600
+++ linux-2.4.20pre10-ac2/include/linux/ide.h	2002-11-05 05:29:24.000000000 -0600
@@ -741,7 +741,8 @@
 	unsigned nice0		: 1;	/* give obvious excess bandwidth */
 	unsigned nice2		: 1;	/* give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
-	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
+	unsigned autotune	: 3;	/* 1=autotune, 2=noautotune, 
+					   3=biostimings, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned dead		: 1;	/* 1=dead, no new attachments */
diff -ur tmp/linux-2.4.20pre10-ac2/drivers/ide/ide-dma.c linux-2.4.20pre10-ac2/drivers/ide/ide-dma.c
--- tmp/linux-2.4.20pre10-ac2/drivers/ide/ide-dma.c	2002-11-05 06:14:26.000000000 -0600
+++ linux-2.4.20pre10-ac2/drivers/ide/ide-dma.c	2002-11-05 06:12:05.000000000 -0600
@@ -1027,9 +1027,16 @@
 
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
 
diff -ur tmp/linux-2.4.20pre10-ac2/drivers/ide/ide-probe.c linux-2.4.20pre10-ac2/drivers/ide/ide-probe.c
--- tmp/linux-2.4.20pre10-ac2/drivers/ide/ide-probe.c	2002-11-05 06:14:26.000000000 -0600
+++ linux-2.4.20pre10-ac2/drivers/ide/ide-probe.c	2002-11-05 05:25:57.000000000 -0600
@@ -421,7 +421,7 @@
 		if (hwif->INB(IDE_STATUS_REG) == (BUSY_STAT|READY_STAT))
 			return 4;
 
-		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
+		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune < 2) {
 			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), "
 				"resetting drive\n", drive->name,
@@ -677,7 +677,7 @@
 			 * Move here to prevent module loading clashing.
 			 */
 	//		drive->autodma = hwif->autodma;
-			if ((drive->autotune != 2) && (hwif->ide_dma_check)) {
+			if ((drive->autotune < 2) && (hwif->ide_dma_check)) {
 				/*
 				 * Force DMAing for the beginning of the check.
 				 * Some chipsets appear to do interesting
diff -ur tmp/linux-2.4.20pre10-ac2/drivers/ide/ide.c linux-2.4.20pre10-ac2/drivers/ide/ide.c
--- tmp/linux-2.4.20pre10-ac2/drivers/ide/ide.c	2002-11-05 06:14:26.000000000 -0600
+++ linux-2.4.20pre10-ac2/drivers/ide/ide.c	2002-11-05 06:53:38.000000000 -0600
@@ -2849,7 +2849,8 @@
  *				Not fully supported by all chipset types,
  *				and quite likely to cause trouble with
  *				older/odd IDE drives.
- *
+ * "hdx=biostimings"	: driver will NOT attempt to tune interface speed 
+ * 				(DMA/PIO) but always honour BIOS timings.
  * "hdx=slow"		: insert a huge pause after each access to the data
  *				port. Should be used only as a last resort.
  *
@@ -2886,6 +2887,8 @@
  * "idex=noautotune"	: driver will NOT attempt to tune interface speed
  *				This is the default for most chipsets,
  *				except the cmd640.
+ * "idex=biostimings"	: driver will NOT attempt to tune interface speed 
+ * 				(DMA/PIO) but always honour BIOS timings.
  * "idex=serialize"	: do not overlap operations on idex and ide(x^1)
  * "idex=four"		: four drives on idex and ide(x^1) share same ports
  * "idex=reset"		: reset interface before first use
@@ -2961,7 +2964,8 @@
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "swapdata", "bswap", "flash",
-				"remap", "noremap", "scsi", NULL};
+				"remap", "noremap", "scsi", "biostimings",
+				NULL};
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -3032,6 +3036,9 @@
 				drive->scsi = 0;
 				goto bad_option;
 #endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+			case -15: /* "biostimings" */
+				drive->autotune = 3;
+				goto done;
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
 				drive->cyl	= drive->bios_cyl  = vals[0];
@@ -3069,9 +3076,10 @@
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
@@ -3090,6 +3098,10 @@
 		}
 
 		switch (i) {
+			case -19: /* "biostimings" */
+				hwif->drives[0].autotune = 3;
+				hwif->drives[1].autotune = 3;
+				goto done;
 #ifdef CONFIG_BLK_DEV_PDC4030
 			case -18: /* "dc4030" */
 			{
@@ -3577,7 +3589,7 @@
 	drive->driver = driver;
 	setup_driver_defaults(drive);
 	spin_unlock_irqrestore(&io_request_lock, flags);
-	if (drive->autotune != 2) {
+	if (drive->autotune < 2) {
 		/* DMA timings and setup moved to ide-probe.c */
 		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
 //			HWIF(drive)->ide_dma_off_quietly(drive);
diff -ur tmp/linux-2.4.20pre10-ac2/drivers/ide/setup-pci.c linux-2.4.20pre10-ac2/drivers/ide/setup-pci.c
--- tmp/linux-2.4.20pre10-ac2/drivers/ide/setup-pci.c	2002-11-05 06:14:26.000000000 -0600
+++ linux-2.4.20pre10-ac2/drivers/ide/setup-pci.c	2002-11-05 05:25:57.000000000 -0600
@@ -586,6 +586,7 @@
 	u32 port, at_least_one_hwif_enabled = 0, autodma = 0;
 	int pciirq = 0;
 	int tried_config = 0;
+	int drive0_tune, drive1_tune;
 	ata_index_t index;
 	u8 tmp = 0;
 	ide_hwif_t *hwif, *mate = NULL;
@@ -691,11 +692,20 @@
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

--lrZ03NoBR/3+SXJZ--
