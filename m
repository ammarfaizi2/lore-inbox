Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUJYOo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUJYOo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUJYOo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:44:26 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:45736 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261842AbUJYOls convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:41:48 -0400
Cc: raven@themaw.net
Subject: [PATCH 6/28] VFS: Make expiry recursive
In-Reply-To: <10987152612887@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:41:31 -0400
Message-Id: <1098715291724@sun.com>
References: <10987152612887@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows for tagging of vfsmounts as being part of a sub-tree
expiry.  It introduces a new vfsmount flag, MNT_CHILDEXPIRE which is used to
let the system know that the given mountpoint expires with its parent.  This
is a recursive definition.

mnt_expiry, the call used to specify that a mount should expire, now takes an
int described as follows:
   -  0  -   The mountpoint should not expire (default)
   - >0  -   The value is used to specify the amount of idle time before the
             given mountpoint expires.
   - <0  -   The mountpoint must expire with it's immediate parent.  (parent
             must be set to expire, or must be itself be marked to expire
             along with _its_ parent.

This allows atomic expiry of a complex hierarchy of mountpoints.  This means
userspace will either 'see' or 'not see' the hierarchy of mountpoints.  (This
required when using a generic automount facility that acts like a mounted
filesystem on top of any other filesystem).

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c        |  236 +++++++++++++++++++++++++++++++++++++-------------
 include/linux/mount.h |    3 
 2 files changed, 179 insertions(+), 60 deletions(-)

Index: linux-2.6.9-quilt/include/linux/mount.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/mount.h	2004-10-22 17:17:35.377086008 -0400
+++ linux-2.6.9-quilt/include/linux/mount.h	2004-10-22 17:17:35.927002408 -0400
@@ -17,6 +17,7 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_CHILDEXPIRE 8
 
 struct vfsmount
 {
@@ -71,7 +72,7 @@ extern struct vfsmount *do_kern_mount(co
 struct nameidata;
 
 extern int do_graft_mount(struct vfsmount *newmnt, struct nameidata *nd);
-extern void mnt_expire(struct vfsmount *mnt, unsigned expire);
+extern int mnt_expire(struct vfsmount *mnt, int expire);
 
 extern spinlock_t vfsmount_lock;
 
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:35.378085856 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:35.929002104 -0400
@@ -157,6 +157,34 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
+static int __can_expire(struct vfsmount *root, int offset)
+{
+	struct vfsmount *mnt;
+	int count;
+	
+	/* handle the case of a root or orphaned mountpoint */
+	if (root->mnt_parent == root || root->mnt_parent == NULL)
+		return 0;
+	count = atomic_read(&root->mnt_count) - 1 - offset;
+	for (mnt = next_mnt(root, root); mnt; mnt = next_mnt(mnt, root)) {
+		if (!(mnt->mnt_flags & MNT_CHILDEXPIRE))
+			return 0;
+		count += atomic_read(&mnt->mnt_count) - 2;
+	}
+	
+	WARN_ON(count < 0);
+	return count == 0;	
+}
+
+static int can_expire(struct vfsmount *root)
+{
+	int ret;
+	spin_lock(&vfsmount_lock);
+	ret = __can_expire(root, 1);
+	spin_unlock(&vfsmount_lock);
+	return ret;
+}
+
 static struct vfsmount *
 clone_mnt(struct vfsmount *old, struct dentry *root)
 {
@@ -164,20 +192,13 @@ clone_mnt(struct vfsmount *old, struct d
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
 
 	if (mnt) {
-		mnt->mnt_flags = old->mnt_flags;
+		mnt->mnt_flags = old->mnt_flags & ~MNT_CHILDEXPIRE;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
 		mnt->mnt_namespace = old->mnt_namespace;
-
-		/* stick the duplicate mount on the same expiry list
-		 * as the original if that was on one */
-		spin_lock(&vfsmount_lock);
-		if (!list_empty(&old->mnt_expire))
-			list_add(&mnt->mnt_expire, &old->mnt_expire);
-		spin_unlock(&vfsmount_lock);
 	}
 	return mnt;
 }
@@ -275,6 +296,43 @@ struct seq_operations mounts_op = {
 	.show	= show_vfsmnt
 };
 
+/*
+ * Clear out MNT_CHILDEXPIRE from the given mountpoint (recursively) to ensure
+ * that our invariant that nodes that have MNT_CHILDEXPIRE set recursivly have
+ * a parent that will eventually expire.
+ */
+static void clear_childexpire(struct vfsmount *root)
+{
+	struct list_head *next;
+	struct vfsmount *this_parent = root;
+
+	if (!(root->mnt_flags & MNT_CHILDEXPIRE))
+		return;
+
+	root->mnt_flags &= ~MNT_CHILDEXPIRE;
+	next = this_parent->mnt_mounts.next;
+again:
+	for ( ; next != &this_parent->mnt_mounts ; next = next->next ) {
+		struct vfsmount *p = list_entry(next, struct vfsmount,
+						mnt_child);
+
+		if (p->mnt_flags & MNT_CHILDEXPIRE) {
+			p->mnt_flags &= ~MNT_CHILDEXPIRE;
+			if (!list_empty(&p->mnt_mounts)) {
+				this_parent = p;
+				next = this_parent->mnt_mounts.next;
+				continue;
+			}
+		}
+	}
+
+	if (this_parent != root) {
+		next = this_parent->mnt_child.next;
+		this_parent = this_parent->mnt_parent;
+		goto again;
+	}
+}
+
 /**
  * may_umount_tree - check if a mount tree is busy
  * @mnt: root of mount tree
@@ -347,6 +405,17 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
+/* clear all expire related information in the subtree rooted at root */
+static void clear_expire(struct vfsmount *root)
+{
+	struct vfsmount *p;
+
+	for (p = root; p; p = next_mnt(p, root)) {
+		list_del_init(&p->mnt_expire);
+		p->mnt_flags &= ~MNT_CHILDEXPIRE;
+	}
+}
+
 static void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
@@ -394,7 +463,7 @@ static int do_umount(struct vfsmount *mn
 		    flags & (MNT_FORCE | MNT_DETACH))
 			return -EINVAL;
 
-		if (atomic_read(&mnt->mnt_count) != 2)
+		if (!can_expire(mnt))
 			return -EBUSY;
 
 		if (--mnt->mnt_expiry_countdown != 0)
@@ -455,9 +524,10 @@ static int do_umount(struct vfsmount *mn
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
+	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH
+		|| (flags & MNT_EXPIRE && can_expire(mnt))) {
 		if (!list_empty(&mnt->mnt_list)) {
-			list_del_init(&mnt->mnt_expire);
+			clear_expire(mnt);
 			umount_tree(mnt);
 		}
 		retval = 0;
@@ -658,6 +728,7 @@ static int do_loopback(struct nameidata 
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
 		list_del_init(&mnt->mnt_expire);
+		clear_childexpire(mnt);
 		spin_unlock(&vfsmount_lock);
 
 		err = graft_tree(mnt, nd);
@@ -698,7 +769,8 @@ static int do_remount(struct nameidata *
 	down_write(&sb->s_umount);
 	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
-		nd->mnt->mnt_flags=mnt_flags;
+		nd->mnt->mnt_flags = mnt_flags | 
+		    (nd->mnt->mnt_flags & MNT_CHILDEXPIRE);
 	up_write(&sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
@@ -754,9 +826,8 @@ static int do_move_mount(struct nameidat
 	detach_mnt(old_nd.mnt, &parent_nd);
 	attach_mnt(old_nd.mnt, nd);
 
-	/* if the mount is moved, it should no longer be expire
-	 * automatically */
-	list_del_init(&old_nd.mnt->mnt_expire);
+	/* if the mount is moved, we need to clear it's child expire flag */
+	clear_childexpire(old_nd.mnt);
 out2:
 	spin_unlock(&vfsmount_lock);
 out1:
@@ -829,8 +900,18 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(do_graft_mount);
 
-void mnt_expire(struct vfsmount *mnt, unsigned expire)
+/*
+ * Change the expiry settings for a given mountpoint
+ *   0 - Disable expiry for a given mountpoint
+ *  <0 - Set this mountpoint to be part of a sub-tree expiry
+ *  >0 - This mountpoint will expire after expire ticks
+ *
+ *  Returns zero on success.
+ */
+int mnt_expire(struct vfsmount *mnt, int expire)
 {
+	int ret = 1;
+
 	down(&expiry_sem);
 	spin_lock(&vfsmount_lock);
 
@@ -841,17 +922,68 @@ void mnt_expire(struct vfsmount *mnt, un
 	if (!mnt->mnt_namespace)
 		goto out;
 
-	list_del_init(&mnt->mnt_expire);
-	mnt->mnt_expiry_ticks = mnt->mnt_expiry_countdown = expire;
-	mnt->mnt_active = 1;
-	if (expire > 0)
-		list_add_tail(&mnt->mnt_expire, &expiry_list);
+	if (expire < 0) {
+		if (!list_empty(&mnt->mnt_expire))
+			goto out;
+		if (mnt->mnt_parent == mnt || mnt->mnt_parent == NULL)
+			goto out;
+		if (!(mnt->mnt_parent->mnt_flags & MNT_CHILDEXPIRE)
+		     && list_empty(&mnt->mnt_parent->mnt_expire))
+			goto out;
+		mnt->mnt_flags |= MNT_CHILDEXPIRE;
+	} else {
+		if (mnt->mnt_flags & MNT_CHILDEXPIRE && expire)
+			goto out;
+		clear_childexpire(mnt);
+		list_del_init(&mnt->mnt_expire);
+		mnt->mnt_expiry_ticks = mnt->mnt_expiry_countdown = expire;
+		mnt->mnt_active = 1;
+		if (expire > 0)
+			list_add_tail(&mnt->mnt_expire, &expiry_list);
+	}
+	ret = 0;
+
 out:
 	spin_unlock(&vfsmount_lock);
 	up(&expiry_sem);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mnt_expire);
 
+/* return the first ancestor mount that impacts expiry, or NULL if none do */
+static struct vfsmount *find_expiring_parent(struct vfsmount *mnt)
+{
+	struct vfsmount *p = mnt->mnt_parent;
+	/*
+	 * one of three things is true:
+	 * 1. all parents are normal mounts
+	 * 2. parent is a simple expiry mount
+	 * 3. parent is a CHILDEXPIRE -- walk up the tree until we get to
+	 *    a mount that fits case 1 or case 2
+	 */
+	while (p && p->mnt_parent != p && p->mnt_flags & MNT_CHILDEXPIRE)
+		p = p->mnt_parent;
+	if (p && list_empty(&p->mnt_expire))
+		return NULL;
+	return mntget(p);
+}
+
+static void bump_expiry_counter(struct vfsmount *mnt, struct vfsmount *parent)
+{
+	int diff;
+
+	/*
+	 * If the parent is set to expire, then its counter has been
+	 * counting down.  If it thinks it has been idle for longer than
+	 * the child, we need to bump it up.  This child has been used more
+	 * recently than the parent, so the parent can only possibly be idle
+	 * for as long as this child (or less).
+	 */
+	diff = parent->mnt_expiry_ticks - mnt->mnt_expiry_ticks;
+	if (parent->mnt_expiry_countdown < diff)
+		parent->mnt_expiry_countdown = diff;
+}
+
 /*
  * process a list of expirable mountpoints with the intent of discarding any
  * mountpoints that aren't in use and haven't been touched since last we came
@@ -887,7 +1019,7 @@ static void do_expiry_run(void *nothing)
 		}
 		if (mnt->mnt_expiry_countdown >= 1)
 			mnt->mnt_expiry_countdown--;
-		if (atomic_read(&mnt->mnt_count) == 2 && mnt->mnt_expiry_countdown == 0) {
+		if (__can_expire(mnt, 0) && mnt->mnt_expiry_countdown == 0) {
 			mntget(mnt);
 			list_move(&mnt->mnt_expire, &graveyard);
 		}
@@ -900,6 +1032,8 @@ static void do_expiry_run(void *nothing)
 	 * - dispose of the corpse
 	 */
 	while (!list_empty(&graveyard)) {
+		struct vfsmount *parent = NULL;
+
 		mnt = list_entry(graveyard.next, struct vfsmount, mnt_expire);
 		list_del_init(&mnt->mnt_expire);
 
@@ -914,50 +1048,33 @@ static void do_expiry_run(void *nothing)
 		down_write(&namespace->sem);
 		spin_lock(&vfsmount_lock);
 
-		/* check that it is still dead: the count should now be 2 - as
-		 * contributed by the vfsmount parent and the mntget above */
-		if (atomic_read(&mnt->mnt_count) == 2 && !mnt->mnt_active) {
-			struct vfsmount *xdmnt;
-			struct dentry *xdentry;
-
-			/* delete from the namespace */
-			list_del_init(&mnt->mnt_list);
-			list_del_init(&mnt->mnt_child);
-			list_del_init(&mnt->mnt_hash);
-			mnt->mnt_mountpoint->d_mounted--;
-
-			xdentry = mnt->mnt_mountpoint;
-			mnt->mnt_mountpoint = mnt->mnt_root;
-			xdmnt = mnt->mnt_parent;
-			mnt->mnt_parent = mnt;
-
-			spin_unlock(&vfsmount_lock);
-
-			mntput(xdmnt);
-			dput(xdentry);
+		if (!__can_expire(mnt, 1) || mnt->mnt_active) {
+			list_add_tail(&mnt->mnt_expire, &expiry_list);
+		} else {
+			parent = find_expiring_parent(mnt);
+			if (parent)
+				bump_expiry_counter(mnt, parent);
+			umount_tree(mnt);
 
-			/* now lay it to rest if this was the last ref on the
-			 * superblock */
-			if (atomic_read(&mnt->mnt_sb->s_active) == 1) {
-				/* last instance - try to be smart */
-				lock_kernel();
-				DQUOT_OFF(mnt->mnt_sb);
-				acct_auto_close(mnt->mnt_sb);
-				unlock_kernel();
+			/* the parent may be expirable now */
+			if (parent && __can_expire(parent, 1) &&
+			    parent->mnt_expiry_countdown == 0 &&
+			    !parent->mnt_active) {
+				list_move_tail(&parent->mnt_expire, &graveyard);
+				
+				/* The ref from find_expiring_parent is now used
+				 * for the graveyard. Set the parent to NULL so
+				 * that it isn't decremented by the _mntput
+				 * below */
+				parent = NULL;
 			}
-
-			mntput(mnt);
-		} else {
-			/* someone brought it back to life whilst we didn't
-			 * have any locks held so return it to the expiration
-			 * list */
-			list_add_tail(&mnt->mnt_expire, &expiry_list);
-			spin_unlock(&vfsmount_lock);
 		}
 
+		spin_unlock(&vfsmount_lock);
 		up_write(&namespace->sem);
 
 		_mntput(mnt);
+		_mntput(parent);
 		put_namespace(namespace);
 
 		spin_lock(&vfsmount_lock);
@@ -1472,6 +1589,7 @@ void __put_namespace(struct namespace *n
 
 	list_for_each_entry(mnt, &namespace->list, mnt_list) {
 		mnt->mnt_namespace = NULL;
+		mnt->mnt_flags &= ~MNT_CHILDEXPIRE;
 		list_del_init(&mnt->mnt_expire);
 	}
 

