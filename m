Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWGLICT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWGLICT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWGLICS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:02:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750807AbWGLICM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:02:12 -0400
Date: Wed, 12 Jul 2006 10:04:59 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: [PATCH 3/7] elevator: abstract out the rbtree sort handling
Message-ID: <20060712080459.GD13920@suse.de>
References: <20060712080319.GA13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712080319.GA13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] elevator: abstract out the rbtree sort handling

The rbtree sort/lookup/reposition logic is mostly duplicated in
cfq/deadline/as, so move it to the elevator core. The io schedulers
still provide the actual rb root, as we don't want to impose any sort
of specific handling on the schedulers.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/as-iosched.c       |  180 +++++++---------------------------------------
 block/cfq-iosched.c      |  179 ++++++++++++----------------------------------
 block/deadline-iosched.c |  170 ++++++++-----------------------------------
 block/elevator.c         |   86 +++++++++++++++++++++-
 block/ll_rw_blk.c        |    7 +-
 include/linux/blkdev.h   |    1 
 include/linux/elevator.h |   19 ++++-
 7 files changed, 214 insertions(+), 428 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index d677029..000e776 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -149,12 +149,6 @@ enum arq_state {
 };
 
 struct as_rq {
-	/*
-	 * rbtree index, key is the starting offset
-	 */
-	struct rb_node rb_node;
-	sector_t rb_key;
-
 	struct request *request;
 
 	struct io_context *io_context;	/* The submitting task */
@@ -268,101 +262,22 @@ static void as_put_io_context(struct as_
 /*
  * rb tree support functions
  */
-#define rb_entry_arq(node)	rb_entry((node), struct as_rq, rb_node)
 #define ARQ_RB_ROOT(ad, arq)	(&(ad)->sort_list[(arq)->is_sync])
-#define rq_rb_key(rq)		(rq)->sector
-
-/*
- * as_find_first_arq finds the first (lowest sector numbered) request
- * for the specified data_dir. Used to sweep back to the start of the disk
- * (1-way elevator) after we process the last (highest sector) request.
- */
-static struct as_rq *as_find_first_arq(struct as_data *ad, int data_dir)
-{
-	struct rb_node *n = ad->sort_list[data_dir].rb_node;
-
-	if (n == NULL)
-		return NULL;
-
-	for (;;) {
-		if (n->rb_left == NULL)
-			return rb_entry_arq(n);
-
-		n = n->rb_left;
-	}
-}
-
-/*
- * Add the request to the rb tree if it is unique.  If there is an alias (an
- * existing request against the same sector), which can happen when using
- * direct IO, then return the alias.
- */
-static struct as_rq *__as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
-{
-	struct rb_node **p = &ARQ_RB_ROOT(ad, arq)->rb_node;
-	struct rb_node *parent = NULL;
-	struct as_rq *__arq;
-	struct request *rq = arq->request;
-
-	arq->rb_key = rq_rb_key(rq);
-
-	while (*p) {
-		parent = *p;
-		__arq = rb_entry_arq(parent);
-
-		if (arq->rb_key < __arq->rb_key)
-			p = &(*p)->rb_left;
-		else if (arq->rb_key > __arq->rb_key)
-			p = &(*p)->rb_right;
-		else
-			return __arq;
-	}
-
-	rb_link_node(&arq->rb_node, parent, p);
-	rb_insert_color(&arq->rb_node, ARQ_RB_ROOT(ad, arq));
 
-	return NULL;
-}
-
-static void as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
+static void as_add_arq_rb(struct as_data *ad, struct request *rq)
 {
-	struct as_rq *alias;
+	struct as_rq *arq = RQ_DATA(rq);
+	struct request *alias;
 
-	while ((unlikely(alias = __as_add_arq_rb(ad, arq)))) {
-		as_move_to_dispatch(ad, alias);
+	while ((unlikely(alias = elv_rb_add(ARQ_RB_ROOT(ad, arq), rq)))) {
+		as_move_to_dispatch(ad, RQ_DATA(alias));
 		as_antic_stop(ad);
 	}
 }
 
-static inline void as_del_arq_rb(struct as_data *ad, struct as_rq *arq)
-{
-	if (RB_EMPTY_NODE(&arq->rb_node)) {
-		WARN_ON(1);
-		return;
-	}
-
-	rb_erase(&arq->rb_node, ARQ_RB_ROOT(ad, arq));
-	RB_CLEAR_NODE(&arq->rb_node);
-}
-
-static struct request *
-as_find_arq_rb(struct as_data *ad, sector_t sector, int data_dir)
+static inline void as_del_arq_rb(struct as_data *ad, struct request *rq)
 {
-	struct rb_node *n = ad->sort_list[data_dir].rb_node;
-	struct as_rq *arq;
-
-	while (n) {
-		arq = rb_entry_arq(n);
-
-		if (sector < arq->rb_key)
-			n = n->rb_left;
-		else if (sector > arq->rb_key)
-			n = n->rb_right;
-		else
-			return arq->request;
-	}
-
-	return NULL;
+	elv_rb_del(ARQ_RB_ROOT(ad, RQ_DATA(rq)), rq);
 }
 
 /*
@@ -455,32 +370,29 @@ as_choose_req(struct as_data *ad, struct
  * this with as_choose_req form the basis for how the scheduler chooses
  * what request to process next. Anticipation works on top of this.
  */
-static struct as_rq *as_find_next_arq(struct as_data *ad, struct as_rq *last)
+static struct as_rq *as_find_next_arq(struct as_data *ad, struct as_rq *arq)
 {
-	const int data_dir = last->is_sync;
-	struct as_rq *ret;
+	struct request *last = arq->request;
 	struct rb_node *rbnext = rb_next(&last->rb_node);
 	struct rb_node *rbprev = rb_prev(&last->rb_node);
-	struct as_rq *arq_next, *arq_prev;
+	struct as_rq *next = NULL, *prev = NULL;
 
-	BUG_ON(!RB_EMPTY_NODE(&last->rb_node));
+	BUG_ON(RB_EMPTY_NODE(&last->rb_node));
 
 	if (rbprev)
-		arq_prev = rb_entry_arq(rbprev);
-	else
-		arq_prev = NULL;
+		prev = RQ_DATA(rb_entry_rq(rbprev));
 
 	if (rbnext)
-		arq_next = rb_entry_arq(rbnext);
+		next = RQ_DATA(rb_entry_rq(rbnext));
 	else {
-		arq_next = as_find_first_arq(ad, data_dir);
-		if (arq_next == last)
-			arq_next = NULL;
-	}
+		const int data_dir = arq->is_sync;
 
-	ret = as_choose_req(ad,	arq_next, arq_prev);
+		rbnext = rb_first(&ad->sort_list[data_dir]);
+		if (rbnext && rbnext != &last->rb_node)
+			next = RQ_DATA(rb_entry_rq(rbnext));
+	}
 
-	return ret;
+	return as_choose_req(ad, next, prev);
 }
 
 /*
@@ -982,7 +894,7 @@ static void as_remove_queued_request(req
 		ad->next_arq[data_dir] = as_find_next_arq(ad, arq);
 
 	list_del_init(&arq->fifo);
-	as_del_arq_rb(ad, arq);
+	as_del_arq_rb(ad, rq);
 }
 
 /*
@@ -1039,7 +951,7 @@ static void as_move_to_dispatch(struct a
 	struct request *rq = arq->request;
 	const int data_dir = arq->is_sync;
 
-	BUG_ON(RB_EMPTY_NODE(&arq->rb_node));
+	BUG_ON(RB_EMPTY_NODE(&rq->rb_node));
 
 	as_antic_stop(ad);
 	ad->antic_status = ANTIC_OFF;
@@ -1064,8 +976,6 @@ static void as_move_to_dispatch(struct a
 	}
 	ad->ioc_finished = 0;
 
-	ad->next_arq[data_dir] = as_find_next_arq(ad, arq);
-
 	/*
 	 * take it off the sort and fifo list, add to dispatch queue
 	 */
@@ -1269,7 +1179,7 @@ static void as_add_request(request_queue
 		atomic_inc(&arq->io_context->aic->nr_queued);
 	}
 
-	as_add_arq_rb(ad, arq);
+	as_add_arq_rb(ad, rq);
 
 	/*
 	 * set expire time (only used for reads) and add to fifo list
@@ -1315,32 +1225,6 @@ static int as_queue_empty(request_queue_
 		&& list_empty(&ad->fifo_list[REQ_SYNC]);
 }
 
-static struct request *as_former_request(request_queue_t *q,
-					struct request *rq)
-{
-	struct as_rq *arq = RQ_DATA(rq);
-	struct rb_node *rbprev = rb_prev(&arq->rb_node);
-	struct request *ret = NULL;
-
-	if (rbprev)
-		ret = rb_entry_arq(rbprev)->request;
-
-	return ret;
-}
-
-static struct request *as_latter_request(request_queue_t *q,
-					struct request *rq)
-{
-	struct as_rq *arq = RQ_DATA(rq);
-	struct rb_node *rbnext = rb_next(&arq->rb_node);
-	struct request *ret = NULL;
-
-	if (rbnext)
-		ret = rb_entry_arq(rbnext)->request;
-
-	return ret;
-}
-
 static int
 as_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
@@ -1351,7 +1235,7 @@ as_merge(request_queue_t *q, struct requ
 	/*
 	 * check for front merge
 	 */
-	__rq = as_find_arq_rb(ad, rb_key, bio_data_dir(bio));
+	__rq = elv_rb_find(&ad->sort_list[bio_data_dir(bio)], rb_key);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		*req = __rq;
 		return ELEVATOR_FRONT_MERGE;
@@ -1360,7 +1244,7 @@ as_merge(request_queue_t *q, struct requ
 	return ELEVATOR_NO_MERGE;
 }
 
-static void as_merged_request(request_queue_t *q, struct request *req)
+static void as_merged_request(request_queue_t *q, struct request *req, int type)
 {
 	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(req);
@@ -1368,9 +1252,8 @@ static void as_merged_request(request_qu
 	/*
 	 * if the merge was a front merge, we need to reposition request
 	 */
-	if (rq_rb_key(req) != arq->rb_key) {
-		as_del_arq_rb(ad, arq);
-		as_add_arq_rb(ad, arq);
+	if (type == ELEVATOR_FRONT_MERGE) {
+		elv_rb_reposition(ARQ_RB_ROOT(ad, arq), req);
 		/*
 		 * Note! At this stage of this and the next function, our next
 		 * request may not be optimal - eg the request may have "grown"
@@ -1382,18 +1265,12 @@ static void as_merged_request(request_qu
 static void as_merged_requests(request_queue_t *q, struct request *req,
 			 	struct request *next)
 {
-	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(req);
 	struct as_rq *anext = RQ_DATA(next);
 
 	BUG_ON(!arq);
 	BUG_ON(!anext);
 
-	if (rq_rb_key(req) != arq->rb_key) {
-		as_del_arq_rb(ad, arq);
-		as_add_arq_rb(ad, arq);
-	}
-
 	/*
 	 * if anext expires before arq, assign its expire time to arq
 	 * and move into anext position (anext will be deleted) in fifo
@@ -1468,7 +1345,6 @@ static int as_set_request(request_queue_
 
 	if (arq) {
 		memset(arq, 0, sizeof(*arq));
-		RB_CLEAR_NODE(&arq->rb_node);
 		arq->request = rq;
 		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
@@ -1654,8 +1530,8 @@ static struct elevator_type iosched_as =
 		.elevator_deactivate_req_fn = 	as_deactivate_request,
 		.elevator_queue_empty_fn =	as_queue_empty,
 		.elevator_completed_req_fn =	as_completed_request,
-		.elevator_former_req_fn =	as_former_request,
-		.elevator_latter_req_fn =	as_latter_request,
+		.elevator_former_req_fn =	elv_rb_former_request,
+		.elevator_latter_req_fn =	elv_rb_latter_request,
 		.elevator_set_req_fn =		as_set_request,
 		.elevator_put_req_fn =		as_put_request,
 		.elevator_may_queue_fn =	as_may_queue,
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 6fd8af1..95bc2e8 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -46,12 +46,6 @@ #define list_entry_fifo(ptr)	list_entry(
 
 #define RQ_DATA(rq)		(rq)->elevator_private
 
-/*
- * rb-tree defines
- */
-#define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
-#define rq_rb_key(rq)		(rq)->sector
-
 static kmem_cache_t *crq_pool;
 static kmem_cache_t *cfq_pool;
 static kmem_cache_t *cfq_ioc_pool;
@@ -185,8 +179,6 @@ struct cfq_queue {
 };
 
 struct cfq_rq {
-	struct rb_node rb_node;
-	sector_t rb_key;
 	struct request *request;
 
 	struct cfq_queue *cfq_queue;
@@ -376,33 +368,27 @@ #define CFQ_RQ2_WRAP	0x02 /* request 2 w
  */
 static struct cfq_rq *
 cfq_find_next_crq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		  struct cfq_rq *last)
+		  struct cfq_rq *last_crq)
 {
-	struct cfq_rq *crq_next = NULL, *crq_prev = NULL;
-	struct rb_node *rbnext, *rbprev;
-
-	if (!(rbnext = rb_next(&last->rb_node))) {
-		rbnext = rb_first(&cfqq->sort_list);
-		if (rbnext == &last->rb_node)
-			rbnext = NULL;
-	}
+	struct request *last = last_crq->request;
+	struct rb_node *rbnext = rb_next(&last->rb_node);
+	struct rb_node *rbprev = rb_prev(&last->rb_node);
+	struct cfq_rq *next = NULL, *prev = NULL;
 
-	rbprev = rb_prev(&last->rb_node);
+	BUG_ON(RB_EMPTY_NODE(&last->rb_node));
 
 	if (rbprev)
-		crq_prev = rb_entry_crq(rbprev);
-	if (rbnext)
-		crq_next = rb_entry_crq(rbnext);
-
-	return cfq_choose_req(cfqd, crq_next, crq_prev);
-}
+		prev = RQ_DATA(rb_entry_rq(rbprev));
 
-static void cfq_update_next_crq(struct cfq_rq *crq)
-{
-	struct cfq_queue *cfqq = crq->cfq_queue;
+	if (rbnext)
+		next = RQ_DATA(rb_entry_rq(rbnext));
+	else {
+		rbnext = rb_first(&cfqq->sort_list);
+		if (rbnext && rbnext != &last->rb_node)
+			next = RQ_DATA(rb_entry_rq(rbnext));
+	}
 
-	if (cfqq->next_crq == crq)
-		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
+	return cfq_choose_req(cfqd, next, prev);
 }
 
 static void cfq_resort_rr_list(struct cfq_queue *cfqq, int preempted)
@@ -497,72 +483,27 @@ static inline void cfq_del_crq_rb(struct
 	BUG_ON(!cfqq->queued[sync]);
 	cfqq->queued[sync]--;
 
-	cfq_update_next_crq(crq);
-
-	rb_erase(&crq->rb_node, &cfqq->sort_list);
+	elv_rb_del(&cfqq->sort_list, crq->request);
 
 	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY_ROOT(&cfqq->sort_list))
 		cfq_del_cfqq_rr(cfqd, cfqq);
 }
 
-static struct cfq_rq *
-__cfq_add_crq_rb(struct cfq_rq *crq)
-{
-	struct rb_node **p = &crq->cfq_queue->sort_list.rb_node;
-	struct rb_node *parent = NULL;
-	struct cfq_rq *__crq;
-
-	while (*p) {
-		parent = *p;
-		__crq = rb_entry_crq(parent);
-
-		if (crq->rb_key < __crq->rb_key)
-			p = &(*p)->rb_left;
-		else if (crq->rb_key > __crq->rb_key)
-			p = &(*p)->rb_right;
-		else
-			return __crq;
-	}
-
-	rb_link_node(&crq->rb_node, parent, p);
-	return NULL;
-}
-
 static void cfq_add_crq_rb(struct cfq_rq *crq)
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct cfq_data *cfqd = cfqq->cfqd;
 	struct request *rq = crq->request;
-	struct cfq_rq *__alias;
+	struct request *__alias;
 
-	crq->rb_key = rq_rb_key(rq);
 	cfqq->queued[cfq_crq_is_sync(crq)]++;
 
 	/*
 	 * looks a little odd, but the first insert might return an alias.
 	 * if that happens, put the alias on the dispatch list
 	 */
-	while ((__alias = __cfq_add_crq_rb(crq)) != NULL)
-		cfq_dispatch_insert(cfqd->queue, __alias);
-
-	rb_insert_color(&crq->rb_node, &cfqq->sort_list);
-
-	if (!cfq_cfqq_on_rr(cfqq))
-		cfq_add_cfqq_rr(cfqd, cfqq);
-
-	/*
-	 * check if this request is a better next-serve candidate
-	 */
-	cfqq->next_crq = cfq_choose_req(cfqd, cfqq->next_crq, crq);
-}
-
-static inline void
-cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
-{
-	rb_erase(&crq->rb_node, &cfqq->sort_list);
-	cfqq->queued[cfq_crq_is_sync(crq)]--;
-
-	cfq_add_crq_rb(crq);
+	while ((__alias = elv_rb_add(&cfqq->sort_list, rq)) != NULL)
+		cfq_dispatch_insert(cfqd->queue, RQ_DATA(__alias));
 }
 
 static struct request *
@@ -570,28 +511,13 @@ cfq_find_rq_fmerge(struct cfq_data *cfqd
 {
 	struct task_struct *tsk = current;
 	pid_t key = cfq_queue_pid(tsk, bio_data_dir(bio));
+	sector_t sector = bio->bi_sector + bio_sectors(bio);
 	struct cfq_queue *cfqq;
-	struct rb_node *n;
-	sector_t sector;
 
 	cfqq = cfq_find_cfq_hash(cfqd, key, tsk->ioprio);
-	if (!cfqq)
-		goto out;
-
-	sector = bio->bi_sector + bio_sectors(bio);
-	n = cfqq->sort_list.rb_node;
-	while (n) {
-		struct cfq_rq *crq = rb_entry_crq(n);
-
-		if (sector < crq->rb_key)
-			n = n->rb_left;
-		else if (sector > crq->rb_key)
-			n = n->rb_right;
-		else
-			return crq->request;
-	}
+	if (cfqq)
+		return elv_rb_find(&cfqq->sort_list, sector);
 
-out:
 	return NULL;
 }
 
@@ -622,9 +548,20 @@ static void cfq_deactivate_request(reque
 static void cfq_remove_request(struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_queue *cfqq = crq->cfq_queue;
+
+	if (cfqq->next_crq == crq)
+		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
 
 	list_del_init(&rq->queuelist);
 	cfq_del_crq_rb(crq);
+
+	if (!cfqq->next_crq && !RB_EMPTY_ROOT(&cfqq->sort_list)) {
+		struct request *rq = rb_entry_rq(rb_first(&cfqq->sort_list));
+
+		cfqq->next_crq = RQ_DATA(rq);
+		printk("foo\n");
+	}
 }
 
 static int
@@ -642,15 +579,15 @@ cfq_merge(request_queue_t *q, struct req
 	return ELEVATOR_NO_MERGE;
 }
 
-static void cfq_merged_request(request_queue_t *q, struct request *req)
+static void cfq_merged_request(request_queue_t *q, struct request *req,
+			       int type)
 {
 	struct cfq_rq *crq = RQ_DATA(req);
 
-	if (rq_rb_key(req) != crq->rb_key) {
+	if (type == ELEVATOR_FRONT_MERGE) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
-		cfq_update_next_crq(crq);
-		cfq_reposition_crq_rb(cfqq, crq);
+		elv_rb_reposition(&cfqq->sort_list, req);
 	}
 }
 
@@ -658,8 +595,6 @@ static void
 cfq_merged_requests(request_queue_t *q, struct request *rq,
 		    struct request *next)
 {
-	cfq_merged_request(q, rq);
-
 	/*
 	 * reposition in fifo if next is older than rq
 	 */
@@ -881,7 +816,6 @@ static void cfq_dispatch_insert(request_
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct request *rq;
 
-	cfqq->next_crq = cfq_find_next_crq(cfqd, cfqq, crq);
 	cfq_remove_request(crq->request);
 	cfqq->on_dispatch[cfq_crq_is_sync(crq)]++;
 	elv_dispatch_sort(q, crq->request);
@@ -1700,6 +1634,12 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 	struct cfq_io_context *cic = crq->io_context;
 
 	/*
+	 * check if this request is a better next-serve candidate
+	 */
+	cfqq->next_crq = cfq_choose_req(cfqd, cfqq->next_crq, crq);
+	BUG_ON(!cfqq->next_crq);
+
+	/*
 	 * we never wait for an async request and we don't allow preemption
 	 * of an async request. so just return early
 	 */
@@ -1756,6 +1696,9 @@ static void cfq_insert_request(request_q
 
 	cfq_add_crq_rb(crq);
 
+	if (!cfq_cfqq_on_rr(cfqq))
+		cfq_add_cfqq_rr(cfqd, cfqq);
+
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 
 	cfq_crq_enqueued(cfqd, cfqq, crq);
@@ -1803,30 +1746,6 @@ static void cfq_completed_request(reques
 	}
 }
 
-static struct request *
-cfq_former_request(request_queue_t *q, struct request *rq)
-{
-	struct cfq_rq *crq = RQ_DATA(rq);
-	struct rb_node *rbprev = rb_prev(&crq->rb_node);
-
-	if (rbprev)
-		return rb_entry_crq(rbprev)->request;
-
-	return NULL;
-}
-
-static struct request *
-cfq_latter_request(request_queue_t *q, struct request *rq)
-{
-	struct cfq_rq *crq = RQ_DATA(rq);
-	struct rb_node *rbnext = rb_next(&crq->rb_node);
-
-	if (rbnext)
-		return rb_entry_crq(rbnext)->request;
-
-	return NULL;
-}
-
 /*
  * we temporarily boost lower priority queues if they are holding fs exclusive
  * resources. they are boosted to normal prio (CLASS_BE/4)
@@ -1982,8 +1901,6 @@ cfq_set_request(request_queue_t *q, stru
 
 	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 	if (crq) {
-		RB_CLEAR_NODE(&crq->rb_node);
-		crq->rb_key = 0;
 		crq->request = rq;
 		crq->cfq_queue = cfqq;
 		crq->io_context = cic;
@@ -2345,8 +2262,8 @@ static struct elevator_type iosched_cfq 
 		.elevator_deactivate_req_fn =	cfq_deactivate_request,
 		.elevator_queue_empty_fn =	cfq_queue_empty,
 		.elevator_completed_req_fn =	cfq_completed_request,
-		.elevator_former_req_fn =	cfq_former_request,
-		.elevator_latter_req_fn =	cfq_latter_request,
+		.elevator_former_req_fn =	elv_rb_former_request,
+		.elevator_latter_req_fn =	elv_rb_latter_request,
 		.elevator_set_req_fn =		cfq_set_request,
 		.elevator_put_req_fn =		cfq_put_request,
 		.elevator_may_queue_fn =	cfq_may_queue,
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index b66e820..ce86b1f 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -57,12 +57,6 @@ struct deadline_data {
  * pre-request data.
  */
 struct deadline_rq {
-	/*
-	 * rbtree index, key is the starting offset
-	 */
-	struct rb_node rb_node;
-	sector_t rb_key;
-
 	struct request *request;
 
 	/*
@@ -78,108 +72,38 @@ static kmem_cache_t *drq_pool;
 
 #define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
 
-/*
- * rb tree support functions
- */
-#define rb_entry_drq(node)	rb_entry((node), struct deadline_rq, rb_node)
-#define DRQ_RB_ROOT(dd, drq)	(&(dd)->sort_list[rq_data_dir((drq)->request)])
-#define rq_rb_key(rq)		(rq)->sector
-
-static struct deadline_rq *
-__deadline_add_drq_rb(struct deadline_data *dd, struct deadline_rq *drq)
-{
-	struct rb_node **p = &DRQ_RB_ROOT(dd, drq)->rb_node;
-	struct rb_node *parent = NULL;
-	struct deadline_rq *__drq;
-
-	while (*p) {
-		parent = *p;
-		__drq = rb_entry_drq(parent);
-
-		if (drq->rb_key < __drq->rb_key)
-			p = &(*p)->rb_left;
-		else if (drq->rb_key > __drq->rb_key)
-			p = &(*p)->rb_right;
-		else
-			return __drq;
-	}
-
-	rb_link_node(&drq->rb_node, parent, p);
-	return NULL;
-}
+#define RQ_RB_ROOT(dd, rq)	(&(dd)->sort_list[rq_data_dir((rq))])
+#define DRQ_RB_ROOT(dd, drq)	RQ_RB_ROOT((drq)->request)
 
 static void
-deadline_add_drq_rb(struct deadline_data *dd, struct deadline_rq *drq)
+deadline_add_drq_rb(struct deadline_data *dd, struct request *rq)
 {
-	struct deadline_rq *__alias;
-
-	drq->rb_key = rq_rb_key(drq->request);
+	struct rb_root *root = RQ_RB_ROOT(dd, rq);
+	struct request *__alias;
 
 retry:
-	__alias = __deadline_add_drq_rb(dd, drq);
-	if (!__alias) {
-		rb_insert_color(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
-		return;
+	__alias = elv_rb_add(root, rq);
+	if (unlikely(__alias)) {
+		deadline_move_request(dd, RQ_DATA(__alias));
+		goto retry;
 	}
-
-	deadline_move_request(dd, __alias);
-	goto retry;
 }
 
 static inline void
 deadline_del_drq_rb(struct deadline_data *dd, struct deadline_rq *drq)
 {
-	const int data_dir = rq_data_dir(drq->request);
+	struct request *rq = drq->request;
+	const int data_dir = rq_data_dir(rq);
 
 	if (dd->next_drq[data_dir] == drq) {
-		struct rb_node *rbnext = rb_next(&drq->rb_node);
+		struct rb_node *rbnext = rb_next(&rq->rb_node);
 
 		dd->next_drq[data_dir] = NULL;
 		if (rbnext)
-			dd->next_drq[data_dir] = rb_entry_drq(rbnext);
+			dd->next_drq[data_dir] = RQ_DATA(rb_entry_rq(rbnext));
 	}
 
-	BUG_ON(!RB_EMPTY_NODE(&drq->rb_node));
-	rb_erase(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
-	RB_CLEAR_NODE(&drq->rb_node);
-}
-
-static struct request *
-deadline_find_drq_rb(struct deadline_data *dd, sector_t sector, int data_dir)
-{
-	struct rb_node *n = dd->sort_list[data_dir].rb_node;
-	struct deadline_rq *drq;
-
-	while (n) {
-		drq = rb_entry_drq(n);
-
-		if (sector < drq->rb_key)
-			n = n->rb_left;
-		else if (sector > drq->rb_key)
-			n = n->rb_right;
-		else
-			return drq->request;
-	}
-
-	return NULL;
-}
-
-/*
- * deadline_find_first_drq finds the first (lowest sector numbered) request
- * for the specified data_dir. Used to sweep back to the start of the disk
- * (1-way elevator) after we process the last (highest sector) request.
- */
-static struct deadline_rq *
-deadline_find_first_drq(struct deadline_data *dd, int data_dir)
-{
-	struct rb_node *n = dd->sort_list[data_dir].rb_node;
-
-	for (;;) {
-		if (n->rb_left == NULL)
-			return rb_entry_drq(n);
-		
-		n = n->rb_left;
-	}
+	elv_rb_del(RQ_RB_ROOT(dd, rq), rq);
 }
 
 /*
@@ -192,7 +116,7 @@ deadline_add_request(struct request_queu
 	struct deadline_rq *drq = RQ_DATA(rq);
 	const int data_dir = rq_data_dir(drq->request);
 
-	deadline_add_drq_rb(dd, drq);
+	deadline_add_drq_rb(dd, rq);
 
 	/*
 	 * set expire time (only used for reads) and add to fifo list
@@ -224,11 +148,11 @@ deadline_merge(request_queue_t *q, struc
 	 * check for front merge
 	 */
 	if (dd->front_merges) {
-		sector_t rb_key = bio->bi_sector + bio_sectors(bio);
+		sector_t sector = bio->bi_sector + bio_sectors(bio);
 
-		__rq = deadline_find_drq_rb(dd, rb_key, bio_data_dir(bio));
+		__rq = elv_rb_find(&dd->sort_list[bio_data_dir(bio)], sector);
 		if (__rq) {
-			BUG_ON(rb_key != rq_rb_key(__rq));
+			BUG_ON(sector != __rq->sector);
 
 			if (elv_rq_merge_ok(__rq, bio)) {
 				ret = ELEVATOR_FRONT_MERGE;
@@ -243,36 +167,28 @@ out:
 	return ret;
 }
 
-static void deadline_merged_request(request_queue_t *q, struct request *req)
+static void deadline_merged_request(request_queue_t *q, struct request *req,
+				    int type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	struct deadline_rq *drq = RQ_DATA(req);
 
 	/*
 	 * if the merge was a front merge, we need to reposition request
 	 */
-	if (rq_rb_key(req) != drq->rb_key) {
-		deadline_del_drq_rb(dd, drq);
-		deadline_add_drq_rb(dd, drq);
-	}
+	if (type == ELEVATOR_FRONT_MERGE)
+		elv_rb_reposition(RQ_RB_ROOT(dd, req), req);
 }
 
 static void
 deadline_merged_requests(request_queue_t *q, struct request *req,
 			 struct request *next)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 	struct deadline_rq *dnext = RQ_DATA(next);
 
 	BUG_ON(!drq);
 	BUG_ON(!dnext);
 
-	if (rq_rb_key(req) != drq->rb_key) {
-		deadline_del_drq_rb(dd, drq);
-		deadline_add_drq_rb(dd, drq);
-	}
-
 	/*
 	 * if dnext expires before drq, assign its expire time to drq
 	 * and move into dnext position (dnext will be deleted) in fifo
@@ -308,14 +224,15 @@ deadline_move_to_dispatch(struct deadlin
 static void
 deadline_move_request(struct deadline_data *dd, struct deadline_rq *drq)
 {
-	const int data_dir = rq_data_dir(drq->request);
-	struct rb_node *rbnext = rb_next(&drq->rb_node);
+	struct request *rq = drq->request;
+	const int data_dir = rq_data_dir(rq);
+	struct rb_node *rbnext = rb_next(&rq->rb_node);
 
 	dd->next_drq[READ] = NULL;
 	dd->next_drq[WRITE] = NULL;
 
 	if (rbnext)
-		dd->next_drq[data_dir] = rb_entry_drq(rbnext);
+		dd->next_drq[data_dir] = RQ_DATA(rb_entry_rq(rbnext));
 	
 	dd->last_sector = drq->request->sector + drq->request->nr_sectors;
 
@@ -426,13 +343,17 @@ dispatch_find_request:
 		 */
 		drq = dd->next_drq[data_dir];
 	} else {
+		struct rb_node *n;
+
 		/*
 		 * The last req was the other direction or we have run out of
 		 * higher-sectored requests. Go back to the lowest sectored
 		 * request (1 way elevator) and start a new batch.
 		 */
 		dd->batching = 0;
-		drq = deadline_find_first_drq(dd, data_dir);
+		n = rb_first(&dd->sort_list[data_dir]);
+		if (n)
+			drq = RQ_DATA(rb_entry_rq(n));
 	}
 
 dispatch_request:
@@ -453,30 +374,6 @@ static int deadline_queue_empty(request_
 		&& list_empty(&dd->fifo_list[READ]);
 }
 
-static struct request *
-deadline_former_request(request_queue_t *q, struct request *rq)
-{
-	struct deadline_rq *drq = RQ_DATA(rq);
-	struct rb_node *rbprev = rb_prev(&drq->rb_node);
-
-	if (rbprev)
-		return rb_entry_drq(rbprev)->request;
-
-	return NULL;
-}
-
-static struct request *
-deadline_latter_request(request_queue_t *q, struct request *rq)
-{
-	struct deadline_rq *drq = RQ_DATA(rq);
-	struct rb_node *rbnext = rb_next(&drq->rb_node);
-
-	if (rbnext)
-		return rb_entry_drq(rbnext)->request;
-
-	return NULL;
-}
-
 static void deadline_exit_queue(elevator_t *e)
 {
 	struct deadline_data *dd = e->elevator_data;
@@ -542,7 +439,6 @@ deadline_set_request(request_queue_t *q,
 	drq = mempool_alloc(dd->drq_pool, gfp_mask);
 	if (drq) {
 		memset(drq, 0, sizeof(*drq));
-		RB_CLEAR_NODE(&drq->rb_node);
 		drq->request = rq;
 
 		INIT_LIST_HEAD(&drq->fifo);
@@ -633,8 +529,8 @@ static struct elevator_type iosched_dead
 		.elevator_dispatch_fn =		deadline_dispatch_requests,
 		.elevator_add_req_fn =		deadline_add_request,
 		.elevator_queue_empty_fn =	deadline_queue_empty,
-		.elevator_former_req_fn =	deadline_former_request,
-		.elevator_latter_req_fn =	deadline_latter_request,
+		.elevator_former_req_fn =	elv_rb_former_request,
+		.elevator_latter_req_fn =	elv_rb_latter_request,
 		.elevator_set_req_fn =		deadline_set_request,
 		.elevator_put_req_fn = 		deadline_put_request,
 		.elevator_init_fn =		deadline_init_queue,
diff --git a/block/elevator.c b/block/elevator.c
index 3e40530..9cca1ac 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -298,6 +298,65 @@ static struct request *elv_rqhash_find(r
 }
 
 /*
+ * RB-tree support functions for inserting/lookup/removal of requests
+ * in a sorted RB tree.
+ */
+struct request *elv_rb_add(struct rb_root *root, struct request *rq)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct request *__rq;
+
+	while (*p) {
+		parent = *p;
+		__rq = rb_entry(parent, struct request, rb_node);
+
+		if (rq->sector < __rq->sector)
+			p = &(*p)->rb_left;
+		else if (rq->sector > __rq->sector)
+			p = &(*p)->rb_right;
+		else
+			return __rq;
+	}
+
+	rb_link_node(&rq->rb_node, parent, p);
+	rb_insert_color(&rq->rb_node, root);
+	return NULL;
+}
+
+void elv_rb_del(struct rb_root *root, struct request *rq)
+{
+	BUG_ON(RB_EMPTY_NODE(&rq->rb_node));
+	rb_erase(&rq->rb_node, root);
+	RB_CLEAR_NODE(&rq->rb_node);
+}
+
+void elv_rb_reposition(struct rb_root *root, struct request *rq)
+{
+	elv_rb_del(root, rq);
+	elv_rb_add(root, rq);
+}
+
+struct request *elv_rb_find(struct rb_root *root, sector_t sector)
+{
+	struct rb_node *n = root->rb_node;
+	struct request *rq;
+
+	while (n) {
+		rq = rb_entry(n, struct request, rb_node);
+
+		if (sector < rq->sector)
+			n = n->rb_left;
+		else if (sector > rq->sector)
+			n = n->rb_right;
+		else
+			return rq;
+	}
+
+	return NULL;
+}
+
+/*
  * Insert rq into dispatch queue of q.  Queue lock must be held on
  * entry.  If sort != 0, rq is sort-inserted; otherwise, rq will be
  * appended to the dispatch queue.  To be used by specific elevators.
@@ -384,14 +443,15 @@ int elv_merge(request_queue_t *q, struct
 	return ELEVATOR_NO_MERGE;
 }
 
-void elv_merged_request(request_queue_t *q, struct request *rq)
+void elv_merged_request(request_queue_t *q, struct request *rq, int type)
 {
 	elevator_t *e = q->elevator;
 
 	if (e->ops->elevator_merged_fn)
-		e->ops->elevator_merged_fn(q, rq);
+		e->ops->elevator_merged_fn(q, rq, type);
 
-	elv_rqhash_reposition(q, rq);
+	if (type == ELEVATOR_BACK_MERGE)
+		elv_rqhash_reposition(q, rq);
 
 	q->last_merge = rq;
 }
@@ -1024,6 +1084,26 @@ ssize_t elv_iosched_show(request_queue_t
 	return len;
 }
 
+struct request *elv_rb_former_request(request_queue_t *q, struct request *rq)
+{
+	struct rb_node *rbprev = rb_prev(&rq->rb_node);
+
+	if (rbprev)
+		return rb_entry_rq(rbprev);
+
+	return NULL;
+}
+
+struct request *elv_rb_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct rb_node *rbnext = rb_next(&rq->rb_node);
+
+	if (rbnext)
+		return rb_entry_rq(rbnext);
+
+	return NULL;
+}
+
 EXPORT_SYMBOL(elv_dispatch_sort);
 EXPORT_SYMBOL(elv_add_request);
 EXPORT_SYMBOL(__elv_add_request);
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 84c7b1c..08c1615 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -281,11 +281,12 @@ static inline void rq_init(request_queue
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_LIST_HEAD(&rq->donelist);
-	INIT_HLIST_NODE(&rq->hash);
 
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->bio = rq->biotail = NULL;
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
 	rq->ioprio = 0;
 	rq->buffer = NULL;
 	rq->ref_count = 1;
@@ -2896,7 +2897,7 @@ static int __make_request(request_queue_
 			req->ioprio = ioprio_best(req->ioprio, prio);
 			drive_stat_acct(req, nr_sectors, 0);
 			if (!attempt_back_merge(q, req))
-				elv_merged_request(q, req);
+				elv_merged_request(q, req, el_ret);
 			goto out;
 
 		case ELEVATOR_FRONT_MERGE:
@@ -2923,7 +2924,7 @@ static int __make_request(request_queue_
 			req->ioprio = ioprio_best(req->ioprio, prio);
 			drive_stat_acct(req, nr_sectors, 0);
 			if (!attempt_front_merge(q, req))
-				elv_merged_request(q, req);
+				elv_merged_request(q, req, el_ret);
 			goto out;
 
 		/* ELV_NO_MERGE: elevator says don't/can't merge. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9b23cbe..e296719 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -149,6 +149,7 @@ struct request {
 	struct bio *biotail;
 
 	struct hlist_node hash;	/* merge hash */
+	struct rb_node rb_node;	/* sort/lookup */
 
 	void *elevator_private;
 	void *completion_data;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 2c270e9..38f0f0d 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -6,7 +6,7 @@ typedef int (elevator_merge_fn) (request
 
 typedef void (elevator_merge_req_fn) (request_queue_t *, struct request *, struct request *);
 
-typedef void (elevator_merged_fn) (request_queue_t *, struct request *);
+typedef void (elevator_merged_fn) (request_queue_t *, struct request *, int);
 
 typedef int (elevator_dispatch_fn) (request_queue_t *, int);
 
@@ -96,7 +96,7 @@ extern void elv_insert(request_queue_t *
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
-extern void elv_merged_request(request_queue_t *, struct request *);
+extern void elv_merged_request(request_queue_t *, struct request *, int);
 extern void elv_dequeue_request(request_queue_t *, struct request *);
 extern void elv_requeue_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
@@ -127,6 +127,20 @@ extern void elevator_exit(elevator_t *);
 extern int elv_rq_merge_ok(struct request *, struct bio *);
 
 /*
+ * Helper functions.
+ */
+extern struct request *elv_rb_former_request(request_queue_t *, struct request *);
+extern struct request *elv_rb_latter_request(request_queue_t *, struct request *);
+
+/*
+ * rb support functions.
+ */
+extern struct request *elv_rb_add(struct rb_root *, struct request *);
+extern void elv_rb_del(struct rb_root *, struct request *);
+extern struct request *elv_rb_find(struct rb_root *, sector_t);
+extern void elv_rb_reposition(struct rb_root *, struct request *);
+
+/*
  * Return values from elevator merger
  */
 #define ELEVATOR_NO_MERGE	0
@@ -151,5 +165,6 @@ enum {
 };
 
 #define rq_end_sector(rq)	((rq)->sector + (rq)->nr_sectors)
+#define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
 
 #endif
-- 
1.4.1.ged0e0

-- 
Jens Axboe

