Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268023AbUHEX6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268023AbUHEX6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUHEX6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:58:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:50899 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268023AbUHEX6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:58:23 -0400
Subject: Re: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>
In-Reply-To: <20040805141336.1687cbbc.akpm@osdl.org>
References: <1091581282.27397.6676.camel@nighthawk>
	 <20040805141336.1687cbbc.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-SuyzyisJMM3NMJ+qrOBn"
Message-Id: <1091750289.31490.588.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 16:58:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SuyzyisJMM3NMJ+qrOBn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-08-05 at 14:13, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > When using CONFIG_NONLINEAR, a zone's mem_map isn't contiguous, and
> > isn't allocated in the same place.  This means that nonlinear doesn't
> > really have a mem_map[] to pass into free_area_init_node() or 
> > memmap_init_zone() which makes any sense.  
> 
> argh, sorry.  It's this patch which I dropped due to psychedelic screen
> syndrome.  The "break out zone free list initialization" patch is innocent, and
> was included in rc3-mm1.

OK, here's a replacement for the bad one.  I could provide an
incremental instead if you prefer.

Turns out I was initializing the mem_map too late.  Not only did
pfn_to_page() use the pgdats, but it also used mem_map.  Not
surprisingly, mem_map == NULL did not make things happy.

My earlier testing didn't catch it because I was always using either
DISCONTIGMEM or NONLINEAR (even on plain SMP because I'm weird), both of
which skip the code that I screwed up.  

-- Dave

--=-SuyzyisJMM3NMJ+qrOBn
Content-Disposition: attachment; filename=B-init-no-mem_map.patch
Content-Type: text/x-patch; name=B-init-no-mem_map.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


Signed-off-by: Dave Hansen <haveblue@us.ibm.com>


---

 memhotplug-dave/arch/alpha/mm/numa.c  |    2 -
 memhotplug-dave/arch/ia64/mm/contig.c |    3 +-
 memhotplug-dave/arch/ia64/mm/init.c   |    2 -
 memhotplug-dave/arch/ppc64/mm/init.c  |    2 -
 memhotplug-dave/arch/sh/mm/init.c     |    2 -
 memhotplug-dave/include/linux/mm.h    |    5 +---
 memhotplug-dave/mm/page_alloc.c       |   39 ++++++++++++++++++----------------
 7 files changed, 29 insertions(+), 26 deletions(-)

diff -puN arch/alpha/mm/numa.c~B-init-no-mem_map arch/alpha/mm/numa.c
--- memhotplug/arch/alpha/mm/numa.c~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/arch/alpha/mm/numa.c	Thu Aug  5 16:45:32 2004
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
--- memhotplug/arch/ia64/mm/contig.c~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/arch/ia64/mm/contig.c	Thu Aug  5 16:45:32 2004
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
--- memhotplug/arch/ia64/mm/init.c~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/arch/ia64/mm/init.c	Thu Aug  5 16:45:32 2004
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
--- memhotplug/arch/ppc64/mm/init.c~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/arch/ppc64/mm/init.c	Thu Aug  5 16:45:32 2004
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
--- memhotplug/arch/sh/mm/init.c~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/arch/sh/mm/init.c	Thu Aug  5 16:45:32 2004
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
--- memhotplug/include/linux/mm.h~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/include/linux/mm.h	Thu Aug  5 16:45:32 2004
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
--- memhotplug/mm/page_alloc.c~B-init-no-mem_map	Thu Aug  5 16:45:32 2004
+++ memhotplug-dave/mm/page_alloc.c	Thu Aug  5 16:46:28 2004
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
@@ -1555,35 +1555,39 @@ static void __init free_area_init_core(s
 
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
+	mem_map = contig_page_data.node_mem_map;
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
@@ -1596,9 +1600,8 @@ EXPORT_SYMBOL(contig_page_data);
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
-	mem_map = contig_page_data.node_mem_map;
 }
 #endif
 

_

--=-SuyzyisJMM3NMJ+qrOBn--

