Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUAEWmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUAEWlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:41:05 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:39823 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265849AbUAEWjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:39:17 -0500
Message-ID: <3FF9E64D.5080107@us.ibm.com>
Date: Mon, 05 Jan 2004 14:33:49 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: [PATCH] Simplify node/zone field in page->flags
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com> <20040105213736.GA19859@sgi.com>
Content-Type: multipart/mixed;
 boundary="------------090503010503060607030209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503010503060607030209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jesse Barnes wrote:
> On Mon, Jan 05, 2004 at 01:22:57PM -0800, Matthew Dobson wrote:
> 
>>Jesse had acked the patch in an earlier itteration.  The only thing 
>>that's changed is some line offsets whilst porting the patch forward.
>>
>>Jesse (or anyone else?), any objections to this patch as a superset of 
>>yours?
> 
> 
> No objections here.  Of course, you'll have to rediff against the
> current tree since that stuff has been merged for awhile now.  On a
> somewhat related note, Martin mentioned that he'd like to get rid of
> memblks.  I'm all for that too; they just seem to get in the way.
> 
> Jesse
> 

Yeah... didn't actually attatch the patch to that last email, did I? 
Brain slowly transitioning back into "on" mode after a couple weeks 
solidly in the "off" position.

-Matt

--------------090503010503060607030209
Content-Type: text/plain;
 name="nodezone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nodezone.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.1-rc1/include/linux/mm.h linux-2.6.1-rc1+nodezone/include/linux/mm.h
--- linux-2.6.1-rc1/include/linux/mm.h	Mon Jan  5 12:36:24 2004
+++ linux-2.6.1-rc1+nodezone/include/linux/mm.h	Mon Jan  5 14:26:28 2004
@@ -322,23 +322,33 @@ static inline void put_page(struct page 
 /*
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
- * We'll have up to log2(MAX_NUMNODES * MAX_NR_ZONES) zones
- * total, so we use NODES_SHIFT here to get enough bits.
+ * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total, 
+ * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
  */
-#define ZONE_SHIFT (BITS_PER_LONG - NODES_SHIFT - MAX_NR_ZONES_SHIFT)
+#define NODEZONE_SHIFT (BITS_PER_LONG - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
+#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
+
+static inline unsigned long page_zonenum(struct page *page)
+{
+	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
+}
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.1-rc1/include/linux/mmzone.h linux-2.6.1-rc1+nodezone/include/linux/mmzone.h
--- linux-2.6.1-rc1/include/linux/mmzone.h	Mon Jan  5 12:36:24 2004
+++ linux-2.6.1-rc1+nodezone/include/linux/mmzone.h	Mon Jan  5 14:04:46 2004
@@ -160,8 +160,8 @@ struct zone {
 #define ZONE_NORMAL		1
 #define ZONE_HIGHMEM		2
 
-#define MAX_NR_ZONES		3	/* Sync this with MAX_NR_ZONES_SHIFT */
-#define MAX_NR_ZONES_SHIFT	2	/* ceil(log2(MAX_NR_ZONES)) */
+#define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
+#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
 #define GFP_ZONEMASK	0x03
 
@@ -311,7 +311,7 @@ extern struct pglist_data contig_page_da
 
 #if BITS_PER_LONG == 32
 /*
- * with 32 bit flags field, page->zone is currently 8 bits.
+ * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
  * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
  */
 #define MAX_NODES_SHIFT		6
@@ -328,6 +328,13 @@ extern struct pglist_data contig_page_da
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
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.1-rc1/mm/page_alloc.c linux-2.6.1-rc1+nodezone/mm/page_alloc.c
--- linux-2.6.1-rc1/mm/page_alloc.c	Mon Jan  5 12:36:24 2004
+++ linux-2.6.1-rc1+nodezone/mm/page_alloc.c	Mon Jan  5 14:04:46 2004
@@ -50,7 +50,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[MAX_NR_ZONES*MAX_NUMNODES];
+struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -1212,7 +1212,7 @@ void __init memmap_init_zone(struct page
 	struct page *page;
 
 	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, nid * MAX_NR_ZONES + zone);
+		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->list);
@@ -1253,7 +1253,7 @@ static void __init free_area_init_core(s
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[nid * MAX_NR_ZONES + j] = zone;
+		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];

--------------090503010503060607030209--

