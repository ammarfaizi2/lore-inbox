Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVL3Wk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVL3Wk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVL3Wk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:40:28 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.19]:4154 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751187AbVL3Wk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:40:27 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224002.765.28812.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 01/14] page-replace-single-batch-insert.patch
Date: Fri, 30 Dec 2005 23:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

page-replace interface function:
  __page_replace_insert()

This function inserts a page into the page replace data structure.

Unify the active and inactive per cpu page lists. For now provide insertion
hints using the LRU specific page flags.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 fs/exec.c                       |    3 +-
 include/linux/mm_page_replace.h |   12 ++++++++++
 include/linux/swap.h            |    2 -
 mm/Makefile                     |    2 -
 mm/memory.c                     |    9 +++++--
 mm/page_replace.c               |   11 +++++++++
 mm/swap.c                       |   47 +---------------------------------------
 mm/swap_state.c                 |    3 +-
 8 files changed, 36 insertions(+), 53 deletions(-)

Index: linux-2.6-git/fs/exec.c
===================================================================
--- linux-2.6-git.orig/fs/exec.c
+++ linux-2.6-git/fs/exec.c
@@ -321,7 +321,8 @@ void install_arg_page(struct vm_area_str
 		goto out;
 	}
 	inc_mm_counter(mm, anon_rss);
-	lru_cache_add_active(page);
+	SetPageActive(page);
+	lru_cache_add(page);
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, vma, address);
Index: linux-2.6-git/include/linux/swap.h
===================================================================
--- linux-2.6-git.orig/include/linux/swap.h
+++ linux-2.6-git/include/linux/swap.h
@@ -163,8 +163,6 @@ extern unsigned int nr_free_pagecache_pa
 
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
-extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
Index: linux-2.6-git/mm/memory.c
===================================================================
--- linux-2.6-git.orig/mm/memory.c
+++ linux-2.6-git/mm/memory.c
@@ -1497,7 +1497,8 @@ gotten:
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
-		lru_cache_add_active(new_page);
+		SetPageActive(new_page);
+		lru_cache_add(new_page);
 		page_add_anon_rmap(new_page, vma, address);
 
 		/* Free the old page.. */
@@ -1953,7 +1954,8 @@ static int do_anonymous_page(struct mm_s
 		if (!pte_none(*page_table))
 			goto release;
 		inc_mm_counter(mm, anon_rss);
-		lru_cache_add_active(page);
+		SetPageActive(page);
+		lru_cache_add(page);
 		SetPageReferenced(page);
 		page_add_anon_rmap(page, vma, address);
 	} else {
@@ -2085,7 +2087,8 @@ retry:
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
-			lru_cache_add_active(new_page);
+			SetPageActive(new_page);
+			lru_cache_add(new_page);
 			page_add_anon_rmap(new_page, vma, address);
 		} else {
 			inc_mm_counter(mm, file_rss);
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -30,6 +30,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
+#include <linux/mm_page_replace.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -134,7 +135,6 @@ EXPORT_SYMBOL(mark_page_accessed);
  * @page: the page to add
  */
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
-static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
 
 void fastcall lru_cache_add(struct page *page)
 {
@@ -146,25 +146,12 @@ void fastcall lru_cache_add(struct page 
 	put_cpu_var(lru_add_pvecs);
 }
 
-void fastcall lru_cache_add_active(struct page *page)
-{
-	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
-
-	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add_active(pvec);
-	put_cpu_var(lru_add_active_pvecs);
-}
-
 void lru_add_drain(void)
 {
 	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
 
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &__get_cpu_var(lru_add_active_pvecs);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
 	put_cpu_var(lru_add_pvecs);
 }
 
@@ -301,7 +288,7 @@ void __pagevec_lru_add(struct pagevec *p
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		add_page_to_inactive_list(zone, page);
+		__page_replace_insert(zone, page);
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
@@ -311,33 +298,6 @@ void __pagevec_lru_add(struct pagevec *p
 
 EXPORT_SYMBOL(__pagevec_lru_add);
 
-void __pagevec_lru_add_active(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestSetPageLRU(page))
-			BUG();
-		if (TestSetPageActive(page))
-			BUG();
-		add_page_to_active_list(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
-	pagevec_reinit(pvec);
-}
-
 /*
  * Try to drop buffers from the pages in a pagevec
  */
@@ -419,9 +379,6 @@ static void lru_drain_cache(unsigned int
 	/* CPU is dead, so no locking needed. */
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &per_cpu(lru_add_active_pvecs, cpu);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
 }
 
 /* Drop the CPU's cached committed space back into the central pool. */
Index: linux-2.6-git/mm/swap_state.c
===================================================================
--- linux-2.6-git.orig/mm/swap_state.c
+++ linux-2.6-git/mm/swap_state.c
@@ -353,7 +353,8 @@ struct page *read_swap_cache_async(swp_e
 			/*
 			 * Initiate read into locked page and return.
 			 */
-			lru_cache_add_active(new_page);
+			SetPageActive(new_page);
+			lru_cache_add(new_page);
 			swap_readpage(NULL, new_page);
 			return new_page;
 		}
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -0,0 +1,12 @@
+#ifndef _LINUX_MM_PAGE_REPLACE_H
+#define _LINUX_MM_PAGE_REPLACE_H
+
+#ifdef __KERNEL__
+
+#include <linux/mmzone.h>
+#include <linux/mm.h>
+
+void __page_replace_insert(struct zone *, struct page *);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_PAGE_REPLACE_H */
Index: linux-2.6-git/mm/page_replace.c
===================================================================
--- /dev/null
+++ linux-2.6-git/mm/page_replace.c
@@ -0,0 +1,11 @@
+#include <linux/mm_page_replace.h>
+#include <linux/mm_inline.h>
+
+
+void __page_replace_insert(struct zone *zone, struct page *page)
+{
+	if (PageActive(page))
+		add_page_to_active_list(zone, page);
+	else
+		add_page_to_inactive_list(zone, page);
+}
Index: linux-2.6-git/mm/Makefile
===================================================================
--- linux-2.6-git.orig/mm/Makefile
+++ linux-2.6-git/mm/Makefile
@@ -10,7 +10,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
-			   prio_tree.o $(mmu-y)
+			   prio_tree.o page_replace.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
