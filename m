Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVFPFCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVFPFCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 01:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVFPFCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 01:02:30 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:29965 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261743AbVFPE5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:57:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Z4Q8W1xXfr529Ub88lKDzAHyiHqLoafoC0hagKe5Fezt7N8/zmuzVDajrtf4HdocmBEAk6f/TZU0xl7dBTVG7DUHTkMbVAwXoBy0BbpKkOxewHUqRaAbb/J4O91bh2bgeaQ8lzcK5l/+KmGWNKrCz4nneftQTtJpf6KnYgYbDD4=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 03/06] blk: update cfq iosched to use generic dispatch queue
Message-ID: <20050616045540.300EF092@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:56:53 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_blk_dispatch_queue_cfq.patch

	Update cfq iosched to use generic dispatch queue

Signed-off-by: Tejun Heo <htejun@gmail.com>

 cfq-iosched.c |  313 +++++++++++++---------------------------------------------
 1 files changed, 72 insertions(+), 241 deletions(-)

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-06-16 13:55:38.000000000 +0900
@@ -83,7 +83,6 @@ static int cfq_max_depth = 1;
 	(node)->rb_left = NULL;		\
 } while (0)
 #define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
-#define ON_RB(node)		((node)->rb_color != RB_NONE)
 #define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
 #define rq_rb_key(rq)		(rq)->sector
 
@@ -233,14 +232,11 @@ struct cfq_rq {
 	struct cfq_queue *cfq_queue;
 	struct cfq_io_context *io_context;
 
-	unsigned in_flight : 1;
-	unsigned accounted : 1;
 	unsigned is_sync   : 1;
-	unsigned requeued  : 1;
 };
 
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned int);
-static void cfq_dispatch_sort(request_queue_t *, struct cfq_rq *);
+static void cfq_dispatch_insert(request_queue_t *, struct cfq_rq *, int);
 static void cfq_put_cfqd(struct cfq_data *cfqd);
 
 #define process_sync(tsk)	((tsk)->flags & PF_SYNCWRITE)
@@ -253,14 +249,6 @@ static inline void cfq_del_crq_hash(stru
 	hlist_del_init(&crq->hash);
 }
 
-static void cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
-{
-	cfq_del_crq_hash(crq);
-
-	if (q->last_merge == crq->request)
-		q->last_merge = NULL;
-}
-
 static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
 	const int hash_idx = CFQ_MHASH_FN(rq_hash_key(crq->request));
@@ -305,10 +293,6 @@ cfq_choose_req(struct cfq_data *cfqd, st
 		return crq2;
 	if (crq2 == NULL)
 		return crq1;
-	if (crq1->requeued)
-		return crq1;
-	if (crq2->requeued)
-		return crq2;
 
 	s1 = crq1->request->sector;
 	s2 = crq2->request->sector;
@@ -375,10 +359,7 @@ cfq_find_next_crq(struct cfq_data *cfqd,
 	struct cfq_rq *crq_next = NULL, *crq_prev = NULL;
 	struct rb_node *rbnext, *rbprev;
 
-	rbnext = NULL;
-	if (ON_RB(&last->rb_node))
-		rbnext = rb_next(&last->rb_node);
-	if (!rbnext) {
+	if (!(rbnext = rb_next(&last->rb_node))) {
 		rbnext = rb_first(&cfqq->sort_list);
 		if (rbnext == &last->rb_node)
 			rbnext = NULL;
@@ -459,13 +440,13 @@ static void cfq_resort_rr_list(struct cf
  * the pending list according to last request service
  */
 static inline void
-cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq, int requeue)
+cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
 	BUG_ON(cfqq->on_rr);
 	cfqq->on_rr = 1;
 	cfqd->busy_queues++;
 
-	cfq_resort_rr_list(cfqq, requeue);
+	cfq_resort_rr_list(cfqq, 0);
 }
 
 static inline void
@@ -485,22 +466,20 @@ cfq_del_cfqq_rr(struct cfq_data *cfqd, s
 static inline void cfq_del_crq_rb(struct cfq_rq *crq)
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_data *cfqd = cfqq->cfqd;
+	const int sync = crq->is_sync;
 
-	if (ON_RB(&crq->rb_node)) {
-		struct cfq_data *cfqd = cfqq->cfqd;
-		const int sync = crq->is_sync;
+	BUG_ON(!cfqq->queued[sync]);
+	cfqq->queued[sync]--;
 
-		BUG_ON(!cfqq->queued[sync]);
-		cfqq->queued[sync]--;
+	cfq_update_next_crq(crq);
 
-		cfq_update_next_crq(crq);
+	rb_erase(&crq->rb_node, &cfqq->sort_list);
+	RB_CLEAR_COLOR(&crq->rb_node);
 
-		rb_erase(&crq->rb_node, &cfqq->sort_list);
-		RB_CLEAR_COLOR(&crq->rb_node);
+	if (cfqq->on_rr && RB_EMPTY(&cfqq->sort_list))
+		cfq_del_cfqq_rr(cfqd, cfqq);
 
-		if (cfqq->on_rr && RB_EMPTY(&cfqq->sort_list))
-			cfq_del_cfqq_rr(cfqd, cfqq);
-	}
 }
 
 static struct cfq_rq *
@@ -541,12 +520,12 @@ static void cfq_add_crq_rb(struct cfq_rq
 	 * if that happens, put the alias on the dispatch list
 	 */
 	while ((__alias = __cfq_add_crq_rb(crq)) != NULL)
-		cfq_dispatch_sort(cfqd->queue, __alias);
+		cfq_dispatch_insert(cfqd->queue, __alias, 1);
 
 	rb_insert_color(&crq->rb_node, &cfqq->sort_list);
 
 	if (!cfqq->on_rr)
-		cfq_add_cfqq_rr(cfqd, cfqq, crq->requeued);
+		cfq_add_cfqq_rr(cfqd, cfqq);
 
 	/*
 	 * check if this request is a better next-serve candidate
@@ -557,10 +536,8 @@ static void cfq_add_crq_rb(struct cfq_rq
 static inline void
 cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	if (ON_RB(&crq->rb_node)) {
-		rb_erase(&crq->rb_node, &cfqq->sort_list);
-		cfqq->queued[crq->is_sync]--;
-	}
+	rb_erase(&crq->rb_node, &cfqq->sort_list);
+	cfqq->queued[crq->is_sync]--;
 
 	cfq_add_crq_rb(crq);
 }
@@ -590,47 +567,28 @@ out:
 	return NULL;
 }
 
-static void cfq_deactivate_request(request_queue_t *q, struct request *rq)
+static void cfq_activate_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_rq *crq = RQ_DATA(rq);
-
-	if (crq) {
-		struct cfq_queue *cfqq = crq->cfq_queue;
 
-		if (crq->accounted) {
-			crq->accounted = 0;
-			WARN_ON(!cfqd->rq_in_driver);
-			cfqd->rq_in_driver--;
-		}
-		if (crq->in_flight) {
-			crq->in_flight = 0;
-			WARN_ON(!cfqq->in_flight);
-			cfqq->in_flight--;
-		}
-		crq->requeued = 1;
-	}
+	cfqd->rq_in_driver++;
 }
 
-/*
- * make sure the service time gets corrected on reissue of this request
- */
-static void cfq_requeue_request(request_queue_t *q, struct request *rq)
+static void cfq_deactivate_request(request_queue_t *q, struct request *rq)
 {
-	cfq_deactivate_request(q, rq);
-	list_add(&rq->queuelist, &q->queue_head);
+	struct cfq_data *cfqd = q->elevator->elevator_data;
+
+	WARN_ON(!cfqd->rq_in_driver);
+	cfqd->rq_in_driver--;
 }
 
-static void cfq_remove_request(request_queue_t *q, struct request *rq)
+static void cfq_remove_request(struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
 
-	if (crq) {
-		list_del_init(&rq->queuelist);
-		cfq_del_crq_rb(crq);
-		cfq_remove_merge_hints(q, crq);
-
-	}
+	list_del_init(&rq->queuelist);
+	cfq_del_crq_rb(crq);
+	cfq_del_crq_hash(crq);
 }
 
 static int
@@ -674,7 +632,7 @@ static void cfq_merged_request(request_q
 	cfq_del_crq_hash(crq);
 	cfq_add_crq_hash(cfqd, crq);
 
-	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
+	if (rq_rb_key(req) != crq->rb_key) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
 		cfq_update_next_crq(crq);
@@ -697,7 +655,7 @@ cfq_merged_requests(request_queue_t *q, 
 	    time_before(next->start_time, rq->start_time))
 		list_move(&rq->queuelist, &next->queuelist);
 
-	cfq_remove_request(q, next);
+	cfq_remove_request(next);
 }
 
 static inline void
@@ -878,52 +836,16 @@ static int cfq_arm_slice_timer(struct cf
 	return 1;
 }
 
-/*
- * we dispatch cfqd->cfq_quantum requests in total from the rr_list queues,
- * this function sector sorts the selected request to minimize seeks. we start
- * at cfqd->last_sector, not 0.
- */
-static void cfq_dispatch_sort(request_queue_t *q, struct cfq_rq *crq)
+static void cfq_dispatch_insert(request_queue_t *q, struct cfq_rq *crq,
+				int force)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq = crq->cfq_queue;
-	struct list_head *head = &q->queue_head, *entry = head;
-	struct request *__rq;
-	sector_t last;
-
-	list_del(&crq->request->queuelist);
-
-	last = cfqd->last_sector;
-	list_for_each_entry_reverse(__rq, head, queuelist) {
-		struct cfq_rq *__crq = RQ_DATA(__rq);
-
-		if (blk_barrier_rq(__rq))
-			break;
-		if (!blk_fs_request(__rq))
-			break;
-		if (__crq->requeued)
-			break;
-
-		if (__rq->sector <= crq->request->sector)
-			break;
-		if (__rq->sector > last && crq->request->sector < last) {
-			last = crq->request->sector + crq->request->nr_sectors;
-			break;
-		}
-		entry = &__rq->queuelist;
-	}
-
-	cfqd->last_sector = last;
 
 	cfqq->next_crq = cfq_find_next_crq(cfqd, cfqq, crq);
-
-	cfq_del_crq_rb(crq);
-	cfq_remove_merge_hints(q, crq);
-
-	crq->in_flight = 1;
-	crq->requeued = 0;
+	cfq_remove_request(crq->request);
 	cfqq->in_flight++;
-	list_add_tail(&crq->request->queuelist, entry);
+	elv_dispatch_insert(q, crq->request, force);
 }
 
 /*
@@ -1020,7 +942,7 @@ keep_queue:
 
 static int
 __cfq_dispatch_requests(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-			int max_dispatch)
+			int max_dispatch, int force)
 {
 	int dispatched = 0;
 
@@ -1038,7 +960,7 @@ __cfq_dispatch_requests(struct cfq_data 
 		/*
 		 * finally, insert request into driver dispatch list
 		 */
-		cfq_dispatch_sort(cfqd->queue, crq);
+		cfq_dispatch_insert(cfqd->queue, crq, force);
 
 		cfqd->dispatch_slice++;
 		dispatched++;
@@ -1073,7 +995,7 @@ __cfq_dispatch_requests(struct cfq_data 
 }
 
 static int
-cfq_dispatch_requests(request_queue_t *q, int max_dispatch, int force)
+cfq_dispatch_requests(request_queue_t *q, int force)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
@@ -1083,96 +1005,31 @@ cfq_dispatch_requests(request_queue_t *q
 
 	cfqq = cfq_select_queue(cfqd, force);
 	if (cfqq) {
+		int max_dispatch;
+
+		/*
+		 * if idle window is disabled, allow queue buildup
+		 */
+		if (!cfqq->idle_window &&
+		    cfqd->rq_in_driver >= cfqd->cfq_max_depth)
+			return 0;
+
 		cfqq->wait_request = 0;
 		cfqq->must_dispatch = 0;
 		del_timer(&cfqd->idle_slice_timer);
 
-		if (cfq_class_idle(cfqq))
-			max_dispatch = 1;
+		if (force)
+			max_dispatch = INT_MAX;
+		else
+			max_dispatch =
+				cfq_class_idle(cfqq) ? 1 : cfqd->cfq_quantum;
 
-		return __cfq_dispatch_requests(cfqd, cfqq, max_dispatch);
+		return __cfq_dispatch_requests(cfqd, cfqq, max_dispatch, force);
 	}
 
 	return 0;
 }
 
-static inline void cfq_account_dispatch(struct cfq_rq *crq)
-{
-	struct cfq_queue *cfqq = crq->cfq_queue;
-	struct cfq_data *cfqd = cfqq->cfqd;
-
-	if (unlikely(!blk_fs_request(crq->request)))
-		return;
-
-	/*
-	 * accounted bit is necessary since some drivers will call
-	 * elv_next_request() many times for the same request (eg ide)
-	 */
-	if (crq->accounted)
-		return;
-
-	crq->accounted = 1;
-	cfqd->rq_in_driver++;
-}
-
-static inline void
-cfq_account_completion(struct cfq_queue *cfqq, struct cfq_rq *crq)
-{
-	struct cfq_data *cfqd = cfqq->cfqd;
-	unsigned long now;
-
-	if (!crq->accounted)
-		return;
-
-	now = jiffies;
-
-	WARN_ON(!cfqd->rq_in_driver);
-	cfqd->rq_in_driver--;
-
-	if (!cfq_class_idle(cfqq))
-		cfqd->last_end_request = now;
-
-	if (!cfqq->in_flight && cfqq->on_rr) {
-		cfqq->service_last = now;
-		cfq_resort_rr_list(cfqq, 0);
-	}
-
-	if (crq->is_sync)
-		crq->io_context->last_end_request = now;
-}
-
-static struct request *cfq_next_request(request_queue_t *q)
-{
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct request *rq;
-
-	if (!list_empty(&q->queue_head)) {
-		struct cfq_rq *crq;
-dispatch:
-		rq = list_entry_rq(q->queue_head.next);
-
-		crq = RQ_DATA(rq);
-		if (crq) {
-			/*
-			 * if idle window is disabled, allow queue buildup
-			 */
-			if (!crq->in_flight && !crq->cfq_queue->idle_window &&
-			    cfqd->rq_in_driver >= cfqd->cfq_max_depth)
-				return NULL;
-
-			cfq_remove_merge_hints(q, crq);
-			cfq_account_dispatch(crq);
-		}
-
-		return rq;
-	}
-
-	if (cfq_dispatch_requests(q, cfqd->cfq_quantum, 0))
-		goto dispatch;
-
-	return NULL;
-}
-
 /*
  * task holds one reference to the queue, dropped when task exits. each crq
  * in-flight on this queue also holds a reference, dropped when crq is freed.
@@ -1675,8 +1532,9 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 	}
 }
 
-static void cfq_enqueue(struct cfq_data *cfqd, struct request *rq)
+static void cfq_insert_request(request_queue_t *q, struct request *rq)
 {
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 	struct cfq_queue *cfqq = crq->cfq_queue;
 
@@ -1696,38 +1554,6 @@ static void cfq_enqueue(struct cfq_data 
 	cfq_crq_enqueued(cfqd, cfqq, crq);
 }
 
-static void
-cfq_insert_request(request_queue_t *q, struct request *rq, int where)
-{
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-
-	switch (where) {
-		case ELEVATOR_INSERT_BACK:
-			while (cfq_dispatch_requests(q, INT_MAX, 1))
-				;
-			list_add_tail(&rq->queuelist, &q->queue_head);
-			/*
-			 * If we were idling with pending requests on
-			 * inactive cfqqs, force dispatching will
-			 * remove the idle timer and the queue won't
-			 * be kicked by __make_request() afterward.
-			 * Kick it here.
-			 */
-			kblockd_schedule_work(&cfqd->unplug_work);
-			break;
-		case ELEVATOR_INSERT_FRONT:
-			list_add(&rq->queuelist, &q->queue_head);
-			break;
-		case ELEVATOR_INSERT_SORT:
-			BUG_ON(!blk_fs_request(rq));
-			cfq_enqueue(cfqd, rq);
-			break;
-		default:
-			printk("%s: bad insert point %d\n", __FUNCTION__,where);
-			return;
-	}
-}
-
 static inline int cfq_pending_requests(struct cfq_data *cfqd)
 {
 	return !list_empty(&cfqd->queue->queue_head) || cfqd->busy_queues;
@@ -1743,19 +1569,27 @@ static int cfq_queue_empty(request_queue
 static void cfq_completed_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
-	struct cfq_queue *cfqq;
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_data *cfqd = cfqq->cfqd;
+	unsigned long now;
 
-	if (unlikely(!blk_fs_request(rq)))
-		return;
+	now = jiffies;
 
-	cfqq = crq->cfq_queue;
+	WARN_ON(!cfqd->rq_in_driver);
+	WARN_ON(!cfqq->in_flight);
+	cfqd->rq_in_driver--;
+	cfqq->in_flight--;
 
-	if (crq->in_flight) {
-		WARN_ON(!cfqq->in_flight);
-		cfqq->in_flight--;
+	if (!cfq_class_idle(cfqq))
+		cfqd->last_end_request = now;
+
+	if (!cfqq->in_flight && cfqq->on_rr) {
+		cfqq->service_last = now;
+		cfq_resort_rr_list(cfqq, 0);
 	}
 
-	cfq_account_completion(cfqq, crq);
+	if (crq->is_sync)
+		crq->io_context->last_end_request = now;
 }
 
 static struct request *
@@ -1981,9 +1815,7 @@ cfq_set_request(request_queue_t *q, stru
 		INIT_HLIST_NODE(&crq->hash);
 		crq->cfq_queue = cfqq;
 		crq->io_context = cic;
-		crq->in_flight = crq->accounted = 0;
 		crq->is_sync = (rw == READ || process_sync(current));
-		crq->requeued = 0;
 		rq->elevator_private = crq;
 		return 0;
 	}
@@ -2426,10 +2258,9 @@ static struct elevator_type iosched_cfq 
 		.elevator_merge_fn = 		cfq_merge,
 		.elevator_merged_fn =		cfq_merged_request,
 		.elevator_merge_req_fn =	cfq_merged_requests,
-		.elevator_next_req_fn =		cfq_next_request,
+		.elevator_dispatch_fn =		cfq_dispatch_requests,
 		.elevator_add_req_fn =		cfq_insert_request,
-		.elevator_remove_req_fn =	cfq_remove_request,
-		.elevator_requeue_req_fn =	cfq_requeue_request,
+		.elevator_activate_req_fn =	cfq_activate_request,
 		.elevator_deactivate_req_fn =	cfq_deactivate_request,
 		.elevator_queue_empty_fn =	cfq_queue_empty,
 		.elevator_completed_req_fn =	cfq_completed_request,

