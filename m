Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267240AbRGKIsQ>; Wed, 11 Jul 2001 04:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbRGKIsG>; Wed, 11 Jul 2001 04:48:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26629 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267236AbRGKIr6>;
	Wed, 11 Jul 2001 04:47:58 -0400
Date: Wed, 11 Jul 2001 10:47:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Dipankar Sarma <dipankar@sequent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711104745.E17314@suse.de>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010711091900.C17314@suse.de> <20010711140923.A9220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010711140923.A9220@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11 2001, Dipankar Sarma wrote:
> > > It also seems that __make_request() holds the lock for the largest
> > > amount of time. This hold time isn't likely to change significantly
> > 
> > __make_request -> elevator merge/insertion scan. This is what is taking
> > all the time, not __make_request itself. With the bio-XX patches I have
> > completely eliminated merge scans, so that can be done in O(1) time. For
> > now insertion is still a O(N) scan, maybe that will change too [1].
> 
> I haven't got as far down as the elevator algorithm yet, but I would
> like to, at some point in time. In any case, my point was that because
> of disk block sorting done during initial queueing, there is likely
> to be a slightly longer lock (per-queue or otherwise) hold time there
> compared to, say, dequeueing for dispatch to lowlevel drivers.

That's exactly right. The merging/insertion is O(N) now, so for queueing
100 buffers it will take some time. Especially for bigger hardware,
where we allocate a much bigger freelist (and potentially get very long
queues). Dequeueing is O(1) always, and thus doesn't hold the lock for
long.

> Where can I get the bio patches from ?

kernel.org/pub/linux/kernel/people/axboe/v2.5

wait for bio-14 final though.

> > > for a per-queue lock, but atleast it will not affect queueing i/o
> > > requests to other devices. Besides, I am not sure if blk_get_queue()
> > > really needs to grab the io_request_lock. blk_dev[] entries aren't
> > 
> > Funny, this is one thing I've been looking at too. blk_get_queue _will_
> > die, don't worry. And yes, ie at open we can assign the queue. Or simply
> > map it and protect it otherwise. It all ties in with being able to up or
> > down a queue too, currently grabbing io_request_lock from blk_get_queue
> > accomplishes exactly nothing and may as well be removed. If you do that,
> > does it change the contention numbers significantly?
> 
> I haven't yet experimented with this yet, but theoritically speaking
> yes, it should make a big difference. blk_get_queue() grabs the lock
> very often and holds it for a very short period of time on average,
> so it is the one that is affected most. Out of the 30 seconds of
> spin-wait for io_request_lock, blk_get_queue() seems to take up
> 610820*60.2%*72us = 26.5 seconds. I will get to this soon though.

In that case, I'll make sure to rip it out immediately in the stock
kernel too. You'll note that the bio-XX patches don't use it either, and
haven't for some time.

> BTW, where can I get some of these lock-splitting patches from ? I
> can do one myself for scsi+aic7xxx, but if there already exist some 
> work, I would like to start off with them.

I have some old patches somewhere, but no chance of them applying now.
It's mostly a case of s/io_request_lock/q->queue_lock in some way for
all cases, so it's probably just as easy if you do it yourself for
testing.

-- 
Jens Axboe

