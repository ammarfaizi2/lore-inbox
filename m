Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWJIULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWJIULd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWJIULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:11:33 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:55270 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964806AbWJIULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:11:32 -0400
Date: Mon, 9 Oct 2006 16:10:48 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: notting@redhat.com, akpm@osdl.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Introduce vfs_listxattr
Message-ID: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Nottingham <notting@redhat.com>

This patch moves code out of fs/xattr.c:listxattr into a new function -
vfs_listxattr. The code for vfs_listxattr was originally submitted by Bill
Nottingham <notting@redhat.com> to Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

diff -r 0231458fbb78 fs/xattr.c
--- a/fs/xattr.c	Sat Oct 07 16:46:17 2006 -0400
+++ b/fs/xattr.c	Sat Oct 07 17:36:18 2006 -0400
@@ -135,6 +135,26 @@ vfs_getxattr(struct dentry *dentry, char
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
+ssize_t
+vfs_listxattr(struct dentry *d, char *list, size_t size)
+{
+	ssize_t error;
+
+	error = security_inode_listxattr(d);
+	if (error)
+		return error;
+	error = -EOPNOTSUPP;
+	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
+		error = d->d_inode->i_op->listxattr(d, list, size);
+	} else {
+		error = security_inode_listsecurity(d->d_inode, list, size);
+		if (size && error > size)
+			error = -ERANGE;
+	}
+	return error;
+}
+EXPORT_SYMBOL_GPL(vfs_listxattr);
+
 int
 vfs_removexattr(struct dentry *dentry, char *name)
 {
@@ -346,17 +366,7 @@ listxattr(struct dentry *d, char __user 
 			return -ENOMEM;
 	}
 
-	error = security_inode_listxattr(d);
-	if (error)
-		goto out;
-	error = -EOPNOTSUPP;
-	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
-		error = d->d_inode->i_op->listxattr(d, klist, size);
-	} else {
-		error = security_inode_listsecurity(d->d_inode, klist, size);
-		if (size && error > size)
-			error = -ERANGE;
-	}
+	error = vfs_listxattr(d, klist, size);
 	if (error > 0) {
 		if (size && copy_to_user(list, klist, error))
 			error = -EFAULT;
@@ -365,7 +375,6 @@ listxattr(struct dentry *d, char __user 
 		   than XATTR_LIST_MAX bytes. Not possible. */
 		error = -E2BIG;
 	}
-out:
 	kfree(klist);
 	return error;
 }
diff -r 0231458fbb78 include/linux/xattr.h
--- a/include/linux/xattr.h	Sat Oct 07 16:46:17 2006 -0400
+++ b/include/linux/xattr.h	Sat Oct 07 17:32:43 2006 -0400
@@ -41,6 +41,7 @@ struct xattr_handler {
 };
 
 ssize_t vfs_getxattr(struct dentry *, char *, void *, size_t);
+ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int vfs_setxattr(struct dentry *, char *, void *, size_t, int);
 int vfs_removexattr(struct dentry *, char *);
 
-- 
UNIX is user-friendly ... it's just selective about who it's friends are
