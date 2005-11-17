Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVKQTd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVKQTd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKQTd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:33:59 -0500
Received: from silver.veritas.com ([143.127.12.111]:47904 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964809AbVKQTd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:33:58 -0500
Date: Thu, 17 Nov 2005 19:32:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] unpaged: unifdefed PageCompound
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171931400.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:33:58.0190 (UTC) FILETIME=[DAC154E0:01C5EBAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like snd_xxx is not the only nopage to be using PageReserved as
a way of holding a high-order page together: which no longer works, but
is masked by our failure to free from VM_RESERVED areas.  We cannot fix
that bug without first substituting another way to hold the high-order
page together, while farming out the 0-order pages from within it.

That's just what PageCompound is designed for, but it's been kept under
CONFIG_HUGETLB_PAGE.  Remove the #ifdefs: which saves some space (out-
of-line put_page), doesn't slow down what most needs to be fast (already
using hugetlb), and unifies the way we handle high-order pages.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mm.h         |   19 -------------------
 include/linux/page-flags.h |    4 ----
 mm/page_alloc.c            |    5 -----
 mm/swap.c                  |    3 ---
 4 files changed, 31 deletions(-)

--- unpaged03/include/linux/mm.h	2005-11-17 13:53:20.000000000 +0000
+++ unpaged04/include/linux/mm.h	2005-11-17 15:10:50.000000000 +0000
@@ -311,8 +311,6 @@ struct page {
 
 extern void FASTCALL(__page_cache_release(struct page *));
 
-#ifdef CONFIG_HUGETLB_PAGE
-
 static inline int page_count(struct page *page)
 {
 	if (PageCompound(page))
@@ -329,23 +327,6 @@ static inline void get_page(struct page 
 
 void put_page(struct page *page);
 
-#else		/* CONFIG_HUGETLB_PAGE */
-
-#define page_count(p)		(atomic_read(&(p)->_count) + 1)
-
-static inline void get_page(struct page *page)
-{
-	atomic_inc(&page->_count);
-}
-
-static inline void put_page(struct page *page)
-{
-	if (put_page_testzero(page))
-		__page_cache_release(page);
-}
-
-#endif		/* CONFIG_HUGETLB_PAGE */
-
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
--- unpaged03/include/linux/page-flags.h	2005-10-28 01:02:08.000000000 +0100
+++ unpaged04/include/linux/page-flags.h	2005-11-17 15:10:50.000000000 +0000
@@ -287,11 +287,7 @@ extern void __mod_page_state(unsigned lo
 #define ClearPageReclaim(page)	clear_bit(PG_reclaim, &(page)->flags)
 #define TestClearPageReclaim(page) test_and_clear_bit(PG_reclaim, &(page)->flags)
 
-#ifdef CONFIG_HUGETLB_PAGE
 #define PageCompound(page)	test_bit(PG_compound, &(page)->flags)
-#else
-#define PageCompound(page)	0
-#endif
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
--- unpaged03/mm/page_alloc.c	2005-11-17 13:53:21.000000000 +0000
+++ unpaged04/mm/page_alloc.c	2005-11-17 15:10:50.000000000 +0000
@@ -148,10 +148,6 @@ static void bad_page(const char *functio
 	add_taint(TAINT_BAD_PAGE);
 }
 
-#ifndef CONFIG_HUGETLB_PAGE
-#define prep_compound_page(page, order) do { } while (0)
-#define destroy_compound_page(page, order) do { } while (0)
-#else
 /*
  * Higher-order pages are called "compound pages".  They are structured thusly:
  *
@@ -205,7 +201,6 @@ static void destroy_compound_page(struct
 		ClearPageCompound(p);
 	}
 }
-#endif		/* CONFIG_HUGETLB_PAGE */
 
 /*
  * function for dealing with page's order in buddy system.
--- unpaged03/mm/swap.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged04/mm/swap.c	2005-11-17 15:10:50.000000000 +0000
@@ -34,8 +34,6 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
-#ifdef CONFIG_HUGETLB_PAGE
-
 void put_page(struct page *page)
 {
 	if (unlikely(PageCompound(page))) {
@@ -52,7 +50,6 @@ void put_page(struct page *page)
 		__page_cache_release(page);
 }
 EXPORT_SYMBOL(put_page);
-#endif
 
 /*
  * Writeback is about to end against a page which has been marked for immediate
