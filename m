Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUJCS2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUJCS2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268055AbUJCS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:28:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38439 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268052AbUJCS1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:27:42 -0400
Date: Sun, 3 Oct 2004 19:27:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] vmtrunc: vm_truncate_count race caution
In-Reply-To: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410031926370.2755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some unlikely races in respect of vm_truncate_count.

Firstly, it's supposed to be guarded by i_mmap_lock, but some places
copy a vma structure by *new_vma = *old_vma: if the compiler implements
that with a bytewise copy, new_vma->vm_truncate_count could be munged,
and new_vma later appear up-to-date when it's not; so set it properly
once under lock.

vma_link set vm_truncate_count to mapping->truncate_count when adding an
empty vma: if new vmas are being added profusely while vmtruncate is in
progess, this lets them be skipped without scanning.

vma_adjust has vm_truncate_count problem much like it had with anon_vma
under mprotect merge: when merging be careful not to leave vma marked as
up-to-date when it might not be, lest unmap_mapping_range in progress -
set vm_truncate_count 0 when in doubt.  Similarly when mremap moving
ptes from one vma to another.

Cut a little code from __anon_vma_merge: now vma_adjust sets "importer"
in the remove_next case (to get its vm_truncate_count right), its
anon_vma is already linked by the time __anon_vma_merge is called.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/fork.c |    1 +
 mm/mmap.c     |   14 +++++++++++++-
 mm/mremap.c   |   16 ++++++++++------
 mm/rmap.c     |    9 +--------
 4 files changed, 25 insertions(+), 15 deletions(-)

--- trunc4/kernel/fork.c	2004-10-02 18:22:28.000000000 +0100
+++ trunc5/kernel/fork.c	2004-10-03 16:37:39.670145872 +0100
@@ -221,6 +221,7 @@ static inline int dup_mmap(struct mm_str
       
 			/* insert tmp into the share list, just after mpnt */
 			spin_lock(&file->f_mapping->i_mmap_lock);
+			tmp->vm_truncate_count = mpnt->vm_truncate_count;
 			flush_dcache_mmap_lock(file->f_mapping);
 			vma_prio_tree_add(tmp, mpnt);
 			flush_dcache_mmap_unlock(file->f_mapping);
--- trunc4/mm/mmap.c	2004-10-02 18:22:29.000000000 +0100
+++ trunc5/mm/mmap.c	2004-10-03 16:37:39.673145416 +0100
@@ -307,8 +307,10 @@ static void vma_link(struct mm_struct *m
 	if (vma->vm_file)
 		mapping = vma->vm_file->f_mapping;
 
-	if (mapping)
+	if (mapping) {
 		spin_lock(&mapping->i_mmap_lock);
+		vma->vm_truncate_count = mapping->truncate_count;
+	}
 	anon_vma_lock(vma);
 
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
@@ -379,6 +381,7 @@ void vma_adjust(struct vm_area_struct *v
 again:			remove_next = 1 + (end > next->vm_end);
 			end = next->vm_end;
 			anon_vma = next->anon_vma;
+			importer = vma;
 		} else if (end > next->vm_start) {
 			/*
 			 * vma expands, overlapping part of the next:
@@ -404,7 +407,16 @@ again:			remove_next = 1 + (end > next->
 		if (!(vma->vm_flags & VM_NONLINEAR))
 			root = &mapping->i_mmap;
 		spin_lock(&mapping->i_mmap_lock);
+		if (importer &&
+		    vma->vm_truncate_count != next->vm_truncate_count) {
+			/*
+			 * unmap_mapping_range might be in progress:
+			 * ensure that the expanding vma is rescanned.
+			 */
+			importer->vm_truncate_count = 0;
+		}
 		if (insert) {
+			insert->vm_truncate_count = vma->vm_truncate_count;
 			/*
 			 * Put into prio_tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
--- trunc4/mm/mremap.c	2004-10-02 18:22:29.000000000 +0100
+++ trunc5/mm/mremap.c	2004-10-03 16:37:39.675145112 +0100
@@ -82,7 +82,7 @@ static inline pte_t *alloc_one_pte_map(s
 
 static int
 move_one_page(struct vm_area_struct *vma, unsigned long old_addr,
-		unsigned long new_addr)
+		struct vm_area_struct *new_vma, unsigned long new_addr)
 {
 	struct address_space *mapping = NULL;
 	struct mm_struct *mm = vma->vm_mm;
@@ -98,6 +98,9 @@ move_one_page(struct vm_area_struct *vma
 		 */
 		mapping = vma->vm_file->f_mapping;
 		spin_lock(&mapping->i_mmap_lock);
+		if (new_vma->vm_truncate_count &&
+		    new_vma->vm_truncate_count != vma->vm_truncate_count)
+			new_vma->vm_truncate_count = 0;
 	}
 	spin_lock(&mm->page_table_lock);
 
@@ -144,8 +147,8 @@ move_one_page(struct vm_area_struct *vma
 }
 
 static unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long new_addr, unsigned long old_addr,
-		unsigned long len)
+		unsigned long old_addr, struct vm_area_struct *new_vma,
+		unsigned long new_addr, unsigned long len)
 {
 	unsigned long offset;
 
@@ -157,7 +160,8 @@ static unsigned long move_page_tables(st
 	 * only a few pages.. This also makes error recovery easier.
 	 */
 	for (offset = 0; offset < len; offset += PAGE_SIZE) {
-		if (move_one_page(vma, old_addr+offset, new_addr+offset) < 0)
+		if (move_one_page(vma, old_addr + offset,
+				new_vma, new_addr + offset) < 0)
 			break;
 		cond_resched();
 	}
@@ -188,14 +192,14 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;
 
-	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
+	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len);
 	if (moved_len < old_len) {
 		/*
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, old_addr, new_addr, moved_len);
+		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
--- trunc4/mm/rmap.c	2004-10-02 18:22:29.000000000 +0100
+++ trunc5/mm/rmap.c	2004-10-03 16:37:39.676144960 +0100
@@ -120,14 +120,7 @@ int anon_vma_prepare(struct vm_area_stru
 
 void __anon_vma_merge(struct vm_area_struct *vma, struct vm_area_struct *next)
 {
-	if (!vma->anon_vma) {
-		BUG_ON(!next->anon_vma);
-		vma->anon_vma = next->anon_vma;
-		list_add(&vma->anon_vma_node, &next->anon_vma_node);
-	} else {
-		/* if they're both non-null they must be the same */
-		BUG_ON(vma->anon_vma != next->anon_vma);
-	}
+	BUG_ON(vma->anon_vma != next->anon_vma);
 	list_del(&next->anon_vma_node);
 }
 

