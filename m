Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSG1TI2>; Sun, 28 Jul 2002 15:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSG1TI2>; Sun, 28 Jul 2002 15:08:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21460 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317114AbSG1TI1>;
	Sun, 28 Jul 2002 15:08:27 -0400
Date: Sun, 28 Jul 2002 21:12:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020728211204.A3203@suse.de>
References: <20020726120248.GI14839@suse.de> <3D419583.DFE940DA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D419583.DFE940DA@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > The layout of the deadline i/o scheduler is roughly:
> > 
> >         [1]       [2]
> >          |         |
> >          |         |
> >          |         |
> >          ====[3]====
> >               |
> >               |
> >               |
> >               |
> >              [4]
> > 
> > where [1] is the regular ascendingly sorted pending list of requests,
> > [2] is a fifo list (well really two lists, one for reads and one for
> > writes) of pending requests which each have an expire time assigned, [3]
> > is the elv_next_request() worker, and [4] is the dispatch queue
> > (q->queue_head again). When a request enters the i/o scheduler, it is
> > sorted into the [1] list, assigned an expire time, and sorted into the
> > fifo list [2] (the fifo list is really two lists, one for reads and one
> > for writes).
> > 
> > [1] is the main list where we serve requests from. If a request deadline
> > gets exceeded, we move a number of entries (known as the 'fifo_batch'
> > count) from the sorted list starting from the expired entry onto the
> > dispatch queue. This makes sure that we at least attempt to start an
> > expired request immediately, but don't completely fall back to FCFS i/o
> > scheduling (well set fifo_batch == 1, and you will get FCFS with an
> > appropriately low expire time).
> 
> I don't quite understand...  When expired requests are moved from the
> fifo [2] onto the dispatch queue [4], is merging performed at the
> dispatch queue?

There are not moved from the fifo queue as such, a single entry (the
front one of course, always the oldest one) is chosen and the sorted
listed is followed from that request. So fifo_batch entries are moved
from the sorted list, starting at location X where X is the front of the
fifo and might be anywhere on the sorted list.

Merging has already been done etc, this takes place on the sorted queue
'as usual'. So it's just a matter of moving entries.

> In other words, if the fifo queue has blocks (1,3,5,7,2,4,6,8) or
> (1,10,20,5,15,25), and they expire, will they be sorted in some manner
> before going to the hardware?  If so, where?

If the fifo queue has the following entries (5,1,4,2,8,7,3,9) then the
sorted list looks like this (1,2,3,4,5,7,8,9). If fifo_batch is 4 in
this case, we would move (5,7,8,9) to the dispatch queue.

Think of it as applying deadlines to any type if i/o scheduler. The
fifo queue could essentially be tacked on to any type of other queue,
not just a plain sorted one.

> > Finally, I've done some testing on it. No testing on whether this really
> > works well in real life (that's what I want testers to do), and no
> > testing on benchmark performance changes etc. What I have done is
> > beat-up testing, making sure it works without corrupting your data.
> 
> I'll give it a whizz over the weekend.

Cool. I'd be interested in latency and throughput results at this point,
I have none of these. BTW, does anyone know of a good benchmark that
also cares about latency?

-- 
Jens Axboe

