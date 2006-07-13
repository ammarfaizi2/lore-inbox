Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWGMMog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWGMMog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWGMMoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:44:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24879 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751488AbWGMMoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:02 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 5/15 cfq-iosched: migrate to using the elevator rb functions
Date: Thu, 13 Jul 2006 14:46:28 +0200
Message-Id: <1152794798563-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the rbtree handling from CFQ.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/cfq-iosched.c |  164 +++++++++++++--------------------------------------
 1 files changed, 41 insertions(+), 123 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 6fd8af1..75efc82 100644
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
@@ -497,71 +483,34 @@ static inline void cfq_del_crq_rb(struct
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
+	while ((__alias = elv_rb_add(&cfqq->sort_list, rq)) != NULL)
+		cfq_dispatch_insert(cfqd->queue, RQ_DATA(__alias));
 }
 
 static inline void
 cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	rb_erase(&crq->rb_node, &cfqq->sort_list);
+	elv_rb_del(&cfqq->sort_list, crq->request);
 	cfqq->queued[cfq_crq_is_sync(crq)]--;
-
 	cfq_add_crq_rb(crq);
 }
 
@@ -570,28 +519,13 @@ cfq_find_rq_fmerge(struct cfq_data *cfqd
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
 
@@ -622,6 +556,10 @@ static void cfq_deactivate_request(reque
 static void cfq_remove_request(struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_queue *cfqq = crq->cfq_queue;
+
+	if (cfqq->next_crq == crq)
+		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
 
 	list_del_init(&rq->queuelist);
 	cfq_del_crq_rb(crq);
@@ -642,14 +580,14 @@ cfq_merge(request_queue_t *q, struct req
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
 		cfq_reposition_crq_rb(cfqq, crq);
 	}
 }
@@ -658,8 +596,6 @@ static void
 cfq_merged_requests(request_queue_t *q, struct request *rq,
 		    struct request *next)
 {
-	cfq_merged_request(q, rq);
-
 	/*
 	 * reposition in fifo if next is older than rq
 	 */
@@ -881,7 +817,6 @@ static void cfq_dispatch_insert(request_
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct request *rq;
 
-	cfqq->next_crq = cfq_find_next_crq(cfqd, cfqq, crq);
 	cfq_remove_request(crq->request);
 	cfqq->on_dispatch[cfq_crq_is_sync(crq)]++;
 	elv_dispatch_sort(q, crq->request);
@@ -1700,6 +1635,12 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
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
@@ -1756,6 +1697,9 @@ static void cfq_insert_request(request_q
 
 	cfq_add_crq_rb(crq);
 
+	if (!cfq_cfqq_on_rr(cfqq))
+		cfq_add_cfqq_rr(cfqd, cfqq);
+
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 
 	cfq_crq_enqueued(cfqd, cfqq, crq);
@@ -1803,30 +1747,6 @@ static void cfq_completed_request(reques
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
@@ -1982,8 +1902,6 @@ cfq_set_request(request_queue_t *q, stru
 
 	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 	if (crq) {
-		RB_CLEAR_NODE(&crq->rb_node);
-		crq->rb_key = 0;
 		crq->request = rq;
 		crq->cfq_queue = cfqq;
 		crq->io_context = cic;
@@ -2345,8 +2263,8 @@ static struct elevator_type iosched_cfq 
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
-- 
1.4.1.ged0e0

