Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbTGIJ73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbTGIJ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:59:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265908AbTGIJ5r (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:57:47 -0400
Date: Wed, 9 Jul 2003 03:12:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5 VM changes: skip-writepage.patch
Message-Id: <20030709031242.14e89af6.akpm@osdl.org>
In-Reply-To: <16139.54921.640901.797268@laputa.namesys.com>
References: <16139.54921.640901.797268@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> Don't call ->writepage from VM scanner when page is met for the first time
>  during scan.


I don't think we need all the code reorganisation.  Something like this:


 include/linux/page-flags.h |    7 +++++++
 mm/page_alloc.c            |    1 +
 mm/truncate.c              |    2 ++
 mm/vmscan.c                |   10 ++++++++--
 5 files changed, 18 insertions(+), 2 deletions(-)

diff -puN include/linux/mm_inline.h~skip-writepage include/linux/mm_inline.h
diff -puN include/linux/page-flags.h~skip-writepage include/linux/page-flags.h
--- 25/include/linux/page-flags.h~skip-writepage	2003-07-09 02:58:48.000000000 -0700
+++ 25-akpm/include/linux/page-flags.h	2003-07-09 02:58:48.000000000 -0700
@@ -75,6 +75,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_skipped		20	/* ->writepage() was skipped on this page */
 
 
 /*
@@ -267,6 +268,12 @@ extern void get_full_page_state(struct p
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageSkipped(page)	test_bit(PG_skipped, &(page)->flags)
+#define SetPageSkipped(page)	set_bit(PG_skipped, &(page)->flags)
+#define TestSetPageSkipped(page)	test_and_set_bit(PG_skipped, &(page)->flags)
+#define ClearPageSkipped(page)		clear_bit(PG_skipped, &(page)->flags)
+#define TestClearPageSkipped(page)	test_and_clear_bit(PG_skipped, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -puN mm/vmscan.c~skip-writepage mm/vmscan.c
--- 25/mm/vmscan.c~skip-writepage	2003-07-09 02:58:48.000000000 -0700
+++ 25-akpm/mm/vmscan.c	2003-07-09 03:05:43.000000000 -0700
@@ -328,6 +328,8 @@ shrink_list(struct list_head *page_list,
 		 * See swapfile.c:page_queue_congested().
 		 */
 		if (PageDirty(page)) {
+			if (!TestSetPageSkipped(page))
+				goto keep_locked;
 			if (!is_page_cache_freeable(page))
 				goto keep_locked;
 			if (!mapping)
@@ -351,6 +353,7 @@ shrink_list(struct list_head *page_list,
 				list_move(&page->list, &mapping->locked_pages);
 				spin_unlock(&mapping->page_lock);
 
+				ClearPageSkipped(page);
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
 
@@ -533,10 +536,13 @@ shrink_cache(const int nr_pages, struct 
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
-			if (PageActive(page))
+			if (PageActive(page)) {
+				if (PageSkipped(page))
+					ClearPageSkipped(page);
 				add_page_to_active_list(zone, page);
-			else
+			} else {
 				add_page_to_inactive_list(zone, page);
+			}
 			if (!pagevec_add(&pvec, page)) {
 				spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
diff -puN mm/truncate.c~skip-writepage mm/truncate.c
--- 25/mm/truncate.c~skip-writepage	2003-07-09 03:05:53.000000000 -0700
+++ 25-akpm/mm/truncate.c	2003-07-09 03:06:37.000000000 -0700
@@ -53,6 +53,7 @@ truncate_complete_page(struct address_sp
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
+	ClearPageSkipped(page);
 	remove_from_page_cache(page);
 	page_cache_release(page);	/* pagecache ref */
 }
@@ -81,6 +82,7 @@ invalidate_complete_page(struct address_
 	__remove_from_page_cache(page);
 	spin_unlock(&mapping->page_lock);
 	ClearPageUptodate(page);
+	ClearPageSkipped(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
 }
diff -puN mm/page_alloc.c~skip-writepage mm/page_alloc.c
--- 25/mm/page_alloc.c~skip-writepage	2003-07-09 03:06:33.000000000 -0700
+++ 25-akpm/mm/page_alloc.c	2003-07-09 03:06:48.000000000 -0700
@@ -220,6 +220,7 @@ static inline void free_pages_check(cons
 			1 << PG_locked	|
 			1 << PG_active	|
 			1 << PG_reclaim	|
+			1 << PG_skipped	|
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))

_

