Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVGYW77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVGYW77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGYW7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:59:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:31616 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261168AbVGYW7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:59:24 -0400
Message-Id: <20050725225908.220780000@localhost>
References: <20050725224417.501066000@localhost>
Date: Mon, 25 Jul 2005 15:44:21 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Avantika Mathur <mathurav@us.ibm.com>, Mike Waychison <mike@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

, miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] shared subtree
Content-Type: text/x-patch; name=move.patch
Content-Disposition: inline; filename=move.patch

Adds ability to move a shared/private/slave/unclone tree to any other
shared/private/slave/unclone tree. Also incorporates the same behavior
for pivot_root()

RP


Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |  196 +++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/mount.h |    2 
 2 files changed, 173 insertions(+), 25 deletions(-)

Index: 2.6.12.work2/fs/namespace.c
===================================================================
--- 2.6.12.work2.orig/fs/namespace.c
+++ 2.6.12.work2/fs/namespace.c
@@ -772,9 +772,12 @@ static void abort_attach_recursive_mnt(s
 	list_del_init(head);
 }
 
+
  /*
  *  @source_mnt : mount tree to be attached
  *  @nd		: place the mount tree @source_mnt is attached
+ *  @move	: use the move semantics if set, else use normal attach semantics
+ *                as explained below
  *
  *  NOTE: in the table below explains the semantics when a source vfsmount
  *  of a given type is attached to a destination vfsmount of a give type.
@@ -801,12 +804,41 @@ static void abort_attach_recursive_mnt(s
  *  |		|		|       	 |   	    |    	|
  *   ********************************************************************
  *
- * (++)  the mount will be propogated to all the vfsmounts in the pnode tree
+ * (++)  the mount is propogated to all the vfsmounts in the pnode tree
  *    	  of the destination vfsmount, and all the non-slave new mounts in
  *    	  destination vfsmount will be added the source vfsmount's pnode.
- * (+)  the mount will be propogated to the destination vfsmount
+ * (+)  the mount is propogated to the destination vfsmount
  *    	  and the new mount will be added to the source vfsmount's pnode.
  *
+ *  ---------------------------------------------------------------------
+ *  |				MOVE MOUNT OPERATION			|
+ *  |*******************************************************************|
+ *  |  dest --> | shared	|	private	 |  slave   |unclonable	|
+ *  | source	|		|       	 |   	    |    	|
+ *  |   |   	|		|       	 |   	    |    	|
+ *  |   v 	|		|       	 |   	    |    	|
+ *  |*******************************************************************|
+ *  |	     	|		|       	 |   	    |    	|
+ *  |  shared	| shared (++) 	|      shared (+)|shared (+)| shared (+)|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *  | private	| shared (+)	|      private	 | private  | private  	|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *  | slave	| shared (+++)	|      slave     | slave    | slave  	|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *  | unclonable|  invalid	|     unclonable |unclonable| unclonable|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *   ********************************************************************
+ *
+ * (+++)  the mount is propogated to all the vfsmounts in the pnode tree
+ *    	  of the destination vfsmount, and all the new mounts is
+ *    	  added to a new pnode , which is a slave pnode of the
+ *    	  source vfsmount's pnode.
+ *
+ *
  * if the source mount is a tree, the operations explained above is
  * applied to each vfsmount in the tree.
  *
@@ -815,7 +847,7 @@ static void abort_attach_recursive_mnt(s
  *
   */
 static int attach_recursive_mnt(struct vfsmount *source_mnt,
-		struct nameidata *nd)
+		struct nameidata *nd, int move)
 {
 	struct vfsmount *mntpt_mnt, *last, *m, *p;
 	struct vfspnode *src_pnode, *dest_pnode, *tmp_pnode;
@@ -849,8 +881,8 @@ static int attach_recursive_mnt(struct v
 	list_add_tail(&mnt_list_head, &source_mnt->mnt_list);
 
 	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
-
-		BUG_ON(IS_MNT_UNCLONE(m));
+		int unclone = IS_MNT_UNCLONE(m);
+		int slave = IS_MNT_SLAVE(m);
 
 		while (p && p != m->mnt_parent)
 			p = p->mnt_parent;
@@ -866,7 +898,7 @@ static int attach_recursive_mnt(struct v
 
 		dest_pnode = IS_MNT_SHARED(mntpt_mnt) ?
 			mntpt_mnt->mnt_pnode : NULL;
-		src_pnode = (IS_MNT_SHARED(m))?
+		src_pnode = (IS_MNT_SHARED(m) || (move && slave))?
 				m->mnt_pnode : NULL;
 
 		/*
@@ -882,7 +914,7 @@ static int attach_recursive_mnt(struct v
 		list_del_init(&m->mnt_list);
 		list_add_tail(&tmp_pnode->pnode_peer_slave, &pnodehead);
 
-		if (dest_pnode) {
+		if (dest_pnode && !unclone) {
 			if ((ret = pnode_prepare_mount(dest_pnode, tmp_pnode,
 					mntpt_dentry, m, mntpt_mnt))) {
 				tmp_pnode->pnode_master = src_pnode;
@@ -890,23 +922,33 @@ static int attach_recursive_mnt(struct v
 				last = m;
 				goto error;
 			}
+			if (move && dest_pnode && slave)
+ 				SET_PNODE_SLAVE(tmp_pnode);
 		} else {
 			if (m == m->mnt_parent)
 				do_attach_prepare_mnt(mntpt_mnt,
 					mntpt_dentry, m, 0);
-			pnode_add_member_mnt(tmp_pnode, m);
-			if (!src_pnode) {
-				set_mnt_private(m);
+			if (move && slave)
+				pnode_add_slave_mnt(tmp_pnode, m);
+			else {
+				pnode_add_member_mnt(tmp_pnode, m);
+				if (unclone) {
+					BUG_ON(!move);
+					set_mnt_unclone(m);
+					m->mnt_pnode = tmp_pnode;
+					SET_PNODE_DELETE(tmp_pnode);
+				} else if (!src_pnode) {
+					set_mnt_private(m);
+					m->mnt_pnode = tmp_pnode;
+					SET_PNODE_DELETE(tmp_pnode);
+				}
 				/*
-				 * NOTE: set_mnt_private()
-				 * resets m->mnt_pnode.
-				 * Reinitialize it. This is needed to
-				 * decrement the refcount on the
-				 * pnode when the mount 'm' is
-				 * unlinked in pnode_commit_mount().
+				 * NOTE: set_mnt_private() & set_mnt_unclone()
+				 * resets m->mnt_pnode. Hence reinitialize it.
+				 * We need this to decrement the refcount
+				 * on the pnode when the mount 'm' is
+				 * unlinked in pnode_commit_mount()
 				 */
-				m->mnt_pnode = tmp_pnode;
-				SET_PNODE_DELETE(tmp_pnode);
 			}
 		}
 
@@ -931,6 +973,46 @@ error:
 	return 1;
 }
 
+static void
+detach_recursive_mnt(struct vfsmount *source_mnt, struct nameidata *nd)
+{
+	struct vfsmount *m;
+
+	detach_mnt(source_mnt, nd);
+	spin_lock(&vfspnode_lock);
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		list_del_init(&m->mnt_pnode_mntlist);
+		list_del_init(&m->mnt_list);
+		if (m != source_mnt)
+			list_add_tail(&m->mnt_list, &source_mnt->mnt_list);
+	}
+	spin_unlock(&vfspnode_lock);
+}
+
+static void
+undo_detach_recursive_mnt(struct vfsmount *mnt, struct nameidata *nd)
+{
+	struct vfsmount *m;
+	LIST_HEAD(head);
+
+	spin_lock(&vfspnode_lock);
+	for (m = mnt; m; m = next_mnt(m, mnt)) {
+		if (m->mnt_pnode) {
+			if (IS_MNT_SHARED(m))
+				list_add(&m->mnt_pnode_mntlist,
+					&m->mnt_pnode->pnode_vfs);
+			if (IS_MNT_SLAVE(m))
+				list_add(&m->mnt_pnode_mntlist,
+					&m->mnt_pnode->pnode_slavevfs);
+		}
+	}
+	attach_mnt(mnt, nd);
+	spin_unlock(&vfspnode_lock);
+
+	list_add_tail(&head, &mnt->mnt_list);
+	list_splice(&head, nd->mnt->mnt_namespace->list.prev);
+}
+
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
 	int err, ret;
@@ -957,7 +1039,7 @@ static int graft_tree(struct vfsmount *m
 	ret = (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry));
 	spin_unlock(&vfsmount_lock);
 	if (ret)
-		err = attach_recursive_mnt(mnt, nd);
+		err = attach_recursive_mnt(mnt, nd, 0);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
@@ -1311,6 +1393,19 @@ static int do_remount(struct nameidata *
 	return err;
 }
 
+/*
+ * return 1 if the mount tree contains a unclonable mount
+ */
+static inline int tree_contains_unclone(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		if (IS_MNT_UNCLONE(p))
+			return 1;
+	}
+	return 0;
+}
+
 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
 	struct nameidata old_nd, parent_nd;
@@ -1351,14 +1446,35 @@ static int do_move_mount(struct nameidat
 	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
 		goto out2;
 
+	/*
+	 * Don't move a mount in a shared parent.
+	 */
+	if (old_nd.mnt->mnt_parent &&
+		IS_MNT_SHARED(old_nd.mnt->mnt_parent))
+		goto out2;
+
+	/*
+	 * Don't move a mount tree having unclonable
+	 * mounts, under a shared mount
+	 */
+	if (IS_MNT_SHARED(nd->mnt) &&
+		tree_contains_unclone(old_nd.mnt))
+		goto out2;
+
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
 		if (p == old_nd.mnt)
 			goto out2;
 	err = 0;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
+	detach_recursive_mnt(old_nd.mnt, &parent_nd);
+	spin_unlock(&vfsmount_lock);
+	if ((err = attach_recursive_mnt(old_nd.mnt, nd, 1))) {
+		undo_detach_recursive_mnt(old_nd.mnt, &parent_nd);
+		goto out1;
+	}
+	spin_lock(&vfsmount_lock);
+	mntput(old_nd.mnt);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
@@ -1949,6 +2065,16 @@ asmlinkage long sys_pivot_root(const cha
 		goto out2; /* not a mountpoint */
 	if (new_nd.mnt->mnt_root != new_nd.dentry)
 		goto out2; /* not a mountpoint */
+	/*
+	 * Don't move a mount in a shared parent.
+	 */
+	if(user_nd.mnt->mnt_parent &&
+		IS_MNT_SHARED(user_nd.mnt->mnt_parent))
+		goto out2;
+	if(new_nd.mnt->mnt_parent &&
+		IS_MNT_SHARED(new_nd.mnt->mnt_parent))
+		goto out2;
+
 	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
 	spin_lock(&vfsmount_lock);
 	if (tmp != new_nd.mnt) {
@@ -1963,10 +2089,30 @@ asmlinkage long sys_pivot_root(const cha
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
-	detach_mnt(new_nd.mnt, &parent_nd);
-	detach_mnt(user_nd.mnt, &root_parent);
-	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
-	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
+
+	detach_recursive_mnt(user_nd.mnt, &root_parent);
+	detach_recursive_mnt(new_nd.mnt, &parent_nd);
+
+	spin_unlock(&vfsmount_lock);
+ 	if ((error = attach_recursive_mnt(user_nd.mnt, &old_nd, 1))) {
+		spin_lock(&vfsmount_lock);
+		undo_detach_recursive_mnt(new_nd.mnt, &parent_nd);
+		undo_detach_recursive_mnt(user_nd.mnt, &root_parent);
+		goto out3;
+	}
+	spin_lock(&vfsmount_lock);
+ 	mntput(user_nd.mnt);
+
+	spin_unlock(&vfsmount_lock);
+ 	if ((error = attach_recursive_mnt(new_nd.mnt, &root_parent, 1))) {
+		spin_lock(&vfsmount_lock);
+		undo_detach_recursive_mnt(new_nd.mnt, &parent_nd);
+		undo_detach_recursive_mnt(user_nd.mnt, &root_parent);
+		goto out3;
+	}
+	spin_lock(&vfsmount_lock);
+ 	mntput(new_nd.mnt);
+
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
Index: 2.6.12.work2/include/linux/mount.h
===================================================================
--- 2.6.12.work2.orig/include/linux/mount.h
+++ 2.6.12.work2/include/linux/mount.h
@@ -29,6 +29,8 @@
 #define IS_MNT_SLAVE(mnt) (mnt->mnt_flags & MNT_SLAVE)
 #define IS_MNT_PRIVATE(mnt) (mnt->mnt_flags & MNT_PRIVATE)
 #define IS_MNT_UNCLONE(mnt) (mnt->mnt_flags & MNT_UNCLONE)
+#define GET_MNT_TYPE(mnt) (mnt->mnt_flags & MNT_PNODE_MASK)
+#define SET_MNT_TYPE(mnt, type) (mnt->mnt_flags |= (type & MNT_PNODE_MASK))
 
 #define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
 #define CLEAR_MNT_PRIVATE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_PRIVATE))
