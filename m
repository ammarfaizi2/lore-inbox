Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSDAJY7>; Mon, 1 Apr 2002 04:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSDAJYu>; Mon, 1 Apr 2002 04:24:50 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:10371 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S311180AbSDAJYg>;
	Mon, 1 Apr 2002 04:24:36 -0500
Message-ID: <3CA8270B.748EB3A3@colorfullife.com>
Date: Mon, 01 Apr 2002 11:23:23 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre1-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] block/IDE/interrupt lockup
Content-Type: multipart/mixed;
 boundary="------------BD868BAD1D0A50D4FF1A429B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BD868BAD1D0A50D4FF1A429B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've attached an alternative patch:
ide assumes that blk_init_queue doesn't sleep or enable interrupts. As a
quick fix, make block_grow_request_list() nonblocking:
both spin_lock_irqsave() and SLAB_ATOMIC allocations. Just
spin_lock_irqsave() with SLAB_KERNEL allocations doesn't fix the
problem.

The better fix would be cleaning up init_irq() in
drivers/ide/ide-probe.c, but that's something for 2.5 or someone who
understand the ide code.

--
	Manfred
--------------BD868BAD1D0A50D4FF1A429B
Content-Type: text/plain; charset=us-ascii;
 name="patch-alternative"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-alternative"

--- 2.4/drivers/block/ll_rw_blk.c	Mon Apr  1 10:53:25 2002
+++ build-2.4/drivers/block/ll_rw_blk.c	Mon Apr  1 11:00:21 2002
@@ -336,14 +336,17 @@
  */
 int blk_grow_request_list(request_queue_t *q, int nr_requests)
 {
-	spin_lock_irq(&io_request_lock);
+	unsigned long flags;
+	/* Several broken drivers assume that this function doesn't sleep,
+	 * this causes system hangs during boot.
+	 * As a temporary fix, make the the function non-blocking.
+	 */
+	spin_lock_irqsave(&io_request_lock, flags);
 	while (q->nr_requests < nr_requests) {
 		struct request *rq;
 		int rw;
 
-		spin_unlock_irq(&io_request_lock);
-		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
-		spin_lock_irq(&io_request_lock);
+		rq = kmem_cache_alloc(request_cachep, SLAB_ATOMIC);
 		if (rq == NULL)
 			break;
 		memset(rq, 0, sizeof(*rq));
@@ -356,7 +359,7 @@
 	q->batch_requests = q->nr_requests / 4;
 	if (q->batch_requests > 32)
 		q->batch_requests = 32;
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irqrestore(&io_request_lock, flags);
 	return q->nr_requests;
 }
 

--------------BD868BAD1D0A50D4FF1A429B--


