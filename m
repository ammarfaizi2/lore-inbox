Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUGXPMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUGXPMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268668AbUGXPMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:12:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:22999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268667AbUGXPMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:12:15 -0400
X-Authenticated: #12437197
Date: Sat, 24 Jul 2004 18:12:29 +0300
From: Dan Aloni <da-x@gmx.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] d_unhash consolidation
Message-ID: <20040724151229.GA13367@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This removes a copy of d_unhash() from drivers/usb/core/inode.c and
and exports d_unhash() from fs/namei.c as dentry_unhash(). 
Tested - compiled and running.

Signed-off-by: Dan Aloni <da-x@gmx.net>

diff -urN -X /home/dax/colinux/bin/dontdiff linux-2.6.8-rc2-clean/drivers/usb/core/inode.c linux-2.6.8-rc2-work/drivers/usb/core/inode.c
--- linux-2.6.8-rc2-clean/drivers/usb/core/inode.c	2004-07-22 09:31:59.000000000 -0230
+++ linux-2.6.8-rc2-work/drivers/usb/core/inode.c	2004-07-24 10:43:27.000000000 -0230
@@ -345,30 +345,13 @@
 	return 0;
 }
 
-static void d_unhash(struct dentry *dentry)
-{
-	dget(dentry);
-	spin_lock(&dcache_lock);
-	switch (atomic_read(&dentry->d_count)) {
-	default:
-		spin_unlock(&dcache_lock);
-		shrink_dcache_parent(dentry);
-		spin_lock(&dcache_lock);
-		if (atomic_read(&dentry->d_count) != 2)
-			break;
-	case 2:
-		__d_drop(dentry);
-	}
-	spin_unlock(&dcache_lock);
-}
-
 static int usbfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int error = -ENOTEMPTY;
 	struct inode * inode = dentry->d_inode;
 
 	down(&inode->i_sem);
-	d_unhash(dentry);
+	dentry_unhash(dentry);
 	if (usbfs_empty(dentry)) {
 		dentry->d_inode->i_nlink -= 2;
 		dput(dentry);
diff -urN -X /home/dax/colinux/bin/dontdiff linux-2.6.8-rc2-clean/fs/namei.c linux-2.6.8-rc2-work/fs/namei.c
--- linux-2.6.8-rc2-clean/fs/namei.c	2004-07-22 09:32:04.000000000 -0230
+++ linux-2.6.8-rc2-work/fs/namei.c	2004-07-24 10:44:13.000000000 -0230
@@ -1659,7 +1659,7 @@
  * if it cannot handle the case of removing a directory
  * that is still in use by something else..
  */
-static void d_unhash(struct dentry *dentry)
+void dentry_unhash(struct dentry *dentry)
 {
 	dget(dentry);
 	spin_lock(&dcache_lock);
@@ -1689,7 +1689,7 @@
 	DQUOT_INIT(dir);
 
 	down(&dentry->d_inode->i_sem);
-	d_unhash(dentry);
+	dentry_unhash(dentry);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
@@ -2032,7 +2032,7 @@
 	target = new_dentry->d_inode;
 	if (target) {
 		down(&target->i_sem);
-		d_unhash(new_dentry);
+		dentry_unhash(new_dentry);
 	}
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
@@ -2410,4 +2410,5 @@
 EXPORT_SYMBOL(vfs_rmdir);
 EXPORT_SYMBOL(vfs_symlink);
 EXPORT_SYMBOL(vfs_unlink);
+EXPORT_SYMBOL(dentry_unhash);
 EXPORT_SYMBOL(generic_readlink);
diff -urN -X /home/dax/colinux/bin/dontdiff linux-2.6.8-rc2-clean/include/linux/fs.h linux-2.6.8-rc2-work/include/linux/fs.h
--- linux-2.6.8-rc2-clean/include/linux/fs.h	2004-07-22 09:32:10.000000000 -0230
+++ linux-2.6.8-rc2-work/include/linux/fs.h	2004-07-24 10:22:42.000000000 -0230
@@ -808,6 +808,11 @@
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
 
 /*
+ * VFS dentry helper functions.
+ */
+extern void dentry_unhash(struct dentry *dentry);
+
+/*
  * File types
  *
  * NOTE! These match bits 12..15 of stat.st_mode


-- 
Dan Aloni
da-x@colinux.org
