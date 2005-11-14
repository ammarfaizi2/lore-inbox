Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVKNEEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVKNEEK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 23:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKNEEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 23:04:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:58781 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750889AbVKNEEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 23:04:08 -0500
Date: Sun, 13 Nov 2005 20:03:53 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rationalize mm/page_alloc.c:__alloc_pages() ALLOC flag names.

The case where we should be nice and not dip into memory reserves
had been hiding behind the ALLOC_CPUSET flag, but with that gone,
had no name and was a naked "0" value.

It was not clear which of HARDER or HIGH was harder, and it
was not clear how ALLOC_HIGH related to the allocation policy
for dipping into reserves.

Finally, the names and numeric order did not reflect the natural
order of increasing urgency (increasing willingness to dip
into reserves.)

Rename and renumber these flags to fix above.

A comment "Go through the zonelist again ..." explaining some
of this was obsolete, and adequately covered by a modestly
modified earlier comment, so bye bye obsolete comment.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/page_alloc.c |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

--- 2.6.14-mm2.orig/mm/page_alloc.c	2005-11-13 10:04:26.214796388 -0800
+++ 2.6.14-mm2/mm/page_alloc.c	2005-11-13 10:10:59.147820307 -0800
@@ -755,9 +755,10 @@ buffered_rmqueue(struct zone *zone, int 
 	return page;
 }
 
-#define ALLOC_NO_WATERMARKS	0x01 /* don't check watermarks at all */
-#define ALLOC_HARDER		0x02 /* try to alloc harder */
-#define ALLOC_HIGH		0x04 /* __GFP_HIGH set */
+#define ALLOC_DONT_DIP	0x01 	/* don't dip into memory reserves */
+#define ALLOC_DIP_SOME	0x02 	/* dip into reserves some */
+#define ALLOC_DIP_ALOT	0x04 	/* dip into reserves further */
+#define ALLOC_MUSTHAVE	0x08 	/* ignore all constraints */
 
 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
@@ -770,9 +771,9 @@ int zone_watermark_ok(struct zone *z, in
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
 	int o;
 
-	if (alloc_flags & ALLOC_HIGH)
+	if (alloc_flags & ALLOC_DIP_SOME)
 		min -= min / 2;
-	if (alloc_flags & ALLOC_HARDER)
+	if (alloc_flags & ALLOC_DIP_ALOT)
 		min -= min / 4;
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
@@ -813,7 +814,7 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	do {
-		if (!(alloc_flags & ALLOC_NO_WATERMARKS)) {
+		if (!(alloc_flags & ALLOC_MUSTHAVE)) {
 			if (!cpuset_zone_allowed(*z, gfp_mask))
 				continue;
 			if (!zone_watermark_ok(*z, order, (*z)->pages_low,
@@ -908,7 +909,7 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	}
 restart:
 	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, 0);
+				zonelist, ALLOC_DONT_DIP);
 	if (page)
 		goto got_pg;
 
@@ -923,22 +924,14 @@ restart:
 	 *
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
-	 * policy.
+	 * policy or is asking for __GFP_HIGH memory.
 	 */
 	alloc_flags = 0;
 	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)
-		alloc_flags |= ALLOC_HARDER;
+		alloc_flags |= ALLOC_DIP_ALOT;
 	if (gfp_mask & __GFP_HIGH)
-		alloc_flags |= ALLOC_HIGH;
+		alloc_flags |= ALLOC_DIP_SOME;
 
-	/*
-	 * Go through the zonelist again. Let __GFP_HIGH and allocations
-	 * coming from realtime tasks go deeper into reserves.
-	 *
-	 * This is the last chance, in general, before the goto nopage.
-	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
-	 */
 	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);
 	if (page)
 		goto got_pg;
@@ -951,7 +944,7 @@ restart:
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */
 			page = get_page_from_freelist(gfp_mask, order,
-				zonelist, ALLOC_NO_WATERMARKS);
+				zonelist, ALLOC_MUSTHAVE);
 			if (page)
 				goto got_pg;
 			if (gfp_mask & __GFP_NOFAIL) {
@@ -995,7 +988,7 @@ rebalance:
 		 * under heavy pressure.
 		 */
 		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-						zonelist, 0);
+						zonelist, ALLOC_DONT_DIP);
 		if (page)
 			goto got_pg;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
