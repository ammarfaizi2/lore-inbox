Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWGMMsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWGMMsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWGMMrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:47:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31279 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932450AbWGMMoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:05 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 6/15 deadline-iosched: migrate to using the elevator rb functions
Date: Thu, 13 Jul 2006 14:46:29 +0200
Message-Id: <11527947983756-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the rbtree handling from deadline.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/deadline-iosched.c |  170 +++++++++-------------------------------------
 1 files changed, 34 insertions(+), 136 deletions(-)

diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index b66e820..8300ba1 100644
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
-	}
-
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
+			dd->next_drq[data_dir] = RQ_DATA(rb_entry_rq(rbnext));
 	}
 
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
@@ -243,17 +167,17 @@ out:
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
+	if (type == ELEVATOR_FRONT_MERGE) {
+		elv_rb_del(RQ_RB_ROOT(dd, req), req);
+		deadline_add_drq_rb(dd, req);
 	}
 }
 
@@ -261,18 +185,12 @@ static void
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
@@ -308,14 +226,15 @@ deadline_move_to_dispatch(struct deadlin
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
 
@@ -426,13 +345,17 @@ dispatch_find_request:
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
@@ -453,30 +376,6 @@ static int deadline_queue_empty(request_
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
@@ -542,7 +441,6 @@ deadline_set_request(request_queue_t *q,
 	drq = mempool_alloc(dd->drq_pool, gfp_mask);
 	if (drq) {
 		memset(drq, 0, sizeof(*drq));
-		RB_CLEAR_NODE(&drq->rb_node);
 		drq->request = rq;
 
 		INIT_LIST_HEAD(&drq->fifo);
@@ -633,8 +531,8 @@ static struct elevator_type iosched_dead
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
-- 
1.4.1.ged0e0

