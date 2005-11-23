Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVKWTAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVKWTAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVKWTAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:00:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58064 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932184AbVKWTAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:00:11 -0500
Date: Wed, 23 Nov 2005 18:59:47 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, dalomar@serrasold.com
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 1/3] NOMMU: Provide shared-writable mmap support on ramfs
Message-Id: <dhowells1132772387@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes ramfs support shared-writable mmaps by:

 (1) Attempting to perform a contiguous block allocation to the requested size
     when truncate attempts to increase the file from zero size, such as
     happens when:

	fd = shm_open("/file/on/ramfs", ...):
	ftruncate(fd, size_requested);
	addr = mmap(NULL, subsize, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED,
		    fd, offset);

 (2) Permitting any shared-writable mapping over any contiguous set of extant
     pages. get_unmapped_area() will return the address into the actual ramfs
     pages. The mapping may start anywhere and be of any size, but may not go
     over the end of file. Multiple mappings may overlap in any way.

 (3) Not permitting a file to be shrunk if it would truncate any shared
     mappings (private mappings are copied).

Thus this patch provides support for POSIX shared memory on NOMMU kernels, with
certain limitations such as there being a large enough block of pages available
to support the allocation and it only working on directly mappable filesystems.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 shmem-ramfs-2615rc2.diff
 fs/ramfs/Makefile     |    4 
 fs/ramfs/file-mmu.c   |   57 +++++++++
 fs/ramfs/file-nommu.c |  294 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ramfs/inode.c      |   22 ---
 fs/ramfs/internal.h   |   15 ++
 include/linux/ramfs.h |   10 +
 6 files changed, 380 insertions(+), 22 deletions(-)

diff -uNrp linux-2.6.15-rc2-frv/fs/ramfs/file-mmu.c linux-2.6.15-rc2-frv-shmem/fs/ramfs/file-mmu.c
--- linux-2.6.15-rc2-frv/fs/ramfs/file-mmu.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/fs/ramfs/file-mmu.c	2005-11-23 16:00:57.000000000 +0000
@@ -0,0 +1,57 @@
+/* file-mmu.c: ramfs MMU-based file operations
+ *
+ * Resizable simple ram filesystem for Linux.
+ *
+ * Copyright (C) 2000 Linus Torvalds.
+ *               2000 Transmeta Corp.
+ *
+ * Usage limits added by David Gibson, Linuxcare Australia.
+ * This file is released under the GPL.
+ */
+
+/*
+ * NOTE! This filesystem is probably most useful
+ * not as a real filesystem, but as an example of
+ * how virtual filesystems can be written.
+ *
+ * It doesn't get much simpler than this. Consider
+ * that this file implements the full semantics of
+ * a POSIX-compliant read-write filesystem.
+ *
+ * Note in particular how the filesystem does not
+ * need to implement any data structures of its own
+ * to keep track of the virtual data: using the VFS
+ * caches is sufficient.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/ramfs.h>
+
+#include <asm/uaccess.h>
+#include "internal.h"
+
+struct address_space_operations ramfs_aops = {
+	.readpage	= simple_readpage,
+	.prepare_write	= simple_prepare_write,
+	.commit_write	= simple_commit_write
+};
+
+struct file_operations ramfs_file_operations = {
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+	.mmap		= generic_file_mmap,
+	.fsync		= simple_sync_file,
+	.sendfile	= generic_file_sendfile,
+	.llseek		= generic_file_llseek,
+};
+
+struct inode_operations ramfs_file_inode_operations = {
+	.getattr	= simple_getattr,
+};
diff -uNrp linux-2.6.15-rc2-frv/fs/ramfs/file-nommu.c linux-2.6.15-rc2-frv-shmem/fs/ramfs/file-nommu.c
--- linux-2.6.15-rc2-frv/fs/ramfs/file-nommu.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/fs/ramfs/file-nommu.c	2005-11-23 16:24:36.000000000 +0000
@@ -0,0 +1,294 @@
+/* file-nommu.c: no-MMU version of ramfs
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/ramfs.h>
+#include <linux/quotaops.h>
+#include <linux/pagevec.h>
+#include <linux/mman.h>
+
+#include <asm/uaccess.h>
+#include "internal.h"
+
+static int ramfs_nommu_setattr(struct dentry *, struct iattr *);
+
+struct address_space_operations ramfs_aops = {
+	.readpage		= simple_readpage,
+	.prepare_write		= simple_prepare_write,
+	.commit_write		= simple_commit_write
+};
+
+struct file_operations ramfs_file_operations = {
+	.mmap			= ramfs_nommu_mmap,
+	.get_unmapped_area	= ramfs_nommu_get_unmapped_area,
+	.read			= generic_file_read,
+	.write			= generic_file_write,
+	.fsync			= simple_sync_file,
+	.sendfile		= generic_file_sendfile,
+	.llseek			= generic_file_llseek,
+};
+
+struct inode_operations ramfs_file_inode_operations = {
+	.setattr		= ramfs_nommu_setattr,
+	.getattr		= simple_getattr,
+};
+
+/*****************************************************************************/
+/*
+ * add a contiguous set of pages into a ramfs inode when it's truncated from
+ * size 0 on the assumption that it's going to be used for an mmap of shared
+ * memory
+ */
+static int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
+{
+	struct pagevec lru_pvec;
+	unsigned long npages, xpages, loop, limit;
+	struct page *pages;
+	unsigned order;
+	void *data;
+	int ret;
+
+	/* make various checks */
+	order = get_order(newsize);
+	if (unlikely(order >= MAX_ORDER))
+		goto too_big;
+
+	limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
+	if (limit != RLIM_INFINITY && newsize > limit)
+		goto fsize_exceeded;
+
+	if (newsize > inode->i_sb->s_maxbytes)
+		goto too_big;
+
+	i_size_write(inode, newsize);
+
+	/* allocate enough contiguous pages to be able to satisfy the
+	 * request */
+	pages = alloc_pages(mapping_gfp_mask(inode->i_mapping), order);
+	if (!pages)
+		return -ENOMEM;
+
+	/* split the high-order page into an array of single pages */
+	xpages = 1UL << order;
+	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	for (loop = 0; loop < npages; loop++)
+		set_page_count(pages + loop, 1);
+
+	/* trim off any pages we don't actually require */
+	for (loop = npages; loop < xpages; loop++)
+		__free_page(pages + loop);
+
+	/* clear the memory we allocated */
+	newsize = PAGE_SIZE * npages;
+	data = page_address(pages);
+	memset(data, 0, newsize);
+
+	/* attach all the pages to the inode's address space */
+	pagevec_init(&lru_pvec, 0);
+	for (loop = 0; loop < npages; loop++) {
+		struct page *page = pages + loop;
+
+		ret = add_to_page_cache(page, inode->i_mapping, loop, GFP_KERNEL);
+		if (ret < 0)
+			goto add_error;
+
+		if (!pagevec_add(&lru_pvec, page))
+			__pagevec_lru_add(&lru_pvec);
+
+		unlock_page(page);
+	}
+
+	pagevec_lru_add(&lru_pvec);
+	return 0;
+
+ fsize_exceeded:
+	send_sig(SIGXFSZ, current, 0);
+ too_big:
+	return -EFBIG;
+
+ add_error:
+	page_cache_release(pages + loop);
+	for (loop++; loop < npages; loop++)
+		__free_page(pages + loop);
+	return ret;
+}
+
+/*****************************************************************************/
+/*
+ * check that file shrinkage doesn't leave any VMAs dangling in midair
+ */
+static int ramfs_nommu_check_mappings(struct inode *inode,
+				      size_t newsize, size_t size)
+{
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+
+	/* search for VMAs that fall within the dead zone */
+	vma_prio_tree_foreach(vma, &iter, &inode->i_mapping->i_mmap,
+			      newsize >> PAGE_SHIFT,
+			      (size + PAGE_SIZE - 1) >> PAGE_SHIFT
+			      ) {
+		/* found one - only interested if it's shared out of the page
+		 * cache */
+		if (vma->vm_flags & VM_SHARED)
+			return -ETXTBSY; /* not quite true, but near enough */
+	}
+
+	return 0;
+}
+
+/*****************************************************************************/
+/*
+ *
+ */
+static int ramfs_nommu_resize(struct inode *inode, loff_t newsize, loff_t size)
+{
+	int ret;
+
+	/* assume a truncate from zero size is going to be for the purposes of
+	 * shared mmap */
+	if (size == 0) {
+		if (unlikely(newsize >> 32))
+			return -EFBIG;
+
+		return ramfs_nommu_expand_for_mapping(inode, newsize);
+	}
+
+	/* check that a decrease in size doesn't cut off any shared mappings */
+	if (newsize < size) {
+		ret = ramfs_nommu_check_mappings(inode, newsize, size);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = vmtruncate(inode, size);
+
+	return ret;
+}
+
+/*****************************************************************************/
+/*
+ * handle a change of attributes
+ * - we're specifically interested in a change of size
+ */
+static int ramfs_nommu_setattr(struct dentry *dentry, struct iattr *ia)
+{
+	struct inode *inode = dentry->d_inode;
+	unsigned int old_ia_valid = ia->ia_valid;
+	int ret = 0;
+
+	/* by providing our own setattr() method, we skip this quotaism */
+	if ((old_ia_valid & ATTR_UID && ia->ia_uid != inode->i_uid) ||
+	    (old_ia_valid & ATTR_GID && ia->ia_gid != inode->i_gid))
+		ret = DQUOT_TRANSFER(inode, ia) ? -EDQUOT : 0;
+
+	/* pick out size-changing events */
+	if (ia->ia_valid & ATTR_SIZE) {
+		loff_t size = i_size_read(inode);
+		if (ia->ia_size != size) {
+			ret = ramfs_nommu_resize(inode, ia->ia_size, size);
+			if (ret < 0 || ia->ia_valid == ATTR_SIZE)
+				goto out;
+		} else {
+			/* we skipped the truncate but must still update
+			 * timestamps
+			 */
+			ia->ia_valid |= ATTR_MTIME|ATTR_CTIME;
+		}
+	}
+
+	ret = inode_setattr(inode, ia);
+ out:
+	ia->ia_valid = old_ia_valid;
+	return ret;
+}
+
+/*****************************************************************************/
+/*
+ * try to determine where a shared mapping can be made
+ * - we require that:
+ *   - the pages to be mapped must exist
+ *   - the pages be physically contiguous in sequence
+ */
+unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
+					    unsigned long addr, unsigned long len,
+					    unsigned long pgoff, unsigned long flags)
+{
+	unsigned long maxpages, lpages, nr, loop, ret;
+	struct inode *inode = file->f_dentry->d_inode;
+	struct page **pages = NULL, **ptr, *page;
+	loff_t isize;
+
+	if (!(flags & MAP_SHARED))
+		return addr;
+
+	/* the mapping mustn't extend beyond the EOF */
+	lpages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	isize = i_size_read(inode);
+
+	ret = -EINVAL;
+	maxpages = (isize + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (pgoff >= maxpages)
+		goto out;
+
+	if (maxpages - pgoff < lpages)
+		goto out;
+
+	/* gang-find the pages */
+	ret = -ENOMEM;
+	pages = kmalloc(lpages * sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		goto out;
+
+	memset(pages, 0, lpages * sizeof(struct page *));
+
+	nr = find_get_pages(inode->i_mapping, pgoff, lpages, pages);
+	if (nr != lpages)
+		goto out; /* leave if some pages were missing */
+
+	/* check the pages for physical adjacency */
+	ptr = pages;
+	page = *ptr++;
+	page++;
+	for (loop = lpages; loop > 1; loop--)
+		if (*ptr++ != page++)
+			goto out;
+
+	/* okay - all conditions fulfilled */
+	ret = (unsigned long) page_address(pages[0]);
+
+ out:
+	if (pages) {
+		ptr = pages;
+		for (loop = lpages; loop > 0; loop--)
+			put_page(*ptr++);
+		kfree(pages);
+	}
+
+	return ret;
+}
+
+/*****************************************************************************/
+/*
+ * set up a mapping
+ */
+int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return 0;
+}
diff -uNrp linux-2.6.15-rc2-frv/fs/ramfs/inode.c linux-2.6.15-rc2-frv-shmem/fs/ramfs/inode.c
--- linux-2.6.15-rc2-frv/fs/ramfs/inode.c	2005-06-22 13:52:17.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/fs/ramfs/inode.c	2005-11-23 16:00:57.000000000 +0000
@@ -34,13 +34,12 @@
 #include <linux/ramfs.h>
 
 #include <asm/uaccess.h>
+#include "internal.h"
 
 /* some random number */
 #define RAMFS_MAGIC	0x858458f6
 
 static struct super_operations ramfs_ops;
-static struct address_space_operations ramfs_aops;
-static struct inode_operations ramfs_file_inode_operations;
 static struct inode_operations ramfs_dir_inode_operations;
 
 static struct backing_dev_info ramfs_backing_dev_info = {
@@ -142,25 +141,6 @@ static int ramfs_symlink(struct inode * 
 	return error;
 }
 
-static struct address_space_operations ramfs_aops = {
-	.readpage	= simple_readpage,
-	.prepare_write	= simple_prepare_write,
-	.commit_write	= simple_commit_write
-};
-
-struct file_operations ramfs_file_operations = {
-	.read		= generic_file_read,
-	.write		= generic_file_write,
-	.mmap		= generic_file_mmap,
-	.fsync		= simple_sync_file,
-	.sendfile	= generic_file_sendfile,
-	.llseek		= generic_file_llseek,
-};
-
-static struct inode_operations ramfs_file_inode_operations = {
-	.getattr	= simple_getattr,
-};
-
 static struct inode_operations ramfs_dir_inode_operations = {
 	.create		= ramfs_create,
 	.lookup		= simple_lookup,
diff -uNrp linux-2.6.15-rc2-frv/fs/ramfs/internal.h linux-2.6.15-rc2-frv-shmem/fs/ramfs/internal.h
--- linux-2.6.15-rc2-frv/fs/ramfs/internal.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/fs/ramfs/internal.h	2005-11-23 16:25:37.000000000 +0000
@@ -0,0 +1,15 @@
+/* internal.h: ramfs internal definitions
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+extern struct address_space_operations ramfs_aops;
+extern struct file_operations ramfs_file_operations;
+extern struct inode_operations ramfs_file_inode_operations;
diff -uNrp linux-2.6.15-rc2-frv/fs/ramfs/Makefile linux-2.6.15-rc2-frv-shmem/fs/ramfs/Makefile
--- linux-2.6.15-rc2-frv/fs/ramfs/Makefile	2004-06-18 13:41:28.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/fs/ramfs/Makefile	2005-11-23 16:00:57.000000000 +0000
@@ -4,4 +4,6 @@
 
 obj-$(CONFIG_RAMFS) += ramfs.o
 
-ramfs-objs := inode.o
+file-mmu-y := file-nommu.o
+file-mmu-$(CONFIG_MMU) := file-mmu.o
+ramfs-objs += inode.o $(file-mmu-y)
diff -uNrp linux-2.6.15-rc2-frv/include/linux/ramfs.h linux-2.6.15-rc2-frv-shmem/include/linux/ramfs.h
--- linux-2.6.15-rc2-frv/include/linux/ramfs.h	2004-10-19 10:42:17.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/include/linux/ramfs.h	2005-11-23 16:00:57.000000000 +0000
@@ -5,6 +5,16 @@ struct inode *ramfs_get_inode(struct sup
 struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
 	 int flags, const char *dev_name, void *data);
 
+#ifndef CONFIG_MMU
+extern unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
+						   unsigned long addr,
+						   unsigned long len,
+						   unsigned long pgoff,
+						   unsigned long flags);
+
+extern int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma);
+#endif
+
 extern struct file_operations ramfs_file_operations;
 extern struct vm_operations_struct generic_file_vm_ops;
 
