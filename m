Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUK2TAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUK2TAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUK2TAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:00:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26281 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261514AbUK2Syv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:54:51 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM: 4/10 CKRM:  Full rcfs support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19721.1101754104.1@us.ibm.com>
Date: Mon, 29 Nov 2004 10:48:24 -0800
Message-Id: <E1CYqZU-000588-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates CKRM Resource Control Filesystem (rcfs) to include full
directory structure support.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>


Index: linux-2.6.10-rc2/fs/Makefile
===================================================================
--- linux-2.6.10-rc2.orig/fs/Makefile	2004-11-14 17:27:52.000000000 -0800
+++ linux-2.6.10-rc2/fs/Makefile	2004-11-19 20:44:18.255709415 -0800
@@ -92,5 +92,6 @@
 obj-$(CONFIG_XFS_FS)		+= xfs/
 obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
+obj-$(CONFIG_RCFS_FS)		+= rcfs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
Index: linux-2.6.10-rc2/fs/rcfs/dir.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/fs/rcfs/dir.c	2004-11-19 20:44:18.261708464 -0800
@@ -0,0 +1,300 @@
+/* 
+ * fs/rcfs/dir.c 
+ *
+ * Copyright (C) Shailabh Nagar,  IBM Corp. 2004
+ *               Vivek Kashyap,   IBM Corp. 2004
+ *           
+ * 
+ * Directory operations for rcfs
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Changes
+ *
+ * 08 Mar 2004
+ *        Created.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/namespace.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/parser.h>
+
+#include <asm/uaccess.h>
+
+#include <linux/rcfs.h>
+
+#define rcfs_positive(dentry)  ((dentry)->d_inode && !d_unhashed((dentry)))
+
+int rcfs_empty(struct dentry *dentry)
+{
+	struct dentry *child;
+	int ret = 0;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(child, &dentry->d_subdirs, d_child)
+	    if (!rcfs_is_magic(child) && rcfs_positive(child))
+		goto out;
+	ret = 1;
+out:
+	spin_unlock(&dcache_lock);
+	return ret;
+}
+
+/* Directory inode operations */
+
+int
+rcfs_create(struct inode *dir, struct dentry *dentry, int mode,
+	    struct nameidata *nd)
+{
+	return rcfs_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+EXPORT_SYMBOL_GPL(rcfs_create);
+
+/* Symlinks permitted ?? */
+int rcfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	struct inode *inode;
+	int error = -ENOSPC;
+
+	inode = rcfs_get_inode(dir->i_sb, S_IFLNK | S_IRWXUGO, 0);
+	if (inode) {
+		int l = strlen(symname) + 1;
+		error = page_symlink(inode, symname, l);
+		if (!error) {
+			if (dir->i_mode & S_ISGID)
+				inode->i_gid = dir->i_gid;
+			d_instantiate(dentry, inode);
+			dget(dentry);
+		} else
+			iput(inode);
+	}
+	return error;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_symlink);
+
+int rcfs_create_coredir(struct inode *dir, struct dentry *dentry)
+{
+
+	struct rcfs_inode_info *ripar, *ridir;
+	int sz;
+
+	ripar = RCFS_I(dir);
+	ridir = RCFS_I(dentry->d_inode);
+	/* Inform resource controllers - do Core operations */
+	if (ckrm_is_core_valid(ripar->core)) {
+		sz = strlen(ripar->name) + strlen(dentry->d_name.name) + 2;
+		ridir->name = kmalloc(sz, GFP_KERNEL);
+		if (!ridir->name) {
+			return -ENOMEM;
+		}
+		snprintf(ridir->name, sz, "%s/%s", ripar->name,
+			 dentry->d_name.name);
+		ridir->core = (*(ripar->core->classtype->alloc))
+		    (ripar->core, ridir->name);
+	} else {
+		printk(KERN_ERR "rcfs_mkdir: Invalid parent core %p\n",
+		       ripar->core);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_create_coredir);
+
+int rcfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+
+	int retval = 0;
+	ckrm_classtype_t *clstype;
+
+#if 0
+	struct dentry *pd = list_entry(dir->i_dentry.next, struct dentry,
+				       d_alias);
+	if ((!strcmp(pd->d_name.name, "/") &&
+	     !strcmp(dentry->d_name.name, "ce"))) {
+		/* Call CE's mkdir if it has registered, else fail. */
+		if (rcfs_eng_callbacks.mkdir) {
+			return (*rcfs_eng_callbacks.mkdir) (dir, dentry, mode);
+		} else {
+			return -EINVAL;
+		}
+	}
+#endif
+	if (_rcfs_mknod(dir, dentry, mode | S_IFDIR, 0)) {
+		printk(KERN_ERR "rcfs_mkdir: error in _rcfs_mknod\n");
+		return retval;
+	}
+	dir->i_nlink++;
+	/* Inherit parent's ops since _rcfs_mknod assigns noperm ops. */
+	dentry->d_inode->i_op = dir->i_op;
+	dentry->d_inode->i_fop = dir->i_fop;
+	retval = rcfs_create_coredir(dir, dentry);
+	if (retval) {
+		simple_rmdir(dir, dentry);
+		return retval;
+	}
+	/* create the default set of magic files */
+	clstype = (RCFS_I(dentry->d_inode))->core->classtype;
+	rcfs_create_magic(dentry, &(((struct rcfs_magf *)clstype->mfdesc)[1]),
+			  clstype->mfcount - 3);
+	return retval;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_mkdir);
+
+int rcfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct rcfs_inode_info *ri = RCFS_I(dentry->d_inode);
+
+#if 0
+	struct dentry *pd = list_entry(dir->i_dentry.next,
+				       struct dentry, d_alias);
+	if ((!strcmp(pd->d_name.name, "/") &&
+	     !strcmp(dentry->d_name.name, "ce"))) {
+		// Call CE's mkdir if it has registered, else fail.
+		if (rcfs_eng_callbacks.rmdir) {
+			return (*rcfs_eng_callbacks.rmdir) (dir, dentry);
+		} else {
+			return simple_rmdir(dir, dentry);
+		}
+	} else if ((!strcmp(pd->d_name.name, "/") &&
+		    !strcmp(dentry->d_name.name, "network"))) {
+		return -EPERM;
+	}
+#endif
+	if (!rcfs_empty(dentry)) {
+		printk(KERN_ERR "rcfs_rmdir: directory not empty\n");
+		return -ENOTEMPTY;
+	}
+	/* Core class removal  */
+
+	if (ri->core == NULL) {
+		printk(KERN_ERR "rcfs_rmdir: core==NULL\n");
+		// likely a race condition
+		return 0;
+	}
+
+	if ((*(ri->core->classtype->free)) (ri->core)) {
+		printk(KERN_ERR "rcfs_rmdir: ckrm_free_core_class failed\n");
+		goto out;
+	}
+	ri->core = NULL;	// just to be safe 
+
+	/* Clear magic files only after core successfully removed */
+	rcfs_clear_magic(dentry);
+
+	return simple_rmdir(dir, dentry);
+
+out:
+	return -EBUSY;
+}
+
+EXPORT_SYMBOL(rcfs_rmdir);
+
+int rcfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	// -ENOENT and not -ENOPERM to allow rm -rf to work despite 
+	// magic files being present
+	return -ENOENT;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_unlink);
+
+/* rename is allowed on directories only */
+int
+rcfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+	    struct inode *new_dir, struct dentry *new_dentry)
+{
+	if (S_ISDIR(old_dentry->d_inode->i_mode))
+		return simple_rename(old_dir, old_dentry, new_dir, new_dentry);
+	else
+		return -EINVAL;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_rename);
+
+struct inode_operations rcfs_dir_inode_operations = {
+	.create = rcfs_create,
+	.lookup = simple_lookup,
+	.link = simple_link,
+	.unlink = rcfs_unlink,
+	.symlink = rcfs_symlink,
+	.mkdir = rcfs_mkdir,
+	.rmdir = rcfs_rmdir,
+	.mknod = rcfs_mknod,
+	.rename = rcfs_rename,
+};
+
+int
+rcfs_root_create(struct inode *dir, struct dentry *dentry, int mode,
+		 struct nameidata *nd)
+{
+	return -EPERM;
+}
+
+int
+rcfs_root_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	return -EPERM;
+}
+
+int rcfs_root_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	return -EPERM;
+}
+
+int rcfs_root_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	return -EPERM;
+}
+
+int rcfs_root_unlink(struct inode *dir, struct dentry *dentry)
+{
+	return -EPERM;
+}
+
+int
+rcfs_root_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	return -EPERM;
+}
+
+int
+rcfs_root_rename(struct inode *old_dir, struct dentry *old_dentry,
+		 struct inode *new_dir, struct dentry *new_dentry)
+{
+	return -EPERM;
+}
+
+struct inode_operations rcfs_rootdir_inode_operations = {
+	.create = rcfs_root_create,
+	.lookup = simple_lookup,
+	.link = simple_link,
+	.unlink = rcfs_root_unlink,
+	.symlink = rcfs_root_symlink,
+	.mkdir = rcfs_root_mkdir,
+	.rmdir = rcfs_root_rmdir,
+	.mknod = rcfs_root_mknod,
+	.rename = rcfs_root_rename,
+};
Index: linux-2.6.10-rc2/fs/rcfs/inode.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/fs/rcfs/inode.c	2004-11-19 20:44:18.265707831 -0800
@@ -0,0 +1,189 @@
+/* 
+ * fs/rcfs/inode.c 
+ *
+ * Copyright (C) Shailabh Nagar,  IBM Corp. 2004
+ *               Vivek Kashyap,   IBM Corp. 2004
+ *           
+ * Resource class filesystem (rcfs) forming the 
+ * user interface to Class-based Kernel Resource Management (CKRM).
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 05 Mar 2004
+ *        Created.
+ * 06 Mar 2004
+ *        Parsing for shares added
+ */
+
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/namespace.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/parser.h>
+#include <asm/uaccess.h>
+
+#include <linux/rcfs.h>
+
+/*
+ * Address of variable used as flag to indicate a magic file, 
+ * value unimportant
+ */ 
+int RCFS_IS_MAGIC;
+
+struct inode *rcfs_get_inode(struct super_block *sb, int mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			/* Treat as default assignment */
+			inode->i_op = &rcfs_file_inode_operations;
+			/* inode->i_fop = &rcfs_file_operations; */
+			break;
+		case S_IFDIR:
+			/* inode->i_op = &rcfs_dir_inode_operations; */
+			inode->i_op = &rcfs_rootdir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/*
+			 * directory inodes start off with i_nlink == 2 
+			 *  (for "." entry)
+			 */
+			inode->i_nlink++;
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		}
+	}
+	return inode;
+}
+
+int _rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	struct inode *inode;
+	int error = -EPERM;
+
+	if (dentry->d_inode)
+		return -EEXIST;
+	inode = rcfs_get_inode(dir->i_sb, mode, dev);
+	if (inode) {
+		if (dir->i_mode & S_ISGID) {
+			inode->i_gid = dir->i_gid;
+			if (S_ISDIR(mode))
+				inode->i_mode |= S_ISGID;
+		}
+		d_instantiate(dentry, inode);
+		dget(dentry);
+		error = 0;
+	}
+	return error;
+}
+
+EXPORT_SYMBOL_GPL(_rcfs_mknod);
+
+int rcfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	/* User can only create directories, not files */
+	if ((mode & S_IFMT) != S_IFDIR)
+		return -EINVAL;
+
+	return dir->i_op->mkdir(dir, dentry, mode);
+}
+
+EXPORT_SYMBOL_GPL(rcfs_mknod);
+
+struct dentry *rcfs_create_internal(struct dentry *parent,
+				    struct rcfs_magf *magf, int magic)
+{
+	struct qstr qstr;
+	struct dentry *mfdentry;
+
+	/* Get new dentry for name */
+	qstr.name = magf->name;
+	qstr.len = strlen(magf->name);
+	qstr.hash = full_name_hash(magf->name, qstr.len);
+	mfdentry = lookup_hash(&qstr, parent);
+
+	if (!IS_ERR(mfdentry)) {
+		int err;
+
+		down(&parent->d_inode->i_sem);
+		if (magic && (magf->mode & S_IFDIR))
+			err = parent->d_inode->i_op->mkdir(parent->d_inode,
+							   mfdentry,
+							   magf->mode);
+		else {
+			err = _rcfs_mknod(parent->d_inode, mfdentry,
+					  magf->mode, 0);
+			/*
+			 * _rcfs_mknod doesn't increment parent's link count, 
+			 * i_op->mkdir does.
+			 */
+			parent->d_inode->i_nlink++;
+		}
+		up(&parent->d_inode->i_sem);
+		if (err) {
+			dput(mfdentry);
+			return mfdentry;
+		}
+	}
+	return mfdentry;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_create_internal);
+
+int rcfs_delete_internal(struct dentry *mfdentry)
+{
+	struct dentry *parent;
+
+	if (!mfdentry || !mfdentry->d_parent)
+		return -EINVAL;
+	parent = mfdentry->d_parent;
+	if (!mfdentry->d_inode) {
+		return 0;
+	}
+	down(&mfdentry->d_inode->i_sem);
+	if (S_ISDIR(mfdentry->d_inode->i_mode))
+		simple_rmdir(parent->d_inode, mfdentry);
+	else
+		simple_unlink(parent->d_inode, mfdentry);
+	up(&mfdentry->d_inode->i_sem);
+	d_delete(mfdentry);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_delete_internal);
+
+struct inode_operations rcfs_file_inode_operations = {
+	.getattr = simple_getattr,
+};
Index: linux-2.6.10-rc2/fs/rcfs/magic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/fs/rcfs/magic.c	2004-11-19 20:44:18.272706722 -0800
@@ -0,0 +1,542 @@
+/* 
+ * fs/rcfs/magic.c 
+ *
+ * Copyright (C) Shailabh Nagar,      IBM Corp. 2004
+ *           (C) Vivek Kashyap,       IBM Corp. 2004
+ *           (C) Chandra Seetharaman, IBM Corp. 2004
+ *           (C) Hubertus Franke,     IBM Corp. 2004
+ * 
+ * File operations for common magic files in rcfs, 
+ * the user interface for CKRM. 
+ * 
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/*
+ * Changes
+ *
+ * 23 Apr 2004
+ *        Created from code kept earlier in fs/rcfs/magic_*.c
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/namespace.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/parser.h>
+#include <asm/uaccess.h>
+
+#include <linux/rcfs.h>
+
+/*
+ * Macros
+ *
+ * generic macros to assist in writing magic fileops
+ *
+ */
+
+#define MAGIC_SHOW(FUNC)                                               \
+static int                                                             \
+FUNC ## _show(struct seq_file *s, void *v)			       \
+{								       \
+	int rc=0;                                                      \
+        ssize_t precnt;                                                \
+	ckrm_core_class_t *core ;				       \
+								       \
+	core = (ckrm_core_class_t *)                                   \
+		(((struct rcfs_inode_info *)s->private)->core);	       \
+								       \
+	if (!ckrm_is_core_valid(core)) {			       \
+		return -EINVAL;					       \
+        }                                                              \
+        precnt = s->count ;                                            \
+	if (core->classtype->show_ ## FUNC)			       \
+		rc = (* core->classtype->show_ ## FUNC)(core, s);      \
+                                                                       \
+        if (s->count == precnt)                                        \
+		seq_printf(s, "No data to display\n");                 \
+	return rc;						       \
+};
+
+#define MAGIC_OPEN(FUNC)                                               \
+static int                                                             \
+FUNC ## _open(struct inode *inode, struct file *file)                  \
+{                                                                      \
+	struct rcfs_inode_info *ri;                                    \
+	int ret=-EINVAL;                                               \
+								       \
+	if (file->f_dentry && file->f_dentry->d_parent) {	       \
+								       \
+		ri = RCFS_I(file->f_dentry->d_parent->d_inode);	       \
+		ret = single_open(file,FUNC ## _show, (void *)ri);     \
+	}							       \
+	return ret;						       \
+}
+
+#define MAGIC_CLOSE(FUNC)                                              \
+static int                                                             \
+FUNC ## _close(struct inode *inode, struct file *file)		       \
+{								       \
+	return single_release(inode,file);			       \
+}
+
+#define MAGIC_PARSE(FUNC)                                              \
+static int                                                             \
+FUNC ## _parse(char *options, char **resstr, char **otherstr)	       \
+{								       \
+	char *p;						       \
+	*resstr = NULL;                                                \
+								       \
+	if (!options)						       \
+		return 0;					       \
+								       \
+	while ((p = strsep(&options, ",")) != NULL) {		       \
+		substring_t args[MAX_OPT_ARGS];			       \
+		int token;					       \
+								       \
+		if (!*p)					       \
+			continue;				       \
+								       \
+		token = match_token(p, FUNC##_tokens, args);           \
+		switch (token) {				       \
+		case FUNC ## _res_type:			               \
+			*resstr = match_strdup(args);		       \
+			if (!strcmp(#FUNC, "config")) {		       \
+				char *str = p + strlen(p) + 1;	       \
+				*otherstr = kmalloc(strlen(str) + 1,   \
+							 GFP_KERNEL);  \
+				if (*otherstr == NULL) {	       \
+					kfree(*resstr);		       \
+					*resstr = NULL;		       \
+					return 0;		       \
+				} else {			       \
+					strcpy(*otherstr, str);	       \
+					return 1;		       \
+				}				       \
+			}					       \
+			break;					       \
+		case FUNC ## _str:			               \
+			*otherstr = match_strdup(args);		       \
+			break;					       \
+		default:					       \
+			return 0;				       \
+		}                                                      \
+	}                                                              \
+	return (*resstr != NULL);				       \
+}
+
+#define MAGIC_WRITE(FUNC,CLSTYPEFUN)                                   \
+static ssize_t                                                         \
+FUNC ## _write(struct file *file, const char __user *buf,	       \
+			   size_t count, loff_t *ppos)		       \
+{								       \
+	struct rcfs_inode_info *ri = 				       \
+		RCFS_I(file->f_dentry->d_parent->d_inode);	       \
+	char *optbuf, *otherstr=NULL, *resname=NULL;		       \
+	int done, rc = 0;					       \
+	ckrm_core_class_t *core ;				       \
+								       \
+	core = ri->core;					       \
+	if (!ckrm_is_core_valid(core)) 				       \
+		return -EINVAL;					       \
+								       \
+	if ((ssize_t) count < 0 				       \
+	    || (ssize_t) count > FUNC ## _max_input_size)              \
+		return -EINVAL;					       \
+								       \
+	if (!access_ok(VERIFY_READ, buf, count))		       \
+		return -EFAULT;					       \
+								       \
+	down(&(ri->vfs_inode.i_sem));				       \
+								       \
+	optbuf = kmalloc(FUNC ## _max_input_size, GFP_KERNEL);         \
+	__copy_from_user(optbuf, buf, count);			       \
+	if (optbuf[count-1] == '\n')				       \
+		optbuf[count-1]='\0';				       \
+								       \
+	done = FUNC ## _parse(optbuf, &resname, &otherstr);            \
+								       \
+	if (!done) {						       \
+		printk(KERN_ERR "Error parsing FUNC \n");	       \
+		goto FUNC ## _write_out;			       \
+	}							       \
+								       \
+	if (core->classtype-> CLSTYPEFUN) {		               \
+		rc = (*core->classtype->CLSTYPEFUN)	               \
+			(core, resname, otherstr);		       \
+		if (rc) {					       \
+			printk(KERN_ERR "FUNC_write: CLSTYPEFUN error\n");   \
+			goto FUNC ## _write_out; 	               \
+		}						       \
+	}							       \
+								       \
+FUNC ## _write_out:						       \
+	up(&(ri->vfs_inode.i_sem));				       \
+	kfree(optbuf);						       \
+	kfree(otherstr);					       \
+	kfree(resname);						       \
+	return rc ? rc : count;					       \
+}
+
+#define MAGIC_RD_FILEOPS(FUNC)                                         \
+struct file_operations FUNC ## _fileops = {                            \
+	.open           = FUNC ## _open,			       \
+	.read           = seq_read,				       \
+	.llseek         = seq_lseek,				       \
+	.release        = FUNC ## _close,			       \
+};                                                                     \
+EXPORT_SYMBOL(FUNC ## _fileops);
+
+#define MAGIC_RDWR_FILEOPS(FUNC)                                       \
+struct file_operations FUNC ## _fileops = {                            \
+	.open           = FUNC ## _open,			       \
+	.read           = seq_read,				       \
+	.llseek         = seq_lseek,				       \
+	.release        = FUNC ## _close,			       \
+	.write          = FUNC ## _write,	                       \
+};                                                                     \
+EXPORT_SYMBOL(FUNC ## _fileops);
+
+/*
+ * Shared function used by Target / Reclassify
+ */
+
+#define TARGET_MAX_INPUT_SIZE 100
+
+static ssize_t
+target_reclassify_write(struct file *file, const char __user * buf,
+			size_t count, loff_t * ppos, int manual)
+{
+	struct rcfs_inode_info *ri = RCFS_I(file->f_dentry->d_inode);
+	char *optbuf;
+	int rc = -EINVAL;
+	ckrm_classtype_t *clstype;
+
+	if ((ssize_t) count < 0 || (ssize_t) count > TARGET_MAX_INPUT_SIZE)
+		return -EINVAL;
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
+	down(&(ri->vfs_inode.i_sem));
+	optbuf = kmalloc(TARGET_MAX_INPUT_SIZE, GFP_KERNEL);
+	__copy_from_user(optbuf, buf, count);
+	if (optbuf[count - 1] == '\n')
+		optbuf[count - 1] = '\0';
+	clstype = ri->core->classtype;
+	if (clstype->forced_reclassify)
+		rc = (*clstype->forced_reclassify) (manual ? ri->core: NULL, optbuf);
+	up(&(ri->vfs_inode.i_sem));
+	kfree(optbuf);
+	return (!rc ? count : rc);
+
+}
+
+/*
+ * Target
+ *
+ * pseudo file for manually reclassifying members to a class
+ */
+
+static ssize_t
+target_write(struct file *file, const char __user * buf,
+	     size_t count, loff_t * ppos)
+{
+	return target_reclassify_write(file,buf,count,ppos,1);
+}
+
+struct file_operations target_fileops = {
+	.write = target_write,
+};
+
+EXPORT_SYMBOL_GPL(target_fileops);
+
+/*
+ * Reclassify
+ *
+ * pseudo file for reclassification of an object through CE
+ */
+
+static ssize_t
+reclassify_write(struct file *file, const char __user * buf,
+		 size_t count, loff_t * ppos)
+{
+	return target_reclassify_write(file,buf,count,ppos,0);
+}
+
+struct file_operations reclassify_fileops = {
+	.write = reclassify_write,
+};
+
+EXPORT_SYMBOL_GPL(reclassify_fileops);
+
+/*
+ * Config
+ *
+ * Set/get configuration parameters of a class. 
+ */
+
+/*
+ * Currently there are no per-class config parameters defined.
+ * Use existing code as a template
+ */
+
+#define config_max_input_size  300
+
+enum config_token_t {
+	config_str, config_res_type, config_err
+};
+
+static match_table_t config_tokens = {
+	{config_res_type, "res=%s"},
+	{config_err, NULL},
+};
+
+MAGIC_PARSE(config);
+MAGIC_WRITE(config, set_config);
+MAGIC_SHOW(config);
+MAGIC_OPEN(config);
+MAGIC_CLOSE(config);
+
+MAGIC_RDWR_FILEOPS(config);
+
+/*
+ * Members
+ *
+ * List members of a class
+ */
+
+MAGIC_SHOW(members);
+MAGIC_OPEN(members);
+MAGIC_CLOSE(members);
+
+MAGIC_RD_FILEOPS(members);
+
+/*
+ * Stats
+ *
+ * Get/reset class statistics
+ * No standard set of stats defined. Each resource controller chooses
+ * its own set of statistics to maintain and export.
+ */
+
+#define stats_max_input_size  50
+
+enum stats_token_t {
+	stats_res_type, stats_str, stats_err
+};
+
+static match_table_t stats_tokens = {
+	{stats_res_type, "res=%s"},
+	{stats_str, NULL},
+	{stats_err, NULL},
+};
+
+MAGIC_PARSE(stats);
+MAGIC_WRITE(stats, reset_stats);
+MAGIC_SHOW(stats);
+MAGIC_OPEN(stats);
+MAGIC_CLOSE(stats);
+
+MAGIC_RDWR_FILEOPS(stats);
+
+/*
+ * Shares
+ *
+ * Set/get shares of a taskclass.
+ * Share types and semantics are defined by rcfs and ckrm core 
+ */
+
+#define SHARES_MAX_INPUT_SIZE  300
+
+/*
+ * The enums for the share types should match the indices expected by
+ * array parameter to ckrm_set_resshare
+ *
+ * Note only the first NUM_SHAREVAL enums correspond to share types,
+ * the remaining ones are for token matching purposes
+ */
+
+enum share_token_t {
+	MY_GUAR, MY_LIM, TOT_GUAR, MAX_LIM, SHARE_RES_TYPE, SHARE_ERR
+};
+
+/* Token matching for parsing input to this magic file */
+static match_table_t shares_tokens = {
+	{SHARE_RES_TYPE, "res=%s"},
+	{MY_GUAR, "guarantee=%d"},
+	{MY_LIM, "limit=%d"},
+	{TOT_GUAR, "total_guarantee=%d"},
+	{MAX_LIM, "max_limit=%d"},
+	{SHARE_ERR, NULL}
+};
+
+static int
+shares_parse(char *options, char **resstr, struct ckrm_shares *shares)
+{
+	char *p;
+	int option;
+
+	if (!options)
+		return 1;
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, shares_tokens, args);
+		switch (token) {
+		case SHARE_RES_TYPE:
+			*resstr = match_strdup(args);
+			break;
+		case MY_GUAR:
+			if (match_int(args, &option))
+				return 0;
+			shares->my_guarantee = option;
+			break;
+		case MY_LIM:
+			if (match_int(args, &option))
+				return 0;
+			shares->my_limit = option;
+			break;
+		case TOT_GUAR:
+			if (match_int(args, &option))
+				return 0;
+			shares->total_guarantee = option;
+			break;
+		case MAX_LIM:
+			if (match_int(args, &option))
+				return 0;
+			shares->max_limit = option;
+			break;
+		default:
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static ssize_t
+shares_write(struct file *file, const char __user * buf,
+	     size_t count, loff_t * ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct rcfs_inode_info *ri;
+	char *optbuf;
+	int rc = 0;
+	struct ckrm_core_class *core;
+	int done;
+	char *resname = NULL;
+
+	struct ckrm_shares newshares = {
+		CKRM_SHARE_UNCHANGED,
+		CKRM_SHARE_UNCHANGED,
+		CKRM_SHARE_UNCHANGED,
+		CKRM_SHARE_UNCHANGED,
+		CKRM_SHARE_UNCHANGED,
+		CKRM_SHARE_UNCHANGED
+	};
+	if ((ssize_t) count < 0 || (ssize_t) count > SHARES_MAX_INPUT_SIZE)
+		return -EINVAL;
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
+	ri = RCFS_I(file->f_dentry->d_parent->d_inode);
+	if (!ri || !ckrm_is_core_valid((ckrm_core_class_t *) (ri->core))) {
+		printk(KERN_ERR "shares_write: Error accessing core class\n");
+		return -EFAULT;
+	}
+	down(&inode->i_sem);
+	core = ri->core;
+	optbuf = kmalloc(SHARES_MAX_INPUT_SIZE, GFP_KERNEL);
+	if (!optbuf) {
+		up(&inode->i_sem);
+		return -ENOMEM;
+	}
+	__copy_from_user(optbuf, buf, count);
+	if (optbuf[count - 1] == '\n')
+		optbuf[count - 1] = '\0';
+	done = shares_parse(optbuf, &resname, &newshares);
+	if (!done) {
+		printk(KERN_ERR "Error parsing shares\n");
+		rc = -EINVAL;
+		goto write_out;
+	}
+	if (core->classtype->set_shares) {
+		rc = (*core->classtype->set_shares) (core, resname, &newshares);
+		if (rc) {
+			printk(KERN_ERR
+			       "shares_write: resctlr share set error\n");
+			goto write_out;
+		}
+	}
+	printk(KERN_ERR "Set %s shares to %d %d %d %d\n",
+	       resname,
+	       newshares.my_guarantee,
+	       newshares.my_limit,
+	       newshares.total_guarantee, newshares.max_limit);
+	rc = count;
+
+write_out:
+	up(&inode->i_sem);
+	kfree(optbuf);
+	kfree(resname);
+	return rc;
+}
+
+MAGIC_SHOW(shares);
+MAGIC_OPEN(shares);
+MAGIC_CLOSE(shares);
+
+MAGIC_RDWR_FILEOPS(shares);
+
+/*
+ * magic file creation/deletion
+ */
+
+int rcfs_clear_magic(struct dentry *parent)
+{
+	struct dentry *mftmp, *mfdentry;
+
+	list_for_each_entry_safe(mfdentry, mftmp, &parent->d_subdirs, d_child) {
+		if (!rcfs_is_magic(mfdentry))
+			continue;
+		if (rcfs_delete_internal(mfdentry))
+			printk(KERN_ERR
+			       "rcfs_clear_magic: error deleting one\n");
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_clear_magic);
+
+int rcfs_create_magic(struct dentry *parent, struct rcfs_magf magf[], int count)
+{
+	int i;
+	struct dentry *mfdentry;
+
+	for (i = 0; i < count; i++) {
+		mfdentry = rcfs_create_internal(parent, &magf[i], 0);
+		if (IS_ERR(mfdentry)) {
+			rcfs_clear_magic(parent);
+			return -ENOMEM;
+		}
+		RCFS_I(mfdentry->d_inode)->core = RCFS_I(parent->d_inode)->core;
+		mfdentry->d_fsdata = &RCFS_IS_MAGIC;
+		if (magf[i].i_fop)
+			mfdentry->d_inode->i_fop = magf[i].i_fop;
+		if (magf[i].i_op)
+			mfdentry->d_inode->i_op = magf[i].i_op;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_create_magic);
Index: linux-2.6.10-rc2/fs/rcfs/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/fs/rcfs/Makefile	2004-11-19 20:44:18.274706405 -0800
@@ -0,0 +1,6 @@
+#
+# Makefile for rcfs routines.
+#
+
+obj-$(CONFIG_RCFS_FS) += rcfs.o 
+rcfs-objs := super.o inode.o dir.o rootdir.o magic.o
Index: linux-2.6.10-rc2/fs/rcfs/rootdir.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/fs/rcfs/rootdir.c	2004-11-19 20:44:18.279705613 -0800
@@ -0,0 +1,209 @@
+/* 
+ * fs/rcfs/rootdir.c 
+ *
+ * Copyright (C)   Vivek Kashyap,   IBM Corp. 2004
+ *           
+ * 
+ * Functions for creating root directories and magic files 
+ * for classtypes and classification engines under rcfs
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Changes
+ *
+ * 08 April 2004
+ *        Created.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/namespace.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/parser.h>
+
+#include <asm/uaccess.h>
+
+#include <linux/rcfs.h>
+
+rbce_eng_callback_t rcfs_eng_callbacks = {
+	NULL, NULL
+};
+
+int rcfs_register_engine(rbce_eng_callback_t * rcbs)
+{
+	if (!rcbs->mkdir || rcfs_eng_callbacks.mkdir) {
+		return -EINVAL;
+	}
+	rcfs_eng_callbacks = *rcbs;
+	rcfs_engine_regd++;
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_register_engine);
+
+int rcfs_unregister_engine(rbce_eng_callback_t * rcbs)
+{
+	if (!rcbs->mkdir || !rcfs_eng_callbacks.mkdir ||
+	    (rcbs->mkdir != rcfs_eng_callbacks.mkdir)) {
+		return -EINVAL;
+	}
+	rcfs_eng_callbacks.mkdir = NULL;
+	rcfs_eng_callbacks.rmdir = NULL;
+	rcfs_engine_regd--;
+	return 0;
+}
+
+EXPORT_SYMBOL(rcfs_unregister_engine);
+
+/*
+ * rcfs_mkroot
+ * Create and return a "root" dentry under /rcfs. 
+ * Also create associated magic files 
+ *
+ * @mfdesc: array of rcfs_magf describing root dir and its magic files
+ * @count: number of entries in mfdesc
+ * @core:  core class to be associated with root
+ * @rootde: output parameter to return the newly created root dentry
+ */
+
+int rcfs_mkroot(struct rcfs_magf *mfdesc, int mfcount, struct dentry **rootde)
+{
+	int sz;
+	struct rcfs_magf *rootdesc = &mfdesc[0];
+	struct dentry *dentry;
+	struct rcfs_inode_info *rootri;
+
+	if ((mfcount < 0) || (!mfdesc))
+		return -EINVAL;
+
+	rootdesc = &mfdesc[0];
+	printk("allocating classtype root <%s>\n", rootdesc->name);
+	dentry = rcfs_create_internal(rcfs_rootde, rootdesc, 0);
+
+	if (!dentry) {
+		printk(KERN_ERR "Could not create %s\n", rootdesc->name);
+		return -ENOMEM;
+	}
+	rootri = RCFS_I(dentry->d_inode);
+	sz = strlen(rootdesc->name) + strlen(RCFS_ROOT) + 2;
+	rootri->name = kmalloc(sz, GFP_KERNEL);
+	if (!rootri->name) {
+		printk(KERN_ERR "Error allocating name for %s\n",
+		       rootdesc->name);
+		rcfs_delete_internal(dentry);
+		return -ENOMEM;
+	}
+	snprintf(rootri->name, sz, "%s/%s", RCFS_ROOT, rootdesc->name);
+	if (rootdesc->i_fop)
+		dentry->d_inode->i_fop = rootdesc->i_fop;
+	if (rootdesc->i_op)
+		dentry->d_inode->i_op = rootdesc->i_op;
+
+	/* set output parameters */
+	*rootde = dentry;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_mkroot);
+
+int rcfs_rmroot(struct dentry *rootde)
+{
+	struct rcfs_inode_info *ri;
+
+	if (!rootde)
+		return -EINVAL;
+
+	rcfs_clear_magic(rootde);
+	ri = RCFS_I(rootde->d_inode);
+	kfree(ri->name);
+	ri->name = NULL;
+	rcfs_delete_internal(rootde);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_rmroot);
+
+int rcfs_register_classtype(ckrm_classtype_t * clstype)
+{
+	int rc;
+	struct rcfs_inode_info *rootri;
+	struct rcfs_magf *mfdesc;
+
+	if (genmfdesc[clstype->mfidx] == NULL) {
+		return -ENOMEM;
+	}
+
+	clstype->mfdesc = (void *)genmfdesc[clstype->mfidx]->rootmf;
+	clstype->mfcount = genmfdesc[clstype->mfidx]->rootmflen;
+
+	mfdesc = (struct rcfs_magf *)clstype->mfdesc;
+
+	/* rcfs root entry has the same name as the classtype */
+	strncpy(mfdesc[0].name, clstype->name, RCFS_MAGF_NAMELEN);
+
+	rc = rcfs_mkroot(mfdesc, clstype->mfcount,
+			 (struct dentry **)&(clstype->rootde));
+	if (rc)
+		return rc;
+	rootri = RCFS_I(((struct dentry *)(clstype->rootde))->d_inode);
+	rootri->core = clstype->default_class;
+	clstype->default_class->name = rootri->name;
+	ckrm_core_grab(clstype->default_class);
+
+	/* Create magic files under root */
+	if ((rc = rcfs_create_magic(clstype->rootde, &mfdesc[1],
+				    clstype->mfcount - 1))) {
+		kfree(rootri->name);
+		rootri->name = NULL;
+		rcfs_delete_internal(clstype->rootde);
+		return rc;
+	}
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_register_classtype);
+
+int rcfs_deregister_classtype(ckrm_classtype_t * clstype)
+{
+	int rc;
+
+	rc = rcfs_rmroot((struct dentry *)clstype->rootde);
+	if (!rc) {
+		clstype->default_class->name = NULL;
+		ckrm_core_drop(clstype->default_class);
+	}
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(rcfs_deregister_classtype);
+
+/* Common root and magic file entries.
+ * root name, root permissions, magic file names and magic file permissions 
+ * are needed by all entities (classtypes and classification engines) existing 
+ * under the rcfs mount point
+ *
+ * The common sets of these attributes are listed here as a table. Individual 
+ * classtypes and classification engines can simple specify the index into the 
+ * table to initialize their magf entries. 
+ */
+
+struct rcfs_mfdesc *genmfdesc[] = {
+	NULL,
+};
Index: linux-2.6.10-rc2/fs/rcfs/super.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/fs/rcfs/super.c	2004-11-19 20:44:18.283704980 -0800
@@ -0,0 +1,304 @@
+/* 
+ * fs/rcfs/super.c 
+ *
+ * Copyright (C) Shailabh Nagar,  IBM Corp. 2004
+ *		 Vivek Kashyap,   IBM Corp. 2004
+ *           
+ * Super block operations for rcfs
+ * 
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Changes
+ *
+ * 08 Mar 2004
+ *        Created.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/namespace.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
+#include <linux/parser.h>
+
+#include <asm/uaccess.h>
+
+#include <linux/rcfs.h>
+#include <linux/ckrm_rc.h>
+#include <linux/ckrm_ce.h>
+
+static kmem_cache_t *rcfs_inode_cachep;
+
+inline struct rcfs_inode_info *RCFS_I(struct inode *inode)
+{
+	return container_of(inode, struct rcfs_inode_info, vfs_inode);
+}
+
+EXPORT_SYMBOL_GPL(RCFS_I);
+
+static struct inode *rcfs_alloc_inode(struct super_block *sb)
+{
+	struct rcfs_inode_info *ri;
+	ri = (struct rcfs_inode_info *)kmem_cache_alloc(rcfs_inode_cachep,
+							SLAB_KERNEL);
+	if (!ri)
+		return NULL;
+	ri->name = NULL;
+	return &ri->vfs_inode;
+}
+
+static void rcfs_destroy_inode(struct inode *inode)
+{
+	struct rcfs_inode_info *ri = RCFS_I(inode);
+
+	kfree(ri->name);
+	kmem_cache_free(rcfs_inode_cachep, ri);
+}
+
+static void
+rcfs_init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct rcfs_inode_info *ri = (struct rcfs_inode_info *)foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&ri->vfs_inode);
+}
+
+int rcfs_init_inodecache(void)
+{
+	rcfs_inode_cachep = kmem_cache_create("rcfs_inode_cache",
+					      sizeof(struct rcfs_inode_info),
+					      0,
+					      SLAB_HWCACHE_ALIGN |
+					      SLAB_RECLAIM_ACCOUNT,
+					      rcfs_init_once, NULL);
+	if (rcfs_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+void rcfs_destroy_inodecache(void)
+{
+	printk(KERN_WARNING "destroy inodecache was called\n");
+	if (kmem_cache_destroy(rcfs_inode_cachep))
+		printk(KERN_INFO
+		       "rcfs_inode_cache: not all structures were freed\n");
+}
+
+struct super_operations rcfs_super_ops = {
+	.alloc_inode = rcfs_alloc_inode,
+	.destroy_inode = rcfs_destroy_inode,
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+struct dentry *rcfs_rootde;	/* redundant; can also get it from sb */
+static struct inode *rcfs_root;
+static struct rcfs_inode_info *rcfs_rootri;
+
+static int rcfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+	struct rcfs_inode_info *rootri;
+	struct ckrm_classtype *clstype;
+	int i, rc;
+
+	sb->s_fs_info = NULL;
+	if (rcfs_mounted) {
+		return -EPERM;
+	}
+	rcfs_mounted++;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = RCFS_MAGIC;
+	sb->s_op = &rcfs_super_ops;
+	inode = rcfs_get_inode(sb, S_IFDIR | 0755, 0);
+	if (!inode)
+		return -ENOMEM;
+	inode->i_op = &rcfs_rootdir_inode_operations;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+
+	/* Link inode and core class */
+	rootri = RCFS_I(inode);
+	rootri->name = kmalloc(strlen(RCFS_ROOT) + 1, GFP_KERNEL);
+	if (!rootri->name) {
+		d_delete(root);
+		iput(inode);
+		return -ENOMEM;
+	}
+	strcpy(rootri->name, RCFS_ROOT);
+	rootri->core = NULL;
+
+	rcfs_root = inode;
+	sb->s_fs_info = rcfs_root = inode;
+	rcfs_rootde = root;
+	rcfs_rootri = rootri;
+
+	/* register metatypes */
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++) {
+		clstype = ckrm_classtypes[i];
+		if (clstype == NULL)
+			continue;
+		printk("A non null classtype\n");
+
+		if ((rc = rcfs_register_classtype(clstype)))
+			continue;	/* could return with an error too */
+	}
+
+	/*
+	 * do post-mount initializations needed by CE
+	 * this is distinct from CE registration done on rcfs module load
+	 */
+	if (rcfs_engine_regd) {
+		if (rcfs_eng_callbacks.mnt)
+			if ((rc = (*rcfs_eng_callbacks.mnt) ())) {
+				printk(KERN_ERR "Error in CE mnt %d\n", rc);
+			}
+	}
+	/*
+	 * Following comment handled by code above; keep nonetheless if it
+	 * can be done better
+	 *
+	 * register CE's with rcfs 
+	 * check if CE loaded
+	 * call rcfs_register_engine for each classtype
+	 * AND rcfs_mkroot (preferably subsume latter in former)
+	 */
+	return 0;
+}
+
+static struct super_block *rcfs_get_sb(struct file_system_type *fs_type,
+				       int flags, const char *dev_name,
+				       void *data)
+{
+	return get_sb_nodev(fs_type, flags, data, rcfs_fill_super);
+}
+
+void rcfs_kill_sb(struct super_block *sb)
+{
+	int i, rc;
+	struct ckrm_classtype *clstype;
+
+	if (sb->s_fs_info != rcfs_root) {
+		generic_shutdown_super(sb);
+		return;
+	}
+	rcfs_mounted--;
+
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++) {
+		clstype = ckrm_classtypes[i];
+		if (clstype == NULL || clstype->rootde == NULL)
+			continue;
+
+		if ((rc = rcfs_deregister_classtype(clstype))) {
+			printk(KERN_ERR "Error removing classtype %s\n",
+			       clstype->name);
+		}
+	}
+
+	/*
+	 * do pre-umount shutdown needed by CE
+	 * this is distinct from CE deregistration done on rcfs module unload
+	 */
+	if (rcfs_engine_regd) {
+		if (rcfs_eng_callbacks.umnt)
+			if ((rc = (*rcfs_eng_callbacks.umnt) ())) {
+				printk(KERN_ERR "Error in CE umnt %d\n", rc);
+				/* TODO: return ; until error handling improves */
+			}
+	}
+	/*
+	 * Following comment handled by code above; keep nonetheless if it 
+	 * can be done better
+	 *
+	 * deregister CE with rcfs
+	 * Check if loaded
+	 * if ce is in  one directory /rcfs/ce, 
+	 *       rcfs_deregister_engine for all classtypes within above 
+	 *             codebase 
+	 *       followed by
+	 *       rcfs_rmroot here
+	 * if ce in multiple (per-classtype) directories
+	 *       call rbce_deregister_engine within ckrm_deregister_classtype
+	 *
+	 * following will automatically clear rcfs root entry including its 
+	 *  rcfs_inode_info
+	 */
+
+	generic_shutdown_super(sb);
+}
+
+static struct file_system_type rcfs_fs_type = {
+	.name = "rcfs",
+	.get_sb = rcfs_get_sb,
+	.kill_sb = rcfs_kill_sb,
+};
+
+struct rcfs_functions my_rcfs_fn = {
+	.mkroot = rcfs_mkroot,
+	.rmroot = rcfs_rmroot,
+	.register_classtype = rcfs_register_classtype,
+	.deregister_classtype = rcfs_deregister_classtype,
+};
+
+extern struct rcfs_functions rcfs_fn;
+
+static int __init init_rcfs_fs(void)
+{
+	int ret;
+
+	ret = register_filesystem(&rcfs_fs_type);
+	if (ret)
+		goto init_register_err;
+	ret = rcfs_init_inodecache();
+	if (ret)
+		goto init_cache_err;
+	rcfs_fn = my_rcfs_fn;
+	/*
+	 * Due to tight coupling of this module with ckrm
+	 * do not allow this module to be removed.
+	 */
+	try_module_get(THIS_MODULE);
+	return ret;
+
+init_cache_err:
+	unregister_filesystem(&rcfs_fs_type);
+init_register_err:
+	return ret;
+}
+
+static void __exit exit_rcfs_fs(void)
+{
+	rcfs_destroy_inodecache();
+	unregister_filesystem(&rcfs_fs_type);
+}
+
+module_init(init_rcfs_fs)
+module_exit(exit_rcfs_fs)
+
+MODULE_LICENSE("GPL");
Index: linux-2.6.10-rc2/init/Kconfig
===================================================================
--- linux-2.6.10-rc2.orig/init/Kconfig	2004-11-19 20:41:45.572898412 -0800
+++ linux-2.6.10-rc2/init/Kconfig	2004-11-19 20:44:18.288704188 -0800
@@ -152,6 +152,17 @@
 	  If you say Y here, enable the Resource Class File System and atleast
 	  one of the resource controllers below. Say N if you are unsure. 
 
+config RCFS_FS
+	tristate "Resource Class File System (User API)"
+	depends on CKRM
+	help
+	  RCFS is the filesystem API for CKRM. This separate configuration 
+	  option is provided only for debugging and will eventually disappear 
+	  since rcfs will be automounted whenever CKRM is configured. 
+
+	  Say N if unsure, Y if you've enabled CKRM, M to debug rcfs 
+	  initialization.
+
 endmenu
 
 config SYSCTL
