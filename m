Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWIAB7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWIAB7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWIAB7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:59:08 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:24968 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750754AbWIAB7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:59:04 -0400
Date: Thu, 31 Aug 2006 21:58:51 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 18/22][RFC] Unionfs: Superblock operations
Message-ID: <20060901015851.GS5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains the superblock operations for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/super.c |  352 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 352 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/super.c linux-2.6-git-unionfs/fs/unionfs/super.c
--- linux-2.6-git/fs/unionfs/super.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/super.c	2006-08-31 19:04:01.000000000 -0400
@@ -0,0 +1,352 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
+ * Copyright (c) 2005-2006 Junjiro Okajima
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * For specific licensing information, see the COPYING file distributed with
+ * this package.
+ *
+ * This Copyright notice must be kept intact and distributed with all sources.
+ */
+
+#include "union.h"
+
+/* The inode cache is used with alloc_inode for both our inode info and the
+ * vfs inode.  */
+static kmem_cache_t *unionfs_inode_cachep;
+
+static void unionfs_read_inode(struct inode *inode)
+{
+	static struct address_space_operations unionfs_empty_aops;
+	int size;
+
+	if (!itopd(inode)) {
+		printk(KERN_ERR "No kernel memory when allocating inode "
+				"private data!\n");
+		BUG();
+	}
+
+	memset(itopd(inode), 0, sizeof(struct unionfs_inode_info));
+	itopd(inode)->b_start = -1;
+	itopd(inode)->b_end = -1;
+	atomic_set(&itopd(inode)->uii_generation,
+		   atomic_read(&stopd(inode->i_sb)->usi_generation));
+	itopd(inode)->uii_rdlock = SPIN_LOCK_UNLOCKED;
+	itopd(inode)->uii_rdcount = 1;
+	itopd(inode)->uii_hashsize = -1;
+	INIT_LIST_HEAD(&itopd(inode)->uii_readdircache);
+
+	size = sbmax(inode->i_sb) * sizeof(struct inode *);
+	itohi_ptr(inode) = kzalloc(size, GFP_KERNEL);
+	if (!itohi_ptr(inode)) {
+		printk(KERN_ERR "No kernel memory when allocating lower-"
+				"pointer array!\n");
+		BUG();
+	}
+
+	inode->i_version++;
+	inode->i_op = &unionfs_main_iops;
+	inode->i_fop = &unionfs_main_fops;
+
+	/* I don't think ->a_ops is ever allowed to be NULL */
+	inode->i_mapping->a_ops = &unionfs_empty_aops;
+}
+
+static void unionfs_put_inode(struct inode *inode)
+{
+	/*
+	 * This is really funky stuff:
+	 * Basically, if i_count == 1, iput will then decrement it and this
+	 * inode will be destroyed.  It is currently holding a reference to the
+	 * hidden inode.  Therefore, it needs to release that reference by
+	 * calling iput on the hidden inode.  iput() _will_ do it for us (by
+	 * calling our clear_inode), but _only_ if i_nlink == 0.  The problem
+	 * is, NFS keeps i_nlink == 1 for silly_rename'd files.  So we must for
+	 * our i_nlink to 0 here to trick iput() into calling our clear_inode.
+	 */
+
+	if (atomic_read(&inode->i_count) == 1)
+		inode->i_nlink = 0;
+}
+
+/*
+ * we now define delete_inode, because there are two VFS paths that may
+ * destroy an inode: one of them calls clear inode before doing everything
+ * else that's needed, and the other is fine.  This way we truncate the inode
+ * size (and its pages) and then clear our own inode, which will do an iput
+ * on our and the lower inode.
+ */
+static void unionfs_delete_inode(struct inode *inode)
+{
+	inode->i_size = 0;	/* every f/s seems to do that */
+
+	clear_inode(inode);
+}
+
+/* final actions when unmounting a file system */
+static void unionfs_put_super(struct super_block *sb)
+{
+	int bindex, bstart, bend;
+	struct unionfs_sb_info *spd;
+
+	if ((spd = stopd(sb))) {
+		bstart = sbstart(sb);
+		bend = sbend(sb);
+		for (bindex = bstart; bindex <= bend; bindex++)
+			mntput(stohiddenmnt_index(sb, bindex));
+
+		/* Make sure we have no leaks of branchget/branchput. */
+		for (bindex = bstart; bindex <= bend; bindex++)
+			BUG_ON(branch_count(sb, bindex) != 0);
+
+		kfree(spd->usi_data);
+		kfree(spd);
+		stopd_lhs(sb) = NULL;
+	}
+}
+
+/* Since people use this to answer the "How big of a file can I write?"
+ * question, we report the size of the highest priority branch as the size of
+ * the union. */
+static int unionfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	int err	= 0;
+	struct super_block *sb, *hidden_sb;
+
+	sb = dentry->d_sb;
+
+	hidden_sb = stohs_index(sb, sbstart(sb));
+	err = vfs_statfs(hidden_sb->s_root, buf);
+
+	buf->f_type = UNIONFS_SUPER_MAGIC;
+	buf->f_namelen -= UNIONFS_WHLEN;
+
+	memset(&buf->f_fsid, 0, sizeof(__kernel_fsid_t));
+	memset(&buf->f_spare, 0, sizeof(buf->f_spare));
+
+	return err;
+}
+
+/* We don't support a standard text remount. Eventually it would be nice to
+ * support a full-on remount, so that you can have all of the directories
+ * change at once, but that would require some pretty complicated matching
+ * code. */
+static int unionfs_remount_fs(struct super_block *sb, int *flags, char *data)
+{
+	return -ENOSYS;
+}
+
+/*
+ * Called by iput() when the inode reference count reached zero
+ * and the inode is not hashed anywhere.  Used to clear anything
+ * that needs to be, before the inode is completely destroyed and put
+ * on the inode free list.
+ */
+static void unionfs_clear_inode(struct inode *inode)
+{
+	int bindex, bstart, bend;
+	struct inode *hidden_inode;
+	struct list_head *pos, *n;
+	struct unionfs_dir_state *rdstate;
+
+	list_for_each_safe(pos, n, &itopd(inode)->uii_readdircache) {
+		rdstate = list_entry(pos, struct unionfs_dir_state, uds_cache);
+		list_del(&rdstate->uds_cache);
+		free_rdstate(rdstate);
+	}
+
+	/* Decrement a reference to a hidden_inode, which was incremented
+	 * by our read_inode when it was created initially.  */
+	bstart = ibstart(inode);
+	bend = ibend(inode);
+	if (bstart >= 0) {
+		for (bindex = bstart; bindex <= bend; bindex++) {
+			hidden_inode = itohi_index(inode, bindex);
+			if (!hidden_inode)
+				continue;
+			iput(hidden_inode);
+		}
+	}
+
+	kfree(itohi_ptr(inode));
+	itohi_ptr(inode) = NULL;
+}
+
+static struct inode *unionfs_alloc_inode(struct super_block *sb)
+{
+	struct unionfs_inode_container *c;
+
+	c = (struct unionfs_inode_container *)
+	    kmem_cache_alloc(unionfs_inode_cachep, SLAB_KERNEL);
+	if (!c) {
+		return NULL;
+	}
+
+	memset(&c->info, 0, sizeof(c->info));
+
+	c->vfs_inode.i_version = 1;
+	return &c->vfs_inode;
+}
+
+static void unionfs_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(unionfs_inode_cachep, itopd(inode));
+}
+
+static void init_once(void *v, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct unionfs_inode_container *c = (struct unionfs_inode_container *)v;
+
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&c->vfs_inode);
+}
+
+int init_inode_cache(void)
+{
+	int err = 0;
+
+	unionfs_inode_cachep =
+	    kmem_cache_create("unionfs_inode_cache",
+			      sizeof(struct unionfs_inode_container), 0,
+			      SLAB_RECLAIM_ACCOUNT, init_once, NULL);
+	if (!unionfs_inode_cachep)
+		err = -ENOMEM;
+	return err;
+}
+
+void destroy_inode_cache(void)
+{
+	if (!unionfs_inode_cachep)
+		goto out;
+	if (kmem_cache_destroy(unionfs_inode_cachep))
+		printk(KERN_ERR
+		       "unionfs_inode_cache: not all structures were freed\n");
+out:
+	return;
+}
+
+/* Called when we have a dirty inode, right here we only throw out
+ * parts of our readdir list that are too old.
+ */
+static int unionfs_write_inode(struct inode *inode, int sync)
+{
+	struct list_head *pos, *n;
+	struct unionfs_dir_state *rdstate;
+
+	spin_lock(&itopd(inode)->uii_rdlock);
+	list_for_each_safe(pos, n, &itopd(inode)->uii_readdircache) {
+		rdstate = list_entry(pos, struct unionfs_dir_state, uds_cache);
+		/* We keep this list in LRU order. */
+		if ((rdstate->uds_access + RDCACHE_JIFFIES) > jiffies)
+			break;
+		itopd(inode)->uii_rdcount--;
+		list_del(&rdstate->uds_cache);
+		free_rdstate(rdstate);
+	}
+	spin_unlock(&itopd(inode)->uii_rdlock);
+
+	return 0;
+}
+
+/*
+ * Used only in nfs, to kill any pending RPC tasks, so that subsequent
+ * code can actually succeed and won't leave tasks that need handling.
+ *
+ * PS. I wonder if this is somehow useful to undo damage that was
+ * left in the kernel after a user level file server (such as amd)
+ * dies.
+ */
+static void unionfs_umount_begin(struct vfsmount *mnt, int flags)
+{
+	struct super_block *sb, *hidden_sb;
+	struct vfsmount *hidden_mnt;
+	int bindex, bstart, bend;
+
+	if (!(flags & MNT_FORCE))
+		/* we are not being MNT_FORCEd, therefore we should emulate old
+		 * behaviour
+		 */
+		return;
+
+	sb = mnt->mnt_sb;
+
+	bstart = sbstart(sb);
+	bend = sbend(sb);
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		hidden_mnt = stohiddenmnt_index(sb, bindex);
+		hidden_sb = stohs_index(sb, bindex);
+
+		if (hidden_mnt && hidden_sb && hidden_sb->s_op &&
+		    hidden_sb->s_op->umount_begin)
+			hidden_sb->s_op->umount_begin(hidden_mnt, flags);
+	}
+}
+
+static int unionfs_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+	int ret = 0;
+	char *tmp_page;
+	char *path;
+	int bindex, bstart, bend;
+	int perms;
+
+	lock_dentry(sb->s_root);
+
+	tmp_page = (char*) __get_free_page(GFP_KERNEL);
+	if (!tmp_page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	bindex = bstart = sbstart(sb);
+	bend = sbend(sb);
+
+	seq_printf(m, ",dirs=");
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		path = d_path(dtohd_index(sb->s_root, bindex),
+			   stohiddenmnt_index(sb, bindex), tmp_page,
+			   PAGE_SIZE);
+		perms = branchperms(sb, bindex);
+
+		seq_printf(m, "%s=%s", path,
+			   perms & MAY_WRITE ? "rw" :
+			   perms & MAY_NFSRO ? "nfsro" : "ro");
+		if (bindex != bend) {
+			seq_printf(m, ":");
+		}
+	}
+
+out:
+	if (tmp_page)
+		free_page((unsigned long) tmp_page);
+
+	unlock_dentry(sb->s_root);
+
+	return ret;
+}
+
+struct super_operations unionfs_sops = {
+	.read_inode = unionfs_read_inode,
+	.put_inode = unionfs_put_inode,
+	.delete_inode = unionfs_delete_inode,
+	.put_super = unionfs_put_super,
+	.statfs = unionfs_statfs,
+	.remount_fs = unionfs_remount_fs,
+	.clear_inode = unionfs_clear_inode,
+	.umount_begin = unionfs_umount_begin,
+	.show_options = unionfs_show_options,
+	.write_inode = unionfs_write_inode,
+	.alloc_inode = unionfs_alloc_inode,
+	.destroy_inode = unionfs_destroy_inode,
+};
+
