Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWFLVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWFLVNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWFLVNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:13:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27817 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751756AbWFLVNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:24 -0400
Date: Mon, 12 Jun 2006 14:13:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211315.20862.820.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 06/21] Remove nr_mapped from scan controls structure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned VM stats: Remove nr_mapped from scan control
From: Christoph Lameter <clameter@sgi.com>

We can now access the number of pages in a mapped state in an inexpensive
way in shrink_active_list.  So drop the nr_mapped field from scan_control.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmscan.c	2006-06-10 17:25:04.636700267 -0700
+++ linux-2.6.17-rc6-cl/mm/vmscan.c	2006-06-10 19:50:44.835034840 -0700
@@ -48,8 +48,6 @@ struct scan_control {
 	/* Incremented by the number of inactive pages that were scanned */
 	unsigned long nr_scanned;
 
-	unsigned long nr_mapped;	/* From page_state */
-
 	/* This context's GFP mask */
 	gfp_t gfp_mask;
 
@@ -749,7 +747,8 @@ static void shrink_active_list(unsigned 
 		 * how much memory
 		 * is mapped.
 		 */
-		mapped_ratio = (sc->nr_mapped * 100) / vm_total_pages;
+		mapped_ratio = (global_page_state(NR_MAPPED) * 100) /
+					vm_total_pages;
 
 		/*
 		 * Now decide how much we really want to unmap some pages.  The
@@ -996,7 +995,6 @@ unsigned long try_to_free_pages(struct z
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = global_page_state(NR_MAPPED);
 		sc.nr_scanned = 0;
 		if (!priority)
 			disable_swap_token();
@@ -1081,7 +1079,6 @@ loop_again:
 	total_scanned = 0;
 	nr_reclaimed = 0;
 	sc.may_writepage = !laptop_mode,
-	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
 
@@ -1416,7 +1413,6 @@ unsigned long shrink_all_memory(unsigned
 		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
 			unsigned long nr_to_scan = nr_pages - ret;
 
-			sc.nr_mapped = global_page_state(NR_MAPPED);
 			sc.nr_scanned = 0;
 
 			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
@@ -1558,7 +1554,6 @@ static int __zone_reclaim(struct zone *z
 	struct scan_control sc = {
 		.may_writepage = !!(zone_reclaim_mode & RECLAIM_WRITE),
 		.may_swap = !!(zone_reclaim_mode & RECLAIM_SWAP),
-		.nr_mapped = global_page_state(NR_MAPPED),
 		.swap_cluster_max = max_t(unsigned long, nr_pages,
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
