Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTBTM7E>; Thu, 20 Feb 2003 07:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTBTM7E>; Thu, 20 Feb 2003 07:59:04 -0500
Received: from [195.223.140.107] ([195.223.140.107]:6018 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265637AbTBTM7A>;
	Thu, 20 Feb 2003 07:59:00 -0500
Date: Thu, 20 Feb 2003 14:08:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030220130858.GI31480@x30.school.suse.de>
References: <20030219171432.A6059@smp.colors.kwc> <20030219180523.GK14633@x30.suse.de> <20030220124026.GA4051@lilith.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220124026.GA4051@lilith.homenet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 01:40:27PM +0100, Dejan Muhamedagic wrote:
> Andrea,
> 
> On Wed, Feb 19, 2003 at 07:05:24PM +0100, Andrea Arcangeli wrote:
> > On Wed, Feb 19, 2003 at 05:14:32PM +0100, Dejan Muhamedagic wrote:
> > > 
> > > Both servers swap constantly, but the 2.4.20aa1 at a 10-fold
> > > higher rate.  OTOH, there should be enough memory for
> > > everything.  It seems like both VMs have preference for
> > > cache.  Is it possible to reduce the amount of memory used
> > > for cache?
> > 
> > yes:
> > 
> > 	echo 1000 >/proc/sys/vm/vm_mapped_ratio
> > 
> > this controls how hard the vm will try to shrink the cache before
> > starting swapping/unmapping activities.
> 
> Today the swapping rate went up compared to yesterday.  So much
> that it made a serious impact on performance.  The server has been
> up for four days and the more the time passes the less it is
> capable of handling the load.  I tried changing the
> vm_mapped_ratio as you suggested, but the cache use is still very
> high:
> 
> Cached:        2292156 kB
> SwapCached:    2770440 kB
> 
> I must ask for an explanation of the latter item.  Is that swap
> being cached?  If so, why?  AFAIK, if a page is swapped out and

cache is the filesystem cache, all your program images, the whole SHM
area used by sap and the swap can be cached too, so the shm memory can
showup both as cache as swap and as swacache at the same time, probably
you've plenty of swap so there's no need to reclaim shm and anonymous
pages from the swap space, this allows you to do zero-IO cost swapouts
of clean swapcache pages for example which is relevant in a scenario
like this.

> later (soon) referenced again then the system is in a need of more
> memory or the VM didn't predict well.  The latter case should occur
> infrequently.  In the former no clever piece of software would help
> anyway.  So, why cache swap?

primarly beause this way if you don't modify it, the next time you need
to swap it to disk it will be zero I/O cost. Secondly because for
various consistency reason (especially with directio) we must be able to
mark swap cache dirty (and let the vm to collect it away, like we do
with the non-swap cache), and being able to mark swapcache dirty (rather
than reclaiming it from the swapcache by the time you write to it) is
helpful also to try to avoid fragmenting the swap too (so we allocate
the swap space only once and we keep overwriting in the same place).

After half ot the swap is full, the -aa vm stops caching the swap
aggressively because then the priority becomes not running out of
virtual memory, not anymore to swapout as fast as we possibly can.

One of the reason the performance may slowdown over time is also swap
fragmentation, the dirty cache will try to avoid it but it still can
happen and we don't defragment it aggressively. If you had enough memory
for it, it would be interesting if performance returns fine after a
swapoff -a/swapon -a (but I think you don't have enough ram and the
swapoff would lead to either killing tasks or swapoff failure). However
you should be able to verify that the performance returns at its peak
after a restart cycle of the app server. This almost guarantees the
kernel is doing fine.

> 
> elvtune gives:
> 
> /dev/sda elevator ID            2
>         read_latency:           128
>         write_latency:          512
>         max_bomb_segments:      0
> 
> Which seems fine to me.  Anyway, with this much swapping (100-800Kpps)
> it won't help.  I'll do some testing later with file transfer.

the elvtune suggestion was intended only for the file transfer. Just to
give it a spin you can try with a -r 10 (just to see if you notice any
difference).

But really you need to upgrade to pre4aa3 where I improved some bits in
elevator-lowlatency before testing again the file transfer stalling
behaviour.

> > 2.4.21pre4aa3 has also extreme scalability optimizations that generates
> > three digits percent improvements on some hardware, however those won't
> > help latency directly. These optimizations will also change partly when
> > the vm starts swapping, and it will defer the "swap" point somehow, this
> > new behaviour (besides the greatly improved scalability) is also
> > beneficial to very shm-userspace-cache intensive apps.
> 
> It is exactly the case here:
> 
> # df /dev/shm
> Filesystem           1k-blocks      Used Available Use% Mounted on
> shmfs                 16384000   5798364  10585636  36% /dev/shm

Yep I expected a scenario like this ;)

> 
> > You can revert to
> > the non-scalable behaviour (but possibly more desiderable on small
> > desktop/laptops) by using echo 1 >/proc/sys/vm/vm_anon_lru. You should
> > also try 'echo 1 >/proc/sys/vm/vm_anon_lru' if you see the VM isn't
> > swapping well enough and that it shrinks too much cache after upgrading
> > to 2.4.21pre4aa3.
> 
> I hope I will be able to give this one a try.

btw, be careful with the vm_mapped_ratio, 1000 may be too much if you
really need to swap a lot to get good performance. It is possible the
100 value by default is optimal for your workload.

Also remeber that if pushed at the maximum the vm will be forced to run
at the speed of the disk no matter how much the VM is good, there is an
hardware disk limit in how fast it can swap and behave. however the good
VM will run as worse at the speed-of-the-disk-during-seeks and never
much slower of what the disk can deliver during some seeking.

> 
> > Thanks for the interesting feedback!
> 
> Thank you for your input.

You're very welcome!

Andrea
