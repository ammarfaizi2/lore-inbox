Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318147AbSG2WNC>; Mon, 29 Jul 2002 18:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSG2WNB>; Mon, 29 Jul 2002 18:13:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25448 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318147AbSG2WMn>; Mon, 29 Jul 2002 18:12:43 -0400
Date: Mon, 29 Jul 2002 23:16:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct9/9 remove acct arg from do_munmap
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292315040.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An acct flag was added to do_munmap, true everywhere but in mremap's
move_vma: instead of updating the arch and driver sources, revert that
that change and temporarily mask VM_ACCOUNT around that one do_munmap.

Also, noticed that do_mremap fails needlessly if both shrinking _and_
moving a mapping: update old_len to pass vm area boundaries test.

--- vmacct8/include/linux/mm.h	Mon Jul 29 19:23:46 2002
+++ vmacct9/include/linux/mm.h	Mon Jul 29 19:23:46 2002
@@ -430,7 +430,7 @@
 	return ret;
 }
 
-extern int do_munmap(struct mm_struct *, unsigned long, size_t, int);
+extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
--- vmacct8/ipc/shm.c	Mon Jul 29 19:23:46 2002
+++ vmacct9/ipc/shm.c	Mon Jul 29 19:23:46 2002
@@ -671,7 +671,7 @@
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start, 1);
+			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
 			retval = 0;
 		}
 	}
--- vmacct8/mm/mmap.c	Mon Jul 29 19:23:46 2002
+++ vmacct9/mm/mmap.c	Mon Jul 29 19:23:46 2002
@@ -197,7 +197,7 @@
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk, 1))
+		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
 			goto set_brk;
 		goto out;
 	}
@@ -517,7 +517,7 @@
 munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len, 1))
+		if (do_munmap(mm, addr, len))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -945,8 +945,7 @@
 	struct vm_area_struct *mpnt,
 	struct vm_area_struct *prev,
 	unsigned long start,
-	unsigned long end,
-	int acct)
+	unsigned long end)
 {
 	mmu_gather_t *tlb;
 
@@ -960,7 +959,7 @@
 
 		unmap_page_range(tlb, mpnt, from, to);
 
-		if (acct && (mpnt->vm_flags & VM_ACCOUNT)) {
+		if (mpnt->vm_flags & VM_ACCOUNT) {
 			len = to - from;
 			vm_unacct_memory(len >> PAGE_SHIFT);
 		}
@@ -1041,7 +1040,7 @@
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardine <jeremy@sw.oz.au>
  */
-int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, int acct)
+int do_munmap(struct mm_struct *mm, unsigned long start, size_t len)
 {
 	unsigned long end;
 	struct vm_area_struct *mpnt, *prev, *last;
@@ -1085,7 +1084,7 @@
 	 */
 	spin_lock(&mm->page_table_lock);
 	mpnt = touched_by_munmap(mm, mpnt, prev, end);
-	unmap_region(mm, mpnt, prev, start, end, acct);
+	unmap_region(mm, mpnt, prev, start, end);
 	spin_unlock(&mm->page_table_lock);
 
 	/* Fix up all other VM information */
@@ -1100,7 +1099,7 @@
 	struct mm_struct *mm = current->mm;
 
 	down_write(&mm->mmap_sem);
-	ret = do_munmap(mm, addr, len, 1);
+	ret = do_munmap(mm, addr, len);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
@@ -1137,7 +1136,7 @@
  munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len, 1))
+		if (do_munmap(mm, addr, len))
 			return -ENOMEM;
 		goto munmap_back;
 	}
--- vmacct8/mm/mremap.c	Mon Jul 29 19:23:46 2002
+++ vmacct9/mm/mremap.c	Mon Jul 29 19:23:46 2002
@@ -150,6 +150,7 @@
 	struct mm_struct * mm = vma->vm_mm;
 	struct vm_area_struct * new_vma, * next, * prev;
 	int allocated_vma;
+	int split = 0;
 
 	new_vma = NULL;
 	next = find_vma_prev(mm, new_addr, &prev);
@@ -210,11 +211,26 @@
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
-		/*
-		 * The old VMA has been accounted for,
-		 * don't double account
-		 */
-		do_munmap(current->mm, addr, old_len, 0);
+
+		/* Conceal VM_ACCOUNT so old reservation is not undone */
+		if (vma->vm_flags & VM_ACCOUNT) {
+			vma->vm_flags &= ~VM_ACCOUNT;
+			if (addr > vma->vm_start) {
+				if (addr + old_len < vma->vm_end)
+					split = 1;
+			} else if (addr + old_len == vma->vm_end)
+				vma = NULL;	/* it will be removed */
+		} else
+			vma = NULL;		/* nothing more to do */
+
+		do_munmap(current->mm, addr, old_len);
+
+		/* Restore VM_ACCOUNT if one or two pieces of vma left */
+		if (vma) {
+			vma->vm_flags |= VM_ACCOUNT;
+			if (split)
+				vma->vm_next->vm_flags |= VM_ACCOUNT;
+		}
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
 		if (new_vma->vm_flags & VM_LOCKED) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
@@ -272,7 +288,7 @@
 		if ((addr <= new_addr) && (addr+old_len) > new_addr)
 			goto out;
 
-		do_munmap(current->mm, new_addr, new_len, 1);
+		do_munmap(current->mm, new_addr, new_len);
 	}
 
 	/*
@@ -282,9 +298,10 @@
 	 */
 	ret = addr;
 	if (old_len >= new_len) {
-		do_munmap(current->mm, addr+new_len, old_len - new_len, 1);
+		do_munmap(current->mm, addr+new_len, old_len - new_len);
 		if (!(flags & MREMAP_FIXED) || (new_addr == addr))
 			goto out;
+		old_len = new_len;
 	}
 
 	/*

