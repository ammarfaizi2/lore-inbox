Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWDCXAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWDCXAB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWDCXAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:00:01 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:44206 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964901AbWDCXAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:00:00 -0400
Message-ID: <4431A93A.2010702@plan99.net>
Date: Tue, 04 Apr 2006 00:01:14 +0100
From: Mike Hearn <mike@plan99.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] Add a /proc/self/exedir link
Content-Type: multipart/mixed;
 boundary="------------010800020501080009000802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010800020501080009000802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alright, Andrew Morton indicated that he liked this patch but the idea 
needed discussion and mindshare. I asked Con Kolivas if it made sense to 
go in his desktop patchset for people to try: he said he liked it too 
but it's not his area, and that it should be discussed here.

To clarify, I'm proposing this patch for eventual mainline inclusion.

It adds a simple bit of API - a symlink in /proc/pid - which makes it 
easy to build relocatable software:

   ./configure --prefix=/proc/self/exedir/..

This is useful for a variety of purposes:

* Distributing programs that are runnable from CD or USB key (useful for
   Linux magazine cover disks)

* Binary packages that can be installed anywhere, for instance, to your
   home directory

* Network admins can more easily place programs on network mounts

I'm sure you can think of others. You can patch software to be 
relocatable today, but it's awkward and error prone. A simple patch can 
allow us to get it "for free" on any UNIX software that uses the 
idiomatic autotools build system.

So .... does anybody have any objections to this? Would you like to see 
it go in? Speak now or forever hold your peace! :)

thanks -mike

--------------010800020501080009000802
Content-Type: text/x-patch;
 name="exedir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="exedir.patch"

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

--------------010800020501080009000802--
