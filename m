Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTFJQBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTFJQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:01:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59620 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263234AbTFJQBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:01:23 -0400
Date: Tue, 10 Jun 2003 18:15:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE Power Management, try 2
Message-ID: <20030610161503.GH17164@suse.de>
References: <1054820805.766.10.camel@gaston> <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05 2003, Bartlomiej Zolnierkiewicz wrote:
> Jens, I think generic version of ide_do_drive_cmd() would be useful for
> other block devices, what do you think?

Something ala this? Completely untested, and I only did scsi_ioctl.c and
ide-io.c. iirc, scsi uses somthing similar that could be adapted too.

===== drivers/block/ll_rw_blk.c 1.173 vs edited =====
--- 1.173/drivers/block/ll_rw_blk.c	Thu Jun  5 15:22:28 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Jun 10 18:11:02 2003
@@ -1405,6 +1405,55 @@
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
+/**
+ * blk_do_request - insert and issue request into block queue
+ * @bdev:	target block device
+ * @rq:		request to be inserted
+ * @action:	where to insert request
+ *
+ * Description:
+ *	Insert a request into the block queue at the end or head of the list,
+ *	possibly waiting for its completion.
+ */
+int blk_do_request(struct gendisk *disk, struct request *rq, int action)
+{
+	request_queue_t *q = disk->queue;
+	DECLARE_COMPLETION(wait);
+	int err = 0;
+
+	if (!q)
+		return -ENODEV;
+
+	rq->errors = 0;
+	rq->rq_disk = disk;
+	rq->flags |= REQ_NOMERGE;
+
+	if (action & BLK_RQ_WAIT) {
+		/*
+		 * we need an extra reference to the request if we want to
+		 * look at it after io completion
+		 */
+		rq->ref_count++;
+		rq->waiting = &wait;
+	}
+
+	elv_add_request(q, rq, action & BLK_RQ_END, 1);
+
+	generic_unplug_device(q);
+
+	if (action & BLK_RQ_WAIT) {
+		wait_for_completion(&wait);
+
+		if (rq->errors)
+			err = -EIO;
+
+		blk_put_request(rq);
+	}
+
+	return err;
+}
+
+
 void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
 {
 	int rw = rq_data_dir(rq);
===== drivers/block/scsi_ioctl.c 1.29 vs edited =====
--- 1.29/drivers/block/scsi_ioctl.c	Fri May 30 20:01:51 2003
+++ edited/drivers/block/scsi_ioctl.c	Tue Jun 10 18:07:20 2003
@@ -45,20 +45,11 @@
 #define SCSI_SENSE_BUFFERSIZE 64
 #endif
 
-static int blk_do_rq(request_queue_t *q, struct block_device *bdev, 
-		     struct request *rq)
+#include <scsi/sg.h>
+
+static int sg_issue_request(struct block_device *bdev, struct request *rq)
 {
 	char sense[SCSI_SENSE_BUFFERSIZE];
-	DECLARE_COMPLETION(wait);
-	int err = 0;
-
-	rq->rq_disk = bdev->bd_disk;
-
-	/*
-	 * we need an extra reference to the request, so we can look at
-	 * it after io completion
-	 */
-	rq->ref_count++;
 
 	if (!rq->sense) {
 		memset(sense, 0, sizeof(sense));
@@ -66,20 +57,9 @@
 		rq->sense_len = 0;
 	}
 
-	rq->flags |= REQ_NOMERGE;
-	rq->waiting = &wait;
-	elv_add_request(q, rq, 1, 1);
-	generic_unplug_device(q);
-	wait_for_completion(&wait);
-
-	if (rq->errors)
-		err = -EIO;
-
-	return err;
+	return blk_do_request(bdev->bd_disk, rq, BLK_RQ_WAIT | BLK_RQ_END);
 }
 
-#include <scsi/sg.h>
-
 static int sg_get_version(int *p)
 {
 	static int sg_version_num = 30527;
@@ -248,7 +228,7 @@
 	 * (if he doesn't check that is his problem).
 	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
 	 */
-	blk_do_rq(q, bdev, rq);
+	sg_issue_request(bdev, rq);
 
 	if (bio)
 		bio_unmap_user(bio, reading);
@@ -376,7 +356,7 @@
 	rq->data_len = bytes;
 	rq->flags |= REQ_BLOCK_PC;
 
-	blk_do_rq(q, bdev, rq);
+	sg_issue_request(bdev, rq);
 	err = rq->errors & 0xff;	/* only 8 bit SCSI status */
 	if (err) {
 		if (rq->sense_len && rq->sense) {
@@ -458,7 +438,7 @@
 			rq->cmd[0] = GPCMD_START_STOP_UNIT;
 			rq->cmd[4] = 0x02 + (close != 0);
 			rq->cmd_len = 6;
-			err = blk_do_rq(q, bdev, rq);
+			err = sg_issue_request(bdev, rq);
 			blk_put_request(rq);
 			break;
 		default:
===== drivers/ide/ide-io.c 1.11 vs edited =====
--- 1.11/drivers/ide/ide-io.c	Mon May 12 02:09:46 2003
+++ edited/drivers/ide/ide-io.c	Tue Jun 10 18:12:45 2003
@@ -1278,10 +1278,9 @@
  
 int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t action)
 {
-	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	DECLARE_COMPLETION(wait);
-	int insert_end = 1, err;
+	int blk_flags = 0;
 
 #ifdef CONFIG_BLK_DEV_PDC4030
 	/*
@@ -1292,39 +1291,16 @@
 	if (HWIF(drive)->chipset == ide_pdc4030 && rq->buffer != NULL)
 		return -ENOSYS;  /* special drive cmds not supported */
 #endif
-	rq->errors = 0;
-	rq->rq_status = RQ_ACTIVE;
 
-	rq->rq_disk = drive->disk;
+	if (action == ide_wait || action == ide_end)
+		blk_flags |= BLK_RQ_END;
+	if (action == ide_wait)
+		blk_flags |= BLK_RQ_WAIT;
 
-	/*
-	 * we need to hold an extra reference to request for safe inspection
-	 * after completion
-	 */
-	if (action == ide_wait) {
-		rq->ref_count++;
-		rq->waiting = &wait;
-	}
-
-	spin_lock_irqsave(&ide_lock, flags);
-	if (action == ide_preempt) {
+	if (action == ide_preempt)
 		hwgroup->rq = NULL;
-		insert_end = 0;
-	}
-	__elv_add_request(&drive->queue, rq, insert_end, 0);
-	ide_do_request(hwgroup, IDE_NO_IRQ);
-	spin_unlock_irqrestore(&ide_lock, flags);
-
-	err = 0;
-	if (action == ide_wait) {
-		wait_for_completion(&wait);
-		if (rq->errors)
-			err = -EIO;
-
-		blk_put_request(rq);
-	}
-
-	return err;
+	
+	return blk_do_request(drive->disk, rq, blk_flags);
 }
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
===== include/linux/blkdev.h 1.108 vs edited =====
--- 1.108/include/linux/blkdev.h	Sun Jun  8 00:33:38 2003
+++ edited/include/linux/blkdev.h	Tue Jun 10 18:05:49 2003
@@ -329,6 +329,12 @@
 #define BLKPREP_KILL		1	/* fatal error, kill */
 #define BLKPREP_DEFER		2	/* leave on queue */
 
+/*
+ * blk_do_request actions
+ */
+#define BLK_RQ_WAIT		1
+#define BLK_RQ_END		2
+
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 /*
@@ -372,6 +378,7 @@
 extern struct request *blk_get_request(request_queue_t *, int, int);
 extern void blk_put_request(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
+extern int blk_do_request(struct gendisk *, struct request *, int);
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);
 extern void blk_recount_segments(request_queue_t *, struct bio *);

-- 
Jens Axboe

