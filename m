Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVAFLce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVAFLce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAFLce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:32:34 -0500
Received: from [213.146.154.40] ([213.146.154.40]:48804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262581AbVAFLcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:32:18 -0500
Date: Thu, 6 Jan 2005 11:32:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050106113216.GA16261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103100725.GA17856@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103100725.GA17856@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:07:25AM +0000, Christoph Hellwig wrote:
> > add-page-becoming-writable-notification.patch
> >   Add page becoming writable notification
> 
> David, this still has the bogus address_space operation in addition to
> the vm_operation.  page_mkwrite only fits into the vm_operations scheme,
> so please remove the address_space op.  Also the code will be smaller
> and faster witout that indirection..

Here's the fix:


diff -uNr -X dontdiff -p linux-2.6.10-mm2.orig/fs/afs/file.c linux-2.6.10-mm2/fs/afs/file.c
--- linux-2.6.10-mm2.orig/fs/afs/file.c	2005-01-06 11:40:18.727916000 +0100
+++ linux-2.6.10-mm2/fs/afs/file.c	2005-01-06 12:27:59.088000048 +0100
@@ -33,8 +33,10 @@ static int afs_file_releasepage(struct p
 
 static ssize_t afs_file_write(struct file *file, const char __user *buf,
 			      size_t size, loff_t *off);
+static int afs_file_mmap(struct file * file, struct vm_area_struct * vma);
+
 #ifdef CONFIG_AFS_FSCACHE
-static int afs_file_page_mkwrite(struct page *page);
+static int afs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page);
 #endif
 
 struct inode_operations afs_file_inode_operations = {
@@ -44,7 +46,7 @@ struct inode_operations afs_file_inode_o
 struct file_operations afs_file_file_operations = {
 	.read		= generic_file_read,
 	.write		= afs_file_write,
-	.mmap		= generic_file_mmap,
+	.mmap		= afs_file_mmap,
 #if 0
 	.open		= afs_file_open,
 	.release	= afs_file_release,
@@ -58,6 +60,11 @@ struct address_space_operations afs_fs_a
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
@@ -79,6 +86,13 @@ static ssize_t afs_file_write(struct fil
 	return -EIO;
 } /* end afs_file_write() */
 
+static int afs_file_mmap(struct file * file, struct vm_area_struct * vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &afs_fs_vm_operations;
+	return 0;
+}
+
 /*****************************************************************************/
 /*
  * deal with notification that a page was read from the cache
@@ -321,7 +335,7 @@ static int afs_file_releasepage(struct p
  * wait for the disc cache to finish writing before permitting
  */
 #ifdef CONFIG_AFS_FSCACHE
-static int afs_file_page_mkwrite(struct page *page)
+static int afs_file_page_mkwrite(struct vm_area_struct *vma, struct page *page)
 {
 	wait_on_page_fs_misc(page);
 	return 0;
diff -uNr -X dontdiff -p linux-2.6.10-mm2.orig/include/linux/fs.h linux-2.6.10-mm2/include/linux/fs.h
--- linux-2.6.10-mm2.orig/include/linux/fs.h	2005-01-06 11:40:20.124973000 +0100
+++ linux-2.6.10-mm2/include/linux/fs.h	2005-01-06 11:49:55.144888912 +0100
@@ -330,9 +330,6 @@ struct address_space_operations {
 	int (*releasepage) (struct page *, int);
 	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
-
-	/* notification that a page is about to become writable */
-	int (*page_mkwrite)(struct page *page);
 };
 
 struct backing_dev_info;
diff -uNr -X dontdiff -p linux-2.6.10-mm2.orig/include/linux/mm.h linux-2.6.10-mm2/include/linux/mm.h
--- linux-2.6.10-mm2.orig/include/linux/mm.h	2005-01-06 11:40:20.168966000 +0100
+++ linux-2.6.10-mm2/include/linux/mm.h	2005-01-06 11:49:11.645979744 +0100
@@ -762,7 +762,10 @@ extern void truncate_inode_pages_range(s
 				       loff_t lstart, loff_t lend);
 
 /* generic vm_area_ops exported for stackable file systems */
-struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int *);
+extern struct page *filemap_nopage(struct vm_area_struct *,
+		unsigned long, int *);
+extern int filemap_populate(struct vm_area_struct *, unsigned long,
+		unsigned long, pgprot_t, unsigned long, int);
 
 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
diff -uNr -X dontdiff -p linux-2.6.10-mm2.orig/mm/filemap.c linux-2.6.10-mm2/mm/filemap.c
--- linux-2.6.10-mm2.orig/mm/filemap.c	2005-01-06 11:40:20.443924000 +0100
+++ linux-2.6.10-mm2/mm/filemap.c	2005-01-06 11:49:29.311957792 +0100
@@ -1477,7 +1477,7 @@ err:
 	return NULL;
 }
 
-static int filemap_populate(struct vm_area_struct *vma,
+int filemap_populate(struct vm_area_struct *vma,
 			unsigned long addr,
 			unsigned long len,
 			pgprot_t prot,
@@ -1524,26 +1524,13 @@ repeat:
 
 	return 0;
 }
-
-/*
- * pass notification that a page is becoming writable up to the filesystem
- */
-static int filemap_page_mkwrite(struct vm_area_struct *vma, struct page *page)
-{
-	return page->mapping->a_ops->page_mkwrite(page);
-}
+EXPORT_SYMBOL(filemap_populate);
 
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
@@ -1553,10 +1540,7 @@ int generic_file_mmap(struct file * file
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
 
