Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUCGBxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUCGBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 20:53:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:6125 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261739AbUCGBxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 20:53:15 -0500
Date: Sun, 7 Mar 2004 01:53:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Matthieu Castet <castetm@ensimag.imag.fr>, <mulix@mulix.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] [Bug 2219] kernel BUG at mm/rmap.c:306
In-Reply-To: <476870000.1077983073@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0403070128510.6488-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fork's dup_mmap leaves child mm_rb as copied from parent mm while doing
all the copy_page_ranges, and then calls build_mmap_rb without holding
page_table_lock.  try_to_unmap_one's find_vma (holding page_table_lock
not mmap_sem) coming on another cpu may cause mm mayhem.  It may leave
the child's mmap_cache pointing to a vma of the parent mm.  When parent
exits and child faults, quite what happens rather depends on what junk
then inhabits vm_page_prot, which gets set in the page table, with
page_add_rmap adding the ptep, but junk pte likely to fail the tests
for page_remove_rmap.  Eventually child exits, page table is freed,
try_to_unmap_one oopses on null ptep_to_mm (but in a kernel with rss
limiting, usually page_referenced hits the null ptep_to_mm first).

This took me days and days to unravel!
Big thanks to Matthieu for reporting it with a good test case.
Patch below against 2.6.4-rc2, in case you want to rush it to Linus.
Sorry, I've not updated the Bugzilla 2219 entry at all.

Hugh

--- 2.6.4-rc2/include/linux/mm.h	2004-03-04 12:05:05.000000000 +0000
+++ linux/include/linux/mm.h	2004-03-06 22:13:56.829496520 +0000
@@ -530,7 +530,8 @@
 
 /* mmap.c */
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void build_mmap_rb(struct mm_struct *);
+extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
+	struct rb_node **, struct rb_node *);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- 2.6.4-rc2/kernel/fork.c	2004-03-04 12:05:06.000000000 +0000
+++ linux/kernel/fork.c	2004-03-06 22:13:56.865491048 +0000
@@ -265,6 +265,7 @@
 static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
+	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge = 0;
 
@@ -277,6 +278,9 @@
 	mm->map_count = 0;
 	mm->rss = 0;
 	cpus_clear(mm->cpu_vm_mask);
+	mm->mm_rb = RB_ROOT;
+	rb_link = &mm->mm_rb.rb_node;
+	rb_parent = NULL;
 	pprev = &mm->mmap;
 
 	/*
@@ -324,11 +328,17 @@
 
 		/*
 		 * Link in the new vma and copy the page table entries:
-		 * link in first so that swapoff can see swap entries.
+		 * link in first so that swapoff can see swap entries,
+		 * and try_to_unmap_one's find_vma find the new vma.
 		 */
 		spin_lock(&mm->page_table_lock);
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
+
+		__vma_link_rb(mm, tmp, rb_link, rb_parent);
+		rb_link = &tmp->vm_rb.rb_right;
+		rb_parent = &tmp->vm_rb;
+
 		mm->map_count++;
 		retval = copy_page_range(mm, current->mm, tmp);
 		spin_unlock(&mm->page_table_lock);
@@ -340,7 +350,6 @@
 			goto fail;
 	}
 	retval = 0;
-	build_mmap_rb(mm);
 
 out:
 	flush_tlb_mm(current->mm);
--- 2.6.4-rc2/mm/mmap.c	2004-03-04 12:05:07.000000000 +0000
+++ linux/mm/mmap.c	2004-03-06 22:13:56.912483904 +0000
@@ -222,8 +222,8 @@
 	}
 }
 
-static void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct rb_node **rb_link, struct rb_node *rb_parent)
+void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
+		struct rb_node **rb_link, struct rb_node *rb_parent)
 {
 	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
 	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
@@ -1404,22 +1404,6 @@
 
 EXPORT_SYMBOL(do_brk);
 
-/* Build the RB tree corresponding to the VMA list. */
-void build_mmap_rb(struct mm_struct * mm)
-{
-	struct vm_area_struct * vma;
-	struct rb_node ** rb_link, * rb_parent;
-
-	mm->mm_rb = RB_ROOT;
-	rb_link = &mm->mm_rb.rb_node;
-	rb_parent = NULL;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		__vma_link_rb(mm, vma, rb_link, rb_parent);
-		rb_parent = &vma->vm_rb;
-		rb_link = &rb_parent->rb_right;
-	}
-}
-
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {

