Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTFDWRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTFDWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:17:18 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:37327 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264232AbTFDWRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:17:04 -0400
Date: Wed, 04 Jun 2003 17:30:25 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove page_table_lock from vma manipulations
Message-ID: <133290000.1054765825@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1937579384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1937579384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


After more careful consideration, I don't see any reasons why
page_table_lock is necessary for dealing with vmas.  I found one spot in
swapoff, but it was easily changed to mmap_sem.  I've beat on this code and
mjb has beat on this code with no problems.  Here's the patch to remove it.

Feel free to poke holes in it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1937579384==========
Content-Type: text/plain; charset=iso-8859-1; name="nolock-2.5.70-mm4-1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="nolock-2.5.70-mm4-1.diff";
 size=4566

--- 2.5.70-mm4/./mm/swapfile.c	2003-05-26 20:00:25.000000000 -0500
+++ 2.5.70-mm4-nolock/./mm/swapfile.c	2003-06-04 16:02:49.000000000 -0500
@@ -493,6 +493,7 @@ static int unuse_process(struct mm_struc
 	/*
 	 * Go through process' page directory.
 	 */
+	down_read(&mm->mmap_sem);
 	spin_lock(&mm->page_table_lock);
 	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
 		pgd_t * pgd =3D pgd_offset(mm, vma->vm_start);
@@ -500,6 +501,7 @@ static int unuse_process(struct mm_struc
 			break;
 	}
 	spin_unlock(&mm->page_table_lock);
+	up_read(&mm->mmap_sem);
 	pte_chain_free(pte_chain);
 	return 0;
 }
--- 2.5.70-mm4/./mm/mmap.c	2003-06-04 15:47:24.000000000 -0500
+++ 2.5.70-mm4-nolock/./mm/mmap.c	2003-06-04 16:02:49.000000000 -0500
@@ -346,9 +346,7 @@ static void vma_link(struct mm_struct *m
=20
 	if (mapping)
 		down(&mapping->i_shared_sem);
-	spin_lock(&mm->page_table_lock);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
-	spin_unlock(&mm->page_table_lock);
 	if (mapping)
 		up(&mapping->i_shared_sem);
=20
@@ -429,7 +427,6 @@ static int vma_merge(struct mm_struct *m
 			unsigned long end, unsigned long vm_flags,
 			struct file *file, unsigned long pgoff)
 {
-	spinlock_t * lock =3D &mm->page_table_lock;
=20
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags, so this tests
@@ -458,7 +455,6 @@ static int vma_merge(struct mm_struct *m
 			down(&inode->i_mapping->i_shared_sem);
 			need_up =3D 1;
 		}
-		spin_lock(lock);
 		prev->vm_end =3D end;
=20
 		/*
@@ -471,7 +467,6 @@ static int vma_merge(struct mm_struct *m
 			prev->vm_end =3D next->vm_end;
 			__vma_unlink(mm, next, prev);
 			__remove_shared_vm_struct(next, inode);
-			spin_unlock(lock);
 			if (need_up)
 				up(&inode->i_mapping->i_shared_sem);
 			if (file)
@@ -481,7 +476,6 @@ static int vma_merge(struct mm_struct *m
 			kmem_cache_free(vm_area_cachep, next);
 			return 1;
 		}
-		spin_unlock(lock);
 		if (need_up)
 			up(&inode->i_mapping->i_shared_sem);
 		return 1;
@@ -497,10 +491,8 @@ static int vma_merge(struct mm_struct *m
 				pgoff, (end - addr) >> PAGE_SHIFT))
 			return 0;
 		if (end =3D=3D prev->vm_start) {
-			spin_lock(lock);
 			prev->vm_start =3D addr;
 			prev->vm_pgoff -=3D (end - addr) >> PAGE_SHIFT;
-			spin_unlock(lock);
 			return 1;
 		}
 	}
@@ -945,19 +937,16 @@ int expand_stack(struct vm_area_struct *
 	 */
 	address +=3D 4 + PAGE_SIZE - 1;
 	address &=3D PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
 	grow =3D (address - vma->vm_end) >> PAGE_SHIFT;
=20
 	/* Overcommit.. */
 	if (!vm_enough_memory(grow)) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
 	
 	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -965,7 +954,6 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm +=3D grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm +=3D grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
 	return 0;
 }
=20
@@ -999,19 +987,16 @@ int expand_stack(struct vm_area_struct *
 	 * the spinlock only before relocating the vma range ourself.
 	 */
 	address &=3D PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
 	grow =3D (vma->vm_start - address) >> PAGE_SHIFT;
=20
 	/* Overcommit.. */
 	if (!vm_enough_memory(grow)) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
 	
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -1020,7 +1005,6 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm +=3D grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm +=3D grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
 	return 0;
 }
=20
@@ -1183,8 +1167,6 @@ static void unmap_region(struct mm_struc
 /*
  * Create a list of vma's touched by the unmap, removing them from the =
mm's
  * vma list as we go..
- *
- * Called with the page_table_lock held.
  */
 static void
 detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct =
*vma,
@@ -1308,8 +1290,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
-	spin_lock(&mm->page_table_lock);
 	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
+	spin_lock(&mm->page_table_lock);
 	unmap_region(mm, mpnt, prev, start, end);
 	spin_unlock(&mm->page_table_lock);
=20

--==========1937579384==========--

