Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264186AbUEHVzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbUEHVzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 17:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUEHVzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 17:55:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:1835 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264186AbUEHVzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:55:35 -0400
Date: Sat, 8 May 2004 22:55:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 24 no rmap fastcalls
Message-ID: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a batch of nine miscellaneous minor and mostly small patches,
based on 2.6.6-rc3-mm2: some taken from Andrea's tree (not verbatim:
blame screwups on me); others preparatory work by me, moving slowly
but inexorably towards anon_vma... yet still not getting there.

rmap 24 no rmap fastcalls

I like CONFIG_REGPARM, even when it's forced on: because it's easy to
force off for debugging - easier than editing out scattered fastcalls.
Plus I've never understood why we make function foo a fastcall,
but function bar not.  Remove fastcall directives from rmap.  And
fix comment about mremap_moved race: it only applies to anon pages.

 include/linux/rmap.h |   14 ++++++--------
 mm/rmap.c            |   16 ++++++++--------
 2 files changed, 14 insertions(+), 16 deletions(-)

--- 2.6.6-rc3-mm2/include/linux/rmap.h	2004-05-05 13:29:08.000000000 +0100
+++ rmap24/include/linux/rmap.h	2004-05-08 20:54:32.419571320 +0100
@@ -6,7 +6,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/linkage.h>
 
 #define rmap_lock(page) \
 	bit_spin_lock(PG_maplock, (unsigned long *)&(page)->flags)
@@ -15,10 +14,9 @@
 
 #ifdef CONFIG_MMU
 
-void fastcall page_add_anon_rmap(struct page *,
-		struct mm_struct *, unsigned long addr);
-void fastcall page_add_file_rmap(struct page *);
-void fastcall page_remove_rmap(struct page *);
+void page_add_anon_rmap(struct page *, struct mm_struct *, unsigned long);
+void page_add_file_rmap(struct page *);
+void page_remove_rmap(struct page *);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
@@ -34,7 +32,7 @@ static inline void page_dup_rmap(struct 
 	rmap_unlock(page);
 }
 
-int fastcall mremap_move_anon_rmap(struct page *page, unsigned long addr);
+int mremap_move_anon_rmap(struct page *page, unsigned long addr);
 
 /**
  * mremap_moved_anon_rmap - does new address clash with that noted?
@@ -85,8 +83,8 @@ void exit_rmap(struct mm_struct *);
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int fastcall page_referenced(struct page *);
-int fastcall try_to_unmap(struct page *);
+int page_referenced(struct page *);
+int try_to_unmap(struct page *);
 
 #else	/* !CONFIG_MMU */
 
--- 2.6.6-rc3-mm2/mm/rmap.c	2004-05-05 13:29:08.000000000 +0100
+++ rmap24/mm/rmap.c	2004-05-08 20:54:32.421571016 +0100
@@ -259,8 +259,8 @@ static inline int page_referenced_anon(s
 	}
 
 	/*
-	 * The warning below may appear if page_referenced catches the
-	 * page in between page_add_{anon,file}_rmap and its replacement
+	 * The warning below may appear if page_referenced_anon catches
+	 * the page in between page_add_anon_rmap and its replacement
 	 * demanded by mremap_moved_anon_page: so remove the warning once
 	 * we're convinced that anonmm rmap really is finding its pages.
 	 */
@@ -343,7 +343,7 @@ out:
  * returns the number of ptes which referenced the page.
  * Caller needs to hold the rmap lock.
  */
-int fastcall page_referenced(struct page *page)
+int page_referenced(struct page *page)
 {
 	int referenced = 0;
 
@@ -370,7 +370,7 @@ int fastcall page_referenced(struct page
  *
  * The caller needs to hold the mm->page_table_lock.
  */
-void fastcall page_add_anon_rmap(struct page *page,
+void page_add_anon_rmap(struct page *page,
 	struct mm_struct *mm, unsigned long address)
 {
 	struct anonmm *anonmm = mm->anonmm;
@@ -396,7 +396,7 @@ void fastcall page_add_anon_rmap(struct 
  *
  * The caller needs to hold the mm->page_table_lock.
  */
-void fastcall page_add_file_rmap(struct page *page)
+void page_add_file_rmap(struct page *page)
 {
 	BUG_ON(PageAnon(page));
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
@@ -415,7 +415,7 @@ void fastcall page_add_file_rmap(struct 
  *
  * Caller needs to hold the mm->page_table_lock.
  */
-void fastcall page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page)
 {
 	BUG_ON(PageReserved(page));
 	BUG_ON(!page->mapcount);
@@ -444,7 +444,7 @@ void fastcall page_remove_rmap(struct pa
  * If it is shared, then caller must take a copy of the page instead:
  * not very clever, but too rare a case to merit cleverness.
  */
-int fastcall mremap_move_anon_rmap(struct page *page, unsigned long address)
+int mremap_move_anon_rmap(struct page *page, unsigned long address)
 {
 	int move = 0;
 	if (page->mapcount == 1) {
@@ -797,7 +797,7 @@ out:
  * SWAP_AGAIN	- we missed a trylock, try again later
  * SWAP_FAIL	- the page is unswappable
  */
-int fastcall try_to_unmap(struct page *page)
+int try_to_unmap(struct page *page)
 {
 	int ret;
 

