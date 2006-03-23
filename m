Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWCWMQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWCWMQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCWMQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:16:58 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:3199 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751390AbWCWMQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:16:57 -0500
Subject: [PATCH] Implement /proc/pid/exedir
From: Mike Hearn <mike@plan99.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 23 Mar 2006 12:17:07 +0000
Message-Id: <1143116227.3616.2.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does exactly what it says on the tin.

Briefly, this is useful for making relocatable software, that is,
software which can be run from any prefix. It's more convenient for
applications because you can just do

   open_the_file("/proc/self/exedir/../share/my-program/datafile")

and there's no error-prone string handling. You can also do

   ./configure --prefix=/proc/self/exedir/../

to make most UNIX programs relocatable. That was tested on Gaim 2 and
works fine. It's handy if you want to run software off USB keys, network
mounts, install to your home directory etc.

This is my first kernel patch, please be gentle ;)

Signed-off-by: Mike Hearn <mike@plan99.net>



--- fs/proc/base.c~	2006-03-22 21:39:04.000000000 +0000
+++ fs/proc/base.c	2006-03-22 09:42:28.000000000 +0000
@@ -95,6 +95,7 @@
 	PROC_TGID_CWD,
 	PROC_TGID_ROOT,
 	PROC_TGID_EXE,
+	PROC_TGID_EXEDIR,
 	PROC_TGID_FD,
 	PROC_TGID_ENVIRON,
 	PROC_TGID_AUXV,
@@ -135,6 +136,7 @@
 	PROC_TID_CWD,
 	PROC_TID_ROOT,
 	PROC_TID_EXE,
+	PROC_TID_EXEDIR,
 	PROC_TID_FD,
 	PROC_TID_ENVIRON,
 	PROC_TID_AUXV,
@@ -200,6 +202,7 @@
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
+	E(PROC_TGID_EXEDIR,    "exedir",  S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
 	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
@@ -242,6 +245,7 @@
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
+	E(PROC_TID_EXEDIR,     "exedir",  S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
 	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
@@ -1656,6 +1660,11 @@
 			inode->i_op = &proc_pid_link_inode_operations;
 			ei->op.proc_get_link = proc_exe_link;
 			break;
+		case PROC_TID_EXEDIR:
+		case PROC_TGID_EXEDIR:
+			inode->i_op = &proc_pid_link_inode_operations;
+			ei->op.proc_get_link = proc_exedir_link;
+			break;
 		case PROC_TID_CWD:
 		case PROC_TGID_CWD:
 			inode->i_op = &proc_pid_link_inode_operations;
--- fs/proc/internal.h~	2006-03-13 23:40:39.000000000 +0000
+++ fs/proc/internal.h	2006-03-22 09:46:08.000000000 +0000
@@ -32,6 +32,7 @@
 
 extern void create_seq_entry(char *name, mode_t mode, struct file_operations *f);
 extern int proc_exe_link(struct inode *, struct dentry **, struct vfsmount **);
+extern int proc_exedir_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt);
 extern int proc_tid_stat(struct task_struct *,  char *);
 extern int proc_tgid_stat(struct task_struct *, char *);
 extern int proc_pid_status(struct task_struct *, char *);
--- fs/proc/task_mmu.c~	2006-03-22 21:43:37.000000000 +0000
+++ fs/proc/task_mmu.c	2006-03-22 10:26:37.000000000 +0000
@@ -101,6 +101,20 @@
 	return result;
 }
 
+int proc_exedir_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	struct dentry *exe;
+	int result = proc_exe_link(inode, &exe, mnt);
+
+	if (result < 0)
+		return result;
+
+	*dentry = dget_parent(exe);
+	dput(exe);
+
+	return result;
+}
+
 static void pad_len_spaces(struct seq_file *m, int len)
 {
 	len = 25 + sizeof(void*) * 6 - len;
--- fs/proc/task_nommu.c~	2006-03-22 21:45:24.000000000 +0000
+++ fs/proc/task_nommu.c	2006-03-22 10:20:26.000000000 +0000
@@ -137,6 +137,20 @@
 	return result;
 }
 
+int proc_exedir_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	struct dentry *exe;
+	int result = proc_exe_link(inode, &exe, mnt);
+	
+	if (result < 0)
+		return result;
+
+	*dentry = dget_parent(exe);
+	dput(exe);
+
+       return result;
+}
+
 /*
  * Albert D. Cahalan suggested to fake entries for the traditional
  * sections here.  This might be worth investigating.


