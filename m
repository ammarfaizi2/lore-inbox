Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbULOPzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbULOPzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbULOPzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:55:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262373AbULOPyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:54:36 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2149.1103124772@redhat.com> 
References: <2149.1103124772@redhat.com> 
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Permit nommu MAP_SHARED of memory backed files
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Wed, 15 Dec 2004 15:54:29 +0000
Message-ID: <2507.1103126069@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The attached patch applies some further fixes and extensions to the nommu mmap
implementation:

 (1) /proc/maps distinguishes shareable private mappings and real shared
     mappings by marking the former with 's' and the latter with 'S'.

 (2) Rearrange and optimise the checking portion of do_mmap_pgoff() to make it
     easier to follow.

 (3) Only set VM_SHARED on MAP_SHARED mappings. Its presence indicates that the
     backing memory is supplied by the underlying file or chardev.

     VM_MAYSHARE indicates that a VMA may be shared if it's a private VMA. The
     memory for a private VMA is allocated by do_mmap_pgoff() from a kmalloc
     slab and then the file contents are read into it before returning.

 (4) Permit MAP_SHARED + PROT_WRITE on memory-backed files[*] and chardevs to
     indicate a contiguous area of memory when its get_unmapped_area() is
     called if the backing fs/chardev is willing.

     [*] file->f_mapping->backing_dev_info->memory_backed == 1

 (5) Require chardevs and files that support to provide a get_unmapped_area()
     file operation.

 (6) Made sure a private mapping of /dev/zero is possible. Shared mappings of
     /dev/zero are not currently supported because this'd need greater
     interaction of mmap with the chardev driver than is currently supported.

 (7) Add in some extra checks from mm/mmap.c: security, file having write
     access for a writable shared mapping, file not being in append mode.

 (8) Only account the mapping memory if it's allocated here; memory belonging
     to a shared chardev or file is not accounted.

With this patch it should be possible to map contiguous flash files directly
out of ROM simply by providing get_unmapped_area() for a read-only/shared
mapping.

I think that it might be worth splitting do_mmap_pgoff() up into smaller
subfunctions: one to handle the checking, one to handle shared mappings and
one to handle private mappings.


Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog1>diffstat nommu-mmap-2610rc3.diff 
 fs/proc/nommu.c |    2 
 mm/nommu.c      |  182 +++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 124 insertions(+), 60 deletions(-)

diff -uNrp linux-2.6.10-rc3-mm1-nommu-prio/fs/proc/nommu.c linux-2.6.10-rc3-mm1-nommu-mmap/fs/proc/nommu.c
--- linux-2.6.10-rc3-mm1-nommu-prio/fs/proc/nommu.c	2004-12-13 17:34:19.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-mmap/fs/proc/nommu.c	2004-12-14 20:05:49.000000000 +0000
@@ -62,7 +62,7 @@ static int nommu_vma_list_show(struct se
 		   flags & VM_READ ? 'r' : '-',
 		   flags & VM_WRITE ? 'w' : '-',
 		   flags & VM_EXEC ? 'x' : '-',
-		   flags & VM_MAYSHARE ? 's' : 'p',
+		   flags & VM_MAYSHARE ? flags & VM_SHARED ? 'S' : 's' : 'p',
 		   vma->vm_pgoff << PAGE_SHIFT,
 		   MAJOR(dev), MINOR(dev), ino, &len);
 
diff -uNrp linux-2.6.10-rc3-mm1-nommu-prio/mm/nommu.c linux-2.6.10-rc3-mm1-nommu-mmap/mm/nommu.c
--- linux-2.6.10-rc3-mm1-nommu-prio/mm/nommu.c	2004-12-15 13:38:04.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-mmap/mm/nommu.c	2004-12-15 12:48:44.000000000 +0000
@@ -21,6 +21,9 @@
 #include <linux/ptrace.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/mount.h>
+#include <linux/personality.h>
+#include <linux/security.h>
 #include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
@@ -386,31 +389,15 @@ unsigned long do_mmap_pgoff(struct file 
 	struct rb_node *rb;
 	unsigned int vm_flags;
 	void *result;
-	int ret, chrdev;
-
-	/*
-	 * Get the !CONFIG_MMU specific checks done first
-	 */
-	chrdev = 0;
-	if (file)
-		chrdev = S_ISCHR(file->f_dentry->d_inode->i_mode);
-
-	if ((flags & MAP_SHARED) && (prot & PROT_WRITE) && file && !chrdev) {
-		printk("MAP_SHARED not completely supported (cannot detect page dirtying)\n");
-		return -EINVAL;
-	}
+	int ret, membacked;
 
+	/* do the simple checks first */
 	if (flags & MAP_FIXED || addr) {
-		/* printk("can't do fixed-address/overlay mmap of RAM\n"); */
+		printk(KERN_DEBUG "%d: Can't do fixed-address/overlay mmap of RAM\n",
+		       current->pid);
 		return -EINVAL;
 	}
 
-	/*
-	 * now all the standard checks
-	 */
-	if (file && (!file->f_op || !file->f_op->mmap))
-		return -ENODEV;
-
 	if (PAGE_ALIGN(len) == 0)
 		return addr;
 
@@ -421,55 +408,129 @@ unsigned long do_mmap_pgoff(struct file 
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;
 
-	/* we're going to need to record the mapping if it works */
-	vml = kmalloc(sizeof(struct vm_list_struct), GFP_KERNEL);
-	if (!vml)
-		goto error_getting_vml;
-	memset(vml, 0, sizeof(*vml));
+	/* validate file mapping requests */
+	membacked = 0;
+	if (file) {
+		/* files must support mmap */
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) &&
+		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+
+		/* work out if what we've got could possibly be shared
+		 * - we support chardevs that provide their own "memory"
+		 * - we support files/blockdevs that are memory backed
+		 */
+		if (S_ISCHR(file->f_dentry->d_inode->i_mode)) {
+			membacked = 1;
+		}
+		else {
+			struct address_space *mapping = file->f_mapping;
+			if (!mapping)
+				mapping = file->f_dentry->d_inode->i_mapping;
+			if (mapping && mapping->backing_dev_info)
+				membacked = mapping->backing_dev_info->memory_backed;
+		}
+
+		if (flags & MAP_SHARED) {
+			/* do checks for writing, appending and locking */
+			if ((prot & PROT_WRITE) && !(file->f_mode & FMODE_WRITE))
+				return -EACCES;
+
+			if (IS_APPEND(file->f_dentry->d_inode) &&
+			    (file->f_mode & FMODE_WRITE))
+				return -EACCES;
+
+			if (locks_verify_locked(file->f_dentry->d_inode))
+				return -EAGAIN;
+
+			if (!membacked) {
+				printk("MAP_SHARED not completely supported on !MMU\n");
+				return -EINVAL;
+			}
 
-	/* Do simple checking here so the lower-level routines won't have
+			/* we require greater support from the driver or
+			 * filesystem - we ask it to tell us what memory to
+			 * use */
+			if (!file->f_op->get_unmapped_area)
+				return -ENODEV;
+		}
+		else {
+			/* we read private files into memory we allocate */
+			if (!file->f_op->read)
+				return -ENODEV;
+		}
+	}
+
+	/* handle PROT_EXEC implication by PROT_READ */
+	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
+		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
+			prot |= PROT_EXEC;
+
+	/* do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
 	vm_flags = calc_vm_flags(prot,flags) /* | mm->def_flags */
 		| VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
-	if (!chrdev) {
+	if (!membacked) {
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
-		vm_flags |= VM_MAYSHARE;
-		if (flags & MAP_SHARED)
-			vm_flags |= VM_SHARED;
+		/* permit sharing of character devices and ramfs files at any time for
+		 * anything other than a privately writable mapping
+		 */
+		if (!(flags & MAP_PRIVATE) || !(prot & PROT_WRITE)) {
+			vm_flags |= VM_MAYSHARE;
+			if (flags & MAP_SHARED)
+				vm_flags |= VM_SHARED;
+		}
 	}
 
-	/* if we want to share, we need to search for VMAs created by another mmap() call that
-	 * overlap with our proposed mapping
-	 * - we can only share with an exact match on regular files
-	 * - shared mappings on character devices are permitted to overlap inexactly as far as we
-	 *   are concerned, but in that case, sharing is handled in the driver rather than here
-	 */
+	/* allow the security API to have its say */
+	ret = security_file_mmap(file, prot, flags);
+	if (ret)
+		return ret;
+
+	/* we're going to need to record the mapping if it works */
+	vml = kmalloc(sizeof(struct vm_list_struct), GFP_KERNEL);
+	if (!vml)
+		goto error_getting_vml;
+	memset(vml, 0, sizeof(*vml));
+
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
 
@@ -480,8 +541,9 @@ unsigned long do_mmap_pgoff(struct file 
 			if (pgoff >= vma->vm_pgoff + vmpglen)
 				continue;
 
+			/* handle inexact matches between mappings */
 			if (vmpglen != pglen || vma->vm_pgoff != pgoff) {
-				if (flags & MAP_SHARED)
+				if (!membacked)
 					goto sharing_violation;
 				continue;
 			}
@@ -495,11 +557,13 @@ unsigned long do_mmap_pgoff(struct file 
 		}
 	}
 
+	vma = NULL;
+
 	/* obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space
 	 * - this is the hook for quasi-memory character devices
 	 */
-	if (file && file->f_op && file->f_op->get_unmapped_area)
+	if (file && file->f_op->get_unmapped_area)
 		addr = file->f_op->get_unmapped_area(file, addr, len, pgoff, flags);
 
 	if (IS_ERR((void *) addr)) {
@@ -525,18 +589,12 @@ unsigned long do_mmap_pgoff(struct file 
 
 	vml->vma = vma;
 
-	/*
-	 * determine the object being mapped and call the appropriate
-	 * specific mapper.
+	/* determine the object being mapped and call the appropriate specific
+	 * mapper.
 	 */
 	if (file) {
-		ret = -ENODEV;
-		if (!file->f_op)
-			goto error;
-
 #ifdef MAGIC_ROM_PTR
 		/* First, try simpler routine designed to give us a ROM pointer. */
-
 		if (file->f_op->romptr && !(prot & PROT_WRITE)) {
 			ret = file->f_op->romptr(file, vma);
 #ifdef DEBUG
@@ -550,9 +608,9 @@ unsigned long do_mmap_pgoff(struct file 
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
 
@@ -570,11 +628,15 @@ unsigned long do_mmap_pgoff(struct file 
 			goto error;
 		}
 
-		/* An ENOSYS error indicates that mmap isn't possible (as opposed to
-		   tried but failed) so we'll fall through to the copy. */
+		/* An ENOSYS error indicates that mmap isn't possible (as
+		 * opposed to tried but failed) so we'll fall through to the
+		 * copy. */
 	}
 
-	/* allocate some memory to hold the mapping */
+	/* allocate some memory to hold the mapping
+	 * - note that this may not return a page-aligned address if the object
+	 *   we're allocating is smaller than a page
+	 */
 	ret = -ENOMEM;
 	result = kmalloc(len, GFP_KERNEL);
 	if (!result) {
@@ -616,8 +678,10 @@ unsigned long do_mmap_pgoff(struct file 
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
