Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVFPFD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVFPFD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 01:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVFPFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 01:03:56 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:13080 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261744AbVFPE5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:57:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=amlG7JPy0XgQJ6b1sVEB/WzQ7SlHRXHqAj7UNMCoGS6ukPmYDftur5mDP4+ZuVNLJVXYYeV6rOFfDMUJG6ast0J5JOON41H6F0exBODyQafj/44ZRghEUFz5Xw3Ygm1f1B18VLYJWQwFVr4N359h5qa4QdY3yjdcQkQhmOA8fOw=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 04/06] blk: move last_merge handling into generic elevator code
Message-ID: <20050616045540.89FB0651@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:56:59 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_blk_last_merge_consolidation.patch

	Currently, both generic elevator code and specific ioscheds
	participate in the management and usage of last_merge.  This
	and the following patches move last_merge handling into
	generic elevator code.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/elevator.c |   43 ++++++++++++++++++-------------------------
 include/linux/elevator.h |    1 -
 2 files changed, 18 insertions(+), 26 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-06-16 13:55:38.000000000 +0900
@@ -108,15 +108,6 @@ inline int elv_try_merge(struct request 
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
@@ -259,6 +250,9 @@ void elv_dispatch_insert(request_queue_t
 	unsigned max_back;
 	struct list_head *entry;
 
+	if (q->last_merge == rq)
+		q->last_merge = NULL;
+
 	if (!sort) {
 		/* Specific elevator is performing sort.  Step away. */
 		q->last_sector = rq_last_sector(rq);
@@ -290,6 +284,15 @@ void elv_dispatch_insert(request_queue_t
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
@@ -303,6 +306,8 @@ void elv_merged_request(request_queue_t 
 
 	if (e->ops->elevator_merged_fn)
 		e->ops->elevator_merged_fn(q, rq);
+
+	q->last_merge = rq;
 }
 
 void elv_merge_requests(request_queue_t *q, struct request *rq,
@@ -310,11 +315,10 @@ void elv_merge_requests(request_queue_t 
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
@@ -407,6 +411,8 @@ void __elv_add_request(request_queue_t *
 		BUG_ON(!blk_fs_request(rq));
 		rq->flags |= REQ_SORTED;
 		q->elevator->ops->elevator_add_req_fn(q, rq);
+		if (q->last_merge == NULL && rq_mergeable(rq))
+			q->last_merge = rq;
 		break;
 
 	default:
@@ -463,9 +469,6 @@ struct request *elv_next_request(request
 		 */
 		rq->flags |= REQ_STARTED;
 
-		if (rq == q->last_merge)
-			q->last_merge = NULL;
-
 		if (!q->boundary_rq || q->boundary_rq == rq) {
 			q->last_sector = rq_last_sector(rq);
 			q->boundary_rq = NULL;
@@ -526,16 +529,6 @@ void elv_dequeue_request(request_queue_t
 		if (blk_sorted_rq(rq) && e->ops->elevator_activate_req_fn)
 			e->ops->elevator_activate_req_fn(q, rq);
 	}
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
Index: blk-fixes/include/linux/elevator.h
===================================================================
--- blk-fixes.orig/include/linux/elevator.h	2005-06-16 13:55:37.000000000 +0900
+++ blk-fixes/include/linux/elevator.h	2005-06-16 13:55:38.000000000 +0900
@@ -115,7 +115,6 @@ extern int elevator_init(request_queue_t
 extern void elevator_exit(elevator_t *);
 extern int elv_rq_merge_ok(struct request *, struct bio *);
 extern int elv_try_merge(struct request *, struct bio *);
-extern int elv_try_last_merge(request_queue_t *, struct bio *);
 
 /*
  * Return values from elevator merger

