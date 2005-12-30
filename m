Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVL3WmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVL3WmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVL3WmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:42:04 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.19]:10589 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932154AbVL3Wl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:41:56 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224132.765.18970.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 10/14] page-replace-remove-mm_inline.patch
Date: Fri, 30 Dec 2005 23:41:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Move the few mm_inline function to the new files.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/mm_inline.h       |   40 ----------------------------------------
 include/linux/mm_page_replace.h |   33 +++++++++++++++++++++++++++++++++
 mm/page_replace.c               |    7 ++++++-
 mm/swap.c                       |    1 -
 mm/vmscan.c                     |    1 -
 5 files changed, 39 insertions(+), 43 deletions(-)

Index: linux-2.6-git/include/linux/mm_inline.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_inline.h
+++ /dev/null
@@ -1,40 +0,0 @@
-
-static inline void
-add_page_to_active_list(struct zone *zone, struct page *page)
-{
-	list_add(&page->lru, &zone->active_list);
-	zone->nr_active++;
-}
-
-static inline void
-add_page_to_inactive_list(struct zone *zone, struct page *page)
-{
-	list_add(&page->lru, &zone->inactive_list);
-	zone->nr_inactive++;
-}
-
-static inline void
-del_page_from_active_list(struct zone *zone, struct page *page)
-{
-	list_del(&page->lru);
-	zone->nr_active--;
-}
-
-static inline void
-del_page_from_inactive_list(struct zone *zone, struct page *page)
-{
-	list_del(&page->lru);
-	zone->nr_inactive--;
-}
-
-static inline void
-del_page_from_lru(struct zone *zone, struct page *page)
-{
-	list_del(&page->lru);
-	if (PageActive(page)) {
-		ClearPageActive(page);
-		zone->nr_active--;
-	} else {
-		zone->nr_inactive--;
-	}
-}
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -47,5 +47,38 @@ void page_replace_reinsert(struct zone *
 
 int isolate_lru_pages(int, struct list_head *, struct list_head *, int *);
 
+static inline void
+add_page_to_active_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->active_list);
+	zone->nr_active++;
+}
+
+static inline void
+del_page_from_active_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_active--;
+}
+
+static inline void
+del_page_from_inactive_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_inactive--;
+}
+
+static inline void
+del_page_from_lru(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	if (PageActive(page)) {
+		ClearPageActive(page);
+		zone->nr_active--;
+	} else {
+		zone->nr_inactive--;
+	}
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_PAGE_REPLACE_H */
Index: linux-2.6-git/mm/page_replace.c
===================================================================
--- linux-2.6-git.orig/mm/page_replace.c
+++ linux-2.6-git/mm/page_replace.c
@@ -1,8 +1,13 @@
 #include <linux/mm_page_replace.h>
-#include <linux/mm_inline.h>
 #include <linux/swap.h>
 #include <linux/pagevec.h>
 
+static inline void
+add_page_to_inactive_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->inactive_list);
+	zone->nr_inactive++;
+}
 
 void __page_replace_insert(struct zone *zone, struct page *page)
 {
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -22,7 +22,6 @@
 #include <linux/pagevec.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/module.h>
 #include <linux/percpu_counter.h>
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -24,7 +24,6 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page(),
 					buffer_heads_over_limit */
-#include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap.h>
