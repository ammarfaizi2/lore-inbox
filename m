Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946791AbWKALT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946791AbWKALT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946793AbWKALTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:19:25 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:40587 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946791AbWKALTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:19:22 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111920.18798.78007.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 9/11] Add a bitmap that is used to track flags affecting a block of pages
Date: Wed,  1 Nov 2006 11:19:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anti-fragmentation uses two bits per page to track what the page's
reclaimability is. However, what is of real interest is what the whole
block of pages is being used for.  This patch adds a bitmap that is used
for flags affecting a whole a MAX_ORDER block of pages. Later patches drop
the requirement to use page->flags and this bitmap is used instead.

In non-SPARSEMEM configurations, the bitmap is stored in the struct zone
and allocated during initialisation. SPARSEMEM statically allocates the
bitmap in a struct mem_section so that bitmaps do not have to be resized
during memory hotadd. This wastes a small amount of memory per unused section
(usually sizeof(unsigned long)) but the complexity of dynamically allocating
the memory is quite high.

This mechanism is a proof of concept, so it uses obviously correct over optimal
implementation.

Additional credit to Andy Whitcroft who reviewed up an earlier implementation
of the mechanism an suggested how to make it a *lot* cleaner.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 include/linux/mmzone.h          |   13 ++++
 include/linux/pageblock-flags.h |   48 +++++++++++++++
 mm/page_alloc.c                 |  112 +++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-009_stats/include/linux/mmzone.h linux-2.6.19-rc4-mm1-101_pageblock_bits/include/linux/mmzone.h
--- linux-2.6.19-rc4-mm1-009_stats/include/linux/mmzone.h	2006-10-31 13:52:17.000000000 +0000
+++ linux-2.6.19-rc4-mm1-101_pageblock_bits/include/linux/mmzone.h	2006-10-31 17:42:25.000000000 +0000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/seqlock.h>
 #include <linux/nodemask.h>
+#include <linux/pageblock-flags.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
 
@@ -227,6 +228,14 @@ struct zone {
 #endif
 	struct free_area	free_area[MAX_ORDER];
 
+#ifndef CONFIG_SPARSEMEM
+	/*
+	 * Flags for a MAX_ORDER_NR_PAGES block. See pageblock-flags.h.
+	 * In SPARSEMEM, this map is stored in struct mem_section
+	 */
+	unsigned long           *pageblock_flags;
+#endif /* CONFIG_SPARSEMEM */
+
 
 	ZONE_PADDING(_pad1_)
 
@@ -682,6 +691,9 @@ extern struct zone *next_zone(struct zon
 #define PAGES_PER_SECTION       (1UL << PFN_SECTION_SHIFT)
 #define PAGE_SECTION_MASK	(~(PAGES_PER_SECTION-1))
 
+#define SECTION_BLOCKFLAGS_BITS \
+		((SECTION_SIZE_BITS - (MAX_ORDER-1)) * NR_PAGEBLOCK_BITS)
+
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
@@ -701,6 +713,7 @@ struct mem_section {
 	 * before using it wrong.
 	 */
 	unsigned long section_mem_map;
+	DECLARE_BITMAP(pageblock_flags, SECTION_BLOCKFLAGS_BITS);
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-009_stats/include/linux/pageblock-flags.h linux-2.6.19-rc4-mm1-101_pageblock_bits/include/linux/pageblock-flags.h
--- linux-2.6.19-rc4-mm1-009_stats/include/linux/pageblock-flags.h	2006-10-31 18:05:45.000000000 +0000
+++ linux-2.6.19-rc4-mm1-101_pageblock_bits/include/linux/pageblock-flags.h	2006-10-31 17:42:25.000000000 +0000
@@ -0,0 +1,48 @@
+/*
+ * Macros for manipulating and testing flags related to a
+ * MAX_ORDER_NR_PAGES block of pages.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Original author, Mel Gorman
+ * Major cleanups and reduction of bit operations, Andy Whitcroft
+ */
+#ifndef PAGEBLOCK_FLAGS_H
+#define PAGEBLOCK_FLAGS_H
+
+#include <linux/types.h>
+
+/* Bit indices that affect a whole block of pages */
+enum pageblock_bits {
+	NR_PAGEBLOCK_BITS
+};
+
+/* Forward declaration */
+struct page;
+
+/* Declarations for getting and setting flags. See mm/page_alloc.c */
+unsigned long get_pageblock_flags_group(struct page *page,
+					int start_bitidx, int end_bitidx);
+void set_pageblock_flags_group(struct page *page, unsigned long flags,
+					int start_bitidx, int end_bitidx);
+
+#define get_pageblock_flags(page) \
+			get_pageblock_flags_group(page, 0, NR_PAGEBLOCK_BITS-1)
+#define set_pageblock_flags(page) \
+			set_pageblock_flags_group(page, 0, NR_PAGEBLOCK_BITS-1)
+
+#endif	/* PAGEBLOCK_FLAGS_H */
+
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-009_stats/mm/page_alloc.c linux-2.6.19-rc4-mm1-101_pageblock_bits/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-009_stats/mm/page_alloc.c	2006-10-31 13:54:43.000000000 +0000
+++ linux-2.6.19-rc4-mm1-101_pageblock_bits/mm/page_alloc.c	2006-10-31 17:42:25.000000000 +0000
@@ -2823,6 +2823,38 @@ static void __init calculate_node_totalp
 							realtotalpages);
 }
 
+#ifndef CONFIG_SPARSEMEM
+/*
+ * Calculate the size of the zone->blockflags rounded to an unsigned long
+ * Start by making sure zonesize is a multiple of MAX_ORDER-1 by rounding up
+ * Then figure 1 NR_PAGEBLOCK_BITS worth of bits per MAX_ORDER-1, finally
+ * round what is now in bits to nearest long in bits, then return it in
+ * bytes.
+ */
+static unsigned long __init usemap_size(unsigned long zonesize)
+{
+	unsigned long usemapsize;
+
+	usemapsize = roundup(zonesize, MAX_ORDER_NR_PAGES);
+	usemapsize = usemapsize >> (MAX_ORDER-1);
+	usemapsize *= NR_PAGEBLOCK_BITS;
+	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
+
+	return usemapsize / 8;
+}
+
+static void __init setup_usemap(struct pglist_data *pgdat,
+				struct zone *zone, unsigned long zonesize)
+{
+	unsigned long usemapsize = usemap_size(zonesize);
+	zone->pageblock_flags = alloc_bootmem_node(pgdat, usemapsize);
+	memset(zone->pageblock_flags, 0, usemapsize);
+}
+#else
+static void inline setup_usemap(struct pglist_data *pgdat,
+				struct zone *zone, unsigned long zonesize) {}
+#endif /* CONFIG_SPARSEMEM */
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -2909,6 +2941,7 @@ static void __meminit free_area_init_cor
 		ret = init_currently_empty_zone(zone, zone_start_pfn, size);
 		BUG_ON(ret);
 		zone_start_pfn += size;
+		setup_usemap(pgdat, zone, size);
 	}
 }
 
@@ -3622,3 +3655,82 @@ int highest_possible_node_id(void)
 }
 EXPORT_SYMBOL(highest_possible_node_id);
 #endif
+
+/* Return a pointer to the bitmap storing bits affecting a block of pages */
+static inline unsigned long *get_pageblock_bitmap(struct zone *zone,
+							unsigned long pfn)
+{
+#ifdef CONFIG_SPARSEMEM
+	unsigned long blockpfn;
+	blockpfn = pfn & ~(MAX_ORDER_NR_PAGES - 1);
+	return __pfn_to_section(blockpfn)->pageblock_flags;
+#else
+	return zone->pageblock_flags;
+#endif /* CONFIG_SPARSEMEM */
+}
+
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+#ifdef CONFIG_SPARSEMEM
+	pfn &= (PAGES_PER_SECTION-1);
+	return (pfn >> (MAX_ORDER-1)) * NR_PAGEBLOCK_BITS;
+#else
+	pfn = pfn - zone->zone_start_pfn;
+	return (pfn >> (MAX_ORDER-1)) * NR_PAGEBLOCK_BITS;
+#endif /* CONFIG_SPARSEMEM */
+}
+
+/**
+ * get_pageblock_flags_group - Return the requested group of flags for the MAX_ORDER_NR_PAGES block of pages
+ * @page: The page within the block of interest
+ * @start_bitidx: The first bit of interest to retrieve
+ * @end_bitidx: The last bit of interest
+ * returns pageblock_bits flags
+ */
+unsigned long get_pageblock_flags_group(struct page *page,
+					int start_bitidx, int end_bitidx)
+{
+	struct zone *zone;
+	unsigned long *bitmap;
+	unsigned long pfn, bitidx;
+	unsigned long flags = 0;
+	unsigned long value = 1;
+
+	zone = page_zone(page);
+	pfn = page_to_pfn(page);
+	bitmap = get_pageblock_bitmap(zone, pfn);
+	bitidx = pfn_to_bitidx(zone, pfn);
+
+	for (; start_bitidx <= end_bitidx; start_bitidx++, value <<= 1)
+		if (test_bit(bitidx + start_bitidx, bitmap))
+			flags |= value;
+	
+	return flags;
+}
+
+/**
+ * set_pageblock_flags_group - Set the requested group of flags for a MAX_ORDER_NR_PAGES block of pages
+ * @page: The page within the block of interest
+ * @start_bitidx: The first bit of interest
+ * @end_bitidx: The last bit of interest
+ * @flags: The flags to set
+ */
+void set_pageblock_flags_group(struct page *page, unsigned long flags,
+					int start_bitidx, int end_bitidx)
+{
+	struct zone *zone;
+	unsigned long *bitmap;
+	unsigned long pfn, bitidx;
+	unsigned long value = 1;
+
+	zone = page_zone(page);
+	pfn = page_to_pfn(page);
+	bitmap = get_pageblock_bitmap(zone, pfn);
+	bitidx = pfn_to_bitidx(zone, pfn);
+
+	for (; start_bitidx <= end_bitidx; start_bitidx++, value <<= 1)
+		if (flags & value)
+			__set_bit(bitidx + start_bitidx, bitmap);
+		else
+			__clear_bit(bitidx + start_bitidx, bitmap);
+}
