Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVCBPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVCBPxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVCBPw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:52:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262336AbVCBPup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:50:45 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org
Subject: Improving mmap() support for !MMU further
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 02 Mar 2005 15:50:27 +0000
Message-ID: <9420.1109778627@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I'd like to improve mmap() support on !MMU still further by overloading struct
backing_dev_info::memory_backed to hold flags describing what the backing
device is capable of with respect to direct memory access.

 (*) If bdi->memory_backed is 0, then the backing device is not accessible as
     memory.

 (*) If the bdi->memory_backed is non-zero, then it's a bit mask of the
     following:

	#define BDI_NO_WRITEBACK	0x00000001
	#define BDI_MEMORY_BACKED	0x00000001
	#define BDI_CAN_MAP_DIRECT	0x00000002
	#define BDI_CAN_MAP_COPY	0x00000004
	#define BDI_CAN_READ_MAP	VM_MAYREAD
	#define BDI_CAN_WRITE_MAP	VM_MAYWRITE
	#define BDI_CAN_EXEC_MAP	VM_MAYEXEC

 (*) BDI_NO_WRITEBACK

     Don't attempt to write back dirty pages.

 (*) BDI_MEMORY_BACKED

     The device is a memory or quasi-memory device.

 (*) BDI_CAN_MAP_DIRECT

     The device can be mapped directly. This means MAP_SHARED can be supported
     within the bounds of the specific mapping protection types.

 (*) BDI_CAN_MAP_COPY

     A copy into memory can be taken of all or part of the device using the
     file->f_op->read() method, and that can be passed to userspace as a
     MAP_PRIVATE mapping.

     I/O devices, such as framebuffers, probably wouldn't set this as it
     doesn't make sense to take a copy. Storage devices (such as flash) and
     filesystems (such as RAMFS, CRAMFS or ROMFS) might, because it does make
     sense to take a copy for private writable mappings such as are made for
     executables.

 (*) BDI_CAN_READ_MAP
 (*) BDI_CAN_WRITE_MAP
 (*) BDI_CAN_EXEC_MAP

     Describe the capabilities of the backing device if mapped directly. RAMFS
     and RAMDISK could set all three, but CRAMFS, ROMFS and flash filesystems
     would probably not indicate writability and I/O devices such as frame
     buffers would not indicate executability.


By using such capability flags, no-MMU mmap() (and even MMU mmap()) could:

 (1) Reject unsupportable shared mappings early on.

 (2) Obviate the need for ROMFS hooks by determining what mappings can be
     mapped directly out of ROM and what must fall back to copies in RAM.

I've attached a sample mm/nommu.c mmap() implementation using this capability
information for reference. Note the defaults for a chardev are direct mappings
only and for a file are copied mappings only (copied mappings can be shared
under some circumstances).

David

---
unsigned long do_mmap_pgoff(struct file *file,
			    unsigned long addr,
			    unsigned long len,
			    unsigned long prot,
			    unsigned long flags,
			    unsigned long pgoff)
{
	struct vm_list_struct *vml = NULL;
	struct vm_area_struct *vma = NULL;
	struct rb_node *rb;
	unsigned long membacked, vm_flags;
	void *result;
	int ret;

	/* do the simple checks first */
	if (flags & MAP_FIXED || addr) {
		printk(KERN_DEBUG "%d: Can't do fixed-address/overlay mmap of RAM\n",
		       current->pid);
		return -EINVAL;
	}

	if ((flags & MAP_TYPE) != MAP_PRIVATE &&
	    (flags & MAP_TYPE) != MAP_SHARED)
		return -EINVAL;

	if (PAGE_ALIGN(len) == 0)
		return addr;

	if (len > TASK_SIZE)
		return -EINVAL;

	/* offset overflow? */
	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
		return -EINVAL;

	if (file) {
		/* validate file mapping requests */
		struct address_space *mapping;

		/* files must support mmap */
		if (!file->f_op || !file->f_op->mmap)
			return -ENODEV;

		/* work out if what we've got could possibly be shared
		 * - we support chardevs that provide their own "memory"
		 * - we support files/blockdevs that are memory backed
		 */
		mapping = file->f_mapping;
		if (!mapping)
			mapping = file->f_dentry->d_inode->i_mapping;

		membacked = 0;
		if (mapping && mapping->backing_dev_info)
			membacked = mapping->backing_dev_info->memory_backed;
		else if (S_ISCHR(file->f_dentry->d_inode->i_mode))
			membacked = BDI_MEMORY_BACKED | BDI_CAN_MAP_DIRECT;

		if (!membacked) {
			if (S_ISREG(file->f_dentry->d_inode->i_mode) ||
			    S_ISBLK(file->f_dentry->d_inode->i_mode))
				membacked = BDI_CAN_MAP_COPY;
		}

		/* can't map directly unless the driver or filesystem is
		 * willing to tell us where and can't copy and map if we can't
		 * read it
		 */
		if (!file->f_op->get_unmapped_area)
			membacked &= ~BDI_CAN_MAP_DIRECT;
		if (!file->f_op->read)
			membacked &= ~BDI_CAN_MAP_COPY;

		if (flags & MAP_SHARED) {
			/* do checks for writing, appending and locking */
			if ((prot & PROT_WRITE) &&
			    !(file->f_mode & FMODE_WRITE))
				return -EACCES;

			if (IS_APPEND(file->f_dentry->d_inode) &&
			    (file->f_mode & FMODE_WRITE))
				return -EACCES;

			if (locks_verify_locked(file->f_dentry->d_inode))
				return -EAGAIN;

			if (!(membacked & BDI_CAN_MAP_DIRECT))
				return -ENODEV;

			if (((prot & PROT_READ)  && !(membacked & BDI_CAN_READ_MAP))  ||
			    ((prot & PROT_WRITE) && !(membacked & BDI_CAN_WRITE_MAP)) ||
			    ((prot & PROT_EXEC)  && !(membacked & BDI_CAN_EXEC_MAP))
			    ) {
				printk("MAP_SHARED not completely supported on !MMU\n");
				return -EINVAL;
			}

			/* we mustn't privatise shared mappings */
			membacked &= ~BDI_CAN_MAP_COPY;
		}
		else {
			/* we're going to read the file into private memory we
			 * allocate */
			if (!(membacked & BDI_CAN_MAP_COPY))
				return -ENODEV;

			/* we don't permit a private writable mapping to be
			 * shared */
			if (prot & PROT_WRITE)
				membacked &= ~BDI_CAN_MAP_DIRECT;
		}

		/* handle executable mappings and implied executable
		 * mappings */
		if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC) {
			if (prot & PROT_EXEC)
				return -EPERM;
		}
		else if ((prot & PROT_READ) && !(prot & PROT_EXEC)) {
			/* handle implication of PROT_EXEC by PROT_READ */
			if (current->personality & READ_IMPLIES_EXEC) {
				if (membacked & BDI_CAN_EXEC_MAP)
					prot |= PROT_EXEC;
			}
		}
		else if ((prot & PROT_READ) &&
			 (prot & PROT_EXEC) &&
			 !(membacked & BDI_CAN_EXEC_MAP)
			 ) {
			/* backing file is not executable, try to copy */
			membacked &= ~BDI_CAN_MAP_DIRECT;
		}
	}
	else {
		/* anonymous mappings are always memory backed and can be
		 * privately mapped
		 */
		membacked = BDI_MEMORY_BACKED | BDI_CAN_MAP_COPY;

		/* handle PROT_EXEC implication by PROT_READ */
		if ((prot & PROT_READ) &&
		    (current->personality & READ_IMPLIES_EXEC))
			prot |= PROT_EXEC;
	}

	/* translate what we now know into VMA flags */
	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags);
	vm_flags |= VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
	/* vm_flags |= mm->def_flags; */

	if (!(membacked & BDI_CAN_MAP_DIRECT)) {
		/* attempt to share any file segment that's mapped read-only */
		if (file && !(prot & PROT_WRITE))
			vm_flags |= VM_MAYSHARE;
	}
	else {
		/* overlay a shareable mapping on the backing device or inode
		 * if possible - used for chardevs and ramfs/tmpfs/shmfs */
		if (flags & MAP_SHARED)
			vm_flags |= VM_MAYSHARE | VM_SHARED;
		else if ((((vm_flags & membacked) ^ vm_flags) & BDI_MEMBACK_VMFLAGS) == 0)
			vm_flags |= VM_MAYSHARE;
	}

	/* refuse to let anyone share private mappings with this process if
	 * it's being traced - otherwise breakpoints set in it may interfere
	 * with another untraced process
	 */
	if ((flags & MAP_PRIVATE) && (current->ptrace & PT_PTRACED))
		vm_flags &= ~VM_MAYSHARE;

	/* allow the security API to have its say */
	ret = security_file_mmap(file, prot, flags);
	if (ret)
		return ret;

	/* we're going to need to record the mapping if it works */
	vml = kmalloc(sizeof(struct vm_list_struct), GFP_KERNEL);
	if (!vml)
		goto error_getting_vml;
	memset(vml, 0, sizeof(*vml));

	down_write(&nommu_vma_sem);

	/* if we want to share, we need to check for VMAs created by other
	 * mmap() calls that overlap with our proposed mapping
	 * - we can only share with an exact match on most regular files
	 * - shared mappings on character devices and memory backed files are
	 *   permitted to overlap inexactly as far as we are concerned for in
	 *   these cases, sharing is handled in the driver or filesystem rather
	 *   than here
	 */
	if (vm_flags & VM_MAYSHARE) {
		unsigned long pglen = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
		unsigned long vmpglen;

		for (rb = rb_first(&nommu_vma_tree); rb; rb = rb_next(rb)) {
			vma = rb_entry(rb, struct vm_area_struct, vm_rb);

			if (!(vma->vm_flags & VM_MAYSHARE))
				continue;

			/* search for overlapping mappings on the same file */
			if (vma->vm_file->f_dentry->d_inode != file->f_dentry->d_inode)
				continue;

			if (vma->vm_pgoff >= pgoff + pglen)
				continue;

			vmpglen = (vma->vm_end - vma->vm_start + PAGE_SIZE - 1) >> PAGE_SHIFT;
			if (pgoff >= vma->vm_pgoff + vmpglen)
				continue;

			/* handle inexact matches between mappings */
			if (vmpglen != pglen || vma->vm_pgoff != pgoff) {
				if (!membacked)
					goto sharing_violation;
				continue;
			}

			/* we've found a VMA we can share */
			atomic_inc(&vma->vm_usage);

			vml->vma = vma;
			result = (void *) vma->vm_start;
			goto shared;
		}
	}

	vma = NULL;

	/* obtain the address to map to - we verify (or select) it and ensure
	 * that it represents a valid section of the address space
	 * - this is the hook for quasi-memory character devices to tell us
	 *   the location of a shared mapping
	 */
	if (file && file->f_op->get_unmapped_area) {
		addr = file->f_op->get_unmapped_area(file, addr, len, pgoff,
						     flags);
		if (IS_ERR((void *) addr)) {
			ret = addr;
			if (ret == (unsigned long) -ENOSYS)
				ret = (unsigned long) -ENODEV;
			goto error;
		}
	}

	/* we're going to need a VMA struct as well */
	vma = kmalloc(sizeof(struct vm_area_struct), GFP_KERNEL);
	if (!vma)
		goto error_getting_vma;

	memset(vma, 0, sizeof(*vma));
	INIT_LIST_HEAD(&vma->anon_vma_node);
	atomic_set(&vma->vm_usage, 1);
	if (file)
		get_file(file);
	vma->vm_file	= file;
	vma->vm_flags	= vm_flags;
	vma->vm_start	= addr;
	vma->vm_end	= addr + len;
	vma->vm_pgoff	= pgoff;

	vml->vma = vma;

	/* invoke the mapping routine on a file */
	if (file) {
		ret = file->f_op->mmap(file, vma);

#ifdef DEBUG
		printk("f_op->mmap() returned %d (st=%lx)\n",
		       ret, vma->vm_start);
#endif
		result = (void *) vma->vm_start;
		if (!ret)
			goto done;
		else if (ret != -ENOSYS)
			goto error;

		/* getting an ENOSYS error indicates that direct mmap isn't
		 * possible (as opposed to tried but failed) so we'll fall
		 * through to making a private copy of the data and mapping
		 * that if we can */
		ret = -ENODEV;
		if (vma->vm_flags & VM_SHARED)
			goto error;

		/* quick check that we're allowed to read for a private
		 * mapping */
		if (!(membacked & BDI_CAN_MAP_COPY))
			goto error;
	}

	/* allocate some memory to hold the mapping
	 * - note that this may not return a page-aligned address if the object
	 *   we're allocating is smaller than a page
	 */
	ret = -ENOMEM;
	result = kmalloc(len, GFP_KERNEL);
	if (!result) {
		printk("Allocation of length %lu from process %d failed\n",
		       len, current->pid);
		show_free_areas();
		goto error;
	}

	vma->vm_start = (unsigned long) result;
	vma->vm_end = vma->vm_start + len;

#ifdef WARN_ON_SLACK
	if (len + WARN_ON_SLACK <= kobjsize(result))
		printk("Allocation of %lu bytes from process %d has %lu bytes of slack\n",
		       len, current->pid, kobjsize(result) - len);
#endif

	if (file) {
		mm_segment_t old_fs = get_fs();
		loff_t fpos;

		fpos = pgoff;
		fpos <<= PAGE_SHIFT;

		set_fs(KERNEL_DS);
		ret = file->f_op->read(file, (char *) result, len, &fpos);
		set_fs(old_fs);

		if (ret < 0)
			goto error2;
		if (ret < len)
			memset(result + ret, 0, len - ret);
	} else {
		memset(result, 0, len);
	}

 done:
	if (!(vma->vm_flags & VM_SHARED)) {
		realalloc += kobjsize(result);
		askedalloc += len;
	}

	realalloc += kobjsize(vma);
	askedalloc += sizeof(*vma);

	current->mm->total_vm += len >> PAGE_SHIFT;

	add_nommu_vma(vma);
 shared:
	realalloc += kobjsize(vml);
	askedalloc += sizeof(*vml);

	vml->next = current->mm->context.vmlist;
	current->mm->context.vmlist = vml;

	up_write(&nommu_vma_sem);

	if (prot & PROT_EXEC)
		flush_icache_range((unsigned long) result,
				   (unsigned long) result + len);

#ifdef DEBUG
	printk("do_mmap:\n");
	show_process_blocks();
#endif

	return (unsigned long) result;

 error2:
	kfree(result);
 error:
	up_write(&nommu_vma_sem);
	kfree(vml);
	if (vma) {
		fput(vma->vm_file);
		kfree(vma);
	}
	return ret;

 sharing_violation:
	up_write(&nommu_vma_sem);
	printk("Attempt to share mismatched mappings\n");
	kfree(vml);
	return -EINVAL;

 error_getting_vma:
	up_write(&nommu_vma_sem);
	kfree(vml);
	printk("Allocation of vml for %lu byte allocation from process %d failed\n",
	       len, current->pid);
	show_free_areas();
	return -ENOMEM;

 error_getting_vml:
	printk("Allocation of vml for %lu byte allocation from process %d failed\n",
	       len, current->pid);
	show_free_areas();
	return -ENOMEM;
}
