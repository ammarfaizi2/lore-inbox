Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUDNLoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbUDNLoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:44:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9541 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264061AbUDNLoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:44:01 -0400
Date: Wed, 14 Apr 2004 12:43:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ian Kent <raven@themaw.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] umount after bad chdir
Message-ID: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After chdir (or chroot) to non-existent directory on 2.6.5-mm5, you
can no longer unmount filesystem holding working directory (or root).

--- 2.6.5-mm5/fs/open.c	2004-04-13 11:02:25.000000000 +0100
+++ linux/fs/open.c	2004-04-14 12:23:26.633056368 +0100
@@ -517,13 +517,16 @@ asmlinkage long sys_chdir(const char __u
 {
 	struct nameidata nd;
 	int error;
-	struct vfsmount *old_mnt = mntget(current->fs->pwdmnt);
-	struct dentry *old_dentry = dget(current->fs->pwd);
+	struct vfsmount *old_mnt;
+	struct dentry *old_dentry;
 
 	error = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
 	if (error)
 		goto out;
 
+	old_mnt = mntget(current->fs->pwdmnt);
+	old_dentry = dget(current->fs->pwd);
+
 	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd);
 	if (error)
 		goto dput_and_out;
@@ -590,13 +593,16 @@ asmlinkage long sys_chroot(const char __
 {
 	struct nameidata nd;
 	int error;
-	struct vfsmount *old_mnt = mntget(current->fs->rootmnt);
-	struct dentry *old_dentry = dget(current->fs->root);
+	struct vfsmount *old_mnt;
+	struct dentry *old_dentry;
 
 	error = __user_walk(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
 	if (error)
 		goto out;
 
+	old_mnt = mntget(current->fs->pwdmnt);
+	old_dentry = dget(current->fs->pwd);
+
 	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd);
 	if (error)
 		goto dput_and_out;

