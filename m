Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUC0T7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 14:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUC0T7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 14:59:23 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:60397 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261869AbUC0T6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 14:58:53 -0500
Date: Sat, 27 Mar 2004 14:51:45 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: akpm@osdl.org, hugh@veritas.com, riel@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
 fix
In-Reply-To: <20040326175842.GC9604@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0403271448120.28539@sapphire.engin.umich.edu>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
 <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
 <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
 <20040326075343.GB12484@dualathlon.random> <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu>
 <20040326175842.GC9604@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a list_head i_mmap_nonlinear to the address_space
structure. The list is used for storing all nonlinear vmas. This
is helpful in try_to_unmap_inode to find all nonlinear mappings of
a file.

This patch does not change invalidate_mmap_range_list. Already
the behavior of truncate on nonlinear mappings is undefined. We
understand that nonlinear mappings do not guarantee SIGBUS on
truncate. After this patch, we do not touch nonlinear maps on
the truncate path. So it is assured that the nonlinear maps will
not be destroyed by a truncate.

I am not happy with the truncate behavior on nonlinear maps. I
think we can guarantee SIGBUS on nonlinear maps by reusing Andrea's
try_to_unmap_nonlinear code. But, I have to study more to do that.
So I am leaving that for future.

This patch is against 2.6.5-rc2-aa4. The patch was tested in a
SMP m/c. It boots and compiles a kernel without any problem.

Please review and apply.

Thanks,
Rajesh


 fs/inode.c         |    1 +
 fs/locks.c         |    6 ++++--
 include/linux/fs.h |    1 +
 mm/filemap.c       |    3 ++-
 mm/fremap.c        |   14 +++++++++++++-
 mm/mmap.c          |   25 +++++++++++++++++++------
 mm/mremap.c        |    6 ++++--
 mm/objrmap.c       |   10 +++++++++-
 mm/shmem.c         |    3 ++-
 mm/swap_state.c    |    1 +
 mm/vmscan.c        |    2 ++
 11 files changed, 58 insertions(+), 14 deletions(-)

diff -puN include/linux/fs.h~010_nonlinear include/linux/fs.h
--- mmlinux-2.6/include/linux/fs.h~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/include/linux/fs.h	2004-03-27 14:25:07.000000000 -0500
@@ -328,6 +328,7 @@ struct address_space {
 	struct address_space_operations *a_ops;	/* methods */
 	struct prio_tree_root	i_mmap;		/* tree of private mappings */
 	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
+	struct list_head	i_mmap_nonlinear;/*list of nonlinear mappings */
 	struct semaphore	i_shared_sem;	/* protect both above lists */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
diff -puN fs/inode.c~010_nonlinear fs/inode.c
--- mmlinux-2.6/fs/inode.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/fs/inode.c	2004-03-27 14:25:07.000000000 -0500
@@ -187,6 +187,7 @@ void inode_init_once(struct inode *inode
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
 	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
+	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
 }
diff -puN fs/locks.c~010_nonlinear fs/locks.c
--- mmlinux-2.6/fs/locks.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/fs/locks.c	2004-03-27 14:25:07.000000000 -0500
@@ -1455,7 +1455,8 @@ int fcntl_setlk(struct file *filp, unsig
 	if (IS_MANDLOCK(inode) &&
 	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
 		struct address_space *mapping = filp->f_mapping;
-		if (!prio_tree_empty(&mapping->i_mmap_shared)) {
+		if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+			!list_empty(&mapping->i_mmap_nonlinear)) {
 			error = -EAGAIN;
 			goto out;
 		}
@@ -1592,7 +1593,8 @@ int fcntl_setlk64(struct file *filp, uns
 	if (IS_MANDLOCK(inode) &&
 	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
 		struct address_space *mapping = filp->f_mapping;
-		if (!prio_tree_empty(&mapping->i_mmap_shared)) {
+		if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+			!list_empty(&mapping->i_mmap_nonlinear)) {
 			error = -EAGAIN;
 			goto out;
 		}
diff -puN mm/filemap.c~010_nonlinear mm/filemap.c
--- mmlinux-2.6/mm/filemap.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/filemap.c	2004-03-27 14:25:07.000000000 -0500
@@ -650,7 +650,8 @@ page_ok:
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
 		 */
-		if (!prio_tree_empty(&mapping->i_mmap_shared))
+		if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+			!list_empty(&mapping->i_mmap_nonlinear))
 			flush_dcache_page(page);

 		/*
diff -puN mm/shmem.c~010_nonlinear mm/shmem.c
--- mmlinux-2.6/mm/shmem.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/shmem.c	2004-03-27 14:25:07.000000000 -0500
@@ -1328,7 +1328,8 @@ static void do_shmem_file_read(struct fi
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (!prio_tree_empty(&mapping->i_mmap_shared))
+			if (!prio_tree_empty(&mapping->i_mmap_shared) ||
+				!list_empty(&mapping->i_mmap_nonlinear))
 				flush_dcache_page(page);
 			/*
 			 * Mark the page accessed if we read the beginning.
diff -puN mm/swap_state.c~010_nonlinear mm/swap_state.c
--- mmlinux-2.6/mm/swap_state.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/swap_state.c	2004-03-27 14:25:07.000000000 -0500
@@ -30,6 +30,7 @@ struct address_space swapper_space = {
 	.backing_dev_info = &swap_backing_dev_info,
 	.i_mmap		= PRIO_TREE_ROOT_INIT,
 	.i_mmap_shared	= PRIO_TREE_ROOT_INIT,
+	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
 	.truncate_count  = ATOMIC_INIT(0),
 	.private_lock	= SPIN_LOCK_UNLOCKED,
diff -puN mm/vmscan.c~010_nonlinear mm/vmscan.c
--- mmlinux-2.6/mm/vmscan.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/vmscan.c	2004-03-27 14:25:07.000000000 -0500
@@ -195,6 +195,8 @@ static inline int page_mapping_inuse(str
 		return 1;
 	if (!prio_tree_empty(&mapping->i_mmap_shared))
 		return 1;
+	if (!list_empty(&mapping->i_mmap_nonlinear))
+		return 1;

 	return 0;
 }
diff -puN mm/fremap.c~010_nonlinear mm/fremap.c
--- mmlinux-2.6/mm/fremap.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/fremap.c	2004-03-27 14:25:07.000000000 -0500
@@ -151,6 +151,8 @@ asmlinkage long sys_remap_file_pages(uns
 	unsigned long __prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct address_space *mapping;
+	unsigned long linear_pgoff;
 	unsigned long end = start + size;
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
@@ -187,9 +189,19 @@ asmlinkage long sys_remap_file_pages(uns
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end) {

+		linear_pgoff = vma->vm_pgoff;
+		linear_pgoff +=  ((start - vma->vm_start) >> PAGE_SHIFT);
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff)
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
diff -puN mm/mmap.c~010_nonlinear mm/mmap.c
--- mmlinux-2.6/mm/mmap.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mmap.c	2004-03-27 14:25:07.000000000 -0500
@@ -81,7 +81,11 @@ __remove_shared_vm_struct(struct vm_area
 	if (inode) {
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_inc(&inode->i_writecount);
-		if (vma->vm_flags & VM_SHARED)
+		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+			list_del_init(&vma->shared.vm_set.list);
+			INIT_VMA_SHARED(vma);
+		}
+		else if (vma->vm_flags & VM_SHARED)
 			__vma_prio_tree_remove(&mapping->i_mmap_shared, vma);
 		else
 			__vma_prio_tree_remove(&mapping->i_mmap, vma);
@@ -273,7 +277,12 @@ static inline void __vma_link_file(struc
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);

-		if (vma->vm_flags & VM_SHARED)
+		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+			INIT_VMA_SHARED_LIST(vma);
+			list_add_tail(&vma->shared.vm_set.list,
+					&mapping->i_mmap_nonlinear);
+		}
+		else if (vma->vm_flags & VM_SHARED)
 			__vma_prio_tree_insert(&mapping->i_mmap_shared, vma);
 		else
 			__vma_prio_tree_insert(&mapping->i_mmap, vma);
@@ -430,8 +439,10 @@ static int vma_merge(struct mm_struct *m
 	i_shared_sem = file ? &file->f_mapping->i_shared_sem : NULL;

 	if (mapping) {
-		if (vm_flags & VM_SHARED)
-			root = &mapping->i_mmap_shared;
+		if (vm_flags & VM_SHARED) {
+			if (likely(!(vm_flags & VM_NONLINEAR)))
+				root = &mapping->i_mmap_shared;
+		}
 		else
 			root = &mapping->i_mmap;
 	}
@@ -1271,8 +1282,10 @@ int split_vma(struct mm_struct * mm, str
 	if (vma->vm_file) {
 		 mapping = vma->vm_file->f_mapping;

-		 if (vma->vm_flags & VM_SHARED)
-			 root = &mapping->i_mmap_shared;
+		 if (vma->vm_flags & VM_SHARED) {
+			 if (likely(!(vma->vm_flags & VM_NONLINEAR)))
+			 	root = &mapping->i_mmap_shared;
+		 }
 		 else
 			 root = &mapping->i_mmap;
 	}
diff -puN mm/mremap.c~010_nonlinear mm/mremap.c
--- mmlinux-2.6/mm/mremap.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/mremap.c	2004-03-27 14:25:07.000000000 -0500
@@ -413,8 +413,10 @@ unsigned long do_mremap(unsigned long ad

 			if (vma->vm_file) {
 				mapping = vma->vm_file->f_mapping;
-				if (vma->vm_flags & VM_SHARED)
-					root = &mapping->i_mmap_shared;
+				if (vma->vm_flags & VM_SHARED) {
+					if (likely(!(vma->vm_flags & VM_NONLINEAR)))
+						root = &mapping->i_mmap_shared;
+				}
 				else
 					root = &mapping->i_mmap;
 				down(&mapping->i_shared_sem);
diff -puN mm/objrmap.c~010_nonlinear mm/objrmap.c
--- mmlinux-2.6/mm/objrmap.c~010_nonlinear	2004-03-27 14:25:07.000000000 -0500
+++ mmlinux-2.6-jaya/mm/objrmap.c	2004-03-27 14:25:07.000000000 -0500
@@ -133,8 +133,10 @@ page_referenced_one(struct vm_area_struc
 	 * Tracking the referenced info is too expensive
 	 * for nonlinear mappings.
 	 */
-	if (vma->vm_flags & VM_NONLINEAR)
+	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
+		BUG();
 		goto out;
+	}

 	if (unlikely(!spin_trylock(&mm->page_table_lock)))
 		goto out;
@@ -630,6 +632,12 @@ try_to_unmap_inode(struct page *page)
 				loffset, loffset);
 	}

+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list) {
+		ret = try_to_unmap_one(vma, page, &young);
+		if (ret == SWAP_FAIL || !page->mapcount)
+			goto out;
+	}
+
 out:
 	up(&mapping->i_shared_sem);
 	return ret;

_
