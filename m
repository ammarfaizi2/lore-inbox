Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUEDWSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUEDWSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUEDWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:18:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:59794 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261340AbUEDWSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:18:39 -0400
Date: Tue, 4 May 2004 23:18:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 20 i_mmap_shared into i_mmap
Message-ID: <Pine.LNX.4.44.0405042315160.2156-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a batch of four patches against 2.6.6-rc3-mm1.

rmap 20 i_mmap_shared into i_mmap

Why should struct address_space have separate i_mmap and i_mmap_shared
prio_trees (separating !VM_SHARED and VM_SHARED vmas)?  No good reason,
the same processing is usually needed on both.  Merge i_mmap_shared into
i_mmap, but keep i_mmap_writable count of VM_SHARED vmas (those capable
of dirtying the underlying file) for the mapping_writably_mapped test.

The VM_MAYSHARE test in the arm and parisc loops is not necessarily what
they will want to use in the end: it's provided as a harmless example of
what might be appropriate, but maintainers are likely to revise it later
(that parisc loop is currently being changed in the parisc tree anyway).

On the way, remove the now out-of-date comments on vm_area_struct size.

 Documentation/cachetlb.txt |    8 ++++----
 arch/arm/mm/fault-armv.c   |    8 ++++++--
 arch/parisc/kernel/cache.c |   23 ++---------------------
 fs/hugetlbfs/inode.c       |    4 +---
 fs/inode.c                 |    1 -
 include/linux/fs.h         |   12 +++++-------
 include/linux/mm.h         |   11 +++--------
 mm/fremap.c                |    2 +-
 mm/memory.c                |   10 ++--------
 mm/mmap.c                  |   22 ++++++++++------------
 mm/prio_tree.c             |    6 +++---
 mm/rmap.c                  |   26 --------------------------
 12 files changed, 37 insertions(+), 96 deletions(-)

--- 2.6.6-rc3-mm1/Documentation/cachetlb.txt	2003-10-08 20:24:56.000000000 +0100
+++ rmap20/Documentation/cachetlb.txt	2004-05-04 21:21:28.882451984 +0100
@@ -322,10 +322,10 @@ maps this page at its virtual address.
 	about doing this.
 
 	The idea is, first at flush_dcache_page() time, if
-	page->mapping->i_mmap{,_shared} are empty lists, just mark the
-	architecture private page flag bit.  Later, in
-	update_mmu_cache(), a check is made of this flag bit, and if
-	set the flush is done and the flag bit is cleared.
+	page->mapping->i_mmap is an empty tree and ->i_mmap_nonlinear
+	an empty list, just mark the architecture private page flag bit.
+	Later, in update_mmu_cache(), a check is made of this flag bit,
+	and if set the flush is done and the flag bit is cleared.
 
 	IMPORTANT NOTE: It is often important, if you defer the flush,
 			that the actual flush occurs on the same CPU
--- 2.6.6-rc3-mm1/arch/arm/mm/fault-armv.c	2004-04-30 11:58:41.000000000 +0100
+++ rmap20/arch/arm/mm/fault-armv.c	2004-05-04 21:21:28.883451832 +0100
@@ -94,13 +94,15 @@ void __flush_dcache_page(struct page *pa
 	 * and invalidate any user data.
 	 */
 	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
 		if (mpnt->vm_mm != mm)
 			continue;
+		if (!(mpnt->vm_flags & VM_MAYSHARE))
+			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		flush_cache_page(mpnt, mpnt->vm_start + offset);
 	}
@@ -127,7 +129,7 @@ make_coherent(struct vm_area_struct *vma
 	 * space, then we need to handle them specially to maintain
 	 * cache coherency.
 	 */
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
@@ -136,6 +138,8 @@ make_coherent(struct vm_area_struct *vma
 		 */
 		if (mpnt->vm_mm != mm || mpnt == vma)
 			continue;
+		if (!(mpnt->vm_flags & VM_MAYSHARE))
+			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
 	}
--- 2.6.6-rc3-mm1/arch/parisc/kernel/cache.c	2004-04-30 11:58:43.000000000 +0100
+++ rmap20/arch/parisc/kernel/cache.c	2004-05-04 21:21:28.883451832 +0100
@@ -244,33 +244,14 @@ void __flush_dcache_page(struct page *pa
 
 	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
-	/* check shared list first if it's not empty...it's usually
-	 * the shortest */
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
 		if (mpnt->vm_mm != mm)
 			continue;
-
-		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		flush_cache_page(mpnt, mpnt->vm_start + offset);
-
-		/* All user shared mappings should be equivalently mapped,
-		 * so once we've flushed one we should be ok
-		 */
-		return;
-	}
-
-	/* then check private mapping list for read only shared mappings
-	 * which are flagged by VM_MAYSHARE */
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
-					&iter, pgoff, pgoff)) != NULL) {
-		/*
-		 * If this VMA is not in our MM, we can ignore it.
-		 */
-		if (mpnt->vm_mm != mm || !(mpnt->vm_flags & VM_MAYSHARE))
+		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
--- 2.6.6-rc3-mm1/fs/hugetlbfs/inode.c	2004-04-30 11:58:45.000000000 +0100
+++ rmap20/fs/hugetlbfs/inode.c	2004-05-04 21:21:28.885451528 +0100
@@ -266,7 +266,7 @@ static void hugetlbfs_drop_inode(struct 
  * h_pgoff is in HPAGE_SIZE units.
  * vma->vm_pgoff is in PAGE_SIZE units.
  */
-static void
+static inline void
 hugetlb_vmtruncate_list(struct prio_tree_root *root, unsigned long h_pgoff)
 {
 	struct vm_area_struct *vma = NULL;
@@ -312,8 +312,6 @@ static int hugetlb_vmtruncate(struct ino
 	spin_lock(&mapping->i_shared_lock);
 	if (!prio_tree_empty(&mapping->i_mmap))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
-	if (!prio_tree_empty(&mapping->i_mmap_shared))
-		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	spin_unlock(&mapping->i_shared_lock);
 	truncate_hugepages(mapping, offset);
 	return 0;
--- 2.6.6-rc3-mm1/fs/inode.c	2004-04-30 11:58:45.000000000 +0100
+++ rmap20/fs/inode.c	2004-05-04 21:21:28.886451376 +0100
@@ -189,7 +189,6 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
-	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
--- 2.6.6-rc3-mm1/include/linux/fs.h	2004-04-30 11:58:46.000000000 +0100
+++ rmap20/include/linux/fs.h	2004-05-04 21:21:28.888451072 +0100
@@ -331,9 +331,9 @@ struct address_space {
 	pgoff_t			writeback_index;/* writeback starts here */
 	struct address_space_operations *a_ops;	/* methods */
 	struct prio_tree_root	i_mmap;		/* tree of private mappings */
-	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
-	struct list_head	i_mmap_nonlinear;/*list of nonlinear mappings */
-	spinlock_t		i_shared_lock;	/* protect trees & list above */
+	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
+	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
+	spinlock_t		i_shared_lock;	/* protect tree, count, list */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
@@ -382,20 +382,18 @@ int mapping_tagged(struct address_space 
 static inline int mapping_mapped(struct address_space *mapping)
 {
 	return	!prio_tree_empty(&mapping->i_mmap) ||
-		!prio_tree_empty(&mapping->i_mmap_shared) ||
 		!list_empty(&mapping->i_mmap_nonlinear);
 }
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_shared holds all the VM_SHARED vmas: do_mmap_pgoff
+ * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap_pgoff
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  */
 static inline int mapping_writably_mapped(struct address_space *mapping)
 {
-	return	!prio_tree_empty(&mapping->i_mmap_shared) ||
-		!list_empty(&mapping->i_mmap_nonlinear);
+	return mapping->i_mmap_writable != 0;
 }
 
 /*
--- 2.6.6-rc3-mm1/include/linux/mm.h	2004-04-30 11:58:46.000000000 +0100
+++ rmap20/include/linux/mm.h	2004-05-04 21:21:28.890450768 +0100
@@ -46,13 +46,6 @@ extern int page_cluster;
  * per VM-area/task.  A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
- *
- * This structure is exactly 64 bytes on ia32.  Please think very, very hard
- * before adding anything to it.
- * [Now 4 bytes more on 32bit NUMA machines. Sorry. -AK.
- * But if you want to recover the 4 bytes justr remove vm_next. It is redundant
- * with vm_rb. Will be a lot of editing work though. vm_rb.color is redundant
- * too.]
  */
 struct vm_area_struct {
 	struct mm_struct * vm_mm;	/* The address space we belong to. */
@@ -70,7 +63,9 @@ struct vm_area_struct {
 
 	/*
 	 * For areas with an address space and backing store,
-	 * one of the address_space->i_mmap{,shared} trees.
+	 * linkage into the address_space->i_mmap prio tree, or
+	 * linkage to the list of like vmas hanging off its node, or
+	 * linkage of vma in the address_space->i_mmap_nonlinear list.
 	 */
 	union {
 		struct {
--- 2.6.6-rc3-mm1/mm/fremap.c	2004-04-30 11:58:47.000000000 +0100
+++ rmap20/mm/fremap.c	2004-05-04 21:21:28.890450768 +0100
@@ -203,7 +203,7 @@ asmlinkage long sys_remap_file_pages(uns
 			mapping = vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_shared_lock);
 			vma->vm_flags |= VM_NONLINEAR;
-			vma_prio_tree_remove(vma, &mapping->i_mmap_shared);
+			vma_prio_tree_remove(vma, &mapping->i_mmap);
 			vma_prio_tree_init(vma);
 			list_add_tail(&vma->shared.vm_set.list,
 					&mapping->i_mmap_nonlinear);
--- 2.6.6-rc3-mm1/mm/memory.c	2004-04-30 11:58:47.000000000 +0100
+++ rmap20/mm/memory.c	2004-05-04 21:21:28.892450464 +0100
@@ -1118,8 +1118,8 @@ no_new_page:
 /*
  * Helper function for unmap_mapping_range().
  */
-static void unmap_mapping_range_list(struct prio_tree_root *root,
-				     struct zap_details *details)
+static inline void unmap_mapping_range_list(struct prio_tree_root *root,
+					    struct zap_details *details)
 {
 	struct vm_area_struct *vma = NULL;
 	struct prio_tree_iter iter;
@@ -1188,12 +1188,6 @@ void unmap_mapping_range(struct address_
 	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		unmap_mapping_range_list(&mapping->i_mmap, &details);
 
-	/* Don't waste time to check mapping on fully shared vmas */
-	details.check_mapping = NULL;
-
-	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
-		unmap_mapping_range_list(&mapping->i_mmap_shared, &details);
-
 	if (unlikely(!list_empty(&mapping->i_mmap_nonlinear))) {
 		struct vm_area_struct *vma;
 		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
--- 2.6.6-rc3-mm1/mm/mmap.c	2004-04-30 11:58:47.000000000 +0100
+++ rmap20/mm/mmap.c	2004-05-04 21:21:28.894450160 +0100
@@ -69,11 +69,11 @@ static inline void __remove_shared_vm_st
 {
 	if (vma->vm_flags & VM_DENYWRITE)
 		atomic_inc(&file->f_dentry->d_inode->i_writecount);
+	if (vma->vm_flags & VM_SHARED)
+		mapping->i_mmap_writable--;
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR))
 		list_del_init(&vma->shared.vm_set.list);
-	else if (vma->vm_flags & VM_SHARED)
-		vma_prio_tree_remove(vma, &mapping->i_mmap_shared);
 	else
 		vma_prio_tree_remove(vma, &mapping->i_mmap);
 }
@@ -261,12 +261,12 @@ static inline void __vma_link_file(struc
 
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);
+		if (vma->vm_flags & VM_SHARED)
+			mapping->i_mmap_writable++;
 
 		if (unlikely(vma->vm_flags & VM_NONLINEAR))
 			list_add_tail(&vma->shared.vm_set.list,
 					&mapping->i_mmap_nonlinear);
-		else if (vma->vm_flags & VM_SHARED)
-			vma_prio_tree_insert(vma, &mapping->i_mmap_shared);
 		else
 			vma_prio_tree_insert(vma, &mapping->i_mmap);
 	}
@@ -306,8 +306,8 @@ static void vma_link(struct mm_struct *m
 }
 
 /*
- * Insert vm structure into process list sorted by address and into the inode's
- * i_mmap ring. The caller should hold mm->page_table_lock and
+ * Insert vm structure into process list sorted by address and into the
+ * inode's i_mmap tree. The caller should hold mm->page_table_lock and
  * ->f_mappping->i_shared_lock if vm_file is non-NULL.
  */
 static void
@@ -326,8 +326,8 @@ __insert_vm_struct(struct mm_struct * mm
 }
 
 /*
- * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that is
- * already present in an i_mmap{_shared} tree without adjusting the tree.
+ * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
+ * is already present in an i_mmap tree without adjusting the tree.
  * The following helper function should be used when such adjustments
  * are necessary.  The "next" vma (if any) is to be removed or inserted
  * before we drop the necessary locks.
@@ -342,10 +342,8 @@ void vma_adjust(struct vm_area_struct *v
 
 	if (file) {
 		mapping = file->f_mapping;
-		if (!(vma->vm_flags & VM_SHARED))
+		if (!(vma->vm_flags & VM_NONLINEAR))
 			root = &mapping->i_mmap;
-		else if (!(vma->vm_flags & VM_NONLINEAR))
-			root = &mapping->i_mmap_shared;
 		spin_lock(&mapping->i_shared_lock);
 	}
 	spin_lock(&mm->page_table_lock);
@@ -1513,7 +1511,7 @@ void exit_mmap(struct mm_struct *mm)
 }
 
 /* Insert vm structure into process list sorted by address
- * and into the inode's i_mmap ring.  If vm_file is non-NULL
+ * and into the inode's i_mmap tree.  If vm_file is non-NULL
  * then i_shared_lock is taken here.
  */
 void insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
--- 2.6.6-rc3-mm1/mm/prio_tree.c	2004-04-30 11:58:47.000000000 +0100
+++ rmap20/mm/prio_tree.c	2004-05-04 21:21:28.895450008 +0100
@@ -1,5 +1,5 @@
 /*
- * mm/prio_tree.c - priority search tree for mapping->i_mmap{,_shared}
+ * mm/prio_tree.c - priority search tree for mapping->i_mmap
  *
  * Copyright (C) 2004, Rajesh Venkatasubramanian <vrajesh@umich.edu>
  *
@@ -41,7 +41,7 @@
  */
 
 /*
- * The following macros are used for implementing prio_tree for i_mmap{_shared}
+ * The following macros are used for implementing prio_tree for i_mmap
  */
 
 #define RADIX_INDEX(vma)  ((vma)->vm_pgoff)
@@ -491,7 +491,7 @@ repeat:
 }
 
 /*
- * Radix priority search tree for address_space->i_mmap_{_shared}
+ * Radix priority search tree for address_space->i_mmap
  *
  * For each vma that map a unique set of file pages i.e., unique [radix_index,
  * heap_index] value, we have a corresponing priority search tree node. If
--- 2.6.6-rc3-mm1/mm/rmap.c	2004-04-30 11:58:47.000000000 +0100
+++ rmap20/mm/rmap.c	2004-05-04 21:21:28.897449704 +0100
@@ -331,21 +331,6 @@ static inline int page_referenced_file(s
 		}
 	}
 
-	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
-					&iter, pgoff, pgoff)) != NULL) {
-		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
-			referenced++;
-			goto out;
-		}
-		if (vma->vm_mm->rss) {
-			address = vma_address(vma, pgoff);
-			referenced += page_referenced_one(page,
-				vma->vm_mm, address, &mapcount, &failed);
-			if (!mapcount)
-				goto out;
-		}
-	}
-
 	if (list_empty(&mapping->i_mmap_nonlinear))
 		WARN_ON(!failed);
 out:
@@ -734,17 +719,6 @@ static inline int try_to_unmap_file(stru
 		}
 	}
 
-	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
-					&iter, pgoff, pgoff)) != NULL) {
-		if (vma->vm_mm->rss) {
-			address = vma_address(vma, pgoff);
-			ret = try_to_unmap_one(page,
-				vma->vm_mm, address, &mapcount, vma);
-			if (ret == SWAP_FAIL || !mapcount)
-				goto out;
-		}
-	}
-
 	if (list_empty(&mapping->i_mmap_nonlinear))
 		goto out;
 

