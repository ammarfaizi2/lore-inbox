Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWGHLMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWGHLMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWGHLMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:12:54 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:17594 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932370AbWGHLMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:12:44 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Message-Id: <20060708111243.28664.74956.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
References: <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 6/6] Account for memmap and optionally the kernel image as holes
Date: Sat,  8 Jul 2006 12:12:43 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The x86_64 code accounted for memmap and some portions of the the DMA zone
as holes. This was because those areas would never be reclaimed and accounting
for them as memory affects min watermarks. This patch will account for the
memmap as a memory hole. Architectures may optionally use set_dma_reserve() if
they wish to account for a portion of memory in ZONE_DMA as a hole.

 arch/x86_64/mm/init.c |    4 +
 include/linux/mm.h    |    1 
 mm/page_alloc.c       |   96 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-105-ia64_use_init_nodes/arch/x86_64/mm/init.c linux-2.6.17-mm6-106-account_kernel_mmap/arch/x86_64/mm/init.c
--- linux-2.6.17-mm6-105-ia64_use_init_nodes/arch/x86_64/mm/init.c	2006-07-06 11:09:46.000000000 +0100
+++ linux-2.6.17-mm6-106-account_kernel_mmap/arch/x86_64/mm/init.c	2006-07-06 11:13:22.000000000 +0100
@@ -658,8 +658,10 @@ void __init reserve_bootmem_generic(unsi
 #else       		
 	reserve_bootmem(phys, len);    
 #endif
-	if (phys+len <= MAX_DMA_PFN*PAGE_SIZE)
+	if (phys+len <= MAX_DMA_PFN*PAGE_SIZE) {
 		dma_reserve += len / PAGE_SIZE;
+		set_dma_reserve(dma_reserve);
+	}
 }
 
 int kern_addr_valid(unsigned long addr) 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-105-ia64_use_init_nodes/include/linux/mm.h linux-2.6.17-mm6-106-account_kernel_mmap/include/linux/mm.h
--- linux-2.6.17-mm6-105-ia64_use_init_nodes/include/linux/mm.h	2006-07-06 11:04:22.000000000 +0100
+++ linux-2.6.17-mm6-106-account_kernel_mmap/include/linux/mm.h	2006-07-06 11:13:22.000000000 +0100
@@ -1005,6 +1005,7 @@ extern void free_bootmem_with_active_reg
 						unsigned long max_low_pfn);
 extern void sparse_memory_present_with_active_regions(int nid);
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-105-ia64_use_init_nodes/mm/page_alloc.c linux-2.6.17-mm6-106-account_kernel_mmap/mm/page_alloc.c
--- linux-2.6.17-mm6-105-ia64_use_init_nodes/mm/page_alloc.c	2006-07-06 21:44:44.000000000 +0100
+++ linux-2.6.17-mm6-106-account_kernel_mmap/mm/page_alloc.c	2006-07-06 11:13:22.000000000 +0100
@@ -87,6 +87,7 @@ int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
+unsigned long __initdata dma_reserve;
 
 #ifdef CONFIG_ARCH_POPULATES_NODE_MAP
   /*
@@ -2300,6 +2301,20 @@ unsigned long __init zone_absent_pages_i
 				arch_zone_lowest_possible_pfn[zone_type],
 				arch_zone_highest_possible_pfn[zone_type]);
 }
+
+/* Return the zone index a PFN is in */
+int memmap_zone_idx(struct page *lmem_map)
+{
+	int i;
+	unsigned long phys_addr = virt_to_phys(lmem_map);
+	unsigned long pfn = phys_addr >> PAGE_SHIFT;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		if (pfn < arch_zone_highest_possible_pfn[i])
+			break;
+
+	return i;
+}
 #else
 static inline unsigned long zone_spanned_pages_in_node(int nid,
 					unsigned long zone_type,
@@ -2317,6 +2332,11 @@ static inline unsigned long zone_absent_
 
 	return zholes_size[zone_type];
 }
+
+static inline int memmap_zone_idx(struct page *lmem_map)
+{
+	return MAX_NR_ZONES;
+}
 #endif
 
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
@@ -2340,6 +2360,58 @@ static void __init calculate_node_totalp
 							realtotalpages);
 }
 
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
+/* Account for mem_map for CONFIG_FLAT_NODE_MEM_MAP */
+unsigned long __meminit account_memmap(struct pglist_data *pgdat,
+						int zone_index)
+{
+	unsigned long pages = 0;
+	if (zone_index == memmap_zone_idx(pgdat->node_mem_map)) {
+		pages = pgdat->node_spanned_pages;
+		pages = (pages * sizeof(struct page)) >> PAGE_SHIFT;
+		printk(KERN_DEBUG "%lu pages used for memmap\n", pages);
+	}
+	return pages;
+}
+#else
+/* Account for mem_map for CONFIG_SPARSEMEM */
+unsigned long account_memmap(struct pglist_data *pgdat, int zone_index)
+{
+	unsigned long pages = 0;
+	unsigned long memmap_pfn;
+	struct page *memmap_addr;
+	int pnum;
+	unsigned long pgdat_startpfn, pgdat_endpfn;
+	struct mem_section *section;
+
+	pgdat_startpfn = pgdat->node_start_pfn;
+	pgdat_endpfn = pgdat_startpfn + pgdat->node_spanned_pages;
+
+	/* Go through valid sections looking for memmap */
+	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
+		if (!valid_section_nr(pnum))
+			continue;
+
+		section = __nr_to_section(pnum);
+		if (!section_has_mem_map(section))
+			continue;
+
+		memmap_addr = __section_mem_map_addr(section);
+		memmap_pfn = (unsigned long)memmap_addr >> PAGE_SHIFT;
+
+		if (memmap_pfn < pgdat_startpfn || memmap_pfn >= pgdat_endpfn)
+			continue;
+
+		if (zone_index == memmap_zone_idx(memmap_addr))
+			pages += (PAGES_PER_SECTION * sizeof(struct page));
+	}
+
+	pages >>= PAGE_SHIFT;
+	printk(KERN_DEBUG "%lu pages used for SPARSE memmap\n", pages);
+	return pages;
+}
+#endif
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -2366,6 +2438,15 @@ static void __meminit free_area_init_cor
 		size = zone_spanned_pages_in_node(nid, j, zones_size);
 		realsize = size - zone_absent_pages_in_node(nid, j,
 								zholes_size);
+
+		realsize -= account_memmap(pgdat, j);
+		/* Account for reserved DMA pages */
+		if (j == ZONE_DMA && realsize > dma_reserve) {
+			realsize -= dma_reserve;
+			printk(KERN_DEBUG "%lu pages DMA reserved\n",
+								dma_reserve);
+		}
+
 		if (j < ZONE_HIGHMEM)
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
@@ -2685,6 +2761,21 @@ void __init free_area_init_nodes(unsigne
 }
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
+/**
+ * set_dma_reserve - Account the specified number of pages reserved in ZONE_DMA
+ * @new_dma_reserve - The number of pages to mark reserved
+ *
+ * The per-cpu batchsize and zone watermarks are determined by present_pages.
+ * In the DMA zone, a significant percentage may be consumed by kernel image
+ * and other unfreeable allocations which can skew the watermarks badly. This
+ * function may optionally be used to account for unfreeable pages in
+ * ZONE_DMA. The effect will be lower watermarks and smaller per-cpu batchsize
+ */
+void __init set_dma_reserve(unsigned long new_dma_reserve)
+{
+	dma_reserve = new_dma_reserve;
+}
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 static bootmem_data_t contig_bootmem_data;
 struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
