Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVEKO56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVEKO56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEKO54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:57:56 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:16806 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261234AbVEKOaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:30:19 -0400
Message-ID: <428216F7.30303@de.ibm.com>
Date: Wed, 11 May 2005 16:30:15 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cotte@freenet.de
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: [RFC/PATCH 2/5] mm/fs: add execute in place support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 2/5] mm/fs: add execute in place support
This patch is the biggest chunk in the patchset. It adds a new address
space operation called get_xip_page, which works similar to
readpage/writepage but returns a reference to a struct page for the
on-disk data for the given page. The page is supposed to be up-to-date.
In mm/filemap.c, all generic implementations of file operations are
extended to work with the new address space operation if provided.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
diff -ruN linux-2.6-git/fs/open.c linux-2.6-git-xip/fs/open.c
--- linux-2.6-git/fs/open.c	2005-05-10 14:55:18.000000000 +0200
+++ linux-2.6-git-xip/fs/open.c	2005-05-10 14:57:41.720496744 +0200
@@ -807,7 +807,9 @@

 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO) {
+		if (!f->f_mapping->a_ops ||
+		    ((!f->f_mapping->a_ops->direct_IO) &&
+		    (!f->f_mapping->a_ops->get_xip_page))) {
 			fput(f);
 			f = ERR_PTR(-EINVAL);
 		}
diff -ruN linux-2.6-git/include/linux/fs.h linux-2.6-git-xip/include/linux/fs.h
--- linux-2.6-git/include/linux/fs.h	2005-05-10 14:57:29.689325760 +0200
+++ linux-2.6-git-xip/include/linux/fs.h	2005-05-10 14:57:41.724496136 +0200
@@ -330,6 +330,8 @@
 	int (*releasepage) (struct page *, int);
 	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
+	struct page* (*get_xip_page)(struct address_space *, sector_t,
+			int);
 };

 struct backing_dev_info;
@@ -1473,14 +1475,19 @@
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
+extern ssize_t generic_file_xip_write(struct kiocb *, const struct iovec *,
+		unsigned long, loff_t, loff_t *, size_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 extern void do_generic_mapping_read(struct address_space *mapping,
-				    struct file_ra_state *, struct file *,
-				    loff_t *, read_descriptor_t *, read_actor_t);
+				   struct file_ra_state *, struct file *,
+				   loff_t *, read_descriptor_t *, read_actor_t);
+extern void do_xip_mapping_read   (struct address_space *mapping,
+				   struct file_ra_state *, struct file *,
+				   loff_t *, read_descriptor_t *, read_actor_t);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
@@ -1494,17 +1501,26 @@
 extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 extern int nonseekable_open(struct inode * inode, struct file * filp);
+extern int xip_truncate_page(struct address_space *mapping, loff_t from);

 static inline void do_generic_file_read(struct file * filp, loff_t *ppos,
 					read_descriptor_t * desc,
 					read_actor_t actor)
 {
-	do_generic_mapping_read(filp->f_mapping,
-				&filp->f_ra,
-				filp,
-				ppos,
-				desc,
-				actor);
+	if (filp->f_mapping->a_ops->get_xip_page)
+		do_xip_mapping_read(filp->f_mapping,
+					&filp->f_ra,
+					filp,
+					ppos,
+					desc,
+					actor);
+	else
+		do_generic_mapping_read(filp->f_mapping,
+					&filp->f_ra,
+					filp,
+					ppos,
+					desc,
+					actor);
 }

 ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
diff -ruN linux-2.6-git/mm/filemap.c linux-2.6-git-xip/mm/filemap.c
--- linux-2.6-git/mm/filemap.c	2005-05-10 14:55:24.000000000 +0200
+++ linux-2.6-git-xip/mm/filemap.c	2005-05-10 15:09:59.416349928 +0200
@@ -2,6 +2,9 @@
  *	linux/mm/filemap.c
  *
  * Copyright (C) 1994-1999  Linus Torvalds
+ *
+ * xip functionality added by Carsten Otte <cotte@de.ibm.com>,
+ *	Copyright 2005 IBM Corporation
  */

 /*
@@ -918,6 +921,105 @@

 EXPORT_SYMBOL(do_generic_mapping_read);

+/*
+ * This is a generic file read routine for execute in place files, and uses
+ * the mapping->a_ops->get_xip_page() function for the actual low-level
+ * stuff.
+ *
+ * Note the struct file* is not used at all.  It may be NULL.
+ */
+void do_xip_mapping_read(struct address_space *mapping,
+			     struct file_ra_state *_ra,
+			     struct file *filp,
+			     loff_t *ppos,
+			     read_descriptor_t *desc,
+			     read_actor_t actor)
+{
+	struct inode *inode = mapping->host;
+	unsigned long index, end_index, offset;
+	loff_t isize;
+
+	BUG_ON(!mapping->a_ops->get_xip_page);
+
+	index = *ppos >> PAGE_CACHE_SHIFT;
+	offset = *ppos & ~PAGE_CACHE_MASK;
+
+	isize = i_size_read(inode);
+	if (!isize)
+		goto out;
+
+	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
+	for (;;) {
+		struct page *page;
+		unsigned long nr, ret;
+
+		/* nr is the maximum number of bytes to copy from this page */
+		nr = PAGE_CACHE_SIZE;
+		if (index >= end_index) {
+			if (index > end_index)
+				goto out;
+			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
+			if (nr <= offset) {
+				goto out;
+			}
+		}
+		nr = nr - offset;
+
+		page = mapping->a_ops->get_xip_page(mapping,
+			index*(PAGE_SIZE/512), 0);
+		if (!page)
+			goto no_xip_page;
+		if (unlikely(IS_ERR(page))) {
+			if (PTR_ERR(page) == -ENODATA) {
+				/* sparse */
+				page = virt_to_page(empty_zero_page);
+			} else {
+				desc->error = PTR_ERR(page);
+				goto out;
+			}
+		} else
+			BUG_ON(!PageUptodate(page));
+
+		/* If users can be writing to this page using arbitrary
+		 * virtual addresses, take care about potential aliasing
+		 * before reading the page on the kernel side.
+		 */
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
+		/*
+		 * Ok, we have the page, and it's up-to-date, so
+		 * now we can copy it to user space...
+		 *
+		 * The actor routine returns how many bytes were actually used..
+		 * NOTE! This may not be the same as how much of a user buffer
+		 * we filled up (we may be padding etc), so we can only update
+		 * "pos" here (the actor routine has to update the user buffer
+		 * pointers and the remaining count).
+		 */
+		ret = actor(desc, page, offset, nr);
+		offset += ret;
+		index += offset >> PAGE_CACHE_SHIFT;
+		offset &= ~PAGE_CACHE_MASK;
+
+		if (ret == nr && desc->count)
+			continue;
+		goto out;
+
+no_xip_page:
+		/* Did not get the page. Report it */
+		desc->error = -EIO;
+		goto out;
+	}
+
+out:
+	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
+	if (filp)
+		file_accessed(filp);
+}
+
+EXPORT_SYMBOL(do_xip_mapping_read);
+
 int file_read_actor(read_descriptor_t *desc, struct page *page,
 			unsigned long offset, unsigned long size)
 {
@@ -968,6 +1070,7 @@
 	ssize_t retval;
 	unsigned long seg;
 	size_t count;
+	int xip = filp->f_mapping->a_ops->get_xip_page ? 1 : 0;

 	count = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
@@ -990,7 +1093,9 @@
 	}

 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
-	if (filp->f_flags & O_DIRECT) {
+	/* do not use generic_file_direct_IO on xip files, xip IO is
+	   implicitly direct as well */
+	if (filp->f_flags & O_DIRECT && !xip) {
 		loff_t pos = *ppos, size;
 		struct address_space *mapping;
 		struct inode *inode;
@@ -1110,6 +1215,9 @@
 do_readahead(struct address_space *mapping, struct file *filp,
 	     unsigned long index, unsigned long nr)
 {
+	if (mapping && mapping->a_ops && mapping->a_ops->get_xip_page)
+		return 0;
+
 	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
 		return -EINVAL;

@@ -1527,21 +1635,139 @@
 	return 0;
 }

+/*
+ * __filemap_xip_unmap is invoked from filemap_xip_unmap and
+ * generic_file_xip_write
+ *
+ * This function walks all vmas of the address_space and unmaps the
+ * empty_zero_page when found at pgoff. Should it go in rmap.c?
+ */
+static void __filemap_xip_unmap (struct address_space * mapping, unsigned long pgoff)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	struct prio_tree_iter iter;
+	unsigned long address;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t pteval;
+
+	spin_lock(&mapping->i_mmap_lock);
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
+		mm = vma->vm_mm;
+		address = vma->vm_start +
+			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+		BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+		/*
+		 * We need the page_table_lock to protect us from page faults,
+		 * munmap, fork, etc...
+		 */
+		spin_lock(&mm->page_table_lock);
+		pgd = pgd_offset(mm, address);
+		if (!pgd_present(*pgd))
+			goto next_unlock;
+		pud = pud_offset(pgd, address);
+		if (!pud_present(*pud))
+			goto next_unlock;
+		pmd = pmd_offset(pud, address);
+		if (!pmd_present(*pmd))
+			goto next_unlock;
+		
+		pte = pte_offset_map(pmd, address);
+		if (!pte_present(*pte))
+			goto next_unmap;
+		if ((page_to_pfn(virt_to_page(empty_zero_page)))
+			!= pte_pfn(*pte))
+			/* pte does already reference new xip block here */
+			goto next_unmap;
+		/* Nuke the page table entry. */
+		flush_cache_page(vma, address, pte_pfn(pte));
+		pteval = ptep_clear_flush(vma, address, pte);
+		BUG_ON(pte_dirty(pteval));
+	next_unmap:
+		pte_unmap(pte);
+	next_unlock:
+		spin_unlock(&mm->page_table_lock);
+	}
+	spin_unlock(&mapping->i_mmap_lock);
+}
+
+/*
+ * filemap_xip_nopage() is invoked via the vma operations vector for a
+ * mapped memory region to read in file data during a page fault.
+ *
+ * This function is derived from filemap_nopage, but used for execute in place
+ */
+struct page * filemap_xip_nopage(struct vm_area_struct * area, unsigned long address, int *type)
+{
+	struct file *file = area->vm_file;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	struct page *page;
+	unsigned long size, pgoff, endoff;
+
+	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT)
+		+ area->vm_pgoff;
+	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT)
+		+ area->vm_pgoff;
+
+	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (pgoff >= size) {
+		return NULL;
+	}
+
+	page = mapping->a_ops->get_xip_page(mapping, pgoff*(PAGE_SIZE/512), 0);
+	if (!IS_ERR(page)) {
+		BUG_ON(!PageUptodate(page));
+		return page;
+	}
+	if (PTR_ERR(page) != -ENODATA)
+		return NULL;
+
+	/* sparse block */
+	if ((area->vm_flags & (VM_WRITE | VM_MAYWRITE)) &&
+	    (area->vm_flags & (VM_SHARED| VM_MAYSHARE)) &&
+	    (!(mapping->host->i_sb->s_flags & MS_RDONLY))) {
+		/* maybe shared writable, allocate new block */
+		page = mapping->a_ops->get_xip_page (mapping,
+			pgoff*(PAGE_SIZE/512), 1);
+		if (IS_ERR(page))
+			return NULL;
+		BUG_ON(!PageUptodate(page));
+		/* unmap page at pgoff from all other vmas */
+		__filemap_xip_unmap(mapping, pgoff);
+	} else {
+		/* not shared and writable, use empty_zero_page */
+		page = virt_to_page(empty_zero_page);
+	}
+
+	return page;
+};
+
 struct vm_operations_struct generic_file_vm_ops = {
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
 };

+struct vm_operations_struct xip_file_vm_ops = {
+	.nopage         = filemap_xip_nopage,
+};
+
 /* This is used for a general mmap of a disk file */

 int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
 	struct address_space *mapping = file->f_mapping;

-	if (!mapping->a_ops->readpage)
+	if ((!mapping->a_ops->readpage) && (!mapping->a_ops->get_xip_page))
 		return -ENOEXEC;
 	file_accessed(file);
-	vma->vm_ops = &generic_file_vm_ops;
+	if (unlikely(mapping->a_ops->get_xip_page))
+		vma->vm_ops = &xip_file_vm_ops;
+	else
+		vma->vm_ops = &generic_file_vm_ops;
 	return 0;
 }
 EXPORT_SYMBOL(filemap_populate);
@@ -2068,6 +2294,104 @@
 EXPORT_SYMBOL(generic_file_buffered_write);

 ssize_t
+generic_file_xip_write(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos, loff_t *ppos,
+		size_t count)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space * mapping = file->f_mapping;
+	struct address_space_operations *a_ops = mapping->a_ops;
+	struct inode 	*inode = mapping->host;
+	long		status = 0;
+	struct page	*page;
+	size_t		bytes;
+	const struct iovec *cur_iov = iov; /* current iovec */
+	size_t		iov_base = 0;	   /* offset in the current iovec */
+	char __user	*buf;
+	ssize_t		written = 0;
+
+	BUG_ON(!mapping->a_ops->get_xip_page);
+
+	buf = iov->iov_base;
+	do {
+		unsigned long index;
+		unsigned long offset;
+		size_t copied;
+
+		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
+		index = pos >> PAGE_CACHE_SHIFT;
+		bytes = PAGE_CACHE_SIZE - offset;
+		if (bytes > count)
+			bytes = count;
+
+		/*
+		 * Bring in the user page that we will copy from _first_.
+		 * Otherwise there's a nasty deadlock on copying from the
+		 * same page as we're writing to, without it being marked
+		 * up-to-date.
+		 */
+		fault_in_pages_readable(buf, bytes);
+
+		page = a_ops->get_xip_page(mapping,
+						    index*(PAGE_SIZE/512), 0);
+		if (IS_ERR(page) && (PTR_ERR(page) == -ENODATA)) {
+			/* we allocate a new page unmap it */
+			page = a_ops->get_xip_page(mapping,
+				index*(PAGE_SIZE/512), 1);
+			if (!IS_ERR(page))
+			/* unmap page at pgoff from all other vmas */
+			__filemap_xip_unmap(mapping, index);
+
+		}
+
+		if (IS_ERR(page)) {
+			status = PTR_ERR(page);
+			break;
+		}
+
+		BUG_ON(!PageUptodate(page));
+
+		if (likely(nr_segs == 1))
+			copied = filemap_copy_from_user(page, offset,
+							buf, bytes);
+		else
+			copied = filemap_copy_from_user_iovec(page, offset,
+						cur_iov, iov_base, bytes);
+		flush_dcache_page(page);
+		if (likely(copied > 0)) {
+			status = copied;
+
+			if (status >= 0) {
+				written += status;
+				count -= status;
+				pos += status;
+				buf += status;
+				if (unlikely(nr_segs > 1))
+					filemap_set_next_iovec(&cur_iov,
+							&iov_base, status);
+			}
+		}
+		if (unlikely(copied != bytes))
+			if (status >= 0)
+				status = -EFAULT;
+		if (status < 0)
+			break;
+	} while (count);
+	*ppos = pos;
+	/*
+	 * No need to use i_size_read() here, the i_size
+	 * cannot change under us because we hold i_sem.
+	 */
+	if (pos > inode->i_size) {
+		i_size_write(inode, pos);
+		mark_inode_dirty(inode);
+	}
+
+	return written ? written : status;
+}
+EXPORT_SYMBOL(generic_file_xip_write);
+
+ssize_t
 __generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
@@ -2123,6 +2447,13 @@

 	inode_update_time(inode, 1);

+	if (unlikely(file->f_mapping->a_ops->get_xip_page)) {
+		/* use execute in place to copy directly to disk */
+		written = generic_file_xip_write (iocb, iov,
+			        nr_segs, pos, ppos, count);
+		goto out;
+	}
+
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
 		written = generic_file_direct_write(iocb, iov,
@@ -2324,3 +2655,53 @@
 	return retval;
 }
 EXPORT_SYMBOL_GPL(generic_file_direct_IO);
+
+/*
+ * truncate a page used for execute in place
+ * functionality is analog to block_truncate_page but does use get_xip_page
+ * to get the page instead of page cache
+ */
+int xip_truncate_page(struct address_space *mapping, loff_t from)
+{
+	pgoff_t index = from >> PAGE_CACHE_SHIFT;
+	unsigned offset = from & (PAGE_CACHE_SIZE-1);
+	unsigned blocksize;
+	unsigned length;
+	struct page *page;
+	void *kaddr;
+	int err;
+
+	blocksize = 1 << mapping->host->i_blkbits;
+	length = offset & (blocksize - 1);
+
+	/* Block boundary? Nothing to do */
+	if (!length)
+		return 0;
+
+	length = blocksize - length;
+
+	page = mapping->a_ops->get_xip_page(mapping,
+					    index*(PAGE_SIZE/512), 0);
+	err = -ENOMEM;
+	if (!page)
+		goto out;
+	if (unlikely(IS_ERR(page))) {
+		if (PTR_ERR(page) == -ENODATA) {
+			/* Hole? No need to truncate */
+			return 0;
+		} else {
+			err = PTR_ERR(page);
+			goto out;
+		}
+	} else
+		BUG_ON(!PageUptodate(page));
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + offset, 0, length);
+	kunmap_atomic(kaddr, KM_USER0);
+
+	flush_dcache_page(page);
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL(xip_truncate_page);



