Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVGZN5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVGZN5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVGZN5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:57:21 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:37333 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261793AbVGZN42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:56:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Rm/c755abwq3KNFChCkRaGOnyx2FFW0T5FtyxPWow9g+K4bjWqjMP6pTI1y+x9s+tnmjI8ttQYDCuEO0emoKc9AnXDeg+U3tX+pKRqCv7PbZL9ta+fd2yrOb4gpStTUVh9P13oAbDMfas9yFuyE2FYMD0l8T/aFvAMvjjkFLxQQ=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726135502.D83FC6EE@htj.dyndns.org>
In-Reply-To: <20050726135502.D83FC6EE@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 01/05] blk: implement generic dispatch queue
Message-ID: <20050726135502.E1C54197@htj.dyndns.org>
Date: Tue, 26 Jul 2005 22:56:22 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_blk_implement-generic-dispatch-queue.patch

	Implements generic dispatch queue which can replace all
        dispatch queues implemented by each iosched.  This reduces
        code duplication, eases enforcing semantics over dispatch
        queue, and simplifies specific ioscheds.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/elevator.c  |  242 ++++++++++++++++++++++++++++++++--------------
 drivers/block/ll_rw_blk.c |   23 ++--
 include/linux/blkdev.h    |   17 ++-
 include/linux/elevator.h  |   16 +--
 4 files changed, 201 insertions(+), 97 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-07-26 22:55:00.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-07-26 22:55:00.000000000 +0900
@@ -40,6 +40,11 @@
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
+static inline sector_t rq_last_sector(struct request *rq)
+{
+	return rq->sector + rq->nr_sectors;
+}
+
 /*
  * can we safely merge with this request?
  */
@@ -143,6 +148,9 @@ static int elevator_attach(request_queue
 	INIT_LIST_HEAD(&q->queue_head);
 	q->last_merge = NULL;
 	q->elevator = eq;
+	q->last_sector = 0;
+	q->boundary_rq = NULL;
+	q->max_back_kb = 0;
 
 	if (eq->ops->elevator_init_fn)
 		ret = eq->ops->elevator_init_fn(q, eq);
@@ -225,6 +233,48 @@ void elevator_exit(elevator_t *e)
 	kfree(e);
 }
 
+/*
+ * Insert rq into dispatch queue of q.  Queue lock must be held on
+ * entry.  If sort != 0, rq is sort-inserted; otherwise, rq will be
+ * appended to the dispatch queue.  To be used by specific elevators.
+ */
+void elv_dispatch_insert(request_queue_t *q, struct request *rq, int sort)
+{
+	sector_t boundary;
+	unsigned max_back;
+	struct list_head *entry;
+
+	if (!sort) {
+		/* Specific elevator is performing sort.  Step away. */
+		q->last_sector = rq_last_sector(rq);
+		q->boundary_rq = rq;
+		list_add_tail(&rq->queuelist, &q->queue_head);
+		return;
+	}
+
+	boundary = q->last_sector;
+	max_back = q->max_back_kb * 2;
+	boundary = boundary > max_back ? boundary - max_back : 0;
+
+	list_for_each_prev(entry, &q->queue_head) {
+		struct request *pos = list_entry_rq(entry);
+
+		if (pos->flags & (REQ_SOFTBARRIER|REQ_HARDBARRIER|REQ_STARTED))
+			break;
+		if (rq->sector >= boundary) {
+			if (pos->sector < boundary)
+				continue;
+		} else {
+			if (pos->sector >= boundary)
+				break;
+		}
+		if (rq->sector >= pos->sector)
+			break;
+	}
+
+	list_add(&rq->queuelist, entry);
+}
+
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	elevator_t *e = q->elevator;
@@ -255,13 +305,7 @@ void elv_merge_requests(request_queue_t 
 		e->ops->elevator_merge_req_fn(q, rq, next);
 }
 
-/*
- * For careful internal use by the block layer. Essentially the same as
- * a requeue in that it tells the io scheduler that this request is not
- * active in the driver or hardware anymore, but we don't want the request
- * added back to the scheduler. Function is not exported.
- */
-void elv_deactivate_request(request_queue_t *q, struct request *rq)
+void elv_requeue_request(request_queue_t *q, struct request *rq)
 {
 	elevator_t *e = q->elevator;
 
@@ -269,19 +313,14 @@ void elv_deactivate_request(request_queu
 	 * it already went through dequeue, we need to decrement the
 	 * in_flight count again
 	 */
-	if (blk_account_rq(rq))
+	if (blk_account_rq(rq)) {
 		q->in_flight--;
+		if (blk_sorted_rq(rq) && e->ops->elevator_deactivate_req_fn)
+			e->ops->elevator_deactivate_req_fn(q, rq);
+	}
 
 	rq->flags &= ~REQ_STARTED;
 
-	if (e->ops->elevator_deactivate_req_fn)
-		e->ops->elevator_deactivate_req_fn(q, rq);
-}
-
-void elv_requeue_request(request_queue_t *q, struct request *rq)
-{
-	elv_deactivate_request(q, rq);
-
 	/*
 	 * if this is the flush, requeue the original instead and drop the flush
 	 */
@@ -290,55 +329,89 @@ void elv_requeue_request(request_queue_t
 		rq = rq->end_io_data;
 	}
 
-	/*
-	 * the request is prepped and may have some resources allocated.
-	 * allowing unprepped requests to pass this one may cause resource
-	 * deadlock.  turn on softbarrier.
-	 */
-	rq->flags |= REQ_SOFTBARRIER;
-
-	/*
-	 * if iosched has an explicit requeue hook, then use that. otherwise
-	 * just put the request at the front of the queue
-	 */
-	if (q->elevator->ops->elevator_requeue_req_fn)
-		q->elevator->ops->elevator_requeue_req_fn(q, rq);
-	else
-		__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 }
 
 void __elv_add_request(request_queue_t *q, struct request *rq, int where,
 		       int plug)
 {
-	/*
-	 * barriers implicitly indicate back insertion
-	 */
-	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER) &&
-	    where == ELEVATOR_INSERT_SORT)
-		where = ELEVATOR_INSERT_BACK;
+	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)) {
+		/*
+		 * barriers implicitly indicate back insertion
+		 */
+		if (where == ELEVATOR_INSERT_SORT)
+			where = ELEVATOR_INSERT_BACK;
+
+		/*
+		 * this request is scheduling boundary, update last_sector
+		 */
+		if (blk_fs_request(rq)) {
+			q->last_sector = rq_last_sector(rq);
+			q->boundary_rq = rq;
+		}
+	}
 
 	if (plug)
 		blk_plug_device(q);
 
 	rq->q = q;
 
-	if (!test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
-		q->elevator->ops->elevator_add_req_fn(q, rq, where);
-
-		if (blk_queue_plugged(q)) {
-			int nrq = q->rq.count[READ] + q->rq.count[WRITE]
-				  - q->in_flight;
-
-			if (nrq >= q->unplug_thresh)
-				__generic_unplug_device(q);
-		}
-	} else
+	if (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))) {
 		/*
 		 * if drain is set, store the request "locally". when the drain
 		 * is finished, the requests will be handed ordered to the io
 		 * scheduler
 		 */
 		list_add_tail(&rq->queuelist, &q->drain_list);
+		return;
+	}
+
+	switch (where) {
+	case ELEVATOR_INSERT_FRONT:
+		rq->flags |= REQ_SOFTBARRIER;
+
+		list_add(&rq->queuelist, &q->queue_head);
+		break;
+
+	case ELEVATOR_INSERT_BACK:
+		rq->flags |= REQ_SOFTBARRIER;
+
+		while (q->elevator->ops->elevator_dispatch_fn(q, 1))
+			;
+		list_add_tail(&rq->queuelist, &q->queue_head);
+		/*
+		 * We kick the queue here for the following reasons.
+		 * - The elevator might have returned NULL previously
+		 *   to delay requests and returned them now.  As the
+		 *   queue wasn't empty before this request, ll_rw_blk
+		 *   won't run the queue on return, resulting in hang.
+		 * - Usually, back inserted requests won't be merged
+		 *   with anything.  There's no point in delaying queue
+		 *   processing.
+		 */
+		blk_remove_plug(q);
+		q->request_fn(q);
+		break;
+
+	case ELEVATOR_INSERT_SORT:
+		BUG_ON(!blk_fs_request(rq));
+		rq->flags |= REQ_SORTED;
+		q->elevator->ops->elevator_add_req_fn(q, rq);
+		break;
+
+	default:
+		printk(KERN_ERR "%s: bad insertion point %d\n",
+		       __FUNCTION__, where);
+		BUG();
+	}
+
+	if (blk_queue_plugged(q)) {
+		int nrq = q->rq.count[READ] + q->rq.count[WRITE]
+			- q->in_flight;
+
+		if (nrq >= q->unplug_thresh)
+			__generic_unplug_device(q);
+	}
 }
 
 void elv_add_request(request_queue_t *q, struct request *rq, int where,
@@ -353,13 +426,19 @@ void elv_add_request(request_queue_t *q,
 
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
-	struct request *rq = q->elevator->ops->elevator_next_req_fn(q);
+	struct request *rq;
+
+	if (unlikely(list_empty(&q->queue_head) &&
+		     !q->elevator->ops->elevator_dispatch_fn(q, 0)))
+		return NULL;
+
+	rq = list_entry_rq(q->queue_head.next);
 
 	/*
 	 * if this is a barrier write and the device has to issue a
 	 * flush sequence to support it, check how far we are
 	 */
-	if (rq && blk_fs_request(rq) && blk_barrier_rq(rq)) {
+	if (blk_fs_request(rq) && blk_barrier_rq(rq)) {
 		BUG_ON(q->ordered == QUEUE_ORDERED_NONE);
 
 		if (q->ordered == QUEUE_ORDERED_FLUSH &&
@@ -376,16 +455,34 @@ struct request *elv_next_request(request
 	int ret;
 
 	while ((rq = __elv_next_request(q)) != NULL) {
-		/*
-		 * just mark as started even if we don't start it, a request
-		 * that has been delayed should not be passed by new incoming
-		 * requests
-		 */
-		rq->flags |= REQ_STARTED;
+		if (!(rq->flags & REQ_STARTED)) {
+			elevator_t *e = q->elevator;
+
+			/*
+			 * This is the first time the device driver
+			 * sees this request (possibly after
+			 * requeueing).  Notify IO scheduler.
+			 */
+			if (blk_sorted_rq(rq) &&
+			    e->ops->elevator_activate_req_fn)
+				e->ops->elevator_activate_req_fn(q, rq);
+			
+			/*
+			 * just mark as started even if we don't start
+			 * it, a request that has been delayed should
+			 * not be passed by new incoming requests
+			 */
+			rq->flags |= REQ_STARTED;
+		}
 
 		if (rq == q->last_merge)
 			q->last_merge = NULL;
 
+		if (!q->boundary_rq || q->boundary_rq == rq) {
+			q->last_sector = rq_last_sector(rq);
+			q->boundary_rq = NULL;
+		}
+
 		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
 			break;
 
@@ -396,9 +493,9 @@ struct request *elv_next_request(request
 			/*
 			 * the request may have been (partially) prepped.
 			 * we need to keep this request in the front to
-			 * avoid resource deadlock.  turn on softbarrier.
+			 * avoid resource deadlock.  REQ_STARTED will
+			 * prevent other fs requests from passing this one.
 			 */
-			rq->flags |= REQ_SOFTBARRIER;
 			rq = NULL;
 			break;
 		} else if (ret == BLKPREP_KILL) {
@@ -421,16 +518,16 @@ struct request *elv_next_request(request
 	return rq;
 }
 
-void elv_remove_request(request_queue_t *q, struct request *rq)
+void elv_dequeue_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	BUG_ON(list_empty(&rq->queuelist));
+
+	list_del_init(&rq->queuelist);
 
 	/*
 	 * the time frame between a request being removed from the lists
 	 * and to it is freed is accounted as io that is in progress at
-	 * the driver side. note that we only account requests that the
-	 * driver has seen (REQ_STARTED set), to avoid false accounting
-	 * for request-request merges
+	 * the driver side.
 	 */
 	if (blk_account_rq(rq))
 		q->in_flight++;
@@ -444,19 +541,19 @@ void elv_remove_request(request_queue_t 
 	 */
 	if (rq == q->last_merge)
 		q->last_merge = NULL;
-
-	if (e->ops->elevator_remove_req_fn)
-		e->ops->elevator_remove_req_fn(q, rq);
 }
 
 int elv_queue_empty(request_queue_t *q)
 {
 	elevator_t *e = q->elevator;
 
+	if (!list_empty(&q->queue_head))
+		return 0;
+
 	if (e->ops->elevator_queue_empty_fn)
 		return e->ops->elevator_queue_empty_fn(q);
 
-	return list_empty(&q->queue_head);
+	return 1;
 }
 
 struct request *elv_latter_request(request_queue_t *q, struct request *rq)
@@ -527,11 +624,11 @@ void elv_completed_request(request_queue
 	/*
 	 * request is released from the driver, io must be done
 	 */
-	if (blk_account_rq(rq))
+	if (blk_account_rq(rq)) {
 		q->in_flight--;
-
-	if (e->ops->elevator_completed_req_fn)
-		e->ops->elevator_completed_req_fn(q, rq);
+		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
+			e->ops->elevator_completed_req_fn(q, rq);
+	}
 }
 
 int elv_register_queue(struct request_queue *q)
@@ -704,11 +801,12 @@ ssize_t elv_iosched_show(request_queue_t
 	return len;
 }
 
+EXPORT_SYMBOL(elv_dispatch_insert);
 EXPORT_SYMBOL(elv_add_request);
 EXPORT_SYMBOL(__elv_add_request);
 EXPORT_SYMBOL(elv_requeue_request);
 EXPORT_SYMBOL(elv_next_request);
-EXPORT_SYMBOL(elv_remove_request);
+EXPORT_SYMBOL(elv_dequeue_request);
 EXPORT_SYMBOL(elv_queue_empty);
 EXPORT_SYMBOL(elv_completed_request);
 EXPORT_SYMBOL(elevator_exit);
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-07-26 22:54:59.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-07-26 22:55:00.000000000 +0900
@@ -349,6 +349,8 @@ static void blk_pre_flush_end_io(struct 
 	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
 
+	elv_completed_request(q, flush_rq);
+
 	rq->flags |= REQ_BAR_PREFLUSH;
 
 	if (!flush_rq->errors)
@@ -365,6 +367,8 @@ static void blk_post_flush_end_io(struct
 	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
 
+	elv_completed_request(q, flush_rq);
+
 	rq->flags |= REQ_BAR_POSTFLUSH;
 
 	q->end_flush_fn(q, flush_rq);
@@ -404,8 +408,6 @@ struct request *blk_start_pre_flush(requ
 	if (!list_empty(&rq->queuelist))
 		blkdev_dequeue_request(rq);
 
-	elv_deactivate_request(q, rq);
-
 	flush_rq->end_io_data = rq;
 	flush_rq->end_io = blk_pre_flush_end_io;
 
@@ -1036,6 +1038,7 @@ EXPORT_SYMBOL(blk_queue_invalidate_tags)
 static char *rq_flags[] = {
 	"REQ_RW",
 	"REQ_FAILFAST",
+	"REQ_SORTED",
 	"REQ_SOFTBARRIER",
 	"REQ_HARDBARRIER",
 	"REQ_CMD",
@@ -2370,6 +2373,8 @@ static void __blk_put_request(request_qu
 	if (unlikely(--req->ref_count))
 		return;
 
+	elv_completed_request(q, req);
+
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
 	req->rl = NULL;
@@ -2381,8 +2386,6 @@ static void __blk_put_request(request_qu
 	if (rl) {
 		int rw = rq_data_dir(req);
 
-		elv_completed_request(q, req);
-
 		BUG_ON(!list_empty(&req->queuelist));
 
 		blk_free_request(q, req);
@@ -2392,14 +2395,14 @@ static void __blk_put_request(request_qu
 
 void blk_put_request(struct request *req)
 {
+	unsigned long flags;
+	request_queue_t *q = req->q;
+
 	/*
-	 * if req->rl isn't set, this request didnt originate from the
-	 * block layer, so it's safe to just disregard it
+	 * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
+	 * following if (q) test.
 	 */
-	if (req->rl) {
-		unsigned long flags;
-		request_queue_t *q = req->q;
-
+	if (q) {
 		spin_lock_irqsave(q->queue_lock, flags);
 		__blk_put_request(q, req);
 		spin_unlock_irqrestore(q->queue_lock, flags);
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-07-26 22:54:59.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-07-26 22:55:00.000000000 +0900
@@ -193,6 +193,7 @@ struct request {
 enum rq_flag_bits {
 	__REQ_RW,		/* not set, read. set, write */
 	__REQ_FAILFAST,		/* no low level driver retries */
+	__REQ_SORTED,		/* elevator knows about this request */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
 	__REQ_HARDBARRIER,	/* may not be passed by drive either */
 	__REQ_CMD,		/* is a regular fs rw request */
@@ -225,6 +226,7 @@ enum rq_flag_bits {
 
 #define REQ_RW		(1 << __REQ_RW)
 #define REQ_FAILFAST	(1 << __REQ_FAILFAST)
+#define REQ_SORTED	(1 << __REQ_SORTED)
 #define REQ_SOFTBARRIER	(1 << __REQ_SOFTBARRIER)
 #define REQ_HARDBARRIER	(1 << __REQ_HARDBARRIER)
 #define REQ_CMD		(1 << __REQ_CMD)
@@ -326,6 +328,13 @@ struct request_queue
 	end_flush_fn		*end_flush_fn;
 
 	/*
+	 * Dispatch queue sorting
+	 */
+	sector_t		last_sector;
+	struct request		*boundary_rq;
+	unsigned int		max_back_kb;
+
+	/*
 	 * Auto-unplugging state
 	 */
 	struct timer_list	unplug_timer;
@@ -446,6 +455,7 @@ enum {
 #define blk_pm_request(rq)	\
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
+#define blk_sorted_rq(rq)	((rq)->flags & REQ_SORTED)
 #define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
 #define blk_barrier_preflush(rq)	((rq)->flags & REQ_BAR_PREFLUSH)
 #define blk_barrier_postflush(rq)	((rq)->flags & REQ_BAR_POSTFLUSH)
@@ -604,12 +614,7 @@ extern void end_request(struct request *
 
 static inline void blkdev_dequeue_request(struct request *req)
 {
-	BUG_ON(list_empty(&req->queuelist));
-
-	list_del_init(&req->queuelist);
-
-	if (req->rl)
-		elv_remove_request(req->q, req);
+	elv_dequeue_request(req->q, req);
 }
 
 /*
Index: blk-fixes/include/linux/elevator.h
===================================================================
--- blk-fixes.orig/include/linux/elevator.h	2005-07-26 22:54:59.000000000 +0900
+++ blk-fixes/include/linux/elevator.h	2005-07-26 22:55:00.000000000 +0900
@@ -8,18 +8,17 @@ typedef void (elevator_merge_req_fn) (re
 
 typedef void (elevator_merged_fn) (request_queue_t *, struct request *);
 
-typedef struct request *(elevator_next_req_fn) (request_queue_t *);
+typedef int (elevator_dispatch_fn) (request_queue_t *, int);
 
-typedef void (elevator_add_req_fn) (request_queue_t *, struct request *, int);
+typedef void (elevator_add_req_fn) (request_queue_t *, struct request *);
 typedef int (elevator_queue_empty_fn) (request_queue_t *);
-typedef void (elevator_remove_req_fn) (request_queue_t *, struct request *);
-typedef void (elevator_requeue_req_fn) (request_queue_t *, struct request *);
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef void (elevator_completed_req_fn) (request_queue_t *, struct request *);
 typedef int (elevator_may_queue_fn) (request_queue_t *, int);
 
 typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, int);
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
+typedef void (elevator_activate_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_deactivate_req_fn) (request_queue_t *, struct request *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
@@ -31,10 +30,9 @@ struct elevator_ops
 	elevator_merged_fn *elevator_merged_fn;
 	elevator_merge_req_fn *elevator_merge_req_fn;
 
-	elevator_next_req_fn *elevator_next_req_fn;
+	elevator_dispatch_fn *elevator_dispatch_fn;
 	elevator_add_req_fn *elevator_add_req_fn;
-	elevator_remove_req_fn *elevator_remove_req_fn;
-	elevator_requeue_req_fn *elevator_requeue_req_fn;
+	elevator_activate_req_fn *elevator_activate_req_fn;
 	elevator_deactivate_req_fn *elevator_deactivate_req_fn;
 
 	elevator_queue_empty_fn *elevator_queue_empty_fn;
@@ -81,15 +79,15 @@ struct elevator_queue
 /*
  * block elevator interface
  */
+extern void elv_dispatch_insert(request_queue_t *, struct request *, int);
 extern void elv_add_request(request_queue_t *, struct request *, int, int);
 extern void __elv_add_request(request_queue_t *, struct request *, int, int);
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
 extern void elv_merged_request(request_queue_t *, struct request *);
-extern void elv_remove_request(request_queue_t *, struct request *);
+extern void elv_dequeue_request(request_queue_t *, struct request *);
 extern void elv_requeue_request(request_queue_t *, struct request *);
-extern void elv_deactivate_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
 extern struct request *elv_next_request(struct request_queue *q);
 extern struct request *elv_former_request(request_queue_t *, struct request *);

