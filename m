Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWFIM5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWFIM5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 08:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWFIM5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 08:57:47 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:17632 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S965249AbWFIM5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 08:57:46 -0400
Date: Fri, 9 Jun 2006 13:57:43 +0100
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       tony.luck@intel.com, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent manner V7
Message-ID: <20060609125742.GA31718@skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie> <200606071216.24640.ak@suse.de> <Pine.LNX.4.64.0606071118230.20653@skynet.skynet.ie> <200606071720.22242.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200606071720.22242.ak@suse.de>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/06/06 17:20), Andi Kleen didst pronounce:
> 
> > Ok, while true, I'm not sure how it affects performance. The only "real" 
> > value affected by present_pages is the number of patches that are 
> > allocated in batches to the per-cpu allocator.
> 
> It affects the low/high water marks in the VM zone balancer.
> 
> Especially for the 16MB DMA zone it can make a difference if you
> account 4MB kernel in there or not.
> 

Ok, the following patch will account for memmap usage on all
architectures. Optionally, a set_dma_reserve() may be called to account
for pages in ZONE_DMA that will never be usable. In this patch, only
x86_64 uses it.

After this patch is applied, the zone->present_pages figures are very
similar before and after arch-independent zone-sizing and the watermarks
are the same.


diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc6-mm1-105-ia64_use_init_nodes/arch/x86_64/mm/init.c linux-2.6.17-rc6-mm1-106-account_kernel_mmap/arch/x86_64/mm/init.c
--- linux-2.6.17-rc6-mm1-105-ia64_use_init_nodes/arch/x86_64/mm/init.c	2006-06-08 13:45:07.000000000 +0100
+++ linux-2.6.17-rc6-mm1-106-account_kernel_mmap/arch/x86_64/mm/init.c	2006-06-09 09:18:55.000000000 +0100
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
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc6-mm1-105-ia64_use_init_nodes/include/linux/mm.h linux-2.6.17-rc6-mm1-106-account_kernel_mmap/include/linux/mm.h
--- linux-2.6.17-rc6-mm1-105-ia64_use_init_nodes/include/linux/mm.h	2006-06-08 13:42:53.000000000 +0100
+++ linux-2.6.17-rc6-mm1-106-account_kernel_mmap/include/linux/mm.h	2006-06-09 09:18:55.000000000 +0100
@@ -969,6 +969,7 @@ extern void free_bootmem_with_active_reg
 						unsigned long max_low_pfn);
 extern void sparse_memory_present_with_active_regions(int nid);
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc6-mm1-105-ia64_use_init_nodes/mm/page_alloc.c linux-2.6.17-rc6-mm1-106-account_kernel_mmap/mm/page_alloc.c
--- linux-2.6.17-rc6-mm1-105-ia64_use_init_nodes/mm/page_alloc.c	2006-06-08 13:42:53.000000000 +0100
+++ linux-2.6.17-rc6-mm1-106-account_kernel_mmap/mm/page_alloc.c	2006-06-09 09:18:55.000000000 +0100
@@ -88,6 +88,7 @@ int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
+unsigned long __initdata dma_reserve;
 
 #ifdef CONFIG_ARCH_POPULATES_NODE_MAP
   /*
@@ -2459,6 +2460,20 @@ unsigned long __init zone_absent_pages_i
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
@@ -2476,6 +2491,11 @@ static inline unsigned long zone_absent_
 
 	return zholes_size[zone_type];
 }
+
+static inline int memmap_zone_idx(struct page *lmem_map)
+{
+	return MAX_NR_ZONES;
+}
 #endif
 
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
@@ -2499,6 +2519,58 @@ static void __init calculate_node_totalp
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
@@ -2525,6 +2597,15 @@ static void __meminit free_area_init_cor
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
@@ -2849,6 +2930,21 @@ void __init free_area_init_nodes(unsigne
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

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
