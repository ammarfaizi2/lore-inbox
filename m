Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVCPAbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVCPAbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVCPAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:31:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40560
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261253AbVCPAbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:31:39 -0500
Date: Wed, 16 Mar 2005 01:31:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Noah Meyerhans <noahm@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-ID: <20050316003134.GY7699@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315204413.GF20253@csail.mit.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 03:44:13PM -0500, Noah Meyerhans wrote:
> Hello.  We have a server, currently running 2.6.11-rc4, that is
> experiencing similar OOM problems to those described at
> http://groups-beta.google.com/group/fa.linux.kernel/msg/9633559fea029f6e
> and discussed further by several developers here (the summary is at
> http://www.kerneltraffic.org/kernel-traffic/kt20050212_296.html#6)  We
> are running 2.6.11-rc4 because it contains the patches that Andrea
> mentioned in the kerneltraffic link.  The problem was present in 2.6.10
> as well.  We can try newer 2.6 kernels if it helps.

Thanks for testing the new code, but unfortunately the problem you're
facing is a different one. It's still definitely another VM bug though.

While looking after your bug I identified for sure a bug in how the VM
sets the all_unreclaimable, the VM is setting all_unreclaimable on the
normal zone without any care about the progress we're making at freeing
the slab. Once all_unreclaimable is set, it's pretty much too late in
trying not to go OOM. all_unreclaimable truly means OOM so we must be
extremely careful when we set it (for sure the slab progress must be
taken into account).

We also want kswapd to help us in freeing the slab in the background
instead of erroneously giving it up if some slab cache is still
freeable.

Once all_unreclaimable is set, then shrink_caches will stop calling
shrink_zone for anything but the lowest prio, and this will lead to
sc.nr_scanned to be small, and this will lead to shrink_slab to get a
small parameter too.


In short I think we can start by trying this fix (which has some risk,
since now it might become harder to detect an oom condition, but I don't
see many other ways in order to keep the slab progress into account
without major changes). perhaps another way would be to check for
total_reclaimed < SWAP_CLUSTER_MAX, but the one I used in the patch is
much safer for your purposes (even if less safe in terms of not running
into live locks).

Beware this absolutely untested and it may not be enough.  Perhaps there
are more bugs in the same area (the shrink_slab itself seems overkill
complicated for no good reason and different methods returns random
stuff, dcache returns a percentage of the free entries, dquot instead
returns the allocated inuse entries too which makes the whole API
looking unreliable).

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/mm/vmscan.c.~1~	2005-03-14 05:02:17.000000000 +0100
+++ x/mm/vmscan.c	2005-03-16 01:28:16.000000000 +0100
@@ -1074,8 +1074,9 @@ scan:
 			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
 				continue;
-			if (zone->pages_scanned >= (zone->nr_active +
-							zone->nr_inactive) * 4)
+			if (!reclaim_state->reclaimed_slab &&
+			    zone->pages_scanned >= (zone->nr_active +
+						    zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and

This below is an untested attempt at bringing dquot a bit more in line
with the API, to make the whole thing a bit more consistent, though I
doubt you're using quotas, so it's only the above one that's going to be
interesting for you to test.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/fs/dquot.c.~1~	2005-03-08 01:02:13.000000000 +0100
+++ x/fs/dquot.c	2005-03-16 01:18:19.000000000 +0100
@@ -510,7 +510,7 @@ static int shrink_dqcache_memory(int nr,
 	spin_lock(&dq_list_lock);
 	if (nr)
 		prune_dqcache(nr);
-	ret = dqstats.allocated_dquots;
+	ret = (dqstats.free_dquots / 100) * sysctl_vfs_cache_pressure;
 	spin_unlock(&dq_list_lock);
 	return ret;
 }

Let us know if this helps in any way or not. Thanks!
