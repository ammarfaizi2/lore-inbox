Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUKHPla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUKHPla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUKHPl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:41:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28099 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261875AbUKHOfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:32 -0500
Date: Mon, 8 Nov 2004 14:34:20 GMT
Message-Id: <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 17/20] FRV: Better mmap support in uClinux
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com>, <20040401020550.GG3150@beast>
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
diffstat nommu-2610rc1mm3.diff
 include/linux/mm.h |   30 +++
 mm/nommu.c         |  498 ++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 369 insertions(+), 159 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/mm.h linux-2.6.10-rc1-mm3-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/mm.h	2004-11-05 13:15:50.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/include/linux/mm.h	2004-11-05 17:44:09.120160519 +0000
@@ -58,6 +62,7 @@ extern int sysctl_legacy_va_layout;
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
  */
+#ifdef CONFIG_MMU
 struct vm_area_struct {
 	struct mm_struct * vm_mm;	/* The address space we belong to. */
 	unsigned long vm_start;		/* Our start address within vm_mm. */
@@ -112,6 +117,31 @@ struct vm_area_struct {
 #endif
 };
 
+#else
+
+struct vm_area_struct {
+	struct list_head	vm_link;	/* system object list */
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
+extern struct list_head nommu_vma_list;
+extern struct rw_semaphore nommu_vma_sem;
+
+extern unsigned int kobjsize(const void *objp);
+
+#endif
+
 /*
  * vm_flags..
  */
@@ -612,6 +642,10 @@ int FASTCALL(set_page_dirty(struct page 
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
 
+extern unsigned long do_mremap(unsigned long addr,
+			       unsigned long old_len, unsigned long new_len,
+			       unsigned long flags, unsigned long new_addr);
+
 /*
  * Prototype to add a shrinker callback for ageable caches.
  * 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/nommu.c linux-2.6.10-rc1-mm3-frv/mm/nommu.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/nommu.c	2004-11-05 13:15:52.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/mm/nommu.c	2004-11-05 14:13:04.000000000 +0000
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
@@ -38,6 +40,14 @@ int sysctl_max_map_count = DEFAULT_MAX_M
 EXPORT_SYMBOL(sysctl_max_map_count);
 EXPORT_SYMBOL(mem_map);
 
+/* list of shareable VMAs */
+LIST_HEAD(nommu_vma_list);
+DECLARE_RWSEM(nommu_vma_sem);
+
+void __init prio_tree_init(void)
+{
+}
+
 /*
  * Handle all mappings that got truncated by a "truncate()"
  * system call.
@@ -161,7 +171,7 @@ long vwrite(char *buf, char *addr, unsig
 	/* Don't allow overflow */
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
-	
+
 	memcpy(addr, buf, count);
 	return(count);
 }
@@ -217,7 +227,7 @@ asmlinkage unsigned long sys_brk(unsigne
 {
 	struct mm_struct *mm = current->mm;
 
-	if (brk < mm->end_code || brk < mm->start_brk || brk > mm->context.end_brk)
+	if (brk < mm->start_brk || brk > mm->context.end_brk)
 		return mm->brk;
 
 	if (mm->brk == brk)
@@ -276,33 +286,39 @@ static void show_process_blocks(void)
 }
 #endif /* DEBUG */
 
-unsigned long do_mmap_pgoff(
-	struct file * file,
-	unsigned long addr,
-	unsigned long len,
-	unsigned long prot,
-	unsigned long flags,
-	unsigned long pgoff)
-{
-	void * result;
-	struct mm_tblock_struct * tblock;
+unsigned long do_mmap_pgoff(struct file *file,
+			    unsigned long addr,
+			    unsigned long len,
+			    unsigned long prot,
+			    unsigned long flags,
+			    unsigned long pgoff)
+{
+	struct mm_tblock_struct *tblock = NULL;
+	struct vm_area_struct *vma = NULL, *pvma;
+	struct list_head *p;
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
+		/* printk("can't do fixed-address/overlay mmap of RAM\n"); */
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
@@ -317,148 +333,291 @@ unsigned long do_mmap_pgoff(
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
+	down_write(&nommu_vma_sem);
+	if (!chrdev && vm_flags & VM_SHARED) {
+		unsigned long pglen = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		unsigned long vmpglen;
+
+		list_for_each_entry(vma, &nommu_vma_list, vm_link) {
+			if (!(vma->vm_flags & VM_SHARED))
+				continue;
+
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
+	/* obtain the address to map to. we verify (or select) it and ensure
+	 * that it represents a valid section of the address space
+	 * - this is the hook for quasi-memory character devices
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
+	INIT_LIST_HEAD(&vma->vm_link);
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
+
+ done:
+	realalloc += kobjsize(result);
+	askedalloc += len;
 
-	realalloc += kobjsize(tblock->rblock);
-	askedalloc += sizeof(struct mm_rblock_struct);
+	realalloc += kobjsize(vma);
+	askedalloc += sizeof(*vma);
 
-	tblock->next = current->mm->context.tblock.next;
-	current->mm->context.tblock.next = tblock;
 	current->mm->total_vm += len >> PAGE_SHIFT;
 
+	list_for_each(p, &nommu_vma_list) {
+		pvma = list_entry(p, struct vm_area_struct, vm_link);
+		if (pvma->vm_start > vma->vm_start)
+			break;
+	}
+	list_add_tail(&vma->vm_link, p);
+
+ shared:
+	realalloc += kobjsize(tblock);
+	askedalloc += sizeof(*tblock);
+
+	tblock->next = current->mm->context.tblock;
+	current->mm->context.tblock = tblock;
+
+	up_write(&nommu_vma_sem);
+
 #ifdef DEBUG
 	printk("do_mmap:\n");
 	show_process_blocks();
-#endif	  
+#endif
+
+	return (unsigned long) result;
 
-	return (unsigned long)result;
+ error2:
+	kfree(result);
+ error:
+	up_write(&nommu_vma_sem);
+	kfree(tblock);
+	if (vma) {
+		fput(vma->vm_file);
+		kfree(vma);
+	}
+	return ret;
+
+ sharing_violation:
+	up_write(&nommu_vma_sem);
+	printk("Attempt to share mismatched mappings\n");
+	kfree(tblock);
+	return -EINVAL;
+
+ error_getting_vma:
+	up_write(&nommu_vma_sem);
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
 }
 
-int do_munmap(struct mm_struct * mm, unsigned long addr, size_t len)
+static void put_vma(struct vm_area_struct *vma)
 {
-	struct mm_tblock_struct * tblock, *tmp;
+	if (vma) {
+		down_write(&nommu_vma_sem);
+		if (atomic_dec_and_test(&vma->vm_usage)) {
+			list_del_init(&vma->vm_link);
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
+		up_write(&nommu_vma_sem);
+	}
+}
+
+int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
+{
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
@@ -467,38 +626,28 @@ int do_munmap(struct mm_struct * mm, uns
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
@@ -507,38 +656,27 @@ int do_munmap(struct mm_struct * mm, uns
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
@@ -557,6 +695,54 @@ unsigned long do_brk(unsigned long addr,
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
@@ -578,12 +764,6 @@ int remap_pfn_range(struct vm_area_struc
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
