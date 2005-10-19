Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVJSMfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVJSMfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVJSMfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:35:43 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbVJSMfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:35:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=TM+HGNqIlU/agnVMk0anuUlwPeitKSOtXPonZmfSnuj+CNttL9thOVDPHFRYatbye3YUWd5C6Qr7aLUz45/kB82KkjD++GHe3icBid9gKi585pD0hPo7vQ/iFyZP+nGkA/T8SzBmwgXwpKXUBSksxDuUraV0jfiLOtXFGcc+aRQ=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019123429.450E4424@htj.dyndns.org>
In-Reply-To: <20051019123429.450E4424@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 03/05] blk: move last_merge handling into generic elevator code
Message-ID: <20051019123429.2FBB370A@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:35:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_blk_generic-last_merge-handling.patch

	Currently, both generic elevator code and specific ioscheds
        participate in the management and usage of last_merge.  This
        and the following patches move last_merge handling into
        generic elevator code.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 elevator.c |   43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-10-19 21:34:02.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-10-19 21:34:02.000000000 +0900
@@ -88,15 +88,6 @@ inline int elv_try_merge(struct request 
 }
 EXPORT_SYMBOL(elv_try_merge);
 
-inline int elv_try_last_merge(request_queue_t *q, struct bio *bio)
-{
-	if (q->last_merge)
-		return elv_try_merge(q->last_merge, bio);
-
-	return ELEVATOR_NO_MERGE;
-}
-EXPORT_SYMBOL(elv_try_last_merge);
-
 static struct elevator_type *elevator_find(const char *name)
 {
 	struct elevator_type *e = NULL;
@@ -244,6 +235,9 @@ void elv_dispatch_insert(request_queue_t
 	unsigned max_back;
 	struct list_head *entry;
 
+	if (q->last_merge == rq)
+		q->last_merge = NULL;
+
 	if (!sort) {
 		/* Specific elevator is performing sort.  Step away. */
 		q->last_sector = rq_last_sector(rq);
@@ -278,6 +272,15 @@ void elv_dispatch_insert(request_queue_t
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	elevator_t *e = q->elevator;
+	int ret;
+
+	if (q->last_merge) {
+		ret = elv_try_merge(q->last_merge, bio);
+		if (ret != ELEVATOR_NO_MERGE) {
+			*req = q->last_merge;
+			return ret;
+		}
+	}
 
 	if (e->ops->elevator_merge_fn)
 		return e->ops->elevator_merge_fn(q, req, bio);
@@ -291,6 +294,8 @@ void elv_merged_request(request_queue_t 
 
 	if (e->ops->elevator_merged_fn)
 		e->ops->elevator_merged_fn(q, rq);
+
+	q->last_merge = rq;
 }
 
 void elv_merge_requests(request_queue_t *q, struct request *rq,
@@ -298,11 +303,10 @@ void elv_merge_requests(request_queue_t 
 {
 	elevator_t *e = q->elevator;
 
-	if (q->last_merge == next)
-		q->last_merge = NULL;
-
 	if (e->ops->elevator_merge_req_fn)
 		e->ops->elevator_merge_req_fn(q, rq, next);
+
+	q->last_merge = rq;
 }
 
 void elv_requeue_request(request_queue_t *q, struct request *rq)
@@ -397,6 +401,8 @@ void __elv_add_request(request_queue_t *
 		BUG_ON(!blk_fs_request(rq));
 		rq->flags |= REQ_SORTED;
 		q->elevator->ops->elevator_add_req_fn(q, rq);
+		if (q->last_merge == NULL && rq_mergeable(rq))
+			q->last_merge = rq;
 		break;
 
 	default:
@@ -475,9 +481,6 @@ struct request *elv_next_request(request
 			rq->flags |= REQ_STARTED;
 		}
 
-		if (rq == q->last_merge)
-			q->last_merge = NULL;
-
 		if (!q->boundary_rq || q->boundary_rq == rq) {
 			q->last_sector = rq_last_sector(rq);
 			q->boundary_rq = NULL;
@@ -531,16 +534,6 @@ void elv_dequeue_request(request_queue_t
 	 */
 	if (blk_account_rq(rq))
 		q->in_flight++;
-
-	/*
-	 * the main clearing point for q->last_merge is on retrieval of
-	 * request by driver (it calls elv_next_request()), but it _can_
-	 * also happen here if a request is added to the queue but later
-	 * deleted without ever being given to driver (merged with another
-	 * request).
-	 */
-	if (rq == q->last_merge)
-		q->last_merge = NULL;
 }
 
 int elv_queue_empty(request_queue_t *q)

