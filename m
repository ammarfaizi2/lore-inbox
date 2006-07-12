Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWGLSUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWGLSUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGLSRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59552 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932387AbWGLSRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:33 -0400
Subject: [RFC][PATCH 26/27] Originally from: Herbert Poetzl <herbert@13thfloor.at>
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:28 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181728.E70D613A@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c |   45 ++++++++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 21 deletions(-)

diff -puN fs/namespace.c~D6-proc-show-ro-attr fs/namespace.c
--- lxc/fs/namespace.c~D6-proc-show-ro-attr	2006-07-12 11:09:32.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-07-12 11:09:44.000000000 -0700
@@ -374,24 +374,22 @@ static int show_vfsmnt(struct seq_file *
 {
 	struct vfsmount *mnt = v;
 	int err = 0;
+	int i;
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
+		{ MS_SYNCHRONOUS, 0, ",sync", NULL },
+		{ MS_DIRSYNC, 0, ",dirsync", NULL },
+		{ MS_MANDLOCK, 0, ",mand", NULL },
+		{ 0, MNT_NOSUID, ",nosuid", NULL },
+		{ 0, MNT_NODEV, ",nodev", NULL },
+		{ 0, MNT_NOEXEC, ",noexec", NULL },
+		{ 0, MNT_NOATIME, ",noatime", NULL },
+		{ 0, MNT_NODIRATIME, ",nodiratime", NULL }
 	};
-	struct proc_fs_info *fs_infop;
 
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_putc(m, ' ');
@@ -399,13 +397,18 @@ static int show_vfsmnt(struct seq_file *
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
 	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
-	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_sb->s_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
-	}
-	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
+	for (i = 0; i < ARRAY_SIZE(fs_info); i++) {
+		struct proc_fs_info *fs_infop = &fs_info[i];
+		char *str = NULL;
+		if ((mnt->mnt_sb->s_flags & fs_infop->s_flag) ||
+		    mnt_flag_set(mnt, fs_infop->mnt_flag))
+			str = fs_infop->set_str;
+		else
+			str = fs_infop->unset_str;
+
 		if (mnt->mnt_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
+		if (str)
+			seq_puts(m, str);
 	}
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
_
