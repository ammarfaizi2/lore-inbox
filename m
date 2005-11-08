Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVKHCGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVKHCGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVKHCBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25805 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965211AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 17/18] unbindable mounts
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001F9-CG@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131402080 -0500

A unbindable mount does not forward or receive propagation. Also unbindable
mount disallows bind mounts. The semantics is as follows.

Bind semantics:
  Its invalid to bind mount a unbindable mount.
Move semantics:
  Its invalid to move a unbindable mount under shared mount.
Clone-namespace semantics:
  If a mount is unbindable in the parent namespace, the corresponding
  cloned mount in the child namespace becomes unbindable too.  Note:
  there is subtle difference, unbindable mounts cannot be bind mounted
  but can be cloned during clone-namespace.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c        |   88 +++++++++++++++++++++++++++++++++++--------------
 fs/pnode.c            |    2 +
 fs/pnode.h            |    1 +
 include/linux/fs.h    |    1 +
 include/linux/mount.h |    1 +
 5 files changed, 67 insertions(+), 26 deletions(-)

364b3bec7df6c05b99f2f898ddf52821b0d6e42f
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -213,6 +213,16 @@ static struct vfsmount *next_mnt(struct 
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
+static struct vfsmount *skip_mnt_tree(struct vfsmount *p)
+{
+	struct list_head *prev = p->mnt_mounts.prev;
+	while (prev != &p->mnt_mounts) {
+		p = list_entry(prev, struct vfsmount, mnt_child);
+		prev = p->mnt_mounts.prev;
+	}
+	return p;
+}
+
 static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root,
 					int flag)
 {
@@ -650,6 +660,9 @@ struct vfsmount *copy_tree(struct vfsmou
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct nameidata nd;
 
+	if (!(flag & CL_COPY_ALL) && IS_MNT_UNBINDABLE(mnt))
+		return NULL;
+
 	res = q = clone_mnt(mnt, dentry, flag);
 	if (!q)
 		goto Enomem;
@@ -661,6 +674,10 @@ struct vfsmount *copy_tree(struct vfsmou
 			continue;
 
 		for (s = r; s; s = next_mnt(s, r)) {
+			if (!(flag & CL_COPY_ALL) && IS_MNT_UNBINDABLE(s)) {
+				s = skip_mnt_tree(s);
+				continue;
+			}
 			while (p != s->mnt_parent) {
 				p = p->mnt_parent;
 				q = q->mnt_parent;
@@ -698,18 +715,18 @@ Enomem:
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
- * 	-------------------------------------------------------------
- * 	|         BIND MOUNT OPERATION                               |
- * 	|*************************************************************
- * 	| source-->| shared        |       private  |       slave    |
- * 	| dest     |               |                |                |
- * 	|   |      |               |                |                |
- * 	|   v      |               |                |                |
- * 	|*************************************************************
- * 	|  shared  | shared (++)   |     shared (+) |     shared(+++)|
- * 	|          |               |                |                |
- * 	|non-shared| shared (+)    |      private   |      slave (*) |
- * 	**************************************************************
+ * ---------------------------------------------------------------------------
+ * |         BIND MOUNT OPERATION                                            |
+ * |**************************************************************************
+ * | source-->| shared        |       private  |       slave    | unbindable |
+ * | dest     |               |                |                |            |
+ * |   |      |               |                |                |            |
+ * |   v      |               |                |                |            |
+ * |**************************************************************************
+ * |  shared  | shared (++)   |     shared (+) |     shared(+++)|  invalid   |
+ * |          |               |                |                |            |
+ * |non-shared| shared (+)    |      private   |      slave (*) |  invalid   |
+ * ***************************************************************************
  * A bind operation clones the source mount and mounts the clone on the
  * destination mount.
  *
@@ -726,18 +743,18 @@ Enomem:
  * (*)   the cloned mount is made a slave of the same master as that of the
  * 	 source mount.
  *
- * 	--------------------------------------------------------------
- * 	|         		MOVE MOUNT OPERATION                 |
- * 	|*************************************************************
- * 	| source-->| shared        |       private  |       slave    |
- * 	| dest     |               |                |                |
- * 	|   |      |               |                |                |
- * 	|   v      |               |                |                |
- * 	|*************************************************************
- * 	|  shared  | shared (+)    |     shared (+) |    shared(+++) |
- * 	|          |               |                |                |
- * 	|non-shared| shared (+*)   |      private   |    slave (*)   |
- * 	**************************************************************
+ * ---------------------------------------------------------------------------
+ * |         		MOVE MOUNT OPERATION                                 |
+ * |**************************************************************************
+ * | source-->| shared        |       private  |       slave    | unbindable |
+ * | dest     |               |                |                |            |
+ * |   |      |               |                |                |            |
+ * |   v      |               |                |                |            |
+ * |**************************************************************************
+ * |  shared  | shared (+)    |     shared (+) |    shared(+++) |  invalid   |
+ * |          |               |                |                |            |
+ * |non-shared| shared (+*)   |      private   |    slave (*)   | unbindable |
+ * ***************************************************************************
  *
  * (+)  the mount is moved to the destination. And is then propagated to
  * 	all the mounts in the propagation tree of the destination mount.
@@ -854,6 +871,9 @@ static int do_loopback(struct nameidata 
 
 	down_write(&namespace_sem);
 	err = -EINVAL;
+	if (IS_MNT_UNBINDABLE(old_nd.mnt))
+ 		goto out;
+
 	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
 		goto out;
 
@@ -911,6 +931,16 @@ static int do_remount(struct nameidata *
 	return err;
 }
 
+static inline int tree_contains_unbindable(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		if (IS_MNT_UNBINDABLE(p))
+			return 1;
+	}
+	return 0;
+}
+
 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
 	struct nameidata old_nd, parent_nd;
@@ -954,6 +984,12 @@ static int do_move_mount(struct nameidat
 	 */
 	if (old_nd.mnt->mnt_parent && IS_MNT_SHARED(old_nd.mnt->mnt_parent))
 		goto out1;
+	/*
+	 * Don't move a mount tree containing unbindable mounts to a destination
+	 * mount which is shared.
+	 */
+	if (IS_MNT_SHARED(nd->mnt) && tree_contains_unbindable(old_nd.mnt))
+		goto out1;
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent != p; p = p->mnt_parent)
 		if (p == old_nd.mnt)
@@ -1266,7 +1302,7 @@ long do_mount(char *dev_name, char *dir_
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE))
+	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
@@ -1311,7 +1347,7 @@ int copy_namespace(int flags, struct tas
 	down_write(&namespace_sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root,
-					CL_EXPIRE);
+					CL_COPY_ALL | CL_EXPIRE);
 	if (!new_ns->root) {
 		up_write(&namespace_sem);
 		kfree(new_ns);
diff --git a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -82,6 +82,8 @@ void change_mnt_propagation(struct vfsmo
 	if (type != MS_SLAVE) {
 		list_del_init(&mnt->mnt_slave);
 		mnt->mnt_master = NULL;
+		if (type == MS_UNBINDABLE)
+			mnt->mnt_flags |= MNT_UNBINDABLE;
 	}
 }
 
diff --git a/fs/pnode.h b/fs/pnode.h
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -15,6 +15,7 @@
 #define IS_MNT_SLAVE(mnt) (mnt->mnt_master)
 #define IS_MNT_NEW(mnt)  (!mnt->mnt_namespace)
 #define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~MNT_SHARED)
+#define IS_MNT_UNBINDABLE(mnt) (mnt->mnt_flags & MNT_UNBINDABLE)
 
 #define CL_EXPIRE    		0x01
 #define CL_SLAVE     		0x02
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -104,6 +104,7 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
diff --git a/include/linux/mount.h b/include/linux/mount.h
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -21,6 +21,7 @@
 #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
 #define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
+#define MNT_UNBINDABLE	0x20	/* if the vfsmount is a unbindable mount */
 #define MNT_PNODE_MASK	0x30	/* propogation flag mask */
 
 struct vfsmount {
