Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVIYPwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVIYPwr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVIYPwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:52:46 -0400
Received: from gold.veritas.com ([143.127.12.110]:26283 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932169AbVIYPwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:52:45 -0400
Date: Sun, 25 Sep 2005 16:52:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/21] mm: vm_stat_account unshackled
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251651140.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:52:45.0478 (UTC) FILETIME=[2BB57460:01C5C1E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original vm_stat_account has fallen into disuse, with only one user,
and only one user of vm_stat_unaccount.  It's easier to keep track if we
convert them all to __vm_stat_account, then free it from its __shackles.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/ia64/kernel/perfmon.c |    3 ++-
 arch/ia64/mm/fault.c       |    2 +-
 include/linux/mm.h         |   16 ++--------------
 kernel/fork.c              |    2 +-
 mm/mmap.c                  |   20 ++++++++++----------
 mm/mprotect.c              |    4 ++--
 mm/mremap.c                |    4 ++--
 7 files changed, 20 insertions(+), 31 deletions(-)

--- mm05/arch/ia64/kernel/perfmon.c	2005-09-21 12:16:14.000000000 +0100
+++ mm06/arch/ia64/kernel/perfmon.c	2005-09-24 19:27:33.000000000 +0100
@@ -2352,7 +2352,8 @@ pfm_smpl_buffer_alloc(struct task_struct
 	insert_vm_struct(mm, vma);
 
 	mm->total_vm  += size >> PAGE_SHIFT;
-	vm_stat_account(vma);
+	vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
+							vma_pages(vma));
 	up_write(&task->mm->mmap_sem);
 
 	/*
--- mm05/arch/ia64/mm/fault.c	2005-09-21 12:16:14.000000000 +0100
+++ mm06/arch/ia64/mm/fault.c	2005-09-24 19:27:33.000000000 +0100
@@ -41,7 +41,7 @@ expand_backing_store (struct vm_area_str
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
-	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
+	vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
 	return 0;
 }
 
--- mm05/include/linux/mm.h	2005-09-22 12:32:02.000000000 +0100
+++ mm06/include/linux/mm.h	2005-09-24 19:27:33.000000000 +0100
@@ -936,26 +936,14 @@ int remap_pfn_range(struct vm_area_struc
 		unsigned long, unsigned long, pgprot_t);
 
 #ifdef CONFIG_PROC_FS
-void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
+void vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
-static inline void __vm_stat_account(struct mm_struct *mm,
+static inline void vm_stat_account(struct mm_struct *mm,
 			unsigned long flags, struct file *file, long pages)
 {
 }
 #endif /* CONFIG_PROC_FS */
 
-static inline void vm_stat_account(struct vm_area_struct *vma)
-{
-	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
-							vma_pages(vma));
-}
-
-static inline void vm_stat_unaccount(struct vm_area_struct *vma)
-{
-	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
-							-vma_pages(vma));
-}
-
 /* update per process rss and vm hiwater data */
 extern void update_mem_hiwater(struct task_struct *tsk);
 
--- mm05/kernel/fork.c	2005-09-22 12:32:03.000000000 +0100
+++ mm06/kernel/fork.c	2005-09-24 19:27:33.000000000 +0100
@@ -212,7 +212,7 @@ static inline int dup_mmap(struct mm_str
 		if (mpnt->vm_flags & VM_DONTCOPY) {
 			long pages = vma_pages(mpnt);
 			mm->total_vm -= pages;
-			__vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
+			vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
 								-pages);
 			continue;
 		}
--- mm05/mm/mmap.c	2005-09-22 12:32:03.000000000 +0100
+++ mm06/mm/mmap.c	2005-09-24 19:27:33.000000000 +0100
@@ -828,7 +828,7 @@ none:
 }
 
 #ifdef CONFIG_PROC_FS
-void __vm_stat_account(struct mm_struct *mm, unsigned long flags,
+void vm_stat_account(struct mm_struct *mm, unsigned long flags,
 						struct file *file, long pages)
 {
 	const unsigned long stack_flags
@@ -1106,7 +1106,7 @@ munmap_back:
 	}
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
-	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
@@ -1471,7 +1471,7 @@ static int acct_stack_growth(struct vm_a
 	mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm += grow;
-	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, grow);
+	vm_stat_account(mm, vma->vm_flags, vma->vm_file, grow);
 	return 0;
 }
 
@@ -1606,15 +1606,15 @@ find_extend_vma(struct mm_struct * mm, u
  * By the time this function is called, the area struct has been
  * removed from the process mapping list.
  */
-static void unmap_vma(struct mm_struct *mm, struct vm_area_struct *area)
+static void unmap_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	size_t len = area->vm_end - area->vm_start;
+	long nrpages = vma_pages(vma);
 
-	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
-	if (area->vm_flags & VM_LOCKED)
-		area->vm_mm->locked_vm -= len >> PAGE_SHIFT;
-	vm_stat_unaccount(area);
-	remove_vm_struct(area);
+	mm->total_vm -= nrpages;
+	if (vma->vm_flags & VM_LOCKED)
+		mm->locked_vm -= nrpages;
+	vm_stat_account(mm, vma->vm_flags, vma->vm_file, -nrpages);
+	remove_vm_struct(vma);
 }
 
 /*
--- mm05/mm/mprotect.c	2005-09-22 12:32:03.000000000 +0100
+++ mm06/mm/mprotect.c	2005-09-24 19:27:33.000000000 +0100
@@ -168,8 +168,8 @@ success:
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
 	change_protection(vma, start, end, newprot);
-	__vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
-	__vm_stat_account(mm, newflags, vma->vm_file, nrpages);
+	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
+	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
 
 fail:
--- mm05/mm/mremap.c	2005-09-22 12:32:03.000000000 +0100
+++ mm06/mm/mremap.c	2005-09-24 19:27:33.000000000 +0100
@@ -233,7 +233,7 @@ static unsigned long move_vma(struct vm_
 	 * since do_munmap() will decrement it by old_len == new_len
 	 */
 	mm->total_vm += new_len >> PAGE_SHIFT;
-	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
+	vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 
 	if (do_munmap(mm, old_addr, old_len) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
@@ -384,7 +384,7 @@ unsigned long do_mremap(unsigned long ad
 				addr + new_len, vma->vm_pgoff, NULL);
 
 			current->mm->total_vm += pages;
-			__vm_stat_account(vma->vm_mm, vma->vm_flags,
+			vm_stat_account(vma->vm_mm, vma->vm_flags,
 							vma->vm_file, pages);
 			if (vma->vm_flags & VM_LOCKED) {
 				current->mm->locked_vm += pages;
