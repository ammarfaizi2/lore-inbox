Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUBSPIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUBSPFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:05:01 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57828 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267297AbUBSOz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (1/9)
Date: Thu, 19 Feb 2004 15:56:38 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191556.38460.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More cleanups + fix for /proc/ide/<chipset> not being created for IDE modules.

--bart

[IDE] remove dead kernel parameters

Remove "hdx=flash" (ignored since 2.5.63) and "hdx=slow"
(ignored since 2.5.41) kernel parameters.

Also remove "slow" entry from /proc/ide/hdx/settings
and "ata_flash", "nobios" and "slow" fields from ide_drive_t.

 linux-2.6.3-root/Documentation/ide.txt   |    7 -------
 linux-2.6.3-root/drivers/ide/ide-probe.c |   22 ++--------------------
 linux-2.6.3-root/drivers/ide/ide.c       |   18 ++----------------
 linux-2.6.3-root/include/linux/ide.h     |    3 ---
 4 files changed, 4 insertions(+), 46 deletions(-)

diff -puN Documentation/ide.txt~ide_params_cleanup Documentation/ide.txt
--- linux-2.6.3/Documentation/ide.txt~ide_params_cleanup	2004-02-19 01:40:34.459860040 +0100
+++ linux-2.6.3-root/Documentation/ide.txt	2004-02-19 01:41:21.993633808 +0100
@@ -242,17 +242,10 @@ Summary of ide driver parameters for ker
 			  and quite likely to cause trouble with
 			  older/odd IDE drives.
 
- "hdx=slow"		: insert a huge pause after each access to the data
-			  port. Should be used only as a last resort.
-
  "hdx=swapdata"		: when the drive is a disk, byte swap all data
 
  "hdx=bswap"		: same as above..........
 
- "hdx=flash"		: allows for more than one ata_flash disk to be
- 			  registered. In most cases, only one device
- 			  will be present.
-
  "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
diff -puN drivers/ide/ide.c~ide_params_cleanup drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_params_cleanup	2004-02-19 01:40:44.036404184 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 01:41:28.576633040 +0100
@@ -1392,7 +1392,6 @@ void ide_add_generic_settings (ide_drive
 	ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL);
 	ide_add_setting(drive,	"nice1",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL);
 	ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode);
-	ide_add_setting(drive,	"slow",			SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->slow,			NULL);
 	ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL);
 	ide_add_setting(drive,	"using_dma",		SETTING_RW,					HDIO_GET_DMA,		HDIO_SET_DMA,		TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma);
 	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL);
@@ -1805,15 +1804,9 @@ static int __initdata is_chipset_set[MAX
  *				Not fully supported by all chipset types,
  *				and quite likely to cause trouble with
  *				older/odd IDE drives.
- * "hdx=slow"		: insert a huge pause after each access to the data
- *				port. Should be used only as a last resort.
- *
  * "hdx=swapdata"	: when the drive is a disk, byte swap all data
  * "hdx=bswap"		: same as above..........
  * "hdxlun=xx"          : set the drive last logical unit.
- * "hdx=flash"		: allows for more than one ata_flash disk to be
- *				registered. In most cases, only one device
- *				will be present.
  * "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
  *				allowing ide-floppy, ide-tape, and ide-cdrom|writers
  *				to use ide-scsi emulation on a device specific option.
@@ -1915,8 +1908,8 @@ int __init ide_setup (char *s)
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {
 			"none", "noprobe", "nowerr", "cdrom", "serialize",
-			"autotune", "noautotune", "slow", "swapdata", "bswap",
-			"flash", "remap", "remap63", "scsi", NULL };
+			"autotune", "noautotune", "minus8", "swapdata", "bswap",
+			"minus11", "remap", "remap63", "scsi", NULL };
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
@@ -1941,7 +1934,6 @@ int __init ide_setup (char *s)
 		}
 		switch (match_parm(&s[3], hd_words, vals, 3)) {
 			case -1: /* "none" */
-				drive->nobios = 1;  /* drop into "noprobe" */
 			case -2: /* "noprobe" */
 				drive->noprobe = 1;
 				goto done;
@@ -1963,16 +1955,10 @@ int __init ide_setup (char *s)
 			case -7: /* "noautotune" */
 				drive->autotune = IDE_TUNE_NOAUTO;
 				goto done;
-			case -8: /* "slow" */
-				drive->slow = 1;
-				goto done;
 			case -9: /* "swapdata" */
 			case -10: /* "bswap" */
 				drive->bswap = 1;
 				goto done;
-			case -11: /* "flash" */
-				drive->ata_flash = 1;
-				goto done;
 			case -12: /* "remap" */
 				drive->remap_0_to_1 = 1;
 				goto done;
diff -puN drivers/ide/ide-probe.c~ide_params_cleanup drivers/ide/ide-probe.c
--- linux-2.6.3/drivers/ide/ide-probe.c~ide_params_cleanup	2004-02-19 01:40:46.159081488 +0100
+++ linux-2.6.3-root/drivers/ide/ide-probe.c	2004-02-19 01:41:21.998633048 +0100
@@ -237,27 +237,9 @@ static inline void do_identify (ide_driv
 	 */
 	if (id->config & (1<<7))
 		drive->removable = 1;
-		
-	/*
-	 * Prevent long system lockup probing later for non-existant
-	 * slave drive if the hwif is actually a flash memory card of
-	 * some variety:
-	 */
-	drive->is_flash = 0;
-	if (drive_is_flashcard(drive)) {
-#if 0
-		/* The new IDE adapter widgets don't follow this heuristic
-		   so we must nowdays just bite the bullet and take the
-		   probe hit */	
-		ide_drive_t *mate = &hwif->drives[1^drive->select.b.unit];		
-		ide_drive_t *mate = &hwif->drives[1^drive->select.b.unit];
-		if (!mate->ata_flash) {
-			mate->present = 0;
-			mate->noprobe = 1;
-		}
-#endif		
+
+	if (drive_is_flashcard(drive))
 		drive->is_flash = 1;
-	}
 	drive->media = ide_disk;
 	printk("%s DISK drive\n", (drive->is_flash) ? "CFA" : "ATA" );
 	QUIRK_LIST(drive);
diff -puN include/linux/ide.h~ide_params_cleanup include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_params_cleanup	2004-02-19 01:40:52.007192440 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-19 01:41:28.579632584 +0100
@@ -698,7 +698,6 @@ typedef struct ide_drive_s {
 	u8	state;			/* retry state */
 	u8	waiting_for_dma;	/* dma currently in progress */
 	u8	unmask;			/* okay to unmask other irqs */
-	u8	slow;			/* slow data port */
 	u8	bswap;			/* byte swap data */
 	u8	dsc_overlap;		/* DSC overlap */
 	u8	nice1;			/* give potential excess bandwidth */
@@ -713,14 +712,12 @@ typedef struct ide_drive_s {
 	unsigned forced_geom	: 1;	/* 1 if hdx=c,h,s was given at boot */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
-	unsigned nobios		: 1;	/* do not probe bios for drive */
 	unsigned atapi_overlap	: 1;	/* ATAPI overlap (not supported) */
 	unsigned nice0		: 1;	/* give obvious excess bandwidth */
 	unsigned nice2		: 1;	/* give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
 	unsigned autotune	: 2;	/* 0=default, 1=autotune, 2=noautotune */
 	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
-	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
 	unsigned addressing;		/*      : 3;

_

