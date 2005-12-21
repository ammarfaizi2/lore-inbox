Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVLUVIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVLUVIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLUVIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:08:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:12420 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751219AbVLUVIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:08:45 -0500
Date: Wed, 21 Dec 2005 13:08:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: steiner@sgi.com, ak@suse.de, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@vger.kernel.org,
       Martin Hicks <mort@bork.org>
Message-Id: <20051221210823.3354.53223.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zone reclaim V4 [1/3]: resurrect may_swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect may_swap in struct scan_control

Patch against 2.6.15-rc5-mm3 to undo the patch to remove may_writepage.

Not needed for 2.6.14 / 2.6.15-rc6.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/vmscan.c	2005-12-20 15:46:51.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/vmscan.c	2005-12-21 12:32:43.000000000 -0800
@@ -71,6 +71,9 @@ struct scan_control {
 
 	int may_writepage;
 
+	/* Can pages be swapped as part of reclaim? */
+	int may_swap;
+
 	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
 	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
 	 * In this context, it doesn't matter that we scan the
@@ -457,6 +460,8 @@ static int shrink_list(struct list_head 
 		 * Try to allocate it some swap space here.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
+			if (!sc->may_swap)
+				goto keep_locked;
 			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
 		}
@@ -1180,6 +1185,7 @@ int try_to_free_pages(struct zone **zone
 
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
+	sc.may_swap = 1;
 
 	count_event(ALLOCSTALL);
 
@@ -1282,6 +1288,7 @@ loop_again:
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
+	sc.may_swap = 1;
 	sc.nr_mapped = global_page_state(NR_MAPPED);
 
 	count_event(PAGEOUTRUN);
