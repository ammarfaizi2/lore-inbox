Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264520AbUD1AFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbUD1AFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUD1AEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:04:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38057 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264520AbUD1ACb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:02:31 -0400
Date: Wed, 28 Apr 2004 01:02:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 16 pretend prio_tree
In-Reply-To: <Pine.LNX.4.44.0404280055270.2444-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404280101220.2444-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pave the way for prio_tree by switching over to its interfaces,
but actually still implement them with the same old lists as before.

Most of the vma_prio_tree interfaces are straightforward.  The
interesting one is vma_prio_tree_next, used to search the tree for all
vmas which overlap the given range: unlike the list_for_each_entry it
replaces, it does not find every vma, just those that match.

But this does leave handling of nonlinear vmas in a very unsatisfactory
state: for now we have to search again over the maximum range to find
all the nonlinear vmas which might contain a page, which of course
takes away the point of the tree.  Fixed in later patch of this batch.

There is no need to initialize vma linkage all over, just do it before
inserting the vma in list or tree.  /proc/pid/statm had an odd test
for its shared count: simplified to an equivalent test on vm_file.

 fs/exec.c                 |    1 
 fs/hugetlbfs/inode.c      |   30 +++++-------------
 fs/inode.c                |    4 +-
 fs/proc/task_mmu.c        |    2 -
 include/linux/fs.h        |   13 ++++---
 include/linux/mm.h        |   31 +++++++++++++++++--
 include/linux/prio_tree.h |   27 ++++++++++++++++
 kernel/fork.c             |    4 +-
 mm/memory.c               |   41 +++++++++++++++++--------
 mm/mmap.c                 |   62 +++++++++++++++++++++++++++++---------
 mm/rmap.c                 |   75 +++++++++++++++++++++++-----------------------
 11 files changed, 191 insertions(+), 99 deletions(-)

--- rmap15/fs/exec.c	2004-04-26 12:39:43.886535592 +0100
+++ rmap16/fs/exec.c	2004-04-27 19:18:42.765737560 +0100
@@ -427,7 +427,6 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
 		mpol_set_vma_default(mpnt);
-		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- rmap15/fs/hugetlbfs/inode.c	2004-04-26 12:39:44.058509448 +0100
+++ rmap16/fs/hugetlbfs/inode.c	2004-04-27 19:18:42.767737256 +0100
@@ -267,39 +267,27 @@ static void hugetlbfs_drop_inode(struct 
  * vma->vm_pgoff is in PAGE_SIZE units.
  */
 static void
-hugetlb_vmtruncate_list(struct list_head *list, unsigned long h_pgoff)
+hugetlb_vmtruncate_list(struct prio_tree_root *root, unsigned long h_pgoff)
 {
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = NULL;
+	struct prio_tree_iter iter;
 
-	list_for_each_entry(vma, list, shared) {
+	while ((vma = vma_prio_tree_next(vma, root, &iter,
+					h_pgoff, ULONG_MAX)) != NULL) {
 		unsigned long h_vm_pgoff;
 		unsigned long v_length;
-		unsigned long h_length;
 		unsigned long v_offset;
 
 		h_vm_pgoff = vma->vm_pgoff << (HPAGE_SHIFT - PAGE_SHIFT);
 		v_length = vma->vm_end - vma->vm_start;
-		h_length = v_length >> HPAGE_SHIFT;
 		v_offset = (h_pgoff - h_vm_pgoff) << HPAGE_SHIFT;
 
 		/*
 		 * Is this VMA fully outside the truncation point?
 		 */
-		if (h_vm_pgoff >= h_pgoff) {
-			zap_hugepage_range(vma, vma->vm_start, v_length);
-			continue;
-		}
-
-		/*
-		 * Is this VMA fully inside the truncaton point?
-		 */
-		if (h_vm_pgoff + (v_length >> HPAGE_SHIFT) <= h_pgoff)
-			continue;
+		if (h_vm_pgoff >= h_pgoff)
+			v_offset = 0;
 
-		/*
-		 * The VMA straddles the truncation point.  v_offset is the
-		 * offset (in bytes) into the VMA where the point lies.
-		 */
 		zap_hugepage_range(vma,
 				vma->vm_start + v_offset,
 				v_length - v_offset);
@@ -322,9 +310,9 @@ static int hugetlb_vmtruncate(struct ino
 
 	inode->i_size = offset;
 	spin_lock(&mapping->i_shared_lock);
-	if (!list_empty(&mapping->i_mmap))
+	if (!prio_tree_empty(&mapping->i_mmap))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
-	if (!list_empty(&mapping->i_mmap_shared))
+	if (!prio_tree_empty(&mapping->i_mmap_shared))
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	spin_unlock(&mapping->i_shared_lock);
 	truncate_hugepages(mapping, offset);
--- rmap15/fs/inode.c	2004-04-26 12:39:44.062508840 +0100
+++ rmap16/fs/inode.c	2004-04-27 19:18:42.769736952 +0100
@@ -188,8 +188,8 @@ void inode_init_once(struct inode *inode
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
+	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap_shared);
 	spin_lock_init(&inode->i_lock);
 	i_size_ordered_init(inode);
 }
--- rmap15/fs/proc/task_mmu.c	2004-02-04 02:45:17.000000000 +0000
+++ rmap16/fs/proc/task_mmu.c	2004-04-27 19:18:42.770736800 +0100
@@ -65,7 +65,7 @@ int task_statm(struct mm_struct *mm, int
 				*shared += pages;
 			continue;
 		}
-		if (vma->vm_flags & VM_SHARED || !list_empty(&vma->shared))
+		if (vma->vm_file)
 			*shared += pages;
 		if (vma->vm_flags & VM_EXECUTABLE)
 			*text += pages;
--- rmap15/include/linux/fs.h	2004-04-26 12:39:46.364158936 +0100
+++ rmap16/include/linux/fs.h	2004-04-27 19:18:42.773736344 +0100
@@ -18,6 +18,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
+#include <linux/prio_tree.h>
 #include <linux/kobject.h>
 #include <asm/atomic.h>
 #include <linux/audit.h>
@@ -329,9 +330,9 @@ struct address_space {
 	unsigned long		nrpages;	/* number of total pages */
 	pgoff_t			writeback_index;/* writeback starts here */
 	struct address_space_operations *a_ops;	/* methods */
-	struct list_head	i_mmap;		/* list of private mappings */
-	struct list_head	i_mmap_shared;	/* list of shared mappings */
-	spinlock_t		i_shared_lock;	/* protect both above lists */
+	struct prio_tree_root	i_mmap;		/* tree of private mappings */
+	struct prio_tree_root	i_mmap_shared;	/* tree of shared mappings */
+	spinlock_t		i_shared_lock;	/* protect trees & list above */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
@@ -379,8 +380,8 @@ int mapping_tagged(struct address_space 
  */
 static inline int mapping_mapped(struct address_space *mapping)
 {
-	return	!list_empty(&mapping->i_mmap) ||
-		!list_empty(&mapping->i_mmap_shared);
+	return	!prio_tree_empty(&mapping->i_mmap) ||
+		!prio_tree_empty(&mapping->i_mmap_shared);
 }
 
 /*
@@ -391,7 +392,7 @@ static inline int mapping_mapped(struct 
  */
 static inline int mapping_writably_mapped(struct address_space *mapping)
 {
-	return	!list_empty(&mapping->i_mmap_shared);
+	return	!prio_tree_empty(&mapping->i_mmap_shared);
 }
 
 /*
--- rmap15/include/linux/mm.h	2004-04-27 19:18:31.303480088 +0100
+++ rmap16/include/linux/mm.h	2004-04-27 19:18:42.775736040 +0100
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
+#include <linux/prio_tree.h>
 #include <linux/fs.h>
 #include <linux/mempolicy.h>
 
@@ -69,8 +70,7 @@ struct vm_area_struct {
 
 	/*
 	 * For areas with an address space and backing store,
-	 * one of the address_space->i_mmap{,shared} lists,
-	 * for shm areas, the list of attaches, otherwise unused.
+	 * one of the address_space->i_mmap{,shared} trees.
 	 */
 	struct list_head shared;
 
@@ -551,6 +551,33 @@ extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
+static inline void vma_prio_tree_init(struct vm_area_struct *vma)
+{
+	INIT_LIST_HEAD(&vma->shared);
+}
+
+static inline void vma_prio_tree_add(struct vm_area_struct *vma,
+				     struct vm_area_struct *old)
+{
+	list_add(&vma->shared, &old->shared);
+}
+
+static inline void vma_prio_tree_insert(struct vm_area_struct *vma,
+					struct prio_tree_root *root)
+{
+	list_add_tail(&vma->shared, &root->list);
+}
+
+static inline void vma_prio_tree_remove(struct vm_area_struct *vma,
+					struct prio_tree_root *root)
+{
+	list_del_init(&vma->shared);
+}
+
+struct vm_area_struct *vma_prio_tree_next(
+	struct vm_area_struct *, struct prio_tree_root *,
+	struct prio_tree_iter *, pgoff_t begin, pgoff_t end);
+
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *next);
--- rmap15/include/linux/prio_tree.h	1970-01-01 01:00:00.000000000 +0100
+++ rmap16/include/linux/prio_tree.h	2004-04-27 19:18:42.776735888 +0100
@@ -0,0 +1,27 @@
+#ifndef _LINUX_PRIO_TREE_H
+#define _LINUX_PRIO_TREE_H
+/*
+ * Dummy version of include/linux/prio_tree.h, just for this patch:
+ * no radix priority search tree whatsoever, just implement interfaces
+ * using the old lists.
+ */
+
+struct prio_tree_root {
+	struct list_head	list;
+};
+
+struct prio_tree_iter {
+	int			not_used_yet;
+};
+
+#define INIT_PRIO_TREE_ROOT(ptr)	\
+do {					\
+	INIT_LIST_HEAD(&(ptr)->list);	\
+} while (0)				\
+
+static inline int prio_tree_empty(const struct prio_tree_root *root)
+{
+	return list_empty(&root->list);
+}
+
+#endif /* _LINUX_PRIO_TREE_H */
--- rmap15/kernel/fork.c	2004-04-26 12:39:46.742101480 +0100
+++ rmap16/kernel/fork.c	2004-04-27 19:18:42.777735736 +0100
@@ -321,7 +321,7 @@ static inline int dup_mmap(struct mm_str
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		file = tmp->vm_file;
-		INIT_LIST_HEAD(&tmp->shared);
+		vma_prio_tree_init(tmp);
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
@@ -330,7 +330,7 @@ static inline int dup_mmap(struct mm_str
       
 			/* insert tmp into the share list, just after mpnt */
 			spin_lock(&file->f_mapping->i_shared_lock);
-			list_add(&tmp->shared, &mpnt->shared);
+			vma_prio_tree_add(tmp, mpnt);
 			spin_unlock(&file->f_mapping->i_shared_lock);
 		}
 
--- rmap15/mm/memory.c	2004-04-26 12:39:46.947070320 +0100
+++ rmap16/mm/memory.c	2004-04-27 19:18:42.780735280 +0100
@@ -1118,25 +1118,20 @@ no_new_page:
 /*
  * Helper function for unmap_mapping_range().
  */
-static void unmap_mapping_range_list(struct list_head *head,
+static void unmap_mapping_range_list(struct prio_tree_root *root,
 				     struct zap_details *details)
 {
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = NULL;
+	struct prio_tree_iter iter;
 	pgoff_t vba, vea, zba, zea;
 
-	list_for_each_entry(vma, head, shared) {
-		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
-			details->nonlinear_vma = vma;
-			zap_page_range(vma, vma->vm_start,
-				vma->vm_end - vma->vm_start, details);
-			details->nonlinear_vma = NULL;
+	while ((vma = vma_prio_tree_next(vma, root, &iter,
+			details->first_index, details->last_index)) != NULL) {
+		if (unlikely(vma->vm_flags & VM_NONLINEAR))
 			continue;
-		}
 		vba = vma->vm_pgoff;
 		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
 		/* Assume for now that PAGE_CACHE_SHIFT == PAGE_SHIFT */
-		if (vba > details->last_index || vea < details->first_index)
-			continue;	/* Mapping disjoint from hole. */
 		zba = details->first_index;
 		if (zba < vba)
 			zba = vba;
@@ -1149,6 +1144,22 @@ static void unmap_mapping_range_list(str
 	}
 }
 
+static void unmap_nonlinear_range_list(struct prio_tree_root *root,
+				       struct zap_details *details)
+{
+	struct vm_area_struct *vma = NULL;
+	struct prio_tree_iter iter;
+
+	while ((vma = vma_prio_tree_next(vma, root, &iter,
+						0, ULONG_MAX)) != NULL) {
+		if (!(vma->vm_flags & VM_NONLINEAR))
+			continue;
+		details->nonlinear_vma = vma;
+		zap_page_range(vma, vma->vm_start,
+				vma->vm_end - vma->vm_start, details);
+	}
+}
+
 /**
  * unmap_mapping_range - unmap the portion of all mmaps
  * in the specified address_space corresponding to the specified
@@ -1191,14 +1202,18 @@ void unmap_mapping_range(struct address_
 	spin_lock(&mapping->i_shared_lock);
 	/* Protect against page fault */
 	atomic_inc(&mapping->truncate_count);
-	if (unlikely(!list_empty(&mapping->i_mmap)))
+
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		unmap_mapping_range_list(&mapping->i_mmap, &details);
 
 	/* Don't waste time to check mapping on fully shared vmas */
 	details.check_mapping = NULL;
 
-	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared))) {
 		unmap_mapping_range_list(&mapping->i_mmap_shared, &details);
+		unmap_nonlinear_range_list(&mapping->i_mmap_shared, &details);
+	}
+
 	spin_unlock(&mapping->i_shared_lock);
 }
 EXPORT_SYMBOL(unmap_mapping_range);
--- rmap15/mm/mmap.c	2004-04-27 19:18:31.307479480 +0100
+++ rmap16/mm/mmap.c	2004-04-27 19:18:42.784734672 +0100
@@ -64,12 +64,16 @@ EXPORT_SYMBOL(vm_committed_space);
 /*
  * Requires inode->i_mapping->i_shared_lock
  */
-static inline void
-__remove_shared_vm_struct(struct vm_area_struct *vma, struct file *file)
+static inline void __remove_shared_vm_struct(struct vm_area_struct *vma,
+		struct file *file, struct address_space *mapping)
 {
 	if (vma->vm_flags & VM_DENYWRITE)
 		atomic_inc(&file->f_dentry->d_inode->i_writecount);
-	list_del_init(&vma->shared);
+
+	if (vma->vm_flags & VM_SHARED)
+		vma_prio_tree_remove(vma, &mapping->i_mmap_shared);
+	else
+		vma_prio_tree_remove(vma, &mapping->i_mmap);
 }
 
 /*
@@ -82,7 +86,7 @@ static void remove_shared_vm_struct(stru
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 		spin_lock(&mapping->i_shared_lock);
-		__remove_shared_vm_struct(vma, file);
+		__remove_shared_vm_struct(vma, file, mapping);
 		spin_unlock(&mapping->i_shared_lock);
 	}
 }
@@ -257,9 +261,9 @@ static inline void __vma_link_file(struc
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);
 
 		if (vma->vm_flags & VM_SHARED)
-			list_add_tail(&vma->shared, &mapping->i_mmap_shared);
+			vma_prio_tree_insert(vma, &mapping->i_mmap_shared);
 		else
-			list_add_tail(&vma->shared, &mapping->i_mmap);
+			vma_prio_tree_insert(vma, &mapping->i_mmap);
 	}
 }
 
@@ -268,6 +272,7 @@ __vma_link(struct mm_struct *mm, struct 
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	vma_prio_tree_init(vma);
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	__vma_link_file(vma);
@@ -316,6 +321,31 @@ __insert_vm_struct(struct mm_struct * mm
 }
 
 /*
+ * Dummy version of vma_prio_tree_next, just for this patch:
+ * no radix priority search tree whatsoever, just implement interface
+ * using the old lists: return the next vma overlapping [begin,end].
+ */
+struct vm_area_struct *vma_prio_tree_next(
+	struct vm_area_struct *vma, struct prio_tree_root *root,
+	struct prio_tree_iter *iter, pgoff_t begin, pgoff_t end)
+{
+	struct list_head *next;
+	pgoff_t vba, vea;
+
+	next = vma? vma->shared.next: root->list.next;
+	while (next != &root->list) {
+		vma = list_entry(next, struct vm_area_struct, shared);
+		vba = vma->vm_pgoff;
+		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
+		/* Return vma if it overlaps [begin,end] */
+		if (vba <= end && vea >= begin)
+			return vma;
+		next = next->next;
+	}
+	return NULL;
+}
+
+/*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that is
  * already present in an i_mmap{_shared} tree without adjusting the tree.
  * The following helper function should be used when such adjustments
@@ -327,17 +357,28 @@ void vma_adjust(struct vm_area_struct *v
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct address_space *mapping = NULL;
+	struct prio_tree_root *root = NULL;
 	struct file *file = vma->vm_file;
 
 	if (file) {
 		mapping = file->f_mapping;
+		if (vma->vm_flags & VM_SHARED)
+			root = &mapping->i_mmap_shared;
+		else
+			root = &mapping->i_mmap;
 		spin_lock(&mapping->i_shared_lock);
 	}
 	spin_lock(&mm->page_table_lock);
 
+	if (root)
+		vma_prio_tree_remove(vma, root);
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
+	if (root) {
+		vma_prio_tree_init(vma);
+		vma_prio_tree_insert(vma, root);
+	}
 
 	if (next) {
 		if (next == vma->vm_next) {
@@ -347,7 +388,7 @@ void vma_adjust(struct vm_area_struct *v
 			 */
 			__vma_unlink(mm, next, vma);
 			if (file)
-				__remove_shared_vm_struct(next, file);
+				__remove_shared_vm_struct(next, file, mapping);
 		} else {
 			/*
 			 * split_vma has split next from vma, and needs
@@ -675,7 +716,6 @@ munmap_back:
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
 	mpol_set_vma_default(vma);
-	INIT_LIST_HEAD(&vma->shared);
 
 	if (file) {
 		error = -EINVAL;
@@ -1238,8 +1278,6 @@ int split_vma(struct mm_struct * mm, str
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
 
-	INIT_LIST_HEAD(&new->shared);
-
 	if (new_below)
 		new->vm_end = addr;
 	else {
@@ -1432,10 +1470,7 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	mpol_set_vma_default(vma);
-	INIT_LIST_HEAD(&vma->shared);
-
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED) {
@@ -1546,7 +1581,6 @@ struct vm_area_struct *copy_vma(struct v
 				return NULL;
 			}
 			vma_set_policy(new_vma, pol);
-			INIT_LIST_HEAD(&new_vma->shared);
 			new_vma->vm_start = addr;
 			new_vma->vm_end = addr + len;
 			new_vma->vm_pgoff = pgoff;
--- rmap15/mm/rmap.c	2004-04-27 19:18:19.423286152 +0100
+++ rmap16/mm/rmap.c	2004-04-27 19:18:42.786734368 +0100
@@ -159,8 +159,8 @@ unsigned long vma_address(struct vm_area
 	unsigned long address;
 
 	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	return (address >= vma->vm_start && address < vma->vm_end)?
-		address: -EFAULT;
+	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+	return address;
 }
 
 /**
@@ -306,7 +306,8 @@ static inline int page_referenced_file(s
 	unsigned int mapcount = page->mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = NULL;
+	struct prio_tree_iter iter;
 	unsigned long address;
 	int referenced = 0;
 	int failed = 0;
@@ -314,16 +315,15 @@ static inline int page_referenced_file(s
 	if (!spin_trylock(&mapping->i_shared_lock))
 		return 0;
 
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		address = vma_address(vma, pgoff);
-		if (address == -EFAULT)
-			continue;
+	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
+					&iter, pgoff, pgoff)) != NULL) {
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
 				  == (VM_LOCKED|VM_MAYSHARE)) {
 			referenced++;
 			goto out;
 		}
 		if (vma->vm_mm->rss) {
+			address = vma_address(vma, pgoff);
 			referenced += page_referenced_one(page,
 				vma->vm_mm, address, &mapcount, &failed);
 			if (!mapcount)
@@ -331,19 +331,18 @@ static inline int page_referenced_file(s
 		}
 	}
 
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+					&iter, pgoff, pgoff)) != NULL) {
 		if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
 			failed++;
 			continue;
 		}
-		address = vma_address(vma, pgoff);
-		if (address == -EFAULT)
-			continue;
 		if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
 			referenced++;
 			goto out;
 		}
 		if (vma->vm_mm->rss) {
+			address = vma_address(vma, pgoff);
 			referenced += page_referenced_one(page,
 				vma->vm_mm, address, &mapcount, &failed);
 			if (!mapcount)
@@ -351,6 +350,7 @@ static inline int page_referenced_file(s
 		}
 	}
 
+	/* Hmm, but what of the nonlinears which pgoff,pgoff skipped? */
 	WARN_ON(!failed);
 out:
 	spin_unlock(&mapping->i_shared_lock);
@@ -716,7 +716,8 @@ static inline int try_to_unmap_file(stru
 	unsigned int mapcount = page->mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = NULL;
+	struct prio_tree_iter iter;
 	unsigned long address;
 	int ret = SWAP_AGAIN;
 	unsigned long cursor;
@@ -726,11 +727,10 @@ static inline int try_to_unmap_file(stru
 	if (!spin_trylock(&mapping->i_shared_lock))
 		return ret;
 
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
+					&iter, pgoff, pgoff)) != NULL) {
 		if (vma->vm_mm->rss) {
 			address = vma_address(vma, pgoff);
-			if (address == -EFAULT)
-				continue;
 			ret = try_to_unmap_one(page,
 				vma->vm_mm, address, &mapcount, vma);
 			if (ret == SWAP_FAIL || !mapcount)
@@ -738,27 +738,12 @@ static inline int try_to_unmap_file(stru
 		}
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
+	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+					&iter, pgoff, pgoff)) != NULL) {
+		if (unlikely(vma->vm_flags & VM_NONLINEAR))
 			continue;
-		}
 		if (vma->vm_mm->rss) {
 			address = vma_address(vma, pgoff);
-			if (address == -EFAULT)
-				continue;
 			ret = try_to_unmap_one(page,
 				vma->vm_mm, address, &mapcount, vma);
 			if (ret == SWAP_FAIL || !mapcount)
@@ -766,7 +751,20 @@ static inline int try_to_unmap_file(stru
 		}
 	}
 
-	if (max_nl_size == 0)	/* no nonlinear vmas of this file */
+	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+					&iter, 0, ULONG_MAX)) != NULL) {
+		if (VM_NONLINEAR != (vma->vm_flags &
+		     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
+			continue;
+		cursor = (unsigned long) vma->vm_private_data;
+		if (cursor > max_nl_cursor)
+			max_nl_cursor = cursor;
+		cursor = vma->vm_end - vma->vm_start;
+		if (cursor > max_nl_size)
+			max_nl_size = cursor;
+	}
+
+	if (max_nl_size == 0)	/* any nonlinears locked or reserved */
 		goto out;
 
 	/*
@@ -784,9 +782,10 @@ static inline int try_to_unmap_file(stru
 		max_nl_cursor = CLUSTER_SIZE;
 
 	do {
-		list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+					&iter, 0, ULONG_MAX)) != NULL) {
 			if (VM_NONLINEAR != (vma->vm_flags &
-			     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
+		    	     (VM_NONLINEAR|VM_LOCKED|VM_RESERVED)))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
 			while (vma->vm_mm->rss &&
@@ -815,7 +814,9 @@ static inline int try_to_unmap_file(stru
 	 * in locked vmas).  Reset cursor on all unreserved nonlinear
 	 * vmas, now forgetting on which ones it had fallen behind.
 	 */
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+	vma = NULL;	/* it is already, but above loop might change */
+	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap_shared,
+					&iter, 0, ULONG_MAX)) != NULL) {
 		if ((vma->vm_flags & (VM_NONLINEAR|VM_RESERVED)) ==
 				VM_NONLINEAR)
 			vma->vm_private_data = 0;

