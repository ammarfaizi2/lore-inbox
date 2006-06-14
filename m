Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWFNBGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWFNBGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWFNBEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:04:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:20709 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964857AbWFNBEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:25 -0400
Date: Tue, 13 Jun 2006 18:04:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010416.859.61807.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 19/21] swap_prefetch: Conversion of nr_unstable to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: swap_prefetch: conversion of nr_unstable to per zone counter
From: Christoph Lameter <clameter@sgi.com>

The determination of the vm state is now not that expensive
anymore after we remove the use of the page state.
Change the logic to avoid the expensive checks.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-12 13:37:47.283159568 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-12 17:06:44.875945042 -0700
@@ -298,7 +298,7 @@ static int prefetch_suitable(void)
 {
 	unsigned long limit;
 	struct zone *z;
-	int node, ret = 0, test_pagestate = 0;
+	int node, ret = 0;
 
 	/* Purposefully racy */
 	if (test_bit(0, &swapped.busy)) {
@@ -307,17 +307,15 @@ static int prefetch_suitable(void)
 	}
 
 	/*
-	 * get_page_state and above_background_load are expensive so we only
-	 * perform them every SWAP_CLUSTER_MAX prefetched_pages.
+	 * above_background_load() is expensive so we only perform
+	 * it every SWAP_CLUSTER_MAX prefetched_pages.
 	 * We test to see if we're above_background_load as disk activity
 	 * even at low priority can cause interrupt induced scheduling
 	 * latencies.
 	 */
-	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
-		if (above_background_load())
+	if ((!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) &&
+		above_background_load())
 			goto out;
-		test_pagestate = 1;
-	}
 
 	clear_current_prefetch_free();
 
@@ -357,7 +355,6 @@ static int prefetch_suitable(void)
 	 */
 	for_each_node_mask(node, sp_stat.prefetch_nodes) {
 		struct node_stats *ns = &sp_stat.node[node];
-		struct page_state ps;
 
 		/*
 		 * We check to see that pages are not being allocated
@@ -375,11 +372,6 @@ static int prefetch_suitable(void)
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
@@ -394,7 +386,8 @@ static int prefetch_suitable(void)
 			node_page_state(node, NR_ANON) +
 			node_page_state(node, NR_SLAB) +
 			node_page_state(node, NR_DIRTY) +
-			ps.nr_unstable + total_swapcache_pages;
+			node_page_state(node, NR_UNSTABLE) +
+			total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
