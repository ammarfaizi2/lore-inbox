Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbVIPS0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbVIPS0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbVIPS0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:26:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29826 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161231AbVIPS0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:26:24 -0400
Date: Fri, 16 Sep 2005 11:26:20 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 6/10] vfs: shared subtree aware move mounts 
Message-ID: <20050916182620.GA28504@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that help move a mount tree to a different mountpoint. The tree can
contain any combination of shared/slave/private/unclonable mounts.

The semantics of these operation depend on the type of the source mount that
is being moved, and destination mount under which the tree shall be moved.  The
table below defines the semantics.
  --------------------------------------------------------------------
  |                          MOVE MOUNT OPERATION                    |
  |******************************************************************|
  |  dest --> | shared       |       private  |  slave   |unclonable |
  | source   |               |                |          |           |
  |   |      |               |                |          |           |
  |   v      |               |                |          |           |
  |******************************************************************|
  |          |               |                |          |           |
  |  shared  | shared (++)   |     shared (+*)|shared(+*)| shared(+*)|
  |          |               |                |          |           |
  |          |               |                |          |           |
  | private  | shared (+)    |      private   | private  | private   |
  |          |               |                |          |           |
  |          |               |                |          |           |
  | slave    | shared (+++)  |      slave     | slave    | slave     |
  |          |               |                |          |           |
  |          |               |                |          |           |
  | unclonable|  invalid     |     unclonable |unclonable| unclonable|
  |          |               |                |          |           |
  |          |               |                |          |           |
   *******************************************************************
 (+++)  the mount is propagated to all the vfsmounts in the destination's
       vfsmount's propagation tree. And the source mount will
       continue to be a slave mount of whatever vfsmount it was
       the slave off.
 (++)  the mount is propagated to all the mounts in the pnode tree
       of the destination mount and the source mount is made
       a peer mount of the mount from which it got cloned off.
 (+*)  a new shared mount is created under the destination mount
 (+)   the mount is propagated to the destination mount's
       propagation tree.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 132 insertions(+), 15 deletions(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -655,11 +655,11 @@ static inline int tree_contains_propagat
 /*
  * commit the operations done in attach_recursive_mnt(). run through pnode list
  * headed at 'pnodehead', and commit the operation done in
  * attach_recursive_mnt();
  */
-static void commit_attach_recursive_mnt(struct vfsmount *source_mnt)
+static void commit_attach_recursive_mnt(struct vfsmount *source_mnt, int move)
 {
 	struct vfsmount *m, *master, *nextmnt;
 	LIST_HEAD(mnt_list_head);
 	LIST_HEAD(nextmnt_list_head);
 
@@ -698,11 +698,11 @@ static void commit_attach_recursive_mnt(
 
 		spin_lock(&vfspnode_lock);
 		propagate_commit_mount(m);
 		spin_unlock(&vfspnode_lock);
 
-		if ((master = m->mnt_master)) {
+		if (!move && (master = m->mnt_master)) {
 			m->mnt_master = NULL;
 			if (IS_MNT_SHARED(master))
 				pnode_merge_mount(m, master);
 			else if (IS_MNT_SLAVE(master)) {
 				BUG_ON(!master->mnt_master);
@@ -801,36 +801,69 @@ static void abort_attach_recursive_mnt(s
  *       a peer mount of the mount from which it got cloned off.
  * (+*)  a new shared mount is created under the destination mount
  * (+)   the mount is propagated to the destination mount's
  *       propagation tree.
  *
+ *  ---------------------------------------------------------------------
+ *  |                          MOVE MOUNT OPERATION                    |
+ *  |*******************************************************************|
+ *  |  dest --> | shared       |       private  |  slave   |unclonable |
+ *  | source   |               |                |          |           |
+ *  |   |      |               |                |          |           |
+ *  |   v      |               |                |          |           |
+ *  |*******************************************************************|
+ *  |          |               |                |          |           |
+ *  |  shared  | shared (++)   |     shared (+*)|shared(+*)| shared(+*)|
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *  | private  | shared (+)    |      private   | private  | private   |
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *  | slave    | shared (+++)  |      slave     | slave    | slave     |
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *  | unclonable|  invalid     |     unclonable |unclonable| unclonable|
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *   ********************************************************************
+ *
+ * (+++)  the mount is propagated to all the mounts in the destination's
+ *       mount's propagation tree. And the source mount
+ *       continues to be a slave mount of whichever mount it was
+ *       the slave off.
+ *
  * if the source mount is a tree, the operations explained above is
  * applied to each mount in the tree.
  *
  * Must be called without spinlocks held, since this function can sleep
  * in allocations.
  *
  */
 static int attach_recursive_mnt(struct vfsmount *source_mnt,
-				struct nameidata *nd)
+				struct nameidata *nd, int move)
 {
 	struct vfsmount *dest_mnt, *last, *m, *p;
 	struct dentry *dest_dentry;
 	int ret;
 	LIST_HEAD(mnt_list_head);
 
 	/*
-	 * if the source tree has no shared or slave mounts and
-	 * the destination mount is not shared, fastpath.
+	 * No special handling is needed if the destination mount is
+	 * not shared and the source tree is moved into it.
+	 * Similarly no special is needed if the destination mount is
+	 * not shared and the source tree has no mounts that forward
+	 * or receive propagation. So just take the fastpath.
 	 */
 	dest_mnt = nd->mnt;
-	if (!IS_MNT_SHARED(dest_mnt) && !tree_contains_propagation(source_mnt)) {
+	if (!IS_MNT_SHARED(dest_mnt) &&
+	    (move || !tree_contains_propagation(source_mnt))) {
 		spin_lock(&vfsmount_lock);
 		attach_mnt(source_mnt, nd);
 		list_add_tail(&mnt_list_head, &source_mnt->mnt_list);
 		list_splice(&mnt_list_head, dest_mnt->mnt_namespace->list.prev);
-		clean_propagation_reference(source_mnt);
+		if (!move)
+			clean_propagation_reference(source_mnt);
 		spin_unlock(&vfsmount_lock);
 		goto out;
 	}
 
 	p = NULL;
@@ -856,11 +889,11 @@ static int attach_recursive_mnt(struct v
 		list_del_init(&m->mnt_list);
 		last = m;
 		if ((ret = propagate_prepare_mount(dest_mnt, dest_dentry, m)))
 			goto error;
 	}
-	commit_attach_recursive_mnt(source_mnt);
+	commit_attach_recursive_mnt(source_mnt, move);
       out:
 	mntget(source_mnt);
 	return 0;
       error:
 	/*
@@ -870,10 +903,33 @@ static int attach_recursive_mnt(struct v
 	 */
 	abort_attach_recursive_mnt(source_mnt, last, &mnt_list_head);
 	return 1;
 }
 
+static void detach_recursive_mnt(struct vfsmount *source_mnt,
+				 struct nameidata *nd)
+{
+	struct vfsmount *m;
+
+	detach_mnt(source_mnt, nd);
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		list_del_init(&m->mnt_list);
+		if (m != source_mnt)
+			list_add_tail(&m->mnt_list, &source_mnt->mnt_list);
+	}
+}
+
+static void undo_detach_recursive_mnt(struct vfsmount *mnt,
+				      struct nameidata *nd)
+{
+	LIST_HEAD(head);
+
+	attach_mnt(mnt, nd);
+	list_add_tail(&head, &mnt->mnt_list);
+	list_splice(&head, nd->mnt->mnt_namespace->list.prev);
+}
+
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
 	int err;
 	if (mnt->mnt_sb->s_flags & MS_NOUSER)
 		return -EINVAL;
@@ -891,11 +947,11 @@ static int graft_tree(struct vfsmount *m
 	if (err)
 		goto out_unlock;
 
 	err = -ENOENT;
 	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry))
-		err = attach_recursive_mnt(mnt, nd);
+		err = attach_recursive_mnt(mnt, nd, 0);
       out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
 		security_sb_post_addmount(mnt, nd);
 	return err;
@@ -1029,10 +1085,23 @@ static int do_remount(struct nameidata *
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
 	return err;
 }
 
+/*
+ * return 1 if the mount tree contains a unclonable mount
+ */
+static inline int tree_contains_unclone(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		if (IS_MNT_UNCLONABLE(p))
+			return 1;
+	}
+	return 0;
+}
+
 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
 	struct nameidata old_nd, parent_nd;
 	struct vfsmount *p;
 	int err = 0;
@@ -1068,18 +1137,38 @@ static int do_move_mount(struct nameidat
 
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
 	    S_ISDIR(old_nd.dentry->d_inode->i_mode))
 		goto out2;
 
+	/*
+	 * Don't move a mount in a shared parent.
+	 */
+	if (old_nd.mnt->mnt_parent && IS_MNT_SHARED(old_nd.mnt->mnt_parent))
+		goto out2;
+
+	/*
+	 * Don't move a mount tree having unclonable
+	 * mounts, under a shared mount
+	 */
+	if (IS_MNT_SHARED(nd->mnt) && tree_contains_unclone(old_nd.mnt))
+		goto out2;
+
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent != p; p = p->mnt_parent)
 		if (p == old_nd.mnt)
 			goto out2;
 	err = 0;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
+	detach_recursive_mnt(old_nd.mnt, &parent_nd);
+	spin_unlock(&vfsmount_lock);
+	if ((err = attach_recursive_mnt(old_nd.mnt, nd, 1))) {
+		spin_lock(&vfsmount_lock);
+		undo_detach_recursive_mnt(old_nd.mnt, &parent_nd);
+		goto out2;
+	}
+	spin_lock(&vfsmount_lock);
+	mntput(old_nd.mnt);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old_nd.mnt->mnt_expire);
       out2:
@@ -1675,10 +1764,18 @@ asmlinkage long sys_pivot_root(const cha
 	error = -EINVAL;
 	if (user_nd.mnt->mnt_root != user_nd.dentry)
 		goto out2;	/* not a mountpoint */
 	if (new_nd.mnt->mnt_root != new_nd.dentry)
 		goto out2;	/* not a mountpoint */
+	/*
+	 * Don't move a mount in a shared parent.
+	 */
+	if (user_nd.mnt->mnt_parent && IS_MNT_SHARED(user_nd.mnt->mnt_parent))
+		goto out2;
+	if (new_nd.mnt->mnt_parent && IS_MNT_SHARED(new_nd.mnt->mnt_parent))
+		goto out2;
+
 	tmp = old_nd.mnt;	/* make sure we can reach put_old from new_root */
 	spin_lock(&vfsmount_lock);
 	if (tmp != new_nd.mnt) {
 		for (;;) {
 			if (tmp->mnt_parent == tmp)
@@ -1689,14 +1786,34 @@ asmlinkage long sys_pivot_root(const cha
 		}
 		if (!is_subdir(tmp->mnt_mountpoint, new_nd.dentry))
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
-	detach_mnt(new_nd.mnt, &parent_nd);
-	detach_mnt(user_nd.mnt, &root_parent);
-	attach_mnt(user_nd.mnt, &old_nd);	/* mount old root on put_old */
-	attach_mnt(new_nd.mnt, &root_parent);	/* mount new_root on / */
+
+	detach_recursive_mnt(user_nd.mnt, &root_parent);
+	detach_recursive_mnt(new_nd.mnt, &parent_nd);
+
+	spin_unlock(&vfsmount_lock);
+	if ((error = attach_recursive_mnt(new_nd.mnt, &root_parent, 1))) {
+		spin_lock(&vfsmount_lock);
+		undo_detach_recursive_mnt(new_nd.mnt, &parent_nd);
+		undo_detach_recursive_mnt(user_nd.mnt, &root_parent);
+		goto out3;
+	}
+	spin_lock(&vfsmount_lock);
+	mntput(new_nd.mnt);
+
+	spin_unlock(&vfsmount_lock);
+	if ((error = attach_recursive_mnt(user_nd.mnt, &old_nd, 1))) {
+		spin_lock(&vfsmount_lock);
+		undo_detach_recursive_mnt(new_nd.mnt, &parent_nd);
+		undo_detach_recursive_mnt(user_nd.mnt, &root_parent);
+		goto out3;
+	}
+	spin_lock(&vfsmount_lock);
+	mntput(user_nd.mnt);
+
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
 	error = 0;
 	path_release(&root_parent);
