Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWESCWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWESCWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWESCWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:22:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42215 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932179AbWESCWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:22:19 -0400
Date: Fri, 19 May 2006 12:21:44 +1000
From: David Chinner <dgc@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: David Chinner <dgc@sgi.com>, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, clameter@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-ID: <20060519022144.GT1390195@melbourne.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com> <20060517222543.600cb20a.akpm@osdl.org> <20060518054750.GN1390195@melbourne.sgi.com> <20060518174800.f13e2c86.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518174800.f13e2c86.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 05:48:00PM -0700, Paul Jackson wrote:
> David wrote:
> > I suggested to Paul that __cpuset_zone_allowed() should check for
> > __GFP_WAIT and allow the allocation if it is not set. Any allocation
> > from interrupt context has to be GFP_ATOMIC so that would kill
> > the need for the in_interrupt() check as well.

....

> The current implementation of the cpuset hooks in __alloc_pages()
> is designed to have the __GFP_WAIT check done in alloc_pages(), not
> in cpuset_zone_allowed().

Which results in complex and fragile logic in __alloc_pages().

> Putting the check you suggest in cpuset_zone_allowed() would 'obviously'
> fix this particular bug, but it would partially duplicate existing
> checks on 'wait' in __alloc_pages().  Not good.

But if cpuset_zone_allowed() did this check, then the logic
in __alloc_pages() gets simpler because you don't have to juggle
all these flags in just the right way to prevent cpuset_zone_allowed()
from sleeping whenit shouldn't.

> The second thing is that the current code is designed to distinguish
> between the memory allocations requested in the following situations:
>  [A] in interrupt,
>  [B] GFP_ATOMIC (or !__GFP_WAIT, in general) in process context, and
>  [C] __GFP_WAIT ok, in process context.

.....

> Your proposal above, Dave, and what I suspect Andrew's proposal
> would be, if he bothered to waste more time thinking about this,
> amount to changing the above design from the three cases [A], [B],
> and [C], to just the two cases:
> 
>  [D] __GFP_WAIT not ok, such as GFP_ATOMIC and/or in_interrupt, and
>  [E] __GFP_WAIT ok.
> 
> You're suggesting we ignore cpusets in [D], and honor them in [E].

Effectively. There are two atomic allocation cases - one is from
interrupt where you want pages from the node local to the allocation
request, and the other is from process/kthread context where we want
pages as close to the node we are curently running on.

In the first case, cpusets simply don't apply.

In the second case, we are typically already running on a cpu
inside the cpuset we're trying to allocate in. If there's
no memory inside the cpuset, we go outside it on the second
attempt.

That is, we fail the first get_page_from_freelist() due to __GFP_HARDWALL,
then we wake kswapd, then we call get_page_from_freelist() without the
__GFP_HARDWALL to allow allocation outside the cpuset.

This hunk of your patch:

@@ -1057,7 +1057,8 @@ restart:
                alloc_flags |= ALLOC_HARDER;
        if (gfp_mask & __GFP_HIGH)
                alloc_flags |= ALLOC_HIGH;
-       alloc_flags |= ALLOC_CPUSET;
+       if (wait)
+               alloc_flags |= ALLOC_CPUSET;

        /*
         * Go through the zonelist again. Let __GFP_HIGH and allocations

Effectively disables the cpuset checks on atomic allocations
for the second call to get_page_from_freelist().

So the semantics your patch introduces for the second case
is:
	- attempt allocation within the cpuset
	- if that fails, allocate from anywhere

Basically, Case B falls back to case A when the cpuset is
full. So my question really is whether we need to attempt
to allocaate within the cpuset for GFP_ATOMIC because
most of the time the local node will be within the cpuset
anyway....

So that's what lead to me asking this - is there really a
noticable distinction between A and B, or is it just
cluttering up the code with needless complex logic?

> One non-obvious (to me at least, for now) detail of such a design change
> would be what do to with the __alloc_pages() code lines:
> 
>         do {
>                 if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
>                         wakeup_kswapd(*z, order);
>         } while (*(++z));
> 
> If 'wait' is set, for allocations in the current task context that
> can sleep, then it's obvious enough - just wake up the kswapd's on
> the nodes in the current tasks cpuset.
> 
> But what do we do if 'wait' is not set, such as when in interrupt or
> for GFP_ATOMIC requests.  Calling cpuset_zone_allowed() is no longer
> allowed in that case.

Sorry, I don't follow why you'd think that this would be not
allowed. Can you explain this further?

> + * So to keep it simple here:
> + *
> + * ==> Don't call this routine from __alloc_pages() if __GFP_WAIT is
> + *     not set in gfp_mask.  Don't call here from anywhere else if
> + *     one can't sleep.  Just assume that the zone is allowed.

Why not simply check this is __cpuset_zone_allowed() and return
true? We shouldn't put the burden of getting this right on the
callers when it is something internal to the cpuset workings....

> @@ -916,7 +915,7 @@ int zone_watermark_ok(struct zone *z, in
>   */
>  static struct page *
>  get_page_from_freelist(gfp_t gfp_mask, unsigned int order,
> -		struct zonelist *zonelist, int alloc_flags)
> +		struct zonelist *zonelist, int alloc_flags, int wait)
>  {
>  	struct zone **z = zonelist->zones;
>  	struct page *page = NULL;
> @@ -927,8 +926,7 @@ get_page_from_freelist(gfp_t gfp_mask, u
>  	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
>  	 */
>  	do {
> -		if ((alloc_flags & ALLOC_CPUSET) &&
> -				!cpuset_zone_allowed(*z, gfp_mask))
> +		if (wait && !cpuset_zone_allowed(*z, gfp_mask))
>  			continue;

Why push another wait flag around when there's already one in the
gfp_mask?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
