Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267274AbUG1QLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbUG1QLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUG1QLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:11:06 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:22210 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S267274AbUG1QJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:09:46 -0400
Message-ID: <4107D0C8.DB5DAC48@tv-sign.ru>
Date: Wed, 28 Jul 2004 20:14:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: [PATCH] prio_tree 1/3: kill vma_prio_tree_init()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

vma_prio_tree_insert() relies on the fact, that vma was
vma_prio_tree_init()'ed.

Content of vma->shared should be considered undefined, until
this vma is inserted into i_mmap/i_mmap_nonlinear. It's better
to do proper initialization in vma_prio_tree_add/insert.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp 2.6.8-rc2/include/linux/mm.h prio_init/include/linux/mm.h
--- 2.6.8-rc2/include/linux/mm.h	2004-07-13 17:52:47.000000000 +0400
+++ prio_init/include/linux/mm.h	2004-07-28 14:07:07.000000000 +0400
@@ -598,14 +598,6 @@ extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
-static inline void vma_prio_tree_init(struct vm_area_struct *vma)
-{
-	vma->shared.vm_set.list.next = NULL;
-	vma->shared.vm_set.list.prev = NULL;
-	vma->shared.vm_set.parent = NULL;
-	vma->shared.vm_set.head = NULL;
-}
-
 /* prio_tree.c */
 void vma_prio_tree_add(struct vm_area_struct *, struct vm_area_struct *old);
 void vma_prio_tree_insert(struct vm_area_struct *, struct prio_tree_root *);
@@ -614,6 +606,13 @@ struct vm_area_struct *vma_prio_tree_nex
 	struct vm_area_struct *, struct prio_tree_root *,
 	struct prio_tree_iter *, pgoff_t begin, pgoff_t end);
 
+static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
+					struct list_head *list)
+{
+	vma->shared.vm_set.parent = NULL;
+	list_add_tail(&vma->shared.vm_set.list, list);
+}
+
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert);
diff -urp 2.6.8-rc2/kernel/fork.c prio_init/kernel/fork.c
--- 2.6.8-rc2/kernel/fork.c	2004-06-16 12:38:59.000000000 +0400
+++ prio_init/kernel/fork.c	2004-07-27 19:10:46.000000000 +0400
@@ -324,7 +324,6 @@ static inline int dup_mmap(struct mm_str
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		anon_vma_link(tmp);
-		vma_prio_tree_init(tmp);
 		file = tmp->vm_file;
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
diff -urp 2.6.8-rc2/mm/fremap.c prio_init/mm/fremap.c
--- 2.6.8-rc2/mm/fremap.c	2004-07-13 17:52:48.000000000 +0400
+++ prio_init/mm/fremap.c	2004-07-27 19:10:46.000000000 +0400
@@ -214,9 +214,7 @@ asmlinkage long sys_remap_file_pages(uns
 			flush_dcache_mmap_lock(mapping);
 			vma->vm_flags |= VM_NONLINEAR;
 			vma_prio_tree_remove(vma, &mapping->i_mmap);
-			vma_prio_tree_init(vma);
-			list_add_tail(&vma->shared.vm_set.list,
-					&mapping->i_mmap_nonlinear);
+			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 			flush_dcache_mmap_unlock(mapping);
 			spin_unlock(&mapping->i_mmap_lock);
 		}
diff -urp 2.6.8-rc2/mm/mmap.c prio_init/mm/mmap.c
--- 2.6.8-rc2/mm/mmap.c	2004-07-19 12:17:19.000000000 +0400
+++ prio_init/mm/mmap.c	2004-07-27 19:10:46.000000000 +0400
@@ -279,8 +279,7 @@ static inline void __vma_link_file(struc
 
 		flush_dcache_mmap_lock(mapping);
 		if (unlikely(vma->vm_flags & VM_NONLINEAR))
-			list_add_tail(&vma->shared.vm_set.list,
-					&mapping->i_mmap_nonlinear);
+			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 		else
 			vma_prio_tree_insert(vma, &mapping->i_mmap);
 		flush_dcache_mmap_unlock(mapping);
@@ -449,11 +448,8 @@ again:			remove_next = 1 + (end > next->
 	}
 
 	if (root) {
-		if (adjust_next) {
-			vma_prio_tree_init(next);
+		if (adjust_next)
 			vma_prio_tree_insert(next, root);
-		}
-		vma_prio_tree_init(vma);
 		vma_prio_tree_insert(vma, root);
 		flush_dcache_mmap_unlock(mapping);
 	}
@@ -1488,7 +1484,6 @@ int split_vma(struct mm_struct * mm, str
 
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
-	vma_prio_tree_init(new);
 
 	if (new_below)
 		new->vm_end = addr;
@@ -1801,7 +1796,6 @@ struct vm_area_struct *copy_vma(struct v
 		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (new_vma) {
 			*new_vma = *vma;
-			vma_prio_tree_init(new_vma);
 			pol = mpol_copy(vma_policy(vma));
 			if (IS_ERR(pol)) {
 				kmem_cache_free(vm_area_cachep, new_vma);
diff -urp 2.6.8-rc2/mm/prio_tree.c prio_init/mm/prio_tree.c
--- 2.6.8-rc2/mm/prio_tree.c	2004-05-30 13:25:55.000000000 +0400
+++ prio_init/mm/prio_tree.c	2004-07-27 19:16:21.000000000 +0400
@@ -538,6 +538,9 @@ void vma_prio_tree_add(struct vm_area_st
 	BUG_ON(RADIX_INDEX(vma) != RADIX_INDEX(old));
 	BUG_ON(HEAP_INDEX(vma) != HEAP_INDEX(old));
 
+	vma->shared.vm_set.head = NULL;
+	vma->shared.vm_set.parent = NULL;
+
 	if (!old->shared.vm_set.parent)
 		list_add(&vma->shared.vm_set.list,
 				&old->shared.vm_set.list);
@@ -557,6 +560,8 @@ void vma_prio_tree_insert(struct vm_area
 	struct prio_tree_node *ptr;
 	struct vm_area_struct *old;
 
+	vma->shared.vm_set.head = NULL;
+
 	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
 	if (ptr != &vma->shared.prio_tree_node) {
 		old = prio_tree_entry(ptr, struct vm_area_struct,
