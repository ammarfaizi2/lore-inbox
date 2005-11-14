Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVKNEER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKNEER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 23:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVKNEER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 23:04:17 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:64413 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750889AbVKNEEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 23:04:12 -0500
Date: Sun, 13 Nov 2005 20:04:04 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20051114040404.13951.44066.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 04/05] mm simplify __alloc_pages cpuset hardwall logic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The __GFP_HARDWALL flag logic is the same in mm/page_alloc.c
for all calls to get_page_from_freelist().  Save a couple of
lines of source code and a few bytes of text by only computing
it once, inside get_page_from_freelist(), instead of passing
it in each time.  The key improvement is that it reduces the
logic in __alloc_pages() by another detail.  There is now -no-
cpuset specific confinement logic in __alloc_pages().  It is
all more generically stated in get_page_from_freelist().

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/page_alloc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- 2.6.14-mm2.orig/mm/page_alloc.c	2005-11-13 10:10:59.147820307 -0800
+++ 2.6.14-mm2/mm/page_alloc.c	2005-11-13 10:11:02.926182092 -0800
@@ -815,6 +815,8 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	 */
 	do {
 		if (!(alloc_flags & ALLOC_MUSTHAVE)) {
+			if (alloc_flags == ALLOC_DONT_DIP)
+				gfp_mask |= __GFP_HARDWALL;
 			if (!cpuset_zone_allowed(*z, gfp_mask))
 				continue;
 			if (!zone_watermark_ok(*z, order, (*z)->pages_low,
@@ -908,7 +910,7 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 		return NULL;
 	}
 restart:
-	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
+	page = get_page_from_freelist(gfp_mask, order,
 				zonelist, ALLOC_DONT_DIP);
 	if (page)
 		goto got_pg;
@@ -987,7 +989,7 @@ rebalance:
 		 * a parallel oom killing, we must fail if we're still
 		 * under heavy pressure.
 		 */
-		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
+		page = get_page_from_freelist(gfp_mask, order,
 						zonelist, ALLOC_DONT_DIP);
 		if (page)
 			goto got_pg;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
