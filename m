Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262185AbSJJTzz>; Thu, 10 Oct 2002 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262182AbSJJTyk>; Thu, 10 Oct 2002 15:54:40 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:10318 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262180AbSJJTuS>; Thu, 10 Oct 2002 15:50:18 -0400
Date: Thu, 10 Oct 2002 13:04:25 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4PF29568@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (4/8): add in use for page alloc/free
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds in-use tag for dump ordering capabilities (so
that pages in use are dumped first).


 include/linux/page-flags.h |    5 +++++
 mm/page_alloc.c            |   23 ++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)


diff -Naur linux-2.5.41.orig/include/linux/page-flags.h linux-2.5.41.lkcd/include/linux/page-flags.h
--- linux-2.5.41.orig/include/linux/page-flags.h	Mon Oct  7 11:24:45 2002
+++ linux-2.5.41.lkcd/include/linux/page-flags.h	Tue Oct  8 01:15:13 2002
@@ -69,6 +69,7 @@
 
 #define PG_direct		16	/* ->pte_chain points directly at pte */
 
+#define PG_inuse		17
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
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
diff -Naur linux-2.5.41.orig/mm/page_alloc.c linux-2.5.41.lkcd/mm/page_alloc.c
--- linux-2.5.41.orig/mm/page_alloc.c	Mon Oct  7 11:23:24 2002
+++ linux-2.5.41.lkcd/mm/page_alloc.c	Tue Oct  8 01:15:13 2002
@@ -86,6 +86,14 @@
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
 
@@ -207,7 +215,7 @@
 		curr = head->next;
 
 		if (curr != head) {
-			unsigned int index;
+			unsigned int index, i;
 
 			page = list_entry(curr, struct page, list);
 			BUG_ON(bad_range(zone, page));
@@ -222,6 +230,12 @@
 
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
@@ -277,6 +291,7 @@
 		struct list_head * entry, * local_pages;
 		struct page * tmp;
 		int nr_pages;
+		unsigned int i;
 
 		local_pages = &current->local_pages;
 
@@ -289,6 +304,12 @@
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
