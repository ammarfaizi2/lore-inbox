Return-Path: <linux-kernel-owner+willy=40w.ods.org-S311227AbUKAUHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S311227AbUKAUHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 15:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S311220AbUKAUHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 15:07:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291957AbUKATa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:58 -0500
Date: Mon, 1 Nov 2004 19:30:22 GMT
Message-Id: <200411011930.iA1JUMQe023259@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 14/14] FRV: Better mmap support in uClinux
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>, <20040401020550.GG3150@beast>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch changes mm/nommu.c to better support mmap() when MMU support
is disabled (as it is in uClinux).

This was discussed on the uclibc mailing list in a thread revolving around the
following message:

	Date: Thu, 1 Apr 2004 12:05:50 +1000
	From: David McCullough <davidm@snapgear.com>
	To: David Howells <dhowells@redhat.com>
	Cc: Alexandre Oliva <aoliva@redhat.com>, uclibc@uclibc.org
	Subject: Re: [uClibc] mmaps for malloc should be private
	Message-ID: <20040401020550.GG3150@beast>

The revised rules are:

 (1) Anonymous mappings can be shared or private, read or write.

 (2) Chardevs can be mapped shared, provided they supply a get_unmapped_area()
     file operation and use that to set the address of the mapping (as a frame
     buffer driver might do, for instance).

 (3) Files (and blockdevs) cannot be mapped shared since it is not really
     possible to honour this by writing any changes back to the backing device.

 (4) Files (or sections thereof) can be mapped read-only private, in which case
     the mapped bit will be read into memory and shared, and its address will
     be returned. Any excess beyond EOF will be cleared.

 (5) Files (or sections thereof) can be mapped writable private, in which case
     a private copy of the mapped bit will be read into a new bit memory, and
     its address will be returned. Any excess beyond EOF will be cleared.

Mappings are per MM structure still. You can only unmap what you've mapped.

Fork semantics are irrelevant, since there's no fork.

A global list of VMA's is maintained to keep track of the bits of memory
currently mapped on the system.

The new binfmt makes use of (4) to implement shared libraries.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-nommu-2610rc1bk10.diff
 fs/proc/base.c       |   30 ++-
 fs/proc/task_nommu.c |   35 +--
 include/linux/mm.h   |   29 +++
 mm/nommu.c           |  483 ++++++++++++++++++++++++++++++++++-----------------
 mm/tiny-shmem.c      |    2 
 5 files changed, 397 insertions(+), 182 deletions(-)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/base.c linux-2.6.10-rc1-bk10-frv/fs/proc/base.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/base.c	2004-10-27 17:32:31.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/fs/proc/base.c	2004-11-01 11:47:04.870656963 +0000
@@ -220,6 +220,9 @@
 
 static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
+#ifndef CONFIG_MMU
+	struct mm_tblock_struct *tblock;
+#endif
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
 	struct task_struct *task = proc_task(inode);
@@ -228,17 +231,32 @@
 	if (!mm)
 		goto out;
 	down_read(&mm->mmap_sem);
+
+#ifdef CONFIG_MMU
 	vma = mm->mmap;
 	while (vma) {
-		if ((vma->vm_flags & VM_EXECUTABLE) && 
-		    vma->vm_file) {
-			*mnt = mntget(vma->vm_file->f_vfsmnt);
-			*dentry = dget(vma->vm_file->f_dentry);
-			result = 0;
+		if ((vma->vm_flags & VM_EXECUTABLE) && vma->vm_file)
 			break;
-		}
 		vma = vma->vm_next;
 	}
+#else
+	tblock = mm->context.tblock;
+	vma = NULL;
+	while (tblock) {
+		if ((tblock->vma->vm_flags & VM_EXECUTABLE) && tblock->vma->vm_file) {
+			vma = tblock->vma;
+			break;
+		}
+		tblock = tblock->next;
+	}
+#endif
+
+	if (vma) {
+		*mnt = mntget(vma->vm_file->f_vfsmnt);
+		*dentry = dget(vma->vm_file->f_dentry);
+		result = 0;
+	}
+
 	up_read(&mm->mmap_sem);
 	mmput(mm);
 out:
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/task_nommu.c linux-2.6.10-rc1-bk10-frv/fs/proc/task_nommu.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/task_nommu.c	2004-10-19 10:42:09.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/fs/proc/task_nommu.c	2004-11-01 11:47:04.000000000 +0000
@@ -15,19 +15,19 @@
 	struct mm_tblock_struct *tblock;
         
 	down_read(&mm->mmap_sem);
-	for (tblock = &mm->context.tblock; tblock; tblock = tblock->next) {
-		if (!tblock->rblock)
+	for (tblock = mm->context.tblock; tblock; tblock = tblock->next) {
+		if (!tblock->vma)
 			continue;
 		bytes += kobjsize(tblock);
 		if (atomic_read(&mm->mm_count) > 1 ||
-		    tblock->rblock->refcount > 1) {
-			sbytes += kobjsize(tblock->rblock->kblock);
-			sbytes += kobjsize(tblock->rblock);
+		    atomic_read(&tblock->vma->vm_usage) > 1) {
+			sbytes += kobjsize((void *) tblock->vma->vm_start);
+			sbytes += kobjsize(tblock->vma);
 		} else {
-			bytes += kobjsize(tblock->rblock->kblock);
-			bytes += kobjsize(tblock->rblock);
-			slack += kobjsize(tblock->rblock->kblock) -
-					tblock->rblock->size;
+			bytes += kobjsize((void *) tblock->vma->vm_start);
+			bytes += kobjsize(tblock->vma);
+			slack += kobjsize((void *) tblock->vma->vm_start) -
+				(tblock->vma->vm_end - tblock->vma->vm_start);
 		}
 	}
 
@@ -69,9 +69,9 @@
 	unsigned long vsize = 0;
 
 	down_read(&mm->mmap_sem);
-	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
-		if (tbp->rblock)
-			vsize += kobjsize(tbp->rblock->kblock);
+	for (tbp = mm->context.tblock; tbp; tbp = tbp->next) {
+		if (tbp->vma)
+			vsize += kobjsize((void *) tbp->vma->vm_start);
 	}
 	up_read(&mm->mmap_sem);
 	return vsize;
@@ -84,12 +84,11 @@
 	int size = kobjsize(mm);
 
 	down_read(&mm->mmap_sem);
-	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
-		if (tbp->next)
-			size += kobjsize(tbp->next);
-		if (tbp->rblock) {
-			size += kobjsize(tbp->rblock);
-			size += kobjsize(tbp->rblock->kblock);
+	for (tbp = mm->context.tblock; tbp; tbp = tbp->next) {
+		size += kobjsize(tbp);
+		if (tbp->vma) {
+			size += kobjsize(tbp->vma);
+			size += kobjsize((void *) tbp->vma->vm_start);
 		}
 	}
 
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/mm/nommu.c linux-2.6.10-rc1-bk10-frv/mm/nommu.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/mm/nommu.c	2004-11-01 11:45:34.991139255 +0000
+++ linux-2.6.10-rc1-bk10-frv/mm/nommu.c	2004-11-01 14:31:33.105719990 +0000
@@ -4,6 +4,7 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
+ *  Copyright (c) 2004      David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
  *  Copyright (c) 2000-2001 D Jeff Dionne <jeff@uClinux.org>
  *  Copyright (c) 2002      Greg Ungerer <gerg@snapgear.com>
@@ -12,11 +13,12 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
-#include <linux/smp_lock.h>
+#include <linux/file.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/ptrace.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/syscalls.h>
@@ -38,6 +40,10 @@
 EXPORT_SYMBOL(sysctl_max_map_count);
 EXPORT_SYMBOL(mem_map);
 
+/* list of shareable VMAs */
+LIST_HEAD(shareable_vma_list);
+DECLARE_RWSEM(shareable_vma_sem);
+
 /*
  * Handle all mappings that got truncated by a "truncate()"
  * system call.
@@ -161,7 +167,7 @@
 	/* Don't allow overflow */
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
-	
+
 	memcpy(addr, buf, count);
 	return(count);
 }
@@ -217,7 +223,7 @@
 {
 	struct mm_struct *mm = current->mm;
 
-	if (brk < mm->end_code || brk < mm->start_brk || brk > mm->context.end_brk)
+	if (brk < mm->start_brk || brk > mm->context.end_brk)
 		return mm->brk;
 
 	if (mm->brk == brk)
@@ -276,33 +282,38 @@
 }
 #endif /* DEBUG */
 
-unsigned long do_mmap_pgoff(
-	struct file * file,
-	unsigned long addr,
-	unsigned long len,
-	unsigned long prot,
-	unsigned long flags,
-	unsigned long pgoff)
+unsigned long do_mmap_pgoff(struct file *file,
+			    unsigned long addr,
+			    unsigned long len,
+			    unsigned long prot,
+			    unsigned long flags,
+			    unsigned long pgoff)
 {
-	void * result;
-	struct mm_tblock_struct * tblock;
+	struct mm_tblock_struct *tblock = NULL;
+	struct vm_area_struct *vma = NULL;
 	unsigned int vm_flags;
+	void *result;
+	int ret, chrdev;
 
 	/*
 	 * Get the !CONFIG_MMU specific checks done first
 	 */
-	if ((flags & MAP_SHARED) && (prot & PROT_WRITE) && (file)) {
-		printk("MAP_SHARED not supported (cannot write mappings to disk)\n");
+	chrdev = 0;
+	if (file)
+		chrdev = S_ISCHR(file->f_dentry->d_inode->i_mode);
+
+	if ((flags & MAP_SHARED) && (prot & PROT_WRITE) && file && !chrdev) {
+		printk("MAP_SHARED not completely supported (cannot detect page dirtying)\n");
 		return -EINVAL;
 	}
-	
-	if ((prot & PROT_WRITE) && (flags & MAP_PRIVATE)) {
-		printk("Private writable mappings not supported\n");
+
+	if (flags & MAP_FIXED || addr) {
+//		printk("can't do fixed-address/overlay mmap of RAM\n");
 		return -EINVAL;
 	}
-	
+
 	/*
-	 *	now all the standard checks
+	 * now all the standard checks
 	 */
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
@@ -317,148 +328,283 @@
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;
 
+	/* we're going to need to record the mapping if it works */
+	tblock = kmalloc(sizeof(struct mm_tblock_struct), GFP_KERNEL);
+	if (!tblock)
+		goto error_getting_tblock;
+	memset(tblock, 0, sizeof(*tblock));
+
 	/* Do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_flags(prot,flags) /* | mm->def_flags */ | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	vm_flags = calc_vm_flags(prot,flags) /* | mm->def_flags */
+		| VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+
+	if (!chrdev) {
+		/* share any file segment that's mapped read-only */
+		if (((flags & MAP_PRIVATE) && !(prot & PROT_WRITE) && file) ||
+		    ((flags & MAP_SHARED) && !(prot & PROT_WRITE) && file))
+			vm_flags |= VM_SHARED | VM_MAYSHARE;
+
+		/* refuse to let anyone share files with this process if it's being traced -
+		 * otherwise breakpoints set in it may interfere with another untraced process
+		 */
+		if (!chrdev && current->ptrace & PT_PTRACED)
+			vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
+	}
+	else {
+		/* permit sharing of character devices at any time */
+		vm_flags |= VM_MAYSHARE;
+		if (flags & MAP_SHARED)
+			vm_flags |= VM_SHARED;
+	}
+
+	/* if we want to share, we need to search for VMAs created by another mmap() call that
+	 * overlap with our proposed mapping
+	 * - we can only share with an exact match on regular files
+	 * - shared mappings on character devices are permitted to overlap inexactly as far as we
+	 *   are concerned, but in that case, sharing is handled in the driver rather than here
+	 */
+	down_write(&shareable_vma_sem);
+	if (!chrdev && vm_flags & VM_SHARED) {
+		unsigned long pglen = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		unsigned long vmpglen;
+
+		list_for_each_entry(vma, &shareable_vma_list, vm_shlink) {
+			if (vma->vm_file->f_dentry->d_inode != file->f_dentry->d_inode)
+				continue;
+
+			if (vma->vm_pgoff >= pgoff + pglen)
+				continue;
+
+			vmpglen = (vma->vm_end - vma->vm_start + PAGE_SIZE - 1) >> PAGE_SHIFT;
+			if (pgoff >= vma->vm_pgoff + vmpglen)
+				continue;
+
+			if (vmpglen != pglen || vma->vm_pgoff != pgoff) {
+				if (flags & MAP_SHARED)
+					goto sharing_violation;
+				continue;
+			}
+
+			/* we've found a VMA we can share */
+			atomic_inc(&vma->vm_usage);
+
+			tblock->vma = vma;
+			result = (void *) vma->vm_start;
+			goto shared;
+		}
+	}
+
+	/* Obtain the address to map to. we verify (or select) it and ensure
+	 * that it represents a valid section of the address space.
+	 */
+	if (file && file->f_op && file->f_op->get_unmapped_area)
+		addr = file->f_op->get_unmapped_area(file, addr, len, pgoff, flags);
+
+	if (IS_ERR((void *) addr)) {
+		ret = addr;
+		goto error;
+	}
+
+	/* we're going to need a VMA struct as well */
+	vma = kmalloc(sizeof(struct vm_area_struct), GFP_KERNEL);
+	if (!vma)
+		goto error_getting_vma;
+
+	INIT_LIST_HEAD(&vma->vm_shlink);
+	atomic_set(&vma->vm_usage, 1);
+	if (file)
+		get_file(file);
+	vma->vm_file	= file;
+	vma->vm_flags	= vm_flags;
+	vma->vm_start	= addr;
+	vma->vm_end	= addr + len;
+	vma->vm_pgoff	= pgoff;
+
+	tblock->vma = vma;
 
 	/*
 	 * determine the object being mapped and call the appropriate
-	 * specific mapper. 
+	 * specific mapper.
 	 */
 	if (file) {
-		struct vm_area_struct vma;
-		int error;
-
+		ret = -ENODEV;
 		if (!file->f_op)
-			return -ENODEV;
-
-		vma.vm_start = addr;
-		vma.vm_end = addr + len;
-		vma.vm_flags = vm_flags;
-		vma.vm_pgoff = pgoff;
+			goto error;
 
 #ifdef MAGIC_ROM_PTR
 		/* First, try simpler routine designed to give us a ROM pointer. */
 
 		if (file->f_op->romptr && !(prot & PROT_WRITE)) {
-			error = file->f_op->romptr(file, &vma);
+			ret = file->f_op->romptr(file, vma);
 #ifdef DEBUG
-			printk("romptr mmap returned %d, start 0x%.8x\n", error,
-					vma.vm_start);
+			printk("romptr mmap returned %d (st=%lx)\n",
+			       ret, vma->vm_start);
 #endif
-			if (!error)
-				return vma.vm_start;
-			else if (error != -ENOSYS)
-				return error;
+			result = (void *) vma->vm_start;
+			if (!ret)
+				goto done;
+			else if (ret != -ENOSYS)
+				goto error;
 		} else
 #endif /* MAGIC_ROM_PTR */
 		/* Then try full mmap routine, which might return a RAM pointer,
 		   or do something truly complicated. */
-		   
+
 		if (file->f_op->mmap) {
-			error = file->f_op->mmap(file, &vma);
-				   
+			ret = file->f_op->mmap(file, vma);
+
 #ifdef DEBUG
-			printk("f_op->mmap() returned %d/%lx\n", error, vma.vm_start);
+			printk("f_op->mmap() returned %d (st=%lx)\n",
+			       ret, vma->vm_start);
 #endif
-			if (!error)
-				return vma.vm_start;
-			else if (error != -ENOSYS)
-				return error;
-		} else
-			return -ENODEV; /* No mapping operations defined */
+			result = (void *) vma->vm_start;
+			if (!ret)
+				goto done;
+			else if (ret != -ENOSYS)
+				goto error;
+		} else {
+			ret = -ENODEV; /* No mapping operations defined */
+			goto error;
+		}
 
 		/* An ENOSYS error indicates that mmap isn't possible (as opposed to
 		   tried but failed) so we'll fall through to the copy. */
 	}
 
-	tblock = (struct mm_tblock_struct *)
-                        kmalloc(sizeof(struct mm_tblock_struct), GFP_KERNEL);
-	if (!tblock) {
-		printk("Allocation of tblock for %lu byte allocation from process %d failed\n", len, current->pid);
-		show_free_areas();
-		return -ENOMEM;
-	}
-
-	tblock->rblock = (struct mm_rblock_struct *)
-			kmalloc(sizeof(struct mm_rblock_struct), GFP_KERNEL);
-
-	if (!tblock->rblock) {
-		printk("Allocation of rblock for %lu byte allocation from process %d failed\n", len, current->pid);
-		show_free_areas();
-		kfree(tblock);
-		return -ENOMEM;
-	}
-
+	/* allocate some memory to hold the mapping */
+	ret = -ENOMEM;
 	result = kmalloc(len, GFP_KERNEL);
 	if (!result) {
-		printk("Allocation of length %lu from process %d failed\n", len,
-				current->pid);
+		printk("Allocation of length %lu from process %d failed\n",
+		       len, current->pid);
 		show_free_areas();
-		kfree(tblock->rblock);
-		kfree(tblock);
-		return -ENOMEM;
+		goto error;
 	}
 
-	tblock->rblock->refcount = 1;
-	tblock->rblock->kblock = result;
-	tblock->rblock->size = len;
-	
-	realalloc += kobjsize(result);
-	askedalloc += len;
+	vma->vm_start = (unsigned long) result;
+	vma->vm_end = vma->vm_start + len;
 
-#ifdef WARN_ON_SLACK	
-	if ((len+WARN_ON_SLACK) <= kobjsize(result))
-		printk("Allocation of %lu bytes from process %d has %lu bytes of slack\n", len, current->pid, kobjsize(result)-len);
+#ifdef WARN_ON_SLACK
+	if (len + WARN_ON_SLACK <= kobjsize(result))
+		printk("Allocation of %lu bytes from process %d has %lu bytes of slack\n",
+		       len, current->pid, kobjsize(result) - len);
 #endif
-	
+
 	if (file) {
-		int error;
 		mm_segment_t old_fs = get_fs();
+		loff_t fpos;
+
+		fpos = pgoff;
+		fpos <<= PAGE_SHIFT;
+
 		set_fs(KERNEL_DS);
-		error = file->f_op->read(file, (char *) result, len, &file->f_pos);
+		ret = file->f_op->read(file, (char *) result, len, &fpos);
 		set_fs(old_fs);
-		if (error < 0) {
-			kfree(result);
-			kfree(tblock->rblock);
-			kfree(tblock);
-			return error;
-		}
-		if (error < len)
-			memset(result+error, '\0', len-error);
+
+		if (ret < 0)
+			goto error2;
+		if (ret < len)
+			memset(result + ret, 0, len - ret);
 	} else {
-		memset(result, '\0', len);
+		memset(result, 0, len);
 	}
 
-	realalloc += kobjsize(tblock);
-	askedalloc += sizeof(struct mm_tblock_struct);
+	if (prot & PROT_EXEC)
+		flush_icache_range((unsigned long) result, (unsigned long) result + len);
 
-	realalloc += kobjsize(tblock->rblock);
-	askedalloc += sizeof(struct mm_rblock_struct);
+ done:
+	realalloc += kobjsize(result);
+	askedalloc += len;
+
+	realalloc += kobjsize(vma);
+	askedalloc += sizeof(*vma);
 
-	tblock->next = current->mm->context.tblock.next;
-	current->mm->context.tblock.next = tblock;
 	current->mm->total_vm += len >> PAGE_SHIFT;
 
+	if (vm_flags & VM_SHARED)
+		list_add(&vma->vm_shlink, &shareable_vma_list);
+
+ shared:
+	realalloc += kobjsize(tblock);
+	askedalloc += sizeof(*tblock);
+
+	tblock->next = current->mm->context.tblock;
+	current->mm->context.tblock = tblock;
+
+	up_write(&shareable_vma_sem);
+
 #ifdef DEBUG
 	printk("do_mmap:\n");
 	show_process_blocks();
-#endif	  
+#endif
+
+	return (unsigned long) result;
+
+ error2:
+	kfree(result);
+ error:
+	up_write(&shareable_vma_sem);
+	kfree(tblock);
+	if (vma) {
+		fput(vma->vm_file);
+		kfree(vma);
+	}
+	return ret;
+
+ sharing_violation:
+	up_write(&shareable_vma_sem);
+	printk("Attempt to share mismatched mappings\n");
+	kfree(tblock);
+	return -EINVAL;
 
-	return (unsigned long)result;
+ error_getting_vma:
+	up_write(&shareable_vma_sem);
+	kfree(tblock);
+	printk("Allocation of tblock for %lu byte allocation from process %d failed\n",
+	       len, current->pid);
+	show_free_areas();
+	return -ENOMEM;
+
+ error_getting_tblock:
+	printk("Allocation of tblock for %lu byte allocation from process %d failed\n",
+	       len, current->pid);
+	show_free_areas();
+	return -ENOMEM;
+}
+
+static void put_vma(struct vm_area_struct *vma)
+{
+	if (vma) {
+		down_write(&shareable_vma_sem);
+		if (atomic_dec_and_test(&vma->vm_usage)) {
+			list_del_init(&vma->vm_shlink);
+
+			if (!(vma->vm_flags & VM_IO) && vma->vm_start) {
+				realalloc -= kobjsize((void *) vma->vm_start);
+				askedalloc -= vma->vm_end - vma->vm_start;
+				if (vma->vm_file)
+					fput(vma->vm_file);
+				kfree((void *) vma->vm_start);
+			}
+
+			realalloc -= kobjsize(vma);
+			askedalloc -= sizeof(*vma);
+			kfree(vma);
+		}
+		up_write(&shareable_vma_sem);
+	}
 }
 
-int do_munmap(struct mm_struct * mm, unsigned long addr, size_t len)
+int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
 {
-	struct mm_tblock_struct * tblock, *tmp;
+	struct mm_tblock_struct *tblock, **parent;
 
 #ifdef MAGIC_ROM_PTR
-	/*
-	 * For efficiency's sake, if the pointer is obviously in ROM,
-	 * don't bother walking the lists to free it.
-	 */
+	/* For efficiency's sake, if the pointer is obviously in ROM,
+	   don't bother walking the lists to free it */
 	if (is_in_rom(addr))
 		return 0;
 #endif
@@ -467,38 +613,28 @@
 	printk("do_munmap:\n");
 #endif
 
-	tmp = &mm->context.tblock; /* dummy head */
-	while ((tblock=tmp->next) && tblock->rblock &&
-			tblock->rblock->kblock != (void*)addr) 
-		tmp = tblock;
-		
+	for (parent = &mm->context.tblock; *parent; parent = &(*parent)->next)
+		if ((*parent)->vma->vm_start == addr)
+			break;
+	tblock = *parent;
+
 	if (!tblock) {
 		printk("munmap of non-mmaped memory by process %d (%s): %p\n",
-				current->pid, current->comm, (void*)addr);
+		       current->pid, current->comm, (void *) addr);
 		return -EINVAL;
 	}
-	if (tblock->rblock) {
-		if (!--tblock->rblock->refcount) {
-			if (tblock->rblock->kblock) {
-				realalloc -= kobjsize(tblock->rblock->kblock);
-				askedalloc -= tblock->rblock->size;
-				kfree(tblock->rblock->kblock);
-			}
-			
-			realalloc -= kobjsize(tblock->rblock);
-			askedalloc -= sizeof(struct mm_rblock_struct);
-			kfree(tblock->rblock);
-		}
-	}
-	tmp->next = tblock->next;
+
+	put_vma(tblock->vma);
+
+	*parent = tblock->next;
 	realalloc -= kobjsize(tblock);
-	askedalloc -= sizeof(struct mm_tblock_struct);
+	askedalloc -= sizeof(*tblock);
 	kfree(tblock);
 	mm->total_vm -= len >> PAGE_SHIFT;
 
 #ifdef DEBUG
 	show_process_blocks();
-#endif	  
+#endif
 
 	return 0;
 }
@@ -507,38 +643,27 @@
 void exit_mmap(struct mm_struct * mm)
 {
 	struct mm_tblock_struct *tmp;
-	mm->total_vm = 0;
-
-	if (!mm)
-		return;
 
+	if (mm) {
 #ifdef DEBUG
-	printk("Exit_mmap:\n");
+		printk("Exit_mmap:\n");
 #endif
 
-	while((tmp = mm->context.tblock.next)) {
-		if (tmp->rblock) {
-			if (!--tmp->rblock->refcount) {
-				if (tmp->rblock->kblock) {
-					realalloc -= kobjsize(tmp->rblock->kblock);
-					askedalloc -= tmp->rblock->size;
-					kfree(tmp->rblock->kblock);
-				}
-				realalloc -= kobjsize(tmp->rblock);
-				askedalloc -= sizeof(struct mm_rblock_struct);
-				kfree(tmp->rblock);
-			}
-			tmp->rblock = 0;
+		mm->total_vm = 0;
+
+		while ((tmp = mm->context.tblock)) {
+			mm->context.tblock = tmp->next;
+			put_vma(tmp->vma);
+
+			realalloc -= kobjsize(tmp);
+			askedalloc -= sizeof(*tmp);
+			kfree(tmp);
 		}
-		mm->context.tblock.next = tmp->next;
-		realalloc -= kobjsize(tmp);
-		askedalloc -= sizeof(struct mm_tblock_struct);
-		kfree(tmp);
-	}
 
 #ifdef DEBUG
-	show_process_blocks();
-#endif	  
+		show_process_blocks();
+#endif
+	}
 }
 
 asmlinkage long sys_munmap(unsigned long addr, size_t len)
@@ -557,6 +682,54 @@
 	return -ENOMEM;
 }
 
+/*
+ * Expand (or shrink) an existing mapping, potentially moving it at the
+ * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
+ *
+ * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
+ * This option implies MREMAP_MAYMOVE.
+ *
+ * on uClinux, we only permit changing a mapping's size, and only as long as it stays within the
+ * hole allocated by the kmalloc() call in do_mmap_pgoff() and the block is not shareable
+ */
+unsigned long do_mremap(unsigned long addr,
+			unsigned long old_len, unsigned long new_len,
+			unsigned long flags, unsigned long new_addr)
+{
+	struct mm_tblock_struct *tblock = NULL;
+
+	/* insanity checks first */
+	if (new_len == 0)
+		return (unsigned long) -EINVAL;
+
+	if (flags & MREMAP_FIXED && new_addr != addr)
+		return (unsigned long) -EINVAL;
+
+	for (tblock = current->mm->context.tblock; tblock; tblock = tblock->next)
+		if (tblock->vma->vm_start == addr)
+			goto found;
+
+	return (unsigned long) -EINVAL;
+
+ found:
+	if (tblock->vma->vm_end != tblock->vma->vm_start + old_len)
+		return (unsigned long) -EFAULT;
+
+	if (tblock->vma->vm_flags & VM_MAYSHARE)
+		return (unsigned long) -EPERM;
+
+	if (new_len > kobjsize((void *) addr))
+		return (unsigned long) -ENOMEM;
+
+	/* all checks complete - do it */
+	tblock->vma->vm_end = tblock->vma->vm_start + new_len;
+
+	askedalloc -= old_len;
+	askedalloc += new_len;
+
+	return tblock->vma->vm_start;
+}
+
 struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
 {
 	return NULL;
@@ -578,12 +751,6 @@
 	return -EPERM;
 }
 
-unsigned long get_unmapped_area(struct file *file, unsigned long addr,
-	unsigned long len, unsigned long pgoff, unsigned long flags)
-{
-	return -ENOMEM;
-}
-
 void swap_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/mm/tiny-shmem.c linux-2.6.10-rc1-bk10-frv/mm/tiny-shmem.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/mm/tiny-shmem.c	2004-10-27 17:32:38.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/mm/tiny-shmem.c	2004-11-01 14:24:49.419177784 +0000
@@ -112,7 +112,9 @@
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	vma->vm_file = file;
+#ifdef CONFIG_MMU
 	vma->vm_ops = &generic_file_vm_ops;
+#endif
 	return 0;
 }
 
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/mm.h linux-2.6.10-rc1-bk10-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/mm.h	2004-11-01 11:45:33.371274107 +0000
+++ linux-2.6.10-rc1-bk10-frv/include/linux/mm.h	2004-11-01 14:16:26.408497251 +0000
@@ -112,6 +112,31 @@
 #endif
 };
 
+#else
+
+struct vm_area_struct {
+	struct list_head	vm_shlink;	/* system shared object list */
+	atomic_t		vm_usage;	/* count of refs */
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+	pgprot_t		vm_page_prot;	/* access permissions of this VMA */
+	unsigned long		vm_flags;
+	unsigned long		vm_pgoff;
+	struct file		*vm_file;	/* file or device mapped */
+};
+
+struct mm_tblock_struct {
+	struct mm_tblock_struct	*next;
+	struct vm_area_struct	*vma;
+};
+
+extern struct list_head shareable_vma_list;
+extern struct rw_semaphore shareable_vma_sem;
+
+extern unsigned int kobjsize(const void *objp);
+
+#endif
+
 /*
  * vm_flags..
  */
@@ -603,6 +628,10 @@
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
 
+extern unsigned long do_mremap(unsigned long addr,
+			       unsigned long old_len, unsigned long new_len,
+			       unsigned long flags, unsigned long new_addr);
+
 /*
  * Prototype to add a shrinker callback for ageable caches.
  * 
