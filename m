Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWBNRxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWBNRxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWBNRxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:53:10 -0500
Received: from verein.lst.de ([213.95.11.210]:205 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422723AbWBNRxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:53:08 -0500
Date: Tue, 14 Feb 2006 18:53:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] afs: use kthread_ API
Message-ID: <20060214175305.GD19080@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kthread_ API instead of opencoding lots of hairy code for kernel
thread creation and teardown.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/afs/file.c
===================================================================
--- linux-2.6.orig/fs/afs/file.c	2005-10-31 14:59:17.000000000 +0100
+++ linux-2.6/fs/afs/file.c	2005-10-31 15:20:17.000000000 +0100
@@ -31,24 +31,10 @@
 static int afs_file_invalidatepage(struct page *page, unsigned long offset);
 static int afs_file_releasepage(struct page *page, gfp_t gfp_flags);
 
-static ssize_t afs_file_write(struct file *file, const char __user *buf,
-			      size_t size, loff_t *off);
-
 struct inode_operations afs_file_inode_operations = {
 	.getattr	= afs_inode_getattr,
 };
 
-struct file_operations afs_file_file_operations = {
-	.read		= generic_file_read,
-	.write		= afs_file_write,
-	.mmap		= generic_file_mmap,
-#if 0
-	.open		= afs_file_open,
-	.release	= afs_file_release,
-	.fsync		= afs_file_fsync,
-#endif
-};
-
 struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_file_readpage,
 	.sync_page	= block_sync_page,
@@ -59,22 +45,6 @@
 
 /*****************************************************************************/
 /*
- * AFS file write
- */
-static ssize_t afs_file_write(struct file *file, const char __user *buf,
-			      size_t size, loff_t *off)
-{
-	struct afs_vnode *vnode;
-
-	vnode = AFS_FS_I(file->f_dentry->d_inode);
-	if (vnode->flags & AFS_VNODE_DELETED)
-		return -ESTALE;
-
-	return -EIO;
-} /* end afs_file_write() */
-
-/*****************************************************************************/
-/*
  * deal with notification that a page was read from the cache
  */
 #ifdef AFS_CACHING_SUPPORT
Index: linux-2.6/fs/afs/inode.c
===================================================================
--- linux-2.6.orig/fs/afs/inode.c	2005-10-31 12:23:55.000000000 +0100
+++ linux-2.6/fs/afs/inode.c	2005-10-31 15:20:03.000000000 +0100
@@ -49,7 +49,7 @@
 	case AFS_FTYPE_FILE:
 		inode->i_mode	= S_IFREG | vnode->status.mode;
 		inode->i_op	= &afs_file_inode_operations;
-		inode->i_fop	= &afs_file_file_operations;
+		inode->i_fop	= &generic_ro_fops;
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	= S_IFDIR | vnode->status.mode;
Index: linux-2.6/fs/afs/internal.h
===================================================================
--- linux-2.6.orig/fs/afs/internal.h	2005-10-31 12:23:55.000000000 +0100
+++ linux-2.6/fs/afs/internal.h	2005-10-31 15:20:07.000000000 +0100
@@ -71,7 +71,6 @@
  */
 extern struct address_space_operations afs_fs_aops;
 extern struct inode_operations afs_file_inode_operations;
-extern struct file_operations afs_file_file_operations;
 
 #ifdef AFS_CACHING_SUPPORT
 extern int afs_cache_get_page_cookie(struct page *page,
