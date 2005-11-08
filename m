Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVKHCEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVKHCEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVKHCBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29133 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965255AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 12/18] shared mount handling: bind and rbind
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401990 -0500

Handling of MS_BIND in presense of shared mounts (see
Documentation/sharedsubtree.txt in the end of patch series
for detailed description).

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c     |  126 +++++++++++++++++++++++++++++++++++++++++++---------
 fs/pnode.c         |   81 +++++++++++++++++++++++++++++++++
 fs/pnode.h         |   14 ++++++
 include/linux/fs.h |    5 ++
 4 files changed, 204 insertions(+), 22 deletions(-)

61916467f11424161a197c5aab53a6bb79619911
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -28,8 +28,6 @@
 
 extern int __init init_rootfs(void);
 
-#define CL_EXPIRE 	0x01
-
 #ifdef CONFIG_SYSFS
 extern int __init sysfs_init(void);
 #else
@@ -145,13 +143,43 @@ static void detach_mnt(struct vfsmount *
 	old_nd->dentry->d_mounted--;
 }
 
+void mnt_set_mountpoint(struct vfsmount *mnt, struct dentry *dentry,
+			struct vfsmount *child_mnt)
+{
+	child_mnt->mnt_parent = mntget(mnt);
+	child_mnt->mnt_mountpoint = dget(dentry);
+	dentry->d_mounted++;
+}
+
 static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
 {
-	mnt->mnt_parent = mntget(nd->mnt);
-	mnt->mnt_mountpoint = dget(nd->dentry);
-	list_add(&mnt->mnt_hash, mount_hashtable + hash(nd->mnt, nd->dentry));
+	mnt_set_mountpoint(nd->mnt, nd->dentry, mnt);
+	list_add_tail(&mnt->mnt_hash, mount_hashtable +
+			hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
-	nd->dentry->d_mounted++;
+}
+
+/*
+ * the caller must hold vfsmount_lock
+ */
+static void commit_tree(struct vfsmount *mnt)
+{
+	struct vfsmount *parent = mnt->mnt_parent;
+	struct vfsmount *m;
+	LIST_HEAD(head);
+	struct namespace *n = parent->mnt_namespace;
+
+	BUG_ON(parent == mnt);
+
+	list_add_tail(&head, &mnt->mnt_list);
+	list_for_each_entry(m, &head, mnt_list)
+		m->mnt_namespace = n;
+	list_splice(&head, n->list.prev);
+
+	list_add_tail(&mnt->mnt_hash, mount_hashtable +
+				hash(parent, mnt->mnt_mountpoint));
+	list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
+	touch_namespace(n);
 }
 
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
@@ -183,7 +211,11 @@ static struct vfsmount *clone_mnt(struct
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
-		mnt->mnt_namespace = current->namespace;
+
+		if ((flag & CL_PROPAGATION) || IS_MNT_SHARED(old))
+			list_add(&mnt->mnt_share, &old->mnt_share);
+		if (flag & CL_MAKE_SHARED)
+			set_mnt_shared(mnt);
 
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */
@@ -379,7 +411,7 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void release_mounts(struct list_head *head)
+void release_mounts(struct list_head *head)
 {
 	struct vfsmount *mnt;
 	while(!list_empty(head)) {
@@ -401,7 +433,7 @@ static void release_mounts(struct list_h
 	}
 }
 
-static void umount_tree(struct vfsmount *mnt, struct list_head *kill)
+void umount_tree(struct vfsmount *mnt, struct list_head *kill)
 {
 	struct vfsmount *p;
 
@@ -581,7 +613,7 @@ static int lives_below_in_same_fs(struct
 	}
 }
 
-static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry,
+struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry,
 					int flag)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
@@ -626,6 +658,67 @@ Enomem:
 	return NULL;
 }
 
+/*
+ *  @source_mnt : mount tree to be attached
+ *  @nd        : place the mount tree @source_mnt is attached
+ *
+ *  NOTE: in the table below explains the semantics when a source mount
+ *  of a given type is attached to a destination mount of a given type.
+ * 	---------------------------------------------
+ * 	|         BIND MOUNT OPERATION              |
+ * 	|********************************************
+ * 	| source-->| shared        |       private  |
+ * 	| dest     |               |                |
+ * 	|   |      |               |                |
+ * 	|   v      |               |                |
+ * 	|********************************************
+ * 	|  shared  | shared (++)   |     shared (+) |
+ * 	|          |               |                |
+ * 	|non-shared| shared (+)    |      private   |
+ * 	*********************************************
+ * A bind operation clones the source mount and mounts the clone on the
+ * destination mount.
+ *
+ * (++)  the cloned mount is propagated to all the mounts in the propagation
+ * 	 tree of the destination mount and the cloned mount is added to
+ * 	 the peer group of the source mount.
+ * (+)   the cloned mount is created under the destination mount and is marked
+ *       as shared. The cloned mount is added to the peer group of the source
+ *       mount.
+ *
+ * if the source mount is a tree, the operations explained above is
+ * applied to each mount in the tree.
+ * Must be called without spinlocks held, since this function can sleep
+ * in allocations.
+ */
+static int attach_recursive_mnt(struct vfsmount *source_mnt,
+				struct nameidata *nd)
+{
+	LIST_HEAD(tree_list);
+	struct vfsmount *dest_mnt = nd->mnt;
+	struct dentry *dest_dentry = nd->dentry;
+	struct vfsmount *child, *p;
+
+	if (propagate_mnt(dest_mnt, dest_dentry, source_mnt, &tree_list))
+		return -EINVAL;
+
+	if (IS_MNT_SHARED(dest_mnt)) {
+		for (p = source_mnt; p; p = next_mnt(p, source_mnt))
+			set_mnt_shared(p);
+	}
+
+	spin_lock(&vfsmount_lock);
+	mnt_set_mountpoint(dest_mnt, dest_dentry, source_mnt);
+	commit_tree(source_mnt);
+
+	list_for_each_entry_safe(child, p, &tree_list, mnt_hash) {
+		list_del_init(&child->mnt_hash);
+		commit_tree(child);
+	}
+	spin_unlock(&vfsmount_lock);
+	return 0;
+}
+
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
 	int err;
@@ -646,17 +739,8 @@ static int graft_tree(struct vfsmount *m
 		goto out_unlock;
 
 	err = -ENOENT;
-	spin_lock(&vfsmount_lock);
-	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
-		struct list_head head;
-
-		attach_mnt(mnt, nd);
-		list_add_tail(&head, &mnt->mnt_list);
-		list_splice(&head, current->namespace->list.prev);
-		err = 0;
-		touch_namespace(current->namespace);
-	}
-	spin_unlock(&vfsmount_lock);
+	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry))
+		err = attach_recursive_mnt(mnt, nd);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
diff --git a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -20,9 +20,88 @@ static inline struct vfsmount *next_peer
 void change_mnt_propagation(struct vfsmount *mnt, int type)
 {
 	if (type == MS_SHARED) {
-		mnt->mnt_flags |= MNT_SHARED;
+		set_mnt_shared(mnt);
 	} else {
 		list_del_init(&mnt->mnt_share);
 		mnt->mnt_flags &= ~MNT_PNODE_MASK;
 	}
 }
+
+/*
+ * get the next mount in the propagation tree.
+ * @m: the mount seen last
+ * @origin: the original mount from where the tree walk initiated
+ */
+static struct vfsmount *propagation_next(struct vfsmount *m,
+					 struct vfsmount *origin)
+{
+	m = next_peer(m);
+	if (m == origin)
+		return NULL;
+	return m;
+}
+
+/*
+ * mount 'source_mnt' under the destination 'dest_mnt' at
+ * dentry 'dest_dentry'. And propagate that mount to
+ * all the peer and slave mounts of 'dest_mnt'.
+ * Link all the new mounts into a propagation tree headed at
+ * source_mnt. Also link all the new mounts using ->mnt_list
+ * headed at source_mnt's ->mnt_list
+ *
+ * @dest_mnt: destination mount.
+ * @dest_dentry: destination dentry.
+ * @source_mnt: source mount.
+ * @tree_list : list of heads of trees to be attached.
+ */
+int propagate_mnt(struct vfsmount *dest_mnt, struct dentry *dest_dentry,
+		    struct vfsmount *source_mnt, struct list_head *tree_list)
+{
+	struct vfsmount *m, *child;
+	int ret = 0;
+	struct vfsmount *prev_dest_mnt = dest_mnt;
+	struct vfsmount *prev_src_mnt  = source_mnt;
+	LIST_HEAD(tmp_list);
+	LIST_HEAD(umount_list);
+
+	for (m = propagation_next(dest_mnt, dest_mnt); m;
+			m = propagation_next(m, dest_mnt)) {
+		int type = CL_PROPAGATION;
+
+		if (IS_MNT_NEW(m))
+			continue;
+
+		if (IS_MNT_SHARED(m))
+			type |= CL_MAKE_SHARED;
+
+		if (!(child = copy_tree(source_mnt, source_mnt->mnt_root,
+						type))) {
+			ret = -ENOMEM;
+			list_splice(tree_list, tmp_list.prev);
+			goto out;
+		}
+
+		if (is_subdir(dest_dentry, m->mnt_root)) {
+			mnt_set_mountpoint(m, dest_dentry, child);
+			list_add_tail(&child->mnt_hash, tree_list);
+		} else {
+			/*
+			 * This can happen if the parent mount was bind mounted
+			 * on some subdirectory of a shared/slave mount.
+			 */
+			list_add_tail(&child->mnt_hash, &tmp_list);
+		}
+		prev_dest_mnt = m;
+		prev_src_mnt  = child;
+	}
+out:
+	spin_lock(&vfsmount_lock);
+	while (!list_empty(&tmp_list)) {
+		child = list_entry(tmp_list.next, struct vfsmount, mnt_hash);
+		list_del_init(&child->mnt_hash);
+		umount_tree(child, &umount_list);
+	}
+	spin_unlock(&vfsmount_lock);
+	release_mounts(&umount_list);
+	return ret;
+}
diff --git a/fs/pnode.h b/fs/pnode.h
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -12,7 +12,21 @@
 #include <linux/mount.h>
 
 #define IS_MNT_SHARED(mnt) (mnt->mnt_flags & MNT_SHARED)
+#define IS_MNT_NEW(mnt)  (!mnt->mnt_namespace)
 #define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~MNT_SHARED)
 
+#define CL_EXPIRE    		0x01
+#define CL_COPY_ALL 		0x04
+#define CL_MAKE_SHARED 		0x08
+#define CL_PROPAGATION 		0x10
+
+static inline void set_mnt_shared(struct vfsmount *mnt)
+{
+	mnt->mnt_flags &= ~MNT_PNODE_MASK;
+	mnt->mnt_flags |= MNT_SHARED;
+}
+
 void change_mnt_propagation(struct vfsmount *, int);
+int propagate_mnt(struct vfsmount *, struct dentry *, struct vfsmount *,
+		struct list_head *);
 #endif /* _LINUX_PNODE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1251,7 +1251,12 @@ extern int unregister_filesystem(struct 
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
+extern void umount_tree(struct vfsmount *, struct list_head *);
+extern void release_mounts(struct list_head *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
+extern struct vfsmount *copy_tree(struct vfsmount *, struct dentry *, int);
+extern void mnt_set_mountpoint(struct vfsmount *, struct dentry *,
+				  struct vfsmount *);
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
