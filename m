Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTFVSMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTFVSMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:12:08 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27796 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S264897AbTFVSMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:12:02 -0400
Date: Sun, 22 Jun 2003 19:27:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] page cache readahead implemented?
Message-ID: <Pine.LNX.4.44.0306221922110.5241-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_mmap_pgoff's PROT_EXEC do_page_cache_readahead assumes that is
implemented for all mappings, but not all filesystems provide ->readpage.
madvise_willneed (in mainline 2.5.72) makes the same assumption.

They don't reach oops because fault needs down_read on mmap_sem,
already held down_write; ps hangs, others may hang waiting for page lock.

Add page_cache_readahead_implemented, also testing for ->readpages,
since read_pages would also work on an a_ops with just ->readpages.

--- 2.5.72-mm3/include/linux/mm.h	Sun Jun 22 11:51:40 2003
+++ linux/include/linux/mm.h	Sun Jun 22 17:16:05 2003
@@ -568,6 +568,7 @@
 #define VM_MAX_READAHEAD	128	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 
+int page_cache_readahead_implemented(struct address_space *mapping);
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			unsigned long offset, unsigned long nr_to_read);
 void page_cache_readahead(struct address_space *mapping, 
--- 2.5.72-mm3/mm/fadvise.c	Tue Apr 22 16:27:50 2003
+++ linux/mm/fadvise.c	Sun Jun 22 17:16:05 2003
@@ -52,7 +52,7 @@
 		break;
 	case POSIX_FADV_WILLNEED:
 	case POSIX_FADV_NOREUSE:
-		if (!mapping->a_ops->readpage) {
+		if (!page_cache_readahead_implemented(mapping)) {
 			ret = -EINVAL;
 			break;
 		}
--- 2.5.72-mm3/mm/filemap.c	Sun Jun 22 11:51:40 2003
+++ linux/mm/filemap.c	Sun Jun 22 17:16:05 2003
@@ -936,17 +936,6 @@
 	return desc.error;
 }
 
-static ssize_t
-do_readahead(struct address_space *mapping, struct file *filp,
-	     unsigned long index, unsigned long nr)
-{
-	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
-		return -EINVAL;
-
-	do_page_cache_readahead(mapping, filp, index, max_sane_readahead(nr));
-	return 0;
-}
-
 asmlinkage ssize_t sys_readahead(int fd, loff_t offset, size_t count)
 {
 	ssize_t ret;
@@ -960,7 +949,13 @@
 			unsigned long start = offset >> PAGE_CACHE_SHIFT;
 			unsigned long end = (offset + count - 1) >> PAGE_CACHE_SHIFT;
 			unsigned long len = end - start + 1;
-			ret = do_readahead(mapping, file, start, len);
+
+			if (page_cache_readahead_implemented(mapping)) {
+				do_page_cache_readahead(mapping, file, start,
+						max_sane_readahead(len));
+				ret = 0;
+			} else
+				ret = -EINVAL;
 		}
 		fput(file);
 	}
--- 2.5.72-mm3/mm/madvise.c	Fri Dec 27 14:04:41 2002
+++ linux/mm/madvise.c	Sun Jun 22 17:16:05 2003
@@ -56,6 +56,7 @@
 			     unsigned long start, unsigned long end)
 {
 	struct file *file = vma->vm_file;
+	struct address_space *mapping;
 
 	if (!file)
 		return -EBADF;
@@ -65,8 +66,11 @@
 		end = vma->vm_end;
 	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 
-	do_page_cache_readahead(file->f_dentry->d_inode->i_mapping,
-			file, start, max_sane_readahead(end - start));
+	mapping = file->f_dentry->d_inode->i_mapping;
+	if (page_cache_readahead_implemented(mapping)) {
+		do_page_cache_readahead(mapping, file, start,
+					max_sane_readahead(end - start));
+	}
 	return 0;
 }
 
--- 2.5.72-mm3/mm/mmap.c	Sun Jun 22 11:51:40 2003
+++ linux/mm/mmap.c	Sun Jun 22 17:16:05 2003
@@ -749,7 +749,7 @@
 		 * that everything we want is in pagecache anyway.
 		 */
 		mapping = file->f_dentry->d_inode->i_mapping;
-		if (	mapping &&
+		if (	page_cache_readahead_implemented(mapping) &&
 			((len >> PAGE_CACHE_SHIFT) > mapping->nrpages) &&
 			(len < 8 * 1024 * 1024)) {
 			do_page_cache_readahead(mapping, file, pgoff,
--- 2.5.72-mm3/mm/readahead.c	Sun Jun 22 11:51:40 2003
+++ linux/mm/readahead.c	Sun Jun 22 17:16:05 2003
@@ -523,3 +523,13 @@
 	get_zone_counts(&active, &inactive, &free);
 	return min(nr, (inactive + free) / 2);
 }
+
+/*
+ * Check if page cache readahead is implemented on this mapping before
+ * calling do_page_cache_readahead (filemap can assume it's implemented).
+ */
+int page_cache_readahead_implemented(struct address_space *mapping)
+{
+	return mapping && mapping->a_ops &&
+		(mapping->a_ops->readpage || mapping->a_ops->readpages);
+}

