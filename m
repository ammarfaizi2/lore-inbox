Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUGTQgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUGTQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUGTQgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 12:36:16 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:48610 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S265981AbUGTQgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 12:36:05 -0400
Message-ID: <40FD4AE4.F47B8431@tv-sign.ru>
Date: Tue, 20 Jul 2004 20:40:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] kill vma_prio_tree_init()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

vma_prio_tree_insert() relies on the fact, that vma was
vma_prio_tree_init()'ed.

I think, it is a bit unsafe, and pointless.

I think, that content of vma->shared should be considered
undefined, until this vma is inserted into i_mmap/i_mmap_nonlinear.
It's better to do proper initialization in vma_prio_tree_add/insert.

Patch on top of shared.vm_set simplifications, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=109025074219118

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp prio_tree/include/linux/mm.h prio_init/include/linux/mm.h
--- prio_tree/include/linux/mm.h	2004-07-19 17:07:41.000000000 +0400
+++ prio_init/include/linux/mm.h	2004-07-20 17:47:23.000000000 +0400
@@ -598,14 +598,6 @@ extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
-static inline void vma_prio_tree_init(struct vm_area_struct *vma)
-{
-	vma->shared.vm_set.parent = NULL;
-	vma->shared.vm_set.unused = NULL;
-	vma->shared.vm_set.list.next = NULL;
-	vma->shared.vm_set.list.prev = NULL;
-}
-
 /* prio_tree.c */
 void vma_prio_tree_add(struct vm_area_struct *, struct vm_area_struct *old);
 void vma_prio_tree_insert(struct vm_area_struct *, struct prio_tree_root *);
@@ -614,6 +606,12 @@ struct vm_area_struct *vma_prio_tree_nex
 	struct vm_area_struct *, struct prio_tree_root *,
 	struct prio_tree_iter *, pgoff_t begin, pgoff_t end);
 
+static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
+					struct list_head *list)
+{
+	list_add_tail(&vma->shared.vm_set.list, list);
+}
+
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert);
diff -urp prio_tree/kernel/fork.c prio_init/kernel/fork.c
--- prio_tree/kernel/fork.c	2004-06-16 12:38:59.000000000 +0400
+++ prio_init/kernel/fork.c	2004-07-20 17:51:14.000000000 +0400
@@ -324,7 +324,6 @@ static inline int dup_mmap(struct mm_str
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		anon_vma_link(tmp);
-		vma_prio_tree_init(tmp);
 		file = tmp->vm_file;
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
diff -urp prio_tree/mm/fremap.c prio_init/mm/fremap.c
--- prio_tree/mm/fremap.c	2004-07-13 17:52:48.000000000 +0400
+++ prio_init/mm/fremap.c	2004-07-20 17:49:24.000000000 +0400
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
diff -urp prio_tree/mm/mmap.c prio_init/mm/mmap.c
--- prio_tree/mm/mmap.c	2004-07-19 12:17:19.000000000 +0400
+++ prio_init/mm/mmap.c	2004-07-20 17:48:37.000000000 +0400
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
diff -urp prio_tree/mm/prio_tree.c prio_init/mm/prio_tree.c
--- prio_tree/mm/prio_tree.c	2004-07-19 17:07:47.000000000 +0400
+++ prio_init/mm/prio_tree.c	2004-07-20 17:25:15.000000000 +0400
@@ -548,6 +548,8 @@ void vma_prio_tree_add(struct vm_area_st
 	BUG_ON(RADIX_INDEX(vma) != RADIX_INDEX(old));
 	BUG_ON(HEAP_INDEX(vma) != HEAP_INDEX(old));
 
+	vma->shared.vm_set.parent = NULL;
+
 	new  = &vma->shared.vm_set.list;
 	head = &old->shared.vm_set.list;
 
@@ -565,6 +567,8 @@ void vma_prio_tree_insert(struct vm_area
 	struct prio_tree_node *ptr;
 	struct vm_area_struct *old;
 
+	vma->shared.vm_set.list.prev = NULL;
+
 	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
 	if (ptr != &vma->shared.prio_tree_node) {
 		old = prio_tree_entry(ptr, struct vm_area_struct,
