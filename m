Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbULIPJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbULIPJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbULIPJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:09:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261518AbULIPJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:09:25 -0500
Date: Thu, 9 Dec 2004 15:08:58 GMT
Message-Id: <200412091508.iB9F8wgt027555@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: akpm@osdl.org, davidm@snapgear.com, gerg@snapgear.com, wli@holomorphy.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 3/5] NOMMU: mmap fixes and extensions
In-Reply-To: <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com> 
References: <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch applies some fixes and extensions to the nommu mmap
implementation:

 (1) /proc/maps distinguishes shareable private mappings and real shared
     mappings by marking the former with 's' and the latter with 'S'.

 (2) Remove some #ifdefs from linux/mm.h now that proper VMAs are used.

 (3) Compile in prio_trees again now that proper VMAs are used.

 (4) Keep track of VMAs in the relevant mapping's prio_tree.

 (5) Only set VM_SHARED on MAP_SHARED mappings. Its presence indicates that the
     backing memory is supplied by the underlying file or chardev.

     VM_MAYSHARE indicates that a VMA may be shared if it's a private VMA
     (memory allocated by do_mmap_pgoff() calling kmalloc()).

 (6) Permit MAP_SHARED + PROT_WRITE on memory-backed files[*] and chardevs if
     the backing fs/chardev is willing to indicate a contiguous area of memory
     when its get_unmapped_area() is called.

     [*] file->f_mapping->backing_dev_info->memory_backed == 1

 (7) Uniquify overlapping VMAs (eg: MAP_SHARED on chardevs) in
     nommu_vma_tree. Identical entries break the assumptions on which rbtrees
     work. Since we don't need to share VMAs in this case, we uniquify such
     VMAs by using the pointer to the VMA. They're only kept in the tree for
     /proc/maps visibility.

With this patch it should be possible to map contiguous flash files directly
out of ROM simply by providing get_unmapped_area() for a read-only/shared
mapping.

Signed-Off-By: dhowells@redhat.com
---
diffstat nommu-mmap-2610rc2mm3-3.diff
 fs/proc/nommu.c    |    2 
 include/linux/mm.h |    4 -
 mm/Makefile        |    4 -
 mm/nommu.c         |  173 ++++++++++++++++++++++++++++++++++++++---------------
 4 files changed, 129 insertions(+), 54 deletions(-)

diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/fs/proc/nommu.c linux-2.6.10-rc2-mm3-shmem/fs/proc/nommu.c
--- linux-2.6.10-rc2-mm3-mmcleanup/fs/proc/nommu.c	2004-11-22 10:54:11.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/fs/proc/nommu.c	2004-12-03 11:53:00.000000000 +0000
@@ -62,7 +62,7 @@ static int nommu_vma_list_show(struct se
 		   flags & VM_READ ? 'r' : '-',
 		   flags & VM_WRITE ? 'w' : '-',
 		   flags & VM_EXEC ? 'x' : '-',
-		   flags & VM_MAYSHARE ? 's' : 'p',
+		   flags & VM_MAYSHARE ? flags & VM_SHARED ? 'S' : 's' : 'p',
 		   vma->vm_pgoff << PAGE_SHIFT,
 		   MAJOR(dev), MINOR(dev), ino, &len);
 
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/include/linux/mm.h linux-2.6.10-rc2-mm3-shmem/include/linux/mm.h
--- linux-2.6.10-rc2-mm3-mmcleanup/include/linux/mm.h	2004-11-22 10:54:16.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/include/linux/mm.h	2004-12-08 16:52:24.000000000 +0000
@@ -724,14 +772,12 @@ struct vm_area_struct *vma_prio_tree_nex
 	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
 		(vma = vma_prio_tree_next(vma, iter)); )
 
-#ifdef CONFIG_MMU
 static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
 					struct list_head *list)
 {
 	vma->shared.vm_set.parent = NULL;
 	list_add_tail(&vma->shared.vm_set.list, list);
 }
-#endif
 
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
@@ -846,7 +892,6 @@ static inline void __vm_stat_account(str
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef CONFIG_MMU
 static inline void vm_stat_account(struct vm_area_struct *vma)
 {
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
@@ -858,7 +903,6 @@ static inline void vm_stat_unaccount(str
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
 							-vma_pages(vma));
 }
-#endif
 
 /* update per process rss and vm hiwater data */
 extern void update_mem_hiwater(void);
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/mm/Makefile linux-2.6.10-rc2-mm3-shmem/mm/Makefile
--- linux-2.6.10-rc2-mm3-mmcleanup/mm/Makefile	2004-11-22 10:54:18.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/mm/Makefile	2004-11-26 16:15:04.000000000 +0000
@@ -5,12 +5,12 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o prio_tree.o
+			   vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
-			   $(mmu-y)
+			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/mm/nommu.c linux-2.6.10-rc2-mm3-shmem/mm/nommu.c
--- linux-2.6.10-rc2-mm3-mmcleanup/mm/nommu.c	2004-11-22 10:54:18.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/mm/nommu.c	2004-12-07 18:44:17.000000000 +0000
@@ -48,10 +48,6 @@ DECLARE_RWSEM(nommu_vma_sem);
 struct vm_operations_struct generic_file_vm_ops = {
 };
 
-void __init prio_tree_init(void)
-{
-}
-
 /*
  * Handle all mappings that got truncated by a "truncate()"
  * system call.
@@ -315,25 +311,69 @@ static inline struct vm_area_struct *fin
 static void add_nommu_vma(struct vm_area_struct *vma)
 {
 	struct vm_area_struct *pvma;
+	struct address_space *mapping;
 	struct rb_node **p = &nommu_vma_tree.rb_node;
 	struct rb_node *parent = NULL;
 
+	/* add the VMA to the mapping */
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+
+		flush_dcache_mmap_lock(mapping);
+		vma_prio_tree_insert(vma, &mapping->i_mmap);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* add the VMA to the master list */
 	while (*p) {
 		parent = *p;
 		pvma = rb_entry(parent, struct vm_area_struct, vm_rb);
 
-		if (vma->vm_start < pvma->vm_start)
+		if (vma->vm_start < pvma->vm_start) {
 			p = &(*p)->rb_left;
-		else if (vma->vm_start > pvma->vm_start)
+		}
+		else if (vma->vm_start > pvma->vm_start) {
 			p = &(*p)->rb_right;
-		else
-			BUG(); /* shouldn't happen by this point */
+		}
+		else {
+			/* mappings are at the same address - this can only
+			 * happen for shared-mem chardevs and shared file
+			 * mappings backed by ramfs/tmpfs */
+			BUG_ON(!(pvma->vm_flags & VM_SHARED));
+
+			if (vma < pvma)
+				p = &(*p)->rb_left;
+			else if (vma > pvma)
+				p = &(*p)->rb_right;
+			else
+				BUG();
+		}
 	}
 
 	rb_link_node(&vma->vm_rb, parent, p);
 	rb_insert_color(&vma->vm_rb, &nommu_vma_tree);
 }
 
+static void delete_nommu_vma(struct vm_area_struct *vma)
+{
+	struct address_space *mapping;
+
+	/* remove the VMA from the mapping */
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+
+		flush_dcache_mmap_lock(mapping);
+		vma_prio_tree_remove(vma, &mapping->i_mmap);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* remove from the master list */
+	rb_erase(&vma->vm_rb, &nommu_vma_tree);
+}
+
+/*
+ * handle mapping creation for uClinux
+ */
 unsigned long do_mmap_pgoff(struct file *file,
 			    unsigned long addr,
 			    unsigned long len,
@@ -343,19 +383,27 @@ unsigned long do_mmap_pgoff(struct file 
 {
 	struct vm_list_struct *vml = NULL;
 	struct vm_area_struct *vma = NULL;
+	struct address_space *mapping = NULL;
 	struct rb_node *rb;
 	unsigned int vm_flags;
 	void *result;
-	int ret, chrdev;
+	int ret, chrdev, memback;
 
 	/*
 	 * Get the !CONFIG_MMU specific checks done first
 	 */
+	memback = 0;
 	chrdev = 0;
-	if (file)
+	if (file) {
 		chrdev = S_ISCHR(file->f_dentry->d_inode->i_mode);
+		mapping = file->f_mapping;
+		if (!mapping)
+			mapping = file->f_dentry->d_inode->i_mapping;
+		if (mapping && mapping->backing_dev_info)
+			memback = mapping->backing_dev_info->memory_backed;
+	}
 
-	if ((flags & MAP_SHARED) && (prot & PROT_WRITE) && file && !chrdev) {
+	if ((flags & MAP_SHARED) && (prot & PROT_WRITE) && file && !chrdev && !memback) {
 		printk("MAP_SHARED not completely supported (cannot detect page dirtying)\n");
 		return -EINVAL;
 	}
@@ -387,49 +435,53 @@ unsigned long do_mmap_pgoff(struct file 
 		goto error_getting_vml;
 	memset(vml, 0, sizeof(*vml));
 
-	/* Do simple checking here so the lower-level routines won't have
+	/* do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
 	vm_flags = calc_vm_flags(prot,flags) /* | mm->def_flags */
 		| VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
-	if (!chrdev) {
+	if (!chrdev && !memback) {
 		/* share any file segment that's mapped read-only */
 		if (((flags & MAP_PRIVATE) && !(prot & PROT_WRITE) && file) ||
 		    ((flags & MAP_SHARED) && !(prot & PROT_WRITE) && file))
-			vm_flags |= VM_SHARED | VM_MAYSHARE;
+			vm_flags |= VM_MAYSHARE;
 
 		/* refuse to let anyone share files with this process if it's being traced -
 		 * otherwise breakpoints set in it may interfere with another untraced process
 		 */
-		if (!chrdev && current->ptrace & PT_PTRACED)
+		if (current->ptrace & PT_PTRACED)
 			vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
 	}
 	else {
-		/* permit sharing of character devices at any time */
+		/* permit sharing of character devices and ramfs files at any time */
 		vm_flags |= VM_MAYSHARE;
 		if (flags & MAP_SHARED)
 			vm_flags |= VM_SHARED;
 	}
 
-	/* if we want to share, we need to search for VMAs created by another mmap() call that
-	 * overlap with our proposed mapping
-	 * - we can only share with an exact match on regular files
-	 * - shared mappings on character devices are permitted to overlap inexactly as far as we
-	 *   are concerned, but in that case, sharing is handled in the driver rather than here
-	 */
 	down_write(&nommu_vma_sem);
-	if (!chrdev && vm_flags & VM_SHARED) {
+
+	/* if we want to share, we need to search for VMAs created by another
+	 * mmap() call that overlap with our proposed mapping
+	 * - we can only share with an exact match on most regular files
+	 * - shared mappings on character devices and memory backed files are
+	 *   permitted to overlap inexactly as far as we are concerned for in
+	 *   these cases, sharing is handled in the driver or filesystem rather
+	 *   than here
+	 */
+	if (vm_flags & VM_MAYSHARE) {
 		unsigned long pglen = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 		unsigned long vmpglen;
 
 		for (rb = rb_first(&nommu_vma_tree); rb; rb = rb_next(rb)) {
 			vma = rb_entry(rb, struct vm_area_struct, vm_rb);
 
-			if (!(vma->vm_flags & VM_SHARED))
+			if (!(vma->vm_flags & VM_MAYSHARE))
 				continue;
 
+			/* search for overlapping mappings on the same file */
 			if (vma->vm_file->f_dentry->d_inode != file->f_dentry->d_inode)
 				continue;
 
@@ -440,8 +492,9 @@ unsigned long do_mmap_pgoff(struct file 
 			if (pgoff >= vma->vm_pgoff + vmpglen)
 				continue;
 
+			/* handle inexact matches between mappings */
 			if (vmpglen != pglen || vma->vm_pgoff != pgoff) {
-				if (flags & MAP_SHARED)
+				if (!chrdev && !memback)
 					goto sharing_violation;
 				continue;
 			}
@@ -455,6 +508,8 @@ unsigned long do_mmap_pgoff(struct file 
 		}
 	}
 
+	vma = NULL;
+
 	/* obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space
 	 * - this is the hook for quasi-memory character devices
@@ -496,7 +551,6 @@ unsigned long do_mmap_pgoff(struct file 
 
 #ifdef MAGIC_ROM_PTR
 		/* First, try simpler routine designed to give us a ROM pointer. */
-
 		if (file->f_op->romptr && !(prot & PROT_WRITE)) {
 			ret = file->f_op->romptr(file, vma);
 #ifdef DEBUG
@@ -510,9 +564,9 @@ unsigned long do_mmap_pgoff(struct file 
 				goto error;
 		} else
 #endif /* MAGIC_ROM_PTR */
-		/* Then try full mmap routine, which might return a RAM pointer,
-		   or do something truly complicated. */
-
+		/* Then try full mmap routine, which might return a RAM
+		 * pointer, or do something truly complicated
+		 */
 		if (file->f_op->mmap) {
 			ret = file->f_op->mmap(file, vma);
 
@@ -530,8 +584,9 @@ unsigned long do_mmap_pgoff(struct file 
 			goto error;
 		}
 
-		/* An ENOSYS error indicates that mmap isn't possible (as opposed to
-		   tried but failed) so we'll fall through to the copy. */
+		/* An ENOSYS error indicates that mmap isn't possible (as
+		 * opposed to tried but failed) so we'll fall through to the
+		 * copy. */
 	}
 
 	/* allocate some memory to hold the mapping */
@@ -576,8 +631,10 @@ unsigned long do_mmap_pgoff(struct file 
 		flush_icache_range((unsigned long) result, (unsigned long) result + len);
 
  done:
-	realalloc += kobjsize(result);
-	askedalloc += len;
+	if (!(vma->vm_flags & VM_SHARED)) {
+		realalloc += kobjsize(result);
+		askedalloc += len;
+	}
 
 	realalloc += kobjsize(vma);
 	askedalloc += sizeof(*vma);
@@ -639,21 +696,24 @@ static void put_vma(struct vm_area_struc
 		down_write(&nommu_vma_sem);
 
 		if (atomic_dec_and_test(&vma->vm_usage)) {
-			rb_erase(&vma->vm_rb, &nommu_vma_tree);
+			delete_nommu_vma(vma);
 
 			if (vma->vm_ops && vma->vm_ops->close)
 				vma->vm_ops->close(vma);
 
-			if (!(vma->vm_flags & VM_IO) && vma->vm_start) {
+			/* IO memory and memory shared directly out of the pagecache from
+			 * ramfs/tmpfs mustn't be released here */
+			if (!(vma->vm_flags & (VM_IO | VM_SHARED)) && vma->vm_start) {
 				realalloc -= kobjsize((void *) vma->vm_start);
 				askedalloc -= vma->vm_end - vma->vm_start;
-				if (vma->vm_file)
-					fput(vma->vm_file);
 				kfree((void *) vma->vm_start);
 			}
 
 			realalloc -= kobjsize(vma);
 			askedalloc -= sizeof(*vma);
+
+			if (vma->vm_file)
+				fput(vma->vm_file);
 			kfree(vma);
 		}
 
@@ -664,6 +724,7 @@ static void put_vma(struct vm_area_struc
 int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
 {
 	struct vm_list_struct *vml, **parent;
+	unsigned long end = addr + len;
 
 #ifdef MAGIC_ROM_PTR
 	/* For efficiency's sake, if the pointer is obviously in ROM,
@@ -677,15 +738,16 @@ int do_munmap(struct mm_struct *mm, unsi
 #endif
 
 	for (parent = &mm->context.vmlist; *parent; parent = &(*parent)->next)
-		if ((*parent)->vma->vm_start == addr)
-			break;
-	vml = *parent;
+		if ((*parent)->vma->vm_start == addr &&
+		    (*parent)->vma->vm_end == end)
+			goto found;
 
-	if (!vml) {
-		printk("munmap of non-mmaped memory by process %d (%s): %p\n",
-		       current->pid, current->comm, (void *) addr);
-		return -EINVAL;
-	}
+	printk("munmap of non-mmaped memory by process %d (%s): %p\n",
+	       current->pid, current->comm, (void *) addr);
+	return -EINVAL;
+
+ found:
+	vml = *parent;
 
 	put_vma(vml->vma);
 
@@ -793,12 +855,23 @@ unsigned long do_mremap(unsigned long ad
 	return vml->vma->vm_start;
 }
 
-struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
+/*
+ * Look up the first VMA which satisfies  addr < vm_end,  NULL if none
+ */
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
+	struct vm_list_struct *vml;
+
+	for (vml = mm->context.vmlist; vml; vml = vml->next)
+		if (addr >= vml->vma->vm_start && addr < vml->vma->vm_end)
+			return vml->vma;
+
 	return NULL;
 }
 
-struct page * follow_page(struct mm_struct *mm, unsigned long addr, int write)
+EXPORT_SYMBOL(find_vma);
+
+struct page *follow_page(struct mm_struct *mm, unsigned long addr, int write)
 {
 	return NULL;
 }
@@ -845,3 +918,9 @@ void unmap_mapping_range(struct address_
 			 int even_cows)
 {
 }
+
+struct page * filemap_nopage(struct vm_area_struct * area, unsigned long address, int *type)
+{
+	BUG();
+	return NULL;
+}
