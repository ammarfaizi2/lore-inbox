Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWEREgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWEREgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWEREgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:36:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15026 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750886AbWEREgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:36:04 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Paul Jackson <pj@sgi.com>
Date: Wed, 17 May 2006 21:35:56 -0700
Message-Id: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix a couple of infrequently encountered 'sleeping function
called from invalid context' in the cpuset hooks in
__alloc_pages.  Could sleep while interrupts disabled.

The routine cpuset_zone_allowed() is called by code in
mm/page_alloc.c __alloc_pages() to determine if a zone is
allowed in the current tasks cpuset.  This routine can sleep,
for certain GFP_KERNEL allocations, if the zone is on a memory
node not allowed in the current cpuset, but might be allowed
in a parent cpuset.

But we can't sleep in __alloc_pages() if in interrupt, nor
if called for a GFP_ATOMIC request (__GFP_WAIT not set in
gfp_flags).

The rule was intended to be:
  Don't call cpuset_zone_allowed() if you can't sleep, unless you
  pass in the __GFP_HARDWALL flag set in gfp_flag, which disables
  the code that might scan up ancestor cpusets and sleep.

This rule was being violated in a couple of places, due to a
bogus change made (by myself, pj) to __alloc_pages() as part
of the November 2005 effort to cleanup its logic, and also due
to a later fix to constrain which swap daemons were awoken.

The bogus change can be seen at:
  http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-11/4691.html
  [PATCH 01/05] mm fix __alloc_pages cpuset ALLOC_* flags

This was first noticed on a tight memory system, in code that
was disabling interrupts and doing allocation requests with
__GFP_WAIT not set, which resulted in __might_sleep() writing
complaints to the log "Debug: sleeping function called ...",
when the code in cpuset_zone_allowed() tried to take the
callback_sem cpuset semaphore.

We haven't seen a system hang on this 'might_sleep' yet, but
we are at decent risk of seeing it fairly soon, especially
since the additional cpuset_zone_allowed() check was added,
conditioning wakeup_kswapd(), in March 2006.

Special thanks to Dave Chinner, for figuring this out,
and a tip of the hat to Nick Piggin who warned me of this
back in Nov 2005, before I was ready to listen.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Andrew - this patch is worth pushing along a little faster. -pj

 mm/page_alloc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 2.6.17-rc4-mm1.orig/mm/page_alloc.c	2006-05-17 18:57:58.400484681 -0700
+++ 2.6.17-rc4-mm1/mm/page_alloc.c	2006-05-17 19:04:59.177414192 -0700
@@ -1038,7 +1038,7 @@ restart:
 		goto got_pg;
 
 	do {
-		if (cpuset_zone_allowed(*z, gfp_mask))
+		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
 			wakeup_kswapd(*z, order);
 	} while (*(++z));
 
@@ -1057,7 +1057,8 @@ restart:
 		alloc_flags |= ALLOC_HARDER;
 	if (gfp_mask & __GFP_HIGH)
 		alloc_flags |= ALLOC_HIGH;
-	alloc_flags |= ALLOC_CPUSET;
+	if (wait)
+		alloc_flags |= ALLOC_CPUSET;
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
