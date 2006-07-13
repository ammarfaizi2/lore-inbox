Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWGMMpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWGMMpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWGMMpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:45:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38191 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932513AbWGMMoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:08 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 14/15 cfq-iosched: kill crq
Date: Thu, 13 Jul 2006 14:46:37 +0200
Message-Id: <11527947992647-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the cfq_rq request type. With the added elevator_private2, we
have enough room in struct request to get rid of any crq allocation/free
for each request.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/cfq-iosched.c |  239 ++++++++++++++++++++-------------------------------
 1 files changed, 95 insertions(+), 144 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c97e387..d0e49da 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -43,9 +43,9 @@ #define list_entry_qhash(entry)	hlist_en
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
 
-#define RQ_DATA(rq)		(rq)->elevator_private
+#define RQ_CIC(rq)		((struct cfq_io_context*)(rq)->elevator_private)
+#define RQ_CFQQ(rq)		((rq)->elevator_private2)
 
-static kmem_cache_t *crq_pool;
 static kmem_cache_t *cfq_pool;
 static kmem_cache_t *cfq_ioc_pool;
 
@@ -95,8 +95,6 @@ struct cfq_data {
 	 */
 	struct hlist_head *cfq_hash;
 
-	mempool_t *crq_pool;
-
 	int rq_in_driver;
 	int hw_tag;
 
@@ -153,7 +151,7 @@ struct cfq_queue {
 	/* sorted list of pending requests */
 	struct rb_root sort_list;
 	/* if fifo isn't expired, next request to serve */
-	struct cfq_rq *next_crq;
+	struct request *next_rq;
 	/* requests queued in sort_list */
 	int queued[2];
 	/* currently allocated requests */
@@ -177,13 +175,6 @@ struct cfq_queue {
 	unsigned int flags;
 };
 
-struct cfq_rq {
-	struct request *request;
-
-	struct cfq_queue *cfq_queue;
-	struct cfq_io_context *io_context;
-};
-
 enum cfqq_state_flags {
 	CFQ_CFQQ_FLAG_on_rr = 0,
 	CFQ_CFQQ_FLAG_wait_request,
@@ -220,7 +211,7 @@ CFQ_CFQQ_FNS(prio_changed);
 #undef CFQ_CFQQ_FNS
 
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned int, unsigned short);
-static void cfq_dispatch_insert(request_queue_t *, struct cfq_rq *);
+static void cfq_dispatch_insert(request_queue_t *, struct request *);
 static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, unsigned int key, struct task_struct *tsk, gfp_t gfp_mask);
 
 /*
@@ -249,12 +240,12 @@ static inline pid_t cfq_queue_pid(struct
 }
 
 /*
- * Lifted from AS - choose which of crq1 and crq2 that is best served now.
+ * Lifted from AS - choose which of rq1 and rq2 that is best served now.
  * We choose the request that is closest to the head right now. Distance
  * behind the head is penalized and only allowed to a certain extent.
  */
-static struct cfq_rq *
-cfq_choose_req(struct cfq_data *cfqd, struct cfq_rq *crq1, struct cfq_rq *crq2)
+static struct request *
+cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2)
 {
 	sector_t last, s1, s2, d1 = 0, d2 = 0;
 	unsigned long back_max;
@@ -262,18 +253,18 @@ #define CFQ_RQ1_WRAP	0x01 /* request 1 w
 #define CFQ_RQ2_WRAP	0x02 /* request 2 wraps */
 	unsigned wrap = 0; /* bit mask: requests behind the disk head? */
 
-	if (crq1 == NULL || crq1 == crq2)
-		return crq2;
-	if (crq2 == NULL)
-		return crq1;
+	if (rq1 == NULL || rq1 == rq2)
+		return rq2;
+	if (rq2 == NULL)
+		return rq1;
 
-	if (rq_is_sync(crq1->request) && !rq_is_sync(crq2->request))
-		return crq1;
-	else if (rq_is_sync(crq2->request) && !rq_is_sync(crq1->request))
-		return crq2;
+	if (rq_is_sync(rq1) && !rq_is_sync(rq2))
+		return rq1;
+	else if (rq_is_sync(rq2) && !rq_is_sync(rq1))
+		return rq2;
 
-	s1 = crq1->request->sector;
-	s2 = crq2->request->sector;
+	s1 = rq1->sector;
+	s2 = rq2->sector;
 
 	last = cfqd->last_sector;
 
@@ -308,23 +299,23 @@ #define CFQ_RQ2_WRAP	0x02 /* request 2 w
 	 * check two variables for all permutations: --> faster!
 	 */
 	switch (wrap) {
-	case 0: /* common case for CFQ: crq1 and crq2 not wrapped */
+	case 0: /* common case for CFQ: rq1 and rq2 not wrapped */
 		if (d1 < d2)
-			return crq1;
+			return rq1;
 		else if (d2 < d1)
-			return crq2;
+			return rq2;
 		else {
 			if (s1 >= s2)
-				return crq1;
+				return rq1;
 			else
-				return crq2;
+				return rq2;
 		}
 
 	case CFQ_RQ2_WRAP:
-		return crq1;
+		return rq1;
 	case CFQ_RQ1_WRAP:
-		return crq2;
-	case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both crqs wrapped */
+		return rq2;
+	case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both rqs wrapped */
 	default:
 		/*
 		 * Since both rqs are wrapped,
@@ -333,35 +324,34 @@ #define CFQ_RQ2_WRAP	0x02 /* request 2 w
 		 * since back seek takes more time than forward.
 		 */
 		if (s1 <= s2)
-			return crq1;
+			return rq1;
 		else
-			return crq2;
+			return rq2;
 	}
 }
 
 /*
  * would be nice to take fifo expire time into account as well
  */
-static struct cfq_rq *
-cfq_find_next_crq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		  struct cfq_rq *last_crq)
+static struct request *
+cfq_find_next_rq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+		  struct request *last)
 {
-	struct request *last = last_crq->request;
 	struct rb_node *rbnext = rb_next(&last->rb_node);
 	struct rb_node *rbprev = rb_prev(&last->rb_node);
-	struct cfq_rq *next = NULL, *prev = NULL;
+	struct request *next = NULL, *prev = NULL;
 
 	BUG_ON(RB_EMPTY_NODE(&last->rb_node));
 
 	if (rbprev)
-		prev = RQ_DATA(rb_entry_rq(rbprev));
+		prev = rb_entry_rq(rbprev);
 
 	if (rbnext)
-		next = RQ_DATA(rb_entry_rq(rbnext));
+		next = rb_entry_rq(rbnext);
 	else {
 		rbnext = rb_first(&cfqq->sort_list);
 		if (rbnext && rbnext != &last->rb_node)
-			next = RQ_DATA(rb_entry_rq(rbnext));
+			next = rb_entry_rq(rbnext);
 	}
 
 	return cfq_choose_req(cfqd, next, prev);
@@ -450,26 +440,25 @@ cfq_del_cfqq_rr(struct cfq_data *cfqd, s
 /*
  * rb tree support functions
  */
-static inline void cfq_del_crq_rb(struct cfq_rq *crq)
+static inline void cfq_del_rq_rb(struct request *rq)
 {
-	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 	struct cfq_data *cfqd = cfqq->cfqd;
-	const int sync = rq_is_sync(crq->request);
+	const int sync = rq_is_sync(rq);
 
 	BUG_ON(!cfqq->queued[sync]);
 	cfqq->queued[sync]--;
 
-	elv_rb_del(&cfqq->sort_list, crq->request);
+	elv_rb_del(&cfqq->sort_list, rq);
 
 	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY_ROOT(&cfqq->sort_list))
 		cfq_del_cfqq_rr(cfqd, cfqq);
 }
 
-static void cfq_add_crq_rb(struct cfq_rq *crq)
+static void cfq_add_rq_rb(struct request *rq)
 {
-	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 	struct cfq_data *cfqd = cfqq->cfqd;
-	struct request *rq = crq->request;
 	struct request *__alias;
 
 	cfqq->queued[rq_is_sync(rq)]++;
@@ -479,17 +468,15 @@ static void cfq_add_crq_rb(struct cfq_rq
 	 * if that happens, put the alias on the dispatch list
 	 */
 	while ((__alias = elv_rb_add(&cfqq->sort_list, rq)) != NULL)
-		cfq_dispatch_insert(cfqd->queue, RQ_DATA(__alias));
+		cfq_dispatch_insert(cfqd->queue, __alias);
 }
 
 static inline void
-cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+cfq_reposition_rq_rb(struct cfq_queue *cfqq, struct request *rq)
 {
-	struct request *rq = crq->request;
-
 	elv_rb_del(&cfqq->sort_list, rq);
 	cfqq->queued[rq_is_sync(rq)]--;
-	cfq_add_crq_rb(crq);
+	cfq_add_rq_rb(rq);
 }
 
 static struct request *
@@ -533,14 +520,13 @@ static void cfq_deactivate_request(reque
 
 static void cfq_remove_request(struct request *rq)
 {
-	struct cfq_rq *crq = RQ_DATA(rq);
-	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 
-	if (cfqq->next_crq == crq)
-		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
+	if (cfqq->next_rq == rq)
+		cfqq->next_rq = cfq_find_next_rq(cfqq->cfqd, cfqq, rq);
 
 	list_del_init(&rq->queuelist);
-	cfq_del_crq_rb(crq);
+	cfq_del_rq_rb(rq);
 }
 
 static int
@@ -561,12 +547,10 @@ cfq_merge(request_queue_t *q, struct req
 static void cfq_merged_request(request_queue_t *q, struct request *req,
 			       int type)
 {
-	struct cfq_rq *crq = RQ_DATA(req);
-
 	if (type == ELEVATOR_FRONT_MERGE) {
-		struct cfq_queue *cfqq = crq->cfq_queue;
+		struct cfq_queue *cfqq = RQ_CFQQ(req);
 
-		cfq_reposition_crq_rb(cfqq, crq);
+		cfq_reposition_rq_rb(cfqq, req);
 	}
 }
 
@@ -789,11 +773,10 @@ static int cfq_arm_slice_timer(struct cf
 	return 1;
 }
 
-static void cfq_dispatch_insert(request_queue_t *q, struct cfq_rq *crq)
+static void cfq_dispatch_insert(request_queue_t *q, struct request *rq)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_queue *cfqq = crq->cfq_queue;
-	struct request *rq = crq->request;
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 
 	cfq_remove_request(rq);
 	cfqq->on_dispatch[rq_is_sync(rq)]++;
@@ -806,11 +789,10 @@ static void cfq_dispatch_insert(request_
 /*
  * return expired entry, or NULL to just start from scratch in rbtree
  */
-static inline struct cfq_rq *cfq_check_fifo(struct cfq_queue *cfqq)
+static inline struct request *cfq_check_fifo(struct cfq_queue *cfqq)
 {
 	struct cfq_data *cfqd = cfqq->cfqd;
 	struct request *rq;
-	struct cfq_rq *crq;
 
 	if (cfq_cfqq_fifo_expire(cfqq))
 		return NULL;
@@ -818,11 +800,10 @@ static inline struct cfq_rq *cfq_check_f
 	if (!list_empty(&cfqq->fifo)) {
 		int fifo = cfq_cfqq_class_sync(cfqq);
 
-		crq = RQ_DATA(rq_entry_fifo(cfqq->fifo.next));
-		rq = crq->request;
+		rq = rq_entry_fifo(cfqq->fifo.next);
 		if (time_after(jiffies, rq->start_time + cfqd->cfq_fifo_expire[fifo])) {
 			cfq_mark_cfqq_fifo_expire(cfqq);
-			return crq;
+			return rq;
 		}
 	}
 
@@ -909,25 +890,25 @@ __cfq_dispatch_requests(struct cfq_data 
 	BUG_ON(RB_EMPTY_ROOT(&cfqq->sort_list));
 
 	do {
-		struct cfq_rq *crq;
+		struct request *rq;
 
 		/*
 		 * follow expired path, else get first next available
 		 */
-		if ((crq = cfq_check_fifo(cfqq)) == NULL)
-			crq = cfqq->next_crq;
+		if ((rq = cfq_check_fifo(cfqq)) == NULL)
+			rq = cfqq->next_rq;
 
 		/*
 		 * finally, insert request into driver dispatch list
 		 */
-		cfq_dispatch_insert(cfqd->queue, crq);
+		cfq_dispatch_insert(cfqd->queue, rq);
 
 		cfqd->dispatch_slice++;
 		dispatched++;
 
 		if (!cfqd->active_cic) {
-			atomic_inc(&crq->io_context->ioc->refcount);
-			cfqd->active_cic = crq->io_context;
+			atomic_inc(&RQ_CIC(rq)->ioc->refcount);
+			cfqd->active_cic = RQ_CIC(rq);
 		}
 
 		if (RB_EMPTY_ROOT(&cfqq->sort_list))
@@ -958,13 +939,12 @@ static int
 cfq_forced_dispatch_cfqqs(struct list_head *list)
 {
 	struct cfq_queue *cfqq, *next;
-	struct cfq_rq *crq;
 	int dispatched;
 
 	dispatched = 0;
 	list_for_each_entry_safe(cfqq, next, list, cfq_list) {
-		while ((crq = cfqq->next_crq)) {
-			cfq_dispatch_insert(cfqq->cfqd->queue, crq);
+		while (cfqq->next_rq) {
+			cfq_dispatch_insert(cfqq->cfqd->queue, cfqq->next_rq);
 			dispatched++;
 		}
 		BUG_ON(!list_empty(&cfqq->fifo));
@@ -1040,8 +1020,8 @@ cfq_dispatch_requests(request_queue_t *q
 }
 
 /*
- * task holds one reference to the queue, dropped when task exits. each crq
- * in-flight on this queue also holds a reference, dropped when crq is freed.
+ * task holds one reference to the queue, dropped when task exits. each rq
+ * in-flight on this queue also holds a reference, dropped when rq is freed.
  *
  * queue lock must be held here.
  */
@@ -1486,15 +1466,15 @@ #endif
 
 static void
 cfq_update_io_seektime(struct cfq_data *cfqd, struct cfq_io_context *cic,
-		       struct cfq_rq *crq)
+		       struct request *rq)
 {
 	sector_t sdist;
 	u64 total;
 
-	if (cic->last_request_pos < crq->request->sector)
-		sdist = crq->request->sector - cic->last_request_pos;
+	if (cic->last_request_pos < rq->sector)
+		sdist = rq->sector - cic->last_request_pos;
 	else
-		sdist = cic->last_request_pos - crq->request->sector;
+		sdist = cic->last_request_pos - rq->sector;
 
 	/*
 	 * Don't allow the seek distance to get too large from the
@@ -1545,7 +1525,7 @@ cfq_update_idle_window(struct cfq_data *
  */
 static int
 cfq_should_preempt(struct cfq_data *cfqd, struct cfq_queue *new_cfqq,
-		   struct cfq_rq *crq)
+		   struct request *rq)
 {
 	struct cfq_queue *cfqq = cfqd->active_queue;
 
@@ -1564,7 +1544,7 @@ cfq_should_preempt(struct cfq_data *cfqd
 	 */
 	if (new_cfqq->slice_left < cfqd->cfq_slice_idle)
 		return 0;
-	if (rq_is_sync(crq->request) && !cfq_cfqq_sync(cfqq))
+	if (rq_is_sync(rq) && !cfq_cfqq_sync(cfqq))
 		return 1;
 
 	return 0;
@@ -1603,26 +1583,26 @@ static void cfq_start_queueing(struct cf
 }
 
 /*
- * Called when a new fs request (crq) is added (to cfqq). Check if there's
+ * Called when a new fs request (rq) is added (to cfqq). Check if there's
  * something we should do about it
  */
 static void
-cfq_crq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		 struct cfq_rq *crq)
+cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+		struct request *rq)
 {
-	struct cfq_io_context *cic = crq->io_context;
+	struct cfq_io_context *cic = RQ_CIC(rq);
 
 	/*
 	 * check if this request is a better next-serve candidate)) {
 	 */
-	cfqq->next_crq = cfq_choose_req(cfqd, cfqq->next_crq, crq);
-	BUG_ON(!cfqq->next_crq);
+	cfqq->next_rq = cfq_choose_req(cfqd, cfqq->next_rq, rq);
+	BUG_ON(!cfqq->next_rq);
 
 	/*
 	 * we never wait for an async request and we don't allow preemption
 	 * of an async request. so just return early
 	 */
-	if (!rq_is_sync(crq->request)) {
+	if (!rq_is_sync(rq)) {
 		/*
 		 * sync process issued an async request, if it's waiting
 		 * then expire it and kick rq handling.
@@ -1636,11 +1616,11 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 	}
 
 	cfq_update_io_thinktime(cfqd, cic);
-	cfq_update_io_seektime(cfqd, cic, crq);
+	cfq_update_io_seektime(cfqd, cic, rq);
 	cfq_update_idle_window(cfqd, cfqq, cic);
 
 	cic->last_queue = jiffies;
-	cic->last_request_pos = crq->request->sector + crq->request->nr_sectors;
+	cic->last_request_pos = rq->sector + rq->nr_sectors;
 
 	if (cfqq == cfqd->active_queue) {
 		/*
@@ -1653,7 +1633,7 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 			del_timer(&cfqd->idle_slice_timer);
 			cfq_start_queueing(cfqd, cfqq);
 		}
-	} else if (cfq_should_preempt(cfqd, cfqq, crq)) {
+	} else if (cfq_should_preempt(cfqd, cfqq, rq)) {
 		/*
 		 * not the active queue - expire current slice if it is
 		 * idle and has expired it's mean thinktime or this new queue
@@ -1668,25 +1648,23 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 static void cfq_insert_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_rq *crq = RQ_DATA(rq);
-	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 
 	cfq_init_prio_data(cfqq);
 
-	cfq_add_crq_rb(crq);
+	cfq_add_rq_rb(rq);
 
 	if (!cfq_cfqq_on_rr(cfqq))
 		cfq_add_cfqq_rr(cfqd, cfqq);
 
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 
-	cfq_crq_enqueued(cfqd, cfqq, crq);
+	cfq_rq_enqueued(cfqd, cfqq, rq);
 }
 
 static void cfq_completed_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_rq *crq = RQ_DATA(rq);
-	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 	struct cfq_data *cfqd = cfqq->cfqd;
 	const int sync = rq_is_sync(rq);
 	unsigned long now;
@@ -1709,7 +1687,7 @@ static void cfq_completed_request(reques
 	}
 
 	if (sync)
-		crq->io_context->last_end_request = now;
+		RQ_CIC(rq)->last_end_request = now;
 
 	/*
 	 * If this is the active queue, check if it needs to be expired,
@@ -1817,20 +1795,18 @@ static void cfq_check_waiters(request_qu
  */
 static void cfq_put_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_queue *cfqq = RQ_CFQQ(rq);
 
-	if (crq) {
-		struct cfq_queue *cfqq = crq->cfq_queue;
+	if (cfqq) {
 		const int rw = rq_data_dir(rq);
 
 		BUG_ON(!cfqq->allocated[rw]);
 		cfqq->allocated[rw]--;
 
-		put_io_context(crq->io_context->ioc);
+		put_io_context(RQ_CIC(rq)->ioc);
 
-		mempool_free(crq, cfqd->crq_pool);
 		rq->elevator_private = NULL;
+		rq->elevator_private2 = NULL;
 
 		cfq_check_waiters(q, cfqq);
 		cfq_put_queue(cfqq);
@@ -1850,7 +1826,6 @@ cfq_set_request(request_queue_t *q, stru
 	const int rw = rq_data_dir(rq);
 	pid_t key = cfq_queue_pid(tsk, rw);
 	struct cfq_queue *cfqq;
-	struct cfq_rq *crq;
 	unsigned long flags;
 	int is_sync = key != CFQ_KEY_ASYNC;
 
@@ -1876,23 +1851,13 @@ cfq_set_request(request_queue_t *q, stru
 	cfq_clear_cfqq_must_alloc(cfqq);
 	cfqd->rq_starved = 0;
 	atomic_inc(&cfqq->ref);
-	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
-	if (crq) {
-		crq->request = rq;
-		crq->cfq_queue = cfqq;
-		crq->io_context = cic;
+	spin_unlock_irqrestore(q->queue_lock, flags);
 
-		rq->elevator_private = crq;
-		return 0;
-	}
+	rq->elevator_private = cic;
+	rq->elevator_private2 = cfqq;
+	return 0;
 
-	spin_lock_irqsave(q->queue_lock, flags);
-	cfqq->allocated[rw]--;
-	if (!(cfqq->allocated[0] + cfqq->allocated[1]))
-		cfq_mark_cfqq_must_alloc(cfqq);
-	cfq_put_queue(cfqq);
 queue_fail:
 	if (cic)
 		put_io_context(cic->ioc);
@@ -2040,7 +2005,6 @@ static void cfq_exit_queue(elevator_t *e
 
 	cfq_shutdown_timer_wq(cfqd);
 
-	mempool_destroy(cfqd->crq_pool);
 	kfree(cfqd->cfq_hash);
 	kfree(cfqd);
 }
@@ -2067,11 +2031,7 @@ static void *cfq_init_queue(request_queu
 
 	cfqd->cfq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
 	if (!cfqd->cfq_hash)
-		goto out_crqhash;
-
-	cfqd->crq_pool = mempool_create_slab_pool(BLKDEV_MIN_RQ, crq_pool);
-	if (!cfqd->crq_pool)
-		goto out_crqpool;
+		goto out_free;
 
 	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
 		INIT_HLIST_HEAD(&cfqd->cfq_hash[i]);
@@ -2100,17 +2060,13 @@ static void *cfq_init_queue(request_queu
 	cfqd->cfq_slice_idle = cfq_slice_idle;
 
 	return cfqd;
-out_crqpool:
-	kfree(cfqd->cfq_hash);
-out_crqhash:
+out_free:
 	kfree(cfqd);
 	return NULL;
 }
 
 static void cfq_slab_kill(void)
 {
-	if (crq_pool)
-		kmem_cache_destroy(crq_pool);
 	if (cfq_pool)
 		kmem_cache_destroy(cfq_pool);
 	if (cfq_ioc_pool)
@@ -2119,11 +2075,6 @@ static void cfq_slab_kill(void)
 
 static int __init cfq_slab_setup(void)
 {
-	crq_pool = kmem_cache_create("crq_pool", sizeof(struct cfq_rq), 0, 0,
-					NULL, NULL);
-	if (!crq_pool)
-		goto fail;
-
 	cfq_pool = kmem_cache_create("cfq_pool", sizeof(struct cfq_queue), 0, 0,
 					NULL, NULL);
 	if (!cfq_pool)
-- 
1.4.1.ged0e0

