Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWGMMpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWGMMpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWGMMoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:44:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25647 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751491AbWGMMoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:02 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 4/15 as-iosched: migrate to using the elevator rb functions
Date: Thu, 13 Jul 2006 14:46:27 +0200
Message-Id: <11527947983112-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the rbtree handling from AS.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/as-iosched.c |  182 ++++++++--------------------------------------------
 1 files changed, 29 insertions(+), 153 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index d677029..413a944 100644
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
 
-/*
- * as_find_first_arq finds the first (lowest sector numbered) request
- * for the specified data_dir. Used to sweep back to the start of the disk
- * (1-way elevator) after we process the last (highest sector) request.
- */
-static struct as_rq *as_find_first_arq(struct as_data *ad, int data_dir)
+static void as_add_arq_rb(struct as_data *ad, struct request *rq)
 {
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
-
-	return NULL;
-}
-
-static void as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
-{
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
+static inline void as_del_arq_rb(struct as_data *ad, struct request *rq)
 {
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
-{
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
@@ -1360,17 +1244,16 @@ as_merge(request_queue_t *q, struct requ
 	return ELEVATOR_NO_MERGE;
 }
 
-static void as_merged_request(request_queue_t *q, struct request *req)
+static void as_merged_request(request_queue_t *q, struct request *req, int type)
 {
 	struct as_data *ad = q->elevator->elevator_data;
-	struct as_rq *arq = RQ_DATA(req);
 
 	/*
 	 * if the merge was a front merge, we need to reposition request
 	 */
-	if (rq_rb_key(req) != arq->rb_key) {
-		as_del_arq_rb(ad, arq);
-		as_add_arq_rb(ad, arq);
+	if (type == ELEVATOR_FRONT_MERGE) {
+		as_del_arq_rb(ad, req);
+		as_add_arq_rb(ad, req);
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
-- 
1.4.1.ged0e0

