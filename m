Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTBUK6X>; Fri, 21 Feb 2003 05:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTBUK6X>; Fri, 21 Feb 2003 05:58:23 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:46469 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267281AbTBUK6W>;
	Fri, 21 Feb 2003 05:58:22 -0500
Date: Fri, 21 Feb 2003 12:08:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030221110807.GQ31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com> <20030221103140.GN31480@x30.school.suse.de> <20030221105146.GA10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221105146.GA10411@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 02:51:46AM -0800, William Lee Irwin III wrote:
> On Fri, Feb 21, 2003 at 12:16:24AM -0800, Andrew Morton wrote:
> >> Well 2.4 is unreponsive period.  That's due to problems in the VM -
> >> processes which are trying to allocate memory get continually DoS'ed
> >> by `cp' in page reclaim.
> 
> On Fri, Feb 21, 2003 at 11:31:40AM +0100, Andrea Arcangeli wrote:
> > this depends on the workload, you may not have that many allocations,
> > a echo 1 >/proc/sys/vm/bdflush will fix it shall your workload be hurted
> > by too much dirty cache. Furthmore elevator-lowlatency makes
> > the blkdev layer much more fair under load.
> 
> Restricting io in flight doesn't actually repair the issues raised by

the amount of I/O that we allow in flight is purerly random, there is no
point to allow several dozen mbytes of I/O in flight on a 64M machine,
my patch fixes that and nothing more.

> it, but rather avoids them by limiting functionality.

If you can show a (throughput) benchmark where you see this limited
functionalty I'd be very interested.

Alternatively I can also claim that 2.4 and 2.5 are limiting
functionalty too by limiting the I/O in flight to some hundred megabytes
right?

it's like a dma ring buffer size of a soundcard, if you want low latency
it has to be small, it's as simple as that. It's a tradeoff between
latency and performance, but the point here is that apparently you gain
nothing with such an huge amount of I/O in flight. This has nothing to
do with the number of requests, the requests have to be a lot, or seeks
won't be reordered aggressively, but when everything merges using all
the requests is pointless and it only has the effect of locking
everything in ram, and this screw the write throttling too, because we
do write throttling on the dirty stuff, not on the locked stuff, and
this is what elevator-lowlatency address.

You may argue on the amount of in flight I/O limit I choosen, but really
the default in mainlines looks overkill to me for generic hardware.

> The issue raised here is streaming io competing with processes working
> within bounded memory. It's unclear to me how 2.5.x mitigates this but
> the effects are far less drastic there. The "fix" you're suggesting is
> clamping off the entire machine's io just to contain the working set of

show me this claimping off please. take 2.4.21pre4aa3 and trash it
compared to 2.4.21pre4 with the minimum 32M queue, I'd be very
interested, if I've a problem I must fix it ASAP, but all the benchmarks
are in green so far and the behaviour was very bad before these fixes,
go ahead and show me red and you'll make me a big favour. Either that or
you're wrong that I'm claimping off anything.

Just to be clear, this whole thing has nothing to do with the elevator,
or the CFQ or whatever, it only is related to the worthwhile amount of
in flight I/O to keep the disk always running.

> a single process that generates unbounded amounts of dirty data and
> inadvertently penalizes other processes via page reclaim, where instead
> it should be forced to fairly wait its turn for memory.
> 
> -- wli


Andrea
