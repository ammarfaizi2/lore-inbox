Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWEMDo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWEMDo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWEMDo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:44:29 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:19188 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S932249AbWEMDo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:44:27 -0400
Date: Fri, 12 May 2006 21:44:30 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 6/13: eCryptfs] Superblock operations
Message-ID: <20060513034429.GF18631@hellewell.homeip.net>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 6th patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

eCryptfs superblock operations and inode allocation, deallocation, and
initialization functions.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 super.c |  212 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 212 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/super.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/super.c	2006-05-12 20:00:30.000000000 -0600
@@ -0,0 +1,212 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (C) 1997-2003 Erez Zadok
+ * Copyright (C) 2001-2003 Stony Brook University
+ * Copyright (C) 2004-2006 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *              Michael C. Thompson <mcthomps@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/key.h>
+#include <linux/seq_file.h>
+#include "ecryptfs_kernel.h"
+
+struct kmem_cache *ecryptfs_inode_info_cache;
+
+/**
+ * ecryptfs_alloc_inode - allocate an ecryptfs inode
+ * @sb: Pointer to the ecryptfs super block
+ * 
+ * Called to bring an inode into existence.
+ *
+ * Note that setting the self referencing pointer doesn't work here:
+ * 	i.e. ECRYPTFS_INODE_TO_PRIVATE_SM(inode) = ei;
+ *
+ * Only handle allocation, setting up structures should be done in
+ * ecryptfs_read_inode. This is because the kernel, between now and
+ * then, will 0 out the private data pointer.
+ * 
+ * Returns a pointer to a newly allocated inode, NULL otherwise
+ */
+static struct inode *ecryptfs_alloc_inode(struct super_block *sb)
+{
+	struct ecryptfs_inode_info *ecryptfs_inode;
+	struct inode *inode = NULL;
+
+	ecryptfs_inode = kmem_cache_alloc(ecryptfs_inode_info_cache,
+					  SLAB_KERNEL);
+	if (unlikely(!ecryptfs_inode))
+		goto out;
+	ecryptfs_init_crypt_stat(&ecryptfs_inode->crypt_stat);
+	inode = &ecryptfs_inode->vfs_inode;
+out:
+	return inode;
+}
+
+/**
+ * ecryptfs_destroy_inode
+ * @inode: The ecryptfs inode
+ *
+ * This is used during the final destruction of the inode.
+ * All allocation of memory related to the inode, including allocated
+ * memory in the crypt_stat struct, will be released here.
+ * There should be no chance that this deallocation will be missed.
+ */
+static void ecryptfs_destroy_inode(struct inode *inode)
+{
+	struct ecryptfs_inode_info *inode_info;
+
+	inode_info = ecryptfs_inode_to_private(inode);
+	ecryptfs_destruct_crypt_stat(&inode_info->crypt_stat);
+	kmem_cache_free(ecryptfs_inode_info_cache, inode_info);
+}
+
+/**
+ * ecryptfs_read_inode
+ * @inode: The ecryptfs inode
+ *
+ * Set up the ecryptfs inode.
+ */
+static void ecryptfs_read_inode(struct inode *inode)
+{
+	/* This is where we setup the self-reference in the vfs_inode's
+	 * u.generic_ip. That way we don't have to walk the list again. */
+	ecryptfs_set_inode_private(inode,
+				   list_entry(inode, struct ecryptfs_inode_info,
+					      vfs_inode));
+	ecryptfs_set_inode_lower(inode, NULL);
+	inode->i_version++;
+	inode->i_op = &ecryptfs_main_iops;
+	inode->i_fop = &ecryptfs_main_fops;
+	inode->i_mapping->a_ops = &ecryptfs_aops;
+}
+
+/**
+ * ecryptfs_put_super
+ * @sb: Pointer to the ecryptfs super block
+ * 
+ * Final actions when unmounting a file system.
+ * This will handle deallocation and release of our private data.
+ */
+static void ecryptfs_put_super(struct super_block *sb)
+{
+	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
+
+	mntput(sb_info->lower_mnt);
+	key_put(sb_info->mount_crypt_stat.global_auth_tok_key);
+	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
+	ecryptfs_set_superblock_private(sb, NULL);
+}
+
+/**
+ * ecryptfs_statfs
+ * @sb: The ecryptfs super block
+ * @buf: The struct kstatfs to fill in with stats
+ * 
+ * Get the filesystem statistics. Currently, we let this pass right through
+ * to the lower filesystem and take no action ourselves.
+ */
+static inline int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	return vfs_statfs(ecryptfs_superblock_to_lower(sb), buf);
+}
+
+/**
+ * ecryptfs_clear_inode
+ * @inode - The ecryptfs inode
+ *
+ * Called by iput() when the inode reference count reached zero
+ * and the inode is not hashed anywhere.  Used to clear anything
+ * that needs to be, before the inode is completely destroyed and put
+ * on the inode free list. We use this to drop out reference to the
+ * lower inode.
+ */
+static inline void ecryptfs_clear_inode(struct inode *inode)
+{
+	iput(ecryptfs_inode_to_lower(inode));
+}
+
+/**
+ * ecryptfs_umount_begin
+ *
+ * Called in do_umount() if the MNT_FORCE flag was used and this
+ * function is defined.  See comment in linux/fs/super.c:do_umount().
+ * Used only in nfs, to kill any pending RPC tasks, so that subsequent
+ * code can actually succeed and won't leave tasks that need handling.
+ */
+static void ecryptfs_umount_begin(struct vfsmount *vfsmnt, int flags)
+{
+	struct vfsmount *lower_mnt;
+	struct super_block *lower_sb;
+
+	lower_mnt = ecryptfs_superblock_to_private(vfsmnt->mnt_sb)->lower_mnt;
+	lower_sb = lower_mnt->mnt_sb;
+	if (lower_sb->s_op->umount_begin)
+		lower_sb->s_op->umount_begin(lower_mnt, flags);
+}
+
+/**
+ * ecryptfs_show_options
+ * 
+ * Prints the directory we are currently mounted over.
+ * Returns zero on success; non-zero otherwise
+ */
+static int ecryptfs_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+	struct dentry *lower_root_dentry;
+	struct ecryptfs_sb_info *sb_info;
+	struct vfsmount *lower_mount;
+	int rc = 0;
+	char *tmp_page = NULL;
+	char *path;
+
+	tmp_page = (char *)__get_free_page(GFP_KERNEL);
+	if (!tmp_page) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	lower_root_dentry = ecryptfs_dentry_to_lower(sb->s_root);
+	sb_info = ecryptfs_superblock_to_private(sb);
+	lower_mount = sb_info->lower_mnt;
+	path = d_path(lower_root_dentry, lower_mount, tmp_page, PAGE_SIZE);
+	if (IS_ERR(path)) {
+		rc = PTR_ERR(path);
+		goto out;
+	}
+	seq_printf(m, ",dir=%s", path);
+	free_page((unsigned long)tmp_page);
+out:
+	return rc;
+}
+
+struct super_operations ecryptfs_sops = {
+	.alloc_inode = ecryptfs_alloc_inode,
+	.destroy_inode = ecryptfs_destroy_inode,
+	.read_inode = ecryptfs_read_inode,
+	.drop_inode = generic_delete_inode,
+	.put_super = ecryptfs_put_super,
+	.statfs = ecryptfs_statfs,
+	.remount_fs = NULL,
+	.clear_inode = ecryptfs_clear_inode,
+	.umount_begin = ecryptfs_umount_begin,
+	.show_options = ecryptfs_show_options
+};
