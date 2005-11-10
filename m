Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVKJOJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVKJOJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKJOJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:09:10 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:59250 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750940AbVKJOJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:09:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=LUrrNvxv4+8ylmTaakVSdFY3do2jh+2pWj76lNj3LrNLmh89BuiN4YpkUzMqNZpZY5ifkfqX+de6o/oMkqPtGPf0ust1FB4Qm6shlEUcRxL16zw+OhI5exJKNq8pGpijhKiXljzYjw/C4GF6mtiddapFrfuVD1ct7nusygHI2yU=
Date: Thu, 10 Nov 2005 23:08:59 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] as-iosched: update alias handling
Message-ID: <20051110140859.GA26030@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other ioscheds, as-iosched handles alias by chaing them using
rq->queuelist.  As aliased requests are very rare in the first place,
this complicates merge/dispatch handling without meaningful
performance improvement.  This patch updates as-iosched to dump
aliased requests into dispatch queue as other ioscheds do.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jens, I've tested this change for several hours, but it might be
better to postpone this change to next release.  It's your call.

diff --git a/block/as-iosched.c b/block/as-iosched.c
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -184,6 +184,9 @@ struct as_rq {
 
 static kmem_cache_t *arq_pool;
 
+static void as_move_to_dispatch(struct as_data *ad, struct as_rq *arq);
+static void as_antic_stop(struct as_data *ad);
+
 /*
  * IO Context helper functions
  */
@@ -372,7 +375,7 @@ static struct as_rq *as_find_first_arq(s
  * existing request against the same sector), which can happen when using
  * direct IO, then return the alias.
  */
-static struct as_rq *as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
+static struct as_rq *__as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
 {
 	struct rb_node **p = &ARQ_RB_ROOT(ad, arq)->rb_node;
 	struct rb_node *parent = NULL;
@@ -399,6 +402,16 @@ static struct as_rq *as_add_arq_rb(struc
 	return NULL;
 }
 
+static void as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
+{
+	struct as_rq *alias;
+
+	while ((unlikely(alias = __as_add_arq_rb(ad, arq)))) {
+		as_move_to_dispatch(ad, alias);
+		as_antic_stop(ad);
+	}
+}
+
 static inline void as_del_arq_rb(struct as_data *ad, struct as_rq *arq)
 {
 	if (!ON_RB(&arq->rb_node)) {
@@ -1135,23 +1148,6 @@ static void as_move_to_dispatch(struct a
 	/*
 	 * take it off the sort and fifo list, add to dispatch queue
 	 */
-	while (!list_empty(&rq->queuelist)) {
-		struct request *__rq = list_entry_rq(rq->queuelist.next);
-		struct as_rq *__arq = RQ_DATA(__rq);
-
-		list_del(&__rq->queuelist);
-
-		elv_dispatch_add_tail(ad->q, __rq);
-
-		if (__arq->io_context && __arq->io_context->aic)
-			atomic_inc(&__arq->io_context->aic->nr_dispatched);
-
-		WARN_ON(__arq->state != AS_RQ_QUEUED);
-		__arq->state = AS_RQ_DISPATCHED;
-
-		ad->nr_dispatched++;
-	}
-
 	as_remove_queued_request(ad->q, rq);
 	WARN_ON(arq->state != AS_RQ_QUEUED);
 
@@ -1328,49 +1324,12 @@ fifo_expired:
 }
 
 /*
- * Add arq to a list behind alias
- */
-static inline void
-as_add_aliased_request(struct as_data *ad, struct as_rq *arq,
-				struct as_rq *alias)
-{
-	struct request  *req = arq->request;
-	struct list_head *insert = alias->request->queuelist.prev;
-
-	/*
-	 * Transfer list of aliases
-	 */
-	while (!list_empty(&req->queuelist)) {
-		struct request *__rq = list_entry_rq(req->queuelist.next);
-		struct as_rq *__arq = RQ_DATA(__rq);
-
-		list_move_tail(&__rq->queuelist, &alias->request->queuelist);
-
-		WARN_ON(__arq->state != AS_RQ_QUEUED);
-	}
-
-	/*
-	 * Another request with the same start sector on the rbtree.
-	 * Link this request to that sector. They are untangled in
-	 * as_move_to_dispatch
-	 */
-	list_add(&arq->request->queuelist, insert);
-
-	/*
-	 * Don't want to have to handle merges.
-	 */
-	as_del_arq_hash(arq);
-	arq->request->flags |= REQ_NOMERGE;
-}
-
-/*
  * add arq to rbtree and fifo
  */
 static void as_add_request(request_queue_t *q, struct request *rq)
 {
 	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
-	struct as_rq *alias;
 	int data_dir;
 
 	if (arq->state != AS_RQ_PRESCHED) {
@@ -1393,33 +1352,17 @@ static void as_add_request(request_queue
 		atomic_inc(&arq->io_context->aic->nr_queued);
 	}
 
-	alias = as_add_arq_rb(ad, arq);
-	if (!alias) {
-		/*
-		 * set expire time (only used for reads) and add to fifo list
-		 */
-		arq->expires = jiffies + ad->fifo_expire[data_dir];
-		list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
+	as_add_arq_rb(ad, arq);
+	if (rq_mergeable(arq->request))
+		as_add_arq_hash(ad, arq);
 
-		if (rq_mergeable(arq->request))
-			as_add_arq_hash(ad, arq);
-		as_update_arq(ad, arq); /* keep state machine up to date */
-
-	} else {
-		as_add_aliased_request(ad, arq, alias);
-
-		/*
-		 * have we been anticipating this request?
-		 * or does it come from the same process as the one we are
-		 * anticipating for?
-		 */
-		if (ad->antic_status == ANTIC_WAIT_REQ
-				|| ad->antic_status == ANTIC_WAIT_NEXT) {
-			if (as_can_break_anticipation(ad, arq))
-				as_antic_stop(ad);
-		}
-	}
+	/*
+	 * set expire time (only used for reads) and add to fifo list
+	 */
+	arq->expires = jiffies + ad->fifo_expire[data_dir];
+	list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
 
+	as_update_arq(ad, arq); /* keep state machine up to date */
 	arq->state = AS_RQ_QUEUED;
 }
 
@@ -1542,23 +1485,8 @@ static void as_merged_request(request_qu
 	 * if the merge was a front merge, we need to reposition request
 	 */
 	if (rq_rb_key(req) != arq->rb_key) {
-		struct as_rq *alias, *next_arq = NULL;
-
-		if (ad->next_arq[arq->is_sync] == arq)
-			next_arq = as_find_next_arq(ad, arq);
-
-		/*
-		 * Note! We should really be moving any old aliased requests
-		 * off this request and try to insert them into the rbtree. We
-		 * currently don't bother. Ditto the next function.
-		 */
 		as_del_arq_rb(ad, arq);
-		if ((alias = as_add_arq_rb(ad, arq))) {
-			list_del_init(&arq->fifo);
-			as_add_aliased_request(ad, arq, alias);
-			if (next_arq)
-				ad->next_arq[arq->is_sync] = next_arq;
-		}
+		as_add_arq_rb(ad, arq);
 		/*
 		 * Note! At this stage of this and the next function, our next
 		 * request may not be optimal - eg the request may have "grown"
@@ -1585,18 +1513,8 @@ static void as_merged_requests(request_q
 	as_add_arq_hash(ad, arq);
 
 	if (rq_rb_key(req) != arq->rb_key) {
-		struct as_rq *alias, *next_arq = NULL;
-
-		if (ad->next_arq[arq->is_sync] == arq)
-			next_arq = as_find_next_arq(ad, arq);
-
 		as_del_arq_rb(ad, arq);
-		if ((alias = as_add_arq_rb(ad, arq))) {
-			list_del_init(&arq->fifo);
-			as_add_aliased_request(ad, arq, alias);
-			if (next_arq)
-				ad->next_arq[arq->is_sync] = next_arq;
-		}
+		as_add_arq_rb(ad, arq);
 	}
 
 	/*
@@ -1616,18 +1534,6 @@ static void as_merged_requests(request_q
 	}
 
 	/*
-	 * Transfer list of aliases
-	 */
-	while (!list_empty(&next->queuelist)) {
-		struct request *__rq = list_entry_rq(next->queuelist.next);
-		struct as_rq *__arq = RQ_DATA(__rq);
-
-		list_move_tail(&__rq->queuelist, &req->queuelist);
-
-		WARN_ON(__arq->state != AS_RQ_QUEUED);
-	}
-
-	/*
 	 * kill knowledge of next, this one is a goner
 	 */
 	as_remove_queued_request(q, next);
