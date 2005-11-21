Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVKUHQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVKUHQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVKUHQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:16:24 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:33631 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751009AbVKUHQY (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 21 Nov 2005 02:16:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=Y9ODmy2sBvzqXP1CAvAOk4R1ZehPeH8eZ+9wywTupkk7zzSfLz+8+t8+GCRTqoNIIQ92xoazWSJGBgkorrx0E3+fKiS0RBUDnbXAo9Xb0ou/HRPbFGuzwdZvxp3+zHeDxPcPfNrRG+VXlCddYDQRBYR5RC4d/ZHtbRdDVXrDEBo=  ;
Message-ID: <438182E7.9080809@yahoo.com.au>
Date: Mon, 21 Nov 2005 19:18:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 2.6.15-rc2] blk: request poisoning
Content-Type: multipart/mixed;
 boundary="------------080700000905040404010409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700000905040404010409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch should make request poisoning more useful
and more easily extendible in the block layer.

Don't think I have hardware that will trigger a requeue,
but otherwise it has been moderately tested. Comments?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------080700000905040404010409
Content-Type: text/plain;
 name="blk-poison.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-poison.patch"

Move request poisoning out of as-iosched.c and into the generic block layer
so that other io schedulers may make use of the facility.

Wrap the operations in macros so they may easily be ifdefed out if found to
cause any performance slowdowns on some unnamed database benchmark.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/block/as-iosched.c
===================================================================
--- linux-2.6.orig/block/as-iosched.c	2005-11-21 18:24:43.000000000 +1100
+++ linux-2.6/block/as-iosched.c	2005-11-21 18:25:22.000000000 +1100
@@ -136,21 +136,6 @@ struct as_data {
 
 #define list_entry_fifo(ptr)	list_entry((ptr), struct as_rq, fifo)
 
-/*
- * per-request data.
- */
-enum arq_state {
-	AS_RQ_NEW=0,		/* New - not referenced and not on any lists */
-	AS_RQ_QUEUED,		/* In the request queue. It belongs to the
-				   scheduler */
-	AS_RQ_DISPATCHED,	/* On the dispatch list. It belongs to the
-				   driver now */
-	AS_RQ_PRESCHED,		/* Debug poisoning for requests being used */
-	AS_RQ_REMOVED,
-	AS_RQ_MERGED,
-	AS_RQ_POSTSCHED,	/* when they shouldn't be */
-};
-
 struct as_rq {
 	/*
 	 * rbtree index, key is the starting offset
@@ -175,7 +160,6 @@ struct as_rq {
 	unsigned long expires;
 
 	unsigned int is_sync;
-	enum arq_state state;
 };
 
 #define RQ_DATA(rq)	((struct as_rq *) (rq)->elevator_private)
@@ -973,12 +957,6 @@ static void as_completed_request(request
 
 	WARN_ON(!list_empty(&rq->queuelist));
 
-	if (arq->state != AS_RQ_REMOVED) {
-		printk("arq->state %d\n", arq->state);
-		WARN_ON(1);
-		goto out;
-	}
-
 	if (ad->changed_batch && ad->nr_dispatched == 1) {
 		kblockd_schedule_work(&ad->antic_work);
 		ad->changed_batch = 0;
@@ -1014,8 +992,6 @@ static void as_completed_request(request
 	}
 
 	as_put_io_context(arq);
-out:
-	arq->state = AS_RQ_POSTSCHED;
 }
 
 /*
@@ -1030,8 +1006,6 @@ static void as_remove_queued_request(req
 	const int data_dir = arq->is_sync;
 	struct as_data *ad = q->elevator->elevator_data;
 
-	WARN_ON(arq->state != AS_RQ_QUEUED);
-
 	if (arq->io_context && arq->io_context->aic) {
 		BUG_ON(!atomic_read(&arq->io_context->aic->nr_queued));
 		atomic_dec(&arq->io_context->aic->nr_queued);
@@ -1144,18 +1118,13 @@ static void as_move_to_dispatch(struct a
 		if (__arq->io_context && __arq->io_context->aic)
 			atomic_inc(&__arq->io_context->aic->nr_dispatched);
 
-		WARN_ON(__arq->state != AS_RQ_QUEUED);
-		__arq->state = AS_RQ_DISPATCHED;
-
 		ad->nr_dispatched++;
 	}
 
 	as_remove_queued_request(ad->q, rq);
-	WARN_ON(arq->state != AS_RQ_QUEUED);
 
 	elv_dispatch_sort(ad->q, rq);
 
-	arq->state = AS_RQ_DISPATCHED;
 	if (arq->io_context && arq->io_context->aic)
 		atomic_inc(&arq->io_context->aic->nr_dispatched);
 	ad->nr_dispatched++;
@@ -1340,11 +1309,7 @@ as_add_aliased_request(struct as_data *a
 	 */
 	while (!list_empty(&req->queuelist)) {
 		struct request *__rq = list_entry_rq(req->queuelist.next);
-		struct as_rq *__arq = RQ_DATA(__rq);
-
 		list_move_tail(&__rq->queuelist, &alias->request->queuelist);
-
-		WARN_ON(__arq->state != AS_RQ_QUEUED);
 	}
 
 	/*
@@ -1371,12 +1336,6 @@ static void as_add_request(request_queue
 	struct as_rq *alias;
 	int data_dir;
 
-	if (arq->state != AS_RQ_PRESCHED) {
-		printk("arq->state: %d\n", arq->state);
-		WARN_ON(1);
-	}
-	arq->state = AS_RQ_NEW;
-
 	if (rq_data_dir(arq->request) == READ
 			|| current->flags&PF_SYNCWRITE)
 		arq->is_sync = 1;
@@ -1417,16 +1376,12 @@ static void as_add_request(request_queue
 				as_antic_stop(ad);
 		}
 	}
-
-	arq->state = AS_RQ_QUEUED;
 }
 
 static void as_activate_request(request_queue_t *q, struct request *rq)
 {
 	struct as_rq *arq = RQ_DATA(rq);
 
-	WARN_ON(arq->state != AS_RQ_DISPATCHED);
-	arq->state = AS_RQ_REMOVED;
 	if (arq->io_context && arq->io_context->aic)
 		atomic_dec(&arq->io_context->aic->nr_dispatched);
 }
@@ -1435,8 +1390,6 @@ static void as_deactivate_request(reques
 {
 	struct as_rq *arq = RQ_DATA(rq);
 
-	WARN_ON(arq->state != AS_RQ_REMOVED);
-	arq->state = AS_RQ_DISPATCHED;
 	if (arq->io_context && arq->io_context->aic)
 		atomic_inc(&arq->io_context->aic->nr_dispatched);
 }
@@ -1618,11 +1571,7 @@ static void as_merged_requests(request_q
 	 */
 	while (!list_empty(&next->queuelist)) {
 		struct request *__rq = list_entry_rq(next->queuelist.next);
-		struct as_rq *__arq = RQ_DATA(__rq);
-
 		list_move_tail(&__rq->queuelist, &req->queuelist);
-
-		WARN_ON(__arq->state != AS_RQ_QUEUED);
 	}
 
 	/*
@@ -1630,8 +1579,6 @@ static void as_merged_requests(request_q
 	 */
 	as_remove_queued_request(q, next);
 	as_put_io_context(anext);
-
-	anext->state = AS_RQ_MERGED;
 }
 
 /*
@@ -1664,13 +1611,6 @@ static void as_put_request(request_queue
 		return;
 	}
 
-	if (unlikely(arq->state != AS_RQ_POSTSCHED &&
-		     arq->state != AS_RQ_PRESCHED &&
-		     arq->state != AS_RQ_MERGED)) {
-		printk("arq->state %d\n", arq->state);
-		WARN_ON(1);
-	}
-
 	mempool_free(arq, ad->arq_pool);
 	rq->elevator_private = NULL;
 }
@@ -1685,7 +1625,6 @@ static int as_set_request(request_queue_
 		memset(arq, 0, sizeof(*arq));
 		RB_CLEAR(&arq->rb_node);
 		arq->request = rq;
-		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
 		INIT_LIST_HEAD(&arq->hash);
 		arq->on_hash = 0;
Index: linux-2.6/block/elevator.c
===================================================================
--- linux-2.6.orig/block/elevator.c	2005-11-21 18:24:43.000000000 +1100
+++ linux-2.6/block/elevator.c	2005-11-21 19:02:41.000000000 +1100
@@ -222,6 +222,9 @@ void elv_dispatch_sort(request_queue_t *
 	sector_t boundary;
 	struct list_head *entry;
 
+        blk_verify_rq_state(rq, RQ_QUEUED);
+        blk_set_rq_state(rq, RQ_DISPATCHED);
+
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
 	q->nr_sorted--;
@@ -281,6 +284,10 @@ void elv_merge_requests(request_queue_t 
 {
 	elevator_t *e = q->elevator;
 
+	blk_verify_rq_state(rq, RQ_QUEUED);
+	blk_verify_rq_state(next, RQ_QUEUED);
+	blk_set_rq_state(next, RQ_ACTIVATED);
+
 	if (e->ops->elevator_merge_req_fn)
 		e->ops->elevator_merge_req_fn(q, rq, next);
 	q->nr_sorted--;
@@ -292,6 +299,8 @@ void elv_requeue_request(request_queue_t
 {
 	elevator_t *e = q->elevator;
 
+	blk_verify_rq_state(rq, RQ_ACTIVATED);
+
 	/*
 	 * it already went through dequeue, we need to decrement the
 	 * in_flight count again
@@ -357,13 +366,14 @@ void __elv_add_request(request_queue_t *
 	switch (where) {
 	case ELEVATOR_INSERT_FRONT:
 		rq->flags |= REQ_SOFTBARRIER;
-
+		blk_set_rq_state(rq, RQ_DISPATCHED);
 		list_add(&rq->queuelist, &q->queue_head);
 		break;
 
 	case ELEVATOR_INSERT_BACK:
 		rq->flags |= REQ_SOFTBARRIER;
 		elv_drain_elevator(q);
+		blk_set_rq_state(rq, RQ_DISPATCHED);
 		list_add_tail(&rq->queuelist, &q->queue_head);
 		/*
 		 * We kick the queue here for the following reasons.
@@ -390,6 +400,7 @@ void __elv_add_request(request_queue_t *
 		 * rq cannot be accessed after calling
 		 * elevator_add_req_fn.
 		 */
+		blk_set_rq_state(rq, RQ_QUEUED);
 		q->elevator->ops->elevator_add_req_fn(q, rq);
 		break;
 
@@ -413,6 +424,8 @@ void elv_add_request(request_queue_t *q,
 {
 	unsigned long flags;
 
+	blk_verify_rq_state(rq, RQ_NEW);
+
 	spin_lock_irqsave(q->queue_lock, flags);
 	__elv_add_request(q, rq, where, plug);
 	spin_unlock_irqrestore(q->queue_lock, flags);
@@ -457,6 +470,8 @@ struct request *elv_next_request(request
 			 * sees this request (possibly after
 			 * requeueing).  Notify IO scheduler.
 			 */
+			blk_verify_rq_state(rq, RQ_DISPATCHED);
+			blk_set_rq_state(rq, RQ_ACTIVATED);
 			if (blk_sorted_rq(rq) &&
 			    e->ops->elevator_activate_req_fn)
 				e->ops->elevator_activate_req_fn(q, rq);
@@ -589,6 +604,9 @@ void elv_completed_request(request_queue
 {
 	elevator_t *e = q->elevator;
 
+	blk_verify_rq_state(rq, RQ_ACTIVATED);
+	blk_set_rq_state(rq, RQ_COMPLETED);
+
 	/*
 	 * request is released from the driver, io must be done
 	 */
Index: linux-2.6/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/block/ll_rw_blk.c	2005-11-21 18:24:43.000000000 +1100
+++ linux-2.6/block/ll_rw_blk.c	2005-11-21 19:01:50.000000000 +1100
@@ -1795,6 +1795,8 @@ blk_alloc_request(request_queue_t *q, in
 	if (!rq)
 		return NULL;
 
+	blk_set_rq_state(rq, RQ_NEW);
+
 	/*
 	 * first three bits are identical in rq->flags and bio->bi_rw,
 	 * see bio.h and blkdev.h
@@ -2626,8 +2628,12 @@ void blk_attempt_remerge(request_queue_t
 {
 	unsigned long flags;
 
+	blk_verify_rq_state(rq, RQ_ACTIVATED);
+
 	spin_lock_irqsave(q->queue_lock, flags);
+	blk_set_rq_state(rq, RQ_QUEUED); /* hack around merge poisoning */
 	attempt_back_merge(q, rq);
+	blk_set_rq_state(rq, RQ_ACTIVATED);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h	2005-11-21 18:24:43.000000000 +1100
+++ linux-2.6/include/linux/blkdev.h	2005-11-21 19:06:09.000000000 +1100
@@ -115,6 +115,19 @@ struct request_list {
 #define BLK_MAX_CDB	16
 
 /*
+ * Request state within the block layer.
+ * For poisoning/debugging only.
+ */
+enum rq_blk_state {
+	RQ_NEW = 0,	/* No reference by block layer. Belongs to submitter */
+	RQ_QUEUED,	/* In the request queue. Belongs to io scheduler     */
+	RQ_DISPATCHED,	/* In the dispatch list. Belongs to dispatch list    */
+	RQ_ACTIVATED,	/* Off the dispatch list. Belongs to block driver
+			 * (or has been merged) */
+	RQ_COMPLETED,	/* Completed. Should not be seen again               */
+};
+
+/*
  * try to put the fields that are referenced together in the same cacheline
  */
 struct request {
@@ -195,8 +208,24 @@ struct request {
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
+
+	enum rq_blk_state blk_state;
 };
 
+#define blk_verify_rq_state(rq, desired)			\
+do {								\
+	if (unlikely((rq)->blk_state != (desired))) {		\
+		printk(KERN_ERR "Invalid request state (%d)\n",	\
+				(rq)->blk_state);		\
+		WARN_ON(1);					\
+	}							\
+} while (0)
+
+static inline void blk_set_rq_state(struct request *rq, enum rq_blk_state state)
+{
+	rq->blk_state = state;
+}
+
 /*
  * first three bits match BIO_RW* bits, important
  */
@@ -630,6 +659,9 @@ static inline void blkdev_dequeue_reques
 static inline void elv_dispatch_add_tail(struct request_queue *q,
 					 struct request *rq)
 {
+	blk_verify_rq_state(rq, RQ_QUEUED);
+	blk_set_rq_state(rq, RQ_DISPATCHED);
+
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
 	q->nr_sorted--;

--------------080700000905040404010409--
Send instant messages to your online friends http://au.messenger.yahoo.com 
