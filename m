Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUIWXH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUIWXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUIWXHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:07:03 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:56544 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S267362AbUIWXBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:01:17 -0400
Date: Thu, 23 Sep 2004 16:00:56 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch/RFC]Removing zone and node ID from page->flags[1/3]
Cc: Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
References: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
Message-Id: <20040923155916.D8CE.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patche is to remove zone and node id from page->flags.

Note:
  In this patch, zone is obtained from zone_table array whose
  index is offset of page struct's virtual address from PAGE_OFFSET.

  A entry must not include 2 zones by its alignment.
  To avoid it, one entry of array cannot treat larger area than 
  1 << (MAX_ORDER - 1). So, array size must be large.

  (If alighment of zone is smaller than 1 << (MAX_ORDER - 1),
   kernel will warn at free_area_init_core().)
  
  Next two patches are to reduce size of it.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>

---

 erase_zoneid-goto/include/asm-ia64/pgtable.h |    3 ++
 erase_zoneid-goto/include/linux/mm.h         |   32 +++++++++++----------------
 erase_zoneid-goto/include/linux/mmzone.h     |   11 ---------
 erase_zoneid-goto/mm/page_alloc.c            |   19 +++++++++++++---
 4 files changed, 33 insertions(+), 32 deletions(-)

diff -puN include/asm-ia64/pgtable.h~erase_zoneid include/asm-ia64/pgtable.h
--- erase_zoneid/include/asm-ia64/pgtable.h~erase_zoneid	Thu Sep 23 11:20:08 2004
+++ erase_zoneid-goto/include/asm-ia64/pgtable.h	Thu Sep 23 11:20:08 2004
@@ -219,6 +219,9 @@ ia64_phys_addr_valid (unsigned long addr
 #define	kc_vaddr_to_offset(v) ((v) - 0xa000000000000000)
 #define	kc_offset_to_vaddr(o) ((o) + 0xa000000000000000)
 
+#define PAGE_INDEX_OFFSET 0xa000000000000000 /* IA64's mem_maps are mapped
+						in region 5 */
+
 /*
  * Conversion functions: convert page frame number (pfn) and a protection value to a page
  * table entry (pte).
diff -puN include/linux/mm.h~erase_zoneid include/linux/mm.h
--- erase_zoneid/include/linux/mm.h~erase_zoneid	Thu Sep 23 11:20:08 2004
+++ erase_zoneid-goto/include/linux/mm.h	Thu Sep 23 11:20:08 2004
@@ -374,22 +374,18 @@ static inline void put_page(struct page 
  *   to swap space and (later) to be read back into memory.
  */
 
-/*
- * The zone field is never updated after free_area_init_core()
- * sets it, so none of the operations on it need to be atomic.
- * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
- * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
- */
-#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
-#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
+#define PAGEZONE_SHIFT (MAX_ORDER - 1) /* XXX */
+#define PAGEZONE_SIZE (1 << PAGEZONE_SHIFT)
+#define PAGEZONE_MASK (PAGEZONE_SIZE - 1)
 
-static inline unsigned long page_zonenum(struct page *page)
-{
-	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
-}
-static inline unsigned long page_to_nid(struct page *page)
+#ifndef PAGE_INDEX_OFFSET
+#define PAGE_INDEX_OFFSET PAGE_OFFSET
+#endif
+
+static inline unsigned long page_to_index(struct page *page)
 {
-	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
+	unsigned long out = (unsigned long)(page - (struct page *)PAGE_INDEX_OFFSET);
+	return out >> PAGEZONE_SHIFT;
 }
 
 struct zone;
@@ -397,14 +393,14 @@ extern struct zone *zone_table[];
 
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[page->flags >> NODEZONE_SHIFT];
+	return zone_table[ page_to_index(page)];
 }
 
-static inline void set_page_zone(struct page *page, unsigned long nodezone_num)
+static inline unsigned long page_to_nid(struct page *page)
 {
-	page->flags &= ~(~0UL << NODEZONE_SHIFT);
-	page->flags |= nodezone_num << NODEZONE_SHIFT;
+	return page_zone(page)->zone_pgdat->node_id;
 }
+
 
 #ifndef CONFIG_DISCONTIGMEM
 /* The array of struct pages - for discontigmem use pgdat->lmem_map */
diff -puN include/linux/mmzone.h~erase_zoneid include/linux/mmzone.h
--- erase_zoneid/include/linux/mmzone.h~erase_zoneid	Thu Sep 23 11:20:08 2004
+++ erase_zoneid-goto/include/linux/mmzone.h	Thu Sep 23 11:20:08 2004
@@ -399,17 +399,6 @@ extern struct pglist_data contig_page_da
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
-#if NODES_SHIFT > MAX_NODES_SHIFT
-#error NODES_SHIFT > MAX_NODES_SHIFT
-#endif
-
-/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
-#define MAX_ZONES_SHIFT		2
-
-#if ZONES_SHIFT > MAX_ZONES_SHIFT
-#error ZONES_SHIFT > MAX_ZONES_SHIFT
-#endif
-
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
diff -puN mm/page_alloc.c~erase_zoneid mm/page_alloc.c
--- erase_zoneid/mm/page_alloc.c~erase_zoneid	Thu Sep 23 11:20:08 2004
+++ erase_zoneid-goto/mm/page_alloc.c	Thu Sep 23 11:20:08 2004
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
+struct zone *zone_table[ (~PAGE_OFFSET + 1) >> (PAGEZONE_SHIFT + PAGE_SHIFT) ];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -1512,7 +1512,6 @@ void __init memmap_init_zone(unsigned lo
 	struct page *page;
 
 	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
@@ -1577,6 +1576,19 @@ void zone_init_free_lists(struct pglist_
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
+void set_page_zone(struct page *lmem_map, unsigned int size,  struct zone *zone)
+{
+	struct zone **entry;
+	entry = &zone_table[page_to_index(lmem_map)];
+
+	size = size + PAGEZONE_MASK; /* round up */
+	size >>= PAGEZONE_SHIFT;
+
+	for ( ; size > 0; entry++, size--)
+		*entry = zone;
+
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1599,7 +1611,6 @@ static void __init free_area_init_core(s
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -1681,6 +1692,8 @@ static void __init free_area_init_core(s
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");
+
+		set_page_zone(zone->zone_mem_map, size, zone);
 
 		memmap_init(size, nid, j, zone_start_pfn);
 
_


