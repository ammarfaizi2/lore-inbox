Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVKSKhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVKSKhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVKSKhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:37:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10101
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751015AbVKSKhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:37:31 -0500
Date: Sat, 19 Nov 2005 11:37:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, edwardsg@sgi.com
Subject: Re: shrinker->nr = LONG_MAX means deadlock for icache
Message-ID: <20051119103723.GA18782@opteron.random>
References: <20051118171249.GJ24970@opteron.random> <20051118232904.4231ad87.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118232904.4231ad87.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:29:04PM -0800, Andrew Morton wrote:
> Do we know what sort of machine it was?  Amount of memory?  Were there
> zillions of inodes in icache at the time?  edward@sgi means 64 bits?

I don't know, but perhaps Greg can answer that.

All I know is that they deadlocked in shrink_slab with
shrink_icache_memory returning 3 (which I don't see how it can return 3,
given it's multiplied by 100 before returning in shrink_icache_memory,
but anyway I don't care about this detail, I guess they debugged it
wrong, or they tweaked the sysctl or similar).

So one of the suggestion from Greg has been to modify the code to break
the loop if shrink_icache_memory returns the same value twice in a row
(like twice 3), but I thought that was the wrong fix, given that the
division by 100 means shrink_icache_memory can return the same thing
twice despite it made some progress in the lru walk.

If breaking the loop despite we made progress doesn't risk to make us go
out of memory (which I think it theoretically could) then we should
remove the loop completely. I believe the loop is needed if we
shrink in SHRINK_BATCH small passes and breaking the loop early if
shrink_icache_memory returned the same value twice in a row, was unsafe.

And if we don't try to keep nr under control, even if the deadlock is
avoided, an huge nr value would over-shrink the caches. So that
would leave a performance bug and a potential early-oom.

> I'm having trouble seeing how ->nr could go negative.

Me too, I doubt they hit that path, I assume it's a path just in case,
but still the interesting thing is that if that code exists it means
that nr can grow to insane values. Hitting that code or reaching only
half of LONG_MAX isn't going to make any difference w.r.t. deadlocking
in shrink_slab.

> I'm also having trouble remembering how the code works, so bear with me ;)

Well, I'm trying to understand it too, I didn't write it ;). I posted
here exactly to have feedback to who wrote the code to verify my
proposed fix (or band-aid) was ok.

The code does something like this before returning:

	shrinker->nr += total_scan

total_scan is never decreased if the gfp_mask has no __GFP_FS.

So I guess it tries to account for the fact it couldn't shrink the
caches despite it should have.

Regardless of what the code does and why does it, my point is that it
can't be right to have something like this:

		if (shrinker->nr < 0)
			shrinker->nr = LONG_MAX;	/* It wrapped!
*/

right before looping shrinker->nr/SHRINK_BATCH times without any chance
of breaking the loop (and even if we break the loop when there are no
more freeable entries, such an huge "nr" setting means destroying the
icache/dcache every time).

Clearly when I heard about this deadlock, after reading the code, my
preferred point of attack is certainly the above "nr = LONG_MAX"
assumption.

> The idea in shrink_slab is that we'll scan each slab object at a rate which
> is proportional to that at which we scan each page.
> 
> So shrink_slab() is passed the number of LRU pages which were just scanned,
> and the total number of LRU pages (which are pertinent to this allocation
> attempt).
> 
> On this call to shrink_slab(), we need to work out how many objects are to
> be scanned for each cache.  This is calculated as:
> 
> 	(number of objects in the cache) *
> 		(number of scanned LRU pages / number of LRU pages)
> and then we apply a basically-constant multiplier of 4/shrinker->seeks,
> which is close to 1.

So it tries to simulate to have those slab entries in the page-lru
(and the speed becomes tunable by the per-shrinker seek param to give
higher/lower prio to the caches).

> The RHS of this multiplication cannot exceed 1.  (Checks.  Yup, we zero out
> nr_scanned each time we increase the scanning priority).
> 
> The LHS cannot exceed LONG_MAX on 32-bit or 64-bit.
> 
> 
> Now if the shrinker returns -1 during the actual slab scan, the scanner
> will bale out but will remember that it still needs to scan those entries
> for next time.
> 
> 
> All I can surmise is that either
> 
> a) a shrinker keeps on returning -1 and ->nr overflowed.  That means we
>    did a huge number of !__GFP_FS memory allocations.  That seems like
>    quite a problem, so perhaps:

Agreed.

> diff -puN mm/vmscan.c~a mm/vmscan.c
> --- devel/mm/vmscan.c~a	2005-11-18 23:22:51.000000000 -0800
> +++ devel-akpm/mm/vmscan.c	2005-11-18 23:24:08.000000000 -0800
> @@ -227,8 +227,15 @@ static int shrink_slab(unsigned long sca
>  
>  			nr_before = (*shrinker->shrinker)(0, gfp_mask);
>  			shrink_ret = (*shrinker->shrinker)(this_scan, gfp_mask);
> -			if (shrink_ret == -1)
> +			if (shrink_ret == -1) {
> +				/*
> +				 * Don't allow ->nr to overflow.  This can
> +				 * happen if someone is doing a great number
> +				 * of !__GFP_FS calls.
> +				 */
> +				total_scan = 0;
>  				break;
> +			}
>  			if (shrink_ret < nr_before)
>  				ret += nr_before - shrink_ret;
>  			mod_page_state(slabs_scanned, this_scan);
> _

It made some sense to me to account the "failed attempt" for the future
passes, my fix tried to retain this feature.

However I certainly won't object to the above fix, I guess it doesn't
make any real difference in practice to use my fix or the above one.

But then you also have to add a BUG_ON(shrinker->nr < 0). There is no
chance that the current code doing shrinker->nr = LONG_MAX can be
correct, so whatever we change, that branch must go away too (and be
replaced by a BUG_ON).

> b) your inodes_stat.nr_unused went nuts.  ISTR that we've had a few
>    problems with .nr_unused (was it the dentry cache or the inode cache
>    though)?
> 
> Which kernel was this based upon?

Good point, however they reported the return value of
shrink_icache_memory was constant 3, so no negative and no huge value
(as said I don't see why it's not a multiple of 100, but at least it
didn't sound a nr_unused screwup if what they found returned by
shrink_icache_memory was number "3", so not negative and not huge).

If that was the bug, our fixes wouldn't make a difference. Current
status of the kernel that they used has all nr_unused and other icache
wakeup race conditions fixes, but it's not certain if they were using a
previous version that still had those problems.

> Is it reproducible?  If so, a few printks triggered when shrinker->nr
> starts to get ridiculously large would be useful.

Dunno. Also they're using the toss-pagecache feature to invoke the
shrinking, system was not short of free ram. I don't know how they
debugged it but my plan was to fix the obvious problem with "nr"
potentially growing too much (the part certainly good for mainline too)
and then to try again and if they can reproduce to debug it further by
starting checking the paramters in input to shrink_slab. However I
clearly have an hope that all they need is the above needed fix ;).

Thanks!
