Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbUKEBdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUKEBdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKEAwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:52:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:42206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262514AbUKEAs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:48:56 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157042090@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:24 -0800
Message-Id: <10996157042662@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.2, 2004/11/03 13:50:47-08:00, bunk@stusta.de

[PATCH] small sysfs cleanups

The patch below does the following cleanups for the sysfs code:
- remove the unused global function sysfs_mknod
- make some structs and functions static

Please check whether this patch is correct, or whether some of the
things I made static should be used globally in the forseeable future.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c     |    2 +-
 fs/sysfs/inode.c   |    5 -----
 fs/sysfs/mount.c   |    2 +-
 fs/sysfs/symlink.c |   17 +++++++++--------
 fs/sysfs/sysfs.h   |    2 --
 5 files changed, 11 insertions(+), 17 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-04 16:31:09 -08:00
+++ b/fs/sysfs/dir.c	2004-11-04 16:31:09 -08:00
@@ -201,7 +201,7 @@
 	return err;
 }
 
-struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
+static struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
 				struct nameidata *nd)
 {
 	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	2004-11-04 16:31:09 -08:00
+++ b/fs/sysfs/inode.c	2004-11-04 16:31:09 -08:00
@@ -76,11 +76,6 @@
 	return error;
 }
 
-int sysfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
-{
-	return sysfs_create(dentry, mode, NULL);
-}
-
 struct dentry * sysfs_get_dentry(struct dentry * parent, const char * name)
 {
 	struct qstr qstr;
diff -Nru a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	2004-11-04 16:31:09 -08:00
+++ b/fs/sysfs/mount.c	2004-11-04 16:31:09 -08:00
@@ -22,7 +22,7 @@
 	.drop_inode	= generic_delete_inode,
 };
 
-struct sysfs_dirent sysfs_root = {
+static struct sysfs_dirent sysfs_root = {
 	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
 	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
 	.s_element	= NULL,
diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c	2004-11-04 16:31:09 -08:00
+++ b/fs/sysfs/symlink.c	2004-11-04 16:31:09 -08:00
@@ -9,12 +9,6 @@
 
 #include "sysfs.h"
 
-struct inode_operations sysfs_symlink_inode_operations = {
-	.readlink = generic_readlink,
-	.follow_link = sysfs_follow_link,
-	.put_link = sysfs_put_link,
-};
-
 static int object_depth(struct kobject * kobj)
 {
 	struct kobject * p = kobj;
@@ -157,7 +151,7 @@
 
 }
 
-int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int error = -ENOMEM;
 	unsigned long page = get_zeroed_page(GFP_KERNEL);
@@ -167,12 +161,19 @@
 	return 0;
 }
 
-void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
+static void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *page = nd_get_link(nd);
 	if (!IS_ERR(page))
 		free_page((unsigned long)page);
 }
+
+struct inode_operations sysfs_symlink_inode_operations = {
+	.readlink = generic_readlink,
+	.follow_link = sysfs_follow_link,
+	.put_link = sysfs_put_link,
+};
+
 
 EXPORT_SYMBOL_GPL(sysfs_create_link);
 EXPORT_SYMBOL_GPL(sysfs_remove_link);
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2004-11-04 16:31:09 -08:00
+++ b/fs/sysfs/sysfs.h	2004-11-04 16:31:09 -08:00
@@ -17,8 +17,6 @@
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
 extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
 
-extern int sysfs_follow_link(struct dentry *, struct nameidata *);
-extern void sysfs_put_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
 extern struct file_operations sysfs_dir_operations;

