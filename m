Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWFLVRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWFLVRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWFLVOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6064 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932303AbWFLVOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:37 -0400
Date: Mon, 12 Jun 2006 14:14:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211423.20862.41488.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 19/21] swap_prefetch: Conversion of nr_unstable to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: swap_prefetch: conversion of nr_unstable to per zone counter
From: Christoph Lameter <clameter@sgi.com>

The determination of the vm state is now not that expensive
anymore after we remove the use of the page state.
Remove the logic to avoid the expensive checks.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-12 12:55:39.368358636 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-12 12:55:41.321362692 -0700
@@ -298,7 +298,7 @@ static int prefetch_suitable(void)
 {
 	unsigned long limit;
 	struct zone *z;
-	int node, ret = 0, test_pagestate = 0;
+	int node, ret = 0;
 
 	/* Purposefully racy */
 	if (test_bit(0, &swapped.busy)) {
@@ -306,19 +306,6 @@ static int prefetch_suitable(void)
 		goto out;
 	}
 
-	/*
-	 * get_page_state and above_background_load are expensive so we only
-	 * perform them every SWAP_CLUSTER_MAX prefetched_pages.
-	 * We test to see if we're above_background_load as disk activity
-	 * even at low priority can cause interrupt induced scheduling
-	 * latencies.
-	 */
-	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
-		if (above_background_load())
-			goto out;
-		test_pagestate = 1;
-	}
-
 	clear_current_prefetch_free();
 
 	/*
@@ -357,7 +344,6 @@ static int prefetch_suitable(void)
 	 */
 	for_each_node_mask(node, sp_stat.prefetch_nodes) {
 		struct node_stats *ns = &sp_stat.node[node];
-		struct page_state ps;
 
 		/*
 		 * We check to see that pages are not being allocated
@@ -375,11 +361,6 @@ static int prefetch_suitable(void)
 		} else
 			ns->last_free = ns->current_free;
 
-		if (!test_pagestate)
-			continue;
-
-		get_page_state_node(&ps, node);
-
 		/* We shouldn't prefetch when we are doing writeback */
 		if (node_page_state(node, NR_WRITEBACK)) {
 			node_clear(node, sp_stat.prefetch_nodes);
@@ -394,7 +375,8 @@ static int prefetch_suitable(void)
 			node_page_state(node, NR_ANON) +
 			node_page_state(node, NR_SLAB) +
 			node_page_state(node, NR_DIRTY) +
-			ps.nr_unstable + total_swapcache_pages;
+			node_page_state(node, NR_UNSTABLE) +
+			total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
