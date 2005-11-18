Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVKRBDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVKRBDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVKRBDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:03:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15800 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751331AbVKRBDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:03:15 -0500
Date: Thu, 17 Nov 2005 17:03:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051118010313.22328.87781.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
References: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/4] SwapMig: Extend parameters for migrate_pages()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the parameters of migrate_pages() to allow the caller control
over the fate of successfully migrated or impossible to migrate pages.

Swap migration and direct migration will have the same interface after this
patch so that patches can be independently applied to the policy layer
and the core migration code.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc1-mm1.orig/include/linux/swap.h	2005-11-17 16:57:30.000000000 -0800
+++ linux-2.6.15-rc1-mm1/include/linux/swap.h	2005-11-17 16:58:18.000000000 -0800
@@ -179,7 +179,8 @@ extern int vm_swappiness;
 #ifdef CONFIG_MIGRATION
 extern int isolate_lru_page(struct page *p);
 extern int putback_lru_pages(struct list_head *l);
-extern int migrate_pages(struct list_head *l, struct list_head *t);
+extern int migrate_pages(struct list_head *l, struct list_head *t,
+		struct list_head *moved, struct list_head *failed);
 #endif
 
 #ifdef CONFIG_MMU
Index: linux-2.6.15-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/vmscan.c	2005-11-17 16:57:35.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/vmscan.c	2005-11-17 16:57:46.000000000 -0800
@@ -681,10 +681,10 @@ retry:
  * list. The direct migration patchset
  * extends this function to avoid the use of swap.
  */
-int migrate_pages(struct list_head *l, struct list_head *t)
+int migrate_pages(struct list_head *from, struct list_head *to,
+		  struct list_head *moved, struct list_head *failed)
 {
 	int retry;
-	LIST_HEAD(failed);
 	int nr_failed = 0;
 	int pass = 0;
 	struct page *page;
@@ -697,12 +697,12 @@ int migrate_pages(struct list_head *l, s
 redo:
 	retry = 0;
 
-	list_for_each_entry_safe(page, page2, l, lru) {
+	list_for_each_entry_safe(page, page2, from, lru) {
 		cond_resched();
 
 		if (page_count(page) == 1) {
 			/* page was freed from under us. So we are done. */
-			move_to_lru(page);
+			list_move(&page->lru, moved);
 			continue;
 		}
 		/*
@@ -733,7 +733,7 @@ redo:
 		if (PageAnon(page) && !PageSwapCache(page)) {
 			if (!add_to_swap(page, GFP_KERNEL)) {
 				unlock_page(page);
-				list_move(&page->lru, &failed);
+				list_move(&page->lru, failed);
 				nr_failed++;
 				continue;
 			}
@@ -743,8 +743,10 @@ redo:
 		 * Page is properly locked and writeback is complete.
 		 * Try to migrate the page.
 		 */
-		if (!swap_page(page))
+		if (!swap_page(page)) {
+			list_move(&page->lru, moved);
 			continue;
+		}
 retry_later:
 		retry++;
 	}
@@ -754,9 +756,6 @@ retry_later:
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
 
-	if (!list_empty(&failed))
-		list_splice(&failed, l);
-
 	return nr_failed + retry;
 }
 
Index: linux-2.6.15-rc1-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/mempolicy.c	2005-11-17 16:54:24.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/mempolicy.c	2005-11-17 16:57:46.000000000 -0800
@@ -438,6 +438,19 @@ static int contextualize_policy(int mode
 	return mpol_check_policy(mode, nodes);
 }
 
+static int swap_pages(struct list_head *pagelist)
+{
+	LIST_HEAD(moved);
+	LIST_HEAD(failed);
+	int n;
+
+	n = migrate_pages(pagelist, NULL, &moved, &failed);
+	putback_lru_pages(&failed);
+	putback_lru_pages(&moved);
+
+	return n;
+}
+
 long do_mbind(unsigned long start, unsigned long len,
 		unsigned long mode, nodemask_t *nmask, unsigned long flags)
 {
@@ -490,10 +503,13 @@ long do_mbind(unsigned long start, unsig
 	      (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ? &pagelist : NULL);
 	err = PTR_ERR(vma);
 	if (!IS_ERR(vma)) {
+		int nr_failed = 0;
+
 		err = mbind_range(vma, start, end, new);
 		if (!list_empty(&pagelist))
-			migrate_pages(&pagelist, NULL);
-		if (!err && !list_empty(&pagelist) && (flags & MPOL_MF_STRICT))
+			nr_failed = swap_pages(&pagelist);
+
+		if (!err && nr_failed && (flags & MPOL_MF_STRICT))
 			err = -EIO;
 	}
 	if (!list_empty(&pagelist))
@@ -644,11 +660,12 @@ int do_migrate_pages(struct mm_struct *m
 	down_read(&mm->mmap_sem);
 	check_range(mm, mm->mmap->vm_start, TASK_SIZE, &nodes,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+
 	if (!list_empty(&pagelist)) {
-		migrate_pages(&pagelist, NULL);
-		if (!list_empty(&pagelist))
-			count = putback_lru_pages(&pagelist);
+		count = swap_pages(&pagelist);
+		putback_lru_pages(&pagelist);
 	}
+
 	up_read(&mm->mmap_sem);
 	return count;
 }
