Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWJMNWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWJMNWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJMNWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:22:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22418 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750717AbWJMNWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:22:11 -0400
Date: Fri, 13 Oct 2006 16:22:09 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org, jsipek@cs.sunysb.edu, ezk@cs.sunysb.edu,
       mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
Subject: [RFC/PATCH 1/2] stackfs: generic functions for obtaining hidden
 object
Message-ID: <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Add generic functions for obtaining the hidden object (superblock, inode,
dentry, and dentry mount-point) in a stacked filesystem.  As fan-out 
stacked filesystems have multiple hidden objects, we store them in a 
statically allocated array of pointers.  The current hard-coded limit 
STACKFS_MAX_BRANCHES is not enough for unionfs (for which users have more 
than 100 branches).  That, however, can be fixed later for unionfs.

Cc: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/stack_fs.h |   93 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

Index: 2.6/include/linux/stack_fs.h
===================================================================
--- /dev/null
+++ 2.6/include/linux/stack_fs.h
@@ -0,0 +1,93 @@
+#ifndef __LINUX_STACK_FS_H
+#define __LINUX_STACK_FS_H
+
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+
+#define STACKFS_MAX_BRANCHES (8)
+
+struct stackfs_sb_info {
+	struct super_block *hidden_sbs[STACKFS_MAX_BRANCHES];
+};
+
+struct stackfs_inode_info {
+	struct inode *hidden_inodes[STACKFS_MAX_BRANCHES];
+};
+
+struct stackfs_dentry_info {
+	struct dentry *hidden_dentrys[STACKFS_MAX_BRANCHES];
+	struct vfsmount *hidden_mnts[STACKFS_MAX_BRANCHES];
+};
+
+struct stackfs_file_info {
+	struct file *hidden_files[STACKFS_MAX_BRANCHES];
+};
+
+/*
+ * The functions expect struct stackfs_*_info to be the first member in the
+ * filesystem-specific info structures and that inode->i_private points at
+ * the beginning of the inode container.
+ */
+
+static inline struct super_block *
+__stackfs_hidden_sb(struct super_block *sb, unsigned long branch_idx)
+{
+	struct stackfs_sb_info *info = sb->s_fs_info;
+	return info->hidden_sbs[branch_idx];
+}
+
+static inline struct super_block *stackfs_hidden_sb(struct super_block *sb)
+{
+	return __stackfs_hidden_sb(sb, 0);
+}
+
+static inline struct inode *
+__stackfs_hidden_inode(struct inode *inode, unsigned long branch_idx)
+{
+	struct stackfs_inode_info *info = inode->i_private;
+	return info->hidden_inodes[branch_idx];
+}
+
+static inline struct inode *stackfs_hidden_inode(struct inode *inode)
+{
+	return __stackfs_hidden_inode(inode, 0);
+}
+
+static inline struct dentry *
+__stackfs_hidden_dentry(struct dentry *dentry, unsigned long branch_idx)
+{
+	struct stackfs_dentry_info *info = dentry->d_fsdata;
+	return info->hidden_dentrys[branch_idx];
+}
+
+static inline struct dentry *stackfs_hidden_dentry(struct dentry *dentry)
+{
+	return __stackfs_hidden_dentry(dentry, 0);
+}
+
+static inline struct vfsmount *
+__stackfs_hidden_dentry_mnt(struct dentry *dentry, unsigned long branch_idx)
+{
+	struct stackfs_dentry_info *info = dentry->d_fsdata;
+	return info->hidden_mnts[branch_idx];
+}
+
+static inline struct vfsmount *stackfs_hidden_dentry_mnt(struct dentry *dentry)
+{
+	return __stackfs_hidden_dentry_mnt(dentry, 0);
+}
+
+static inline struct file *
+__stackfs_hidden_file(struct file *file, unsigned long branch_idx)
+{
+	struct stackfs_file_info *info = file->private_data;
+	return info->hidden_files[branch_idx];
+}
+
+static inline struct file *stackfs_hidden_file(struct file *file)
+{
+	return __stackfs_hidden_file(file, 0);
+}
+
+#endif
