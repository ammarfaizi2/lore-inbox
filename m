Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVJSMtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVJSMtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVJSMtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:49:00 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:58691 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750937AbVJSMsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:48:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=T748UKZf+RtMxhgo0R/C5hlY0pOn4pItk/yJE47NjW/qdN2aSCeTRkSAEQ38f5WNd0VD4xT5n6Hf5xN/+YbLmzY+Ou2LUI1jXEQpe8aH2UAk5Vpr5AxMxrV/hD2uVDyzu4hz2/nPuxAtonviZ4+74DC9+7UZzF6UfJpzWanqwMc=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019124716.EF1F6546@htj.dyndns.org>
In-Reply-To: <20051019124716.EF1F6546@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 09/10] blk: add FUA support to IDE
Message-ID: <20051019124716.8343B9D6@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:48:27 +0900 (KST)
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
--- blk-fixes.orig/drivers/ide/ide-disk.c	2005-10-19 21:47:14.000000000 +0900
+++ blk-fixes/drivers/ide/ide-disk.c	2005-10-19 21:47:14.000000000 +0900
@@ -164,13 +164,14 @@ static ide_startstop_t __ide_do_rw_disk(
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
@@ -226,6 +227,16 @@ static ide_startstop_t __ide_do_rw_disk(
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
@@ -253,9 +264,12 @@ static ide_startstop_t __ide_do_rw_disk(
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
@@ -284,8 +298,20 @@ static ide_startstop_t __ide_do_rw_disk(
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
@@ -295,6 +321,10 @@ static ide_startstop_t __ide_do_rw_disk(
 
 		return pre_task_out_intr(drive, rq);
 	}
+
+ fail:
+	ide_end_request(drive, 0, 0);
+	return ide_stopped;
 }
 
 /*
@@ -846,7 +876,7 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
-	int barrier;
+	int barrier, fua;
 
 	idedisk_add_settings(drive);
 
@@ -967,10 +997,19 @@ static void idedisk_setup (ide_drive_t *
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
--- blk-fixes.orig/include/linux/ata.h	2005-10-19 21:47:14.000000000 +0900
+++ blk-fixes/include/linux/ata.h	2005-10-19 21:47:14.000000000 +0900
@@ -129,6 +129,7 @@ enum {
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
+	ATA_CMD_MULT_WRITE_FUA_EXT = 0xCE,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
Index: blk-fixes/include/linux/hdreg.h
===================================================================
--- blk-fixes.orig/include/linux/hdreg.h	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/include/linux/hdreg.h	2005-10-19 21:47:14.000000000 +0900
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
--- blk-fixes.orig/include/linux/ide.h	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/include/linux/ide.h	2005-10-19 21:47:14.000000000 +0900
@@ -1497,6 +1497,9 @@ extern struct bus_type ide_bus_type;
 /* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
 #define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
 
+/* check if WRITE DMA FUA EXT command is supported (defined in ATA-8) */
+#define ide_id_has_fua(id)		((id)->cfsse & 0x0040)
+
 /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)

