Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVAMJW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVAMJW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 04:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVAMJW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 04:22:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42141 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261297AbVAMJWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 04:22:48 -0500
Date: Thu, 13 Jan 2005 10:22:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: nickpiggin@yahoo.com.au, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] possible rq starvation on oom
Message-ID: <20050113092246.GJ2815@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I stumbled across this the other day. The block layer only uses a single
memory pool for request allocation, so it's very possible for eg writes
to have allocated them all at any point in time. If that is the case and
the machine is low on memory, a reader attempting to allocate a request
and failing in blk_alloc_request() can get stuck for a long time since
no one is there to wake it up.

The solution is either to add the extra mempool so both reads and writes
have one, or attempt to handle the situation. I chose the latter, to
save the extra memory required for the additional mempool with
BLKDEV_MIN_RQ statically allocated requests per-queue.

If a read allocation fails and we have no readers in flight for this
queue, mark us rq-starved so that the next write being freed will wake
up the sleeping reader(s). Same situation would happen for writes as
well of course, it's just a lot more unlikely.

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/ll_rw_blk.c 1.281 vs edited =====
--- 1.281/drivers/block/ll_rw_blk.c	2004-12-01 09:13:57 +01:00
+++ edited/drivers/block/ll_rw_blk.c	2005-01-13 10:17:36 +01:00
@@ -1438,6 +1438,7 @@
 	struct request_list *rl = &q->rq;
 
 	rl->count[READ] = rl->count[WRITE] = 0;
+	rl->starved[READ] = rl->starved[WRITE] = 0;
 	init_waitqueue_head(&rl->wait[READ]);
 	init_waitqueue_head(&rl->wait[WRITE]);
 	init_waitqueue_head(&rl->drain);
@@ -1618,6 +1619,22 @@
 	ioc->last_waited = jiffies;
 }
 
+static void __freed_request(request_queue_t *q, int rw)
+{
+	struct request_list *rl = &q->rq;
+
+	if (rl->count[rw] < queue_congestion_off_threshold(q))
+		clear_queue_congested(q, rw);
+
+	if (rl->count[rw] + 1 <= q->nr_requests) {
+		smp_mb();
+		if (waitqueue_active(&rl->wait[rw]))
+			wake_up(&rl->wait[rw]);
+
+		blk_clear_queue_full(q, rw);
+	}
+}
+
 /*
  * A request has just been released.  Account for it, update the full and
  * congestion status, wake up any waiters.   Called under q->queue_lock.
@@ -1627,17 +1644,17 @@
 	struct request_list *rl = &q->rq;
 
 	rl->count[rw]--;
-	if (rl->count[rw] < queue_congestion_off_threshold(q))
-		clear_queue_congested(q, rw);
-	if (rl->count[rw]+1 <= q->nr_requests) {
+
+	__freed_request(q, rw);
+
+	if (unlikely(rl->starved[rw ^ 1]))
+		__freed_request(q, rw ^ 1);
+
+	if (!rl->count[READ] && !rl->count[WRITE]) {
 		smp_mb();
-		if (waitqueue_active(&rl->wait[rw]))
-			wake_up(&rl->wait[rw]);
-		blk_clear_queue_full(q, rw);
+		if (unlikely(waitqueue_active(&rl->drain)))
+			wake_up(&rl->drain);
 	}
-	if (unlikely(waitqueue_active(&rl->drain)) &&
-	    !rl->count[READ] && !rl->count[WRITE])
-		wake_up(&rl->drain);
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
@@ -1669,8 +1686,7 @@
 
 	switch (elv_may_queue(q, rw)) {
 		case ELV_MQUEUE_NO:
-			spin_unlock_irq(q->queue_lock);
-			goto out;
+			goto rq_starved;
 		case ELV_MQUEUE_MAY:
 			break;
 		case ELV_MQUEUE_MUST:
@@ -1688,6 +1704,7 @@
 
 get_rq:
 	rl->count[rw]++;
+	rl->starved[rw] = 0;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
 		set_queue_congested(q, rw);
 	spin_unlock_irq(q->queue_lock);
@@ -1703,6 +1720,18 @@
 		 */
 		spin_lock_irq(q->queue_lock);
 		freed_request(q, rw);
+
+		/*
+		 * in the very unlikely event that allocation failed and no
+		 * requests for this direction was pending, mark us starved
+		 * so that freeing of a request in the other direction will
+		 * notice us. another possible fix would be to split the
+		 * rq mempool into READ and WRITE
+		 */
+rq_starved:
+		if (unlikely(rl->count[rw] == 0))
+			rl->starved[rw] = 1;
+
 		spin_unlock_irq(q->queue_lock);
 		goto out;
 	}
===== include/linux/blkdev.h 1.157 vs edited =====
--- 1.157/include/linux/blkdev.h	2004-11-11 09:39:16 +01:00
+++ edited/include/linux/blkdev.h	2005-01-13 10:16:43 +01:00
@@ -95,6 +95,7 @@
 
 struct request_list {
 	int count[2];
+	int starved[2];
 	mempool_t *rq_pool;
 	wait_queue_head_t wait[2];
 	wait_queue_head_t drain;

-- 
Jens Axboe

