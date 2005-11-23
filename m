Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVKWIdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVKWIdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVKWIdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:33:17 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32162 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030350AbVKWIdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:33:16 -0500
Date: Wed, 23 Nov 2005 08:33:04 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Rohit Seth <rohit.seth@intel.com>
Cc: linux-mm@kvack.org, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Subject: RE: [PATCH 5/5] Light fragmentation avoidance without usemap:
 005_drainpercpu
In-Reply-To: <1132708940.12204.12.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0511230827100.17121@skynet>
References: <01EF044AAEE12F4BAAD955CB75064943053DF65D@scsmsx401.amr.corp.intel.com>
  <Pine.LNX.4.58.0511230009330.31913@skynet> <1132708940.12204.12.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Rohit Seth wrote:

> On Wed, 2005-11-23 at 00:17 +0000, Mel Gorman wrote:
> > On Tue, 22 Nov 2005, Seth, Rohit wrote:
> >
> > >
> > >
> > > >requested order is greater than 3.
> > >
> > > Why this order limit.  Most of the previous failures seen (because of my
> > > earlier patches of bigger and more physical contiguous chunks for pcps)
> > > were with order 1 allocation.
> > >
> >
> > The order 3 is because of this block;
> >
> >         if (!(gfp_mask & __GFP_NORETRY)) {
> >                 if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
> >                         do_retry = 1;
> >                 if (gfp_mask & __GFP_NOFAIL)
> >                         do_retry = 1;
> >         }
> >
> > If it's less than 3, we are retrying anyway and it's something we are
>
> You are retrying (for 0<order<=3) but without draining the pcps (in your
> patch).
>
> > > That code has issues with pre-emptible kernel.
> > >
> >
> > ok... why? I thought that we could only be preempted when we were about to
> > take a spinlock but I have an imperfect understanding of preempt and
> > things change quickly. The path the drain_all_local_pages() enters
> > disables the local IRQs before calling __drain_pages() and when
> > smp_drain_local_pages()  is called, the local IRQs are disabled again
> > before releasing pages. Where can we get preempted?
> >
>
> Basically the get_cpu(), put_cpu() needs to cover the whole scope of
> smp_processor_id usage.  (When you enable CONFIG_DEBUG_PREEMPT the
> kernel will barf if preempt is enabled while calling smp_processor_id).
>
> If the interrupts are disabled all the way through then you wouldn't be
> preempted though.  But get/put_cpu is the right mechanism to ensure
> smp_processor_id and its derived value is used on same processor.
>

That can be easily enough fixed.

> > > I will be shortly sending the patch to free pages from pcp when higher
> > > order allocation is not able to get serviced from global list.
> > >
> >
> > If that works, this part of the patch can be dropped. The intention is to
> > "drain the per-cpu lists by some mechanism". I am not too particular about
> > how it happens. Right now, the per-cpu caches make a massive difference on
> > my 4-way machine at least on whether a large number of contiguous blocks
> > can be allocated or not.
> >
>
> Please let me know if you see any issues with the patch that I sent out
> a bit earlier.
>

I don't have access to my test environment for the rest of the week so I
can't actually try them out.

However, reading through the patches, they appear to duplicate a
significant amount of the existing drain_local_pages() functions and they
only drain the pages on the currently running CPU. On a system with a
number of CPUs, you will only be improving your chances slightly.

I think you would get more of what you need with this patch if;

1. Removed the compile time dependency on CONFIG_PM||CONFIG_HOTPLUG
2. Rechecked the usage of smp_processor_id() (although I don't think it's
    wrong because it's only called with local IRQs disabled)
3. Draining the CPUs after direct reclaim and the allocation still failing

This patch does everything you need including the draining of remove
per-cpus.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
