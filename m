Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUCKQyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUCKQyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:54:49 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:2544 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261530AbUCKQxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:53:21 -0500
Subject: [PATCH][SELINUX] Conditional policy extension and MLS detection
	support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>,
       Karl MacMillan <kmacmillan@tresys.com>,
       Chad Hanson <chanson@tcs-sec.com>, Frank Mayer <mayerf@tresys.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1079023963.5752.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 11 Mar 2004 11:52:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.4 extends the SELinux policy engine to support
conditional policy logic based on a set of policy booleans, allowing
well-formed changes to the policy to be defined within and mediated by
the policy itself.  The conditional policy extensions were implemented
and contributed by Tresys Technology.  Userland packages that support
these extensions are already available from nsa.gov/selinux, and
backward compatibility is provided for the prior policy version.  The
patch also includes a small change to enable detection of the optional
MLS policy model on a SELinux system and fixes to the conditional policy
extensions to allow the MLS policy to work correctly with them that were
implemented and contributed by Trusted Computer Solutions.  Please
apply.  


 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    1 
 security/selinux/include/conditional.h       |   22 +
 security/selinux/include/security.h          |   11 
 security/selinux/selinuxfs.c                 |  434 +++++++++++++++++++++++-
 security/selinux/ss/Makefile                 |    2 
 security/selinux/ss/avtab.c                  |  256 ++++++++++----
 security/selinux/ss/avtab.h                  |   20 +
 security/selinux/ss/conditional.c            |  487 +++++++++++++++++++++++++++
 security/selinux/ss/conditional.h            |   77 ++++
 security/selinux/ss/mls.h                    |   12 
 security/selinux/ss/policydb.c               |   78 +++-
 security/selinux/ss/policydb.h               |   33 +
 security/selinux/ss/services.c               |  141 +++++++
 14 files changed, 1480 insertions(+), 95 deletions(-)

Index: linux-2.6/security/selinux/selinuxfs.c
diff -u linux-2.6/security/selinux/selinuxfs.c:1.1.1.6 linux-2.6/security/selinux/selinuxfs.c:1.40
--- linux-2.6/security/selinux/selinuxfs.c:1.1.1.6	Thu Mar 11 08:25:16 2004
+++ linux-2.6/security/selinux/selinuxfs.c	Thu Mar 11 11:19:06 2004
@@ -1,5 +1,16 @@
+/* Updated: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
@@ -7,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
@@ -16,6 +28,14 @@
 #include "avc_ss.h"
 #include "security.h"
 #include "objsec.h"
+#include "conditional.h"
+
+static DECLARE_MUTEX(sel_sem);
+
+/* global data for booleans */
+static struct dentry *bool_dir = NULL;
+static int bool_num = 0;
+static int *bool_pending_values = NULL;
 
 extern void selnl_notify_setenforce(int val);
 
@@ -40,7 +60,9 @@
 	SEL_CREATE,	/* compute create labeling decision */
 	SEL_RELABEL,	/* compute relabeling decision */
 	SEL_USER,	/* compute reachable user contexts */
-	SEL_POLICYVERS	/* return policy version for this kernel */
+	SEL_POLICYVERS,	/* return policy version for this kernel */
+	SEL_COMMIT_BOOLS,
+	SEL_MLS		/* return if MLS policy is enabled */
 };
 
 static ssize_t sel_read_enforce(struct file *filp, char *buf,
@@ -169,24 +191,74 @@
 	.read		= sel_read_policyvers,
 };
 
+/* declaration for sel_write_load */
+static int sel_make_bools(void);
+
+static ssize_t sel_read_mls(struct file *filp, char *buf,
+				size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+	ssize_t end;
+
+	if (count < 0 || count > PAGE_SIZE)
+		return -EINVAL;
+	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+
+	length = scnprintf(page, PAGE_SIZE, "%d", selinux_mls_enabled);
+	if (length < 0) {
+		free_page((unsigned long)page);
+		return length;
+	}
+
+	if (*ppos >= length) {
+		free_page((unsigned long)page);
+		return 0;
+	}
+	if (count + *ppos > length)
+		count = length - *ppos;
+	end = count + *ppos;
+	if (copy_to_user(buf, (char *) page + *ppos, count)) {
+		count = -EFAULT;
+		goto out;
+	}
+	*ppos = end;
+out:
+	free_page((unsigned long)page);
+	return count;
+}
+
+static struct file_operations sel_mls_ops = {
+	.read		= sel_read_mls,
+};
+
 static ssize_t sel_write_load(struct file * file, const char * buf,
 			      size_t count, loff_t *ppos)
 
 {
+	int ret;
 	ssize_t length;
-	void *data;
+	void *data = NULL;
+
+	down(&sel_sem);
 
 	length = task_has_security(current, SECURITY__LOAD_POLICY);
 	if (length)
-		return length;
+		goto out;
 
 	if (*ppos != 0) {
 		/* No partial writes. */
-		return -EINVAL;
+		length = -EINVAL;
+		goto out;
 	}
 
-	if ((count < 0) || (count > 64 * 1024 * 1024) || (data = vmalloc(count)) == NULL)
-		return -ENOMEM;
+	if ((count < 0) || (count > 64 * 1024 * 1024)
+	    || (data = vmalloc(count)) == NULL) {
+		length = -ENOMEM;
+		goto out;
+	}
 
 	length = -EFAULT;
 	if (copy_from_user(data, buf, count) != 0)
@@ -196,8 +268,13 @@
 	if (length)
 		goto out;
 
-	length = count;
+	ret = sel_make_bools();
+	if (ret)
+		length = ret;
+	else
+		length = count;
 out:
+	up(&sel_sem);
 	vfree(data);
 	return length;
 }
@@ -601,9 +678,322 @@
 	return length;
 }
 
+static struct inode *sel_make_inode(struct super_block *sb, int mode)
+{
+	struct inode *ret = new_inode(sb);
+
+	if (ret) {
+		ret->i_mode = mode;
+		ret->i_uid = ret->i_gid = 0;
+		ret->i_blksize = PAGE_CACHE_SIZE;
+		ret->i_blocks = 0;
+		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
+	}
+	return ret;
+}
+
+#define BOOL_INO_OFFSET 30
+
+static ssize_t sel_read_bool(struct file *filep, char *buf,
+			     size_t count, loff_t *ppos)
+{
+	char *page = NULL;
+	ssize_t length;
+	ssize_t end;
+	ssize_t ret;
+	int cur_enforcing;
+	struct inode *inode;
+	
+	down(&sel_sem);
+	
+	ret = -EFAULT;
+
+	/* check to see if this file has been deleted */
+	if (!filep->f_op)
+		goto out;
+
+	if (count < 0 || count > PAGE_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (!(page = (char*)__get_free_page(GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(page, 0, PAGE_SIZE);
+	
+	inode = filep->f_dentry->d_inode;
+	cur_enforcing = security_get_bool_value(inode->i_ino - BOOL_INO_OFFSET);
+	if (cur_enforcing < 0) {
+		ret = cur_enforcing;
+		goto out;
+	}
+
+	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
+			  bool_pending_values[inode->i_ino - BOOL_INO_OFFSET]);
+	if (length < 0) {
+		ret = length;
+		goto out;
+	}
+
+	if (*ppos >= length) {
+		ret = 0;
+		goto out;
+	}
+	if (count + *ppos > length)
+		count = length - *ppos;
+	end = count + *ppos;
+	if (copy_to_user(buf, (char *) page + *ppos, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	*ppos = end;
+	ret = count;
+out:
+	up(&sel_sem);
+	if (page)
+		free_page((unsigned long)page);
+	return ret;
+}
+
+static ssize_t sel_write_bool(struct file *filep, const char *buf,
+			      size_t count, loff_t *ppos)
+{
+	char *page = NULL;
+	ssize_t length = -EFAULT;
+	int new_value;
+	struct inode *inode;
+
+	down(&sel_sem);
+	
+	length = task_has_security(current, SECURITY__SETBOOL);
+	if (length)
+		goto out;
+
+	/* check to see if this file has been deleted */
+	if (!filep->f_op)
+		goto out;
+
+	if (count < 0 || count >= PAGE_SIZE) {
+		length = -ENOMEM;
+		goto out;
+	}
+	if (*ppos != 0) {
+		/* No partial writes. */
+		goto out;
+	}
+	page = (char*)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%d", &new_value) != 1)
+		goto out;
+
+	if (new_value)
+		new_value = 1;
+
+	inode = filep->f_dentry->d_inode;
+	bool_pending_values[inode->i_ino - BOOL_INO_OFFSET] = new_value;
+	length = count;
+
+out:
+	up(&sel_sem);
+	if (page)
+		free_page((unsigned long) page);
+	return length;
+}
+
+static struct file_operations sel_bool_ops = {
+	.read           = sel_read_bool,
+	.write          = sel_write_bool,
+};
+
+static ssize_t sel_commit_bools_write(struct file *filep, const char *buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page = NULL;
+	ssize_t length = -EFAULT;
+	int new_value;
+
+	down(&sel_sem);
+
+	length = task_has_security(current, SECURITY__SETBOOL);
+	if (length)
+		goto out;
+
+	/* check to see if this file has been deleted */
+	if (!filep->f_op)
+		goto out;
+
+	if (count < 0 || count >= PAGE_SIZE) {
+		length = -ENOMEM;
+		goto out;
+	}
+	if (*ppos != 0) {
+		/* No partial writes. */
+		goto out;
+	}
+	page = (char*)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;	       
+
+	memset(page, 0, PAGE_SIZE);
+
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%d", &new_value) != 1)
+		goto out;
+
+	if (new_value) {
+		security_set_bools(bool_num, bool_pending_values);
+	}
+
+	length = count;
+
+out:
+	up(&sel_sem);
+	if (page)
+		free_page((unsigned long) page);
+	return length;
+}
+
+static struct file_operations sel_commit_bools_ops = {
+	.write          = sel_commit_bools_write,
+};
+
+/* delete booleans - partial revoke() from
+ * fs/proc/generic.c proc_kill_inodes */
+static void sel_remove_bools(struct dentry *de)
+{
+	struct list_head *p, *node;
+	struct super_block *sb = de->d_sb;
+	
+	spin_lock(&dcache_lock);
+	node = de->d_subdirs.next;
+	while (node != &de->d_subdirs) {
+		struct dentry *d = list_entry(node, struct dentry, d_child);
+		list_del_init(node);
+
+		if (d->d_inode) {
+			d = dget_locked(d);
+			spin_unlock(&dcache_lock);
+			d_delete(d);
+			simple_unlink(de->d_inode, d);
+			dput(d);
+			spin_lock(&dcache_lock);
+		}
+		node = de->d_subdirs.next;
+	}
+
+	spin_unlock(&dcache_lock);
+
+	file_list_lock();
+	list_for_each(p, &sb->s_files) {
+		struct file * filp = list_entry(p, struct file, f_list);
+		struct dentry * dentry = filp->f_dentry;
+
+		if (dentry->d_parent != de) {
+			continue;
+		}
+		filp->f_op = NULL;
+	}
+	file_list_unlock();
+}
+
+#define BOOL_DIR_NAME "booleans"
+
+static int sel_make_bools(void)
+{
+	int i, ret = 0;
+	ssize_t len;
+	struct dentry *dentry = NULL;
+	struct dentry *dir = bool_dir;
+	struct inode *inode = NULL;
+	struct inode_security_struct *isec;
+	struct qstr qname;
+	char **names = NULL, *page;
+	int num;
+	int *values = NULL;
+	u32 sid;
+
+	/* remove any existing files */
+	if (bool_pending_values)
+		kfree(bool_pending_values);
+	
+	sel_remove_bools(dir);
+
+	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+
+	ret = security_get_bools(&num, &names, &values);
+	if (ret != 0)
+		goto out;
+	
+	for (i = 0; i < num; i++) {
+		qname.name = names[i];
+		qname.len = strlen(qname.name);
+		qname.hash = full_name_hash(qname.name, qname.len);
+		dentry = d_alloc(dir, &qname);
+		if (!dentry) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
+		if (!inode) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
+		if (len < 0) {
+			ret = -EINVAL;
+			goto err;
+		} else if (len >= PAGE_SIZE) {
+			ret = -ENAMETOOLONG;
+			goto err;
+		}
+		isec = (struct inode_security_struct*)inode->i_security;
+		if ((ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid)))
+			goto err;
+		isec->sid = sid;
+		isec->initialized = 1;
+		inode->i_fop = &sel_bool_ops;
+		inode->i_ino = i + BOOL_INO_OFFSET;
+		d_add(dentry, inode);
+	}
+	bool_num = num;
+	bool_pending_values = values;
+out:
+	free_page((unsigned long)page);
+	if (names) {
+		for (i = 0; i < num; i++) {
+			if (names[i])
+				kfree(names[i]);
+		}
+		kfree(names);
+	}
+	return ret;
+err:
+	d_genocide(dir);
+	ret = -ENOMEM;
+	goto out;
+}
 
 static int sel_fill_super(struct super_block * sb, void * data, int silent)
 {
+	int ret;
+	struct dentry *dentry;
+	struct inode *inode;
+	struct qstr qname;
+
 	static struct tree_descr selinux_files[] = {
 		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
 		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUGO|S_IWUSR},
@@ -613,9 +1003,37 @@
 		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
+		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
+		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
 		/* last one */ {""}
 	};
-	return simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
+	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
+	if (ret)
+		return ret;
+
+	qname.name = BOOL_DIR_NAME;
+	qname.len = strlen(qname.name);
+	qname.hash = full_name_hash(qname.name, qname.len);
+	dentry = d_alloc(sb->s_root, &qname);
+	if (!dentry)
+		return -ENOMEM;
+
+	inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+	if (!inode)
+		goto out;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	d_add(dentry, inode);
+	bool_dir = dentry;
+	ret = sel_make_bools();
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	dput(dentry);
+	printk(KERN_ERR "security:	error creating conditional out_dput\n");
+	return -ENOMEM;
 }
 
 static struct super_block *sel_get_sb(struct file_system_type *fs_type,
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
diff -u linux-2.6/security/selinux/include/av_perm_to_string.h:1.1.1.3 linux-2.6/security/selinux/include/av_perm_to_string.h:1.9
--- linux-2.6/security/selinux/include/av_perm_to_string.h:1.1.1.3	Wed Feb  4 08:46:40 2004
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	Wed Feb  4 12:58:52 2004
@@ -84,6 +84,7 @@
    { SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL, "compute_relabel" },
    { SECCLASS_SECURITY, SECURITY__COMPUTE_USER, "compute_user" },
    { SECCLASS_SECURITY, SECURITY__SETENFORCE, "setenforce" },
+   { SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool" },
    { SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info" },
    { SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read" },
    { SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod" },
Index: linux-2.6/security/selinux/include/av_permissions.h
diff -u linux-2.6/security/selinux/include/av_permissions.h:1.1.1.3 linux-2.6/security/selinux/include/av_permissions.h:1.8
--- linux-2.6/security/selinux/include/av_permissions.h:1.1.1.3	Wed Feb  4 08:46:40 2004
+++ linux-2.6/security/selinux/include/av_permissions.h	Wed Feb  4 12:58:52 2004
@@ -512,6 +512,7 @@
 #define SECURITY__COMPUTE_RELABEL                 0x00000020UL
 #define SECURITY__COMPUTE_USER                    0x00000040UL
 #define SECURITY__SETENFORCE                      0x00000080UL
+#define SECURITY__SETBOOL                         0x00000100UL
 
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
Index: linux-2.6/security/selinux/include/conditional.h
diff -u /dev/null linux-2.6/security/selinux/include/conditional.h:1.1
--- /dev/null	Thu Mar 11 11:24:31 2004
+++ linux-2.6/security/selinux/include/conditional.h	Thu Feb  5 08:53:05 2004
@@ -0,0 +1,22 @@
+/*
+ * Interface to booleans in the security server. This is exported
+ * for the selinuxfs.
+ *
+ * Author: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#ifndef _SELINUX_CONDITIONAL_H_
+#define _SELINUX_CONDITIONAL_H_
+
+int security_get_bools(int *len, char ***names, int **values);
+
+int security_set_bools(int len, int *values);
+
+int security_get_bool_value(int bool);
+
+#endif
Index: linux-2.6/security/selinux/include/security.h
diff -u linux-2.6/security/selinux/include/security.h:1.1.1.4 linux-2.6/security/selinux/include/security.h:1.15
--- linux-2.6/security/selinux/include/security.h:1.1.1.4	Wed Feb 18 08:42:09 2004
+++ linux-2.6/security/selinux/include/security.h	Wed Mar  3 13:18:33 2004
@@ -2,7 +2,9 @@
  * Security server interface.
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ *
  */
+
 #ifndef _SELINUX_SECURITY_H_
 #define _SELINUX_SECURITY_H_
 
@@ -13,12 +15,19 @@
 #define SECCLASS_NULL			0x0000 /* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c
-#define POLICYDB_VERSION 15
+#define POLICYDB_VERSION 16
+#define POLICYDB_VERSION_COMPAT 15
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
 #else
 #define selinux_enabled 1
+#endif
+
+#ifdef CONFIG_SECURITY_SELINUX_MLS
+#define selinux_mls_enabled 1
+#else
+#define selinux_mls_enabled 0
 #endif
 
 int security_load_policy(void * data, size_t len);
Index: linux-2.6/security/selinux/ss/Makefile
diff -u linux-2.6/security/selinux/ss/Makefile:1.1.1.3 linux-2.6/security/selinux/ss/Makefile:1.9
--- linux-2.6/security/selinux/ss/Makefile:1.1.1.3	Wed Feb  4 08:46:37 2004
+++ linux-2.6/security/selinux/ss/Makefile	Wed Feb  4 12:57:33 2004
@@ -5,7 +5,7 @@
 EXTRA_CFLAGS += -Isecurity/selinux/include
 obj-y := ss.o
 
-ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
+ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o
 
 ss-$(CONFIG_SECURITY_SELINUX_MLS) += mls.o
 
Index: linux-2.6/security/selinux/ss/avtab.c
diff -u linux-2.6/security/selinux/ss/avtab.c:1.1.1.4 linux-2.6/security/selinux/ss/avtab.c:1.17
--- linux-2.6/security/selinux/ss/avtab.c:1.1.1.4	Wed Feb 18 08:42:08 2004
+++ linux-2.6/security/selinux/ss/avtab.c	Wed Feb 11 09:10:55 2004
@@ -3,10 +3,22 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
+
 #include "avtab.h"
 #include "policydb.h"
 
@@ -16,6 +28,29 @@
  (keyp->source_type << 9)) & \
  AVTAB_HASH_MASK)
 
+static struct avtab_node*
+avtab_insert_node(struct avtab *h, int hvalue, struct avtab_node * prev, struct avtab_node * cur,
+		  struct avtab_key *key, struct avtab_datum *datum)
+{
+	struct avtab_node * newnode;
+	newnode = (struct avtab_node *) kmalloc(sizeof(struct avtab_node),GFP_KERNEL);
+	if (newnode == NULL)
+		return NULL;
+	memset(newnode, 0, sizeof(struct avtab_node));
+	newnode->key = *key;
+	newnode->datum = *datum;
+	if (prev) {
+		newnode->next = prev->next;
+		prev->next = newnode;
+	} else {
+		newnode->next = h->htable[hvalue];
+		h->htable[hvalue] = newnode;
+	}
+
+	h->nel++;
+	return newnode;
+}
+
 int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
 {
 	int hvalue;
@@ -44,24 +79,48 @@
 			break;
 	}
 
-	newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);
-	if (newnode == NULL)
+	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	if(!newnode)
 		return -ENOMEM;
-	memset(newnode, 0, sizeof(*newnode));
-	newnode->key = *key;
-	newnode->datum = *datum;
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		newnode->next = h->htable[hvalue];
-		h->htable[hvalue] = newnode;
-	}
 
-	h->nel++;
 	return 0;
 }
 
+/* Unlike avtab_insert(), this function allow multiple insertions of the same 
+ * key/specified mask into the table, as needed by the conditional avtab.  
+ * It also returns a pointer to the node inserted.
+ */
+struct avtab_node *
+avtab_insert_nonunique(struct avtab * h, struct avtab_key * key, struct avtab_datum * datum)
+{
+	int hvalue;
+	struct avtab_node *prev, *cur, *newnode;
+
+	if (!h)
+		return NULL;
+	hvalue = AVTAB_HASH(key);
+	for (prev = NULL, cur = h->htable[hvalue];
+	     cur;
+	     prev = cur, cur = cur->next) {
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class == cur->key.target_class &&
+		    (datum->specified & cur->datum.specified))
+			break;
+		if (key->source_type < cur->key.source_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type < cur->key.target_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class < cur->key.target_class)
+			break;
+	}
+	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	
+	return newnode;
+}
 
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key, int specified)
 {
@@ -93,6 +152,67 @@
 	return NULL;
 }
 
+/* This search function returns a node pointer, and can be used in
+ * conjunction with avtab_search_next_node()
+ */
+struct avtab_node*
+avtab_search_node(struct avtab *h, struct avtab_key *key, int specified)
+{
+	int hvalue;
+	struct avtab_node *cur;
+
+	if (!h)
+		return NULL;
+
+	hvalue = AVTAB_HASH(key);
+	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class == cur->key.target_class &&
+		    (specified & cur->datum.specified))
+			return cur;
+
+		if (key->source_type < cur->key.source_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type < cur->key.target_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class < cur->key.target_class)
+			break;
+	}
+	return NULL;
+}
+
+struct avtab_node*
+avtab_search_node_next(struct avtab_node *node, int specified)
+{
+	struct avtab_node *cur;
+
+	if (!node)
+		return NULL;
+		
+	for (cur = node->next; cur; cur = cur->next) {
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type == cur->key.target_type &&
+		    node->key.target_class == cur->key.target_class &&
+		    (specified & cur->datum.specified))
+			return cur;
+
+		if (node->key.source_type < cur->key.source_type)
+			break;
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type < cur->key.target_type)
+			break;
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type == cur->key.target_type &&
+		    node->key.target_class < cur->key.target_class)
+			break;
+	}
+	return NULL;
+}
+
 void avtab_destroy(struct avtab *h)
 {
 	int i;
@@ -179,13 +299,72 @@
 	       max_chain_len);
 }
 
+int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
+{
+	__u32 *buf;
+	__u32 items, items2;
+
+	memset(avkey, 0, sizeof(struct avtab_key));
+	memset(avdatum, 0, sizeof(struct avtab_datum));
+	
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf) {
+		printk(KERN_ERR "security: avtab: truncated entry\n");
+		goto bad;
+	}
+	items2 = le32_to_cpu(buf[0]);
+	buf = next_entry(fp, sizeof(__u32)*items2);
+	if (!buf) {
+		printk(KERN_ERR "security: avtab: truncated entry\n");
+		goto bad;
+	}
+	items = 0;
+	avkey->source_type = le32_to_cpu(buf[items++]);
+	avkey->target_type = le32_to_cpu(buf[items++]);
+	avkey->target_class = le32_to_cpu(buf[items++]);
+	avdatum->specified = le32_to_cpu(buf[items++]);
+	if (!(avdatum->specified & (AVTAB_AV | AVTAB_TYPE))) {
+		printk(KERN_ERR "security: avtab: null entry\n");
+		goto bad;
+	}
+	if ((avdatum->specified & AVTAB_AV) &&
+	    (avdatum->specified & AVTAB_TYPE)) {
+		printk(KERN_ERR "security: avtab: entry has both access vectors and types\n");
+		goto bad;
+	}
+	if (avdatum->specified & AVTAB_AV) {
+		if (avdatum->specified & AVTAB_ALLOWED)
+			avtab_allowed(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_AUDITDENY) 
+			avtab_auditdeny(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_AUDITALLOW) 
+			avtab_auditallow(avdatum) = le32_to_cpu(buf[items++]);
+	} else {		
+		if (avdatum->specified & AVTAB_TRANSITION)
+			avtab_transition(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_CHANGE)
+			avtab_change(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_MEMBER)
+			avtab_member(avdatum) = le32_to_cpu(buf[items++]);
+	}	
+	if (items != items2) {
+		printk(KERN_ERR "security: avtab: entry only had %d items, expected %d\n",
+		       items2, items);
+		goto bad;
+	}
+	
+	return 0;
+bad:
+	return -1;
+}
+
 int avtab_read(struct avtab *a, void *fp, u32 config)
 {
 	int i, rc = -EINVAL;
 	struct avtab_key avkey;
 	struct avtab_datum avdatum;
 	u32 *buf;
-	u32 nel, items, items2;
+	u32 nel;
 
 
 	buf = next_entry(fp, sizeof(u32));
@@ -199,55 +378,8 @@
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
-		memset(&avkey, 0, sizeof(avkey));
-		memset(&avdatum, 0, sizeof(avdatum));
-
-		buf = next_entry(fp, sizeof(u32));
-		if (!buf) {
-			printk(KERN_ERR "security: avtab: truncated entry\n");
-			goto bad;
-		}
-		items2 = le32_to_cpu(buf[0]);
-		buf = next_entry(fp, sizeof(u32)*items2);
-		if (!buf) {
-			printk(KERN_ERR "security: avtab: truncated entry\n");
-			goto bad;
-		}
-		items = 0;
-		avkey.source_type = le32_to_cpu(buf[items++]);
-		avkey.target_type = le32_to_cpu(buf[items++]);
-		avkey.target_class = le32_to_cpu(buf[items++]);
-		avdatum.specified = le32_to_cpu(buf[items++]);
-		if (!(avdatum.specified & (AVTAB_AV | AVTAB_TYPE))) {
-			printk(KERN_ERR "security: avtab: null entry\n");
-			goto bad;
-		}
-		if ((avdatum.specified & AVTAB_AV) &&
-		    (avdatum.specified & AVTAB_TYPE)) {
-			printk(KERN_ERR "security: avtab: entry has both "
-			       "access vectors and types\n");
+		if (avtab_read_item(fp, &avdatum, &avkey))
 			goto bad;
-		}
-		if (avdatum.specified & AVTAB_AV) {
-			if (avdatum.specified & AVTAB_ALLOWED)
-				avtab_allowed(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_AUDITDENY)
-				avtab_auditdeny(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_AUDITALLOW)
-				avtab_auditallow(&avdatum) = le32_to_cpu(buf[items++]);
-		} else {
-			if (avdatum.specified & AVTAB_TRANSITION)
-				avtab_transition(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_CHANGE)
-				avtab_change(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_MEMBER)
-				avtab_member(&avdatum) = le32_to_cpu(buf[items++]);
-		}
-		if (items != items2) {
-			printk(KERN_ERR "security: avtab: entry only had %d "
-			       "items, expected %d\n", items2, items);
-			goto bad;
-		}
 		rc = avtab_insert(a, &avkey, &avdatum);
 		if (rc) {
 			if (rc == -ENOMEM)
Index: linux-2.6/security/selinux/ss/avtab.h
diff -u linux-2.6/security/selinux/ss/avtab.h:1.1.1.1 linux-2.6/security/selinux/ss/avtab.h:1.12
--- linux-2.6/security/selinux/ss/avtab.h:1.1.1.1	Tue Aug 12 09:05:06 2003
+++ linux-2.6/security/selinux/ss/avtab.h	Wed Feb  4 12:57:33 2004
@@ -7,6 +7,16 @@
  *
  *  Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
 #ifndef _SS_AVTAB_H_
 #define _SS_AVTAB_H_
 
@@ -25,6 +35,7 @@
 #define AVTAB_MEMBER     32
 #define AVTAB_CHANGE     64
 #define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
+#define AVTAB_ENABLED    0x80000000 /* reserved for used in cond_avtab */
 	u32 specified;	/* what fields are specified */
 	u32 data[3];	/* access vectors or types */
 #define avtab_allowed(x) (x)->data[0]
@@ -56,7 +67,16 @@
 			    void *args),
 	      void *args);
 void avtab_hash_eval(struct avtab *h, char *tag);
+
+int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey);
 int avtab_read(struct avtab *a, void *fp, u32 config);
+
+struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
+					  struct avtab_datum *datum);
+
+struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key, int specified);
+
+struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
 #define AVTAB_HASH_BITS 15
 #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
Index: linux-2.6/security/selinux/ss/conditional.c
diff -u /dev/null linux-2.6/security/selinux/ss/conditional.c:1.2
--- /dev/null	Thu Mar 11 11:24:31 2004
+++ linux-2.6/security/selinux/ss/conditional.c	Wed Feb 11 14:22:23 2004
@@ -0,0 +1,487 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Frank Mayer <mayerf@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
+#include <linux/slab.h>
+
+#include "security.h"
+#include "conditional.h"
+
+/*
+ * cond_evaluate_expr evaluates a conditional expr
+ * in reverse polish notation. It returns true (1), false (0),
+ * or undefined (-1). Undefined occurs when the expression
+ * exceeds the stack depth of COND_EXPR_MAXDEPTH.
+ */
+static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
+{
+
+	struct cond_expr *cur;
+	int s[COND_EXPR_MAXDEPTH];
+	int sp = -1;
+
+	for (cur = expr; cur != NULL; cur = cur->next) {
+		switch (cur->expr_type) {
+		case COND_BOOL:
+			if (sp == (COND_EXPR_MAXDEPTH - 1))
+				return -1;
+			sp++;
+			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
+			break;
+		case COND_NOT:
+			if (sp < 0)
+				return -1;
+			s[sp] = !s[sp];
+			break;
+		case COND_OR:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] |= s[sp + 1];
+			break;
+		case COND_AND:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] &= s[sp + 1];
+			break;
+		case COND_XOR:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] ^= s[sp + 1];
+			break;
+		case COND_EQ:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] = (s[sp] == s[sp + 1]);
+			break;
+		case COND_NEQ:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] = (s[sp] != s[sp + 1]);
+			break;
+		default:
+			return -1;
+		}
+	}
+	return s[0];
+}
+
+/*
+ * evaluate_cond_node evaluates the conditional stored in
+ * a struct cond_node and if the result is different than the
+ * current state of the node it sets the rules in the true/false
+ * list appropriately. If the result of the expression is undefined
+ * all of the rules are disabled for safety.
+ */
+int evaluate_cond_node(struct policydb *p, struct cond_node *node)
+{
+	int new_state;
+	struct cond_av_list* cur;
+
+	new_state = cond_evaluate_expr(p, node->expr);
+	if (new_state != node->cur_state) {
+		node->cur_state = new_state;
+		if (new_state == -1)
+			printk(KERN_ERR "security: expression result was undefined - disabling all rules.\n");
+		/* turn the rules on or off */
+		for (cur = node->true_list; cur != NULL; cur = cur->next) {
+			if (new_state <= 0) {
+				cur->node->datum.specified &= ~AVTAB_ENABLED;
+			} else {
+				cur->node->datum.specified |= AVTAB_ENABLED;
+			}
+		}
+
+		for (cur = node->false_list; cur != NULL; cur = cur->next) {	
+			/* -1 or 1 */
+			if (new_state) {
+				cur->node->datum.specified &= ~AVTAB_ENABLED;
+			} else {
+				cur->node->datum.specified |= AVTAB_ENABLED;
+			}
+		}
+	}
+	return 0;
+}
+
+int cond_policydb_init(struct policydb *p)
+{
+	p->bool_val_to_struct = NULL;
+	p->cond_list = NULL;
+	if (avtab_init(&p->te_cond_avtab))
+		return -1;
+
+	return 0;
+}
+
+static void cond_av_list_destroy(struct cond_av_list *list)
+{
+	struct cond_av_list *cur, *next;
+	for (cur = list; cur != NULL; cur = next) {
+		next = cur->next;
+		/* the avtab_ptr_t node is destroy by the avtab */
+		kfree(cur);
+	}
+}
+
+static void cond_node_destroy(struct cond_node *node)
+{
+	struct cond_expr *cur_expr, *next_expr;
+
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = next_expr) {
+		next_expr = cur_expr->next;
+		kfree(cur_expr);
+	}
+	cond_av_list_destroy(node->true_list);
+	cond_av_list_destroy(node->false_list);
+	kfree(node);
+}
+
+static void cond_list_destroy(struct cond_node *list)
+{
+	struct cond_node *next, *cur;
+	
+	if (list == NULL)
+		return;
+
+	for (cur = list; cur != NULL; cur = next) {
+		next = cur->next;
+		cond_node_destroy(cur);
+	}
+}
+
+void cond_policydb_destroy(struct policydb *p)
+{
+	if (p->bool_val_to_struct != NULL)
+		kfree(p->bool_val_to_struct);
+	avtab_destroy(&p->te_cond_avtab);
+	cond_list_destroy(p->cond_list);
+}
+
+int cond_init_bool_indexes(struct policydb *p)
+{
+	if (p->bool_val_to_struct)
+		kfree(p->bool_val_to_struct);
+	p->bool_val_to_struct = (struct cond_bool_datum**)
+		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum*), GFP_KERNEL);
+	if (!p->bool_val_to_struct)
+		return -1;
+	return 0;
+}
+
+int cond_destroy_bool(void *key, void *datum, void *p)
+{
+	if (key)
+		kfree(key);
+	kfree(datum);
+	return 0;
+}
+
+int cond_index_bool(void *key, void *datum, void *datap)
+{
+	struct policydb *p;
+	struct cond_bool_datum *booldatum;
+
+	booldatum = datum;
+	p = datap;
+
+	if (!booldatum->value || booldatum->value > p->p_bools.nprim)
+		return -EINVAL;
+
+	p->p_bool_val_to_name[booldatum->value - 1] = key;
+	p->bool_val_to_struct[booldatum->value -1] = booldatum;
+
+	return 0;
+}
+
+int bool_isvalid(struct cond_bool_datum *b)
+{
+	if (!(b->state == 0 || b->state == 1))
+		return 0;
+	return 1;
+}
+
+int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
+{
+	char *key = 0;
+	struct cond_bool_datum *booldatum;
+	__u32 *buf, len;
+
+	booldatum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	if (!booldatum)
+		return -1;
+	memset(booldatum, 0, sizeof(struct cond_bool_datum));
+
+	buf = next_entry(fp, sizeof(__u32) * 3);
+	if (!buf)
+		goto err;
+
+	booldatum->value = le32_to_cpu(buf[0]);
+	booldatum->state = le32_to_cpu(buf[1]);
+	
+	if (!bool_isvalid(booldatum))
+		goto err;
+
+	len = le32_to_cpu(buf[2]);
+	
+	buf = next_entry(fp, len);
+	if (!buf)
+		goto err;
+	key = kmalloc(len + 1, GFP_KERNEL);
+	if (!key)
+		goto err;
+	memcpy(key, buf, len);
+	key[len] = 0;
+	if (hashtab_insert(h, key, booldatum))
+		goto err;
+	
+	return 0;
+err:
+	cond_destroy_bool(key, booldatum, 0);
+	return -1;
+}
+
+static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list,
+			     struct cond_av_list *other)
+{
+	struct cond_av_list *list, *last = NULL, *cur;
+	struct avtab_key key;
+	struct avtab_datum datum;
+	struct avtab_node *node_ptr;
+	int len, i;
+	__u32 *buf;
+	__u8 found;
+
+	*ret_list = NULL;
+
+	len = 0;
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+	if (len == 0) {
+		return 0;
+	}
+
+	for (i = 0; i < len; i++) {
+		if (avtab_read_item(fp, &datum, &key))
+			goto err;
+
+		/*
+		 * For type rules we have to make certain there aren't any
+		 * conflicting rules by searching the te_avtab and the
+		 * cond_te_avtab.
+		 */
+		if (datum.specified & AVTAB_TYPE) {
+			if (avtab_search(&p->te_avtab, &key, AVTAB_TYPE)) {
+				printk("security: type rule already exists outside of a conditional.");
+				goto err;
+			}
+			/*
+			 * If we are reading the false list other will be a pointer to
+			 * the true list. We can have duplicate entries if there is only
+			 * 1 other entry and it is in our true list.
+			 *
+			 * If we are reading the true list (other == NULL) there shouldn't
+			 * be any other entries.
+			 */
+			if (other) {
+				node_ptr = avtab_search_node(&p->te_cond_avtab, &key, AVTAB_TYPE);
+				if (node_ptr) {
+					if (avtab_search_node_next(node_ptr, AVTAB_TYPE)) {
+						printk("security: too many conflicting type rules.");
+						goto err;
+					}
+					found = 0;
+					for (cur = other; cur != NULL; cur = cur->next) {
+						if (cur->node == node_ptr) {
+							found = 1;
+							break;
+						}
+					}
+					if (!found) {
+						printk("security: conflicting type rules.");
+						goto err;
+					}
+				}
+			} else {    
+				if (avtab_search(&p->te_cond_avtab, &key, AVTAB_TYPE)) {
+					printk("security: conflicting type rules when adding type rule for true.");
+					goto err;
+				}
+			}
+		}
+		node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, &key, &datum);
+		if (!node_ptr) {
+			printk("security: could not insert rule.");
+			goto err;
+		}
+
+		list = kmalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+		if (!list)
+			goto err;
+		memset(list, 0, sizeof(struct cond_av_list));
+
+		list->node = node_ptr;
+		if (i == 0)
+			*ret_list = list;
+		else
+			last->next = list;
+		last = list;
+
+	}
+
+	return 0;
+err:
+	cond_av_list_destroy(*ret_list);
+	*ret_list = NULL;
+	return -1;
+}
+
+static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
+{
+	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
+		printk("security: conditional expressions uses unknown operator.\n");
+		return 0;
+	}
+	
+	if (expr->bool > p->p_bools.nprim) {
+		printk("security: conditional expressions uses unknown bool.\n");
+		return 0;
+	}
+	return 1;
+}
+
+static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
+{
+	__u32 *buf;
+	int len, i;
+	struct cond_expr *expr = NULL, *last = NULL;
+
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	node->cur_state = le32_to_cpu(buf[0]);
+	
+	len = 0;
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	/* expr */
+	len = le32_to_cpu(buf[0]);
+	
+	for (i = 0; i < len; i++ ) {
+		buf = next_entry(fp, sizeof(__u32) * 2);
+		if (!buf)
+			goto err;
+
+		expr = kmalloc(sizeof(struct cond_expr), GFP_KERNEL);
+		if (!expr) {
+			goto err;
+		}
+		memset(expr, 0, sizeof(struct cond_expr));
+
+		expr->expr_type = le32_to_cpu(buf[0]);
+		expr->bool = le32_to_cpu(buf[1]);
+		
+		if (!expr_isvalid(p, expr))
+			goto err;
+
+		if (i == 0) {
+			node->expr = expr;
+		} else {
+			last->next = expr;
+		}
+		last = expr;
+	}
+	
+	if (cond_read_av_list(p, fp, &node->true_list, NULL) != 0)
+		goto err;
+	if (cond_read_av_list(p, fp, &node->false_list, node->true_list) != 0)
+		goto err;
+	return 0;
+err:
+	cond_node_destroy(node);
+	return -1;
+}
+
+int cond_read_list(struct policydb *p, void *fp)
+{
+	struct cond_node *node, *last = NULL;
+	__u32 *buf;
+	int i, len;
+
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+
+	for (i = 0; i < len; i++) {
+		node = kmalloc(sizeof(struct cond_node), GFP_KERNEL);
+		if (!node)
+			goto err;
+		memset(node, 0, sizeof(struct cond_node));
+		
+		if (cond_read_node(p, node, fp) != 0)
+			goto err;
+
+		if (i == 0) {
+			p->cond_list = node;
+		} else {
+			last->next = node;
+		}
+		last = node;			
+	}
+	return 0;
+err:
+	cond_list_destroy(p->cond_list);
+	return -1;
+}
+
+/* Determine whether additional permissions are granted by the conditional
+ * av table, and if so, add them to the result 
+ */
+void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd)
+{
+	struct avtab_node *node;
+	
+	if(!ctab || !key || !avd) 
+		return;
+		
+	for(node = avtab_search_node(ctab, key, AVTAB_AV); node != NULL; 
+				node = avtab_search_node_next(node, AVTAB_AV)) {
+		if ( (__u32) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+			avd->allowed |= avtab_allowed(&node->datum);
+		if ( (__u32) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+			/* Since a '0' in an auditdeny mask represents a 
+			 * permission we do NOT want to audit (dontaudit), we use
+			 * the '&' operand to ensure that all '0's in the mask
+			 * are retained (much unlike the allow and auditallow cases).
+			 */
+			avd->auditdeny &= avtab_auditdeny(&node->datum);
+		if ( (__u32) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+			avd->auditallow |= avtab_auditallow(&node->datum);
+	}
+	return;	
+}
Index: linux-2.6/security/selinux/ss/conditional.h
diff -u /dev/null linux-2.6/security/selinux/ss/conditional.h:1.1
--- /dev/null	Thu Mar 11 11:24:31 2004
+++ linux-2.6/security/selinux/ss/conditional.h	Thu Feb  5 08:53:31 2004
@@ -0,0 +1,77 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Frank Mayer <mayerf@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#ifndef _CONDITIONAL_H_
+#define _CONDITIONAL_H_
+
+#include "avtab.h"
+#include "symtab.h"
+#include "policydb.h"
+
+#define COND_EXPR_MAXDEPTH 10
+
+/*
+ * A conditional expression is a list of operators and operands
+ * in reverse polish notation.
+ */
+struct cond_expr {
+#define COND_BOOL	1 /* plain bool */
+#define COND_NOT	2 /* !bool */
+#define COND_OR		3 /* bool || bool */
+#define COND_AND	4 /* bool && bool */
+#define COND_XOR	5 /* bool ^ bool */
+#define COND_EQ		6 /* bool == bool */
+#define COND_NEQ	7 /* bool != bool */
+#define COND_LAST	8
+	__u32 expr_type;
+	__u32 bool;
+	struct cond_expr *next;
+};
+
+/*
+ * Each cond_node contains a list of rules to be enabled/disabled
+ * depending on the current value of the conditional expression. This 
+ * struct is for that list.
+ */
+struct cond_av_list {
+	struct avtab_node *node;
+	struct cond_av_list *next;
+};
+
+/*
+ * A cond node represents a conditional block in a policy. It
+ * contains a conditional expression, the current state of the expression,
+ * two lists of rules to enable/disable depending on the value of the
+ * expression (the true list corresponds to if and the false list corresponds
+ * to else)..
+ */
+struct cond_node {
+	int cur_state;
+	struct cond_expr *expr;
+	struct cond_av_list *true_list;
+	struct cond_av_list *false_list;
+	struct cond_node *next;
+};
+
+int cond_policydb_init(struct policydb* p);
+void cond_policydb_destroy(struct policydb* p);
+
+int cond_init_bool_indexes(struct policydb* p);
+int cond_destroy_bool(void *key, void *datum, void *p);
+
+int cond_index_bool(void *key, void *datum, void *datap);
+
+int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
+int cond_read_list(struct policydb *p, void *fp);
+
+void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd);
+
+int evaluate_cond_node(struct policydb *p, struct cond_node *node);
+
+#endif /* _CONDITIONAL_H_ */
Index: linux-2.6/security/selinux/ss/mls.h
diff -u linux-2.6/security/selinux/ss/mls.h:1.1.1.1 linux-2.6/security/selinux/ss/mls.h:1.13
--- linux-2.6/security/selinux/ss/mls.h:1.1.1.1	Tue Aug 12 09:05:06 2003
+++ linux-2.6/security/selinux/ss/mls.h	Wed Mar  3 10:01:53 2004
@@ -48,12 +48,12 @@
 
 #define mls_end_user_ranges } }
 
-#define mls_symtab_names , "levels", "categories"
-#define mls_symtab_sizes , 16, 16
-#define mls_index_f ,sens_index, cat_index
-#define mls_destroy_f ,sens_destroy, cat_destroy
-#define mls_read_f ,sens_read, cat_read
-#define mls_write_f ,sens_write, cat_write
+#define mls_symtab_names  "levels", "categories",
+#define mls_symtab_sizes  16, 16,
+#define mls_index_f sens_index, cat_index,
+#define mls_destroy_f sens_destroy, cat_destroy,
+#define mls_read_f sens_read, cat_read,
+#define mls_write_f sens_write, cat_write,
 #define mls_policydb_index_others(p) printk(", %d levels", p->nlevels);
 
 #define mls_set_config(config) config |= POLICYDB_CONFIG_MLS
Index: linux-2.6/security/selinux/ss/policydb.c
diff -u linux-2.6/security/selinux/ss/policydb.c:1.1.1.6 linux-2.6/security/selinux/ss/policydb.c:1.29
--- linux-2.6/security/selinux/ss/policydb.c:1.1.1.6	Wed Feb 18 08:42:07 2004
+++ linux-2.6/security/selinux/ss/policydb.c	Wed Mar  3 10:01:53 2004
@@ -3,12 +3,25 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include "security.h"
+
 #include "policydb.h"
+#include "conditional.h"
 #include "mls.h"
 
 #define _DEBUG_HASHES
@@ -19,8 +32,9 @@
 	"classes",
 	"roles",
 	"types",
-	"users"
+	"users",
 	mls_symtab_names
+	"bools"
 };
 #endif
 
@@ -29,8 +43,9 @@
 	32,
 	16,
 	512,
-	128
+	128,
 	mls_symtab_sizes
+	16
 };
 
 /*
@@ -95,6 +110,10 @@
 	if (rc)
 		goto out_free_avtab;
 
+	rc = cond_policydb_init(p);
+	if (rc)
+		goto out_free_avtab;
+
 out:
 	return rc;
 
@@ -195,8 +214,9 @@
 	class_index,
 	role_index,
 	type_index,
-	user_index
+	user_index,
 	mls_index_f
+	cond_index_bool
 };
 
 /*
@@ -267,8 +287,8 @@
 {
 	int i, rc = 0;
 
-	printk(KERN_INFO "security:  %d users, %d roles, %d types",
-	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim);
+	printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
+	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
 	mls_policydb_index_others(p);
 	printk("\n");
 
@@ -296,6 +316,11 @@
 		goto out;
 	}
 
+	if (cond_init_bool_indexes(p)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] =
 			kmalloc(p->symtab[i].nprim * sizeof(char *), GFP_KERNEL);
@@ -402,8 +427,9 @@
 	class_destroy,
 	role_destroy,
 	type_destroy,
-	user_destroy
+	user_destroy,
 	mls_destroy_f
+	cond_destroy_bool
 };
 
 void ocontext_destroy(struct ocontext *c, int i)
@@ -467,6 +493,8 @@
 		kfree(gtmp);
 	}
 
+	cond_policydb_destroy(p);
+
 	return;
 }
 
@@ -1040,8 +1068,9 @@
 	class_read,
 	role_read,
 	type_read,
-	user_read
+	user_read,
 	mls_read_f
+	cond_read_bool
 };
 
 #define mls_config(x) \
@@ -1057,7 +1086,7 @@
 	struct role_trans *tr, *ltr;
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
-	int i, j, rc;
+	int i, j, rc, policy_ver, num_syms;
 	u32 *buf, len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 
@@ -1122,7 +1151,8 @@
 	for (i = 0; i < 4; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	if (buf[0] != POLICYDB_VERSION) {
+	policy_ver = buf[0];
+	if (policy_ver != POLICYDB_VERSION && policy_ver != POLICYDB_VERSION_COMPAT) {
 		printk(KERN_ERR "security:  policydb version %d does not match "
 		       "my version %d\n", buf[0], POLICYDB_VERSION);
 		goto bad;
@@ -1134,18 +1164,30 @@
 		       mls_config(config));
 		goto bad;
 	}
-	if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
-		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
-		       "not match mine (%d,%d)\n",
-		       buf[2], buf[3], SYM_NUM, OCON_NUM);
-		goto bad;
+
+	if (policy_ver == POLICYDB_VERSION_COMPAT) {
+		if (buf[2] != (SYM_NUM - 1) || buf[3] != OCON_NUM) {
+			printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
+			       "not match mine (%d,%d)\n",
+			       buf[2], buf[3], SYM_NUM, OCON_NUM);
+			goto bad;
+		}
+		num_syms = SYM_NUM - 1;
+	} else {
+		if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
+			printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
+			       "not match mine (%d,%d)\n",
+			       buf[2], buf[3], SYM_NUM, OCON_NUM);
+			goto bad;
+		}
+		num_syms = SYM_NUM;
 	}
 
 	rc = mls_read_nlevels(p, fp);
 	if (rc)
 		goto bad;
 
-	for (i = 0; i < SYM_NUM; i++) {
+	for (i = 0; i < num_syms; i++) {
 		buf = next_entry(fp, sizeof(u32)*2);
 		if (!buf) {
 			rc = -EINVAL;
@@ -1165,6 +1207,12 @@
 	rc = avtab_read(&p->te_avtab, fp, config);
 	if (rc)
 		goto bad;
+
+	if (policy_ver == POLICYDB_VERSION) {
+		rc = cond_read_list(p, fp);
+		if (rc)
+			goto bad;
+	}
 
 	buf = next_entry(fp, sizeof(u32));
 	if (!buf) {
Index: linux-2.6/security/selinux/ss/policydb.h
diff -u linux-2.6/security/selinux/ss/policydb.h:1.1.1.2 linux-2.6/security/selinux/ss/policydb.h:1.19
--- linux-2.6/security/selinux/ss/policydb.h:1.1.1.2	Mon Oct 20 09:27:37 2003
+++ linux-2.6/security/selinux/ss/policydb.h	Wed Feb  4 12:57:33 2004
@@ -4,6 +4,17 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #ifndef _SS_POLICYDB_H_
 #define _SS_POLICYDB_H_
 
@@ -100,6 +111,13 @@
 };
 #endif
 
+/* Boolean data type */
+struct cond_bool_datum {
+	__u32 value;		/* internal type value */
+	int state;
+};
+
+struct cond_node;
 
 /*
  * The configuration data includes security contexts for
@@ -145,9 +163,11 @@
 #ifdef CONFIG_SECURITY_SELINUX_MLS
 #define SYM_LEVELS  5
 #define SYM_CATS    6
-#define SYM_NUM     7
+#define SYM_BOOLS   7
+#define SYM_NUM     8
 #else
-#define SYM_NUM     5
+#define SYM_BOOLS   5
+#define SYM_NUM     6
 #endif
 
 /* object context array indices */
@@ -170,6 +190,7 @@
 #define p_users symtab[SYM_USERS]
 #define p_levels symtab[SYM_LEVELS]
 #define p_cats symtab[SYM_CATS]
+#define p_bools symtab[SYM_BOOLS]
 
 	/* symbol names indexed by (value - 1) */
 	char **sym_val_to_name[SYM_NUM];
@@ -180,6 +201,7 @@
 #define p_user_val_to_name sym_val_to_name[SYM_USERS]
 #define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]
 #define p_cat_val_to_name sym_val_to_name[SYM_CATS]
+#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	struct class_datum **class_val_to_struct;
@@ -191,6 +213,13 @@
 
 	/* role transitions */
 	struct role_trans *role_tr;
+
+	/* bools indexed by (value - 1) */
+	struct cond_bool_datum **bool_val_to_struct;
+	/* type enforcement conditional access vectors and transitions */
+	struct avtab te_cond_avtab;
+	/* linked list indexing te_cond_avtab by conditional */
+	struct cond_node* cond_list;
 
 	/* role allows */
 	struct role_allow *role_allow;
Index: linux-2.6/security/selinux/ss/services.c
diff -u linux-2.6/security/selinux/ss/services.c:1.1.1.5 linux-2.6/security/selinux/ss/services.c:1.34
--- linux-2.6/security/selinux/ss/services.c:1.1.1.5	Thu Mar 11 08:25:18 2004
+++ linux-2.6/security/selinux/ss/services.c	Wed Feb 18 09:26:06 2004
@@ -9,6 +9,15 @@
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
  *      as published by the Free Software Foundation.
+ *
+ * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -26,6 +35,7 @@
 #include "policydb.h"
 #include "sidtab.h"
 #include "services.h"
+#include "conditional.h"
 #include "mls.h"
 
 extern void selnl_notify_policyload(u32 seqno);
@@ -225,6 +235,9 @@
 			avd->auditallow = avtab_auditallow(avdatum);
 	}
 
+	/* Check conditional av table for additional permissions */
+	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+
 	/*
 	 * Remove any permissions prohibited by the MLS policy.
 	 */
@@ -573,6 +586,7 @@
 	struct role_trans *roletr = 0;
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
+	struct avtab_node *node;
 	unsigned int type_change = 0;
 	int rc = 0;
 
@@ -639,6 +653,18 @@
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_TYPE);
+
+	/* If no permanent rule, also check for enabled conditional rules */
+	if(!avdatum) {
+		node = avtab_search_node(&policydb.te_cond_avtab, &avkey, specified);
+		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
+			if (node->datum.specified & AVTAB_ENABLED) {
+				avdatum = &node->datum;
+				break;
+			}
+		}
+	}
+
 	type_change = (avdatum && (avdatum->specified & specified));
 	if (type_change) {
 		/* Use the type from the type transition/member/change rule. */
@@ -1000,6 +1026,7 @@
 			return -EINVAL;
 		}
 		ss_initialized = 1;
+
 		LOAD_UNLOCK;
 		selinux_complete_init();
 		return 0;
@@ -1046,6 +1073,7 @@
 	memcpy(&policydb, &newpolicydb, sizeof policydb);
 	sidtab_set(&sidtab, &newsidtab);
 	seqno = ++latest_granting;
+
 	POLICY_WRUNLOCK;
 	LOAD_UNLOCK;
 
@@ -1424,6 +1452,119 @@
 		}
 	}
 
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+}
+
+int security_get_bools(int *len, char ***names, int **values)
+{
+	int i, rc = -ENOMEM;
+
+	POLICY_RDLOCK;
+	*names = NULL;
+	*values = NULL;
+	
+	*len = policydb.p_bools.nprim;
+	if (!*len) {
+		rc = 0;
+		goto out;
+	}
+
+	*names = (char**)kmalloc(sizeof(char*) * *len, GFP_ATOMIC);
+	if (!*names)
+		goto err;
+	memset(*names, 0, sizeof(char*) * *len);
+
+	*values = (int*)kmalloc(sizeof(int) * *len, GFP_ATOMIC);
+	if (!*values)
+		goto err;
+
+	for (i = 0; i < *len; i++) {
+		size_t name_len;
+		(*values)[i] = policydb.bool_val_to_struct[i]->state;
+		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
+		(*names)[i] = (char*)kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
+		if (!(*names)[i])
+			goto err;
+		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
+		(*names)[i][name_len - 1] = 0;
+	}
+	rc = 0;
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+err:
+	if (*names) {
+		for (i = 0; i < *len; i++)
+			if ((*names)[i])
+				kfree((*names)[i]);
+	}
+	if (*values)
+		kfree(*values);
+	goto out;
+}
+
+
+int security_set_bools(int len, int *values)
+{
+	int i, rc = 0;
+	int lenp, seqno = 0;
+	struct cond_node *cur;
+
+	POLICY_WRLOCK;
+
+	lenp = policydb.p_bools.nprim;
+	if (len != lenp) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	printk(KERN_INFO "security: committed booleans { ");
+	for (i = 0; i < len; i++) {
+		if (values[i]) {
+			policydb.bool_val_to_struct[i]->state = 1;
+		} else {
+			policydb.bool_val_to_struct[i]->state = 0;
+		}
+		if (i != 0)
+			printk(", ");
+		printk("%s:%d", policydb.p_bool_val_to_name[i],
+		       policydb.bool_val_to_struct[i]->state);
+	}
+	printk(" }\n");
+
+	for (cur = policydb.cond_list; cur != NULL; cur = cur->next) {
+		rc = evaluate_cond_node(&policydb, cur);
+		if (rc)
+			goto out;
+	}
+
+	seqno = ++latest_granting;
+
+out:
+	POLICY_WRUNLOCK;
+	if (!rc) {
+		avc_ss_reset(seqno);
+		selnl_notify_policyload(seqno);
+	}
+	return rc;
+}
+
+int security_get_bool_value(int bool)
+{
+	int rc = 0;
+	int len;
+	
+	POLICY_RDLOCK;
+	
+	len = policydb.p_bools.nprim;
+	if (bool >= len) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = policydb.bool_val_to_struct[bool]->state;
 out:
 	POLICY_RDUNLOCK;
 	return rc;

 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

