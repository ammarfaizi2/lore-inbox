Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUFVUHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUFVUHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUFVTbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:31:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13467 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265200AbUFVTX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:23:59 -0400
To: torvalds@osdl.org
Subject: [PATCH] (3/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xT-HF@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        trivial cases - ones where we have no need to clean up after
pathname traversal (link body embedded into inode, etc.).  Plugged leak in
devfs_follow_link(), while we are at it.

diff -urN RC7-bk5-ext2/fs/autofs/symlink.c RC7-bk5-trivial/fs/autofs/symlink.c
--- RC7-bk5-ext2/fs/autofs/symlink.c	Sat Oct 12 00:54:43 2002
+++ RC7-bk5-trivial/fs/autofs/symlink.c	Tue Jun 22 15:13:10 2004
@@ -12,19 +12,14 @@
 
 #include "autofs_i.h"
 
-static int autofs_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
-	return vfs_readlink(dentry, buffer, buflen, s);
-}
-
 static int autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
-	return vfs_follow_link(nd, s);
+	nd_set_link(nd, s);
+	return 0;
 }
 
 struct inode_operations autofs_symlink_inode_operations = {
-	.readlink	= autofs_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= autofs_follow_link
 };
diff -urN RC7-bk5-ext2/fs/autofs4/symlink.c RC7-bk5-trivial/fs/autofs4/symlink.c
--- RC7-bk5-ext2/fs/autofs4/symlink.c	Sat Oct 12 00:54:43 2002
+++ RC7-bk5-trivial/fs/autofs4/symlink.c	Tue Jun 22 15:13:10 2004
@@ -12,21 +12,14 @@
 
 #include "autofs_i.h"
 
-static int autofs4_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-
-	return vfs_readlink(dentry, buffer, buflen, ino->u.symlink);
-}
-
 static int autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-
-	return vfs_follow_link(nd, ino->u.symlink);
+	nd_set_link(nd, (char *)ino->u.symlink);
+	return 0;
 }
 
 struct inode_operations autofs4_symlink_inode_operations = {
-	.readlink	= autofs4_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= autofs4_follow_link
 };
diff -urN RC7-bk5-ext2/fs/bad_inode.c RC7-bk5-trivial/fs/bad_inode.c
--- RC7-bk5-ext2/fs/bad_inode.c	Thu Oct  9 17:34:46 2003
+++ RC7-bk5-trivial/fs/bad_inode.c	Tue Jun 22 15:13:10 2004
@@ -13,6 +13,7 @@
 #include <linux/stat.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
+#include <linux/namei.h>
 
 /*
  * The follow_link operation is special: it must behave as a no-op
@@ -21,7 +22,8 @@
  */
 static int bad_follow_link(struct dentry *dent, struct nameidata *nd)
 {
-	return vfs_follow_link(nd, ERR_PTR(-EIO));
+	nd_set_link(nd, ERR_PTR(-EIO));
+	return 0;
 }
 
 static int return_EIO(void)
diff -urN RC7-bk5-ext2/fs/devfs/base.c RC7-bk5-trivial/fs/devfs/base.c
--- RC7-bk5-ext2/fs/devfs/base.c	Tue Jun 22 15:11:30 2004
+++ RC7-bk5-trivial/fs/devfs/base.c	Tue Jun 22 15:17:02 2004
@@ -2490,29 +2490,11 @@
 	return 0;
 }				/*  End Function devfs_mknod  */
 
-static int devfs_readlink(struct dentry *dentry, char __user *buffer,
-			  int buflen)
-{
-	int err;
-	struct devfs_entry *de;
-
-	de = get_devfs_entry_from_vfs_inode(dentry->d_inode);
-	if (!de)
-		return -ENODEV;
-	err = vfs_readlink(dentry, buffer, buflen, de->u.symlink.linkname);
-	return err;
-}				/*  End Function devfs_readlink  */
-
 static int devfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	int err;
-	struct devfs_entry *de;
-
-	de = get_devfs_entry_from_vfs_inode(dentry->d_inode);
-	if (!de)
-		return -ENODEV;
-	err = vfs_follow_link(nd, de->u.symlink.linkname);
-	return err;
+	struct devfs_entry *p = get_devfs_entry_from_vfs_inode(dentry->d_inode);
+	nd_set_link(nd, p ? p->u.symlink.linkname : ERR_PTR(-ENODEV));
+	return 0;
 }				/*  End Function devfs_follow_link  */
 
 static struct inode_operations devfs_iops = {
@@ -2530,7 +2512,7 @@
 };
 
 static struct inode_operations devfs_symlink_iops = {
-	.readlink = devfs_readlink,
+	.readlink = generic_readlink,
 	.follow_link = devfs_follow_link,
 	.setattr = devfs_notify_change,
 };
diff -urN RC7-bk5-ext2/fs/freevxfs/vxfs_immed.c RC7-bk5-trivial/fs/freevxfs/vxfs_immed.c
--- RC7-bk5-ext2/fs/freevxfs/vxfs_immed.c	Wed Feb 18 13:40:47 2004
+++ RC7-bk5-trivial/fs/freevxfs/vxfs_immed.c	Tue Jun 22 15:13:10 2004
@@ -32,12 +32,12 @@
  */
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/namei.h>
 
 #include "vxfs.h"
 #include "vxfs_inode.h"
 
 
-static int	vxfs_immed_readlink(struct dentry *, char __user *, int);
 static int	vxfs_immed_follow_link(struct dentry *, struct nameidata *);
 
 static int	vxfs_immed_readpage(struct file *, struct page *);
@@ -49,7 +49,7 @@
  * but do all work directly on the inode.
  */
 struct inode_operations vxfs_immed_symlink_iops = {
-	.readlink =		vxfs_immed_readlink,
+	.readlink =		generic_readlink,
 	.follow_link =		vxfs_immed_follow_link,
 };
 
@@ -60,28 +60,6 @@
 	.readpage =		vxfs_immed_readpage,
 };
 
-
-/**
- * vxfs_immed_readlink - read immed symlink
- * @dp:		dentry for the link
- * @bp:		output buffer
- * @buflen:	length of @bp
- *
- * Description:
- *   vxfs_immed_readlink calls vfs_readlink to read the link
- *   described by @dp into userspace.
- *
- * Returns:
- *   Number of bytes successfully copied to userspace.
- */
-static int
-vxfs_immed_readlink(struct dentry *dp, char __user *bp, int buflen)
-{
-	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);
-
-	return (vfs_readlink(dp, bp, buflen, vip->vii_immed.vi_immed));
-}
-
 /**
  * vxfs_immed_follow_link - follow immed symlink
  * @dp:		dentry for the link
@@ -98,8 +76,8 @@
 vxfs_immed_follow_link(struct dentry *dp, struct nameidata *np)
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);
-
-	return (vfs_follow_link(np, vip->vii_immed.vi_immed));
+	nd_set_link(np, vip->vii_immed.vi_immed);
+	return 0;
 }
 
 /**
diff -urN RC7-bk5-ext2/fs/jfs/symlink.c RC7-bk5-trivial/fs/jfs/symlink.c
--- RC7-bk5-ext2/fs/jfs/symlink.c	Thu Oct  9 17:34:47 2003
+++ RC7-bk5-trivial/fs/jfs/symlink.c	Tue Jun 22 15:13:10 2004
@@ -17,23 +17,19 @@
  */
 
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include "jfs_incore.h"
 #include "jfs_xattr.h"
 
 static int jfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s = JFS_IP(dentry->d_inode)->i_inline;
-	return vfs_follow_link(nd, s);
-}
-
-static int jfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
-{
-	char *s = JFS_IP(dentry->d_inode)->i_inline;
-	return vfs_readlink(dentry, buffer, buflen, s);
+	nd_set_link(nd, s);
+	return 0;
 }
 
 struct inode_operations jfs_symlink_inode_operations = {
-	.readlink	= jfs_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= jfs_follow_link,
 	.setxattr	= jfs_setxattr,
 	.getxattr	= jfs_getxattr,
diff -urN RC7-bk5-ext2/fs/proc/generic.c RC7-bk5-trivial/fs/proc/generic.c
--- RC7-bk5-ext2/fs/proc/generic.c	Tue Jun 22 13:15:09 2004
+++ RC7-bk5-trivial/fs/proc/generic.c	Tue Jun 22 15:13:10 2004
@@ -17,6 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/idr.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
 
@@ -321,21 +322,14 @@
 	spin_unlock(&proc_inum_lock);
 }
 
-static int
-proc_readlink(struct dentry *dentry, char __user *buffer, int buflen)
-{
-	char *s = PDE(dentry->d_inode)->data;
-	return vfs_readlink(dentry, buffer, buflen, s);
-}
-
 static int proc_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s = PDE(dentry->d_inode)->data;
-	return vfs_follow_link(nd, s);
+	nd_set_link(nd, PDE(dentry->d_inode)->data);
+	return 0;
 }
 
 static struct inode_operations proc_link_inode_operations = {
-	.readlink	= proc_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= proc_follow_link,
 };
 
diff -urN RC7-bk5-ext2/fs/sysv/symlink.c RC7-bk5-trivial/fs/sysv/symlink.c
--- RC7-bk5-ext2/fs/sysv/symlink.c	Sat Oct 12 00:54:56 2002
+++ RC7-bk5-trivial/fs/sysv/symlink.c	Tue Jun 22 15:13:10 2004
@@ -6,20 +6,15 @@
  */
 
 #include "sysv.h"
-
-static int sysv_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	char *s = (char *)SYSV_I(dentry->d_inode)->i_data;
-	return vfs_readlink(dentry, buffer, buflen, s);
-}
+#include <linux/namei.h>
 
 static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s = (char *)SYSV_I(dentry->d_inode)->i_data;
-	return vfs_follow_link(nd, s);
+	nd_set_link(nd, (char *)SYSV_I(dentry->d_inode)->i_data);
+	return 0;
 }
 
 struct inode_operations sysv_fast_symlink_inode_operations = {
-	.readlink	= sysv_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= sysv_follow_link,
 };
diff -urN RC7-bk5-ext2/fs/ufs/symlink.c RC7-bk5-trivial/fs/ufs/symlink.c
--- RC7-bk5-ext2/fs/ufs/symlink.c	Tue Oct  1 23:41:48 2002
+++ RC7-bk5-trivial/fs/ufs/symlink.c	Tue Jun 22 15:13:10 2004
@@ -26,21 +26,17 @@
  */
 
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/ufs_fs.h>
 
-static int ufs_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	struct ufs_inode_info *p = UFS_I(dentry->d_inode);
-	return vfs_readlink(dentry, buffer, buflen, (char*)p->i_u1.i_symlink);
-}
-
 static int ufs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct ufs_inode_info *p = UFS_I(dentry->d_inode);
-	return vfs_follow_link(nd, (char*)p->i_u1.i_symlink);
+	nd_set_link(nd, (char*)p->i_u1.i_symlink);
+	return 0;
 }
 
 struct inode_operations ufs_fast_symlink_inode_operations = {
-	.readlink	= ufs_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= ufs_follow_link,
 };
