Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbVKHCEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbVKHCEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbVKHCBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22477 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965168AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 16/18] handling of slave mounts
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001F7-Bu@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131402061 -0500

Makes bind, rbind, move, clone namespace and umount operations aware of the
semantics of slave mount (see Documentation/sharedsubtree.txt in the
last patch of the series for detailed description).

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   77 ++++++++++++++++++++++++++++++++++-------------------
 fs/pnode.c     |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 121 insertions(+), 37 deletions(-)

e2568e82f9fa6e6b8caa7e333a60ebd8af26606e
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -227,8 +227,17 @@ static struct vfsmount *clone_mnt(struct
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
 
-		if ((flag & CL_PROPAGATION) || IS_MNT_SHARED(old))
-			list_add(&mnt->mnt_share, &old->mnt_share);
+		if (flag & CL_SLAVE) {
+			list_add(&mnt->mnt_slave, &old->mnt_slave_list);
+			mnt->mnt_master = old;
+			CLEAR_MNT_SHARED(mnt);
+		} else {
+			if ((flag & CL_PROPAGATION) || IS_MNT_SHARED(old))
+				list_add(&mnt->mnt_share, &old->mnt_share);
+			if (IS_MNT_SLAVE(old))
+				list_add(&mnt->mnt_slave, &old->mnt_slave);
+			mnt->mnt_master = old->mnt_master;
+		}
 		if (flag & CL_MAKE_SHARED)
 			set_mnt_shared(mnt);
 
@@ -689,18 +698,18 @@ Enomem:
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
- * 	---------------------------------------------
- * 	|         BIND MOUNT OPERATION              |
- * 	|********************************************
- * 	| source-->| shared        |       private  |
- * 	| dest     |               |                |
- * 	|   |      |               |                |
- * 	|   v      |               |                |
- * 	|********************************************
- * 	|  shared  | shared (++)   |     shared (+) |
- * 	|          |               |                |
- * 	|non-shared| shared (+)    |      private   |
- * 	*********************************************
+ * 	-------------------------------------------------------------
+ * 	|         BIND MOUNT OPERATION                               |
+ * 	|*************************************************************
+ * 	| source-->| shared        |       private  |       slave    |
+ * 	| dest     |               |                |                |
+ * 	|   |      |               |                |                |
+ * 	|   v      |               |                |                |
+ * 	|*************************************************************
+ * 	|  shared  | shared (++)   |     shared (+) |     shared(+++)|
+ * 	|          |               |                |                |
+ * 	|non-shared| shared (+)    |      private   |      slave (*) |
+ * 	**************************************************************
  * A bind operation clones the source mount and mounts the clone on the
  * destination mount.
  *
@@ -710,21 +719,33 @@ Enomem:
  * (+)   the cloned mount is created under the destination mount and is marked
  *       as shared. The cloned mount is added to the peer group of the source
  *       mount.
- * 	---------------------------------------------
- * 	|         	MOVE MOUNT OPERATION        |
- * 	|********************************************
- * 	| source-->| shared        |       private  |
- * 	| dest     |               |                |
- * 	|   |      |               |                |
- * 	|   v      |               |                |
- * 	|********************************************
- * 	|  shared  | shared (+)    |     shared (+) |
- * 	|          |               |                |
- * 	|non-shared| shared (+*)   |      private   |
- * 	*********************************************
- * (+)  the mount is moved to the destination. And is then propagated to all
- * 	the mounts in the propagation tree of the destination mount.
+ * (+++) the mount is propagated to all the mounts in the propagation tree
+ *       of the destination mount and the cloned mount is made slave
+ *       of the same master as that of the source mount. The cloned mount
+ *       is marked as 'shared and slave'.
+ * (*)   the cloned mount is made a slave of the same master as that of the
+ * 	 source mount.
+ *
+ * 	--------------------------------------------------------------
+ * 	|         		MOVE MOUNT OPERATION                 |
+ * 	|*************************************************************
+ * 	| source-->| shared        |       private  |       slave    |
+ * 	| dest     |               |                |                |
+ * 	|   |      |               |                |                |
+ * 	|   v      |               |                |                |
+ * 	|*************************************************************
+ * 	|  shared  | shared (+)    |     shared (+) |    shared(+++) |
+ * 	|          |               |                |                |
+ * 	|non-shared| shared (+*)   |      private   |    slave (*)   |
+ * 	**************************************************************
+ *
+ * (+)  the mount is moved to the destination. And is then propagated to
+ * 	all the mounts in the propagation tree of the destination mount.
  * (+*)  the mount is moved to the destination.
+ * (+++)  the mount is moved to the destination and is then propagated to
+ * 	all the mounts belonging to the destination mount's propagation tree.
+ * 	the mount is marked as 'shared and slave'.
+ * (*)	the mount continues to be a slave at the new location.
  *
  * if the source mount is a tree, the operations explained above is
  * applied to each mount in the tree.
diff --git a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -17,6 +17,16 @@ static inline struct vfsmount *next_peer
 	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
 }
 
+static inline struct vfsmount *first_slave(struct vfsmount *p)
+{
+	return list_entry(p->mnt_slave_list.next, struct vfsmount, mnt_slave);
+}
+
+static inline struct vfsmount *next_slave(struct vfsmount *p)
+{
+	return list_entry(p->mnt_slave.next, struct vfsmount, mnt_slave);
+}
+
 static int do_make_slave(struct vfsmount *mnt)
 {
 	struct vfsmount *peer_mnt = mnt, *master = mnt->mnt_master;
@@ -83,10 +93,64 @@ void change_mnt_propagation(struct vfsmo
 static struct vfsmount *propagation_next(struct vfsmount *m,
 					 struct vfsmount *origin)
 {
-	m = next_peer(m);
-	if (m == origin)
-		return NULL;
-	return m;
+	/* are there any slaves of this mount? */
+	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
+		return first_slave(m);
+
+	while (1) {
+		struct vfsmount *next;
+		struct vfsmount *master = m->mnt_master;
+
+		if ( master == origin->mnt_master ) {
+			next = next_peer(m);
+			return ((next == origin) ? NULL : next);
+		} else if (m->mnt_slave.next != &master->mnt_slave_list)
+			return next_slave(m);
+
+		/* back at master */
+		m = master;
+	}
+}
+
+/*
+ * return the source mount to be used for cloning
+ *
+ * @dest 	the current destination mount
+ * @last_dest  	the last seen destination mount
+ * @last_src  	the last seen source mount
+ * @type	return CL_SLAVE if the new mount has to be
+ * 		cloned as a slave.
+ */
+static struct vfsmount *get_source(struct vfsmount *dest,
+					struct vfsmount *last_dest,
+					struct vfsmount *last_src,
+					int *type)
+{
+	struct vfsmount *p_last_src = NULL;
+	struct vfsmount *p_last_dest = NULL;
+	*type = CL_PROPAGATION;;
+
+	if (IS_MNT_SHARED(dest))
+		*type |= CL_MAKE_SHARED;
+
+	while (last_dest != dest->mnt_master) {
+		p_last_dest = last_dest;
+		p_last_src = last_src;
+		last_dest = last_dest->mnt_master;
+		last_src = last_src->mnt_master;
+	}
+
+	if (p_last_dest) {
+		do {
+			p_last_dest = next_peer(p_last_dest);
+		} while (IS_MNT_NEW(p_last_dest));
+	}
+
+	if (dest != p_last_dest) {
+		*type |= CL_SLAVE;
+		return last_src;
+	} else
+		return p_last_src;
 }
 
 /*
@@ -114,16 +178,15 @@ int propagate_mnt(struct vfsmount *dest_
 
 	for (m = propagation_next(dest_mnt, dest_mnt); m;
 			m = propagation_next(m, dest_mnt)) {
-		int type = CL_PROPAGATION;
+		int type;
+		struct vfsmount *source;
 
 		if (IS_MNT_NEW(m))
 			continue;
 
-		if (IS_MNT_SHARED(m))
-			type |= CL_MAKE_SHARED;
+		source =  get_source(m, prev_dest_mnt, prev_src_mnt, &type);
 
-		if (!(child = copy_tree(source_mnt, source_mnt->mnt_root,
-						type))) {
+		if (!(child = copy_tree(source, source->mnt_root, type))) {
 			ret = -ENOMEM;
 			list_splice(tree_list, tmp_list.prev);
 			goto out;
