Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVGZQza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVGZQza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVGZPrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:47 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:920 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261867AbVGZPqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=kSWNrrYBltARPipA6fumd8R5Y39510ZxEcG2OT4IbcUbc3SZdoTE1kmDm8Y8zQMtKVRIljeWjzYLwM5J7dadTCt3sllgeuJ98iWYqpUFtQ//VDo8k545N4Ps9sAyTbEUE+t+5tANSkgrKGCyL8nzg+PmTYeyv2TzSx+bG7tcyjE=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 03/10] blk: reimplement handling of barrier request
Message-ID: <20050726154457.CAED1A68@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:06 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_blk_reimplement-ordered.patch

	 Reimplement handling of barrier requests.

        * Flexible handling to deal with various capabilities of
          target devices.
	* Retry support for falling back.
	* Tagged queues which don't support ordered tag can do ordered.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/elevator.c  |   83 +++++---
 drivers/block/ll_rw_blk.c |  468 ++++++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h    |   83 +++++---
 include/linux/elevator.h  |    1 
 4 files changed, 443 insertions(+), 192 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-07-27 00:44:50.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-07-27 00:44:51.000000000 +0900
@@ -326,22 +326,24 @@ void elv_requeue_request(request_queue_t
 
 	rq->flags &= ~REQ_STARTED;
 
-	/*
-	 * if this is the flush, requeue the original instead and drop the flush
-	 */
-	if (rq->flags & REQ_BAR_FLUSH) {
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		rq = rq->end_io_data;
-	}
-
-	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	__elv_add_request(q, rq, ELEVATOR_INSERT_REQUEUE, 0);
 }
 
 void __elv_add_request(request_queue_t *q, struct request *rq, int where,
 		       int plug)
 {
+	struct list_head *pos;
+	unsigned ordseq;
+
+	rq->flags |= q->ordcolor ? REQ_ORDERED_COLOR : 0;
+
 	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)) {
 		/*
+		 * toggle ordered color
+		 */
+		q->ordcolor ^= 1;
+
+		/*
 		 * barriers implicitly indicate back insertion
 		 */
 		if (where == ELEVATOR_INSERT_SORT)
@@ -397,6 +399,30 @@ void __elv_add_request(request_queue_t *
 			q->last_merge = rq;
 		break;
 
+	case ELEVATOR_INSERT_REQUEUE:
+		/*
+		 * If ordered flush isn't in progress, we do front
+		 * insertion; otherwise, requests should be requeued
+		 * in ordseq order.
+		 */
+		rq->flags |= REQ_SOFTBARRIER;
+
+		if (q->ordseq == 0) {
+			list_add(&rq->queuelist, &q->queue_head);
+			break;
+		}
+
+		ordseq = blk_ordered_req_seq(rq);
+
+		list_for_each(pos, &q->queue_head) {
+			struct request *pos_rq = list_entry_rq(pos);
+			if (ordseq <= blk_ordered_req_seq(pos_rq))
+				break;
+		}
+
+		list_add_tail(&rq->queuelist, pos);
+		break;
+
 	default:
 		printk(KERN_ERR "%s: bad insertion point %d\n",
 		       __FUNCTION__, where);
@@ -426,25 +452,16 @@ static inline struct request *__elv_next
 {
 	struct request *rq;
 
-	if (unlikely(list_empty(&q->queue_head) &&
-		     !q->elevator->ops->elevator_dispatch_fn(q, 0)))
-		return NULL;
-
-	rq = list_entry_rq(q->queue_head.next);
-
-	/*
-	 * if this is a barrier write and the device has to issue a
-	 * flush sequence to support it, check how far we are
-	 */
-	if (blk_fs_request(rq) && blk_barrier_rq(rq)) {
-		BUG_ON(q->ordered == QUEUE_ORDERED_NONE);
+	while (1) {
+		while (!list_empty(&q->queue_head)) {
+			rq = list_entry_rq(q->queue_head.next);
+			if (blk_do_ordered(q, &rq))
+				return rq;
+		}
 
-		if (q->ordered == QUEUE_ORDERED_FLUSH &&
-		    !blk_barrier_preflush(rq))
-			rq = blk_start_pre_flush(q, rq);
+		if (!q->elevator->ops->elevator_dispatch_fn(q, 0))
+			return NULL;
 	}
-
-	return rq;
 }
 
 struct request *elv_next_request(request_queue_t *q)
@@ -610,7 +627,21 @@ void elv_completed_request(request_queue
 	 * request is released from the driver, io must be done
 	 */
 	if (blk_account_rq(rq)) {
+		struct request *first_rq = list_entry_rq(q->queue_head.next);
+
 		q->in_flight--;
+
+		/*
+		 * Check if the queue is waiting for fs requests to be
+		 * drained for flush sequence.
+		 */
+		if (q->ordseq && q->in_flight == 0 &&
+		    blk_ordered_cur_seq(q) == QUEUE_ORDSEQ_DRAIN &&
+		    blk_ordered_req_seq(first_rq) > QUEUE_ORDSEQ_DRAIN) {
+			blk_ordered_complete_seq(q, QUEUE_ORDSEQ_DRAIN, 0);
+			q->request_fn(q);
+		}
+
 		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
 			e->ops->elevator_completed_req_fn(q, rq);
 	}
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-07-27 00:44:50.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-07-27 00:44:51.000000000 +0900
@@ -286,10 +286,104 @@ static inline void rq_init(request_queue
 	rq->end_io_data = NULL;
 }
 
+static int __blk_queue_ordered(request_queue_t *q, int ordered,
+			       prepare_flush_fn *prepare_flush_fn,
+			       unsigned gfp_mask, int locked)
+{
+	void *rq0 = NULL, *rq1 = NULL, *rq2 = NULL;
+	unsigned long flags = 0; /* shut up, gcc */
+	int ret = 0;
+
+	might_sleep_if(gfp_mask & __GFP_WAIT);
+
+	if (ordered & (QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_POSTFLUSH) &&
+	    prepare_flush_fn == NULL) {
+		printk(KERN_ERR "blk_queue_ordered: prepare_flush_fn required\n");
+		ret = -EINVAL;
+		goto out_unlocked;
+	}
+
+	if (!locked)
+		spin_lock_irqsave(q->queue_lock, flags);
+
+	if (q->ordseq) {
+		/* Queue flushing in progress. */
+		ret = -EINPROGRESS;
+		goto out;
+	}
+
+	switch (ordered) {
+	case QUEUE_ORDERED_NONE:
+		if (!q->pre_flush_rq) {
+			rq0 = q->pre_flush_rq;
+			rq1 = q->bar_rq;
+			rq2 = q->post_flush_rq;
+			q->pre_flush_rq = NULL;
+			q->bar_rq = NULL;
+			q->post_flush_rq = NULL;
+		}
+		break;
+
+	case QUEUE_ORDERED_DRAIN:
+	case QUEUE_ORDERED_DRAIN_FLUSH:
+	case QUEUE_ORDERED_DRAIN_FUA:
+	case QUEUE_ORDERED_TAG:
+	case QUEUE_ORDERED_TAG_FLUSH:
+	case QUEUE_ORDERED_TAG_FUA:
+		if (q->pre_flush_rq)
+			break;
+
+		if (!locked)
+			spin_unlock_irqrestore(q->queue_lock, flags);
+		if (!(rq0 = kmem_cache_alloc(request_cachep, gfp_mask)) ||
+		    !(rq1 = kmem_cache_alloc(request_cachep, gfp_mask)) ||
+		    !(rq2 = kmem_cache_alloc(request_cachep, gfp_mask))) {
+			printk(KERN_ERR "blk_queue_ordered: failed to "
+			       "switch to 0x%x (out of memory)\n", ordered);
+			ret = -ENOMEM;
+			goto out_unlocked;
+		}
+		if (!locked)
+			spin_lock_irqsave(q->queue_lock, flags);
+
+		if (!q->pre_flush_rq) {
+			q->pre_flush_rq = rq0;
+			q->bar_rq = rq1;
+			q->post_flush_rq = rq2;
+			rq0 = NULL;
+			rq1 = NULL;
+			rq2 = NULL;
+		}
+		break;
+
+	default:
+		printk(KERN_ERR "blk_queue_ordered: bad value %d\n", ordered);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	q->ordered = ordered;
+	q->prepare_flush_fn = prepare_flush_fn;
+
+ out:
+	if (!locked)
+		spin_unlock_irqrestore(q->queue_lock, flags);
+ out_unlocked:
+	if (rq0)
+		kmem_cache_free(request_cachep, rq0);
+	if (rq1)
+		kmem_cache_free(request_cachep, rq1);
+	if (rq2)
+		kmem_cache_free(request_cachep, rq2);
+
+	return ret;
+}
+
 /**
  * blk_queue_ordered - does this queue support ordered writes
- * @q:     the request queue
- * @flag:  see below
+ * @q:        the request queue
+ * @ordered:  one of QUEUE_ORDERED_*
+ * @gfp_mask: allocation mask
  *
  * Description:
  *   For journalled file systems, doing ordered writes on a commit
@@ -298,32 +392,24 @@ static inline void rq_init(request_queue
  *   feature should call this function and indicate so.
  *
  **/
-void blk_queue_ordered(request_queue_t *q, int flag)
+extern int blk_queue_ordered(request_queue_t *q, unsigned ordered,
+			     prepare_flush_fn *prepare_flush_fn,
+			     unsigned gfp_mask)
 {
-	switch (flag) {
-		case QUEUE_ORDERED_NONE:
-			if (q->flush_rq)
-				kmem_cache_free(request_cachep, q->flush_rq);
-			q->flush_rq = NULL;
-			q->ordered = flag;
-			break;
-		case QUEUE_ORDERED_TAG:
-			q->ordered = flag;
-			break;
-		case QUEUE_ORDERED_FLUSH:
-			q->ordered = flag;
-			if (!q->flush_rq)
-				q->flush_rq = kmem_cache_alloc(request_cachep,
-								GFP_KERNEL);
-			break;
-		default:
-			printk("blk_queue_ordered: bad value %d\n", flag);
-			break;
-	}
+	return __blk_queue_ordered(q, ordered, prepare_flush_fn, gfp_mask, 0);
 }
 
 EXPORT_SYMBOL(blk_queue_ordered);
 
+extern int blk_queue_ordered_locked(request_queue_t *q, unsigned ordered,
+				    prepare_flush_fn *prepare_flush_fn,
+				    unsigned gfp_mask)
+{
+	return __blk_queue_ordered(q, ordered, prepare_flush_fn, gfp_mask, 1);
+}
+
+EXPORT_SYMBOL(blk_queue_ordered_locked);
+
 /**
  * blk_queue_issue_flush_fn - set function for issuing a flush
  * @q:     the request queue
@@ -344,167 +430,263 @@ EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 /*
  * Cache flushing for ordered writes handling
  */
-static void blk_pre_flush_end_io(struct request *flush_rq, int error)
+inline unsigned blk_ordered_cur_seq(request_queue_t *q)
 {
-	struct request *rq = flush_rq->end_io_data;
-	request_queue_t *q = rq->q;
-
-	elv_completed_request(q, flush_rq);
-
-	rq->flags |= REQ_BAR_PREFLUSH;
-
-	if (!flush_rq->errors)
-		elv_requeue_request(q, rq);
-	else {
-		q->end_flush_fn(q, flush_rq);
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		q->request_fn(q);
-	}
+	if (!q->ordseq)
+		return 0;
+	return 1 << ffz(q->ordseq);
 }
 
-static void blk_post_flush_end_io(struct request *flush_rq, int error)
+unsigned blk_ordered_req_seq(struct request *rq)
 {
-	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
 
-	elv_completed_request(q, flush_rq);
-
-	rq->flags |= REQ_BAR_POSTFLUSH;
+	BUG_ON(q->ordseq == 0);
 
-	q->end_flush_fn(q, flush_rq);
-	clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-	q->request_fn(q);
+	if (rq == q->pre_flush_rq)
+		return QUEUE_ORDSEQ_PREFLUSH;
+	if (rq == q->bar_rq)
+		return QUEUE_ORDSEQ_BAR;
+	if (rq == q->post_flush_rq)
+		return QUEUE_ORDSEQ_POSTFLUSH;
+
+	if ((rq->flags & REQ_ORDERED_COLOR) ==
+	    (q->orig_bar_rq->flags & REQ_ORDERED_COLOR))
+		return QUEUE_ORDSEQ_DRAIN;
+	else
+		return QUEUE_ORDSEQ_DONE;
 }
 
-struct request *blk_start_pre_flush(request_queue_t *q, struct request *rq)
+void blk_ordered_complete_seq(request_queue_t *q, unsigned seq, int error)
 {
-	struct request *flush_rq = q->flush_rq;
-
-	BUG_ON(!blk_barrier_rq(rq));
+	struct request *rq;
+	int uptodate;
 
-	if (test_and_set_bit(QUEUE_FLAG_FLUSH, &q->queue_flags))
-		return NULL;
+	if (error && !q->orderr)
+		q->orderr = error;
 
-	rq_init(q, flush_rq);
-	flush_rq->elevator_private = NULL;
-	flush_rq->flags = REQ_BAR_FLUSH;
-	flush_rq->rq_disk = rq->rq_disk;
-	flush_rq->rl = NULL;
+	BUG_ON(q->ordseq & seq);
+	q->ordseq |= seq;
 
-	/*
-	 * prepare_flush returns 0 if no flush is needed, just mark both
-	 * pre and post flush as done in that case
-	 */
-	if (!q->prepare_flush_fn(q, flush_rq)) {
-		rq->flags |= REQ_BAR_PREFLUSH | REQ_BAR_POSTFLUSH;
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		return rq;
-	}
+	if (blk_ordered_cur_seq(q) != QUEUE_ORDSEQ_DONE)
+		return;
 
 	/*
-	 * some drivers dequeue requests right away, some only after io
-	 * completion. make sure the request is dequeued.
+	 * Okay, sequence complete.
 	 */
-	if (!list_empty(&rq->queuelist))
-		blkdev_dequeue_request(rq);
+	rq = q->orig_bar_rq;
+	uptodate = q->orderr ? q->orderr : 1;
 
-	flush_rq->end_io_data = rq;
-	flush_rq->end_io = blk_pre_flush_end_io;
+	q->ordseq = 0;
 
-	__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-	return flush_rq;
+	end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
+	end_that_request_last(rq, uptodate);
 }
 
-static void blk_start_post_flush(request_queue_t *q, struct request *rq)
+static void pre_flush_end_io(struct request *rq, int error)
 {
-	struct request *flush_rq = q->flush_rq;
+	elv_completed_request(rq->q, rq);
+	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_PREFLUSH, error);
+}
 
-	BUG_ON(!blk_barrier_rq(rq));
+static void bar_end_io(struct request *rq, int error)
+{
+	elv_completed_request(rq->q, rq);
+	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_BAR, error);
+}
 
-	rq_init(q, flush_rq);
-	flush_rq->elevator_private = NULL;
-	flush_rq->flags = REQ_BAR_FLUSH;
-	flush_rq->rq_disk = rq->rq_disk;
-	flush_rq->rl = NULL;
+static void post_flush_end_io(struct request *rq, int error)
+{
+	elv_completed_request(rq->q, rq);
+	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_POSTFLUSH, error);
+}
 
-	if (q->prepare_flush_fn(q, flush_rq)) {
-		flush_rq->end_io_data = rq;
-		flush_rq->end_io = blk_post_flush_end_io;
+static void queue_flush(request_queue_t *q, unsigned which)
+{
+	struct request *rq;
+	rq_end_io_fn *end_io;
 
-		__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-		q->request_fn(q);
+	if (which == QUEUE_ORDERED_PREFLUSH) {
+		rq = q->pre_flush_rq;
+		end_io = pre_flush_end_io;
+	} else {
+		rq = q->post_flush_rq;
+		end_io = post_flush_end_io;
 	}
+
+	rq_init(q, rq);
+	rq->flags = REQ_HARDBARRIER;
+	rq->elevator_private = NULL;
+	rq->rq_disk = q->bar_rq->rq_disk;
+	rq->rl = NULL;
+	rq->end_io = end_io;
+	q->prepare_flush_fn(q, rq);
+
+	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 }
 
-static inline int blk_check_end_barrier(request_queue_t *q, struct request *rq,
-					int sectors)
+static inline struct request *start_ordered(request_queue_t *q,
+					    struct request *rq)
 {
-	if (sectors > rq->nr_sectors)
-		sectors = rq->nr_sectors;
+	q->bi_size = 0;
+	q->orderr = 0;
+	q->ordseq |= QUEUE_ORDSEQ_STARTED;
+
+	/*
+	 * Prep proxy barrier request.
+	 */
+	blkdev_dequeue_request(rq);
+	q->orig_bar_rq = rq;
+	rq = q->bar_rq;
+	rq_init(q, rq);
+	rq->flags = bio_data_dir(q->orig_bar_rq->bio);
+	rq->flags |= q->ordered & QUEUE_ORDERED_FUA ? REQ_FUA : 0;
+	rq->elevator_private = NULL;
+	rq->rl = NULL;
+	init_request_from_bio(rq, q->orig_bar_rq->bio);
+	rq->end_io = bar_end_io;
 
-	rq->nr_sectors -= sectors;
-	return rq->nr_sectors;
+	/*
+	 * Queue ordered sequence.  As we stack them at the head, we
+	 * need to queue in reverse order.  Note that we rely on that
+	 * no fs request uses ELEVATOR_INSERT_FRONT and thus no fs
+	 * request gets inbetween ordered sequence.
+	 */
+	if (q->ordered & QUEUE_ORDERED_POSTFLUSH)
+		queue_flush(q, QUEUE_ORDERED_POSTFLUSH);
+	else
+		q->ordseq |= QUEUE_ORDSEQ_POSTFLUSH;
+
+	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+
+	if (q->ordered & QUEUE_ORDERED_PREFLUSH) {
+		queue_flush(q, QUEUE_ORDERED_PREFLUSH);
+		rq = q->pre_flush_rq;
+	} else
+		q->ordseq |= QUEUE_ORDSEQ_PREFLUSH;
+
+	if ((q->ordered & QUEUE_ORDERED_TAG) || q->in_flight == 0)
+		q->ordseq |= QUEUE_ORDSEQ_DRAIN;
+	else
+		rq = NULL;
+
+	return rq;
 }
 
-static int __blk_complete_barrier_rq(request_queue_t *q, struct request *rq,
-				     int sectors, int queue_locked)
+int blk_do_ordered(request_queue_t *q, struct request **rqp)
 {
-	if (q->ordered != QUEUE_ORDERED_FLUSH)
-		return 0;
-	if (!blk_fs_request(rq) || !blk_barrier_rq(rq))
-		return 0;
-	if (blk_barrier_postflush(rq))
-		return 0;
-
-	if (!blk_check_end_barrier(q, rq, sectors)) {
-		unsigned long flags = 0;
+	struct request *rq = *rqp, *allowed_rq;
+	int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
 
-		if (!queue_locked)
-			spin_lock_irqsave(q->queue_lock, flags);
+	if (!q->ordseq) {
+		if (!is_barrier)
+			return 1;
 
-		blk_start_post_flush(q, rq);
+		if (q->ordered != QUEUE_ORDERED_NONE) {
+			*rqp = start_ordered(q, rq);
+			return 1;
+		} else {
+			/*
+			 * This can happen when the queue switches to
+			 * ORDERED_NONE while this request is on it.
+			 */
+			blkdev_dequeue_request(rq);
+			end_that_request_first(rq, -EOPNOTSUPP,
+					       rq->hard_nr_sectors);
+			end_that_request_last(rq, -EOPNOTSUPP);
+			*rqp = NULL;
+			return 0;
+		}
+	}
 
-		if (!queue_locked)
-			spin_unlock_irqrestore(q->queue_lock, flags);
+	if (q->ordered & QUEUE_ORDERED_TAG) {
+		if (is_barrier && rq != q->bar_rq)
+			*rqp = NULL;
+		return 1;
 	}
 
+	switch (blk_ordered_cur_seq(q)) {
+	case QUEUE_ORDSEQ_PREFLUSH:
+		allowed_rq = q->pre_flush_rq;
+		break;
+	case QUEUE_ORDSEQ_BAR:
+		allowed_rq = q->bar_rq;
+		break;
+	case QUEUE_ORDSEQ_POSTFLUSH:
+		allowed_rq = q->post_flush_rq;
+		break;
+	default:
+		allowed_rq = NULL;
+		break;
+	}
+
+	if (rq != allowed_rq && (blk_fs_request(rq) || rq == q->pre_flush_rq ||
+				 rq == q->post_flush_rq))
+		*rqp = NULL;
+
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
+static int flush_dry_bio_endio(struct bio *bio, unsigned int bytes, int error)
 {
-	return __blk_complete_barrier_rq(q, rq, sectors, 0);
+	request_queue_t *q = bio->bi_private;
+	struct bio_vec *bvec;
+	int i;
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
+	/* Rewind bvec's */
+	bio->bi_idx = 0;
+	bio_for_each_segment(bvec, bio, i) {
+		bvec->bv_len += bvec->bv_offset;
+		bvec->bv_offset = 0;
+	}
+
+	/* Reset bio */
+	set_bit(BIO_UPTODATE, &bio->bi_flags);
+	bio->bi_size = q->bi_size;
+	bio->bi_sector -= (q->bi_size >> 9);
+	q->bi_size = 0;
+
+	return 0;
 }
-EXPORT_SYMBOL(blk_complete_barrier_rq);
 
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
+static inline int ordered_bio_endio(struct request *rq, struct bio *bio,
+				    unsigned int nbytes, int error)
 {
-	return __blk_complete_barrier_rq(q, rq, sectors, 1);
+	request_queue_t *q = rq->q;
+	bio_end_io_t *endio;
+	void *private;
+
+	if (q->bar_rq != rq)
+		return 0;
+
+	/*
+	 * Okay, this is the barrier request in progress, dry finish it.
+	 */
+	if (error && !q->orderr)
+		q->orderr = error;
+
+	endio = bio->bi_end_io;
+	private = bio->bi_private;
+	bio->bi_end_io = flush_dry_bio_endio;
+	bio->bi_private = q;
+
+	bio_endio(bio, nbytes, error);
+
+	bio->bi_end_io = endio;
+	bio->bi_private = private;
+
+	return 1;
 }
-EXPORT_SYMBOL(blk_complete_barrier_rq_locked);
 
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
@@ -1041,6 +1223,7 @@ static char *rq_flags[] = {
 	"REQ_SORTED",
 	"REQ_SOFTBARRIER",
 	"REQ_HARDBARRIER",
+	"REQ_FUA",
 	"REQ_CMD",
 	"REQ_NOMERGE",
 	"REQ_STARTED",
@@ -1060,6 +1243,7 @@ static char *rq_flags[] = {
 	"REQ_PM_SUSPEND",
 	"REQ_PM_RESUME",
 	"REQ_PM_SHUTDOWN",
+	"REQ_ORDERED_COLOR",
 };
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
@@ -1632,7 +1816,7 @@ void blk_cleanup_queue(request_queue_t *
 	if (q->queue_tags)
 		__blk_queue_free_tags(q);
 
-	blk_queue_ordered(q, QUEUE_ORDERED_NONE);
+	blk_queue_ordered(q, QUEUE_ORDERED_NONE, NULL, 0);
 
 	kmem_cache_free(requestq_cachep, q);
 }
@@ -2997,7 +3181,8 @@ static int __end_that_request_first(stru
 		if (nr_bytes >= bio->bi_size) {
 			req->bio = bio->bi_next;
 			nbytes = bio->bi_size;
-			bio_endio(bio, nbytes, error);
+			if (!ordered_bio_endio(req, bio, nbytes, error))
+				bio_endio(bio, nbytes, error);
 			next_idx = 0;
 			bio_nbytes = 0;
 		} else {
@@ -3052,7 +3237,8 @@ static int __end_that_request_first(stru
 	 * if the request wasn't completed, update state
 	 */
 	if (bio_nbytes) {
-		bio_endio(bio, bio_nbytes, error);
+		if (!ordered_bio_endio(req, bio, bio_nbytes, error))
+			bio_endio(bio, bio_nbytes, error);
 		bio->bi_idx += next_idx;
 		bio_iovec(bio)->bv_offset += nr_bytes;
 		bio_iovec(bio)->bv_len -= nr_bytes;
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-07-27 00:44:50.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-07-27 00:44:51.000000000 +0900
@@ -196,6 +196,7 @@ enum rq_flag_bits {
 	__REQ_SORTED,		/* elevator knows about this request */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
 	__REQ_HARDBARRIER,	/* may not be passed by drive either */
+	__REQ_FUA,		/* forced unit access */
 	__REQ_CMD,		/* is a regular fs rw request */
 	__REQ_NOMERGE,		/* don't touch this for merging */
 	__REQ_STARTED,		/* drive already may have started this one */
@@ -219,9 +220,7 @@ enum rq_flag_bits {
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
-	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
-	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
-	__REQ_BAR_FLUSH,	/* rq is the flush request */
+	__REQ_ORDERED_COLOR,	/* is before or after barrier */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -230,6 +229,7 @@ enum rq_flag_bits {
 #define REQ_SORTED	(1 << __REQ_SORTED)
 #define REQ_SOFTBARRIER	(1 << __REQ_SOFTBARRIER)
 #define REQ_HARDBARRIER	(1 << __REQ_HARDBARRIER)
+#define REQ_FUA		(1 << __REQ_FUA)
 #define REQ_CMD		(1 << __REQ_CMD)
 #define REQ_NOMERGE	(1 << __REQ_NOMERGE)
 #define REQ_STARTED	(1 << __REQ_STARTED)
@@ -249,9 +249,7 @@ enum rq_flag_bits {
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
-#define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
-#define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
-#define REQ_BAR_FLUSH	(1 << __REQ_BAR_FLUSH)
+#define REQ_ORDERED_COLOR	(1 << __REQ_ORDERED_COLOR)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
@@ -281,8 +279,7 @@ struct bio_vec;
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
 typedef void (activity_fn) (void *data, int rw);
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
-typedef int (prepare_flush_fn) (request_queue_t *, struct request *);
-typedef void (end_flush_fn) (request_queue_t *, struct request *);
+typedef void (prepare_flush_fn) (request_queue_t *, struct request *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -327,7 +324,6 @@ struct request_queue
 	activity_fn		*activity_fn;
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
-	end_flush_fn		*end_flush_fn;
 
 	/*
 	 * Dispatch queue sorting
@@ -411,14 +407,11 @@ struct request_queue
 	/*
 	 * reserved for flush operations
 	 */
-	struct request		*flush_rq;
-	unsigned char		ordered;
-};
-
-enum {
-	QUEUE_ORDERED_NONE,
-	QUEUE_ORDERED_TAG,
-	QUEUE_ORDERED_FLUSH,
+	unsigned int		ordered, ordseq;
+	int			orderr, ordcolor;
+	struct request		*pre_flush_rq, *bar_rq, *post_flush_rq;
+	struct request		*orig_bar_rq;
+	unsigned int		bi_size;
 };
 
 #define RQ_INACTIVE		(-1)
@@ -436,12 +429,51 @@ enum {
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_BYPASS	8	/* don't use elevator, just do FIFO */
-#define QUEUE_FLAG_FLUSH	9	/* doing barrier flush sequence */
+
+enum {
+	/*
+	 * Hardbarrier is supported with one of the following methods.
+	 *
+	 * NONE		: hardbarrier unsupported
+	 * DRAIN	: ordering by draining is enough
+	 * DRAIN_FLUSH	: ordering by draining w/ pre and post flushes
+	 * DRAIN_FUA	: ordering by draining w/ pre flush and FUA write
+	 * TAG		: ordering by tag is enough
+	 * TAG_FLUSH	: ordering by tag w/ pre and post flushes
+	 * TAG_FUA	: ordering by tag w/ pre flush and FUA write
+	 */
+	QUEUE_ORDERED_NONE	= 0x00,
+	QUEUE_ORDERED_DRAIN	= 0x01,
+	QUEUE_ORDERED_TAG	= 0x02,
+
+	QUEUE_ORDERED_PREFLUSH	= 0x10,
+	QUEUE_ORDERED_POSTFLUSH	= 0x20,
+	QUEUE_ORDERED_FUA	= 0x40,
+
+	QUEUE_ORDERED_DRAIN_FLUSH = QUEUE_ORDERED_DRAIN |
+			QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_POSTFLUSH,
+	QUEUE_ORDERED_DRAIN_FUA	= QUEUE_ORDERED_DRAIN |
+			QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_FUA,
+	QUEUE_ORDERED_TAG_FLUSH	= QUEUE_ORDERED_TAG |
+			QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_POSTFLUSH,
+	QUEUE_ORDERED_TAG_FUA	= QUEUE_ORDERED_TAG |
+			QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_FUA,
+
+	/*
+	 * Ordered operation sequence
+	 */
+	QUEUE_ORDSEQ_STARTED	= 0x01,	/* flushing in progress */
+	QUEUE_ORDSEQ_DRAIN	= 0x02,	/* waiting for the queue to be drained */
+	QUEUE_ORDSEQ_PREFLUSH	= 0x04,	/* pre-flushing in progress */
+	QUEUE_ORDSEQ_BAR	= 0x08,	/* original barrier req in progress */
+	QUEUE_ORDSEQ_POSTFLUSH	= 0x10,	/* post-flushing in progress */
+	QUEUE_ORDSEQ_DONE	= 0x20,
+};
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
-#define blk_queue_flushing(q)	test_bit(QUEUE_FLAG_FLUSH, &(q)->queue_flags)
+#define blk_queue_flushing(q)	((q)->ordseq)
 
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
@@ -457,8 +489,7 @@ enum {
 
 #define blk_sorted_rq(rq)	((rq)->flags & REQ_SORTED)
 #define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
-#define blk_barrier_preflush(rq)	((rq)->flags & REQ_BAR_PREFLUSH)
-#define blk_barrier_postflush(rq)	((rq)->flags & REQ_BAR_POSTFLUSH)
+#define blk_fua_rq(rq)		((rq)->flags & REQ_FUA)
 
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
@@ -635,12 +666,14 @@ extern void blk_queue_prep_rq(request_qu
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
-extern void blk_queue_ordered(request_queue_t *, int);
+extern int blk_queue_ordered(request_queue_t *, unsigned, prepare_flush_fn *, unsigned);
+extern int blk_queue_ordered_locked(request_queue_t *, unsigned, prepare_flush_fn *, unsigned);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);
 extern int blkdev_scsi_issue_flush_fn(request_queue_t *, struct gendisk *, sector_t *);
-extern struct request *blk_start_pre_flush(request_queue_t *,struct request *);
-extern int blk_complete_barrier_rq(request_queue_t *, struct request *, int);
-extern int blk_complete_barrier_rq_locked(request_queue_t *, struct request *, int);
+extern int blk_do_ordered(request_queue_t *, struct request **);
+extern unsigned blk_ordered_cur_seq(request_queue_t *);
+extern unsigned blk_ordered_req_seq(struct request *);
+extern void blk_ordered_complete_seq(request_queue_t *, unsigned, int);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
Index: blk-fixes/include/linux/elevator.h
===================================================================
--- blk-fixes.orig/include/linux/elevator.h	2005-07-27 00:44:49.000000000 +0900
+++ blk-fixes/include/linux/elevator.h	2005-07-27 00:44:51.000000000 +0900
@@ -130,6 +130,7 @@ extern int elv_try_last_merge(request_qu
 #define ELEVATOR_INSERT_FRONT	1
 #define ELEVATOR_INSERT_BACK	2
 #define ELEVATOR_INSERT_SORT	3
+#define ELEVATOR_INSERT_REQUEUE	4
 
 /*
  * return values from elevator_may_queue_fn

