Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUGGNFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUGGNFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUGGNAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:00:11 -0400
Received: from linuxhacker.ru ([217.76.32.60]:12759 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265106AbUGGMtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:47 -0400
Date: Wed, 7 Jul 2004 15:47:33 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [7/9] Lustre VFS patches for 2.6
Message-ID: <20040707124733.GA25969@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make do_truncate aware of the case when we do truncate from open,
that may need some special handling by filesystems.
(special flag in ia_valid)

 fs/exec.c          |    2 +-
 fs/namei.c         |    2 +-
 fs/open.c          |    8 +++++---
 include/linux/fs.h |    3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6.6/fs/namei.c
===================================================================
--- linux-2.6.6.orig/fs/namei.c	2004-05-30 23:17:06.267030976 +0300
+++ linux-2.6.6/fs/namei.c	2004-05-30 23:23:15.642877312 +0300
@@ -1270,7 +1270,7 @@
 		if (!error) {
 			DQUOT_INIT(inode);
 			
-			error = do_truncate(dentry, 0);
+			error = do_truncate(dentry, 0, 1);
 		}
 		put_write_access(inode);
 		if (error)
Index: linux-2.6.6/fs/open.c
===================================================================
--- linux-2.6.6.orig/fs/open.c	2004-05-30 20:05:26.857206992 +0300
+++ linux-2.6.6/fs/open.c	2004-05-30 23:24:38.908219056 +0300
@@ -189,7 +189,7 @@
 	return error;
 }
 
-int do_truncate(struct dentry *dentry, loff_t length)
+int do_truncate(struct dentry *dentry, loff_t length, int called_from_open)
 {
 	int err;
 	struct iattr newattrs;
@@ -202,6 +202,8 @@
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
 	down(&dentry->d_inode->i_sem);
 	down_write(&dentry->d_inode->i_alloc_sem);
+	if (called_from_open)
+		newattrs.ia_valid |= ATTR_FROM_OPEN;
 	err = notify_change(dentry, &newattrs);
 	up_write(&dentry->d_inode->i_alloc_sem);
 	up(&dentry->d_inode->i_sem);
@@ -259,7 +261,7 @@
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length);
+		error = do_truncate(nd.dentry, length, 0);
 	}
 	put_write_access(inode);
 
@@ -311,7 +313,7 @@
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length);
+		error = do_truncate(dentry, length, 0);
 out_putf:
 	fput(file);
 out:
Index: linux-2.6.6/fs/exec.c
===================================================================
--- linux-2.6.6.orig/fs/exec.c	2004-05-30 20:05:26.862206232 +0300
+++ linux-2.6.6/fs/exec.c	2004-05-30 23:23:15.648876400 +0300
@@ -1395,7 +1395,7 @@
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0) != 0)
+	if (do_truncate(file->f_dentry, 0, 0) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);
Index: linux-2.6.6/include/linux/fs.h
===================================================================
--- linux-2.6.6.orig/include/linux/fs.h	2004-05-30 23:20:11.979798344 +0300
+++ linux-2.6.6/include/linux/fs.h	2004-05-30 23:25:29.167578472 +0300
@@ -249,6 +249,7 @@
 #define ATTR_ATTR_FLAG	1024
 #define ATTR_KILL_SUID	2048
 #define ATTR_KILL_SGID	4096
+#define ATTR_FROM_OPEN	8192   /* called from open path, ie O_TRUNC */
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
@@ -1189,7 +1190,7 @@
 
 /* fs/open.c */
 
-extern int do_truncate(struct dentry *, loff_t start);
+extern int do_truncate(struct dentry *, loff_t start, int called_from_open);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
 extern struct file * dentry_open_it(struct dentry *, struct vfsmount *, int, struct lookup_intent *);
