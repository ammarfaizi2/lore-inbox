Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSJWJbO>; Wed, 23 Oct 2002 05:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJWJ34>; Wed, 23 Oct 2002 05:29:56 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:1092 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263270AbSJWJ3t>; Wed, 23 Oct 2002 05:29:49 -0400
Date: Wed, 23 Oct 2002 02:44:16 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [PATCH] LKCD for 2.5.44 (4/8): add in use for page alloc/free
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210230244060.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds in-use tag for dump ordering capabilities (so that pages
in use are dumped first).

 include/linux/page-flags.h |    5 +++++
 mm/page_alloc.c            |   22 +++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff -Naur linux-2.5.44.orig/include/linux/page-flags.h linux-2.5.44.lkcd/include/linux/page-flags.h
--- linux-2.5.44.orig/include/linux/page-flags.h	Fri Oct 18 21:02:26 2002
+++ linux-2.5.44.lkcd/include/linux/page-flags.h	Sat Oct 19 12:39:15 2002
@@ -68,6 +68,7 @@
 #define PG_chainlock		15	/* lock bit for ->pte_chain */
 
 #define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_inuse		17
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -228,6 +229,10 @@
 #define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
 
+#define PageInuse(page)		test_bit(PG_inuse, &(page)->flags)
+#define SetPageInuse(page)	__set_bit(PG_inuse, &(page)->flags)
+#define ClearPageInuse(page)	__clear_bit(PG_inuse, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -Naur linux-2.5.44.orig/mm/page_alloc.c linux-2.5.44.lkcd/mm/page_alloc.c
--- linux-2.5.44.orig/mm/page_alloc.c	Fri Oct 18 21:01:09 2002
+++ linux-2.5.44.lkcd/mm/page_alloc.c	Sat Oct 19 12:39:15 2002
@@ -88,6 +88,14 @@
 	struct free_area *area;
 	struct page *base;
 	struct zone *zone;
+ 	unsigned int i;
+ 
+ 	i = 1UL << order;
+ 	page += i;
+ 	do {
+ 		page--;
+ 		ClearPageInuse(page);
+ 	} while (--i);
 
 	mod_page_state(pgfree, 1<<order);
 
@@ -179,8 +187,16 @@
 /*
  * This page is about to be returned from the page allocator
  */
-static inline void prep_new_page(struct page *page)
+static inline void prep_new_page(struct page *page, unsigned int order)
 {
+	unsigned int i;
+
+	i = 1UL << order;
+	page += i;
+	do {
+		page--;
+		SetPageInuse(page);
+	} while (--i);
 	BUG_ON(page->mapping);
 	BUG_ON(PagePrivate(page));
 	BUG_ON(PageLocked(page));
@@ -224,7 +240,7 @@
 
 			if (bad_range(zone, page))
 				BUG();
-			prep_new_page(page);
+			prep_new_page(page, order);
 			return page;	
 		}
 		curr_order++;
@@ -291,7 +307,7 @@
 					list_del(entry);
 					page = tmp;
 					current->nr_local_pages--;
-					prep_new_page(page);
+					prep_new_page(page, order);
 					break;
 				}
 			} while ((entry = entry->next) != local_pages);

