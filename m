Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318970AbSHFDP4>; Mon, 5 Aug 2002 23:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSHFDPE>; Mon, 5 Aug 2002 23:15:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32972 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318970AbSHFDOw>; Mon, 5 Aug 2002 23:14:52 -0400
Message-Id: <200208060318.g763I2c25128@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, mjbligh@us.ibm.com
Subject: [PATCH] {node,zone}_start_paddr to pfn for 2.4.20pre1
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-19820892080"
Date: Mon, 05 Aug 2002 20:18:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-19820892080
Content-Type: text/plain; charset=us-ascii


This patch was written by Martin Bligh.  

Please consider this patch for inclusion into the 2.4.20pre tree.  It
has been accepted to the aa tree.  This version of the patch is just 
a forward port of the aa patch.

This patch changes all references of node_start_paddr and zone_start_paddr 
to node_start_pfn and zone_start_pfn.  This change is required to support PAE
for i386 discontigmem.

Here's Martin's previous discussion regarding these changes:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101925939829917&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101925421326030&w=2

I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
multiquad, multiquad PAE, multiquad DISCONTIGMEM, multiquad DISCONTIGMEM PAE.

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


--==_Exmh_-19820892080
Content-Type: application/x-patch ; name="linux-2.4.20-pre1_zone_start_pfn_A2.patch"
Content-Description: linux-2.4.20-pre1_zone_start_pfn_A2.patch
Content-Disposition: attachment; filename="linux-2.4.20-pre1_zone_start_pfn_A2.patch"

diff -Nru a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
--- a/arch/alpha/mm/numa.c	Mon Aug  5 18:23:14 2002
+++ b/arch/alpha/mm/numa.c	Mon Aug  5 18:23:14 2002
@@ -294,7 +294,7 @@
 			zones_size[ZONE_DMA] = dma_local_pfn;
 			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
 		}
-		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn<<PAGE_SHIFT, NULL);
+		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn, NULL);
 		lmax_mapnr = PLAT_NODE_DATA_STARTNR(nid) + PLAT_NODE_DATA_SIZE(nid);
 		if (lmax_mapnr > max_mapnr) {
 			max_mapnr = lmax_mapnr;
@@ -372,7 +372,7 @@
 		totalram_pages += free_all_bootmem_node(NODE_DATA(nid));
 
 		lmem_map = NODE_MEM_MAP(nid);
-		pfn = NODE_DATA(nid)->node_start_paddr >> PAGE_SHIFT;
+		pfn = NODE_DATA(nid)->node_start_pfn;
 		for (i = 0; i < PLAT_NODE_DATA_SIZE(nid); i++, pfn++)
 			if (page_is_ram(pfn) && PageReserved(lmem_map+i))
 				reservedpages++;
diff -Nru a/arch/arm/mm/init.c b/arch/arm/mm/init.c
--- a/arch/arm/mm/init.c	Mon Aug  5 18:23:14 2002
+++ b/arch/arm/mm/init.c	Mon Aug  5 18:23:14 2002
@@ -558,7 +558,7 @@
 		arch_adjust_zones(node, zone_size, zhole_size);
 
 		free_area_init_node(node, pgdat, 0, zone_size,
-				bdata->node_boot_start, zhole_size);
+				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
 	/*
diff -Nru a/arch/cris/mm/init.c b/arch/cris/mm/init.c
--- a/arch/cris/mm/init.c	Mon Aug  5 18:23:14 2002
+++ b/arch/cris/mm/init.c	Mon Aug  5 18:23:14 2002
@@ -361,7 +361,7 @@
 	 * mem_map page array.
 	 */
 
-	free_area_init_node(0, 0, 0, zones_size, PAGE_OFFSET, 0);
+	free_area_init_node(0, 0, 0, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
 
 }
 
diff -Nru a/arch/mips64/sgi-ip27/ip27-memory.c b/arch/mips64/sgi-ip27/ip27-memory.c
--- a/arch/mips64/sgi-ip27/ip27-memory.c	Mon Aug  5 18:23:14 2002
+++ b/arch/mips64/sgi-ip27/ip27-memory.c	Mon Aug  5 18:23:14 2002
@@ -253,7 +253,7 @@
 
 		zones_size[ZONE_DMA] = end_pfn + 1 - start_pfn;
 		free_area_init_node(node, NODE_DATA(node), 0, zones_size, 
-						start_pfn << PAGE_SHIFT, 0);
+						start_pfn, 0);
 		if ((PLAT_NODE_DATA_STARTNR(node) + 
 					PLAT_NODE_DATA_SIZE(node)) > pagenr)
 			pagenr = PLAT_NODE_DATA_STARTNR(node) +
diff -Nru a/arch/sh/mm/init.c b/arch/sh/mm/init.c
--- a/arch/sh/mm/init.c	Mon Aug  5 18:23:14 2002
+++ b/arch/sh/mm/init.c	Mon Aug  5 18:23:14 2002
@@ -127,11 +127,11 @@
 			zones_size[ZONE_DMA] = max_dma - start_pfn;
 			zones_size[ZONE_NORMAL] = low - max_dma;
 		}
-		free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START, 0);
+		free_area_init_node(0, NODE_DATA(0), 0, zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
 #ifdef CONFIG_DISCONTIGMEM
 		zones_size[ZONE_DMA] = __MEMORY_SIZE_2ND >> PAGE_SHIFT;
 		zones_size[ZONE_NORMAL] = 0;
-		free_area_init_node(1, NODE_DATA(1), 0, zones_size, __MEMORY_START_2ND, 0);
+		free_area_init_node(1, NODE_DATA(1), 0, zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
 #endif
  	}
 }
diff -Nru a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	Mon Aug  5 18:23:14 2002
+++ b/arch/sparc/mm/srmmu.c	Mon Aug  5 18:23:14 2002
@@ -1244,7 +1244,7 @@
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
 		free_area_init_node(0, NULL, NULL, zones_size,
-				    phys_base, zholes_size);
+				    phys_base >> PAGE_SHIFT, zholes_size);
 	}
 }
 
diff -Nru a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
--- a/arch/sparc/mm/sun4c.c	Mon Aug  5 18:23:14 2002
+++ b/arch/sparc/mm/sun4c.c	Mon Aug  5 18:23:14 2002
@@ -2042,7 +2042,7 @@
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
 		free_area_init_node(0, NULL, NULL, zones_size,
-				    phys_base, zholes_size);
+				    phys_base >> PAGE_SHIFT, zholes_size);
 	}
 
 	cnt = 0;
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	Mon Aug  5 18:23:14 2002
+++ b/arch/sparc64/mm/init.c	Mon Aug  5 18:23:14 2002
@@ -1434,7 +1434,7 @@
 		zholes_size[ZONE_DMA] = npages - pages_avail;
 
 		free_area_init_node(0, NULL, NULL, zones_size,
-				    phys_base, zholes_size);
+				    phys_base >> PAGE_SHIFT, zholes_size);
 	}
 
 	device_scan();
diff -Nru a/include/asm-alpha/mmzone.h b/include/asm-alpha/mmzone.h
--- a/include/asm-alpha/mmzone.h	Mon Aug  5 18:23:14 2002
+++ b/include/asm-alpha/mmzone.h	Mon Aug  5 18:23:14 2002
@@ -52,14 +52,14 @@
 
 #if 1
 #define PLAT_NODE_DATA_LOCALNR(p, n)	\
-	(((p) - PLAT_NODE_DATA(n)->gendata.node_start_paddr) >> PAGE_SHIFT)
+	(((p) >> PAGE_SHIFT) - PLAT_NODE_DATA(n)->gendata.node_start_pfn)
 #else
 static inline unsigned long
 PLAT_NODE_DATA_LOCALNR(unsigned long p, int n)
 {
 	unsigned long temp;
-	temp = p - PLAT_NODE_DATA(n)->gendata.node_start_paddr;
-	return (temp >> PAGE_SHIFT);
+	temp = p >> PAGE_SHIFT;
+	return temp - PLAT_NODE_DATA(n)->gendata.node_start_pfn;
 }
 #endif
 
@@ -96,7 +96,7 @@
  * and returns the kaddr corresponding to first physical page in the
  * node's mem_map.
  */
-#define LOCAL_BASE_ADDR(kaddr)	((unsigned long)__va(NODE_DATA(KVADDR_TO_NID(kaddr))->node_start_paddr))
+#define LOCAL_BASE_ADDR(kaddr)	((unsigned long)__va(NODE_DATA(KVADDR_TO_NID(kaddr))->node_start_pfn << PAGE_SHIFT))
 
 #define LOCAL_MAP_NR(kvaddr) \
 	(((unsigned long)(kvaddr)-LOCAL_BASE_ADDR(kvaddr)) >> PAGE_SHIFT)
diff -Nru a/include/asm-alpha/pgtable.h b/include/asm-alpha/pgtable.h
--- a/include/asm-alpha/pgtable.h	Mon Aug  5 18:23:14 2002
+++ b/include/asm-alpha/pgtable.h	Mon Aug  5 18:23:14 2002
@@ -193,9 +193,9 @@
 #ifndef CONFIG_DISCONTIGMEM
 #define PAGE_TO_PA(page)	((page - mem_map) << PAGE_SHIFT)
 #else
-#define PAGE_TO_PA(page) \
-		((((page)-page_zone(page)->zone_mem_map) << PAGE_SHIFT) \
-		+ page_zone(page)->zone_start_paddr)
+#define PAGE_TO_PA(page)					\
+		((((page)-page_zone(page)->zone_mem_map) +	\
+		 page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
 #endif
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -214,7 +214,7 @@
 	unsigned long pfn;							\
 										\
 	pfn = ((unsigned long)((page)-page_zone(page)->zone_mem_map)) << 32;	\
-	pfn += page_zone(page)->zone_start_paddr << (32-PAGE_SHIFT);		\
+	pfn += page_zone(page)->zone_start_pfn << 32;				\
 	pte_val(pte) = pfn | pgprot_val(pgprot);				\
 										\
 	pte;									\
diff -Nru a/include/asm-mips64/mmzone.h b/include/asm-mips64/mmzone.h
--- a/include/asm-mips64/mmzone.h	Mon Aug  5 18:23:14 2002
+++ b/include/asm-mips64/mmzone.h	Mon Aug  5 18:23:14 2002
@@ -27,7 +27,7 @@
 #define PLAT_NODE_DATA_STARTNR(n)    (PLAT_NODE_DATA(n)->gendata.node_start_mapnr)
 #define PLAT_NODE_DATA_SIZE(n)	     (PLAT_NODE_DATA(n)->gendata.node_size)
 #define PLAT_NODE_DATA_LOCALNR(p, n) \
-		(((p) - PLAT_NODE_DATA(n)->gendata.node_start_paddr) >> PAGE_SHIFT)
+		(((p) >> PAGE_SHIFT) - PLAT_NODE_DATA(n)->gendata.node_start_pfn)
 
 #define numa_node_id()	cputocnode(current->processor)
 
diff -Nru a/include/asm-mips64/pgtable.h b/include/asm-mips64/pgtable.h
--- a/include/asm-mips64/pgtable.h	Mon Aug  5 18:23:14 2002
+++ b/include/asm-mips64/pgtable.h	Mon Aug  5 18:23:14 2002
@@ -488,8 +488,8 @@
 #define PAGE_TO_PA(page)	((page - mem_map) << PAGE_SHIFT)
 #else
 #define PAGE_TO_PA(page) \
-		((((page) - page_zone(page)->zone_mem_map) << PAGE_SHIFT) \
-		  + (page_zone(page)->zone_start_paddr))
+		((((page) - page_zone(page)->zone_mem_map) \
+		  + (page_zone(page)->zone_start_pfn)) << PAGE_SHIFT)
 #endif
 #define mk_pte(page, pgprot)						\
 ({									\
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Mon Aug  5 18:23:14 2002
+++ b/include/linux/mm.h	Mon Aug  5 18:23:14 2002
@@ -364,8 +364,8 @@
 #else /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
 
 #define page_address(page)						\
-	__va( (((page) - page_zone(page)->zone_mem_map) << PAGE_SHIFT)	\
-			+ page_zone(page)->zone_start_paddr)
+	__va( (((page) - page_zone(page)->zone_mem_map) 	\
+			+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
 
 #endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
 
@@ -509,7 +509,7 @@
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
-	unsigned long * zones_size, unsigned long zone_start_paddr, 
+	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
 extern void mem_init(void);
 extern void show_mem(void);
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Mon Aug  5 18:23:14 2002
+++ b/include/linux/mmzone.h	Mon Aug  5 18:23:14 2002
@@ -82,7 +82,8 @@
 	 */
 	struct pglist_data	*zone_pgdat;
 	struct page		*zone_mem_map;
-	unsigned long		zone_start_paddr;
+	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
+	unsigned long		zone_start_pfn;
 	unsigned long		zone_start_mapnr;
 
 	/*
@@ -133,7 +134,7 @@
 	struct page *node_mem_map;
 	unsigned long *valid_addr_bitmap;
 	struct bootmem_data *bdata;
-	unsigned long node_start_paddr;
+	unsigned long node_start_pfn;
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
diff -Nru a/mm/numa.c b/mm/numa.c
--- a/mm/numa.c	Mon Aug  5 18:23:14 2002
+++ b/mm/numa.c	Mon Aug  5 18:23:14 2002
@@ -22,11 +22,11 @@
  * Should be invoked with paramters (0, 0, unsigned long *[], start_paddr).
  */
 void __init free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
-	unsigned long *zones_size, unsigned long zone_start_paddr, 
+	unsigned long *zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size)
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 
-				zone_start_paddr, zholes_size, pmap);
+				zone_start_pfn, zholes_size, pmap);
 }
 
 #endif /* !CONFIG_DISCONTIGMEM */
@@ -59,7 +59,7 @@
  * Nodes can be initialized parallely, in no particular order.
  */
 void __init free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
-	unsigned long *zones_size, unsigned long zone_start_paddr, 
+	unsigned long *zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size)
 {
 	int i, size = 0;
@@ -68,7 +68,7 @@
 	if (mem_map == (mem_map_t *)NULL)
 		mem_map = (mem_map_t *)PAGE_OFFSET;
 
-	free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_paddr,
+	free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_pfn,
 					zholes_size, pmap);
 	pgdat->node_id = nid;
 
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Mon Aug  5 18:23:14 2002
+++ b/mm/page_alloc.c	Mon Aug  5 18:23:14 2002
@@ -680,7 +680,7 @@
  *   - clear the memory bitmaps
  */
 void __init free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
-	unsigned long *zones_size, unsigned long zone_start_paddr, 
+	unsigned long *zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size, struct page *lmem_map)
 {
 	unsigned long i, j;
@@ -688,9 +688,6 @@
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
-
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		unsigned long size = zones_size[i];
@@ -718,7 +715,7 @@
 	}
 	*gmap = pgdat->node_mem_map = lmem_map;
 	pgdat->node_size = totalpages;
-	pgdat->node_start_paddr = zone_start_paddr;
+	pgdat->node_start_pfn = zone_start_pfn;
 	pgdat->node_start_mapnr = (lmem_map - mem_map);
 	pgdat->nr_zones = 0;
 
@@ -770,9 +767,9 @@
 
 		zone->zone_mem_map = mem_map + offset;
 		zone->zone_start_mapnr = offset;
-		zone->zone_start_paddr = zone_start_paddr;
+		zone->zone_start_pfn = zone_start_pfn;
 
-		if ((zone_start_paddr >> PAGE_SHIFT) & (zone_required_alignment-1))
+		if ((zone_start_pfn) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");
 
 		/*
@@ -787,8 +784,12 @@
 			SetPageReserved(page);
 			INIT_LIST_HEAD(&page->list);
 			if (j != ZONE_HIGHMEM)
-				set_page_address(page, __va(zone_start_paddr));
-			zone_start_paddr += PAGE_SIZE;
+				/*
+				 * The shift left won't overflow because the
+				 * ZONE_NORMAL is below 4G.
+				 */
+				set_page_address(page, __va(zone_start_pfn << PAGE_SHIFT));
+			zone_start_pfn++;
 		}
 
 		offset += size;

--==_Exmh_-19820892080--


