Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWDLXXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWDLXXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDLXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:23:05 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:19888 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932404AbWDLXXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:23:04 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060412232257.18862.80856.sendpatchset@skynet>
In-Reply-To: <20060412232036.18862.84118.sendpatchset@skynet>
References: <20060412232036.18862.84118.sendpatchset@skynet>
Subject: [PATCH 7/7] Print out debugging information during initialisation
Date: Thu, 13 Apr 2006 00:22:57 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The zone and hole sizing code is new and unexpected problems showed up
on machines that were not covered by the pre-release tests. This patch
prints out useful information when those unexpected situations occur.

It is not expected that this patch become a permanent part of the set.


 mem_init.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 46 insertions(+), 4 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-106-breakout_mem_init/mm/mem_init.c linux-2.6.17-rc1-107-debug/mm/mem_init.c
--- linux-2.6.17-rc1-106-breakout_mem_init/mm/mem_init.c	2006-04-12 23:37:42.000000000 +0100
+++ linux-2.6.17-rc1-107-debug/mm/mem_init.c	2006-04-13 00:05:58.000000000 +0100
@@ -645,13 +645,23 @@ void __init free_bootmem_with_active_reg
 	for_each_active_range_index_in_nid(i, nid) {
 		unsigned long size_pages = 0;
 		unsigned long end_pfn = early_node_map[i].end_pfn;
-		if (early_node_map[i].start_pfn >= max_low_pfn)
+		if (early_node_map[i].start_pfn >= max_low_pfn) {
+			printk("start_pfn %lu >= %lu\n", early_node_map[i].start_pfn,
+								max_low_pfn);
 			continue;
+		}
 
-		if (end_pfn > max_low_pfn)
+		if (end_pfn > max_low_pfn) {
+			printk("end_pfn %lu going back to %lu\n", early_node_map[i].end_pfn,
+									max_low_pfn);
 			end_pfn = max_low_pfn;
+		}
 
 		size_pages = end_pfn - early_node_map[i].start_pfn;
+		printk("free_bootmem_node(%d, %lu, %lu)\n",
+				early_node_map[i].nid,
+				PFN_PHYS(early_node_map[i].start_pfn),
+				PFN_PHYS(size_pages));
 		free_bootmem_node(NODE_DATA(early_node_map[i].nid),
 				PFN_PHYS(early_node_map[i].start_pfn),
 				PFN_PHYS(size_pages));
@@ -661,10 +671,15 @@ void __init free_bootmem_with_active_reg
 void __init memory_present_with_active_regions(int nid)
 {
 	unsigned int i;
-	for_each_active_range_index_in_nid(i, nid)
+	for_each_active_range_index_in_nid(i, nid) {
+		printk("memory_present(%d, %lu, %lu)\n",
+			early_node_map[i].nid,
+			early_node_map[i].start_pfn,
+			early_node_map[i].end_pfn);
 		memory_present(early_node_map[i].nid,
 				early_node_map[i].start_pfn,
 				early_node_map[i].end_pfn);
+	}
 }
 
 void __init get_pfn_range_for_nid(unsigned int nid,
@@ -738,10 +753,17 @@ unsigned long __init zone_absent_pages_i
 		start_pfn = early_node_map[i].start_pfn;
 		if (start_pfn > arch_zone_highest_possible_pfn[zone_type])
 			start_pfn = arch_zone_highest_possible_pfn[zone_type];
-		BUG_ON(prev_end_pfn > start_pfn);
+		if (prev_end_pfn > start_pfn) {
+			printk("prev_end > start_pfn : %lu > %lu\n",
+					prev_end_pfn,
+					start_pfn);
+			BUG();
+		}
 
 		/* Update the hole size cound and move on */
 		hole_pages += start_pfn - prev_end_pfn;
+		printk("Hole found index %d: %lu -> %lu\n",
+				i, prev_end_pfn, start_pfn);
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 
@@ -892,6 +914,9 @@ void __init add_active_range(unsigned in
 {
 	unsigned int i;
 
+	printk("add_active_range(%d, %lu, %lu): ",
+			nid, start_pfn, end_pfn);
+
 	/* Merge with existing active regions if possible */
 	for (i = 0; early_node_map[i].end_pfn; i++) {
 		if (early_node_map[i].nid != nid)
@@ -900,6 +925,7 @@ void __init add_active_range(unsigned in
 		/* Merge forward if suitable */
 		if (start_pfn <= early_node_map[i].end_pfn &&
 				end_pfn > early_node_map[i].end_pfn) {
+			printk("Merging forward\n");
 			early_node_map[i].end_pfn = end_pfn;
 			return;
 		}
@@ -907,6 +933,7 @@ void __init add_active_range(unsigned in
 		/* Merge backward if suitable */
 		if (start_pfn < early_node_map[i].end_pfn &&
 				end_pfn >= early_node_map[i].start_pfn) {
+			printk("Merging backwards\n");
 			early_node_map[i].start_pfn = start_pfn;
 			return;
 		}
@@ -922,6 +949,7 @@ void __init add_active_range(unsigned in
 		return;
 	}
 
+	printk("New\n");
 	early_node_map[i].nid = nid;
 	early_node_map[i].start_pfn = start_pfn;
 	early_node_map[i].end_pfn = end_pfn;
@@ -951,6 +979,14 @@ static void __init sort_node_map(void)
 
 	sort(early_node_map, num, sizeof(struct node_active_region),
 						cmp_node_active_region, NULL);
+
+	printk("Dumping sorted node map\n");
+	for (num = 0; early_node_map[num].end_pfn; num++) {
+		printk("entry %lu: %d  %lu -> %lu\n", num,
+				early_node_map[num].nid,
+				early_node_map[num].start_pfn,
+				early_node_map[num].end_pfn);
+	}
 }
 
 unsigned long __init find_min_pfn(void)
@@ -988,6 +1024,10 @@ void __init free_area_init_nodes(unsigne
 {
 	unsigned long nid;
 
+	printk("free_area_init_nodes(%lu, %lu, %lu, %lu)\n",
+			arch_max_dma_pfn, arch_max_dma32_pfn,
+			arch_max_low_pfn, arch_max_high_pfn);
+
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
@@ -1002,6 +1042,8 @@ void __init free_area_init_nodes(unsigne
 	arch_zone_lowest_possible_pfn[ZONE_HIGHMEM] = arch_max_low_pfn;
 	arch_zone_highest_possible_pfn[ZONE_HIGHMEM] = arch_max_high_pfn;
 
+	printk("free_area_init_nodes(): find_min_pfn = %lu\n", find_min_pfn());
+
 	/* Regions in the early_node_map can be in any order */
 	sort_node_map();
 
