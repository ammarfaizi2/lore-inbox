Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVIZUFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVIZUFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVIZUFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:05:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57279 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932120AbVIZUFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:05:10 -0400
Message-ID: <43385473.6090101@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:05:07 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 2/9] declare defrag structs
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000604000606020804070900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000604000606020804070900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch declares most of the structures needed by fragmentation avoidance
and associated macros.

There are two things of note in this patch.
1. free_area_usemap is in the zone information by default and in the mem_section
for CONFIG_SPARSEMEM.  This is done to be more efficient for both memory
hotplug add and memory hotplug remove, which add and remove sections. With the
macros this placement should be transparent.

2. free_area_usemap requires > 32 bits and < 64 bits for all
known architectures and possible configurations, a compile time check has been
added to make sure future architectures still have this property.

Originally authored by Mel Gorman and heavily modified by me.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------000604000606020804070900
Content-Type: text/plain;
 name="2_declare_defrag_structs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2_declare_defrag_structs"

Index: 2.6.13-joel2/include/linux/mmzone.h
===================================================================
--- 2.6.13-joel2.orig/include/linux/mmzone.h	2005-09-13 14:54:17.%N -0500
+++ 2.6.13-joel2/include/linux/mmzone.h	2005-09-19 16:26:18.%N -0500
@@ -21,6 +21,21 @@
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
 
+/*
+ * The two bit field __GFP_RECLAIMBITS enumerates the following 4 kinds of 
+ * page reclaimability.
+ */
+#define RCLM_TYPES 4
+#define RCLM_NORCLM 0
+#define RCLM_USER 1
+#define RCLM_KERN 2
+#define RCLM_FALLBACK 3
+
+#define RCLM_SHIFT 18
+#define BITS_PER_RCLM_TYPE 2
+
+#define BITS_PER_ALLOC_TYPE 2
+
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		nr_free;
@@ -137,7 +152,45 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
+	/*
+	 *  free_area to be removed in later patch  as it is replaced by
+	 *  free_area_list
+	 */
 	struct free_area	free_area[MAX_ORDER];
+#ifndef CONFIG_SPARSEMEM
+	/*
+	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for.
+	 * Each 2^MAX_ORDER block have pages has BITS_PER_ALLOC_TYPE bits in
+	 * this map to remember what the block is for. When a page is freed,
+	 * it's index within this bitmap is calculated in get_pageblock_type()
+	 * This means that pages will always be freed into the correct list in
+	 * free_area_lists
+	 *
+	 * The bits are set when a 2^MAX_ORDER block of pages is split
+ 	 */
+ 	unsigned long		*free_area_usemap;
+#endif
+
+	/*
+	 * free_area_lists contains buddies of split MAX_ORDER blocks indexed
+	 * by their intended allocation type, while free_area_global contains
+	 * whole MAX_ORDER blocks that can be used for any allocation type.
+	 */
+	struct free_area	free_area_lists[RCLM_TYPES][MAX_ORDER];
+
+	/*
+	 * A percentage of a zone is reserved for falling back to. Without
+	 * a fallback, memory will slowly fragment over time meaning the
+	 * placement policy only delays the fragmentation problem, not
+	 * fixes it
+	 */
+	unsigned long fallback_reserve;
+
+	/*
+	 * When negative, 2^MAX_ORDER-1 sized blocks of pages will be reserved
+	 * for fallbacks
+	 */
+	long fallback_balance;
 
 
 	ZONE_PADDING(_pad1_)
@@ -230,6 +283,17 @@ struct zone {
 } ____cacheline_maxaligned_in_smp;
 
 
+static inline void inc_reserve_count(struct zone* zone, int type)
+{
+	if(type == RCLM_FALLBACK)
+		zone->fallback_reserve++;
+}
+static inline void dec_reserve_count(struct zone* zone, int type)
+{
+	if(type == RCLM_FALLBACK && zone->fallback_reserve)
+		zone->fallback_reserve--;
+}
+
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
  * go. A value of 12 for DEF_PRIORITY implies that we will scan 1/4096th of the
@@ -473,6 +537,9 @@ extern struct pglist_data contig_page_da
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#if ((SECTION_SIZE_BITS - MAX_ORDER) * BITS_PER_ALLOC) > 64
+#error free_area_usemap is not big enough
+#endif
 
 struct page;
 struct mem_section {
@@ -485,6 +552,7 @@ struct mem_section {
 	 * before using it wrong.
 	 */
 	unsigned long section_mem_map;
+	DECLARE_BITMAP(free_area_usemap,64);
 };
 
 extern struct mem_section mem_section[NR_MEM_SECTIONS];
@@ -536,6 +604,17 @@ static inline struct mem_section *__pfn_
 	return __nr_to_section(pfn_to_section_nr(pfn));
 }
 
+static inline unsigned long *pfn_to_usemap(struct zone *zone, unsigned long pfn)
+{
+	return &__pfn_to_section(pfn)->free_area_usemap[0];
+}
+
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+	pfn &= (PAGES_PER_SECTION-1);
+	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
+}
+
 #define pfn_to_page(pfn) 						\
 ({ 									\
 	unsigned long __pfn = (pfn);					\
@@ -572,6 +651,15 @@ static inline int pfn_valid(unsigned lon
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
+static inline unsigned long *pfn_to_usemap(struct zone *zone, unsigned long pfn)
+{
+	return (zone->free_area_usemap);
+}
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+	pfn = pfn - zone->zone_start_pfn;
+	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
+}
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES

--------------000604000606020804070900--
