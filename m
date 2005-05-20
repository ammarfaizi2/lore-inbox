Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVETOFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVETOFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVETN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:59:34 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:13583 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261435AbVETNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:55:36 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH] namespace.c: cleanup in mark_mounts_for_expiry()
Message-Id: <E1DZ7xj-0003ol-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 15:54:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ fell in love with that function, now can't let go... ]

This patch simplifies mark_mounts_for_expiry() by using detach_mnt()
instead of duplicating everything it does.

It should be an equivalent transformation except for righting the
dput/mntput order.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-20 15:44:59.000000000 +0200
+++ linux/fs/namespace.c	2005-05-20 15:45:21.000000000 +0200
@@ -880,24 +880,13 @@ void mark_mounts_for_expiry(struct list_
 		/* check that it is still dead: the count should now be 2 - as
 		 * contributed by the vfsmount parent and the mntget above */
 		if (atomic_read(&mnt->mnt_count) == 2) {
-			struct vfsmount *xdmnt;
-			struct dentry *xdentry;
+			struct nameidata old_nd;
 
 			/* delete from the namespace */
 			list_del_init(&mnt->mnt_list);
-			list_del_init(&mnt->mnt_child);
-			list_del_init(&mnt->mnt_hash);
-			mnt->mnt_mountpoint->d_mounted--;
-
-			xdentry = mnt->mnt_mountpoint;
-			mnt->mnt_mountpoint = mnt->mnt_root;
-			xdmnt = mnt->mnt_parent;
-			mnt->mnt_parent = mnt;
-
+			detach_mnt(mnt, &old_nd);
 			spin_unlock(&vfsmount_lock);
-
-			mntput(xdmnt);
-			dput(xdentry);
+			path_release(&old_nd);
 
 			/* now lay it to rest if this was the last ref on the
 			 * superblock */
