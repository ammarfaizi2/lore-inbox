Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUHFIKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUHFIKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUHFIKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:10:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:63187 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265317AbUHFIJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:09:39 -0400
Subject: [RFC] initialize all arches mem_map in one place
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>
Cc: Anton Blanchard <anton@samba.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-szWkXzByYmIsEtRkq3xB"
Message-Id: <1091779673.6496.1021.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 06 Aug 2004 01:07:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-szWkXzByYmIsEtRkq3xB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

So, this patch started out with me trying to keep from passing
contiguous, node-specific mem_map into free_area_init_node() and
cousins.  Instead, I relied on some calls to pfn_to_page().

This works fine and dandy when all you need is the pgdat->node_mem_map
to do pfn_to_page().  However, the non-NUMA/DISCONTIG architectures use
the real, global mem_map[] instead of a node_mem_map in the
pfn_to_page() calculation.  So, I ended up effectively trying to
initialize mem_map from itself, when it was NULL.  That was bad, and
caused some very pretty colors on someone's screen when he tested it.

So, I had to make sure to initialize the global mem_map[] before calling
into free_area_init_node().  Then, I realized how many architectures do
this on their own, and have comments like this:

	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
	mem_map = NODE_DATA(0)->node_mem_map;

Also, ppc64 has some interesting hacks^Wcode in this area to make up for
any empty-memory NUMA nodes, which I think can go away now.

The following patch does what my first one did (don't pass mem_map into
the init functions), incorporates Jesse Barnes' ia64 fixes on top of
that, and gets rid of all but one of the global mem_map initializations
(parisc is weird).  It also magically removes more code than it adds. 
It could be smaller, but I shamelessly added some comments.  

 arch/alpha/mm/numa.c             |    2 -
 arch/arm/mm/init.c               |    6 ----
 arch/arm26/mm/init.c             |    4 ---
 arch/cris/arch-v10/mm/init.c     |    3 --
 arch/i386/mm/discontig.c         |   11 +++-----
 arch/ia64/mm/contig.c            |    7 ++---
 arch/ia64/mm/discontig.c         |    4 +--
 arch/ia64/mm/init.c              |    8 +++---
 arch/mips/sgi-ip27/ip27-memory.c |    2 -
 arch/parisc/mm/init.c            |    2 -
 arch/ppc64/mm/init.c             |    3 --
 arch/ppc64/mm/numa.c             |   12 ---------
 arch/sh/mm/init.c                |    6 +---
 arch/sh64/mm/init.c              |    5 ---
 arch/sparc/mm/srmmu.c            |    3 --
 arch/sparc/mm/sun4c.c            |    3 --
 arch/sparc64/mm/init.c           |    3 --
 arch/v850/kernel/setup.c         |    3 --
 arch/x86_64/mm/numa.c            |    2 -
 include/asm-ia64/pgtable.h       |    2 -
 include/linux/mm.h               |    5 +--
 mm/page_alloc.c                  |   51 +++++++++++++++++++++++++--------------
 22 files changed, 66 insertions(+), 81 deletions(-)

-- Dave

--=-szWkXzByYmIsEtRkq3xB
Content-Disposition: attachment; filename=B-init-no-mem_map.patch
Content-Type: text/x-patch; name=B-init-no-mem_map.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


Signed-off-by: Dave Hansen <haveblue@us.ibm.com>


---

 memhotplug-dave/arch/alpha/mm/numa.c             |    2 
 memhotplug-dave/arch/arm/mm/init.c               |    6 --
 memhotplug-dave/arch/arm26/mm/init.c             |    4 -
 memhotplug-dave/arch/cris/arch-v10/mm/init.c     |    3 -
 memhotplug-dave/arch/i386/mm/discontig.c         |   11 +---
 memhotplug-dave/arch/ia64/mm/contig.c            |    7 +--
 memhotplug-dave/arch/ia64/mm/discontig.c         |    4 -
 memhotplug-dave/arch/ia64/mm/init.c              |    8 ++-
 memhotplug-dave/arch/mips/sgi-ip27/ip27-memory.c |    2 
 memhotplug-dave/arch/parisc/mm/init.c            |    2 
 memhotplug-dave/arch/ppc64/mm/init.c             |    3 -
 memhotplug-dave/arch/ppc64/mm/numa.c             |   12 -----
 memhotplug-dave/arch/sh/mm/init.c                |    6 --
 memhotplug-dave/arch/sh64/mm/init.c              |    5 --
 memhotplug-dave/arch/sparc/mm/srmmu.c            |    3 -
 memhotplug-dave/arch/sparc/mm/sun4c.c            |    3 -
 memhotplug-dave/arch/sparc64/mm/init.c           |    3 -
 memhotplug-dave/arch/v850/kernel/setup.c         |    3 -
 memhotplug-dave/arch/x86_64/mm/numa.c            |    2 
 memhotplug-dave/include/asm-ia64/pgtable.h       |    2 
 memhotplug-dave/include/linux/mm.h               |    5 --
 memhotplug-dave/mm/page_alloc.c                  |   51 ++++++++++++++---------
 22 files changed, 66 insertions(+), 81 deletions(-)

diff -puN arch/alpha/mm/numa.c~B-init-no-mem_map arch/alpha/mm/numa.c
--- memhotplug/arch/alpha/mm/numa.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/alpha/mm/numa.c	Thu Aug  5 19:13:41 2004
@@ -313,7 +313,7 @@ void __init paging_init(void)
 			zones_size[ZONE_DMA] = dma_local_pfn;
 			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
 		}
-		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn, NULL);
+		free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn, NULL);
 	}
 
 	/* Initialize the kernel's ZERO_PGE. */
diff -puN arch/arm/mm/init.c~B-init-no-mem_map arch/arm/mm/init.c
--- memhotplug/arch/arm/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/arm/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -502,13 +502,9 @@ void __init paging_init(struct meminfo *
 		 */
 		arch_adjust_zones(node, zone_size, zhole_size);
 
-		free_area_init_node(node, pgdat, NULL, zone_size,
+		free_area_init_node(node, pgdat, zone_size,
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
-
-#ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
-#endif
 
 	/*
 	 * finish off the bad pages once
diff -puN arch/arm26/mm/init.c~B-init-no-mem_map arch/arm26/mm/init.c
--- memhotplug/arch/arm26/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/arm26/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -306,10 +306,8 @@ void __init paging_init(struct meminfo *
 	if (!zone_size[0])
 		BUG();
 
-	free_area_init_node(0, pgdat, 0, zone_size,
+	free_area_init_node(0, pgdat, zone_size,
 			bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
-
-	mem_map = NODE_DATA(0)->node_mem_map;
 
 	/*
 	 * finish off the bad pages once
diff -puN arch/cris/arch-v10/mm/init.c~B-init-no-mem_map arch/cris/arch-v10/mm/init.c
--- memhotplug/arch/cris/arch-v10/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/cris/arch-v10/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -183,8 +183,7 @@ paging_init(void)
 	 * mem_map page array.
 	 */
 
-	free_area_init_node(0, &contig_page_data, 0, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
-	mem_map = contig_page_data.node_mem_map;
+	free_area_init_node(0, &contig_page_data, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
 }
 
 /* Initialize remaps of some I/O-ports. It is important that this
diff -puN arch/i386/mm/discontig.c~B-init-no-mem_map arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/i386/mm/discontig.c	Thu Aug  5 19:13:41 2004
@@ -417,18 +417,15 @@ void __init zone_sizes_init(void)
 		 * normal bootmem allocator, but other nodes come from the
 		 * remapped KVA area - mbligh
 		 */
-		if (!nid)
-			free_area_init_node(nid, NODE_DATA(nid), 0, 
-				zones_size, start, zholes_size);
-		else {
+		if (nid) {
 			unsigned long lmem_map;
 			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
 			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
 			lmem_map &= PAGE_MASK;
-			free_area_init_node(nid, NODE_DATA(nid), 
-				(struct page *)lmem_map, zones_size, 
-				start, zholes_size);
+			NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
 		}
+		free_area_init_node(nid, NODE_DATA(nid), zones_size,
+				    start, zholes_size);
 	}
 	return;
 }
diff -puN arch/ia64/mm/contig.c~B-init-no-mem_map arch/ia64/mm/contig.c
--- memhotplug/arch/ia64/mm/contig.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/ia64/mm/contig.c	Thu Aug  5 19:13:41 2004
@@ -267,9 +267,8 @@ paging_init (void)
 	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
 	if (max_gap < LARGE_GAP) {
 		vmem_map = (struct page *) 0;
-		free_area_init_node(0, &contig_page_data, NULL, zones_size, 0,
+		free_area_init_node(0, &contig_page_data, zones_size, 0,
 				    zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	} else {
 		unsigned long map_size;
 
@@ -280,10 +279,10 @@ paging_init (void)
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, 0);
 
-		free_area_init_node(0, &contig_page_data, vmem_map, zones_size,
+		NODE_DATA(0)->node_mem_map = vmem_map;
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
-		mem_map = contig_page_data.node_mem_map;
 		printk("Virtual mem_map starts at 0x%p\n", mem_map);
 	}
 #else /* !CONFIG_VIRTUAL_MEM_MAP */
diff -puN arch/ia64/mm/discontig.c~B-init-no-mem_map arch/ia64/mm/discontig.c
--- memhotplug/arch/ia64/mm/discontig.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/ia64/mm/discontig.c	Thu Aug  5 19:13:41 2004
@@ -665,8 +665,8 @@ void paging_init(void)
 
 		pfn_offset = mem_data[node].min_pfn;
 
-		free_area_init_node(node, NODE_DATA(node),
-				    vmem_map + pfn_offset, zones_size,
+		NODE_DATA(node)->node_mem_map = vmem_map + pfn_offset;
+		free_area_init_node(node, NODE_DATA(node), zones_size,
 				    pfn_offset, zholes_size);
 	}
 
diff -puN arch/ia64/mm/init.c~B-init-no-mem_map arch/ia64/mm/init.c
--- memhotplug/arch/ia64/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/ia64/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -433,14 +433,16 @@ virtual_memmap_init (u64 start, u64 end,
 }
 
 void
-memmap_init (struct page *start, unsigned long size, int nid,
-	     unsigned long zone, unsigned long start_pfn)
+memmap_init (unsigned long size, int nid, unsigned long zone,
+	     unsigned long start_pfn)
 {
 	if (!vmem_map)
-		memmap_init_zone(start, size, nid, zone, start_pfn);
+		memmap_init_zone(size, nid, zone, start_pfn);
 	else {
+		struct page *start;
 		struct memmap_init_callback_data args;
 
+		start = pfn_to_page(start_pfn);
 		args.start = start;
 		args.end = start + size;
 		args.nid = nid;
diff -puN arch/mips/sgi-ip27/ip27-memory.c~B-init-no-mem_map arch/mips/sgi-ip27/ip27-memory.c
--- memhotplug/arch/mips/sgi-ip27/ip27-memory.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/mips/sgi-ip27/ip27-memory.c	Thu Aug  5 19:13:41 2004
@@ -225,7 +225,7 @@ void __init paging_init(void)
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
 		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		free_area_init_node(node, NODE_DATA(node), NULL,
+		free_area_init_node(node, NODE_DATA(node),
 				zones_size, start_pfn, NULL);
 
 		if (end_pfn > max_low_pfn)
diff -puN arch/parisc/mm/init.c~B-init-no-mem_map arch/parisc/mm/init.c
--- memhotplug/arch/parisc/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/parisc/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -761,7 +761,7 @@ void __init paging_init(void)
 		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0, };
 
 		zones_size[ZONE_DMA] = pmem_ranges[i].pages;
-		free_area_init_node(i,NODE_DATA(i),NULL,zones_size,
+		free_area_init_node(i,NODE_DATA(i),zones_size,
 				(pmem_ranges[i].start_pfn << PAGE_SHIFT),0);
 	}
 
diff -puN arch/ppc64/mm/init.c~B-init-no-mem_map arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/ppc64/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -587,9 +587,8 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
 
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
-	mem_map = contig_page_data.node_mem_map;
 }
 #endif /* CONFIG_DISCONTIGMEM */
 
diff -puN arch/ppc64/mm/numa.c~B-init-no-mem_map arch/ppc64/mm/numa.c
--- memhotplug/arch/ppc64/mm/numa.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/ppc64/mm/numa.c	Thu Aug  5 19:13:41 2004
@@ -464,17 +464,7 @@ void __init paging_init(void)
 		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
 		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
 
-		/* 
-		 * Give this empty node a dummy struct page to avoid
-		 * us from trying to allocate a node local mem_map
-		 * in free_area_init_node (which will fail).
-		 */
-		if (!node_data[nid].node_spanned_pages)
-			node_mem_map = alloc_bootmem(sizeof(struct page));
-		else
-			node_mem_map = NULL;
-
-		free_area_init_node(nid, NODE_DATA(nid), node_mem_map,
+		free_area_init_node(nid, NODE_DATA(nid),
 				    zones_size, start_pfn, zholes_size);
 	}
 }
diff -puN arch/sh/mm/init.c~B-init-no-mem_map arch/sh/mm/init.c
--- memhotplug/arch/sh/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/sh/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -215,9 +215,7 @@ void __init paging_init(void)
 	disable_mmu();
 #endif
 
-	free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
+	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
 
 #ifdef CONFIG_DISCONTIGMEM
 	/*
@@ -225,7 +223,7 @@ void __init paging_init(void)
 	 */
 	zones_size[ZONE_DMA] = __MEMORY_SIZE_2ND >> PAGE_SHIFT;
 	zones_size[ZONE_NORMAL] = 0;
-	free_area_init_node(1, NODE_DATA(1), 0, zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
+	free_area_init_node(1, NODE_DATA(1), zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
 #endif
 }
 
diff -puN arch/sh64/mm/init.c~B-init-no-mem_map arch/sh64/mm/init.c
--- memhotplug/arch/sh64/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/sh64/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -123,10 +123,7 @@ void __init paging_init(void)
          */
 	zones_size[ZONE_DMA] = MAX_LOW_PFN - START_PFN;
 
-	free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
+	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
 }
 
 void __init mem_init(void)
diff -puN arch/sparc/mm/srmmu.c~B-init-no-mem_map arch/sparc/mm/srmmu.c
--- memhotplug/arch/sparc/mm/srmmu.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/sparc/mm/srmmu.c	Thu Aug  5 19:13:41 2004
@@ -1341,9 +1341,8 @@ void __init srmmu_paging_init(void)
 		zones_size[ZONE_HIGHMEM] = npages;
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 }
 
diff -puN arch/sparc/mm/sun4c.c~B-init-no-mem_map arch/sparc/mm/sun4c.c
--- memhotplug/arch/sparc/mm/sun4c.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/sparc/mm/sun4c.c	Thu Aug  5 19:13:41 2004
@@ -2114,9 +2114,8 @@ void __init sun4c_paging_init(void)
 		zones_size[ZONE_HIGHMEM] = npages;
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	cnt = 0;
diff -puN arch/sparc64/mm/init.c~B-init-no-mem_map arch/sparc64/mm/init.c
--- memhotplug/arch/sparc64/mm/init.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/sparc64/mm/init.c	Thu Aug  5 19:13:41 2004
@@ -1585,9 +1585,8 @@ void __init paging_init(void)
 		zones_size[ZONE_DMA] = npages;
 		zholes_size[ZONE_DMA] = npages - pages_avail;
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	device_scan();
diff -puN arch/x86_64/mm/numa.c~B-init-no-mem_map arch/x86_64/mm/numa.c
--- memhotplug/arch/x86_64/mm/numa.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/x86_64/mm/numa.c	Thu Aug  5 19:13:41 2004
@@ -136,7 +136,7 @@ void __init setup_node_zones(int nodeid)
 		zones[ZONE_NORMAL] = end_pfn - start_pfn; 
 	} 
     
-	free_area_init_node(nodeid, NODE_DATA(nodeid), NULL, zones, 
+	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
 			    start_pfn, NULL); 
 } 
 
diff -puN include/linux/mm.h~B-init-no-mem_map include/linux/mm.h
--- memhotplug/include/linux/mm.h~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/include/linux/mm.h	Thu Aug  5 19:13:41 2004
@@ -601,11 +601,10 @@ static inline pmd_t *pmd_alloc(struct mm
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
--- memhotplug/mm/page_alloc.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/mm/page_alloc.c	Thu Aug  5 19:13:41 2004
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
@@ -1555,35 +1555,51 @@ static void __init free_area_init_core(s
 
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
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long size;
 
+	/*
+	 * Make sure that the architecture hasn't already allocated
+	 * a node_mem_map, and that the node contains memory.
+	 */
+	if (pgdat->node_mem_map || !pgdat->node_spanned_pages)
+		return;
+
+	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+#ifndef CONFIG_DISCONTIGMEM
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0))
+		mem_map = NODE_DATA(0)->node_mem_map;
+#endif
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
+	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
@@ -1596,9 +1612,8 @@ EXPORT_SYMBOL(contig_page_data);
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
-	mem_map = contig_page_data.node_mem_map;
 }
 #endif
 
diff -puN arch/v850/kernel/setup.c~B-init-no-mem_map arch/v850/kernel/setup.c
--- memhotplug/arch/v850/kernel/setup.c~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/arch/v850/kernel/setup.c	Thu Aug  5 19:13:41 2004
@@ -281,7 +281,6 @@ init_mem_alloc (unsigned long ram_start,
 #error MAX_ORDER is too large for given PAGE_OFFSET (use CONFIG_FORCE_MAX_ZONEORDER to change it)
 #endif
 
-	free_area_init_node (0, NODE_DATA(0), 0, zones_size,
+	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
diff -puN include/asm-ia64/pgtable.h~B-init-no-mem_map include/asm-ia64/pgtable.h
--- memhotplug/include/asm-ia64/pgtable.h~B-init-no-mem_map	Thu Aug  5 19:13:41 2004
+++ memhotplug-dave/include/asm-ia64/pgtable.h	Thu Aug  5 19:13:41 2004
@@ -520,7 +520,7 @@ do {											\
 #  ifdef CONFIG_VIRTUAL_MEM_MAP
   /* arch mem_map init routine is needed due to holes in a virtual mem_map */
 #   define __HAVE_ARCH_MEMMAP_INIT
-    extern void memmap_init (struct page *start, unsigned long size, int nid, unsigned long zone,
+    extern void memmap_init (unsigned long size, int nid, unsigned long zone,
 			     unsigned long start_pfn);
 #  endif /* CONFIG_VIRTUAL_MEM_MAP */
 # endif /* !__ASSEMBLY__ */

_

--=-szWkXzByYmIsEtRkq3xB--

