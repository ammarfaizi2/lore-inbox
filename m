Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbTJ3Xku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbTJ3Xku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:40:50 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:28601 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262909AbTJ3Xki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:40:38 -0500
Message-ID: <3FA1A171.3040807@cyberone.com.au>
Date: Fri, 31 Oct 2003 10:40:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>,
       Thomas Schlichter <schlicht@uni-mannheim.de>
CC: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
References: <200310301601.55588.schlicht@uni-mannheim.de> <20031030133316.6bd00b4a.akpm@osdl.org> <200310302310.53798.schlicht@uni-mannheim.de> <3FA1943A.7010300@cornell.edu>
In-Reply-To: <3FA1943A.7010300@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------060403030406060005000505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403030406060005000505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
If you're testing IDE TCQ, please try the following patch and use the
default io scheduler. It won't fix anything, but it poisons requests
so we can sometimes tell if they are being used in the wrong places.
I have seen warnings that lead me to believe this might be happening.
Its against 2.6.0-test9-mm1. Report any stack traces you see. Thanks.

Nick


--------------060403030406060005000505
Content-Type: text/plain;
 name="as-req-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-req-debug.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |   69 ++++++++++++++++++++-------
 1 files changed, 53 insertions(+), 16 deletions(-)

diff -puN drivers/block/as-iosched.c~as-req-debug drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-req-debug	2003-10-31 09:42:27.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-10-31 10:33:00.000000000 +1100
@@ -136,6 +136,10 @@ enum arq_state {
 				   scheduler */
 	AS_RQ_DISPATCHED,	/* On the dispatch list. It belongs to the
 				   driver now */
+	AS_RQ_PRESCHED,		/* Debug poisoning for requests being used */
+	AS_RQ_REMOVED,
+	AS_RQ_MERGED,
+	AS_RQ_POSTSCHED,	/* when they shouldn't be */
 };
 
 struct as_rq {
@@ -897,8 +901,14 @@ static void as_completed_request(request
 
 	WARN_ON(!list_empty(&rq->queuelist));
 
-	if (unlikely(arq->state != AS_RQ_DISPATCHED))
-		return;
+	if (arq->state == AS_RQ_MERGED)
+		goto out;
+
+	if (arq->state != AS_RQ_REMOVED) {
+		printk("arq->state %d\n", arq->state);
+		WARN_ON(1);
+		goto out;
+	}
 
 	if (ad->changed_batch && ad->nr_dispatched == 1) {
 		WARN_ON(ad->batch_data_dir == arq->is_sync);
@@ -926,7 +936,7 @@ static void as_completed_request(request
 	}
 
 	if (!arq->io_context)
-		return;
+		goto out;
 
 	if (ad->io_context == arq->io_context) {
 		ad->antic_start = jiffies;
@@ -942,7 +952,7 @@ static void as_completed_request(request
 
 	aic = arq->io_context->aic;
 	if (!aic)
-		return;
+		goto out;
 
 	spin_lock(&aic->lock);
 	if (arq->is_sync == REQ_SYNC) {
@@ -952,6 +962,9 @@ static void as_completed_request(request
 	spin_unlock(&aic->lock);
 
 	put_io_context(arq->io_context);
+
+out:
+	arq->state = AS_RQ_POSTSCHED;
 }
 
 /*
@@ -1020,14 +1033,14 @@ static void as_remove_request(request_qu
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (unlikely(arq->state == AS_RQ_NEW))
-		return;
-
-	if (!arq) {
-		WARN_ON(1);
-		return;
-	}
+		goto out;
 
 	if (ON_RB(&arq->rb_node)) {
+		if (arq->state != AS_RQ_QUEUED) {
+			printk("arq->state %d\n", arq->state);
+			WARN_ON(1);
+			goto out;
+		}
 		/*
 		 * We'll lose the aliased request(s) here. I don't think this
 		 * will ever happen, but if it does, hopefully someone will
@@ -1035,8 +1048,16 @@ static void as_remove_request(request_qu
 		 */
 		WARN_ON(!list_empty(&rq->queuelist));
 		as_remove_queued_request(q, rq);
-	} else
+	} else {
+		if (arq->state != AS_RQ_DISPATCHED) {
+			printk("arq->state %d\n", arq->state);
+			WARN_ON(1);
+			goto out;
+		}
 		as_remove_dispatched_request(q, rq);
+	}
+out:
+	arq->state = AS_RQ_REMOVED;
 }
 
 /*
@@ -1276,8 +1297,6 @@ fifo_expired:
 			ad->new_batch = 1;
 
 		ad->changed_batch = 0;
-
-//		arq->request->flags |= REQ_SOFTBARRIER;
 	}
 
 	/*
@@ -1402,6 +1421,11 @@ static void as_requeue_request(request_q
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (arq) {
+		if (arq->state != AS_RQ_REMOVED) {
+			printk("arq->state %d\n", arq->state);
+			WARN_ON(1);
+		}
+
 		arq->state = AS_RQ_DISPATCHED;
 		if (arq->io_context && arq->io_context->aic)
 			atomic_inc(&arq->io_context->aic->nr_dispatched);
@@ -1421,12 +1445,18 @@ as_insert_request(request_queue_t *q, st
 	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-#if 0
+ 	if (arq) {
+ 		if (arq->state != AS_RQ_PRESCHED) {
+ 			printk("arq->state: %d\n", arq->state);
+ 			WARN_ON(1);
+ 		}
+ 		arq->state = AS_RQ_NEW;
+ 	}
+
 	/* barriers must flush the reorder queue */
 	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
 			&& where == ELEVATOR_INSERT_SORT))
 		where = ELEVATOR_INSERT_BACK;
-#endif
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:
@@ -1662,6 +1692,8 @@ as_merged_requests(request_queue_t *q, s
 	 */
 	as_remove_queued_request(q, next);
 	put_io_context(anext->io_context);
+
+	anext->state = AS_RQ_MERGED;
 }
 
 /*
@@ -1694,6 +1726,11 @@ static void as_put_request(request_queue
 		return;
 	}
 
+	if (arq->state != AS_RQ_POSTSCHED) {
+		printk("arq->state %d\n", arq->state);
+		WARN_ON(1);
+	}
+
 	mempool_free(arq, ad->arq_pool);
 	rq->elevator_private = NULL;
 }
@@ -1707,7 +1744,7 @@ static int as_set_request(request_queue_
 		memset(arq, 0, sizeof(*arq));
 		RB_CLEAR(&arq->rb_node);
 		arq->request = rq;
-		arq->state = AS_RQ_NEW;
+		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
 		INIT_LIST_HEAD(&arq->hash);
 		arq->on_hash = 0;

_

--------------060403030406060005000505--

