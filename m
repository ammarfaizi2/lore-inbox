Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbUJYOxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUJYOxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUJYOxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:53:51 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:48552 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261844AbUJYOmo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:42:44 -0400
Cc: raven@themaw.net
Subject: [PATCH 8/28] VFS: Remove MNT_EXPIRE support
In-Reply-To: <10987153211852@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:42:32 -0400
Message-Id: <10987153522992@sun.com>
References: <10987153211852@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop support for MNT_EXPIRE (flag to umount(2)).  Nobody was using it and it
didn't fit into the new expiry framework.

Note: maybe make this bit a DO NOT USE bit?

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c     |   45 +++++++++------------------------------------
 include/linux/fs.h |    1 -
 2 files changed, 9 insertions(+), 37 deletions(-)

Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-08-14 01:36:32.000000000 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:37.120820920 -0400
@@ -719,7 +719,6 @@ extern int send_sigurg(struct fown_struc
 
 #define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
-#define MNT_EXPIRE	0x00000004	/* Mark for expiry */
 
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:35.929002104 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:37.121820768 -0400
@@ -157,11 +157,12 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static int __can_expire(struct vfsmount *root, int offset)
+/* this expects the caller to hold vfsmount_lock */
+static int can_expire(struct vfsmount *root, int offset)
 {
 	struct vfsmount *mnt;
 	int count;
-	
+
 	/* handle the case of a root or orphaned mountpoint */
 	if (root->mnt_parent == root || root->mnt_parent == NULL)
 		return 0;
@@ -171,18 +172,9 @@ static int __can_expire(struct vfsmount 
 			return 0;
 		count += atomic_read(&mnt->mnt_count) - 2;
 	}
-	
-	WARN_ON(count < 0);
-	return count == 0;	
-}
 
-static int can_expire(struct vfsmount *root)
-{
-	int ret;
-	spin_lock(&vfsmount_lock);
-	ret = __can_expire(root, 1);
-	spin_unlock(&vfsmount_lock);
-	return ret;
+	WARN_ON(count < 0);
+	return count == 0;
 }
 
 static struct vfsmount *
@@ -453,24 +445,6 @@ static int do_umount(struct vfsmount *mn
 		return retval;
 
 	/*
-	 * Allow userspace to request a mountpoint be expired rather than
-	 * unmounting unconditionally. Unmount only happens if:
-	 *  (1) the mark is already set (the mark is cleared by mntput())
-	 *  (2) the usage count == 1 [parent vfsmount] + 1 [sys_umount]
-	 */
-	if (flags & MNT_EXPIRE) {
-		if (mnt == current->fs->rootmnt ||
-		    flags & (MNT_FORCE | MNT_DETACH))
-			return -EINVAL;
-
-		if (!can_expire(mnt))
-			return -EBUSY;
-
-		if (--mnt->mnt_expiry_countdown != 0)
-			return -EAGAIN;
-	}
-
-	/*
 	 * If we may have to abort operations to get out of this
 	 * mount, and they will themselves hold resources we must
 	 * allow the fs to do things. In the Unix tradition of
@@ -524,8 +498,7 @@ static int do_umount(struct vfsmount *mn
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH
-		|| (flags & MNT_EXPIRE && can_expire(mnt))) {
+	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list)) {
 			clear_expire(mnt);
 			umount_tree(mnt);
@@ -1019,7 +992,7 @@ static void do_expiry_run(void *nothing)
 		}
 		if (mnt->mnt_expiry_countdown >= 1)
 			mnt->mnt_expiry_countdown--;
-		if (__can_expire(mnt, 0) && mnt->mnt_expiry_countdown == 0) {
+		if (can_expire(mnt, 0) && mnt->mnt_expiry_countdown == 0) {
 			mntget(mnt);
 			list_move(&mnt->mnt_expire, &graveyard);
 		}
@@ -1048,7 +1021,7 @@ static void do_expiry_run(void *nothing)
 		down_write(&namespace->sem);
 		spin_lock(&vfsmount_lock);
 
-		if (!__can_expire(mnt, 1) || mnt->mnt_active) {
+		if (!can_expire(mnt, 1) || mnt->mnt_active) {
 			list_add_tail(&mnt->mnt_expire, &expiry_list);
 		} else {
 			parent = find_expiring_parent(mnt);
@@ -1057,7 +1030,7 @@ static void do_expiry_run(void *nothing)
 			umount_tree(mnt);
 
 			/* the parent may be expirable now */
-			if (parent && __can_expire(parent, 1) &&
+			if (parent && can_expire(parent, 1) &&
 			    parent->mnt_expiry_countdown == 0 &&
 			    !parent->mnt_active) {
 				list_move_tail(&parent->mnt_expire, &graveyard);

