Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSFBWKd>; Sun, 2 Jun 2002 18:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSFBWKc>; Sun, 2 Jun 2002 18:10:32 -0400
Received: from holomorphy.com ([66.224.33.161]:30626 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316588AbSFBWKb>;
	Sun, 2 Jun 2002 18:10:31 -0400
Date: Sun, 2 Jun 2002 15:10:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: remove memlist_* macros from page_alloc.c
Message-ID: <20020602221009.GL14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The memlist_* macros serve as nothing but an insulation layer from the
Linux-native generic list operations. This patch removes them in favor
of using generic list operations directly.

Against 2.5.19.


Cheers,
Bill


===== mm/page_alloc.c 1.66 vs edited =====
--- 1.66/mm/page_alloc.c	Sun Jun  2 15:05:35 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 15:07:58 2002
@@ -43,14 +43,6 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
-#define memlist_init(x) INIT_LIST_HEAD(x)
-#define memlist_add_head list_add
-#define memlist_add_tail list_add_tail
-#define memlist_del list_del
-#define memlist_entry list_entry
-#define memlist_next(x) ((x)->next)
-#define memlist_prev(x) ((x)->prev)
-
 /*
  * Temporary debugging check.
  */
@@ -145,13 +137,13 @@
 		if (BAD_RANGE(zone,buddy2))
 			BUG();
 
-		memlist_del(&buddy1->list);
+		list_del(&buddy1->list);
 		mask <<= 1;
 		area++;
 		index >>= 1;
 		page_idx &= mask;
 	}
-	memlist_add_head(&(base + page_idx)->list, &area->free_list);
+	list_add(&(base + page_idx)->list, &area->free_list);
 
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return;
@@ -181,7 +173,7 @@
 		area--;
 		high--;
 		size >>= 1;
-		memlist_add_head(&(page)->list, &(area)->free_list);
+		list_add(&(page)->list, &(area)->free_list);
 		MARK_USED(index, high, area);
 		index += size;
 		page += size;
@@ -203,15 +195,15 @@
 	spin_lock_irqsave(&zone->lock, flags);
 	do {
 		head = &area->free_list;
-		curr = memlist_next(head);
+		curr = head->next;
 
 		if (curr != head) {
 			unsigned int index;
 
-			page = memlist_entry(curr, struct page, list);
+			page = list_entry(curr, struct page, list);
 			if (BAD_RANGE(zone,page))
 				BUG();
-			memlist_del(curr);
+			list_del(curr);
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
 				MARK_USED(index, curr_order, area);
@@ -673,7 +665,7 @@
 				curr = head;
 				nr = 0;
 				for (;;) {
-					curr = memlist_next(curr);
+					curr = curr->next;
 					if (curr == head)
 						break;
 					nr++;
@@ -900,7 +892,7 @@
 			set_page_zone(page, nid * MAX_NR_ZONES + j);
 			set_page_count(page, 0);
 			SetPageReserved(page);
-			memlist_init(&page->list);
+			INIT_LIST_HEAD(&page->list);
 			if (j != ZONE_HIGHMEM)
 				set_page_address(page, __va(zone_start_paddr));
 			zone_start_paddr += PAGE_SIZE;
@@ -910,7 +902,7 @@
 		for (i = 0; ; i++) {
 			unsigned long bitmap_size;
 
-			memlist_init(&zone->free_area[i].free_list);
+			INIT_LIST_HEAD(&zone->free_area[i].free_list);
 			if (i == MAX_ORDER-1) {
 				zone->free_area[i].map = NULL;
 				break;
