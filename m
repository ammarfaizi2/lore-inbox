Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSGWRYB>; Tue, 23 Jul 2002 13:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSGWRYB>; Tue, 23 Jul 2002 13:24:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41019 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S318136AbSGWRX4>; Tue, 23 Jul 2002 13:23:56 -0400
Date: Tue, 23 Jul 2002 18:27:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] VM accounting 1/3 trivial
Message-ID: <Pine.LNX.4.21.0207231823470.10982-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of three patches against 2.4.19-rc3-ac3 fixing some VM accounting.
Could be split further, but this one too trivial to need much thought.

1. do_munmap doesn't need an extra acct arg (and rc3-ac3 still leaves
   arch files without it): just clear VM_ACCOUNT in mremap's move_vma.
2. Remove vm_unacct_vma: in the only two places it's used,
   size is already known and so it can be done more efficiently.
3. Add inline vm_accounts_strictly() to remove a couple of FIXMEs.
4. do_mmap_pgoff used it wrongly: MAP_NORESERVE is in flags not vm_flags
5. do_mremap used it pointlessly: MAP_NORESERVE is invalid in its flags

diff -urN rc3-ac3/drivers/char/drm/i810_dma.c vmacct1/drivers/char/drm/i810_dma.c
--- rc3-ac3/drivers/char/drm/i810_dma.c	Tue Jul 23 15:33:25 2002
+++ vmacct1/drivers/char/drm/i810_dma.c	Tue Jul 23 15:48:24 2002
@@ -231,7 +231,7 @@
 #endif
         	retcode = do_munmap(current->mm,
 				    (unsigned long)buf_priv->virtual,
-				    (size_t) buf->total, 1);
+				    (size_t) buf->total);
 #if LINUX_VERSION_CODE <= 0x020402
 		up( &current->mm->mmap_sem );
 #else
diff -urN rc3-ac3/drivers/char/drm/i830_dma.c vmacct1/drivers/char/drm/i830_dma.c
--- rc3-ac3/drivers/char/drm/i830_dma.c	Tue Jul 23 15:33:25 2002
+++ vmacct1/drivers/char/drm/i830_dma.c	Tue Jul 23 15:48:24 2002
@@ -243,7 +243,7 @@
 		down_write( &current->mm->mmap_sem );
         	retcode = do_munmap(current->mm, 
 				    (unsigned long)buf_priv->virtual, 
-				    (size_t) buf->total, 1);
+				    (size_t) buf->total);
    		up_write( &current->mm->mmap_sem );
 	}
    	buf_priv->currently_mapped = I830_BUF_UNMAPPED;
diff -urN rc3-ac3/drivers/char/drm-4.0/i810_dma.c vmacct1/drivers/char/drm-4.0/i810_dma.c
--- rc3-ac3/drivers/char/drm-4.0/i810_dma.c	Tue Jul 23 15:33:25 2002
+++ vmacct1/drivers/char/drm-4.0/i810_dma.c	Tue Jul 23 15:48:24 2002
@@ -231,7 +231,7 @@
 #else
         	retcode = do_munmap(current->mm, 
 				    (unsigned long)buf_priv->virtual, 
-				    (size_t) buf->total, 1);
+				    (size_t) buf->total);
 #endif
    		up_write(&current->mm->mmap_sem);
 	}
diff -urN rc3-ac3/include/linux/mm.h vmacct1/include/linux/mm.h
--- rc3-ac3/include/linux/mm.h	Tue Jul 23 15:33:34 2002
+++ vmacct1/include/linux/mm.h	Tue Jul 23 15:48:24 2002
@@ -602,7 +602,7 @@
 	return ret;
 }
 
-extern int do_munmap(struct mm_struct *, unsigned long, size_t, int acct);
+extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 extern unsigned long do_brk(unsigned long, unsigned long);

diff -urN rc3-ac3/include/linux/mman.h vmacct1/include/linux/mman.h
--- rc3-ac3/include/linux/mman.h	Tue Jul 23 15:33:34 2002
+++ vmacct1/include/linux/mman.h	Tue Jul 23 15:48:24 2002
@@ -8,7 +8,12 @@
 
 extern int vm_enough_memory(long pages);
 extern void vm_unacct_memory(long pages);
-extern void vm_unacct_vma(struct vm_area_struct *vma);
 extern void vm_validate_enough(char *x);
+
+static inline int vm_accounts_strictly(void)
+{
+	extern int sysctl_overcommit_memory;
+	return sysctl_overcommit_memory > 1;
+}
 
 #endif /* _LINUX_MMAN_H */
diff -urN rc3-ac3/ipc/shm.c vmacct1/ipc/shm.c
--- rc3-ac3/ipc/shm.c	Tue Jul 23 15:33:34 2002
+++ vmacct1/ipc/shm.c	Tue Jul 23 15:48:24 2002
@@ -680,7 +680,7 @@
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start, 1);
+			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
 			retval = 0;
 		}
 	}
diff -urN rc3-ac3/mm/mmap.c vmacct1/mm/mmap.c
--- rc3-ac3/mm/mmap.c	Tue Jul 23 15:33:35 2002
+++ vmacct1/mm/mmap.c	Tue Jul 23 15:48:24 2002
@@ -140,13 +140,6 @@
 	atomic_sub(pages, &vm_committed_space);
 }
 
-void vm_unacct_vma(struct vm_area_struct *vma)
-{
-	int len = vma->vm_end - vma->vm_start;
-	if(vma->vm_flags & VM_ACCOUNT)
-		vm_unacct_memory(len >> PAGE_SHIFT);
-}
-
 /*
  *	Don't even bother telling me the locking is wrong - its a test
  *	routine and uniprocessor is quite sufficient..
@@ -253,7 +246,7 @@
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk, 1))
+		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
 			goto set_brk;
 		goto out;
 	}
@@ -591,9 +584,8 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	/* FIXME - this ought to be a nice inline ! */
-	if(sysctl_overcommit_memory > 1)
-		vm_flags &= ~MAP_NORESERVE;
+	if (vm_accounts_strictly())
+		flags &= ~MAP_NORESERVE;
 	
 	/* Private writable mapping? Check memory availability.. */
 
@@ -938,7 +930,7 @@
  */
 static struct vm_area_struct * unmap_fixup(struct mm_struct *mm, 
 	struct vm_area_struct *area, unsigned long addr, size_t len, 
-	struct vm_area_struct *extra, int acct)
+	struct vm_area_struct *extra)
 {
 	struct vm_area_struct *mpnt;
 	unsigned long end = addr + len;
@@ -946,6 +938,8 @@
 	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
 	if (area->vm_flags & VM_LOCKED)
 		area->vm_mm->locked_vm -= len >> PAGE_SHIFT;
+	if (area->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(len >> PAGE_SHIFT);
 
 	/* Unmapping the whole area. */
 	if (addr == area->vm_start && end == area->vm_end) {
@@ -953,15 +947,10 @@
 			area->vm_ops->close(area);
 		if (area->vm_file)
 			fput(area->vm_file);
-		if(acct)
-			vm_unacct_vma(area);
 		kmem_cache_free(vm_area_cachep, area);
 		return extra;
 	}
 
-	if(acct && (area->vm_flags & VM_ACCOUNT))
-		vm_unacct_memory(len >> PAGE_SHIFT);
-	
 	/* Work out to one of the ends. */
 	if (end == area->vm_end) {
 		/*
@@ -1075,11 +1064,11 @@
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardine <jeremy@sw.oz.au>
  */
-int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len, int acct)
+int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
 {
 	struct vm_area_struct *mpnt, *prev, **npp, *free, *extra;
 
-	if(acct) vm_validate_enough("entering do_munmap");
+	vm_validate_enough("entering do_munmap");
 
 	if ((addr & ~PAGE_MASK) || addr > TASK_SIZE || len > TASK_SIZE-addr)
 		return -EINVAL;
@@ -1156,7 +1145,7 @@
 		/*
 		 * Fix the mapping, and free the old area if it wasn't reused.
 		 */
-		extra = unmap_fixup(mm, mpnt, st, size, extra, acct);
+		extra = unmap_fixup(mm, mpnt, st, size, extra);
 		if (file)
 			atomic_inc(&file->f_dentry->d_inode->i_writecount);
 	}
@@ -1167,7 +1156,7 @@
 		kmem_cache_free(vm_area_cachep, extra);
 
 	free_pgtables(mm, prev, addr, addr+len);
-	if(acct) vm_validate_enough("exit -ok- do_munmap");
+	vm_validate_enough("exit -ok- do_munmap");
 
 	return 0;
 }
@@ -1178,7 +1167,7 @@
 	struct mm_struct *mm = current->mm;
 
 	down_write(&mm->mmap_sem);
-	ret = do_munmap(mm, addr, len, 1);
+	ret = do_munmap(mm, addr, len);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
@@ -1218,7 +1207,7 @@
  munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len, 1))
+		if (do_munmap(mm, addr, len))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -1314,7 +1303,7 @@
 
 		/* If the VMA has been charged for, account for its removal */
 		if (mpnt->vm_flags & VM_ACCOUNT)
-			vm_unacct_vma(mpnt);
+			vm_unacct_memory(size >> PAGE_SHIFT);
 	
 		if (mpnt->vm_ops) {
 			if (mpnt->vm_ops->close)
diff -urN rc3-ac3/mm/mremap.c vmacct1/mm/mremap.c
--- rc3-ac3/mm/mremap.c	Tue Jul 23 15:33:35 2002
+++ vmacct1/mm/mremap.c	Tue Jul 23 15:48:24 2002
@@ -213,8 +213,8 @@
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
-		/* The old VMA has been accounted for, don't double account */
-		do_munmap(current->mm, addr, old_len, 0);
+		vma->vm_flags &= ~VM_ACCOUNT;
+		do_munmap(current->mm, addr, old_len);
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
 		if (new_vma->vm_flags & VM_LOCKED) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
@@ -240,8 +240,6 @@
 	unsigned long old_len, unsigned long new_len,
 	unsigned long flags, unsigned long new_addr)
 {
-	extern int sysctl_overcommit_memory;	/* FIXME!! */
-
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
@@ -274,7 +272,7 @@
 		if ((addr <= new_addr) && (addr+old_len) > new_addr)
 			goto out;
 
-		do_munmap(current->mm, new_addr, new_len, 1);
+		do_munmap(current->mm, new_addr, new_len);
 	}
 
 	/*
@@ -284,7 +282,7 @@
 	 */
 	ret = addr;
 	if (old_len >= new_len) {
-		do_munmap(current->mm, addr+new_len, old_len - new_len, 1);
+		do_munmap(current->mm, addr+new_len, old_len - new_len);
 		if (!(flags & MREMAP_FIXED) || (new_addr == addr))
 			goto out;
 	}
@@ -315,16 +313,12 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
 
-        /* FIXME - this ought to be a nice inline ! */
-	if(sysctl_overcommit_memory > 1)
-		flags &= ~MAP_NORESERVE;
-                                	
-	if(vma->vm_flags&VM_ACCOUNT)
-	{
+	if (vma->vm_flags & VM_ACCOUNT) {
 		charged = (new_len - old_len) >> PAGE_SHIFT;
 		if(!vm_enough_memory(charged))
 			goto out_nc;
 	}
+
 	/* old_len exactly to the end of the area..
 	 * And we're not relocating the area.
 	 */

