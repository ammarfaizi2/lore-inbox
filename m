Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVCYUtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVCYUtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVCYUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:48:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61334 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261796AbVCYUoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:44:07 -0500
Subject: resubmit - [PATCH 3/4] sparsemem base: reorganize page->flags bit operations
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 12:44:03 -0800
Message-Id: <E1DEvf2-0004ay-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generify the value fields in the page_flags.  The aim is to allow
the location and size of these fields to be varied.  Additionally we
want to move away from fixed allocations per field whilst still
enforcing the overall bit utilisation limits.  We rely on the
compiler to spot and optimise the accessor functions.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/mm.h     |   53 +++++++++++++++++++++++++++------
 memhotplug-dave/include/linux/mmzone.h |   19 ++++-------
 memhotplug-dave/mm/page_alloc.c        |    2 -
 3 files changed, 52 insertions(+), 22 deletions(-)

diff -puN include/linux/mm.h~FROM-MM-cleanup-node-zone include/linux/mm.h
--- memhotplug/include/linux/mm.h~FROM-MM-cleanup-node-zone	2005-03-25 08:17:11.000000000 -0800
+++ memhotplug-dave/include/linux/mm.h	2005-03-25 08:17:11.000000000 -0800
@@ -404,19 +404,41 @@ static inline void put_page(struct page 
 /*
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
- * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
- * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
  */
-#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
+
+/* Page flags: | NODE | ZONE | ... | FLAGS | */
+#define NODES_PGOFF		((sizeof(page_flags_t)*8) - NODES_SHIFT)
+#define ZONES_PGOFF		(NODES_PGOFF - ZONES_SHIFT)
+
+/*
+ * Define the bit shifts to access each section.  For non-existant
+ * sections we define the shift as 0; that plus a 0 mask ensures
+ * the compiler will optimise away reference to them.
+ */
+#define NODES_PGSHIFT		(NODES_PGOFF * (NODES_SHIFT != 0))
+#define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_SHIFT != 0))
+
+/* NODE:ZONE is used to lookup the zone from a page. */
+#define ZONETABLE_SHIFT		(NODES_SHIFT + ZONES_SHIFT)
+#define ZONETABLE_PGSHIFT	ZONES_PGSHIFT
+
+#if NODES_SHIFT+ZONES_SHIFT > FLAGS_RESERVED
+#error NODES_SHIFT+ZONES_SHIFT > FLAGS_RESERVED
+#endif
+
 #define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
 
+#define ZONES_MASK		((1UL << ZONES_SHIFT) - 1)
+#define NODES_MASK		((1UL << NODES_SHIFT) - 1)
+#define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
+
 static inline unsigned long page_zonenum(struct page *page)
 {
-	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
+	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 static inline unsigned long page_to_nid(struct page *page)
 {
-	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
+	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
 }
 
 struct zone;
@@ -424,13 +446,26 @@ extern struct zone *zone_table[];
 
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[page->flags >> NODEZONE_SHIFT];
+	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
+			ZONETABLE_MASK];
+}
+
+static inline void set_page_zone(struct page *page, unsigned long zone)
+{
+	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
+	page->flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
+}
+static inline void set_page_node(struct page *page, unsigned long node)
+{
+	page->flags &= ~(NODES_MASK << NODES_PGSHIFT);
+	page->flags |= (node & NODES_MASK) << NODES_PGSHIFT;
 }
 
-static inline void set_page_zone(struct page *page, unsigned long nodezone_num)
+static inline void set_page_links(struct page *page, unsigned long zone,
+	unsigned long node)
 {
-	page->flags &= ~(~0UL << NODEZONE_SHIFT);
-	page->flags |= nodezone_num << NODEZONE_SHIFT;
+	set_page_zone(page, zone);
+	set_page_node(page, node);
 }
 
 #ifndef CONFIG_DISCONTIGMEM
diff -puN include/linux/mmzone.h~FROM-MM-cleanup-node-zone include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~FROM-MM-cleanup-node-zone	2005-03-25 08:17:11.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-03-25 08:17:11.000000000 -0800
@@ -395,30 +395,25 @@ extern struct pglist_data contig_page_da
 
 #include <asm/mmzone.h>
 
+#endif /* !CONFIG_DISCONTIGMEM */
+
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
  * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
  * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
  */
-#define MAX_NODES_SHIFT		6
+#define FLAGS_RESERVED		8
+
 #elif BITS_PER_LONG == 64
 /*
  * with 64 bit flags field, there's plenty of room.
  */
-#define MAX_NODES_SHIFT		10
-#endif
+#define FLAGS_RESERVED		32
 
-#endif /* !CONFIG_DISCONTIGMEM */
-
-#if NODES_SHIFT > MAX_NODES_SHIFT
-#error NODES_SHIFT > MAX_NODES_SHIFT
-#endif
+#else
 
-/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
-#define MAX_ZONES_SHIFT		2
+#error BITS_PER_LONG not defined
 
-#if ZONES_SHIFT > MAX_ZONES_SHIFT
-#error ZONES_SHIFT > MAX_ZONES_SHIFT
 #endif
 
 #endif /* !__ASSEMBLY__ */
diff -puN mm/page_alloc.c~FROM-MM-cleanup-node-zone mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~FROM-MM-cleanup-node-zone	2005-03-25 08:17:11.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-03-25 08:17:11.000000000 -0800
@@ -1583,7 +1583,7 @@ void __init memmap_init_zone(unsigned lo
 	struct page *page;
 
 	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, NODEZONE(nid, zone));
+		set_page_links(page, zone, nid);
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
_
