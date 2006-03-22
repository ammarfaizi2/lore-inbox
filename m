Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932900AbWCVWki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWCVWki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbWCVWkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:40:15 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:18417 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932902AbWCVWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:36:15 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223541.12658.23706.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 27/34] mm: clockpro-ignore_token.patch
Date: Wed, 22 Mar 2006 23:36:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Re-introduce the ignore_token argument to page_referenced(); hand hot
rotation will make use of this feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_use_once_policy.h |    2 +-
 include/linux/rmap.h               |    4 ++--
 mm/rmap.c                          |   26 ++++++++++++++++----------
 mm/useonce.c                       |    2 +-
 4 files changed, 20 insertions(+), 14 deletions(-)

Index: linux-2.6-git/include/linux/rmap.h
===================================================================
--- linux-2.6-git.orig/include/linux/rmap.h
+++ linux-2.6-git/include/linux/rmap.h
@@ -90,7 +90,7 @@ static inline void page_dup_rmap(struct 
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int page_referenced(struct page *, int is_locked);
+int page_referenced(struct page *, int is_locked, int ignore_token);
 int try_to_unmap(struct page *, int ignore_refs);
 void remove_from_swap(struct page *page);
 
@@ -111,7 +111,7 @@ unsigned long page_address_in_vma(struct
 #define anon_vma_prepare(vma)	(0)
 #define anon_vma_link(vma)	do {} while (0)
 
-#define page_referenced(page,l) TestClearPageReferenced(page)
+#define page_referenced(page,l,i) TestClearPageReferenced(page)
 #define try_to_unmap(page, refs) SWAP_FAIL
 
 #endif	/* CONFIG_MMU */
Index: linux-2.6-git/mm/rmap.c
===================================================================
--- linux-2.6-git.orig/mm/rmap.c
+++ linux-2.6-git/mm/rmap.c
@@ -329,7 +329,7 @@ pte_t *page_check_address(struct page *p
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-	struct vm_area_struct *vma, unsigned int *mapcount)
+	struct vm_area_struct *vma, unsigned int *mapcount, int ignore_token)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -350,7 +350,7 @@ static int page_referenced_one(struct pa
 
 	/* Pretend the page is referenced if the task has the
 	   swap token and is in the middle of a page fault. */
-	if (mm != current->mm && has_swap_token(mm) &&
+	if (mm != current->mm && !ignore_token && has_swap_token(mm) &&
 			rwsem_is_locked(&mm->mmap_sem))
 		referenced++;
 
@@ -360,7 +360,7 @@ out:
 	return referenced;
 }
 
-static int page_referenced_anon(struct page *page)
+static int page_referenced_anon(struct page *page, int ignore_token)
 {
 	unsigned int mapcount;
 	struct anon_vma *anon_vma;
@@ -373,7 +373,8 @@ static int page_referenced_anon(struct p
 
 	mapcount = page_mapcount(page);
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		referenced += page_referenced_one(page, vma, &mapcount);
+		referenced += page_referenced_one(page, vma, &mapcount,
+							ignore_token);
 		if (!mapcount)
 			break;
 	}
@@ -392,7 +393,7 @@ static int page_referenced_anon(struct p
  *
  * This function is only called from page_referenced for object-based pages.
  */
-static int page_referenced_file(struct page *page)
+static int page_referenced_file(struct page *page, int ignore_token)
 {
 	unsigned int mapcount;
 	struct address_space *mapping = page->mapping;
@@ -430,7 +431,8 @@ static int page_referenced_file(struct p
 			referenced++;
 			break;
 		}
-		referenced += page_referenced_one(page, vma, &mapcount);
+		referenced += page_referenced_one(page, vma, &mapcount,
+							ignore_token);
 		if (!mapcount)
 			break;
 	}
@@ -447,10 +449,13 @@ static int page_referenced_file(struct p
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of ptes which referenced the page.
  */
-int page_referenced(struct page *page, int is_locked)
+int page_referenced(struct page *page, int is_locked, int ignore_token)
 {
 	int referenced = 0;
 
+	if (!swap_token_default_timeout)
+		ignore_token = 1;
+
 	if (page_test_and_clear_young(page))
 		referenced++;
 
@@ -459,14 +464,15 @@ int page_referenced(struct page *page, i
 
 	if (page_mapped(page) && page->mapping) {
 		if (PageAnon(page))
-			referenced += page_referenced_anon(page);
+			referenced += page_referenced_anon(page, ignore_token);
 		else if (is_locked)
-			referenced += page_referenced_file(page);
+			referenced += page_referenced_file(page, ignore_token);
 		else if (TestSetPageLocked(page))
 			referenced++;
 		else {
 			if (page->mapping)
-				referenced += page_referenced_file(page);
+				referenced += page_referenced_file(page,
+								ignore_token);
 			unlock_page(page);
 		}
 	}
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -312,7 +312,7 @@ refill_inactive_zone(struct zone *zone, 
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0)) {
+			    page_referenced(page, 0, 0)) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}
Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -108,7 +108,7 @@ static inline reclaim_t page_replace_rec
 	if (PageActive(page))
 		BUG();
 
-	referenced = page_referenced(page, 1);
+	referenced = page_referenced(page, 1, 0);
 	/* In active use or really unfreeable?  Activate it. */
 	if (referenced && page_mapping_inuse(page))
 		return RECLAIM_ACTIVATE;
