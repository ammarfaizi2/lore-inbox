Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVIYPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVIYPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVIYPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:54:25 -0400
Received: from silver.veritas.com ([143.127.12.111]:38326 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932234AbVIYPyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:54:24 -0400
Date: Sun, 25 Sep 2005 16:53:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] mm: unlink_file_vma, remove_vma
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251653180.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:54:23.0759 (UTC) FILETIME=[6649F1F0:01C5C1E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Divide remove_vm_struct into two parts: first anon_vma_unlink plus
unlink_file_vma, to unlink the vma from the list and tree by which rmap
or vmtruncate might find it; then remove_vma to close, fput and free.

The intention here is to do the anon_vma_unlink and unlink_file_vma
earlier, in free_pgtables before freeing any page tables: so we can be
sure that any page tables traversed by rmap and vmtruncate are stable
(and other, ordinary cases are stabilized by holding mmap_sem).

This will be crucial to traversing pgd,pud,pmd without page_table_lock.
But testing the split-out patch showed that lifting the page_table_lock
is symbiotically necessary to make this change - the lock ordering is
wrong to move those unlinks into free_pgtables while it's under ptlock.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/mm.h |    1 +
 mm/mmap.c          |   41 +++++++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 14 deletions(-)

--- mm07/include/linux/mm.h	2005-09-24 19:27:33.000000000 +0100
+++ mm08/include/linux/mm.h	2005-09-24 19:28:01.000000000 +0100
@@ -840,6 +840,7 @@ extern int split_vma(struct mm_struct *,
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
+extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff);
 extern void exit_mmap(struct mm_struct *);
--- mm07/mm/mmap.c	2005-09-24 19:27:47.000000000 +0100
+++ mm08/mm/mmap.c	2005-09-24 19:28:01.000000000 +0100
@@ -177,26 +177,44 @@ static void __remove_shared_vm_struct(st
 }
 
 /*
- * Remove one vm structure and free it.
+ * Unlink a file-based vm structure from its prio_tree, to hide
+ * vma from rmap and vmtruncate before freeing its page tables.
  */
-static void remove_vm_struct(struct vm_area_struct *vma)
+void unlink_file_vma(struct vm_area_struct *vma)
 {
 	struct file *file = vma->vm_file;
 
-	might_sleep();
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 		spin_lock(&mapping->i_mmap_lock);
 		__remove_shared_vm_struct(vma, file, mapping);
 		spin_unlock(&mapping->i_mmap_lock);
 	}
+}
+
+/*
+ * Close a vm structure and free it, returning the next.
+ */
+static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+{
+	struct vm_area_struct *next = vma->vm_next;
+
+	/*
+	 * Hide vma from rmap and vmtruncate before freeing page tables:
+	 * to be moved into free_pgtables once page_table_lock is lifted
+	 * from it, but until then lock ordering forbids that move.
+	 */
+	anon_vma_unlink(vma);
+	unlink_file_vma(vma);
+
+	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
-	if (file)
-		fput(file);
-	anon_vma_unlink(vma);
+	if (vma->vm_file)
+		fput(vma->vm_file);
 	mpol_free(vma_policy(vma));
 	kmem_cache_free(vm_area_cachep, vma);
+	return next;
 }
 
 asmlinkage unsigned long sys_brk(unsigned long brk)
@@ -1608,15 +1626,13 @@ find_extend_vma(struct mm_struct * mm, u
 static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	do {
-		struct vm_area_struct *next = vma->vm_next;
 		long nrpages = vma_pages(vma);
 
 		mm->total_vm -= nrpages;
 		if (vma->vm_flags & VM_LOCKED)
 			mm->locked_vm -= nrpages;
 		vm_stat_account(mm, vma->vm_flags, vma->vm_file, -nrpages);
-		remove_vm_struct(vma);
-		vma = next;
+		vma = remove_vma(vma);
 	} while (vma);
 	validate_mm(mm);
 }
@@ -1940,11 +1956,8 @@ void exit_mmap(struct mm_struct *mm)
 	 * Walk the list again, actually closing and freeing it
 	 * without holding any MM locks.
 	 */
-	while (vma) {
-		struct vm_area_struct *next = vma->vm_next;
-		remove_vm_struct(vma);
-		vma = next;
-	}
+	while (vma)
+		vma = remove_vma(vma);
 
 	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
