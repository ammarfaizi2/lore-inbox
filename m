Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbTE1Khf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTE1Khf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:37:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43146 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264666AbTE1Kha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:37:30 -0400
Date: Wed, 28 May 2003 12:50:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>,
       m.c.p@wolk-project.de, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528105029.GS845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <20030528032315.679e77b0.akpm@digeo.com> <20030528102529.GQ845@suse.de> <200305282048.58032.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305282048.58032.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Con Kolivas wrote:
> On Wed, 28 May 2003 20:25, Jens Axboe wrote:
> > On Wed, May 28 2003, Andrew Morton wrote:
> > > Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de> wrote:
> > > > Works fine on my notebook. Good throughput and no mouse hangs anymore.
> > >
> > > Interesting.
> > >
> > > Could you please work out which change caused it?  Go back to stock 2.4
> > > and then apply this:
> > >
> > >
> > > diff -puN drivers/block/ll_rw_blk.c~1 drivers/block/ll_rw_blk.c
> > > --- 24/drivers/block/ll_rw_blk.c~1	2003-05-28 03:20:42.000000000 -0700
> > > +++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:20:57.000000000 -0700
> > > @@ -590,10 +590,10 @@ static struct request *__get_request_wai
> > >  	register struct request *rq;
> > >  	DECLARE_WAITQUEUE(wait, current);
> > >
> > > -	generic_unplug_device(q);
> > >  	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
> > >  	do {
> > >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > > +		generic_unplug_device(q);
> > >  		if (q->rq[rw].count == 0)
> > >  			schedule();
> > >  		spin_lock_irq(&io_request_lock);
> >
> > I think it was already established that this wasn't the reason. Was my
> > first suspect too, though...
> >
> > > then this:
> > >
> > > diff -puN drivers/block/ll_rw_blk.c~2 drivers/block/ll_rw_blk.c
> > > --- 24/drivers/block/ll_rw_blk.c~2	2003-05-28 03:21:03.000000000 -0700
> > > +++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:21:09.000000000 -0700
> > > @@ -590,7 +590,7 @@ static struct request *__get_request_wai
> > >  	register struct request *rq;
> > >  	DECLARE_WAITQUEUE(wait, current);
> > >
> > > -	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
> > > +	add_wait_queue(&q->wait_for_requests[rw], &wait);
> > >  	do {
> > >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > >  		generic_unplug_device(q);
> >
> > Since we do a general wake_up(), only the order of wakeups matter here
> > right (lifo vs fifo). Given that, the _exclusive() should be more fair
> > possibly at the cost of a bit of throughput.
> >
> > > Then this (totally unlikely, don't bother):
> > >
> > > diff -puN drivers/block/ll_rw_blk.c~3 drivers/block/ll_rw_blk.c
> > > --- 24/drivers/block/ll_rw_blk.c~3	2003-05-28 03:21:15.000000000 -0700
> > > +++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:21:39.000000000 -0700
> > > @@ -829,8 +829,7 @@ void blkdev_release_request(struct reque
> > >  	 */
> > >  	if (q) {
> > >  		list_add(&req->queue, &q->rq[rw].free);
> > > -		if (++q->rq[rw].count >= q->batch_requests &&
> > > -				waitqueue_active(&q->wait_for_requests[rw]))
> > > +		if (++q->rq[rw].count >= q->batch_requests)
> > >  			wake_up(&q->wait_for_requests[rw]);
> > >  	}
> > >  }
> >
> > Well it's the only one left :). But you are right, try one of them at
> > the time, establishing the effect of each of them.
> 
> THIS IS IT! The last one. No pauses writing a 2Gb file now unless I do a read 
> midstream.

Cool, especially since we can easily apply this to -rc5 without any
worries. Marcelo, if you please...?

===== drivers/block/ll_rw_blk.c 1.44 vs edited =====
--- 1.44/drivers/block/ll_rw_blk.c	Mon Apr 14 12:53:03 2003
+++ edited/drivers/block/ll_rw_blk.c	Wed May 28 12:49:30 2003
@@ -829,8 +829,7 @@
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests &&
-				waitqueue_active(&q->wait_for_requests[rw]))
+		if (++q->rq[rw].count >= q->batch_requests)
 			wake_up(&q->wait_for_requests[rw]);
 	}
 }

-- 
Jens Axboe

