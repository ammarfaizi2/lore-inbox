Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVBVML7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVBVML7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVBVML7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:11:59 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:54478 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262281AbVBVMKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:10:52 -0500
Date: Tue, 22 Feb 2005 13:10:49 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 1/6] Bind Mount Extensions 0.06
Message-ID: <20050222121049.GB3682@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



;
; Bind Mount Extensions
;
; This part adds support for the RDONLY, NOATIME and NODIRATIME
; vfsmount flags, propagates those options into loopback (bind)
; mounts and displays them properly in show_vfsmnt()/proc
;
; Copyright (C) 2003-2005 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:
;
;   0.01  - broken out part from bme0.05
;
; this patch is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; this patch is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;

diff -NurpP --minimal linux-2.6.11-rc4/fs/namespace.c linux-2.6.11-rc4-bme0.06-bm0.01/fs/namespace.c
--- linux-2.6.11-rc4/fs/namespace.c	2005-02-13 17:16:55 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01/fs/namespace.c	2005-02-19 06:31:24 +0100
@@ -220,37 +220,40 @@ static int show_vfsmnt(struct seq_file *
 	struct vfsmount *mnt = v;
 	int err = 0;
 	static struct proc_fs_info {
-		int flag;
-		char *str;
+		int s_flag;
+		int mnt_flag;
+		char *set_str;
+		char *unset_str;
 	} fs_info[] = {
-		{ MS_SYNCHRONOUS, ",sync" },
-		{ MS_DIRSYNC, ",dirsync" },
-		{ MS_MANDLOCK, ",mand" },
-		{ MS_NOATIME, ",noatime" },
-		{ MS_NODIRATIME, ",nodiratime" },
-		{ 0, NULL }
-	};
-	static struct proc_fs_info mnt_info[] = {
-		{ MNT_NOSUID, ",nosuid" },
-		{ MNT_NODEV, ",nodev" },
-		{ MNT_NOEXEC, ",noexec" },
-		{ 0, NULL }
+		{ MS_RDONLY, MNT_RDONLY, "ro", "rw" },
+		{ MS_SYNCHRONOUS, 0, ",sync", NULL },
+		{ MS_DIRSYNC, 0, ",dirsync", NULL },
+		{ MS_MANDLOCK, 0, ",mand", NULL },
+		{ MS_NOATIME, MNT_NOATIME, ",noatime", NULL },
+		{ MS_NODIRATIME, MNT_NODIRATIME, ",nodiratime", NULL },
+		{ 0, MNT_NOSUID, ",nosuid", NULL },
+		{ 0, MNT_NODEV, ",nodev", NULL },
+		{ 0, MNT_NOEXEC, ",noexec", NULL },
+		{ 0, 0, NULL, NULL }
 	};
-	struct proc_fs_info *fs_infop;
+	struct proc_fs_info *p;
+	unsigned long s_flags = mnt->mnt_sb->s_flags;
+	int mnt_flags = mnt->mnt_flags;
 
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_putc(m, ' ');
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
-	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_sb->s_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
-	}
-	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
+	seq_putc(m, ' ');
+	for (p = fs_info; (p->s_flag | p->mnt_flag) ; p++) {
+		if ((s_flags & p->s_flag) || (mnt_flags & p->mnt_flag)) {
+			if (p->set_str)
+				seq_puts(m, p->set_str);
+		} else {
+			if (p->unset_str)
+				seq_puts(m, p->unset_str);
+		}
 	}
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
@@ -618,11 +621,13 @@ out_unlock:
 /*
  * do loopback mount.
  */
-static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
+static int do_loopback(struct nameidata *nd, char *old_name, unsigned long flags, int mnt_flags)
 {
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
+	int recurse = flags & MS_REC;
 	int err = mount_is_safe(nd);
+
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
@@ -654,6 +659,7 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -1027,12 +1033,18 @@ long do_mount(char * dev_name, char * di
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
+	if (flags & MS_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
 
 	/* ... and get the mountpoint */
@@ -1048,7 +1060,7 @@ long do_mount(char * dev_name, char * di
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurpP --minimal linux-2.6.11-rc4/include/linux/fs.h linux-2.6.11-rc4-bme0.06-bm0.01/include/linux/fs.h
--- linux-2.6.11-rc4/include/linux/fs.h	2005-02-13 17:17:06 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01/include/linux/fs.h	2005-02-19 06:31:24 +0100
@@ -17,6 +17,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/kobject.h>
+#include <linux/mount.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -162,7 +163,7 @@ extern int dir_notify_enable;
  */
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
+#define IS_RDONLY(inode)	__IS_FLG(inode, MS_RDONLY)
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
 					((inode)->i_flags & S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
diff -NurpP --minimal linux-2.6.11-rc4/include/linux/mount.h linux-2.6.11-rc4-bme0.06-bm0.01/include/linux/mount.h
--- linux-2.6.11-rc4/include/linux/mount.h	2004-12-25 01:55:29 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01/include/linux/mount.h	2005-02-19 06:31:24 +0100
@@ -19,6 +19,9 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_RDONLY	8
+#define MNT_NOATIME	16
+#define MNT_NODIRATIME	32
 
 struct vfsmount
 {
@@ -38,6 +41,10 @@ struct vfsmount
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
+#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
+#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
+#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
