Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbUJYOzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUJYOzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUJYOqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:46:55 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:41384 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261836AbUJYOkK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:40:10 -0400
Cc: raven@themaw.net
Subject: [PATCH 3/28] VFS: Move expiry into vfs
In-Reply-To: <10987151702831@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:40:00 -0400
Message-Id: <10987152003432@sun.com>
References: <10987151702831@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the recently added expiry functionality directly into the
VFS layer.  Doing this gives us a couple advantages:

  - Allows for configurable timeouts using a single consolidated timer
  - Keeps filesystems from having to each implement their own expiry logic
  - Provides a generic interface that can be used for _any_ filesystem, as
    desired by user applications and/or the system admninistrator.

This patch implements expiry by having the VFS recursively register work to
do.  Checks are done for expiry every 1 second, so expiry is configurable to
that granularity.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c        |   75 ++++++++++++++++++++++++++++++++++++--------------
 include/linux/mount.h |    6 +---
 2 files changed, 57 insertions(+), 24 deletions(-)

Index: linux-2.6.9-quilt/include/linux/mount.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/mount.h	2004-10-22 17:17:33.460377392 -0400
+++ linux-2.6.9-quilt/include/linux/mount.h	2004-10-22 17:17:34.147272968 -0400
@@ -68,10 +68,8 @@ extern struct vfsmount *do_kern_mount(co
 
 struct nameidata;
 
-extern int do_add_mount(struct vfsmount *newmnt, struct nameidata *nd,
-			int mnt_flags, struct list_head *fslist);
-
-extern void mark_mounts_for_expiry(struct list_head *mounts);
+extern int do_graft_mount(struct vfsmount *newmnt, struct nameidata *nd);
+extern void mnt_expire(struct vfsmount *mnt, unsigned expire);
 
 extern spinlock_t vfsmount_lock;
 
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:33.461377240 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:34.148272816 -0400
@@ -42,6 +42,13 @@ static struct list_head *mount_hashtable
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
 
+/* manage mountpoint expiry */
+static LIST_HEAD(expiry_list);
+static void do_expiry_run(void *nothing);
+static DECLARE_WORK(expiry_work, do_expiry_run, NULL);
+static DECLARE_MUTEX(expiry_sem);
+#define EXPIRE_PERIOD (HZ)
+
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
@@ -431,6 +438,7 @@ static int do_umount(struct vfsmount *mn
 		return retval;
 	}
 
+	down(&expiry_sem);
 	down_write(&current->namespace->sem);
 	spin_lock(&vfsmount_lock);
 
@@ -446,14 +454,17 @@ static int do_umount(struct vfsmount *mn
 	}
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
-		if (!list_empty(&mnt->mnt_list))
+		if (!list_empty(&mnt->mnt_list)) {
+			list_del_init(&mnt->mnt_expire);
 			umount_tree(mnt);
+		}
 		retval = 0;
 	}
 	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);
+	up(&expiry_sem);
 	return retval;
 }
 
@@ -760,7 +771,7 @@ out:
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
  */
-static int do_new_mount(struct nameidata *nd, char *type, int flags,
+static int do_add_mount(struct nameidata *nd, char *type, int flags,
 			int mnt_flags, char *name, void *data)
 {
 	struct vfsmount *mnt;
@@ -776,15 +787,15 @@ static int do_new_mount(struct nameidata
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	return do_add_mount(mnt, nd, mnt_flags, NULL);
+	mnt->mnt_flags = mnt_flags;
+	return do_graft_mount(mnt, nd);
 }
 
 /*
  * add a mount into a namespace's mount tree
  * - provide the option of adding the new mount to an expiration list
  */
-int do_add_mount(struct vfsmount *newmnt, struct nameidata *nd,
-		 int mnt_flags, struct list_head *fslist)
+int do_graft_mount(struct vfsmount *newmnt, struct nameidata *nd)
 {
 	int err;
 
@@ -806,38 +817,52 @@ int do_add_mount(struct vfsmount *newmnt
 	if (S_ISLNK(newmnt->mnt_root->d_inode->i_mode))
 		goto unlock;
 
-	newmnt->mnt_flags = mnt_flags;
 	err = graft_tree(newmnt, nd);
 
-	if (err == 0 && fslist) {
-		/* add to the specified expiration list */
-		spin_lock(&vfsmount_lock);
-		list_add_tail(&newmnt->mnt_expire, fslist);
-		spin_unlock(&vfsmount_lock);
-	}
 
 unlock:
 	up_write(&current->namespace->sem);
 	mntput(newmnt);
 	return err;
 }
+EXPORT_SYMBOL_GPL(do_graft_mount);
+
+void mnt_expire(struct vfsmount *mnt, unsigned expire)
+{
+	down(&expiry_sem);
+	spin_lock(&vfsmount_lock);
 
-EXPORT_SYMBOL_GPL(do_add_mount);
+	/* Expiry is not permitted on mounts that are not associated with a
+	 * namespace.  This is due to the fact that we cannot reliably handle
+	 * removing the mount from the expiry list when the mount is no longer
+	 * referenced */
+	if (!mnt->mnt_namespace)
+		goto out;
 
+	list_del_init(&mnt->mnt_expire);
+	if (expire > 0)
+		list_add_tail(&mnt->mnt_expire, &expiry_list);
+out:
+	spin_unlock(&vfsmount_lock);
+	up(&expiry_sem);
+}
+EXPORT_SYMBOL_GPL(mnt_expire);
+  
 /*
  * process a list of expirable mountpoints with the intent of discarding any
  * mountpoints that aren't in use and haven't been touched since last we came
  * here
  */
-void mark_mounts_for_expiry(struct list_head *mounts)
+static void do_expiry_run(void *nothing)
 {
 	struct namespace *namespace;
 	struct vfsmount *mnt, *next;
 	LIST_HEAD(graveyard);
 
-	if (list_empty(mounts))
+	if (list_empty(&expiry_list))
 		return;
 
+	down(&expiry_sem);
 	spin_lock(&vfsmount_lock);
 
 	/* extract from the expiration list every vfsmount that matches the
@@ -846,7 +871,7 @@ void mark_mounts_for_expiry(struct list_
 	 * - still marked for expiry (marked on the last call here; marks are
 	 *   cleared by mntput())
 	 */
-	list_for_each_entry_safe(mnt, next, mounts, mnt_expire) {
+	list_for_each_entry_safe(mnt, next, &expiry_list, mnt_expire) {
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 		    atomic_read(&mnt->mnt_count) != 1)
 			continue;
@@ -913,22 +938,29 @@ void mark_mounts_for_expiry(struct list_
 			/* someone brought it back to life whilst we didn't
 			 * have any locks held so return it to the expiration
 			 * list */
-			list_add_tail(&mnt->mnt_expire, mounts);
+			list_add_tail(&mnt->mnt_expire, &expiry_list);
 			spin_unlock(&vfsmount_lock);
 		}
 
 		up_write(&namespace->sem);
 
-		mntput(mnt);
+		_mntput(mnt);
 		put_namespace(namespace);
 
 		spin_lock(&vfsmount_lock);
 	}
 
 	spin_unlock(&vfsmount_lock);
+	up(&expiry_sem);
+	schedule_delayed_work(&expiry_work, EXPIRE_PERIOD);
 }
 
-EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
+static __init int start_expiry_work(void)
+{
+	schedule_delayed_work(&expiry_work, EXPIRE_PERIOD);
+	return 1;
+}
+late_initcall(start_expiry_work);
 
 int copy_mount_options (const void __user *data, unsigned long *where)
 {
@@ -1024,7 +1056,7 @@ long do_mount(char * dev_name, char * di
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
-		retval = do_new_mount(&nd, type_page, flags, mnt_flags,
+		retval = do_add_mount(&nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
 dput_out:
 	path_release(&nd);
@@ -1421,15 +1453,18 @@ void __put_namespace(struct namespace *n
 {
 	struct vfsmount *mnt;
 
+	down(&expiry_sem);
 	down_write(&namespace->sem);
 	spin_lock(&vfsmount_lock);
 
 	list_for_each_entry(mnt, &namespace->list, mnt_list) {
 		mnt->mnt_namespace = NULL;
+		list_del_init(&mnt->mnt_expire);
 	}
 
 	umount_tree(namespace->root);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace->sem);
+	up(&expiry_sem);
 	kfree(namespace);
 }

