Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVKHCCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVKHCCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVKHCB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24781 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965183AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 8/18] mount expiry fixes
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Er-9H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401842 -0500

1) cleans up the ugliness in may_umount_tree()

2) fixes a bug in do_loopback(). after cloning a tree, do_loopback() unlinks
only the topmost mount of the cloned tree, leaving behind the children mounts
on their corresponding expiry list.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   64 +++++++++++++++++++-------------------------------------
 1 files changed, 22 insertions(+), 42 deletions(-)

dff96a6036a64c1cc16161d622db76239d4172b5
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -27,6 +27,8 @@
 
 extern int __init init_rootfs(void);
 
+#define CL_EXPIRE 	0x01
+
 #ifdef CONFIG_SYSFS
 extern int __init sysfs_init(void);
 #else
@@ -165,7 +167,8 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
+static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root,
+					int flag)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
@@ -181,10 +184,12 @@ static struct vfsmount *clone_mnt(struct
 
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */
-		spin_lock(&vfsmount_lock);
-		if (!list_empty(&old->mnt_expire))
-			list_add(&mnt->mnt_expire, &old->mnt_expire);
-		spin_unlock(&vfsmount_lock);
+		if (flag & CL_EXPIRE) {
+			spin_lock(&vfsmount_lock);
+			if (!list_empty(&old->mnt_expire))
+				list_add(&mnt->mnt_expire, &old->mnt_expire);
+			spin_unlock(&vfsmount_lock);
+		}
 	}
 	return mnt;
 }
@@ -331,36 +336,14 @@ struct seq_operations mounts_op = {
  */
 int may_umount_tree(struct vfsmount *mnt)
 {
-	struct list_head *next;
-	struct vfsmount *this_parent = mnt;
-	int actual_refs;
-	int minimum_refs;
+	int actual_refs = 0;
+	int minimum_refs = 0;
+	struct vfsmount *p;
 
 	spin_lock(&vfsmount_lock);
-	actual_refs = atomic_read(&mnt->mnt_count);
-	minimum_refs = 2;
-repeat:
-	next = this_parent->mnt_mounts.next;
-resume:
-	while (next != &this_parent->mnt_mounts) {
-		struct vfsmount *p =
-		    list_entry(next, struct vfsmount, mnt_child);
-
-		next = next->next;
-
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		actual_refs += atomic_read(&p->mnt_count);
 		minimum_refs += 2;
-
-		if (!list_empty(&p->mnt_mounts)) {
-			this_parent = p;
-			goto repeat;
-		}
-	}
-
-	if (this_parent != mnt) {
-		next = this_parent->mnt_child.next;
-		this_parent = this_parent->mnt_parent;
-		goto resume;
 	}
 	spin_unlock(&vfsmount_lock);
 
@@ -596,12 +579,13 @@ static int lives_below_in_same_fs(struct
 	}
 }
 
-static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
+static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry,
+					int flag)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct nameidata nd;
 
-	res = q = clone_mnt(mnt, dentry);
+	res = q = clone_mnt(mnt, dentry, flag);
 	if (!q)
 		goto Enomem;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
@@ -619,7 +603,7 @@ static struct vfsmount *copy_tree(struct
 			p = s;
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
-			q = clone_mnt(p, p->mnt_root);
+			q = clone_mnt(p, p->mnt_root, flag);
 			if (!q)
 				goto Enomem;
 			spin_lock(&vfsmount_lock);
@@ -701,18 +685,13 @@ static int do_loopback(struct nameidata 
 
 	err = -ENOMEM;
 	if (recurse)
-		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry, 0);
 	else
-		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry, 0);
 
 	if (!mnt)
 		goto out;
 
-	/* stop bind mounts from expiring */
-	spin_lock(&vfsmount_lock);
-	list_del_init(&mnt->mnt_expire);
-	spin_unlock(&vfsmount_lock);
-
 	err = graft_tree(mnt, nd);
 	if (err) {
 		LIST_HEAD(umount_list);
@@ -1155,7 +1134,8 @@ int copy_namespace(int flags, struct tas
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
-	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
+	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root,
+					CL_EXPIRE);
 	if (!new_ns->root) {
 		up_write(&tsk->namespace->sem);
 		kfree(new_ns);
