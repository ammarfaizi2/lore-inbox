Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWGMMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWGMMrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWGMMqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:46:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37935 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932512AbWGMMoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:08 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 11/15 deadline-iosched: remove elevator private drq request type
Date: Thu, 13 Jul 2006 14:46:34 +0200
Message-Id: <11527947983692-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A big win, we now save an allocation/free on each request! With the
previous rb/hash abstractions, we can just reuse queuelist/donelist
for the FIFO data and be done with it.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/deadline-iosched.c |  194 ++++++++++++----------------------------------
 1 files changed, 52 insertions(+), 142 deletions(-)

diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 8300ba1..3b3b441 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -37,7 +37,7 @@ struct deadline_data {
 	/*
 	 * next in sort order. read, write or both are NULL
 	 */
-	struct deadline_rq *next_drq[2];
+	struct request *next_rq[2];
 	unsigned int batching;		/* number of sequential requests made */
 	sector_t last_sector;		/* head position */
 	unsigned int starved;		/* times reads have starved writes */
@@ -49,34 +49,14 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
-
-	mempool_t *drq_pool;
 };
 
-/*
- * pre-request data.
- */
-struct deadline_rq {
-	struct request *request;
-
-	/*
-	 * expire fifo
-	 */
-	struct list_head fifo;
-	unsigned long expires;
-};
-
-static void deadline_move_request(struct deadline_data *dd, struct deadline_rq *drq);
-
-static kmem_cache_t *drq_pool;
-
-#define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
+static void deadline_move_request(struct deadline_data *, struct request *);
 
 #define RQ_RB_ROOT(dd, rq)	(&(dd)->sort_list[rq_data_dir((rq))])
-#define DRQ_RB_ROOT(dd, drq)	RQ_RB_ROOT((drq)->request)
 
 static void
-deadline_add_drq_rb(struct deadline_data *dd, struct request *rq)
+deadline_add_rq_rb(struct deadline_data *dd, struct request *rq)
 {
 	struct rb_root *root = RQ_RB_ROOT(dd, rq);
 	struct request *__alias;
@@ -84,45 +64,43 @@ deadline_add_drq_rb(struct deadline_data
 retry:
 	__alias = elv_rb_add(root, rq);
 	if (unlikely(__alias)) {
-		deadline_move_request(dd, RQ_DATA(__alias));
+		deadline_move_request(dd, __alias);
 		goto retry;
 	}
 }
 
 static inline void
-deadline_del_drq_rb(struct deadline_data *dd, struct deadline_rq *drq)
+deadline_del_rq_rb(struct deadline_data *dd, struct request *rq)
 {
-	struct request *rq = drq->request;
 	const int data_dir = rq_data_dir(rq);
 
-	if (dd->next_drq[data_dir] == drq) {
+	if (dd->next_rq[data_dir] == rq) {
 		struct rb_node *rbnext = rb_next(&rq->rb_node);
 
-		dd->next_drq[data_dir] = NULL;
+		dd->next_rq[data_dir] = NULL;
 		if (rbnext)
-			dd->next_drq[data_dir] = RQ_DATA(rb_entry_rq(rbnext));
+			dd->next_rq[data_dir] = rb_entry_rq(rbnext);
 	}
 
 	elv_rb_del(RQ_RB_ROOT(dd, rq), rq);
 }
 
 /*
- * add drq to rbtree and fifo
+ * add rq to rbtree and fifo
  */
 static void
 deadline_add_request(struct request_queue *q, struct request *rq)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	struct deadline_rq *drq = RQ_DATA(rq);
-	const int data_dir = rq_data_dir(drq->request);
+	const int data_dir = rq_data_dir(rq);
 
-	deadline_add_drq_rb(dd, rq);
+	deadline_add_rq_rb(dd, rq);
 
 	/*
 	 * set expire time (only used for reads) and add to fifo list
 	 */
-	drq->expires = jiffies + dd->fifo_expire[data_dir];
-	list_add_tail(&drq->fifo, &dd->fifo_list[data_dir]);
+	rq_set_fifo_time(rq, jiffies + dd->fifo_expire[data_dir]);
+	list_add_tail(&rq->queuelist, &dd->fifo_list[data_dir]);
 }
 
 /*
@@ -130,11 +108,10 @@ deadline_add_request(struct request_queu
  */
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
 {
-	struct deadline_rq *drq = RQ_DATA(rq);
 	struct deadline_data *dd = q->elevator->elevator_data;
 
-	list_del_init(&drq->fifo);
-	deadline_del_drq_rb(dd, drq);
+	rq_fifo_clear(rq);
+	deadline_del_rq_rb(dd, rq);
 }
 
 static int
@@ -177,7 +154,7 @@ static void deadline_merged_request(requ
 	 */
 	if (type == ELEVATOR_FRONT_MERGE) {
 		elv_rb_del(RQ_RB_ROOT(dd, req), req);
-		deadline_add_drq_rb(dd, req);
+		deadline_add_rq_rb(dd, req);
 	}
 }
 
@@ -185,20 +162,14 @@ static void
 deadline_merged_requests(request_queue_t *q, struct request *req,
 			 struct request *next)
 {
-	struct deadline_rq *drq = RQ_DATA(req);
-	struct deadline_rq *dnext = RQ_DATA(next);
-
-	BUG_ON(!drq);
-	BUG_ON(!dnext);
-
 	/*
-	 * if dnext expires before drq, assign its expire time to drq
-	 * and move into dnext position (dnext will be deleted) in fifo
+	 * if next expires before rq, assign its expire time to rq
+	 * and move into next position (next will be deleted) in fifo
 	 */
-	if (!list_empty(&drq->fifo) && !list_empty(&dnext->fifo)) {
-		if (time_before(dnext->expires, drq->expires)) {
-			list_move(&drq->fifo, &dnext->fifo);
-			drq->expires = dnext->expires;
+	if (!list_empty(&req->queuelist) && !list_empty(&next->queuelist)) {
+		if (time_before(rq_fifo_time(next), rq_fifo_time(req))) {
+			list_move(&req->queuelist, &next->queuelist);
+			rq_set_fifo_time(req, rq_fifo_time(next));
 		}
 	}
 
@@ -212,53 +183,50 @@ deadline_merged_requests(request_queue_t
  * move request from sort list to dispatch queue.
  */
 static inline void
-deadline_move_to_dispatch(struct deadline_data *dd, struct deadline_rq *drq)
+deadline_move_to_dispatch(struct deadline_data *dd, struct request *rq)
 {
-	request_queue_t *q = drq->request->q;
+	request_queue_t *q = rq->q;
 
-	deadline_remove_request(q, drq->request);
-	elv_dispatch_add_tail(q, drq->request);
+	deadline_remove_request(q, rq);
+	elv_dispatch_add_tail(q, rq);
 }
 
 /*
  * move an entry to dispatch queue
  */
 static void
-deadline_move_request(struct deadline_data *dd, struct deadline_rq *drq)
+deadline_move_request(struct deadline_data *dd, struct request *rq)
 {
-	struct request *rq = drq->request;
 	const int data_dir = rq_data_dir(rq);
 	struct rb_node *rbnext = rb_next(&rq->rb_node);
 
-	dd->next_drq[READ] = NULL;
-	dd->next_drq[WRITE] = NULL;
+	dd->next_rq[READ] = NULL;
+	dd->next_rq[WRITE] = NULL;
 
 	if (rbnext)
-		dd->next_drq[data_dir] = RQ_DATA(rb_entry_rq(rbnext));
+		dd->next_rq[data_dir] = rb_entry_rq(rbnext);
 	
-	dd->last_sector = drq->request->sector + drq->request->nr_sectors;
+	dd->last_sector = rq->sector + rq->nr_sectors;
 
 	/*
 	 * take it off the sort and fifo list, move
 	 * to dispatch queue
 	 */
-	deadline_move_to_dispatch(dd, drq);
+	deadline_move_to_dispatch(dd, rq);
 }
 
-#define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
-
 /*
  * deadline_check_fifo returns 0 if there are no expired reads on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
  */
 static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
 {
-	struct deadline_rq *drq = list_entry_fifo(dd->fifo_list[ddir].next);
+	struct request *rq = rq_entry_fifo(dd->fifo_list[ddir].next);
 
 	/*
-	 * drq is expired!
+	 * rq is expired!
 	 */
-	if (time_after(jiffies, drq->expires))
+	if (time_after(jiffies, rq_fifo_time(rq)))
 		return 1;
 
 	return 0;
@@ -273,21 +241,21 @@ static int deadline_dispatch_requests(re
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const int reads = !list_empty(&dd->fifo_list[READ]);
 	const int writes = !list_empty(&dd->fifo_list[WRITE]);
-	struct deadline_rq *drq;
+	struct request *rq;
 	int data_dir;
 
 	/*
 	 * batches are currently reads XOR writes
 	 */
-	if (dd->next_drq[WRITE])
-		drq = dd->next_drq[WRITE];
+	if (dd->next_rq[WRITE])
+		rq = dd->next_rq[WRITE];
 	else
-		drq = dd->next_drq[READ];
+		rq = dd->next_rq[READ];
 
-	if (drq) {
+	if (rq) {
 		/* we have a "next request" */
 		
-		if (dd->last_sector != drq->request->sector)
+		if (dd->last_sector != rq->sector)
 			/* end the batch on a non sequential request */
 			dd->batching += dd->fifo_batch;
 		
@@ -336,34 +304,33 @@ dispatch_find_request:
 	if (deadline_check_fifo(dd, data_dir)) {
 		/* An expired request exists - satisfy it */
 		dd->batching = 0;
-		drq = list_entry_fifo(dd->fifo_list[data_dir].next);
+		rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
 		
-	} else if (dd->next_drq[data_dir]) {
+	} else if (dd->next_rq[data_dir]) {
 		/*
 		 * The last req was the same dir and we have a next request in
 		 * sort order. No expired requests so continue on from here.
 		 */
-		drq = dd->next_drq[data_dir];
+		rq = dd->next_rq[data_dir];
 	} else {
-		struct rb_node *n;
-
+		struct rb_node *node;
 		/*
 		 * The last req was the other direction or we have run out of
 		 * higher-sectored requests. Go back to the lowest sectored
 		 * request (1 way elevator) and start a new batch.
 		 */
 		dd->batching = 0;
-		n = rb_first(&dd->sort_list[data_dir]);
-		if (n)
-			drq = RQ_DATA(rb_entry_rq(n));
+		node = rb_first(&dd->sort_list[data_dir]);
+		if (node)
+			rq = rb_entry_rq(node);
 	}
 
 dispatch_request:
 	/*
-	 * drq is the selected appropriate request.
+	 * rq is the selected appropriate request.
 	 */
 	dd->batching++;
-	deadline_move_request(dd, drq);
+	deadline_move_request(dd, rq);
 
 	return 1;
 }
@@ -383,33 +350,21 @@ static void deadline_exit_queue(elevator
 	BUG_ON(!list_empty(&dd->fifo_list[READ]));
 	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
 
-	mempool_destroy(dd->drq_pool);
 	kfree(dd);
 }
 
 /*
- * initialize elevator private data (deadline_data), and alloc a drq for
- * each request on the free lists
+ * initialize elevator private data (deadline_data).
  */
 static void *deadline_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
 
-	if (!drq_pool)
-		return NULL;
-
 	dd = kmalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
 	if (!dd)
 		return NULL;
 	memset(dd, 0, sizeof(*dd));
 
-	dd->drq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
-					mempool_free_slab, drq_pool, q->node);
-	if (!dd->drq_pool) {
-		kfree(dd);
-		return NULL;
-	}
-
 	INIT_LIST_HEAD(&dd->fifo_list[READ]);
 	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
 	dd->sort_list[READ] = RB_ROOT;
@@ -422,36 +377,6 @@ static void *deadline_init_queue(request
 	return dd;
 }
 
-static void deadline_put_request(request_queue_t *q, struct request *rq)
-{
-	struct deadline_data *dd = q->elevator->elevator_data;
-	struct deadline_rq *drq = RQ_DATA(rq);
-
-	mempool_free(drq, dd->drq_pool);
-	rq->elevator_private = NULL;
-}
-
-static int
-deadline_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		     gfp_t gfp_mask)
-{
-	struct deadline_data *dd = q->elevator->elevator_data;
-	struct deadline_rq *drq;
-
-	drq = mempool_alloc(dd->drq_pool, gfp_mask);
-	if (drq) {
-		memset(drq, 0, sizeof(*drq));
-		drq->request = rq;
-
-		INIT_LIST_HEAD(&drq->fifo);
-
-		rq->elevator_private = drq;
-		return 0;
-	}
-
-	return 1;
-}
-
 /*
  * sysfs parts below
  */
@@ -533,8 +458,6 @@ static struct elevator_type iosched_dead
 		.elevator_queue_empty_fn =	deadline_queue_empty,
 		.elevator_former_req_fn =	elv_rb_former_request,
 		.elevator_latter_req_fn =	elv_rb_latter_request,
-		.elevator_set_req_fn =		deadline_set_request,
-		.elevator_put_req_fn = 		deadline_put_request,
 		.elevator_init_fn =		deadline_init_queue,
 		.elevator_exit_fn =		deadline_exit_queue,
 	},
@@ -546,24 +469,11 @@ static struct elevator_type iosched_dead
 
 static int __init deadline_init(void)
 {
-	int ret;
-
-	drq_pool = kmem_cache_create("deadline_drq", sizeof(struct deadline_rq),
-				     0, 0, NULL, NULL);
-
-	if (!drq_pool)
-		return -ENOMEM;
-
-	ret = elv_register(&iosched_deadline);
-	if (ret)
-		kmem_cache_destroy(drq_pool);
-
-	return ret;
+	return elv_register(&iosched_deadline);
 }
 
 static void __exit deadline_exit(void)
 {
-	kmem_cache_destroy(drq_pool);
 	elv_unregister(&iosched_deadline);
 }
 
-- 
1.4.1.ged0e0

