Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVGZN7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVGZN7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVGZN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:57:42 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:60824 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261797AbVGZN4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:56:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=rL383agUHH4C9Hwtkbri0ez7sVermzQhMeAzyR7Tw0RD3fYi7Hg0itSxExaXERMv4SkJyYTC1gFPjeDO2BEh/+ymTPRkPlpxyaScmq3P9NL1LaQ+wF2zNHV/LKr3chIc/pR32s99PTmLxvBoa6CITBar2coQQE420JeLBNX9Kus=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726135502.D83FC6EE@htj.dyndns.org>
In-Reply-To: <20050726135502.D83FC6EE@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 04/05] blk: remove last_merge handling from ioscheds
Message-ID: <20050726135502.31FBDBE4@htj.dyndns.org>
Date: Tue, 26 Jul 2005 22:56:37 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_blk_generic-last_merge-handling-update-for-ioscheds.patch

	Remove last_merge handling from all ioscheds.  This patch
	removes merging capability of noop iosched.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 as-iosched.c       |   35 ++++-------------------------------
 cfq-iosched.c      |   19 +------------------
 deadline-iosched.c |   30 ++----------------------------
 noop-iosched.c     |   31 -------------------------------
 4 files changed, 7 insertions(+), 108 deletions(-)

Index: blk-fixes/drivers/block/as-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/as-iosched.c	2005-07-26 22:55:00.000000000 +0900
+++ blk-fixes/drivers/block/as-iosched.c	2005-07-26 22:55:01.000000000 +0900
@@ -279,14 +279,6 @@ static inline void as_del_arq_hash(struc
 		__as_del_arq_hash(arq);
 }
 
-static void as_remove_merge_hints(request_queue_t *q, struct as_rq *arq)
-{
-	as_del_arq_hash(arq);
-
-	if (q->last_merge == arq->request)
-		q->last_merge = NULL;
-}
-
 static void as_add_arq_hash(struct as_data *ad, struct as_rq *arq)
 {
 	struct request *rq = arq->request;
@@ -330,7 +322,7 @@ static struct request *as_find_arq_hash(
 		BUG_ON(!arq->on_hash);
 
 		if (!rq_mergeable(__rq)) {
-			as_remove_merge_hints(ad->q, arq);
+			as_del_arq_hash(arq);
 			continue;
 		}
 
@@ -1040,7 +1032,7 @@ static void as_remove_queued_request(req
 		ad->next_arq[data_dir] = as_find_next_arq(ad, arq);
 
 	list_del_init(&arq->fifo);
-	as_remove_merge_hints(q, arq);
+	as_del_arq_hash(arq);
 	as_del_arq_rb(ad, arq);
 }
 
@@ -1351,7 +1343,7 @@ as_add_aliased_request(struct as_data *a
 	/*
 	 * Don't want to have to handle merges.
 	 */
-	as_remove_merge_hints(ad->q, arq);
+	as_del_arq_hash(arq);
 }
 
 /*
@@ -1392,12 +1384,8 @@ static void as_add_request(request_queue
 		arq->expires = jiffies + ad->fifo_expire[data_dir];
 		list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
 
-		if (rq_mergeable(arq->request)) {
+		if (rq_mergeable(arq->request))
 			as_add_arq_hash(ad, arq);
-
-			if (!ad->q->last_merge)
-				ad->q->last_merge = arq->request;
-		}
 		as_update_arq(ad, arq); /* keep state machine up to date */
 
 	} else {
@@ -1487,15 +1475,6 @@ as_merge(request_queue_t *q, struct requ
 	int ret;
 
 	/*
-	 * try last_merge to avoid going to hash
-	 */
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = q->last_merge;
-		goto out_insert;
-	}
-
-	/*
 	 * see if the merge hash can satisfy a back merge
 	 */
 	__rq = as_find_arq_hash(ad, bio->bi_sector);
@@ -1523,9 +1502,6 @@ as_merge(request_queue_t *q, struct requ
 
 	return ELEVATOR_NO_MERGE;
 out:
-	if (rq_mergeable(__rq))
-		q->last_merge = __rq;
-out_insert:
 	if (ret) {
 		if (rq_mergeable(__rq))
 			as_hot_arq_hash(ad, RQ_DATA(__rq));
@@ -1572,9 +1548,6 @@ static void as_merged_request(request_qu
 		 * behind the disk head. We currently don't bother adjusting.
 		 */
 	}
-
-	if (arq->on_hash)
-		q->last_merge = req;
 }
 
 static void
Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-07-26 22:55:00.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-07-26 22:55:01.000000000 +0900
@@ -648,8 +648,6 @@ static void cfq_remove_request(struct re
 	list_del_init(&rq->queuelist);
 	cfq_del_crq_rb(crq);
 	cfq_del_crq_hash(crq);
-	if (rq->q->last_merge == crq->request)
-		rq->q->last_merge = NULL;
 }
 
 static int
@@ -659,12 +657,6 @@ cfq_merge(request_queue_t *q, struct req
 	struct request *__rq;
 	int ret;
 
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = q->last_merge;
-		goto out_insert;
-	}
-
 	__rq = cfq_find_rq_hash(cfqd, bio->bi_sector);
 	if (__rq) {
 		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
@@ -685,8 +677,6 @@ cfq_merge(request_queue_t *q, struct req
 
 	return ELEVATOR_NO_MERGE;
 out:
-	q->last_merge = __rq;
-out_insert:
 	*req = __rq;
 	return ret;
 }
@@ -705,8 +695,6 @@ static void cfq_merged_request(request_q
 		cfq_update_next_crq(crq);
 		cfq_reposition_crq_rb(cfqq, crq);
 	}
-
-	q->last_merge = req;
 }
 
 static void
@@ -1127,12 +1115,8 @@ cfq_insert_request(request_queue_t *q, s
 
 	list_add_tail(&crq->request->queuelist, &crq->cfq_queue->fifo[crq->is_sync]);
 
-	if (rq_mergeable(rq)) {
+	if (rq_mergeable(rq))
 		cfq_add_crq_hash(cfqd, crq);
-
-		if (!q->last_merge)
-			q->last_merge = rq;
-	}
 }
 
 static int cfq_queue_empty(request_queue_t *q)
@@ -1251,7 +1235,6 @@ static void cfq_put_request(request_queu
 	struct cfq_rq *crq = RQ_DATA(rq);
 	struct cfq_queue *cfqq = crq->cfq_queue;
 
-	BUG_ON(q->last_merge == rq);
 	BUG_ON(!hlist_unhashed(&crq->hash));
 
 	if (crq->io_context)
Index: blk-fixes/drivers/block/deadline-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/deadline-iosched.c	2005-07-26 22:55:00.000000000 +0900
+++ blk-fixes/drivers/block/deadline-iosched.c	2005-07-26 22:55:01.000000000 +0900
@@ -112,15 +112,6 @@ static inline void deadline_del_drq_hash
 		__deadline_del_drq_hash(drq);
 }
 
-static void
-deadline_remove_merge_hints(request_queue_t *q, struct deadline_rq *drq)
-{
-	deadline_del_drq_hash(drq);
-
-	if (q->last_merge == drq->request)
-		q->last_merge = NULL;
-}
-
 static inline void
 deadline_add_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
 {
@@ -299,12 +290,8 @@ deadline_add_request(struct request_queu
 	drq->expires = jiffies + dd->fifo_expire[data_dir];
 	list_add_tail(&drq->fifo, &dd->fifo_list[data_dir]);
 
-	if (rq_mergeable(rq)) {
+	if (rq_mergeable(rq))
 		deadline_add_drq_hash(dd, drq);
-
-		if (!q->last_merge)
-			q->last_merge = rq;
-	}
 }
 
 /*
@@ -316,8 +303,8 @@ static void deadline_remove_request(requ
 	struct deadline_data *dd = q->elevator->elevator_data;
 
 	list_del_init(&drq->fifo);
-	deadline_remove_merge_hints(q, drq);
 	deadline_del_drq_rb(dd, drq);
+	deadline_del_drq_hash(drq);
 }
 
 static int
@@ -328,15 +315,6 @@ deadline_merge(request_queue_t *q, struc
 	int ret;
 
 	/*
-	 * try last_merge to avoid going to hash
-	 */
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = q->last_merge;
-		goto out_insert;
-	}
-
-	/*
 	 * see if the merge hash can satisfy a back merge
 	 */
 	__rq = deadline_find_drq_hash(dd, bio->bi_sector);
@@ -368,8 +346,6 @@ deadline_merge(request_queue_t *q, struc
 
 	return ELEVATOR_NO_MERGE;
 out:
-	q->last_merge = __rq;
-out_insert:
 	if (ret)
 		deadline_hot_drq_hash(dd, RQ_DATA(__rq));
 	*req = __rq;
@@ -394,8 +370,6 @@ static void deadline_merged_request(requ
 		deadline_del_drq_rb(dd, drq);
 		deadline_add_drq_rb(dd, drq);
 	}
-
-	q->last_merge = req;
 }
 
 static void
Index: blk-fixes/drivers/block/noop-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/noop-iosched.c	2005-07-26 22:55:00.000000000 +0900
+++ blk-fixes/drivers/block/noop-iosched.c	2005-07-26 22:55:01.000000000 +0900
@@ -7,38 +7,9 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-/*
- * See if we can find a request that this buffer can be coalesced with.
- */
-static int elevator_noop_merge(request_queue_t *q, struct request **req,
-			       struct bio *bio)
-{
-	int ret;
-
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE)
-		*req = q->last_merge;
-
-	return ret;
-}
-
-static void elevator_noop_merge_requests(request_queue_t *q, struct request *req,
-					 struct request *next)
-{
-	list_del_init(&next->queuelist);
-}
-
 static void elevator_noop_add_request(request_queue_t *q, struct request *rq)
 {
 	elv_dispatch_insert(q, rq, 0);
-
-	/*
-	 * new merges must not precede this barrier
-	 */
-	if (rq->flags & REQ_HARDBARRIER)
-		q->last_merge = NULL;
-	else if (!q->last_merge)
-		q->last_merge = rq;
 }
 
 static int elevator_noop_dispatch(request_queue_t *q, int force)
@@ -48,8 +19,6 @@ static int elevator_noop_dispatch(reques
 
 static struct elevator_type elevator_noop = {
 	.ops = {
-		.elevator_merge_fn		= elevator_noop_merge,
-		.elevator_merge_req_fn		= elevator_noop_merge_requests,
 		.elevator_dispatch_fn		= elevator_noop_dispatch,
 		.elevator_add_req_fn		= elevator_noop_add_request,
 	},

