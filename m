Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312396AbSC3FrZ>; Sat, 30 Mar 2002 00:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312397AbSC3FrQ>; Sat, 30 Mar 2002 00:47:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34832 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312396AbSC3Fq6>;
	Sat, 30 Mar 2002 00:46:58 -0500
Message-ID: <3CA550F4.28014B4E@zip.com.au>
Date: Fri, 29 Mar 2002 21:45:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] block/IDE/interrupt lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

my blk_grow_request_list() patch in -pre5 is buggy.  It
can cause boot-time lockups.  The window is fairly small,
but I just hit it.

drivers/ide/ide-probe.c:init_irq() does cli().
It calls down to blk_init_free_list() and
blk_grow_request_list().

blk_grow_request_list() does spin_unlock_irq().  Which
is illegal inside cli().  An interrupt comes in and
the CPU locks up in irq_enter(), spinning on global_irq_lock,
which this CPU already holds.

Below is the patch.  (That's the last spin_lock_irq()
anyone will be seeing from me :))

Andre, init_irq() is somewhat broken - it appears to
be assuming that cli() will disable interrupts, but it's
calling functions which can sleep.   If these functions
_do_ sleep, interrupts will be enabled, which is presumably
not what IDE wants to happen.


--- 2.4.19-pre5/drivers/block/ll_rw_blk.c~ide-lockup	Fri Mar 29 21:19:11 2002
+++ 2.4.19-pre5-akpm/drivers/block/ll_rw_blk.c	Fri Mar 29 21:20:04 2002
@@ -336,14 +336,16 @@ void generic_unplug_device(void *data)
  */
 int blk_grow_request_list(request_queue_t *q, int nr_requests)
 {
-	spin_lock_irq(&io_request_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
 	while (q->nr_requests < nr_requests) {
 		struct request *rq;
 		int rw;
 
-		spin_unlock_irq(&io_request_lock);
+		spin_unlock_irqrestore(&io_request_lock, flags);
 		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
-		spin_lock_irq(&io_request_lock);
+		spin_lock_irqsave(&io_request_lock, flags);
 		if (rq == NULL)
 			break;
 		memset(rq, 0, sizeof(*rq));
@@ -356,7 +358,7 @@ int blk_grow_request_list(request_queue_
 	q->batch_requests = q->nr_requests / 4;
 	if (q->batch_requests > 32)
 		q->batch_requests = 32;
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irqrestore(&io_request_lock, flags);
 	return q->nr_requests;
 }
 

-
