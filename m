Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVDDJnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDDJnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDDJnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:43:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9701 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261200AbVDDJlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:41:45 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <424DDADB.9080403@us.ibm.com> 
References: <424DDADB.9080403@us.ibm.com> 
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make page-becoming-writable notification a VMA-op only
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 04 Apr 2005 10:41:34 +0100
Message-ID: <5372.1112607694@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the page-becoming-writable notification a VMA
operation only - it removes the equivalent address-space operation and the
chaining of the call.

Furthermore, it fixes the kAFS filesystem to take account of this.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 cachefs-2612rc1mm3.diff 
 fs/afs/file.c      |   30 ++++++++++++++++++++++++++----
 include/linux/fs.h |    3 ---
 mm/filemap.c       |   19 +------------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff -uNr linux-2.6.12-rc1-mm3/fs/afs/file.c linux-2.6.12-rc1-mm3-cachefs/fs/afs/file.c
--- linux-2.6.12-rc1-mm3/fs/afs/file.c	2005-03-29 15:42:00.000000000 +0100
+++ linux-2.6.12-rc1-mm3-cachefs/fs/afs/file.c	2005-03-29 18:31:43.000000000 +0100
@@ -33,8 +33,10 @@
 
 static ssize_t afs_file_write(struct file *file, const char __user *buf,
 			      size_t size, loff_t *off);
+static int afs_file_mmap(struct file * file, struct vm_area_struct * vma);
+
 #ifdef CONFIG_AFS_FSCACHE
-static int afs_file_page_mkwrite(struct page *page);
+static int afs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page);
 #endif
 
 struct inode_operations afs_file_inode_operations = {
@@ -44,7 +46,7 @@
 struct file_operations afs_file_file_operations = {
 	.read		= generic_file_read,
 	.write		= afs_file_write,
-	.mmap		= generic_file_mmap,
+	.mmap		= afs_file_mmap,
 #if 0
 	.open		= afs_file_open,
 	.release	= afs_file_release,
@@ -58,6 +60,11 @@
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.releasepage	= afs_file_releasepage,
 	.invalidatepage	= afs_file_invalidatepage,
+};
+
+struct vm_operations_struct afs_fs_vm_operations = {
+	.nopage		= filemap_nopage,
+	.populate	= filemap_populate,
 #ifdef CONFIG_AFS_FSCACHE
 	.page_mkwrite	= afs_file_page_mkwrite,
 #endif
@@ -81,6 +88,20 @@
 
 /*****************************************************************************/
 /*
+ * set up a memory mapping on an AFS file
+ * - we set our own VMA ops so that we can catch the page becoming writable for
+ *   userspace for shared-writable mmap
+ */
+static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &afs_fs_vm_operations;
+	return 0;
+
+} /* end afs_file_mmap() */
+
+/*****************************************************************************/
+/*
  * deal with notification that a page was read from the cache
  */
 #ifdef CONFIG_AFS_FSCACHE
@@ -318,10 +339,11 @@
 
 /*****************************************************************************/
 /*
- * wait for the disc cache to finish writing before permitting
+ * wait for the disc cache to finish writing before permitting modification of
+ * our page in the page cache
  */
 #ifdef CONFIG_AFS_FSCACHE
-static int afs_file_page_mkwrite(struct page *page)
+static int afs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page)
 {
 	wait_on_page_fs_misc(page);
 	return 0;
diff -uNr linux-2.6.12-rc1-mm3/include/linux/fs.h linux-2.6.12-rc1-mm3-cachefs/include/linux/fs.h
--- linux-2.6.12-rc1-mm3/include/linux/fs.h	2005-03-29 15:42:08.000000000 +0100
+++ linux-2.6.12-rc1-mm3-cachefs/include/linux/fs.h	2005-03-29 18:16:39.000000000 +0100
@@ -332,9 +332,6 @@
 	int (*releasepage) (struct page *, int);
 	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
-
-	/* notification that a page is about to become writable */
-	int (*page_mkwrite)(struct page *page);
 };
 
 struct backing_dev_info;
diff -uNr linux-2.6.12-rc1-mm3/mm/filemap.c linux-2.6.12-rc1-mm3-cachefs/mm/filemap.c
--- linux-2.6.12-rc1-mm3/mm/filemap.c	2005-03-29 15:42:11.000000000 +0100
+++ linux-2.6.12-rc1-mm3-cachefs/mm/filemap.c	2005-03-29 18:24:22.000000000 +0100
@@ -1535,25 +1535,11 @@
 	return 0;
 }
 
-/*
- * pass notification that a page is becoming writable up to the filesystem
- */
-static int filemap_page_mkwrite(struct vm_area_struct *vma, struct page *page)
-{
-	return page->mapping->a_ops->page_mkwrite(page);
-}
-
 struct vm_operations_struct generic_file_vm_ops = {
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
 };
 
-struct vm_operations_struct generic_file_vm_mkwr_ops = {
-	.nopage		= filemap_nopage,
-	.populate	= filemap_populate,
-	.page_mkwrite	= filemap_page_mkwrite,
-};
-
 /* This is used for a general mmap of a disk file */
 
 int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
@@ -1563,10 +1549,7 @@
 	if (!mapping->a_ops->readpage)
 		return -ENOEXEC;
 	file_accessed(file);
-	if (!mapping->a_ops->page_mkwrite)
-		vma->vm_ops = &generic_file_vm_ops;
-	else
-		vma->vm_ops = &generic_file_vm_mkwr_ops;
+	vma->vm_ops = &generic_file_vm_ops;
 	return 0;
 }
 EXPORT_SYMBOL(filemap_populate);
