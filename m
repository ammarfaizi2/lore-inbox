Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267603AbSLFFkX>; Fri, 6 Dec 2002 00:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267604AbSLFFkX>; Fri, 6 Dec 2002 00:40:23 -0500
Received: from [195.223.140.107] ([195.223.140.107]:61569 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267603AbSLFFkW>;
	Fri, 6 Dec 2002 00:40:22 -0500
Date: Fri, 6 Dec 2002 06:48:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206054804.GK1567@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF034BB.D5F863B5@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 09:25:15PM -0800, Andrew Morton wrote:
> William Lee Irwin III wrote:
> > 
> > Yes, it's necessary; no, I've never directly encountered the issue it
> > fixes. Sorry about the miscommunication there.
> 
> The google thing.
> 
> The basic problem is in allowing allocations which _could_ use
> highmem to use the normal zone as anon memory or pagecache.
> 
> Because the app could mlock that memory.   So for a simple
> demonstration:
> 
> - mem=2G
> - read a 1.2G file
> - malloc 800M, now mlock it.
> 
> Those 800M will be in ZONE_NORMAL, simply because that was where the
> free memory was.  And you're dead, even though you've only mlocked
> 800M.  The same thing happens if you have lots of anon memory in the
> normal zone and there is no swapspace available.
> 
> Linus's approach was to raise the ZONE_NORMAL pages_min limit for
> allocations which _could_ use highmem.  So a GFP_HIGHUSER allocation
> has a pages_min limit of (say) 4M when considering the normal zone,
> but a GFP_KERNEL allocation has a limit of 2M.
> 
> Andrea's patch does the same thing, via a separate table.   He has
> set the threshold much higher (100M on a 4G box).   AFAICT, the
> algorithms are identical - I was planning on just adding a multiplier
> to set Linus's ratio - it is currently hardwired to "1".   Search for 
> "mysterious" in mm/page_alloc.c ;)
> 
> It's not clear to me why -aa defaults to 100 megs when the problem
> only occurs with no swap or when the app is using mlock.  The default
> multiplier (of variable local_min) should be zero.  Swapless machines
> or heavy mlock users can crank it up.
> 
> But mlocking 700M on a 4G box would kill it as well.  The google
> application, IIRC, mlocks 1G on a 2G machine.  Daniel put them
> onto the 2G+2G split and all was well.
> 
> Anyway, thanks.   I'll take another look at Andrea's implementation.

you should because it seems you didn't realize how my code works. the
algorithm is autotuned at boot and depends on the zone sizes, and it
applies to the dma zone too with respect to the normal zone, the highmem
case is just one of the cases that the fix for the general problem
resolves, and you're totally wrong saying that mlocking 700m on a 4G box
could kill it. I call it the per-claszone point of view watermark. If
you are capable of highmem (mlock users are) you must left 100M or 10M
or 10G free on the normal zone (depends on the watermark setting tuned
at boot that is calculated in function of the zone sizes) etc... so it
doesn't matter if you mlock 700M or 700G, it can't kill it. The split
doesn't matter at all. 2.5 misses this important fix too btw.

If you ignore this bugfix people will notice and there's no other way
to fix it completely (unless you want to drop the zone-normal and
zone-dma enterely, actually zone-dma matters much less because even if
it exists basically nobody uses it).

> 
> Now, regarding mlock(mmap(open(/dev/hda1))) ;)


Andrea
