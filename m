Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVCTKRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVCTKRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVCTKPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:15:55 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:36527 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262107AbVCTKOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:14:44 -0500
Subject: [PATCH][3/5] New member for proc_inode: ctl_name
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Date: Sun, 20 Mar 2005 11:14:43 +0100
Message-Id: <1111313683.3a45D.17773@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new field to struct proc_inode and struct pid_entry: ctl_name.  It
will be used to hold the ctl_name value of the sysctl that is responsible
for the respective inode or pid_entry.  Also initialize this value for
our example sysctl (proc.cmdline).

diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-03-19 19:59:00.000000000 +0100
+++ l2/fs/proc/base.c	2005-03-19 19:59:43.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
+#include <linux/sysctl.h>
 #include "internal.h"
 
 /*
@@ -130,9 +131,18 @@ struct pid_entry {
 	int len;
 	char *name;
 	mode_t mode;
+#ifdef CONFIG_SYSCTL
+	int ctl_name;
+#endif
 };
 
-#define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
+#ifdef CONFIG_SYSCTL
+#define E(type, name, mode)		{(type), sizeof(name)-1, (name), (mode), 0}
+#define S(type, name, mode, ctl_name)	{(type), sizeof(name)-1, (name), (mode), (ctl_name)}
+#else
+#define E(type, name, mode)		{(type), sizeof(name)-1, (name), (mode)}
+#define S(type, name, mode, ctl_name)	{(type), sizeof(name)-1, (name), (mode)}
+#endif	/* CONFIG_SYSCTL */
 
 static struct pid_entry tgid_base_stuff[] = {
 	E(PROC_TGID_TASK,      "task",    S_IFDIR|S_IRUGO|S_IXUGO),
@@ -140,7 +150,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ENVIRON,   "environ", S_IFREG|S_IRUSR),
 	E(PROC_TGID_AUXV,      "auxv",	  S_IFREG|S_IRUSR),
 	E(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO),
-	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
+	S(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO, PROC_CMDLINE),
 	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
 	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
@@ -176,7 +186,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_ENVIRON,    "environ", S_IFREG|S_IRUSR),
 	E(PROC_TID_AUXV,       "auxv",	  S_IFREG|S_IRUSR),
 	E(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO),
-	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
+	S(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO, PROC_CMDLINE),
 	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
 	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
@@ -226,6 +236,7 @@ static struct pid_entry tid_attr_stuff[]
 #endif
 
 #undef E
+#undef S
 
 #ifdef CONFIG_SYSCTL
 /* Order and number of elements must match CTL_PROC table in sysctl.h! */
@@ -1150,6 +1161,9 @@ static struct inode *proc_pid_make_inode
 	get_task_struct(task);
 	ei->task = task;
 	ei->type = ino;
+#ifdef CONFIG_SYSCTL
+	ei->ctl_name = 0;
+#endif
 	inode->i_uid = 0;
 	inode->i_gid = 0;
 	if (ino == PROC_TGID_INO || ino == PROC_TID_INO || task_dumpable(task)) {
@@ -1458,6 +1472,9 @@ static struct dentry *proc_pident_lookup
 		goto out;
 
 	ei = PROC_I(inode);
+#ifdef CONFIG_SYSCTL
+	ei->ctl_name = p->ctl_name;
+#endif
 	inode->i_mode = p->mode;
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
diff -pur l1/fs/proc/internal.h l2/fs/proc/internal.h
--- l1/fs/proc/internal.h	2005-02-12 09:26:31.000000000 +0100
+++ l2/fs/proc/internal.h	2005-03-19 19:55:44.000000000 +0100
@@ -46,3 +46,8 @@ static inline int proc_type(struct inode
 {
 	return PROC_I(inode)->type;
 }
+
+static inline int proc_ctl_name(struct inode *inode)
+{
+	return PROC_I(inode)->ctl_name;
+}
diff -pur l1/include/linux/proc_fs.h l2/include/linux/proc_fs.h
--- l1/include/linux/proc_fs.h	2005-02-12 09:26:36.000000000 +0100
+++ l2/include/linux/proc_fs.h	2005-03-19 19:55:44.000000000 +0100
@@ -238,6 +238,7 @@ extern void kclist_add(struct kcore_list
 struct proc_inode {
 	struct task_struct *task;
 	int type;
+	int ctl_name;
 	union {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
 		int (*proc_read)(struct task_struct *task, char *page);

