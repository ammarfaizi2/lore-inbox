Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUHXSDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUHXSDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUHXSDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:03:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11730 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268141AbUHXSDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:03:33 -0400
Subject: [PATCH] no arch-specific mem_map init
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="=-za2gHEp0uAoLzgHBa3iI"
Message-Id: <1093370583.1009.195.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 11:03:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-za2gHEp0uAoLzgHBa3iI
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

The patch magically removes more code than it adds.  It could be
smaller, but I shamelessly added some comments.

Applies on top of 2.6.8.1-mm4.  It touches enough architectures that it
probably needs plenty of cooling-off time in -mm.  

-- Dave

--=-za2gHEp0uAoLzgHBa3iI
Content-Disposition: attachment; filename=no_arch_mem_map_init.patch
Content-Type: text/x-patch; name=no_arch_mem_map_init.patch; charset=ANSI_X3.4-1968
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

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---
diff -urp clean/arch/arm/mm/init.c btest/arch/arm/mm/init.c
--- clean/arch/arm/mm/init.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/arm/mm/init.c	2004-08-24 10:47:18.000000000 -0700
@@ -499,10 +499,6 @@ void __init paging_init(struct meminfo *
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
-#endif
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
diff -urp clean/arch/arm26/mm/init.c btest/arch/arm26/mm/init.c
--- clean/arch/arm26/mm/init.c	2004-08-23 08:07:29.000000000 -0700
+++ btest/arch/arm26/mm/init.c	2004-08-24 10:47:18.000000000 -0700
@@ -306,11 +306,9 @@ void __init paging_init(struct meminfo *
 	if (!zone_size[0])
 		BUG();
 
-	free_area_init_node(0, pgdat, 0, zone_size,
+	free_area_init_node(0, pgdat, zone_size,
 			bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 
-	mem_map = NODE_DATA(0)->node_mem_map;
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
diff -urp clean/arch/cris/arch-v10/mm/init.c btest/arch/cris/arch-v10/mm/init.c
--- clean/arch/cris/arch-v10/mm/init.c	2004-08-23 08:07:28.000000000 -0700
+++ btest/arch/cris/arch-v10/mm/init.c	2004-08-24 10:47:18.000000000 -0700
@@ -183,8 +183,7 @@ paging_init(void)
 	 * mem_map page array.
 	 */
 
-	free_area_init_node(0, &contig_page_data, 0, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
-	mem_map = contig_page_data.node_mem_map;
+	free_area_init_node(0, &contig_page_data, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
 }
 
 /* Initialize remaps of some I/O-ports. It is important that this
diff -urp clean/arch/i386/mm/discontig.c btest/arch/i386/mm/discontig.c
--- clean/arch/i386/mm/discontig.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/i386/mm/discontig.c	2004-08-24 10:47:18.000000000 -0700
@@ -417,18 +417,15 @@ void __init zone_sizes_init(void)
 		 * normal bootmem allocator, but other nodes come from the
 		 * remapped KVA area - mbligh
 		 */
-		if (!nid)
-			free_area_init_node(nid, NODE_DATA(nid),
-					zones_size, start, zholes_size);
-		else {
+		if (nid) {
 			unsigned long lmem_map;
 			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
 			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
 			lmem_map &= PAGE_MASK;
 			NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
-			free_area_init_node(nid, NODE_DATA(nid), zones_size,
-				start, zholes_size);
 		}
+		free_area_init_node(nid, NODE_DATA(nid), zones_size,
+				    start, zholes_size);
 	}
 	return;
 }
diff -urp clean/arch/ia64/mm/contig.c btest/arch/ia64/mm/contig.c
--- clean/arch/ia64/mm/contig.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/ia64/mm/contig.c	2004-08-24 10:47:18.000000000 -0700
@@ -269,7 +269,6 @@ paging_init (void)
 		vmem_map = (struct page *) 0;
 		free_area_init_node(0, &contig_page_data, zones_size, 0,
 				    zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	} else {
 		unsigned long map_size;
 
@@ -280,11 +279,10 @@ paging_init (void)
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, 0);
 
-		contig_page_data.node_mem_map = vmem_map;
+		NODE_DATA(0)->node_mem_map = vmem_map;
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
-		mem_map = contig_page_data.node_mem_map;
 		printk("Virtual mem_map starts at 0x%p\n", mem_map);
 	}
 #else /* !CONFIG_VIRTUAL_MEM_MAP */
diff -urp clean/arch/ia64/mm/discontig.c btest/arch/ia64/mm/discontig.c
--- clean/arch/ia64/mm/discontig.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/ia64/mm/discontig.c	2004-08-24 10:47:18.000000000 -0700
@@ -665,6 +665,7 @@ void paging_init(void)
 
 		pfn_offset = mem_data[node].min_pfn;
 
+		NODE_DATA(node)->node_mem_map = vmem_map + pfn_offset;
 		free_area_init_node(node, NODE_DATA(node), zones_size,
 				    pfn_offset, zholes_size);
 	}
diff -urp clean/arch/ia64/mm/init.c btest/arch/ia64/mm/init.c
--- clean/arch/ia64/mm/init.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/ia64/mm/init.c	2004-08-24 10:47:18.000000000 -0700
@@ -429,7 +429,7 @@ virtual_memmap_init (u64 start, u64 end,
 		    / sizeof(struct page));
 
 	if (map_start < map_end)
-		memmap_init_zone((unsigned long)(map_end - map_start),
+		memmap_init_zone(map_start, (unsigned long) (map_end - map_start),
 				 args->nid, args->zone, page_to_pfn(map_start));
 	return 0;
 }
diff -urp clean/arch/ppc64/mm/init.c btest/arch/ppc64/mm/init.c
--- clean/arch/ppc64/mm/init.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/ppc64/mm/init.c	2004-08-24 10:47:18.000000000 -0700
@@ -615,7 +615,6 @@ void __init paging_init(void)
 
 	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
-	mem_map = contig_page_data.node_mem_map;
 }
 #endif /* CONFIG_DISCONTIGMEM */
 
diff -urp clean/arch/sh/mm/init.c btest/arch/sh/mm/init.c
--- clean/arch/sh/mm/init.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/sh/mm/init.c	2004-08-24 10:47:28.000000000 -0700
@@ -215,9 +215,7 @@ void __init paging_init(void)
 	disable_mmu();
 #endif
 
-	free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
+	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
 
 #ifdef CONFIG_DISCONTIGMEM
 	/*
diff -urp clean/arch/sh64/mm/init.c btest/arch/sh64/mm/init.c
--- clean/arch/sh64/mm/init.c	2004-08-23 08:07:29.000000000 -0700
+++ btest/arch/sh64/mm/init.c	2004-08-24 10:47:28.000000000 -0700
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
diff -urp clean/arch/sparc/mm/srmmu.c btest/arch/sparc/mm/srmmu.c
--- clean/arch/sparc/mm/srmmu.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/sparc/mm/srmmu.c	2004-08-24 10:47:28.000000000 -0700
@@ -1343,7 +1343,6 @@ void __init srmmu_paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 }
 
diff -urp clean/arch/sparc/mm/sun4c.c btest/arch/sparc/mm/sun4c.c
--- clean/arch/sparc/mm/sun4c.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/sparc/mm/sun4c.c	2004-08-24 10:47:28.000000000 -0700
@@ -2116,7 +2116,6 @@ void __init sun4c_paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	cnt = 0;
diff -urp clean/arch/sparc64/mm/init.c btest/arch/sparc64/mm/init.c
--- clean/arch/sparc64/mm/init.c	2004-08-23 08:08:11.000000000 -0700
+++ btest/arch/sparc64/mm/init.c	2004-08-24 10:47:28.000000000 -0700
@@ -1504,7 +1504,6 @@ void __init paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	device_scan();
diff -urp clean/arch/v850/kernel/setup.c btest/arch/v850/kernel/setup.c
--- clean/arch/v850/kernel/setup.c	2004-08-23 08:07:29.000000000 -0700
+++ btest/arch/v850/kernel/setup.c	2004-08-24 10:47:29.000000000 -0700
@@ -281,7 +281,6 @@ init_mem_alloc (unsigned long ram_start,
 #error MAX_ORDER is too large for given PAGE_OFFSET (use CONFIG_FORCE_MAX_ZONEORDER to change it)
 #endif
 
-	free_area_init_node (0, NODE_DATA(0), 0, zones_size,
+	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
diff -urp clean/mm/page_alloc.c btest/mm/page_alloc.c
--- clean/mm/page_alloc.c	2004-08-23 08:08:23.000000000 -0700
+++ btest/mm/page_alloc.c	2004-08-24 10:47:28.000000000 -0700
@@ -1690,14 +1690,25 @@ static void __init free_area_init_core(s
 	}
 }
 
-void __init node_alloc_mem_map(struct pglist_data *pgdat)
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
 	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
 	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
 #ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0))
+		mem_map = NODE_DATA(0)->node_mem_map;
 #endif
 }
 
@@ -1709,8 +1720,7 @@ void __init free_area_init_node(int nid,
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
 
-	if (!pfn_to_page(node_start_pfn))
-		node_alloc_mem_map(pgdat);
+	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }

--=-za2gHEp0uAoLzgHBa3iI--

