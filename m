Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVE2EdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVE2EdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVE2EcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:32:20 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:57861 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVE2EXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:23:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=p8bpkUIKZx4ZYvFvPlLfq1EDW2hRDzuN/D/rMg/M4rRVOn+C+u8g/0GJIevkxUr2a+0QmU6jbtZ8UdQ3phLjWxR481zVUBrxwtGWeP5iL45FksKLdso0wdRw6fEzzdcbGwAJAP8rtF1oOC7SDiQqt5Yh7VQBV8qAPE6z3dt/wec=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050529042034.5FF4CF1C@htj.dyndns.org>
In-Reply-To: <20050529042034.5FF4CF1C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 04/06] blk: reimplement QUEUE_OREDERED_FLUSH
Message-ID: <20050529042034.2CF278F2@htj.dyndns.org>
Date: Sun, 29 May 2005 13:23:38 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_blk_flush_reimplementation.patch

	Reimplement QUEUE_ORDERED_FLUSH.

	* Implementation is contained inside blk layer.  Only
	  prepare_flush_fn() is needed from individual drivers.
	* Tagged queues which don't support ordered tag can use
          flushing.
	* Multi-bio barrier requests supported.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/elevator.c   |   52 ++++----
 drivers/block/ll_rw_blk.c  |  279 +++++++++++++++++++++++++++------------------
 drivers/ide/ide-disk.c     |   39 ------
 drivers/ide/ide-io.c       |    5 
 drivers/scsi/scsi_lib.c    |   21 ---
 drivers/scsi/sd.c          |   25 ----
 include/linux/blkdev.h     |   29 ++--
 include/scsi/scsi_driver.h |    1 
 8 files changed, 210 insertions(+), 241 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-05-29 13:20:30.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-05-29 13:20:31.000000000 +0900
@@ -40,6 +40,26 @@
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
+static inline void elv_inc_inflight(request_queue_t *q)
+{
+	q->in_flight++;
+}
+
+static inline void elv_dec_inflight(request_queue_t *q)
+{
+	q->in_flight--;
+
+	/*
+	 * If the queue is waiting for all accounted requests to be
+	 * drained to start flush sequence and we're the last one,
+	 * kick the queue in the ass to start the flush sequence.
+	 */
+	if (q->flush_seq == QUEUE_FLUSH_DRAIN && q->in_flight == 0) {
+		q->flush_seq = QUEUE_FLUSH_PRE;
+		q->request_fn(q);
+	}
+}
+
 /*
  * can we safely merge with this request?
  */
@@ -270,7 +290,7 @@ void elv_deactivate_request(request_queu
 	 * in_flight count again
 	 */
 	if (blk_account_rq(rq))
-		q->in_flight--;
+		elv_dec_inflight(q);
 
 	rq->flags &= ~REQ_STARTED;
 
@@ -283,14 +303,6 @@ void elv_requeue_request(request_queue_t
 	elv_deactivate_request(q, rq);
 
 	/*
-	 * if this is the flush, requeue the original instead and drop the flush
-	 */
-	if (rq->flags & REQ_BAR_FLUSH) {
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		rq = rq->end_io_data;
-	}
-
-	/*
 	 * the request is prepped and may have some resources allocated.
 	 * allowing unprepped requests to pass this one may cause resource
 	 * deadlock.  turn on softbarrier.
@@ -353,20 +365,10 @@ void elv_add_request(request_queue_t *q,
 
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
-	struct request *rq = q->elevator->ops->elevator_next_req_fn(q);
-
-	/*
-	 * if this is a barrier write and the device has to issue a
-	 * flush sequence to support it, check how far we are
-	 */
-	if (rq && blk_fs_request(rq) && blk_barrier_rq(rq)) {
-		BUG_ON(q->ordered == QUEUE_ORDERED_NONE);
-
-		if (q->ordered == QUEUE_ORDERED_FLUSH &&
-		    !blk_barrier_preflush(rq))
-			rq = blk_start_pre_flush(q, rq);
-	}
-
+	struct request *rq;
+	while ((rq = q->elevator->ops->elevator_next_req_fn(q)))
+		if (blk_do_barrier(q, &rq))
+			break;
 	return rq;
 }
 
@@ -433,7 +435,7 @@ void elv_remove_request(request_queue_t 
 	 * for request-request merges
 	 */
 	if (blk_account_rq(rq))
-		q->in_flight++;
+		elv_inc_inflight(q);
 
 	/*
 	 * the main clearing point for q->last_merge is on retrieval of
@@ -529,7 +531,7 @@ void elv_completed_request(request_queue
 	 * request is released from the driver, io must be done
 	 */
 	if (blk_account_rq(rq))
-		q->in_flight--;
+		elv_dec_inflight(q);
 
 	if (e->ops->elevator_completed_req_fn)
 		e->ops->elevator_completed_req_fn(q, rq);
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-05-29 13:20:30.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-05-29 13:20:31.000000000 +0900
@@ -347,165 +347,216 @@ EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 /*
  * Cache flushing for ordered writes handling
  */
-static void blk_pre_flush_end_io(struct request *flush_rq, int error)
+static void blk_finish_flush(request_queue_t *q, int error)
 {
-	struct request *rq = flush_rq->end_io_data;
-	request_queue_t *q = rq->q;
+	struct request *rq = q->bar_rq;
+	struct bio *bio = q->bar_bio;
 
-	rq->flags |= REQ_BAR_PREFLUSH;
+	q->flush_seq = QUEUE_FLUSH_NONE;
+	q->bar_rq = NULL;
+	q->bar_bio = NULL;
 
-	if (!flush_rq->errors)
-		elv_requeue_request(q, rq);
-	else {
-		q->end_flush_fn(q, flush_rq);
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		q->request_fn(q);
+	while (bio) {
+		bio_endio(bio, bio->bi_size, error);
+		bio = bio->bi_next;
 	}
+	end_that_request_last(rq, error ? error : 1);
+
+	q->request_fn(q);	/* is this necessary? - tj */
 }
 
-static void blk_post_flush_end_io(struct request *flush_rq, int error)
+static int blk_prep_flush(request_queue_t *q, struct request *flush_rq,
+			  struct gendisk *disk)
 {
-	struct request *rq = flush_rq->end_io_data;
-	request_queue_t *q = rq->q;
-
-	rq->flags |= REQ_BAR_POSTFLUSH;
+	rq_init(q, flush_rq);
+	flush_rq->flags = 0;
+	flush_rq->elevator_private = NULL;
+	flush_rq->rq_disk = disk;
+	flush_rq->rl = NULL;
 
-	q->end_flush_fn(q, flush_rq);
-	clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-	q->request_fn(q);
+	return q->prepare_flush_fn(q, flush_rq);
 }
 
-struct request *blk_start_pre_flush(request_queue_t *q, struct request *rq)
+static void blk_pre_flush_end_io(struct request *flush_rq, int error)
 {
-	struct request *flush_rq = q->flush_rq;
+	request_queue_t *q = flush_rq->q;
+	struct request *rq = q->bar_rq;
 
-	BUG_ON(!blk_barrier_rq(rq));
+	switch (error) {
+	case 0:
+		q->flush_seq = QUEUE_FLUSH_BAR;
+		elv_requeue_request(q, rq);
+		break;
 
-	if (test_and_set_bit(QUEUE_FLAG_FLUSH, &q->queue_flags))
-		return NULL;
+	case -EOPNOTSUPP:
+		blk_queue_ordered(q, QUEUE_ORDERED_NONE);
+		/* fall through */
+	default:
+		blk_finish_flush(q, error);
+		break;
+	}
+}
 
-	rq_init(q, flush_rq);
-	flush_rq->elevator_private = NULL;
-	flush_rq->flags = REQ_BAR_FLUSH;
-	flush_rq->rq_disk = rq->rq_disk;
-	flush_rq->rl = NULL;
+static void blk_post_flush_end_io(struct request *flush_rq, int error)
+{
+	blk_finish_flush(flush_rq->q, error);
+}
 
-	/*
-	 * prepare_flush returns 0 if no flush is needed, just mark both
-	 * pre and post flush as done in that case
-	 */
-	if (!q->prepare_flush_fn(q, flush_rq)) {
-		rq->flags |= REQ_BAR_PREFLUSH | REQ_BAR_POSTFLUSH;
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		return rq;
-	}
+struct request *blk_start_pre_flush(request_queue_t *q, struct request *rq)
+{
+	struct request *flush_rq = q->flush_rq;
 
 	/*
-	 * some drivers dequeue requests right away, some only after io
-	 * completion. make sure the request is dequeued.
+	 * prepare_flush returns 0 if no flush is needed, just perform
+	 * the original barrier request in that case.
 	 */
-	if (!list_empty(&rq->queuelist))
-		blkdev_dequeue_request(rq);
+	if (!blk_prep_flush(q, flush_rq, rq->rq_disk))
+		return rq;
 
-	elv_deactivate_request(q, rq);
+	blkdev_dequeue_request(rq);
+	q->bar_rq = rq;
+	q->bar_bio = rq->bio;
+	q->bi_size = 0;
+	q->flush_error = 0;
 
-	flush_rq->end_io_data = rq;
 	flush_rq->end_io = blk_pre_flush_end_io;
 
 	__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-	return flush_rq;
+
+	if (q->in_flight == 0) {
+		q->flush_seq = QUEUE_FLUSH_PRE;
+		return flush_rq;
+	} else {
+		q->flush_seq = QUEUE_FLUSH_DRAIN;
+		return NULL;
+	}
 }
 
-static void blk_start_post_flush(request_queue_t *q, struct request *rq)
+static void blk_start_post_flush(request_queue_t *q)
 {
 	struct request *flush_rq = q->flush_rq;
 
-	BUG_ON(!blk_barrier_rq(rq));
+	if (blk_prep_flush(q, flush_rq, q->bar_rq->rq_disk)) {
+		flush_rq->end_io = blk_post_flush_end_io;
+		q->flush_seq = QUEUE_FLUSH_POST;
+		__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
+		q->request_fn(q);	/* is this necessary? - tj */
+	} else
+		blk_finish_flush(q, 0);
+}
 
-	rq_init(q, flush_rq);
-	flush_rq->elevator_private = NULL;
-	flush_rq->flags = REQ_BAR_FLUSH;
-	flush_rq->rq_disk = rq->rq_disk;
-	flush_rq->rl = NULL;
+int blk_do_barrier(request_queue_t *q, struct request **rqp)
+{
+	struct request *rq = *rqp;
+	int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
 
-	if (q->prepare_flush_fn(q, flush_rq)) {
-		flush_rq->end_io_data = rq;
-		flush_rq->end_io = blk_post_flush_end_io;
+	switch (q->ordered) {
+	case QUEUE_ORDERED_NONE:
+		if (is_barrier) {
+			/*
+			 * This can happen when the queue switches to
+			 * ORDERED_NONE while this request is on it.
+			 */
+			end_that_request_first(rq, -EOPNOTSUPP,
+					       rq->hard_nr_sectors);
+			end_that_request_last(rq, -EOPNOTSUPP);
+			*rqp = NULL;
+			return 0;
+		}
+		return 1;
 
-		__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-		q->request_fn(q);
+	case QUEUE_ORDERED_FLUSH:
+		switch (q->flush_seq) {
+		case QUEUE_FLUSH_NONE:
+			if (is_barrier)
+				*rqp = blk_start_pre_flush(q, rq);
+			break;
+		case QUEUE_FLUSH_DRAIN:
+			*rqp = NULL;
+			break;
+		default:
+			/*
+			 * Don't allow any other requests while
+			 * flushing is in progress.
+			 */
+			if (rq != q->flush_rq && rq != q->bar_rq)
+				*rqp = NULL;
+			break;
+		}
+		return 1;
+
+	case QUEUE_ORDERED_TAG:
+		return 1;
+
+	default:
+		BUG();
+		return 1;
 	}
 }
 
-static inline int blk_check_end_barrier(request_queue_t *q, struct request *rq,
-					int sectors)
+static int flush_dry_bio_endio(struct bio *bio, unsigned int bytes, int error)
 {
-	if (sectors > rq->nr_sectors)
-		sectors = rq->nr_sectors;
+	request_queue_t *q = bio->bi_private;
+
+	/*
+	 * This is dry run, restore bio_sector and size.  We'll finish
+	 * this request again with the original bi_end_io after an
+	 * error occurs or post flush is complete.
+	 */
+	q->bi_size += bytes;
+
+	if (bio->bi_size)
+		return 1;
+
+	bio->bi_size = q->bi_size;
+	bio->bi_sector -= (q->bi_size >> 9);
+	q->bi_size = 0;
 
-	rq->nr_sectors -= sectors;
-	return rq->nr_sectors;
+	return 0;
 }
 
-static int __blk_complete_barrier_rq(request_queue_t *q, struct request *rq,
-				     int sectors, int queue_locked)
+static inline int blk_flush_bio_endio(struct request *rq, struct bio *bio,
+				      unsigned int nbytes, int error)
 {
-	if (q->ordered != QUEUE_ORDERED_FLUSH)
-		return 0;
-	if (!blk_fs_request(rq) || !blk_barrier_rq(rq))
-		return 0;
-	if (blk_barrier_postflush(rq))
+	request_queue_t *q = rq->q;
+	bio_end_io_t *endio;
+	void *private;
+
+	if (q->flush_seq != QUEUE_FLUSH_BAR || q->bar_rq != rq)
 		return 0;
 
-	if (!blk_check_end_barrier(q, rq, sectors)) {
-		unsigned long flags = 0;
+	/*
+	 * Okay, this is the barrier request in progress, dry finish it.
+	 */
+	if (error)
+		q->flush_error = error;
 
-		if (!queue_locked)
-			spin_lock_irqsave(q->queue_lock, flags);
+	endio = bio->bi_end_io;
+	private = bio->bi_private;
+	bio->bi_end_io = flush_dry_bio_endio;
+	bio->bi_private = q;
 
-		blk_start_post_flush(q, rq);
+	bio_endio(bio, nbytes, error);
 
-		if (!queue_locked)
-			spin_unlock_irqrestore(q->queue_lock, flags);
-	}
+	bio->bi_end_io = endio;
+	bio->bi_private = private;
 
 	return 1;
 }
 
-/**
- * blk_complete_barrier_rq - complete possible barrier request
- * @q:  the request queue for the device
- * @rq:  the request
- * @sectors:  number of sectors to complete
- *
- * Description:
- *   Used in driver end_io handling to determine whether to postpone
- *   completion of a barrier request until a post flush has been done. This
- *   is the unlocked variant, used if the caller doesn't already hold the
- *   queue lock.
- **/
-int blk_complete_barrier_rq(request_queue_t *q, struct request *rq, int sectors)
+static inline int blk_flush_end_request(struct request *rq)
 {
-	return __blk_complete_barrier_rq(q, rq, sectors, 0);
-}
-EXPORT_SYMBOL(blk_complete_barrier_rq);
+	request_queue_t *q = rq->q;
 
-/**
- * blk_complete_barrier_rq_locked - complete possible barrier request
- * @q:  the request queue for the device
- * @rq:  the request
- * @sectors:  number of sectors to complete
- *
- * Description:
- *   See blk_complete_barrier_rq(). This variant must be used if the caller
- *   holds the queue lock.
- **/
-int blk_complete_barrier_rq_locked(request_queue_t *q, struct request *rq,
-				   int sectors)
-{
-	return __blk_complete_barrier_rq(q, rq, sectors, 1);
+	if (q->flush_seq != QUEUE_FLUSH_BAR || q->bar_rq != rq)
+		return 0;
+
+	if (!q->flush_error)
+		blk_start_post_flush(q);
+	else
+		blk_finish_flush(q, q->flush_error);
+	return 1;
 }
-EXPORT_SYMBOL(blk_complete_barrier_rq_locked);
 
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
@@ -3029,7 +3080,8 @@ static int __end_that_request_first(stru
 		if (nr_bytes >= bio->bi_size) {
 			req->bio = bio->bi_next;
 			nbytes = bio->bi_size;
-			bio_endio(bio, nbytes, error);
+			if (!blk_flush_bio_endio(req, bio, nbytes, error))
+				bio_endio(bio, nbytes, error);
 			next_idx = 0;
 			bio_nbytes = 0;
 		} else {
@@ -3084,7 +3136,8 @@ static int __end_that_request_first(stru
 	 * if the request wasn't completed, update state
 	 */
 	if (bio_nbytes) {
-		bio_endio(bio, bio_nbytes, error);
+		if (!blk_flush_bio_endio(req, bio, bio_nbytes, error))
+			bio_endio(bio, bio_nbytes, error);
 		bio->bi_idx += next_idx;
 		bio_iovec(bio)->bv_offset += nr_bytes;
 		bio_iovec(bio)->bv_len -= nr_bytes;
@@ -3147,6 +3200,12 @@ void end_that_request_last(struct reques
 	int error;
 
 	/*
+	 * Are we finishing the barrier request?
+	 */
+	if (blk_flush_end_request(req))
+		return;
+
+	/*
 	 * extend uptodate bool to allow < 0 value to be direct io error
 	 */
 	error = 0;
Index: blk-fixes/drivers/ide/ide-disk.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-disk.c	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/drivers/ide/ide-disk.c	2005-05-29 13:20:31.000000000 +0900
@@ -681,44 +681,6 @@ static ide_proc_entry_t idedisk_proc[] =
 
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
 static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
@@ -1016,7 +978,6 @@ static void idedisk_setup (ide_drive_t *
 	if (barrier) {
 		blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
 		drive->queue->prepare_flush_fn = idedisk_prepare_flush;
-		drive->queue->end_flush_fn = idedisk_end_flush;
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
 	}
 }
Index: blk-fixes/drivers/ide/ide-io.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-io.c	2005-05-29 13:20:31.000000000 +0900
+++ blk-fixes/drivers/ide/ide-io.c	2005-05-29 13:20:31.000000000 +0900
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
Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-05-29 13:20:31.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-05-29 13:20:31.000000000 +0900
@@ -717,9 +717,6 @@ void scsi_io_completion(struct scsi_cmnd
 	int sense_valid = 0;
 	int sense_deferred = 0;
 
-	if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
-		return;
-
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
 	 * For the case of a READ, we need to copy the data out of the
@@ -999,23 +996,6 @@ static int scsi_prepare_flush_fn(request
 	return 0;
 }
 
-static void scsi_end_flush_fn(request_queue_t *q, struct request *rq)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct request *flush_rq = rq->end_io_data;
-	struct scsi_driver *drv;
-
-	if (flush_rq->errors) {
-		printk("scsi: barrier error, disabling flush support\n");
-		blk_queue_ordered(q, QUEUE_ORDERED_NONE);
-	}
-
-	if (sdev->sdev_state == SDEV_RUNNING) {
-		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
-		drv->end_flush(q, rq);
-	}
-}
-
 static int scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
 			       sector_t *error_sector)
 {
@@ -1451,7 +1431,6 @@ struct request_queue *scsi_alloc_queue(s
 	else if (shost->ordered_flush) {
 		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
 		q->prepare_flush_fn = scsi_prepare_flush_fn;
-		q->end_flush_fn = scsi_end_flush_fn;
 	}
 
 	if (!shost->use_clustering)
Index: blk-fixes/drivers/scsi/sd.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sd.c	2005-05-29 13:20:30.000000000 +0900
+++ blk-fixes/drivers/scsi/sd.c	2005-05-29 13:20:31.000000000 +0900
@@ -122,7 +122,6 @@ static void sd_shutdown(struct device *d
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
 static int sd_issue_flush(struct device *, sector_t *);
-static void sd_end_flush(request_queue_t *, struct request *);
 static int sd_prepare_flush(request_queue_t *, struct request *);
 static void sd_read_capacity(struct scsi_disk *sdkp, char *diskname,
 		 struct scsi_request *SRpnt, unsigned char *buffer);
@@ -139,7 +138,6 @@ static struct scsi_driver sd_template = 
 	.init_command		= sd_init_command,
 	.issue_flush		= sd_issue_flush,
 	.prepare_flush		= sd_prepare_flush,
-	.end_flush		= sd_end_flush,
 };
 
 /*
@@ -739,29 +737,6 @@ static int sd_issue_flush(struct device 
 	return sd_sync_cache(sdp);
 }
 
-static void sd_end_flush(request_queue_t *q, struct request *flush_rq)
-{
-	struct request *rq = flush_rq->end_io_data;
-	struct scsi_cmnd *cmd = rq->special;
-	unsigned int bytes = rq->hard_nr_sectors << 9;
-
-	if (!flush_rq->errors) {
-		spin_unlock(q->queue_lock);
-		scsi_io_completion(cmd, bytes, 0);
-		spin_lock(q->queue_lock);
-	} else if (blk_barrier_postflush(rq)) {
-		spin_unlock(q->queue_lock);
-		scsi_io_completion(cmd, 0, bytes);
-		spin_lock(q->queue_lock);
-	} else {
-		/*
-		 * force journal abort of barriers
-		 */
-		end_that_request_first(rq, -EOPNOTSUPP, rq->hard_nr_sectors);
-		end_that_request_last(rq, -EOPNOTSUPP);
-	}
-}
-
 static int sd_prepare_flush(request_queue_t *q, struct request *rq)
 {
 	struct scsi_device *sdev = q->queuedata;
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-05-29 13:20:30.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-05-29 13:20:31.000000000 +0900
@@ -227,9 +227,6 @@ enum rq_flag_bits {
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
-	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
-	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
-	__REQ_BAR_FLUSH,	/* rq is the flush request */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -255,9 +252,6 @@ enum rq_flag_bits {
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
-#define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
-#define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
-#define REQ_BAR_FLUSH	(1 << __REQ_BAR_FLUSH)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
@@ -288,7 +282,6 @@ typedef int (merge_bvec_fn) (request_que
 typedef void (activity_fn) (void *data, int rw);
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
 typedef int (prepare_flush_fn) (request_queue_t *, struct request *);
-typedef void (end_flush_fn) (request_queue_t *, struct request *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -329,7 +322,6 @@ struct request_queue
 	activity_fn		*activity_fn;
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
-	end_flush_fn		*end_flush_fn;
 
 	/*
 	 * Auto-unplugging state
@@ -409,7 +401,11 @@ struct request_queue
 	/*
 	 * reserved for flush operations
 	 */
-	struct request		*flush_rq;
+	int			flush_seq;	/* QUEUE_FLUSH_* */
+	int			flush_error;
+	struct request		*flush_rq, *bar_rq;
+	struct bio		*bar_bio;
+	unsigned int		bi_size;
 	unsigned char		ordered;
 };
 
@@ -434,12 +430,17 @@ enum {
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_DRAIN	8	/* draining queue for sched switch */
-#define QUEUE_FLAG_FLUSH	9	/* doing barrier flush sequence */
+
+#define QUEUE_FLUSH_NONE	0	/* flushing isn't in progress */
+#define QUEUE_FLUSH_DRAIN	1	/* waiting for the queue to be drained */
+#define QUEUE_FLUSH_PRE		2	/* pre-flushing in progress */
+#define QUEUE_FLUSH_BAR		3	/* original barrier req in progress */
+#define QUEUE_FLUSH_POST	4	/* post-flushing in progress */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
-#define blk_queue_flushing(q)	test_bit(QUEUE_FLAG_FLUSH, &(q)->queue_flags)
+#define blk_queue_flushing(q)	((q)->flush_seq != QUEUE_FLUSH_NONE)
 
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
@@ -454,8 +455,6 @@ enum {
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
 #define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
-#define blk_barrier_preflush(rq)	((rq)->flags & REQ_BAR_PREFLUSH)
-#define blk_barrier_postflush(rq)	((rq)->flags & REQ_BAR_POSTFLUSH)
 
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
@@ -638,9 +637,7 @@ extern void blk_queue_dma_alignment(requ
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 extern void blk_queue_ordered(request_queue_t *, int);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);
-extern struct request *blk_start_pre_flush(request_queue_t *,struct request *);
-extern int blk_complete_barrier_rq(request_queue_t *, struct request *, int);
-extern int blk_complete_barrier_rq_locked(request_queue_t *, struct request *, int);
+extern int blk_do_barrier(request_queue_t *, struct request **);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
Index: blk-fixes/include/scsi/scsi_driver.h
===================================================================
--- blk-fixes.orig/include/scsi/scsi_driver.h	2005-05-29 13:20:29.000000000 +0900
+++ blk-fixes/include/scsi/scsi_driver.h	2005-05-29 13:20:31.000000000 +0900
@@ -15,7 +15,6 @@ struct scsi_driver {
 	void (*rescan)(struct device *);
 	int (*issue_flush)(struct device *, sector_t *);
 	int (*prepare_flush)(struct request_queue *, struct request *);
-	void (*end_flush)(struct request_queue *, struct request *);
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)

