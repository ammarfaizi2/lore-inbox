Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUG1U71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUG1U71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUG1U71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:59:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:20434 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264260AbUG1Uz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:55:58 -0400
Subject: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-mm <linux-mm@kvack.org>, LSE <lse-tech@lists.sourceforge.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-OI/cO9exPTW22IEXDNme"
Message-Id: <1091048123.2871.435.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 13:55:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OI/cO9exPTW22IEXDNme
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When using CONFIG_NONLINEAR, a zone's mem_map isn't contiguous, and
isn't allocated in the same place.  This means that nonlinear doesn't
really have a mem_map[] to pass into free_area_init_node() or 
memmap_init_zone() which makes any sense.  

So, this patch removes the 'struct page *mem_map' argument to both of
those functions.  All non-NUMA architectures just pass a NULL in there,
which is ignored.  I've cc'd any NUMA architecture's maintainer who's
code I've touched.  

To replace the removed arguments, a call to pfn_to_page(node_start_pfn)
is made.  This is valid because all of the pfn_to_page() implementations
rely only on the pgdats, which are already set up at this time.  Plus,
the pfn_to_page() method should work for any future nonlinear-type
code.  

Finally, the patch creates a function: node_alloc_mem_map(), which I
plan to effectively #ifdef out for nonlinear at some future date.  

Compile tested on SMP x86 and NUMAQ.  I plan to give it a run on ppc64
in a bit.  I'd appreciate if one of the ia64 guys could make sure it's
OK for them as well.  

 arch/alpha/mm/numa.c             |    2 +-
 arch/arm/mm/init.c               |    2 +-
 arch/arm26/mm/init.c             |    2 +-
 arch/cris/arch-v10/mm/init.c     |    2 +-
 arch/i386/mm/discontig.c         |    6 +++---
 arch/ia64/mm/contig.c            |    5 +++--
 arch/ia64/mm/discontig.c         |    4 ++--
 arch/ia64/mm/init.c              |    4 ++--
 arch/mips/sgi-ip27/ip27-memory.c |    2 +-
 arch/parisc/mm/init.c            |    2 +-
 arch/ppc64/mm/init.c             |    2 +-
 arch/ppc64/mm/numa.c             |    5 +++--
 arch/sh/mm/init.c                |    4 ++--
 arch/sh64/mm/init.c              |    2 +-
 arch/sparc/mm/srmmu.c            |    2 +-
 arch/sparc/mm/sun4c.c            |    2 +-
 arch/sparc64/mm/init.c           |    2 +-
 arch/v850/kernel/setup.c         |    2 +-
 arch/x86_64/mm/numa.c            |    2 +-
 include/linux/mm.h               |    4 ++--
 mm/page_alloc.c                  |   37 ++++++++++++++++++++-----------------
 21 files changed, 50 insertions(+), 45 deletions(-)

-- Dave

--=-OI/cO9exPTW22IEXDNme
Content-Disposition: attachment; filename=init-time-no-mem_map-2.6.8-rc2-mm1-0.patch
Content-Type: text/x-patch; name=init-time-no-mem_map-2.6.8-rc2-mm1-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -ru C-create-__boot-ppc64/arch/alpha/mm/numa.c D-init-no-mem_map/arch/alpha/mm/numa.c
--- C-create-__boot-ppc64/arch/alpha/mm/numa.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/alpha/mm/numa.c	2004-07-28 11:52:55.000000000 -0700
@@ -313,7 +313,7 @@
 			zones_size[ZONE_DMA] = dma_local_pfn;
 			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
 		}
-		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn, NULL);
+		free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn, NULL);
 	}
 
 	/* Initialize the kernel's ZERO_PGE. */
diff -ru C-create-__boot-ppc64/arch/arm/mm/init.c D-init-no-mem_map/arch/arm/mm/init.c
--- C-create-__boot-ppc64/arch/arm/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/arm/mm/init.c	2004-07-28 11:53:09.000000000 -0700
@@ -502,7 +502,7 @@
 		 */
 		arch_adjust_zones(node, zone_size, zhole_size);
 
-		free_area_init_node(node, pgdat, 0, zone_size,
+		free_area_init_node(node, pgdat, zone_size,
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
diff -ru C-create-__boot-ppc64/arch/arm26/mm/init.c D-init-no-mem_map/arch/arm26/mm/init.c
--- C-create-__boot-ppc64/arch/arm26/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/arm26/mm/init.c	2004-07-28 11:53:14.000000000 -0700
@@ -306,7 +306,7 @@
 	if (!zone_size[0])
 		BUG();
 
-	free_area_init_node(0, pgdat, 0, zone_size,
+	free_area_init_node(0, pgdat, zone_size,
 			bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 
 	mem_map = NODE_DATA(0)->node_mem_map;
diff -ru C-create-__boot-ppc64/arch/cris/arch-v10/mm/init.c D-init-no-mem_map/arch/cris/arch-v10/mm/init.c
--- C-create-__boot-ppc64/arch/cris/arch-v10/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/cris/arch-v10/mm/init.c	2004-07-28 11:53:20.000000000 -0700
@@ -183,7 +183,7 @@
 	 * mem_map page array.
 	 */
 
-	free_area_init_node(0, &contig_page_data, 0, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
+	free_area_init_node(0, &contig_page_data, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
 	mem_map = contig_page_data.node_mem_map;
 }
 
diff -ru C-create-__boot-ppc64/arch/i386/mm/discontig.c D-init-no-mem_map/arch/i386/mm/discontig.c
--- C-create-__boot-ppc64/arch/i386/mm/discontig.c	2004-07-28 11:33:38.000000000 -0700
+++ D-init-no-mem_map/arch/i386/mm/discontig.c	2004-07-28 13:19:18.000000000 -0700
@@ -418,16 +418,16 @@
 		 * remapped KVA area - mbligh
 		 */
 		if (!nid)
-			free_area_init_node(nid, NODE_DATA(nid), 0, 
+			free_area_init_node(nid, NODE_DATA(nid),
 				zones_size, start, zholes_size);
 		else {
 			unsigned long lmem_map;
 			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
 			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
 			lmem_map &= PAGE_MASK;
+			NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
 			free_area_init_node(nid, NODE_DATA(nid), 
-				(struct page *)lmem_map, zones_size, 
-				start, zholes_size);
+				zones_size, start, zholes_size);
 		}
 	}
 	return;
diff -ru C-create-__boot-ppc64/arch/ia64/mm/contig.c D-init-no-mem_map/arch/ia64/mm/contig.c
--- C-create-__boot-ppc64/arch/ia64/mm/contig.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/ia64/mm/contig.c	2004-07-28 11:56:35.000000000 -0700
@@ -267,7 +267,7 @@
 	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
 	if (max_gap < LARGE_GAP) {
 		vmem_map = (struct page *) 0;
-		free_area_init_node(0, &contig_page_data, NULL, zones_size, 0,
+		free_area_init_node(0, &contig_page_data, zones_size, 0,
 				    zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	} else {
@@ -280,7 +280,8 @@
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, 0);
 
-		free_area_init_node(0, &contig_page_data, vmem_map, zones_size,
+		contig_page_data.node_mem_map = vmem_map;
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
 		mem_map = contig_page_data.node_mem_map;
diff -ru C-create-__boot-ppc64/arch/ia64/mm/discontig.c D-init-no-mem_map/arch/ia64/mm/discontig.c
--- C-create-__boot-ppc64/arch/ia64/mm/discontig.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/ia64/mm/discontig.c	2004-07-28 12:33:40.000000000 -0700
@@ -665,8 +665,8 @@
 
 		pfn_offset = mem_data[node].min_pfn;
 
-		free_area_init_node(node, NODE_DATA(node),
-				    vmem_map + pfn_offset, zones_size,
+		NODE_DATA(node)->node_mem_map = vmem_map + pfn_offset;
+		free_area_init_node(node, NODE_DATA(node), zones_size,
 				    pfn_offset, zholes_size);
 	}
 
diff -ru C-create-__boot-ppc64/arch/ia64/mm/init.c D-init-no-mem_map/arch/ia64/mm/init.c
--- C-create-__boot-ppc64/arch/ia64/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/ia64/mm/init.c	2004-07-28 12:55:16.000000000 -0700
@@ -427,7 +427,7 @@
 		    / sizeof(struct page));
 
 	if (map_start < map_end)
-		memmap_init_zone(map_start, (unsigned long) (map_end - map_start),
+		memmap_init_zone((unsigned long) (map_end - map_start),
 				 args->nid, args->zone, page_to_pfn(map_start));
 	return 0;
 }
@@ -437,7 +437,7 @@
 	     unsigned long zone, unsigned long start_pfn)
 {
 	if (!vmem_map)
-		memmap_init_zone(start, size, nid, zone, start_pfn);
+		memmap_init_zone(size, nid, zone, start_pfn);
 	else {
 		struct memmap_init_callback_data args;
 
diff -ru C-create-__boot-ppc64/arch/mips/sgi-ip27/ip27-memory.c D-init-no-mem_map/arch/mips/sgi-ip27/ip27-memory.c
--- C-create-__boot-ppc64/arch/mips/sgi-ip27/ip27-memory.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/mips/sgi-ip27/ip27-memory.c	2004-07-28 11:57:35.000000000 -0700
@@ -225,7 +225,7 @@
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
 		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		free_area_init_node(node, NODE_DATA(node), NULL,
+		free_area_init_node(node, NODE_DATA(node),
 				zones_size, start_pfn, NULL);
 
 		if (end_pfn > max_low_pfn)
diff -ru C-create-__boot-ppc64/arch/parisc/mm/init.c D-init-no-mem_map/arch/parisc/mm/init.c
--- C-create-__boot-ppc64/arch/parisc/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/parisc/mm/init.c	2004-07-28 11:57:42.000000000 -0700
@@ -761,7 +761,7 @@
 		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0, };
 
 		zones_size[ZONE_DMA] = pmem_ranges[i].pages;
-		free_area_init_node(i,NODE_DATA(i),NULL,zones_size,
+		free_area_init_node(i,NODE_DATA(i),zones_size,
 				(pmem_ranges[i].start_pfn << PAGE_SHIFT),0);
 	}
 
diff -ru C-create-__boot-ppc64/arch/ppc64/mm/init.c D-init-no-mem_map/arch/ppc64/mm/init.c
--- C-create-__boot-ppc64/arch/ppc64/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/ppc64/mm/init.c	2004-07-28 11:57:47.000000000 -0700
@@ -587,7 +587,7 @@
 	zones_size[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
 
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 	mem_map = contig_page_data.node_mem_map;
 }
diff -ru C-create-__boot-ppc64/arch/ppc64/mm/numa.c D-init-no-mem_map/arch/ppc64/mm/numa.c
--- C-create-__boot-ppc64/arch/ppc64/mm/numa.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/ppc64/mm/numa.c	2004-07-28 11:58:29.000000000 -0700
@@ -474,7 +474,8 @@
 		else
 			node_mem_map = NULL;
 
-		free_area_init_node(nid, NODE_DATA(nid), node_mem_map,
-				    zones_size, start_pfn, zholes_size);
+		NODE_DATA(nid)->node_mem_map = node_mem_map;
+		free_area_init_node(nid, NODE_DATA(nid), zones_size,
+				    start_pfn, zholes_size);
 	}
 }
diff -ru C-create-__boot-ppc64/arch/sh/mm/init.c D-init-no-mem_map/arch/sh/mm/init.c
--- C-create-__boot-ppc64/arch/sh/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/sh/mm/init.c	2004-07-28 11:59:25.000000000 -0700
@@ -215,7 +215,7 @@
 	disable_mmu();
 #endif
 
-	free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
+	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
 	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
 	mem_map = NODE_DATA(0)->node_mem_map;
 
@@ -225,7 +225,7 @@
 	 */
 	zones_size[ZONE_DMA] = __MEMORY_SIZE_2ND >> PAGE_SHIFT;
 	zones_size[ZONE_NORMAL] = 0;
-	free_area_init_node(1, NODE_DATA(1), 0, zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
+	free_area_init_node(1, NODE_DATA(1), zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
 #endif
 }
 
diff -ru C-create-__boot-ppc64/arch/sh64/mm/init.c D-init-no-mem_map/arch/sh64/mm/init.c
--- C-create-__boot-ppc64/arch/sh64/mm/init.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/sh64/mm/init.c	2004-07-28 11:59:29.000000000 -0700
@@ -123,7 +123,7 @@
          */
 	zones_size[ZONE_DMA] = MAX_LOW_PFN - START_PFN;
 
-	free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
+	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
 
 	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
 	mem_map = NODE_DATA(0)->node_mem_map;
diff -ru C-create-__boot-ppc64/arch/sparc/mm/srmmu.c D-init-no-mem_map/arch/sparc/mm/srmmu.c
--- C-create-__boot-ppc64/arch/sparc/mm/srmmu.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/sparc/mm/srmmu.c	2004-07-28 11:59:34.000000000 -0700
@@ -1341,7 +1341,7 @@
 		zones_size[ZONE_HIGHMEM] = npages;
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
diff -ru C-create-__boot-ppc64/arch/sparc/mm/sun4c.c D-init-no-mem_map/arch/sparc/mm/sun4c.c
--- C-create-__boot-ppc64/arch/sparc/mm/sun4c.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/sparc/mm/sun4c.c	2004-07-28 11:59:40.000000000 -0700
@@ -2114,7 +2114,7 @@
 		zones_size[ZONE_HIGHMEM] = npages;
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
diff -ru C-create-__boot-ppc64/arch/sparc64/mm/init.c D-init-no-mem_map/arch/sparc64/mm/init.c
--- C-create-__boot-ppc64/arch/sparc64/mm/init.c	2004-07-28 11:33:38.000000000 -0700
+++ D-init-no-mem_map/arch/sparc64/mm/init.c	2004-07-28 11:59:45.000000000 -0700
@@ -1585,7 +1585,7 @@
 		zones_size[ZONE_DMA] = npages;
 		zholes_size[ZONE_DMA] = npages - pages_avail;
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
diff -ru C-create-__boot-ppc64/arch/v850/kernel/setup.c D-init-no-mem_map/arch/v850/kernel/setup.c
--- C-create-__boot-ppc64/arch/v850/kernel/setup.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/v850/kernel/setup.c	2004-07-28 11:59:49.000000000 -0700
@@ -281,7 +281,7 @@
 #error MAX_ORDER is too large for given PAGE_OFFSET (use CONFIG_FORCE_MAX_ZONEORDER to change it)
 #endif
 
-	free_area_init_node (0, NODE_DATA(0), 0, zones_size,
+	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
 	mem_map = NODE_DATA(0)->node_mem_map;
 }
diff -ru C-create-__boot-ppc64/arch/x86_64/mm/numa.c D-init-no-mem_map/arch/x86_64/mm/numa.c
--- C-create-__boot-ppc64/arch/x86_64/mm/numa.c	2004-07-28 11:33:39.000000000 -0700
+++ D-init-no-mem_map/arch/x86_64/mm/numa.c	2004-07-28 11:59:54.000000000 -0700
@@ -136,7 +136,7 @@
 		zones[ZONE_NORMAL] = end_pfn - start_pfn; 
 	} 
     
-	free_area_init_node(nodeid, NODE_DATA(nodeid), NULL, zones, 
+	free_area_init_node(nodeid, NODE_DATA(nodeid), zones, 
 			    start_pfn, NULL); 
 } 
 
diff -ru C-create-__boot-ppc64/include/linux/mm.h D-init-no-mem_map/include/linux/mm.h
--- C-create-__boot-ppc64/include/linux/mm.h	2004-07-28 11:33:42.000000000 -0700
+++ D-init-no-mem_map/include/linux/mm.h	2004-07-28 13:24:32.000000000 -0700
@@ -588,10 +588,10 @@
 }
 
 extern void free_area_init(unsigned long * zones_size);
-extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
+extern void free_area_init_node(int nid, pg_data_t *pgdat,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
-extern void memmap_init_zone(struct page *, unsigned long, int,
+extern void memmap_init_zone(unsigned long, int,
 	unsigned long, unsigned long);
 extern void mem_init(void);
 extern void show_mem(void);
diff -ru C-create-__boot-ppc64/mm/page_alloc.c D-init-no-mem_map/mm/page_alloc.c
--- C-create-__boot-ppc64/mm/page_alloc.c	2004-07-28 11:33:43.000000000 -0700
+++ D-init-no-mem_map/mm/page_alloc.c	2004-07-28 12:56:26.000000000 -0700
@@ -1396,11 +1396,12 @@
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
-void __init memmap_init_zone(struct page *start, unsigned long size, int nid,
+void __init memmap_init_zone(unsigned long size, int nid,
 		unsigned long zone, unsigned long start_pfn)
 {
-	struct page *page;
+	struct page *page, *start;
 
+	start = pfn_to_page(start_pfn);
 	for (page = start; page < (start + size); page++) {
 		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
@@ -1462,8 +1463,8 @@
 }
 
 #ifndef __HAVE_ARCH_MEMMAP_INIT
-#define memmap_init(start, size, nid, zone, start_pfn) \
-	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
+#define memmap_init(size, nid, zone, start_pfn) \
+	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
 /*
@@ -1478,7 +1479,6 @@
 	unsigned long i, j;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
-	struct page *lmem_map = pgdat->node_mem_map;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
 	pgdat->nr_zones = 0;
@@ -1566,35 +1566,38 @@
 
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
@@ -1607,7 +1610,7 @@
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+	free_area_init_node(0, &contig_page_data, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 	mem_map = contig_page_data.node_mem_map;
 }

--=-OI/cO9exPTW22IEXDNme--

