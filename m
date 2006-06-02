Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWFBTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWFBTvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWFBTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:34 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27009 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751474AbWFBTqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:31 -0400
Message-Id: <20060602194735.685911000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:03 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Paul Jackson <pj@sgi.com>,
       David Chinner <dgc@sgi.com>, Simon.Derr@bull.net,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/11] Cpuset: might sleep checking zones allowed fix
Content-Disposition: inline; filename=cpuset-might-sleep-checking-zones-allowed-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Paul Jackson <pj@sgi.com>

Fix an infrequently encountered 'sleeping function called
from invalid context' in the cpuset hooks in __alloc_pages.
Could sleep while interrupts disabled.

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

This rule was being violated due to a bogus change made (by myself,
pj) to __alloc_pages() as part of the November 2005 effort to
cleanup its logic.

The bogus change can be seen at:
  http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-11/4691.html
  [PATCH 01/05] mm fix __alloc_pages cpuset ALLOC_* flags

This was first noticed on a tight memory system, in code that
was disabling interrupts and doing allocation requests with
__GFP_WAIT not set, which resulted in __might_sleep() writing
complaints to the log "Debug: sleeping function called ...",
when the code in cpuset_zone_allowed() tried to take the
callback_sem cpuset semaphore.

Special thanks to Dave Chinner, for figuring this out,
and a tip of the hat to Nick Piggin who warned me of this
back in Nov 2005, before I was ready to listen.

Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 mm/page_alloc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16.19.orig/mm/page_alloc.c
+++ linux-2.6.16.19/mm/page_alloc.c
@@ -949,7 +949,8 @@ restart:
 		alloc_flags |= ALLOC_HARDER;
 	if (gfp_mask & __GFP_HIGH)
 		alloc_flags |= ALLOC_HIGH;
-	alloc_flags |= ALLOC_CPUSET;
+	if (wait)
+		alloc_flags |= ALLOC_CPUSET;
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations

--
