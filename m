Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbUJYOzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUJYOzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUJYOpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:45:21 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:44200 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261837AbUJYOlM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:41:12 -0400
Cc: raven@themaw.net
Subject: [PATCH 5/28] VFS: Make expiry timeout configurable
In-Reply-To: <1098715230634@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:41:01 -0400
Message-Id: <10987152612887@sun.com>
References: <1098715230634@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the expiry logic to make timeouts configurable.  We do
this by using an atomic counter that ticks downwards every second of
non-usage.  We also store a per vfsmount value of what this timer gets reset
to on every mntput.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c        |   33 +++++++++++++++++++++++----------
 include/linux/mount.h |    6 ++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

Index: linux-2.6.9-quilt/include/linux/mount.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/mount.h	2004-10-22 17:17:34.147272968 -0400
+++ linux-2.6.9-quilt/include/linux/mount.h	2004-10-22 17:17:35.377086008 -0400
@@ -29,7 +29,9 @@ struct vfsmount
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
 	int mnt_flags;
-	int mnt_expiry_mark;		/* true if marked for expiry */
+	int mnt_active;			/* flag set on mntput() */
+	int mnt_expiry_countdown;	/* countdown of ticks until expiry */
+	int mnt_expiry_ticks;		/* total ticks before expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
@@ -56,7 +58,7 @@ static inline void _mntput(struct vfsmou
 static inline void mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
-		mnt->mnt_expiry_mark = 0;
+		xchg(&mnt->mnt_active, 1);
 		_mntput(mnt);
 	}
 }
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:34.148272816 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:35.378085856 -0400
@@ -68,6 +68,8 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_expire);
+		mnt->mnt_expiry_ticks = mnt->mnt_expiry_countdown = 0;
+		mnt->mnt_active = 1;
 		if (name) {
 			int size = strlen(name)+1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -365,9 +367,9 @@ static void umount_tree(struct vfsmount 
 			struct nameidata old_nd;
 			detach_mnt(mnt, &old_nd);
 			spin_unlock(&vfsmount_lock);
-			path_release(&old_nd);
+			path_release_on_umount(&old_nd);
 		}
-		mntput(mnt);
+		_mntput(mnt);
 		spin_lock(&vfsmount_lock);
 	}
 }
@@ -395,7 +397,7 @@ static int do_umount(struct vfsmount *mn
 		if (atomic_read(&mnt->mnt_count) != 2)
 			return -EBUSY;
 
-		if (!xchg(&mnt->mnt_expiry_mark, 1))
+		if (--mnt->mnt_expiry_countdown != 0)
 			return -EAGAIN;
 	}
 
@@ -840,6 +842,8 @@ void mnt_expire(struct vfsmount *mnt, un
 		goto out;
 
 	list_del_init(&mnt->mnt_expire);
+	mnt->mnt_expiry_ticks = mnt->mnt_expiry_countdown = expire;
+	mnt->mnt_active = 1;
 	if (expire > 0)
 		list_add_tail(&mnt->mnt_expire, &expiry_list);
 out:
@@ -847,7 +851,7 @@ out:
 	up(&expiry_sem);
 }
 EXPORT_SYMBOL_GPL(mnt_expire);
-  
+
 /*
  * process a list of expirable mountpoints with the intent of discarding any
  * mountpoints that aren't in use and haven't been touched since last we came
@@ -872,12 +876,21 @@ static void do_expiry_run(void *nothing)
 	 *   cleared by mntput())
 	 */
 	list_for_each_entry_safe(mnt, next, &expiry_list, mnt_expire) {
-		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
-		    atomic_read(&mnt->mnt_count) != 1)
+		/*
+		 * Something might still hold a reference to this mount. If
+		 * mnt_active is set, we can just move on.  If it gets set
+		 * after we xchg() here, we'll catch it on the graveyard list.
+		 */
+		if (xchg(&mnt->mnt_active, 0)) {
+			mnt->mnt_expiry_countdown = mnt->mnt_expiry_ticks;
 			continue;
-
-		mntget(mnt);
-		list_move(&mnt->mnt_expire, &graveyard);
+		}
+		if (mnt->mnt_expiry_countdown >= 1)
+			mnt->mnt_expiry_countdown--;
+		if (atomic_read(&mnt->mnt_count) == 2 && mnt->mnt_expiry_countdown == 0) {
+			mntget(mnt);
+			list_move(&mnt->mnt_expire, &graveyard);
+		}
 	}
 
 	/*
@@ -903,7 +916,7 @@ static void do_expiry_run(void *nothing)
 
 		/* check that it is still dead: the count should now be 2 - as
 		 * contributed by the vfsmount parent and the mntget above */
-		if (atomic_read(&mnt->mnt_count) == 2) {
+		if (atomic_read(&mnt->mnt_count) == 2 && !mnt->mnt_active) {
 			struct vfsmount *xdmnt;
 			struct dentry *xdentry;
 

