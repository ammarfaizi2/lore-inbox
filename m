Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285097AbRLLIp1>; Wed, 12 Dec 2001 03:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285098AbRLLIpS>; Wed, 12 Dec 2001 03:45:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:7181 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285097AbRLLIpI>; Wed, 12 Dec 2001 03:45:08 -0500
Message-ID: <3C1718E1.C22141B3@zip.com.au>
Date: Wed, 12 Dec 2001 00:44:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <3C15B0B3.1399043B@zip.com.au> <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>,
		<Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Dec 11, 2001 at 11:32:25AM -0200 <20011211144634.F4801@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Tue, Dec 11, 2001 at 11:32:25AM -0200, Rik van Riel wrote:
> > On Mon, 10 Dec 2001, Andrew Morton wrote:
> >
> > > This test on a 64 megabyte machine, on ext2:
> > >
> > >     time (tar xfz /nfsserver/linux-2.4.16.tar.gz ; sync)
> > >
> > > On 2.4.17-pre7 it takes 21 seconds.  On -aa it is much slower: 36 seconds.
> >
> > > Execution time for `make -j12 bzImage' on a 64meg RAM/512 meg swap
> > > dual x86:
> > >
> > > -aa:                                        4 minutes 20 seconds
> > > 2.4.7-pre8                          4 minutes 8 seconds
> > > 2.4.7-pre8 plus the below patch:    3 minutes 55 seconds
> >
> >
> > Andrea, it seems -aa is not the holy grail VM-wise. If you want
> 
> it may be not a holy grail in swap benchmarks and flood of writes to
> disk, those are minor performance regressions, but I have no one single
> bug report related to "stability".

Your patch increases the time to untar a kernel tree by seventy five
percent.  That's a fairly major minor regression.

> The only thing I got back from Andrew is been "it runs a little slower"
> in those two tests.

The swapstorm I agree is uninteresting.  The slowdown with a heavy write
load impacts a very common usage, and I've told you how to mostly fix
it.  You need to back out the change to bdflush.
 
> and of course he didn't even attempted to benchmark the interactive
> feeling that was the _whole_ point of my buffer.c and elevator changes.

As far as I know, at no point in time have you told anyone that
this was an objective of your latest patch.  So of course I
didn't test for it.

Interactivity is indeed improved.  It has gone from catastrophic to
horrid.

There are four basic tests I use to quantify this, all with 64 megs of
memory:

1: Start a continuous write, and on a different partition, time how
   long it takes to read a 16 megabyte file.

   Here, -aa takes 40 seconds.  Stock 2.4.17-pre8 takes 71 seconds.
   2.4.17-pre8 with the same elevator settings as in -aa takes
   40 seconds.

   Large writes are slowing reads by a factor of 100.

2: Start a continuous write and, from another machine, run

	time ssh -X otherhost xterm -e true

   On -aa this takes 68 seconds.  On 2.4.17-pre8 it takes over
   three minutes.  I got bored and killed it.  The problem can't
   be fixed on 2.4.17-pre8 with tuning - it's probably due to the
   poor page replacement - stuff is getting swapped out.  This is
   a significant problem in 2.4.17-pre and we need a fix for it.

3: Run `cp -a linux/ junk'.  Time how long it takes to read a 16 meg file.

   There's no appreciable difference between any of the kernels here.
   It varies from 2 seconds to 10, and is generally OK.

4:  Run `cp -a linux/ junk'.  time ssh -X otherhost xterm -e true

   Varies between three and five seconds, depending on elvtune settings.
   No noticeable difference between any kernels.

It's tests 1 and 2 which are interesting, because we perform so
very badly.  And no amount of fiddling buffer.c or elvtune settings
is going to fix it, because they don't address the core problem.

Which is: when the elevator can't merge a read it sticks it at the
end of the request queue, behind all the writes.

I'll be submitting a little patch for 2.4.18-pre which allows the user
to tunably promote reads ahead of most of the writes.  It improves
tests 1 and 2 by a factor of eight to twelve.

> So as far as I'm concerned 2.4.15aa1 and 2.4.17pre?aa? are just rock
> solid and usable in production.

I haven't done much stability testing - without a description of what the
changes are trying to do, I can't test them - all I could do is blindly
run stress tests and I'm sure your QA team can do that as well as I,
on bigger boxes.

But I don't doubt that it's stable.   However Red Hat's QA guys are
pretty good at knocking kernels over...

gargh.  Ninety seconds of bash-shared-mapping and I get "end-request:
buffer-list destroyed" against the swap device.  Borked IDE driver.
Seems stable on SCSI.

The -aa VM is still a little prone to tossing out "0-order allocation
failures" when there's tons of swap available and when much memory
is freeable by dropping or writing back to shared mappings.  But
this doesn't seem to cause any problems, as long as there's some
memory available for atomic allocations, and I never saw free
memory go below 800 kbytes...

> We'll keep doing background benchmarking and changes that cannot
> affect stability, but the core design is finished as far I can tell.

We'll know when it gets wider testing in the runup to 2.4.18.  The
fact that I found a major (although easily fixed) performance problem
in the first ten minutes indicates that caution is needed, yes?

What's the thinking with the changes to dcache/icache flushing?
A single d/icache entry can save three seeks, which is _enormous_ value for
just a few hundred bytes of memory.  You appear to be shrinking the i/dcache
by 12% each time you try to swap out or evict 32 pages.   What this means
is that as soon we start to get a bit short on memory, the i/dcache vanishes.
And it takes ages to read that stuff back in.  How did you test this?  Without
having done (or even devised) any quantitative testing myself, I have a gut
feel that we need to preserve the i/dcache (versus file data) much more than
this.



Oh.  Maybe the core design (whatever it is :)) is not finished,
because it retains the bone-headed, dumb-to-the-point-of-astonishing
misfeature which Linux VM has always had:

If someone is linearly writing (or reading) a gigabyte file on a 64
megabyte box they *don't* want the VM to evict every last little scrap
of cache on behalf of data which they *obviously* do not want
cached.

It's good that -aa VM doesn't summarily dump the i/dcache and plonk
everything you want into swap when this happens.  Progress.


So. To summarise.

- Your attempt to address read latencies didn't work out, and should
  be dropped (hopefully Marcelo and Jens are OK with an elevator hack :))

- We urgently need a fix for 2.4.17's page replacement problems.  
 
- aa is good.  Believe it or not, I like it. The mm/* portions fix
  significant performance problems in our current VM.  I guess we
  should bite the bullet and merge it all in 2.4.18-pre

-
