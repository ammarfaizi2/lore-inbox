Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVFTHXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVFTHXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVFTHXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:23:32 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:30302 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261274AbVFTHXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:23:19 -0400
Subject: [patch 1/2] vm early reclaim orphaned pages (take 2)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, mason@suse.de
In-Reply-To: <1118978590.5261.4.camel@npiggin-nld.site>
References: <1118978590.5261.4.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-rX4cQfhThA0Xu2OJ+PSW"
Date: Mon, 20 Jun 2005 17:23:14 +1000
Message-Id: <1119252194.6240.22.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rX4cQfhThA0Xu2OJ+PSW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

How about this?

-- 
SUSE Labs, Novell Inc.



--=-rX4cQfhThA0Xu2OJ+PSW
Content-Disposition: attachment; filename=vm-early-reclaim-orphaned.patch
Content-Type: text/x-patch; name=vm-early-reclaim-orphaned.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have workloads where orphaned pages build up and appear to slow
the system down when it starts reclaiming memory.

Stripping the referenced bit from orphaned pages and putting them
on the end of the inactive list should help improve reclaim.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c	2005-06-01 16:09:34.000000000 +1000
+++ linux-2.6/mm/truncate.c	2005-06-20 17:05:41.011026426 +1000
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
+#include <linux/swap.h>
 #include <linux/buffer_head.h>	/* grr. try_to_release_page,
 				   block_invalidatepage */
 
@@ -48,9 +49,11 @@
 	if (page->mapping != mapping)
 		return;
 
-	if (PagePrivate(page))
-		do_invalidatepage(page, 0);
-
+	if (PagePrivate(page)) {
+		if (!(do_invalidatepage(page, 0)))
+			rotate_orphaned_page(page);
+	}
+				
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h	2005-06-01 16:09:26.000000000 +1000
+++ linux-2.6/include/linux/swap.h	2005-06-20 17:05:01.632921946 +1000
@@ -169,6 +169,7 @@
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
+extern void rotate_orphaned_page(struct page *page);
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c	2004-12-25 08:34:31.000000000 +1100
+++ linux-2.6/mm/swap.c	2005-06-20 17:20:28.216728238 +1000
@@ -87,7 +87,7 @@
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
 		list_del(&page->lru);
-		list_add_tail(&page->lru, &zone->inactive_list);
+		list_move_tail(&page->lru, &zone->inactive_list);
 		inc_page_state(pgrotated);
 	}
 	if (!test_clear_page_writeback(page))
@@ -97,6 +97,32 @@
 }
 
 /*
+ * A page has been truncated, but is being orphaned on the LRU list due to
+ * a filesystem dependancy.
+ *
+ * Strip the referenced bit from this page, and if it is on the active list
+ * then put it on the head of the inactive list to aid page reclaim.
+ *
+ * We don't put it on the tail of the inactive list because the page is
+ * not able to be immediately freed due to filesystem dependancy (however
+ * in general, putting the page on the tail would probably be a win, but
+ * slightly more prone to introducing a regression).
+ */
+void rotate_orphaned_page(struct page *page)
+{
+	unsigned long flags;
+	struct zone *zone = page_zone(page);
+
+	spin_lock_irqsave(&zone->lru_lock, flags);
+	ClearPageReferenced(page);
+	if (PageLRU(page) && PageActive(page)) {
+		list_move(&page->lru, &zone->inactive_list);
+		ClearPageActive(page);
+	}
+	spin_unlock_irqrestore(&zone->lru_lock, flags);
+}
+
+/*
  * FIXME: speed this up?
  */
 void fastcall activate_page(struct page *page)

--=-rX4cQfhThA0Xu2OJ+PSW--

Send instant messages to your online friends http://au.messenger.yahoo.com 
