Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVGHKuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVGHKuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVGHKsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:48:32 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52420 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262453AbVGHKZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:25:59 -0400
Subject: [RFC PATCH 4/8] move a shared/private/slave/unclone tree
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120816521.30164.22.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120816355.30164.16.camel@localhost>
	 <1120816436.30164.19.camel@localhost> <1120816521.30164.22.camel@localhost>
Content-Type: multipart/mixed; boundary="=-BCjYK5dVHgL1QFGnWdIY"
Organization: IBM 
Message-Id: <1120817640.30164.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:25:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BCjYK5dVHgL1QFGnWdIY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Adds ability to move a shared/private/slave/unclone tree to any other
shared/private/slave/unclone tree. Also incorporates the same behavior
for pivot_root()

RP


--=-BCjYK5dVHgL1QFGnWdIY
Content-Disposition: attachment; filename=move.patch
Content-Type: text/x-patch; name=move.patch
Content-Transfer-Encoding: 7bit

Adds ability to move a shared/private/slave/unclone tree to any other
shared/private/slave/unclone tree. Also incorporates the same behavior
for pivot_root()

RP


Signed by Ram Pai (linuxram@us.ibm.com)

 namespace.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 94 insertions(+), 12 deletions(-)

Index: 2.6.12/fs/namespace.c
===================================================================
--- 2.6.12.orig/fs/namespace.c
+++ 2.6.12/fs/namespace.c
@@ -656,9 +656,12 @@ static struct vfsmount *copy_tree(struct
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
@@ -691,6 +694,34 @@ static struct vfsmount *copy_tree(struct
  * (+)  the mount will be propogated to the destination vfsmount
  *    	  and the new mount will be added to the source vfsmount's pnode.
  *
+ *  -----------------------------------------------------------------------------
+ *  |				MOVE MOUNT SEMANTICS				|
+ *  |***************************************************************************|
+ *  |  dest --> | shared	 |	private	     |   slave	    |unclonable	|
+ *  | source   	|		 |       	     |   	    |    	|
+ *  |   |   	|		 |       	     |   	    |    	|
+ *  |   v 	|		 |       	     |   	    |    	|
+ *  |***************************************************************************|
+ *  |	     	|		 |       	     |   	    |    	|
+ *  | shared 	| shared (++) 	 |      shared (+)   | shared (+)   | shared (+)|
+ *  |		|		 |       	     |   	    |    	|
+ *  |		|		 |       	     |   	    |    	|
+ *  | private	| shared (+)	 |      private	     | private 	    | private  	|
+ *  |		|		 |       	     |   	    |    	|
+ *  |		|		 |       	     |   	    |    	|
+ *  | slave	| shared (+++)	 |      slave        | slave   	    | slave    	|
+ *  |		|		 |       	     |   	    |    	|
+ *  |		|		 |       	     |   	    |    	|
+ *  | unclonable| unclonable	 |     unclonable    | unclonable   | unclonable|
+ *  |		|		 |       	     |   	    |    	|
+ *  |		|		 |       	     |   	    |    	|
+ *  |***************************************************************************|
+ *
+ * (+++)  the mount will be propogated to all the vfsmounts in the pnode tree
+ *    	  of the destination vfsmount, and all the new mounts will be
+ *    	  added to a new pnode , which will be a slave pnode of the
+ *    	  source vfsmount's pnode.
+ *
  * if the source mount is a tree, the operations explained above is applied to each
  * vfsmount in the tree.
  *
@@ -699,7 +730,7 @@ static struct vfsmount *copy_tree(struct
  *
   */
 static void
-attach_recursive_mnt(struct vfsmount *source_mnt, struct nameidata *nd)
+attach_recursive_mnt(struct vfsmount *source_mnt, struct nameidata *nd, int move)
 {
 	struct vfsmount *mntpt_mnt, *m, *p;
 	struct vfspnode *src_pnode, *t_p, *dest_pnode, *tmp_pnode;
@@ -729,6 +760,7 @@ attach_recursive_mnt(struct vfsmount *so
 	p = NULL;
 	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
 		int unclone = IS_MNT_UNCLONABLE(m);
+		int slave = IS_MNT_SLAVE(m);
 
 		list_del_init(&m->mnt_list);
 
@@ -747,7 +779,7 @@ attach_recursive_mnt(struct vfsmount *so
 		p=m;
 		dest_pnode = IS_MNT_SHARED(mntpt_mnt) ?
 			mntpt_mnt->mnt_pnode : NULL;
-		src_pnode = (IS_MNT_SHARED(m))?
+		src_pnode = (IS_MNT_SHARED(m) || (move && dest_pnode && slave))?
 				m->mnt_pnode : NULL;
 
 		m->mnt_pnode = NULL;
@@ -766,14 +798,20 @@ attach_recursive_mnt(struct vfsmount *so
 			if (m == m->mnt_parent)
 				do_attach_prepare_mnt(mntpt_mnt,
 					mntpt_dentry, m, 0);
-			pnode_add_member_mnt(tmp_pnode, m);
-			if (unclone)
-				SET_MNT_UNCLONABLE(m);
+			if (move && slave)
+				pnode_add_slave_mnt(tmp_pnode, m);
+			else {
+				pnode_add_member_mnt(tmp_pnode, m);
+				if (unclone)
+					SET_MNT_UNCLONABLE(m);
+			}
 		}
 
 		if ((!src_pnode && !dest_pnode) || unclone)
 			SET_PNODE_DELETE(tmp_pnode);
 		tmp_pnode->pnode_master = src_pnode;
+		if (move && dest_pnode && slave)
+			SET_PNODE_SLAVE(tmp_pnode);
 		/*
 		 * temporarily track the pnode with which the tmp_pnode
 		 * has to merge with; in the pnode_master field.
@@ -787,12 +825,16 @@ attach_recursive_mnt(struct vfsmount *so
 	spin_lock(&vfsmount_lock);
 	list_for_each_entry_safe(tmp_pnode, t_p, &pnodehead, pnode_peer_slave) {
 		int del_flag = IS_PNODE_DELETE(tmp_pnode);
+		int slave_flag = IS_PNODE_SLAVE(tmp_pnode);
 		struct vfspnode *master_pnode = tmp_pnode->pnode_master;
 		list_del_init(&tmp_pnode->pnode_peer_slave);
 		pnode_real_mount(tmp_pnode, del_flag);
 		if (!del_flag && master_pnode) {
 			tmp_pnode->pnode_master = NULL;
-			pnode_merge_pnode(tmp_pnode, master_pnode);
+			if (slave_flag)
+				pnode_add_slave_pnode(master_pnode, tmp_pnode);
+			else
+				pnode_merge_pnode(tmp_pnode, master_pnode);
 			/*
 			 * we don't need the extra reference to
 			 * the master_pnode, that was created either
@@ -809,6 +851,18 @@ out:
 	return;
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
@@ -835,7 +889,7 @@ static int graft_tree(struct vfsmount *m
 	ret = (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry));
 	spin_unlock(&vfsmount_lock);
 	if (ret) {
-		attach_recursive_mnt(mnt, nd);
+		attach_recursive_mnt(mnt, nd, 0);
 		err = 0;
 	}
 out_unlock:
@@ -1195,6 +1249,12 @@ static int do_move_mount(struct nameidat
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
@@ -1202,8 +1262,14 @@ static int do_move_mount(struct nameidat
 			goto out2;
 	err = 0;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
+	detach_recursive_mnt(old_nd.mnt, &parent_nd);
+	if(IS_MNT_SHARED(nd->mnt)) {
+		spin_unlock(&vfsmount_lock);
+		attach_recursive_mnt(old_nd.mnt, nd, 1);
+		spin_lock(&vfsmount_lock);
+		mntput(old_nd.mnt);
+	} else
+		attach_mnt(old_nd.mnt, nd);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
@@ -1794,6 +1860,16 @@ asmlinkage long sys_pivot_root(const cha
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
@@ -1808,10 +1884,22 @@ asmlinkage long sys_pivot_root(const cha
 			goto out3;
 	} else if (!is_subdir(old_nd.dentry, new_nd.dentry))
 		goto out3;
-	detach_mnt(new_nd.mnt, &parent_nd);
-	detach_mnt(user_nd.mnt, &root_parent);
-	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
-	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
+	detach_recursive_mnt(new_nd.mnt, &parent_nd);
+	detach_recursive_mnt(user_nd.mnt, &root_parent);
+ 	if(IS_MNT_SHARED(old_nd.mnt)) {
+		spin_unlock(&vfsmount_lock);
+ 		attach_recursive_mnt(user_nd.mnt, &old_nd, 1);
+		spin_lock(&vfsmount_lock);
+ 		mntput(user_nd.mnt);
+	} else
+ 		attach_mnt(user_nd.mnt, &old_nd);
+ 	if(IS_MNT_SHARED(root_parent.mnt)) {
+		spin_unlock(&vfsmount_lock);
+ 		attach_recursive_mnt(new_nd.mnt, &root_parent, 1);
+		spin_lock(&vfsmount_lock);
+ 		mntput(new_nd.mnt);
+	} else
+ 		attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);

--=-BCjYK5dVHgL1QFGnWdIY--

