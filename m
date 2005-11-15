Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVKOTWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVKOTWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVKOTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:22:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38563 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965008AbVKOTWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:22:53 -0500
Date: Tue, 15 Nov 2005 11:22:47 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20051115192247.4210.22639.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] mm redo ALLOC_* flag names again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More consistent mm/page_alloc.c ALLOC_* flag names.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/page_alloc.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

--- 2.6.14-mm2.orig/mm/page_alloc.c	2005-11-13 10:32:33.090792563 -0800
+++ 2.6.14-mm2/mm/page_alloc.c	2005-11-15 11:00:30.967888018 -0800
@@ -755,10 +755,10 @@ buffered_rmqueue(struct zone *zone, int 
 	return page;
 }
 
-#define ALLOC_DONT_DIP	0x01 	/* don't dip into memory reserves */
-#define ALLOC_DIP_SOME	0x02 	/* dip into reserves some */
-#define ALLOC_DIP_ALOT	0x04 	/* dip into reserves further */
-#define ALLOC_MUSTHAVE	0x08 	/* ignore all constraints */
+#define ALLOC_DIP_NONE	0x01 	/* don't dip into memory reserves */
+#define ALLOC_DIP_LESS	0x02 	/* dip into reserves some */
+#define ALLOC_DIP_MORE	0x04 	/* dip into reserves further */
+#define ALLOC_DIP_FULL	0x08 	/* ignore all constraints */
 
 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
@@ -771,9 +771,9 @@ int zone_watermark_ok(struct zone *z, in
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
 	int o;
 
-	if (alloc_flags & ALLOC_DIP_SOME)
+	if (alloc_flags & ALLOC_DIP_LESS)
 		min -= min / 2;
-	if (alloc_flags & ALLOC_DIP_ALOT)
+	if (alloc_flags & ALLOC_DIP_MORE)
 		min -= min / 4;
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
@@ -814,8 +814,8 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	do {
-		if (!(alloc_flags & ALLOC_MUSTHAVE)) {
-			if (alloc_flags == ALLOC_DONT_DIP)
+		if (!(alloc_flags & ALLOC_DIP_FULL)) {
+			if (alloc_flags == ALLOC_DIP_NONE)
 				gfp_mask |= __GFP_HARDWALL;
 			if (!cpuset_zone_allowed(*z, gfp_mask))
 				continue;
@@ -911,7 +911,7 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	}
 restart:
 	page = get_page_from_freelist(gfp_mask, order,
-				zonelist, ALLOC_DONT_DIP);
+				zonelist, ALLOC_DIP_NONE);
 	if (page)
 		goto got_pg;
 
@@ -927,13 +927,13 @@ restart:
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_DIP_ALOT (!wait) and ALLOC_DIP_SOME (__GFP_HIGH).
+	 * set both ALLOC_DIP_MORE (!wait) and ALLOC_DIP_LESS (__GFP_HIGH).
 	 */
 	alloc_flags = 0;
 	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)
-		alloc_flags |= ALLOC_DIP_ALOT;
+		alloc_flags |= ALLOC_DIP_MORE;
 	if (gfp_mask & __GFP_HIGH)
-		alloc_flags |= ALLOC_DIP_SOME;
+		alloc_flags |= ALLOC_DIP_LESS;
 
 	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);
 	if (page)
@@ -947,7 +947,7 @@ restart:
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */
 			page = get_page_from_freelist(gfp_mask, order,
-				zonelist, ALLOC_MUSTHAVE);
+				zonelist, ALLOC_DIP_FULL);
 			if (page)
 				goto got_pg;
 			if (gfp_mask & __GFP_NOFAIL) {
@@ -991,7 +991,7 @@ rebalance:
 		 * under heavy pressure.
 		 */
 		page = get_page_from_freelist(gfp_mask, order,
-						zonelist, ALLOC_DONT_DIP);
+						zonelist, ALLOC_DIP_NONE);
 		if (page)
 			goto got_pg;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
