Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVBXJwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVBXJwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVBXJwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:52:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:1960 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262159AbVBXJee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:34:34 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM [6/8] CKRM tracking for socket classes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26682.1109237672.1@us.ibm.com>
Date: Thu, 24 Feb 2005 01:34:32 -0800
Message-Id: <E1D4FOC-0006wP-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the extensions for CKRM to track per socket classes.
This is the base to enable socket based resource control for inbound
connection control, bandwidth control etc.

Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>


Index: linux-2.6.11-rc5-ckrm01/fs/rcfs/Makefile
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/fs/rcfs/Makefile	2005-02-24 01:09:01.190232913 -0800
+++ linux-2.6.11-rc5-ckrm01/fs/rcfs/Makefile	2005-02-24 01:09:01.408206631 -0800
@@ -6,3 +6,4 @@
 
 rcfs-y := super.o inode.o dir.o rootdir.o magic.o
 rcfs-$(CONFIG_CKRM_TYPE_TASKCLASS) += tc_magic.o
+rcfs-$(CONFIG_CKRM_TYPE_SOCKETCLASS) += socket_fs.o
Index: linux-2.6.11-rc5-ckrm01/fs/rcfs/rootdir.c
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/fs/rcfs/rootdir.c	2005-02-24 01:09:01.191232792 -0800
+++ linux-2.6.11-rc5-ckrm01/fs/rcfs/rootdir.c	2005-02-24 01:09:34.051270771 -0800
@@ -187,6 +187,10 @@
 extern struct rcfs_mfdesc tc_mfdesc;
 #endif
 
+#ifdef CONFIG_CKRM_TYPE_SOCKETCLASS
+extern struct rcfs_mfdesc rcfs_sock_mfdesc;
+#endif
+
 /* Common root and magic file entries.
  * root name, root permissions, magic file names and magic file permissions 
  * are needed by all entities (classtypes and classification engines) existing 
@@ -203,4 +207,10 @@
 #else
 	NULL,
 #endif
+#ifdef CONFIG_CKRM_TYPE_SOCKETCLASS
+	&rcfs_sock_mfdesc,
+#else
+	NULL,
+#endif
+
 };
Index: linux-2.6.11-rc5-ckrm01/fs/rcfs/socket_fs.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc5-ckrm01/fs/rcfs/socket_fs.c	2005-02-24 01:09:01.410206390 -0800
@@ -0,0 +1,308 @@
+/* ckrm_socketaq.c 
+ *
+ * Copyright (C) Vivek Kashyap,      IBM Corp. 2004
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
+/*******************************************************************************
+ *  Socket class type
+ *   
+ * Defines the root structure for socket based classes. Currently only inbound
+ * connection control is supported based on prioritized accept queues. 
+ ******************************************************************************/
+
+#include <linux/rcfs.h>
+#include <net/tcp.h>
+
+extern int rcfs_create(struct inode *, struct dentry *, int,
+		       struct nameidata *);
+extern int rcfs_unlink(struct inode *, struct dentry *);
+extern int rcfs_symlink(struct inode *, struct dentry *, const char *);
+extern int rcfs_mknod(struct inode *, struct dentry *, int mode, dev_t);
+extern int rcfs_mkdir(struct inode *, struct dentry *, int);
+extern int rcfs_rmdir(struct inode *, struct dentry *);
+extern int rcfs_rename(struct inode *, struct dentry *, struct inode *,
+		       struct dentry *);
+
+extern int rcfs_create_coredir(struct inode *, struct dentry *);
+int rcfs_sock_mkdir(struct inode *, struct dentry *, int mode);
+int rcfs_sock_rmdir(struct inode *, struct dentry *);
+
+int rcfs_sock_create_noperm(struct inode *, struct dentry *, int,
+		       struct nameidata *);
+int rcfs_sock_unlink_noperm(struct inode *, struct dentry *);
+int rcfs_sock_mkdir_noperm(struct inode *, struct dentry *, int);
+int rcfs_sock_rmdir_noperm(struct inode *, struct dentry *);
+int rcfs_sock_mknod_noperm(struct inode *, struct dentry *, int, dev_t);
+
+void rcfs_sock_set_directory(void);
+
+extern struct file_operations config_fileops,
+    members_fileops, shares_fileops, stats_fileops, target_fileops;
+
+struct inode_operations my_iops = {
+	.create = rcfs_create,
+	.lookup = simple_lookup,
+	.link = simple_link,
+	.unlink = rcfs_unlink,
+	.symlink = rcfs_symlink,
+	.mkdir = rcfs_sock_mkdir,
+	.rmdir = rcfs_sock_rmdir,
+	.mknod = rcfs_mknod,
+	.rename = rcfs_rename,
+};
+
+struct inode_operations class_iops = {
+	.create = rcfs_sock_create_noperm,
+	.lookup = simple_lookup,
+	.link = simple_link,
+	.unlink = rcfs_sock_unlink_noperm,
+	.symlink = rcfs_symlink,
+	.mkdir = rcfs_sock_mkdir_noperm,
+	.rmdir = rcfs_sock_rmdir_noperm,
+	.mknod = rcfs_sock_mknod_noperm,
+	.rename = rcfs_rename,
+};
+
+struct inode_operations sub_iops = {
+	.create = rcfs_sock_create_noperm,
+	.lookup = simple_lookup,
+	.link = simple_link,
+	.unlink = rcfs_sock_unlink_noperm,
+	.symlink = rcfs_symlink,
+	.mkdir = rcfs_sock_mkdir_noperm,
+	.rmdir = rcfs_sock_rmdir_noperm,
+	.mknod = rcfs_sock_mknod_noperm,
+	.rename = rcfs_rename,
+};
+
+struct rcfs_magf def_magf = {
+	.mode = RCFS_DEFAULT_DIR_MODE,
+	.i_op = &sub_iops,
+	.i_fop = NULL,
+};
+
+struct rcfs_magf rcfs_sock_rootdesc[] = {
+	{
+	 /* .name = should not be set, copy from classtype name, */
+	 .mode = RCFS_DEFAULT_DIR_MODE,
+	 .i_op = &my_iops,
+	 /* .i_fop   = &simple_dir_operations, */
+	 .i_fop = NULL,
+	 },
+	{
+	 .name = "members",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &members_fileops,
+	 },
+	{
+	 .name = "target",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &target_fileops,
+	 },
+	{
+	 .name = "reclassify",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &reclassify_fileops,
+	 },
+};
+
+struct rcfs_magf rcfs_sock_magf[] = {
+	{
+	 .name = "config",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &config_fileops,
+	 },
+	{
+	 .name = "members",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &members_fileops,
+	 },
+	{
+	 .name = "shares",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &shares_fileops,
+	 },
+	{
+	 .name = "stats",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &stats_fileops,
+	 },
+	{
+	 .name = "target",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &target_fileops,
+	 },
+};
+
+struct rcfs_magf sub_magf[] = {
+	{
+	 .name = "config",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &config_fileops,
+	 },
+	{
+	 .name = "shares",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &shares_fileops,
+	 },
+	{
+	 .name = "stats",
+	 .mode = RCFS_DEFAULT_FILE_MODE,
+	 .i_op = &my_iops,
+	 .i_fop = &stats_fileops,
+	 },
+};
+
+struct rcfs_mfdesc rcfs_sock_mfdesc = {
+	.rootmf = rcfs_sock_rootdesc,
+	.rootmflen = (sizeof(rcfs_sock_rootdesc) / sizeof(struct rcfs_magf)),
+};
+
+#define SOCK_MAX_MAGF (sizeof(rcfs_sock_magf)/sizeof(struct rcfs_magf))
+#define LAQ_MAX_SUBMAGF (sizeof(sub_magf)/sizeof(struct rcfs_magf))
+
+int rcfs_sock_rmdir(struct inode *p, struct dentry *me)
+{
+	struct dentry *mftmp, *mfdentry;
+	int ret = 0;
+
+	/* delete all magic sub directories */
+	list_for_each_entry_safe(mfdentry, mftmp, &me->d_subdirs, d_child) {
+		if (S_ISDIR(mfdentry->d_inode->i_mode)) {
+			ret = rcfs_rmdir(me->d_inode, mfdentry);
+			if (ret)
+				return ret;
+		}
+	}
+	/* delete ourselves */
+	ret = rcfs_rmdir(p, me);
+
+	return ret;
+}
+
+#ifdef NUM_ACCEPT_QUEUES
+#define LAQ_NUM_ACCEPT_QUEUES NUM_ACCEPT_QUEUES
+#else
+#define LAQ_NUM_ACCEPT_QUEUES 0
+#endif
+
+int rcfs_sock_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int retval = 0;
+	int i, j;
+	struct dentry *pentry, *mfdentry;
+
+	if (_rcfs_mknod(dir, dentry, mode | S_IFDIR, 0)) {
+		printk(KERN_ERR "rcfs_mkdir: error reaching parent\n");
+		return retval;
+	}
+	/* Needed if only _rcfs_mknod is used instead of i_op->mkdir */
+	dir->i_nlink++;
+
+	retval = rcfs_create_coredir(dir, dentry);
+	if (retval)
+		goto mkdir_err;
+
+	/* create the default set of magic files */
+	for (i = 0; i < SOCK_MAX_MAGF; i++) {
+		mfdentry = rcfs_create_internal(dentry, &rcfs_sock_magf[i], 0);
+		mfdentry->d_fsdata = &RCFS_IS_MAGIC;
+		rcfs_get_inode_info(mfdentry->d_inode)->core = 
+			rcfs_get_inode_info(dentry->d_inode)->core;
+		rcfs_get_inode_info(mfdentry->d_inode)->mfdentry = mfdentry;
+		if (rcfs_sock_magf[i].i_fop)
+			mfdentry->d_inode->i_fop = rcfs_sock_magf[i].i_fop;
+		if (rcfs_sock_magf[i].i_op)
+			mfdentry->d_inode->i_op = rcfs_sock_magf[i].i_op;
+	}
+
+	for (i = 1; i < LAQ_NUM_ACCEPT_QUEUES; i++) {
+		j = sprintf(def_magf.name, "%d", i);
+		def_magf.name[j] = '\0';
+
+		pentry = rcfs_create_internal(dentry, &def_magf, 0);
+		retval = rcfs_create_coredir(dentry->d_inode, pentry);
+		if (retval)
+			goto mkdir_err;
+		pentry->d_fsdata = &RCFS_IS_MAGIC;
+		for (j = 0; j < LAQ_MAX_SUBMAGF; j++) {
+			mfdentry =
+			    rcfs_create_internal(pentry, &sub_magf[j], 0);
+			mfdentry->d_fsdata = &RCFS_IS_MAGIC;
+			rcfs_get_inode_info(mfdentry->d_inode)->core =
+			    rcfs_get_inode_info(pentry->d_inode)->core;
+			rcfs_get_inode_info(mfdentry->d_inode)->mfdentry =
+				 mfdentry;
+			if (sub_magf[j].i_fop)
+				mfdentry->d_inode->i_fop = sub_magf[j].i_fop;
+			if (sub_magf[j].i_op)
+				mfdentry->d_inode->i_op = sub_magf[j].i_op;
+		}
+		pentry->d_inode->i_op = &sub_iops;
+	}
+	dentry->d_inode->i_op = &class_iops;
+	return 0;
+
+      mkdir_err:
+	/* Needed */
+	dir->i_nlink--;
+	return retval;
+}
+
+char *rcfs_sock_get_name(struct ckrm_core_class *c)
+{
+	char *p = (char *)c->name;
+
+	while (*p)
+		p++;
+	while (*p != '/' && p != c->name)
+		p--;
+
+	return ++p;
+}
+
+int
+rcfs_sock_create_noperm(struct inode *dir, struct dentry *dentry, int mode,
+		   struct nameidata *nd)
+{
+	return -EPERM;
+}
+
+int rcfs_sock_unlink_noperm(struct inode *dir, struct dentry *dentry)
+{
+	return -EPERM;
+}
+
+int rcfs_sock_mkdir_noperm(struct inode *dir, struct dentry *dentry, int mode)
+{
+	return -EPERM;
+}
+
+int rcfs_sock_rmdir_noperm(struct inode *dir, struct dentry *dentry)
+{
+	return -EPERM;
+}
+
+int
+rcfs_sock_mknod_noperm(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	return -EPERM;
+}
Index: linux-2.6.11-rc5-ckrm01/include/linux/ckrm_net.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc5-ckrm01/include/linux/ckrm_net.h	2005-02-24 01:09:01.410206390 -0800
@@ -0,0 +1,42 @@
+/* ckrm_rc.h - Header file to be used by Resource controllers of CKRM
+ *
+ * Copyright (C) Vivek Kashyap , IBM Corp. 2004
+ * 
+ * Provides data structures, macros and kernel API of CKRM for 
+ * resource controllers.
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
+#ifndef _LINUX_CKRM_NET_H
+#define _LINUX_CKRM_NET_H
+
+struct ckrm_sock_class;
+
+struct ckrm_net_struct {
+	int ns_type;		/* type of net class */
+	struct sock *ns_sk;	/* pointer to socket */
+	pid_t ns_tgid;		/* real process id */
+	pid_t ns_pid;		/* calling thread's pid */
+	struct task_struct *ns_tsk;
+	int ns_family;		/* IPPROTO_IPV4 || IPPROTO_IPV6 */
+				/* Currently only IPV4 is supported */
+	union {
+		__u32 ns_dipv4;	/* V4 listener's address */
+	} ns_daddr;
+	__u16 ns_dport;		/* listener's port */
+	__u16 ns_sport;		/* sender's port */
+	atomic_t ns_refcnt;
+	struct ckrm_sock_class *core;
+	struct list_head ckrm_link;
+};
+
+#define ns_daddrv4     ns_daddr.ns_dipv4
+
+#endif
Index: linux-2.6.11-rc5-ckrm01/include/net/sock.h
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/include/net/sock.h	2005-02-23 20:03:09.000000000 -0800
+++ linux-2.6.11-rc5-ckrm01/include/net/sock.h	2005-02-24 01:09:01.422204943 -0800
@@ -112,6 +112,8 @@
 	atomic_t		skc_refcnt;
 };
 
+struct ckrm_net_struct;
+
 /**
   *	struct sock - network layer representation of sockets
   *	@__sk_common - shared layout with tcp_tw_bucket
@@ -249,6 +251,7 @@
 	struct timeval		sk_stamp;
 	struct socket		*sk_socket;
 	void			*sk_user_data;
+	struct ckrm_net_struct	*sk_ckrm_ns;
 	struct module		*sk_owner;
 	struct page		*sk_sndmsg_page;
 	__u32			sk_sndmsg_off;
Index: linux-2.6.11-rc5-ckrm01/init/Kconfig
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/init/Kconfig	2005-02-24 01:09:01.194232431 -0800
+++ linux-2.6.11-rc5-ckrm01/init/Kconfig	2005-02-24 01:09:01.423204823 -0800
@@ -173,6 +173,16 @@
 	
 	  Say N if unsure 
 
+config CKRM_TYPE_SOCKETCLASS
+	bool "Class Manager for socket groups"
+	depends on CKRM && RCFS_FS
+	help
+	  SOCKET provides the extensions for CKRM to track per socket
+	  classes.  This is the base to enable socket based resource 
+	  control for inbound connection control, bandwidth control etc.
+	
+	  Say N if unsure.  
+
 endmenu
 
 config SYSCTL
Index: linux-2.6.11-rc5-ckrm01/kernel/ckrm/ckrm_sockc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc5-ckrm01/kernel/ckrm/ckrm_sockc.c	2005-02-24 01:09:01.424204702 -0800
@@ -0,0 +1,559 @@
+/* ckrm_sock.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman,  IBM Corp. 2003
+ *	     (C) Vivek Kashyap,	IBM Corp. 2004
+ * 
+ * 
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers 
+ * (one each for cpu, memory, io, network) and callbacks for 
+ * classification modules.
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
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <asm/errno.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/ckrm_rc.h>
+#include <linux/parser.h>
+#include <net/tcp.h>
+
+#include <linux/ckrm_net.h>
+
+struct ckrm_sock_class {
+	struct ckrm_core_class core;
+};
+
+static struct ckrm_sock_class ckrm_sockclass_dflt_class = {
+};
+
+#define SOCKET_CLASS_TYPE_NAME  "socketclass"
+
+const char *dflt_sockclass_name = SOCKET_CLASS_TYPE_NAME;
+
+static struct ckrm_core_class *ckrm_sock_alloc_class(struct ckrm_core_class *parent,
+						const char *name);
+static int ckrm_sock_free_class(struct ckrm_core_class *core);
+
+static int ckrm_sock_forced_reclassify(struct ckrm_core_class * target,
+				  const char *resname);
+static int ckrm_sock_show_members(struct ckrm_core_class *core,
+			     struct seq_file *seq);
+static void ckrm_sock_add_resctrl(struct ckrm_core_class *core, int resid);
+static void ckrm_sock_reclassify_class(struct ckrm_sock_class *cls);
+
+struct ckrm_classtype ct_sockclass = {
+	.mfidx = 1,
+	.name = SOCKET_CLASS_TYPE_NAME,
+	.type_id = CKRM_CLASSTYPE_SOCKET_CLASS,
+	.maxdepth = 3,
+	.resid_reserved = 0,
+	.max_res_ctlrs = CKRM_MAX_RES_CTLRS,
+	.max_resid = 0,
+	.bit_res_ctlrs = 0L,
+	.res_ctlrs_lock = SPIN_LOCK_UNLOCKED,
+	.classes = LIST_HEAD_INIT(ct_sockclass.classes),
+
+	.default_class = &ckrm_sockclass_dflt_class.core,
+
+	/* private version of functions */
+	.alloc = &ckrm_sock_alloc_class,
+	.free = &ckrm_sock_free_class,
+	.show_members = &ckrm_sock_show_members,
+	.forced_reclassify = &ckrm_sock_forced_reclassify,
+
+	/* use of default functions */
+	.show_shares = &ckrm_class_show_shares,
+	.show_stats = &ckrm_class_show_stats,
+	.show_config = &ckrm_class_show_config,
+	.set_config = &ckrm_class_set_config,
+	.set_shares = &ckrm_class_set_shares,
+	.reset_stats = &ckrm_class_reset_stats,
+
+	/* Mandatory private version.  No default available */
+	.add_resctrl = &ckrm_sock_add_resctrl,
+};
+
+/* helper functions */
+
+void ckrm_ns_hold(struct ckrm_net_struct *ns)
+{
+	atomic_inc(&ns->ns_refcnt);
+	return;
+}
+
+void ckrm_ns_put(struct ckrm_net_struct *ns)
+{
+	if (atomic_dec_and_test(&ns->ns_refcnt))
+		kfree(ns);
+	return;
+}
+
+/*
+ * Change the class of a netstruct 
+ *
+ * Change the task's task class  to "newcls" if the task's current 
+ * class (task->taskclass) is same as given "oldcls", if it is non-NULL.
+ *
+ */
+
+static void
+ckrm_sock_set_class(struct ckrm_net_struct *ns, struct ckrm_sock_class *newcls,
+	       struct ckrm_sock_class *oldcls, enum ckrm_event event)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype;
+	void *old_res_class, *new_res_class;
+
+	if ((newcls == oldcls) || (newcls == NULL)) {
+		ns->core = (void *)oldcls;
+		return;
+	}
+
+	class_lock(class_core(newcls));
+	ns->core = newcls;
+	list_add(&ns->ckrm_link, &class_core(newcls)->objlist);
+	class_unlock(class_core(newcls));
+
+	clstype = class_isa(newcls);
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		old_res_class =
+		    oldcls ? class_core(oldcls)->res_class[i] : NULL;
+		new_res_class =
+		    newcls ? class_core(newcls)->res_class[i] : NULL;
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->change_resclass
+		    && (old_res_class != new_res_class))
+			(*rcbs->change_resclass) (ns, old_res_class,
+						  new_res_class);
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return;
+}
+
+static void ckrm_sock_add_resctrl(struct ckrm_core_class *core, int resid)
+{
+	struct ckrm_net_struct *ns;
+	struct ckrm_res_ctlr *rcbs;
+
+	if ((resid < 0) || (resid >= CKRM_MAX_RES_CTLRS)
+	    || ((rcbs = core->classtype->res_ctlrs[resid]) == NULL))
+		return;
+
+	class_lock(core);
+	list_for_each_entry(ns, &core->objlist, ckrm_link) {
+		if (rcbs->change_resclass)
+			(*rcbs->change_resclass) (ns, NULL,
+						  core->res_class[resid]);
+	}
+	class_unlock(core);
+}
+
+/**************************************************************************
+ *                   Functions called from classification points          *
+ **************************************************************************/
+
+static void cb_sockclass_listen_start(struct sock *sk)
+{
+	struct ckrm_net_struct *ns = NULL;
+	struct ckrm_sock_class *newcls = NULL;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype;
+	int i = 0;
+
+	/* XXX - TBD ipv6 */
+	if (sk->sk_family == AF_INET6)
+		return;
+
+	/* to store the socket address */
+	ns = (struct ckrm_net_struct *)
+	    kmalloc(sizeof(struct ckrm_net_struct), GFP_ATOMIC);
+	if (!ns)
+		return;
+
+	memset(ns, 0, sizeof(*ns));
+	INIT_LIST_HEAD(&ns->ckrm_link);
+	ckrm_ns_hold(ns);
+
+	ns->ns_family = sk->sk_family;
+	if (ns->ns_family == AF_INET6)	// IPv6 not supported yet.
+		return;
+
+	ns->ns_daddrv4 = inet_sk(sk)->rcv_saddr;
+	ns->ns_dport = inet_sk(sk)->num;
+
+	ns->ns_pid = current->pid;
+	ns->ns_tgid = current->tgid;
+	ns->ns_tsk = current;
+	ce_protect(&ct_sockclass);
+	CE_CLASSIFY_RET(newcls, &ct_sockclass, CKRM_EVENT_LISTEN_START, ns,
+			current);
+	ce_release(&ct_sockclass);
+
+	if (newcls == NULL) {
+		newcls = &ckrm_sockclass_dflt_class;
+		ckrm_core_grab(class_core(newcls));
+	}
+
+	class_lock(class_core(newcls));
+	list_add(&ns->ckrm_link, &class_core(newcls)->objlist);
+	ns->core = newcls;
+	class_unlock(class_core(newcls));
+
+	/*
+	 * the socket is already locked
+	 * take a reference on socket on our behalf
+	 */
+	sock_hold(sk);
+	sk->sk_ckrm_ns = (void *)ns;
+	ns->ns_sk = sk;
+
+	/* modify its shares */
+	clstype = class_isa(newcls);
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->change_resclass) {
+			(*rcbs->change_resclass) ((void *)ns,
+						  NULL,
+						  class_core(newcls)->
+						  res_class[i]);
+		}
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return;
+}
+
+static void cb_sockclass_listen_stop(struct sock *sk)
+{
+	struct ckrm_net_struct *ns = NULL;
+	struct ckrm_sock_class *newcls = NULL;
+
+	/* XXX - TBD ipv6 */
+	if (sk->sk_family == AF_INET6)
+		return;
+
+	ns = (struct ckrm_net_struct *)sk->sk_ckrm_ns;
+	if (!ns)     /* listen_start called before socket_aq was loaded */
+		return;
+
+	newcls = ns->core;
+	if (newcls) {
+		class_lock(class_core(newcls));
+		list_del(&ns->ckrm_link);
+		INIT_LIST_HEAD(&ns->ckrm_link);
+		class_unlock(class_core(newcls));
+		ckrm_core_drop(class_core(newcls));
+	}
+	/* the socket is already locked */
+	sk->sk_ckrm_ns = NULL;
+	sock_put(sk);
+
+	// Should be the last count and free it
+	ckrm_ns_put(ns);
+	return;
+}
+
+static struct ckrm_event_spec ckrm_sock_events_callbacks[] = {
+	{CKRM_EVENT_LISTEN_START, {cb_sockclass_listen_start, NULL}},
+	{CKRM_EVENT_LISTEN_STOP, {cb_sockclass_listen_stop, NULL}},
+	{-1, {NULL, NULL}}
+};
+
+/**************************************************************************
+ *                  Class Object Creation / Destruction
+ **************************************************************************/
+
+static struct ckrm_core_class *ckrm_sock_alloc_class(struct ckrm_core_class *parent,
+						const char *name)
+{
+	struct ckrm_sock_class *sockcls;
+	sockcls = kmalloc(sizeof(struct ckrm_sock_class), GFP_KERNEL);
+	if (sockcls == NULL)
+		return NULL;
+	memset(sockcls, 0, sizeof(struct ckrm_sock_class));
+
+	ckrm_init_core_class(&ct_sockclass, class_core(sockcls), parent, name);
+
+	ce_protect(&ct_sockclass);
+	if (ct_sockclass.ce_cb_active && ct_sockclass.ce_callbacks.class_add)
+		(*ct_sockclass.ce_callbacks.class_add) (name, sockcls,
+							ct_sockclass.type_id);
+	ce_release(&ct_sockclass);
+
+	return class_core(sockcls);
+}
+
+static int ckrm_sock_free_class(struct ckrm_core_class *core)
+{
+	struct ckrm_sock_class *sockcls;
+
+	if (!ckrm_is_core_valid(core)) {
+		/* Invalid core */
+		return (-EINVAL);
+	}
+	if (core == core->classtype->default_class) {
+		/* reset the name tag */
+		core->name = dflt_sockclass_name;
+		return 0;
+	}
+
+	sockcls = class_type(struct ckrm_sock_class, core);
+
+	ce_protect(&ct_sockclass);
+
+	if (ct_sockclass.ce_cb_active && ct_sockclass.ce_callbacks.class_delete)
+		(*ct_sockclass.ce_callbacks.class_delete) (core->name, sockcls,
+							   ct_sockclass.type_id);
+
+	ckrm_sock_reclassify_class(sockcls);
+
+	ce_release(&ct_sockclass);
+
+	ckrm_release_core_class(core);	
+	/* Could just drop the class?  Error message? */
+
+	return 0;
+}
+
+static int ckrm_sock_show_members(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	struct list_head *lh;
+	struct ckrm_net_struct *ns = NULL;
+
+	class_lock(core);
+	list_for_each(lh, &core->objlist) {
+		ns = container_of(lh, struct ckrm_net_struct, ckrm_link);
+		seq_printf(seq, "%d.%d.%d.%d\\%d\n",
+			   NIPQUAD(ns->ns_daddrv4), ns->ns_dport);
+	}
+	class_unlock(core);
+
+	return 0;
+}
+
+static int
+ckrm_sock_forced_reclassify_ns(struct ckrm_net_struct *tns,
+			  struct ckrm_core_class *core)
+{
+	struct ckrm_net_struct *ns = NULL;
+	struct sock *sk = NULL;
+	struct ckrm_sock_class *oldcls, *newcls;
+	int rc = -EINVAL;
+
+	if (!ckrm_is_core_valid(core)) {
+		return rc;
+	}
+
+	newcls = class_type(struct ckrm_sock_class, core);
+	/*
+	 * lookup the listening sockets
+	 * returns with a reference count set on socket
+	 */
+	if (tns->ns_family == AF_INET6)
+		return -EOPNOTSUPP;
+
+	sk = tcp_v4_lookup_listener(tns->ns_daddrv4, tns->ns_dport, 0);
+	if (!sk) {
+		printk(KERN_INFO "No such listener 0x%x:%d\n",
+		       tns->ns_daddrv4, tns->ns_dport);
+		return rc;
+	}
+	lock_sock(sk);
+	if (!sk->sk_ckrm_ns) {
+		goto out;
+	}
+	ns = sk->sk_ckrm_ns;
+	ckrm_ns_hold(ns);
+	if (!capable(CAP_NET_ADMIN) && (ns->ns_tsk->user != current->user)) {
+		ckrm_ns_put(ns);
+		rc = -EPERM;
+		goto out;
+	}
+
+	oldcls = ns->core;
+	if ((oldcls == NULL) || (oldcls == newcls)) {
+		ckrm_ns_put(ns);
+		goto out;
+	}
+	/* remove the net_struct from the current class */
+	class_lock(class_core(oldcls));
+	list_del(&ns->ckrm_link);
+	INIT_LIST_HEAD(&ns->ckrm_link);
+	ns->core = NULL;
+	class_unlock(class_core(oldcls));
+
+	ckrm_sock_set_class(ns, newcls, oldcls, CKRM_EVENT_MANUAL);
+	ckrm_ns_put(ns);
+	rc = 0;
+      out:
+	release_sock(sk);
+	sock_put(sk);
+
+	return rc;
+
+}
+
+enum ckrm_sock_target_token {
+	IPV4, IPV6, SOCKC_TARGET_ERR
+};
+
+static match_table_t ckrm_sock_target_tokens = {
+	{IPV4, "ipv4=%s"},
+	{IPV6, "ipv6=%s"},
+	{SOCKC_TARGET_ERR, NULL},
+};
+
+char *v4toi(char *s, char c, __u32 * v)
+{
+	unsigned int k = 0, n = 0;
+
+	while (*s && (*s != c)) {
+		if (*s == '.') {
+			n <<= 8;
+			n |= k;
+			k = 0;
+		} else
+			k = k * 10 + *s - '0';
+		s++;
+	}
+
+	n <<= 8;
+	*v = n | k;
+
+	return s;
+}
+
+static int
+ckrm_sock_forced_reclassify(struct ckrm_core_class *target, const char *options)
+{
+	char *p, *p2;
+	struct ckrm_net_struct ns;
+	__u32 v4addr, tmp;
+
+	if (!options)
+		return -EINVAL;
+
+	if (target == NULL) {
+		unsigned long id = simple_strtol(options,NULL,0);
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (id != 0) 
+			return -EINVAL;
+		printk("ckrm_sock_class: reclassify all not net implemented\n");
+		return 0;
+	}
+
+	while ((p = strsep((char **)&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, ckrm_sock_target_tokens, args);
+		switch (token) {
+
+		case IPV4:
+
+			p2 = p;
+			while (*p2 && (*p2 != '='))
+				++p2;
+			p2++;
+			p2 = v4toi(p2, '\\', &(v4addr));
+			ns.ns_daddrv4 = htonl(v4addr);
+			ns.ns_family = AF_INET;
+			p2 = v4toi(++p2, ':', &tmp);
+			ns.ns_dport = (__u16) tmp;
+			if (*p2)
+				p2 = v4toi(++p2, '\0', &ns.ns_pid);
+			ckrm_sock_forced_reclassify_ns(&ns, target);
+			break;
+
+		case IPV6:
+			printk(KERN_INFO "rcfs: IPV6 not supported yet\n");
+			return -ENOSYS;
+		default:
+			return -EINVAL;
+		}
+	}
+	return -EINVAL;
+}
+
+/*
+ * Listen_aq reclassification.
+ */
+static void ckrm_sock_reclassify_class(struct ckrm_sock_class *cls)
+{
+	struct ckrm_net_struct *ns, *tns;
+	struct ckrm_core_class *core = class_core(cls);
+	LIST_HEAD(local_list);
+
+	if (!cls)
+		return;
+
+	if (!ckrm_validate_and_grab_core(core))
+		return;
+
+	class_lock(core);
+	/* we have the core refcnt */
+	if (list_empty(&core->objlist)) {
+		class_unlock(core);
+		ckrm_core_drop(core);
+		return;
+	}
+
+	INIT_LIST_HEAD(&local_list);
+	list_splice_init(&core->objlist, &local_list);
+	class_unlock(core);
+	ckrm_core_drop(core);
+
+	list_for_each_entry_safe(ns, tns, &local_list, ckrm_link) {
+		ckrm_ns_hold(ns);
+		list_del(&ns->ckrm_link);
+		if (ns->ns_sk) {
+			lock_sock(ns->ns_sk);
+			ckrm_sock_set_class(ns, &ckrm_sockclass_dflt_class, NULL,
+				       CKRM_EVENT_MANUAL);
+			release_sock(ns->ns_sk);
+		}
+		ckrm_ns_put(ns);
+	}
+	return;
+}
+
+void __init ckrm_meta_init_sockclass(void)
+{
+	printk("...... Initializing ClassType<%s> ........\n",
+	       ct_sockclass.name);
+	/* intialize the default class */
+	ckrm_init_core_class(&ct_sockclass, class_core(&ckrm_sockclass_dflt_class),
+			     NULL, dflt_sockclass_name);
+
+	/* register classtype and initialize default task class */
+	ckrm_register_classtype(&ct_sockclass);
+	ckrm_register_event_set(ckrm_sock_events_callbacks);
+
+	/*
+	 * note registeration of all resource controllers will be done
+	 * later dynamically as these are specified as modules
+	 */
+}
Index: linux-2.6.11-rc5-ckrm01/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/kernel/ckrm/Makefile	2005-02-24 01:09:01.196232190 -0800
+++ linux-2.6.11-rc5-ckrm01/kernel/ckrm/Makefile	2005-02-24 01:09:01.425204582 -0800
@@ -4,3 +4,4 @@
 
 obj-y += ckrm_events.o ckrm.o ckrmutils.o
 obj-$(CONFIG_CKRM_TYPE_TASKCLASS) += ckrm_tc.o
+obj-$(CONFIG_CKRM_TYPE_SOCKETCLASS) += ckrm_sockc.o
Index: linux-2.6.11-rc5-ckrm01/net/ipv4/tcp_ipv4.c
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/net/ipv4/tcp_ipv4.c	2005-02-24 01:09:01.308218687 -0800
+++ linux-2.6.11-rc5-ckrm01/net/ipv4/tcp_ipv4.c	2005-02-24 01:09:01.426204461 -0800
@@ -448,7 +448,8 @@
 }
 
 /* Optimize the common listener case. */
-static inline struct sock *tcp_v4_lookup_listener(u32 daddr,
+/* XXX:  Was inline - need to use for CKRM, fix before next release */
+struct sock *tcp_v4_lookup_listener(u32 daddr,
 		unsigned short hnum, int dif)
 {
 	struct sock *sk = NULL;
Index: linux-2.6.11-rc5-ckrm01/include/net/tcp.h
===================================================================
--- linux-2.6.11-rc5-ckrm01.orig/include/net/tcp.h	2005-02-23 20:02:22.000000000 -0800
+++ linux-2.6.11-rc5-ckrm01/include/net/tcp.h	2005-02-24 01:09:01.441202653 -0800
@@ -800,6 +800,7 @@
 
 extern void			tcp_rcv_space_adjust(struct sock *sk);
 
+
 enum tcp_ack_state_t
 {
 	TCP_ACK_SCHED = 1,
@@ -930,6 +931,9 @@
 
 extern int			tcp_v4_hash_connecting(struct sock *sk);
 
+extern struct sock *		tcp_v4_lookup_listener(u32 daddr,
+						    unsigned short hnum,
+						    int dif);
 
 /* From syncookies.c */
 extern struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb, 

