Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319072AbSH2ChF>; Wed, 28 Aug 2002 22:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319079AbSH2ChF>; Wed, 28 Aug 2002 22:37:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319072AbSH2ChE>;
	Wed, 28 Aug 2002 22:37:04 -0400
Message-ID: <3D6D8C88.BD4180CF@zip.com.au>
Date: Wed, 28 Aug 2002 19:52:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
References: <3D6D82A3.A3A0C7F0@zip.com.au> <Pine.LNX.4.44L.0208282306110.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 28 Aug 2002, Andrew Morton wrote:
> > Rik van Riel wrote:
> > >
> > > On Wed, 28 Aug 2002, Andrew Morton wrote:
> > >
> > > > But sigh.  Pointlessly scanning zillions of dirty pages and doing
> > > > nothing with them is dumb.  So much better to go for a FIFO snooze on a
> > > > per-zone waitqueue, be woken when some memory has been cleansed.
> > >
> > > But not per-zone, since many (most?) allocations can be satisfied
> > > from multiple zones.  Guess what 2.4-rmap has had for ages ?
> >
> > Per-classzone ;)
> 
> I pull the NUMA-fallback card ;)

Ah, but you can never satisfy a NUMA person.

> But serious, having one waitqueue for this case should be
> fine. If the system is not under lots of VM pressure with
> tons of dirty pages, kswapd will free pages as fast as
> they get allocated.
> 
> If the system can't keep up and we have to wait for dirty
> page writeout to finish before we can allocate more, it
> shouldn't really matter how many waitqueues we have.
> Except for the fact that having a more complex system can
> introduce more opportunities for unfairness and starvation.

Sure.  We have this lovely fast wakeup/context switch time.  Blowing
some cycles in this situation surely is not a problem.

But I do think we want to perform the wakeups from interrupt context;
there are just too many opportunities for kswapd to take an
extended vacation on a request queue.

Non-blocking writeout infrastructure would be nice, too.  And for
simple cases, that's just a matter of getting the block layer
to manage a flag in q->backing_dev_info.  But even that would result
in scanning past pages.  And every time we do that, there are
whacko corner cases which chew tons of CPU or cause oom failures.
Lists, lists, we need more lists!

hmm.  But mapping->backing_dev_info is trivially available in the
superblock scan, and in that case we can scan past entire congested
filesystems, rather than single congested pages.  hmm.

I suspect q->backing_dev_info gets inaccurate once we get into
stacking and striping at the block layer, but that's just an
efficiency failing, not an oops.

> ...
> 
> > But what is even more valuable than the code is a report of its
> > before-and-after effectiveness under a broad range of loads on a broad
> > range of hardware.  That's the most time-consuming part...
> 
> Eeeks ;)   I don't even have a broad range of hardware...
> 

Eeeks indeed.  But the main variables really are memory size,
IO bandwidth and workload.  That's manageable.

The traditional toss-it-in-and-see-who-complains approach will
catch the weird corner cases but it's slow turnaround.  I guess
as long as we know what the code is trying to do then it should be
fairly straightforward to verify that it's doing it.
