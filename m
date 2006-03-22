Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932877AbWCVWfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877AbWCVWfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932885AbWCVWep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:34:45 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63764 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932887AbWCVWeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:34:12 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223338.12658.78359.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 15/34] mm: page-replace-rotate.patch
Date: Wed, 22 Mar 2006 23:34:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Take out the knowledge of the rotation itself.

API:

rotate the page to the candidate end of the page scanner 
(when suitable for reclaim)

	void __page_replace_rotate_reclaimable(struct zone *, struct page *);

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    1 +
 include/linux/mm_use_once_policy.h |    8 ++++++++
 mm/swap.c                          |    8 +-------
 3 files changed, 10 insertions(+), 7 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -127,5 +127,13 @@ static inline void page_replace_remove(s
 	}
 }
 
+static inline void __page_replace_rotate_reclaimable(struct zone *zone, struct page *page)
+{
+	if (PageLRU(page) && !PageActive(page)) {
+		list_move_tail(&page->lru, &zone->inactive_list);
+		inc_page_state(pgrotated);
+	}
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -89,6 +89,7 @@ extern void page_replace_reinsert(struct
 extern void page_replace_shrink(struct zone *, struct scan_control *);
 /* void page_replace_mark_accessed(struct page *); */
 /* void page_replace_remove(struct zone *, struct page *); */
+/* void __page_replace_rotate_reclaimable(struct zone *, struct page *); */
 
 #ifdef CONFIG_MIGRATION
 extern int page_replace_isolate(struct page *p);
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -78,18 +78,12 @@ int rotate_reclaimable_page(struct page 
 		return 1;
 	if (PageDirty(page))
 		return 1;
-	if (PageActive(page))
-		return 1;
 	if (!PageLRU(page))
 		return 1;
 
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
