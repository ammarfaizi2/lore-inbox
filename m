Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUBSOcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUBSOcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:32:42 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:13983 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S267218AbUBSO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:29:21 -0500
Date: Thu, 19 Feb 2004 09:29:11 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@azure.engin.umich.edu
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, <Linux-MM@kvack.org>
Subject: [PATCH] orphaned ptes -- mremap vs. truncate race
In-Reply-To: <Pine.LNX.4.58.0402162203230.2154@home.osdl.org>
Message-ID: <Pine.SOL.4.44.0402190925280.18144-100000@azure.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Copying and moving page tables can race with invalidate_mmap_range
and leave some orphaned ptes in the target page table unless some
fix is already in place. For extra information about related races
follow the links [1] and [2].

Fork (dup_mmap) copies page tables from an old process to a new
process. In dup_mmap, orphaned ptes due to a race between
copy_page_range and invalidate_mmap_range can be avoided by ordering
the old process's vma and the new process's vma appropriately in
the corresponding i_mmap{_shared} list. This patch does that and
adds a fat comment. This ordering ensures that invalidate_mmap_range
zaps ptes from the old vma before the new vma. This helps to avoid
orphaned ptes.

Currently, mremap does not add the new_vma to the corresponding
i_mmap{_shared} list before copying the page tables. This is racy
and leads to orphaned ptes. You can use the test program in the
link [4] to trigger the race. In my old Quad Pentium II 200Mz 256MB,
I can consistently trigger the race with the test program.

This patch adds the new_vma to the corresponding i_mmap{_shared} list
in appropriate order before moving the page tables. This does not
entirely solve the orphaned ptes problem because in the error path
move_page_tables moves the ptes from the new_vma to the old vma
(i.e., in opposite to the order of those vmas in the i_mmap{_shared}
list). Therefore, to fix orphaned ptes in the error path, this patch
uses the mapping's truncate_count. The fix is ugly and not efficient.
However, truncate race in the error path is _very_ rare. So I think
it is okay to take some performance penalty.

In the error path, this patch ignores nonlinear mappings since
it's my understanding that we do not care about SIGBUS in nonlinear
maps. To find Andrew Morton's take on this follow the link [3].

This patch is for 2.6.3-mm1. The patch is tested minimally.

Let me know of my stupidities and mistakes, if any.

Links:
-----
[1] initial patch for do_no_page() vs. truncate race
    http://marc.theaimsgroup.com/?t=105434202900003

[2] final patch for do_no_page() vs. truncate -- distributed FS
    http://marc.theaimsgroup.com/?t=105544905100001

[3] nonlinear map - truncate - SIGBUS
    http://marc.theaimsgroup.com/?m=106595961920958

[4] Test programs
    http://www-personal.engin.umich.edu/~vrajesh/linux/mremap-truncate/



 include/linux/mm.h |    2 +
 kernel/fork.c      |    9 ++++++-
 mm/mmap.c          |   30 +++++++++++++++++++++-----
 mm/mremap.c        |   60 +++++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 78 insertions(+), 23 deletions(-)

diff -puN kernel/fork.c~mremap_race kernel/fork.c
--- mmlinux-2.6/kernel/fork.c~mremap_race	2004-02-19 00:39:36.000000000 -0500
+++ mmlinux-2.6-jaya/kernel/fork.c	2004-02-19 00:39:36.000000000 -0500
@@ -316,9 +316,14 @@ static inline int dup_mmap(struct mm_str
 			if (tmp->vm_flags & VM_DENYWRITE)
 				atomic_dec(&inode->i_writecount);

-			/* insert tmp into the share list, just after mpnt */
+			/*
+			 * insert tmp into the share list, just after mpnt.
+			 * Note that this order of insertion is important to
+			 * avoid orphaned ptes due to a rare race between
+			 * invalidate_mmap_range and copy_page_range.
+			 */
 			down(&file->f_mapping->i_shared_sem);
-			list_add_tail(&tmp->shared, &mpnt->shared);
+			list_add(&tmp->shared, &mpnt->shared);
 			up(&file->f_mapping->i_shared_sem);
 		}

diff -puN include/linux/mm.h~mremap_race include/linux/mm.h
--- mmlinux-2.6/include/linux/mm.h~mremap_race	2004-02-19 00:39:36.000000000 -0500
+++ mmlinux-2.6-jaya/include/linux/mm.h	2004-02-19 00:39:36.000000000 -0500
@@ -530,6 +530,8 @@ extern void si_meminfo_node(struct sysin

 /* mmap.c */
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
+extern void add_vma_to_process(struct mm_struct *, struct vm_area_struct *);
+extern void unmap_vma(struct mm_struct *, struct vm_area_struct *);
 extern void build_mmap_rb(struct mm_struct *);
 extern void exit_mmap(struct mm_struct *);

diff -puN mm/mremap.c~mremap_race mm/mremap.c
--- mmlinux-2.6/mm/mremap.c~mremap_race	2004-02-19 00:39:36.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mremap.c	2004-02-19 00:39:36.000000000 -0500
@@ -191,8 +191,9 @@ static unsigned long move_vma(struct vm_
 	unsigned long new_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct address_space *mapping = NULL;
 	struct vm_area_struct *new_vma, *next, *prev;
-	int allocated_vma;
+	int allocated_vma, sequence = 0;
 	int split = 0;

 	new_vma = NULL;
@@ -244,23 +245,40 @@ static unsigned long move_vma(struct vm_
 		if (!new_vma)
 			goto out;
 		allocated_vma = 1;
+		*new_vma = *vma;
+		INIT_LIST_HEAD(&new_vma->shared);
+		new_vma->vm_start = new_addr;
+		new_vma->vm_end = new_addr+new_len;
+		new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
+
+		if (new_vma->vm_file) {
+			struct inode *inode;
+			get_file(new_vma->vm_file);
+			inode = new_vma->vm_file->f_dentry->d_inode;
+			mapping = new_vma->vm_file->f_mapping;
+			if (new_vma->vm_flags & VM_DENYWRITE)
+				atomic_dec(&inode->i_writecount);
+			/*
+			 * insert new_vma into the shared list, just after vma.
+			 * Note that this ordering of insertion is important
+			 * to avoid orphaned ptes due to a rare race between
+			 * invalidate_mmap_range and move_page_tables.
+			 */
+			down(&mapping->i_shared_sem);
+			sequence = atomic_read(&mapping->truncate_count);
+			list_add(&new_vma->shared, &vma->shared);
+			up(&mapping->i_shared_sem);
+		}
+
+		if (new_vma->vm_ops && new_vma->vm_ops->open)
+			new_vma->vm_ops->open(new_vma);
 	}

 	if (!move_page_tables(vma, new_addr, addr, old_len)) {
 		unsigned long vm_locked = vma->vm_flags & VM_LOCKED;

-		if (allocated_vma) {
-			*new_vma = *vma;
-			INIT_LIST_HEAD(&new_vma->shared);
-			new_vma->vm_start = new_addr;
-			new_vma->vm_end = new_addr+new_len;
-			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
-			if (new_vma->vm_file)
-				get_file(new_vma->vm_file);
-			if (new_vma->vm_ops && new_vma->vm_ops->open)
-				new_vma->vm_ops->open(new_vma);
-			insert_vm_struct(current->mm, new_vma);
-		}
+		if (allocated_vma)
+			add_vma_to_process(current->mm, new_vma);

 		/* Conceal VM_ACCOUNT so old reservation is not undone */
 		if (vma->vm_flags & VM_ACCOUNT) {
@@ -291,8 +309,20 @@ static unsigned long move_vma(struct vm_
 		}
 		return new_addr;
 	}
-	if (allocated_vma)
-		kmem_cache_free(vm_area_cachep, new_vma);
+
+	/*
+	 * Ugly. Not efficient. Paranoid about leaving orphaned ptes due to
+	 * mremap vs. truncate race. But then, it works, and we do not worry
+	 * too much about burning few extra cycles under memory pressure.
+	 */
+	if (mapping && !(vma->vm_flags & VM_NONLINEAR) &&
+		(unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
+		flush_cache_range(vma, addr, addr + old_len);
+		zap_page_range(vma, addr, old_len);
+	}
+
+	if (allocated_vma)
+		unmap_vma(current->mm, new_vma);
  out:
 	return -ENOMEM;
 }
diff -puN mm/mmap.c~mremap_race mm/mmap.c
--- mmlinux-2.6/mm/mmap.c~mremap_race	2004-02-19 00:39:36.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mmap.c	2004-02-19 00:39:36.000000000 -0500
@@ -1079,13 +1079,8 @@ no_mmaps:
  * By the time this function is called, the area struct has been
  * removed from the process mapping list.
  */
-static void unmap_vma(struct mm_struct *mm, struct vm_area_struct *area)
+void unmap_vma(struct mm_struct *mm, struct vm_area_struct *area)
 {
-	size_t len = area->vm_end - area->vm_start;
-
-	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
-	if (area->vm_flags & VM_LOCKED)
-		area->vm_mm->locked_vm -= len >> PAGE_SHIFT;
 	/*
 	 * Is this a new hole at the lowest possible address?
 	 */
@@ -1113,6 +1108,10 @@ static void unmap_vma_list(struct mm_str
 {
 	do {
 		struct vm_area_struct *next = mpnt->vm_next;
+		size_t len = mpnt->vm_end - mpnt->vm_start;
+		mpnt->vm_mm->total_vm -= len >> PAGE_SHIFT;
+		if (mpnt->vm_flags & VM_LOCKED)
+			mpnt->vm_mm->locked_vm -= len >> PAGE_SHIFT;
 		unmap_vma(mm, mpnt);
 		mpnt = next;
 	} while (mpnt != NULL);
@@ -1485,3 +1484,22 @@ void insert_vm_struct(struct mm_struct *
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	validate_mm(mm);
 }
+
+/* Insert vm structure into process list sorted by address */
+
+void add_vma_to_process(struct mm_struct * mm, struct vm_area_struct * vma)
+{
+	struct vm_area_struct * __vma, * prev;
+	struct rb_node ** rb_link, * rb_parent;
+
+	__vma = find_vma_prepare(mm,vma->vm_start,&prev,&rb_link,&rb_parent);
+	if (__vma && __vma->vm_start < vma->vm_end)
+		BUG();
+	spin_lock(&mm->page_table_lock);
+	__vma_link_list(mm, vma, prev, rb_parent);
+	__vma_link_rb(mm, vma, rb_link, rb_parent);
+	spin_unlock(&mm->page_table_lock);
+	mark_mm_hugetlb(mm, vma);
+	mm->map_count++;
+	validate_mm(mm);
+}

_


