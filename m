Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVJSMfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVJSMfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVJSMfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:35:46 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750871AbVJSMfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=NCj35Fb0/Qwmm0znQg/sk0HxhmcIgzSIBfdhcrgwtBD77Vv/cR2YljxFJ0MfAdwwtzy3D9D3gzhxxu6jhmn9dfF0KLsc+S/fE48g2MP5lgS9O0+8zzqad+gnoShoZ4lHRp3HUyUzDncqd7ov0cXLPSqrHY0ibntduJH52IAwR1Q=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019123429.450E4424@htj.dyndns.org>
In-Reply-To: <20051019123429.450E4424@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 04/05] blk: remove last_merge handling from ioscheds
Message-ID: <20051019123429.3444D769@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:35:24 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_blk_generic-last_merge-handling-update-for-ioscheds.patch

	Remove last_merge handling from all ioscheds.  This patch
	removes merging capability of noop iosched.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 as-iosched.c       |   35 ++++-------------------------------
 cfq-iosched.c      |   26 ++------------------------
 deadline-iosched.c |   30 ++----------------------------
 noop-iosched.c     |   31 -------------------------------
 4 files changed, 8 insertions(+), 114 deletions(-)

Index: blk-fixes/drivers/block/as-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/as-iosched.c	2005-10-19 21:34:02.000000000 +0900
+++ blk-fixes/drivers/block/as-iosched.c	2005-10-19 21:34:02.000000000 +0900
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
Index: blk-fixes/drivers/block/deadline-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/deadline-iosched.c	2005-10-19 21:34:02.000000000 +0900
+++ blk-fixes/drivers/block/deadline-iosched.c	2005-10-19 21:34:02.000000000 +0900
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
--- blk-fixes.orig/drivers/block/noop-iosched.c	2005-10-19 21:34:02.000000000 +0900
+++ blk-fixes/drivers/block/noop-iosched.c	2005-10-19 21:34:02.000000000 +0900
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
Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-10-19 21:34:02.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-10-19 21:34:02.000000000 +0900
@@ -304,14 +304,6 @@ static inline void cfq_del_crq_hash(stru
 	hlist_del_init(&crq->hash);
 }
 
-static void cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
-{
-	cfq_del_crq_hash(crq);
-
-	if (q->last_merge == crq->request)
-		q->last_merge = NULL;
-}
-
 static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
 	const int hash_idx = CFQ_MHASH_FN(rq_hash_key(crq->request));
@@ -672,7 +664,7 @@ static void cfq_remove_request(struct re
 
 	list_del_init(&rq->queuelist);
 	cfq_del_crq_rb(crq);
-	cfq_remove_merge_hints(rq->q, crq);
+	cfq_del_crq_hash(crq);
 }
 
 static int
@@ -682,12 +674,6 @@ cfq_merge(request_queue_t *q, struct req
 	struct request *__rq;
 	int ret;
 
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = q->last_merge;
-		goto out_insert;
-	}
-
 	__rq = cfq_find_rq_hash(cfqd, bio->bi_sector);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		ret = ELEVATOR_BACK_MERGE;
@@ -702,8 +688,6 @@ cfq_merge(request_queue_t *q, struct req
 
 	return ELEVATOR_NO_MERGE;
 out:
-	q->last_merge = __rq;
-out_insert:
 	*req = __rq;
 	return ret;
 }
@@ -722,8 +706,6 @@ static void cfq_merged_request(request_q
 		cfq_update_next_crq(crq);
 		cfq_reposition_crq_rb(cfqq, crq);
 	}
-
-	q->last_merge = req;
 }
 
 static void
@@ -1670,13 +1652,9 @@ static void cfq_insert_request(request_q
 
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 
-	if (rq_mergeable(rq)) {
+	if (rq_mergeable(rq))
 		cfq_add_crq_hash(cfqd, crq);
 
-		if (!cfqd->queue->last_merge)
-			cfqd->queue->last_merge = rq;
-	}
-
 	cfq_crq_enqueued(cfqd, cfqq, crq);
 }
 

