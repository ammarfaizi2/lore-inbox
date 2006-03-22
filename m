Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932879AbWCVWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbWCVWei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932881AbWCVWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:33:59 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:20643 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S932895AbWCVWdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:33:52 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223318.12658.32710.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 13/34] mm: page-replace-mark-accessed.patch
Date: Wed, 22 Mar 2006 23:33:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Abstract the page activation.

API:
	void page_replace_mark_accessed(struct page *);

Mark a page as accessed.

XXX: go through tree and rename mark_page_accessed() ?

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    1 +
 include/linux/mm_use_once_policy.h |   26 ++++++++++++++++++++++++++
 mm/swap.c                          |   28 +---------------------------
 3 files changed, 28 insertions(+), 27 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -31,6 +31,32 @@ static inline void page_replace_hint_use
 {
 }
 
+/*
+ * Mark a page as having seen activity.
+ *
+ * inactive,unreferenced	->	inactive,referenced
+ * inactive,referenced		->	active,unreferenced
+ * active,unreferenced		->	active,referenced
+ */
+static inline void page_replace_mark_accessed(struct page *page)
+{
+	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+		struct zone *zone = page_zone(page);
+
+		spin_lock_irq(&zone->lru_lock);
+		if (PageLRU(page) && !PageActive(page)) {
+			del_page_from_inactive_list(zone, page);
+			SetPageActive(page);
+			add_page_to_active_list(zone, page);
+			inc_page_state(pgactivate);
+		}
+		spin_unlock_irq(&zone->lru_lock);
+		ClearPageReferenced(page);
+	} else if (!PageReferenced(page)) {
+		SetPageReferenced(page);
+	}
+}
+
 /* Called without lock on whether page is mapped, so answer is unstable */
 static inline int page_mapping_inuse(struct page *page)
 {
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -88,6 +88,7 @@ typedef enum {
 /* int page_replace_activate(struct page *page); */
 extern void page_replace_reinsert(struct list_head *);
 extern void page_replace_shrink(struct zone *, struct scan_control *);
+/* void page_replace_mark_accessed(struct page *); */
 
 #ifdef CONFIG_MIGRATION
 extern int page_replace_isolate(struct page *p);
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -98,37 +98,11 @@ int rotate_reclaimable_page(struct page 
 }
 
 /*
- * FIXME: speed this up?
- */
-void fastcall activate_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-
-	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-}
-
-/*
  * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	}
+	page_replace_mark_accessed(page);
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
