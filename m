Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbTBUM2h>; Fri, 21 Feb 2003 07:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbTBUM2h>; Fri, 21 Feb 2003 07:28:37 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:50309 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267418AbTBUM2e>;
	Fri, 21 Feb 2003 07:28:34 -0500
Date: Fri, 21 Feb 2003 13:38:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030221123821.GT31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com> <20030221103140.GN31480@x30.school.suse.de> <20030221105146.GA10411@holomorphy.com> <20030221110807.GQ31480@x30.school.suse.de> <20030221113436.GB10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221113436.GB10411@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 03:34:36AM -0800, William Lee Irwin III wrote:
> On Fri, Feb 21, 2003 at 02:51:46AM -0800, William Lee Irwin III wrote:
> >> Restricting io in flight doesn't actually repair the issues raised by
> 
> On Fri, Feb 21, 2003 at 12:08:07PM +0100, Andrea Arcangeli wrote:
> > the amount of I/O that we allow in flight is purerly random, there is no
> > point to allow several dozen mbytes of I/O in flight on a 64M machine,
> > my patch fixes that and nothing more.
> 
> I was arguing against having any preset limit whatsoever.

the preset limit exists in every linux kernel out there.  It should be
mandated by the lowlevel device driver, I don't allow that yet, but it
should be trivial to extend with just an additional per-queue int, it's
just an implementation matter.

> On Fri, Feb 21, 2003 at 02:51:46AM -0800, William Lee Irwin III wrote:
> >> it, but rather avoids them by limiting functionality.
> 
> On Fri, Feb 21, 2003 at 12:08:07PM +0100, Andrea Arcangeli wrote:
> > If you can show a (throughput) benchmark where you see this limited
> > functionalty I'd be very interested.
> > Alternatively I can also claim that 2.4 and 2.5 are limiting
> > functionalty too by limiting the I/O in flight to some hundred megabytes
> > right?
> 
> This has nothing to do with benchmarks.

it has to, you claimed I limited functionalty, if you can't measure it
in any way (or at least demonstrate it with math), it doesn't exist.

> Counterexample: suppose the process generating dirty data is the only
> one running. The machine's effective RAM capacity is then limited to
> the dirty data limit plus some small constant by this io in flight
> limitation.

only the free memory and cache is accounted here, while this task allocates
ram with malloc, the amount of dirty ram will be reduced accordingly,
what you said is far from reality. We aren't 100% accurate in the cache
level accounting true, but we're 100% accurate in the anonymous memory
accounting.

> This functionality is not to be dismissed lightly: changing the /proc/
> business is root-only, hence it may not be within the power of a victim
> of a poor setting to adjust it.
> 
> 
> On Fri, Feb 21, 2003 at 12:08:07PM +0100, Andrea Arcangeli wrote:
> > it's like a dma ring buffer size of a soundcard, if you want low latency
> > it has to be small, it's as simple as that. It's a tradeoff between
> > latency and performance, but the point here is that apparently you gain
> > nothing with such an huge amount of I/O in flight. This has nothing to
> > do with the number of requests, the requests have to be a lot, or seeks
> > won't be reordered aggressively, but when everything merges using all
> > the requests is pointless and it only has the effect of locking
> > everything in ram, and this screw the write throttling too, because we
> > do write throttling on the dirty stuff, not on the locked stuff, and
> > this is what elevator-lowlatency address.
> > You may argue on the amount of in flight I/O limit I choosen, but really
> > the default in mainlines looks overkill to me for generic hardware.
> 
> It's not a question of gain but rather immunity to reconfigurations.

You mean immunity of reconfigurations of machines with more than 4G of
ram maybe, and you are ok to ignore completely the latency effects of
the overkill queue size. Everything smaller can be affected by it not
only in terms of latency effect. Especially if you have multiple spindle
that literally multiply the fixed max amount of in flight I/O.

> Redoing it for all the hardware raises a tuning issue, and in truth
> all I've ever wound up doing is turning it off because I've got so
> much RAM that various benchmarks could literally be done in-core as a
> first pass, then sorted, then sprayed out to disk in block-order. And
> a bunch of open benchmarks are basically just in-core spinlock exercise.
> (Ignore the fact there was a benchmark mentioned.)
> 
> Amortizing seeks and incrementally sorting and so on generally require
> large buffers, and if you have the RAM, the kernel should use it.
> 
> But more seriously, global io in flight limits are truly worthless, if
> anything it should be per-process, but even that's inadequate as it

This doesn't make any sense, the limit alwyas exists, it has to, if you
drop it the machine will die deadlocking in a few milliseconds, the
whole plugging and write throttling logic that completely drives the
whole I/O subsystem totally depends on a limit on the in flight I/O.

> requires retuning for varying io speeds. Limit enforcement needs to be
> (1) localized
> (2) self-tuned via block layer feedback
> 
> If I understand the code properly, 2.5.x has (2) but not (1).

2.5 has the unplugging logic so it definitely has an high limit of in
flight I/O too, no matter what elevator or whatever, w/o the fixed limit
2.5 will die too like any other linux kernel out there I have ever seen.

> 
> On Fri, Feb 21, 2003 at 02:51:46AM -0800, William Lee Irwin III wrote:
> >> The issue raised here is streaming io competing with processes working
> >> within bounded memory. It's unclear to me how 2.5.x mitigates this but
> >> the effects are far less drastic there. The "fix" you're suggesting is
> >> clamping off the entire machine's io just to contain the working set of
> 
> On Fri, Feb 21, 2003 at 12:08:07PM +0100, Andrea Arcangeli wrote:
> > show me this claimping off please. take 2.4.21pre4aa3 and trash it
> > compared to 2.4.21pre4 with the minimum 32M queue, I'd be very
> > interested, if I've a problem I must fix it ASAP, but all the benchmarks
> > are in green so far and the behaviour was very bad before these fixes,
> > go ahead and show me red and you'll make me a big favour. Either that or
> > you're wrong that I'm claimping off anything.
> > Just to be clear, this whole thing has nothing to do with the elevator,
> > or the CFQ or whatever, it only is related to the worthwhile amount of
> > in flight I/O to keep the disk always running.
> 
> You named the clamping off yourself. A dozen MB on a 64MB box, 32MB on
> 2.4.21pre4. Some limit that's a hard upper bound but resettable via a
> sysctl or /proc/ or something. Testing 2.4.x-based trees might be a
> little painful since I'd have to debug why 2.4.x stopped booting on my
> boxen, which would take me a bit far afield from my current hacking.

2.4.21pre4aa3 has to boot on it.

> On Fri, Feb 21, 2003 at 02:51:46AM -0800, William Lee Irwin III wrote:
> >> a single process that generates unbounded amounts of dirty data and
> >> inadvertently penalizes other processes via page reclaim, where instead
> >> it should be forced to fairly wait its turn for memory.
> 
> I believe I said something important here. =)

You're arguing about the async flushing heuristic that should be made
smarter instead of taking 50% of the freeable memory (not anonymous
memory). This isn't black and white stuff and you shouldn't mix issues,
it has nothing to do with the blkdev plugging logic driven by the limit
of in flight I/O (in every l-k out there ever).

> The reason why this _should_ be the case is because processes stealing
> from each other is the kind of mutual interference that leads to things
> like Mozilla taking ages to swap in because other things were running
> for a while and it wasn't and so on.
> 
> 
> -- wli


Andrea
