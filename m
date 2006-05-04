Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWEDDi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWEDDi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWEDDi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:38:28 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:26602 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750976AbWEDDi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:38:27 -0400
Date: Wed, 3 May 2006 21:38:29 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 6/13: eCryptfs] Superblock operations
Message-ID: <20060504033829.GE28613@hellewell.homeip.net>
References: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
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

 super.c |  225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 225 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/super.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/super.c	2006-05-02 19:36:04.000000000 -0600
@@ -0,0 +1,225 @@
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
+kmem_cache_t *ecryptfs_inode_info_cache;
+
+/**
+ * Called to bring an inode into existence.
+ *
+ * Note that setting the self referencing pointer doesn't work here:
+ * 	i.e. ECRYPTFS_INODE_TO_PRIVATE_SM(inode) = ei;
+ *
+ * Only handle allocation, setting up structures should be done in
+ * ecryptfs_read_inode. This is because the kernel, between now and
+ * then, will 0 out the private data pointer.
+ *
+ * @param sb Pointer to the super block of the filesystem
+ * @return Pointer to a newly allocated inode, NULL otherwise
+ */
+static struct inode *ecryptfs_alloc_inode(struct super_block *sb) {
+	struct ecryptfs_inode_info *ecryptfs_inode = NULL;
+	struct inode *inode = NULL;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; sb = [%p]\n", sb);
+	ecryptfs_inode = kmem_cache_alloc(ecryptfs_inode_info_cache,
+					  SLAB_KERNEL);
+	if (unlikely(!ecryptfs_inode)) {
+		ecryptfs_printk(KERN_WARNING,
+				"Failed to allocate new inode\n");
+		goto out;
+	}
+	ecryptfs_init_crypt_stat(&(ecryptfs_inode->crypt_stat));
+	inode = &(ecryptfs_inode->vfs_inode);
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; inode = [%p]\n", inode);
+	return inode;
+}
+
+/**
+ * This is used during the final destruction of the inode.
+ * All allocation of memory related to the inode, including allocated
+ * memory in the crypt_stat struct, will be released here.
+ * There should be no chance that this deallocation will be missed.
+ */
+static void ecryptfs_destroy_inode(struct inode *inode) {
+	struct ecryptfs_crypt_stat *crypt_stat;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
+	crypt_stat = &(ECRYPTFS_INODE_TO_PRIVATE(inode))->crypt_stat;
+	ecryptfs_destruct_crypt_stat(crypt_stat);
+	kmem_cache_free(ecryptfs_inode_info_cache,
+			ECRYPTFS_INODE_TO_PRIVATE(inode));
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+}
+
+/**
+ * Set up the ecryptfs inode.
+ */
+static void ecryptfs_read_inode(struct inode *inode)
+{
+	ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
+	/* This is where we setup the self-reference in the vfs_inode's
+	 * u.generic_ip. That way we don't have to walk the list again. */
+	ECRYPTFS_INODE_TO_PRIVATE_SM(inode) =
+		list_entry(inode, struct ecryptfs_inode_info, vfs_inode);
+	ECRYPTFS_INODE_TO_LOWER(inode) = NULL;
+	inode->i_version++;
+	inode->i_op = &ecryptfs_main_iops;
+	inode->i_fop = &ecryptfs_main_fops;
+	inode->i_mapping->a_ops = &ecryptfs_aops;
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
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
+	struct ecryptfs_sb_info *sb_info = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb);
+
+	ecryptfs_printk(KERN_DEBUG, "Enter\n");
+	mntput(sb_info->lower_mnt);
+	key_put(sb_info->mount_crypt_stat.global_auth_tok_key);
+	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
+	ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(sb) = NULL;
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+}
+
+/**
+ * Get the filesystem statistics. Currently, we let this pass right through
+ * to the lower filesystem and take no action ourselves.
+ */
+static int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	int rc = 0;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter\n");
+	rc = vfs_statfs(ECRYPTFS_SUPERBLOCK_TO_LOWER(sb), buf);
+	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Called to ask filesystem to change mount options. Not implemented;
+ * returns -ENOSYS every time.
+ */
+static int ecryptfs_remount_fs(struct super_block *sb, int *flags, char *data)
+{
+	ecryptfs_printk(KERN_DEBUG, "Enter\n");
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+	return -ENOSYS;
+}
+
+/**
+ * Called by iput() when the inode reference count reached zero
+ * and the inode is not hashed anywhere.  Used to clear anything
+ * that needs to be, before the inode is completely destroyed and put
+ * on the inode free list. We use this to drop out reference to the
+ * lower inode.
+ */
+static void ecryptfs_clear_inode(struct inode *inode)
+{
+	ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]; i_ino = [0x%.16x]\n",
+			inode, inode->i_ino);
+	iput(ECRYPTFS_INODE_TO_LOWER(inode));
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+}
+
+/**
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
+	ecryptfs_printk(KERN_DEBUG, "Enter\n");
+	lower_mnt = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(vfsmnt->mnt_sb)->lower_mnt;
+	lower_sb = lower_mnt->mnt_sb;
+	if (lower_sb->s_op->umount_begin)
+		lower_sb->s_op->umount_begin(lower_mnt, flags);
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+}
+
+/**
+ * Prints the directory we are currently mounted over
+ * 
+ * @return Zero on success; non-zero otherwise
+ */
+static int ecryptfs_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+	int rc = 0;
+	char *tmp = NULL;
+	char *path;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter\n");
+	tmp = (char *)__get_free_page(GFP_KERNEL);
+	if (!tmp) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	path = d_path(ECRYPTFS_DENTRY_TO_LOWER(sb->s_root),
+		      ECRYPTFS_SUPERBLOCK_TO_PRIVATE(sb)->lower_mnt, tmp,
+		      PAGE_SIZE);
+	seq_printf(m, ",dir=%s", path);
+	free_page((unsigned long)tmp);
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
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
