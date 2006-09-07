Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWIGO1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWIGO1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWIGO1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:27:48 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:7111 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1751705AbWIGO1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:27:46 -0400
Date: Thu, 7 Sep 2006 15:27:44 +0100
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: [PATCH] Fix memmap accounting by approximating the map size
Message-ID: <20060907142744.GA31799@skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com> <Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie> <20060831100156.24fc0521.pj@sgi.com> <Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie> <20060901202430.0681f5c5.pj@sgi.com> <20060904094503.GA4475@skynet.ie> <20060906151008.e84ffdd1.pj@sgi.com> <Pine.LNX.4.64.0609071502001.31287@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609071502001.31287@skynet.skynet.ie>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arch-independent zone-sizing uses account_memmap() in an attempt to accurately
account for how much memory was used in a zone by memmap.  Watermarks and
per-cpu sizes initialisations then take the memmap into account. However,
the memmap may span multiple zones and in one case, there was an underflow
causing boot failures.

The fix that perfectly accounts for memory consumed by memmap is complicated
with no clear benefit. The architecture-specific code in x86_64 was simpler
because it approximated how much memory was consumed for memmap backing that
zone regardless of where the memmap was really stored.

This patch ditches the account_memmap() complexity and replaces with the
simple approximation used by x86_64 while ensuring no underflow occurs.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c linux-2.6.18-rc4-mm3-101_fix_account_memmap/mm/page_alloc.c
--- linux-2.6.18-rc4-mm3-clean/mm/page_alloc.c	2006-08-28 15:05:30.000000000 +0100
+++ linux-2.6.18-rc4-mm3-101_fix_account_memmap/mm/page_alloc.c	2006-09-07 14:36:05.000000000 +0100
@@ -2364,58 +2364,6 @@ static void __init calculate_node_totalp
 							realtotalpages);
 }
 
-#ifdef CONFIG_FLAT_NODE_MEM_MAP
-/* Account for mem_map for CONFIG_FLAT_NODE_MEM_MAP */
-unsigned long __meminit account_memmap(struct pglist_data *pgdat,
-						int zone_index)
-{
-	unsigned long pages = 0;
-	if (zone_index == memmap_zone_idx(pgdat->node_mem_map)) {
-		pages = pgdat->node_spanned_pages;
-		pages = (pages * sizeof(struct page)) >> PAGE_SHIFT;
-		printk(KERN_DEBUG "%lu pages used for memmap\n", pages);
-	}
-	return pages;
-}
-#else
-/* Account for mem_map for CONFIG_SPARSEMEM */
-unsigned long account_memmap(struct pglist_data *pgdat, int zone_index)
-{
-	unsigned long pages = 0;
-	unsigned long memmap_pfn;
-	struct page *memmap_addr;
-	int pnum;
-	unsigned long pgdat_startpfn, pgdat_endpfn;
-	struct mem_section *section;
-
-	pgdat_startpfn = pgdat->node_start_pfn;
-	pgdat_endpfn = pgdat_startpfn + pgdat->node_spanned_pages;
-
-	/* Go through valid sections looking for memmap */
-	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
-		if (!valid_section_nr(pnum))
-			continue;
-
-		section = __nr_to_section(pnum);
-		if (!section_has_mem_map(section))
-			continue;
-
-		memmap_addr = __section_mem_map_addr(section);
-		memmap_pfn = (unsigned long)memmap_addr >> PAGE_SHIFT;
-
-		if (memmap_pfn < pgdat_startpfn || memmap_pfn >= pgdat_endpfn)
-			continue;
-
-		if (zone_index == memmap_zone_idx(memmap_addr))
-			pages += (PAGES_PER_SECTION * sizeof(struct page));
-	}
-
-	pages >>= PAGE_SHIFT;
-	printk(KERN_DEBUG "%lu pages used for SPARSE memmap\n", pages);
-	return pages;
-}
-#endif
-
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -2437,17 +2385,32 @@ static void __meminit free_area_init_cor
 	
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, realsize;
+		unsigned long size, realsize, memmap_pages;
 
 		size = zone_spanned_pages_in_node(nid, j, zones_size);
 		realsize = size - zone_absent_pages_in_node(nid, j,
 								zholes_size);
 
-		realsize -= account_memmap(pgdat, j);
+		/*
+		 * Adjust realsize so that it accounts for how much memory
+		 * is used by this zone for memmap. This affects the watermark
+		 * and per-cpu initialisations
+		 */
+		memmap_pages = (size * sizeof(struct page)) >> PAGE_SHIFT;
+		if (realsize >= memmap_pages) {
+			realsize -= memmap_pages;
+			printk(KERN_DEBUG
+				"  %s zone: %lu pages used for memmap\n",
+				zone_names[j], memmap_pages);
+		} else
+			printk(KERN_WARNING
+				"  %s zone: %lu pages exceeds realsize %lu\n",
+				zone_names[j], memmap_pages, realsize);
+
 		/* Account for reserved DMA pages */
 		if (j == ZONE_DMA && realsize > dma_reserve) {
 			realsize -= dma_reserve;
-			printk(KERN_DEBUG "%lu pages DMA reserved\n",
+			printk(KERN_DEBUG "  DMA zone: %lu pages reserved\n",
 								dma_reserve);
 		}
 
