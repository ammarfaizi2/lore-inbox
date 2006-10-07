Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWJGF6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWJGF6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWJGF5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:57:01 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:13489 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932721AbWJGF4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:56:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 23] Unionfs: Main module functions
Message-Id: <e107be2f4ead5bbb79f1.1160197651@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:31 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Module init & cleanup code, as well as interposition functions.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 695 insertions(+)
fs/unionfs/main.c |  695 +++++++++++++++++++++++++++++++++++++++++++++++++++++

diff -r 0f1852653e5d -r e107be2f4ead fs/unionfs/main.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/main.c	Sat Oct 07 00:46:19 2006 -0400
@@ -0,0 +1,695 @@
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
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "union.h"
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+/* declarations added for "sparse" */
+extern void unionfs_kill_block_super(struct super_block *sb);
+
+/* declarations added for malloc_debugging */
+
+/* sb we pass is unionfs's super_block */
+int unionfs_interpose(struct dentry *dentry, struct super_block *sb, int flag)
+{
+	struct inode *hidden_inode;
+	struct dentry *hidden_dentry;
+	int err = 0;
+	struct inode *inode;
+	int is_negative_dentry = 1;
+	int bindex, bstart, bend;
+
+	verify_locked(dentry);
+
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+
+	/* Make sure that we didn't get a negative dentry. */
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		if (dtohd_index(dentry, bindex) &&
+		    dtohd_index(dentry, bindex)->d_inode) {
+			is_negative_dentry = 0;
+			break;
+		}
+	}
+	BUG_ON(is_negative_dentry);
+
+	/* We allocate our new inode below, by calling iget.
+	 * iget will call our read_inode which will initialize some
+	 * of the new inode's fields
+	 */
+
+	/* On revalidate we've already got our own inode and just need
+	 * to fix it up. */
+	if (flag == INTERPOSE_REVAL) {
+		inode = dentry->d_inode;
+		itopd(inode)->b_start = -1;
+		itopd(inode)->b_end = -1;
+		atomic_set(&itopd(inode)->uii_generation,
+			   atomic_read(&stopd(sb)->usi_generation));
+
+		itohi_ptr(inode) =
+		    kcalloc(sbmax(sb), sizeof(struct inode *), GFP_KERNEL);
+		if (!itohi_ptr(inode)) {
+			err = -ENOMEM;
+			goto out;
+		}
+		mutex_lock(&inode->i_mutex);
+	} else {
+		ino_t ino;
+		/* get unique inode number for unionfs */
+		ino = iunique(sb, UNIONFS_ROOT_INO);
+
+		inode = iget(sb, ino);
+		if (!inode) {
+			err = -EACCES;	/* should be impossible??? */
+			goto out;
+		}
+
+		mutex_lock(&inode->i_mutex);
+		if (atomic_read(&inode->i_count) > 1)
+			goto skip;
+	}
+
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		hidden_dentry = dtohd_index(dentry, bindex);
+		if (!hidden_dentry) {
+			set_itohi_index(inode, bindex, NULL);
+			continue;
+		}
+
+		/* Initialize the hidden inode to the new hidden inode. */
+		if (!hidden_dentry->d_inode)
+			continue;
+
+		set_itohi_index(inode, bindex, igrab(hidden_dentry->d_inode));
+	}
+
+	ibstart(inode) = dbstart(dentry);
+	ibend(inode) = dbend(dentry);
+
+	/* Use attributes from the first branch. */
+	hidden_inode = itohi(inode);
+
+	/* Use different set of inode ops for symlinks & directories */
+	if (S_ISLNK(hidden_inode->i_mode))
+		inode->i_op = &unionfs_symlink_iops;
+	else if (S_ISDIR(hidden_inode->i_mode))
+		inode->i_op = &unionfs_dir_iops;
+
+	/* Use different set of file ops for directories */
+	if (S_ISDIR(hidden_inode->i_mode))
+		inode->i_fop = &unionfs_dir_fops;
+
+	/* properly initialize special inodes */
+	if (S_ISBLK(hidden_inode->i_mode) || S_ISCHR(hidden_inode->i_mode) ||
+	    S_ISFIFO(hidden_inode->i_mode) || S_ISSOCK(hidden_inode->i_mode))
+		init_special_inode(inode, hidden_inode->i_mode,
+				   hidden_inode->i_rdev);
+	/* Fix our inode's address operations to that of the lower inode (Unionfs is FiST-Lite) */
+	if (inode->i_mapping->a_ops != hidden_inode->i_mapping->a_ops)
+		inode->i_mapping->a_ops = hidden_inode->i_mapping->a_ops;
+
+	/* all well, copy inode attributes */
+	fist_copy_attr_all(inode, hidden_inode);
+
+skip:
+	/* only (our) lookup wants to do a d_add */
+	switch (flag) {
+		case INTERPOSE_DEFAULT:
+		case INTERPOSE_REVAL_NEG:
+			d_instantiate(dentry, inode);
+			break;
+		case INTERPOSE_LOOKUP:
+			err = PTR_ERR(d_splice_alias(inode, dentry));
+			break;
+		case INTERPOSE_REVAL:
+			/* Do nothing. */
+			break;
+		default:
+			printk(KERN_ERR "Invalid interpose flag passed!");
+			BUG();
+	}
+
+	mutex_unlock(&inode->i_mutex);
+
+out:
+	return err;
+}
+
+void unionfs_reinterpose(struct dentry *dentry)
+{
+	struct dentry *hidden_dentry;
+	struct inode *inode;
+	int bindex, bstart, bend;
+
+	verify_locked(dentry);
+
+	/* This is pre-allocated inode */
+	inode = dentry->d_inode;
+
+	bstart = dbstart(dentry);
+	bend = dbend(dentry);
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		hidden_dentry = dtohd_index(dentry, bindex);
+		if (!hidden_dentry)
+			continue;
+
+		if (!hidden_dentry->d_inode)
+			continue;
+		if (itohi_index(inode, bindex))
+			continue;
+		set_itohi_index(inode, bindex, igrab(hidden_dentry->d_inode));
+	}
+	ibstart(inode) = dbstart(dentry);
+	ibend(inode) = dbend(dentry);
+}
+
+int check_branch(struct nameidata *nd)
+{
+	if (!strcmp(nd->dentry->d_sb->s_type->name, "unionfs"))
+		return -EINVAL;
+	if (!nd->dentry->d_inode)
+		return -ENOENT;
+	if (!S_ISDIR(nd->dentry->d_inode->i_mode))
+		return -ENOTDIR;
+	return 0;
+}
+
+/* checks if two hidden_dentries have overlapping branches */
+int is_branch_overlap(struct dentry *dent1, struct dentry *dent2)
+{
+	struct dentry *dent = NULL;
+
+	dent = dent1;
+	while ((dent != dent2) && (dent->d_parent != dent))
+		dent = dent->d_parent;
+
+	if (dent == dent2)
+		return 1;
+
+	dent = dent2;
+	while ((dent != dent1) && (dent->d_parent != dent))
+		dent = dent->d_parent;
+
+	return (dent == dent1);
+}
+static int parse_branch_mode(char *name)
+{
+	int perms;
+	int l = strlen(name);
+	if (!strcmp(name + l - 3, "=ro")) {
+		perms = MAY_READ;
+		name[l - 3] = '\0';
+	} else if (!strcmp(name + l - 6, "=nfsro")) {
+		perms = MAY_READ | MAY_NFSRO;
+		name[l - 6] = '\0';
+	} else if (!strcmp(name + l - 3, "=rw")) {
+		perms = MAY_READ | MAY_WRITE;
+		name[l - 3] = '\0';
+	} else
+		perms = MAY_READ | MAY_WRITE;
+
+	return perms;
+}
+
+static int parse_dirs_option(struct super_block *sb, struct unionfs_dentry_info
+			     *hidden_root_info, char *options)
+{
+	struct nameidata nd;
+	char *name;
+	int err = 0;
+	int branches = 1;
+	int bindex = 0;
+	int i = 0;
+	int j = 0;
+
+	struct dentry *dent1;
+	struct dentry *dent2;
+
+	if (options[0] == '\0') {
+		printk(KERN_WARNING "unionfs: no branches specified\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Each colon means we have a separator, this is really just a rough
+	 * guess, since strsep will handle empty fields for us. */
+	for (i = 0; options[i]; i++)
+		if (options[i] == ':')
+			branches++;
+
+	/* allocate space for underlying pointers to hidden dentry */
+	if (!(stopd(sb)->usi_data = alloc_new_data(branches))) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (!(hidden_root_info->udi_dentry = alloc_new_dentries(branches))) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	hidden_root_info->udi_mnt = kcalloc(branches,
+			sizeof(struct vfsmount *), GFP_KERNEL);
+	if (!hidden_root_info->udi_mnt) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* now parsing the string b1:b2=rw:b3=ro:b4 */
+	branches = 0;
+	while ((name = strsep(&options, ":")) != NULL) {
+		int perms;
+
+		if (!*name)
+			continue;
+
+		branches++;
+
+		/* strip off =rw or =ro if it is specified. */
+		perms = parse_branch_mode(name);
+		if (!bindex && !(perms & MAY_WRITE)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = path_lookup(name, LOOKUP_FOLLOW, &nd);
+		if (err) {
+			printk(KERN_WARNING "unionfs: error accessing "
+			       "hidden directory '%s' (error %d)\n", name, err);
+			goto out;
+		}
+
+		if ((err = check_branch(&nd))) {
+			printk(KERN_WARNING "unionfs: hidden directory "
+			       "'%s' is not a valid branch\n", name);
+			path_release(&nd);
+			goto out;
+		}
+
+		hidden_root_info->udi_dentry[bindex] = nd.dentry;
+		hidden_root_info->udi_mnt[bindex] = nd.mnt;
+
+		set_branchperms(sb, bindex, perms);
+		set_branch_count(sb, bindex, 0);
+
+		if (hidden_root_info->udi_bstart < 0)
+			hidden_root_info->udi_bstart = bindex;
+		hidden_root_info->udi_bend = bindex;
+		bindex++;
+	}
+
+	if (branches == 0) {
+		printk(KERN_WARNING "unionfs: no branches specified\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	BUG_ON(branches != (hidden_root_info->udi_bend + 1));
+
+	/* ensure that no overlaps exist in the branches */
+	for (i = 0; i < branches; i++) {
+		for (j = i + 1; j < branches; j++) {
+			dent1 = hidden_root_info->udi_dentry[i];
+			dent2 = hidden_root_info->udi_dentry[j];
+
+			if (is_branch_overlap(dent1, dent2)) {
+				printk(KERN_WARNING "unionfs: branches %d and %d overlap\n", i, j);
+				err = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+out:
+	if (err) {
+		for (i = 0; i < branches; i++)
+			if (hidden_root_info->udi_dentry[i]) {
+				dput(hidden_root_info->udi_dentry[i]);
+				mntput(hidden_root_info->udi_mnt[i]);
+			}
+
+		kfree(hidden_root_info->udi_dentry);
+		kfree(hidden_root_info->udi_mnt);
+		kfree(stopd(sb)->usi_data);
+
+		/* MUST clear the pointers to prevent potential double free if
+		 * the caller dies later on
+		 */
+		hidden_root_info->udi_dentry = NULL;
+		hidden_root_info->udi_mnt = NULL;
+		stopd(sb)->usi_data = NULL;
+	}
+	return err;
+}
+
+/*
+ * Parse mount options.  See the manual page for usage instructions.
+ *
+ * Returns the dentry object of the lower-level (hidden) directory;
+ * We want to mount our stackable file system on top of that hidden directory.
+ *
+ * Sets default debugging level to N, if any.
+ */
+static struct unionfs_dentry_info *unionfs_parse_options(struct super_block *sb,
+							 char *options)
+{
+	struct unionfs_dentry_info *hidden_root_info;
+	char *optname;
+	int err = 0;
+	int bindex;
+	int dirsfound = 0;
+
+	/* allocate private data area */
+	err = -ENOMEM;
+	hidden_root_info =
+	    kzalloc(sizeof(struct unionfs_dentry_info), GFP_KERNEL);
+	if (!hidden_root_info)
+		goto out_error;
+	hidden_root_info->udi_bstart = -1;
+	hidden_root_info->udi_bend = -1;
+	hidden_root_info->udi_bopaque = -1;
+
+	while ((optname = strsep(&options, ",")) != NULL) {
+		char *optarg;
+		char *endptr;
+		int intval;
+
+		if (!*optname)
+			continue;
+
+		optarg = strchr(optname, '=');
+		if (optarg)
+			*optarg++ = '\0';
+
+		/* All of our options take an argument now. Insert ones that
+		 * don't, above this check.  */
+		if (!optarg) {
+			printk("unionfs: %s requires an argument.\n", optname);
+			err = -EINVAL;
+			goto out_error;
+		}
+
+		if (!strcmp("dirs", optname)) {
+			if (++dirsfound > 1) {
+				printk(KERN_WARNING
+				       "unionfs: multiple dirs specified\n");
+				err = -EINVAL;
+				goto out_error;
+			}
+			err = parse_dirs_option(sb, hidden_root_info, optarg);
+			if (err)
+				goto out_error;
+			continue;
+		}
+
+		/* All of these options require an integer argument. */
+		intval = simple_strtoul(optarg, &endptr, 0);
+		if (*endptr) {
+			printk(KERN_WARNING
+			       "unionfs: invalid %s option '%s'\n",
+			       optname, optarg);
+			err = -EINVAL;
+			goto out_error;
+		}
+
+		err = -EINVAL;
+		printk(KERN_WARNING
+		       "unionfs: unrecognized option '%s'\n", optname);
+		goto out_error;
+	}
+	if (dirsfound != 1) {
+		printk(KERN_WARNING "unionfs: dirs option required\n");
+		err = -EINVAL;
+		goto out_error;
+	}
+	goto out;
+
+out_error:
+	if (hidden_root_info && hidden_root_info->udi_dentry) {
+		for (bindex = hidden_root_info->udi_bstart;
+		     bindex >= 0 && bindex <= hidden_root_info->udi_bend;
+		     bindex++) {
+			struct dentry *d;
+			struct vfsmount *m;
+
+			d = hidden_root_info->udi_dentry[bindex];
+			m = hidden_root_info->udi_mnt[bindex];
+
+			dput(d);
+
+			if (m)
+				mntput(m);
+		}
+	}
+
+	kfree(hidden_root_info->udi_dentry);
+	kfree(hidden_root_info);
+
+	kfree(stopd(sb)->usi_data);
+	stopd(sb)->usi_data = NULL;
+
+	hidden_root_info = ERR_PTR(err);
+out:
+	return hidden_root_info;
+}
+
+static struct dentry *unionfs_d_alloc_root(struct super_block *sb)
+{
+	struct dentry *ret = NULL;
+
+	if (sb) {
+		static const struct qstr name = {.name = "/",.len = 1 };
+
+		ret = d_alloc(NULL, &name);
+		if (ret) {
+			ret->d_op = &unionfs_dops;
+			ret->d_sb = sb;
+			ret->d_parent = ret;
+		}
+	}
+	return ret;
+}
+
+static int unionfs_read_super(struct super_block *sb, void *raw_data,
+			      int silent)
+{
+	int err = 0;
+
+	struct unionfs_dentry_info *hidden_root_info = NULL;
+	int bindex, bstart, bend;
+
+	if (!raw_data) {
+		printk(KERN_WARNING
+		       "unionfs_read_super: missing data argument\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Allocate superblock private data
+	 */
+	stopd_lhs(sb) = kzalloc(sizeof(struct unionfs_sb_info), GFP_KERNEL);
+	if (!stopd(sb)) {
+		printk(KERN_WARNING "%s: out of memory\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto out;
+	}
+	stopd(sb)->b_end = -1;
+	atomic_set(&stopd(sb)->usi_generation, 1);
+	init_rwsem(&stopd(sb)->usi_rwsem);
+
+	hidden_root_info = unionfs_parse_options(sb, raw_data);
+	if (IS_ERR(hidden_root_info)) {
+		printk(KERN_WARNING
+		       "unionfs_read_super: error while parsing options (err = %ld)\n",
+		       PTR_ERR(hidden_root_info));
+		err = PTR_ERR(hidden_root_info);
+		hidden_root_info = NULL;
+		goto out_free;
+	}
+	if (hidden_root_info->udi_bstart == -1) {
+		err = -ENOENT;
+		goto out_free;
+	}
+
+	/* set the hidden superblock field of upper superblock */
+	bstart = hidden_root_info->udi_bstart;
+	BUG_ON(bstart != 0);
+	sbend(sb) = bend = hidden_root_info->udi_bend;
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		struct dentry *d;
+
+		d = hidden_root_info->udi_dentry[bindex];
+
+		set_stohs_index(sb, bindex, d->d_sb);
+	}
+
+	/* Unionfs: Max Bytes is the maximum bytes from highest priority branch */
+	sb->s_maxbytes = stohs_index(sb, 0)->s_maxbytes;
+
+	sb->s_op = &unionfs_sops;
+
+	/*
+	 * we can't use d_alloc_root if we want to use
+	 * our own interpose function unchanged,
+	 * so we simply call our own "fake" d_alloc_root
+	 */
+	sb->s_root = unionfs_d_alloc_root(sb);
+	if (!sb->s_root) {
+		err = -ENOMEM;
+		goto out_dput;
+	}
+
+	/* link the upper and lower dentries */
+	dtopd_lhs(sb->s_root) = NULL;
+	if ((err = new_dentry_private_data(sb->s_root)))
+		goto out_freedpd;
+
+	/* Set the hidden dentries for s_root */
+	for (bindex = bstart; bindex <= bend; bindex++) {
+		struct dentry *d;
+		struct vfsmount *m;
+
+		d = hidden_root_info->udi_dentry[bindex];
+		m = hidden_root_info->udi_mnt[bindex];
+
+		set_dtohd_index(sb->s_root, bindex, d);
+		set_dtohm_index(sb->s_root, bindex, m);
+	}
+	set_dbstart(sb->s_root, bstart);
+	set_dbend(sb->s_root, bend);
+
+	/* Set the generation number to one, since this is for the mount. */
+	atomic_set(&dtopd(sb->s_root)->udi_generation, 1);
+
+	/* call interpose to create the upper level inode */
+	if ((err = unionfs_interpose(sb->s_root, sb, 0)))
+		goto out_freedpd;
+	unlock_dentry(sb->s_root);
+	goto out;
+
+out_freedpd:
+	if (dtopd(sb->s_root)) {
+		kfree(dtohd_ptr(sb->s_root));
+		free_dentry_private_data(dtopd(sb->s_root));
+	}
+	dput(sb->s_root);
+
+out_dput:
+	if (hidden_root_info && !IS_ERR(hidden_root_info)) {
+		for (bindex = hidden_root_info->udi_bstart;
+		     bindex <= hidden_root_info->udi_bend; bindex++) {
+			struct dentry *d;
+			struct vfsmount *m;
+
+			d = hidden_root_info->udi_dentry[bindex];
+			m = hidden_root_info->udi_mnt[bindex];
+
+			if (d)
+				dput(d);
+
+			if (m)
+				mntput(m);
+		}
+		kfree(hidden_root_info->udi_dentry);
+		kfree(hidden_root_info);
+		hidden_root_info = NULL;
+	}
+
+out_free:
+	kfree(stopd(sb)->usi_data);
+	kfree(stopd(sb));
+	stopd_lhs(sb) = NULL;
+
+out:
+	if (hidden_root_info && !IS_ERR(hidden_root_info)) {
+		kfree(hidden_root_info->udi_dentry);
+		kfree(hidden_root_info);
+	}
+	return err;
+}
+
+static int unionfs_get_sb(struct file_system_type *fs_type,
+			  int flags, const char *dev_name,
+			  void *raw_data, struct vfsmount *mnt)
+{
+	return get_sb_nodev(fs_type, flags, raw_data, unionfs_read_super, mnt);
+}
+
+void unionfs_kill_block_super(struct super_block *sb)
+{
+	generic_shutdown_super(sb);
+}
+
+static struct file_system_type unionfs_fs_type = {
+	.owner = THIS_MODULE,
+	.name = "unionfs",
+	.get_sb = unionfs_get_sb,
+	.kill_sb = unionfs_kill_block_super,
+	.fs_flags = FS_REVAL_DOT,
+};
+
+static int init_debug = 0;
+module_param_named(debug, init_debug, int, S_IRUGO);
+MODULE_PARM_DESC(debug, "Initial Unionfs debug value.");
+
+static int __init init_unionfs_fs(void)
+{
+	int err;
+	printk("Registering unionfs " UNIONFS_VERSION "\n");
+
+	if ((err = init_filldir_cache()))
+		goto out;
+	if ((err = init_inode_cache()))
+		goto out;
+	if ((err = init_dentry_cache()))
+		goto out;
+	if ((err = init_sioq()))
+		goto out;
+	err = register_filesystem(&unionfs_fs_type);
+out:
+	if (err) {
+		fin_sioq();
+		destroy_filldir_cache();
+		destroy_inode_cache();
+		destroy_dentry_cache();
+	}
+	return err;
+}
+static void __exit exit_unionfs_fs(void)
+{
+	fin_sioq();
+	destroy_filldir_cache();
+	destroy_inode_cache();
+	destroy_dentry_cache();
+	unregister_filesystem(&unionfs_fs_type);
+	printk("Completed unionfs module unload.\n");
+}
+
+MODULE_AUTHOR("Erez Zadok, Filesystems and Storage Lab, Stony Brook University"
+		" (http://www.fsl.cs.sunysb.edu)");
+MODULE_DESCRIPTION("Unionfs " UNIONFS_VERSION
+		" (http://www.unionfs.org)");
+MODULE_LICENSE("GPL");
+
+module_init(init_unionfs_fs);
+module_exit(exit_unionfs_fs);
+


