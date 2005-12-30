Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVL3Wqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVL3Wqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVL3Wqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:46:52 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:63042 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S964887AbVL3Wn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:43:26 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224302.765.54845.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 5/9] clockpro-ignore_token.patch
Date: Fri, 30 Dec 2005 23:43:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Re-introduce the ignore_token argument to page_referenced(); hand hot
rotation will make use of this feature.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
 
 include/linux/rmap.h |    4 ++--
 mm/page_replace.c    |    2 +-
 mm/rmap.c            |   26 ++++++++++++++++----------
 mm/vmscan.c          |    2 +-
 4 files changed, 20 insertions(+), 14 deletions(-)

Index: linux-2.6-git-2/include/linux/rmap.h
===================================================================
--- linux-2.6-git-2.orig/include/linux/rmap.h
+++ linux-2.6-git-2/include/linux/rmap.h
@@ -89,7 +89,7 @@ static inline void page_dup_rmap(struct 
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int page_referenced(struct page *, int is_locked);
+int page_referenced(struct page *, int is_locked, int ignore_token);
 int try_to_unmap(struct page *);
 
 /*
@@ -109,7 +109,7 @@ unsigned long page_address_in_vma(struct
 #define anon_vma_prepare(vma)	(0)
 #define anon_vma_link(vma)	do {} while (0)
 
-#define page_referenced(page,l) TestClearPageReferenced(page)
+#define page_referenced(page,l,i) TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 
 #endif	/* CONFIG_MMU */
Index: linux-2.6-git-2/mm/page_replace.c
===================================================================
--- linux-2.6-git-2.orig/mm/page_replace.c
+++ linux-2.6-git-2/mm/page_replace.c
@@ -232,7 +232,7 @@ static void refill_inactive_zone(struct 
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0)) {
+			    page_referenced(page, 0, 0)) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}
Index: linux-2.6-git-2/mm/rmap.c
===================================================================
--- linux-2.6-git-2.orig/mm/rmap.c
+++ linux-2.6-git-2/mm/rmap.c
@@ -290,7 +290,7 @@ pte_t *page_check_address(struct page *p
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-	struct vm_area_struct *vma, unsigned int *mapcount)
+	struct vm_area_struct *vma, unsigned int *mapcount, int ignore_token)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -311,7 +311,7 @@ static int page_referenced_one(struct pa
 
 	/* Pretend the page is referenced if the task has the
 	   swap token and is in the middle of a page fault. */
-	if (mm != current->mm && has_swap_token(mm) &&
+	if (mm != current->mm && !ignore_token && has_swap_token(mm) &&
 			rwsem_is_locked(&mm->mmap_sem))
 		referenced++;
 
@@ -321,7 +321,7 @@ out:
 	return referenced;
 }
 
-static int page_referenced_anon(struct page *page)
+static int page_referenced_anon(struct page *page, int ignore_token)
 {
 	unsigned int mapcount;
 	struct anon_vma *anon_vma;
@@ -334,7 +334,8 @@ static int page_referenced_anon(struct p
 
 	mapcount = page_mapcount(page);
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		referenced += page_referenced_one(page, vma, &mapcount);
+		referenced += page_referenced_one(page, vma, &mapcount,
+							ignore_token);
 		if (!mapcount)
 			break;
 	}
@@ -353,7 +354,7 @@ static int page_referenced_anon(struct p
  *
  * This function is only called from page_referenced for object-based pages.
  */
-static int page_referenced_file(struct page *page)
+static int page_referenced_file(struct page *page, int ignore_token)
 {
 	unsigned int mapcount;
 	struct address_space *mapping = page->mapping;
@@ -391,7 +392,8 @@ static int page_referenced_file(struct p
 			referenced++;
 			break;
 		}
-		referenced += page_referenced_one(page, vma, &mapcount);
+		referenced += page_referenced_one(page, vma, &mapcount,
+							ignore_token);
 		if (!mapcount)
 			break;
 	}
@@ -408,10 +410,13 @@ static int page_referenced_file(struct p
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
 
@@ -420,14 +425,15 @@ int page_referenced(struct page *page, i
 
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
Index: linux-2.6-git-2/mm/vmscan.c
===================================================================
--- linux-2.6-git-2.orig/mm/vmscan.c
+++ linux-2.6-git-2/mm/vmscan.c
@@ -352,7 +352,7 @@ static try_pageout_t try_pageout(struct 
 	if (PageWriteback(page))
 		goto keep_locked;
 
-	referenced = page_referenced(page, 1);
+	referenced = page_referenced(page, 1, 0);
 
 		if (referenced)
 		goto activate_locked;
