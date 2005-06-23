Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVFWGxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVFWGxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVFWGva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:51:30 -0400
Received: from [24.22.56.4] ([24.22.56.4]:31206 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262348AbVFWGTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:09 -0400
Message-Id: <20050623061757.104398000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:07 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 15/38] CKRM e18: Rule Based Classification Engine, stub rcfs support
Content-Disposition: inline; filename=09-01-rbce_fs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 1 of 5 patches to support Rule Based Classification Engine for CKRM.
This patch provides the the basic rcfs interface for rbce. It just provides
the interface with stub functions.

Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 include/linux/rbce.h             |   28 ++
 init/Kconfig                     |   12 +
 kernel/ckrm/Makefile             |    1 
 kernel/ckrm/rbce/Makefile        |    6 
 kernel/ckrm/rbce/rbce_fs.c       |  365 +++++++++++++++++++++++++++++++++++++++
 kernel/ckrm/rbce/rbce_internal.h |   59 ++++++
 kernel/ckrm/rbce/rbce_main.c     |   97 ++++++++++
 7 files changed, 568 insertions(+)

Index: linux-2.6.12-ckrm1/include/linux/rbce.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/include/linux/rbce.h	2005-06-20 13:08:42.000000000 -0700
@@ -0,0 +1,28 @@
+/* Rule-based Classification Engine (RBCE) module
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *
+ * Module for loading of classification policies and providing
+ * a user API for Class-based Kernel Resource Management (CKRM)
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ *
+ */
+
+#ifndef _LINUX_RBCE_H
+#define _LINUX_RBCE_H
+
+#define RBCE_MOD_DESCR "Rule Based Classification Engine Module for CKRM"
+#define RBCE_MOD_NAME  "rbce"
+
+#endif	/* _LINUX_RBCE_H */
Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-20 13:08:34.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 13:08:42.000000000 -0700
@@ -203,6 +203,18 @@ config CKRM_RES_NUMTASKS
 
 	  Say N if unsure, Y to use the feature.
 
+
+config CKRM_RBCE
+	tristate "Vanilla Rule-based Classification Engine (RBCE)"
+	depends on CKRM && RCFS_FS
+	default m
+	help
+	  Provides an optional module to support creation of rules for automatic
+	  classification of kernel objects. Rules are created/deleted/modified
+	  through an rcfs interface. RBCE is not required for CKRM.
+
+	  If unsure, say N.
+
 endmenu
 
 config SYSCTL
Index: linux-2.6.12-ckrm1/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/Makefile	2005-06-20 13:08:34.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/Makefile	2005-06-20 13:08:42.000000000 -0700
@@ -6,3 +6,4 @@ obj-y += ckrm_events.o ckrm.o ckrmutils.
 obj-$(CONFIG_CKRM_TYPE_TASKCLASS) += ckrm_tc.o ckrm_numtasks_stub.o
 obj-$(CONFIG_CKRM_TYPE_SOCKETCLASS) += ckrm_sockc.o
 obj-$(CONFIG_CKRM_RES_NUMTASKS) += ckrm_numtasks.o
+obj-$(CONFIG_CKRM_RBCE) += rbce/
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:42.000000000 -0700
@@ -0,0 +1,6 @@
+#
+# Makefile for RBCE
+#
+
+obj-$(CONFIG_CKRM_RBCE)	+= rbce.o
+rbce-objs := rbce_fs.o rbce_main.o
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_fs.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_fs.c	2005-06-20 13:08:42.000000000 -0700
@@ -0,0 +1,365 @@
+/*
+ * RCFS API for Rule-based Classification Engine (RBCE)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *           (C) Vivek Kashyap, IBM Corp. 2004
+ *
+ * Module for loading of classification policies and providing
+ * a user API for Class-based Kernel Resource Management (CKRM)
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include <linux/pagemap.h>
+#include <linux/rcfs.h>
+#include "rbce_internal.h"
+
+#define CONFIG_CE_DIR		"ce"
+#define CONFIG_RULES_DIR	"rules"
+#define CONFIG_RBCE_STATE	"rbce_state"
+#define CONFIG_RBCE_TAG		"rbce_tag"
+
+static int rbce_unlink(struct inode *, struct dentry *);
+
+static ssize_t
+rbce_write(struct file *file, const char __user * buf,
+	   size_t len, loff_t * ppos)
+{
+	char *line, *ptr;
+	int rc = 0, pid;
+
+	line = kmalloc(len + 1, GFP_KERNEL);
+	if (!line) {
+		return -ENOMEM;
+	}
+	if (copy_from_user(line, buf, len)) {
+		kfree(line);
+		return -EFAULT;
+	}
+	line[len] = '\0';
+	ptr = line;
+	while (*ptr) {
+		if (*ptr == '\n') {
+			*ptr = '\0';
+			break;
+		}
+		ptr++;
+	}
+	if (!strcmp(file->f_dentry->d_name.name, CONFIG_RBCE_TAG)) {
+		pid = simple_strtol(line, &ptr, 0);
+		rc = rbce_set_tasktag(pid, ptr + 1); /* syntax "pid tag" */
+	} else if (!strcmp(file->f_dentry->d_name.name, CONFIG_RBCE_STATE))
+		rbce_enabled = line[0] - '0';
+	else
+		rc = rbce_change_rule(file->f_dentry->d_name.name, line);
+	if (rc)
+		len = rc;
+	kfree(line);
+	return len;
+}
+
+static int rbce_show(struct seq_file *seq, void *offset)
+{
+	struct file *file = (struct file *)seq->private;
+	char result[256];
+
+	memset(result, 0, 256);
+	if (!strcmp(file->f_dentry->d_name.name, CONFIG_RBCE_TAG))
+		return -EPERM;
+	if (!strcmp(file->f_dentry->d_name.name, CONFIG_RBCE_STATE))
+		seq_printf(seq, "%d\n", rbce_enabled);
+	else {
+		rbce_get_rule(file->f_dentry->d_name.name, result);
+		seq_printf(seq, "%s\n", result);
+	}
+	return 0;
+}
+
+static int rbce_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rbce_show, file);
+}
+
+static int rbce_close(struct inode *ino, struct file *file)
+{
+	const char *name = file->f_dentry->d_name.name;
+
+	if (strcmp(name, CONFIG_RBCE_STATE) &&
+			strcmp(name, CONFIG_RBCE_TAG) &&
+			!rbce_rule_exists(name))
+		rbce_unlink(file->f_dentry->d_parent->d_inode, file->f_dentry);
+	return single_release(ino, file);
+}
+
+static struct file_operations rbce_file_operations;
+static struct inode_operations rbce_file_inode_operations;
+static struct inode_operations rbce_dir_inode_operations;
+
+static struct inode *rbce_get_inode(struct inode *dir, int mode, dev_t dev)
+{
+	struct inode *inode = new_inode(dir->i_sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_mapping->a_ops = dir->i_mapping->a_ops;
+		inode->i_mapping->backing_dev_info =
+		    dir->i_mapping->backing_dev_info;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			/* Treat as default assignment */
+			inode->i_op = &rbce_file_inode_operations;
+			inode->i_fop = &rbce_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &rbce_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2
+			   (for "." entry) */
+			inode->i_nlink++;
+			break;
+		}
+	}
+	return inode;
+}
+
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+static int
+rbce_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	struct inode *inode = rbce_get_inode(dir, mode, dev);
+	int error = -ENOSPC;
+
+	if (inode) {
+		if (dir->i_mode & S_ISGID) {
+			inode->i_gid = dir->i_gid;
+			if (S_ISDIR(mode))
+				inode->i_mode |= S_ISGID;
+		}
+		d_instantiate(dentry, inode);
+		dget(dentry);	/* Extra count - pin the dentry in core */
+		error = 0;
+
+	}
+	return error;
+}
+
+static int rbce_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int rc;
+
+	rc = rbce_delete_rule(dentry->d_name.name);
+	if (rc == 0) {
+		if (dir)
+			dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME;
+		inode->i_nlink--;
+		dput(dentry);
+	}
+	return rc;
+}
+
+static int
+rbce_rename(struct inode *old_dir, struct dentry *old_dentry,
+	    struct inode *new_dir, struct dentry *new_dentry)
+{
+	int rc;
+	struct inode *inode = old_dentry->d_inode;
+	struct dentry *old_d = list_entry(old_dir->i_dentry.next,
+					  struct dentry, d_alias);
+	struct dentry *new_d = list_entry(new_dir->i_dentry.next,
+					  struct dentry, d_alias);
+
+	/* Do not allow renaming any directory */
+	if (S_ISDIR(old_dentry->d_inode->i_mode))
+		return -EINVAL;
+
+	/* Do not allow renaming files just under under /ce */
+	if (!strcmp(old_d->d_name.name, CONFIG_CE_DIR))
+		return -EINVAL;
+
+	/* cannot move anything to /ce */
+	if (!strcmp(new_d->d_name.name, CONFIG_CE_DIR))
+		return -EINVAL;
+
+	rc = rbce_rename_rule(old_dentry->d_name.name, new_dentry->d_name.name);
+
+	if (!rc)
+		old_dir->i_ctime = old_dir->i_mtime = new_dir->i_ctime =
+		    new_dir->i_mtime = inode->i_ctime = CURRENT_TIME;
+	return rc;
+}
+
+/* CE allows only the rules directory to be created */
+int rbce_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int retval = -EINVAL;
+
+	struct dentry *pd =
+	    list_entry(dir->i_dentry.next, struct dentry, d_alias);
+
+	/* Allow only /rcfs/ce and ce/rules */
+	if ((!strcmp(pd->d_name.name, CONFIG_CE_DIR) &&
+			!strcmp(dentry->d_name.name, CONFIG_RULES_DIR)) ||
+			(!strcmp(pd->d_name.name, "/") &&
+			!strcmp(dentry->d_name.name, CONFIG_CE_DIR))) {
+		if (!strcmp(dentry->d_name.name, CONFIG_CE_DIR))
+			try_module_get(THIS_MODULE);
+		retval = rbce_mknod(dir, dentry, mode | S_IFDIR, 0);
+		if (!retval)
+			dir->i_nlink++;
+	}
+
+	return retval;
+}
+
+/* CE doesn't allow deletion of directory */
+int rbce_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	int rc;
+	rc = simple_rmdir(dir, dentry);
+
+	if (!rc && !strcmp(dentry->d_name.name, CONFIG_CE_DIR))
+		module_put(THIS_MODULE);
+	return rc;
+}
+
+static int
+rbce_create(struct inode *dir, struct dentry *dentry,
+	    int mode, struct nameidata *nd)
+{
+	struct dentry *pd =
+	    list_entry(dir->i_dentry.next, struct dentry, d_alias);
+
+	/* No creation allowed under ce */
+	if (!strcmp(pd->d_name.name, CONFIG_CE_DIR))
+		return -EINVAL;
+
+	return rbce_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+static int rbce_link(struct dentry *old_d, struct inode *dir, struct dentry *d)
+{
+	return -EINVAL;
+}
+
+static int
+rbce_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	return -EINVAL;
+}
+
+/******************************* Config files  ********************/
+
+#define RBCE_NR_CONFIG 5
+struct rcfs_magf rbce_config_files[RBCE_NR_CONFIG] = {
+	{
+	 .name = CONFIG_CE_DIR,
+	 .mode = RCFS_DEFAULT_DIR_MODE,
+	 .i_op = &rbce_dir_inode_operations,
+	 },
+	{
+	 .name = CONFIG_RBCE_TAG,
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_fop = &rbce_file_operations,
+	 },
+	{
+	 .name = CONFIG_RBCE_STATE,
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_fop = &rbce_file_operations,
+	 },
+	{
+	 .name = CONFIG_RULES_DIR,
+	 .mode = (RCFS_DEFAULT_DIR_MODE | S_IWUSR),
+	 .i_fop = &simple_dir_operations,
+	 .i_op = &rbce_dir_inode_operations,
+	 }
+};
+
+static struct dentry *ce_root_dentry;
+
+int rbce_create_config(void)
+{
+	int rc;
+
+	/* Make root dentry */
+	rc = rcfs_mkroot(rbce_config_files, RBCE_NR_CONFIG, &ce_root_dentry);
+	if ((!ce_root_dentry) || rc)
+		return rc;
+
+	/* Create config files */
+	if ((rc = rcfs_create_magic(ce_root_dentry, &rbce_config_files[1],
+				    RBCE_NR_CONFIG - 1))) {
+		printk(KERN_ERR "Failed to create c/rbce config files."
+		       " Deleting c/rbce root\n");
+		rcfs_rmroot(ce_root_dentry);
+		return rc;
+	}
+
+	return rc;
+}
+
+int rbce_clear_config(void)
+{
+	int rc = 0;
+	if (ce_root_dentry)
+		rc = rcfs_rmroot(ce_root_dentry);
+	return rc;
+}
+
+/******************************* File ops ********************/
+
+static struct file_operations rbce_file_operations = {
+	.owner = THIS_MODULE,
+	.open = rbce_open,
+	.llseek = seq_lseek,
+	.read = seq_read,
+	.write = rbce_write,
+	.release = rbce_close,
+};
+
+static struct inode_operations rbce_file_inode_operations = {
+	.getattr = simple_getattr,
+};
+
+static struct inode_operations rbce_dir_inode_operations = {
+	.create = rbce_create,
+	.lookup = simple_lookup,
+	.link = rbce_link,
+	.unlink = rbce_unlink,
+	.symlink = rbce_symlink,
+	.mkdir = rbce_mkdir,
+	.rmdir = rbce_rmdir,
+	.mknod = rbce_mknod,
+	.rename = rbce_rename,
+	.getattr = simple_getattr,
+};
+
+struct rbce_eng_callback rbce_rcfs_ecbs = {
+	rbce_mkdir,
+	rbce_rmdir,
+	rbce_create_config,
+	rbce_clear_config
+};
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:42.000000000 -0700
@@ -0,0 +1,59 @@
+/*
+ * rbce internal header file.
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *           (C) Vivek Kashyap, IBM Corp. 2004
+ *
+ * Module for loading of classification policies and providing
+ * a user API for Class-based Kernel Resource Management (CKRM)
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+#ifndef _RBCE_INTERNAL_H
+#define _RBCE_INTERNAL_H
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/proc_fs.h>
+#include <linux/limits.h>
+#include <linux/pid.h>
+#include <linux/sysctl.h>
+
+#include <linux/ckrm_rc.h>
+#include <linux/ckrm_ce.h>
+#include <linux/ckrm_net.h>
+#include <linux/rbce.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+extern int rbce_enabled;
+extern struct rbce_eng_callback rbce_rcfs_ecbs;
+
+extern int rbce_mkdir(struct inode *, struct dentry *, int);
+extern int rbce_rmdir(struct inode *, struct dentry *);
+extern int rbce_create_config(void);
+extern int rbce_clear_config(void);
+
+extern void rbce_get_rule(const char *, char *);
+extern int rbce_rule_exists(const char *);
+extern int rbce_change_rule(const char *, char *);
+extern int rbce_delete_rule(const char *);
+extern int rbce_set_tasktag(int, char *);
+extern int rbce_rename_rule(const char *, const char *);
+
+#endif /* _RBCE_INTERNAL_H */
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:42.000000000 -0700
@@ -0,0 +1,97 @@
+/*
+ * Rule Functionality and module initialization and destrution
+ * for Rule-based Classification Engine (RBCE)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *           (C) Vivek Kashyap, IBM Corp. 2004
+ *
+ * Module for loading of classification policies and providing
+ * a user API for Class-based Kernel Resource Management (CKRM)
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include "rbce_internal.h"
+
+MODULE_DESCRIPTION(RBCE_MOD_DESCR);
+MODULE_AUTHOR("Hubertus Franke, Chandra Seetharaman (IBM)");
+MODULE_LICENSE("GPL");
+
+static char modname[] = RBCE_MOD_NAME;
+
+/* Stub routines for now */
+void rbce_get_rule(const char *a, char *b)
+{
+}
+int rbce_rule_exists(const char *a)
+{
+	return 0;
+}
+int rbce_change_rule(const char *a, char *b)
+{
+	return 1;
+}
+int rbce_delete_rule(const char *a)
+{
+	return 1;
+}
+int rbce_set_tasktag(int i, char *a)
+{
+	return 1;
+}
+int rbce_rename_rule(const char *a, const char *b)
+{
+	return 1;
+}
+
+int rbce_enabled = 1;
+/* ======================= Module definition Functions ====================== */
+
+int init_rbce(void)
+{
+	int rc, line;
+
+	printk(KERN_INFO "Installing \'%s\' module\n", modname);
+
+	rc = rcfs_register_engine(&rbce_rcfs_ecbs);
+	line = __LINE__;
+	if (rc)
+		goto out;
+
+	if (rcfs_mounted) {
+		rc = rbce_create_config();
+		line = __LINE__;
+		if (!rc)
+			goto out;
+	}
+
+	rcfs_unregister_engine(&rbce_rcfs_ecbs);
+out:
+	printk(KERN_ERR "%s: error installing rc=%d line=%d\n",
+		__FUNCTION__, rc, line);
+	return rc;
+}
+
+void exit_rbce(void)
+{
+	printk(KERN_INFO "Removing \'%s\' module\n", modname);
+
+	if (rcfs_mounted)
+		rbce_clear_config();
+
+	rcfs_unregister_engine(&rbce_rcfs_ecbs);
+}
+
+module_init(init_rbce);
+module_exit(exit_rbce);

--
