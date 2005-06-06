Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVFFUAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVFFUAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVFFT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:58:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57363 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261657AbVFFTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:55:24 -0400
Date: Mon, 6 Jun 2005 20:55:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] get_user_pages: kill get_page_map
Message-ID: <Pine.LNX.4.61.0506062054170.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:54:30.0933 (UTC) 
    FILETIME=[8DC7FC50:01C56AD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since its birth, get_user_pages has been calling a misguided get_page_map
function.  follow_page has already returned NULL if the pfn is invalid,
we cannot reach an invalid pfn from a validated struct page.

Remove get_page_map, and the messy rewind in get_user_pages to cope with
its failure.  Oh, and could we please call that "struct page *page" like
everywhere else, instead of "struct page *map"?

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |   45 ++++++++++-----------------------------------
 1 files changed, 10 insertions(+), 35 deletions(-)

--- 2.6.12-rc6/mm/memory.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/memory.c	2005-06-04 20:41:55.000000000 +0100
@@ -840,23 +840,8 @@ check_user_page_readable(struct mm_struc
 {
 	return __follow_page(mm, address, /*read*/1, /*write*/0) != NULL;
 }
-
 EXPORT_SYMBOL(check_user_page_readable);
 
-/* 
- * Given a physical address, is there a useful struct page pointing to
- * it?  This may become more complex in the future if we start dealing
- * with IO-aperture pages for direct-IO.
- */
-
-static inline struct page *get_page_map(struct page *page)
-{
-	if (!pfn_valid(page_to_pfn(page)))
-		return NULL;
-	return page;
-}
-
-
 static inline int
 untouched_anonymous_page(struct mm_struct* mm, struct vm_area_struct *vma,
 			 unsigned long address)
@@ -887,7 +872,6 @@ untouched_anonymous_page(struct mm_struc
 	return 0;
 }
 
-
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -951,21 +935,21 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
-			struct page *map;
+			struct page *page;
 			int lookup_write = write;
 
 			cond_resched_lock(&mm->page_table_lock);
-			while (!(map = follow_page(mm, start, lookup_write))) {
+			while (!(page = follow_page(mm, start, lookup_write))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
-				 * insanly big anonymously mapped areas that
+				 * insanely big anonymously mapped areas that
 				 * nobody touched so far. This is important
 				 * for doing a core dump for these mappings.
 				 */
 				if (!lookup_write &&
 				    untouched_anonymous_page(mm,vma,start)) {
-					map = ZERO_PAGE(start);
+					page = ZERO_PAGE(start);
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
@@ -994,30 +978,21 @@ int get_user_pages(struct task_struct *t
 				spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {
-				pages[i] = get_page_map(map);
-				if (!pages[i]) {
-					spin_unlock(&mm->page_table_lock);
-					while (i--)
-						page_cache_release(pages[i]);
-					i = -EFAULT;
-					goto out;
-				}
-				flush_dcache_page(pages[i]);
-				if (!PageReserved(pages[i]))
-					page_cache_get(pages[i]);
+				pages[i] = page;
+				flush_dcache_page(page);
+				if (!PageReserved(page))
+					page_cache_get(page);
 			}
 			if (vmas)
 				vmas[i] = vma;
 			i++;
 			start += PAGE_SIZE;
 			len--;
-		} while(len && start < vma->vm_end);
+		} while (len && start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
-	} while(len);
-out:
+	} while (len);
 	return i;
 }
-
 EXPORT_SYMBOL(get_user_pages);
 
 static int zeromap_pte_range(struct mm_struct *mm, pmd_t *pmd,
