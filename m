Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268908AbUHZMIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268908AbUHZMIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268882AbUHZMGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:06:06 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47780 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268722AbUHZL6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:58:47 -0400
Date: Thu, 26 Aug 2004 21:03:54 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap  [2/4]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-id: <412DD1AA.8080408@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is 3rd part, for page allocation.

PG_private is used for indicating
"This page is a head of contiguous free pages,whose length is 2^(page->private)"


-- Kame

========================

This patch removes bitmap operation from alloc_pages().

Instead of using MARK_USED() bitmap operation,
this patch records page's order in page struct itself, page->private field.

During locking zone->lock, a returned page's PG_private is cleared and
new heads of contiguous pages of 2^n length are connected to free_area[].
they are all marked with PG_private and their page->private keep their order.

example) 1 page allocation from 8 pages chunk


start ) before calling alloc_pages()
         free_area[3] -> page[0],order=3
         free_area[2] ->
         free_area[1] ->
         free_area[0] ->
	
	8 pages of chunk, starting from page[0] is connected to free_area[3].list
	here, free_area[2],free_area[1],free_area[0] is empty.	

step1 ) before calling expand()
         free_area[3] ->
         free_area[2] ->
         free_area[1] ->
         free_area[0] ->
         return page  -> page[0],order=invalid
	
	Because free_area[2],free_area[1],free_area[0] are empty,
	page[0] in free_area[3] is selected.
	expand() is called to divide page[0-7] into suitable chunks.

step2 ) expand loop 1st
         free_area[3] ->
	free_area[2] -> page[4],order = 2
	free_area[1] ->
	free_area[0] ->
         return page  -> page[0],order=invalid
	
	bottom half of pages[0-7], page[4-7] are free and have an order of 2.
	page[4] is connected to free_list[2].	
	
step3 ) expand loop 2nd
         free_area[3] ->
	free_area[2] -> page[4],order = 2
	free_area[1] -> page[2],order = 1
	free_area[0] ->
         return page  -> page[0],order=invalid
	
	bottom half of pages[0-3], page[2-3] are free and have an order of 1.
	page[2] is connected to free_list[1].
	
step4 ) expand loop 3rd
         free_area[3] ->
	free_area[2] -> page[4],order = 2
	free_area[1] -> page[2],order = 1
	free_area[0] -> page[1],order = 0
         return page  -> page[0],order=invalid
	
	bottom half of pages[0-1], page[1] is free and has an order of 0.
	page[1] is connected to free_list[0].

end )
         chunks of page[0 -7] is divided into
	page[4-7] of order 2
	page[2-3] of order 1
	page[1]   of order 0
         page[0]   is allocated.



---

  linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c |   16 ++++++----------
  1 files changed, 6 insertions(+), 10 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-alloc mm/page_alloc.c
--- linux-2.6.8.1-mm4-kame/mm/page_alloc.c~eliminate-bitmap-alloc	2004-08-26 08:43:16.000000000 +0900
+++ linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c	2004-08-26 11:40:29.461979560 +0900
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

@@ -317,7 +314,8 @@ expand(struct zone *zone, struct page *p
  		size >>= 1;
  		BUG_ON(bad_range(zone, &page[size]));
  		list_add(&page[size].lru, &area->free_list);
-		MARK_USED(index + size, high, area);
+		page[size].flags |= (1 << PG_private);
+		page[size].private = high;
  	}
  	return page;
  }
@@ -371,7 +369,6 @@ static struct page *__rmqueue(struct zon
  	struct free_area * area;
  	unsigned int current_order;
  	struct page *page;
-	unsigned int index;

  	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
  		area = zone->free_area + current_order;
@@ -380,11 +377,10 @@ static struct page *__rmqueue(struct zon

  		page = list_entry(area->free_list.next, struct page, lru);
  		list_del(&page->lru);
-		index = page - zone->zone_mem_map;
-		if (current_order != MAX_ORDER-1)
-			MARK_USED(index, current_order, area);
+		/* Atomic operation is needless here */
+		page->flags &= ~(1 << PG_private);
  		zone->free_pages -= 1UL << order;
-		return expand(zone, page, index, order, current_order, area);
+		return expand(zone, page, order, current_order, area);
  	}

  	return NULL;

_

