Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUIEFrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUIEFrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 01:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIEFrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 01:47:22 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:1880 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266188AbUIEFq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 01:46:57 -0400
Message-ID: <413AA841.1040003@yahoo.com.au>
Date: Sun, 05 Sep 2004 15:46:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 2/3] alloc-order watermarks
References: <413AA7B2.4000907@yahoo.com.au> <413AA7F8.3050706@yahoo.com.au>
In-Reply-To: <413AA7F8.3050706@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090607020702000101060607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090607020702000101060607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/3

--------------090607020702000101060607
Content-Type: text/x-patch;
 name="vm-alloc-order-watermarks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-alloc-order-watermarks.patch"



Move the watermark checking code into a single function. Extend it to account
for the order of the allocation and the number of free pages that could satisfy
such a request.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/include/linux/mmzone.h |    2 +
 linux-2.6-npiggin/mm/page_alloc.c        |   57 ++++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff -puN mm/page_alloc.c~vm-alloc-order-watermarks mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-alloc-order-watermarks	2004-09-05 14:55:46.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-09-05 15:10:07.000000000 +1000
@@ -676,6 +676,36 @@ buffered_rmqueue(struct zone *zone, int 
 }
 
 /*
+ * Return the number of pages available for order 'order' allocations.
+ */
+int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
+		int alloc_type, int can_try_harder, int gfp_high)
+{
+	unsigned long min = mark, free_pages = z->free_pages;
+	int o;
+
+	if (gfp_high)
+		min -= min / 2;
+	if (can_try_harder)
+		min -= min / 4;
+	min += z->protection[alloc_type];
+
+	if (free_pages < min)
+		return 0;
+	for (o = 0; o < order; o++) {
+		/* At the next order, this order's pages become unavailable */
+		free_pages -= z->free_area[order].nr_free << o;
+
+		/* Require fewer higher order pages to be free */
+		min >>= 1;
+
+		if (free_pages < min + (1 << order) - 1)
+			return 0;
+	}
+	return 1;
+}
+
+/*
  * This is the 'heart' of the zoned buddy allocator.
  *
  * Herein lies the mysterious "incremental min".  That's the
@@ -696,7 +726,6 @@ __alloc_pages(unsigned int gfp_mask, uns
 		struct zonelist *zonelist)
 {
 	const int wait = gfp_mask & __GFP_WAIT;
-	unsigned long min;
 	struct zone **zones, *z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
@@ -732,9 +761,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 
 	/* Go through the zonelist once, looking for a zone with enough free */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_low + (1<<order) + z->protection[alloc_type];
 
-		if (z->free_pages < min)
+		if (!zone_watermark_ok(z, order, z->pages_low,
+				alloc_type, 0, 0))
 			continue;
 
 		if (!cpuset_zone_allowed(z))
@@ -753,14 +782,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	 * coming from realtime tasks to go deeper into reserves
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_min;
-		if (gfp_mask & __GFP_HIGH)
-			min /= 2;
-		if (can_try_harder)
-			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
-
-		if (z->free_pages < min)
+		if (!zone_watermark_ok(z, order, z->pages_min,
+				alloc_type, can_try_harder,
+				gfp_mask & __GFP_HIGH))
 			continue;
 
 		if (!cpuset_zone_allowed(z))
@@ -801,14 +825,9 @@ rebalance:
 
 	/* go through the zonelist yet one more time */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_min;
-		if (gfp_mask & __GFP_HIGH)
-			min /= 2;
-		if (can_try_harder)
-			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
-
-		if (z->free_pages < min)
+		if (!zone_watermark_ok(z, order, z->pages_min,
+				alloc_type, can_try_harder,
+				gfp_mask & __GFP_HIGH))
 			continue;
 
 		if (!cpuset_zone_allowed(z))
diff -puN include/linux/mmzone.h~vm-alloc-order-watermarks include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~vm-alloc-order-watermarks	2004-09-05 14:55:46.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-09-05 15:10:07.000000000 +1000
@@ -279,6 +279,8 @@ void get_zone_counts(unsigned long *acti
 			unsigned long *free);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone);
+int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
+		int alloc_type, int can_try_harder, int gfp_high);
 
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.

_

--------------090607020702000101060607--
