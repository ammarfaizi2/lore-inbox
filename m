Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbSKHQuY>; Fri, 8 Nov 2002 11:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSKHQuY>; Fri, 8 Nov 2002 11:50:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54666 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266805AbSKHQuU>;
	Fri, 8 Nov 2002 11:50:20 -0500
Date: Fri, 8 Nov 2002 17:56:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
Message-ID: <20021108165641.GA18126@suse.de>
References: <20021107164009.GL1737@tmathiasen> <1036775438.16898.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036775438.16898.31.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08 2002, Alan Cox wrote:
> On Thu, 2002-11-07 at 16:40, Torben Mathiasen wrote:
> > Linus,
> > 
> > Please accept the attached for 2.5.46.
> > 
> > It introduces a new boot parameter (eg. ide0=biostimings) that forces the
> > IDE driver to honour BIOS DMA/PIO timings. Sometimes the BIOS has a better
> > overview of how the IDE devices are connected/setup and some chipsets doesn't
> > support >ata66 speed detection.
> > 
> > The patch has been tested for quite a while on both PIIX and serverworks.
> 
> Linus please drop this patch for now. Its not been tested on enough
> controllers, its making things unneccessarily ugly and its also just
> going to make updates hard.

Alan, the patch is pretty much straight forward. Cleaning up the magic
numbers and ->autotune consistencies is a good thing, imo.

I'm attaching Torben's modified version which adds symbolic names
instead of using more weird autotune magics.

--- linux-2.5.46-clean/include/linux/ide.h	2002-11-08 10:17:50.000000000 +0100
+++ linux-2.5.46/include/linux/ide.h	2002-11-08 10:51:36.000000000 +0100
@@ -96,6 +96,14 @@
 #define ERROR_RECAL	1	/* Recalibrate every 2nd retry */
 
 /*
+ * Tune flags
+ */
+#define IDE_TUNE_BIOS		3
+#define IDE_TUNE_NOAUTO		2
+#define IDE_TUNE_AUTO		1
+#define IDE_TUNE_DEFAULT	0
+
+/*
  * state flags
  */
 #define DMA_PIO_RETRY	1	/* retrying in PIO */
@@ -743,7 +751,8 @@
 	unsigned nice0		: 1;	/* give obvious excess bandwidth */
 	unsigned nice2		: 1;	/* give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
-	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
+	unsigned autotune	: 3;	/* 1=autotune, 2=noautotune, 
+					   3=biostimings, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
diff -ur linux-2.5.46-clean/drivers/ide/ide-dma.c linux-2.5.46/drivers/ide/ide-dma.c
--- linux-2.5.46-clean/drivers/ide/ide-dma.c	2002-11-08 10:16:58.000000000 +0100
+++ linux-2.5.46/drivers/ide/ide-dma.c	2002-11-08 10:35:41.000000000 +0100
@@ -1028,9 +1028,18 @@
 
 	if (hwif->chipset != ide_trm290) {
 		u8 dma_stat = hwif->INB(hwif->dma_status);
-		printk(", BIOS settings: %s:%s, %s:%s",
+		printk(", BIOS settings: %s:%s%s, %s:%s%s",
 		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
+		       hwif->drives[0].autotune == IDE_TUNE_BIOS ? 
+		       		" (used)" : "",
+		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio",
+		       hwif->drives[1].autotune == IDE_TUNE_BIOS ? 
+		       		" (used)" : "");
+
+		if (hwif->drives[0].autotune == IDE_TUNE_BIOS)
+			hwif->drives[0].using_dma = (dma_stat & 0x20);
+		if (hwif->drives[1].autotune == IDE_TUNE_BIOS)
+			hwif->drives[1].using_dma = (dma_stat & 0x40);
 	}
 	printk("\n");
 
diff -ur linux-2.5.46-clean/drivers/ide/ide-probe.c linux-2.5.46/drivers/ide/ide-probe.c
--- linux-2.5.46-clean/drivers/ide/ide-probe.c	2002-11-08 10:16:58.000000000 +0100
+++ linux-2.5.46/drivers/ide/ide-probe.c	2002-11-08 10:34:17.000000000 +0100
@@ -434,7 +434,9 @@
 		if (hwif->INB(IDE_STATUS_REG) == (BUSY_STAT|READY_STAT))
 			return 4;
 
-		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
+		if ((rc == 1 && cmd == WIN_PIDENTIFY) &&
+			((drive->autotune == IDE_TUNE_DEFAULT) ||
+			(drive->autotune == IDE_TUNE_AUTO))) {
 			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), "
 				"resetting drive\n", drive->name,
@@ -699,7 +701,8 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 		if (drive->present) {
-			if (hwif->tuneproc != NULL && drive->autotune == 1)
+			if (hwif->tuneproc != NULL && 
+				drive->autotune == IDE_TUNE_AUTO)
 				/* auto-tune PIO mode */
 				hwif->tuneproc(drive, 255);
 			/*
@@ -711,7 +714,9 @@
 			 * Move here to prevent module loading clashing.
 			 */
 	//		drive->autodma = hwif->autodma;
-			if ((drive->autotune != 2) && (hwif->ide_dma_check)) {
+			if ((hwif->ide_dma_check) &&
+				((drive->autotune == IDE_TUNE_DEFAULT) ||
+				(drive->autotune == IDE_TUNE_AUTO))) {
 				/*
 				 * Force DMAing for the beginning of the check.
 				 * Some chipsets appear to do interesting
diff -ur linux-2.5.46-clean/drivers/ide/ide.c linux-2.5.46/drivers/ide/ide.c
--- linux-2.5.46-clean/drivers/ide/ide.c	2002-11-08 10:16:58.000000000 +0100
+++ linux-2.5.46/drivers/ide/ide.c	2002-11-08 10:28:39.000000000 +0100
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
@@ -2775,10 +2779,10 @@
 				printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
 				goto do_serialize;
 			case -6: /* "autotune" */
-				drive->autotune = 1;
+				drive->autotune = IDE_TUNE_AUTO;
 				goto done;
 			case -7: /* "noautotune" */
-				drive->autotune = 2;
+				drive->autotune = IDE_TUNE_NOAUTO;
 				goto done;
 			case -8: /* "slow" */
 				drive->slow = 1;
@@ -2804,6 +2808,9 @@
 				drive->scsi = 0;
 				goto bad_option;
 #endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+			case -15: /* "biostimings" */
+				drive->autotune = IDE_TUNE_BIOS;
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
+				hwif->drives[0].autotune = IDE_TUNE_BIOS;
+				hwif->drives[1].autotune = IDE_TUNE_BIOS;
+				goto done;
 #ifdef CONFIG_BLK_DEV_PDC4030
 			case -18: /* "dc4030" */
 			{
@@ -2949,12 +2961,12 @@
 				hwif->reset = 1;
 				goto done;
 			case -4: /* "noautotune" */
-				hwif->drives[0].autotune = 2;
-				hwif->drives[1].autotune = 2;
+				hwif->drives[0].autotune = IDE_TUNE_NOAUTO;
+				hwif->drives[1].autotune = IDE_TUNE_NOAUTO;
 				goto done;
 			case -3: /* "autotune" */
-				hwif->drives[0].autotune = 1;
-				hwif->drives[1].autotune = 1;
+				hwif->drives[0].autotune = IDE_TUNE_AUTO;
+				hwif->drives[1].autotune = IDE_TUNE_AUTO;
 				goto done;
 			case -2: /* "serialize" */
 			do_serialize:
@@ -3211,7 +3223,8 @@
 	spin_lock(&drives_lock);
 	list_add(&drive->list, &driver->drives);
 	spin_unlock(&drives_lock);
-	if (drive->autotune != 2) {
+	if ((drive->autotune == IDE_TUNE_DEFAULT) ||
+		(drive->autotune == IDE_TUNE_AUTO)) {
 		/* DMA timings and setup moved to ide-probe.c */
 		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
 //			HWIF(drive)->ide_dma_off_quietly(drive);
diff -ur linux-2.5.46-clean/drivers/ide/setup-pci.c linux-2.5.46/drivers/ide/setup-pci.c
--- linux-2.5.46-clean/drivers/ide/setup-pci.c	2002-11-08 10:16:58.000000000 +0100
+++ linux-2.5.46/drivers/ide/setup-pci.c	2002-11-08 10:46:57.000000000 +0100
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
+		if (drive0_tune == IDE_TUNE_BIOS) /* biostimings */
+			hwif->drives[0].autotune = IDE_TUNE_BIOS;
+		if (drive1_tune == IDE_TUNE_BIOS)
+			hwif->drives[1].autotune = IDE_TUNE_BIOS;
 
 		mate = hwif;
 		at_least_one_hwif_enabled = 1;

-- 
Jens Axboe

