Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVKWSG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVKWSG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVKWSG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:06:56 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:46564 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932130AbVKWSGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:06:55 -0500
Date: Wed, 23 Nov 2005 18:06:41 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <1132768482.25086.16.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0511231754020.7045@skynet>
References: <20051122161000.A22430@unix-os.sc.intel.com> 
 <20051122213612.4adef5d0.akpm@osdl.org> <1132768482.25086.16.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Rohit Seth wrote:

> On Tue, 2005-11-22 at 21:36 -0800, Andrew Morton wrote:
> > Rohit Seth <rohit.seth@intel.com> wrote:
> > >
> > > Andrew, Linus,
> > >
> > > [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> > > local pcp lists when a higher order allocation request is not able to
> > > get serviced from global free_list.
> > >
> > > This should help fix some of the earlier failures seen with order 1 allocations.
> > >
> > > I will send separate patches for:
> > >
> > > 1- Reducing the remote cpus pcp
> > > 2- Clean up page_alloc.c for CONFIG_HOTPLUG_CPU to use this code appropiately
> > >
> > > +static int
> > > +reduce_cpu_pcp(void )
> > >
> > This significantly duplicates the existing drain_local_pages().
>
> Yes.  The main change in this new function is I'm only freeing batch
> number of pages from each pcp rather than draining out all of them (even
> under a little memory pressure).  IMO, we should be more opportunistic
> here in alloc_pages in moving pages back to global page pool list.
> Thoughts?
>

I doubt you gain a whole lot by releasing them in batches. There is no way
to determine if freeing a few will result in contiguous blocks or not and
the overhead of been cautious will likely exceed the cost of simply
refilling them on the next order-0 allocation. Your worst case is where
the buddies you need are in different per-cpu caches.

As it's easy to refill a per-cpu cache, it would be easier, clearer and
probably faster to just purge the per-cpu cache and have it refilled on
the next order-0 allocation. The release-in-batch approach would only be
worthwhile if you expect an order-1 allocation to be very rare.

> As said earlier, I will be cleaning up the existing drain_local_pages in
> next follow up patch.
>
> >
> > >
> > > +	if (order > 0)
> > > +		while (reduce_cpu_pcp()) {
> > > +			if (get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags))
> >
> > This forgot to assign to local variable `page'!  It'll return NULL and will
> > leak memory.
> >
> My bad.  Will fix it.
>
> > The `while' loop worries me for some reason, so I wimped out and just tried
> > the remote drain once.
> >
> Even after direct reclaim it probably does make sense to see how
> minimally we can service a higher order request.
>

After direct reclaim, things are already very slow. The cost of refilling
a per-cpu cache is nowhere near the same as a direct-reclaim.

> > > +				goto got_pg;
> > > +		}
> > > +	/* FIXME: Add the support for reducing/draining the remote pcps.
> >
> > This is easy enough to do.
> >
>
> The couple of options that I wanted to think little more were (before
> attempting to do this part):
>
> 1- Whether use the IPI to get the remote CPUs to free pages from pcp or
> do it lazily (using work_pending or such).  As at this point in
> execution we can definitely afford to get scheduled out.
>

In 005_drainpercpu.patch from the last version of the anti-defrag, I used
the smp_call_function() and it did not seem to slow up the system.
Certainly, by the time it was called, the system was already low on
memory and trashing a bit so it just wasn't noticable.

> 2- Do we drain the whole pcp on remote processors or again follow the
> stepped approach (but may be with a steeper slope).
>

I would say do the same on the remote case as you do locally to keep
things consistent.

>
> > We need to verify that this patch actually does something useful.
> >
> >
> I'm working on this.  Will let you know later today if I can come with
> some workload easily hitting this additional logic.
>

I found it hard to generate reliable workloads which hit these sort of
situations although a fork-heavy workload with 8k stacks will put pressure
on order-1 allocations. You can artifically force high order allocations
using vmregress by doing something like this;

./configure --with-linux=/usr/src/linux-yourtree
make
insmod kernel_src/core/vmregress_core.ko
insmod kernel_src/core/buddyinfo.ko
insmod kernel_src/test/highalloc.ko
echo 1 100 > /proc/vmregress/test_highalloc

That will allocate 1 order-1 page every tenth of a second until it has
tried 100 allocations. When it completes, the success/failure report can
be read by catting /proc/vmregress/test_highalloc. Obviously, this is very
artifical.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
