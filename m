Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263642AbUERWJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUERWJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUERWJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:09:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23255 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263642AbUERWJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:09:02 -0400
Date: Tue, 18 May 2004 23:08:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 37 page_add_anon_rmap vma
In-Reply-To: <Pine.LNX.4.44.0405182304150.3416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405182308050.3416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silly final patch for anonmm rmap: change page_add_anon_rmap's mm arg
to vma arg like anon_vma rmap, to smooth the transition between them.

 fs/exec.c            |    2 +-
 include/linux/rmap.h |    5 ++++-
 mm/memory.c          |    8 ++++----
 mm/rmap.c            |    6 +++---
 mm/swapfile.c        |    2 +-
 5 files changed, 13 insertions(+), 10 deletions(-)

--- rmap36/fs/exec.c	2004-05-16 11:39:24.000000000 +0100
+++ rmap37/fs/exec.c	2004-05-18 20:51:12.074665480 +0100
@@ -320,7 +320,7 @@ void install_arg_page(struct vm_area_str
 	lru_cache_add_active(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
-	page_add_anon_rmap(page, mm, address);
+	page_add_anon_rmap(page, vma, address);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 
--- rmap36/include/linux/rmap.h	2004-05-16 11:39:23.000000000 +0100
+++ rmap37/include/linux/rmap.h	2004-05-18 20:51:12.099661680 +0100
@@ -14,7 +14,10 @@
 
 #ifdef CONFIG_MMU
 
-void page_add_anon_rmap(struct page *, struct mm_struct *, unsigned long);
+/*
+ * rmap interfaces called when adding or removing pte of page
+ */
+void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
 void page_remove_rmap(struct page *);
 
--- rmap36/mm/memory.c	2004-05-16 11:39:23.000000000 +0100
+++ rmap37/mm/memory.c	2004-05-18 20:51:12.101661376 +0100
@@ -1099,7 +1099,7 @@ static int do_wp_page(struct mm_struct *
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
-		page_add_anon_rmap(new_page, mm, address);
+		page_add_anon_rmap(new_page, vma, address);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1377,7 +1377,7 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	page_add_anon_rmap(page, mm, address);
+	page_add_anon_rmap(page, vma, address);
 
 	if (write_access || mremap_moved_anon_rmap(page, address)) {
 		if (do_wp_page(mm, vma, address,
@@ -1436,7 +1436,7 @@ do_anonymous_page(struct mm_struct *mm, 
 				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
-		page_add_anon_rmap(page, mm, addr);
+		page_add_anon_rmap(page, vma, addr);
 	}
 
 	set_pte(page_table, entry);
@@ -1543,7 +1543,7 @@ retry:
 		set_pte(page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
-			page_add_anon_rmap(new_page, mm, address);
+			page_add_anon_rmap(new_page, vma, address);
 		} else
 			page_add_file_rmap(new_page);
 		pte_unmap(page_table);
--- rmap36/mm/rmap.c	2004-05-16 11:39:23.000000000 +0100
+++ rmap37/mm/rmap.c	2004-05-18 20:51:12.103661072 +0100
@@ -365,15 +365,15 @@ int page_referenced(struct page *page)
 /**
  * page_add_anon_rmap - add pte mapping to an anonymous page
  * @page:	the page to add the mapping to
- * @mm:		the mm in which the mapping is added
+ * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  *
  * The caller needs to hold the mm->page_table_lock.
  */
 void page_add_anon_rmap(struct page *page,
-	struct mm_struct *mm, unsigned long address)
+	struct vm_area_struct *vma, unsigned long address)
 {
-	struct anonmm *anonmm = mm->anonmm;
+	struct anonmm *anonmm = vma->vm_mm->anonmm;
 
 	BUG_ON(PageReserved(page));
 
--- rmap36/mm/swapfile.c	2004-05-16 11:39:22.000000000 +0100
+++ rmap37/mm/swapfile.c	2004-05-18 20:51:12.104660920 +0100
@@ -433,7 +433,7 @@ unuse_pte(struct vm_area_struct *vma, un
 	vma->vm_mm->rss++;
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	page_add_anon_rmap(page, vma->vm_mm, address);
+	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
 }
 

