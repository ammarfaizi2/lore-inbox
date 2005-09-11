Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVIKQ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVIKQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVIKQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:59:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751073AbVIKQ7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:59:21 -0400
Date: Sun, 11 Sep 2005 18:59:19 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [1/3] Add 4GB DMA32 zone
Message-ID: <43246267.mailL4R11PXCB@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 4GB DMA32 zone

Add a new 4GB GFP_DMA32 zone between the GFP_DMA and GFP_NORMAL zones. 

As a bit of historical background: when the x86-64 port 
was originally designed we had some discussion if we should
use a 16MB DMA zone like i386 or a 4GB DMA zone like IA64 or 
both. Both was ruled out at this point because it was in early
2.4 when VM is still quite shakey and had bad troubles even
dealing with one DMA zone.  We settled on the 16MB DMA zone mainly
because we worried about older soundcards and the floppy.

But this has always caused problems since then because
device drivers had trouble getting enough DMA able memory. These days
the VM works much better and the wide use of NUMA has proven
it can deal with many zones successfully.

So this patch adds both zones.

This helps drivers who need a lot of memory below 4GB because
their hardware is not accessing more (graphic drivers - proprietary
and free ones, video frame buffer drivers, sound drivers etc.).
Previously they could only use IOMMU+16MB GFP_DMA, which
was not enough memory.

Another common problem is that hardware who has full memory
addressing for >4GB misses it for some control structures in memory
(like transmit rings or other metadata).  They tended to allocate memory 
in the 16MB GFP_DMA or the IOMMU/swiotlb then using pci_alloc_consistent, 
but that can tie up a lot of precious 16MB GFPDMA/IOMMU/swiotlb memory 
(even on AMD systems the IOMMU tends to be quite small) especially if you have
many devices.  With the new zone pci_alloc_consistent can just put
this stuff into memory below 4GB which works better.

One argument was still if the zone should be 4GB or 2GB. The main
motivation for 2GB would be an unnamed not so unpopular hardware
raid controller (mostly found in older machines from a particular four letter
company) who has a strange 2GB restriction in firmware. But 
that one works ok with swiotlb/IOMMU anyways, so it doesn't really
need GFP_DMA32. I chose 4GB to be compatible with IA64 and because
it seems to be the most common restriction.

The new zone is so far added only for x86-64.

For other architectures who don't set up this 
new zone nothing changes. Architectures can set a compatibility
define in Kconfig CONFIG_DMA_IS_DMA32 that will define GFP_DMA32
as GFP_DMA. Otherwise it's a nop because on 32bit architectures
it's normally not needed because GFP_NORMAL (=0) is DMA able 
enough.

One problem is still that GFP_DMA means different things on different
architectures. e.g. some drivers used to have #ifdef ia64  use GFP_DMA
(trusting it to be 4GB) #elif __x86_64__ (use other hacks like 
the swiotlb because 16MB is not enough) ... . This was quite 
ugly and is now obsolete.

These should be now converted to use GFP_DMA32 unconditionally. I haven't done
this yet. Or best only use pci_alloc_consistent/dma_alloc_coherent
which will use GFP_DMA32 transparently.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/init.c
===================================================================
--- linux.orig/arch/x86_64/mm/init.c
+++ linux/arch/x86_64/mm/init.c
@@ -318,32 +318,51 @@ void zap_low_mappings(void)
 	flush_tlb_all();
 }
 
+/* Compute zone sizes for the DMA and DMA32 zones in a node. */
+__init void
+size_zones(unsigned long *z, unsigned long *h,
+	   unsigned long start_pfn, unsigned long end_pfn)
+{
+ 	int i;
+ 	unsigned long w;
+
+ 	for (i = 0; i < MAX_NR_ZONES; i++)
+ 		z[i] = 0;
+
+ 	if (start_pfn < MAX_DMA_PFN)
+ 		z[ZONE_DMA] = MAX_DMA_PFN - start_pfn;
+ 	if (start_pfn < MAX_DMA32_PFN) {
+ 		unsigned long dma32_pfn = MAX_DMA32_PFN;
+ 		if (dma32_pfn > end_pfn)
+ 			dma32_pfn = end_pfn;
+ 		z[ZONE_DMA32] = dma32_pfn - start_pfn;
+ 	}
+ 	z[ZONE_NORMAL] = end_pfn - start_pfn;
+
+ 	/* Remove lower zones from higher ones. */
+ 	w = 0;
+ 	for (i = 0; i < MAX_NR_ZONES; i++) {
+ 		if (z[i])
+ 			z[i] -= w;
+ 	        w += z[i];
+	}
+	
+	/* Compute holes */
+	w = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		unsigned long s = w;
+		w += z[i];
+		h[i] = e820_hole_size(s, w);
+	}
+}
+
 #ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
-	{
-		unsigned long zones_size[MAX_NR_ZONES];
-		unsigned long holes[MAX_NR_ZONES];
-		unsigned int max_dma;
-
-		memset(zones_size, 0, sizeof(zones_size));
-		memset(holes, 0, sizeof(holes));
-
-		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-
-		if (end_pfn < max_dma) {
-			zones_size[ZONE_DMA] = end_pfn;
-			holes[ZONE_DMA] = e820_hole_size(0, end_pfn);
-		} else {
-			zones_size[ZONE_DMA] = max_dma;
-			holes[ZONE_DMA] = e820_hole_size(0, max_dma);
-			zones_size[ZONE_NORMAL] = end_pfn - max_dma;
-			holes[ZONE_NORMAL] = e820_hole_size(max_dma, end_pfn);
-		}
-		free_area_init_node(0, NODE_DATA(0), zones_size,
-                        __pa(PAGE_OFFSET) >> PAGE_SHIFT, holes);
-	}
-	return;
+	unsigned long zones[MAX_NR_ZONES], holes[MAX_NR_ZONES];
+	size_zones(zones, holes, 0, end_pfn);
+	free_area_init_node(0, NODE_DATA(0), zones,
+			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, holes);
 }
 #endif
 
Index: linux/arch/x86_64/mm/numa.c
===================================================================
--- linux.orig/arch/x86_64/mm/numa.c
+++ linux/arch/x86_64/mm/numa.c
@@ -132,29 +132,14 @@ void __init setup_node_zones(int nodeid)
 	unsigned long start_pfn, end_pfn; 
 	unsigned long zones[MAX_NR_ZONES];
 	unsigned long holes[MAX_NR_ZONES];
-	unsigned long dma_end_pfn;
 
-	memset(zones, 0, sizeof(unsigned long) * MAX_NR_ZONES); 
-	memset(holes, 0, sizeof(unsigned long) * MAX_NR_ZONES);
+ 	start_pfn = node_start_pfn(nodeid);
+ 	end_pfn = node_end_pfn(nodeid);
 
-	start_pfn = node_start_pfn(nodeid);
-	end_pfn = node_end_pfn(nodeid);
+	Dprintk(KERN_INFO "setting up node %d %lx-%lx\n",
+		nodeid, start_pfn, end_pfn);
 
-	Dprintk(KERN_INFO "setting up node %d %lx-%lx\n", nodeid, start_pfn, end_pfn);
-	
-	/* All nodes > 0 have a zero length zone DMA */ 
-	dma_end_pfn = __pa(MAX_DMA_ADDRESS) >> PAGE_SHIFT; 
-	if (start_pfn < dma_end_pfn) { 
-		zones[ZONE_DMA] = dma_end_pfn - start_pfn;
-		holes[ZONE_DMA] = e820_hole_size(start_pfn, dma_end_pfn);
-		zones[ZONE_NORMAL] = end_pfn - dma_end_pfn; 
-		holes[ZONE_NORMAL] = e820_hole_size(dma_end_pfn, end_pfn);
-
-	} else { 
-		zones[ZONE_NORMAL] = end_pfn - start_pfn; 
-		holes[ZONE_NORMAL] = e820_hole_size(start_pfn, end_pfn);
-	} 
-    
+	size_zones(zones, holes, start_pfn, end_pfn);
 	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
 			    start_pfn, holes);
 } 
Index: linux/include/asm-x86_64/dma.h
===================================================================
--- linux.orig/include/asm-x86_64/dma.h
+++ linux/include/asm-x86_64/dma.h
@@ -72,8 +72,15 @@
 
 #define MAX_DMA_CHANNELS	8
 
-/* The maximum address that we can perform a DMA transfer to on this platform */
-#define MAX_DMA_ADDRESS      (PAGE_OFFSET+0x1000000)
+
+/* 16MB ISA DMA zone */
+#define MAX_DMA_PFN   ((16*1024*1024) >> PAGE_SHIFT)
+
+/* 4GB broken PCI/AGP hardware bus master zone */
+#define MAX_DMA32_PFN ((4UL*1024*1024*1024) >> PAGE_SHIFT)
+
+/* Compat define for old dma zone */
+#define MAX_DMA_ADDRESS ((unsigned long)__va(MAX_DMA_PFN << PAGE_SHIFT))
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -23,6 +23,8 @@ extern void mtrr_bp_init(void);
 #define mtrr_bp_init() do {} while (0)
 #endif
 extern void init_memory_mapping(unsigned long start, unsigned long end);
+extern void size_zones(unsigned long *z, unsigned long *h,
+			unsigned long start_pfn, unsigned long end_pfn);
 
 extern void system_call(void); 
 extern int kernel_syscall(void);
Index: linux/include/linux/gfp.h
===================================================================
--- linux.orig/include/linux/gfp.h
+++ linux/include/linux/gfp.h
@@ -14,6 +14,13 @@ struct vm_area_struct;
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
 #define __GFP_DMA	0x01u
 #define __GFP_HIGHMEM	0x02u
+#ifdef CONFIG_DMA_IS_DMA32
+#define __GFP_DMA32	0x01	/* ZONE_DMA is ZONE_DMA32 */
+#elif BITS_PER_LONG < 64
+#define __GFP_DMA32	0x00	/* ZONE_NORMAL is ZONE_DMA32 */
+#else
+#define __GFP_DMA32	0x04	/* Has own ZONE_DMA32 */
+#endif
 
 /*
  * Action modifiers - doesn't change the zoning
@@ -64,6 +71,8 @@ struct vm_area_struct;
 
 #define GFP_DMA		__GFP_DMA
 
+/* 4GB DMA on some platforms */
+#define GFP_DMA32	__GFP_DMA32
 
 /*
  * There is only one page-allocator function, and two main namespaces to
Index: linux/include/linux/mmzone.h
===================================================================
--- linux.orig/include/linux/mmzone.h
+++ linux/include/linux/mmzone.h
@@ -70,11 +70,12 @@ struct per_cpu_pageset {
 #endif
 
 #define ZONE_DMA		0
-#define ZONE_NORMAL		1
-#define ZONE_HIGHMEM		2
+#define ZONE_DMA32		1
+#define ZONE_NORMAL		2
+#define ZONE_HIGHMEM		3
 
-#define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
-#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
+#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
 
 
 /*
@@ -90,7 +91,7 @@ struct per_cpu_pageset {
  * be 8 (2 ** 3) zonelists.  GFP_ZONETYPES defines the number of possible
  * combinations of zone modifiers in "zone modifier space".
  */
-#define GFP_ZONEMASK	0x03
+#define GFP_ZONEMASK	0x07
 /*
  * As an optimisation any zone modifier bits which are only valid when
  * no other zone modifier bits are set (loners) should be placed in
@@ -110,6 +111,7 @@ struct per_cpu_pageset {
  * into multiple physical zones. On a PC we have 3 zones:
  *
  * ZONE_DMA	  < 16 MB	ISA DMA capable memory
+ * ZONE_DMA32	     0 MB 	Empty
  * ZONE_NORMAL	16-896 MB	direct mapped by the kernel
  * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
  */
@@ -428,10 +430,10 @@ extern struct pglist_data contig_page_da
 
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
- * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
- * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
+ * with 32 bit page->flags field, we reserve 9 bits for node/zone info.
+ * there are 4 zones (3 bits) and this leaves 9-3=6 bits for nodes.
  */
-#define FLAGS_RESERVED		8
+#define FLAGS_RESERVED		9
 
 #elif BITS_PER_LONG == 64
 /*
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -58,8 +58,11 @@ long nr_swap_pages;
  *	NORMAL allocation will leave 784M/256 of ram reserved in the ZONE_DMA
  *	HIGHMEM allocation will leave 224M/32 of ram reserved in ZONE_NORMAL
  *	HIGHMEM allocation will (224M+784M)/256 of ram reserved in ZONE_DMA
+ *
+ * TBD: should special case ZONE_DMA32 machines here - in those we normally
+ * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -71,7 +74,7 @@ EXPORT_SYMBOL(nr_swap_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -1418,6 +1421,10 @@ static int __init build_zonelists_node(p
 		zone = pgdat->node_zones + ZONE_NORMAL;
 		if (zone->present_pages)
 			zonelist->zones[j++] = zone;
+	case ZONE_DMA32:
+		zone = pgdat->node_zones + ZONE_DMA32;
+		if (zone->present_pages)
+			zonelist->zones[j++] = zone;
 	case ZONE_DMA:
 		zone = pgdat->node_zones + ZONE_DMA;
 		if (zone->present_pages)
@@ -1526,6 +1533,8 @@ static void __init build_zonelists(pg_da
 			k = ZONE_NORMAL;
 			if (i & __GFP_HIGHMEM)
 				k = ZONE_HIGHMEM;
+			if (i & __GFP_DMA32)
+				k = ZONE_DMA32;
 			if (i & __GFP_DMA)
 				k = ZONE_DMA;
 
@@ -1550,7 +1559,9 @@ static void __init build_zonelists(pg_da
 		j = 0;
 		k = ZONE_NORMAL;
 		if (i & __GFP_HIGHMEM)
-			k = ZONE_HIGHMEM;
+			k = ZONE_HIGHMEM;		
+		if (i & __GFP_DMA32)
+			k = ZONE_DMA32;
 		if (i & __GFP_DMA)
 			k = ZONE_DMA;
 
@@ -1895,7 +1906,7 @@ static void __init free_area_init_core(s
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		if (j == ZONE_DMA || j == ZONE_NORMAL)
+		if (j < ZONE_HIGHMEM)
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
 
