Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTDHSDM (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDHSDM (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 14:03:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4544 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S261999AbTDHSDJ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 14:03:09 -0400
Date: Tue, 8 Apr 2003 19:16:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix obj vma sorting
Message-ID: <Pine.LNX.4.44.0304081914110.10459-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several points in objrmap's vma sorting:

1. It was adding all vmas, even private ones, to i_mmap_shared.
2. It was not quite sorting: list_add_tail is needed in all cases.
3. If vm_pgoff is changed on a file vma (as in vma_merge and split_vma)
   we must unlink vma from list and relink while holding i_shared_sem:
   move_vma_start to do this (holds page_table_lock too, as vma_merge
   did and split_vma did not: I think nothing needs that, rip it out
   if you like, but my guess was that you'd prefer the extra safety).

Sorry, no, this doesn't magically make it all a hundred times faster.

--- 2.5.67-mm1/mm/mmap.c	Tue Apr  8 14:02:06 2003
+++ linux/mm/mmap.c	Tue Apr  8 18:06:07 2003
@@ -321,16 +321,13 @@
 		else
 			vmhead = &mapping->i_mmap;
 
-		list_for_each(vmlist, &mapping->i_mmap_shared) {
+		list_for_each(vmlist, vmhead) {
 			struct vm_area_struct *vmtemp;
 			vmtemp = list_entry(vmlist, struct vm_area_struct, shared);
 			if (vmtemp->vm_pgoff >= vma->vm_pgoff)
 				break;
 		}
-		if (vmlist == vmhead)
-			list_add_tail(&vma->shared, vmlist);
-		else
-			list_add(&vma->shared, vmlist);
+		list_add_tail(&vma->shared, vmlist);
 	}
 }
 
@@ -366,6 +363,28 @@
 	validate_mm(mm);
 }
 
+static void move_vma_start(struct vm_area_struct *vma, unsigned long addr)
+{
+	spinlock_t *lock = &vma->vm_mm->page_table_lock;
+	struct inode *inode = NULL;
+	
+	if (vma->vm_file) {
+		inode = vma->vm_file->f_dentry->d_inode;
+		down(&inode->i_mapping->i_shared_sem);
+	}
+	spin_lock(lock);
+	if (inode)
+		__remove_shared_vm_struct(vma, inode);
+	/* If no vm_file, perhaps we should always keep vm_pgoff at 0?? */
+	vma->vm_pgoff += (long)(addr - vma->vm_start) >> PAGE_SHIFT;
+	vma->vm_start = addr;
+	if (inode) {
+		__vma_link_file(vma);
+		up(&inode->i_mapping->i_shared_sem);
+	}
+	spin_unlock(lock);
+}
+
 /*
  * Return true if we can merge this (vm_flags,file,vm_pgoff,size)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -422,8 +441,6 @@
 			unsigned long end, unsigned long vm_flags,
 			struct file *file, unsigned long pgoff)
 {
-	spinlock_t * lock = &mm->page_table_lock;
-
 	if (!prev) {
 		prev = rb_entry(rb_parent, struct vm_area_struct, vm_rb);
 		goto merge_next;
@@ -435,6 +452,7 @@
 	if (prev->vm_end == addr &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		struct vm_area_struct *next;
+		spinlock_t *lock = &mm->page_table_lock;
 		struct inode *inode = file ? file->f_dentry->d_inode : NULL;
 		int need_up = 0;
 
@@ -480,10 +498,7 @@
 				pgoff, (end - addr) >> PAGE_SHIFT))
 			return 0;
 		if (end == prev->vm_start) {
-			spin_lock(lock);
-			prev->vm_start = addr;
-			prev->vm_pgoff -= (end - addr) >> PAGE_SHIFT;
-			spin_unlock(lock);
+			move_vma_start(prev, addr);
 			return 1;
 		}
 	}
@@ -1203,8 +1218,7 @@
 
 	if (new_below) {
 		new->vm_end = addr;
-		vma->vm_start = addr;
-		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
+		move_vma_start(vma, addr);
 	} else {
 		vma->vm_end = addr;
 		new->vm_start = addr;

