Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJQXsY>; Thu, 17 Oct 2002 19:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262356AbSJQXsX>; Thu, 17 Oct 2002 19:48:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50511 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262322AbSJQXsP>; Thu, 17 Oct 2002 19:48:15 -0400
Date: Fri, 18 Oct 2002 00:55:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 5/9 shmem_file_sendfile
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180053100.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added shmem_file_sendfile to allow sendfile from tmpfs.  Checked
do_shmem_file_read and shmem_file_read against filemap equivalents
to add in any recent fixes (-EINVAL when count < 0 was missing).

--- tmpfs4/include/linux/fs.h	Wed Oct 16 06:31:04 2002
+++ tmpfs5/include/linux/fs.h	Thu Oct 17 22:01:29 2002
@@ -1242,6 +1242,7 @@
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
+extern int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t generic_file_aio_read(struct kiocb *, char *, size_t, loff_t);
--- tmpfs4/mm/filemap.c	Wed Oct 16 06:31:04 2002
+++ tmpfs5/mm/filemap.c	Thu Oct 17 22:01:29 2002
@@ -906,7 +906,7 @@
 	return ret;
 }
 
-static int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	ssize_t written;
 	unsigned long count = desc->count;
--- tmpfs4/mm/shmem.c	Thu Oct 17 22:01:19 2002
+++ tmpfs5/mm/shmem.c	Thu Oct 17 22:01:29 2002
@@ -1136,19 +1136,18 @@
 	goto release;
 }
 
-static void do_shmem_file_read(struct file *filp, loff_t *ppos, read_descriptor_t *desc)
+static void do_shmem_file_read(struct file *filp, loff_t *ppos, read_descriptor_t *desc, read_actor_t actor)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
 	unsigned long index, offset;
-	int nr = 1;
 
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
-	while (nr && desc->count) {
+	for (;;) {
 		struct page *page;
-		unsigned long end_index, nr;
+		unsigned long end_index, nr, ret;
 
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 		if (index > end_index)
@@ -1181,6 +1180,10 @@
 		}
 		nr -= offset;
 
+		/* If users can be writing to this page using arbitrary
+		 * virtual addresses, take care about potential aliasing
+		 * before reading the page on the kernel side.
+		 */
 		if (!list_empty(&mapping->i_mmap_shared) &&
 		    page != ZERO_PAGE(0))
 			flush_dcache_page(page);
@@ -1195,12 +1198,14 @@
 		 * "pos" here (the actor routine has to update the user buffer
 		 * pointers and the remaining count).
 		 */
-		nr = file_read_actor(desc, page, offset, nr);
-		offset += nr;
+		ret = actor(desc, page, offset, nr);
+		offset += ret;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
 		page_cache_release(page);
+		if (ret != nr || !desc->count)
+			break;
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
@@ -1209,27 +1214,43 @@
 
 static ssize_t shmem_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
-	ssize_t retval;
+	read_descriptor_t desc;
 
-	retval = -EFAULT;
-	if (access_ok(VERIFY_WRITE, buf, count)) {
-		retval = 0;
-
-		if (count) {
-			read_descriptor_t desc;
-
-			desc.written = 0;
-			desc.count = count;
-			desc.buf = buf;
-			desc.error = 0;
-			do_shmem_file_read(filp, ppos, &desc);
-
-			retval = desc.written;
-			if (!retval)
-				retval = desc.error;
-		}
-	}
-	return retval;
+	if ((ssize_t) count < 0)
+		return -EINVAL;
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
+	if (!count)
+		return 0;
+
+	desc.written = 0;
+	desc.count = count;
+	desc.buf = buf;
+	desc.error = 0;
+
+	do_shmem_file_read(filp, ppos, &desc, file_read_actor);
+	if (desc.written)
+		return desc.written;
+	return desc.error;
+}
+
+static ssize_t shmem_file_sendfile(struct file *out_file,
+	struct file *in_file, loff_t *ppos, size_t count)
+{
+	read_descriptor_t desc;
+
+	if (!count)
+		return 0;
+
+	desc.written = 0;
+	desc.count = count;
+	desc.buf = (char *)out_file;
+	desc.error = 0;
+
+	do_shmem_file_read(in_file, ppos, &desc, file_send_actor);
+	if (desc.written)
+		return desc.written;
+	return desc.error;
 }
 
 static int shmem_statfs(struct super_block *sb, struct statfs *buf)
@@ -1649,6 +1670,7 @@
 	.read		= shmem_file_read,
 	.write		= shmem_file_write,
 	.fsync		= simple_sync_file,
+	.sendfile	= shmem_file_sendfile,
 #endif
 };
 

