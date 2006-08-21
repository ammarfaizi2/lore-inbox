Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWHUNrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWHUNrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWHUNrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:47:21 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:7890 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1030471AbWHUNrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:47:19 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, tony.luck@intel.com, linux-mm@kvack.org,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Message-Id: <20060821134718.22179.30422.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 6/6] Account for memmap and optionally the kernel image as holes
Date: Mon, 21 Aug 2006 14:47:18 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The x86_64 code accounted for memmap and some portions of the the DMA zone
as holes. This was because those areas would never be reclaimed and accounting
for them as memory affects min watermarks. This patch will account for the
memmap as a memory hole. Architectures may optionally use set_dma_reserve() if
they wish to account for a portion of memory in ZONE_DMA as a hole.

 arch/x86_64/mm/init.c |    4 +
 include/linux/mm.h    |    1 
 mm/page_alloc.c       |   95 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm2-105-ia64_use_init_nodes/arch/x86_64/mm/init.c linux-2.6.18-rc4-mm2-106-account_kernel_mmap/arch/x86_64/mm/init.c
--- linux-2.6.18-rc4-mm2-105-ia64_use_init_nodes/arch/x86_64/mm/init.c	2006-08-21 10:15:58.000000000 +0100
+++ linux-2.6.18-rc4-mm2-106-account_kernel_mmap/arch/x86_64/mm/init.c	2006-08-21 10:18:23.000000000 +0100
@@ -660,8 +660,10 @@ void __init reserve_bootmem_generic(unsi
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
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm2-105-ia64_use_init_nodes/include/linux/mm.h linux-2.6.18-rc4-mm2-106-account_kernel_mmap/include/linux/mm.h
--- linux-2.6.18-rc4-mm2-105-ia64_use_init_nodes/include/linux/mm.h	2006-08-21 10:12:12.000000000 +0100
+++ linux-2.6.18-rc4-mm2-106-account_kernel_mmap/include/linux/mm.h	2006-08-21 10:18:23.000000000 +0100
@@ -1021,6 +1021,7 @@ extern void sparse_memory_present_with_a
 extern int early_pfn_to_nid(unsigned long pfn);
 #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm2-105-ia64_use_init_nodes/mm/page_alloc.c linux-2.6.18-rc4-mm2-106-account_kernel_mmap/mm/page_alloc.c
--- linux-2.6.18-rc4-mm2-105-ia64_use_init_nodes/mm/page_alloc.c	2006-08-21 10:12:12.000000000 +0100
+++ linux-2.6.18-rc4-mm2-106-account_kernel_mmap/mm/page_alloc.c	2006-08-21 10:18:23.000000000 +0100
@@ -104,6 +104,7 @@ int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
+static unsigned long __initdata dma_reserve;
 
 #ifdef CONFIG_ARCH_POPULATES_NODE_MAP
   /*
@@ -2303,6 +2304,20 @@ unsigned long __init zone_absent_pages_i
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
@@ -2320,6 +2335,11 @@ static inline unsigned long zone_absent_
 
 	return zholes_size[zone_type];
 }
+
+static inline int memmap_zone_idx(struct page *lmem_map)
+{
+	return MAX_NR_ZONES;
+}
 #endif
 
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
@@ -2343,6 +2363,58 @@ static void __init calculate_node_totalp
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
@@ -2370,6 +2442,14 @@ static void __meminit free_area_init_cor
 		realsize = size - zone_absent_pages_in_node(nid, j,
 								zholes_size);
 
+		realsize -= account_memmap(pgdat, j);
+		/* Account for reserved DMA pages */
+		if (j == ZONE_DMA && realsize > dma_reserve) {
+			realsize -= dma_reserve;
+			printk(KERN_DEBUG "%lu pages DMA reserved\n",
+								dma_reserve);
+		}
+
 		if (!is_highmem_idx(j))
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
@@ -2685,6 +2765,21 @@ void __init free_area_init_nodes(unsigne
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
