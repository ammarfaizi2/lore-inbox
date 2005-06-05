Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVFEGHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVFEGHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVFEGHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:07:15 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:32244 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261466AbVFEF5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=fnbc3gOzNfftFzAMN54JBpBuW9CpqTX/nV80peBkNcLlGB9YaEDHWq71iO2noIEj1ca6vQq9H0iU+3aKsjdjdhkiHksLNZ4jcQ2XVHOYYeuG6po4mgFtnRbKYHJcjgvQ7T8icJU76ljX4KgKbBhUoCJPKRZuCD3vOHXHaPsMocg=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 05/09] blk: reimplement handling of barrier request
Message-ID: <20050605055337.C21DB928@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:29 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_blk_ordered_reimpl.patch

	Reimplement handling of barrier requests.

	* Flexible handling to deal with various capabilities of
          target devices.
	* Retry support for falling back.
	* Tagged queues which don't support ordered tag can do ordered.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/elevator.c  |   79 ++++---
 drivers/block/ll_rw_blk.c |  491 ++++++++++++++++++++++++++++++++--------------
 include/linux/blkdev.h    |   93 ++++++--
 3 files changed, 469 insertions(+), 194 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-06-05 14:53:32.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-06-05 14:53:34.000000000 +0900
@@ -37,9 +37,38 @@
 
 #include <asm/uaccess.h>
 
+/*
+ * XXX HACK XXX Before entering elevator callbacks, we temporailiy
+ * turn off REQ_CMD of proxy barrier request so that elevators don't
+ * try to account it as a normal one.  This ugliness can go away once
+ * generic dispatch queue is implemented. - tj
+ */
+#define bar_rq_hack_start(q)	((q)->bar_rq && ((q)->bar_rq->flags &= ~REQ_CMD))
+#define bar_rq_hack_end(q)	((q)->bar_rq && ((q)->bar_rq->flags |= REQ_CMD))
+
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
+	if (q->in_flight == 0 && blk_ordered_cur_seq(q) == QUEUE_ORDSEQ_DRAIN) {
+		blk_ordered_complete_seq(q, QUEUE_ORDSEQ_DRAIN, 0);
+		q->request_fn(q);
+	}
+}
+
 /*
  * can we safely merge with this request?
  */
@@ -270,12 +299,15 @@ void elv_deactivate_request(request_queu
 	 * in_flight count again
 	 */
 	if (blk_account_rq(rq))
-		q->in_flight--;
+		elv_dec_inflight(q);
 
 	rq->flags &= ~REQ_STARTED;
 
-	if (e->ops->elevator_deactivate_req_fn)
+	if (e->ops->elevator_deactivate_req_fn) {
+		bar_rq_hack_start(q);
 		e->ops->elevator_deactivate_req_fn(q, rq);
+		bar_rq_hack_end(q);
+	}
 }
 
 void elv_requeue_request(request_queue_t *q, struct request *rq)
@@ -283,14 +315,6 @@ void elv_requeue_request(request_queue_t
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
@@ -301,9 +325,11 @@ void elv_requeue_request(request_queue_t
 	 * if iosched has an explicit requeue hook, then use that. otherwise
 	 * just put the request at the front of the queue
 	 */
-	if (q->elevator->ops->elevator_requeue_req_fn)
+	if (q->elevator->ops->elevator_requeue_req_fn) {
+		bar_rq_hack_start(q);
 		q->elevator->ops->elevator_requeue_req_fn(q, rq);
-	else
+		bar_rq_hack_end(q);
+	} else
 		__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 }
 
@@ -323,7 +349,9 @@ void __elv_add_request(request_queue_t *
 	rq->q = q;
 
 	if (!test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
+		bar_rq_hack_start(q);
 		q->elevator->ops->elevator_add_req_fn(q, rq, where);
+		bar_rq_hack_end(q);
 
 		if (blk_queue_plugged(q)) {
 			int nrq = q->rq.count[READ] + q->rq.count[WRITE]
@@ -353,20 +381,10 @@ void elv_add_request(request_queue_t *q,
 
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
+		if (blk_do_ordered(q, &rq))
+			break;
 	return rq;
 }
 
@@ -433,7 +451,7 @@ void elv_remove_request(request_queue_t 
 	 * for request-request merges
 	 */
 	if (blk_account_rq(rq))
-		q->in_flight++;
+		elv_inc_inflight(q);
 
 	/*
 	 * the main clearing point for q->last_merge is on retrieval of
@@ -445,8 +463,11 @@ void elv_remove_request(request_queue_t 
 	if (rq == q->last_merge)
 		q->last_merge = NULL;
 
-	if (e->ops->elevator_remove_req_fn)
+	if (e->ops->elevator_remove_req_fn) {
+		bar_rq_hack_start(q);
 		e->ops->elevator_remove_req_fn(q, rq);
+		bar_rq_hack_end(q);
+	}
 }
 
 int elv_queue_empty(request_queue_t *q)
@@ -529,7 +550,7 @@ void elv_completed_request(request_queue
 	 * request is released from the driver, io must be done
 	 */
 	if (blk_account_rq(rq))
-		q->in_flight--;
+		elv_dec_inflight(q);
 
 	if (e->ops->elevator_completed_req_fn)
 		e->ops->elevator_completed_req_fn(q, rq);
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-06-05 14:53:34.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-06-05 14:53:34.000000000 +0900
@@ -291,10 +291,112 @@ static inline void rq_init(request_queue
 	rq->end_io_data = NULL;
 }
 
+static int __blk_queue_ordered(request_queue_t *q, int ordered,
+			       prepare_flush_fn *prepare_flush_fn,
+			       unsigned gfp_mask, int locked)
+{
+	void *rq0 = NULL, *rq1 = NULL, *rq2 = NULL;
+	unsigned long flags = 0; /* shut up, gcc */
+	unsigned ordered_flags;
+	int ret = 0;
+
+	might_sleep_if(gfp_mask & __GFP_WAIT);
+
+	ordered_flags = ordered & QUEUE_ORDERED_FLAGS;
+	ordered &= ~QUEUE_ORDERED_FLAGS;
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
+		/* Queue flushing in progress, defer changing q->ordered. */
+		q->next_ordered = ordered;
+		q->next_prepare_flush_fn = prepare_flush_fn;
+		ret = -EINPROGRESS;
+		goto out;
+	}
+
+	switch (ordered) {
+	case QUEUE_ORDERED_NONE:
+		ordered_flags = 0;	/* for '== QUEUE_ORDERED_NONE' tests */
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
+	q->ordered = ordered | ordered_flags;
+	q->next_ordered = q->ordered;
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
@@ -303,32 +405,24 @@ static inline void rq_init(request_queue
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
@@ -349,165 +443,281 @@ EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 /*
  * Cache flushing for ordered writes handling
  */
-static void blk_pre_flush_end_io(struct request *flush_rq, int error)
+inline unsigned blk_ordered_cur_seq(request_queue_t *q)
 {
-	struct request *rq = flush_rq->end_io_data;
-	request_queue_t *q = rq->q;
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
+static void ordered_set_error(request_queue_t *q, unsigned seq, int error)
 {
-	struct request *rq = flush_rq->end_io_data;
-	request_queue_t *q = rq->q;
+	unsigned ordered;
 
-	rq->flags |= REQ_BAR_POSTFLUSH;
+	q->orderr = error;
 
-	q->end_flush_fn(q, flush_rq);
-	clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-	q->request_fn(q);
+	if (q->ordered & QUEUE_ORDERED_NOFALLBACK ||
+	    q->ordered != q->next_ordered)
+		return;
+
+	switch (seq) {
+	case QUEUE_ORDSEQ_PREFLUSH:
+		if (q->ordered & QUEUE_ORDERED_TAG)
+			ordered = (q->ordered & ~QUEUE_ORDERED_TAG) |
+				QUEUE_ORDERED_DRAIN;
+		else
+			ordered = QUEUE_ORDERED_NONE;
+		break;
+	case QUEUE_ORDSEQ_BAR:
+		ordered = (q->ordered & ~QUEUE_ORDERED_FUA) |
+			QUEUE_ORDERED_POSTFLUSH;
+		break;
+	default:
+		return;
+	}
+
+	blk_queue_ordered_locked(q, ordered, q->prepare_flush_fn, GFP_ATOMIC);
 }
 
-struct request *blk_start_pre_flush(request_queue_t *q, struct request *rq)
+void blk_ordered_complete_seq(request_queue_t *q, unsigned seq, int error)
 {
-	struct request *flush_rq = q->flush_rq;
+	struct request *rq;
+	int uptodate, changed = 0;
 
-	BUG_ON(!blk_barrier_rq(rq));
+	if (error && !q->orderr)
+		ordered_set_error(q, seq, error);
 
-	if (test_and_set_bit(QUEUE_FLAG_FLUSH, &q->queue_flags))
-		return NULL;
+	BUG_ON(q->ordseq & seq);
+	q->ordseq |= seq;
 
-	rq_init(q, flush_rq);
-	flush_rq->elevator_private = NULL;
-	flush_rq->flags = REQ_BAR_FLUSH;
-	flush_rq->rq_disk = rq->rq_disk;
-	flush_rq->rl = NULL;
+	if (blk_ordered_cur_seq(q) != QUEUE_ORDSEQ_DONE)
+		return;
 
 	/*
-	 * prepare_flush returns 0 if no flush is needed, just mark both
-	 * pre and post flush as done in that case
-	 */
-	if (!q->prepare_flush_fn(q, flush_rq)) {
-		rq->flags |= REQ_BAR_PREFLUSH | REQ_BAR_POSTFLUSH;
-		clear_bit(QUEUE_FLAG_FLUSH, &q->queue_flags);
-		return rq;
-	}
+	 * Okay, sequence complete.
+	 */
+	rq = q->orig_bar_rq;
+	uptodate = q->orderr ? q->orderr : 1;
+
+	q->ordseq = 0;
 
 	/*
-	 * some drivers dequeue requests right away, some only after io
-	 * completion. make sure the request is dequeued.
+	 * We give a failed barrier request second chance if ordered
+	 * has changed since it has started.
 	 */
-	if (!list_empty(&rq->queuelist))
-		blkdev_dequeue_request(rq);
+	if (q->next_ordered != q->ordered)
+		changed = !blk_queue_ordered_locked(q, q->next_ordered,
+						    q->next_prepare_flush_fn,
+						    GFP_ATOMIC);
 
-	elv_deactivate_request(q, rq);
+	if (!q->orderr || !changed || q->ordered == QUEUE_ORDERED_NONE) {
+		end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
+		end_that_request_last(rq, uptodate);
+	} else
+		blk_requeue_request(q, rq);
+}
 
-	flush_rq->end_io_data = rq;
-	flush_rq->end_io = blk_pre_flush_end_io;
+static void pre_flush_end_io(struct request *rq, int error)
+{
+	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_PREFLUSH, error);
+}
 
-	__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-	return flush_rq;
+static void bar_end_io(struct request *rq, int error)
+{
+	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_BAR, error);
 }
 
-static void blk_start_post_flush(request_queue_t *q, struct request *rq)
+static void post_flush_end_io(struct request *rq, int error)
 {
-	struct request *flush_rq = q->flush_rq;
+	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_POSTFLUSH, error);
+}
 
-	BUG_ON(!blk_barrier_rq(rq));
+static void queue_flush(request_queue_t *q, unsigned which)
+{
+	struct request *rq;
+	rq_end_io_fn *end_io;
 
-	rq_init(q, flush_rq);
-	flush_rq->elevator_private = NULL;
-	flush_rq->flags = REQ_BAR_FLUSH;
-	flush_rq->rq_disk = rq->rq_disk;
-	flush_rq->rl = NULL;
+	if (which == QUEUE_ORDERED_PREFLUSH) {
+		rq = q->pre_flush_rq;
+		end_io = pre_flush_end_io;
+	} else {
+		rq = q->post_flush_rq;
+		end_io = post_flush_end_io;
+	}
 
-	if (q->prepare_flush_fn(q, flush_rq)) {
-		flush_rq->end_io_data = rq;
-		flush_rq->end_io = blk_post_flush_end_io;
+	rq_init(q, rq);
+	rq->flags = REQ_HARDBARRIER;
+	rq->elevator_private = NULL;
+	rq->rq_disk = q->bar_rq->rq_disk;
+	rq->rl = NULL;
+	rq->end_io = end_io;
+	q->prepare_flush_fn(q, rq);
 
-		__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-		q->request_fn(q);
-	}
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
 
-	rq->nr_sectors -= sectors;
-	return rq->nr_sectors;
-}
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
 
-static int __blk_complete_barrier_rq(request_queue_t *q, struct request *rq,
-				     int sectors, int queue_locked)
-{
-	if (q->ordered != QUEUE_ORDERED_FLUSH)
-		return 0;
-	if (!blk_fs_request(rq) || !blk_barrier_rq(rq))
-		return 0;
-	if (blk_barrier_postflush(rq))
-		return 0;
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
 
-	if (!blk_check_end_barrier(q, rq, sectors)) {
-		unsigned long flags = 0;
+	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 
-		if (!queue_locked)
-			spin_lock_irqsave(q->queue_lock, flags);
+	if (q->ordered & QUEUE_ORDERED_PREFLUSH) {
+		queue_flush(q, QUEUE_ORDERED_PREFLUSH);
+		rq = q->pre_flush_rq;
+	} else
+		q->ordseq |= QUEUE_ORDSEQ_PREFLUSH;
 
-		blk_start_post_flush(q, rq);
+	if ((q->ordered & QUEUE_ORDERED_TAG) || q->in_flight == 0)
+		q->ordseq |= QUEUE_ORDSEQ_DRAIN;
+	else
+		rq = NULL;
 
-		if (!queue_locked)
-			spin_unlock_irqrestore(q->queue_lock, flags);
+	return rq;
+}
+
+int blk_do_ordered(request_queue_t *q, struct request **rqp)
+{
+	struct request *rq = *rqp, *allowed_rq;
+	int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
+
+	if (!q->ordseq) {
+		if (!is_barrier)
+			return 1;
+
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
+
+	if (q->ordered & QUEUE_ORDERED_TAG) {
+		if (blk_fs_request(rq) && rq != q->bar_rq)
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
+		ordered_set_error(q, QUEUE_ORDSEQ_BAR, error);
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
@@ -1031,6 +1241,7 @@ static char *rq_flags[] = {
 	"REQ_FAILFAST",
 	"REQ_SOFTBARRIER",
 	"REQ_HARDBARRIER",
+	"REQ_FUA",
 	"REQ_CMD",
 	"REQ_NOMERGE",
 	"REQ_STARTED",
@@ -1614,7 +1825,7 @@ void blk_cleanup_queue(request_queue_t *
 	if (q->queue_tags)
 		__blk_queue_free_tags(q);
 
-	blk_queue_ordered(q, QUEUE_ORDERED_NONE);
+	blk_queue_ordered(q, QUEUE_ORDERED_NONE, NULL, 0);
 
 	kmem_cache_free(requestq_cachep, q);
 }
@@ -3034,7 +3245,8 @@ static int __end_that_request_first(stru
 		if (nr_bytes >= bio->bi_size) {
 			req->bio = bio->bi_next;
 			nbytes = bio->bi_size;
-			bio_endio(bio, nbytes, error);
+			if (!ordered_bio_endio(req, bio, nbytes, error))
+				bio_endio(bio, nbytes, error);
 			next_idx = 0;
 			bio_nbytes = 0;
 		} else {
@@ -3089,7 +3301,8 @@ static int __end_that_request_first(stru
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
--- blk-fixes.orig/include/linux/blkdev.h	2005-06-05 14:53:32.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-06-05 14:53:34.000000000 +0900
@@ -205,6 +205,7 @@ enum rq_flag_bits {
 	__REQ_FAILFAST,		/* no low level driver retries */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
 	__REQ_HARDBARRIER,	/* may not be passed by drive either */
+	__REQ_FUA,		/* forced unit access */
 	__REQ_CMD,		/* is a regular fs rw request */
 	__REQ_NOMERGE,		/* don't touch this for merging */
 	__REQ_STARTED,		/* drive already may have started this one */
@@ -227,9 +228,6 @@ enum rq_flag_bits {
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
-	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
-	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
-	__REQ_BAR_FLUSH,	/* rq is the flush request */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -237,6 +235,7 @@ enum rq_flag_bits {
 #define REQ_FAILFAST	(1 << __REQ_FAILFAST)
 #define REQ_SOFTBARRIER	(1 << __REQ_SOFTBARRIER)
 #define REQ_HARDBARRIER	(1 << __REQ_HARDBARRIER)
+#define REQ_FUA		(1 << __REQ_FUA)
 #define REQ_CMD		(1 << __REQ_CMD)
 #define REQ_NOMERGE	(1 << __REQ_NOMERGE)
 #define REQ_STARTED	(1 << __REQ_STARTED)
@@ -255,9 +254,6 @@ enum rq_flag_bits {
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
-#define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
-#define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
-#define REQ_BAR_FLUSH	(1 << __REQ_BAR_FLUSH)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
@@ -287,8 +283,7 @@ struct bio_vec;
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
 typedef void (activity_fn) (void *data, int rw);
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
-typedef int (prepare_flush_fn) (request_queue_t *, struct request *);
-typedef void (end_flush_fn) (request_queue_t *, struct request *);
+typedef void (prepare_flush_fn) (request_queue_t *, struct request *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -329,7 +324,6 @@ struct request_queue
 	activity_fn		*activity_fn;
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
-	end_flush_fn		*end_flush_fn;
 
 	/*
 	 * Auto-unplugging state
@@ -409,14 +403,13 @@ struct request_queue
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
+	unsigned int		ordseq;
+	int			orderr;
+	struct request		*pre_flush_rq, *bar_rq, *post_flush_rq;
+	struct request		*orig_bar_rq;
+	unsigned int		bi_size;
+	unsigned int		ordered, next_ordered;
+	prepare_flush_fn	*next_prepare_flush_fn;
 };
 
 #define RQ_INACTIVE		(-1)
@@ -434,19 +427,67 @@ enum {
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_DRAIN	8	/* draining queue for sched switch */
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
+	 *
+	 * The following flags can be or'd.
+	 *
+	 * NOFALLBACK	: disable auto-fallback
+	 */
+	QUEUE_ORDERED_NONE	= 0x00,
+	QUEUE_ORDERED_DRAIN	= 0x01,
+	QUEUE_ORDERED_TAG	= 0x02,
+
+	QUEUE_ORDERED_PREFLUSH	= 0x10,
+	QUEUE_ORDERED_POSTFLUSH	= 0x20,
+	QUEUE_ORDERED_FUA	= 0x40,
+
+	QUEUE_ORDERED_NOFALLBACK = 0x80,
+
+	QUEUE_ORDERED_FLAGS	= QUEUE_ORDERED_NOFALLBACK,
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
 #define blk_noretry_request(rq)	((rq)->flags & REQ_FAILFAST)
 #define blk_rq_started(rq)	((rq)->flags & REQ_STARTED)
 
-#define blk_account_rq(rq)	(blk_rq_started(rq) && blk_fs_request(rq))
+#define blk_account_rq(rq)	\
+	(blk_rq_started(rq) && blk_fs_request(rq) && rq != rq->q->bar_rq)
 
 #define blk_pm_suspend_request(rq)	((rq)->flags & REQ_PM_SUSPEND)
 #define blk_pm_resume_request(rq)	((rq)->flags & REQ_PM_RESUME)
@@ -454,8 +495,7 @@ enum {
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
 #define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
-#define blk_barrier_preflush(rq)	((rq)->flags & REQ_BAR_PREFLUSH)
-#define blk_barrier_postflush(rq)	((rq)->flags & REQ_BAR_POSTFLUSH)
+#define blk_fua_rq(rq)		((rq)->flags & REQ_FUA)
 
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
@@ -636,11 +676,12 @@ extern void blk_queue_prep_rq(request_qu
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
-extern void blk_queue_ordered(request_queue_t *, int);
+extern int blk_queue_ordered(request_queue_t *, unsigned, prepare_flush_fn *, unsigned);
+extern int blk_queue_ordered_locked(request_queue_t *, unsigned, prepare_flush_fn *, unsigned);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);
-extern struct request *blk_start_pre_flush(request_queue_t *,struct request *);
-extern int blk_complete_barrier_rq(request_queue_t *, struct request *, int);
-extern int blk_complete_barrier_rq_locked(request_queue_t *, struct request *, int);
+extern int blk_do_ordered(request_queue_t *, struct request **);
+extern unsigned blk_ordered_cur_seq(request_queue_t *);
+extern void blk_ordered_complete_seq(request_queue_t *, unsigned, int);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);

