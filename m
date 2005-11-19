Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbVKSHcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVKSHcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 02:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVKSHcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 02:32:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751453AbVKSHcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 02:32:25 -0500
Date: Fri, 18 Nov 2005 23:29:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, edwardsg@sgi.com
Subject: Re: shrinker->nr = LONG_MAX means deadlock for icache
Message-Id: <20051118232904.4231ad87.akpm@osdl.org>
In-Reply-To: <20051118171249.GJ24970@opteron.random>
References: <20051118171249.GJ24970@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Greg Edwards found some deadlock in the icache shrinker.

Do we know what sort of machine it was?  Amount of memory?  Were there
zillions of inodes in icache at the time?  edward@sgi means 64 bits?

>  I believe the major bug is that the VM is currently potentially setting
>  nr = LONG_MAX before shrinking the icache (and the icache shrinker never
>  returns -1, which means the api doesn't currently require shrinkers to
>  return -1 when they're finished).

I'm having trouble seeing how ->nr could go negative.

I'm also having trouble remembering how the code works, so bear with me ;)

The idea in shrink_slab is that we'll scan each slab object at a rate which
is proportional to that at which we scan each page.

So shrink_slab() is passed the number of LRU pages which were just scanned,
and the total number of LRU pages (which are pertinent to this allocation
attempt).

On this call to shrink_slab(), we need to work out how many objects are to
be scanned for each cache.  This is calculated as:

	(number of objects in the cache) *
		(number of scanned LRU pages / number of LRU pages)

and then we apply a basically-constant multiplier of 4/shrinker->seeks,
which is close to 1.

The RHS of this multiplication cannot exceed 1.  (Checks.  Yup, we zero out
nr_scanned each time we increase the scanning priority).

The LHS cannot exceed LONG_MAX on 32-bit or 64-bit.


Now if the shrinker returns -1 during the actual slab scan, the scanner
will bale out but will remember that it still needs to scan those entries
for next time.


All I can surmise is that either

a) a shrinker keeps on returning -1 and ->nr overflowed.  That means we
   did a huge number of !__GFP_FS memory allocations.  That seems like
   quite a problem, so perhaps:

diff -puN mm/vmscan.c~a mm/vmscan.c
--- devel/mm/vmscan.c~a	2005-11-18 23:22:51.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2005-11-18 23:24:08.000000000 -0800
@@ -227,8 +227,15 @@ static int shrink_slab(unsigned long sca
 
 			nr_before = (*shrinker->shrinker)(0, gfp_mask);
 			shrink_ret = (*shrinker->shrinker)(this_scan, gfp_mask);
-			if (shrink_ret == -1)
+			if (shrink_ret == -1) {
+				/*
+				 * Don't allow ->nr to overflow.  This can
+				 * happen if someone is doing a great number
+				 * of !__GFP_FS calls.
+				 */
+				total_scan = 0;
 				break;
+			}
 			if (shrink_ret < nr_before)
 				ret += nr_before - shrink_ret;
 			mod_page_state(slabs_scanned, this_scan);
_



or

b) your inodes_stat.nr_unused went nuts.  ISTR that we've had a few
   problems with .nr_unused (was it the dentry cache or the inode cache
   though)?

Which kernel was this based upon?

Is it reproducible?  If so, a few printks triggered when shrinker->nr
starts to get ridiculously large would be useful.

