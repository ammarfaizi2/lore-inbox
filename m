Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbVKPToy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbVKPToy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVKPToy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:44:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20582 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030465AbVKPTow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:44:52 -0500
Date: Wed, 16 Nov 2005 20:45:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051116194520.GS7787@suse.de>
References: <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu> <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de> <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com> <20051116153119.GN7787@suse.de> <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com> <20051116171051.GP7787@suse.de> <58cb370e0511161111u7e99c74ufe0bb9019619d5d0@mail.gmail.com> <20051116192205.GR7787@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116192205.GR7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2005, Jens Axboe wrote:
> which of course didn't work, so it was changed to the above which then
> broke the assumption of what type of requests we expect to see in
> ide_softirq_done(). We can't generically handle this case, so it's
> probably best to just add this logic to __ide_end_request() - it's just
> another case for _not_ using the blk_complete_request() path, just like
> the partial case.

How about something like this? It requires blk_complete_request() calls
to be full completions of the request (or what is left of it). It cleans
up the calls a lot and fixes the wrong comment for IDE.

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 82b7290..8e6dd9f 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3223,33 +3223,20 @@ static struct notifier_block __devinitda
 /**
  * blk_complete_request - end I/O on a request
  * @req:      the request being processed
- * @uptodate: 1 for success, 0 for I/O error, < 0 for specific error
- * @nbytes:   number of bytes to end I/O on
  *
  * Description:
- *     Ends I/O on a number of sectors attached to @req, and sets it up
- *     for the next range of segments (if any) in the cluster. This variant
- *     completes the request out-of-order through a softirq handler. The user
- *     must have registered a completion callback through
- *     blk_queue_softirq_fn() at queue init time.
- *
- * Return:
- *     0 - we are done with this request, call end_that_request_last()
- *     1 - still buffers pending for this request
+ *     Ends all I/O on a request. It does not handle partial completions,
+ *     unless the driver actually implements this in its completionc callback
+ *     through requeueing. Theh actual completion happens out-of-order,
+ *     through a softirq handler. The user must have registered a completion
+ *     callback through blk_queue_softirq_done().
  **/
-int blk_complete_request(struct request *req, int uptodate, unsigned int nbytes,
-			 int partial_ok)
+
+void blk_complete_request(struct request *req)
 {
 	struct list_head *cpu_list;
 	unsigned long flags;
 
-	/*
-	 * for partial completions, fall back to normal end io handling.
-	 */
-	if (unlikely(!partial_ok && !rq_all_done(req, nbytes)))
-		if (end_that_request_chunk(req, uptodate, nbytes))
-			return 1;
-
 	BUG_ON(!req->q->softirq_done_fn);
 		
 	local_irq_save(flags);
@@ -3259,7 +3246,6 @@ int blk_complete_request(struct request 
 	raise_softirq_irqoff(BLOCK_SOFTIRQ);
 
 	local_irq_restore(flags);
-	return 0;
 }
 
 EXPORT_SYMBOL(blk_complete_request);
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index f114106..1129bfb 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -58,22 +58,9 @@
 void ide_softirq_done(struct request *rq)
 {
 	request_queue_t *q = rq->q;
-	int nbytes, uptodate = 1;
 
 	add_disk_randomness(rq->rq_disk);
-
-	/*
-	 * we know it's either an FS or PC request
-	 */
-	if (blk_fs_request(rq))
-		nbytes = rq->hard_nr_sectors << 9;
-	else
-		nbytes = rq->data_len;
-
-	if (rq->errors < 0)
-		uptodate = rq->errors;
-
-	end_that_request_chunk(rq, uptodate, nbytes);
+	end_that_request_chunk(rq, rq->errors, rq->data_len);
 
 	spin_lock_irq(q->queue_lock);
 	end_that_request_last(rq);
@@ -83,6 +70,9 @@ void ide_softirq_done(struct request *rq
 int __ide_end_request(ide_drive_t *drive, struct request *rq, int uptodate,
 		      int nr_sectors)
 {
+	unsigned int nbytes;
+	int ret = 1;
+
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
 	/*
@@ -104,13 +94,30 @@ int __ide_end_request(ide_drive_t *drive
 		HWGROUP(drive)->hwif->ide_dma_on(drive);
 	}
 
-	if (!blk_complete_request(rq, uptodate, nr_sectors << 9, 0)) {
+	/*
+	 * For partial completions (or non fs/pc requests), use the regular
+	 * direct completion path.
+	 */
+	nbytes = nr_sectors << 9;
+	if (rq_all_done(rq, nbytes)) {
+		rq->errors = uptodate;
+		rq->data_len = nbytes;
+		blk_complete_request(rq);
+		ret = 0;
+	} else {
+		if (!end_that_request_first(rq, uptodate, nr_sectors)) {
+			add_disk_randomness(rq->rq_disk);
+			end_that_request_last(rq);
+			ret = 0;
+		}
+	}
+
+	if (!ret) {
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
-		return 0;
 	}
 
-	return 1;
+	return ret;
 }
 EXPORT_SYMBOL(__ide_end_request);
 
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 4044ba4..bf902cf 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -751,6 +751,8 @@ static void scsi_done(struct scsi_cmnd *
  * isn't running --- used by scsi_times_out */
 void __scsi_done(struct scsi_cmnd *cmd)
 {
+	struct request *rq = cmd->request;
+
 	/*
 	 * Set the serial numbers back to zero
 	 */
@@ -760,14 +762,14 @@ void __scsi_done(struct scsi_cmnd *cmd)
 	if (cmd->result)
 		atomic_inc(&cmd->device->ioerr_cnt);
 
-	BUG_ON(!cmd->request);
+	BUG_ON(!rq);
 
 	/*
 	 * The uptodate/nbytes values don't matter, as we allow partial
 	 * completes and thus will check this in the softirq callback
 	 */
-	cmd->request->completion_data = cmd;
-	blk_complete_request(cmd->request, 0, 0, 1);
+	rq->completion_data = cmd;
+	blk_complete_request(rq);
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 588b9cc..3ff7c3f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -613,7 +613,7 @@ extern int end_that_request_first(struct
 extern int end_that_request_chunk(struct request *, int, int);
 extern void end_that_request_last(struct request *);
 extern void end_request(struct request *req, int uptodate);
-extern int blk_complete_request(struct request *, int, unsigned int, int);
+extern void blk_complete_request(struct request *);
 
 static inline int rq_all_done(struct request *rq, unsigned int nr_bytes)
 {

-- 
Jens Axboe

