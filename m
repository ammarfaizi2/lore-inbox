Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVFTXa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVFTXa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVFTXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:23:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261805AbVFTXAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:17 -0400
Cc: maneesh@in.ibm.com
Subject: [PATCH] sysfs-iattr: set inode attributes
In-Reply-To: <1119308369529@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <1119308369371@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs-iattr: set inode attributes

o Following patch sets the attributes for newly allocated inodes for sysfs
  objects. If the object has non-default attributes, inode attributes are
  set as saved in sysfs_dirent->s_iattr, pointer to struct iattr.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8215534ce7d073423bfa9c17405c43ab7636ca03
tree b53aed1111cf10a7d42ef0695308c4a70b820747
parent 988d186de5b6966a71a8cc52e6cb4895fd2f7799
author Maneesh Soni <maneesh@in.ibm.com> Tue, 31 May 2005 10:39:52 +0530
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:37 -0700

 fs/sysfs/inode.c |   37 +++++++++++++++++++++++++++++++------
 fs/sysfs/mount.c |    4 +++-
 fs/sysfs/sysfs.h |    2 +-
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -91,18 +91,42 @@ int sysfs_setattr(struct dentry * dentry
 	return error;
 }
 
-struct inode * sysfs_new_inode(mode_t mode)
+static inline void set_default_inode_attr(struct inode * inode, mode_t mode)
+{
+	inode->i_mode = mode;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+}
+
+static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
+{
+	inode->i_mode = iattr->ia_mode;
+	inode->i_uid = iattr->ia_uid;
+	inode->i_gid = iattr->ia_gid;
+	inode->i_atime = iattr->ia_atime;
+	inode->i_mtime = iattr->ia_mtime;
+	inode->i_ctime = iattr->ia_ctime;
+}
+
+struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent * sd)
 {
 	struct inode * inode = new_inode(sysfs_sb);
 	if (inode) {
-		inode->i_mode = mode;
-		inode->i_uid = 0;
-		inode->i_gid = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		inode->i_mapping->a_ops = &sysfs_aops;
 		inode->i_mapping->backing_dev_info = &sysfs_backing_dev_info;
+		inode->i_op = &sysfs_inode_operations;
+
+		if (sd->s_iattr) {
+			/* sysfs_dirent has non-default attributes
+			 * get them for the new inode from persistent copy
+			 * in sysfs_dirent
+			 */
+			set_inode_attr(inode, sd->s_iattr);
+		} else
+			set_default_inode_attr(inode, mode);
 	}
 	return inode;
 }
@@ -113,7 +137,8 @@ int sysfs_create(struct dentry * dentry,
 	struct inode * inode = NULL;
 	if (dentry) {
 		if (!dentry->d_inode) {
-			if ((inode = sysfs_new_inode(mode))) {
+			struct sysfs_dirent * sd = dentry->d_fsdata;
+			if ((inode = sysfs_new_inode(mode, sd))) {
 				if (dentry->d_parent && dentry->d_parent->d_inode) {
 					struct inode *p_inode = dentry->d_parent->d_inode;
 					p_inode->i_mtime = p_inode->i_ctime = CURRENT_TIME;
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -28,6 +28,7 @@ static struct sysfs_dirent sysfs_root = 
 	.s_children	= LIST_HEAD_INIT(sysfs_root.s_children),
 	.s_element	= NULL,
 	.s_type		= SYSFS_ROOT,
+	.s_iattr	= NULL,
 };
 
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
@@ -42,7 +43,8 @@ static int sysfs_fill_super(struct super
 	sb->s_time_gran = 1;
 	sysfs_sb = sb;
 
-	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+				 &sysfs_root);
 	if (inode) {
 		inode->i_op = &sysfs_dir_inode_operations;
 		inode->i_fop = &sysfs_dir_operations;
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -2,7 +2,7 @@
 extern struct vfsmount * sysfs_mount;
 extern kmem_cache_t *sysfs_dir_cachep;
 
-extern struct inode * sysfs_new_inode(mode_t mode);
+extern struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent *);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
 extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,

