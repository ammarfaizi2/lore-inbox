Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJDWzO>; Fri, 4 Oct 2002 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261780AbSJDWyG>; Fri, 4 Oct 2002 18:54:06 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:34891 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261742AbSJDWto>; Fri, 4 Oct 2002 18:49:44 -0400
Date: Fri, 4 Oct 2002 16:03:42 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3g810034@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (5/9): add in use for page alloc/free
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds in-use tag for dump ordering capabilities (so
taht pages in use are dumped first).

diff -urN -X /home/bharata/dontdiff linux-2.5.40/include/linux/page-flags.h linux-2.5.40+lkcd/include/linux/page-flags.h
--- linux-2.5.40/include/linux/page-flags.h	Tue Oct  1 12:37:31 2002
+++ linux-2.5.40+lkcd/include/linux/page-flags.h	Thu Oct  3 07:21:23 2002
@@ -69,6 +69,7 @@
 
 #define PG_direct		16	/* ->pte_chain points directly at pte */
 
+#define PG_inuse		17
 /*
  * Global page accounting.  One instance per CPU.
  */
@@ -204,6 +205,10 @@
 #define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
 
+#define PageInuse(page)		test_bit(PG_inuse, &(page)->flags)
+#define SetPageInuse(page)	__set_bit(PG_inuse, &(page)->flags)
+#define ClearPageInuse(page)	__clear_bit(PG_inuse, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -urN -X /home/bharata/dontdiff linux-2.5.40/mm/page_alloc.c linux-2.5.40+lkcd/mm/page_alloc.c
--- linux-2.5.40/mm/page_alloc.c	Tue Oct  1 12:36:16 2002
+++ linux-2.5.40+lkcd/mm/page_alloc.c	Thu Oct  3 07:21:23 2002
@@ -85,6 +85,14 @@
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
 
 	KERNEL_STAT_ADD(pgfree, 1<<order);
 
@@ -206,7 +214,7 @@
 		curr = head->next;
 
 		if (curr != head) {
-			unsigned int index;
+			unsigned int index, i;
 
 			page = list_entry(curr, struct page, list);
 			BUG_ON(bad_range(zone, page));
@@ -221,6 +229,12 @@
 
 			if (bad_range(zone, page))
 				BUG();
+			i = 1UL << order;
+			page += i;
+			do {
+				page--;
+				SetPageInuse(page);
+			} while (--i);
 			prep_new_page(page);
 			return page;	
 		}
@@ -276,6 +290,7 @@
 		struct list_head * entry, * local_pages;
 		struct page * tmp;
 		int nr_pages;
+		unsigned int i;
 
 		local_pages = &current->local_pages;
 
@@ -288,6 +303,12 @@
 					list_del(entry);
 					page = tmp;
 					current->nr_local_pages--;
+					i = 1UL << order;
+					page = tmp + i;
+					do {
+						page--;
+						SetPageInuse(page);
+					} while (--i);
 					prep_new_page(page);
 					break;
 				}
