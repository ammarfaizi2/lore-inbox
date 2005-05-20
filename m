Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVETSQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVETSQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVETSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:16:48 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:35852 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261531AbVETSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:16:22 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] namespace.c: split mark_mounts_for_expiry()
Message-Id: <E1DZC22-0005oO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 20:15:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This applies on top of the previous namepace.c patches]

This patch splits the mark_mounts_for_expiry() function.  It's too
complex and too deeply nested, even without the bugfix in the
following patch.

Otherwise code is completely the same.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-20 19:05:20.000000000 +0200
+++ linux/fs/namespace.c	2005-05-20 19:58:07.000000000 +0200
@@ -825,6 +825,40 @@ unlock:
 
 EXPORT_SYMBOL_GPL(do_add_mount);
 
+static void expire_mount(struct vfsmount *mnt, struct list_head *mounts)
+{
+	spin_lock(&vfsmount_lock);
+
+	/* check that it is still dead: the count should now be 2 - as
+	 * contributed by the vfsmount parent and the mntget above */
+	if (atomic_read(&mnt->mnt_count) == 2) {
+		struct nameidata old_nd;
+
+		/* delete from the namespace */
+		list_del_init(&mnt->mnt_list);
+		detach_mnt(mnt, &old_nd);
+		spin_unlock(&vfsmount_lock);
+		path_release(&old_nd);
+
+		/* now lay it to rest if this was the last ref on the
+		 * superblock */
+		if (atomic_read(&mnt->mnt_sb->s_active) == 1) {
+			/* last instance - try to be smart */
+			lock_kernel();
+			DQUOT_OFF(mnt->mnt_sb);
+			acct_auto_close(mnt->mnt_sb);
+			unlock_kernel();
+		}
+
+		mntput(mnt);
+	} else {
+		/* someone brought it back to life whilst we didn't have any
+		 * locks held so return it to the expiration list */
+		list_add_tail(&mnt->mnt_fslink, mounts);
+		spin_unlock(&vfsmount_lock);
+	}
+}
+
 /*
  * process a list of expirable mountpoints with the intent of discarding any
  * mountpoints that aren't in use and haven't been touched since last we came
@@ -875,38 +909,7 @@ void mark_mounts_for_expiry(struct list_
 
 		spin_unlock(&vfsmount_lock);
 		down_write(&namespace->sem);
-		spin_lock(&vfsmount_lock);
-
-		/* check that it is still dead: the count should now be 2 - as
-		 * contributed by the vfsmount parent and the mntget above */
-		if (atomic_read(&mnt->mnt_count) == 2) {
-			struct nameidata old_nd;
-
-			/* delete from the namespace */
-			list_del_init(&mnt->mnt_list);
-			detach_mnt(mnt, &old_nd);
-			spin_unlock(&vfsmount_lock);
-			path_release(&old_nd);
-
-			/* now lay it to rest if this was the last ref on the
-			 * superblock */
-			if (atomic_read(&mnt->mnt_sb->s_active) == 1) {
-				/* last instance - try to be smart */
-				lock_kernel();
-				DQUOT_OFF(mnt->mnt_sb);
-				acct_auto_close(mnt->mnt_sb);
-				unlock_kernel();
-			}
-
-			mntput(mnt);
-		} else {
-			/* someone brought it back to life whilst we didn't
-			 * have any locks held so return it to the expiration
-			 * list */
-			list_add_tail(&mnt->mnt_fslink, mounts);
-			spin_unlock(&vfsmount_lock);
-		}
-
+		expire_mount(mnt, mounts);
 		up_write(&namespace->sem);
 
 		mntput(mnt);

