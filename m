Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbTC0XqI>; Thu, 27 Mar 2003 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbTC0Xpg>; Thu, 27 Mar 2003 18:45:36 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62105 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261614AbTC0XpL>; Thu, 27 Mar 2003 18:45:11 -0500
Date: Fri, 28 Mar 2003 00:56:02 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] new IDE PIO handlers 2/4
In-Reply-To: <Pine.SOL.4.30.0303280054270.6453-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303280055380.6453-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Rewritten PIO handlers, both single and multiple sector sizes.
#
# They make use of new bio travelsing code and are supposed to be
# correct in respect to ATA state machine.
#
# Patch 2/4 - Fix compilation of CONFIG_IDE_TASKFILE_IO.
#	      Fix read/write DMA commands handling in do_rw_taskfile()
#	      (b/c default return value is ide_stopped).
#
# New PIO handlers will be used if you turn on IDE_TASKFILE_IO config option.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.66-ide-pio-1/drivers/ide/Kconfig linux/drivers/ide/Kconfig
--- linux-2.5.66-ide-pio-1/drivers/ide/Kconfig	Tue Mar 25 22:53:09 2003
+++ linux/drivers/ide/Kconfig	Wed Mar 26 23:59:07 2003
@@ -219,7 +219,10 @@

 	  If you are unsure, say N here.

-#bool '  IDE Taskfile IO' CONFIG_IDE_TASKFILE_IO
+config IDE_TASKFILE_IO
+	bool "IDE Taskfile IO"
+	depends on BLK_DEV_IDE
+
 comment "IDE chipset support/bugfixes"
 	depends on BLK_DEV_IDE

diff -uNr linux-2.5.66-ide-pio-1/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.66-ide-pio-1/drivers/ide/ide-disk.c	Tue Mar 25 22:53:09 2003
+++ linux/drivers/ide/ide-disk.c	Wed Mar 26 23:53:44 2003
@@ -73,8 +73,6 @@

 #include "legacy/pdc4030.h"

-static int driver_blocked;
-
 static inline u32 idedisk_read_24 (ide_drive_t *drive)
 {
 	u8 hcyl = HWIF(drive)->INB(IDE_HCYL_REG);
@@ -133,8 +131,24 @@
 	return 0;	/* lba_capacity value may be bad */
 }

+static int idedisk_start_tag(ide_drive_t *drive, struct request *rq)
+{
+	unsigned long flags;
+	int ret = 1;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if (ata_pending_commands(drive) < drive->queue_depth)
+		ret = blk_queue_start_tag(&drive->queue, rq);
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return ret;
+}
+
 #ifndef CONFIG_IDE_TASKFILE_IO

+static int driver_blocked;
+
 /*
  * read_intr() is the handler for disk read/multread interrupts
  */
@@ -345,20 +359,6 @@
 	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
 }

-static int idedisk_start_tag(ide_drive_t *drive, struct request *rq)
-{
-	unsigned long flags;
-	int ret = 1;
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	if (ata_pending_commands(drive) < drive->queue_depth)
-		ret = blk_queue_start_tag(&drive->queue, rq);
-
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return ret;
-}
-
 /*
  * do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
@@ -745,7 +745,7 @@
 		args.tfRegister[IDE_FEATURE_OFFSET] = sectors;
 		args.tfRegister[IDE_NSECTOR_OFFSET] = rq->tag << 3;
 		args.hobRegister[IDE_FEATURE_OFFSET_HOB] = sectors >> 8;
-		args.hobRegister[IDE_NSECT_OFFSET_HOB] = 0;
+		args.hobRegister[IDE_NSECTOR_OFFSET_HOB] = 0;
 	} else {
 		args.tfRegister[IDE_NSECTOR_OFFSET] = sectors;
 		args.hobRegister[IDE_NSECTOR_OFFSET_HOB] = sectors >> 8;
diff -uNr linux-2.5.66-ide-pio-1/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.66-ide-pio-1/drivers/ide/ide-taskfile.c	Wed Mar 26 22:54:54 2003
+++ linux/drivers/ide/ide-taskfile.c	Wed Mar 26 23:50:20 2003
@@ -193,15 +193,15 @@
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
-			if (hwif->ide_dma_write(drive))
-				return ide_stopped;
+			if (!hwif->ide_dma_write(drive))
+				return ide_started;
 			break;
 		case WIN_READDMA_ONCE:
 		case WIN_READDMA:
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
-			if (hwif->ide_dma_read(drive))
-				return ide_stopped;
+			if (!hwif->ide_dma_read(drive))
+				return ide_started;
 			break;
 		case WIN_READDMA_QUEUED:
 		case WIN_READDMA_QUEUED_EXT:

