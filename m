Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUJ3SSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUJ3SSp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUJ3SRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:17:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:777 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261277AbUJ3SKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:10:10 -0400
Date: Sat, 30 Oct 2004 20:09:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small sysfs cleanups
Message-ID: <20041030180939.GU4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups for the sysfs code:
- remove the unused global function sysfs_mknod
- make some structs and functions static

Please check whether this patch is correct, or whether some of the 
things I made static should be used globally in the forseeable future.


diffstat output:
 fs/sysfs/dir.c     |    2 +-
 fs/sysfs/inode.c   |    5 -----
 fs/sysfs/mount.c   |    2 +-
 fs/sysfs/symlink.c |   17 +++++++++--------
 fs/sysfs/sysfs.h   |    2 --
 5 files changed, 11 insertions(+), 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/sysfs/sysfs.h.old	2004-10-30 15:14:26.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/sysfs/sysfs.h	2004-10-30 15:15:11.000000000 +0200
@@ -17,8 +17,6 @@
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
 extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
 
-extern int sysfs_follow_link(struct dentry *, struct nameidata *);
-extern void sysfs_put_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
 extern struct file_operations sysfs_dir_operations;
--- linux-2.6.10-rc1-mm2-full/fs/sysfs/dir.c.old	2004-10-30 15:05:13.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/sysfs/dir.c	2004-10-30 15:06:01.000000000 +0200
@@ -201,7 +201,7 @@
 	return err;
 }
 
-struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
+static struct dentry * sysfs_lookup(struct inode *dir, struct dentry *dentry,
 				struct nameidata *nd)
 {
 	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
--- linux-2.6.10-rc1-mm2-full/fs/sysfs/inode.c.old	2004-10-30 15:06:15.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/sysfs/inode.c	2004-10-30 15:10:25.000000000 +0200
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
--- linux-2.6.10-rc1-mm2-full/fs/sysfs/mount.c.old	2004-10-30 15:10:33.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/sysfs/mount.c	2004-10-30 15:10:49.000000000 +0200
@@ -22,7 +22,7 @@
 	.drop_inode	= generic_delete_inode,
 };
 
-struct sysfs_dirent sysfs_root = {
+static struct sysfs_dirent sysfs_root = {
 	.s_sibling	= LIST_HEAD_INIT(sysfs_root.s_sibling),
 	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
 	.s_element	= NULL,
--- linux-2.6.10-rc1-mm2-full/fs/sysfs/symlink.c.old	2004-10-30 15:11:00.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/sysfs/symlink.c	2004-10-30 15:14:13.000000000 +0200
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
@@ -167,13 +161,20 @@
 	return 0;
 }
 
-void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
+static void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *page = nd_get_link(nd);
 	if (!IS_ERR(page))
 		free_page((unsigned long)page);
 }
 
+struct inode_operations sysfs_symlink_inode_operations = {
+	.readlink = generic_readlink,
+	.follow_link = sysfs_follow_link,
+	.put_link = sysfs_put_link,
+};
+
+
 EXPORT_SYMBOL_GPL(sysfs_create_link);
 EXPORT_SYMBOL_GPL(sysfs_remove_link);
 

