Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVKHCDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVKHCDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVKHCBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:30157 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965257AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 7/18] umount_tree() locking change
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ep-8v@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401824 -0500

umount is done under the protection of the namespace semaphore. This can lead
to intresting deadlocks when the last reference to a mount is released, if
filesystem code is in sufficiently nasty state.

This patch collects all the to-be-released-mounts and releases them after
releasing the namespace semaphore.  That both reduces the time we are
holding namespace semaphore and gets the things more robust.

Idea proposed by Al Viro.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   84 ++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 51 insertions(+), 33 deletions(-)

dd3f73bd6018c2260f0315b959b8167b36ac4b1a
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -394,32 +394,45 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void umount_tree(struct vfsmount *mnt)
+static void release_mounts(struct list_head *head)
+{
+	struct vfsmount *mnt;
+	while(!list_empty(head)) {
+		mnt = list_entry(head->next, struct vfsmount, mnt_hash);
+		list_del_init(&mnt->mnt_hash);
+		if (mnt->mnt_parent != mnt) {
+			struct dentry *dentry;
+			struct vfsmount *m;
+			spin_lock(&vfsmount_lock);
+			dentry = mnt->mnt_mountpoint;
+			m = mnt->mnt_parent;
+			mnt->mnt_mountpoint = mnt->mnt_root;
+			mnt->mnt_parent = mnt;
+			spin_unlock(&vfsmount_lock);
+			dput(dentry);
+			mntput(m);
+		}
+		mntput(mnt);
+	}
+}
+
+static void umount_tree(struct vfsmount *mnt, struct list_head *kill)
 {
 	struct vfsmount *p;
-	LIST_HEAD(kill);
 
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		list_del(&p->mnt_list);
-		list_add(&p->mnt_list, &kill);
-		__touch_namespace(p->mnt_namespace);
-		p->mnt_namespace = NULL;
+		list_del(&p->mnt_hash);
+		list_add(&p->mnt_hash, kill);
 	}
 
-	while (!list_empty(&kill)) {
-		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
-		list_del_init(&mnt->mnt_list);
-		list_del_init(&mnt->mnt_expire);
-		if (mnt->mnt_parent == mnt) {
-			spin_unlock(&vfsmount_lock);
-		} else {
-			struct nameidata old_nd;
-			detach_mnt(mnt, &old_nd);
-			spin_unlock(&vfsmount_lock);
-			path_release(&old_nd);
-		}
-		mntput(mnt);
-		spin_lock(&vfsmount_lock);
+	list_for_each_entry(p, kill, mnt_hash) {
+		list_del_init(&p->mnt_expire);
+		list_del_init(&p->mnt_list);
+		__touch_namespace(p->mnt_namespace);
+		p->mnt_namespace = NULL;
+		list_del_init(&p->mnt_child);
+		if (p->mnt_parent != p)
+			mnt->mnt_mountpoint->d_mounted--;
 	}
 }
 
@@ -427,6 +440,7 @@ static int do_umount(struct vfsmount *mn
 {
 	struct super_block *sb = mnt->mnt_sb;
 	int retval;
+	LIST_HEAD(umount_list);
 
 	retval = security_sb_umount(mnt, flags);
 	if (retval)
@@ -497,13 +511,14 @@ static int do_umount(struct vfsmount *mn
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list))
-			umount_tree(mnt);
+			umount_tree(mnt, &umount_list);
 		retval = 0;
 	}
 	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);
+	release_mounts(&umount_list);
 	return retval;
 }
 
@@ -616,9 +631,11 @@ static struct vfsmount *copy_tree(struct
 	return res;
 Enomem:
 	if (res) {
+		LIST_HEAD(umount_list);
 		spin_lock(&vfsmount_lock);
-		umount_tree(res);
+		umount_tree(res, &umount_list);
 		spin_unlock(&vfsmount_lock);
+		release_mounts(&umount_list);
 	}
 	return NULL;
 }
@@ -698,9 +715,11 @@ static int do_loopback(struct nameidata 
 
 	err = graft_tree(mnt, nd);
 	if (err) {
+		LIST_HEAD(umount_list);
 		spin_lock(&vfsmount_lock);
-		umount_tree(mnt);
+		umount_tree(mnt, &umount_list);
 		spin_unlock(&vfsmount_lock);
+		release_mounts(&umount_list);
 	}
 
 out:
@@ -875,7 +894,8 @@ unlock:
 
 EXPORT_SYMBOL_GPL(do_add_mount);
 
-static void expire_mount(struct vfsmount *mnt, struct list_head *mounts)
+static void expire_mount(struct vfsmount *mnt, struct list_head *mounts,
+				struct list_head *umounts)
 {
 	spin_lock(&vfsmount_lock);
 
@@ -893,16 +913,12 @@ static void expire_mount(struct vfsmount
 	 * contributed by the vfsmount parent and the mntget above
 	 */
 	if (atomic_read(&mnt->mnt_count) == 2) {
-		struct nameidata old_nd;
-
 		/* delete from the namespace */
 		touch_namespace(mnt->mnt_namespace);
 		list_del_init(&mnt->mnt_list);
 		mnt->mnt_namespace = NULL;
-		detach_mnt(mnt, &old_nd);
+		umount_tree(mnt, umounts);
 		spin_unlock(&vfsmount_lock);
-		path_release(&old_nd);
-		mntput(mnt);
 	} else {
 		/*
 		 * Someone brought it back to life whilst we didn't have any
@@ -951,6 +967,7 @@ void mark_mounts_for_expiry(struct list_
 	 * - dispose of the corpse
 	 */
 	while (!list_empty(&graveyard)) {
+		LIST_HEAD(umounts);
 		mnt = list_entry(graveyard.next, struct vfsmount, mnt_expire);
 		list_del_init(&mnt->mnt_expire);
 
@@ -963,12 +980,11 @@ void mark_mounts_for_expiry(struct list_
 
 		spin_unlock(&vfsmount_lock);
 		down_write(&namespace->sem);
-		expire_mount(mnt, mounts);
+		expire_mount(mnt, mounts, &umounts);
 		up_write(&namespace->sem);
-
+		release_mounts(&umounts);
 		mntput(mnt);
 		put_namespace(namespace);
-
 		spin_lock(&vfsmount_lock);
 	}
 
@@ -1508,12 +1524,14 @@ void __init mnt_init(unsigned long mempa
 void __put_namespace(struct namespace *namespace)
 {
 	struct vfsmount *root = namespace->root;
+	LIST_HEAD(umount_list);
 	namespace->root = NULL;
 	spin_unlock(&vfsmount_lock);
 	down_write(&namespace->sem);
 	spin_lock(&vfsmount_lock);
-	umount_tree(root);
+	umount_tree(root, &umount_list);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace->sem);
+	release_mounts(&umount_list);
 	kfree(namespace);
 }
