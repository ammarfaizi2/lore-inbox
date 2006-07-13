Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWGMMri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWGMMri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGMMqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:46:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36911 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932500AbWGMMoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:08 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 15/15 as-iosched: kill arq
Date: Thu, 13 Jul 2006 14:46:38 +0200
Message-Id: <1152794799690-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the as_rq request type. With the added elevator_private2, we
have enough room in struct request to get rid of any arq allocation/free
for each request.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/as-iosched.c |  311 ++++++++++++++++++++--------------------------------
 1 files changed, 117 insertions(+), 194 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index 3fbb56d..5083f6a 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -92,7 +92,7 @@ struct as_data {
 	struct rb_root sort_list[2];
 	struct list_head fifo_list[2];
 
-	struct as_rq *next_arq[2];	/* next in sort order */
+	struct request *next_rq[2];	/* next in sort order */
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
 
 	unsigned long exit_prob;	/* probability a task will exit while
@@ -113,7 +113,6 @@ struct as_data {
 	int write_batch_count;		/* max # of reqs in a write batch */
 	int current_write_count;	/* how many requests left this batch */
 	int write_batch_idled;		/* has the write batch gone idle? */
-	mempool_t *arq_pool;
 
 	enum anticipation_status antic_status;
 	unsigned long antic_start;	/* jiffies: when it started */
@@ -146,22 +145,14 @@ enum arq_state {
 	AS_RQ_POSTSCHED,	/* when they shouldn't be */
 };
 
-struct as_rq {
-	struct request *request;
-
-	struct io_context *io_context;	/* The submitting task */
-
-	enum arq_state state;
-};
-
-#define RQ_DATA(rq)	((struct as_rq *) (rq)->elevator_private)
-
-static kmem_cache_t *arq_pool;
+#define RQ_IOC(rq)	((struct io_context *) (rq)->elevator_private)
+#define RQ_STATE(rq)	((enum arq_state)(rq)->elevator_private2)
+#define RQ_SET_STATE(rq, state)	((rq)->elevator_private2 = (void *) state)
 
 static atomic_t ioc_count = ATOMIC_INIT(0);
 static struct completion *ioc_gone;
 
-static void as_move_to_dispatch(struct as_data *ad, struct as_rq *arq);
+static void as_move_to_dispatch(struct as_data *ad, struct request *rq);
 static void as_antic_stop(struct as_data *ad);
 
 /*
@@ -231,23 +222,23 @@ static struct io_context *as_get_io_cont
 	return ioc;
 }
 
-static void as_put_io_context(struct as_rq *arq)
+static void as_put_io_context(struct request *rq)
 {
 	struct as_io_context *aic;
 
-	if (unlikely(!arq->io_context))
+	if (unlikely(!RQ_IOC(rq)))
 		return;
 
-	aic = arq->io_context->aic;
+	aic = RQ_IOC(rq)->aic;
 
-	if (rq_is_sync(arq->request) && aic) {
+	if (rq_is_sync(rq) && aic) {
 		spin_lock(&aic->lock);
 		set_bit(AS_TASK_IORUNNING, &aic->state);
 		aic->last_end_request = jiffies;
 		spin_unlock(&aic->lock);
 	}
 
-	put_io_context(arq->io_context);
+	put_io_context(RQ_IOC(rq));
 }
 
 /*
@@ -255,17 +246,17 @@ static void as_put_io_context(struct as_
  */
 #define RQ_RB_ROOT(ad, rq)	(&(ad)->sort_list[rq_is_sync((rq))])
 
-static void as_add_arq_rb(struct as_data *ad, struct request *rq)
+static void as_add_rq_rb(struct as_data *ad, struct request *rq)
 {
 	struct request *alias;
 
 	while ((unlikely(alias = elv_rb_add(RQ_RB_ROOT(ad, rq), rq)))) {
-		as_move_to_dispatch(ad, RQ_DATA(alias));
+		as_move_to_dispatch(ad, alias);
 		as_antic_stop(ad);
 	}
 }
 
-static inline void as_del_arq_rb(struct as_data *ad, struct request *rq)
+static inline void as_del_rq_rb(struct as_data *ad, struct request *rq)
 {
 	elv_rb_del(RQ_RB_ROOT(ad, rq), rq);
 }
@@ -285,26 +276,26 @@ #define BACK_PENALTY	2
  * as_choose_req selects the preferred one of two requests of the same data_dir
  * ignoring time - eg. timeouts, which is the job of as_dispatch_request
  */
-static struct as_rq *
-as_choose_req(struct as_data *ad, struct as_rq *arq1, struct as_rq *arq2)
+static struct request *
+as_choose_req(struct as_data *ad, struct request *rq1, struct request *rq2)
 {
 	int data_dir;
 	sector_t last, s1, s2, d1, d2;
 	int r1_wrap=0, r2_wrap=0;	/* requests are behind the disk head */
 	const sector_t maxback = MAXBACK;
 
-	if (arq1 == NULL || arq1 == arq2)
-		return arq2;
-	if (arq2 == NULL)
-		return arq1;
+	if (rq1 == NULL || rq1 == rq2)
+		return rq2;
+	if (rq2 == NULL)
+		return rq1;
 
-	data_dir = rq_is_sync(arq1->request);
+	data_dir = rq_is_sync(rq1);
 
 	last = ad->last_sector[data_dir];
-	s1 = arq1->request->sector;
-	s2 = arq2->request->sector;
+	s1 = rq1->sector;
+	s2 = rq2->sector;
 
-	BUG_ON(data_dir != rq_is_sync(arq2->request));
+	BUG_ON(data_dir != rq_is_sync(rq2));
 
 	/*
 	 * Strict one way elevator _except_ in the case where we allow
@@ -331,55 +322,55 @@ as_choose_req(struct as_data *ad, struct
 
 	/* Found required data */
 	if (!r1_wrap && r2_wrap)
-		return arq1;
+		return rq1;
 	else if (!r2_wrap && r1_wrap)
-		return arq2;
+		return rq2;
 	else if (r1_wrap && r2_wrap) {
 		/* both behind the head */
 		if (s1 <= s2)
-			return arq1;
+			return rq1;
 		else
-			return arq2;
+			return rq2;
 	}
 
 	/* Both requests in front of the head */
 	if (d1 < d2)
-		return arq1;
+		return rq1;
 	else if (d2 < d1)
-		return arq2;
+		return rq2;
 	else {
 		if (s1 >= s2)
-			return arq1;
+			return rq1;
 		else
-			return arq2;
+			return rq2;
 	}
 }
 
 /*
- * as_find_next_arq finds the next request after @prev in elevator order.
+ * as_find_next_rq finds the next request after @prev in elevator order.
  * this with as_choose_req form the basis for how the scheduler chooses
  * what request to process next. Anticipation works on top of this.
  */
-static struct as_rq *as_find_next_arq(struct as_data *ad, struct as_rq *arq)
+static struct request *
+as_find_next_rq(struct as_data *ad, struct request *last)
 {
-	struct request *last = arq->request;
 	struct rb_node *rbnext = rb_next(&last->rb_node);
 	struct rb_node *rbprev = rb_prev(&last->rb_node);
-	struct as_rq *next = NULL, *prev = NULL;
+	struct request *next = NULL, *prev = NULL;
 
 	BUG_ON(RB_EMPTY_NODE(&last->rb_node));
 
 	if (rbprev)
-		prev = RQ_DATA(rb_entry_rq(rbprev));
+		prev = rb_entry_rq(rbprev);
 
 	if (rbnext)
-		next = RQ_DATA(rb_entry_rq(rbnext));
+		next = rb_entry_rq(rbnext);
 	else {
 		const int data_dir = rq_is_sync(last);
 
 		rbnext = rb_first(&ad->sort_list[data_dir]);
 		if (rbnext && rbnext != &last->rb_node)
-			next = RQ_DATA(rb_entry_rq(rbnext));
+			next = rb_entry_rq(rbnext);
 	}
 
 	return as_choose_req(ad, next, prev);
@@ -575,11 +566,11 @@ static void as_update_iohist(struct as_d
  * previous one issued.
  */
 static int as_close_req(struct as_data *ad, struct as_io_context *aic,
-				struct as_rq *arq)
+			struct request *rq)
 {
 	unsigned long delay;	/* milliseconds */
 	sector_t last = ad->last_sector[ad->batch_data_dir];
-	sector_t next = arq->request->sector;
+	sector_t next = rq->sector;
 	sector_t delta; /* acceptable close offset (in sectors) */
 	sector_t s;
 
@@ -636,7 +627,7 @@ static int as_close_req(struct as_data *
  *
  * If this task has queued some other IO, do not enter enticipation.
  */
-static int as_can_break_anticipation(struct as_data *ad, struct as_rq *arq)
+static int as_can_break_anticipation(struct as_data *ad, struct request *rq)
 {
 	struct io_context *ioc;
 	struct as_io_context *aic;
@@ -644,7 +635,7 @@ static int as_can_break_anticipation(str
 	ioc = ad->io_context;
 	BUG_ON(!ioc);
 
-	if (arq && ioc == arq->io_context) {
+	if (rq && ioc == RQ_IOC(rq)) {
 		/* request from same process */
 		return 1;
 	}
@@ -671,7 +662,7 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
-	if (arq && rq_is_sync(arq->request) && as_close_req(ad, aic, arq)) {
+	if (rq && rq_is_sync(rq) && as_close_req(ad, aic, rq)) {
 		/*
 		 * Found a close request that is not one of ours.
 		 *
@@ -687,7 +678,7 @@ static int as_can_break_anticipation(str
 			ad->exit_no_coop = (7*ad->exit_no_coop)/8;
 		}
 
-		as_update_iohist(ad, aic, arq->request);
+		as_update_iohist(ad, aic, rq);
 		return 1;
 	}
 
@@ -714,10 +705,10 @@ static int as_can_break_anticipation(str
 }
 
 /*
- * as_can_anticipate indicates whether we should either run arq
+ * as_can_anticipate indicates whether we should either run rq
  * or keep anticipating a better request.
  */
-static int as_can_anticipate(struct as_data *ad, struct as_rq *arq)
+static int as_can_anticipate(struct as_data *ad, struct request *rq)
 {
 	if (!ad->io_context)
 		/*
@@ -731,7 +722,7 @@ static int as_can_anticipate(struct as_d
 		 */
 		return 0;
 
-	if (as_can_break_anticipation(ad, arq))
+	if (as_can_break_anticipation(ad, rq))
 		/*
 		 * This request is a good candidate. Don't keep anticipating,
 		 * run it.
@@ -749,16 +740,16 @@ static int as_can_anticipate(struct as_d
 }
 
 /*
- * as_update_arq must be called whenever a request (arq) is added to
+ * as_update_rq must be called whenever a request (rq) is added to
  * the sort_list. This function keeps caches up to date, and checks if the
  * request might be one we are "anticipating"
  */
-static void as_update_arq(struct as_data *ad, struct as_rq *arq)
+static void as_update_rq(struct as_data *ad, struct request *rq)
 {
-	const int data_dir = rq_is_sync(arq->request);
+	const int data_dir = rq_is_sync(rq);
 
-	/* keep the next_arq cache up to date */
-	ad->next_arq[data_dir] = as_choose_req(ad, arq, ad->next_arq[data_dir]);
+	/* keep the next_rq cache up to date */
+	ad->next_rq[data_dir] = as_choose_req(ad, rq, ad->next_rq[data_dir]);
 
 	/*
 	 * have we been anticipating this request?
@@ -767,7 +758,7 @@ static void as_update_arq(struct as_data
 	 */
 	if (ad->antic_status == ANTIC_WAIT_REQ
 			|| ad->antic_status == ANTIC_WAIT_NEXT) {
-		if (as_can_break_anticipation(ad, arq))
+		if (as_can_break_anticipation(ad, rq))
 			as_antic_stop(ad);
 	}
 }
@@ -807,12 +798,11 @@ static void update_write_batch(struct as
 static void as_completed_request(request_queue_t *q, struct request *rq)
 {
 	struct as_data *ad = q->elevator->elevator_data;
-	struct as_rq *arq = RQ_DATA(rq);
 
 	WARN_ON(!list_empty(&rq->queuelist));
 
-	if (arq->state != AS_RQ_REMOVED) {
-		printk("arq->state %d\n", arq->state);
+	if (RQ_STATE(rq) != AS_RQ_REMOVED) {
+		printk("rq->state %d\n", RQ_STATE(rq));
 		WARN_ON(1);
 		goto out;
 	}
@@ -839,7 +829,7 @@ static void as_completed_request(request
 		ad->new_batch = 0;
 	}
 
-	if (ad->io_context == arq->io_context && ad->io_context) {
+	if (ad->io_context == RQ_IOC(rq) && ad->io_context) {
 		ad->antic_start = jiffies;
 		ad->ioc_finished = 1;
 		if (ad->antic_status == ANTIC_WAIT_REQ) {
@@ -851,9 +841,9 @@ static void as_completed_request(request
 		}
 	}
 
-	as_put_io_context(arq);
+	as_put_io_context(rq);
 out:
-	arq->state = AS_RQ_POSTSCHED;
+	RQ_SET_STATE(rq, AS_RQ_POSTSCHED);
 }
 
 /*
@@ -864,26 +854,27 @@ out:
  */
 static void as_remove_queued_request(request_queue_t *q, struct request *rq)
 {
-	struct as_rq *arq = RQ_DATA(rq);
 	const int data_dir = rq_is_sync(rq);
 	struct as_data *ad = q->elevator->elevator_data;
+	struct io_context *ioc;
 
-	WARN_ON(arq->state != AS_RQ_QUEUED);
+	WARN_ON(RQ_STATE(rq) != AS_RQ_QUEUED);
 
-	if (arq->io_context && arq->io_context->aic) {
-		BUG_ON(!atomic_read(&arq->io_context->aic->nr_queued));
-		atomic_dec(&arq->io_context->aic->nr_queued);
+	ioc = RQ_IOC(rq);
+	if (ioc && ioc->aic) {
+		BUG_ON(!atomic_read(&ioc->aic->nr_queued));
+		atomic_dec(&ioc->aic->nr_queued);
 	}
 
 	/*
-	 * Update the "next_arq" cache if we are about to remove its
+	 * Update the "next_rq" cache if we are about to remove its
 	 * entry
 	 */
-	if (ad->next_arq[data_dir] == arq)
-		ad->next_arq[data_dir] = as_find_next_arq(ad, arq);
+	if (ad->next_rq[data_dir] == rq)
+		ad->next_rq[data_dir] = as_find_next_rq(ad, rq);
 
 	rq_fifo_clear(rq);
-	as_del_arq_rb(ad, rq);
+	as_del_rq_rb(ad, rq);
 }
 
 /*
@@ -935,9 +926,8 @@ static inline int as_batch_expired(struc
 /*
  * move an entry to dispatch queue
  */
-static void as_move_to_dispatch(struct as_data *ad, struct as_rq *arq)
+static void as_move_to_dispatch(struct as_data *ad, struct request *rq)
 {
-	struct request *rq = arq->request;
 	const int data_dir = rq_is_sync(rq);
 
 	BUG_ON(RB_EMPTY_NODE(&rq->rb_node));
@@ -947,13 +937,14 @@ static void as_move_to_dispatch(struct a
 
 	/*
 	 * This has to be set in order to be correctly updated by
-	 * as_find_next_arq
+	 * as_find_next_rq
 	 */
 	ad->last_sector[data_dir] = rq->sector + rq->nr_sectors;
 
 	if (data_dir == REQ_SYNC) {
+		struct io_context *ioc = RQ_IOC(rq);
 		/* In case we have to anticipate after this */
-		copy_io_context(&ad->io_context, &arq->io_context);
+		copy_io_context(&ad->io_context, &ioc);
 	} else {
 		if (ad->io_context) {
 			put_io_context(ad->io_context);
@@ -969,13 +960,13 @@ static void as_move_to_dispatch(struct a
 	 * take it off the sort and fifo list, add to dispatch queue
 	 */
 	as_remove_queued_request(ad->q, rq);
-	WARN_ON(arq->state != AS_RQ_QUEUED);
+	WARN_ON(RQ_STATE(rq) != AS_RQ_QUEUED);
 
 	elv_dispatch_sort(ad->q, rq);
 
-	arq->state = AS_RQ_DISPATCHED;
-	if (arq->io_context && arq->io_context->aic)
-		atomic_inc(&arq->io_context->aic->nr_dispatched);
+	RQ_SET_STATE(rq, AS_RQ_DISPATCHED);
+	if (RQ_IOC(rq) && RQ_IOC(rq)->aic)
+		atomic_inc(&RQ_IOC(rq)->aic->nr_dispatched);
 	ad->nr_dispatched++;
 }
 
@@ -987,9 +978,9 @@ static void as_move_to_dispatch(struct a
 static int as_dispatch_request(request_queue_t *q, int force)
 {
 	struct as_data *ad = q->elevator->elevator_data;
-	struct as_rq *arq;
 	const int reads = !list_empty(&ad->fifo_list[REQ_SYNC]);
 	const int writes = !list_empty(&ad->fifo_list[REQ_ASYNC]);
+	struct request *rq;
 
 	if (unlikely(force)) {
 		/*
@@ -1005,14 +996,14 @@ static int as_dispatch_request(request_q
 		ad->changed_batch = 0;
 		ad->new_batch = 0;
 
-		while (ad->next_arq[REQ_SYNC]) {
-			as_move_to_dispatch(ad, ad->next_arq[REQ_SYNC]);
+		while (ad->next_rq[REQ_SYNC]) {
+			as_move_to_dispatch(ad, ad->next_rq[REQ_SYNC]);
 			dispatched++;
 		}
 		ad->last_check_fifo[REQ_SYNC] = jiffies;
 
-		while (ad->next_arq[REQ_ASYNC]) {
-			as_move_to_dispatch(ad, ad->next_arq[REQ_ASYNC]);
+		while (ad->next_rq[REQ_ASYNC]) {
+			as_move_to_dispatch(ad, ad->next_rq[REQ_ASYNC]);
 			dispatched++;
 		}
 		ad->last_check_fifo[REQ_ASYNC] = jiffies;
@@ -1036,19 +1027,19 @@ static int as_dispatch_request(request_q
 		/*
 		 * batch is still running or no reads or no writes
 		 */
-		arq = ad->next_arq[ad->batch_data_dir];
+		rq = ad->next_rq[ad->batch_data_dir];
 
 		if (ad->batch_data_dir == REQ_SYNC && ad->antic_expire) {
 			if (as_fifo_expired(ad, REQ_SYNC))
 				goto fifo_expired;
 
-			if (as_can_anticipate(ad, arq)) {
+			if (as_can_anticipate(ad, rq)) {
 				as_antic_waitreq(ad);
 				return 0;
 			}
 		}
 
-		if (arq) {
+		if (rq) {
 			/* we have a "next request" */
 			if (reads && !writes)
 				ad->current_batch_expires =
@@ -1076,7 +1067,7 @@ static int as_dispatch_request(request_q
 			ad->changed_batch = 1;
 		}
 		ad->batch_data_dir = REQ_SYNC;
-		arq = RQ_DATA(rq_entry_fifo(ad->fifo_list[REQ_SYNC].next));
+		rq = rq_entry_fifo(ad->fifo_list[REQ_SYNC].next);
 		ad->last_check_fifo[ad->batch_data_dir] = jiffies;
 		goto dispatch_request;
 	}
@@ -1102,7 +1093,7 @@ dispatch_writes:
 		ad->batch_data_dir = REQ_ASYNC;
 		ad->current_write_count = ad->write_batch_count;
 		ad->write_batch_idled = 0;
-		arq = ad->next_arq[ad->batch_data_dir];
+		rq = ad->next_rq[ad->batch_data_dir];
 		goto dispatch_request;
 	}
 
@@ -1116,7 +1107,7 @@ dispatch_request:
 
 	if (as_fifo_expired(ad, ad->batch_data_dir)) {
 fifo_expired:
-		arq = RQ_DATA(rq_entry_fifo(ad->fifo_list[ad->batch_data_dir].next));
+		rq = rq_entry_fifo(ad->fifo_list[ad->batch_data_dir].next);
 	}
 
 	if (ad->changed_batch) {
@@ -1135,34 +1126,33 @@ fifo_expired:
 	}
 
 	/*
-	 * arq is the selected appropriate request.
+	 * rq is the selected appropriate request.
 	 */
-	as_move_to_dispatch(ad, arq);
+	as_move_to_dispatch(ad, rq);
 
 	return 1;
 }
 
 /*
- * add arq to rbtree and fifo
+ * add rq to rbtree and fifo
  */
 static void as_add_request(request_queue_t *q, struct request *rq)
 {
 	struct as_data *ad = q->elevator->elevator_data;
-	struct as_rq *arq = RQ_DATA(rq);
 	int data_dir;
 
-	arq->state = AS_RQ_NEW;
+	RQ_SET_STATE(rq, AS_RQ_NEW);
 
 	data_dir = rq_is_sync(rq);
 
-	arq->io_context = as_get_io_context();
+	rq->elevator_private = as_get_io_context();
 
-	if (arq->io_context) {
-		as_update_iohist(ad, arq->io_context->aic, arq->request);
-		atomic_inc(&arq->io_context->aic->nr_queued);
+	if (RQ_IOC(rq)) {
+		as_update_iohist(ad, RQ_IOC(rq)->aic, rq);
+		atomic_inc(&RQ_IOC(rq)->aic->nr_queued);
 	}
 
-	as_add_arq_rb(ad, rq);
+	as_add_rq_rb(ad, rq);
 
 	/*
 	 * set expire time (only used for reads) and add to fifo list
@@ -1170,28 +1160,24 @@ static void as_add_request(request_queue
 	rq_set_fifo_time(rq, jiffies + ad->fifo_expire[data_dir]);
 	list_add_tail(&rq->queuelist, &ad->fifo_list[data_dir]);
 
-	as_update_arq(ad, arq); /* keep state machine up to date */
-	arq->state = AS_RQ_QUEUED;
+	as_update_rq(ad, rq); /* keep state machine up to date */
+	RQ_SET_STATE(rq, AS_RQ_QUEUED);
 }
 
 static void as_activate_request(request_queue_t *q, struct request *rq)
 {
-	struct as_rq *arq = RQ_DATA(rq);
-
-	WARN_ON(arq->state != AS_RQ_DISPATCHED);
-	arq->state = AS_RQ_REMOVED;
-	if (arq->io_context && arq->io_context->aic)
-		atomic_dec(&arq->io_context->aic->nr_dispatched);
+	WARN_ON(RQ_STATE(rq) != AS_RQ_DISPATCHED);
+	RQ_SET_STATE(rq, AS_RQ_REMOVED);
+	if (RQ_IOC(rq) && RQ_IOC(rq)->aic)
+		atomic_dec(&RQ_IOC(rq)->aic->nr_dispatched);
 }
 
 static void as_deactivate_request(request_queue_t *q, struct request *rq)
 {
-	struct as_rq *arq = RQ_DATA(rq);
-
-	WARN_ON(arq->state != AS_RQ_REMOVED);
-	arq->state = AS_RQ_DISPATCHED;
-	if (arq->io_context && arq->io_context->aic)
-		atomic_inc(&arq->io_context->aic->nr_dispatched);
+	WARN_ON(RQ_STATE(rq) != AS_RQ_REMOVED);
+	RQ_SET_STATE(rq, AS_RQ_DISPATCHED);
+	if (RQ_IOC(rq) && RQ_IOC(rq)->aic)
+		atomic_inc(&RQ_IOC(rq)->aic->nr_dispatched);
 }
 
 /*
@@ -1235,8 +1221,8 @@ static void as_merged_request(request_qu
 	 * if the merge was a front merge, we need to reposition request
 	 */
 	if (type == ELEVATOR_FRONT_MERGE) {
-		as_del_arq_rb(ad, req);
-		as_add_arq_rb(ad, req);
+		as_del_rq_rb(ad, req);
+		as_add_rq_rb(ad, req);
 		/*
 		 * Note! At this stage of this and the next function, our next
 		 * request may not be optimal - eg the request may have "grown"
@@ -1248,25 +1234,22 @@ static void as_merged_request(request_qu
 static void as_merged_requests(request_queue_t *q, struct request *req,
 			 	struct request *next)
 {
-	struct as_rq *arq = RQ_DATA(req);
-	struct as_rq *anext = RQ_DATA(next);
-
-	BUG_ON(!arq);
-	BUG_ON(!anext);
-
 	/*
-	 * if anext expires before arq, assign its expire time to arq
-	 * and move into anext position (anext will be deleted) in fifo
+	 * if next expires before rq, assign its expire time to arq
+	 * and move into next position (next will be deleted) in fifo
 	 */
 	if (!list_empty(&req->queuelist) && !list_empty(&next->queuelist)) {
 		if (time_before(rq_fifo_time(next), rq_fifo_time(req))) {
+			struct io_context *rioc = RQ_IOC(req);
+			struct io_context *nioc = RQ_IOC(next);
+
 			list_move(&req->queuelist, &next->queuelist);
 			rq_set_fifo_time(req, rq_fifo_time(next));
 			/*
 			 * Don't copy here but swap, because when anext is
 			 * removed below, it must contain the unused context
 			 */
-			swap_io_context(&arq->io_context, &anext->io_context);
+			swap_io_context(&rioc, &nioc);
 		}
 	}
 
@@ -1274,9 +1257,9 @@ static void as_merged_requests(request_q
 	 * kill knowledge of next, this one is a goner
 	 */
 	as_remove_queued_request(q, next);
-	as_put_io_context(anext);
+	as_put_io_context(next);
 
-	anext->state = AS_RQ_MERGED;
+	RQ_SET_STATE(next, AS_RQ_MERGED);
 }
 
 /*
@@ -1299,45 +1282,6 @@ static void as_work_handler(void *data)
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
-static void as_put_request(request_queue_t *q, struct request *rq)
-{
-	struct as_data *ad = q->elevator->elevator_data;
-	struct as_rq *arq = RQ_DATA(rq);
-
-	if (!arq) {
-		WARN_ON(1);
-		return;
-	}
-
-	if (unlikely(arq->state != AS_RQ_POSTSCHED &&
-		     arq->state != AS_RQ_PRESCHED &&
-		     arq->state != AS_RQ_MERGED)) {
-		printk("arq->state %d\n", arq->state);
-		WARN_ON(1);
-	}
-
-	mempool_free(arq, ad->arq_pool);
-	rq->elevator_private = NULL;
-}
-
-static int as_set_request(request_queue_t *q, struct request *rq,
-			  struct bio *bio, gfp_t gfp_mask)
-{
-	struct as_data *ad = q->elevator->elevator_data;
-	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
-
-	if (arq) {
-		memset(arq, 0, sizeof(*arq));
-		arq->request = rq;
-		arq->state = AS_RQ_PRESCHED;
-		arq->io_context = NULL;
-		rq->elevator_private = arq;
-		return 0;
-	}
-
-	return 1;
-}
-
 static int as_may_queue(request_queue_t *q, int rw, struct bio *bio)
 {
 	int ret = ELV_MQUEUE_MAY;
@@ -1364,22 +1308,17 @@ static void as_exit_queue(elevator_t *e)
 	BUG_ON(!list_empty(&ad->fifo_list[REQ_SYNC]));
 	BUG_ON(!list_empty(&ad->fifo_list[REQ_ASYNC]));
 
-	mempool_destroy(ad->arq_pool);
 	put_io_context(ad->io_context);
 	kfree(ad);
 }
 
 /*
- * initialize elevator private data (as_data), and alloc a arq for
- * each request on the free lists
+ * initialize elevator private data (as_data).
  */
 static void *as_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct as_data *ad;
 
-	if (!arq_pool)
-		return NULL;
-
 	ad = kmalloc_node(sizeof(*ad), GFP_KERNEL, q->node);
 	if (!ad)
 		return NULL;
@@ -1387,13 +1326,6 @@ static void *as_init_queue(request_queue
 
 	ad->q = q; /* Identify what queue the data belongs to */
 
-	ad->arq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
-				mempool_free_slab, arq_pool, q->node);
-	if (!ad->arq_pool) {
-		kfree(ad);
-		return NULL;
-	}
-
 	/* anticipatory scheduling helpers */
 	ad->antic_timer.function = as_antic_timeout;
 	ad->antic_timer.data = (unsigned long)q;
@@ -1514,8 +1446,6 @@ static struct elevator_type iosched_as =
 		.elevator_completed_req_fn =	as_completed_request,
 		.elevator_former_req_fn =	elv_rb_former_request,
 		.elevator_latter_req_fn =	elv_rb_latter_request,
-		.elevator_set_req_fn =		as_set_request,
-		.elevator_put_req_fn =		as_put_request,
 		.elevator_may_queue_fn =	as_may_queue,
 		.elevator_init_fn =		as_init_queue,
 		.elevator_exit_fn =		as_exit_queue,
@@ -1531,11 +1461,6 @@ static int __init as_init(void)
 {
 	int ret;
 
-	arq_pool = kmem_cache_create("as_arq", sizeof(struct as_rq),
-				     0, 0, NULL, NULL);
-	if (!arq_pool)
-		return -ENOMEM;
-
 	ret = elv_register(&iosched_as);
 	if (!ret) {
 		/*
@@ -1547,7 +1472,6 @@ static int __init as_init(void)
 		return 0;
 	}
 
-	kmem_cache_destroy(arq_pool);
 	return ret;
 }
 
@@ -1561,7 +1485,6 @@ static void __exit as_exit(void)
 	if (atomic_read(&ioc_count))
 		wait_for_completion(ioc_gone);
 	synchronize_rcu();
-	kmem_cache_destroy(arq_pool);
 }
 
 module_init(as_init);
-- 
1.4.1.ged0e0

