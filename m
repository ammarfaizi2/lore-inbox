Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUGLV6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUGLV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUGLV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:56:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4977 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263804AbUGLVz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:55:26 -0400
Date: Mon, 12 Jul 2004 22:55:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmaplock 6/6 swapoff use anon_vma
In-Reply-To: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407122254291.4005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swapoff can make good use of a page's anon_vma and index, while it's
still left in swapcache, or once it's brought back in and the first pte
mapped back: unuse_vma go directly to just one page of only those vmas
with the same anon_vma.  And unuse_process can skip any vmas without an
anon_vma (extending the hugetlb check: hugetlb vmas have no anon_vma).

This just hacks in on top of the existing procedure, still going through
all the vmas of all the mms in mmlist.  A more elegant procedure might
replace mmlist by a list of anon_vmas: but that would be more work to
implement, with apparently more overhead in the common paths.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 include/linux/rmap.h |    5 +++++
 mm/rmap.c            |   20 ++++++++++++++++++++
 mm/swapfile.c        |   23 ++++++++++++++++-------
 3 files changed, 41 insertions(+), 7 deletions(-)

--- rmaplock5/include/linux/rmap.h	2004-07-12 18:20:22.333796048 +0100
+++ rmaplock6/include/linux/rmap.h	2004-07-12 18:21:16.752523144 +0100
@@ -91,6 +91,11 @@ static inline void page_dup_rmap(struct 
 int page_referenced(struct page *, int is_locked);
 int try_to_unmap(struct page *);
 
+/*
+ * Used by swapoff to help locate where page is expected in vma.
+ */
+unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
+
 #else	/* !CONFIG_MMU */
 
 #define anon_vma_init()		do {} while (0)
--- rmaplock5/mm/rmap.c	2004-07-12 18:21:02.456696440 +0100
+++ rmaplock6/mm/rmap.c	2004-07-12 18:21:16.767520864 +0100
@@ -231,6 +231,24 @@ vma_address(struct page *page, struct vm
 }
 
 /*
+ * At what user virtual address is page expected in vma? checking that the
+ * page matches the vma: currently only used by unuse_process, on anon pages.
+ */
+unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
+{
+	if (PageAnon(page)) {
+		if ((void *)vma->anon_vma !=
+		    (void *)page->mapping - PAGE_MAPPING_ANON)
+			return -EFAULT;
+	} else if (page->mapping && !(vma->vm_flags & VM_NONLINEAR)) {
+		if (vma->vm_file->f_mapping != page->mapping)
+			return -EFAULT;
+	} else
+		return -EFAULT;
+	return vma_address(page, vma);
+}
+
+/*
  * Subfunctions of page_referenced: page_referenced_one called
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
@@ -457,6 +475,8 @@ void page_remove_rmap(struct page *page)
 		 * which increments mapcount after us but sets mapping
 		 * before us: so leave the reset to free_hot_cold_page,
 		 * and remember that it's only reliable while mapped.
+		 * Leaving it set also helps swapoff to reinstate ptes
+		 * faster for those pages still in swapcache.
 		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
--- rmaplock5/mm/swapfile.c	2004-07-12 18:21:02.458696136 +0100
+++ rmaplock6/mm/swapfile.c	2004-07-12 18:21:16.769520560 +0100
@@ -520,14 +520,24 @@ static unsigned long unuse_pgd(struct vm
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
+static unsigned long unuse_vma(struct vm_area_struct * vma,
 	swp_entry_t entry, struct page *page)
 {
-	unsigned long start = vma->vm_start, end = vma->vm_end;
+	pgd_t *pgdir;
+	unsigned long start, end;
 	unsigned long foundaddr;
 
-	if (start >= end)
-		BUG();
+	if (page->mapping) {
+		start = page_address_in_vma(page, vma);
+		if (start == -EFAULT)
+			return 0;
+		else
+			end = start + PAGE_SIZE;
+	} else {
+		start = vma->vm_start;
+		end = vma->vm_end;
+	}
+	pgdir = pgd_offset(vma->vm_mm, start);
 	do {
 		foundaddr = unuse_pgd(vma, pgdir, start, end - start,
 						entry, page);
@@ -559,9 +569,8 @@ static int unuse_process(struct mm_struc
 	}
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (!is_vm_hugetlb_page(vma)) {
-			pgd_t * pgd = pgd_offset(mm, vma->vm_start);
-			foundaddr = unuse_vma(vma, pgd, entry, page);
+		if (vma->anon_vma) {
+			foundaddr = unuse_vma(vma, entry, page);
 			if (foundaddr)
 				break;
 		}

