Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVE3Kj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVE3Kj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVE3KjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:39:24 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:1799 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261342AbVE3Khi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:37:38 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] namespace: rename mnt_fslink to mnt_expire
Message-Id: <E1Dche5-0000FS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 May 2005 12:37:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames vfsmount->mnt_fslink to something a little more
descriptive: vfsmount->mnt_expire.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/mount.h
===================================================================
--- linux.orig/include/linux/mount.h	2005-05-29 13:32:28.000000000 +0200
+++ linux/include/linux/mount.h	2005-05-29 13:35:12.000000000 +0200
@@ -34,7 +34,7 @@ struct vfsmount
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
-	struct list_head mnt_fslink;	/* link in fs-specific expiry list */
+	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-29 13:32:28.000000000 +0200
+++ linux/fs/namespace.c	2005-05-29 13:36:14.000000000 +0200
@@ -61,7 +61,7 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
-		INIT_LIST_HEAD(&mnt->mnt_fslink);
+		INIT_LIST_HEAD(&mnt->mnt_expire);
 		if (name) {
 			int size = strlen(name)+1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -165,8 +165,8 @@ clone_mnt(struct vfsmount *old, struct d
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */
 		spin_lock(&vfsmount_lock);
-		if (!list_empty(&old->mnt_fslink))
-			list_add(&mnt->mnt_fslink, &old->mnt_fslink);
+		if (!list_empty(&old->mnt_expire))
+			list_add(&mnt->mnt_expire, &old->mnt_expire);
 		spin_unlock(&vfsmount_lock);
 	}
 	return mnt;
@@ -351,7 +351,7 @@ static void umount_tree(struct vfsmount 
 	while (!list_empty(&kill)) {
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
-		list_del_init(&mnt->mnt_fslink);
+		list_del_init(&mnt->mnt_expire);
 		if (mnt->mnt_parent == mnt) {
 			spin_unlock(&vfsmount_lock);
 		} else {
@@ -645,7 +645,7 @@ static int do_loopback(struct nameidata 
 	if (mnt) {
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
-		list_del_init(&mnt->mnt_fslink);
+		list_del_init(&mnt->mnt_expire);
 		spin_unlock(&vfsmount_lock);
 
 		err = graft_tree(mnt, nd);
@@ -744,7 +744,7 @@ static int do_move_mount(struct nameidat
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
-	list_del_init(&old_nd.mnt->mnt_fslink);
+	list_del_init(&old_nd.mnt->mnt_expire);
 out2:
 	spin_unlock(&vfsmount_lock);
 out1:
@@ -814,7 +814,7 @@ int do_add_mount(struct vfsmount *newmnt
 	if (err == 0 && fslist) {
 		/* add to the specified expiration list */
 		spin_lock(&vfsmount_lock);
-		list_add_tail(&newmnt->mnt_fslink, fslist);
+		list_add_tail(&newmnt->mnt_expire, fslist);
 		spin_unlock(&vfsmount_lock);
 	}
 
@@ -863,7 +863,7 @@ static void expire_mount(struct vfsmount
 	} else {
 		/* someone brought it back to life whilst we didn't have any
 		 * locks held so return it to the expiration list */
-		list_add_tail(&mnt->mnt_fslink, mounts);
+		list_add_tail(&mnt->mnt_expire, mounts);
 		spin_unlock(&vfsmount_lock);
 	}
 }
@@ -890,13 +890,13 @@ void mark_mounts_for_expiry(struct list_
 	 * - still marked for expiry (marked on the last call here; marks are
 	 *   cleared by mntput())
 	 */
-	list_for_each_entry_safe(mnt, next, mounts, mnt_fslink) {
+	list_for_each_entry_safe(mnt, next, mounts, mnt_expire) {
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 		    atomic_read(&mnt->mnt_count) != 1)
 			continue;
 
 		mntget(mnt);
-		list_move(&mnt->mnt_fslink, &graveyard);
+		list_move(&mnt->mnt_expire, &graveyard);
 	}
 
 	/*
@@ -906,8 +906,8 @@ void mark_mounts_for_expiry(struct list_
 	 * - dispose of the corpse
 	 */
 	while (!list_empty(&graveyard)) {
-		mnt = list_entry(graveyard.next, struct vfsmount, mnt_fslink);
-		list_del_init(&mnt->mnt_fslink);
+		mnt = list_entry(graveyard.next, struct vfsmount, mnt_expire);
+		list_del_init(&mnt->mnt_expire);
 
 		/* don't do anything if the namespace is dead - all the
 		 * vfsmounts from it are going away anyway */
