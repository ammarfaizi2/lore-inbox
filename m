Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVFPE6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVFPE6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVFPE6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:58:25 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:27664 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261739AbVFPE4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:56:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=BiYeijhH8uDklEh0l/BLoX3AtY8KSxXy9hMAiQtE6L8cDKvHxbRa7lUZq3k5JMEefbWRD8fN4Hf4AW7jAqLD1m3Wj9sM2QiFotrpMoiudRLwF7zfG0kdQDFvOPvWihMSs3dEDiESdri3QlWaTUR/7TsaHlcKZ9/A/RsY9xaisxg=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 01/06] blk: implement generic dispatch queue
Message-ID: <20050616045540.D4031B70@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:56:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_blk_dispatch_queue.patch

	Implements generic dispatch queue which can replace all
	dispatch queues implemented by each iosched.  This reduces
	code duplication, eases enforcing semantics over dispatch
	queue, and simplifies specific ioscheds.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/elevator.c  |  245 ++++++++++++++++++++++++++++++----------------
 drivers/block/ll_rw_blk.c |   26 ++--
 include/linux/blkdev.h    |   20 ++-
 include/linux/elevator.h  |   16 +--
 4 files changed, 192 insertions(+), 115 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-06-16 13:55:37.000000000 +0900
@@ -37,18 +37,14 @@
 
 #include <asm/uaccess.h>
 
-/*
- * XXX HACK XXX Before entering elevator callbacks, we temporailiy
- * turn off REQ_CMD of proxy barrier request so that elevators don't
- * try to account it as a normal one.  This ugliness can go away once
- * generic dispatch queue is implemented. - tj
- */
-#define bar_rq_hack_start(q)	((q)->bar_rq && ((q)->bar_rq->flags &= ~REQ_CMD))
-#define bar_rq_hack_end(q)	((q)->bar_rq && ((q)->bar_rq->flags |= REQ_CMD))
-
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
+static inline sector_t rq_last_sector(struct request *rq)
+{
+	return rq->sector + rq->nr_sectors;
+}
+
 static inline void elv_inc_inflight(request_queue_t *q)
 {
 	q->in_flight++;
@@ -171,6 +167,9 @@ static int elevator_attach(request_queue
 	INIT_LIST_HEAD(&q->queue_head);
 	q->last_merge = NULL;
 	q->elevator = eq;
+	q->last_sector = 0;
+	q->boundary_rq = 0;
+	q->max_back_kb = 0;
 
 	if (eq->ops->elevator_init_fn)
 		ret = eq->ops->elevator_init_fn(q, eq);
@@ -249,6 +248,45 @@ void elevator_exit(elevator_t *e)
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
+		if (rq->sector >= boundary && pos->sector < boundary)
+			continue;
+		if (rq->sector >= pos->sector)
+			break;
+		if (rq->sector < boundary && pos->sector >= boundary)
+			break;
+	}
+
+	list_add(&rq->queuelist, entry);
+}
+
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	elevator_t *e = q->elevator;
@@ -279,13 +317,7 @@ void elv_merge_requests(request_queue_t 
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
 
@@ -293,75 +325,103 @@ void elv_deactivate_request(request_queu
 	 * it already went through dequeue, we need to decrement the
 	 * in_flight count again
 	 */
-	if (blk_account_rq(rq))
+	if (blk_account_rq(rq)) {
 		elv_dec_inflight(q);
-
-	rq->flags &= ~REQ_STARTED;
-
-	if (e->ops->elevator_deactivate_req_fn) {
-		bar_rq_hack_start(q);
-		e->ops->elevator_deactivate_req_fn(q, rq);
-		bar_rq_hack_end(q);
+		if (blk_sorted_rq(rq) && e->ops->elevator_deactivate_req_fn)
+			e->ops->elevator_deactivate_req_fn(q, rq);
 	}
-}
-
-void elv_requeue_request(request_queue_t *q, struct request *rq)
-{
-	elv_deactivate_request(q, rq);
 
-	/*
-	 * the request is prepped and may have some resources allocated.
-	 * allowing unprepped requests to pass this one may cause resource
-	 * deadlock.  turn on softbarrier.
-	 */
-	rq->flags |= REQ_SOFTBARRIER;
+	rq->flags &= ~REQ_STARTED;
 
-	/*
-	 * if iosched has an explicit requeue hook, then use that. otherwise
-	 * just put the request at the front of the queue
-	 */
-	if (q->elevator->ops->elevator_requeue_req_fn) {
-		bar_rq_hack_start(q);
-		q->elevator->ops->elevator_requeue_req_fn(q, rq);
-		bar_rq_hack_end(q);
-	} else
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
-		bar_rq_hack_start(q);
-		q->elevator->ops->elevator_add_req_fn(q, rq, where);
-		bar_rq_hack_end(q);
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
+		/*
+		 * don't let dispatch sorting pass front-inserted requests.
+		 */
+		rq->flags |= REQ_SOFTBARRIER;
+
+		list_add(&rq->queuelist, &q->queue_head);
+		break;
+
+	case ELEVATOR_INSERT_BACK:
+		/*
+		 * don't let dispatch sorting pass back-inserted requests.
+		 */
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
@@ -377,10 +437,17 @@ void elv_add_request(request_queue_t *q,
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
 	struct request *rq;
-	while ((rq = q->elevator->ops->elevator_next_req_fn(q)))
-		if (blk_do_ordered(q, &rq))
-			break;
-	return rq;
+
+	while (1) {
+		while (!list_empty(&q->queue_head)) {
+			rq = list_entry_rq(q->queue_head.next);
+			if (blk_do_ordered(q, &rq))
+				return rq;
+		}
+
+		if (!q->elevator->ops->elevator_dispatch_fn(q, 0))
+			return NULL;
+	}
 }
 
 struct request *elv_next_request(request_queue_t *q)
@@ -399,6 +466,11 @@ struct request *elv_next_request(request
 		if (rq == q->last_merge)
 			q->last_merge = NULL;
 
+		if (!q->boundary_rq || q->boundary_rq == rq) {
+			q->last_sector = rq_last_sector(rq);
+			q->boundary_rq = NULL;
+		}
+
 		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
 			break;
 
@@ -409,9 +481,9 @@ struct request *elv_next_request(request
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
@@ -434,10 +506,14 @@ struct request *elv_next_request(request
 	return rq;
 }
 
-void elv_remove_request(request_queue_t *q, struct request *rq)
+void elv_dequeue_request(request_queue_t *q, struct request *rq)
 {
 	elevator_t *e = q->elevator;
 
+	BUG_ON(list_empty(&rq->queuelist));
+
+	list_del_init(&rq->queuelist);
+
 	/*
 	 * the time frame between a request being removed from the lists
 	 * and to it is freed is accounted as io that is in progress at
@@ -445,8 +521,11 @@ void elv_remove_request(request_queue_t 
 	 * driver has seen (REQ_STARTED set), to avoid false accounting
 	 * for request-request merges
 	 */
-	if (blk_account_rq(rq))
+	if (blk_account_rq(rq)) {
 		elv_inc_inflight(q);
+		if (blk_sorted_rq(rq) && e->ops->elevator_activate_req_fn)
+			e->ops->elevator_activate_req_fn(q, rq);
+	}
 
 	/*
 	 * the main clearing point for q->last_merge is on retrieval of
@@ -457,22 +536,19 @@ void elv_remove_request(request_queue_t 
 	 */
 	if (rq == q->last_merge)
 		q->last_merge = NULL;
-
-	if (e->ops->elevator_remove_req_fn) {
-		bar_rq_hack_start(q);
-		e->ops->elevator_remove_req_fn(q, rq);
-		bar_rq_hack_end(q);
-	}
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
@@ -544,11 +620,11 @@ void elv_completed_request(request_queue
 	/*
 	 * request is released from the driver, io must be done
 	 */
-	if (blk_account_rq(rq))
+	if (blk_account_rq(rq)) {
 		elv_dec_inflight(q);
-
-	if (e->ops->elevator_completed_req_fn)
-		e->ops->elevator_completed_req_fn(q, rq);
+		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
+			e->ops->elevator_completed_req_fn(q, rq);
+	}
 }
 
 int elv_register_queue(struct request_queue *q)
@@ -722,11 +798,12 @@ ssize_t elv_iosched_show(request_queue_t
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
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-06-16 13:55:37.000000000 +0900
@@ -519,16 +519,19 @@ void blk_ordered_complete_seq(request_qu
 
 static void pre_flush_end_io(struct request *rq, int error)
 {
+	elv_completed_request(rq->q, rq);
 	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_PREFLUSH, error);
 }
 
 static void bar_end_io(struct request *rq, int error)
 {
+	elv_completed_request(rq->q, rq);
 	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_BAR, error);
 }
 
 static void post_flush_end_io(struct request *rq, int error)
 {
+	elv_completed_request(rq->q, rq);
 	blk_ordered_complete_seq(rq->q, QUEUE_ORDSEQ_POSTFLUSH, error);
 }
 
@@ -1239,6 +1242,7 @@ EXPORT_SYMBOL(blk_queue_invalidate_tags)
 static char *rq_flags[] = {
 	"REQ_RW",
 	"REQ_FAILFAST",
+	"REQ_SORTED",
 	"REQ_SOFTBARRIER",
 	"REQ_HARDBARRIER",
 	"REQ_FUA",
@@ -2556,6 +2560,8 @@ static void __blk_put_request(request_qu
 	if (unlikely(--req->ref_count))
 		return;
 
+	elv_completed_request(q, req);
+
 	req->rq_status = RQ_INACTIVE;
 	req->rl = NULL;
 
@@ -2566,8 +2572,6 @@ static void __blk_put_request(request_qu
 	if (rl) {
 		int rw = rq_data_dir(req);
 
-		elv_completed_request(q, req);
-
 		BUG_ON(!list_empty(&req->queuelist));
 
 		blk_free_request(q, req);
@@ -2577,18 +2581,12 @@ static void __blk_put_request(request_qu
 
 void blk_put_request(struct request *req)
 {
-	/*
-	 * if req->rl isn't set, this request didnt originate from the
-	 * block layer, so it's safe to just disregard it
-	 */
-	if (req->rl) {
-		unsigned long flags;
-		request_queue_t *q = req->q;
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		__blk_put_request(q, req);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
+	unsigned long flags;
+	request_queue_t *q = req->q;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	__blk_put_request(q, req);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
 EXPORT_SYMBOL(blk_put_request);
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-06-16 13:55:37.000000000 +0900
@@ -203,6 +203,7 @@ struct request {
 enum rq_flag_bits {
 	__REQ_RW,		/* not set, read. set, write */
 	__REQ_FAILFAST,		/* no low level driver retries */
+	__REQ_SORTED,		/* elevator knows about this request */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
 	__REQ_HARDBARRIER,	/* may not be passed by drive either */
 	__REQ_FUA,		/* forced unit access */
@@ -233,6 +234,7 @@ enum rq_flag_bits {
 
 #define REQ_RW		(1 << __REQ_RW)
 #define REQ_FAILFAST	(1 << __REQ_FAILFAST)
+#define REQ_SORTED	(1 << __REQ_SORTED)
 #define REQ_SOFTBARRIER	(1 << __REQ_SOFTBARRIER)
 #define REQ_HARDBARRIER	(1 << __REQ_HARDBARRIER)
 #define REQ_FUA		(1 << __REQ_FUA)
@@ -326,6 +328,13 @@ struct request_queue
 	prepare_flush_fn	*prepare_flush_fn;
 
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
@@ -486,14 +495,14 @@ enum {
 #define blk_noretry_request(rq)	((rq)->flags & REQ_FAILFAST)
 #define blk_rq_started(rq)	((rq)->flags & REQ_STARTED)
 
-#define blk_account_rq(rq)	\
-	(blk_rq_started(rq) && blk_fs_request(rq) && rq != rq->q->bar_rq)
+#define blk_account_rq(rq)	(blk_rq_started(rq) && blk_fs_request(rq))
 
 #define blk_pm_suspend_request(rq)	((rq)->flags & REQ_PM_SUSPEND)
 #define blk_pm_resume_request(rq)	((rq)->flags & REQ_PM_RESUME)
 #define blk_pm_request(rq)	\
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
+#define blk_sorted_rq(rq)	((rq)->flags & REQ_SORTED)
 #define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
 #define blk_fua_rq(rq)		((rq)->flags & REQ_FUA)
 
@@ -648,12 +657,7 @@ extern void end_request(struct request *
 
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
--- blk-fixes.orig/include/linux/elevator.h	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/include/linux/elevator.h	2005-06-16 13:55:37.000000000 +0900
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
 typedef int (elevator_may_queue_fn) (request_queue_t *, int, struct bio *);
 
 typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, struct bio *, int);
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

