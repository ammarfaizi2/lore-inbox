Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285120AbRLLJV2>; Wed, 12 Dec 2001 04:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285118AbRLLJVT>; Wed, 12 Dec 2001 04:21:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23334 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285117AbRLLJVK>; Wed, 12 Dec 2001 04:21:10 -0500
Date: Wed, 12 Dec 2001 10:21:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011212102141.Q4801@athlon.random>
In-Reply-To: <3C15B0B3.1399043B@zip.com.au> <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>, <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>; <20011211144634.F4801@athlon.random> <3C1718E1.C22141B3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C1718E1.C22141B3@zip.com.au>; from akpm@zip.com.au on Wed, Dec 12, 2001 at 12:44:17AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 12:44:17AM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Tue, Dec 11, 2001 at 11:32:25AM -0200, Rik van Riel wrote:
> > > On Mon, 10 Dec 2001, Andrew Morton wrote:
> > >
> > > > This test on a 64 megabyte machine, on ext2:
> > > >
> > > >     time (tar xfz /nfsserver/linux-2.4.16.tar.gz ; sync)
> > > >
> > > > On 2.4.17-pre7 it takes 21 seconds.  On -aa it is much slower: 36 seconds.
> > >
> > > > Execution time for `make -j12 bzImage' on a 64meg RAM/512 meg swap
> > > > dual x86:
> > > >
> > > > -aa:                                        4 minutes 20 seconds
> > > > 2.4.7-pre8                          4 minutes 8 seconds
> > > > 2.4.7-pre8 plus the below patch:    3 minutes 55 seconds
> > >
> > >
> > > Andrea, it seems -aa is not the holy grail VM-wise. If you want
> > 
> > it may be not a holy grail in swap benchmarks and flood of writes to
> > disk, those are minor performance regressions, but I have no one single
> > bug report related to "stability".
> 
> Your patch increases the time to untar a kernel tree by seventy five
> percent.  That's a fairly major minor regression.
> 
> > The only thing I got back from Andrew is been "it runs a little slower"
> > in those two tests.
> 
> The swapstorm I agree is uninteresting.  The slowdown with a heavy write
> load impacts a very common usage, and I've told you how to mostly fix
> it.  You need to back out the change to bdflush.

I guess i should drop the run_task_queue(&tq_disk) instead of replacing
it back with a wait_for_some_buffers().

> > and of course he didn't even attempted to benchmark the interactive
> > feeling that was the _whole_ point of my buffer.c and elevator changes.
> 
> As far as I know, at no point in time have you told anyone that
> this was an objective of your latest patch.  So of course I
> didn't test for it.
> 
> Interactivity is indeed improved.  It has gone from catastrophic to
> horrid.

:)

> 
> There are four basic tests I use to quantify this, all with 64 megs of
> memory:
> 
> 1: Start a continuous write, and on a different partition, time how
>    long it takes to read a 16 megabyte file.
> 
>    Here, -aa takes 40 seconds.  Stock 2.4.17-pre8 takes 71 seconds.
>    2.4.17-pre8 with the same elevator settings as in -aa takes
>    40 seconds.
> 
>    Large writes are slowing reads by a factor of 100.
> 
> 2: Start a continuous write and, from another machine, run
> 
> 	time ssh -X otherhost xterm -e true
> 
>    On -aa this takes 68 seconds.  On 2.4.17-pre8 it takes over
>    three minutes.  I got bored and killed it.  The problem can't
>    be fixed on 2.4.17-pre8 with tuning - it's probably due to the
>    poor page replacement - stuff is getting swapped out.  This is
>    a significant problem in 2.4.17-pre and we need a fix for it.
> 
> 3: Run `cp -a linux/ junk'.  Time how long it takes to read a 16 meg file.
> 
>    There's no appreciable difference between any of the kernels here.
>    It varies from 2 seconds to 10, and is generally OK.
> 
> 4:  Run `cp -a linux/ junk'.  time ssh -X otherhost xterm -e true
> 
>    Varies between three and five seconds, depending on elvtune settings.
>    No noticeable difference between any kernels.
> 
> It's tests 1 and 2 which are interesting, because we perform so
> very badly.  And no amount of fiddling buffer.c or elvtune settings
> is going to fix it, because they don't address the core problem.
> 
> Which is: when the elevator can't merge a read it sticks it at the
> end of the request queue, behind all the writes.
> 
> I'll be submitting a little patch for 2.4.18-pre which allows the user
> to tunably promote reads ahead of most of the writes.  It improves
> tests 1 and 2 by a factor of eight to twelve.

Note that the first elevator (not elevator_linus) could handle this
case, however it was too complicated and I'm been told it was hurting
too much the performance of things like dbench etc.. But it was allowing
you to take a few seconds for your test number 2 for example. Quite
frankly all my benchmark were latency oriented, but I couldn't notice
an huge drop of performance, but OTOH at that time my test box had a
10mbyte/sec HD, and I know for experience that on such HD numbers tends
to be very different than on fast SCSI and my current test hd IDE
33mbyte/sec so I think they were right.

> > So as far as I'm concerned 2.4.15aa1 and 2.4.17pre?aa? are just rock
> > solid and usable in production.
> 
> I haven't done much stability testing - without a description of what the
> changes are trying to do, I can't test them - all I could do is blindly
> run stress tests and I'm sure your QA team can do that as well as I,
> on bigger boxes.
> 
> But I don't doubt that it's stable.   However Red Hat's QA guys are
> pretty good at knocking kernels over...
> 
> gargh.  Ninety seconds of bash-shared-mapping and I get "end-request:
> buffer-list destroyed" against the swap device.  Borked IDE driver.
> Seems stable on SCSI.
> 
> The -aa VM is still a little prone to tossing out "0-order allocation
> failures" when there's tons of swap available and when much memory
> is freeable by dropping or writing back to shared mappings.  But
> this doesn't seem to cause any problems, as long as there's some
> memory available for atomic allocations, and I never saw free
> memory go below 800 kbytes...

It mostly tends to fail on the GFP_NOIO and friends, where it cannot
block and I believe that's correct, looping forever inside the allocator
can only lead to deadlocks. Those GFP_NOIO users have loops outside the
allocator if required.

A failure means that unless somebody else does something for us, we
couldn't allocate anything. Thus SCHED_YIELD and try again.

> > We'll keep doing background benchmarking and changes that cannot
> > affect stability, but the core design is finished as far I can tell.
> 
> We'll know when it gets wider testing in the runup to 2.4.18.  The
> fact that I found a major (although easily fixed) performance problem
> in the first ten minutes indicates that caution is needed, yes?

I consider that minor tuning (as you said removing the run_task_queue()
in bdflush may be enough to cure the tar xzf, I will make some test).

> What's the thinking with the changes to dcache/icache flushing?
> A single d/icache entry can save three seeks, which is _enormous_ value for
> just a few hundred bytes of memory.  You appear to be shrinking the i/dcache
> by 12% each time you try to swap out or evict 32 pages.   What this means

yes.

> is that as soon we start to get a bit short on memory, the i/dcache vanishes.
> And it takes ages to read that stuff back in.  How did you test this?  Without
> having done (or even devised) any quantitative testing myself, I have a gut
> feel that we need to preserve the i/dcache (versus file data) much more than
> this.

The problem is the zone-normal, if we fail to shrink the cache we _must_
shrink the dcache/icache as well to be correct (at the very least if the
classzone is < ZONE_HIGHMEM). Otherwise zone normal/dma allocations can
fail forever and you won't be able to fork a new task any longer. I
tested this with a ZONE_NORMAL of 1/2 mbytes with highmem emulation. Of
course this makes the problem reproducible trivially but it could happen
on larger boxes as well at least in theory, and I want to cover all the
cases as best as I can.

> Oh.  Maybe the core design (whatever it is :)) is not finished,
> because it retains the bone-headed, dumb-to-the-point-of-astonishing
> misfeature which Linux VM has always had:
> 
> If someone is linearly writing (or reading) a gigabyte file on a 64
> megabyte box they *don't* want the VM to evict every last little scrap
> of cache on behalf of data which they *obviously* do not want
> cached.

The current design tries to detect this, at least much much better than
2.2. This is why I disagree with Rik's patch of yesterday.  detecting
cache pollution is good also on the lowmem boxes (not only for DB).

> It's good that -aa VM doesn't summarily dump the i/dcache and plonk
> everything you want into swap when this happens.  Progress.
> 
> 
> So. To summarise.
> 
> - Your attempt to address read latencies didn't work out, and should
>   be dropped (hopefully Marcelo and Jens are OK with an elevator hack :))

It should not be dropped. And it's not an hack, I only enabled the code
that was basically disabled due the huge numbers. It will work as 2.2.20.

Now what you want to add is an hack to move the read at the top of the
request_queue and if you go back to 2.3.5x you'll see I was doing this,
that's the first thing I did while playing with the elevator. And
latency-wise it was working great. I'm sure somebody remebers the kind
of latency you could get with such an elevator.

Then I got flames from Linus and Ingo claiming that I screwedup the
elevator and that I was the source of the 2.3.x bad I/O performance and
so they required to nearly rewrite the elevator in a way that was
obvious that couldn't hurt the benchmarks and so Jens dropped part of my
latency-capable elevator and he did the elevator_linus that of course
cannot hurt performance of benchmarks, but that has the usual problem
you need to wait 1 minute for xterm to be stared under a write flood.

However my object was to avoid nearly infinite starvation and the
elevator_linus avoids it (you can start the xterm it in 1 minute,
previously in early 2.3 and 2.2 you'd need to wait for the disk to be
full, and that could take some day with some terabyte of data). So I was
pretty much fine with elevator_linus too but we very well known reads
would be starved again significantly (even if not indefinitely).

Many thanks for the help!!

Andrea
