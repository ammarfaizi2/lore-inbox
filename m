Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWAUIkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWAUIkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWAUIkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:40:19 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:24253 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751168AbWAUIkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:40:18 -0500
Date: Sat, 21 Jan 2006 09:40:17 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] vfs: add missing MNT_RDONLY and macro to check
Message-ID: <20060121084016.GB10044@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121083843.GA10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


;
; Bind Mount Extensions
;
; Copyright (C) 2003-2006 Herbert Pötzl <herbert@13thfloor.at>
;
; the missing MNT_RDONLY mount flag is added together with
; a macro MNT_IS_RDONLY(m) to check it on a vfsmount
;
; the separate flag to string structures in show_vfsmnt are
; combined and adjusted to honor the new flag, which is set
; at do_mount time
;
;
; Changelog:
;
;   0.01  - broken out part from bme0.05
;   0.02  - moved the loopback mounts into separate patch
;

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.16-rc1/fs/namespace.c linux-2.6.16-rc1-bme0.06.2-bm0.02/fs/namespace.c
--- linux-2.6.16-rc1/fs/namespace.c	2006-01-18 06:08:30 +0100
+++ linux-2.6.16-rc1-bme0.06.2-bm0.02/fs/namespace.c	2006-01-21 09:08:20 +0100
@@ -354,37 +354,40 @@ static int show_vfsmnt(struct seq_file *
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
-		{ 0, NULL }
-	};
-	static struct proc_fs_info mnt_info[] = {
-		{ MNT_NOSUID, ",nosuid" },
-		{ MNT_NODEV, ",nodev" },
-		{ MNT_NOEXEC, ",noexec" },
-		{ MNT_NOATIME, ",noatime" },
-		{ MNT_NODIRATIME, ",nodiratime" },
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
@@ -1285,6 +1288,8 @@ long do_mount(char *dev_name, char *dir_
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
diff -NurpP --minimal linux-2.6.16-rc1/include/linux/fs.h linux-2.6.16-rc1-bme0.06.2-bm0.02/include/linux/fs.h
--- linux-2.6.16-rc1/include/linux/fs.h	2006-01-18 06:08:43 +0100
+++ linux-2.6.16-rc1-bme0.06.2-bm0.02/include/linux/fs.h	2006-01-21 09:08:20 +0100
@@ -150,7 +150,7 @@ extern int dir_notify_enable;
  */
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
+#define IS_RDONLY(inode)	__IS_FLG(inode, MS_RDONLY)
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
 					((inode)->i_flags & S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
diff -NurpP --minimal linux-2.6.16-rc1/include/linux/mount.h linux-2.6.16-rc1-bme0.06.2-bm0.02/include/linux/mount.h
--- linux-2.6.16-rc1/include/linux/mount.h	2006-01-18 06:08:43 +0100
+++ linux-2.6.16-rc1-bme0.06.2-bm0.02/include/linux/mount.h	2006-01-21 09:08:20 +0100
@@ -22,6 +22,9 @@
 #define MNT_NOEXEC	0x04
 #define MNT_NOATIME	0x08
 #define MNT_NODIRATIME	0x10
+#define MNT_RDONLY	0x20
+
+#define MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
 
 #define MNT_SHARED	0x1000	/* if the vfsmount is a shared mount */
 #define MNT_UNBINDABLE	0x2000	/* if the vfsmount is a unbindable mount */

