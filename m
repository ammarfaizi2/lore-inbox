Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVKXQ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVKXQ1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVKXQ1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:27:14 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:53347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932362AbVKXQ0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:26:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Mbd6vbW4lKY93nW9qlYS0jHBH7DKINzM0e1/S53Qo3T9DZeWLb0Gnu1xsZ1Ct/L5Nq7OoKuCus4507qBL3hfsJYbG70Mpd2+RdphCGsuhccYLs9eDbAMDssKMfLm+GIfWitz80ajcoDmWNUhko3lWzzcxm8GKCdBCZ/DEMskg48=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051124162449.209CADD5@htj.dyndns.org>
In-Reply-To: <20051124162449.209CADD5@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 10/11] blk: add FUA support to IDE
Message-ID: <20051124162449.94344DD0@htj.dyndns.org>
Date: Fri, 25 Nov 2005 01:26:31 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10_blk_ide-add-fua-support.patch

	Add FUA support to IDE.  IDE FUA support makes use of
	->protocol_changed callback to correctly adjust FUA setting
	according to transfer protocol change.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c |   59 +++++++++++++++++++++++++++++++++++++++++--------
 include/linux/hdreg.h  |   16 +++++++++++--
 include/linux/ide.h    |    3 ++
 3 files changed, 67 insertions(+), 11 deletions(-)

Index: work/drivers/ide/ide-disk.c
===================================================================
--- work.orig/drivers/ide/ide-disk.c	2005-11-25 00:52:03.000000000 +0900
+++ work/drivers/ide/ide-disk.c	2005-11-25 00:52:04.000000000 +0900
@@ -164,18 +164,24 @@ static ide_startstop_t __ide_do_rw_disk(
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
 	}
 
+	if (unlikely(fua)) {
+		if (!lba48 || ((!dma || drive->vdma) && !drive->mult_count))
+			goto fail_fua;
+	}
+
 	if (!dma) {
 		ide_init_sg_cmd(drive, rq);
 		ide_map_sg(drive, rq);
@@ -253,9 +259,15 @@ static ide_startstop_t __ide_do_rw_disk(
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
+				} else {
+					command = ATA_CMD_WRITE_FUA_EXT;
+					if (drive->vdma)
+						command = ATA_CMD_WRITE_MULTI_FUA_EXT;
+				}
 			} else {
 				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
 				if (drive->vdma)
@@ -284,7 +296,10 @@ static ide_startstop_t __ide_do_rw_disk(
 	} else {
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_OUT;
-			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			if (!fua)
+				command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+			else
+				command = ATA_CMD_WRITE_MULTI_FUA_EXT;
 		} else {
 			hwif->data_phase = TASKFILE_OUT;
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
@@ -295,6 +310,13 @@ static ide_startstop_t __ide_do_rw_disk(
 
 		return pre_task_out_intr(drive, rq);
 	}
+
+ fail_fua:
+	printk(KERN_ERR "%s: FUA write unsupported (lba48=%u dma=%u "
+	       "vdma=%u mult_count=%u)\n",
+	       drive->name, lba48, dma, drive->vdma, drive->mult_count);
+	ide_end_request(drive, 0, 0);
+	return ide_stopped;
 }
 
 /*
@@ -761,7 +783,7 @@ static void update_ordered(ide_drive_t *
 
 	if (drive->wcache) {
 		unsigned long long capacity;
-		int barrier;
+		int barrier, lba48_dma, fua;
 		/*
 		 * We must avoid issuing commands a drive does not
 		 * understand or we may crash it. We check flush cache
@@ -775,11 +797,24 @@ static void update_ordered(ide_drive_t *
 			(drive->addressing == 0 || capacity <= (1ULL << 28) ||
 			 ide_id_has_flush_cache_ext(id));
 
-		printk(KERN_INFO "%s: cache flushes %ssupported\n",
-		       drive->name, barrier ? "" : "not");
+		/*
+		 * There is no single-sector or CHS/LBA28 FUA write
+		 * command.  Enable FUA only if DMA or multi-sector
+		 * PIO is used for LBA48 requests.
+		 */
+		lba48_dma = drive->using_dma &&
+			!drive->hwif->no_lba48_dma && !drive->vdma;
+		fua = barrier &&
+			idedisk_supports_lba48(id) && ide_id_has_fua(id) &&
+			(lba48_dma || drive->mult_count);
+
+		printk(KERN_INFO "%s: cache flushes %ssupported%s\n",
+		       drive->name, barrier ? "" : "not ",
+		       fua ? " w/ FUA" : "");
 
 		if (barrier) {
-			ordered = QUEUE_ORDERED_DRAIN_FLUSH;
+			ordered = fua ? QUEUE_ORDERED_DRAIN_FUA
+				      : QUEUE_ORDERED_DRAIN_FLUSH;
 			prep_fn = idedisk_prepare_flush;
 			issue_fn = idedisk_issue_flush;
 		}
@@ -1057,6 +1092,11 @@ static void ide_device_shutdown(struct d
 	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
+static void ide_disk_protocol_changed(ide_drive_t *drive)
+{
+	update_ordered(drive);
+}
+
 static ide_driver_t idedisk_driver = {
 	.owner			= THIS_MODULE,
 	.gen_driver = {
@@ -1074,6 +1114,7 @@ static ide_driver_t idedisk_driver = {
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
+	.protocol_changed	= ide_disk_protocol_changed,
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
Index: work/include/linux/hdreg.h
===================================================================
--- work.orig/include/linux/hdreg.h	2005-11-25 00:51:37.000000000 +0900
+++ work/include/linux/hdreg.h	2005-11-25 00:52:04.000000000 +0900
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
Index: work/include/linux/ide.h
===================================================================
--- work.orig/include/linux/ide.h	2005-11-25 00:52:03.000000000 +0900
+++ work/include/linux/ide.h	2005-11-25 00:52:04.000000000 +0900
@@ -1513,6 +1513,9 @@ extern struct bus_type ide_bus_type;
 /* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
 #define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
 
+/* check if WRITE DMA FUA EXT command is supported (defined in ATA-8) */
+#define ide_id_has_fua(id)		((id)->cfsse & 0x0040)
+
 /* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)

