Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVEYL1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVEYL1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVEYL1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:27:43 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:27920 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262122AbVEYL1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:27:38 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] namespace.c: fix mnt_namespace zeroing for expired mounts
Message-Id: <E1Dau2O-0005U1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 May 2005 13:27:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clears mnt_namespace in an expired mount. 

If mnt_namespace is not cleared, it's possible to attach a new mount
to the already detached mount, because check_mnt() can return true.

The effect is a resource leak, since the resulting tree will never be
freed.

An earlier patch doing the same for regular umount has already been
applied (namespacec-fix-mnt_namespace-clearing.patch).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-22 11:52:56.000000000 +0200
+++ linux/fs/namespace.c	2005-05-22 11:52:59.000000000 +0200
@@ -843,6 +843,7 @@ static void expire_mount(struct vfsmount
 
 		/* delete from the namespace */
 		list_del_init(&mnt->mnt_list);
+		mnt->mnt_namespace = NULL;
 		detach_mnt(mnt, &old_nd);
 		spin_unlock(&vfsmount_lock);
 		path_release(&old_nd);

