Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUCOH46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 02:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUCOH4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 02:56:48 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:62670 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262132AbUCOH4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:56:37 -0500
Date: Mon, 15 Mar 2004 08:56:36 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04.1 1/5
Message-ID: <20040315075636.GC31818@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040314203427.27857fd9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


;
; Bind Mount Extensions 
;
; this patch adds some functionality to the --bind
; type of vfs mounts.
;
; (C) 2003-2004 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:  
;
;   0.01  - readonly bind mounts
;   0.02  - added ro truncate handling
;         - added ro (f)chown, (f)chmod handling
;   0.03  - added ro utime(s) handling
;         - added ro access and *_ioctl
;   0.04  - added noatime and nodiratime
;         - made autofs4 update_atime uncond
;
;   0.04.1  IS_RDONLY extended by vfsmnt
;         - IS_RDONLY_INODE() added for legacy
;         - update_atime() updated (20040314_2308)
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

diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/namespace.c linux-2.6.4-20040314_2308-bme0.04.1/fs/namespace.c
--- linux-2.6.4-20040314_2308/fs/namespace.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/namespace.c	2004-03-15 07:51:27.000000000 +0100
@@ -229,7 +229,8 @@ static int show_vfsmnt(struct seq_file *
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_puts(m, (MNT_IS_RDONLY(mnt) ||
+		(mnt->mnt_sb->s_flags & MS_RDONLY)) ? " ro" : " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -522,11 +523,13 @@ out_unlock:
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
@@ -553,6 +556,7 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -759,12 +763,18 @@ long do_mount(char * dev_name, char * di
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
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
@@ -780,7 +790,7 @@ long do_mount(char * dev_name, char * di
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurpP --minimal linux-2.6.4-20040314_2308/include/linux/mount.h linux-2.6.4-20040314_2308-bme0.04.1/include/linux/mount.h
--- linux-2.6.4-20040314_2308/include/linux/mount.h	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/include/linux/mount.h	2004-03-15 05:58:04.000000000 +0100
@@ -14,9 +14,12 @@
 
 #include <linux/list.h>
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_RDONLY	1
+#define MNT_NOSUID	2
+#define MNT_NODEV	4
+#define MNT_NOEXEC	8
+#define MNT_NOATIME	1024
+#define MNT_NODIRATIME	2048
 
 struct vfsmount
 {
@@ -33,6 +36,11 @@ struct vfsmount
 	struct list_head mnt_list;
 };
 
+				    	/* remove (m) when done */
+#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
+#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
+#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
