Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVEPTyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVEPTyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVEPTxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:53:51 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:52233 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261836AbVEPTv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:51:57 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-Id: <E1DXlcQ-0005h6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 May 2005 21:51:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending this patch, because I still believe it's the correct fix.

Tested before/after applying the patch with a test application
available from:

  http://www.inf.bme.hu/~mszeredi/nstest.c

Bind mount from a foreign namespace results in an un-removable mount.
The reason is that mnt->mnt_namespace is copied from the old mount in
clone_mnt().  Because of this check_mnt() in sys_umount() will fail.

The solution is to set mnt->mnt_namespace to current->namespace in
clone_mnt().  clone_mnt() is either called from do_loopback() or
copy_tree().  copy_tree() is called from do_loopback() or
copy_namespace().

When called (directly or indirectly) from do_loopback(), always
current->namspace is being modified: check_mnt(nd->mnt).  So setting
mnt->mnt_namespace to current->namspace is the right thing to do.

When called from copy_namespace(), the setting of mnt_namespace is
irrelevant, since mnt_namespace is reset later in that function for
all copied mounts.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-13 12:22:52.000000000 +0200
+++ linux/fs/namespace.c	2005-05-13 12:32:36.000000000 +0200
@@ -160,7 +160,7 @@ clone_mnt(struct vfsmount *old, struct d
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
-		mnt->mnt_namespace = old->mnt_namespace;
+		mnt->mnt_namespace = current->namespace;
 
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */


