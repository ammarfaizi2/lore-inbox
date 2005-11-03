Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVKCDu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVKCDu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVKCDu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:50:59 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:34798
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1030326AbVKCDu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:50:58 -0500
Date: Wed, 2 Nov 2005 20:51:20 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 6/12: eCryptfs] Superblock operations
Message-ID: <20051103035120.GF3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs superblock operations and inode
allocation/deallocation/initialization functions.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 super.c |  246 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 246 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/super.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/super.c	2005-11-01 14:40:17.000000000 -0600
@@ -0,0 +1,246 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (c) 1997-2003 Erez Zadok
+ * Copyright (c) 2001-2003 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
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
+#ifdef HAVE_CONFIG_H
+# include <config.h>
+#endif				/* HAVE_CONFIG_H */
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/key.h>
+#include "ecryptfs_kernel.h"
+
+kmem_cache_t *ecryptfs_inode_info_cache;
+
+/**
+ * Called to bring an inode into existence.
+ *
+ * Note that setting the self referencing pointer doesn't work here:
+ * 	i.e. INODE_TO_PRIVATE_SM(inode)=ei;
+ *
+ * Only handle allocation, setting up structures should be done in
+ * ecryptfs_read_inode. This is because the kernel, between now and
+ * then, will 0 out the private data pointer.
+ *
+ * @param sb	Pointer to the super block of the filesystem
+ * @return	Pointer to a newly allocated inode, NULL otherwise
+ */
+static struct inode *ecryptfs_alloc_inode(struct super_block *sb) {
+	struct ecryptfs_inode_info *ecryptfs_inode = NULL;
+	struct inode *inode = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p]\n", sb);
+	ecryptfs_inode = ecryptfs_kmem_cache_alloc(ecryptfs_inode_info_cache,
+						   SLAB_KERNEL);
+	if (unlikely(!ecryptfs_inode)) {
+		ecryptfs_printk(1, KERN_WARNING,
+				"Failed to allocate new inode\n");
+		goto out;
+	}
+	ecryptfs_init_crypt_stats(&(ecryptfs_inode->crypt_stats));
+	inode = &(ecryptfs_inode->vfs_inode);
+ out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; inode = [%p]\n", inode);
+	return inode;
+}
+
+/**
+ * This is used during the final destruction of the inode.
+ * All allocation of memory related to the inode, including allocated
+ * memory in the crypt_stats struct, will be released here.
+ * There should be no chance that this deallocation will be missed.
+ */
+static void ecryptfs_destroy_inode(struct inode *inode) {
+	struct ecryptfs_crypt_stats *crypt_stats;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode = [%p]\n", inode);
+	crypt_stats = &(INODE_TO_PRIVATE(inode))->crypt_stats;
+	ecryptfs_destruct_crypt_stats(crypt_stats);
+	ecryptfs_kmem_cache_free(ecryptfs_inode_info_cache,
+                                  INODE_TO_PRIVATE(inode));
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Return a pointer to our ecryptfs_inode_info struct.
+ * This is specified by the kernel documentation for the alloc_inode &
+ * destroy_inode change. We use this function to get a handle to our
+ * ecryptfs specific data.
+ *
+ * @param inode	The inode component of the ecryptfs_inode_info we want to find
+ * @return	Handle to our ecryptfs_inode_info
+ */
+static inline struct ecryptfs_inode_info *ECRYPTFS_I(struct inode *inode)
+{
+	return list_entry(inode, struct ecryptfs_inode_info, vfs_inode);
+}
+
+/**
+ * Set up the ecryptfs inode.
+ */
+static void ecryptfs_read_inode(struct inode *inode)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode = [%p]\n", inode);
+	/* This is where we setup the self-reference in the vfs_inode's
+	 * u.generic_ip. That way we don't have to walk the list again. */
+	INODE_TO_PRIVATE_SM(inode) = ECRYPTFS_I(inode);
+	INODE_TO_LOWER(inode) = NULL;
+	inode->i_version++;
+	inode->i_op = &ecryptfs_main_iops;
+	inode->i_fop = &ecryptfs_main_fops;
+	inode->i_mapping->a_ops = &ecryptfs_aops;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+
+/**
+ * This is called through iput_final().
+ * This is function will replace generic_drop_inode. The end result of which
+ * is we are skipping the check in inode->i_nlink, which we do not use.
+ */
+static void ecryptfs_drop_inode(struct inode *inode) {
+	generic_delete_inode(inode);
+}
+
+/**
+ * Final actions when unmounting a file system.
+ * This will handle deallocation and release of our private data.
+ */
+static void ecryptfs_put_super(struct super_block *sb)
+{
+	struct ecryptfs_sb_info *sb_info = SUPERBLOCK_TO_PRIVATE(sb);
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	mntput(sb_info->lower_mnt);
+	key_put(sb_info->mount_crypt_stats.global_auth_tok_key);
+	ecryptfs_kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
+	SUPERBLOCK_TO_PRIVATE_SM(sb) = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Get the filesystem statistics. Currently, we let this pass right through
+ * to the lower filesystem and take no action ourselves
+ * 
+ * TODO: Any stats need to be transposed?
+ */
+static int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	int err = 0;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	err = vfs_statfs(SUPERBLOCK_TO_LOWER(sb), buf);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n",err);
+	return err;
+}
+
+/**
+ * TODO: Not implemented.
+ * Called to ask filesystem to change mount options.
+ */
+static int ecryptfs_remount_fs(struct super_block *sb, int *flags, char *data)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return -ENOSYS;
+}
+
+/**
+ * Called by iput() when the inode reference count reached zero
+ * and the inode is not hashed anywhere.  Used to clear anything
+ * that needs to be, before the inode is completely destroyed and put
+ * on the inode free list. We use this to drop out reference to the
+ * lower inode.
+ *
+ * TODO: Why do we just not drop the reference to the lower inode in
+ *      ecryptfs_destroy_inode?
+ */
+static void ecryptfs_clear_inode(struct inode *inode)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode = [%p]; i_ino = [%lu]\n",
+			inode, inode->i_ino);
+	ecryptfs_iput(INODE_TO_LOWER(inode));
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Called in do_umount() if the MNT_FORCE flag was used and this
+ * function is defined.  See comment in linux/fs/super.c:do_umount().
+ * Used only in nfs, to kill any pending RPC tasks, so that subsequent
+ * code can actually succeed and won't leave tasks that need handling.
+ *
+ * PS. I wonder if this is somehow useful to undo damage that was
+ * left in the kernel after a user level file server (such as amd)
+ * dies.
+ */
+static void ecryptfs_umount_begin(struct super_block *sb)
+{
+	struct super_block *lower_sb;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	/* TODO: Explain why we are umounting the lower superblock */
+	lower_sb = SUPERBLOCK_TO_LOWER(sb);
+	if (lower_sb->s_op->umount_begin)
+		lower_sb->s_op->umount_begin(lower_sb);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/* TODO: Where is this normally declared? */
+int seq_printf(struct seq_file *m, const char *f, ...);
+
+/**
+ * Prints the directory we are currently mounted over
+ * 
+ * @return Zero on success; non-zero otherwise
+ */
+static int ecryptfs_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+	int ret = 0;
+	char *tmp = NULL;
+	char *path;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	tmp = (char *)__get_free_page(GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* TODO: wrap? */
+	path = d_path(DENTRY_TO_LOWER(sb->s_root),
+		      SUPERBLOCK_TO_PRIVATE(sb)->lower_mnt, tmp, PAGE_SIZE);
+	seq_printf(m, ",dir=%s", path);
+	free_page((unsigned long)tmp);
+ out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; ret = [%d]\n",ret);
+	return ret;
+}
+
+/* TODO: Provide operations? (quota stuff, dirty, sync) */
+struct super_operations ecryptfs_sops = {
+	.alloc_inode = ecryptfs_alloc_inode,
+	.destroy_inode = ecryptfs_destroy_inode,
+	.read_inode = ecryptfs_read_inode,
+	.drop_inode = ecryptfs_drop_inode,
+	.put_super = ecryptfs_put_super,
+	.statfs = ecryptfs_statfs,
+	.remount_fs = ecryptfs_remount_fs,
+	.clear_inode = ecryptfs_clear_inode,
+	.umount_begin = ecryptfs_umount_begin,
+	.show_options = ecryptfs_show_options
+};
