Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSFBWcI>; Sun, 2 Jun 2002 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSFBWcH>; Sun, 2 Jun 2002 18:32:07 -0400
Received: from holomorphy.com ([66.224.33.161]:37282 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317023AbSFBWcH>;
	Sun, 2 Jun 2002 18:32:07 -0400
Date: Sun, 2 Jun 2002 15:31:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: remove MARK_USED() macros
Message-ID: <20020602223144.GO14918@holomorphy.com>
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

MARK_USED() only has two call sites within page_alloc.c and does not
effectively serve to clarify the code. This patch removes it in favor
of open-coding the __change_bit() at its call sites.


Against 2.5.19.


Cheers,
Bill


===== mm/page_alloc.c 1.69 vs edited =====
--- 1.69/mm/page_alloc.c	Sun Jun  2 15:26:30 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 15:28:11 2002
@@ -153,9 +153,6 @@
 	current->nr_local_pages++;
 }
 
-#define MARK_USED(index, order, area) \
-	__change_bit((index) >> (1+(order)), (area)->map)
-
 static inline struct page * expand (zone_t *zone, struct page *page,
 	 unsigned long index, int low, int high, free_area_t * area)
 {
@@ -167,7 +164,7 @@
 		high--;
 		size >>= 1;
 		list_add(&(page)->list, &(area)->free_list);
-		MARK_USED(index, high, area);
+		__change_bit(index >> (1+high), area->map);
 		index += size;
 		page += size;
 	}
@@ -197,7 +194,7 @@
 			list_del(curr);
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
-				MARK_USED(index, curr_order, area);
+				__change_bit(index >> (1+curr_order), area->map);
 			zone->free_pages -= 1UL << order;
 
 			page = expand(zone, page, index, order, curr_order, area);
