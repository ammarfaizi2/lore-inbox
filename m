Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313090AbSDSXaM>; Fri, 19 Apr 2002 19:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312076AbSDSX2E>; Fri, 19 Apr 2002 19:28:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47270 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313128AbSDSXRY>;
	Fri, 19 Apr 2002 19:17:24 -0400
Date: Fri, 19 Apr 2002 17:15:43 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] / [CFT] convert zone_start_paddr to zone_start_pfn
Message-ID: <2950000.1019261743@flay>
In-Reply-To: <1985660000.1019257493@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At present we store zone_start_paddr as an unsigned long, which is
not correct - it may work for some architectures, but not for others
(eg ia32 with PAE, where a paddr is 36 bits and a ulong is 32).

Below is a (untested) patch to convert the paddr to a pfn. This patch
applies on top of the previous node_start_paddr, though there's only
one conflict, and it's easy to fix.
 
zone_start_pfn == zone_start_paddr >> PAGE_SHIFT

Comments ?

M.

diff -urN linux-2.5.8-node_start_paddr/arch/alpha/mm/numa.c linux-2.5.8-zone_start_paddr/arch/alpha/mm/numa.c
--- linux-2.5.8-node_start_paddr/arch/alpha/mm/numa.c	Fri Apr 19 15:24:11 2002
+++ linux-2.5.8-zone_start_paddr/arch/alpha/mm/numa.c	Fri Apr 19 16:50:20 2002
@@ -294,7 +294,7 @@
 			zones_size[ZONE_DMA] = dma_local_pfn;
 			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
 		}
-		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn<<PAGE_SHIFT, NULL);
+		free_area_init_node(nid, NODE_DATA(nid), NULL, zones_size, start_pfn, NULL);
 		lmax_mapnr = PLAT_NODE_DATA_STARTNR(nid) + PLAT_NODE_DATA_SIZE(nid);
 		if (lmax_mapnr > max_mapnr) {
 			max_mapnr = lmax_mapnr;
diff -urN linux-2.5.8-node_start_paddr/include/asm-alpha/pgtable.h linux-2.5.8-zone_start_paddr/include/asm-alpha/pgtable.h
--- linux-2.5.8-node_start_paddr/include/asm-alpha/pgtable.h	Sun Apr 14 12:18:48 2002
+++ linux-2.5.8-zone_start_paddr/include/asm-alpha/pgtable.h	Fri Apr 19 16:35:26 2002
@@ -194,8 +194,8 @@
 #define PAGE_TO_PA(page)	((page - mem_map) << PAGE_SHIFT)
 #else
 #define PAGE_TO_PA(page) \
-		((((page)-(page)->zone->zone_mem_map) << PAGE_SHIFT) \
-		+ (page)->zone->zone_start_paddr)
+		(( ((page)-(page)->zone->zone_mem_map) \
+		   + (page)->zone->zone_start_pfn) << PAGE_SHIFT) 
 #endif
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -214,7 +214,7 @@
 	unsigned long pfn;							\
 										\
 	pfn = ((unsigned long)((page)-(page)->zone->zone_mem_map)) << 32;	\
-	pfn += (page)->zone->zone_start_paddr << (32-PAGE_SHIFT);		\
+	pfn += (page)->zone->zone_start_pfn << 32;		\
 	pte_val(pte) = pfn | pgprot_val(pgprot);				\
 										\
 	pte;									\
diff -urN linux-2.5.8-node_start_paddr/include/asm-mips64/pgtable.h linux-2.5.8-zone_start_paddr/include/asm-mips64/pgtable.h
--- linux-2.5.8-node_start_paddr/include/asm-mips64/pgtable.h	Sun Apr 14 12:18:56 2002
+++ linux-2.5.8-zone_start_paddr/include/asm-mips64/pgtable.h	Fri Apr 19 16:37:42 2002
@@ -484,8 +484,8 @@
 #define PAGE_TO_PA(page)	((page - mem_map) << PAGE_SHIFT)
 #else
 #define PAGE_TO_PA(page) \
-		((((page)-(page)->zone->zone_mem_map) << PAGE_SHIFT) \
-		+ ((page)->zone->zone_start_paddr))
+		(( ((page)-(page)->zone->zone_mem_map) \
+		   (page)->zone->zone_start_pfn) << PAGE_SHIFT)
 #endif
 #define mk_pte(page, pgprot)						\
 ({									\
diff -urN linux-2.5.8-node_start_paddr/include/linux/mm.h linux-2.5.8-zone_start_paddr/include/linux/mm.h
--- linux-2.5.8-node_start_paddr/include/linux/mm.h	Sun Apr 14 12:18:43 2002
+++ linux-2.5.8-zone_start_paddr/include/linux/mm.h	Fri Apr 19 16:21:27 2002
@@ -363,8 +363,8 @@
 #else /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
 
 #define page_address(page)						\
-	__va( (((page) - page_zone(page)->zone_mem_map) << PAGE_SHIFT)	\
-			+ page_zone(page)->zone_start_paddr)
+	__va( ( ((page) - page_zone(page)->zone_mem_map) \
+	     + page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
 
 #endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
 
@@ -461,7 +461,7 @@
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
-	unsigned long * zones_size, unsigned long zone_start_paddr, 
+	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
 extern void mem_init(void);
 extern void show_mem(void);
diff -urN linux-2.5.8-node_start_paddr/include/linux/mmzone.h linux-2.5.8-zone_start_paddr/include/linux/mmzone.h
--- linux-2.5.8-node_start_paddr/include/linux/mmzone.h	Fri Apr 19 15:23:28 2002
+++ linux-2.5.8-zone_start_paddr/include/linux/mmzone.h	Fri Apr 19 16:23:42 2002
@@ -81,7 +81,8 @@
 	 */
 	struct pglist_data	*zone_pgdat;
 	struct page		*zone_mem_map;
-	unsigned long		zone_start_paddr;
+	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
+	unsigned long		zone_start_pfn;
 	unsigned long		zone_start_mapnr;
 
 	/*
diff -urN linux-2.5.8-node_start_paddr/mm/highmem.c linux-2.5.8-zone_start_paddr/mm/highmem.c
--- linux-2.5.8-node_start_paddr/mm/highmem.c	Sun Apr 14 12:18:44 2002
+++ linux-2.5.8-zone_start_paddr/mm/highmem.c	Fri Apr 19 16:41:40 2002
@@ -379,7 +379,7 @@
 		/*
 		 * is destination page below bounce pfn?
 		 */
-		if ((page - page_zone(page)->zone_mem_map) + (page_zone(page)->zone_start_paddr >> PAGE_SHIFT) < pfn)
+		if ( ( (page - page_zone(page)->zone_mem_map) + page_zone(page)->zone_start_pfn ) < pfn)
 			continue;
 
 		/*
diff -urN linux-2.5.8-node_start_paddr/mm/numa.c linux-2.5.8-zone_start_paddr/mm/numa.c
--- linux-2.5.8-node_start_paddr/mm/numa.c	Sun Apr 14 12:18:49 2002
+++ linux-2.5.8-zone_start_paddr/mm/numa.c	Fri Apr 19 16:49:37 2002
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
 
diff -urN linux-2.5.8-node_start_paddr/mm/page_alloc.c linux-2.5.8-zone_start_paddr/mm/page_alloc.c
--- linux-2.5.8-node_start_paddr/mm/page_alloc.c	Fri Apr 19 15:32:01 2002
+++ linux-2.5.8-zone_start_paddr/mm/page_alloc.c	Fri Apr 19 16:55:43 2002
@@ -705,7 +705,7 @@
  *   - clear the memory bitmaps
  */
 void __init free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
-	unsigned long *zones_size, unsigned long zone_start_paddr, 
+	unsigned long *zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size, struct page *lmem_map)
 {
 	unsigned long i, j;
@@ -713,9 +713,6 @@
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
-
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		unsigned long size = zones_size[i];
@@ -746,7 +743,7 @@
 	}
 	*gmap = pgdat->node_mem_map = lmem_map;
 	pgdat->node_size = totalpages;
-	pgdat->node_start_pfn = zone_start_paddr >> PAGE_SHIFT;
+	pgdat->node_start_pfn = zone_start_pfn;
 	pgdat->node_start_mapnr = (lmem_map - mem_map);
 	pgdat->nr_zones = 0;
 
@@ -798,9 +795,9 @@
 
 		zone->zone_mem_map = mem_map + offset;
 		zone->zone_start_mapnr = offset;
-		zone->zone_start_paddr = zone_start_paddr;
+		zone->zone_start_pfn = zone_start_pfn;
 
-		if ((zone_start_paddr >> PAGE_SHIFT) & (zone_required_alignment-1))
+		if ((zone_start_pfn) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");
 
 		/*
@@ -815,8 +812,9 @@
 			__SetPageReserved(page);
 			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)
-				set_page_address(page, __va(zone_start_paddr));
-			zone_start_paddr += PAGE_SIZE;
+			/* WARNING - this looks dangerous, could overflow */
+				set_page_address(page, __va(zone_start_pfn << PAGE_SHIFT));
+			zone_start_pfn++;
 		}
 
 		offset += size;

