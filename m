Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUFBUJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUFBUJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUFBUJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:09:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38457 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264002AbUFBUJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:09:28 -0400
Date: Wed, 2 Jun 2004 21:09:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vma_adjust insert file earlier
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022108330.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those arches (arm and parisc) which use the i_mmap tree to implement
flush_dcache_page, during split_vma there's a small window in vma_adjust
when flush_dcache_mmap_lock is dropped, and pages in the split-off part
of the vma might for an instant be invisible to __flush_dcache_page.

Though we're more solid there than ever before, I guess it's a bad idea
to leave that window: so (with regret, it was structurally nicer before)
take __vma_link_file (and vma_prio_tree_init) out of __vma_link.

vma_prio_tree_init (which NULLs a few fields) is actually only needed
when copying a vma, not when a new one has just been memset to 0.

__insert_vm_struct is used by nothing but vma_adjust's split_vma case:
comment it accordingly, remove its mark_mm_hugetlb (it can never create
a new kind of vma) and its validate_mm (another follows immediately).

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/mmap.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

--- 2.6.7-rc2/mm/mmap.c	2004-05-30 11:36:40.000000000 +0100
+++ linux/mm/mmap.c	2004-06-02 16:31:55.343008336 +0100
@@ -293,10 +293,8 @@ __vma_link(struct mm_struct *mm, struct 
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
-	vma_prio_tree_init(vma);
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
-	__vma_link_file(vma);
 	__anon_vma_link(vma);
 }
 
@@ -312,7 +310,10 @@ static void vma_link(struct mm_struct *m
 	if (mapping)
 		spin_lock(&mapping->i_mmap_lock);
 	anon_vma_lock(vma);
+
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	__vma_link_file(vma);
+
 	anon_vma_unlock(vma);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
@@ -323,9 +324,9 @@ static void vma_link(struct mm_struct *m
 }
 
 /*
- * Insert vm structure into process list sorted by address and into the
- * inode's i_mmap tree. The caller should hold mm->mmap_sem and
- * ->f_mappping->i_mmap_lock if vm_file is non-NULL.
+ * Helper for vma_adjust in the split_vma insert case:
+ * insert vm structure into list and rbtree and anon_vma,
+ * but it has already been inserted into prio_tree earlier.
  */
 static void
 __insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
@@ -337,9 +338,7 @@ __insert_vm_struct(struct mm_struct * mm
 	if (__vma && __vma->vm_start < vma->vm_end)
 		BUG();
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
-	mark_mm_hugetlb(mm, vma);
 	mm->map_count++;
-	validate_mm(mm);
 }
 
 static inline void
@@ -396,6 +395,15 @@ again:			remove_next = 1 + (end > next->
 		if (!(vma->vm_flags & VM_NONLINEAR))
 			root = &mapping->i_mmap;
 		spin_lock(&mapping->i_mmap_lock);
+		if (insert) {
+			/*
+			 * Put into prio_tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(insert);
+		}
 	}
 
 	/*
@@ -1456,6 +1464,7 @@ int split_vma(struct mm_struct * mm, str
 
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
+	vma_prio_tree_init(new);
 
 	if (new_below)
 		new->vm_end = addr;
@@ -1768,6 +1777,7 @@ struct vm_area_struct *copy_vma(struct v
 		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (new_vma) {
 			*new_vma = *vma;
+			vma_prio_tree_init(new_vma);
 			pol = mpol_copy(vma_policy(vma));
 			if (IS_ERR(pol)) {
 				kmem_cache_free(vm_area_cachep, new_vma);

