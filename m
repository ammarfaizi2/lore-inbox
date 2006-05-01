Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWEANiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWEANiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWEANh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:37:57 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:23723 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932096AbWEANhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:37:53 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       ak@suse.de, linuxppc-dev@ozlabs.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060501133751.6379.12632.sendpatchset@skynet>
In-Reply-To: <20060501133530.6379.66000.sendpatchset@skynet>
References: <20060501133530.6379.66000.sendpatchset@skynet>
Subject: [PATCH 7/7] Print out debugging information during initialisation
Date: Mon,  1 May 2006 14:37:51 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The zone and hole sizing code is new and unexpected problems showed up
during early releases on machines that were not covered by the pre-release
tests. This patch prints out useful information when those unexpected
situations occur.

It is not expected that this patch become a permanent part of the set.


 mem_init.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 58 insertions(+), 4 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/mem_init.c linux-2.6.17-rc3-mm1-107-debug/mm/mem_init.c
--- linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/mem_init.c	2006-05-01 11:51:50.000000000 +0100
+++ linux-2.6.17-rc3-mm1-107-debug/mm/mem_init.c	2006-05-01 11:51:50.000000000 +0100
@@ -341,6 +341,9 @@ void __meminit memmap_init_zone(unsigned
 	unsigned long end_pfn = start_pfn + size;
 	unsigned long pfn;
 
+	printk("memmap_init_zone(size %lu, nid %d, zone %lu, start_pfn %lu)\n",
+						size, nid, zone, start_pfn);
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!early_pfn_valid(pfn))
 			continue;
@@ -661,6 +664,7 @@ __meminit int init_currently_empty_zone(
 }
 
 #ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+
 /* Note: nid == MAX_NUMNODES returns first region */
 static int __init first_active_region_index_in_nid(int nid)
 {
@@ -713,13 +717,24 @@ void __init free_bootmem_with_active_reg
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
+		printk("free_bootmem_node(%d, %lu, %lu) :::: pfn ranges (%d, %lu, %lu)\n",
+				early_node_map[i].nid,
+				PFN_PHYS(early_node_map[i].start_pfn),
+				PFN_PHYS(size_pages),
+				early_node_map[i].nid, early_node_map[i].start_pfn, end_pfn);
 		free_bootmem_node(NODE_DATA(early_node_map[i].nid),
 				PFN_PHYS(early_node_map[i].start_pfn),
 				size_pages << PAGE_SHIFT);
@@ -729,10 +744,15 @@ void __init free_bootmem_with_active_reg
 void __init sparse_memory_present_with_active_regions(int nid)
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
@@ -785,6 +805,8 @@ unsigned long __init __absent_pages_in_r
 	unsigned long prev_end_pfn = 0, hole_pages = 0;
 	unsigned long start_pfn;
 
+	printk("__absent_pages_in_range(%d, %lu, %lu) = ", nid,
+					range_start_pfn, range_end_pfn);
 	/* Find the end_pfn of the first active range of pfns in the node */
 	i = first_active_region_index_in_nid(nid);
 	if (i == MAX_ACTIVE_REGIONS)
@@ -811,6 +833,8 @@ unsigned long __init __absent_pages_in_r
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 
+	printk("%lu\n", hole_pages);
+
 	return hole_pages;
 }
 
@@ -975,6 +999,9 @@ void __init add_active_range(unsigned in
 {
 	unsigned int i;
 
+	printk("add_active_range(%d, %lu, %lu): ",
+			nid, start_pfn, end_pfn);
+
 	/* Merge with existing active regions if possible */
 	for (i = 0; early_node_map[i].end_pfn; i++) {
 		if (early_node_map[i].nid != nid)
@@ -982,12 +1009,15 @@ void __init add_active_range(unsigned in
 
 		/* Skip if an existing region covers this new one */
 		if (start_pfn >= early_node_map[i].start_pfn &&
-				end_pfn <= early_node_map[i].end_pfn)
+				end_pfn <= early_node_map[i].end_pfn) {
+			printk("Existing\n");
 			return;
+		}
 
 		/* Merge forward if suitable */
 		if (start_pfn <= early_node_map[i].end_pfn &&
 				end_pfn > early_node_map[i].end_pfn) {
+			printk("Merging forward\n");
 			early_node_map[i].end_pfn = end_pfn;
 			return;
 		}
@@ -995,6 +1025,7 @@ void __init add_active_range(unsigned in
 		/* Merge backward if suitable */
 		if (start_pfn < early_node_map[i].end_pfn &&
 				end_pfn >= early_node_map[i].start_pfn) {
+			printk("Merging backwards\n");
 			early_node_map[i].start_pfn = start_pfn;
 			return;
 		}
@@ -1006,6 +1037,7 @@ void __init add_active_range(unsigned in
 		return;
 	}
 
+	printk("New\n");
 	early_node_map[i].nid = nid;
 	early_node_map[i].start_pfn = start_pfn;
 	early_node_map[i].end_pfn = end_pfn;
@@ -1017,16 +1049,22 @@ void __init shrink_active_range(unsigned
 	unsigned int i;
 
 	/* Find the old active region end and shrink */
+	printk("Shrinking %u from %lu to %lu: ",
+					nid, old_end_pfn, new_end_pfn);
 	for_each_active_range_index_in_nid(i, nid) {
 		if (early_node_map[i].end_pfn == old_end_pfn) {
+			printk("Done\n");
 			early_node_map[i].end_pfn = new_end_pfn;
 			break;
 		}
 	}
+
+	printk("Not found\n");
 }
 
 void __init remove_all_active_ranges()
 {
+	printk("remove_all_active_ranges()\n");
 	memset(early_node_map, 0, sizeof(early_node_map));
 }
 
@@ -1054,6 +1092,14 @@ static void __init sort_node_map(void)
 
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
 
 /* Find the lowest pfn for a node. This depends on a sorted early_node_map */
@@ -1069,6 +1115,7 @@ unsigned long __init find_min_pfn_for_no
 	return 0;
 }
 
+
 unsigned long __init find_min_pfn_with_active_regions(void)
 {
 	return find_min_pfn_for_node(MAX_NUMNODES);
@@ -1082,6 +1129,7 @@ unsigned long __init find_max_pfn_with_a
 	for (i = 0; early_node_map[i].end_pfn; i++)
 		max_pfn = max(max_pfn, early_node_map[i].end_pfn);
 
+	printk("find_max_pfn_with_active_regions() == %lu\n", max_pfn);
 	return max_pfn;
 }
 
@@ -1093,6 +1141,10 @@ void __init free_area_init_nodes(unsigne
 	unsigned long nid;
 	int zone_index;
 
+	printk("free_area_init_nodes(%lu, %lu, %lu, %lu)\n",
+			arch_max_dma_pfn, arch_max_dma32_pfn,
+			arch_max_low_pfn, arch_max_high_pfn);
+
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
@@ -1109,6 +1161,8 @@ void __init free_area_init_nodes(unsigne
 			arch_zone_highest_possible_pfn[zone_index-1];
 	}
 
+	printk("free_area_init_nodes(): find_min_pfn = %lu\n", find_min_pfn_with_active_regions());
+
 	/* Regions in the early_node_map can be in any order */
 	sort_node_map();
 
