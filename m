Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVKHCDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVKHCDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVKHCB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28109 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965246AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 13/18] shared mounts handling: move
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001F1-Aj@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131402003 -0500

Handling of mount --move in presense of shared mounts (see
Documentation/sharedsubtree.txt in the end of patch series
for detailed description).

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   63 +++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 46 insertions(+), 17 deletions(-)

f530c48214f7fd8ff91d6d8c245373438be97ce2
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -660,7 +660,10 @@ Enomem:
 
 /*
  *  @source_mnt : mount tree to be attached
- *  @nd        : place the mount tree @source_mnt is attached
+ *  @nd         : place the mount tree @source_mnt is attached
+ *  @parent_nd  : if non-null, detach the source_mnt from its parent and
+ *  		   store the parent mount and mountpoint dentry.
+ *  		   (done when source_mnt is moved)
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
@@ -685,6 +688,21 @@ Enomem:
  * (+)   the cloned mount is created under the destination mount and is marked
  *       as shared. The cloned mount is added to the peer group of the source
  *       mount.
+ * 	---------------------------------------------
+ * 	|         	MOVE MOUNT OPERATION        |
+ * 	|********************************************
+ * 	| source-->| shared        |       private  |
+ * 	| dest     |               |                |
+ * 	|   |      |               |                |
+ * 	|   v      |               |                |
+ * 	|********************************************
+ * 	|  shared  | shared (+)    |     shared (+) |
+ * 	|          |               |                |
+ * 	|non-shared| shared (+*)   |      private   |
+ * 	*********************************************
+ * (+)  the mount is moved to the destination. And is then propagated to all
+ * 	the mounts in the propagation tree of the destination mount.
+ * (+*)  the mount is moved to the destination.
  *
  * if the source mount is a tree, the operations explained above is
  * applied to each mount in the tree.
@@ -692,7 +710,7 @@ Enomem:
  * in allocations.
  */
 static int attach_recursive_mnt(struct vfsmount *source_mnt,
-				struct nameidata *nd)
+			struct nameidata *nd, struct nameidata *parent_nd)
 {
 	LIST_HEAD(tree_list);
 	struct vfsmount *dest_mnt = nd->mnt;
@@ -708,8 +726,14 @@ static int attach_recursive_mnt(struct v
 	}
 
 	spin_lock(&vfsmount_lock);
-	mnt_set_mountpoint(dest_mnt, dest_dentry, source_mnt);
-	commit_tree(source_mnt);
+	if (parent_nd) {
+		detach_mnt(source_mnt, parent_nd);
+		attach_mnt(source_mnt, nd);
+		touch_namespace(current->namespace);
+	} else {
+		mnt_set_mountpoint(dest_mnt, dest_dentry, source_mnt);
+		commit_tree(source_mnt);
+	}
 
 	list_for_each_entry_safe(child, p, &tree_list, mnt_hash) {
 		list_del_init(&child->mnt_hash);
@@ -740,7 +764,7 @@ static int graft_tree(struct vfsmount *m
 
 	err = -ENOENT;
 	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry))
-		err = attach_recursive_mnt(mnt, nd);
+		err = attach_recursive_mnt(mnt, nd, NULL);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
@@ -869,35 +893,36 @@ static int do_move_mount(struct nameidat
 	if (IS_DEADDIR(nd->dentry->d_inode))
 		goto out1;
 
-	spin_lock(&vfsmount_lock);
 	if (!IS_ROOT(nd->dentry) && d_unhashed(nd->dentry))
-		goto out2;
+		goto out1;
 
 	err = -EINVAL;
 	if (old_nd.dentry != old_nd.mnt->mnt_root)
-		goto out2;
+		goto out1;
 
 	if (old_nd.mnt == old_nd.mnt->mnt_parent)
-		goto out2;
+		goto out1;
 
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
 	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
-		goto out2;
-
+		goto out1;
+	/*
+	 * Don't move a mount residing in a shared parent.
+	 */
+	if (old_nd.mnt->mnt_parent && IS_MNT_SHARED(old_nd.mnt->mnt_parent))
+		goto out1;
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent != p; p = p->mnt_parent)
 		if (p == old_nd.mnt)
-			goto out2;
-	err = 0;
+			goto out1;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
-	touch_namespace(current->namespace);
+	if ((err = attach_recursive_mnt(old_nd.mnt, nd, &parent_nd)))
+		goto out1;
 
+	spin_lock(&vfsmount_lock);
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old_nd.mnt->mnt_expire);
-out2:
 	spin_unlock(&vfsmount_lock);
 out1:
 	up(&nd->dentry->d_inode->i_sem);
@@ -1467,6 +1492,10 @@ asmlinkage long sys_pivot_root(const cha
 	down_write(&namespace_sem);
 	down(&old_nd.dentry->d_inode->i_sem);
 	error = -EINVAL;
+	if (IS_MNT_SHARED(old_nd.mnt) ||
+		IS_MNT_SHARED(new_nd.mnt->mnt_parent) ||
+		IS_MNT_SHARED(user_nd.mnt->mnt_parent))
+		goto out2;
 	if (!check_mnt(user_nd.mnt))
 		goto out2;
 	error = -ENOENT;
