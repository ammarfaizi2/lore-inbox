Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUHaKj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUHaKj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUHaKj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:39:26 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7141 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267766AbUHaKiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:38:54 -0400
Date: Tue, 31 Aug 2004 19:44:02 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap(2) [2/3]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
Message-id: <41345672.4000702@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 3rd.
Implements alloc_pages() code.

-- Kame
-------------------------------------

This patch removes bitmap operation from alloc_pages().

Instead of using MARK_USED() bitmap operation,
this patch records page's order in page struct itself, page->private field.

During locking zone->lock, a returned page's PG_private is cleared and
new heads of contiguous pages of 2^n length are connected to free_area[].
they are all marked with PG_private and their page->private keep their order.



---

 linux-2.6.9-rc1-mm1-k-kamezawa/mm/page_alloc.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-alloc mm/page_alloc.c
--- linux-2.6.9-rc1-mm1-k/mm/page_alloc.c~eliminate-bitmap-alloc	2004-08-31 18:37:16.768188896 +0900
+++ linux-2.6.9-rc1-mm1-k-kamezawa/mm/page_alloc.c	2004-08-31 18:43:27.740792488 +0900
@@ -288,9 +288,6 @@ void __free_pages_ok(struct page *page,
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }

-#define MARK_USED(index, order, area) \
-	__change_bit((index) >> (1+(order)), (area)->map)
-
 /*
  * The order of subdivision here is critical for the IO subsystem.
  * Please do not alter this order without good reasons and regression
@@ -307,7 +304,7 @@ void __free_pages_ok(struct page *page,
  */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
-	 unsigned long index, int low, int high, struct free_area *area)
+       int low, int high, struct free_area *area)
 {
 	unsigned long size = 1 << high;

@@ -317,7 +314,9 @@ expand(struct zone *zone, struct page *p
 		size >>= 1;
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
-		MARK_USED(index + size, high, area);
+		/* Note: already have lock, we don't need to use atomic ops */
+		set_page_order(&page[size], high);
+		SetPagePrivate(&page[size]);
 	}
 	return page;
 }
@@ -371,7 +370,6 @@ static struct page *__rmqueue(struct zon
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
-	unsigned int index;

 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
 		area = zone->free_area + current_order;
@@ -380,11 +378,10 @@ static struct page *__rmqueue(struct zon

 		page = list_entry(area->free_list.next, struct page, lru);
 		list_del(&page->lru);
-		index = page - zone->zone_mem_map;
-		if (current_order != MAX_ORDER-1)
-			MARK_USED(index, current_order, area);
+		/* Note: already have lock, we don't need to use atomic ops */
+		ClearPagePrivate(page);
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, index, order, current_order, area);
+		return expand(zone, page, order, current_order, area);
 	}

 	return NULL;

_

