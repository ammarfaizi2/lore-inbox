Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310155AbSCAXGZ>; Fri, 1 Mar 2002 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310156AbSCAXGP>; Fri, 1 Mar 2002 18:06:15 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:40345 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310155AbSCAXGG>; Fri, 1 Mar 2002 18:06:06 -0500
Date: Fri, 1 Mar 2002 16:20:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301162016.A12413@vger.timpanogas.org>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7FE7DD.98121E87@zip.com.au>; from akpm@zip.com.au on Fri, Mar 01, 2002 at 12:43:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:43:09PM -0800, Andrew Morton wrote:
> "Jeff V. Merkey" wrote:
> > 
> > Linus/Alan/Linux,
> > 
> > Performance numbers can be increased dramatically (> 300 MB/S)
> > by increasing queue_nr_requests in ll_rw_blk.c on large RAID
> > controllers that are hosting a lot of drives.
> 
> I don't immediately see why increasing the queue length should
> increase bandwidth in this manner.  One possibility is that
> the shorter queue results in tasks sleeping in __get_request_wait
> more often, and the real problem is the "request starvation" thing.

This is the case.  We end up sleeping at with 8,000 buffer head requests
(4K block size) queued per adapter.  After I made the change and 
increased the size to 1024, this number increased to 17,000 
buffer heads queued per adapter.  Performance went up and processor
utilization went down.  

>From the profiling I ran, we were sleeping in __get_request_wait
far too much.  This value should be maintained on a per card 
basis and for RAID controllers that present a single virtual disk
for many physical disks (i.e. on 3Ware this number is 8), we should 
make the queue 8 X default.  I guess each driver would need to 
change this value based on how many actual drives were attached 
to the controller.  

> 
> The "request starvation" thing could conceivably result in more
> seeky behaviour.  In your kernel, disk writeouts come from
> two places:

This is not happening.  The elevator code is above this level and 
I am seeing the requests are ordered for the most part at this 
layer.

> 
> - Off the tail of the dirty buffer LRU
> 
> - Basically random guess, from the page LRU.

There are two senarios, one scenario is not using Linus' buffer cache
but a custom cache maintained between SCI nodes, another implementation
is using Linus' buffer cache.  We are seeing > 300 MB/S on the SCI 
cache.  

> 
> It's competition between these two writeout sources which causes
> decreased bandwidth - I've seen kernels in which ext2 writeback
> performance was down 40% due to this.
> 
> Anyway.   You definitely need to try 2.4.19-pre1.   Max sleep times
> in __get_request_wait will be improved, and it's possible that the
> bandwidth will improve.  Or not.  My gut feel is that it won't
> help.
> 

How about just increasing the value of queue_nr_requests or making 
it adapter specific?


> And yes, 128 requests is too few.  It used to be ~1000.  I think
> this change was made in a (misguided, unsuccessful) attempt to
> manage latency for readers.  The request queue is the only mechanism
> we have for realigning out-of-order requests and it needs to be
> larger so it can do this better. I've seen 15-25% throughput
> improvements from a 1024-slot request queue.


> 
> And if a return to a large request queue damages latency (it doesn't)
> then we need to fix that latency *without* damaging request merging.
> 
> First step: please test 2.4.19-pre1 or -pre2.  Also 2.4.19-pre1-ac2
> may provide some surprises..
> 

I will test, but unless this value is higher, I am skeptical I will see
the needed improvement.  The issue here is that it sleeps too much
and what's really happening and that we are forcing 8 disk drives
toshare 64/128 request buffers rather than provide each physical disk
with what it really needs.  


Jeff

> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
