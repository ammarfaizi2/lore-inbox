Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUIHLrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUIHLrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269131AbUIHLrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:47:00 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55237 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269132AbUIHLqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:46:33 -0400
Date: Wed, 08 Sep 2004 20:51:46 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC][PATCH] no bitmap buddy allocator : modifies expand() (2/4)
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413EF252.8040808@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part (2/4) and modifies expand().

This patch removes bitmap operation from alloc_pages().

Instead of using MARK_USED() bitmap operation,
this patch records page's order in page struct itself, page->private field.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

  test-kernel-kamezawa/mm/page_alloc.c |   17 +++++++----------
  1 files changed, 7 insertions(+), 10 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-alloc mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-alloc	2004-09-08 18:48:40.667294640 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-09-08 19:04:05.398714096 +0900
@@ -296,9 +296,6 @@ void __free_pages_ok(struct page *page,
  	free_pages_bulk(page_zone(page), 1, &list, order);
  }

-#define MARK_USED(index, order, area) \
-	__change_bit((index) >> (1+(order)), (area)->map)
-
  /*
   * The order of subdivision here is critical for the IO subsystem.
   * Please do not alter this order without good reasons and regression
@@ -315,7 +312,7 @@ void __free_pages_ok(struct page *page,
   */
  static inline struct page *
  expand(struct zone *zone, struct page *page,
-	 unsigned long index, int low, int high, struct free_area *area)
+       int low, int high, struct free_area *area)
  {
  	unsigned long size = 1 << high;

@@ -325,7 +322,9 @@ expand(struct zone *zone, struct page *p
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
@@ -379,7 +378,6 @@ static struct page *__rmqueue(struct zon
  	struct free_area * area;
  	unsigned int current_order;
  	struct page *page;
-	unsigned int index;

  	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
  		area = zone->free_area + current_order;
@@ -388,11 +386,10 @@ static struct page *__rmqueue(struct zon

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



-- 

