Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVFTX0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVFTX0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVFTXXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:23:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261804AbVFTXAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:17 -0400
Cc: maneesh@in.ibm.com
Subject: [PATCH] sysfs-iattr: add sysfs_setattr
In-Reply-To: <1119308369371@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <11193083692565@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs-iattr: add sysfs_setattr

o This adds ->i_op->setattr VFS method for sysfs inodes. The changed
  attribues are saved in the persistent sysfs_dirent structure as a pointer
  to struct iattr. The struct iattr is allocated only for those sysfs_dirent's
  for which default attributes are getting changed. Thanks to Jon Smirl for
  this suggestion.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 988d186de5b6966a71a8cc52e6cb4895fd2f7799
tree 428cb6c29cbe2563eb91f9f2a03512b7eafa9449
parent 6fa5c828c7fb6beef7035864bd2b18e7386fbdd5
author Maneesh Soni <maneesh@in.ibm.com> Tue, 31 May 2005 10:39:14 +0530
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:37 -0700

 fs/sysfs/dir.c        |    1 +
 fs/sysfs/inode.c      |   65 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/sysfs.h      |    2 ++
 include/linux/sysfs.h |    1 +
 4 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -233,6 +233,7 @@ static struct dentry * sysfs_lookup(stru
 
 struct inode_operations sysfs_dir_inode_operations = {
 	.lookup		= sysfs_lookup,
+	.setattr	= sysfs_setattr,
 };
 
 static void remove_dir(struct dentry * d)
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -26,6 +26,71 @@ static struct backing_dev_info sysfs_bac
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
+static struct inode_operations sysfs_inode_operations ={
+	.setattr	= sysfs_setattr,
+};
+
+int sysfs_setattr(struct dentry * dentry, struct iattr * iattr)
+{
+	struct inode * inode = dentry->d_inode;
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	struct iattr * sd_iattr;
+	unsigned int ia_valid = iattr->ia_valid;
+	int error;
+
+	if (!sd)
+		return -EINVAL;
+
+	sd_iattr = sd->s_iattr;
+
+	error = inode_change_ok(inode, iattr);
+	if (error)
+		return error;
+
+	error = inode_setattr(inode, iattr);
+	if (error)
+		return error;
+
+	if (!sd_iattr) {
+		/* setting attributes for the first time, allocate now */
+		sd_iattr = kmalloc(sizeof(struct iattr), GFP_KERNEL);
+		if (!sd_iattr)
+			return -ENOMEM;
+		/* assign default attributes */
+		memset(sd_iattr, 0, sizeof(struct iattr));
+		sd_iattr->ia_mode = sd->s_mode;
+		sd_iattr->ia_uid = 0;
+		sd_iattr->ia_gid = 0;
+		sd_iattr->ia_atime = sd_iattr->ia_mtime = sd_iattr->ia_ctime = CURRENT_TIME;
+		sd->s_iattr = sd_iattr;
+	}
+
+	/* attributes were changed atleast once in past */
+
+	if (ia_valid & ATTR_UID)
+		sd_iattr->ia_uid = iattr->ia_uid;
+	if (ia_valid & ATTR_GID)
+		sd_iattr->ia_gid = iattr->ia_gid;
+	if (ia_valid & ATTR_ATIME)
+		sd_iattr->ia_atime = timespec_trunc(iattr->ia_atime,
+						inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_MTIME)
+		sd_iattr->ia_mtime = timespec_trunc(iattr->ia_mtime,
+						inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_CTIME)
+		sd_iattr->ia_ctime = timespec_trunc(iattr->ia_ctime,
+						inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_MODE) {
+		umode_t mode = iattr->ia_mode;
+
+		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
+			mode &= ~S_ISGID;
+		sd_iattr->ia_mode = mode;
+	}
+
+	return error;
+}
+
 struct inode * sysfs_new_inode(mode_t mode)
 {
 	struct inode * inode = new_inode(sysfs_sb);
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -17,6 +17,7 @@ extern void sysfs_remove_subdir(struct d
 
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
 extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
+extern int sysfs_setattr(struct dentry *dentry, struct iattr *iattr);
 
 extern struct rw_semaphore sysfs_rename_sem;
 extern struct super_block * sysfs_sb;
@@ -75,6 +76,7 @@ static inline void release_sysfs_dirent(
 		kobject_put(sl->target_kobj);
 		kfree(sl);
 	}
+	kfree(sd->s_iattr);
 	kmem_cache_free(sysfs_dir_cachep, sd);
 }
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -73,6 +73,7 @@ struct sysfs_dirent {
 	int			s_type;
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
+	struct iattr		* s_iattr;
 };
 
 #define SYSFS_ROOT		0x0001

