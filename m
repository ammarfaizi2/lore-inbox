Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbUJYOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUJYOsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUJYOr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:47:28 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:39848 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261833AbUJYOjx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:39:53 -0400
Cc: raven@themaw.net
Subject: [PATCH 2/28] VFS: mnt_fslink -> mnt_expire
In-Reply-To: <10987151403173@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:39:30 -0400
Message-Id: <10987151702831@sun.com>
References: <10987151403173@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames vfsmount->mnt_fslink to something a little more
descriptive: vfsmount->mnt_expire.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c        |   24 ++++++++++++------------
 include/linux/mount.h |    2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.9-quilt/include/linux/mount.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/mount.h	2004-08-14 01:36:14.000000000 -0400
+++ linux-2.6.9-quilt/include/linux/mount.h	2004-10-22 17:17:33.460377392 -0400
@@ -32,7 +32,7 @@ struct vfsmount
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
-	struct list_head mnt_fslink;	/* link in fs-specific expiry list */
+	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:32.921459320 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:33.461377240 -0400
@@ -60,7 +60,7 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
-		INIT_LIST_HEAD(&mnt->mnt_fslink);
+		INIT_LIST_HEAD(&mnt->mnt_expire);
 		if (name) {
 			int size = strlen(name)+1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -166,8 +166,8 @@ clone_mnt(struct vfsmount *old, struct d
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
@@ -644,7 +644,7 @@ static int do_loopback(struct nameidata 
 	if (mnt) {
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
-		list_del_init(&mnt->mnt_fslink);
+		list_del_init(&mnt->mnt_expire);
 		spin_unlock(&vfsmount_lock);
 
 		err = graft_tree(mnt, nd);
@@ -743,7 +743,7 @@ static int do_move_mount(struct nameidat
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
-	list_del_init(&old_nd.mnt->mnt_fslink);
+	list_del_init(&old_nd.mnt->mnt_expire);
 out2:
 	spin_unlock(&vfsmount_lock);
 out1:
@@ -812,7 +812,7 @@ int do_add_mount(struct vfsmount *newmnt
 	if (err == 0 && fslist) {
 		/* add to the specified expiration list */
 		spin_lock(&vfsmount_lock);
-		list_add_tail(&newmnt->mnt_fslink, fslist);
+		list_add_tail(&newmnt->mnt_expire, fslist);
 		spin_unlock(&vfsmount_lock);
 	}
 
@@ -846,13 +846,13 @@ void mark_mounts_for_expiry(struct list_
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
@@ -862,8 +862,8 @@ void mark_mounts_for_expiry(struct list_
 	 * - dispose of the corpse
 	 */
 	while (!list_empty(&graveyard)) {
-		mnt = list_entry(graveyard.next, struct vfsmount, mnt_fslink);
-		list_del_init(&mnt->mnt_fslink);
+		mnt = list_entry(graveyard.next, struct vfsmount, mnt_expire);
+		list_del_init(&mnt->mnt_expire);
 
 		/* don't do anything if the namespace is dead - all the
 		 * vfsmounts from it are going away anyway */
@@ -913,7 +913,7 @@ void mark_mounts_for_expiry(struct list_
 			/* someone brought it back to life whilst we didn't
 			 * have any locks held so return it to the expiration
 			 * list */
-			list_add_tail(&mnt->mnt_fslink, mounts);
+			list_add_tail(&mnt->mnt_expire, mounts);
 			spin_unlock(&vfsmount_lock);
 		}
 

