Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVGRHTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVGRHTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVGRHHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:07:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29576 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261558AbVGRHHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:10 -0400
Message-Id: <20050718070701.693484000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:15 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 4/8] shared subtree
Content-Type: text/x-patch; name=move.patch
Content-Disposition: inline; filename=move.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds ability to move a shared/private/slave/unclone tree to any other
shared/private/slave/unclone tree. Also incorporates the same behavior
for pivot_root()

RP


Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c |  150 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 125 insertions(+), 25 deletions(-)

Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
@@ -664,9 +664,12 @@ static struct vfsmount *copy_tree(struct
 	return NULL;
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
@@ -699,16 +702,44 @@ static struct vfsmount *copy_tree(struct
  * (+)  the mount will be propogated to the destination vfsmount
  *    	  and the new mount will be added to the source vfsmount's pnode.
  *
+ *
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
+ *  | unclonable| unclonable	|     unclonable |unclonable| unclonable|
+ *  |		|		|       	 |   	    |    	|
+ *  |		|		|       	 |   	    |    	|
+ *   ********************************************************************
+ *
+ * (+++)  the mount will be propogated to all the vfsmounts in the pnode tree
+ *    	  of the destination vfsmount, and all the new mounts will be
+ *    	  added to a new pnode , which will be a slave pnode of the
+ *    	  source vfsmount's pnode.
+ *
  * if the source mount is a tree, the operations explained above is
- * applied to each
- * vfsmount in the tree.
+ * applied to each vfsmount in the tree.
  *
  * Should be called without spinlocks held, because this function can sleep
  * in allocations.
  *
   */
 static int attach_recursive_mnt(struct vfsmount *source_mnt,
-		struct nameidata *nd)
+		struct nameidata *nd, int move)
 {
 	struct vfsmount *mntpt_mnt, *m, *p;
 	struct vfspnode *src_pnode, *t_p, *dest_pnode, *tmp_pnode;
@@ -718,7 +749,9 @@ static int attach_recursive_mnt(struct v
 
 	mntpt_mnt = nd->mnt;
 	dest_pnode = IS_MNT_SHARED(mntpt_mnt) ? mntpt_mnt->mnt_pnode : NULL;
-	src_pnode = IS_MNT_SHARED(source_mnt) ? source_mnt->mnt_pnode : NULL;
+	src_pnode = IS_MNT_SHARED(source_mnt) ||
+		(move && IS_MNT_SLAVE(source_mnt)) ?
+		source_mnt->mnt_pnode : NULL;
 
 	if (!dest_pnode && !src_pnode) {
 		LIST_HEAD(head);
@@ -739,6 +772,7 @@ static int attach_recursive_mnt(struct v
 	p = NULL;
 	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
 		int unclone = IS_MNT_UNCLONE(m);
+		int slave = IS_MNT_SLAVE(m);
 
 		list_del_init(&m->mnt_list);
 
@@ -756,7 +790,7 @@ static int attach_recursive_mnt(struct v
 		p=m;
 		dest_pnode = IS_MNT_SHARED(mntpt_mnt) ?
 			mntpt_mnt->mnt_pnode : NULL;
-		src_pnode = (IS_MNT_SHARED(m))?
+		src_pnode = (IS_MNT_SHARED(m) || (move && slave))?
 				m->mnt_pnode : NULL;
 
 		m->mnt_pnode = NULL;
@@ -772,19 +806,35 @@ static int attach_recursive_mnt(struct v
 			if ((ret = pnode_prepare_mount(dest_pnode, tmp_pnode,
 					mntpt_dentry, m, mntpt_mnt)))
 				return ret;
+			if (move && dest_pnode && slave)
+				SET_PNODE_SLAVE(tmp_pnode);
 		} else {
 			if (m == m->mnt_parent)
 				do_attach_prepare_mnt(mntpt_mnt,
 					mntpt_dentry, m, 0);
-			pnode_add_member_mnt(tmp_pnode, m);
-			if (unclone) {
-				set_mnt_unclone(m);
-				m->mnt_pnode = tmp_pnode;
-				SET_PNODE_DELETE(tmp_pnode);
-			} else if (!src_pnode) {
-				set_mnt_private(m);
-				m->mnt_pnode = tmp_pnode;
-				SET_PNODE_DELETE(tmp_pnode);
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
+				/*
+				 * NOTE: set_mnt_private() or
+				 * set_mnt_unclone() resets the
+				 * m->mnt_pnode information.
+				 * reinitialize it.  This is needed to
+				 * decrement the refcount on the
+				 * pnode when * the mount 'm' is
+				 * unlinked in * pnode_real_mount().
+				 */
 			}
 			/*
 			 * NOTE: set_mnt_private() or
@@ -809,19 +859,29 @@ static int attach_recursive_mnt(struct v
 	 * new mounts. Merge or delete or slave the temporary pnode
 	 */
 	spin_lock(&vfsmount_lock);
-	list_for_each_entry_safe(tmp_pnode, t_p, &pnodehead, pnode_peer_slave) {
+	list_for_each_entry_safe(tmp_pnode, t_p, &pnodehead,
+			pnode_peer_slave) {
+
 		int del_flag = IS_PNODE_DELETE(tmp_pnode);
+		int slave_flag = IS_PNODE_SLAVE(tmp_pnode);
 		struct vfspnode *master_pnode = tmp_pnode->pnode_master;
+
 		list_del_init(&tmp_pnode->pnode_peer_slave);
 		pnode_real_mount(tmp_pnode, del_flag);
+
 		if (!del_flag && master_pnode) {
 			tmp_pnode->pnode_master = NULL;
-			pnode_merge_pnode(tmp_pnode, master_pnode);
+
+			if (slave_flag)
+				pnode_add_slave_pnode(master_pnode, tmp_pnode);
+			else
+				pnode_merge_pnode(tmp_pnode, master_pnode);
+
 			/*
 			 * we don't need the extra reference to
 			 * the master_pnode, that was created either
-			 * (a) pnode_add_slave_pnode: when the mnt was made as
-			 * 		a slave mnt.
+			 * (a) pnode_add_slave_pnode: when the mnt
+			 * 	was made as a slave mnt.
 			 * (b) pnode_merge_pnode: during clone_mnt().
 			 */
 			put_pnode(master_pnode);
@@ -833,6 +893,18 @@ out:
 	return 0;
 }
 
+static void
+detach_recursive_mnt(struct vfsmount *source_mnt, struct nameidata *nd)
+{
+	struct vfsmount *m;
+
+	detach_mnt(source_mnt, nd);
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		list_del_init(&m->mnt_pnode_mntlist);
+	}
+	return;
+}
+
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
 	int err, ret;
@@ -859,7 +931,7 @@ static int graft_tree(struct vfsmount *m
 	ret = (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry));
 	spin_unlock(&vfsmount_lock);
 	if (ret)
-		err = attach_recursive_mnt(mnt, nd);
+		err = attach_recursive_mnt(mnt, nd, 0);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
@@ -1256,6 +1328,12 @@ static int do_move_mount(struct nameidat
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
 	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
 		goto out2;
+	/*
+	 * Don't move a mount in a shared parent.
+	 */
+	if(old_nd.mnt->mnt_parent &&
+		IS_MNT_SHARED(old_nd.mnt->mnt_parent))
+		goto out2;
 
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
@@ -1263,8 +1341,11 @@ static int do_move_mount(struct nameidat
 			goto out2;
 	err = 0;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
+	detach_recursive_mnt(old_nd.mnt, &parent_nd);
+	spin_unlock(&vfsmount_lock);
+	err = attach_recursive_mnt(old_nd.mnt, nd, 1);
+	spin_lock(&vfsmount_lock);
+	mntput(old_nd.mnt);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
@@ -1855,6 +1936,16 @@ asmlinkage long sys_pivot_root(const cha
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
@@ -1869,10 +1960,19 @@ asmlinkage long sys_pivot_root(const cha
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
-	detach_mnt(new_nd.mnt, &parent_nd);
-	detach_mnt(user_nd.mnt, &root_parent);
-	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
-	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
+	detach_recursive_mnt(new_nd.mnt, &parent_nd);
+	detach_recursive_mnt(user_nd.mnt, &root_parent);
+
+	spin_unlock(&vfsmount_lock);
+ 	error = attach_recursive_mnt(user_nd.mnt, &old_nd, 1);
+	spin_lock(&vfsmount_lock);
+ 	mntput(user_nd.mnt);
+
+	spin_unlock(&vfsmount_lock);
+ 	error = attach_recursive_mnt(new_nd.mnt, &root_parent, 1);
+	spin_lock(&vfsmount_lock);
+ 	mntput(new_nd.mnt);
+
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
