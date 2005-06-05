Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVFEGPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVFEGPa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVFEGOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:14:41 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:55539 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261470AbVFEF5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Dx7oF84QSS9OAsy/zCBn5PbKWUeWcLPc3p3hcsmGXU/uH2frlUa14wVooARPLt0Ta9zMWai2K/3qBtTIwH9ggWM8SJHFe6pMOXKWYxekY89eFXPlhoGfFCHRSO2tgFHiUH34VdOWTBSjIypF9hO6rdF3TIofcYEQA/7XLCUlsvU=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 08/09] blk: update IDE to use the new blk_ordered.
Message-ID: <20050605055337.ADD601D4@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:45 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08_blk_update_ide_to_use_new_ordered.patch

	Update IDE to use the new blk_ordered.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c |   92 ++++++++++++++++++++-----------------------------
 drivers/ide/ide-io.c   |    5 --
 include/linux/hdreg.h  |   19 +++++++++-
 include/linux/ide.h    |    3 +
 4 files changed, 59 insertions(+), 60 deletions(-)

Index: blk-fixes/drivers/ide/ide-disk.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-disk.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/ide/ide-disk.c	2005-06-05 14:53:35.000000000 +0900
@@ -176,6 +176,18 @@ static ide_startstop_t __ide_do_rw_disk(
 			lba48 = 0;
 	}
 
+	if (blk_fua_rq(rq) &&
+	    (!rq_data_dir(rq) || !drive->select.b.lba || !lba48)) {
+		if (!rq_data_dir(rq))
+			printk(KERN_WARNING "%s: FUA READ unsupported\n",
+			       drive->name);
+		else
+			printk(KERN_WARNING "%s: FUA request received but "
+			       "cannot use LBA48\n", drive->name);
+		ide_end_request(drive, 0, 0);
+		return ide_stopped;
+	}
+
 	if (!dma) {
 		ide_init_sg_cmd(drive, rq);
 		ide_map_sg(drive, rq);
@@ -253,9 +265,12 @@ static ide_startstop_t __ide_do_rw_disk(
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
 			if (rq_data_dir(rq)) {
-				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-				if (drive->vdma)
-					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
+				if (!blk_fua_rq(rq)) {
+					command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+					if (drive->vdma)
+						command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
+				} else
+					command = WIN_WRITEDMA_FUA_EXT;
 			} else {
 				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
 				if (drive->vdma)
@@ -284,7 +299,10 @@ static ide_startstop_t __ide_do_rw_disk(
 	} else {
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_OUT;
-			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			if (!blk_fua_rq(rq))
+				command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			else
+				command = WIN_MULTWRITE_FUA_EXT;
 		} else {
 			hwif->data_phase = TASKFILE_OUT;
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
@@ -681,51 +699,10 @@ static ide_proc_entry_t idedisk_proc[] =
 
 #endif	/* CONFIG_PROC_FS */
 
-static void idedisk_end_flush(request_queue_t *q, struct request *flush_rq)
-{
-	ide_drive_t *drive = q->queuedata;
-	struct request *rq = flush_rq->end_io_data;
-	int good_sectors = rq->hard_nr_sectors;
-	int bad_sectors;
-	sector_t sector;
-
-	if (flush_rq->errors & ABRT_ERR) {
-		printk(KERN_ERR "%s: barrier support doesn't work\n", drive->name);
-		blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE);
-		blk_queue_issue_flush_fn(drive->queue, NULL);
-		good_sectors = 0;
-	} else if (flush_rq->errors) {
-		good_sectors = 0;
-		if (blk_barrier_preflush(rq)) {
-			sector = ide_get_error_location(drive,flush_rq->buffer);
-			if ((sector >= rq->hard_sector) &&
-			    (sector < rq->hard_sector + rq->hard_nr_sectors))
-				good_sectors = sector - rq->hard_sector;
-		}
-	}
-
-	if (flush_rq->errors)
-		printk(KERN_ERR "%s: failed barrier write: "
-				"sector=%Lx(good=%d/bad=%d)\n",
-				drive->name, (unsigned long long)rq->sector,
-				good_sectors,
-				(int) (rq->hard_nr_sectors-good_sectors));
-
-	bad_sectors = rq->hard_nr_sectors - good_sectors;
-
-	if (good_sectors)
-		__ide_end_request(drive, rq, 1, good_sectors);
-	if (bad_sectors)
-		__ide_end_request(drive, rq, 0, bad_sectors);
-}
-
-static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
+static void idedisk_prepare_flush(request_queue_t *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
 
-	if (!drive->wcache)
-		return 0;
-
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
@@ -737,7 +714,6 @@ static int idedisk_prepare_flush(request
 
 	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
 	rq->buffer = rq->cmd;
-	return 1;
 }
 
 static int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
@@ -888,7 +864,7 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
-	int barrier;
+	int barrier, fua;
 
 	idedisk_add_settings(drive);
 
@@ -1011,14 +987,20 @@ static void idedisk_setup (ide_drive_t *
 			barrier = 0;
 	}
 
-	printk(KERN_INFO "%s: cache flushes %ssupported\n",
-		drive->name, barrier ? "" : "not ");
+	fua = barrier && idedisk_supports_lba48(id) && ide_id_has_fua(id);
+
+	printk(KERN_INFO "%s: cache flushes %ssupported%s\n",
+	       drive->name, barrier ? "" : "not ",
+	       fua ? " with forced unit access" : "");
 	if (barrier) {
-		blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
-		drive->queue->prepare_flush_fn = idedisk_prepare_flush;
-		drive->queue->end_flush_fn = idedisk_end_flush;
+		unsigned ordered = fua ? QUEUE_ORDERED_DRAIN_FUA
+				       : QUEUE_ORDERED_DRAIN_FLUSH;
+		blk_queue_ordered(drive->queue, ordered,
+				  idedisk_prepare_flush, GFP_KERNEL);
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
-	}
+	} else if (!drive->wcache)
+		blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN,
+				  NULL, GFP_KERNEL);
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
@@ -1036,6 +1018,8 @@ static int ide_disk_remove(struct device
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
+	blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE, NULL, 0);
+
 	ide_cacheflush_p(drive);
 
 	ide_unregister_subdriver(drive, idkp->driver);
Index: blk-fixes/drivers/ide/ide-io.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-io.c	2005-06-05 14:53:33.000000000 +0900
+++ blk-fixes/drivers/ide/ide-io.c	2005-06-05 14:53:35.000000000 +0900
@@ -119,10 +119,7 @@ int ide_end_request (ide_drive_t *drive,
 	if (!nr_sectors)
 		nr_sectors = rq->hard_cur_sectors;
 
-	if (blk_complete_barrier_rq_locked(drive->queue, rq, nr_sectors))
-		ret = rq->nr_sectors != 0;
-	else
-		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
+	ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ret;
Index: blk-fixes/include/linux/hdreg.h
===================================================================
--- blk-fixes.orig/include/linux/hdreg.h	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/include/linux/hdreg.h	2005-06-05 14:53:35.000000000 +0900
@@ -221,10 +221,13 @@ typedef struct hd_drive_hob_hdr {
 #define WIN_WRITE_LONG_ONCE		0x33 /* 28-Bit without retries */
 #define WIN_WRITE_EXT			0x34 /* 48-Bit */
 #define WIN_WRITEDMA_EXT		0x35 /* 48-Bit */
+#define WIN_WRITEDMA_FUA_EXT		0x3D /* 48-Bit forced unit access */
 #define WIN_WRITEDMA_QUEUED_EXT		0x36 /* 48-Bit */
+#define WIN_WRITEDMA_QUEUED_FUA_EXT	0x3E /* 48-Bit forced unit access */
 #define WIN_SET_MAX_EXT			0x37 /* 48-Bit */
 #define CFA_WRITE_SECT_WO_ERASE		0x38 /* CFA Write Sectors without erase */
 #define WIN_MULTWRITE_EXT		0x39 /* 48-Bit */
+#define WIN_MULTWRITE_FUA_EXT		0xCE /* 48-Bit forced unit access */
 /*
  *	0x3A->0x3B Reserved
  */
@@ -550,7 +553,13 @@ struct hd_driveid {
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
@@ -600,7 +609,13 @@ struct hd_driveid {
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
--- blk-fixes.orig/include/linux/ide.h	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/include/linux/ide.h	2005-06-05 14:53:35.000000000 +0900
@@ -1497,6 +1497,9 @@ extern struct bus_type ide_bus_type;
 /* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
 #define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
 
+/* check if WRITE DMA FUA EXT command is supported (defined in ATA-8) */
+#define ide_id_has_fua(id)		((id)->cfsse & 0x0040)
+
 /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)

