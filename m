Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVEYMMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVEYMMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVEYMMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:12:36 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:14097 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261412AbVEYMMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:12:30 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] set mnt_namespace in the correct place
Message-Id: <E1Daujs-0005X1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 May 2005 14:11:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets ->mnt_namespace where it's actually added to the
namespace.

Previously mnt_namespace was set in do_kern_mount() even if the
filesystem was never added to any process's namespace (most
kernel-internal filesystems).

This discrepancy doesn't actually cause any problems, but it's cleaner
if mnt_namespace is NULL for these non exported filesystems.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/super.c
===================================================================
--- linux.orig/fs/super.c	2005-05-23 11:12:17.000000000 +0200
+++ linux/fs/super.c	2005-05-25 13:56:33.000000000 +0200
@@ -842,7 +842,6 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
-	mnt->mnt_namespace = current->namespace;
 	up_write(&sb->s_umount);
 	put_filesystem(type);
 	return mnt;
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-25 12:40:31.000000000 +0200
+++ linux/fs/namespace.c	2005-05-25 13:59:04.000000000 +0200
@@ -808,6 +808,7 @@ int do_add_mount(struct vfsmount *newmnt
 		goto unlock;
 
 	newmnt->mnt_flags = mnt_flags;
+	newmnt->mnt_namespace = current->namespace;
 	err = graft_tree(newmnt, nd);
 
 	if (err == 0 && fslist) {
