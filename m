Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUDDMfx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 08:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUDDMfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 08:35:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17589 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262356AbUDDMd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 08:33:56 -0400
Date: Sun, 4 Apr 2004 13:33:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <Pine.LNX.4.44.0404041330580.21790-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This anobjrmap 9 (or anon_mm9) patch adds Rajesh's radix priority search
tree on top of Martin's 2.6.5-rc3-mjb2 tree, making a priority mjb tree!
Approximately equivalent to Andrea's 2.6.5-aa1, but using anonmm instead
of anon_vma, and of course each tree has its own additional features.

 arch/arm/mm/fault-armv.c        |   80 ++---
 arch/mips/mm/cache.c            |    9 
 arch/parisc/kernel/cache.c      |   86 ++---
 arch/parisc/kernel/sys_parisc.c |   14 
 arch/s390/kernel/compat_exec.c  |    2 
 arch/sparc64/mm/init.c          |    8 
 arch/x86_64/ia32/ia32_binfmt.c  |    2 
 fs/exec.c                       |    2 
 fs/hugetlbfs/inode.c            |   14 
 fs/inode.c                      |    5 
 fs/locks.c                      |    8 
 fs/proc/task_mmu.c              |    2 
 fs/xfs/linux/xfs_vnode.h        |    5 
 include/asm-arm/cacheflush.h    |    8 
 include/asm-parisc/cacheflush.h |   10 
 include/asm-sh/pgalloc.h        |    5 
 include/linux/fs.h              |    6 
 include/linux/mm.h              |  167 +++++++++++
 include/linux/prio_tree.h       |   78 +++++
 init/main.c                     |    2 
 kernel/fork.c                   |    4 
 kernel/kexec.c                  |    2 
 mm/Makefile                     |    3 
 mm/filemap.c                    |    3 
 mm/fremap.c                     |   14 
 mm/memory.c                     |   15 -
 mm/mmap.c                       |  100 +++---
 mm/mremap.c                     |   42 ++
 mm/page_io.c                    |    4 
 mm/prio_tree.c                  |  577 ++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c                       |  164 ++++++-----
 mm/shmem.c                      |    3 
 mm/vmscan.c                     |    6 
 33 files changed, 1172 insertions(+), 278 deletions(-)

--- 2.6.5-rc3-mjb2/arch/arm/mm/fault-armv.c	2004-04-02 21:01:43.725406016 +0100
+++ anobjrmap9/arch/arm/mm/fault-armv.c	2004-04-04 13:05:41.369476056 +0100
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/io.h>
@@ -186,47 +187,47 @@ no_pmd:
 
 void __flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct list_head *l;
+	struct vm_area_struct *mpnt;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 
 	__cpuc_flush_dcache_page(page_address(page));
 
-	if (!page_mapping(page))
+	if (!mapping)
 		return;
 
 	/*
 	 * With a VIVT cache, we need to also write back
 	 * and invalidate any user data.
 	 */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		if (mpnt->vm_mm != mm)
-			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
+		if (mpnt->vm_mm == mm) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			flush_cache_page(mpnt, mpnt->vm_start + offset);
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 }
 
 static void
 make_coherent(struct vm_area_struct *vma, unsigned long addr, struct page *page, int dirty)
 {
-	struct list_head *l;
+	struct address_space *mapping = page->mapping;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	struct vm_area_struct *mpnt;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 	int aliases = 0;
 
 	/*
@@ -234,36 +235,21 @@ make_coherent(struct vm_area_struct *vma
 	 * space, then we need to handle them specially to maintain
 	 * cache coherency.
 	 */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
-		 * Note that we intentionally don't mask out the VMA
+		 * Note that we intentionally mask out the VMA
 		 * that we are fixing up.
 		 */
-		if (mpnt->vm_mm != mm || mpnt == vma)
-			continue;
-
-		/*
-		 * If the page isn't in this VMA, we can also ignore it.
-		 */
-		if (pgoff < mpnt->vm_pgoff)
-			continue;
-
-		off = pgoff - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		off = mpnt->vm_start + (off << PAGE_SHIFT);
-
-		/*
-		 * Ok, it is within mpnt.  Fix it up.
-		 */
-		aliases += adjust_pte(mpnt, off);
+		if (mpnt->vm_mm == mm && mpnt != vma) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 	if (aliases)
 		adjust_pte(vma, addr);
--- 2.6.5-rc3-mjb2/arch/mips/mm/cache.c	2004-04-02 21:01:44.347311472 +0100
+++ anobjrmap9/arch/mips/mm/cache.c	2004-04-04 13:05:41.370475904 +0100
@@ -55,13 +55,14 @@ asmlinkage int sys_cacheflush(void *addr
 
 void flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	unsigned long addr;
 
-	if (page_mapping(page) &&
-	    list_empty(&page->mapping->i_mmap) &&
-	    list_empty(&page->mapping->i_mmap_shared)) {
+	if (mapping &&
+	    prio_tree_empty(&mapping->i_mmap) &&
+	    prio_tree_empty(&mapping->i_mmap_shared) &&
+	    list_empty(&mapping->i_mmap_nonlinear)) {
 		SetPageDcacheDirty(page);
-
 		return;
 	}
 
--- 2.6.5-rc3-mjb2/arch/parisc/kernel/cache.c	2004-04-02 21:01:44.356310104 +0100
+++ anobjrmap9/arch/parisc/kernel/cache.c	2004-04-04 13:05:41.371475752 +0100
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/pagemap.h>
 
 #include <asm/pdc.h>
 #include <asm/cache.h>
@@ -229,67 +230,60 @@ void disable_sr_hashing(void)
 
 void __flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct list_head *l;
+	struct vm_area_struct *mpnt;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 
 	flush_kernel_dcache_page(page_address(page));
 
-	if (!page_mapping(page))
+	if (!mapping)
 		return;
-	/* check shared list first if it's not empty...it's usually
-	 * the shortest */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
 
-		mpnt = list_entry(l, struct vm_area_struct, shared);
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
+	/* check shared list first if it's not empty...it's usually
+	 * the shortest */
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		if (mpnt->vm_mm != mm)
-			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
-
-		/* All user shared mappings should be equivalently mapped,
-		 * so once we've flushed one we should be ok
-		 */
-		return;
+		if (mpnt->vm_mm == mm) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			flush_cache_page(mpnt, mpnt->vm_start + offset);
+
+			/* All user shared mappings should be equivalently
+			 * mapped, so once we've flushed one we should be ok
+			 */
+			return;
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 
 	/* then check private mapping list for read only shared mappings
 	 * which are flagged by VM_MAYSHARE */
-	list_for_each(l, &page->mapping->i_mmap) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
-
-		if (mpnt->vm_mm != mm || !(mpnt->vm_flags & VM_MAYSHARE))
-			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
-
-		/* All user shared mappings should be equivalently mapped,
-		 * so once we've flushed one we should be ok
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
+		/*
+		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		break;
+		if (mpnt->vm_mm == mm && (mpnt->vm_flags & VM_MAYSHARE)) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			flush_cache_page(mpnt, mpnt->vm_start + offset);
+
+			/* All user shared mappings should be equivalently
+			 * mapped, so once we've flushed one we should be ok
+			 */
+			return;
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 }
 EXPORT_SYMBOL(__flush_dcache_page);
--- 2.6.5-rc3-mjb2/arch/parisc/kernel/sys_parisc.c	2004-03-30 13:04:00.000000000 +0100
+++ anobjrmap9/arch/parisc/kernel/sys_parisc.c	2004-04-04 13:05:41.372475600 +0100
@@ -68,17 +68,8 @@ static unsigned long get_unshared_area(u
  * existing mapping and use the same offset.  New scheme is to use the
  * address of the kernel data structure as the seed for the offset.
  * We'll see how that works...
- */
-#if 0
-static int get_offset(struct address_space *mapping)
-{
-	struct vm_area_struct *vma = list_entry(mapping->i_mmap_shared.next,
-			struct vm_area_struct, shared);
-	return (vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT)) &
-		(SHMLBA - 1);
-}
-#else
-/* The mapping is cacheline aligned, so there's no information in the bottom
+ *
+ * The mapping is cacheline aligned, so there's no information in the bottom
  * few bits of the address.  We're looking for 10 bits (4MB / 4k), so let's
  * drop the bottom 8 bits and use bits 8-17.  
  */
@@ -87,7 +78,6 @@ static int get_offset(struct address_spa
 	int offset = (unsigned long) mapping << (PAGE_SHIFT - 8);
 	return offset & 0x3FF000;
 }
-#endif
 
 static unsigned long get_shared_area(struct address_space *mapping,
 		unsigned long addr, unsigned long len, unsigned long pgoff)
--- 2.6.5-rc3-mjb2/arch/s390/kernel/compat_exec.c	2003-07-10 21:16:28.000000000 +0100
+++ anobjrmap9/arch/s390/kernel/compat_exec.c	2004-04-04 13:05:41.372475600 +0100
@@ -71,7 +71,7 @@ int setup_arg_pages32(struct linux_binpr
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
-		INIT_LIST_HEAD(&mpnt->shared);
+		INIT_VMA_SHARED(mpnt);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- 2.6.5-rc3-mjb2/arch/sparc64/mm/init.c	2004-04-02 21:01:44.535282896 +0100
+++ anobjrmap9/arch/sparc64/mm/init.c	2004-04-04 13:05:41.375475144 +0100
@@ -224,12 +224,14 @@ void update_mmu_cache(struct vm_area_str
 
 void flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	int dirty = test_bit(PG_dcache_dirty, &page->flags);
 	int dirty_cpu = dcache_dirty_cpu(page);
 
-	if (page_mapping(page) &&
-	    list_empty(&page->mapping->i_mmap) &&
-	    list_empty(&page->mapping->i_mmap_shared)) {
+	if (mapping &&
+	    prio_tree_empty(&mapping->i_mmap) &&
+	    prio_tree_empty(&mapping->i_mmap_shared) &&
+	    list_empty(&mapping->i_mmap_nonlinear)) {
 		if (dirty) {
 			if (dirty_cpu == smp_processor_id())
 				return;
--- 2.6.5-rc3-mjb2/arch/x86_64/ia32/ia32_binfmt.c	2004-03-30 13:04:03.000000000 +0100
+++ anobjrmap9/arch/x86_64/ia32/ia32_binfmt.c	2004-04-04 13:05:41.375475144 +0100
@@ -360,7 +360,7 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
-		INIT_LIST_HEAD(&mpnt->shared);
+		INIT_VMA_SHARED(mpnt);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- 2.6.5-rc3-mjb2/fs/exec.c	2004-04-02 21:01:45.785092896 +0100
+++ anobjrmap9/fs/exec.c	2004-04-04 13:05:41.377474840 +0100
@@ -423,7 +423,7 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
-		INIT_LIST_HEAD(&mpnt->shared);
+		INIT_VMA_SHARED(mpnt);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- 2.6.5-rc3-mjb2/fs/hugetlbfs/inode.c	2004-04-02 21:01:45.794091528 +0100
+++ anobjrmap9/fs/hugetlbfs/inode.c	2004-04-04 13:05:41.378474688 +0100
@@ -270,11 +270,13 @@ static void hugetlbfs_drop_inode(struct 
  * vma->vm_pgoff is in PAGE_SIZE units.
  */
 static void
-hugetlb_vmtruncate_list(struct list_head *list, unsigned long h_pgoff)
+hugetlb_vmtruncate_list(struct prio_tree_root *root, unsigned long h_pgoff)
 {
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
 
-	list_for_each_entry(vma, list, shared) {
+	vma = __vma_prio_tree_first(root, &iter, h_pgoff, ULONG_MAX);
+	while (vma) {
 		unsigned long h_vm_pgoff;
 		unsigned long v_length;
 		unsigned long h_length;
@@ -306,6 +308,8 @@ hugetlb_vmtruncate_list(struct list_head
 		zap_hugepage_range(vma,
 				vma->vm_start + v_offset,
 				v_length - v_offset);
+
+		vma = __vma_prio_tree_next(vma, root, &iter, h_pgoff, ULONG_MAX);
 	}
 }
 
@@ -325,9 +329,11 @@ static int hugetlb_vmtruncate(struct ino
 
 	inode->i_size = offset;
 	down(&mapping->i_shared_sem);
-	if (!list_empty(&mapping->i_mmap))
+	/* Protect against page fault */
+	atomic_inc(&mapping->truncate_count);
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
-	if (!list_empty(&mapping->i_mmap_shared))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	up(&mapping->i_shared_sem);
 	truncate_hugepages(mapping, offset);
--- 2.6.5-rc3-mjb2/fs/inode.c	2004-03-30 13:04:15.000000000 +0100
+++ anobjrmap9/fs/inode.c	2004-04-04 13:05:41.380474384 +0100
@@ -189,8 +189,9 @@ void inode_init_once(struct inode *inode
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
+	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
 }
--- 2.6.5-rc3-mjb2/fs/locks.c	2004-03-11 01:56:12.000000000 +0000
+++ anobjrmap9/fs/locks.c	2004-04-04 13:05:41.382474080 +0100
@@ -1455,8 +1455,8 @@ int fcntl_setlk(struct file *filp, unsig
 	if (IS_MANDLOCK(inode) &&
 	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
 		struct address_space *mapping = filp->f_mapping;
-
-		if (!list_empty(&mapping->i_mmap_shared)) {
+		if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+			!list_empty(&mapping->i_mmap_nonlinear)) {
 			error = -EAGAIN;
 			goto out;
 		}
@@ -1593,8 +1593,8 @@ int fcntl_setlk64(struct file *filp, uns
 	if (IS_MANDLOCK(inode) &&
 	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
 		struct address_space *mapping = filp->f_mapping;
-
-		if (!list_empty(&mapping->i_mmap_shared)) {
+		if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+			!list_empty(&mapping->i_mmap_nonlinear)) {
 			error = -EAGAIN;
 			goto out;
 		}
--- 2.6.5-rc3-mjb2/fs/proc/task_mmu.c	2004-04-02 21:01:45.864080888 +0100
+++ anobjrmap9/fs/proc/task_mmu.c	2004-04-04 13:05:41.383473928 +0100
@@ -65,7 +65,7 @@ int task_statm(struct mm_struct *mm, int
 				*shared += pages;
 			continue;
 		}
-		if (vma->vm_flags & VM_SHARED || !list_empty(&vma->shared))
+		if (vma->vm_flags & VM_SHARED || !vma_shared_empty(vma))
 			*shared += pages;
 		if (vma->vm_flags & VM_EXECUTABLE)
 			*text += pages;
--- 2.6.5-rc3-mjb2/fs/xfs/linux/xfs_vnode.h	2004-02-04 02:45:43.000000000 +0000
+++ anobjrmap9/fs/xfs/linux/xfs_vnode.h	2004-04-04 13:05:41.384473776 +0100
@@ -597,8 +597,9 @@ static __inline__ void vn_flagclr(struct
  * Some useful predicates.
  */
 #define VN_MAPPED(vp)	\
-	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
-	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
+	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
+	 !prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared)) || \
+	 !list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_nonlinear)))
 #define VN_CACHED(vp)	(LINVFS_GET_IP(vp)->i_mapping->nrpages)
 #define VN_DIRTY(vp)	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->dirty_pages)))
 #define VMODIFY(vp)	VN_FLAGSET(vp, VMODIFIED)
--- 2.6.5-rc3-mjb2/include/asm-arm/cacheflush.h	2004-04-02 21:01:45.998060520 +0100
+++ anobjrmap9/include/asm-arm/cacheflush.h	2004-04-04 13:05:41.385473624 +0100
@@ -292,8 +292,12 @@ flush_cache_page(struct vm_area_struct *
  * about to change to user space.  This is the same method as used on SPARC64.
  * See update_mmu_cache for the user space part.
  */
-#define mapping_mapped(map)	(!list_empty(&(map)->i_mmap) || \
-				 !list_empty(&(map)->i_mmap_shared))
+static inline int mapping_mapped(struct address_space *mapping)
+{
+	return	!prio_tree_empty(&mapping->i_mmap) ||
+		!prio_tree_empty(&mapping->i_mmap_shared) ||
+		!list_empty(&mapping->i_mmap_nonlinear);
+}
 
 extern void __flush_dcache_page(struct page *);
 
--- 2.6.5-rc3-mjb2/include/asm-parisc/cacheflush.h	2004-04-02 21:01:46.794939376 +0100
+++ anobjrmap9/include/asm-parisc/cacheflush.h	2004-04-04 13:05:41.385473624 +0100
@@ -65,12 +65,18 @@ flush_user_icache_range(unsigned long st
 #endif
 }
 
+static inline int mapping_mapped(struct address_space *mapping)
+{
+	return	!prio_tree_empty(&mapping->i_mmap) ||
+		!prio_tree_empty(&mapping->i_mmap_shared) ||
+		!list_empty(&mapping->i_mmap_nonlinear);
+}
+
 extern void __flush_dcache_page(struct page *page);
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page_mapping(page) && list_empty(&page->mapping->i_mmap) &&
-			list_empty(&page->mapping->i_mmap_shared)) {
+	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
 		set_bit(PG_dcache_dirty, &page->flags);
 	} else {
 		__flush_dcache_page(page);
--- 2.6.5-rc3-mjb2/include/asm-sh/pgalloc.h	2004-04-02 21:01:46.963913688 +0100
+++ anobjrmap9/include/asm-sh/pgalloc.h	2004-04-04 13:05:41.386473472 +0100
@@ -101,8 +101,9 @@ static inline pte_t ptep_get_and_clear(p
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (!page_mapping(page)
-			    || list_empty(&page->mapping->i_mmap_shared))
+			if (!page_mapping(page) ||
+			    (prio_tree_empty(&page->mapping->i_mmap_shared) &&
+			     list_empty(&page->mapping->i_mmap_nonlinear)))
 				__clear_bit(PG_mapped, &page->flags);
 		}
 	}
--- 2.6.5-rc3-mjb2/include/linux/fs.h	2004-03-30 13:04:18.000000000 +0100
+++ anobjrmap9/include/linux/fs.h	2004-04-04 13:05:41.388473168 +0100
@@ -18,6 +18,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
+#include <linux/prio_tree.h>
 #include <linux/kobject.h>
 #include <asm/atomic.h>
 
@@ -329,8 +330,9 @@ struct address_space {
 	struct list_head	io_pages;	/* being prepared for I/O */
 	unsigned long		nrpages;	/* number of total pages */
 	struct address_space_operations *a_ops;	/* methods */
-	struct list_head	i_mmap;		/* list of private mappings */
-	struct list_head	i_mmap_shared;	/* list of shared mappings */
+	struct prio_tree_root	i_mmap;		/* tree of private mappings */
+	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
+	struct list_head	i_mmap_nonlinear;/*list of nonlinear mappings */
 	struct semaphore	i_shared_sem;	/* protect both above lists */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
--- 2.6.5-rc3-mjb2/include/linux/mm.h	2004-04-02 21:01:47.316860032 +0100
+++ anobjrmap9/include/linux/mm.h	2004-04-04 13:05:41.390472864 +0100
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
+#include <linux/prio_tree.h>
 #include <linux/fs.h>
 
 #ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
@@ -68,7 +69,26 @@ struct vm_area_struct {
 	 * one of the address_space->i_mmap{,shared} lists,
 	 * for shm areas, the list of attaches, otherwise unused.
 	 */
-	struct list_head shared;
+	union {
+		struct {
+			struct list_head list;
+			void *parent;
+		} vm_set;
+
+		struct prio_tree_node  prio_tree_node;
+
+		struct {
+			void *first;
+			void *second;
+			void *parent;
+		} both;
+	} shared;
+
+	/*
+	 * shared.vm_set : list of vmas that map exactly the same set of pages
+	 * vm_set_head   : head of the vm_set list
+	 */
+	struct vm_area_struct *vm_set_head;
 
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
@@ -130,6 +150,150 @@ struct vm_area_struct {
 #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
 
 /*
+ * The following macros are used for implementing prio_tree for i_mmap{_shared}
+ */
+
+#define	RADIX_INDEX(vma)  ((vma)->vm_pgoff)
+#define	VMA_SIZE(vma)	  (((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
+/* avoid overflow */
+#define	HEAP_INDEX(vma)	  ((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))
+
+#define GET_INDEX_VMA(vma, radix, heap)		\
+do {						\
+	radix = RADIX_INDEX(vma);		\
+	heap = HEAP_INDEX(vma);			\
+} while (0)
+
+#define GET_INDEX(node, radix, heap)		\
+do { 						\
+	struct vm_area_struct *__tmp = 		\
+	  prio_tree_entry(node, struct vm_area_struct, shared.prio_tree_node);\
+	GET_INDEX_VMA(__tmp, radix, heap); 	\
+} while (0)
+
+#define	INIT_VMA_SHARED_LIST(vma)			\
+do {							\
+	INIT_LIST_HEAD(&(vma)->shared.vm_set.list);	\
+	(vma)->shared.vm_set.parent = NULL;		\
+	(vma)->vm_set_head = NULL;			\
+} while (0)
+
+#define INIT_VMA_SHARED(vma)			\
+do {						\
+	(vma)->shared.both.first = NULL;	\
+	(vma)->shared.both.second = NULL;	\
+	(vma)->shared.both.parent = NULL;	\
+	(vma)->vm_set_head = NULL;		\
+} while (0)
+
+extern void __vma_prio_tree_insert(struct prio_tree_root *,
+	struct vm_area_struct *);
+
+extern void __vma_prio_tree_remove(struct prio_tree_root *,
+	struct vm_area_struct *);
+
+static inline int vma_shared_empty(struct vm_area_struct *vma)
+{
+	return vma->shared.both.first == NULL;
+}
+
+/*
+ * Helps to add a new vma that maps the same (identical) set of pages as the
+ * old vma to an i_mmap tree.
+ */
+static inline void __vma_prio_tree_add(struct vm_area_struct *vma,
+	struct vm_area_struct *old)
+{
+	INIT_VMA_SHARED_LIST(vma);
+
+	/* Leave these BUG_ONs till prio_tree patch stabilizes */
+	BUG_ON(RADIX_INDEX(vma) != RADIX_INDEX(old));
+	BUG_ON(HEAP_INDEX(vma) != HEAP_INDEX(old));
+
+	if (old->shared.both.parent) {
+		if (old->vm_set_head) {
+			list_add_tail(&vma->shared.vm_set.list,
+					&old->vm_set_head->shared.vm_set.list);
+			return;
+		}
+		else {
+			old->vm_set_head = vma;
+			vma->vm_set_head = old;
+		}
+	}
+	else
+		list_add(&vma->shared.vm_set.list, &old->shared.vm_set.list);
+}
+
+/*
+ * We cannot modify vm_start, vm_end, vm_pgoff fields of a vma that has been
+ * already present in an i_mmap{_shared} tree without modifying the tree. The
+ * following helper function should be used when such modifications are
+ * necessary. We should hold the mapping's i_shared_sem.
+ *
+ * This function can be (micro)optimized for some special cases (maybe later).
+ */
+static inline void __vma_modify(struct prio_tree_root *root,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	unsigned long pgoff)
+{
+	if (root)
+		__vma_prio_tree_remove(root, vma);
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	if (root)
+		__vma_prio_tree_insert(root, vma);
+}
+
+/*
+ * Helper functions to enumerate vmas that map a given file page or a set of
+ * contiguous file pages. The functions return vmas that at least map a single
+ * page in the given range of contiguous file pages.
+ */
+static inline struct vm_area_struct *__vma_prio_tree_first(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long begin, unsigned long end)
+{
+	struct prio_tree_node *ptr;
+
+	ptr = prio_tree_first(root, iter, begin, end);
+
+	if (ptr)
+		return prio_tree_entry(ptr, struct vm_area_struct,
+				shared.prio_tree_node);
+	else
+		return NULL;
+}
+
+static inline struct vm_area_struct *__vma_prio_tree_next(
+	struct vm_area_struct *vma, struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long begin, unsigned long end)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *next;
+
+	if (vma->shared.both.parent) {
+		if (vma->vm_set_head)
+			return vma->vm_set_head;
+	}
+	else {
+		next = list_entry(vma->shared.vm_set.list.next,
+				struct vm_area_struct, shared.vm_set.list);
+		if (!(next->vm_set_head))
+			return next;
+	}
+
+	ptr = prio_tree_next(root, iter, begin, end);
+
+	if (ptr)
+		return prio_tree_entry(ptr, struct vm_area_struct,
+				shared.prio_tree_node);
+	else
+		return NULL;
+}
+
+/*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
@@ -520,7 +684,6 @@ extern void __vma_link_rb(struct mm_stru
 	struct rb_node **, struct rb_node *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct *,
 	unsigned long addr, unsigned long len, unsigned long pgoff);
-extern void vma_relink_file(struct vm_area_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- 2.6.5-rc3-mjb2/include/linux/prio_tree.h	1970-01-01 01:00:00.000000000 +0100
+++ anobjrmap9/include/linux/prio_tree.h	2004-04-04 13:05:41.391472712 +0100
@@ -0,0 +1,78 @@
+#ifndef _LINUX_PRIO_TREE_H
+#define _LINUX_PRIO_TREE_H
+
+struct prio_tree_node {
+	struct prio_tree_node *left;
+	struct prio_tree_node *right;
+	struct prio_tree_node *parent;
+};
+
+struct prio_tree_root {
+	struct prio_tree_node	*prio_tree_node;
+	unsigned int 		index_bits;
+};
+
+struct prio_tree_iter {
+	struct prio_tree_node	*cur;
+	unsigned long		mask;
+	unsigned long		value;
+	int			size_level;
+};
+
+#define PRIO_TREE_ROOT	(struct prio_tree_root) {NULL, 1}
+
+#define PRIO_TREE_ROOT_INIT	{NULL, 1}
+
+#define INIT_PRIO_TREE_ROOT(ptr)	\
+do {					\
+	(ptr)->prio_tree_node = NULL;	\
+	(ptr)->index_bits = 1;		\
+} while (0)
+
+#define PRIO_TREE_NODE_INIT(name)	{&(name), &(name), &(name)}
+
+#define PRIO_TREE_NODE(name) \
+	struct prio_tree_node name = PRIO_TREE_NODE_INIT(name)
+
+#define INIT_PRIO_TREE_NODE(ptr)				\
+do {								\
+	(ptr)->left = (ptr)->right = (ptr)->parent = (ptr);	\
+} while (0)
+
+#define	prio_tree_entry(ptr, type, member) \
+       ((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+
+#define	PRIO_TREE_ITER	(struct prio_tree_iter) {NULL, 0UL, 0UL, 0}
+
+static inline int prio_tree_empty(const struct prio_tree_root *root)
+{
+	return root->prio_tree_node == NULL;
+}
+
+static inline int prio_tree_root(const struct prio_tree_node *node)
+{
+	return node->parent == node;
+}
+
+static inline int prio_tree_left_empty(const struct prio_tree_node *node)
+{
+	return node->left == node;
+}
+
+static inline int prio_tree_right_empty(const struct prio_tree_node *node)
+{
+	return node->right == node;
+}
+
+extern struct prio_tree_node *prio_tree_insert(struct prio_tree_root *,
+	struct prio_tree_node *);
+
+extern void prio_tree_remove(struct prio_tree_root *, struct prio_tree_node *);
+
+extern struct prio_tree_node *prio_tree_first(struct prio_tree_root *,
+	struct prio_tree_iter *, unsigned long, unsigned long);
+
+extern struct prio_tree_node *prio_tree_next(struct prio_tree_root *,
+	struct prio_tree_iter *, unsigned long, unsigned long);
+
+#endif
--- 2.6.5-rc3-mjb2/init/main.c	2004-04-02 21:01:47.345855624 +0100
+++ anobjrmap9/init/main.c	2004-04-04 13:05:41.392472560 +0100
@@ -85,6 +85,7 @@ extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
 extern void radix_tree_init(void);
+extern void prio_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
 extern void driver_init(void);
@@ -466,6 +467,7 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
+	prio_tree_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
--- 2.6.5-rc3-mjb2/kernel/fork.c	2004-04-02 21:01:47.350854864 +0100
+++ anobjrmap9/kernel/fork.c	2004-04-04 13:05:41.394472256 +0100
@@ -314,7 +314,7 @@ static inline int dup_mmap(struct mm_str
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		file = tmp->vm_file;
-		INIT_LIST_HEAD(&tmp->shared);
+		INIT_VMA_SHARED(tmp);
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
@@ -323,7 +323,7 @@ static inline int dup_mmap(struct mm_str
       
 			/* insert tmp into the share list, just after mpnt */
 			down(&file->f_mapping->i_shared_sem);
-			list_add(&tmp->shared, &mpnt->shared);
+			__vma_prio_tree_add(tmp, mpnt);
 			up(&file->f_mapping->i_shared_sem);
 		}
 
--- 2.6.5-rc3-mjb2/kernel/kexec.c	2004-04-02 21:01:47.354854256 +0100
+++ anobjrmap9/kernel/kexec.c	2004-04-04 13:05:41.395472104 +0100
@@ -191,7 +191,7 @@ static int identity_map_pages(struct pag
 	vma->vm_page_prot = protection_map[vma->vm_flags & 0xf];
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
-	INIT_LIST_HEAD(&vma->shared);
+	INIT_VMA_SHARED(vma);
 	insert_vm_struct(mm, vma);
 
 	error = remap_page_range(vma, vma->vm_start, vma->vm_start,
--- 2.6.5-rc3-mjb2/mm/Makefile	2004-04-02 21:01:47.392848480 +0100
+++ anobjrmap9/mm/Makefile	2004-04-04 13:05:41.395472104 +0100
@@ -9,7 +9,8 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
+			   slab.o swap.o truncate.o vmscan.o prio_tree.o \
+			   $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_X86_4G)	+= usercopy.o
--- 2.6.5-rc3-mjb2/mm/filemap.c	2004-04-02 21:01:47.395848024 +0100
+++ anobjrmap9/mm/filemap.c	2004-04-04 13:05:41.397471800 +0100
@@ -632,7 +632,8 @@ page_ok:
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
 		 */
-		if (!list_empty(&mapping->i_mmap_shared))
+		if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+			!list_empty(&mapping->i_mmap_nonlinear))
 			flush_dcache_page(page);
 
 		/*
--- 2.6.5-rc3-mjb2/mm/fremap.c	2004-04-02 21:01:47.397847720 +0100
+++ anobjrmap9/mm/fremap.c	2004-04-04 13:05:41.398471648 +0100
@@ -157,6 +157,8 @@ asmlinkage long sys_remap_file_pages(uns
 	unsigned long __prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct address_space *mapping;
+	unsigned long linear_pgoff;
 	unsigned long end = start + size;
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
@@ -197,8 +199,18 @@ asmlinkage long sys_remap_file_pages(uns
 				end <= vma->vm_end) {
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff)
+		linear_pgoff = vma->vm_pgoff;
+		linear_pgoff += ((start - vma->vm_start) >> PAGE_SHIFT);
+		if (pgoff != linear_pgoff && !(vma->vm_flags & VM_NONLINEAR)) {
+			mapping = vma->vm_file->f_mapping;
+			down(&mapping->i_shared_sem);
 			vma->vm_flags |= VM_NONLINEAR;
+			__vma_prio_tree_remove(&mapping->i_mmap_shared, vma);
+			INIT_VMA_SHARED_LIST(vma);
+			list_add_tail(&vma->shared.vm_set.list,
+					&mapping->i_mmap_nonlinear);
+			up(&mapping->i_shared_sem);
+		}
 
 		/* ->populate can take a long time, so downgrade the lock. */
 		downgrade_write(&mm->mmap_sem);
--- 2.6.5-rc3-mjb2/mm/memory.c	2004-04-02 21:01:47.402846960 +0100
+++ anobjrmap9/mm/memory.c	2004-04-04 13:05:41.400471344 +0100
@@ -1077,11 +1077,11 @@ no_new_page:
  * An hlen of zero blows away the entire portion file after hba.
  */
 static void
-invalidate_mmap_range_list(struct list_head *head,
+invalidate_mmap_range_list(struct prio_tree_root *root,
 			   unsigned long const hba,
 			   unsigned long const hlen)
 {
-	struct list_head *curr;
+	struct prio_tree_iter iter;
 	unsigned long hea;	/* last page of hole. */
 	unsigned long vba;
 	unsigned long vea;	/* last page of corresponding uva hole. */
@@ -1092,17 +1092,16 @@ invalidate_mmap_range_list(struct list_h
 	hea = hba + hlen - 1;	/* avoid overflow. */
 	if (hea < hba)
 		hea = ULONG_MAX;
-	list_for_each(curr, head) {
-		vp = list_entry(curr, struct vm_area_struct, shared);
+	vp = __vma_prio_tree_first(root, &iter, hba, hea);
+	while(vp) {
 		vba = vp->vm_pgoff;
 		vea = vba + ((vp->vm_end - vp->vm_start) >> PAGE_SHIFT) - 1;
-		if (hea < vba || vea < hba)
-		    	continue;	/* Mapping disjoint from hole. */
 		zba = (hba <= vba) ? vba : hba;
 		zea = (vea <= hea) ? vea : hea;
 		zap_page_range(vp,
 			       ((zba - vba) << PAGE_SHIFT) + vp->vm_start,
 			       (zea - zba + 1) << PAGE_SHIFT);
+		vp = __vma_prio_tree_next(vp, root, &iter, hba, hea);
 	}
 }
 
@@ -1137,9 +1136,9 @@ void invalidate_mmap_range(struct addres
 	down(&mapping->i_shared_sem);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
-	if (unlikely(!list_empty(&mapping->i_mmap)))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
-	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen);
 	up(&mapping->i_shared_sem);
 }
--- 2.6.5-rc3-mjb2/mm/mmap.c	2004-04-02 21:01:47.406846352 +0100
+++ anobjrmap9/mm/mmap.c	2004-04-04 13:05:41.403470888 +0100
@@ -68,12 +68,20 @@ int mmap_hugepages_map_sz = 256;
  * Requires inode->i_mapping->i_shared_sem
  */
 static inline void
-__remove_shared_vm_struct(struct vm_area_struct *vma, struct inode *inode)
+__remove_shared_vm_struct(struct vm_area_struct *vma, struct inode *inode,
+			  struct address_space * mapping)
 {
 	if (inode) {
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_inc(&inode->i_writecount);
-		list_del_init(&vma->shared);
+		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+			list_del_init(&vma->shared.vm_set.list);
+			INIT_VMA_SHARED(vma);
+		}
+		else if (vma->vm_flags & VM_SHARED)
+			__vma_prio_tree_remove(&mapping->i_mmap_shared, vma);
+		else
+			__vma_prio_tree_remove(&mapping->i_mmap, vma);
 	}
 }
 
@@ -87,7 +95,8 @@ static void remove_shared_vm_struct(stru
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 		down(&mapping->i_shared_sem);
-		__remove_shared_vm_struct(vma, file->f_dentry->d_inode);
+		__remove_shared_vm_struct(vma, file->f_dentry->d_inode,
+				mapping);
 		up(&mapping->i_shared_sem);
 	}
 }
@@ -261,10 +270,15 @@ static inline void __vma_link_file(struc
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);
 
-		if (vma->vm_flags & VM_SHARED)
-			list_add_tail(&vma->shared, &mapping->i_mmap_shared);
+		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+			INIT_VMA_SHARED_LIST(vma);
+			list_add_tail(&vma->shared.vm_set.list,
+					&mapping->i_mmap_nonlinear);
+		}
+		else if (vma->vm_flags & VM_SHARED)
+			__vma_prio_tree_insert(&mapping->i_mmap_shared, vma);
 		else
-			list_add_tail(&vma->shared, &mapping->i_mmap);
+			__vma_prio_tree_insert(&mapping->i_mmap, vma);
 	}
 }
 
@@ -393,7 +407,9 @@ static struct vm_area_struct *vma_merge(
 {
 	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
+	struct address_space *mapping = file ? file->f_mapping : NULL;
 	struct semaphore *i_shared_sem;
+	struct prio_tree_root *root = NULL;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags, so this tests
@@ -404,6 +420,15 @@ static struct vm_area_struct *vma_merge(
 
 	i_shared_sem = file ? &file->f_mapping->i_shared_sem : NULL;
 
+	if (mapping) {
+		if (vm_flags & VM_SHARED) {
+			if (likely(!(vm_flags & VM_NONLINEAR)))
+				root = &mapping->i_mmap_shared;
+		}
+		else
+			root = &mapping->i_mmap;
+	}
+
 	if (!prev) {
 		prev = rb_entry(rb_parent, struct vm_area_struct, vm_rb);
 		goto merge_next;
@@ -423,18 +448,18 @@ static struct vm_area_struct *vma_merge(
 			need_up = 1;
 		}
 		spin_lock(lock);
-		prev->vm_end = end;
 
 		/*
 		 * OK, it did.  Can we now merge in the successor as well?
 		 */
 		next = prev->vm_next;
-		if (next && prev->vm_end == next->vm_start &&
+		if (next && end == next->vm_start &&
 				can_vma_merge_before(next, vm_flags, file,
 					pgoff, (end - addr) >> PAGE_SHIFT)) {
-			prev->vm_end = next->vm_end;
 			__vma_unlink(mm, next, prev);
-			__remove_shared_vm_struct(next, inode);
+			__vma_modify(root, prev, prev->vm_start,
+					next->vm_end, prev->vm_pgoff);
+			__remove_shared_vm_struct(next, inode, mapping);
 			spin_unlock(lock);
 			if (need_up)
 				up(i_shared_sem);
@@ -445,6 +470,8 @@ static struct vm_area_struct *vma_merge(
 			kmem_cache_free(vm_area_cachep, next);
 			return prev;
 		}
+
+		__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
 		spin_unlock(lock);
 		if (need_up)
 			up(i_shared_sem);
@@ -464,8 +491,8 @@ static struct vm_area_struct *vma_merge(
 			if (file)
 				down(i_shared_sem);
 			spin_lock(lock);
-			prev->vm_start = addr;
-			prev->vm_pgoff -= (end - addr) >> PAGE_SHIFT;
+			__vma_modify(root, prev, addr, prev->vm_end,
+				prev->vm_pgoff - ((end - addr) >> PAGE_SHIFT));
 			spin_unlock(lock);
 			if (file)
 				up(i_shared_sem);
@@ -698,7 +725,7 @@ munmap_back:
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
-	INIT_LIST_HEAD(&vma->shared);
+	INIT_VMA_SHARED(vma);
 
 	if (file) {
 		error = -EINVAL;
@@ -1289,6 +1316,7 @@ int split_vma(struct mm_struct * mm, str
 {
 	struct vm_area_struct *new;
 	struct address_space *mapping = NULL;
+	struct prio_tree_root *root = NULL;
 
 	if (mm->map_count >= MAX_MAP_COUNT)
 		return -ENOMEM;
@@ -1300,7 +1328,7 @@ int split_vma(struct mm_struct * mm, str
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
 
-	INIT_LIST_HEAD(&new->shared);
+	INIT_VMA_SHARED(new);
 
 	if (new_below)
 		new->vm_end = addr;
@@ -1315,18 +1343,25 @@ int split_vma(struct mm_struct * mm, str
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	if (vma->vm_file)
+	if (vma->vm_file) {
 		 mapping = vma->vm_file->f_mapping;
+		 if (vma->vm_flags & VM_SHARED) {
+			 if (likely(!(vma->vm_flags & VM_NONLINEAR)))
+			 	root = &mapping->i_mmap_shared;
+		 }
+		 else
+			 root = &mapping->i_mmap;
+	}
 
 	if (mapping)
 		down(&mapping->i_shared_sem);
 	spin_lock(&mm->page_table_lock);
 
-	if (new_below) {
-		vma->vm_start = addr;
-		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
-	} else
-		vma->vm_end = addr;
+	if (new_below)
+		__vma_modify(root, vma, addr, vma->vm_end,
+			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT));
+	else
+		__vma_modify(root, vma, vma->vm_start, addr, vma->vm_pgoff);
 
 	__insert_vm_struct(mm, new);
 
@@ -1499,7 +1534,7 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_pgoff = 0;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
-	INIT_LIST_HEAD(&vma->shared);
+	INIT_VMA_SHARED(vma);
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 
@@ -1597,7 +1632,7 @@ struct vm_area_struct *copy_vma(struct v
 		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (new_vma) {
 			*new_vma = *vma;
-			INIT_LIST_HEAD(&new_vma->shared);
+			INIT_VMA_SHARED(new_vma);
 			new_vma->vm_start = addr;
 			new_vma->vm_end = addr + len;
 			new_vma->vm_pgoff = pgoff;
@@ -1610,24 +1645,3 @@ struct vm_area_struct *copy_vma(struct v
 	}
 	return new_vma;
 }
-
-/*
- * Position vma after prev in shared file list:
- * for mremap move error recovery racing against vmtruncate.
- */
-void vma_relink_file(struct vm_area_struct *vma, struct vm_area_struct *prev)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct address_space *mapping;
-
-	if (vma->vm_file) {
-		mapping = vma->vm_file->f_mapping;
-		if (mapping) {
-			down(&mapping->i_shared_sem);
-			spin_lock(&mm->page_table_lock);
-			list_move(&vma->shared, &prev->shared);
-			spin_unlock(&mm->page_table_lock);
-			up(&mapping->i_shared_sem);
-		}
-	}
-}
--- 2.6.5-rc3-mjb2/mm/mremap.c	2004-04-02 21:01:47.409845896 +0100
+++ anobjrmap9/mm/mremap.c	2004-04-04 13:05:41.405470584 +0100
@@ -237,6 +237,7 @@ static int move_page_tables(struct vm_ar
 	 * only a few pages.. This also makes error recovery easier.
 	 */
 	while (offset < len) {
+		cond_resched();
 		ret = move_one_page(vma, old_addr+offset, new_addr+offset);
 		if (!ret) {
 			offset += PAGE_SIZE;
@@ -266,6 +267,7 @@ static unsigned long move_vma(struct vm_
 		unsigned long new_len, unsigned long new_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct address_space *mapping = NULL;
 	struct vm_area_struct *new_vma;
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
@@ -285,26 +287,31 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;
 
+	if (vma->vm_file) {
+		/*
+		 * Subtle point from Rajesh Venkatasubramanian: before
+		 * moving file-based ptes, we must lock vmtruncate out,
+		 * since it might clean the dst vma before the src vma,
+		 * and we propagate stale pages into the dst afterward.
+		 */
+		mapping = vma->vm_file->f_mapping;
+		down(&mapping->i_shared_sem);
+	}
 	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
 	if (moved_len < old_len) {
 		/*
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
-		 *
-		 * Subtle point from Rajesh Venkatasubramanian: before
-		 * moving file-based ptes, move new_vma before old vma
-		 * in the i_mmap or i_mmap_shared list, so when racing
-		 * against vmtruncate we cannot propagate pages to be
-		 * truncated back from new_vma into just cleaned old.
 		 */
-		vma_relink_file(vma, new_vma);
 		move_page_tables(new_vma, old_addr, new_addr, moved_len);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
 	}
+	if (mapping)
+		up(&mapping->i_shared_sem);
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
@@ -351,6 +358,8 @@ unsigned long do_mremap(unsigned long ad
 	unsigned long flags, unsigned long new_addr)
 {
 	struct vm_area_struct *vma;
+	struct address_space *mapping = NULL;
+	struct prio_tree_root *root = NULL;
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
 
@@ -458,9 +467,26 @@ unsigned long do_mremap(unsigned long ad
 		/* can we just expand the current mapping? */
 		if (max_addr - addr >= new_len) {
 			int pages = (new_len - old_len) >> PAGE_SHIFT;
+
+			if (vma->vm_file) {
+				mapping = vma->vm_file->f_mapping;
+				if (vma->vm_flags & VM_SHARED) {
+					if (likely(!(vma->vm_flags & VM_NONLINEAR)))
+						root = &mapping->i_mmap_shared;
+				}
+				else
+					root = &mapping->i_mmap;
+				down(&mapping->i_shared_sem);
+			}
+
 			spin_lock(&vma->vm_mm->page_table_lock);
-			vma->vm_end = addr + new_len;
+			__vma_modify(root, vma, vma->vm_start,
+					addr + new_len, vma->vm_pgoff);
 			spin_unlock(&vma->vm_mm->page_table_lock);
+
+			if(mapping)
+				up(&mapping->i_shared_sem);
+
 			current->mm->total_vm += pages;
 			if (vma->vm_flags & VM_LOCKED) {
 				current->mm->locked_vm += pages;
--- 2.6.5-rc3-mjb2/mm/page_io.c	2004-04-02 21:01:47.416844832 +0100
+++ anobjrmap9/mm/page_io.c	2004-04-04 13:05:41.405470584 +0100
@@ -135,12 +135,14 @@ out:
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
 	int ret;
+	unsigned long save_private;
 	struct writeback_control swap_wbc = {
 		.sync_mode = WB_SYNC_ALL,
 	};
 
 	lock_page(page);
 	SetPageSwapCache(page);
+	save_private = page->private;
 	page->private = entry.val;
 
 	if (rw == READ) {
@@ -150,7 +152,9 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
+
 	ClearPageSwapCache(page);
+	page->private = save_private;
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
--- 2.6.5-rc3-mjb2/mm/prio_tree.c	1970-01-01 01:00:00.000000000 +0100
+++ anobjrmap9/mm/prio_tree.c	2004-04-04 13:05:41.408470128 +0100
@@ -0,0 +1,577 @@
+/*
+ * mm/prio_tree.c - priority search tree for mapping->i_mmap{,_shared}
+ *
+ * Copyright (C) 2004, Rajesh Venkatasubramanian <vrajesh@umich.edu>
+ *
+ * Based on the radix priority search tree proposed by Edward M. McCreight
+ * SIAM Journal of Computing, vol. 14, no.2, pages 257-276, May 1985
+ *
+ * 02Feb2004	Initial version
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/prio_tree.h>
+
+/*
+ * A clever mix of heap and radix trees forms a radix priority search tree (PST)
+ * which is useful for storing intervals, e.g, we can consider a vma as a closed
+ * interval of file pages [offset_begin, offset_end], and store all vmas that
+ * map a file in a PST. Then, using the PST, we can answer a stabbing query,
+ * i.e., selecting a set of stored intervals (vmas) that overlap with (map) a
+ * given input interval X (a set of consecutive file pages), in "O(log n + m)"
+ * time where 'log n' is the height of the PST, and 'm' is the number of stored
+ * intervals (vmas) that overlap (map) with the input interval X (the set of
+ * consecutive file pages).
+ *
+ * In our implementation, we store closed intervals of the form [radix_index,
+ * heap_index]. We assume that always radix_index <= heap_index. McCreight's PST
+ * is designed for storing intervals with unique radix indices, i.e., each
+ * interval have different radix_index. However, this limitation can be easily
+ * overcome by using the size, i.e., heap_index - radix_index, as part of the
+ * index, so we index the tree using [(radix_index,size), heap_index].
+ *
+ * When the above-mentioned indexing scheme is used, theoretically, in a 32 bit
+ * machine, the maximum height of a PST can be 64. We can use a balanced version
+ * of the priority search tree to optimize the tree height, but the balanced
+ * tree proposed by McCreight is too complex and memory-hungry for our purpose.
+ */
+
+static unsigned long index_bits_to_maxindex[BITS_PER_LONG];
+
+/*
+ * Maximum heap_index that can be stored in a PST with index_bits bits
+ */
+static inline unsigned long prio_tree_maxindex(unsigned int bits)
+{
+	return index_bits_to_maxindex[bits - 1];
+}
+
+/*
+ * Extend a priority search tree so that it can store a node with heap_index
+ * max_heap_index. In the worst case, this algorithm takes O((log n)^2).
+ * However, this function is used rarely and the common case performance is
+ * not bad.
+ */
+static struct prio_tree_node *prio_tree_expand(struct prio_tree_root *root,
+	struct prio_tree_node *node, unsigned long max_heap_index)
+{
+	struct prio_tree_node *first = NULL, *prev, *last = NULL;
+
+	if (max_heap_index > prio_tree_maxindex(root->index_bits))
+		root->index_bits++;
+
+	while (max_heap_index > prio_tree_maxindex(root->index_bits)) {
+		root->index_bits++;
+
+		if (prio_tree_empty(root))
+			continue;
+
+		if (first == NULL) {
+			first = root->prio_tree_node;
+			prio_tree_remove(root, root->prio_tree_node);
+			INIT_PRIO_TREE_NODE(first);
+			last = first;
+		}
+		else {
+			prev = last;
+			last = root->prio_tree_node;
+			prio_tree_remove(root, root->prio_tree_node);
+			INIT_PRIO_TREE_NODE(last);
+			prev->left = last;
+			last->parent = prev;
+		}
+	}
+
+	INIT_PRIO_TREE_NODE(node);
+
+	if (first) {
+		node->left = first;
+		first->parent = node;
+	}
+	else
+		last = node;
+
+	if (!prio_tree_empty(root)) {
+		last->left = root->prio_tree_node;
+		last->left->parent = last;
+	}
+
+	root->prio_tree_node = node;
+	return node;
+}
+
+/*
+ * Replace a prio_tree_node with a new node and return the old node
+ */
+static inline struct prio_tree_node *prio_tree_replace(
+	struct prio_tree_root *root, struct prio_tree_node *old,
+	struct prio_tree_node *node)
+{
+	INIT_PRIO_TREE_NODE(node);
+
+	if (prio_tree_root(old)) {
+		BUG_ON(root->prio_tree_node != old);
+		/*
+		 * We can reduce root->index_bits here. However, it is complex
+		 * and does not help much to improve performance (IMO).
+		 */
+		node->parent = node;
+		root->prio_tree_node = node;
+	}
+	else {
+		node->parent = old->parent;
+		if (old->parent->left == old)
+			old->parent->left = node;
+		else {
+			BUG_ON(old->parent->right != old);
+			old->parent->right = node;
+		}
+	}
+
+	if (!prio_tree_left_empty(old)) {
+		node->left = old->left;
+		old->left->parent = node;
+	}
+
+	if (!prio_tree_right_empty(old)) {
+		node->right = old->right;
+		old->right->parent = node;
+	}
+
+	return old;
+}
+
+#undef	swap
+#define	swap(x,y,z)	do {z = x; x = y; y = z; } while (0)
+
+/*
+ * Insert a prio_tree_node @node into a radix priority search tree @root. The
+ * algorithm typically takes O(log n) time where 'log n' is the number of bits
+ * required to represent the maximum heap_index. In the worst case, the algo
+ * can take O((log n)^2) - check prio_tree_expand.
+ *
+ * If a prior node with same radix_index and heap_index is already found in
+ * the tree, then returns the address of the prior node. Otherwise, inserts
+ * @node into the tree and returns @node.
+ */
+
+struct prio_tree_node *prio_tree_insert(struct prio_tree_root *root,
+			struct prio_tree_node *node)
+{
+	struct prio_tree_node *cur, *res = node;
+	unsigned long radix_index, heap_index;
+	unsigned long r_index, h_index, index, mask;
+	int size_flag = 0;
+
+	GET_INDEX(node, radix_index, heap_index);
+
+	if (prio_tree_empty(root) ||
+			heap_index > prio_tree_maxindex(root->index_bits))
+		return prio_tree_expand(root, node, heap_index);
+
+	cur = root->prio_tree_node;
+	mask = 1UL << (root->index_bits - 1);
+
+	while (mask) {
+		GET_INDEX(cur, r_index, h_index);
+
+		if (r_index == radix_index && h_index == heap_index)
+			return cur;
+
+                if (h_index < heap_index || (h_index == heap_index &&
+						r_index > radix_index))
+		{
+			struct prio_tree_node *tmp = node;
+			node = prio_tree_replace(root, cur, node);
+			cur = tmp;
+			swap(r_index, radix_index, index);
+			swap(h_index, heap_index, index);
+		}
+
+		if (size_flag)
+			index = heap_index - radix_index;
+		else
+			index = radix_index;
+
+		if (index & mask) {
+			if (prio_tree_right_empty(cur)) {
+				INIT_PRIO_TREE_NODE(node);
+				cur->right = node;
+				node->parent = cur;
+				return res;
+			}
+			else
+				cur = cur->right;
+		}
+		else {
+			if (prio_tree_left_empty(cur)) {
+				INIT_PRIO_TREE_NODE(node);
+				cur->left = node;
+				node->parent = cur;
+				return res;
+			}
+			else
+				cur = cur->left;
+		}
+
+		mask >>= 1;
+
+		if (!mask) {
+			mask = 1UL << (root->index_bits - 1);
+			size_flag = 1;
+		}
+	}
+	/* Should not reach here */
+	BUG();
+	return NULL;
+}
+
+/*
+ * Remove a prio_tree_node @node from a radix priority search tree @root. The
+ * algorithm takes O(log n) time where 'log n' is the number of bits required
+ * to represent the maximum heap_index.
+ */
+
+void prio_tree_remove(struct prio_tree_root *root, struct prio_tree_node *node)
+{
+	struct prio_tree_node *cur;
+	unsigned long r_index, h_index_right, h_index_left;
+
+	cur = node;
+
+	while (!prio_tree_left_empty(cur) || !prio_tree_right_empty(cur)) {
+		if (!prio_tree_left_empty(cur))
+			GET_INDEX(cur->left, r_index, h_index_left);
+		else {
+			cur = cur->right;
+			continue;
+		}
+
+		if (!prio_tree_right_empty(cur))
+			GET_INDEX(cur->right, r_index, h_index_right);
+		else {
+			cur = cur->left;
+			continue;
+		}
+
+		/* both h_index_left and h_index_right cannot be 0 */
+		if (h_index_left >= h_index_right)
+			cur = cur->left;
+		else
+			cur = cur->right;
+	}
+
+	if (prio_tree_root(cur)) {
+		BUG_ON(root->prio_tree_node != cur);
+		*root = PRIO_TREE_ROOT;
+		return;
+	}
+
+	if (cur->parent->right == cur)
+		cur->parent->right = cur->parent;
+	else {
+		BUG_ON(cur->parent->left != cur);
+		cur->parent->left = cur->parent;
+	}
+
+	while (cur != node)
+		cur = prio_tree_replace(root, cur->parent, cur);
+
+	return;
+}
+
+/*
+ * Following functions help to enumerate all prio_tree_nodes in the tree that
+ * overlap with the input interval X [radix_index, heap_index]. The enumeration
+ * takes O(log n + m) time where 'log n' is the height of the tree (which is
+ * proportional to # of bits required to represent the maximum heap_index) and
+ * 'm' is the number of prio_tree_nodes that overlap the interval X.
+ */
+
+static inline struct prio_tree_node *__prio_tree_left(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long radix_index, unsigned long heap_index,
+	unsigned long *r_index, unsigned long *h_index)
+{
+	if (prio_tree_left_empty(iter->cur))
+		return NULL;
+
+	GET_INDEX(iter->cur->left, *r_index, *h_index);
+
+	if (radix_index <= *h_index) {
+		iter->cur = iter->cur->left;
+		iter->mask >>= 1;
+		if (iter->mask) {
+			if (iter->size_level)
+				iter->size_level++;
+		}
+		else {
+			iter->size_level = 1;
+			iter->mask = 1UL << (root->index_bits - 1);
+		}
+		return iter->cur;
+	}
+
+	return NULL;
+}
+
+
+static inline struct prio_tree_node *__prio_tree_right(
+	struct prio_tree_root *root, struct prio_tree_iter *iter,
+	unsigned long radix_index, unsigned long heap_index,
+	unsigned long *r_index, unsigned long *h_index)
+{
+	unsigned long value;
+
+	if (prio_tree_right_empty(iter->cur))
+		return NULL;
+
+	if (iter->size_level)
+		value = iter->value;
+	else
+		value = iter->value | iter->mask;
+
+	if (heap_index < value)
+		return NULL;
+
+	GET_INDEX(iter->cur->right, *r_index, *h_index);
+
+	if (radix_index <= *h_index) {
+		iter->cur = iter->cur->right;
+		iter->mask >>= 1;
+		iter->value = value;
+		if (iter->mask) {
+			if (iter->size_level)
+				iter->size_level++;
+		}
+		else {
+			iter->size_level = 1;
+			iter->mask = 1UL << (root->index_bits - 1);
+		}
+		return iter->cur;
+	}
+
+	return NULL;
+}
+
+static inline struct prio_tree_node *__prio_tree_parent(
+	struct prio_tree_iter *iter)
+{
+	iter->cur = iter->cur->parent;
+	iter->mask <<= 1;
+	if (iter->size_level) {
+		if (iter->size_level == 1)
+			iter->mask = 1UL;
+		iter->size_level--;
+	}
+	else if (iter->value & iter->mask)
+		iter->value ^= iter->mask;
+	return iter->cur;
+}
+
+static inline int overlap(unsigned long radix_index, unsigned long heap_index,
+	unsigned long r_index, unsigned long h_index)
+{
+	if (heap_index < r_index || radix_index > h_index)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * prio_tree_first:
+ *
+ * Get the first prio_tree_node that overlaps with the interval [radix_index,
+ * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
+ * traversal of the tree.
+ */
+struct prio_tree_node *prio_tree_first(struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long radix_index,
+	unsigned long heap_index)
+{
+	unsigned long r_index, h_index;
+
+	*iter = PRIO_TREE_ITER;
+
+	if (prio_tree_empty(root))
+		return NULL;
+
+	GET_INDEX(root->prio_tree_node, r_index, h_index);
+
+	if (radix_index > h_index)
+		return NULL;
+
+	iter->mask = 1UL << (root->index_bits - 1);
+	iter->cur = root->prio_tree_node;
+
+	while (1) {
+		if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+
+		if (__prio_tree_left(root, iter, radix_index, heap_index,
+					&r_index, &h_index))
+			continue;
+
+		if (__prio_tree_right(root, iter, radix_index, heap_index,
+					&r_index, &h_index))
+			continue;
+
+		break;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(prio_tree_first);
+
+/* Get the next prio_tree_node that overlaps with the input interval in iter */
+struct prio_tree_node *prio_tree_next(struct prio_tree_root *root,
+	struct prio_tree_iter *iter, unsigned long radix_index,
+	unsigned long heap_index)
+{
+	unsigned long r_index, h_index;
+
+repeat:
+	while (__prio_tree_left(root, iter, radix_index, heap_index,
+				&r_index, &h_index))
+		if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+
+	while (!__prio_tree_right(root, iter, radix_index, heap_index,
+				&r_index, &h_index)) {
+	    	while (!prio_tree_root(iter->cur) &&
+				iter->cur->parent->right == iter->cur)
+			__prio_tree_parent(iter);
+
+		if (prio_tree_root(iter->cur))
+			return NULL;
+
+		__prio_tree_parent(iter);
+	}
+
+	if (overlap(radix_index, heap_index, r_index, h_index))
+			return iter->cur;
+
+	goto repeat;
+}
+EXPORT_SYMBOL(prio_tree_next);
+
+/*
+ * Radix priority search tree for address_space->i_mmap_{_shared}
+ *
+ * For each vma that map a unique set of file pages i.e., unique [radix_index,
+ * heap_index] value, we have a corresponing priority search tree node. If
+ * multiple vmas have identical [radix_index, heap_index] value, then one of
+ * them is used as a tree node and others are stored in a vm_set list. The tree
+ * node points to the first vma (head) of the list using vm_set_head.
+ *
+ * prio_tree_root
+ *      |
+ *      A       vm_set_head
+ *     / \      /
+ *    L   R -> H-I-J-K-M-N-O-P-Q-S
+ *    ^   ^    <-- vm_set.list -->
+ *  tree nodes
+ *
+ * We need some way to identify whether a vma is a tree node, head of a vm_set
+ * list, or just a member of a vm_set list. We cannot use vm_flags to store
+ * such information. The reason is, in the above figure, it is possible that
+ * vm_flags' of R and H are covered by the different mmap_sems. When R is
+ * removed under R->mmap_sem, H replaces R as a tree node. Since we do not hold
+ * H->mmap_sem, we cannot use H->vm_flags for marking that H is a tree node now.
+ * That's why some trick involving shared.both.parent is used for identifying
+ * tree nodes and list head nodes. We can possibly use the least significant
+ * bit of the vm_set_head field to mark tree and list head nodes. I was worried
+ * about the alignment of vm_area_struct in various architectures.
+ *
+ * vma radix priority search tree node rules:
+ *
+ * vma->shared.both.parent != NULL	==>	a tree node
+ *
+ * vma->shared.both.parent == NULL
+ * 	vma->vm_set_head != NULL  ==>  list head of vmas that map same pages
+ * 	vma->vm_set_head == NULL  ==>  a list node
+ */
+
+void __vma_prio_tree_insert(struct prio_tree_root *root,
+	struct vm_area_struct *vma)
+{
+	struct prio_tree_node *ptr;
+	struct vm_area_struct *old;
+
+	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
+
+	if (ptr == &vma->shared.prio_tree_node) {
+		vma->vm_set_head = NULL;
+		return;
+	}
+
+	old = prio_tree_entry(ptr, struct vm_area_struct,
+			shared.prio_tree_node);
+
+	__vma_prio_tree_add(vma, old);
+}
+
+void __vma_prio_tree_remove(struct prio_tree_root *root,
+	struct vm_area_struct *vma)
+{
+	struct vm_area_struct *node, *head, *new_head;
+
+	if (vma->shared.both.parent == NULL && vma->vm_set_head == NULL) {
+		list_del_init(&vma->shared.vm_set.list);
+		INIT_VMA_SHARED(vma);
+		return;
+	}
+
+	if (vma->vm_set_head) {
+		/* Leave this BUG_ON till prio_tree patch stabilizes */
+		BUG_ON(vma->vm_set_head->vm_set_head != vma);
+		if (vma->shared.both.parent) {
+			head = vma->vm_set_head;
+			if (!list_empty(&head->shared.vm_set.list)) {
+				new_head = list_entry(
+					head->shared.vm_set.list.next,
+					struct vm_area_struct,
+					shared.vm_set.list);
+				list_del_init(&head->shared.vm_set.list);
+			}
+			else
+				new_head = NULL;
+
+			prio_tree_replace(root, &vma->shared.prio_tree_node,
+					&head->shared.prio_tree_node);
+			head->vm_set_head = new_head;
+			if (new_head)
+				new_head->vm_set_head = head;
+
+		}
+		else {
+			node = vma->vm_set_head;
+			if (!list_empty(&vma->shared.vm_set.list)) {
+				new_head = list_entry(
+					vma->shared.vm_set.list.next,
+					struct vm_area_struct,
+					shared.vm_set.list);
+				list_del_init(&vma->shared.vm_set.list);
+				node->vm_set_head = new_head;
+				new_head->vm_set_head = node;
+			}
+			else
+				node->vm_set_head = NULL;
+		}
+		INIT_VMA_SHARED(vma);
+		return;
+	}
+
+	prio_tree_remove(root, &vma->shared.prio_tree_node);
+	INIT_VMA_SHARED(vma);
+}
+
+void __init prio_tree_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(index_bits_to_maxindex) - 1; i++)
+		index_bits_to_maxindex[i] = (1UL << (i + 1)) - 1;
+	index_bits_to_maxindex[ARRAY_SIZE(index_bits_to_maxindex) - 1] = ~0UL;
+}
--- 2.6.5-rc3-mjb2/mm/rmap.c	2004-04-02 21:01:47.423843768 +0100
+++ anobjrmap9/mm/rmap.c	2004-04-04 13:05:41.411469672 +0100
@@ -154,19 +154,16 @@ static inline void clear_page_anon(struc
  **/
 
 /*
- * At what user virtual address is page expected in file-backed vma?
+ * At what user virtual address is pgoff expected in file-backed vma?
  */
-#define NOADDR	(~0UL)		/* impossible user virtual address */
 static inline unsigned long
-vma_address(struct page *page, struct vm_area_struct *vma)
+vma_address(struct vm_area_struct *vma, unsigned long pgoff)
 {
-	unsigned long pgoff;
 	unsigned long address;
 
-	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	return (address >= vma->vm_start && address < vma->vm_end)?
-		address: NOADDR;
+	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+	return address;
 }
 
 /**
@@ -182,8 +179,14 @@ static int page_referenced_one(struct pa
 	pte_t *pte;
 	int referenced = 0;
 
-	if (!spin_trylock(&mm->page_table_lock))
+	if (!spin_trylock(&mm->page_table_lock)) {
+		/*
+		 * For debug we're currently warning if not all found,
+		 * but in this case that's expected: suppress warning.
+		 */
+		*mapcount = -1;
 		return 0;
+	}
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -246,6 +249,8 @@ static inline int page_referenced_anon(s
 		if (!*mapcount)
 			goto out;
 	}
+	
+	WARN_ON(*mapcount > 0);
 out:
 	spin_unlock(&anonhd->lock);
 	return referenced;
@@ -268,45 +273,54 @@ out:
 static inline int page_referenced_obj(struct page *page, int *mapcount)
 {
 	struct address_space *mapping = page->mapping;
+	unsigned long pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
 	unsigned long address;
 	int referenced = 0;
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return 0;
 
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		if (!vma->vm_mm->rss)
-			continue;
-		address = vma_address(page, vma);
-		if (address == NOADDR)
-			continue;
-		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE)) ==
-					(VM_LOCKED|VM_MAYSHARE)) {
+	vma = __vma_prio_tree_first(&mapping->i_mmap,
+					&iter, pgoff, pgoff);
+	while (vma) {
+		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
+				  == (VM_LOCKED|VM_MAYSHARE)) {
 			referenced++;
 			goto out;
 		}
-		referenced += page_referenced_one(
-			page, vma->vm_mm, address, mapcount);
-		if (!*mapcount)
-			goto out;
+		if (vma->vm_mm->rss) {
+			address = vma_address(vma, pgoff);
+			referenced += page_referenced_one(
+				page, vma->vm_mm, address, mapcount);
+			if (!*mapcount)
+				goto out;
+		}
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap,
+						&iter, pgoff, pgoff);
 	}
 
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if (!vma->vm_mm->rss || (vma->vm_flags & VM_NONLINEAR))
-			continue;
-		address = vma_address(page, vma);
-		if (address == NOADDR)
-			continue;
+	vma = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (vma) {
 		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
 			referenced++;
 			goto out;
 		}
-		referenced += page_referenced_one(
-			page, vma->vm_mm, address, mapcount);
-		if (!*mapcount)
-			goto out;
+		if (vma->vm_mm->rss) {
+			address = vma_address(vma, pgoff);
+			referenced += page_referenced_one(
+				page, vma->vm_mm, address, mapcount);
+			if (!*mapcount)
+				goto out;
+		}
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
+
+	if (list_empty(&mapping->i_mmap_nonlinear))
+		WARN_ON(*mapcount > 0);
 out:
 	up(&mapping->i_shared_sem);
 	return referenced;
@@ -688,7 +702,9 @@ out:
 static inline int try_to_unmap_obj(struct page *page, int *mapcount)
 {
 	struct address_space *mapping = page->mapping;
+	unsigned long pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
 	unsigned long address;
 	int ret = SWAP_AGAIN;
 	unsigned long cursor;
@@ -698,47 +714,50 @@ static inline int try_to_unmap_obj(struc
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
 
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		if (!vma->vm_mm->rss)
-			continue;
-		address = vma_address(page, vma);
-		if (address == NOADDR)
-			continue;
-		ret = try_to_unmap_one(
-			page, vma->vm_mm, address, mapcount, vma);
-		if (ret == SWAP_FAIL || !*mapcount)
-			goto out;
+	vma = __vma_prio_tree_first(&mapping->i_mmap,
+					&iter, pgoff, pgoff);
+	while (vma) {
+		if (vma->vm_mm->rss) {
+			address = vma_address(vma, pgoff);
+			ret = try_to_unmap_one(
+				page, vma->vm_mm, address, mapcount, vma);
+			if (ret == SWAP_FAIL || !*mapcount)
+				goto out;
+		}
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap,
+						&iter, pgoff, pgoff);
 	}
 
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
-			/*
-			 * Defer unmapping nonlinear to the next loop,
-			 * but take notes while we're here e.g. don't
-			 * want to loop again when no nonlinear vmas.
-			 */
-			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
-				continue;
-			cursor = (unsigned long) vma->vm_private_data;
-			if (cursor > max_nl_cursor)
-				max_nl_cursor = cursor;
-			cursor = vma->vm_end - vma->vm_start;
-			if (cursor > max_nl_size)
-				max_nl_size = cursor;
-			continue;
+	vma = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (vma) {
+		if (vma->vm_mm->rss) {
+			address = vma_address(vma, pgoff);
+			ret = try_to_unmap_one(
+				page, vma->vm_mm, address, mapcount, vma);
+			if (ret == SWAP_FAIL || !*mapcount)
+				goto out;
 		}
-		if (!vma->vm_mm->rss)
-			continue;
-		address = vma_address(page, vma);
-		if (address == NOADDR)
-			continue;
-		ret = try_to_unmap_one(
-			page, vma->vm_mm, address, mapcount, vma);
-		if (ret == SWAP_FAIL || !*mapcount)
-			goto out;
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 
-	if (max_nl_size == 0)	/* no nonlinear vmas of this file */
+	if (list_empty(&mapping->i_mmap_nonlinear))
+		goto out;
+
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
+			continue;
+		cursor = (unsigned long) vma->vm_private_data;
+		if (cursor > max_nl_cursor)
+			max_nl_cursor = cursor;
+		cursor = vma->vm_end - vma->vm_start;
+		if (cursor > max_nl_size)
+			max_nl_size = cursor;
+	}
+
+	if (max_nl_size == 0)
 		goto out;
 
 	/*
@@ -755,9 +774,9 @@ static inline int try_to_unmap_obj(struc
 		max_nl_cursor = CLUSTER_SIZE;
 
 	do {
-		list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-			if (VM_NONLINEAR != (vma->vm_flags &
-			     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
+		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
 			while (vma->vm_mm->rss &&
@@ -771,6 +790,7 @@ static inline int try_to_unmap_obj(struc
 				vma->vm_private_data = (void *) cursor;
 				if (*mapcount <= 0)
 					goto relock;
+				cond_resched();
 			}
 			if (ret != SWAP_FAIL)
 				vma->vm_private_data =
@@ -785,9 +805,9 @@ static inline int try_to_unmap_obj(struc
 	 * in locked vmas).  Reset cursor on all unreserved nonlinear
 	 * vmas, now forgetting on which ones it had fallen behind.
 	 */
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if ((vma->vm_flags & (VM_NONLINEAR|VM_RESERVED)) ==
-				VM_NONLINEAR)
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+		if (!(vma->vm_flags & VM_RESERVED))
 			vma->vm_private_data = 0;
 	}
 relock:
--- 2.6.5-rc3-mjb2/mm/shmem.c	2004-04-02 21:01:47.427843160 +0100
+++ anobjrmap9/mm/shmem.c	2004-04-04 13:05:41.413469368 +0100
@@ -1351,7 +1351,8 @@ static void do_shmem_file_read(struct fi
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (!list_empty(&mapping->i_mmap_shared))
+			if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+				!list_empty(&mapping->i_mmap_nonlinear))
 				flush_dcache_page(page);
 			/*
 			 * Mark the page accessed if we read the beginning.
--- 2.6.5-rc3-mjb2/mm/vmscan.c	2004-04-02 21:01:47.443840728 +0100
+++ anobjrmap9/mm/vmscan.c	2004-04-04 13:05:41.415469064 +0100
@@ -191,9 +191,11 @@ static inline int page_mapping_inuse(str
 		return 0;
 
 	/* File is mmap'd by somebody. */
-	if (!list_empty(&mapping->i_mmap))
+	if (!prio_tree_empty(&mapping->i_mmap))
 		return 1;
-	if (!list_empty(&mapping->i_mmap_shared))
+	if (!prio_tree_empty(&mapping->i_mmap_shared))
+		return 1;
+	if (!list_empty(&mapping->i_mmap_nonlinear))
 		return 1;
 
 	return 0;

