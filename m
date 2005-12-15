Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVLOAch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVLOAch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVLOAc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:32:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20661 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932656AbVLOAcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:32:18 -0500
Date: Wed, 14 Dec 2005 16:32:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003217.31788.17771.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 05/14] Resurrect scan_control.may_swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect may_swap in struct scan_control

Undo the patch to remove may_writepage from mm.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/vmscan.c	2005-12-14 14:57:29.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/vmscan.c	2005-12-14 15:24:19.000000000 -0800
@@ -71,6 +71,9 @@ struct scan_control {
 
 	int may_writepage;
 
+	/* Can pages be swapped as part of reclaim? */
+	int may_swap;
+
 	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
 	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
 	 * In this context, it doesn't matter that we scan the
@@ -458,6 +461,8 @@ static int shrink_list(struct list_head 
 		 * Try to allocate it some swap space here.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
+			if (!sc->may_swap)
+				goto keep_locked;
 			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
 		}
@@ -1415,6 +1420,7 @@ int try_to_free_pages(struct zone **zone
 
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
+	sc.may_swap = 1;
 
 	inc_page_state(allocstall);
 
@@ -1517,6 +1523,7 @@ loop_again:
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
+	sc.may_swap = 1;
 	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	inc_page_state(pageoutrun);
