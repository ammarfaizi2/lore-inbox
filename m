Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSHBPZ4>; Fri, 2 Aug 2002 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSHBPZ4>; Fri, 2 Aug 2002 11:25:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315415AbSHBPZy>;
	Fri, 2 Aug 2002 11:25:54 -0400
Date: Fri, 2 Aug 2002 16:29:24 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/mmap.c: upward-growing stacks
Message-ID: <20020802162924.C24631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - trivial: cache file->f_dentry->d_inode; saves a few bytes of compiled
   size.
 - move expand_stack inside ARCH_STACK_GROWSUP, add an alternate
   implementation for PA-RISC.
 - partially fix the comment (mmap_sem is held for READ, not for WRITE).
   It still doesn't make sense, saying we don't need to take the spinlock
   right before we take it.  I expect one of the vm hackers will know
   what the right thing is.

diff -urpNX dontdiff linux-2.5.30/mm/mmap.c linux-2.5.30-willy/mm/mmap.c
--- linux-2.5.30/mm/mmap.c	2002-08-02 05:44:53.000000000 -0600
+++ linux-2.5.30-willy/mm/mmap.c	2002-08-02 08:24:26.000000000 -0600
@@ -422,6 +422,7 @@ unsigned long do_mmap_pgoff(struct file 
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
+	struct inode *inode = NULL;
 	unsigned int vm_flags;
 	int correct_wcount = 0;
 	int error;
@@ -469,17 +470,18 @@ unsigned long do_mmap_pgoff(struct file 
 	}
 
 	if (file) {
+		inode = file->f_dentry->d_inode;
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
 			if ((prot & PROT_WRITE) && !(file->f_mode & FMODE_WRITE))
 				return -EACCES;
 
 			/* Make sure we don't allow writing to an append-only file.. */
-			if (IS_APPEND(file->f_dentry->d_inode) && (file->f_mode & FMODE_WRITE))
+			if (IS_APPEND(inode) && (file->f_mode & FMODE_WRITE))
 				return -EACCES;
 
 			/* make sure there are no mandatory locks on the file. */
-			if (locks_verify_locked(file->f_dentry->d_inode))
+			if (locks_verify_locked(inode))
 				return -EAGAIN;
 
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
@@ -603,7 +605,7 @@ munmap_back:
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	if (correct_wcount)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
+		atomic_inc(&inode->i_writecount);
 
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -615,7 +617,7 @@ out:	
 
 unmap_and_free_vma:
 	if (correct_wcount)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
+		atomic_inc(&inode->i_writecount);
 	vma->vm_file = NULL;
 	fput(file);
 
@@ -755,38 +757,41 @@ struct vm_area_struct * find_vma_prev(st
 	return prev ? prev->vm_next : vma;
 }
 
+#ifdef ARCH_STACK_GROWSUP
 /*
- * vma is the first one with  address < vma->vm_end,
- * and even address < vma->vm_start. Have to extend vma.
+ * vma is the first one with address > vma->vm_end.  Have to extend vma.
  */
 int expand_stack(struct vm_area_struct * vma, unsigned long address)
 {
 	unsigned long grow;
 
+	if (!(vma->vm_flags & VM_GROWSUP))
+		return -EFAULT;
+
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
-	 * is required to hold the mmap_sem in write mode. We need to get
+	 * is required to hold the mmap_sem in read mode. We need to get
 	 * the spinlock only before relocating the vma range ourself.
 	 */
+	address += 4 + PAGE_SIZE - 1;
 	address &= PAGE_MASK;
  	spin_lock(&vma->vm_mm->page_table_lock);
-	grow = (vma->vm_start - address) >> PAGE_SHIFT;
+	grow = (address - vma->vm_end) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
-	if(!vm_enough_memory(grow)) {
+	if (!vm_enough_memory(grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
 	
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
-	vma->vm_start = address;
-	vma->vm_pgoff -= grow;
+	vma->vm_end = address;
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
@@ -794,7 +799,6 @@ int expand_stack(struct vm_area_struct *
 	return 0;
 }
 
-#ifdef ARCH_STACK_GROWSUP
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
 	struct vm_area_struct *vma, *prev;
@@ -811,6 +815,44 @@ struct vm_area_struct * find_extend_vma(
 	return prev;
 }
 #else
+/*
+ * vma is the first one with address < vma->vm_start.  Have to extend vma.
+ */
+int expand_stack(struct vm_area_struct * vma, unsigned long address)
+{
+	unsigned long grow;
+
+	/*
+	 * vma->vm_start/vm_end cannot change under us because the caller
+	 * is required to hold the mmap_sem in read mode. We need to get
+	 * the spinlock only before relocating the vma range ourself.
+	 */
+	address &= PAGE_MASK;
+ 	spin_lock(&vma->vm_mm->page_table_lock);
+	grow = (vma->vm_start - address) >> PAGE_SHIFT;
+
+	/* Overcommit.. */
+	if (!vm_enough_memory(grow)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return -ENOMEM;
+	}
+	
+	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
+			current->rlim[RLIMIT_AS].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		return -ENOMEM;
+	}
+	vma->vm_start = address;
+	vma->vm_pgoff -= grow;
+	vma->vm_mm->total_vm += grow;
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm += grow;
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return 0;
+}
+
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
 	struct vm_area_struct * vma;

-- 
Revolutions do not require corporate support.
