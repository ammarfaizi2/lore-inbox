Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTLVT4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTLVT4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:56:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51958 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264415AbTLVT41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:56:27 -0500
Message-ID: <3FE74B43.7010407@us.ibm.com>
Date: Mon, 22 Dec 2003 11:51:31 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com, Andrew Morton <akpm@digeo.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH] Simplify node/zone field in page->flags
Content-Type: multipart/mixed;
 boundary="------------040602060202080701080103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040602060202080701080103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently we keep track of a pages node & zone in the top 8 bits (on 
32-bit arches, 10 bits on 64-bit arches) of page->flags.  We typically 
compute the field as follows:
	node_num * MAX_NR_ZONES + zone_num = 'nodezone'

It's non-trivial to break this 'nodezone' back into node and zone 
numbers.  This patch modifies the way we compute the index to be:
	(node_num << ZONE_SHIFT) | zone_num

This makes it trivial to recover either the node or zone number with a 
simple bitshift.  There are many places in the kernel where we do things 
like: page_zone(page)->zone_pgdat->node_id to determine the node a page 
belongs to.  With this patch we save several pointer dereferences, and 
it all boils down to shifting some bits.

Cheers!

-Matt

--------------040602060202080701080103
Content-Type: text/plain;
 name="nodezone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nodezone.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/include/linux/mm.h linux-2.6.0-patched/include/linux/mm.h
--- linux-2.6.0-vanilla/include/linux/mm.h	Wed Dec 17 18:58:05 2003
+++ linux-2.6.0-patched/include/linux/mm.h	Thu Dec 18 14:27:26 2003
@@ -323,20 +323,31 @@ static inline void put_page(struct page 
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
  */
-#define ZONE_SHIFT (BITS_PER_LONG - 8)
+#define NODEZONE_SHIFT (BITS_PER_LONG - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
+#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
+
+static inline unsigned long page_zonenum(struct page *page)
+{
+	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
+}
+
+static inline unsigned long page_nodenum(struct page *page)
+{
+	return (page->flags >> NODEZONE_SHIFT + ZONES_SHIFT);
+}
 
 struct zone;
 extern struct zone *zone_table[];
 
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[page->flags >> ZONE_SHIFT];
+	return zone_table[page->flags >> NODEZONE_SHIFT];
 }
 
-static inline void set_page_zone(struct page *page, unsigned long zone_num)
+static inline void set_page_zone(struct page *page, unsigned long nodezone_num)
 {
-	page->flags &= ~(~0UL << ZONE_SHIFT);
-	page->flags |= zone_num << ZONE_SHIFT;
+	page->flags &= ~(~0UL << NODEZONE_SHIFT);
+	page->flags |= nodezone_num << NODEZONE_SHIFT;
 }
 
 #ifndef CONFIG_DISCONTIGMEM
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/include/linux/mmzone.h linux-2.6.0-patched/include/linux/mmzone.h
--- linux-2.6.0-vanilla/include/linux/mmzone.h	Wed Dec 17 18:58:57 2003
+++ linux-2.6.0-patched/include/linux/mmzone.h	Thu Dec 18 14:27:26 2003
@@ -159,8 +159,10 @@ struct zone {
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1
 #define ZONE_HIGHMEM		2
-#define MAX_NR_ZONES		3
-#define GFP_ZONEMASK	0x03
+
+#define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
+#define ZONES_SHIFT		2	/* = ceil(log2(MAX_NR_ZONES)) */
+#define GFP_ZONEMASK		0x03
 
 /*
  * One allocation request operates on a zonelist. A zonelist
@@ -310,7 +312,7 @@ extern struct pglist_data contig_page_da
 
 #if BITS_PER_LONG == 32
 /*
- * with 32 bit flags field, page->zone is currently 8 bits.
+ * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
  * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
  */
 #define MAX_NODES_SHIFT		6
@@ -327,6 +329,13 @@ extern struct pglist_data contig_page_da
 #error NODES_SHIFT > MAX_NODES_SHIFT
 #endif
 
+/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
+#define MAX_ZONES_SHIFT		2
+
+#if ZONES_SHIFT > MAX_ZONES_SHIFT
+#error ZONES_SHIFT > MAX_ZONES_SHIFT
+#endif
+
 extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/mm/page_alloc.c linux-2.6.0-patched/mm/page_alloc.c
--- linux-2.6.0-vanilla/mm/page_alloc.c	Wed Dec 17 18:58:08 2003
+++ linux-2.6.0-patched/mm/page_alloc.c	Thu Dec 18 14:27:26 2003
@@ -50,7 +50,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[MAX_NR_ZONES*MAX_NUMNODES];
+struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -1210,7 +1210,7 @@ void __init memmap_init_zone(struct page
 	struct page *page;
 
 	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, nid * MAX_NR_ZONES + zone);
+		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->list);
@@ -1251,7 +1251,7 @@ static void __init free_area_init_core(s
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[nid * MAX_NR_ZONES + j] = zone;
+		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];

--------------040602060202080701080103--

