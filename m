Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWEHOKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWEHOKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEHOKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:10:55 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:18614 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751275AbWEHOKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:10:52 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Message-Id: <20060508141050.26912.82635.sendpatchset@skynet>
In-Reply-To: <20060508141030.26912.93090.sendpatchset@skynet>
References: <20060508141030.26912.93090.sendpatchset@skynet>
Subject: [PATCH 1/6] Introduce mechanism for registering active regions of memory
Date: Mon,  8 May 2006 15:10:51 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch defines the structure to represent an active range of page
frames within a node in an architecture independent manner. Architectures
are expected to register active ranges of PFNs using add_active_range(nid,
start_pfn, end_pfn) and call free_area_init_nodes() passing the PFNs of
the end of each zone.


 include/linux/mm.h     |   34 +++
 include/linux/mmzone.h |   10 -
 mm/page_alloc.c        |  403 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 422 insertions(+), 25 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-clean/include/linux/mm.h linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/include/linux/mm.h
--- linux-2.6.17-rc3-mm1-clean/include/linux/mm.h	2006-05-01 11:37:01.000000000 +0100
+++ linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/include/linux/mm.h	2006-05-08 09:16:57.000000000 +0100
@@ -916,6 +916,40 @@ extern void free_area_init(unsigned long
 extern void free_area_init_node(int nid, pg_data_t *pgdat,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+/*
+ * Any architecture that supports CONFIG_ARCH_POPULATES_NODE_MAP can
+ * initialise zone and hole information by
+ *
+ * for_all_memory_regions()
+ * 	add_active_range(nid, start, end)
+ * free_area_init_nodes(max_dma, max_dma32, max_low_pfn, max_pfn);
+ *
+ * Optionally, free_bootmem_with_active_regions() can be used to call
+ * free_bootmem_node() after active regions have been registered with
+ * add_active_range(). Similarly, sparse_memory_present_with_active_regions()
+ * calls memory_present() for active regions when SPARSEMEM is enabled
+ */
+extern void free_area_init_nodes(unsigned long max_dma_pfn,
+					unsigned long max_dma32_pfn,
+					unsigned long max_low_pfn,
+					unsigned long max_high_pfn);
+extern void add_active_range(unsigned int nid, unsigned long start_pfn,
+					unsigned long end_pfn);
+extern void shrink_active_range(unsigned int nid, unsigned long old_end_pfn,
+						unsigned long new_end_pfn);
+extern void remove_all_active_ranges(void);
+extern unsigned long absent_pages_in_range(unsigned long start_pfn,
+						unsigned long end_pfn);
+extern void get_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn);
+extern unsigned long find_min_pfn_with_active_regions(void);
+extern unsigned long find_max_pfn_with_active_regions(void);
+extern int early_pfn_to_nid(unsigned long pfn);
+extern void free_bootmem_with_active_regions(int nid,
+						unsigned long max_low_pfn);
+extern void sparse_memory_present_with_active_regions(int nid);
+#endif
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-clean/include/linux/mmzone.h linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/include/linux/mmzone.h
--- linux-2.6.17-rc3-mm1-clean/include/linux/mmzone.h	2006-05-01 11:37:01.000000000 +0100
+++ linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/include/linux/mmzone.h	2006-05-08 09:16:57.000000000 +0100
@@ -271,6 +271,13 @@ struct zonelist {
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+struct node_active_region {
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	int nid;
+};
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
@@ -468,7 +475,8 @@ extern struct zone *next_zone(struct zon
 
 #endif
 
-#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+#if !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) && \
+	!defined(CONFIG_ARCH_POPULATES_NODE_MAP)
 #define early_pfn_to_nid(nid)  (0UL)
 #endif
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-clean/mm/page_alloc.c linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/mm/page_alloc.c
--- linux-2.6.17-rc3-mm1-clean/mm/page_alloc.c	2006-05-01 11:37:01.000000000 +0100
+++ linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/mm/page_alloc.c	2006-05-08 10:56:43.000000000 +0100
@@ -38,6 +38,8 @@
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
 #include <linux/stop_machine.h>
+#include <linux/sort.h>
+#include <linux/pfn.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -86,6 +88,18 @@ int min_free_kbytes = 1024;
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+  #ifdef CONFIG_MAX_ACTIVE_REGIONS
+    #define MAX_ACTIVE_REGIONS CONFIG_MAX_ACTIVE_REGIONS
+  #else
+    #define MAX_ACTIVE_REGIONS (MAX_NR_ZONES * MAX_NUMNODES + 1)
+  #endif
+
+  struct node_active_region __initdata early_node_map[MAX_ACTIVE_REGIONS];
+  unsigned long __initdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
+  unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -1864,25 +1878,6 @@ static inline unsigned long wait_table_b
 
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
 
-static void __init calculate_zone_totalpages(struct pglist_data *pgdat,
-		unsigned long *zones_size, unsigned long *zholes_size)
-{
-	unsigned long realtotalpages, totalpages = 0;
-	int i;
-
-	for (i = 0; i < MAX_NR_ZONES; i++)
-		totalpages += zones_size[i];
-	pgdat->node_spanned_pages = totalpages;
-
-	realtotalpages = totalpages;
-	if (zholes_size)
-		for (i = 0; i < MAX_NR_ZONES; i++)
-			realtotalpages -= zholes_size[i];
-	pgdat->node_present_pages = realtotalpages;
-	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
-}
-
-
 /*
  * Initially all pages are reserved - free ones are freed
  * up by free_all_bootmem() once the early boot process is
@@ -2200,6 +2195,215 @@ __meminit int init_currently_empty_zone(
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+/* Note: nid == MAX_NUMNODES returns first region */
+static int __init first_active_region_index_in_nid(int nid)
+{
+	int i;
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		if (nid == MAX_NUMNODES || early_node_map[i].nid == nid)
+			return i;
+	}
+
+	return MAX_ACTIVE_REGIONS;
+}
+
+/* Note: nid == MAX_NUMNODES returns next region */
+static int __init next_active_region_index_in_nid(unsigned int index, int nid)
+{
+	for (index = index + 1; early_node_map[index].end_pfn; index++) {
+		if (nid == MAX_NUMNODES || early_node_map[index].nid == nid)
+			return index;
+	}
+
+	return MAX_ACTIVE_REGIONS;
+}
+
+#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+int __init early_pfn_to_nid(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		unsigned long start_pfn = early_node_map[i].start_pfn;
+		unsigned long end_pfn = early_node_map[i].end_pfn;
+
+		if ((start_pfn <= pfn) && (pfn < end_pfn))
+			return early_node_map[i].nid;
+	}
+
+	return -1;
+}
+#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
+
+#define for_each_active_range_index_in_nid(i, nid) \
+	for (i = first_active_region_index_in_nid(nid); \
+				i != MAX_ACTIVE_REGIONS; \
+				i = next_active_region_index_in_nid(i, nid))
+
+void __init free_bootmem_with_active_regions(int nid,
+						unsigned long max_low_pfn)
+{
+	unsigned int i;
+	for_each_active_range_index_in_nid(i, nid) {
+		unsigned long size_pages = 0;
+		unsigned long end_pfn = early_node_map[i].end_pfn;
+		if (early_node_map[i].start_pfn >= max_low_pfn)
+			continue;
+
+		if (end_pfn > max_low_pfn)
+			end_pfn = max_low_pfn;
+
+		size_pages = end_pfn - early_node_map[i].start_pfn;
+		free_bootmem_node(NODE_DATA(early_node_map[i].nid),
+				PFN_PHYS(early_node_map[i].start_pfn),
+				size_pages << PAGE_SHIFT);
+	}
+}
+
+void __init sparse_memory_present_with_active_regions(int nid)
+{
+	unsigned int i;
+	for_each_active_range_index_in_nid(i, nid)
+		memory_present(early_node_map[i].nid,
+				early_node_map[i].start_pfn,
+				early_node_map[i].end_pfn);
+}
+
+void __init get_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	unsigned int i;
+	*start_pfn = -1UL;
+	*end_pfn = 0;
+
+	for_each_active_range_index_in_nid(i, nid) {
+		*start_pfn = min(*start_pfn, early_node_map[i].start_pfn);
+		*end_pfn = max(*end_pfn, early_node_map[i].end_pfn);
+	}
+
+	if (*start_pfn == -1UL) {
+		printk(KERN_WARNING "Node %u active with no memory\n", nid);
+		*start_pfn = 0;
+	}
+}
+
+unsigned long __init zone_present_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *ignored)
+{
+	unsigned long node_start_pfn, node_end_pfn;
+	unsigned long zone_start_pfn, zone_end_pfn;
+
+	/* Get the start and end of the node and zone */
+	get_pfn_range_for_nid(nid, &node_start_pfn, &node_end_pfn);
+	zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
+	zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
+
+	/* Check that this node has pages within the zone's required range */
+	if (zone_end_pfn < node_start_pfn || zone_start_pfn > node_end_pfn)
+		return 0;
+
+	/* Move the zone boundaries inside the node if necessary */
+	zone_end_pfn = min(zone_end_pfn, node_end_pfn);
+	zone_start_pfn = max(zone_start_pfn, node_start_pfn);
+
+	/* Return the spanned pages */
+	return zone_end_pfn - zone_start_pfn;
+}
+
+unsigned long __init __absent_pages_in_range(int nid,
+				unsigned long range_start_pfn,
+				unsigned long range_end_pfn)
+{
+	int i = 0;
+	unsigned long prev_end_pfn = 0, hole_pages = 0;
+	unsigned long start_pfn;
+
+	/* Find the end_pfn of the first active range of pfns in the node */
+	i = first_active_region_index_in_nid(nid);
+	if (i == MAX_ACTIVE_REGIONS)
+		return 0;
+	prev_end_pfn = early_node_map[i].start_pfn;
+
+	/* Find all holes for the zone within the node */
+	for (; i != MAX_ACTIVE_REGIONS;
+			i = next_active_region_index_in_nid(i, nid)) {
+
+		/* No need to continue if prev_end_pfn is outside the zone */
+		if (prev_end_pfn >= range_end_pfn)
+			break;
+
+		/* Make sure the end of the zone is not within the hole */
+		start_pfn = min(early_node_map[i].start_pfn, range_end_pfn);
+		prev_end_pfn = max(prev_end_pfn, range_start_pfn);
+
+		/* Update the hole size cound and move on */
+		if (start_pfn > range_start_pfn) {
+			BUG_ON(prev_end_pfn > start_pfn);
+			hole_pages += start_pfn - prev_end_pfn;
+		}
+		prev_end_pfn = early_node_map[i].end_pfn;
+	}
+
+	return hole_pages;
+}
+
+unsigned long __init absent_pages_in_range(unsigned long start_pfn,
+							unsigned long end_pfn)
+{
+	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
+}
+
+unsigned long __init zone_absent_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *ignored)
+{
+	return __absent_pages_in_range(nid,
+				arch_zone_lowest_possible_pfn[zone_type],
+				arch_zone_highest_possible_pfn[zone_type]);
+}
+#else
+static inline unsigned long zone_present_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *zones_size)
+{
+	return zones_size[zone_type];
+}
+
+static inline unsigned long zone_absent_pages_in_node(int nid,
+						unsigned long zone_type,
+						unsigned long *zholes_size)
+{
+	if (!zholes_size)
+		return 0;
+
+	return zholes_size[zone_type];
+}
+#endif
+
+static void __init calculate_node_totalpages(struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long *zholes_size)
+{
+	unsigned long realtotalpages, totalpages = 0;
+	int i;
+
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		totalpages += zone_present_pages_in_node(pgdat->node_id, i,
+								zones_size);
+	}
+	pgdat->node_spanned_pages = totalpages;
+
+	realtotalpages = totalpages;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		realtotalpages -=
+			zone_absent_pages_in_node(pgdat->node_id, i, zholes_size);
+	}
+	pgdat->node_present_pages = realtotalpages;
+	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id,
+							realtotalpages);
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -2223,10 +2427,9 @@ static void __meminit free_area_init_cor
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 
-		realsize = size = zones_size[j];
-		if (zholes_size)
-			realsize -= zholes_size[j];
-
+		size = zone_present_pages_in_node(nid, j, zones_size);
+		realsize = size - zone_absent_pages_in_node(nid, j,
+								zholes_size);
 		if (j < ZONE_HIGHMEM)
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
@@ -2294,13 +2497,165 @@ void __meminit free_area_init_node(int n
 {
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = node_start_pfn;
-	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
+	calculate_node_totalpages(pgdat, zones_size, zholes_size);
 
 	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+void __init add_active_range(unsigned int nid, unsigned long start_pfn,
+						unsigned long end_pfn)
+{
+	unsigned int i;
+	printk(KERN_DEBUG "Range (%d) %lu -> %lu\n", nid, start_pfn, end_pfn);
+
+	/* Merge with existing active regions if possible */
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		if (early_node_map[i].nid != nid)
+			continue;
+
+		/* Skip if an existing region covers this new one */
+		if (start_pfn >= early_node_map[i].start_pfn &&
+				end_pfn <= early_node_map[i].end_pfn)
+			return;
+
+		/* Merge forward if suitable */
+		if (start_pfn <= early_node_map[i].end_pfn &&
+				end_pfn > early_node_map[i].end_pfn) {
+			early_node_map[i].end_pfn = end_pfn;
+			return;
+		}
+
+		/* Merge backward if suitable */
+		if (start_pfn < early_node_map[i].end_pfn &&
+				end_pfn >= early_node_map[i].start_pfn) {
+			early_node_map[i].start_pfn = start_pfn;
+			return;
+		}
+	}
+
+	/* Leave last entry NULL, we use range.end_pfn to terminate the walk */
+	if (i >= MAX_ACTIVE_REGIONS - 1) {
+		printk(KERN_ERR "Too many memory regions, truncating\n");
+		return;
+	}
+
+	early_node_map[i].nid = nid;
+	early_node_map[i].start_pfn = start_pfn;
+	early_node_map[i].end_pfn = end_pfn;
+}
+
+void __init shrink_active_range(unsigned int nid, unsigned long old_end_pfn,
+						unsigned long new_end_pfn)
+{
+	unsigned int i;
+
+	/* Find the old active region end and shrink */
+	for_each_active_range_index_in_nid(i, nid) {
+		if (early_node_map[i].end_pfn == old_end_pfn) {
+			early_node_map[i].end_pfn = new_end_pfn;
+			break;
+		}
+	}
+}
+
+void __init remove_all_active_ranges()
+{
+	memset(early_node_map, 0, sizeof(early_node_map));
+}
+
+/* Compare two active node_active_regions */
+static int __init cmp_node_active_region(const void *a, const void *b)
+{
+	struct node_active_region *arange = (struct node_active_region *)a;
+	struct node_active_region *brange = (struct node_active_region *)b;
+
+	/* Done this way to avoid overflows */
+	if (arange->start_pfn > brange->start_pfn)
+		return 1;
+	if (arange->start_pfn < brange->start_pfn)
+		return -1;
+
+	return 0;
+}
+
+/* sort the node_map by start_pfn */
+static void __init sort_node_map(void)
+{
+	size_t num = 0;
+	while (early_node_map[num].end_pfn)
+		num++;
+
+	sort(early_node_map, num, sizeof(struct node_active_region),
+						cmp_node_active_region, NULL);
+}
+
+/* Find the lowest pfn for a node. This depends on a sorted early_node_map */
+unsigned long __init find_min_pfn_for_node(unsigned long nid)
+{
+	int i;
+
+	/* Assuming a sorted map, the first range found has the starting pfn */
+	for_each_active_range_index_in_nid(i, nid)
+		return early_node_map[i].start_pfn;
+
+	printk(KERN_WARNING "Could not find start_pfn for node %lu\n", nid);
+	return 0;
+}
+
+unsigned long __init find_min_pfn_with_active_regions(void)
+{
+	return find_min_pfn_for_node(MAX_NUMNODES);
+}
+
+unsigned long __init find_max_pfn_with_active_regions(void)
+{
+	int i;
+	unsigned long max_pfn = 0;
+
+	for (i = 0; early_node_map[i].end_pfn; i++)
+		max_pfn = max(max_pfn, early_node_map[i].end_pfn);
+
+	return max_pfn;
+}
+
+void __init free_area_init_nodes(unsigned long arch_max_dma_pfn,
+				unsigned long arch_max_dma32_pfn,
+				unsigned long arch_max_low_pfn,
+				unsigned long arch_max_high_pfn)
+{
+	unsigned long nid;
+	int zone_index;
+
+	/* Record where the zone boundaries are */
+	memset(arch_zone_lowest_possible_pfn, 0,
+				sizeof(arch_zone_lowest_possible_pfn));
+	memset(arch_zone_highest_possible_pfn, 0,
+				sizeof(arch_zone_highest_possible_pfn));
+	arch_zone_lowest_possible_pfn[ZONE_DMA] =
+					find_min_pfn_with_active_regions();
+	arch_zone_highest_possible_pfn[ZONE_DMA] = arch_max_dma_pfn;
+	arch_zone_highest_possible_pfn[ZONE_DMA32] = arch_max_dma32_pfn;
+	arch_zone_highest_possible_pfn[ZONE_NORMAL] = arch_max_low_pfn;
+	arch_zone_highest_possible_pfn[ZONE_HIGHMEM] = arch_max_high_pfn;
+	for (zone_index = 1; zone_index < MAX_NR_ZONES; zone_index++) {
+		arch_zone_lowest_possible_pfn[zone_index] =
+			arch_zone_highest_possible_pfn[zone_index-1];
+	}
+
+	/* Regions in the early_node_map can be in any order */
+	sort_node_map();
+
+	for_each_online_node(nid) {
+		pg_data_t *pgdat = NODE_DATA(nid);
+		free_area_init_node(nid, pgdat, NULL,
+				find_min_pfn_for_node(nid), NULL);
+	}
+}
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 static bootmem_data_t contig_bootmem_data;
 struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
