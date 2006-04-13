Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWDMXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWDMXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWDMXJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42446 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965011AbWDMXJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:09:07 -0400
Date: Thu, 13 Apr 2006 16:07:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Martin Bligh <mbligh@google.com>, Rohit Seth <rohitseth@google.com>,
       Nick Piggin <npiggin@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/22] Fix buddy list race that could lead to page lru list corruptions
Message-ID: <20060413230759.GK5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-buddy-list-race-that-could-lead-to-page-lru-list-corruptions.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Nick Piggin <piggin@cyberone.com.au>

[PATCH] Fix buddy list race that could lead to page lru list corruptions

Rohit found an obscure bug causing buddy list corruption.

page_is_buddy is using a non-atomic test (PagePrivate && page_count == 0)
to determine whether or not a free page's buddy is itself free and in the
buddy lists.

Each of the conjuncts may be true at different times due to unrelated
conditions, so the non-atomic page_is_buddy test may find each conjunct to
be true even if they were not both true at the same time (ie. the page was
not on the buddy lists).

Signed-off-by: Martin Bligh <mbligh@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>
Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/mm.h         |    5 ++---
 include/linux/page-flags.h |    8 +++++++-
 mm/page_alloc.c            |   31 ++++++++++++++++++-------------
 3 files changed, 27 insertions(+), 17 deletions(-)

--- linux-2.6.16.5.orig/include/linux/mm.h
+++ linux-2.6.16.5/include/linux/mm.h
@@ -229,10 +229,9 @@ struct page {
 		unsigned long private;		/* Mapping-private opaque data:
 					 	 * usually used for buffer_heads
 						 * if PagePrivate set; used for
-						 * swp_entry_t if PageSwapCache.
-						 * When page is free, this
+						 * swp_entry_t if PageSwapCache;
 						 * indicates order in the buddy
-						 * system.
+						 * system if PG_buddy is set.
 						 */
 		struct address_space *mapping;	/* If low bit clear, points to
 						 * inode address_space, or NULL.
--- linux-2.6.16.5.orig/include/linux/page-flags.h
+++ linux-2.6.16.5/include/linux/page-flags.h
@@ -74,7 +74,9 @@
 #define PG_mappedtodisk		16	/* Has blocks allocated on-disk */
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
-#define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_buddy		19	/* Page is free, on buddy lists */
+
+#define PG_uncached		20	/* Page has been mapped as uncached */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -319,6 +321,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
 #define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
 
+#define PageBuddy(page)		test_bit(PG_buddy, &(page)->flags)
+#define __SetPageBuddy(page)	__set_bit(PG_buddy, &(page)->flags)
+#define __ClearPageBuddy(page)	__clear_bit(PG_buddy, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- linux-2.6.16.5.orig/mm/page_alloc.c
+++ linux-2.6.16.5/mm/page_alloc.c
@@ -153,7 +153,8 @@ static void bad_page(struct page *page)
 			1 << PG_reclaim |
 			1 << PG_slab    |
 			1 << PG_swapcache |
-			1 << PG_writeback );
+			1 << PG_writeback |
+			1 << PG_buddy );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
@@ -224,12 +225,12 @@ static inline unsigned long page_order(s
 
 static inline void set_page_order(struct page *page, int order) {
 	set_page_private(page, order);
-	__SetPagePrivate(page);
+	__SetPageBuddy(page);
 }
 
 static inline void rmv_page_order(struct page *page)
 {
-	__ClearPagePrivate(page);
+	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 }
 
@@ -268,11 +269,13 @@ __find_combined_index(unsigned long page
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
  * (a) the buddy is not in a hole &&
- * (b) the buddy is free &&
- * (c) the buddy is on the buddy system &&
- * (d) a page and its buddy have the same order.
- * for recording page's order, we use page_private(page) and PG_private.
+ * (b) the buddy is in the buddy system &&
+ * (c) a page and its buddy have the same order.
+ *
+ * For recording whether a page is in the buddy system, we use PG_buddy.
+ * Setting, clearing, and testing PG_buddy is serialized by zone->lock.
  *
+ * For recording page's order, we use page_private(page).
  */
 static inline int page_is_buddy(struct page *page, int order)
 {
@@ -281,10 +284,10 @@ static inline int page_is_buddy(struct p
 		return 0;
 #endif
 
-       if (PagePrivate(page)           &&
-           (page_order(page) == order) &&
-            page_count(page) == 0)
+	if (PageBuddy(page) && page_order(page) == order) {
+		BUG_ON(page_count(page) != 0);
                return 1;
+	}
        return 0;
 }
 
@@ -301,7 +304,7 @@ static inline int page_is_buddy(struct p
  * as necessary, plus some accounting needed to play nicely with other
  * parts of the VM system.
  * At each level, we keep a list of pages, which are heads of continuous
- * free pages of length of (1 << order) and marked with PG_Private.Page's
+ * free pages of length of (1 << order) and marked with PG_buddy. Page's
  * order is recorded in page_private(page) field.
  * So when we are allocating or freeing one, we can derive the state of the
  * other.  That is, if we allocate a small block, and both were   
@@ -364,7 +367,8 @@ static inline int free_pages_check(struc
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved ))))
+			1 << PG_reserved |
+			1 << PG_buddy ))))
 		bad_page(page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -522,7 +526,8 @@ static int prep_new_page(struct page *pa
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved ))))
+			1 << PG_reserved |
+			1 << PG_buddy ))))
 		bad_page(page);
 
 	/*

--
