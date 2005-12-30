Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVL3Wn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVL3Wn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVL3Wmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:42:53 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.27]:50255 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932154AbVL3WmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:42:17 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224152.765.28577.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 12/14] page-replace-rotate.patch
Date: Fri, 30 Dec 2005 23:42:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

page-replace interface function:
  __page_replace_rotate_reclaimable()

This function moves the page so that it will be available to the next
candidate scan.

Removes the knowledge of the page reclaim lists from the actual function.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/mm_page_replace.h |   15 ++++++++++++++-
 mm/page_replace.c               |    1 -
 mm/swap.c                       |    6 +-----
 3 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -6,6 +6,7 @@
 #include <linux/mmzone.h>
 #include <linux/mm.h>
 #include <linux/list.h>
+#include <linux/page-flags.h>
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
@@ -39,12 +40,24 @@
 
 void __page_replace_insert(struct zone *, struct page *);
 void page_replace_candidates(struct zone *, int, struct list_head *);
-static inline void page_replace_activate(struct page *page)
+
+static inline
+void page_replace_activate(struct page *page)
 {
 	SetPageActive(page);
 }
+
 void page_replace_reinsert(struct zone *, struct list_head *);
 
+static inline
+void __page_replace_rotate_reclaimable(struct zone *zone, struct page *page)
+{
+	if (PageLRU(page) && !PageActive(page)) {
+		list_move_tail(&page->lru, &zone->inactive_list);
+		inc_page_state(pgrotated);
+	}
+}
+
 static inline void
 add_page_to_active_list(struct zone *zone, struct page *page)
 {
Index: linux-2.6-git/mm/page_replace.c
===================================================================
--- linux-2.6-git.orig/mm/page_replace.c
+++ linux-2.6-git/mm/page_replace.c
@@ -1,7 +1,6 @@
 #include <linux/mm_page_replace.h>
 #include <linux/swap.h>
 #include <linux/pagevec.h>
-#include <linux/page-flags.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page(),
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -82,11 +82,7 @@ int rotate_reclaimable_page(struct page 
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (PageLRU(page) && !PageActive(page)) {
-		list_del(&page->lru);
-		list_add_tail(&page->lru, &zone->inactive_list);
-		inc_page_state(pgrotated);
-	}
+	__page_replace_rotate_reclaimable(zone, page);
 	if (!test_clear_page_writeback(page))
 		BUG();
 	spin_unlock_irqrestore(&zone->lru_lock, flags);
