Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932881AbWCVWfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbWCVWfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWCVWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:35:11 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32296 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932884AbWCVWfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:35:05 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223430.12658.69558.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 20/34] mm: page-replace-pg_flags.patch
Date: Wed, 22 Mar 2006 23:35:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Abstract the replacement policy specific pageflags.

API:

Copy the policy specific page flags

	void page_replace_copy_state(struct page *, struct page *);

Clear the policy specific page flags

	void page_replace_clear_state(struct page *);

Account the page as active

	int page_replace_is_active(struct page *);

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    3 +++
 include/linux/mm_use_once_policy.h |   26 ++++++++++++++++++++++++++
 include/linux/page-flags.h         |    8 +-------
 mm/hugetlb.c                       |    2 +-
 mm/mempolicy.c                     |    2 +-
 mm/page_alloc.c                    |    6 +++---
 mm/vmscan.c                        |    6 +++---
 7 files changed, 38 insertions(+), 15 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -5,6 +5,15 @@
 
 #include <linux/fs.h>
 #include <linux/rmap.h>
+#include <linux/page-flags.h>
+
+#define PG_active	PG_reclaim1
+
+#define PageActive(page)	test_bit(PG_active, &(page)->flags)
+#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
+#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
+#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
+#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
 
 static inline void page_replace_hint_active(struct page *page)
 {
@@ -135,6 +144,23 @@ static inline void __page_replace_rotate
 	}
 }
 
+static inline void page_replace_copy_state(struct page *dpage, struct page *spage)
+{
+	if (PageActive(spage))
+		SetPageActive(dpage);
+}
+
+static inline void page_replace_clear_state(struct page *page)
+{
+	if (PageActive(page))
+		ClearPageActive(page);
+}
+
+static inline int page_replace_is_active(struct page *page)
+{
+	return PageActive(page);
+}
+
 static inline unsigned long __page_replace_nr_pages(struct zone *zone)
 {
 	return zone->policy.nr_active + zone->policy.nr_inactive;
Index: linux-2.6-git/include/linux/page-flags.h
===================================================================
--- linux-2.6-git.orig/include/linux/page-flags.h
+++ linux-2.6-git/include/linux/page-flags.h
@@ -58,7 +58,7 @@
 
 #define PG_dirty	 	 4
 #define PG_lru			 5
-#define PG_active		 6
+#define PG_reclaim1		 6	/* reserved by the mm reclaim code */
 #define PG_slab			 7	/* slab debug (Suparna wants this) */
 
 #define PG_checked		 8	/* kill me in 2.5.<early>. */
@@ -244,12 +244,6 @@ extern void __mod_page_state_offset(unsi
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
 
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
-#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
-
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
 #define ClearPageSlab(page)	clear_bit(PG_slab, &(page)->flags)
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c
+++ linux-2.6-git/mm/page_alloc.c
@@ -149,7 +149,7 @@ static void bad_page(struct page *page)
 	page->flags &= ~(1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|
-			1 << PG_active	|
+			1 << PG_reclaim1 |
 			1 << PG_dirty	|
 			1 << PG_reclaim |
 			1 << PG_slab    |
@@ -360,7 +360,7 @@ static inline int free_pages_check(struc
 			1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|
-			1 << PG_active	|
+			1 << PG_reclaim1 |
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_swapcache |
@@ -517,7 +517,7 @@ static int prep_new_page(struct page *pa
 			1 << PG_lru	|
 			1 << PG_private	|
 			1 << PG_locked	|
-			1 << PG_active	|
+			1 << PG_reclaim1 |
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_slab    |
Index: linux-2.6-git/mm/hugetlb.c
===================================================================
--- linux-2.6-git.orig/mm/hugetlb.c
+++ linux-2.6-git/mm/hugetlb.c
@@ -152,7 +152,7 @@ static void update_and_free_page(struct 
 	nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id]--;
 	for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
+				1 << PG_dirty | 1 << PG_reclaim1 | 1 << PG_reserved |
 				1 << PG_private | 1<< PG_writeback);
 		set_page_count(&page[i], 0);
 	}
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -93,6 +93,9 @@ extern void page_replace_shrink(struct z
 /* void page_replace_mark_accessed(struct page *); */
 /* void page_replace_remove(struct zone *, struct page *); */
 /* void __page_replace_rotate_reclaimable(struct zone *, struct page *); */
+/* void page_replace_copy_state(struct page *, struct page *); */
+/* void page_replace_clear_state(struct page *); */
+/* int page_replace_is_active(struct page *); */
 extern void page_replace_show(struct zone *);
 extern void page_replace_zoneinfo(struct zone *, struct seq_file *);
 extern void __page_replace_counts(unsigned long *, unsigned long *,
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -484,6 +484,7 @@ int shrink_list(struct list_head *page_l
 			goto keep_locked;
 
 free_it:
+		page_replace_clear_state(page);
 		unlock_page(page);
 		reclaimed++;
 		if (!pagevec_add(&freed_pvec, page))
@@ -668,12 +669,11 @@ void migrate_page_copy(struct page *newp
 		SetPageReferenced(newpage);
 	if (PageUptodate(page))
 		SetPageUptodate(newpage);
-	if (PageActive(page))
-		SetPageActive(newpage);
 	if (PageChecked(page))
 		SetPageChecked(newpage);
 	if (PageMappedToDisk(page))
 		SetPageMappedToDisk(newpage);
+	page_replace_copy_state(newpage, page);
 
 	if (PageDirty(page)) {
 		clear_page_dirty_for_io(page);
@@ -681,8 +681,8 @@ void migrate_page_copy(struct page *newp
  	}
 
 	ClearPageSwapCache(page);
-	ClearPageActive(page);
 	ClearPagePrivate(page);
+	page_replace_clear_state(page);
 	set_page_private(page, 0);
 	page->mapping = NULL;
 
Index: linux-2.6-git/mm/mempolicy.c
===================================================================
--- linux-2.6-git.orig/mm/mempolicy.c
+++ linux-2.6-git/mm/mempolicy.c
@@ -1774,7 +1774,7 @@ static void gather_stats(struct page *pa
 	if (PageSwapCache(page))
 		md->swapcache++;
 
-	if (PageActive(page))
+	if (page_replace_is_active(page))
 		md->active++;
 
 	if (PageWriteback(page))
