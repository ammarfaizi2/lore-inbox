Return-Path: <linux-kernel-owner+w=401wt.eu-S933030AbWLSWLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbWLSWLe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWLSWLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:11:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933030AbWLSWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:11:33 -0500
Date: Tue, 19 Dec 2006 17:11:19 -0500 (EST)
Message-Id: <20061219.171119.18572687.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be called
 from interrupt context
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, blk_get_request() is not ready for being called from
interrupt context because it enables interrupt forcibly in it.

Request-based device-mapper sometimes needs to get a request
in interrupt context to create a clone.
Calling blk_get_request() from interrupt context should be OK
because blk_get_request() returns NULL without sleep if no memory
unless __GFP_WAIT mask is specified, and then the interrupt context
can plug queue to retry after and return immediately.

So this patch allows blk_get_request() to be called from interrupt
context by save/restore current state of irq.


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rupN 2.6.19.1/block/ll_rw_blk.c 1-blk-get-request-irqrestore/block/ll_rw_blk.c
--- 2.6.19.1/block/ll_rw_blk.c	2006-12-11 14:32:53.000000000 -0500
+++ 1-blk-get-request-irqrestore/block/ll_rw_blk.c	2006-12-15 10:21:29.000000000 -0500
@@ -2064,9 +2064,10 @@ static void freed_request(request_queue_
  * Get a free request, queue_lock must be held.
  * Returns NULL on failure, with queue_lock held.
  * Returns !NULL on success, with queue_lock *not held*.
+ * If flags is given, the irq state is kept when unlocking the queue_lock.
  */
 static struct request *get_request(request_queue_t *q, int rw, struct bio *bio,
-				   gfp_t gfp_mask)
+				   gfp_t gfp_mask, unsigned long *flags)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
@@ -2119,7 +2120,10 @@ static struct request *get_request(reque
 	if (priv)
 		rl->elvpriv++;
 
-	spin_unlock_irq(q->queue_lock);
+	if (flags)
+		spin_unlock_irqrestore(q->queue_lock, *flags);
+	else
+		spin_unlock_irq(q->queue_lock);
 
 	rq = blk_alloc_request(q, rw, priv, gfp_mask);
 	if (unlikely(!rq)) {
@@ -2130,7 +2134,10 @@ static struct request *get_request(reque
 		 * Allocating task should really be put onto the front of the
 		 * wait queue, but this is pretty rare.
 		 */
-		spin_lock_irq(q->queue_lock);
+		if (flags)
+			spin_lock_irqsave(q->queue_lock, *flags);
+		else
+			spin_lock_irq(q->queue_lock);
 		freed_request(q, rw, priv);
 
 		/*
@@ -2174,7 +2181,7 @@ static struct request *get_request_wait(
 {
 	struct request *rq;
 
-	rq = get_request(q, rw, bio, GFP_NOIO);
+	rq = get_request(q, rw, bio, GFP_NOIO, NULL);
 	while (!rq) {
 		DEFINE_WAIT(wait);
 		struct request_list *rl = &q->rq;
@@ -2182,7 +2189,7 @@ static struct request *get_request_wait(
 		prepare_to_wait_exclusive(&rl->wait[rw], &wait,
 				TASK_UNINTERRUPTIBLE);
 
-		rq = get_request(q, rw, bio, GFP_NOIO);
+		rq = get_request(q, rw, bio, GFP_NOIO, NULL);
 
 		if (!rq) {
 			struct io_context *ioc;
@@ -2213,16 +2220,17 @@ static struct request *get_request_wait(
 struct request *blk_get_request(request_queue_t *q, int rw, gfp_t gfp_mask)
 {
 	struct request *rq;
+	unsigned long flags;
 
 	BUG_ON(rw != READ && rw != WRITE);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irqsave(q->queue_lock, flags);
 	if (gfp_mask & __GFP_WAIT) {
 		rq = get_request_wait(q, rw, NULL);
 	} else {
-		rq = get_request(q, rw, NULL, gfp_mask);
+		rq = get_request(q, rw, NULL, gfp_mask, &flags);
 		if (!rq)
-			spin_unlock_irq(q->queue_lock);
+			spin_unlock_irqrestore(q->queue_lock, flags);
 	}
 	/* q->queue_lock is unlocked at this point */
 

