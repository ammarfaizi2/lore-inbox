Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTBTXxX>; Thu, 20 Feb 2003 18:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbTBTXxX>; Thu, 20 Feb 2003 18:53:23 -0500
Received: from octopussy.utanet.at ([213.90.36.45]:9680 "EHLO
	octopussy.utanet.at") by vger.kernel.org with ESMTP
	id <S267175AbTBTXxV>; Thu, 20 Feb 2003 18:53:21 -0500
Date: Fri, 21 Feb 2003 01:03:22 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030221000322.GA8096@lilith.homenet>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
References: <20030219171432.A6059@smp.colors.kwc> <20030219180523.GK14633@x30.suse.de> <20030220124026.GA4051@lilith.homenet> <20030220130858.GI31480@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220130858.GI31480@x30.school.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

On Thu, Feb 20, 2003 at 02:08:58PM +0100, Andrea Arcangeli wrote:
> On Thu, Feb 20, 2003 at 01:40:27PM +0100, Dejan Muhamedagic wrote:
> > 
> > Today the swapping rate went up compared to yesterday.  So much
> > that it made a serious impact on performance.  The server has been
> > up for four days and the more the time passes the less it is
> > capable of handling the load.  I tried changing the
> > vm_mapped_ratio as you suggested, but the cache use is still very
> > high:
> > 
> > Cached:        2292156 kB
> > SwapCached:    2770440 kB
> > 
> > I must ask for an explanation of the latter item.  Is that swap
> > being cached?  If so, why?  AFAIK, if a page is swapped out and
> 
> cache is the filesystem cache, all your program images, the whole SHM
> area used by sap and the swap can be cached too, so the shm memory can
> showup both as cache as swap and as swacache at the same time, probably
> you've plenty of swap so there's no need to reclaim shm and anonymous
> pages from the swap space, this allows you to do zero-IO cost swapouts
> of clean swapcache pages for example which is relevant in a scenario
> like this.
>
> > later (soon) referenced again then the system is in a need of more
> > memory or the VM didn't predict well.  The latter case should occur
> > infrequently.  In the former no clever piece of software would help
> > anyway.  So, why cache swap?
> 
> primarly beause this way if you don't modify it, the next time you need
> to swap it to disk it will be zero I/O cost. Secondly because for
> various consistency reason (especially with directio) we must be able to
> mark swap cache dirty (and let the vm to collect it away, like we do
> with the non-swap cache), and being able to mark swapcache dirty (rather
> than reclaiming it from the swapcache by the time you write to it) is
> helpful also to try to avoid fragmenting the swap too (so we allocate
> the swap space only once and we keep overwriting in the same place).

I guess that I don't understand the vm so please forgive my
ignorance and bear with me.  I can't see why would a page be
swapped out and then cached.  In other words, why would caching be
preferred.  Of course, if a page stays for a "long" time
untouched, then it is desirable to use that space for caching
purposes.  However, this VM seems to like swapping a bit too much.

> After half ot the swap is full, the -aa vm stops caching the swap
> aggressively because then the priority becomes not running out of
> virtual memory, not anymore to swapout as fast as we possibly can.

I'm not sure if it's wise to base decisions on the swap size.
Swap size is commonly thought of as a VM fuse.  Often people don't
think a lot how much space to reserve for swap.  In many places it
is recommended to allocate three times the memory size for
swapping.  In that case a half full swap would seem like trouble.

> One of the reason the performance may slowdown over time is also swap
> fragmentation, the dirty cache will try to avoid it but it still can
> happen and we don't defragment it aggressively. If you had enough memory
> for it, it would be interesting if performance returns fine after a
> swapoff -a/swapon -a (but I think you don't have enough ram and the
> swapoff would lead to either killing tasks or swapoff failure). However
> you should be able to verify that the performance returns at its peak
> after a restart cycle of the app server. This almost guarantees the
> kernel is doing fine.

I'd disagree here.  The system _should_ be able to keep stability
without resetting.  If it can't, then there's something wrong.
Unfortunately, in this case, the performance deteriorates over
time.  The server goes through a cycle of heavy use during working
hours and a relative peace during the evening.  However, the
amount of swapping increases every day.  BTW, swapin prevails by
two or three times.  Today it ended up in swapping in around 3000
Kpps almost continuosly.

[snipped part about the elevator;  more on that in another post
and with the new kernel]

> Also remeber that if pushed at the maximum the vm will be forced to run
> at the speed of the disk no matter how much the VM is good, there is an
> hardware disk limit in how fast it can swap and behave. however the good
> VM will run as worse at the speed-of-the-disk-during-seeks and never
> much slower of what the disk can deliver during some seeking.

Yes, but I don't have a feeling that the memory is overcommitted.
I can't prove that(1), but the other app server handles the load
much better.  The two should each be given a fair share of work,
though load balancing is never perfect.  The other server is
swapping too, but on the order of magnitude less, and, more
important, it exhibits the same behaviour every day.  Finally, the
AIX server, equipped with the same amount of memory, swaps a
couple of pages a few times a day.

(1)  Summing up the RSS column of "ps aux" yields incredible 21GB.
Could one calculate used_mem - bufs - cached + used_swap ?

Sorry for such a long post.  I hope to come back with some data on
the 2.4.21 kernel next week.

Cheers!

Dejan
