Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVKNEDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVKNEDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 23:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVKNEDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 23:03:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65484 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750884AbVKNEDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 23:03:48 -0500
Date: Sun, 13 Nov 2005 20:03:41 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20051114040341.13951.18900.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 02/05] mm simplify __alloc_pages cpuset ALLOC_* flags
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ALLOC_CPUSET flag from mm/page_alloc.c:__alloc_pages().
Thanks to the previous patch, it is equivalent to the setting
of !ALLOC_NO_WATERMARKS, so redundant.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/page_alloc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--- 2.6.14-mm2.orig/mm/page_alloc.c	2005-11-12 22:27:30.519813285 -0800
+++ 2.6.14-mm2/mm/page_alloc.c	2005-11-12 22:28:35.792016688 -0800
@@ -758,7 +758,6 @@ buffered_rmqueue(struct zone *zone, int 
 #define ALLOC_NO_WATERMARKS	0x01 /* don't check watermarks at all */
 #define ALLOC_HARDER		0x02 /* try to alloc harder */
 #define ALLOC_HIGH		0x04 /* __GFP_HIGH set */
-#define ALLOC_CPUSET		0x08 /* check for correct cpuset */
 
 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
@@ -814,11 +813,9 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	do {
-		if ((alloc_flags & ALLOC_CPUSET) &&
-				!cpuset_zone_allowed(*z, gfp_mask))
-			continue;
-
 		if (!(alloc_flags & ALLOC_NO_WATERMARKS)) {
+			if (!cpuset_zone_allowed(*z, gfp_mask))
+				continue;
 			if (!zone_watermark_ok(*z, order, (*z)->pages_low,
 				    classzone_idx, alloc_flags))
 				continue;
@@ -911,7 +908,7 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	}
 restart:
 	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, ALLOC_CPUSET);
+				zonelist, 0);
 	if (page)
 		goto got_pg;
 
@@ -933,7 +930,6 @@ restart:
 		alloc_flags |= ALLOC_HARDER;
 	if (gfp_mask & __GFP_HIGH)
 		alloc_flags |= ALLOC_HIGH;
-	alloc_flags |= ALLOC_CPUSET;
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
@@ -999,7 +995,7 @@ rebalance:
 		 * under heavy pressure.
 		 */
 		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-						zonelist, ALLOC_CPUSET);
+						zonelist, 0);
 		if (page)
 			goto got_pg;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
