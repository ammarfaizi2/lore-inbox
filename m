Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUHDBDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUHDBDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUHDBDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:03:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7628 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267164AbUHDBDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:03:06 -0400
Subject: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>
Content-Type: multipart/mixed; boundary="=-4UCO1n7b5u8RY62CgZ8Y"
Message-Id: <1091581282.27397.6676.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 18:01:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4UCO1n7b5u8RY62CgZ8Y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When using CONFIG_NONLINEAR, a zone's mem_map isn't contiguous, and
isn't allocated in the same place.  This means that nonlinear doesn't
really have a mem_map[] to pass into free_area_init_node() or 
memmap_init_zone() which makes any sense.  

So, this patch removes the 'struct page *mem_map' argument to both of
those functions.  All non-NUMA architectures just pass a NULL in there,
which is ignored.  The solution on the NUMA arches is to pass the
mem_map in via the pgdat, which works just fine. 

To replace the removed arguments, a call to pfn_to_page(node_start_pfn)
is made.  This is valid because all of the pfn_to_page() implementations
rely only on the pgdats, which are already set up at this time.  Plus,
the pfn_to_page() method should work for any future nonlinear-type
code.  

Finally, the patch creates a function: node_alloc_mem_map(), which I
plan to effectively #ifdef out for nonlinear at some future date.  

Compile tested and booted on SMP x86, NUMAQ, and ppc64.  Jesse Barnes
said he gave it a run on an ia64 box, and needed one additional patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109105562606682&q=raw

Jesse, could you follow up to this mail with a copy of your patch?

Attached patch is against 2.6.8-rc2-mm2.

-- Dave

--=-4UCO1n7b5u8RY62CgZ8Y
Content-Disposition: attachment; filename=B-init-no-mem_map.patch
Content-Type: text/x-patch; name=B-init-no-mem_map.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit




---

 memhotplug-dave/arch/alpha/mm/numa.c  |    2 -
 memhotplug-dave/arch/ia64/mm/contig.c |    3 +-
 memhotplug-dave/arch/ia64/mm/init.c   |    2 -
 memhotplug-dave/arch/ppc64/mm/init.c  |    2 -
 memhotplug-dave/arch/sh/mm/init.c     |    2 -
 memhotplug-dave/include/linux/mm.h    |    5 +---
 memhotplug-dave/mm/page_alloc.c       |   37 ++++++++++++++++++----------------
 7 files changed, 28 insertions(+), 25 deletions(-)

diff -puN arch/alpha/mm/numa.c~B-init-no-mem_map arch/alpha/mm/numa.c
--- memhotplug/arch/alpha/mm/numa.c~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/arch/alpha/mm/numa.c	Tue Aug  3 17:45:34 2004
@@ -313,7 +313,7 @@ void __init paging_init(void)
 			zones_size[ZONE_DMA] = dma_local_pfn;
 			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
 		}
-		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn, NULL);
+		free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn, NULL);
 	}
 
 	/* Initialize the kernel's ZERO_PGE. */
diff -puN arch/arm/mm/init.c~B-init-no-mem_map arch/arm/mm/init.c
diff -puN arch/arm26/mm/init.c~B-init-no-mem_map arch/arm26/mm/init.c
diff -puN arch/cris/arch-v10/mm/init.c~B-init-no-mem_map arch/cris/arch-v10/mm/init.c
diff -puN arch/i386/mm/discontig.c~B-init-no-mem_map arch/i386/mm/discontig.c
diff -puN arch/ia64/mm/contig.c~B-init-no-mem_map arch/ia64/mm/contig.c
--- memhotplug/arch/ia64/mm/contig.c~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/arch/ia64/mm/contig.c	Tue Aug  3 17:45:34 2004
@@ -280,7 +280,8 @@ paging_init (void)
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, 0);
 
-		free_area_init_node(0, &contig_page_data, vmem_map, zones_size,
+		contig_page_data.node_mem_map = vmem_map;
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
 		mem_map = contig_page_data.node_mem_map;
diff -puN arch/ia64/mm/discontig.c~B-init-no-mem_map arch/ia64/mm/discontig.c
diff -puN arch/ia64/mm/init.c~B-init-no-mem_map arch/ia64/mm/init.c
--- memhotplug/arch/ia64/mm/init.c~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/arch/ia64/mm/init.c	Tue Aug  3 17:45:34 2004
@@ -437,7 +437,7 @@ memmap_init (struct page *start, unsigne
 	     unsigned long zone, unsigned long start_pfn)
 {
 	if (!vmem_map)
-		memmap_init_zone(start, size, nid, zone, start_pfn);
+		memmap_init_zone(size, nid, zone, start_pfn);
 	else {
 		struct memmap_init_callback_data args;
 
diff -puN arch/mips/sgi-ip27/ip27-memory.c~B-init-no-mem_map arch/mips/sgi-ip27/ip27-memory.c
diff -puN arch/parisc/mm/init.c~B-init-no-mem_map arch/parisc/mm/init.c
diff -puN arch/ppc64/mm/init.c~B-init-no-mem_map arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/arch/ppc64/mm/init.c	Tue Aug  3 17:45:34 2004
@@ -587,7 +587,7 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
 
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 	mem_map = contig_page_data.node_mem_map;
 }
diff -puN arch/ppc64/mm/numa.c~B-init-no-mem_map arch/ppc64/mm/numa.c
diff -puN arch/sh/mm/init.c~B-init-no-mem_map arch/sh/mm/init.c
--- memhotplug/arch/sh/mm/init.c~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/arch/sh/mm/init.c	Tue Aug  3 17:45:34 2004
@@ -225,7 +225,7 @@ void __init paging_init(void)
 	 */
 	zones_size[ZONE_DMA] = __MEMORY_SIZE_2ND >> PAGE_SHIFT;
 	zones_size[ZONE_NORMAL] = 0;
-	free_area_init_node(1, NODE_DATA(1), 0, zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
+	free_area_init_node(1, NODE_DATA(1), zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
 #endif
 }
 
diff -puN arch/sh64/mm/init.c~B-init-no-mem_map arch/sh64/mm/init.c
diff -puN arch/sparc/mm/srmmu.c~B-init-no-mem_map arch/sparc/mm/srmmu.c
diff -puN arch/sparc/mm/sun4c.c~B-init-no-mem_map arch/sparc/mm/sun4c.c
diff -puN arch/sparc64/mm/init.c~B-init-no-mem_map arch/sparc64/mm/init.c
diff -puN arch/x86_64/mm/numa.c~B-init-no-mem_map arch/x86_64/mm/numa.c
diff -puN include/linux/mm.h~B-init-no-mem_map include/linux/mm.h
--- memhotplug/include/linux/mm.h~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/include/linux/mm.h	Tue Aug  3 17:45:34 2004
@@ -590,11 +590,10 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 
 extern void free_area_init(unsigned long * zones_size);
-extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
+extern void free_area_init_node(int nid, pg_data_t *pgdat,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
-extern void memmap_init_zone(struct page *, unsigned long, int,
-	unsigned long, unsigned long);
+extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
diff -puN mm/page_alloc.c~B-init-no-mem_map mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B-init-no-mem_map	Tue Aug  3 17:45:34 2004
+++ memhotplug-dave/mm/page_alloc.c	Tue Aug  3 17:45:34 2004
@@ -1385,9 +1385,10 @@ static void __init calculate_zone_totalp
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
-void __init memmap_init_zone(struct page *start, unsigned long size, int nid,
-		unsigned long zone, unsigned long start_pfn)
+void __init memmap_init_zone(unsigned long size, int nid, unsigned long zone,
+		unsigned long start_pfn)
 {
+	struct page *start = pfn_to_page(start_pfn);
 	struct page *page;
 
 	for (page = start; page < (start + size); page++) {
@@ -1451,8 +1452,8 @@ void zone_init_free_lists(struct pglist_
 }
 
 #ifndef __HAVE_ARCH_MEMMAP_INIT
-#define memmap_init(start, size, nid, zone, start_pfn) \
-	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
+#define memmap_init(size, nid, zone, start_pfn) \
+	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
 /*
@@ -1467,7 +1468,6 @@ static void __init free_area_init_core(s
 	unsigned long i, j;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
-	struct page *lmem_map = pgdat->node_mem_map;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
 	pgdat->nr_zones = 0;
@@ -1555,35 +1555,38 @@ static void __init free_area_init_core(s
 
 		pgdat->nr_zones = j+1;
 
-		zone->zone_mem_map = lmem_map;
+		zone->zone_mem_map = pfn_to_page(zone_start_pfn);
 		zone->zone_start_pfn = zone_start_pfn;
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");
 
-		memmap_init(lmem_map, size, nid, j, zone_start_pfn);
+		memmap_init(size, nid, j, zone_start_pfn);
 
 		zone_start_pfn += size;
-		lmem_map += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
 	}
 }
 
-void __init free_area_init_node(int nid, struct pglist_data *pgdat,
-		struct page *node_mem_map, unsigned long *zones_size,
-		unsigned long node_start_pfn, unsigned long *zholes_size)
+void __init node_alloc_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long size;
 
+	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+}
+
+void __init free_area_init_node(int nid, struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long node_start_pfn,
+		unsigned long *zholes_size)
+{
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
-	if (!node_mem_map) {
-		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
-		node_mem_map = alloc_bootmem_node(pgdat, size);
-	}
-	pgdat->node_mem_map = node_mem_map;
+
+	if (!pfn_to_page(node_start_pfn))
+		node_alloc_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
@@ -1596,7 +1599,7 @@ EXPORT_SYMBOL(contig_page_data);
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 	mem_map = contig_page_data.node_mem_map;
 }

_

--=-4UCO1n7b5u8RY62CgZ8Y--

