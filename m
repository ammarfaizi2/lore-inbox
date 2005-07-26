Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVGZRDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVGZRDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVGZPrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:15 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:20774 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261878AbVGZPqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=SpE6hrMKAmyzim1lLY79aEKXvNRMPiIkaTM6tj92Bdc4jND7sdUPjLRs8r5zhRvEGTFunQRTRryUOBrABBs6G5nZdfoH6BLz6DTIjnhnEmMfTvYy99Sm1R6AJnSZ2IsK9+iwk8gU2JJrYk9phZxJ/VqJHKiVStbEjAMHA8S8ZUU=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 09/10] blk: add FUA support to IDE
Message-ID: <20050726154457.A3C81676@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:36 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09_blk_ide-add-fua-support.patch

	Add FUA support to IDE

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c |   57 +++++++++++++++++++++++++++++++++++++++++--------
 include/linux/ata.h    |    1 
 include/linux/hdreg.h  |   16 ++++++++++++-
 include/linux/ide.h    |    3 ++
 4 files changed, 66 insertions(+), 11 deletions(-)

Index: blk-fixes/drivers/ide/ide-disk.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-disk.c	2005-07-27 00:44:52.000000000 +0900
+++ blk-fixes/drivers/ide/ide-disk.c	2005-07-27 00:44:52.000000000 +0900
@@ -160,13 +160,14 @@ static ide_startstop_t __ide_do_rw_disk(
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned int dma	= drive->using_dma;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	int fua			= blk_fua_rq(rq);
 	task_ioreg_t command	= WIN_NOP;
 	ata_nsector_t		nsectors;
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
 	if (hwif->no_lba48_dma && lba48 && dma) {
-		if (block + rq->nr_sectors > 1ULL << 28)
+		if (block + rq->nr_sectors > 1ULL << 28 || fua)
 			dma = 0;
 		else
 			lba48 = 0;
@@ -222,6 +223,16 @@ static ide_startstop_t __ide_do_rw_disk(
 			hwif->OUTB(tasklets[6], IDE_HCYL_REG);
 			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
 		} else {
+			if (unlikely(fua)) {
+				/*
+				 * This happens if LBA48 addressing is
+				 * turned off during operation.
+				 */
+				printk(KERN_ERR "%s: FUA write but LBA48 off\n",
+				       drive->name);
+				goto fail;
+			}
+
 			hwif->OUTB(0x00, IDE_FEATURE_REG);
 			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
 			hwif->OUTB(block, IDE_SECTOR_REG);
@@ -249,9 +260,12 @@ static ide_startstop_t __ide_do_rw_disk(
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
 			if (rq_data_dir(rq)) {
-				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-				if (drive->vdma)
-					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
+				if (!fua) {
+					command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+					if (drive->vdma)
+						command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
+				} else
+					command = ATA_CMD_WRITE_FUA_EXT;
 			} else {
 				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
 				if (drive->vdma)
@@ -280,8 +294,20 @@ static ide_startstop_t __ide_do_rw_disk(
 	} else {
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_OUT;
-			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			if (!fua)
+				command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			else
+				command = ATA_CMD_MULT_WRITE_FUA_EXT;
 		} else {
+			if (unlikely(fua)) {
+				/*
+				 * This happens if multisector PIO is
+				 * turned off during operation.
+				 */
+				printk(KERN_ERR "%s: FUA write but in single "
+				       "sector PIO mode\n", drive->name);
+				goto fail;
+			}
 			hwif->data_phase = TASKFILE_OUT;
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
@@ -291,6 +317,10 @@ static ide_startstop_t __ide_do_rw_disk(
 
 		return pre_task_out_intr(drive, rq);
 	}
+
+ fail:
+	ide_end_request(drive, 0, 0);
+	return ide_stopped;
 }
 
 /*
@@ -842,7 +872,7 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
-	int barrier;
+	int barrier, fua;
 
 	idedisk_add_settings(drive);
 
@@ -963,10 +993,19 @@ static void idedisk_setup (ide_drive_t *
 			barrier = 0;
 	}
 
-	printk(KERN_INFO "%s: cache flushes %ssupported\n",
-		drive->name, barrier ? "" : "not ");
+	fua = barrier && idedisk_supports_lba48(id) && ide_id_has_fua(id);
+	/* When using PIO, FUA needs multisector. */
+	if ((!drive->using_dma || drive->hwif->no_lba48_dma) &&
+	    drive->mult_count == 0)
+		fua = 0;
+
+	printk(KERN_INFO "%s: cache flushes %ssupported%s\n",
+	       drive->name, barrier ? "" : "not ",
+	       fua ? " w/ FUA" : "");
 	if (barrier) {
-		blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN_FLUSH,
+		unsigned ordered = fua ? QUEUE_ORDERED_DRAIN_FUA
+				       : QUEUE_ORDERED_DRAIN_FLUSH;
+		blk_queue_ordered(drive->queue, ordered,
 				  idedisk_prepare_flush, GFP_KERNEL);
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
 	} else if (!drive->wcache)
Index: blk-fixes/include/linux/ata.h
===================================================================
--- blk-fixes.orig/include/linux/ata.h	2005-07-27 00:44:52.000000000 +0900
+++ blk-fixes/include/linux/ata.h	2005-07-27 00:44:52.000000000 +0900
@@ -122,6 +122,7 @@ enum {
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
+	ATA_CMD_MULT_WRITE_FUA_EXT = 0xCE,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
Index: blk-fixes/include/linux/hdreg.h
===================================================================
--- blk-fixes.orig/include/linux/hdreg.h	2005-07-27 00:44:47.000000000 +0900
+++ blk-fixes/include/linux/hdreg.h	2005-07-27 00:44:52.000000000 +0900
@@ -550,7 +550,13 @@ struct hd_driveid {
 					 * cmd set-feature supported extensions
 					 * 15:	Shall be ZERO
 					 * 14:	Shall be ONE
-					 * 13:6	reserved
+					 * 13:  IDLE IMMEDIATE w/ UNLOAD FEATURE
+					 * 12:11 reserved for technical report
+					 * 10:  URG for WRITE STREAM
+					 *  9:  URG for READ STREAM
+					 *  8:  64-bit World wide name
+					 *  7:  WRITE DMA QUEUED FUA EXT
+					 *  6:  WRITE DMA/MULTIPLE FUA EXT
 					 *  5:	General Purpose Logging
 					 *  4:	Streaming Feature Set
 					 *  3:	Media Card Pass Through
@@ -600,7 +606,13 @@ struct hd_driveid {
 					 * command set-feature default
 					 * 15:	Shall be ZERO
 					 * 14:	Shall be ONE
-					 * 13:6	reserved
+					 * 13:  IDLE IMMEDIATE w/ UNLOAD FEATURE
+					 * 12:11 reserved for technical report
+					 * 10:  URG for WRITE STREAM
+					 *  9:  URG for READ STREAM
+					 *  8:  64-bit World wide name
+					 *  7:  WRITE DMA QUEUED FUA EXT
+					 *  6:  WRITE DMA/MULTIPLE FUA EXT
 					 *  5:	General Purpose Logging enabled
 					 *  4:	Valid CONFIGURE STREAM executed
 					 *  3:	Media Card Pass Through enabled
Index: blk-fixes/include/linux/ide.h
===================================================================
--- blk-fixes.orig/include/linux/ide.h	2005-07-27 00:44:47.000000000 +0900
+++ blk-fixes/include/linux/ide.h	2005-07-27 00:44:52.000000000 +0900
@@ -1497,6 +1497,9 @@ extern struct bus_type ide_bus_type;
 /* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
 #define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
 
+/* check if WRITE DMA FUA EXT command is supported (defined in ATA-8) */
+#define ide_id_has_fua(id)		((id)->cfsse & 0x0040)
+
 /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)

