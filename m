Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUDSRvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDSRvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:51:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50431 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261628AbUDSRvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:51:37 -0400
Date: Mon, 19 Apr 2004 18:51:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] dontneed nonlinear
Message-ID: <Pine.LNX.4.44.0404191848200.30692-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie points out that madvise(MADV_DONTNEED) should unmap pages from a
nonlinear area in such a way that the nonlinear offsets are preserved if
the pages do turn out to be needed later after all, instead of reverting
them to linearity: needs to pass down a zap_details block.

(But this still leaves mincore unaware of nonlinear vmas: bigger job.)

--- 2.6.6-rc1-bk4/include/linux/mm.h	2004-04-19 15:29:38.808606600 +0100
+++ linux/include/linux/mm.h	2004-04-19 16:15:16.925349584 +0100
@@ -439,7 +439,16 @@ struct file *shmem_file_setup(char * nam
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
 
-struct zap_details;
+/*
+ * Parameter block passed down to zap_pte_range in exceptional cases.
+ */
+struct zap_details {
+	struct vm_area_struct *nonlinear_vma;	/* Check page->index if set */
+	struct address_space *check_mapping;	/* Check page->mapping if set */
+	pgoff_t	first_index;			/* Lowest page->index to unmap */
+	pgoff_t last_index;			/* Highest page->index to unmap */
+};
+
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *);
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
--- 2.6.6-rc1-bk4/mm/madvise.c	2004-04-19 15:29:38.896593224 +0100
+++ linux/mm/madvise.c	2004-04-19 16:42:15.197334848 +0100
@@ -92,10 +92,19 @@ static long madvise_willneed(struct vm_a
 static long madvise_dontneed(struct vm_area_struct * vma,
 			     unsigned long start, unsigned long end)
 {
+	struct zap_details details;
+
 	if (vma->vm_flags & VM_LOCKED)
 		return -EINVAL;
 
-	zap_page_range(vma, start, end - start, NULL);
+	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+		details.check_mapping = NULL;
+		details.nonlinear_vma = vma;
+		details.first_index = 0;
+		details.last_index = ULONG_MAX;
+		zap_page_range(vma, start, end - start, &details);
+	} else
+		zap_page_range(vma, start, end - start, NULL);
 	return 0;
 }
 
--- 2.6.6-rc1-bk4/mm/memory.c	2004-04-19 15:29:38.902592312 +0100
+++ linux/mm/memory.c	2004-04-19 16:15:16.000000000 +0100
@@ -384,16 +384,6 @@ nomem:
 	return -ENOMEM;
 }
 
-/*
- * Parameter block passed down to zap_pte_range in exceptional cases.
- */
-struct zap_details {
-	struct vm_area_struct *nonlinear_vma;	/* Check page->index if set */
-	struct address_space *check_mapping;	/* Check page->mapping if set */
-	pgoff_t	first_index;			/* Lowest page->index to unmap */
-	pgoff_t last_index;			/* Highest page->index to unmap */
-};
-
 static void zap_pte_range(struct mmu_gather *tlb,
 		pmd_t *pmd, unsigned long address,
 		unsigned long size, struct zap_details *details)

