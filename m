Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUIOD3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUIOD3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUIOD3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:29:51 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:52886 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S266914AbUIOD3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:29:42 -0400
Date: Tue, 14 Sep 2004 20:29:19 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: [RFC/PATCH]Remove zone_id and node_id from page->flags.
Cc: Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>
Message-Id: <20040914200944.F8E4.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I wrote a patch to remove node_id and zone_id from page->flags.
Because, I guess many people would like to use page->flags, 
but its remaining bits are not so many.

Please comment.


Note:
  - In my personal motivation, I would like to create new zone 
    as a removable for memory hotplug. Some person recommended me
    that I should create 6 zone as
     [Removable/Un-removable] x [DMA/Normal/Highmem], because 
    removable attribute is orthogonal from DMA/Normal/Highmem.
    But if I create 6 zone, zone_id must be 3 bits in page->flags and
    node_id's bits must be reduced. I would like to avoid it.

  - zone_table's indexes are decided by offset of page_struct from
    PAGE_OFFSET.
    
  - I think zone_table is too big in this patch.
    To avoid cache miss hit, I'll make zone_table like below.
    
     zone_table_directory.
     +------------+             zone_table
     |            |------------>+-----------+
     |------------|             |           |-> zone
     |            |             |-----------|
     |------------|             |           |-> zone
     |            |             +-----------+
     +------------+
     
  - This patch is not stable yet. System might be hung up.
    I guess alignment of zone_table is something wrong, but 
    I'm not sure. Sorry....

Bye.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>



---

 erase_zoneid-goto/include/asm-ia64/pgtable.h |    3 ++
 erase_zoneid-goto/include/linux/mm.h         |   32 ++++++++++++++++-----------
 erase_zoneid-goto/include/linux/mmzone.h     |   11 ---------
 erase_zoneid-goto/mm/page_alloc.c            |   20 ++++++++++++++--
 4 files changed, 40 insertions(+), 26 deletions(-)

diff -puN include/linux/mm.h~erase_zoneid include/linux/mm.h
--- erase_zoneid/include/linux/mm.h~erase_zoneid	Tue Sep 14 17:40:05 2004
+++ erase_zoneid-goto/include/linux/mm.h	Tue Sep 14 18:58:57 2004
@@ -380,31 +380,39 @@ static inline void put_page(struct page 
  * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
  * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
  */
-#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
-#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
 
-static inline unsigned long page_zonenum(struct page *page)
-{
-	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
-}
-static inline unsigned long page_to_nid(struct page *page)
+#define PAGEZONE_SHIFT (MAX_ORDER - 1) /* XXX */
+
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
 extern struct zone *zone_table[];
 
+/*
+ * XXX: page_to_index should return index from lowest address of mem_map.
+ *      But if memory hot-add happens, new mem_map might become new
+ *      lowest one. (I'm not sure). At least, mem_map address is higher
+ *      than PAGE_OFFSET except some arch.
+ */
+
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
--- erase_zoneid/include/linux/mmzone.h~erase_zoneid	Tue Sep 14 17:40:05 2004
+++ erase_zoneid-goto/include/linux/mmzone.h	Tue Sep 14 18:49:05 2004
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
--- erase_zoneid/mm/page_alloc.c~erase_zoneid	Tue Sep 14 17:40:05 2004
+++ erase_zoneid-goto/mm/page_alloc.c	Tue Sep 14 18:46:03 2004
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
@@ -1577,6 +1576,20 @@ void zone_init_free_lists(struct pglist_
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
+void set_page_zone(struct page *lmem_map, unsigned int size, int nid,
+		   struct zone *zone)
+{
+	unsigned int index, count;
+
+	index = page_to_index(lmem_map);
+
+	size += (1 << PAGEZONE_SHIFT) - 1; /* round up */
+	size >>= PAGEZONE_SHIFT;
+
+	for( count = 0; count < size ; count++, index++)
+		zone_table[index] = zone;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1599,7 +1612,6 @@ static void __init free_area_init_core(s
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -1681,6 +1693,8 @@ static void __init free_area_init_core(s
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");
+
+		set_page_zone(zone->zone_mem_map, size, nid, zone);
 
 		memmap_init(size, nid, j, zone_start_pfn);
 
diff -puN include/asm-ia64/pgtable.h~erase_zoneid include/asm-ia64/pgtable.h
--- erase_zoneid/include/asm-ia64/pgtable.h~erase_zoneid	Tue Sep 14 18:03:03 2004
+++ erase_zoneid-goto/include/asm-ia64/pgtable.h	Tue Sep 14 18:10:21 2004
@@ -219,6 +219,9 @@ ia64_phys_addr_valid (unsigned long addr
 #define	kc_vaddr_to_offset(v) ((v) - 0xa000000000000000)
 #define	kc_offset_to_vaddr(o) ((o) + 0xa000000000000000)
 
+#define PAGE_INDEX_OFFSET 0xa000000000000000 /* IA64's mem_maps are mapped
+						in region 5 */
+
 /*
  * Conversion functions: convert page frame number (pfn) and a protection value to a page
  * table entry (pte).
_



