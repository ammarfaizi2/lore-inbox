Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVCBV5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVCBV5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVCBV5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:57:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262507AbVCBVlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:41:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050302090734.5a9895a3.akpm@osdl.org> 
References: <20050302090734.5a9895a3.akpm@osdl.org>  <9420.1109778627@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] BDI: Improve nommu mmap support
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 02 Mar 2005 21:41:06 +0000
Message-ID: <31892.1109799666@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes use of patch #1 to improve nommu mmap support;
particularly in terms on supporting private mappings. It does this by
examining the device capability mask now in the backing_dev_info structure.

Private mappings will now be backed by the underlying device directly if
possible, where "possible" is constrained by the protection mask parameter and
the device capabilities mask.

I've also split the do_mmap_pgoff() function contents into a number of
auxilliary functions to make it easier to understand.

The documentation is also updated; including the addition of a warning about
permitting direct mapping of flash chips and the problems of XIP vs write.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 memback-nommu-2611rc4.diff 
 Documentation/nommu-mmap.txt |   81 +++++-
 include/linux/mm.h           |    1 
 mm/nommu.c                   |  519 ++++++++++++++++++++++++++-----------------
 3 files changed, 384 insertions(+), 217 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc4/include/linux/mm.h linux-2.6.11-rc4-memback/include/linux/mm.h
--- /warthog/kernels/linux-2.6.11-rc4/include/linux/mm.h	2005-02-14 12:19:01.000000000 +0000
+++ linux-2.6.11-rc4-memback/include/linux/mm.h	2005-03-02 20:29:50.798818320 +0000
@@ -164,6 +164,7 @@ extern unsigned int kobjsize(const void 
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+#define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/nommu.c linux-2.6.11-rc4-memback/mm/nommu.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/nommu.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/nommu.c	2005-03-02 20:50:04.063807220 +0000
@@ -256,29 +256,6 @@ asmlinkage unsigned long sys_brk(unsigne
 	return mm->brk = brk;
 }
 
-/*
- * Combine the mmap "prot" and "flags" argument into one "vm_flags" used
- * internally. Essentially, translate the "PROT_xxx" and "MAP_xxx" bits
- * into "VM_xxx".
- */
-static inline unsigned long calc_vm_flags(unsigned long prot, unsigned long flags)
-{
-#define _trans(x,bit1,bit2) \
-((bit1==bit2)?(x&bit1):(x&bit1)?bit2:0)
-
-	unsigned long prot_bits, flag_bits;
-	prot_bits =
-		_trans(prot, PROT_READ, VM_READ) |
-		_trans(prot, PROT_WRITE, VM_WRITE) |
-		_trans(prot, PROT_EXEC, VM_EXEC);
-	flag_bits =
-		_trans(flags, MAP_GROWSDOWN, VM_GROWSDOWN) |
-		_trans(flags, MAP_DENYWRITE, VM_DENYWRITE) |
-		_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE);
-	return prot_bits | flag_bits;
-#undef _trans
-}
-
 #ifdef DEBUG
 static void show_process_blocks(void)
 {
@@ -381,29 +358,32 @@ static void delete_nommu_vma(struct vm_a
 }
 
 /*
- * handle mapping creation for uClinux
+ * determine whether a mapping should be permitted and, if so, what sort of
+ * mapping we're capable of supporting
  */
-unsigned long do_mmap_pgoff(struct file *file,
-			    unsigned long addr,
-			    unsigned long len,
-			    unsigned long prot,
-			    unsigned long flags,
-			    unsigned long pgoff)
+static int validate_mmap_request(struct file *file,
+				 unsigned long addr,
+				 unsigned long len,
+				 unsigned long prot,
+				 unsigned long flags,
+				 unsigned long pgoff,
+				 unsigned long *_capabilities)
 {
-	struct vm_list_struct *vml = NULL;
-	struct vm_area_struct *vma = NULL;
-	struct rb_node *rb;
-	unsigned int vm_flags;
-	void *result;
-	int ret, membacked;
+	unsigned long capabilities;
+	int ret;
 
 	/* do the simple checks first */
 	if (flags & MAP_FIXED || addr) {
-		printk(KERN_DEBUG "%d: Can't do fixed-address/overlay mmap of RAM\n",
+		printk(KERN_DEBUG
+		       "%d: Can't do fixed-address/overlay mmap of RAM\n",
 		       current->pid);
 		return -EINVAL;
 	}
 
+	if ((flags & MAP_TYPE) != MAP_PRIVATE &&
+	    (flags & MAP_TYPE) != MAP_SHARED)
+		return -EINVAL;
+
 	if (PAGE_ALIGN(len) == 0)
 		return addr;
 
@@ -414,35 +394,58 @@ unsigned long do_mmap_pgoff(struct file 
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;
 
-	/* validate file mapping requests */
-	membacked = 0;
 	if (file) {
+		/* validate file mapping requests */
+		struct address_space *mapping;
+
 		/* files must support mmap */
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
 
-		if ((prot & PROT_EXEC) &&
-		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
-			return -EPERM;
-
 		/* work out if what we've got could possibly be shared
 		 * - we support chardevs that provide their own "memory"
 		 * - we support files/blockdevs that are memory backed
 		 */
-		if (S_ISCHR(file->f_dentry->d_inode->i_mode)) {
-			membacked = 1;
-		}
-		else {
-			struct address_space *mapping = file->f_mapping;
-			if (!mapping)
-				mapping = file->f_dentry->d_inode->i_mapping;
-			if (mapping && mapping->backing_dev_info)
-				membacked = mapping->backing_dev_info->memory_backed;
+		mapping = file->f_mapping;
+		if (!mapping)
+			mapping = file->f_dentry->d_inode->i_mapping;
+
+		capabilities = 0;
+		if (mapping && mapping->backing_dev_info)
+			capabilities = mapping->backing_dev_info->capabilities;
+
+		if (!capabilities) {
+			/* no explicit capabilities set, so assume some
+			 * defaults */
+			switch (file->f_dentry->d_inode->i_mode & S_IFMT) {
+			case S_IFREG:
+			case S_IFBLK:
+				capabilities = BDI_CAP_MAP_COPY;
+				break;
+
+			case S_IFCHR:
+				capabilities =
+					BDI_CAP_MAP_DIRECT |
+					BDI_CAP_READ_MAP |
+					BDI_CAP_WRITE_MAP;
+				break;
+
+			default:
+				return -EINVAL;
+			}
 		}
 
+		/* eliminate any capabilities that we can't support on this
+		 * device */
+		if (!file->f_op->get_unmapped_area)
+			capabilities &= ~BDI_CAP_MAP_DIRECT;
+		if (!file->f_op->read)
+			capabilities &= ~BDI_CAP_MAP_COPY;
+
 		if (flags & MAP_SHARED) {
 			/* do checks for writing, appending and locking */
-			if ((prot & PROT_WRITE) && !(file->f_mode & FMODE_WRITE))
+			if ((prot & PROT_WRITE) &&
+			    !(file->f_mode & FMODE_WRITE))
 				return -EACCES;
 
 			if (IS_APPEND(file->f_dentry->d_inode) &&
@@ -452,64 +455,243 @@ unsigned long do_mmap_pgoff(struct file 
 			if (locks_verify_locked(file->f_dentry->d_inode))
 				return -EAGAIN;
 
-			if (!membacked) {
+			if (!(capabilities & BDI_CAP_MAP_DIRECT))
+				return -ENODEV;
+
+			if (((prot & PROT_READ)  && !(capabilities & BDI_CAP_READ_MAP))  ||
+			    ((prot & PROT_WRITE) && !(capabilities & BDI_CAP_WRITE_MAP)) ||
+			    ((prot & PROT_EXEC)  && !(capabilities & BDI_CAP_EXEC_MAP))
+			    ) {
 				printk("MAP_SHARED not completely supported on !MMU\n");
 				return -EINVAL;
 			}
 
-			/* we require greater support from the driver or
-			 * filesystem - we ask it to tell us what memory to
-			 * use */
-			if (!file->f_op->get_unmapped_area)
-				return -ENODEV;
+			/* we mustn't privatise shared mappings */
+			capabilities &= ~BDI_CAP_MAP_COPY;
 		}
 		else {
-			/* we read private files into memory we allocate */
-			if (!file->f_op->read)
+			/* we're going to read the file into private memory we
+			 * allocate */
+			if (!(capabilities & BDI_CAP_MAP_COPY))
 				return -ENODEV;
+
+			/* we don't permit a private writable mapping to be
+			 * shared with the backing device */
+			if (prot & PROT_WRITE)
+				capabilities &= ~BDI_CAP_MAP_DIRECT;
+		}
+
+		/* handle executable mappings and implied executable
+		 * mappings */
+		if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC) {
+			if (prot & PROT_EXEC)
+				return -EPERM;
+		}
+		else if ((prot & PROT_READ) && !(prot & PROT_EXEC)) {
+			/* handle implication of PROT_EXEC by PROT_READ */
+			if (current->personality & READ_IMPLIES_EXEC) {
+				if (capabilities & BDI_CAP_EXEC_MAP)
+					prot |= PROT_EXEC;
+			}
+		}
+		else if ((prot & PROT_READ) &&
+			 (prot & PROT_EXEC) &&
+			 !(capabilities & BDI_CAP_EXEC_MAP)
+			 ) {
+			/* backing file is not executable, try to copy */
+			capabilities &= ~BDI_CAP_MAP_DIRECT;
 		}
 	}
+	else {
+		/* anonymous mappings are always memory backed and can be
+		 * privately mapped
+		 */
+		capabilities = BDI_CAP_MAP_COPY;
 
-	/* handle PROT_EXEC implication by PROT_READ */
-	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
-		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
+		/* handle PROT_EXEC implication by PROT_READ */
+		if ((prot & PROT_READ) &&
+		    (current->personality & READ_IMPLIES_EXEC))
 			prot |= PROT_EXEC;
+	}
 
-	/* do simple checking here so the lower-level routines won't have
-	 * to. we assume access permissions have been handled by the open
-	 * of the memory object, so we don't do any here.
-	 */
-	vm_flags = calc_vm_flags(prot,flags) /* | mm->def_flags */
-		| VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	/* allow the security API to have its say */
+	ret = security_file_mmap(file, prot, flags);
+	if (ret < 0)
+		return ret;
 
-	if (!membacked) {
-		/* share any file segment that's mapped read-only */
-		if (((flags & MAP_PRIVATE) && !(prot & PROT_WRITE) && file) ||
-		    ((flags & MAP_SHARED) && !(prot & PROT_WRITE) && file))
-			vm_flags |= VM_MAYSHARE;
+	/* looks okay */
+	*_capabilities = capabilities;
+	return 0;
+}
 
-		/* refuse to let anyone share files with this process if it's being traced -
-		 * otherwise breakpoints set in it may interfere with another untraced process
-		 */
-		if (current->ptrace & PT_PTRACED)
-			vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
+/*
+ * we've determined that we can make the mapping, now translate what we
+ * now know into VMA flags
+ */
+static unsigned long determine_vm_flags(struct file *file,
+					unsigned long prot,
+					unsigned long flags,
+					unsigned long capabilities)
+{
+	unsigned long vm_flags;
+
+	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags);
+	vm_flags |= VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	/* vm_flags |= mm->def_flags; */
+
+	if (!(capabilities & BDI_CAP_MAP_DIRECT)) {
+		/* attempt to share read-only copies of mapped file chunks */
+		if (file && !(prot & PROT_WRITE))
+			vm_flags |= VM_MAYSHARE;
 	}
 	else {
-		/* permit sharing of character devices and ramfs files at any time for
-		 * anything other than a privately writable mapping
-		 */
-		if (!(flags & MAP_PRIVATE) || !(prot & PROT_WRITE)) {
+		/* overlay a shareable mapping on the backing device or inode
+		 * if possible - used for chardevs, ramfs/tmpfs/shmfs and
+		 * romfs/cramfs */
+		if (flags & MAP_SHARED)
+			vm_flags |= VM_MAYSHARE | VM_SHARED;
+		else if ((((vm_flags & capabilities) ^ vm_flags) & BDI_CAP_VMFLAGS) == 0)
 			vm_flags |= VM_MAYSHARE;
-			if (flags & MAP_SHARED)
-				vm_flags |= VM_SHARED;
+	}
+
+	/* refuse to let anyone share private mappings with this process if
+	 * it's being traced - otherwise breakpoints set in it may interfere
+	 * with another untraced process
+	 */
+	if ((flags & MAP_PRIVATE) && (current->ptrace & PT_PTRACED))
+		vm_flags &= ~VM_MAYSHARE;
+
+	return vm_flags;
+}
+
+/*
+ * set up a shared mapping on a file
+ */
+static int do_mmap_shared_file(struct vm_area_struct *vma, unsigned long len)
+{
+	int ret;
+
+	ret = vma->vm_file->f_op->mmap(vma->vm_file, vma);
+	if (ret != -ENOSYS)
+		return ret;
+
+	/* getting an ENOSYS error indicates that direct mmap isn't
+	 * possible (as opposed to tried but failed) so we'll fall
+	 * through to making a private copy of the data and mapping
+	 * that if we can */
+	return -ENODEV;
+}
+
+/*
+ * set up a private mapping or an anonymous shared mapping
+ */
+static int do_mmap_private(struct vm_area_struct *vma, unsigned long len)
+{
+	void *base;
+	int ret;
+
+	/* invoke the file's mapping function so that it can keep track of
+	 * shared mappings on devices or memory
+	 * - VM_MAYSHARE will be set if it may attempt to share
+	 */
+	if (vma->vm_file) {
+		ret = vma->vm_file->f_op->mmap(vma->vm_file, vma);
+		if (ret != -ENOSYS) {
+			/* shouldn't return success if we're not sharing */
+			BUG_ON(ret == 0 && !(vma->vm_flags & VM_MAYSHARE));
+			return ret; /* success or a real error */
 		}
+
+		/* getting an ENOSYS error indicates that direct mmap isn't
+		 * possible (as opposed to tried but failed) so we'll try to
+		 * make a private copy of the data and map that instead */
 	}
 
-	/* allow the security API to have its say */
-	ret = security_file_mmap(file, prot, flags);
-	if (ret)
+	/* allocate some memory to hold the mapping
+	 * - note that this may not return a page-aligned address if the object
+	 *   we're allocating is smaller than a page
+	 */
+	base = kmalloc(len, GFP_KERNEL);
+	if (!base)
+		goto enomem;
+
+	vma->vm_start = (unsigned long) base;
+	vma->vm_end = vma->vm_start + len;
+	vma->vm_flags |= VM_MAPPED_COPY;
+
+#ifdef WARN_ON_SLACK
+	if (len + WARN_ON_SLACK <= kobjsize(result))
+		printk("Allocation of %lu bytes from process %d has %lu bytes of slack\n",
+		       len, current->pid, kobjsize(result) - len);
+#endif
+
+	if (vma->vm_file) {
+		/* read the contents of a file into the copy */
+		mm_segment_t old_fs;
+		loff_t fpos;
+
+		fpos = vma->vm_pgoff;
+		fpos <<= PAGE_SHIFT;
+
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		ret = vma->vm_file->f_op->read(vma->vm_file, base, len, &fpos);
+		set_fs(old_fs);
+
+		if (ret < 0)
+			goto error_free;
+
+		/* clear the last little bit */
+		if (ret < len)
+			memset(base + ret, 0, len - ret);
+
+	} else {
+		/* if it's an anonymous mapping, then just clear it */
+		memset(base, 0, len);
+	}
+
+	return 0;
+
+error_free:
+	kfree(base);
+	vma->vm_start = 0;
+	return ret;
+
+enomem:
+	printk("Allocation of length %lu from process %d failed\n",
+	       len, current->pid);
+	show_free_areas();
+	return -ENOMEM;
+}
+
+/*
+ * handle mapping creation for uClinux
+ */
+unsigned long do_mmap_pgoff(struct file *file,
+			    unsigned long addr,
+			    unsigned long len,
+			    unsigned long prot,
+			    unsigned long flags,
+			    unsigned long pgoff)
+{
+	struct vm_list_struct *vml = NULL;
+	struct vm_area_struct *vma = NULL;
+	struct rb_node *rb;
+	unsigned long capabilities, vm_flags;
+	void *result;
+	int ret;
+
+	/* decide whether we should attempt the mapping, and if so what sort of
+	 * mapping */
+	ret = validate_mmap_request(file, addr, len, prot, flags, pgoff,
+				    &capabilities);
+	if (ret < 0)
 		return ret;
 
+	/* we've determined that we can make the mapping, now translate what we
+	 * now know into VMA flags */
+	vm_flags = determine_vm_flags(file, prot, flags, capabilities);
+
 	/* we're going to need to record the mapping if it works */
 	vml = kmalloc(sizeof(struct vm_list_struct), GFP_KERNEL);
 	if (!vml)
@@ -518,8 +700,8 @@ unsigned long do_mmap_pgoff(struct file 
 
 	down_write(&nommu_vma_sem);
 
-	/* if we want to share, we need to search for VMAs created by another
-	 * mmap() call that overlap with our proposed mapping
+	/* if we want to share, we need to check for VMAs created by other
+	 * mmap() calls that overlap with our proposed mapping
 	 * - we can only share with an exact match on most regular files
 	 * - shared mappings on character devices and memory backed files are
 	 *   permitted to overlap inexactly as far as we are concerned for in
@@ -543,13 +725,14 @@ unsigned long do_mmap_pgoff(struct file 
 			if (vma->vm_pgoff >= pgoff + pglen)
 				continue;
 
-			vmpglen = (vma->vm_end - vma->vm_start + PAGE_SIZE - 1) >> PAGE_SHIFT;
+			vmpglen = vma->vm_end - vma->vm_start + PAGE_SIZE - 1;
+			vmpglen >>= PAGE_SHIFT;
 			if (pgoff >= vma->vm_pgoff + vmpglen)
 				continue;
 
-			/* handle inexact matches between mappings */
-			if (vmpglen != pglen || vma->vm_pgoff != pgoff) {
-				if (!membacked)
+			/* handle inexactly overlapping matches between mappings */
+			if (vma->vm_pgoff != pgoff || vmpglen != pglen) {
+				if (!(capabilities & BDI_CAP_MAP_DIRECT))
 					goto sharing_violation;
 				continue;
 			}
@@ -561,21 +744,30 @@ unsigned long do_mmap_pgoff(struct file 
 			result = (void *) vma->vm_start;
 			goto shared;
 		}
-	}
 
-	vma = NULL;
+		vma = NULL;
 
-	/* obtain the address to map to. we verify (or select) it and ensure
-	 * that it represents a valid section of the address space
-	 * - this is the hook for quasi-memory character devices
-	 */
-	if (file && file->f_op->get_unmapped_area) {
-		addr = file->f_op->get_unmapped_area(file, addr, len, pgoff, flags);
-		if (IS_ERR((void *) addr)) {
-			ret = addr;
-			if (ret == (unsigned long) -ENOSYS)
+		/* obtain the address at which to make a shared mapping
+		 * - this is the hook for quasi-memory character devices to
+		 *   tell us the location of a shared mapping
+		 */
+		if (file && file->f_op->get_unmapped_area) {
+			addr = file->f_op->get_unmapped_area(file, addr, len,
+							     pgoff, flags);
+			if (IS_ERR((void *) addr)) {
+				ret = addr;
+				if (ret != (unsigned long) -ENOSYS)
+					goto error;
+
+				/* the driver refused to tell us where to site
+				 * the mapping so we'll have to attempt to copy
+				 * it */
 				ret = (unsigned long) -ENODEV;
-			goto error;
+				if (!(capabilities & BDI_CAP_MAP_COPY))
+					goto error;
+
+				capabilities &= ~BDI_CAP_MAP_DIRECT;
+			}
 		}
 	}
 
@@ -597,96 +789,18 @@ unsigned long do_mmap_pgoff(struct file 
 
 	vml->vma = vma;
 
-	/* determine the object being mapped and call the appropriate specific
-	 * mapper.
-	 */
-	if (file) {
-#ifdef MAGIC_ROM_PTR
-		/* First, try simpler routine designed to give us a ROM pointer. */
-		if (file->f_op->romptr && !(prot & PROT_WRITE)) {
-			ret = file->f_op->romptr(file, vma);
-#ifdef DEBUG
-			printk("romptr mmap returned %d (st=%lx)\n",
-			       ret, vma->vm_start);
-#endif
-			result = (void *) vma->vm_start;
-			if (!ret)
-				goto done;
-			else if (ret != -ENOSYS)
-				goto error;
-		} else
-#endif /* MAGIC_ROM_PTR */
-		/* Then try full mmap routine, which might return a RAM
-		 * pointer, or do something truly complicated
-		 */
-		if (file->f_op->mmap) {
-			ret = file->f_op->mmap(file, vma);
-
-#ifdef DEBUG
-			printk("f_op->mmap() returned %d (st=%lx)\n",
-			       ret, vma->vm_start);
-#endif
-			result = (void *) vma->vm_start;
-			if (!ret)
-				goto done;
-			else if (ret != -ENOSYS)
-				goto error;
-		} else {
-			ret = -ENODEV; /* No mapping operations defined */
-			goto error;
-		}
-
-		/* An ENOSYS error indicates that mmap isn't possible (as
-		 * opposed to tried but failed) so we'll fall through to the
-		 * copy. */
-	}
-
-	/* allocate some memory to hold the mapping
-	 * - note that this may not return a page-aligned address if the object
-	 *   we're allocating is smaller than a page
-	 */
-	ret = -ENOMEM;
-	result = kmalloc(len, GFP_KERNEL);
-	if (!result) {
-		printk("Allocation of length %lu from process %d failed\n",
-		       len, current->pid);
-		show_free_areas();
+	/* set up the mapping */
+	if (file && vma->vm_flags & VM_SHARED)
+		ret = do_mmap_shared_file(vma, len);
+	else
+		ret = do_mmap_private(vma, len);
+	if (ret < 0)
 		goto error;
-	}
-
-	vma->vm_start = (unsigned long) result;
-	vma->vm_end = vma->vm_start + len;
 
-#ifdef WARN_ON_SLACK
-	if (len + WARN_ON_SLACK <= kobjsize(result))
-		printk("Allocation of %lu bytes from process %d has %lu bytes of slack\n",
-		       len, current->pid, kobjsize(result) - len);
-#endif
+	/* okay... we have a mapping; now we have to register it */
+	result = (void *) vma->vm_start;
 
-	if (file) {
-		mm_segment_t old_fs = get_fs();
-		loff_t fpos;
-
-		fpos = pgoff;
-		fpos <<= PAGE_SHIFT;
-
-		set_fs(KERNEL_DS);
-		ret = file->f_op->read(file, (char *) result, len, &fpos);
-		set_fs(old_fs);
-
-		if (ret < 0)
-			goto error2;
-		if (ret < len)
-			memset(result + ret, 0, len - ret);
-	} else {
-		memset(result, 0, len);
-	}
-
-	if (prot & PROT_EXEC)
-		flush_icache_range((unsigned long) result, (unsigned long) result + len);
-
- done:
-	if (!(vma->vm_flags & VM_SHARED)) {
+	if (vma->vm_flags & VM_MAPPED_COPY) {
 		realalloc += kobjsize(result);
 		askedalloc += len;
 	}
@@ -697,6 +811,7 @@ unsigned long do_mmap_pgoff(struct file 
 	current->mm->total_vm += len >> PAGE_SHIFT;
 
 	add_nommu_vma(vma);
+
  shared:
 	realalloc += kobjsize(vml);
 	askedalloc += sizeof(*vml);
@@ -706,6 +821,10 @@ unsigned long do_mmap_pgoff(struct file 
 
 	up_write(&nommu_vma_sem);
 
+	if (prot & PROT_EXEC)
+		flush_icache_range((unsigned long) result,
+				   (unsigned long) result + len);
+
 #ifdef DEBUG
 	printk("do_mmap:\n");
 	show_process_blocks();
@@ -713,8 +832,6 @@ unsigned long do_mmap_pgoff(struct file 
 
 	return (unsigned long) result;
 
- error2:
-	kfree(result);
  error:
 	up_write(&nommu_vma_sem);
 	kfree(vml);
@@ -761,7 +878,7 @@ static void put_vma(struct vm_area_struc
 
 			/* IO memory and memory shared directly out of the pagecache from
 			 * ramfs/tmpfs mustn't be released here */
-			if (!(vma->vm_flags & (VM_IO | VM_SHARED)) && vma->vm_start) {
+			if (vma->vm_flags & VM_MAPPED_COPY) {
 				realalloc -= kobjsize((void *) vma->vm_start);
 				askedalloc -= vma->vm_end - vma->vm_start;
 				kfree((void *) vma->vm_start);
@@ -784,13 +901,6 @@ int do_munmap(struct mm_struct *mm, unsi
 	struct vm_list_struct *vml, **parent;
 	unsigned long end = addr + len;
 
-#ifdef MAGIC_ROM_PTR
-	/* For efficiency's sake, if the pointer is obviously in ROM,
-	   don't bother walking the lists to free it */
-	if (is_in_rom(addr))
-		return 0;
-#endif
-
 #ifdef DEBUG
 	printk("do_munmap:\n");
 #endif
@@ -1062,4 +1172,3 @@ int __vm_enough_memory(long pages, int c
 
 	return -ENOMEM;
 }
-
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/Documentation/nommu-mmap.txt linux-2.6.11-rc4-memback/Documentation/nommu-mmap.txt
--- /warthog/kernels/linux-2.6.11-rc4/Documentation/nommu-mmap.txt	2005-02-14 12:18:03.000000000 +0000
+++ linux-2.6.11-rc4-memback/Documentation/nommu-mmap.txt	2005-03-02 19:31:37.000000000 +0000
@@ -36,20 +36,35 @@ and it's also much more restricted in th
 	In the MMU case: VM regions backed by pages read from file; changes to
 	the underlying file are reflected in the mapping; copied across fork.
 
-	In the no-MMU case: VM regions backed by arbitrary contiguous runs of
-	pages into which the appropriate bit of the file is read; any remaining
-	bit of the mapping is cleared; such mappings are shared if possible;
-	writes to the file do not affect the mapping; writes to the mapping are
-	visible in other processes (no MMU protection), but should not happen.
+	In the no-MMU case:
+
+         - If one exists, the kernel will re-use an existing mapping to the
+           same segment of the same file if that has compatible permissions,
+           even if this was created by another process.
+
+         - If possible, the file mapping will be directly on the backing device
+           if the backing device has the BDI_CAP_MAP_DIRECT capability and
+           appropriate mapping protection capabilities. Ramfs, romfs, cramfs
+           and mtd might all permit this.
+
+	 - If the backing device device can't or won't permit direct sharing,
+           but does have the BDI_CAP_MAP_COPY capability, then a copy of the
+           appropriate bit of the file will be read into a contiguous bit of
+           memory and any extraneous space beyond the EOF will be cleared
+
+	 - Writes to the file do not affect the mapping; writes to the mapping
+	   are visible in other processes (no MMU protection), but should not
+	   happen.
 
  (*) File, MAP_PRIVATE, PROT_READ / PROT_EXEC, PROT_WRITE
 
 	In the MMU case: like the non-PROT_WRITE case, except that the pages in
 	question get copied before the write actually happens. From that point
-	on writes to that page in the file no longer get reflected into the
-	mapping's backing pages.
+	on writes to the file underneath that page no longer get reflected into
+	the mapping's backing pages. The page is then backed by swap instead.
 
-	In the no-MMU case: works exactly as for the non-PROT_WRITE case.
+	In the no-MMU case: works much like the non-PROT_WRITE case, except
+	that a copy is always taken and never shared.
 
  (*) Regular file / blockdev, MAP_SHARED, PROT_READ / PROT_EXEC / PROT_WRITE
 
@@ -70,6 +85,15 @@ and it's also much more restricted in th
 	as for the MMU case. If the filesystem does not provide any such
 	support, then the mapping request will be denied.
 
+ (*) Memory backed blockdev, MAP_SHARED, PROT_READ / PROT_EXEC / PROT_WRITE
+
+	In the MMU case: As for ordinary regular files.
+
+	In the no-MMU case: As for memory backed regular files, but the
+	blockdev must be able to provide a contiguous run of pages without
+	truncate being called. The ramdisk driver could do this if it allocated
+	all its memory as a contiguous array upfront.
+
  (*) Memory backed chardev, MAP_SHARED, PROT_READ / PROT_EXEC / PROT_WRITE
 
 	In the MMU case: As for ordinary regular files.
@@ -95,12 +119,12 @@ FURTHER NOTES ON NO-MMU MMAP
  (*) Supplying MAP_FIXED or a requesting a particular mapping address will
      result in an error.
 
- (*) Files mapped privately must have a read method provided by the driver or
-     filesystem so that the contents can be read into the memory allocated. An
+ (*) Files mapped privately usually have to have a read method provided by the
+     driver or filesystem so that the contents can be read into the memory
+     allocated if mmap() chooses not to map the backing device directly. An
      error will result if they don't. This is most likely to be encountered
      with character device files, pipes, fifos and sockets.
 
-
 ============================================
 PROVIDING SHAREABLE CHARACTER DEVICE SUPPORT
 ============================================
@@ -111,6 +135,15 @@ to get a proposed address for the mappin
 doesn't wish to honour the mapping because it's too long, at a weird offset,
 under some unsupported combination of flags or whatever.
 
+The driver should also provide backing device information with capabilities set
+to indicate the permitted types of mapping on such devices. The default is
+assumed to be readable and writable, not executable, and only shareable
+directly (can't be copied).
+
+The file->f_op->mmap() operation will be called to actually inaugurate the
+mapping. It can be rejected at that point. Returning the ENOSYS error will
+cause the mapping to be copied instead if BDI_CAP_MAP_COPY is specified.
+
 The vm_ops->close() routine will be invoked when the last mapping on a chardev
 is removed. An existing mapping will be shared, partially or not, if possible
 without notifying the driver.
@@ -120,7 +153,22 @@ return -ENOSYS. This will be taken to me
 want to handle it, despite the fact it's got an operation. For instance, it
 might try directing the call to a secondary driver which turns out not to
 implement it. Such is the case for the framebuffer driver which attempts to
-direct the call to the device-specific driver.
+direct the call to the device-specific driver. Under such circumstances, the
+mapping request will be rejected if BDI_CAP_MAP_COPY is not specified, and a
+copy mapped otherwise.
+
+IMPORTANT NOTE:
+
+	Some types of device may present a different appearance to anyone
+	looking at them in certain modes. Flash chips can be like this; for
+	instance if they're in programming or erase mode, you might see the
+	status reflected in the mapping, instead of the data.
+
+	In such a case, care must be taken lest userspace see a shared or a
+	private mapping showing such information when the driver is busy
+	controlling the device. Remember especially: private executable
+	mappings may still be mapped directly off the device under some
+	circumstances!
 
 
 ==============================================
@@ -139,3 +187,12 @@ memory.
 
 Memory backed devices are indicated by the mapping's backing device info having
 the memory_backed flag set.
+
+
+========================================
+PROVIDING SHAREABLE BLOCK DEVICE SUPPORT
+========================================
+
+Provision of shared mappings on block device files is exactly the same as for
+character devices. If there isn't a real device underneath, then the driver
+should allocate sufficient contiguous memory to honour any supported mapping.
