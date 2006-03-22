Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932907AbWCVWoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbWCVWoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932868AbWCVWdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:33:09 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26550 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932854AbWCVWcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:32:42 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223208.12658.66934.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 06/34] mm: page-replace-activate.patch
Date: Wed, 22 Mar 2006 23:32:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Abstract page activation and the reclaimable condition.

API:

wether the page is reclaimable

	reclaim_t page_replace_reclaimable(struct page *);

	RECLAIM_KEEP		- keep the page
	RECLAIM_ACTIVATE	- keep the page and activate
	RECLAIM_REFERENCED	- try to pageout even though referenced
	RECLAIM_OK		- try to pageout
	
activate the page
	
	int page_replace_activate(struct page *page);

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |   11 ++++++++
 include/linux/mm_use_once_policy.h |   48 +++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                        |   42 ++++++++++----------------------
 3 files changed, 72 insertions(+), 29 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -3,6 +3,9 @@
 
 #ifdef __KERNEL__
 
+#include <linux/fs.h>
+#include <linux/rmap.h>
+
 static inline void page_replace_hint_active(struct page *page)
 {
 	SetPageActive(page);
@@ -28,5 +31,50 @@ static inline void page_replace_hint_use
 {
 }
 
+/* Called without lock on whether page is mapped, so answer is unstable */
+static inline int page_mapping_inuse(struct page *page)
+{
+	struct address_space *mapping;
+
+	/* Page is in somebody's page tables. */
+	if (page_mapped(page))
+		return 1;
+
+	/* Be more reluctant to reclaim swapcache than pagecache */
+	if (PageSwapCache(page))
+		return 1;
+
+	mapping = page_mapping(page);
+	if (!mapping)
+		return 0;
+
+	/* File is mmap'd by somebody? */
+	return mapping_mapped(mapping);
+}
+
+static inline reclaim_t page_replace_reclaimable(struct page *page)
+{
+	int referenced;
+
+	if (PageActive(page))
+		BUG();
+
+	referenced = page_referenced(page, 1);
+	/* In active use or really unfreeable?  Activate it. */
+	if (referenced && page_mapping_inuse(page))
+		return RECLAIM_ACTIVATE;
+
+	if (referenced)
+		return RECLAIM_REFERENCED;
+
+	return RECLAIM_OK;
+}
+
+static inline int page_replace_activate(struct page *page)
+{
+	SetPageActive(page);
+	return 1;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -17,6 +17,17 @@ extern void __page_replace_add_drain(uns
 extern int page_replace_add_drain_all(void);
 extern void __pagevec_page_replace_add(struct pagevec *);
 
+typedef enum {
+	RECLAIM_KEEP,
+	RECLAIM_ACTIVATE,
+	RECLAIM_REFERENCED,
+	RECLAIM_OK,
+} reclaim_t;
+
+/* reclaim_t page_replace_reclaimable(struct page *); */
+/* int page_replace_activate(struct page *page); */
+
+
 #ifdef CONFIG_MM_POLICY_USEONCE
 #include <linux/mm_use_once_policy.h>
 #else
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -244,27 +244,6 @@ int shrink_slab(unsigned long scanned, g
 	return ret;
 }
 
-/* Called without lock on whether page is mapped, so answer is unstable */
-static inline int page_mapping_inuse(struct page *page)
-{
-	struct address_space *mapping;
-
-	/* Page is in somebody's page tables. */
-	if (page_mapped(page))
-		return 1;
-
-	/* Be more reluctant to reclaim swapcache than pagecache */
-	if (PageSwapCache(page))
-		return 1;
-
-	mapping = page_mapping(page);
-	if (!mapping)
-		return 0;
-
-	/* File is mmap'd by somebody? */
-	return mapping_mapped(mapping);
-}
-
 static inline int is_page_cache_freeable(struct page *page)
 {
 	return page_count(page) - !!PagePrivate(page) == 2;
@@ -431,7 +410,7 @@ static int shrink_list(struct list_head 
 		struct address_space *mapping;
 		struct page *page;
 		int may_enter_fs;
-		int referenced;
+		int referenced = 0;
 
 		cond_resched();
 
@@ -441,8 +420,6 @@ static int shrink_list(struct list_head 
 		if (TestSetPageLocked(page))
 			goto keep;
 
-		BUG_ON(PageActive(page));
-
 		sc->nr_scanned++;
 
 		if (!sc->may_swap && page_mapped(page))
@@ -455,10 +432,17 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
-		referenced = page_referenced(page, 1);
-		/* In active use or really unfreeable?  Activate it. */
-		if (referenced && page_mapping_inuse(page))
+		switch (page_replace_reclaimable(page)) {
+		case RECLAIM_KEEP:
+			goto keep_locked;
+		case RECLAIM_ACTIVATE:
 			goto activate_locked;
+		case RECLAIM_REFERENCED:
+			referenced = 1;
+			break;
+		case RECLAIM_OK:
+			break;
+		}
 
 #ifdef CONFIG_SWAP
 		/*
@@ -568,8 +552,8 @@ free_it:
 		continue;
 
 activate_locked:
-		SetPageActive(page);
-		pgactivate++;
+		if (page_replace_activate(page))
+			pgactivate++;
 keep_locked:
 		unlock_page(page);
 keep:
