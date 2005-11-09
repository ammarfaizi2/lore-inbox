Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030579AbVKIRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbVKIRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVKIRdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:33:08 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:3145 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030579AbVKIRdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:33:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BCa/mE8UW3avCo0sPogZuVws90d00ZxoPJseKtNRnjBoTR4MKm9IUK+WTLxCPSEK/86YKip58/EBQE5pkREar89RxrvnuLGX6b2Ps9C27+uHeXq34ru8tB3VpcV0RUsPLda2eTIlzF6pB3B5DoNOS9w9Z/zF5Qvi+8FKUSmLcTA=
Date: Thu, 10 Nov 2005 02:32:57 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] blk: implement elv_drain_elevator
Message-ID: <20051109173257.GD24115@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds request_queue->nr_sorted which keeps the number of
requests in the iosched and implement elv_drain_elevator which
performs forced dispatching.  elv_drain_elevator checks whether
iosched actually dispatches all requests it has and prints error
message if it doesn't.  As buggy forced dispatching can result in
wrong barrier operations, I think this extra check is worthwhile.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jens, this patch isn't strictly necessary if forced dispatching on all
ioscheds is implemented correctly.  However, added overhead is
insignificant and as detecting forced dispatching errors without this
mechanism is very difficult and may result in fs inconsistency in rare
cases, I think it's worthwhile.

With this and all three previous patches applied, I've been running
stress test which involves concurrent random accesses, localized
accesses for merges and periodic elevator switch for more than 36hrs
without any failure.

Thanks.

diff --git a/block/elevator.c b/block/elevator.c
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -225,6 +225,7 @@ void elv_dispatch_sort(request_queue_t *
 
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
+	q->nr_sorted--;
 
 	boundary = q->end_sector;
 
@@ -283,6 +284,7 @@ void elv_merge_requests(request_queue_t 
 
 	if (e->ops->elevator_merge_req_fn)
 		e->ops->elevator_merge_req_fn(q, rq, next);
+	q->nr_sorted--;
 
 	q->last_merge = rq;
 }
@@ -314,6 +316,20 @@ void elv_requeue_request(request_queue_t
 	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 }
 
+static void elv_drain_elevator(request_queue_t *q)
+{
+	static int printed;
+	while (q->elevator->ops->elevator_dispatch_fn(q, 1))
+		;
+	if (q->nr_sorted == 0)
+		return;
+	if (printed++ < 10) {
+		printk(KERN_ERR "%s: forced dispatching is broken "
+		       "(nr_sorted=%u), please report this\n",
+		       q->elevator->elevator_type->elevator_name, q->nr_sorted);
+	}
+}
+
 void __elv_add_request(request_queue_t *q, struct request *rq, int where,
 		       int plug)
 {
@@ -348,9 +364,7 @@ void __elv_add_request(request_queue_t *
 
 	case ELEVATOR_INSERT_BACK:
 		rq->flags |= REQ_SOFTBARRIER;
-
-		while (q->elevator->ops->elevator_dispatch_fn(q, 1))
-			;
+		elv_drain_elevator(q);
 		list_add_tail(&rq->queuelist, &q->queue_head);
 		/*
 		 * We kick the queue here for the following reasons.
@@ -369,6 +383,7 @@ void __elv_add_request(request_queue_t *
 	case ELEVATOR_INSERT_SORT:
 		BUG_ON(!blk_fs_request(rq));
 		rq->flags |= REQ_SORTED;
+		q->nr_sorted++;
 		if (q->last_merge == NULL && rq_mergeable(rq))
 			q->last_merge = rq;
 		/*
@@ -691,8 +706,7 @@ static void elevator_switch(request_queu
 
 	set_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
 
-	while (q->elevator->ops->elevator_dispatch_fn(q, 1))
-		;
+	elv_drain_elevator(q);
 
 	while (q->rq.elvpriv) {
 		blk_remove_plug(q);
@@ -700,6 +714,7 @@ static void elevator_switch(request_queu
 		spin_unlock_irq(q->queue_lock);
 		msleep(10);
 		spin_lock_irq(q->queue_lock);
+		elv_drain_elevator(q);
 	}
 
 	spin_unlock_irq(q->queue_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -406,6 +406,7 @@ struct request_queue
 
 	atomic_t		refcnt;
 
+	unsigned int		nr_sorted;
 	unsigned int		in_flight;
 
 	/*
@@ -631,6 +632,7 @@ static inline void elv_dispatch_add_tail
 {
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
+	q->nr_sorted--;
 
 	q->end_sector = rq_end_sector(rq);
 	q->boundary_rq = rq;
