Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266610AbSKGWPZ>; Thu, 7 Nov 2002 17:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbSKGWPZ>; Thu, 7 Nov 2002 17:15:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:50418 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266610AbSKGWPX>;
	Thu, 7 Nov 2002 17:15:23 -0500
Message-ID: <3DCAE784.E8BEFB24@digeo.com>
Date: Thu, 07 Nov 2002 14:21:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, jw@pegasys.ws, wa@almesberger.net,
       andersen@codepoet.org, woofwoof@hathway.com
Subject: Re: ps performance sucks
References: <3DCAD5A9.D4D4C1CB@digeo.com> from "Andrew Morton" at Nov 07, 2002 01:05:45 PM <200211072202.gA7M2Rd132519@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 22:21:56.0877 (UTC) FILETIME=[153F6BD0:01C286AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Andrew Morton writes:
> > "Albert D. Cahalan" wrote:
> 
> >> In case you happen to know where they are, I'm looking for these:
> >>
> >> pages reclaimed
> >
> > /proc/vmstat:pgsteal
> 
> That's a funny name for it. Sure about that? Longer description
> of what I'm looking for:
> 
>     reattaches from reclaim list
>         Number of pages that have been faulted while on the inactive list

Ah.  No, we don't account that.  That would be "minor faults
against pagecache".

> To me, "pgsteal" sounds like pages grabbed from a clean list to
> be used for some new purpose.

Yes, it is.  "page reclaim"
 
> >> minor faults
> >
> > /proc/vmstat:pgfault - /proc/vmstat:pgmajfault
> >
> >> COW faults
> >> zero-page faults
> >
> > These are not available separately
> 
> They count as minor faults?

Yes.
 
> >> anticipated short-term memory shortfall
> >
> > hm.  tricky.
> 
> How about these then? (and would you want them?)
> 
> a. urgency level for the need to free up memory

It's a bit hard to put one's finger on what this means
really.  We have the free-pages info in /proc/meminfo,
and the page-stealing rates in /proc/meminfo.

If we see that kswapd is stealing pages like mad then we
know there's a lot of replacement pressure, but that certainly
doesn't mean that the system is under any sort of difficulty.

I guess one should step back and ask "what are we trying to
report here"?

> b. amount (or %) by which the system is overcommitted

That's approximately /proc/meminfo:Committed_AS / total memory.
 
> >> pages freed
> >
> > /proc/vmstat:pgfree
> >
> > This is a little broken in 2.5.46.  pgfree is accumulated
> > _before_ the per-cpu LIFO queues and pgalloc is accumulated _after_
> > the per-cpu queues (or vice versa) so they're out of whack.
> 
> Can I assume it will be fixed soon? Is this a value you'd like?

Yes, I have a fix for that queued.

pgfree will include freeings from programs exitting, munmapping,
truncating, etc.  I think it's not a very interesting metric
for system behaviour.

/proc/vmstat:pgsteal is more interesting.  It shows the rate
at which the kernel is reclaiming cache (pagecache and swapcache)
to satisfy its memory demands.

> >> pages scanned by page-replacement algorithm
> >
> > /proc/vmstat:pgscan
> >
> >> clock cycles by page replacement algorithm
> >
> > Not available.  Could sum up the CPU across all kswapd instances,
> > which is a bit lame.
> 
> I suspect that it's cycles of the page aging "clock" hand,
> not CPU cycles. So that would be pages scanned divided by
> the average number of pages in a full scan.

OK.  /proc/vmstat:pgscan is incremented when the VM considers
a page for replacement.  You can divide this by Active+Inactive
from meminfo to determine the scanning rate.

Also, pgscan/pgsteal is a metric of the efficiency of page
reclaim.  If it's 1.00 then every page coming off the tail of
the inactive list is being reaped.  If it gets much below 0.3
or so then the VM is having quite some difficulty.
 
> >> number of system calls
> >
> > Not available
> 
> I though so. Bummer. I guess this is due to overhead.
> 
> >> number of forks (fork, vfork, & clone) and execs
> >
> > /proc/stat: processes
> 
> That's fork/vfork/clone all together, w/o execs?

Looks like it, yes.

> (good for "vmstat -f", but poor for "vmstat -s")
> 
> Got one more:
> 
>       wired pages
>           Total number of pages that are currently in use
>           and cannot be used for paging

I guess this should include:

- Pages in use by the kernel (kmalloc, kernel stacks etc).
  (These are mostly accounted for in /proc/meminfo:Slab)

- Pages which are mlocked (there is no accounting of these at all)

- PageReserved pages

- Not much else, really.  Maybe pages which are under direct-IO.

PageReserved accounting is simple enough, but it looks like the
problem which needed that metric can be solved by other means.

mlock accounting is tricky, and without that the value of this is a 
bit questionable.

> Thanks for all the help. BTW, you didn't say if you liked the
> proposed changes, so I'm assuming they don't matter to you.

I like anything which improves the observability of kernel
behaviour ;)
