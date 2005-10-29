Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVJ2Fr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVJ2Fr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVJ2Fr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:47:26 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:24715 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751009AbVJ2FrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:47:25 -0400
Message-Id: <20051029060236.776500000@localhost.localdomain>
References: <20051029060216.159380000@localhost.localdomain>
Date: Sat, 29 Oct 2005 14:02:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 01/13] mm: delayed page activation
Content-Disposition: inline; filename=mm-delayed-activation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a page is referenced the second time in inactive_list, mark it with
PG_activate instead of moving it into active_list immediately. The actual
moving work is delayed to vmscan time.

This means two essential changes:
- keeps the adjecency of pages in lru;
- lifts the page reference counter max from 1 to 3.

And leads to the following improvements:
- read-ahead for a leading reader will not be disturbed by a following reader;
- enables the thrashing protection logic to save pages for following readers;
- keeping relavant pages together helps improve I/O efficiency;
- and also helps decrease vm fragmantation;
- increased refcnt space might help page replacement algorithms.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/page-flags.h |   31 +++++++++++++++++++++++++++++++
 mm/page_alloc.c            |    1 +
 mm/swap.c                  |    9 ++++-----
 mm/vmscan.c                |    6 ++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

--- linux-2.6.14-rc5-mm1.orig/include/linux/page-flags.h
+++ linux-2.6.14-rc5-mm1/include/linux/page-flags.h
@@ -76,6 +76,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_activate		20	/* delayed activate */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -308,6 +309,12 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageActivate(page)	test_bit(PG_activate, &(page)->flags)
+#define SetPageActivate(page)	set_bit(PG_activate, &(page)->flags)
+#define ClearPageActivate(page)	clear_bit(PG_activate, &(page)->flags)
+#define TestClearPageActivate(page) test_and_clear_bit(PG_activate, &(page)->flags)
+#define TestSetPageActivate(page) test_and_set_bit(PG_activate, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
@@ -333,4 +340,28 @@ static inline void set_page_writeback(st
 #define ClearPageFsMisc(page)		clear_bit(PG_fs_misc, &(page)->flags)
 #define TestClearPageFsMisc(page)	test_and_clear_bit(PG_fs_misc, &(page)->flags)
 
+#if PG_activate < PG_referenced
+#error unexpected page flags order
+#endif
+
+#define PAGE_REFCNT_0		0
+#define PAGE_REFCNT_1		(1 << PG_referenced)
+#define PAGE_REFCNT_2		(1 << PG_activate)
+#define PAGE_REFCNT_3		((1 << PG_activate) | (1 << PG_referenced))
+#define PAGE_REFCNT_MASK	PAGE_REFCNT_3
+
+/*
+ * STATUS   REFERENCE COUNT
+ *  __                   0
+ *  _R       PAGE_REFCNT_1
+ *  A_       PAGE_REFCNT_2
+ *  AR       PAGE_REFCNT_3
+ *
+ *  A/R: Active / Referenced
+ */
+static inline unsigned long page_refcnt(struct page *page)
+{
+	return page->flags & PAGE_REFCNT_MASK;
+}
+
 #endif	/* PAGE_FLAGS_H */
--- linux-2.6.14-rc5-mm1.orig/mm/page_alloc.c
+++ linux-2.6.14-rc5-mm1/mm/page_alloc.c
@@ -488,6 +488,7 @@ static void prep_new_page(struct page *p
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
+			1 << PG_activate |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
 	set_page_refs(page, order);
--- linux-2.6.14-rc5-mm1.orig/mm/swap.c
+++ linux-2.6.14-rc5-mm1/mm/swap.c
@@ -29,7 +29,6 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
-#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -117,13 +116,13 @@ void fastcall activate_page(struct page 
  * Mark a page as having seen activity.
  *
  * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
+ * inactive,referenced		->	activate,unreferenced
+ * activate,unreferenced	->	activate,referenced
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
+	if (!PageActivate(page) && PageReferenced(page) && PageLRU(page)) {
+		SetPageActivate(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c
@@ -407,6 +407,12 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (PageActivate(page)) {
+			ClearPageActivate(page);
+			ClearPageReferenced(page);
+			goto activate_locked;
+		}
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))

--
