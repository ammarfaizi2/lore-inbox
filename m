Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWGHLLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWGHLLG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWGHLLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:11:06 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:61369 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751307AbWGHLLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:11:04 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Message-Id: <20060708111102.28664.7292.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
References: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 1/6] Introduce mechanism for registering active regions of memory
Date: Sat,  8 Jul 2006 12:11:02 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch defines the structure to represent an active range of page
frames within a node in an architecture independent manner. Architectures
are expected to register active ranges of PFNs using add_active_range(nid,
start_pfn, end_pfn) and call free_area_init_nodes() passing the PFNs of
the end of each zone.


 include/linux/mm.h     |   45 +++
 include/linux/mmzone.h |   10 
 mm/page_alloc.c        |  557 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 586 insertions(+), 26 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Bob Picco <bob.picco@hp.com>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/include/linux/mm.h linux-2.6.17-mm6-101-add_free_area_init_nodes/include/linux/mm.h
--- linux-2.6.17-mm6-clean/include/linux/mm.h	2006-07-05 14:31:17.000000000 +0100
+++ linux-2.6.17-mm6-101-add_free_area_init_nodes/include/linux/mm.h	2006-07-06 11:04:22.000000000 +0100
@@ -960,6 +960,51 @@ extern void free_area_init(unsigned long
 extern void free_area_init_node(int nid, pg_data_t *pgdat,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+/*
+ * With CONFIG_ARCH_POPULATES_NODE_MAP set, an architecture may initialise its
+ * zones, allocate the backing mem_map and account for memory holes in a more
+ * architecture independent manner. This is a substitute for creating the
+ * zone_sizes[] and zholes_size[] arrays and passing them to
+ * free_area_init_node()
+ *
+ * An architecture is expected to register range of page frames backed by
+ * physical memory with add_active_range() before calling
+ * free_area_init_nodes() passing in the PFN each zone ends at. At a basic
+ * usage, an architecture is expected to do something like
+ *
+ * for_each_valid_physical_page_range()
+ * 	add_active_range(node_id, start_pfn, end_pfn)
+ * free_area_init_nodes(max_dma, max_dma32, max_normal_pfn, max_highmem_pfn);
+ *
+ * If the architecture guarantees that there are no holes in the ranges
+ * registered with add_active_range(), free_bootmem_active_regions()
+ * will call free_bootmem_node() for each registered physical page range.
+ * Similarly sparse_memory_present_with_active_regions() calls
+ * memory_present() for each range when SPARSEMEM is enabled.
+ *
+ * See mm/page_alloc.c for more information on each function exposed by
+ * CONFIG_ARCH_POPULATES_NODE_MAP
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
+extern void free_bootmem_with_active_regions(int nid,
+						unsigned long max_low_pfn);
+extern void sparse_memory_present_with_active_regions(int nid);
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/include/linux/mmzone.h linux-2.6.17-mm6-101-add_free_area_init_nodes/include/linux/mmzone.h
--- linux-2.6.17-mm6-clean/include/linux/mmzone.h	2006-07-05 14:31:17.000000000 +0100
+++ linux-2.6.17-mm6-101-add_free_area_init_nodes/include/linux/mmzone.h	2006-07-06 11:04:22.000000000 +0100
@@ -293,6 +293,13 @@ struct zonelist {
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
@@ -493,7 +500,8 @@ extern struct zone *next_zone(struct zon
 
 #endif
 
-#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+#if !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) && \
+	!defined(CONFIG_ARCH_POPULATES_NODE_MAP)
 #define early_pfn_to_nid(nid)  (0UL)
 #endif
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/mm/page_alloc.c linux-2.6.17-mm6-101-add_free_area_init_nodes/mm/page_alloc.c
--- linux-2.6.17-mm6-clean/mm/page_alloc.c	2006-07-05 14:31:18.000000000 +0100
+++ linux-2.6.17-mm6-101-add_free_area_init_nodes/mm/page_alloc.c	2006-07-06 21:44:44.000000000 +0100
@@ -37,6 +37,8 @@
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
 #include <linux/stop_machine.h>
+#include <linux/sort.h>
+#include <linux/pfn.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -86,6 +88,33 @@ int min_free_kbytes = 1024;
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+  /*
+   * MAX_ACTIVE_REGIONS determines the maxmimum number of distinct
+   * ranges of memory (RAM) that may be registered with add_active_range().
+   * Ranges passed to add_active_range() will be merged if possible
+   * so the number of times add_active_range() can be called is
+   * related to the number of nodes and the number of holes
+   */
+  #ifdef CONFIG_MAX_ACTIVE_REGIONS
+    /* Allow an architecture to set MAX_ACTIVE_REGIONS to save memory */
+    #define MAX_ACTIVE_REGIONS CONFIG_MAX_ACTIVE_REGIONS
+  #else
+    #if MAX_NUMNODES >= 32
+      /* If there can be many nodes, allow up to 50 holes per node */
+      #define MAX_ACTIVE_REGIONS (MAX_NUMNODES*50)
+    #else
+      /* By default, allow up to 256 distinct regions */
+      #define MAX_ACTIVE_REGIONS 256
+    #endif
+  #endif
+
+  struct node_active_region __initdata early_node_map[MAX_ACTIVE_REGIONS];
+  int __initdata nr_nodemap_entries;
+  unsigned long __initdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
+  unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -1728,25 +1757,6 @@ static inline unsigned long wait_table_b
 
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
@@ -2064,6 +2074,272 @@ __meminit int init_currently_empty_zone(
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+/*
+ * Basic iterator support. Return the first range of PFNs for a node
+ * Note: nid == MAX_NUMNODES returns first region regardless of node
+ */
+static int __init first_active_region_index_in_nid(int nid)
+{
+	int i;
+
+	for (i = 0; i < nr_nodemap_entries; i++)
+		if (nid == MAX_NUMNODES || early_node_map[i].nid == nid)
+			return i;
+
+	return -1;
+}
+
+/*
+ * Basic iterator support. Return the next active range of PFNs for a node
+ * Note: nid == MAX_NUMNODES returns next region regardles of node
+ */
+static int __init next_active_region_index_in_nid(int index, int nid)
+{
+	for (index = index + 1; index < nr_nodemap_entries; index++)
+		if (nid == MAX_NUMNODES || early_node_map[index].nid == nid)
+			return index;
+
+	return -1;
+}
+
+#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+/*
+ * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
+ * Architectures may implement their own version but if add_active_range()
+ * was used and there are no special requirements, this is a convenient
+ * alternative
+ */
+int __init early_pfn_to_nid(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; i < nr_nodemap_entries; i++) {
+		unsigned long start_pfn = early_node_map[i].start_pfn;
+		unsigned long end_pfn = early_node_map[i].end_pfn;
+
+		if (start_pfn <= pfn && pfn < end_pfn)
+			return early_node_map[i].nid;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
+
+/* Basic iterator support to walk early_node_map[] */
+#define for_each_active_range_index_in_nid(i, nid) \
+	for (i = first_active_region_index_in_nid(nid); i != -1; \
+				i = next_active_region_index_in_nid(i, nid))
+
+/**
+ * free_bootmem_with_active_regions - Call free_bootmem_node for each active range
+ * @nid: The node to free memory on. If MAX_NUMNODES, all nodes are freed
+ * @max_low_pfn: The highest PFN that till be passed to free_bootmem_node
+ *
+ * If an architecture guarantees that all ranges registered with
+ * add_active_ranges() contain no holes and may be freed, this
+ * this function may be used instead of calling free_bootmem() manually.
+ */
+void __init free_bootmem_with_active_regions(int nid,
+						unsigned long max_low_pfn)
+{
+	int i;
+
+	for_each_active_range_index_in_nid(i, nid) {
+		unsigned long size_pages = 0;
+		unsigned long end_pfn = early_node_map[i].end_pfn;
+
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
+/**
+ * sparse_memory_present_with_active_regions - Call memory_present for each active range
+ * @nid: The node to call memory_present for. If MAX_NUMNODES, all nodes will be used
+ *
+ * If an architecture guarantees that all ranges registered with
+ * add_active_ranges() contain no holes and may be freed, this
+ * this function may be used instead of calling memory_present() manually.
+ */
+void __init sparse_memory_present_with_active_regions(int nid)
+{
+	int i;
+
+	for_each_active_range_index_in_nid(i, nid)
+		memory_present(early_node_map[i].nid,
+				early_node_map[i].start_pfn,
+				early_node_map[i].end_pfn);
+}
+
+/**
+ * get_pfn_range_for_nid - Return the start and end page frames for a node
+ * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned
+ * @start_pfn: Passed by reference. On return, it will have the node start_pfn
+ * @end_pfn: Passed by reference. On return, it will have the node end_pfn
+ *
+ * It returns the start and end page frame of a node based on information
+ * provided by an arch calling add_active_range(). If called for a node
+ * with no available memory, a warning is printed and the start and end
+ * PFNs will be 0
+ */
+void __init get_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	int i;
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
+/*
+ * Return the number of pages a zone spans in a node, including holes
+ * present_pages = zone_spanned_pages_in_node() - zone_absent_pages_in_node()
+ */
+unsigned long __init zone_spanned_pages_in_node(int nid,
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
+/*
+ * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
+ * then all holes in the requested range will be accounted for
+ */
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
+	if (i == -1)
+		return 0;
+
+	prev_end_pfn = early_node_map[i].start_pfn;
+
+	/* Find all holes for the zone within the node */
+	for (; i != -1; i = next_active_region_index_in_nid(i, nid)) {
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
+/**
+ * absent_pages_in_range - Return number of page frames in holes within a range
+ * @start_pfn: The start PFN to start searching for holes
+ * @end_pfn: The end PFN to stop searching for holes
+ *
+ * It returns the number of pages frames in memory holes within a range
+ */
+unsigned long __init absent_pages_in_range(unsigned long start_pfn,
+							unsigned long end_pfn)
+{
+	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
+}
+
+/* Return the number of page frames in holes in a zone on a node */
+unsigned long __init zone_absent_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *ignored)
+{
+	return __absent_pages_in_range(nid,
+				arch_zone_lowest_possible_pfn[zone_type],
+				arch_zone_highest_possible_pfn[zone_type]);
+}
+#else
+static inline unsigned long zone_spanned_pages_in_node(int nid,
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
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		totalpages += zone_spanned_pages_in_node(pgdat->node_id, i,
+								zones_size);
+	pgdat->node_spanned_pages = totalpages;
+
+	realtotalpages = totalpages;
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		realtotalpages -=
+			zone_absent_pages_in_node(pgdat->node_id, i,
+								zholes_size);
+	pgdat->node_present_pages = realtotalpages;
+	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id,
+							realtotalpages);
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -2087,10 +2363,9 @@ static void __meminit free_area_init_cor
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 
-		realsize = size = zones_size[j];
-		if (zholes_size)
-			realsize -= zholes_size[j];
-
+		size = zone_spanned_pages_in_node(nid, j, zones_size);
+		realsize = size - zone_absent_pages_in_node(nid, j,
+								zholes_size);
 		if (j < ZONE_HIGHMEM)
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
@@ -2159,8 +2434,13 @@ static void __init alloc_node_mem_map(st
 	/*
 	 * With no DISCONTIG, the global mem_map is just set as node 0's
 	 */
-	if (pgdat == NODE_DATA(0))
+	if (pgdat == NODE_DATA(0)) {
 		mem_map = NODE_DATA(0)->node_mem_map;
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+		if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
+			mem_map -= pgdat->node_start_pfn;
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+	}
 #endif
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
@@ -2171,13 +2451,240 @@ void __meminit free_area_init_node(int n
 {
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = node_start_pfn;
-	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
+	calculate_node_totalpages(pgdat, zones_size, zholes_size);
 
 	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
 
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+/**
+ * add_active_range - Register a range of PFNs backed by physical memory
+ * @nid: The node ID the range resides on
+ * @start_pfn: The start PFN of the available physical memory
+ * @end_pfn: The end PFN of the available physical memory
+ *
+ * These ranges are stored in an early_node_map[] and later used by
+ * free_area_init_nodes() to calculate zone sizes and holes. If the
+ * range spans a memory hole, it is up to the architecture to ensure
+ * the memory is not freed by the bootmem allocator. If possible
+ * the range being registered will be merged with existing ranges.
+ */
+void __init add_active_range(unsigned int nid, unsigned long start_pfn,
+						unsigned long end_pfn)
+{
+	int i;
+
+	printk(KERN_DEBUG "Entering add_active_range(%d, %lu, %lu) "
+			  "%d entries of %d used\n",
+			  nid, start_pfn, end_pfn,
+			  nr_nodemap_entries, MAX_ACTIVE_REGIONS);
+
+	/* Merge with existing active regions if possible */
+	for (i = 0; i < nr_nodemap_entries; i++) {
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
+	/* Check that early_node_map is large enough */
+	if (i >= MAX_ACTIVE_REGIONS) {
+		printk(KERN_CRIT "More than %d memory regions, truncating\n",
+							MAX_ACTIVE_REGIONS);
+		return;
+	}
+
+	early_node_map[i].nid = nid;
+	early_node_map[i].start_pfn = start_pfn;
+	early_node_map[i].end_pfn = end_pfn;
+	nr_nodemap_entries = i + 1;
+}
+
+/**
+ * shrink_active_range - Shrink an existing registered range of PFNs
+ * @nid: The node id the range is on that should be shrunk
+ * @old_end_pfn: The old end PFN of the range
+ * @new_end_pfn: The new PFN of the range
+ *
+ * i386 with NUMA use alloc_remap() to store a node_mem_map on a local node.
+ * The map is kept at the end physical page range that has already been
+ * registered with add_active_range(). This function allows an arch to shrink
+ * an existing registered range.
+ */
+void __init shrink_active_range(unsigned int nid, unsigned long old_end_pfn,
+						unsigned long new_end_pfn)
+{
+	int i;
+
+	/* Find the old active region end and shrink */
+	for_each_active_range_index_in_nid(i, nid)
+		if (early_node_map[i].end_pfn == old_end_pfn) {
+			early_node_map[i].end_pfn = new_end_pfn;
+			break;
+		}
+}
+
+/**
+ * remove_all_active_ranges - Remove all currently registered regions
+ * During discovery, it may be found that a table like SRAT is invalid
+ * and an alternative discovery method must be used. This function removes
+ * all currently registered regions.
+ */
+void __init remove_all_active_ranges()
+{
+	memset(early_node_map, 0, sizeof(early_node_map));
+	nr_nodemap_entries = 0;
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
+	sort(early_node_map, (size_t)nr_nodemap_entries,
+			sizeof(struct node_active_region),
+			cmp_node_active_region, NULL);
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
+/**
+ * find_min_pfn_with_active_regions - Find the minimum PFN registered
+ *
+ * It returns the minimum PFN based on information provided via
+ * add_active_range()
+ */
+unsigned long __init find_min_pfn_with_active_regions(void)
+{
+	return find_min_pfn_for_node(MAX_NUMNODES);
+}
+
+/**
+ * find_max_pfn_with_active_regions - Find the maximum PFN registered
+ *
+ * It returns the maximum PFN based on information provided via
+ * add_active_range()
+ */
+unsigned long __init find_max_pfn_with_active_regions(void)
+{
+	int i;
+	unsigned long max_pfn = 0;
+
+	for (i = 0; i < nr_nodemap_entries; i++)
+		max_pfn = max(max_pfn, early_node_map[i].end_pfn);
+
+	return max_pfn;
+}
+
+/**
+ * free_area_init_nodes - Initialise all pg_data_t and zone data
+ * @arch_max_dma_pfn: The maximum PFN usable for ZONE_DMA
+ * @arch_max_dma32_pfn: The maximum PFN usable for ZONE_DMA32
+ * @arch_max_low_pfn: The maximum PFN usable for ZONE_NORMAL
+ * @arch_max_high_pfn: The maximum PFN usable for ZONE_HIGHMEM
+ *
+ * This will call free_area_init_node() for each active node in the system.
+ * Using the page ranges provided by add_active_range(), the size of each
+ * zone in each node and their holes is calculated. If the maximum PFN
+ * between two adjacent zones match, it is assumed that the zone is empty.
+ * For example, if arch_max_dma_pfn == arch_max_dma32_pfn, it is assumed
+ * that arch_max_dma32_pfn has no pages. It is also assumed that a zone
+ * starts where the previous one ended. For example, ZONE_DMA32 starts
+ * at arch_max_dma_pfn.
+ */
+void __init free_area_init_nodes(unsigned long arch_max_dma_pfn,
+				unsigned long arch_max_dma32_pfn,
+				unsigned long arch_max_low_pfn,
+				unsigned long arch_max_high_pfn)
+{
+	unsigned long nid;
+	int i;
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
+	for (i = 1; i < MAX_NR_ZONES; i++)
+		arch_zone_lowest_possible_pfn[i] =
+			arch_zone_highest_possible_pfn[i-1];
+
+	/* Regions in the early_node_map can be in any order */
+	sort_node_map();
+
+	/* Print out the zone ranges */
+	printk("Zone PFN ranges:\n");
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		printk("  %-8s %8lu -> %8lu\n",
+				zone_names[i],
+				arch_zone_lowest_possible_pfn[i],
+				arch_zone_highest_possible_pfn[i]);
+
+	/* Print out the early_node_map[] */
+	printk("early_node_map[%d] active PFN ranges\n", nr_nodemap_entries);
+	for (i = 0; i < nr_nodemap_entries; i++)
+		printk("  %3d: %8lu -> %8lu\n", early_node_map[i].nid,
+						early_node_map[i].start_pfn,
+						early_node_map[i].end_pfn);
+
+	/* Initialise every node */
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
