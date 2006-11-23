Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933689AbWKWN1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933689AbWKWN1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933696AbWKWN1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:27:11 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:56760 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S933689AbWKWN1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:27:10 -0500
Date: Thu, 23 Nov 2006 13:27:07 +0000
To: ak@suse.de
Cc: akpm@osdl.org, bunk@stusta.de, torvalds@osdl.org,
       rientjes@cs.washington.edu, maan@systemlinux.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bug where early_node_map[] is not sorted before use
Message-ID: <20061123132707.GA22611@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With reference to this bug;

> Subject    : x86_64: Bad page state in process 'swapper'
> References : http://lkml.org/lkml/2006/11/10/135
>              http://lkml.org/lkml/2006/11/10/208
> Submitter  : Andre Noll <maan@systemlinux.org>
> Handled-By : David Rientjes <rientjes@cs.washington.edu>
> Status     : problem is being debugged

The problem was within architecture-independent zone-sizing and exposed
by a particular SRAT table on x86_64.

find_min_pfn_for_node() and find_min_pfn_with_active_regions() both
depend on a sorted early_node_map[] to find the correct values. However,
sort_node_map() is being called after find_min_pfn_with_active_regions()
in free_area_init_nodes(). In most cases, this is ok, but on an x86_64,
the SRAT table caused the E820 ranges to be registered out of order. This gave
the wrong values for the min PFN range resulting in some pages not being
initialised.

This patch sorts the early_node_map in find_min_pfn_for_node(). It is a
critical fix for 2.6.19.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup linux-2.6.19-rc6-clean/mm/page_alloc.c linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c
--- linux-2.6.19-rc6-clean/mm/page_alloc.c	2006-11-15 20:03:40.000000000 -0800
+++ linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c	2006-11-23 02:23:57.000000000 -0800
@@ -2612,6 +2612,9 @@ unsigned long __init find_min_pfn_for_no
 {
 	int i;
 
+	/* Regions in the early_node_map can be in any order */
+	sort_node_map();
+
 	/* Assuming a sorted map, the first range found has the starting pfn */
 	for_each_active_range_index_in_nid(i, nid)
 		return early_node_map[i].start_pfn;
@@ -2680,9 +2683,6 @@ void __init free_area_init_nodes(unsigne
 			max(max_zone_pfn[i], arch_zone_lowest_possible_pfn[i]);
 	}
 
-	/* Regions in the early_node_map can be in any order */
-	sort_node_map();
-
 	/* Print out the zone ranges */
 	printk("Zone PFN ranges:\n");
 	for (i = 0; i < MAX_NR_ZONES; i++)

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
