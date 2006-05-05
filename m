Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWEERfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWEERfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWEERff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:35:35 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:42372 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751674AbWEERfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:35:30 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173526.9030.84928.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 2/8] Create the ZONE_EASYRCLM zone
Date: Fri,  5 May 2006 18:35:26 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the ZONE_EASYRCLM zone and updates relevant contants and
helper functions. After this patch is applied, memory that is hot-added on
the x86 will be placed in ZONE_EASYRCLM. Memory hot-added on the ppc64 still
goes to ZONE_DMA.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/arch/i386/kernel/srat.c linux-2.6.17-rc3-mm1-zonesizing-102_addzone/arch/i386/kernel/srat.c
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/arch/i386/kernel/srat.c	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/arch/i386/kernel/srat.c	2006-05-03 09:46:37.000000000 +0100
@@ -43,7 +43,7 @@
 #define PXM_BITMAP_LEN (MAX_PXM_DOMAINS / 8) 
 static u8 pxm_bitmap[PXM_BITMAP_LEN];	/* bitmap of proximity domains */
 
-#define MAX_CHUNKS_PER_NODE	4
+#define MAX_CHUNKS_PER_NODE	5
 #define MAXCHUNKS		(MAX_CHUNKS_PER_NODE * MAX_NUMNODES)
 struct node_memory_chunk_s {
 	unsigned long	start_pfn;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/arch/x86_64/mm/init.c linux-2.6.17-rc3-mm1-zonesizing-102_addzone/arch/x86_64/mm/init.c
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/arch/x86_64/mm/init.c	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/arch/x86_64/mm/init.c	2006-05-03 09:46:37.000000000 +0100
@@ -482,7 +482,7 @@ int memory_add_physaddr_to_nid(u64 start
 int arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
-	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
+	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-3;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/ntfs/malloc.h linux-2.6.17-rc3-mm1-zonesizing-102_addzone/fs/ntfs/malloc.h
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/fs/ntfs/malloc.h	2006-05-03 09:41:32.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/fs/ntfs/malloc.h	2006-05-05 14:34:38.000000000 +0100
@@ -44,7 +44,8 @@ static inline void *__ntfs_malloc(unsign
 	if (likely(size <= PAGE_SIZE)) {
 		BUG_ON(!size);
 		/* kmalloc() has per-CPU caches so is faster for now. */
-		return kmalloc(PAGE_SIZE, gfp_mask & ~__GFP_HIGHMEM);
+		return kmalloc(PAGE_SIZE, gfp_mask & 
+					~(__GFP_HIGHMEM | __GFP_EASYRCLM));
 		/* return (void *)__get_free_page(gfp_mask); */
 	}
 	if (likely(size >> PAGE_SHIFT < num_physpages))
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/mm.h linux-2.6.17-rc3-mm1-zonesizing-102_addzone/include/linux/mm.h
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/mm.h	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/include/linux/mm.h	2006-05-03 09:46:37.000000000 +0100
@@ -949,6 +949,7 @@ extern int early_pfn_to_nid(unsigned lon
 extern void free_bootmem_with_active_regions(int nid,
 						unsigned long max_low_pfn);
 extern void sparse_memory_present_with_active_regions(int nid);
+extern void set_required_kernelcore(unsigned long kernelcore_pfn);
 #endif
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void setup_per_zone_pages_min(void);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/mmzone.h linux-2.6.17-rc3-mm1-zonesizing-102_addzone/include/linux/mmzone.h
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/include/linux/mmzone.h	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/include/linux/mmzone.h	2006-05-03 09:46:37.000000000 +0100
@@ -74,9 +74,10 @@ struct per_cpu_pageset {
 #define ZONE_DMA32		1
 #define ZONE_NORMAL		2
 #define ZONE_HIGHMEM		3
+#define ZONE_EASYRCLM		4
 
-#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
-#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+#define MAX_NR_ZONES		5	/* Sync this with ZONES_SHIFT */
+#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
 
 
 /*
@@ -104,7 +105,7 @@ struct per_cpu_pageset {
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
-#define GFP_ZONEMASK	0x07
+#define GFP_ZONEMASK	0x0f
 /* #define GFP_ZONETYPES       (GFP_ZONEMASK + 1) */           /* Non-loner */
 #define GFP_ZONETYPES  ((GFP_ZONEMASK + 1) / 2 + 1)            /* Loner */
 
@@ -364,7 +365,7 @@ static inline int populated_zone(struct 
 
 static inline int is_highmem_idx(int idx)
 {
-	return (idx == ZONE_HIGHMEM);
+	return (idx == ZONE_HIGHMEM || idx == ZONE_EASYRCLM);
 }
 
 static inline int is_normal_idx(int idx)
@@ -380,7 +381,8 @@ static inline int is_normal_idx(int idx)
  */
 static inline int is_highmem(struct zone *zone)
 {
-	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM;
+	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM ||
+		zone == zone->zone_pgdat->node_zones + ZONE_EASYRCLM;
 }
 
 static inline int is_normal(struct zone *zone)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/mem_init.c linux-2.6.17-rc3-mm1-zonesizing-102_addzone/mm/mem_init.c
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/mem_init.c	2006-05-03 09:42:17.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/mm/mem_init.c	2006-05-05 08:30:46.000000000 +0100
@@ -24,7 +24,8 @@
 #include <linux/cpu.h>
 #include <linux/stop_machine.h>
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal",
+						"HighMem", "EasyRclm" };
 int percpu_pagelist_fraction;
 
 #ifdef CONFIG_ARCH_POPULATES_NODE_MAP
@@ -37,6 +38,8 @@ int percpu_pagelist_fraction;
   struct node_active_region __initdata early_node_map[MAX_ACTIVE_REGIONS];
   unsigned long __initdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
   unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
+  unsigned long __initdata required_kernelcore;
+  unsigned long __initdata easyrclm_pfn[MAX_NUMNODES];
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
 /*
@@ -49,13 +52,17 @@ static int __meminit build_zonelists_nod
 {
 	struct zone *zone;
 
-	BUG_ON(zone_type > ZONE_HIGHMEM);
+	BUG_ON(zone_type > ZONE_EASYRCLM);
 
 	do {
 		zone = pgdat->node_zones + zone_type;
 		if (populated_zone(zone)) {
 #ifndef CONFIG_HIGHMEM
-			BUG_ON(zone_type > ZONE_NORMAL);
+			/*
+			 * On architectures with only ZONE_DMA, it is still
+			 * valid to have a ZONE_EASYRCLM
+			 */
+			BUG_ON(zone_type == ZONE_HIGHMEM);
 #endif
 			zonelist->zones[nr_zones++] = zone;
 			check_highest_zone(zone_type);
@@ -69,6 +76,8 @@ static int __meminit build_zonelists_nod
 static inline int highest_zone(int zone_bits)
 {
 	int res = ZONE_NORMAL;
+	if (zone_bits & (__force int)__GFP_EASYRCLM)
+		res = ZONE_EASYRCLM;
 	if (zone_bits & (__force int)__GFP_HIGHMEM)
 		res = ZONE_HIGHMEM;
 	if (zone_bits & (__force int)__GFP_DMA32)
@@ -773,6 +782,44 @@ void __init get_pfn_range_for_nid(unsign
 	}
 }
 
+/* Return the highest zone that can be used for EASYRCLM pages */
+unsigned long __init highest_usable_zone(void)
+{
+	int zone_index;
+	for (zone_index = MAX_NR_ZONES - 1; zone_index >= 0; zone_index--) {
+		if (arch_zone_highest_possible_pfn[zone_index] >
+				arch_zone_lowest_possible_pfn[zone_index])
+			break;
+	}
+
+	BUG_ON(zone_index == -1);
+	return zone_index;
+}
+
+void __init adjust_zone_range_for_easyrclm(int nid,
+					unsigned long zone_type,
+					unsigned long *zone_start_pfn,
+					unsigned long *zone_end_pfn)
+{
+	/* Adjust the zone range to take EASYRCLM into account */
+	if (easyrclm_pfn[nid]) {
+		unsigned long usable_zone = highest_usable_zone();
+		/* Size ZONE_EASYRCLM */
+		if (zone_type == ZONE_EASYRCLM) {
+			*zone_start_pfn = easyrclm_pfn[nid];
+			*zone_end_pfn =
+				arch_zone_highest_possible_pfn[usable_zone];
+
+		/* Adjust for ZONE_EASYRCLM starting within this range */
+		} else if (*zone_start_pfn < easyrclm_pfn[nid] &&
+				*zone_end_pfn > easyrclm_pfn[nid]) {
+			*zone_end_pfn = easyrclm_pfn[nid];
+
+		/* Check if this whole range is within ZONE_EASYRCLM */
+		} else if (*zone_start_pfn >= easyrclm_pfn[nid])
+			*zone_start_pfn = *zone_end_pfn;
+	}
+}
 unsigned long __init zone_present_pages_in_node(int nid,
 					unsigned long zone_type,
 					unsigned long *ignored)
@@ -784,6 +831,8 @@ unsigned long __init zone_present_pages_
 	get_pfn_range_for_nid(nid, &node_start_pfn, &node_end_pfn);
 	zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
 	zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
+	adjust_zone_range_for_easyrclm(nid, zone_type,
+			&zone_start_pfn, &zone_end_pfn);
 
 	/* Check that this node has pages within the zone's required range */
 	if (zone_end_pfn < node_start_pfn || zone_start_pfn > node_end_pfn)
@@ -794,6 +843,8 @@ unsigned long __init zone_present_pages_
 	zone_start_pfn = max(zone_start_pfn, node_start_pfn);
 
 	/* Return the spanned pages */
+	printk("zone_present_pages_in_node(%d, %lu) = %lu\n", nid,
+					zone_type, zone_end_pfn - zone_start_pfn);
 	return zone_end_pfn - zone_start_pfn;
 }
 
@@ -805,8 +856,6 @@ unsigned long __init __absent_pages_in_r
 	unsigned long prev_end_pfn = 0, hole_pages = 0;
 	unsigned long start_pfn;
 
-	printk("__absent_pages_in_range(%d, %lu, %lu) = ", nid,
-					range_start_pfn, range_end_pfn);
 	/* Find the end_pfn of the first active range of pfns in the node */
 	i = first_active_region_index_in_nid(nid);
 	if (i == MAX_ACTIVE_REGIONS)
@@ -833,8 +882,6 @@ unsigned long __init __absent_pages_in_r
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 
-	printk("%lu\n", hole_pages);
-
 	return hole_pages;
 }
 
@@ -848,9 +895,13 @@ unsigned long __init zone_absent_pages_i
 					unsigned long zone_type,
 					unsigned long *ignored)
 {
-	return __absent_pages_in_range(nid,
-				arch_zone_lowest_possible_pfn[zone_type],
-				arch_zone_highest_possible_pfn[zone_type]);
+	unsigned long zone_start_pfn, zone_end_pfn;
+	zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
+	zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
+	adjust_zone_range_for_easyrclm(nid, zone_type,
+			&zone_start_pfn, &zone_end_pfn);
+
+	return __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
 }
 #else
 static inline unsigned long zone_present_pages_in_node(int nid,
@@ -1121,18 +1172,122 @@ unsigned long __init find_min_pfn_with_a
 	return find_min_pfn_for_node(MAX_NUMNODES);
 }
 
-unsigned long __init find_max_pfn_with_active_regions(void)
+/* Find the highest pfn for a node. This depends on a sorted early_node_map */
+unsigned long __init find_max_pfn_for_node(unsigned long nid)
 {
 	int i;
 	unsigned long max_pfn = 0;
 
-	for (i = 0; early_node_map[i].end_pfn; i++)
+	/* Assuming a sorted map, the first range found has the starting pfn */
+	for_each_active_range_index_in_nid(i, nid)
 		max_pfn = max(max_pfn, early_node_map[i].end_pfn);
 
-	printk("find_max_pfn_with_active_regions() == %lu\n", max_pfn);
 	return max_pfn;
 }
 
+unsigned long __init find_max_pfn_with_active_regions(void)
+{
+	return find_max_pfn_for_node(MAX_NUMNODES);
+}
+
+/*
+ * Find the PFN the EasyRclm zone begins in each node for. Assumes
+ * that early_node_map is already sorted. In this function, an attempt
+ * is made to spread the kernel memory evenly between nodes
+ */
+void __init find_easyrclm_pfns_for_nodes(unsigned long *easyrclm_pfn)
+{
+	int i, j, nid, map_index;
+	int nids_seen[MAX_NUMNODES];
+	unsigned long num_active_nodes = 0;
+	unsigned long usable_startpfn;
+
+	/* If kernelcore was not specified, just return */
+	if (!required_kernelcore)
+		return;
+
+	/* Count the number of unique nodes in the system */
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		for (j = 0; j < num_active_nodes; j++) {
+			if (nids_seen[j] == early_node_map[i].nid)
+				break;
+		}
+
+		if (j == num_active_nodes) {
+			nids_seen[j] = early_node_map[i].nid;
+			num_active_nodes++;
+		}
+	}
+	printk("num_active_nodes = %lu\n", num_active_nodes);
+	printk("highest_usable_zone = %lu\n", highest_usable_zone());
+
+	usable_startpfn = arch_zone_lowest_possible_pfn[highest_usable_zone()];
+	printk("usable_startpfn = %lu\n", arch_zone_lowest_possible_pfn[highest_usable_zone()]);
+
+	/* Walk the early_node_map, finding where easyrclm pfn is */
+	for (map_index = 0; early_node_map[map_index].end_pfn; map_index++) {
+		unsigned long size_pages;
+		unsigned long start_pfn, end_pfn;
+		unsigned long node_max_pfn;
+		unsigned long kernelcore_required_node = 0;
+
+		nid = early_node_map[map_index].nid;
+		start_pfn = early_node_map[map_index].start_pfn;
+		end_pfn = early_node_map[map_index].end_pfn;
+		node_max_pfn = find_max_pfn_for_node(nid);
+
+		/* Check if this range is usable only by the kernel */
+		if (end_pfn < usable_startpfn) {
+			required_kernelcore -= min( (end_pfn - start_pfn),
+							required_kernelcore);
+			continue;
+		}
+
+recalc:
+		/* Divide the remaining required_kernelcore between nodes */
+		if (num_active_nodes > 0) {
+			kernelcore_required_node =
+				required_kernelcore / num_active_nodes;
+		}
+
+		/* Calculate usable pages for kernelcore in this range */
+		size_pages = end_pfn - start_pfn;
+		if (size_pages > kernelcore_required_node)
+			size_pages = kernelcore_required_node;
+
+		/* Set the easyrclm_pfn and update required_kernelcore */
+		if (required_kernelcore)
+			easyrclm_pfn[nid] = start_pfn + size_pages;
+		required_kernelcore -= size_pages;
+
+		/*
+		 * If easyrclm_pfn is currently using more than the usable
+		 * zone, then easyrclm_pfn to the start of the usable zone,
+		 * account for the additional pages used for kernelcore and
+		 * recalculate requirements
+		 */
+		if (easyrclm_pfn[nid] < usable_startpfn) {
+			size_pages = usable_startpfn - easyrclm_pfn[nid];
+			required_kernelcore -=
+				min(required_kernelcore, size_pages);
+			easyrclm_pfn[nid] = usable_startpfn;
+			start_pfn = usable_startpfn;
+			goto recalc;
+		}
+
+
+		/* If this node is now empty, stop counting it as active */
+		if (node_max_pfn == end_pfn)
+			num_active_nodes--;
+	}
+
+	/* Make sure all easyrclm pfns are within the usable zone */
+	for (nid = 0; i < MAX_NUMNODES; i++) {
+		if (easyrclm_pfn[nid] < usable_startpfn)
+			easyrclm_pfn[nid] = usable_startpfn;
+	}
+}
+
 void __init free_area_init_nodes(unsigned long arch_max_dma_pfn,
 				unsigned long arch_max_dma32_pfn,
 				unsigned long arch_max_low_pfn,
@@ -1154,7 +1309,8 @@ void __init free_area_init_nodes(unsigne
 					find_min_pfn_with_active_regions();
 	arch_zone_highest_possible_pfn[ZONE_DMA] = arch_max_dma_pfn;
 	arch_zone_highest_possible_pfn[ZONE_DMA32] = arch_max_dma32_pfn;
-	arch_zone_highest_possible_pfn[ZONE_NORMAL] = arch_max_low_pfn;
+	arch_zone_highest_possible_pfn[ZONE_NORMAL] = 
+				max(arch_max_dma32_pfn, arch_max_low_pfn);
 	arch_zone_highest_possible_pfn[ZONE_HIGHMEM] = arch_max_high_pfn;
 	for (zone_index = 1; zone_index < MAX_NR_ZONES; zone_index++) {
 		arch_zone_lowest_possible_pfn[zone_index] =
@@ -1163,13 +1319,26 @@ void __init free_area_init_nodes(unsigne
 
 	printk("free_area_init_nodes(): find_min_pfn = %lu\n", find_min_pfn_with_active_regions());
 
+	arch_zone_lowest_possible_pfn[ZONE_EASYRCLM] = 0;
+	arch_zone_highest_possible_pfn[ZONE_EASYRCLM] = 0;
+
 	/* Regions in the early_node_map can be in any order */
 	sort_node_map();
 
+	/* Find the PFNs that EasyRclm begins at in each node */
+	memset(easyrclm_pfn, 0, sizeof(easyrclm_pfn));
+	find_easyrclm_pfns_for_nodes(easyrclm_pfn);
+
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
 		free_area_init_node(nid, pgdat, NULL,
 				find_min_pfn_for_node(nid), NULL);
 	}
 }
+
+void __init set_required_kernelcore(unsigned long size_pfn)
+{
+	required_kernelcore = size_pfn;
+	printk("required_kernelcore = %lu\n", size_pfn);
+}
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/page_alloc.c linux-2.6.17-rc3-mm1-zonesizing-102_addzone/mm/page_alloc.c
--- linux-2.6.17-rc3-mm1-zonesizing-101_antifrag_flags/mm/page_alloc.c	2006-05-03 09:42:17.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-102_addzone/mm/page_alloc.c	2006-05-03 09:46:37.000000000 +0100
@@ -68,7 +68,7 @@ static void __free_pages_ok(struct page 
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -231,6 +231,8 @@ static inline void prep_zero_page(struct
 	int i;
 
 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_EASYRCLM))
+							== __GFP_EASYRCLM);
 	/*
 	 * clear_highpage() will use KM_USER0, so it's a bug to use __GFP_ZERO
 	 * and __GFP_HIGHMEM from hard or soft interrupt context.
@@ -1271,7 +1273,7 @@ unsigned int nr_free_buffer_pages(void)
  */
 unsigned int nr_free_pagecache_pages(void)
 {
-	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
+	return nr_free_zone_pages(gfp_zone(GFP_RCLMUSER));
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -1280,8 +1282,10 @@ unsigned int nr_free_highpages (void)
 	pg_data_t *pgdat;
 	unsigned int pages = 0;
 
-	for_each_online_pgdat(pgdat)
+	for_each_online_pgdat(pgdat) {
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		pages += pgdat->node_zones[ZONE_EASYRCLM].free_pages;
+	}
 
 	return pages;
 }
