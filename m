Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVKSLG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVKSLG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 06:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKSLG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 06:06:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751226AbVKSLG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 06:06:26 -0500
Date: Sat, 19 Nov 2005 03:03:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, edwardsg@sgi.com
Subject: Re: shrinker->nr = LONG_MAX means deadlock for icache
Message-Id: <20051119030306.3049837d.akpm@osdl.org>
In-Reply-To: <20051119103723.GA18782@opteron.random>
References: <20051118171249.GJ24970@opteron.random>
	<20051118232904.4231ad87.akpm@osdl.org>
	<20051119103723.GA18782@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 
> ...
> The code does something like this before returning:
> 
> 	shrinker->nr += total_scan
> 
> total_scan is never decreased if the gfp_mask has no __GFP_FS.
> 
> So I guess it tries to account for the fact it couldn't shrink the
> caches despite it should have.

yup.  It's problematic, if someone is doing a huge amount of GFP_IO (say)
allocations, ->nr might get really big.  But we do expect that next time
kswapd gets in there with GFP_KERNEL it will sit in a tight loop doing huge
amounts of work, and will catch up.

It would be nice to understand exactly what's gone wrong.

> Regardless of what the code does and why does it, my point is that it
> can't be right to have something like this:
> 
> 		if (shrinker->nr < 0)
> 			shrinker->nr = LONG_MAX;	/* It wrapped!
> */
> 
> right before looping shrinker->nr/SHRINK_BATCH times without any chance
> of breaking the loop (and even if we break the loop when there are no
> more freeable entries, such an huge "nr" setting means destroying the
> icache/dcache every time).

Yes, I think that code's crap.  Perhaps it's left over from when the
counters in there were `long'.  I ended up making them `long long' because
I couldn't work out how to prevent the intermediate results from
overflowing in all scenarios.

We'd be better off with a printk and a reset-it-to-something-sane.

> 
> So it tries to simulate to have those slab entries in the page-lru
> (and the speed becomes tunable by the per-shrinker seek param to give
> higher/lower prio to the caches).

Yup.

<OT>It's actually quite inaccurate because of slab internal fragmentation -
freeing a page always frees some memory, but freeing a slab object doesn't
necessarily do so.  Although on average I guess it gets it right, unless
there are pathological allocation patterns in slab.

It's fairly easy to set up such patterns with artificial test apps: create
a deep+broad directory tree with the same number of entries in each subdir,
for example. </OT>

> 
> It made some sense to me to account the "failed attempt" for the future
> passes, my fix tried to retain this feature.
> 

I guess so, although I worry that this way we'll obscure the real bug,
whatever it is.

> However I certainly won't object to the above fix, I guess it doesn't
> make any real difference in practice to use my fix or the above one.

Sure.  You've limited the number of scanned objects in one pass to twice
the number of objects - there's no point in doing more work than that.

> But then you also have to add a BUG_ON(shrinker->nr < 0). There is no
> chance that the current code doing shrinker->nr = LONG_MAX can be
> correct, so whatever we change, that branch must go away too (and be
> replaced by a BUG_ON).

True.

> > b) your inodes_stat.nr_unused went nuts.  ISTR that we've had a few
> >    problems with .nr_unused (was it the dentry cache or the inode cache
> >    though)?
> > 
> > Which kernel was this based upon?
> 
> Good point, however they reported the return value of
> shrink_icache_memory was constant 3, so no negative and no huge value
> (as said I don't see why it's not a multiple of 100, but at least it
> didn't sound a nr_unused screwup if what they found returned by
> shrink_icache_memory was number "3", so not negative and not huge).

A return value of 3 is very odd.  I'd be suspecting a mismeasurement. 
Unless someone had altered vfs_cache_pressure.

> If that was the bug, our fixes wouldn't make a difference. Current
> status of the kernel that they used has all nr_unused and other icache
> wakeup race conditions fixes, but it's not certain if they were using a
> previous version that still had those problems.

OK.  Well If Edward&co could do a bit more investigation it'd be great -
meanwhile I'll hang onto this (and might add some mm-only debugging,
depending on how Edward gets on):


diff -puN mm/vmscan.c~shrinker-nr-=-long_max-means-deadlock-for-icache mm/vmscan.c
--- devel/mm/vmscan.c~shrinker-nr-=-long_max-means-deadlock-for-icache	2005-11-19 02:53:18.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2005-11-19 03:00:25.000000000 -0800
@@ -201,13 +201,25 @@ static int shrink_slab(unsigned long sca
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 		unsigned long total_scan;
+		unsigned long max_pass = (*shrinker->shrinker)(0, gfp_mask);
 
 		delta = (4 * scanned) / shrinker->seeks;
-		delta *= (*shrinker->shrinker)(0, gfp_mask);
+		delta *= max_pass;
 		do_div(delta, lru_pages + 1);
 		shrinker->nr += delta;
-		if (shrinker->nr < 0)
-			shrinker->nr = LONG_MAX;	/* It wrapped! */
+		if (shrinker->nr < 0) {
+			printk(KERN_ERR "%s: nr=%ld\n",
+					__FUNCTION__, shrinker->nr);
+			shrinker->nr = max_pass;
+		}
+
+		/*
+		 * Avoid risking looping forever due to too large nr value:
+		 * never try to free more than twice the estimate number of
+		 * freeable entries.
+		 */
+		if (shrinker->nr > max_pass * 2)
+			shrinker->nr = max_pass * 2;
 
 		total_scan = shrinker->nr;
 		shrinker->nr = 0;
_

