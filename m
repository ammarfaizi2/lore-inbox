Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVCGXxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVCGXxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVCGXlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:41:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:5514 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261804AbVCGX3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:29:00 -0500
Subject: [PATCH] no arch-specific mem_map init
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="=-jUyheRscNblqGksMyOFJ"
Date: Mon, 07 Mar 2005 15:28:40 -0800
Message-Id: <1110238120.6446.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jUyheRscNblqGksMyOFJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been sitting this in the memhotplug tree for quite a while. It's
invasive, but it's been pretty well tested on the hardware that I
can get my hands on.  I think it's ready for a run in -mm.

-- Dave

--=-jUyheRscNblqGksMyOFJ
Content-Disposition: attachment; filename=A6-no_arch_mem_map_init.patch
Content-Type: text/x-patch; name=A6-no_arch_mem_map_init.patch; charset=ANSI_X3.4-1968
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

The following patch does what my first one did (don't pass mem_map into
the init functions), incorporates Jesse Barnes' ia64 fixes on top of
that, and gets rid of all but one of the global mem_map initializations
(parisc is weird).  It also magically removes more code than it adds. 
It could be smaller, but I shamelessly added some comments.  

Boot-tested on ppc64, i386 (NUMAQ, plain SMP, laptop), UML (i386).

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/arm/mm/init.c           |    4 ----
 memhotplug-dave/arch/arm26/mm/init.c         |    2 --
 memhotplug-dave/arch/cris/arch-v10/mm/init.c |    1 -
 memhotplug-dave/arch/ia64/mm/contig.c        |    2 +-
 memhotplug-dave/arch/m32r/mm/init.c          |    2 --
 memhotplug-dave/arch/ppc64/mm/init.c         |    1 -
 memhotplug-dave/arch/sh/mm/init.c            |    2 --
 memhotplug-dave/arch/sh64/mm/init.c          |    3 ---
 memhotplug-dave/arch/sparc/mm/srmmu.c        |    1 -
 memhotplug-dave/arch/sparc/mm/sun4c.c        |    1 -
 memhotplug-dave/arch/sparc64/mm/init.c       |    1 -
 memhotplug-dave/arch/um/kernel/physmem.c     |    1 -
 memhotplug-dave/arch/v850/kernel/setup.c     |    1 -
 memhotplug-dave/mm/page_alloc.c              |   22 ++++++++++++++++------
 14 files changed, 17 insertions(+), 27 deletions(-)

diff -puN arch/arm/mm/init.c~A6-no_arch_mem_map_init arch/arm/mm/init.c
--- memhotplug/arch/arm/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/arm/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -501,10 +501,6 @@ void __init paging_init(struct meminfo *
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
-#endif
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
diff -puN arch/arm26/mm/init.c~A6-no_arch_mem_map_init arch/arm26/mm/init.c
--- memhotplug/arch/arm26/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/arm26/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -309,8 +309,6 @@ void __init paging_init(struct meminfo *
 	free_area_init_node(0, pgdat, zone_size,
 			bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 
-	mem_map = NODE_DATA(0)->node_mem_map;
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
diff -puN arch/cris/arch-v10/mm/init.c~A6-no_arch_mem_map_init arch/cris/arch-v10/mm/init.c
--- memhotplug/arch/cris/arch-v10/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/cris/arch-v10/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -184,7 +184,6 @@ paging_init(void)
 	 */
 
 	free_area_init_node(0, &contig_page_data, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
-	mem_map = contig_page_data.node_mem_map;
 }
 
 /* Initialize remaps of some I/O-ports. It is important that this
diff -puN arch/i386/mm/discontig.c~A6-no_arch_mem_map_init arch/i386/mm/discontig.c
diff -puN arch/ia64/mm/contig.c~A6-no_arch_mem_map_init arch/ia64/mm/contig.c
--- memhotplug/arch/ia64/mm/contig.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/ia64/mm/contig.c	2005-03-04 09:16:41.000000000 -0800
@@ -280,7 +280,7 @@ paging_init (void)
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, NULL);
 
-		mem_map = contig_page_data.node_mem_map = vmem_map;
+		NODE_DATA(0)->node_mem_map = vmem_map;
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
diff -puN arch/ppc64/mm/init.c~A6-no_arch_mem_map_init arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/ppc64/mm/init.c	2005-03-04 13:41:28.000000000 -0800
@@ -658,7 +658,6 @@ void __init paging_init(void)
 
 	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
-	mem_map = contig_page_data.node_mem_map;
 }
 #endif /* CONFIG_DISCONTIGMEM */
 
diff -puN arch/sh/mm/init.c~A6-no_arch_mem_map_init arch/sh/mm/init.c
--- memhotplug/arch/sh/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/sh/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -216,8 +216,6 @@ void __init paging_init(void)
 #endif
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
 
 #ifdef CONFIG_DISCONTIGMEM
 	/*
diff -puN arch/sh64/mm/init.c~A6-no_arch_mem_map_init arch/sh64/mm/init.c
--- memhotplug/arch/sh64/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/sh64/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -124,9 +124,6 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA] = MAX_LOW_PFN - START_PFN;
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
 
 void __init mem_init(void)
diff -puN arch/sparc/mm/srmmu.c~A6-no_arch_mem_map_init arch/sparc/mm/srmmu.c
--- memhotplug/arch/sparc/mm/srmmu.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/sparc/mm/srmmu.c	2005-03-04 09:16:41.000000000 -0800
@@ -1344,7 +1344,6 @@ void __init srmmu_paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 }
 
diff -puN arch/sparc/mm/sun4c.c~A6-no_arch_mem_map_init arch/sparc/mm/sun4c.c
--- memhotplug/arch/sparc/mm/sun4c.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/sparc/mm/sun4c.c	2005-03-04 09:16:41.000000000 -0800
@@ -2117,7 +2117,6 @@ void __init sun4c_paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	cnt = 0;
diff -puN arch/sparc64/mm/init.c~A6-no_arch_mem_map_init arch/sparc64/mm/init.c
--- memhotplug/arch/sparc64/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/sparc64/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -1512,7 +1512,6 @@ void __init paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	device_scan();
diff -puN arch/v850/kernel/setup.c~A6-no_arch_mem_map_init arch/v850/kernel/setup.c
--- memhotplug/arch/v850/kernel/setup.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/v850/kernel/setup.c	2005-03-04 09:16:41.000000000 -0800
@@ -283,5 +283,4 @@ init_mem_alloc (unsigned long ram_start,
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
diff -puN mm/page_alloc.c~A6-no_arch_mem_map_init mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-03-04 13:41:29.000000000 -0800
@@ -1730,14 +1730,25 @@ static void __init free_area_init_core(s
 	}
 }
 
-void __init node_alloc_mem_map(struct pglist_data *pgdat)
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long size;
 
-	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
-	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+	/* Skip empty nodes */
+	if (!pgdat->node_spanned_pages)
+		return;
+
+	/* ia64 gets its own node_mem_map, before this, without bootmem */
+	if (!pgdat->node_mem_map) {
+		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+		pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+	}
 #ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0))
+		mem_map = NODE_DATA(0)->node_mem_map;
 #endif
 }
 
@@ -1749,8 +1760,7 @@ void __init free_area_init_node(int nid,
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
 
-	if (!pfn_to_page(node_start_pfn))
-		node_alloc_mem_map(pgdat);
+	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
diff -puN arch/i386/kernel/mpparse.c~A6-no_arch_mem_map_init arch/i386/kernel/mpparse.c
diff -puN arch/i386/kernel/setup.c~A6-no_arch_mem_map_init arch/i386/kernel/setup.c
diff -puN arch/m32r/mm/init.c~A6-no_arch_mem_map_init arch/m32r/mm/init.c
--- memhotplug/arch/m32r/mm/init.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/m32r/mm/init.c	2005-03-04 09:16:41.000000000 -0800
@@ -121,8 +121,6 @@ unsigned long __init zone_sizes_init(voi
 
 	free_area_init_node(0, NODE_DATA(0), zones_size, start_pfn, 0);
 
-	mem_map = contig_page_data.node_mem_map;
-
 	return 0;
 }
 #else	/* CONFIG_DISCONTIGMEM */
diff -puN arch/um/kernel/physmem.c~A6-no_arch_mem_map_init arch/um/kernel/physmem.c
--- memhotplug/arch/um/kernel/physmem.c~A6-no_arch_mem_map_init	2005-03-04 09:16:41.000000000 -0800
+++ memhotplug-dave/arch/um/kernel/physmem.c	2005-03-04 09:16:41.000000000 -0800
@@ -294,7 +294,6 @@ int init_maps(unsigned long physmem, uns
 		INIT_LIST_HEAD(&p->lru);
 	}
 
-	mem_map = map;
 	max_mapnr = total_pages;
 	return(0);
 }
_

--=-jUyheRscNblqGksMyOFJ--

