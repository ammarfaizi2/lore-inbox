Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131975AbQK2SnC>; Wed, 29 Nov 2000 13:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131973AbQK2Smm>; Wed, 29 Nov 2000 13:42:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17939 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S131685AbQK2Smc>;
        Wed, 29 Nov 2000 13:42:32 -0500
Date: Wed, 29 Nov 2000 19:11:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: plug problem in linux-2.4.0-test11
Message-ID: <20001129191157.A30394@suse.de>
In-Reply-To: <20001129152308.A28399@suse.de> <Pine.LNX.4.10.10011290949520.11951-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10011290949520.11951-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Nov 29, 2000 at 09:52:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2000, Linus Torvalds wrote:
> I would much rather actually go back to the original setup, which did
> nothing at all if the queue wasn't plugged in the first place.

But that potentially breaks devices that either don't use plugging
or alternatively implement their own, because q->plugged will not
get set and the unplug from __get_request_wait does nothing. It's
clear that the plug/noplug is too coarse. Anyway, I don't think
there's currently a problem with the old setup for any in-kernel
drivers so I'm fine with reverting to that behaviour for now.

> I think that we should strive for a setup that calls "request_fn" only to
> start new IO, and that expects the low-level driver to be able to do the
> whole request queue until it is empty. Then we re-start it the next time
> around.

Yes agreed.

--- drivers/block/ll_rw_blk.c~	Wed Nov 29 15:17:33 2000
+++ drivers/block/ll_rw_blk.c	Wed Nov 29 19:04:50 2000
@@ -347,9 +347,10 @@
  */
 static inline void __generic_unplug_device(request_queue_t *q)
 {
-	if (!list_empty(&q->queue_head)) {
+	if (q->plugged) {
 		q->plugged = 0;
-		q->request_fn(q);
+		if (!list_empty(&q->queue_head))
+			q->request_fn(q);
 	}
 }
 
-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
