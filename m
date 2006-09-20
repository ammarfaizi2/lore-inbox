Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWITPDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWITPDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWITPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:03:33 -0400
Received: from mail.suse.de ([195.135.220.2]:2751 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751584AbWITPDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:03:32 -0400
Date: Wed, 20 Sep 2006 17:03:31 +0200
From: Nick Piggin <npiggin@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [rfc][patch 2.6.18-rc7] block: explicit plugging
Message-ID: <20060920150331.GC27347@wotan.suse.de>
References: <20060916115607.GA16971@wotan.suse.de> <5c49b0ed0609181310n409a64c2i172e07044802751a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0609181310n409a64c2i172e07044802751a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 01:10:13PM -0700, Nate Diller wrote:
> On 9/16/06, Nick Piggin <npiggin@suse.de> wrote:
> >Hi,
> >
> >I've been tinkering with this idea for a while, and I'd be interested
> >in seeing what people think about it. The patch isn't in a great state
> >of commenting or splitting ;) but I'd be interested feelings about the
> >general approach, and whether I'm going to hit any bad problems (eg.
> >with SCSI or IDE).
> 
> I *really* like this idea, and I would like to help get it merged.  I
> can even run some benchmarks for you once I get my test rig running
> again.

Thanks, that would be handy.

> I had a related idea that I have not been able to work on yet.  I
> called it "kernel anticipation", and it explicitly instructs the
> scheduler when a function is submitting I/O that subsequent I/O is
> dependent on.  In other words, when we are composing a bio and get the
> "BH_Boundary" flag in a buffer head, mark the bio for mandatory
> anticipation, since we know we'll have a hit.  This would enable the
> anticipation code to act in some cases even for processes with very
> high thinktimes.

This patch gives you the mechanism to do that for independent IOs,
but not for dependent ones (ie. where you actually want to forcefully
idle the queue).

But do remember that if your thinktime is potentially very high, then
it can quickly get to the point where it is cheaper to eat the cost
of moving the heads. So even if we *know* we'll have a subsequent
request very close to the last, it may not be the best idea to wait.

> >On a parallel tiobench benchmark, of the 800 000 calls to __make_request
> >performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
> >early merging on the private plugged list.
> 
> Have you run any FS performance benchmorks to check for regressions in
> performance?  Who knows, you might even see be able to show a visible
> increase :)

I haven't done anything interesting/intensive yet. I imagine the
queue_lock savings won't be measurable on 2-way systems with only
one or two disks. I do hope the actual request patterns will be
improved when under parallel and asynch IO, though.

> 
> >@@ -2865,68 +2762,48 @@ static int __make_request(request_queue_
> >         */
> >        blk_queue_bounce(q, &bio);
> >
> >-       spin_lock_prefetch(q->queue_lock);
> >-
> >        barrier = bio_barrier(bio);
> >        if (unlikely(barrier) && (q->next_ordered == QUEUE_ORDERED_NONE)) {
> >                err = -EOPNOTSUPP;
> >                goto end_io;
> >        }
> >
> >+       /* Attempt merging with the plugged list before taking locks */
> >+       ioc = current->io_context;
> >+       if (ioc && ioc->plugged && !list_empty(&ioc->plugged_list)) {
> >+               struct request *rq;
> >+               rq = list_entry_rq(ioc->plugged_list.prev);
> >+
> >+               el_ret = elv_try_merge(rq, bio);
> >+               if (el_ret == ELEVATOR_BACK_MERGE) {
> >+                       if (bio_attempt_back_merge(q, rq, nr_sectors, bio))
> >+                               goto out;
> >+               } else if (el_ret == ELEVATOR_FRONT_MERGE) {
> >+                       if (bio_attempt_front_merge(q, rq, nr_sectors, 
> >bio))
> >+                               goto out;
> >+               }
> >+       }
> >+
> >        spin_lock_irq(q->queue_lock);
> >
> >-       if (unlikely(barrier) || elv_queue_empty(q))
> >+       if (elv_queue_empty(q))
> >                goto get_rq;
> >
> >        el_ret = elv_merge(q, &req, bio);
> >-       switch (el_ret) {
> 
> Have you considered skipping the queue merge entirely, if there is not
> a hit in the plugged_list?  I would be interested to see a "hit rate"
> of how many queue merge attempts are successful here.  I bet it's
> pretty low.  The difference froim just skipping these entirely might
> not even be visible in a benchmark.  It'd be pretty cool to be able to
> eliminate the queue merging interface altogether.

On the tiobench workload above, of the 310 000 requests that hit the
queue, 290 000 were merged, leaving about 20 000 actual requests going
to the block device. So it is not insignificant. Definitely it could
be less if the private queue merging was a bit smarter, but I think
classes of parallel IO workloads will want to merge on the public queue.

Given that we need to maintain the queue for sorting purposes anyway,
I don't think merging ends up being too costly .

> 
> Thanks for doing this work, it looks really promising.

I appreciate the interest, thanks.

