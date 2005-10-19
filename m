Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVJSMfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVJSMfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVJSMfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:35:24 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbVJSMfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:35:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=FHPHkDz4PrhhwHyDVysWkTTT49oL/MbgKyw4A2TTGjauGcG4rmik72dKlRog/ZL5T9cgitD4vH23imX2AVlLSWCn1AO43XzEoxrg1bTFdnSsRlIFSMC60UQAO1Bw73kAtdTZO1awuCn5RWSxrPYmCC96c9iE7B6Uy1dmY1jq7Uk=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019123429.450E4424@htj.dyndns.org>
In-Reply-To: <20051019123429.450E4424@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 02/05] blk: update ioscheds to use generic dispatch queue
Message-ID: <20051019123429.D377069C@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:35:13 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_generic-dispatch-queue-update-for-ioscheds.patch

	This patch updates all four ioscheds to use generic dispatch
	queue.  There's one behavior change in as-iosched.

	* In as-iosched, when force dispatching
	  (ELEVATOR_INSERT_BACK), batch_data_dir is reset to REQ_SYNC
	  and changed_batch and new_batch are cleared to zero.  This
	  prevernts AS from doing incorrect update_write_batch after
	  the forced dispatched requests are finished.

	* In cfq-iosched, cfqd->rq_in_driver currently counts the
	  number of activated (removed) requests to determine
	  whether queue-kicking is needed and cfq_max_depth has been
	  reached.  With generic dispatch queue, I think counting
	  the number of dispatched requests would be more appropriate.

	* cfq_max_depth can be lowered to 1 again.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 as-iosched.c       |  294 +++++++++++++--------------------------------
 cfq-iosched.c      |  344 ++++++++++++-----------------------------------------
 deadline-iosched.c |   95 ++------------
 noop-iosched.c     |   17 --
 4 files changed, 191 insertions(+), 559 deletions(-)

Index: blk-fixes/drivers/block/as-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/as-iosched.c	2005-10-19 21:26:16.000000000 +0900
+++ blk-fixes/drivers/block/as-iosched.c	2005-10-19 21:34:02.000000000 +0900
@@ -98,7 +98,6 @@ struct as_data {
 
 	struct as_rq *next_arq[2];	/* next in sort order */
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
-	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
 
 	unsigned long exit_prob;	/* probability a task will exit while
@@ -239,6 +238,25 @@ static struct io_context *as_get_io_cont
 	return ioc;
 }
 
+static void as_put_io_context(struct as_rq *arq)
+{
+	struct as_io_context *aic;
+
+	if (unlikely(!arq->io_context))
+		return;
+
+	aic = arq->io_context->aic;
+
+	if (arq->is_sync == REQ_SYNC && aic) {
+		spin_lock(&aic->lock);
+		set_bit(AS_TASK_IORUNNING, &aic->state);
+		aic->last_end_request = jiffies;
+		spin_unlock(&aic->lock);
+	}
+
+	put_io_context(arq->io_context);
+}
+
 /*
  * the back merge hash support functions
  */
@@ -950,23 +968,12 @@ static void as_completed_request(request
 
 	WARN_ON(!list_empty(&rq->queuelist));
 
-	if (arq->state == AS_RQ_PRESCHED) {
-		WARN_ON(arq->io_context);
-		goto out;
-	}
-
-	if (arq->state == AS_RQ_MERGED)
-		goto out_ioc;
-
 	if (arq->state != AS_RQ_REMOVED) {
 		printk("arq->state %d\n", arq->state);
 		WARN_ON(1);
 		goto out;
 	}
 
-	if (!blk_fs_request(rq))
-		goto out;
-
 	if (ad->changed_batch && ad->nr_dispatched == 1) {
 		kblockd_schedule_work(&ad->antic_work);
 		ad->changed_batch = 0;
@@ -1001,21 +1008,7 @@ static void as_completed_request(request
 		}
 	}
 
-out_ioc:
-	if (!arq->io_context)
-		goto out;
-
-	if (arq->is_sync == REQ_SYNC) {
-		struct as_io_context *aic = arq->io_context->aic;
-		if (aic) {
-			spin_lock(&aic->lock);
-			set_bit(AS_TASK_IORUNNING, &aic->state);
-			aic->last_end_request = jiffies;
-			spin_unlock(&aic->lock);
-		}
-	}
-
-	put_io_context(arq->io_context);
+	as_put_io_context(arq);
 out:
 	arq->state = AS_RQ_POSTSCHED;
 }
@@ -1052,68 +1045,6 @@ static void as_remove_queued_request(req
 }
 
 /*
- * as_remove_dispatched_request is called to remove a request which has gone
- * to the dispatch list.
- */
-static void as_remove_dispatched_request(request_queue_t *q, struct request *rq)
-{
-	struct as_rq *arq = RQ_DATA(rq);
-	struct as_io_context *aic;
-
-	if (!arq) {
-		WARN_ON(1);
-		return;
-	}
-
-	WARN_ON(arq->state != AS_RQ_DISPATCHED);
-	WARN_ON(ON_RB(&arq->rb_node));
-	if (arq->io_context && arq->io_context->aic) {
-		aic = arq->io_context->aic;
-		if (aic) {
-			WARN_ON(!atomic_read(&aic->nr_dispatched));
-			atomic_dec(&aic->nr_dispatched);
-		}
-	}
-}
-
-/*
- * as_remove_request is called when a driver has finished with a request.
- * This should be only called for dispatched requests, but for some reason
- * a POWER4 box running hwscan it does not.
- */
-static void as_remove_request(request_queue_t *q, struct request *rq)
-{
-	struct as_rq *arq = RQ_DATA(rq);
-
-	if (unlikely(arq->state == AS_RQ_NEW))
-		goto out;
-
-	if (ON_RB(&arq->rb_node)) {
-		if (arq->state != AS_RQ_QUEUED) {
-			printk("arq->state %d\n", arq->state);
-			WARN_ON(1);
-			goto out;
-		}
-		/*
-		 * We'll lose the aliased request(s) here. I don't think this
-		 * will ever happen, but if it does, hopefully someone will
-		 * report it.
-		 */
-		WARN_ON(!list_empty(&rq->queuelist));
-		as_remove_queued_request(q, rq);
-	} else {
-		if (arq->state != AS_RQ_DISPATCHED) {
-			printk("arq->state %d\n", arq->state);
-			WARN_ON(1);
-			goto out;
-		}
-		as_remove_dispatched_request(q, rq);
-	}
-out:
-	arq->state = AS_RQ_REMOVED;
-}
-
-/*
  * as_fifo_expired returns 0 if there are no expired reads on the fifo,
  * 1 otherwise.  It is ratelimited so that we only perform the check once per
  * `fifo_expire' interval.  Otherwise a large number of expired requests
@@ -1162,10 +1093,9 @@ static inline int as_batch_expired(struc
 /*
  * move an entry to dispatch queue
  */
-static void as_move_to_dispatch(struct as_data *ad, struct as_rq *arq)
+static void as_move_to_dispatch(struct as_data *ad, struct as_rq *arq, int force)
 {
 	struct request *rq = arq->request;
-	struct list_head *insert;
 	const int data_dir = arq->is_sync;
 
 	BUG_ON(!ON_RB(&arq->rb_node));
@@ -1198,13 +1128,13 @@ static void as_move_to_dispatch(struct a
 	/*
 	 * take it off the sort and fifo list, add to dispatch queue
 	 */
-	insert = ad->dispatch->prev;
-
 	while (!list_empty(&rq->queuelist)) {
 		struct request *__rq = list_entry_rq(rq->queuelist.next);
 		struct as_rq *__arq = RQ_DATA(__rq);
 
-		list_move_tail(&__rq->queuelist, ad->dispatch);
+		list_del(&__rq->queuelist);
+
+		elv_dispatch_insert(ad->q, __rq, force);
 
 		if (__arq->io_context && __arq->io_context->aic)
 			atomic_inc(&__arq->io_context->aic->nr_dispatched);
@@ -1218,7 +1148,8 @@ static void as_move_to_dispatch(struct a
 	as_remove_queued_request(ad->q, rq);
 	WARN_ON(arq->state != AS_RQ_QUEUED);
 
-	list_add(&rq->queuelist, insert);
+	elv_dispatch_insert(ad->q, rq, force);
+
 	arq->state = AS_RQ_DISPATCHED;
 	if (arq->io_context && arq->io_context->aic)
 		atomic_inc(&arq->io_context->aic->nr_dispatched);
@@ -1230,12 +1161,42 @@ static void as_move_to_dispatch(struct a
  * read/write expire, batch expire, etc, and moves it to the dispatch
  * queue. Returns 1 if a request was found, 0 otherwise.
  */
-static int as_dispatch_request(struct as_data *ad)
+static int as_dispatch_request(request_queue_t *q, int force)
 {
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq;
 	const int reads = !list_empty(&ad->fifo_list[REQ_SYNC]);
 	const int writes = !list_empty(&ad->fifo_list[REQ_ASYNC]);
 
+	if (unlikely(force)) {
+		/*
+		 * Forced dispatch, accounting is useless.  Reset
+		 * accounting states and dump fifo_lists.  Note that
+		 * batch_data_dir is reset to REQ_SYNC to avoid
+		 * screwing write batch accounting as write batch
+		 * accounting occurs on W->R transition.
+		 */
+		int dispatched = 0;
+
+		ad->batch_data_dir = REQ_SYNC;
+		ad->changed_batch = 0;
+		ad->new_batch = 0;
+
+		while (ad->next_arq[REQ_SYNC]) {
+			as_move_to_dispatch(ad, ad->next_arq[REQ_SYNC], 1);
+			dispatched++;
+		}
+		ad->last_check_fifo[REQ_SYNC] = jiffies;
+
+		while (ad->next_arq[REQ_ASYNC]) {
+			as_move_to_dispatch(ad, ad->next_arq[REQ_ASYNC], 1);
+			dispatched++;
+		}
+		ad->last_check_fifo[REQ_ASYNC] = jiffies;
+
+		return dispatched;
+	}
+
 	/* Signal that the write batch was uncontended, so we can't time it */
 	if (ad->batch_data_dir == REQ_ASYNC && !reads) {
 		if (ad->current_write_count == 0 || !writes)
@@ -1354,25 +1315,11 @@ fifo_expired:
 	/*
 	 * arq is the selected appropriate request.
 	 */
-	as_move_to_dispatch(ad, arq);
+	as_move_to_dispatch(ad, arq, 0);
 
 	return 1;
 }
 
-static struct request *as_next_request(request_queue_t *q)
-{
-	struct as_data *ad = q->elevator->elevator_data;
-	struct request *rq = NULL;
-
-	/*
-	 * if there are still requests on the dispatch queue, grab the first
-	 */
-	if (!list_empty(ad->dispatch) || as_dispatch_request(ad))
-		rq = list_entry_rq(ad->dispatch->next);
-
-	return rq;
-}
-
 /*
  * Add arq to a list behind alias
  */
@@ -1410,11 +1357,19 @@ as_add_aliased_request(struct as_data *a
 /*
  * add arq to rbtree and fifo
  */
-static void as_add_request(struct as_data *ad, struct as_rq *arq)
+static void as_add_request(request_queue_t *q, struct request *rq)
 {
+	struct as_data *ad = q->elevator->elevator_data;
+	struct as_rq *arq = RQ_DATA(rq);
 	struct as_rq *alias;
 	int data_dir;
 
+	if (arq->state != AS_RQ_PRESCHED) {
+		printk("arq->state: %d\n", arq->state);
+		WARN_ON(1);
+	}
+	arq->state = AS_RQ_NEW;
+
 	if (rq_data_dir(arq->request) == READ
 			|| current->flags&PF_SYNCWRITE)
 		arq->is_sync = 1;
@@ -1463,96 +1418,24 @@ static void as_add_request(struct as_dat
 	arq->state = AS_RQ_QUEUED;
 }
 
-static void as_deactivate_request(request_queue_t *q, struct request *rq)
+static void as_activate_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-	if (arq) {
-		if (arq->state == AS_RQ_REMOVED) {
-			arq->state = AS_RQ_DISPATCHED;
-			if (arq->io_context && arq->io_context->aic)
-				atomic_inc(&arq->io_context->aic->nr_dispatched);
-		}
-	} else
-		WARN_ON(blk_fs_request(rq)
-			&& (!(rq->flags & (REQ_HARDBARRIER|REQ_SOFTBARRIER))) );
-
-	/* Stop anticipating - let this request get through */
-	as_antic_stop(ad);
-}
-
-/*
- * requeue the request. The request has not been completed, nor is it a
- * new request, so don't touch accounting.
- */
-static void as_requeue_request(request_queue_t *q, struct request *rq)
-{
-	as_deactivate_request(q, rq);
-	list_add(&rq->queuelist, &q->queue_head);
-}
-
-/*
- * Account a request that is inserted directly onto the dispatch queue.
- * arq->io_context->aic->nr_dispatched should not need to be incremented
- * because only new requests should come through here: requeues go through
- * our explicit requeue handler.
- */
-static void as_account_queued_request(struct as_data *ad, struct request *rq)
-{
-	if (blk_fs_request(rq)) {
-		struct as_rq *arq = RQ_DATA(rq);
-		arq->state = AS_RQ_DISPATCHED;
-		ad->nr_dispatched++;
-	}
+	WARN_ON(arq->state != AS_RQ_DISPATCHED);
+	arq->state = AS_RQ_REMOVED;
+	if (arq->io_context && arq->io_context->aic)
+		atomic_dec(&arq->io_context->aic->nr_dispatched);
 }
 
-static void
-as_insert_request(request_queue_t *q, struct request *rq, int where)
+static void as_deactivate_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-	if (arq) {
-		if (arq->state != AS_RQ_PRESCHED) {
-			printk("arq->state: %d\n", arq->state);
-			WARN_ON(1);
-		}
-		arq->state = AS_RQ_NEW;
-	}
-
-	/* barriers must flush the reorder queue */
-	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
-			&& where == ELEVATOR_INSERT_SORT)) {
-		WARN_ON(1);
-		where = ELEVATOR_INSERT_BACK;
-	}
-
-	switch (where) {
-		case ELEVATOR_INSERT_BACK:
-			while (ad->next_arq[REQ_SYNC])
-				as_move_to_dispatch(ad, ad->next_arq[REQ_SYNC]);
-
-			while (ad->next_arq[REQ_ASYNC])
-				as_move_to_dispatch(ad, ad->next_arq[REQ_ASYNC]);
-
-			list_add_tail(&rq->queuelist, ad->dispatch);
-			as_account_queued_request(ad, rq);
-			as_antic_stop(ad);
-			break;
-		case ELEVATOR_INSERT_FRONT:
-			list_add(&rq->queuelist, ad->dispatch);
-			as_account_queued_request(ad, rq);
-			as_antic_stop(ad);
-			break;
-		case ELEVATOR_INSERT_SORT:
-			BUG_ON(!blk_fs_request(rq));
-			as_add_request(ad, arq);
-			break;
-		default:
-			BUG();
-			return;
-	}
+	WARN_ON(arq->state != AS_RQ_REMOVED);
+	arq->state = AS_RQ_DISPATCHED;
+	if (arq->io_context && arq->io_context->aic)
+		atomic_inc(&arq->io_context->aic->nr_dispatched);
 }
 
 /*
@@ -1565,12 +1448,8 @@ static int as_queue_empty(request_queue_
 {
 	struct as_data *ad = q->elevator->elevator_data;
 
-	if (!list_empty(&ad->fifo_list[REQ_ASYNC])
-		|| !list_empty(&ad->fifo_list[REQ_SYNC])
-		|| !list_empty(ad->dispatch))
-			return 0;
-
-	return 1;
+	return list_empty(&ad->fifo_list[REQ_ASYNC])
+		&& list_empty(&ad->fifo_list[REQ_SYNC]);
 }
 
 static struct request *
@@ -1763,6 +1642,7 @@ as_merged_requests(request_queue_t *q, s
 	 * kill knowledge of next, this one is a goner
 	 */
 	as_remove_queued_request(q, next);
+	as_put_io_context(anext);
 
 	anext->state = AS_RQ_MERGED;
 }
@@ -1782,7 +1662,7 @@ static void as_work_handler(void *data)
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	if (as_next_request(q))
+	if (!as_queue_empty(q))
 		q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
@@ -1797,7 +1677,9 @@ static void as_put_request(request_queue
 		return;
 	}
 
-	if (arq->state != AS_RQ_POSTSCHED && arq->state != AS_RQ_PRESCHED) {
+	if (unlikely(arq->state != AS_RQ_POSTSCHED &&
+		     arq->state != AS_RQ_PRESCHED &&
+		     arq->state != AS_RQ_MERGED)) {
 		printk("arq->state %d\n", arq->state);
 		WARN_ON(1);
 	}
@@ -1907,7 +1789,6 @@ static int as_init_queue(request_queue_t
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_ASYNC]);
 	ad->sort_list[REQ_SYNC] = RB_ROOT;
 	ad->sort_list[REQ_ASYNC] = RB_ROOT;
-	ad->dispatch = &q->queue_head;
 	ad->fifo_expire[REQ_SYNC] = default_read_expire;
 	ad->fifo_expire[REQ_ASYNC] = default_write_expire;
 	ad->antic_expire = default_antic_expire;
@@ -2072,10 +1953,9 @@ static struct elevator_type iosched_as =
 		.elevator_merge_fn = 		as_merge,
 		.elevator_merged_fn =		as_merged_request,
 		.elevator_merge_req_fn =	as_merged_requests,
-		.elevator_next_req_fn =		as_next_request,
-		.elevator_add_req_fn =		as_insert_request,
-		.elevator_remove_req_fn =	as_remove_request,
-		.elevator_requeue_req_fn = 	as_requeue_request,
+		.elevator_dispatch_fn =		as_dispatch_request,
+		.elevator_add_req_fn =		as_add_request,
+		.elevator_activate_req_fn =	as_activate_request,
 		.elevator_deactivate_req_fn = 	as_deactivate_request,
 		.elevator_queue_empty_fn =	as_queue_empty,
 		.elevator_completed_req_fn =	as_completed_request,
Index: blk-fixes/drivers/block/deadline-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/deadline-iosched.c	2005-10-19 21:26:16.000000000 +0900
+++ blk-fixes/drivers/block/deadline-iosched.c	2005-10-19 21:34:02.000000000 +0900
@@ -50,7 +50,6 @@ struct deadline_data {
 	 * next in sort order. read, write or both are NULL
 	 */
 	struct deadline_rq *next_drq[2];
-	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
 	unsigned int batching;		/* number of sequential requests made */
 	sector_t last_sector;		/* head position */
@@ -239,10 +238,9 @@ deadline_del_drq_rb(struct deadline_data
 			dd->next_drq[data_dir] = rb_entry_drq(rbnext);
 	}
 
-	if (ON_RB(&drq->rb_node)) {
-		rb_erase(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
-		RB_CLEAR(&drq->rb_node);
-	}
+	BUG_ON(!ON_RB(&drq->rb_node));
+	rb_erase(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
+	RB_CLEAR(&drq->rb_node);
 }
 
 static struct request *
@@ -286,7 +284,7 @@ deadline_find_first_drq(struct deadline_
 /*
  * add drq to rbtree and fifo
  */
-static inline void
+static void
 deadline_add_request(struct request_queue *q, struct request *rq)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
@@ -315,14 +313,11 @@ deadline_add_request(struct request_queu
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
 {
 	struct deadline_rq *drq = RQ_DATA(rq);
+	struct deadline_data *dd = q->elevator->elevator_data;
 
-	if (drq) {
-		struct deadline_data *dd = q->elevator->elevator_data;
-
-		list_del_init(&drq->fifo);
-		deadline_remove_merge_hints(q, drq);
-		deadline_del_drq_rb(dd, drq);
-	}
+	list_del_init(&drq->fifo);
+	deadline_remove_merge_hints(q, drq);
+	deadline_del_drq_rb(dd, drq);
 }
 
 static int
@@ -452,7 +447,7 @@ deadline_move_to_dispatch(struct deadlin
 	request_queue_t *q = drq->request->q;
 
 	deadline_remove_request(q, drq->request);
-	list_add_tail(&drq->request->queuelist, dd->dispatch);
+	elv_dispatch_insert(q, drq->request, 0);
 }
 
 /*
@@ -502,8 +497,9 @@ static inline int deadline_check_fifo(st
  * deadline_dispatch_requests selects the best request according to
  * read/write expire, fifo_batch, etc
  */
-static int deadline_dispatch_requests(struct deadline_data *dd)
+static int deadline_dispatch_requests(request_queue_t *q, int force)
 {
+	struct deadline_data *dd = q->elevator->elevator_data;
 	const int reads = !list_empty(&dd->fifo_list[READ]);
 	const int writes = !list_empty(&dd->fifo_list[WRITE]);
 	struct deadline_rq *drq;
@@ -597,65 +593,12 @@ dispatch_request:
 	return 1;
 }
 
-static struct request *deadline_next_request(request_queue_t *q)
-{
-	struct deadline_data *dd = q->elevator->elevator_data;
-	struct request *rq;
-
-	/*
-	 * if there are still requests on the dispatch queue, grab the first one
-	 */
-	if (!list_empty(dd->dispatch)) {
-dispatch:
-		rq = list_entry_rq(dd->dispatch->next);
-		return rq;
-	}
-
-	if (deadline_dispatch_requests(dd))
-		goto dispatch;
-
-	return NULL;
-}
-
-static void
-deadline_insert_request(request_queue_t *q, struct request *rq, int where)
-{
-	struct deadline_data *dd = q->elevator->elevator_data;
-
-	/* barriers must flush the reorder queue */
-	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
-			&& where == ELEVATOR_INSERT_SORT))
-		where = ELEVATOR_INSERT_BACK;
-
-	switch (where) {
-		case ELEVATOR_INSERT_BACK:
-			while (deadline_dispatch_requests(dd))
-				;
-			list_add_tail(&rq->queuelist, dd->dispatch);
-			break;
-		case ELEVATOR_INSERT_FRONT:
-			list_add(&rq->queuelist, dd->dispatch);
-			break;
-		case ELEVATOR_INSERT_SORT:
-			BUG_ON(!blk_fs_request(rq));
-			deadline_add_request(q, rq);
-			break;
-		default:
-			printk("%s: bad insert point %d\n", __FUNCTION__,where);
-			return;
-	}
-}
-
 static int deadline_queue_empty(request_queue_t *q)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 
-	if (!list_empty(&dd->fifo_list[WRITE])
-	    || !list_empty(&dd->fifo_list[READ])
-	    || !list_empty(dd->dispatch))
-		return 0;
-
-	return 1;
+	return list_empty(&dd->fifo_list[WRITE])
+		&& list_empty(&dd->fifo_list[READ]);
 }
 
 static struct request *
@@ -733,7 +676,6 @@ static int deadline_init_queue(request_q
 	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
 	dd->sort_list[READ] = RB_ROOT;
 	dd->sort_list[WRITE] = RB_ROOT;
-	dd->dispatch = &q->queue_head;
 	dd->fifo_expire[READ] = read_expire;
 	dd->fifo_expire[WRITE] = write_expire;
 	dd->writes_starved = writes_starved;
@@ -748,10 +690,8 @@ static void deadline_put_request(request
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
-	if (drq) {
-		mempool_free(drq, dd->drq_pool);
-		rq->elevator_private = NULL;
-	}
+	mempool_free(drq, dd->drq_pool);
+	rq->elevator_private = NULL;
 }
 
 static int
@@ -917,9 +857,8 @@ static struct elevator_type iosched_dead
 		.elevator_merge_fn = 		deadline_merge,
 		.elevator_merged_fn =		deadline_merged_request,
 		.elevator_merge_req_fn =	deadline_merged_requests,
-		.elevator_next_req_fn =		deadline_next_request,
-		.elevator_add_req_fn =		deadline_insert_request,
-		.elevator_remove_req_fn =	deadline_remove_request,
+		.elevator_dispatch_fn =		deadline_dispatch_requests,
+		.elevator_add_req_fn =		deadline_add_request,
 		.elevator_queue_empty_fn =	deadline_queue_empty,
 		.elevator_former_req_fn =	deadline_former_request,
 		.elevator_latter_req_fn =	deadline_latter_request,
Index: blk-fixes/drivers/block/noop-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/noop-iosched.c	2005-10-19 21:26:16.000000000 +0900
+++ blk-fixes/drivers/block/noop-iosched.c	2005-10-19 21:34:02.000000000 +0900
@@ -28,13 +28,9 @@ static void elevator_noop_merge_requests
 	list_del_init(&next->queuelist);
 }
 
-static void elevator_noop_add_request(request_queue_t *q, struct request *rq,
-				      int where)
+static void elevator_noop_add_request(request_queue_t *q, struct request *rq)
 {
-	if (where == ELEVATOR_INSERT_FRONT)
-		list_add(&rq->queuelist, &q->queue_head);
-	else
-		list_add_tail(&rq->queuelist, &q->queue_head);
+	elv_dispatch_insert(q, rq, 0);
 
 	/*
 	 * new merges must not precede this barrier
@@ -45,19 +41,16 @@ static void elevator_noop_add_request(re
 		q->last_merge = rq;
 }
 
-static struct request *elevator_noop_next_request(request_queue_t *q)
+static int elevator_noop_dispatch(request_queue_t *q, int force)
 {
-	if (!list_empty(&q->queue_head))
-		return list_entry_rq(q->queue_head.next);
-
-	return NULL;
+	return 0;
 }
 
 static struct elevator_type elevator_noop = {
 	.ops = {
 		.elevator_merge_fn		= elevator_noop_merge,
 		.elevator_merge_req_fn		= elevator_noop_merge_requests,
-		.elevator_next_req_fn		= elevator_noop_next_request,
+		.elevator_dispatch_fn		= elevator_noop_dispatch,
 		.elevator_add_req_fn		= elevator_noop_add_request,
 	},
 	.elevator_name = "noop",
Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-10-19 21:26:16.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-10-19 21:34:02.000000000 +0900
@@ -84,7 +84,6 @@ static int cfq_max_depth = 2;
 	(node)->rb_left = NULL;		\
 } while (0)
 #define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
-#define ON_RB(node)		((node)->rb_color != RB_NONE)
 #define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
 #define rq_rb_key(rq)		(rq)->sector
 
@@ -271,10 +270,7 @@ CFQ_CFQQ_FNS(expired);
 #undef CFQ_CFQQ_FNS
 
 enum cfq_rq_state_flags {
-	CFQ_CRQ_FLAG_in_flight = 0,
-	CFQ_CRQ_FLAG_in_driver,
-	CFQ_CRQ_FLAG_is_sync,
-	CFQ_CRQ_FLAG_requeued,
+	CFQ_CRQ_FLAG_is_sync = 0,
 };
 
 #define CFQ_CRQ_FNS(name)						\
@@ -291,14 +287,11 @@ static inline int cfq_crq_##name(const s
 	return (crq->crq_flags & (1 << CFQ_CRQ_FLAG_##name)) != 0;	\
 }
 
-CFQ_CRQ_FNS(in_flight);
-CFQ_CRQ_FNS(in_driver);
 CFQ_CRQ_FNS(is_sync);
-CFQ_CRQ_FNS(requeued);
 #undef CFQ_CRQ_FNS
 
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned int, unsigned short);
-static void cfq_dispatch_sort(request_queue_t *, struct cfq_rq *);
+static void cfq_dispatch_insert(request_queue_t *, struct cfq_rq *, int);
 static void cfq_put_cfqd(struct cfq_data *cfqd);
 
 #define process_sync(tsk)	((tsk)->flags & PF_SYNCWRITE)
@@ -347,18 +340,13 @@ static struct request *cfq_find_rq_hash(
 	return NULL;
 }
 
-static inline int cfq_pending_requests(struct cfq_data *cfqd)
-{
-	return !list_empty(&cfqd->queue->queue_head) || cfqd->busy_queues;
-}
-
 /*
  * scheduler run of queue, if there are requests pending and no one in the
  * driver that will restart queueing
  */
 static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
 {
-	if (!cfqd->rq_in_driver && cfq_pending_requests(cfqd))
+	if (!cfqd->rq_in_driver && cfqd->busy_queues)
 		kblockd_schedule_work(&cfqd->unplug_work);
 }
 
@@ -366,7 +354,7 @@ static int cfq_queue_empty(request_queue
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 
-	return !cfq_pending_requests(cfqd);
+	return !cfqd->busy_queues;
 }
 
 /*
@@ -386,11 +374,6 @@ cfq_choose_req(struct cfq_data *cfqd, st
 	if (crq2 == NULL)
 		return crq1;
 
-	if (cfq_crq_requeued(crq1) && !cfq_crq_requeued(crq2))
-		return crq1;
-	else if (cfq_crq_requeued(crq2) && !cfq_crq_requeued(crq1))
-		return crq2;
-
 	if (cfq_crq_is_sync(crq1) && !cfq_crq_is_sync(crq2))
 		return crq1;
 	else if (cfq_crq_is_sync(crq2) && !cfq_crq_is_sync(crq1))
@@ -461,10 +444,7 @@ cfq_find_next_crq(struct cfq_data *cfqd,
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
@@ -545,13 +525,13 @@ static void cfq_resort_rr_list(struct cf
  * the pending list according to last request service
  */
 static inline void
-cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq, int requeue)
+cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
 	BUG_ON(cfq_cfqq_on_rr(cfqq));
 	cfq_mark_cfqq_on_rr(cfqq);
 	cfqd->busy_queues++;
 
-	cfq_resort_rr_list(cfqq, requeue);
+	cfq_resort_rr_list(cfqq, 0);
 }
 
 static inline void
@@ -571,22 +551,19 @@ cfq_del_cfqq_rr(struct cfq_data *cfqd, s
 static inline void cfq_del_crq_rb(struct cfq_rq *crq)
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_data *cfqd = cfqq->cfqd;
+	const int sync = cfq_crq_is_sync(crq);
 
-	if (ON_RB(&crq->rb_node)) {
-		struct cfq_data *cfqd = cfqq->cfqd;
-		const int sync = cfq_crq_is_sync(crq);
-
-		BUG_ON(!cfqq->queued[sync]);
-		cfqq->queued[sync]--;
+	BUG_ON(!cfqq->queued[sync]);
+	cfqq->queued[sync]--;
 
-		cfq_update_next_crq(crq);
+	cfq_update_next_crq(crq);
 
-		rb_erase(&crq->rb_node, &cfqq->sort_list);
-		RB_CLEAR_COLOR(&crq->rb_node);
+	rb_erase(&crq->rb_node, &cfqq->sort_list);
+	RB_CLEAR_COLOR(&crq->rb_node);
 
-		if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY(&cfqq->sort_list))
-			cfq_del_cfqq_rr(cfqd, cfqq);
-	}
+	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY(&cfqq->sort_list))
+		cfq_del_cfqq_rr(cfqd, cfqq);
 }
 
 static struct cfq_rq *
@@ -627,12 +604,12 @@ static void cfq_add_crq_rb(struct cfq_rq
 	 * if that happens, put the alias on the dispatch list
 	 */
 	while ((__alias = __cfq_add_crq_rb(crq)) != NULL)
-		cfq_dispatch_sort(cfqd->queue, __alias);
+		cfq_dispatch_insert(cfqd->queue, __alias, 1);
 
 	rb_insert_color(&crq->rb_node, &cfqq->sort_list);
 
 	if (!cfq_cfqq_on_rr(cfqq))
-		cfq_add_cfqq_rr(cfqd, cfqq, cfq_crq_requeued(crq));
+		cfq_add_cfqq_rr(cfqd, cfqq);
 
 	/*
 	 * check if this request is a better next-serve candidate
@@ -643,10 +620,8 @@ static void cfq_add_crq_rb(struct cfq_rq
 static inline void
 cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	if (ON_RB(&crq->rb_node)) {
-		rb_erase(&crq->rb_node, &cfqq->sort_list);
-		cfqq->queued[cfq_crq_is_sync(crq)]--;
-	}
+	rb_erase(&crq->rb_node, &cfqq->sort_list);
+	cfqq->queued[cfq_crq_is_sync(crq)]--;
 
 	cfq_add_crq_rb(crq);
 }
@@ -676,49 +651,28 @@ out:
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
 
-		if (cfq_crq_in_driver(crq)) {
-			cfq_clear_crq_in_driver(crq);
-			WARN_ON(!cfqd->rq_in_driver);
-			cfqd->rq_in_driver--;
-		}
-		if (cfq_crq_in_flight(crq)) {
-			const int sync = cfq_crq_is_sync(crq);
-
-			cfq_clear_crq_in_flight(crq);
-			WARN_ON(!cfqq->on_dispatch[sync]);
-			cfqq->on_dispatch[sync]--;
-		}
-		cfq_mark_crq_requeued(crq);
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
+	cfq_remove_merge_hints(rq->q, crq);
 }
 
 static int
@@ -762,7 +716,7 @@ static void cfq_merged_request(request_q
 	cfq_del_crq_hash(crq);
 	cfq_add_crq_hash(cfqd, crq);
 
-	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
+	if (rq_rb_key(req) != crq->rb_key) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
 		cfq_update_next_crq(crq);
@@ -785,7 +739,7 @@ cfq_merged_requests(request_queue_t *q, 
 	    time_before(next->start_time, rq->start_time))
 		list_move(&rq->queuelist, &next->queuelist);
 
-	cfq_remove_request(q, next);
+	cfq_remove_request(next);
 }
 
 static inline void
@@ -992,53 +946,16 @@ static int cfq_arm_slice_timer(struct cf
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
-		if (cfq_crq_requeued(__crq))
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
-	cfq_mark_crq_in_flight(crq);
-	cfq_clear_crq_requeued(crq);
-
+	cfq_remove_request(crq->request);
 	cfqq->on_dispatch[cfq_crq_is_sync(crq)]++;
-	list_add_tail(&crq->request->queuelist, entry);
+	elv_dispatch_insert(q, crq->request, force);
 }
 
 /*
@@ -1141,7 +1058,7 @@ keep_queue:
 
 static int
 __cfq_dispatch_requests(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-			int max_dispatch)
+			int max_dispatch, int force)
 {
 	int dispatched = 0;
 
@@ -1159,7 +1076,7 @@ __cfq_dispatch_requests(struct cfq_data 
 		/*
 		 * finally, insert request into driver dispatch list
 		 */
-		cfq_dispatch_sort(cfqd->queue, crq);
+		cfq_dispatch_insert(cfqd->queue, crq, force);
 
 		cfqd->dispatch_slice++;
 		dispatched++;
@@ -1194,7 +1111,7 @@ __cfq_dispatch_requests(struct cfq_data 
 }
 
 static int
-cfq_dispatch_requests(request_queue_t *q, int max_dispatch, int force)
+cfq_dispatch_requests(request_queue_t *q, int force)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
@@ -1204,106 +1121,31 @@ cfq_dispatch_requests(request_queue_t *q
 
 	cfqq = cfq_select_queue(cfqd, force);
 	if (cfqq) {
+		int max_dispatch;
+
+		/*
+		 * if idle window is disabled, allow queue buildup
+		 */
+		if (!cfq_cfqq_idle_window(cfqq) &&
+		    cfqd->rq_in_driver >= cfqd->cfq_max_depth)
+			return 0;
+
 		cfq_clear_cfqq_must_dispatch(cfqq);
 		cfq_clear_cfqq_wait_request(cfqq);
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
-	if (cfq_crq_in_driver(crq))
-		return;
-
-	cfq_mark_crq_in_driver(crq);
-	cfqd->rq_in_driver++;
-}
-
-static inline void
-cfq_account_completion(struct cfq_queue *cfqq, struct cfq_rq *crq)
-{
-	struct cfq_data *cfqd = cfqq->cfqd;
-	unsigned long now;
-
-	if (!cfq_crq_in_driver(crq))
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
-	if (!cfq_cfqq_dispatched(cfqq)) {
-		if (cfq_cfqq_on_rr(cfqq)) {
-			cfqq->service_last = now;
-			cfq_resort_rr_list(cfqq, 0);
-		}
-		if (cfq_cfqq_expired(cfqq)) {
-			__cfq_slice_expired(cfqd, cfqq, 0);
-			cfq_schedule_dispatch(cfqd);
-		}
-	}
-
-	if (cfq_crq_is_sync(crq))
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
-			struct cfq_queue *cfqq = crq->cfq_queue;
-
-			/*
-			 * if idle window is disabled, allow queue buildup
-			 */
-			if (!cfq_crq_in_driver(crq) &&
-			    !cfq_cfqq_idle_window(cfqq) &&
-			    !blk_barrier_rq(rq) &&
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
@@ -1816,8 +1658,9 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 	}
 }
 
-static void cfq_enqueue(struct cfq_data *cfqd, struct request *rq)
+static void cfq_insert_request(request_queue_t *q, struct request *rq)
 {
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 	struct cfq_queue *cfqq = crq->cfq_queue;
 
@@ -1837,56 +1680,37 @@ static void cfq_enqueue(struct cfq_data 
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
-			cfq_schedule_dispatch(cfqd);
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
 static void cfq_completed_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
-	struct cfq_queue *cfqq;
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_data *cfqd = cfqq->cfqd;
+	const int sync = cfq_crq_is_sync(crq);
+	unsigned long now;
 
-	if (unlikely(!blk_fs_request(rq)))
-		return;
+	now = jiffies;
 
-	cfqq = crq->cfq_queue;
+	WARN_ON(!cfqd->rq_in_driver);
+	WARN_ON(!cfqq->on_dispatch[sync]);
+	cfqd->rq_in_driver--;
+	cfqq->on_dispatch[sync]--;
 
-	if (cfq_crq_in_flight(crq)) {
-		const int sync = cfq_crq_is_sync(crq);
+	if (!cfq_class_idle(cfqq))
+		cfqd->last_end_request = now;
 
-		WARN_ON(!cfqq->on_dispatch[sync]);
-		cfqq->on_dispatch[sync]--;
+	if (!cfq_cfqq_dispatched(cfqq)) {
+		if (cfq_cfqq_on_rr(cfqq)) {
+			cfqq->service_last = now;
+			cfq_resort_rr_list(cfqq, 0);
+		}
+		if (cfq_cfqq_expired(cfqq)) {
+			__cfq_slice_expired(cfqd, cfqq, 0);
+			cfq_schedule_dispatch(cfqd);
+		}
 	}
 
-	cfq_account_completion(cfqq, crq);
+	if (cfq_crq_is_sync(crq))
+		crq->io_context->last_end_request = now;
 }
 
 static struct request *
@@ -2118,9 +1942,6 @@ cfq_set_request(request_queue_t *q, stru
 		INIT_HLIST_NODE(&crq->hash);
 		crq->cfq_queue = cfqq;
 		crq->io_context = cic;
-		cfq_clear_crq_in_flight(crq);
-		cfq_clear_crq_in_driver(crq);
-		cfq_clear_crq_requeued(crq);
 
 		if (rw == READ || process_sync(tsk))
 			cfq_mark_crq_is_sync(crq);
@@ -2201,7 +2022,7 @@ static void cfq_idle_slice_timer(unsigne
 		 * only expire and reinvoke request handler, if there are
 		 * other queues with pending requests
 		 */
-		if (!cfq_pending_requests(cfqd)) {
+		if (!cfqd->busy_queues) {
 			cfqd->idle_slice_timer.expires = min(now + cfqd->cfq_slice_idle, cfqq->slice_end);
 			add_timer(&cfqd->idle_slice_timer);
 			goto out_cont;
@@ -2576,10 +2397,9 @@ static struct elevator_type iosched_cfq 
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

