Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVFTHZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVFTHZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFTHZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:25:54 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:51072 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261459AbVFTHYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:24:34 -0400
Subject: [patch 2/2] stats for orphaned pages (-mm only)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, mason@suse.de
In-Reply-To: <1119252194.6240.22.camel@npiggin-nld.site>
References: <1118978590.5261.4.camel@npiggin-nld.site>
	 <1119252194.6240.22.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-IsMOhptYNwSuszRZcdO8"
Date: Mon, 20 Jun 2005 17:24:29 +1000
Message-Id: <1119252269.6240.25.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IsMOhptYNwSuszRZcdO8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

And this.

-- 
SUSE Labs, Novell Inc.



--=-IsMOhptYNwSuszRZcdO8
Content-Disposition: attachment; filename=vm-orphaned-debug.patch
Content-Type: text/x-patch; name=vm-orphaned-debug.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c	2005-06-20 17:20:28.216728238 +1000
+++ linux-2.6/mm/swap.c	2005-06-20 17:21:38.253021265 +1000
@@ -114,8 +114,16 @@
 	struct zone *zone = page_zone(page);
 
 	spin_lock_irqsave(&zone->lru_lock, flags);
-	ClearPageReferenced(page);
+	if (PageLRU(page))
+		SetPageOrphaned(page);
+	if (PageReferenced(page)) {
+		if (PageLRU(page))
+			inc_page_state(pg_orph_stripped);
+		ClearPageReferenced(page);
+	}
+	
 	if (PageLRU(page) && PageActive(page)) {
+		inc_page_state(pg_orph_rotated);
 		list_move(&page->lru, &zone->inactive_list);
 		ClearPageActive(page);
 	}
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h	2005-06-20 17:20:28.216728238 +1000
+++ linux-2.6/include/linux/page-flags.h	2005-06-20 17:20:56.005273542 +1000
@@ -77,6 +77,8 @@
 #define PG_nosave_free		19	/* Free, should not be written */
 #define PG_uncached		20	/* Page has been mapped as uncached */
 
+#define PG_orphaned		21
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -132,6 +134,11 @@
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
 	unsigned long nr_bounce;	/* pages for bounce buffers */
+	
+	unsigned long pg_orph_stripped;	/* Removed ref bit from orphaned page */
+	unsigned long pg_orph_rotated;	/* Deactivated orphaned page */
+	unsigned long pg_orph_busy;	/* Found orphans still busy */
+	unsigned long pg_orph_reclaim;	/* Reclaimed orphan at first sight */
 };
 
 extern void get_page_state(struct page_state *ret);
@@ -306,6 +313,10 @@
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageOrphaned(page)	test_bit(PG_orphaned, &(page)->flags)
+#define SetPageOrphaned(page)	set_bit(PG_orphaned, &(page)->flags)
+#define ClearPageOrphaned(page)	clear_bit(PG_orphaned, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2005-06-20 17:20:28.216728238 +1000
+++ linux-2.6/mm/page_alloc.c	2005-06-20 17:20:56.006273417 +1000
@@ -1899,6 +1899,11 @@
 
 	"pgrotated",
 	"nr_bounce",
+
+	"pg_orph_stripped",
+	"pg_orph_rotated",
+	"pg_orph_busy",
+	"pg_orph_reclaim",
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2005-06-20 17:20:28.216728238 +1000
+++ linux-2.6/mm/vmscan.c	2005-06-20 17:21:26.171523247 +1000
@@ -522,6 +522,11 @@
 		__put_page(page);
 
 free_it:
+		if (PageOrphaned(page)) {
+			inc_page_state(pg_orph_reclaim);
+			ClearPageOrphaned(page);
+		}
+		
 		unlock_page(page);
 		reclaimed++;
 		if (!pagevec_add(&freed_pvec, page))
@@ -534,6 +539,11 @@
 keep_locked:
 		unlock_page(page);
 keep:
+		if (PageOrphaned(page)) {
+			inc_page_state(pg_orph_busy);
+			ClearPageOrphaned(page);
+		}
+
 		list_add(&page->lru, &ret_pages);
 		BUG_ON(PageLRU(page));
 	}

--=-IsMOhptYNwSuszRZcdO8--

Send instant messages to your online friends http://au.messenger.yahoo.com 
