Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264528AbUD1AHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbUD1AHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUD1AHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:07:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4568 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264528AbUD1AEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:04:38 -0400
Date: Wed, 28 Apr 2004 01:04:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 18 i_mmap_nonlinear
In-Reply-To: <Pine.LNX.4.44.0404280055270.2444-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404280103350.2444-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The prio_tree is of no use to nonlinear vmas: currently we're having to
search the tree in the most inefficient way to find all its nonlinears.
At the very least we need an indication of the unlikely case when there
are some nonlinears; but really, we'd do best to take them out of the
prio_tree altogether, into a list of their own - i_mmap_nonlinear.

 fs/inode.c         |    1 +
 include/linux/fs.h |    7 +++++--
 mm/fremap.c        |   12 +++++++++++-
 mm/memory.c        |   31 ++++++++++---------------------
 mm/mmap.c          |   15 ++++++++++-----
 mm/prio_tree.c     |    1 +
 mm/rmap.c          |   35 ++++++++++++++---------------------
 7 files changed, 52 insertions(+), 50 deletions(-)

--- rmap17/fs/inode.c	2004-04-27 19:18:42.769736952 +0100
+++ rmap18/fs/inode.c	2004-04-27 19:19:05.866225752 +0100
@@ -190,6 +190,7 @@ void inode_init_once(struct inode *inode
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
 	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
+	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
 }
--- rmap17/include/linux/fs.h	2004-04-27 19:18:42.773736344 +0100
+++ rmap18/include/linux/fs.h	2004-04-27 19:19:05.869225296 +0100
@@ -332,6 +332,7 @@ struct address_space {
 	struct address_space_operations *a_ops;	/* methods */
 	struct prio_tree_root	i_mmap;		/* tree of private mappings */
 	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
+	struct list_head	i_mmap_nonlinear;/*list of nonlinear mappings */
 	spinlock_t		i_shared_lock;	/* protect trees & list above */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
@@ -381,7 +382,8 @@ int mapping_tagged(struct address_space 
 static inline int mapping_mapped(struct address_space *mapping)
 {
 	return	!prio_tree_empty(&mapping->i_mmap) ||
-		!prio_tree_empty(&mapping->i_mmap_shared);
+		!prio_tree_empty(&mapping->i_mmap_shared) ||
+		!list_empty(&mapping->i_mmap_nonlinear);
 }
 
 /*
@@ -392,7 +394,8 @@ static inline int mapping_mapped(struct 
  */
 static inline int mapping_writably_mapped(struct address_space *mapping)
 {
-	return	!prio_tree_empty(&mapping->i_mmap_shared);
+	return	!prio_tree_empty(&mapping->i_mmap_shared) ||
+		!list_empty(&mapping->i_mmap_nonlinear);
 }
 
 /*
--- rmap17/mm/fremap.c	2004-04-26 12:39:46.922074120 +0100
+++ rmap18/mm/fremap.c	2004-04-27 19:19:05.870225144 +0100
@@ -157,6 +157,7 @@ asmlinkage long sys_remap_file_pages(uns
 	unsigned long __prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct address_space *mapping;
 	unsigned long end = start + size;
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
@@ -197,8 +198,17 @@ asmlinkage long sys_remap_file_pages(uns
 				end <= vma->vm_end) {
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start))
+		if (pgoff != linear_page_index(vma, start) &&
+		    !(vma->vm_flags & VM_NONLINEAR)) {
+			mapping = vma->vm_file->f_mapping;
+			spin_lock(&mapping->i_shared_lock);
 			vma->vm_flags |= VM_NONLINEAR;
+			vma_prio_tree_remove(vma, &mapping->i_mmap_shared);
+			vma_prio_tree_init(vma);
+			list_add_tail(&vma->shared.vm_set.list,
+					&mapping->i_mmap_nonlinear);
+			spin_unlock(&mapping->i_shared_lock);
+		}
 
 		/* ->populate can take a long time, so downgrade the lock. */
 		downgrade_write(&mm->mmap_sem);
--- rmap17/mm/memory.c	2004-04-27 19:18:42.780735280 +0100
+++ rmap18/mm/memory.c	2004-04-27 19:19:05.873224688 +0100
@@ -1127,8 +1127,6 @@ static void unmap_mapping_range_list(str
 
 	while ((vma = vma_prio_tree_next(vma, root, &iter,
 			details->first_index, details->last_index)) != NULL) {
-		if (unlikely(vma->vm_flags & VM_NONLINEAR))
-			continue;
 		vba = vma->vm_pgoff;
 		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
 		/* Assume for now that PAGE_CACHE_SHIFT == PAGE_SHIFT */
@@ -1144,22 +1142,6 @@ static void unmap_mapping_range_list(str
 	}
 }
 
-static void unmap_nonlinear_range_list(struct prio_tree_root *root,
-				       struct zap_details *details)
-{
-	struct vm_area_struct *vma = NULL;
-	struct prio_tree_iter iter;
-
-	while ((vma = vma_prio_tree_next(vma, root, &iter,
-						0, ULONG_MAX)) != NULL) {
-		if (!(vma->vm_flags & VM_NONLINEAR))
-			continue;
-		details->nonlinear_vma = vma;
-		zap_page_range(vma, vma->vm_start,
-				vma->vm_end - vma->vm_start, details);
-	}
-}
-
 /**
  * unmap_mapping_range - unmap the portion of all mmaps
  * in the specified address_space corresponding to the specified
@@ -1209,11 +1191,18 @@ void unmap_mapping_range(struct address_
 	/* Don't waste time to check mapping on fully shared vmas */
 	details.check_mapping = NULL;
 
-	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared))) {
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		unmap_mapping_range_list(&mapping->i_mmap_shared, &details);
-		unmap_nonlinear_range_list(&mapping->i_mmap_shared, &details);
-	}
 
+	if (unlikely(!list_empty(&mapping->i_mmap_nonlinear))) {
+		struct vm_area_struct *vma;
+		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+			details.nonlinear_vma = vma;
+			zap_page_range(vma, vma->vm_start,
+				vma->vm_end - vma->vm_start, &details);
+		}
+	}
 	spin_unlock(&mapping->i_shared_lock);
 }
 EXPORT_SYMBOL(unmap_mapping_range);
--- rmap17/mm/mmap.c	2004-04-27 19:18:54.268988800 +0100
+++ rmap18/mm/mmap.c	2004-04-27 19:19:05.875224384 +0100
@@ -70,7 +70,9 @@ static inline void __remove_shared_vm_st
 	if (vma->vm_flags & VM_DENYWRITE)
 		atomic_inc(&file->f_dentry->d_inode->i_writecount);
 
-	if (vma->vm_flags & VM_SHARED)
+	if (unlikely(vma->vm_flags & VM_NONLINEAR))
+		list_del_init(&vma->shared.vm_set.list);
+	else if (vma->vm_flags & VM_SHARED)
 		vma_prio_tree_remove(vma, &mapping->i_mmap_shared);
 	else
 		vma_prio_tree_remove(vma, &mapping->i_mmap);
@@ -260,7 +262,10 @@ static inline void __vma_link_file(struc
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);
 
-		if (vma->vm_flags & VM_SHARED)
+		if (unlikely(vma->vm_flags & VM_NONLINEAR))
+			list_add_tail(&vma->shared.vm_set.list,
+					&mapping->i_mmap_nonlinear);
+		else if (vma->vm_flags & VM_SHARED)
 			vma_prio_tree_insert(vma, &mapping->i_mmap_shared);
 		else
 			vma_prio_tree_insert(vma, &mapping->i_mmap);
@@ -337,10 +342,10 @@ void vma_adjust(struct vm_area_struct *v
 
 	if (file) {
 		mapping = file->f_mapping;
-		if (vma->vm_flags & VM_SHARED)
-			root = &mapping->i_mmap_shared;
-		else
+		if (!(vma->vm_flags & VM_SHARED))
 			root = &mapping->i_mmap;
+		else if (!(vma->vm_flags & VM_NONLINEAR))
+			root = &mapping->i_mmap_shared;
 		spin_lock(&mapping->i_shared_lock);
 	}
 	spin_lock(&mm->page_table_lock);
--- rmap17/mm/prio_tree.c	2004-04-27 19:18:54.272988192 +0100
+++ rmap18/mm/prio_tree.c	2004-04-27 19:19:05.877224080 +0100
@@ -530,6 +530,7 @@ repeat:
 /*
  * Add a new vma known to map the same set of pages as the old vma:
  * useful for fork's dup_mmap as well as vma_prio_tree_insert below.
+ * Note that it just happens to work correctly on i_mmap_nonlinear too.
  */
 void vma_prio_tree_add(struct vm_area_struct *vma, struct vm_area_struct *old)
 {
--- rmap17/mm/rmap.c	2004-04-27 19:18:42.786734368 +0100
+++ rmap18/mm/rmap.c	2004-04-27 19:19:05.879223776 +0100
@@ -333,10 +333,6 @@ static inline int page_referenced_file(s
 
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
 					&iter, pgoff, pgoff)) != NULL) {
-		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
-			failed++;
-			continue;
-		}
 		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
 			referenced++;
 			goto out;
@@ -350,8 +346,8 @@ static inline int page_referenced_file(s
 		}
 	}
 
-	/* Hmm, but what of the nonlinears which pgoff,pgoff skipped? */
-	WARN_ON(!failed);
+	if (list_empty(&mapping->i_mmap_nonlinear))
+		WARN_ON(!failed);
 out:
 	spin_unlock(&mapping->i_shared_lock);
 	return referenced;
@@ -740,8 +736,6 @@ static inline int try_to_unmap_file(stru
 
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
 					&iter, pgoff, pgoff)) != NULL) {
-		if (unlikely(vma->vm_flags & VM_NONLINEAR))
-			continue;
 		if (vma->vm_mm->rss) {
 			address = vma_address(vma, pgoff);
 			ret = try_to_unmap_one(page,
@@ -751,10 +745,12 @@ static inline int try_to_unmap_file(stru
 		}
 	}
 
-	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
-					&iter, 0, ULONG_MAX)) != NULL) {
-		if (VM_NONLINEAR != (vma->vm_flags &
-		     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
+	if (list_empty(&mapping->i_mmap_nonlinear))
+		goto out;
+
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 			continue;
 		cursor = (unsigned long) vma->vm_private_data;
 		if (cursor > max_nl_cursor)
@@ -782,10 +778,9 @@ static inline int try_to_unmap_file(stru
 		max_nl_cursor = CLUSTER_SIZE;
 
 	do {
-		while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
-					&iter, 0, ULONG_MAX)) != NULL) {
-			if (VM_NONLINEAR != (vma->vm_flags &
-		    	     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
+		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
 			while (vma->vm_mm->rss &&
@@ -814,11 +809,9 @@ static inline int try_to_unmap_file(stru
 	 * in locked vmas).  Reset cursor on all unreserved nonlinear
 	 * vmas, now forgetting on which ones it had fallen behind.
 	 */
-	vma = NULL;	/* it is already, but above loop might change */
-	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
-					&iter, 0, ULONG_MAX)) != NULL) {
-		if ((vma->vm_flags & (VM_NONLINEAR|VM_RESERVED)) ==
-				VM_NONLINEAR)
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+						shared.vm_set.list) {
+		if (!(vma->vm_flags & VM_RESERVED))
 			vma->vm_private_data = 0;
 	}
 relock:

