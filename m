Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbTDAKfu>; Tue, 1 Apr 2003 05:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbTDAKfu>; Tue, 1 Apr 2003 05:35:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45018 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262272AbTDAKfs>;
	Tue, 1 Apr 2003 05:35:48 -0500
Date: Tue, 1 Apr 2003 12:47:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rq-dyn-alloc, dynamic request allocation
Message-ID: <20030401104712.GH812@suse.de>
References: <20030401102350.GG812@suse.de> <20030401024548.715ff3c3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401024548.715ff3c3.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Hi,
> > 
> > This patch adds dynamic request allocation to the block io path. On
> > systems with lots of disks (and thus queues) it saves a non-significant
> > amount of low memory. It also allows for much better experimentation
> > with larger queue lengths, this experimental patch tops the queue depth
> > off at 16384 (vs 128 before).
> 
> heh, 16k requests per queue?  Last time I played with 1024 certain popular
> benchmarks ran like a bullet.

I have one such unmentionable benchmark running right now, current depth
is 5127 :-)

> > Please play with it. Andrew, want a version for -mm?
> 
> Would be much appreciated, thanks.

Ok, getting on it.

> >   */
> >  static struct request *get_request_wait(request_queue_t *q, int rw)
> >  {
> > -	DEFINE_WAIT(wait);
> > -	struct request_list *rl = &q->rq[rw];
> >  	struct request *rq;
> >  
> > -	spin_lock_prefetch(q->queue_lock);
> > -
> >  	generic_unplug_device(q);
> >  	do {
> > -		int block = 0;
> > +		rq = get_request(q, rw, GFP_NOIO);
> >  
> > -		prepare_to_wait_exclusive(&rl->wait, &wait,
> > -					TASK_UNINTERRUPTIBLE);
> > -		spin_lock_irq(q->queue_lock);
> > -		if (!rl->count)
> > -			block = 1;
> > -		spin_unlock_irq(q->queue_lock);
> > -
> > -		if (block)
> > +		if (!rq)
> >  			io_schedule();
> 
> hmm.  I fear that if a SCHED_FIFO/SCHED_RR task hits this, it will just pick
> itself to run again in the schedule() and the box locks up.
> 
> A blk_congestion_wait(WRITE, HZ/50) may be better here.  It will send the
> caller to sleep until someone puts a write request back, which seems
> appropriate.

Yes good point, I'll make that change.

-- 
Jens Axboe

