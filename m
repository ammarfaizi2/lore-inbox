Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143746AbRA1SXr>; Sun, 28 Jan 2001 13:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143745AbRA1SX0>; Sun, 28 Jan 2001 13:23:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9995 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S143692AbRA1SXT>;
	Sun, 28 Jan 2001 13:23:19 -0500
Date: Sun, 28 Jan 2001 19:23:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 deadlock (Re: ps hang in 241-pre10)
Message-ID: <20010128192306.C4871@suse.de>
In-Reply-To: <3.0.6.32.20010127220102.01367ce0@pop.tiscalinet.it> <Pine.LNX.4.10.10101271524010.1076-100000@penguin.transmeta .com> <3.0.6.32.20010128104843.01367eb0@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20010128104843.01367eb0@pop.tiscalinet.it>; from lenstra@tiscalinet.it on Sun, Jan 28, 2001 at 10:48:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28 2001, Lorenzo Allegrucci wrote:
> >Ho humm. Jens: imagine that you have more people waiting for requests than
> >"batchcount". Further, imagine that you have multiple requests finishing
> >at the same time. Not unlikely. Now, imagine that one request finishes,
> >and causes "batchcount" users to wake up, and immediately another request
> >finishes but THAT one doesn't wake anybody up because it notices that the
> >freelist isn't empty - so it thinks that it doesn't need to wake anybody.
> >
> >Lorenzo, does the problem go away for you if you remove the
> >
> >	if (!list_empty(&q->request_freelist[rw])) {
> >		...
> >	}
> >
> >code from blkdev_release_request() in drivers/block/ll_rw_block.c?
> 
> Yes, it does.

How about this instead?

--- /opt/kernel/linux-2.4.1-pre10/drivers/block/ll_rw_blk.c	Thu Jan 25 19:15:12 2001
+++ drivers/block/ll_rw_blk.c	Sun Jan 28 19:22:20 2001
@@ -633,6 +634,8 @@
 		if (!list_empty(&q->request_freelist[rw])) {
 			blk_refill_freelist(q, rw);
 			list_add(&req->table, &q->request_freelist[rw]);
+			if (waitqueue_active(&q->wait_for_request))
+				wake_up_nr(&q->wait_for_request, 2);
 			return;
 		}
 

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
