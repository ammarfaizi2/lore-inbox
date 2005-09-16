Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbVIPS0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbVIPS0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbVIPS0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:26:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59070 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161230AbVIPS0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:26:24 -0400
Date: Fri, 16 Sep 2005 11:26:19 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 5/10] vfs: shared subtree aware bind mounts 
Message-ID: <20050916182619.GA28489@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that help bind/rbind a mount tree. The tree can contain any combination of
shared/slave/private/unclonable mounts.

The semantics of these operations depend on the type of the source mount that
is being bound to, and destination mount under which the new mount is mounted
on. The table below define the semantics.
  --------------------------------------------------------------------
  |                          BIND MOUNT OPERATION                    |
  |******************************************************************|
  | dest --> | shared        |       private  |  slave   |unclonable |
  | source   |               |                |          |           |
  |   |      |               |                |          |           |
  |   v      |               |                |          |           |
  |******************************************************************|
  |          |               |                |          |           |
  |  shared  | shared (++)   |     shared (+*)|shared(+*)|shared (+*)|
  |          |               |                |          |           |
  |          |               |                |          |           |
  | private  | shared (+)    |      private   | private  | private   |
  |          |               |                |          |           |
  |          |               |                |          |           |
  | slave    | shared (+)    |      slave     | slave    | slave     |
  |          |               |                |          |           |
  |          |               |                |          |           |
  |unclonable|     invalid   |       invalid  |  invalid | invalid   |
  |          |               |                |          |           |
  |          |               |                |          |           |
   *******************************************************************
 (++)  the mount is propagated to all the mounts in the pnode tree
       of the destination mount and the source mount is made
       a peer mount of the mount from which it got cloned off.
 (+*)  a new shared mount is created under the destination mount
 (+)   the mount is propagated to the destination mount's
       propagation tree.


Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |  316 ++++++++++++++++++++++++++++++++-
 fs/pnode.c            |  470 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h    |    6 
 include/linux/pnode.h |   11 +
 4 files changed, 775 insertions(+), 28 deletions(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -129,15 +129,48 @@ static void detach_mnt(struct vfsmount *
 
 static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
 {
 	mnt->mnt_parent = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
+	mnt->mnt_namespace = nd->mnt->mnt_namespace;
 	list_add(&mnt->mnt_hash, mount_hashtable + hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
 }
 
+void do_attach_commit_mnt(struct vfsmount *mnt)
+{
+	struct vfsmount *parent = mnt->mnt_parent;
+	BUG_ON(parent == mnt);
+	if (list_empty(&mnt->mnt_hash))
+		list_add_tail(&mnt->mnt_hash,
+			      mount_hashtable + hash(parent,
+						     mnt->mnt_mountpoint));
+	if (list_empty(&mnt->mnt_child))
+		list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
+	if (list_empty(&mnt->mnt_list)) {
+		mnt->mnt_namespace = parent->mnt_namespace;
+		list_add_tail(&mnt->mnt_list, &mnt->mnt_namespace->list);
+	}
+}
+
+void do_attach_prepare_mnt(struct vfsmount *mnt,
+			   struct dentry *dentry, struct vfsmount *child_mnt)
+{
+	child_mnt->mnt_parent = mntget(mnt);
+	child_mnt->mnt_mountpoint = dget(dentry);
+	dentry->d_mounted++;
+}
+
+void do_detach_prepare_mnt(struct vfsmount *mnt)
+{
+	mnt->mnt_mountpoint->d_mounted--;
+	mntput(mnt->mnt_parent);
+	dput(mnt->mnt_mountpoint);
+	mnt->mnt_parent = mnt;
+}
+
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
 {
 	struct list_head *next = p->mnt_mounts.next;
 	if (next == &p->mnt_mounts) {
 		while (1) {
@@ -150,11 +183,21 @@ static struct vfsmount *next_mnt(struct 
 		}
 	}
 	return list_entry(next, struct vfsmount, mnt_child);
 }
 
-static struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
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
+struct vfsmount *clone_mnt(struct vfsmount *old, struct dentry *root)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
 
 	if (mnt) {
@@ -163,10 +206,11 @@ static struct vfsmount *clone_mnt(struct
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
 		mnt->mnt_namespace = current->namespace;
+		mnt->mnt_master = mntget(old);
 
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */
 		spin_lock(&vfsmount_lock);
 		if (!list_empty(&old->mnt_expire))
@@ -174,10 +218,18 @@ static struct vfsmount *clone_mnt(struct
 		spin_unlock(&vfsmount_lock);
 	}
 	return mnt;
 }
 
+static void inline clean_propagation_reference(struct vfsmount *mnt)
+{
+	struct vfsmount *p;
+	for (p = mnt; p; p = next_mnt(p, mnt))
+		if (p->mnt_master)
+			mntput(p->mnt_master);
+}
+
 void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 	dput(mnt->mnt_root);
 	free_vfsmnt(mnt);
@@ -541,10 +593,12 @@ static struct vfsmount *copy_tree(struct
 {
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct list_head *h;
 	struct nameidata nd;
 
+	if (IS_MNT_UNCLONABLE(mnt))
+		return NULL;
 	res = q = clone_mnt(mnt, dentry);
 	if (!q)
 		goto Enomem;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
@@ -553,10 +607,14 @@ static struct vfsmount *copy_tree(struct
 		r = list_entry(h, struct vfsmount, mnt_child);
 		if (!lives_below_in_same_fs(r->mnt_mountpoint, dentry))
 			continue;
 
 		for (s = r; s; s = next_mnt(s, r)) {
+			if (IS_MNT_UNCLONABLE(s)) {
+				s = skip_mnt_tree(s);
+				continue;
+			}
 			while (p != s->mnt_parent) {
 				p = p->mnt_parent;
 				q = q->mnt_parent;
 			}
 			p = s;
@@ -573,16 +631,249 @@ static struct vfsmount *copy_tree(struct
 	}
 	return res;
       Enomem:
 	if (res) {
 		spin_lock(&vfsmount_lock);
+		clean_propagation_reference(res);
 		umount_tree(res);
 		spin_unlock(&vfsmount_lock);
 	}
 	return NULL;
 }
 
+static inline int tree_contains_propagation(struct vfsmount *mnt)
+{
+	struct vfsmount *p, *tmp;
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		if (!(tmp = p->mnt_master))
+			continue;
+		if (IS_MNT_SHARED(tmp) || IS_MNT_SLAVE(tmp))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * commit the operations done in attach_recursive_mnt(). run through pnode list
+ * headed at 'pnodehead', and commit the operation done in
+ * attach_recursive_mnt();
+ */
+static void commit_attach_recursive_mnt(struct vfsmount *source_mnt)
+{
+	struct vfsmount *m, *master, *nextmnt;
+	LIST_HEAD(mnt_list_head);
+	LIST_HEAD(nextmnt_list_head);
+
+	spin_lock(&vfsmount_lock);
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		/*
+		 * note: mount 'm' heads all its propogation peers through the
+		 * 'mnt_list' field.  But the same field 'mnt_list' is needed
+		 * to group togather all the mounts in the mount-tree. Hence
+		 * temporarily delink the propogation peers and accumulate them
+		 * in a different list @nextmnt_list_head.
+		 */
+		if (!list_empty(&m->mnt_list)) {
+			nextmnt = list_entry(m->mnt_list.next,
+					     struct vfsmount, mnt_list);
+			list_del_init(&m->mnt_list);
+			list_add_tail(&nextmnt->mnt_mounts, &nextmnt_list_head);
+		}
+		list_add_tail(&m->mnt_list, &mnt_list_head);
+	}
+
+	while (!list_empty(&mnt_list_head)) {
+		m = list_entry(mnt_list_head.next, struct vfsmount, mnt_list);
+		list_del_init(&m->mnt_list);
+
+		/*
+		 * link back the propagation peers temporarily
+		 * stored in nextmnt_list_head, to 'm'
+		 */
+		if (!list_empty(&nextmnt_list_head)) {
+			nextmnt = list_entry(nextmnt_list_head.next,
+					     struct vfsmount, mnt_mounts);
+			list_del_init(&nextmnt->mnt_mounts);
+			list_add_tail(&m->mnt_list, &nextmnt->mnt_list);
+		}
+
+		spin_lock(&vfspnode_lock);
+		propagate_commit_mount(m);
+		spin_unlock(&vfspnode_lock);
+
+		if ((master = m->mnt_master)) {
+			m->mnt_master = NULL;
+			if (IS_MNT_SHARED(master))
+				pnode_merge_mount(m, master);
+			else if (IS_MNT_SLAVE(master)) {
+				BUG_ON(!master->mnt_master);
+				pnode_slave_mount(m, master);
+			}
+			/*
+			 * release the reference held during clone_mnt()
+			 */
+			mntput(master);
+		}
+	}
+	spin_unlock(&vfsmount_lock);
+}
+
+/*
+ * abort the operations done in attach_recursive_mnt(). run through the mount
+ * tree, till vfsmount 'last' and undo the changes.  Ensure that all the mounts
+ * in the tree are all back in the mnt_list headed at 'source_mnt'.
+ * NOTE: This function is closely tied to the logic in
+ * 'attach_recursive_mnt()'
+ */
+static void abort_attach_recursive_mnt(struct vfsmount *source_mnt, struct
+				       vfsmount *last, struct list_head *head)
+{
+	struct vfsmount *m, *nextmnt;
+	LIST_HEAD(mnt_list_head);
+	LIST_HEAD(nextmnt_list_head);
+	if (!last)
+		return;
+
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		if (!list_empty(&m->mnt_list)) {
+			nextmnt = list_entry(m->mnt_list.next,
+					     struct vfsmount, mnt_list);
+			list_del_init(&m->mnt_list);
+			list_add_tail(&nextmnt->mnt_mounts, &nextmnt_list_head);
+		}
+		list_add(&m->mnt_list, &mnt_list_head);
+		if (m == last)
+			break;
+	}
+
+	while (!list_empty(&mnt_list_head)) {
+		m = list_entry(mnt_list_head.next, struct vfsmount, mnt_list);
+		list_del_init(&m->mnt_list);
+
+		if (!list_empty(&nextmnt_list_head)) {
+			nextmnt = list_entry(nextmnt_list_head.next,
+					     struct vfsmount, mnt_mounts);
+			list_del_init(&nextmnt->mnt_mounts);
+			list_add_tail(&m->mnt_list, &nextmnt->mnt_list);
+		}
+		spin_lock(&vfspnode_lock);
+		propagate_abort_mount(m);
+		spin_unlock(&vfspnode_lock);
+		list_add(&m->mnt_list, head);
+	}
+	do_detach_prepare_mnt(source_mnt);
+	list_del_init(head);
+	return;
+}
+
+/*
+ *  @source_mnt : mount tree to be attached
+ *  @nd                : place the mount tree @source_mnt is attached
+ *  @move      : use the move semantics if set, else use normal attach
+ *             semantics as explained below
+ *
+ *  NOTE: in the table below explains the semantics when a source mount
+ *  of a given type is attached to a destination mount of a given type.
+ *  ---------------------------------------------------------------------
+ *  |                          BIND MOUNT OPERATION                    |
+ *  |******************************************************************|
+ *  | dest --> |  shared       |       private  |  slave   |unclonable |
+ *  | source   |               |                |          |           |
+ *  |   |      |               |                |          |           |
+ *  |   v      |               |                |          |           |
+ *  |******************************************************************|
+ *  |          |               |                |          |           |
+ *  |  shared  | shared (++)   |     shared (+*)|shared(+*)|shared (+*)|
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *  | private  | shared (+)    |      private   | private  | private   |
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *  | slave    | shared (+)    |      slave     | slave    | slave     |
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *  |unclonable|    invalid    |       invalid  |  invalid | invalid   |
+ *  |          |               |                |          |           |
+ *  |          |               |                |          |           |
+ *   ********************************************************************
+ *
+ * (++)  the mount is propagated to all the mounts in the pnode tree
+ *       of the destination mount and the source mount is made
+ *       a peer mount of the mount from which it got cloned off.
+ * (+*)  a new shared mount is created under the destination mount
+ * (+)   the mount is propagated to the destination mount's
+ *       propagation tree.
+ *
+ * if the source mount is a tree, the operations explained above is
+ * applied to each mount in the tree.
+ *
+ * Must be called without spinlocks held, since this function can sleep
+ * in allocations.
+ *
+ */
+static int attach_recursive_mnt(struct vfsmount *source_mnt,
+				struct nameidata *nd)
+{
+	struct vfsmount *dest_mnt, *last, *m, *p;
+	struct dentry *dest_dentry;
+	int ret;
+	LIST_HEAD(mnt_list_head);
+
+	/*
+	 * if the source tree has no shared or slave mounts and
+	 * the destination mount is not shared, fastpath.
+	 */
+	dest_mnt = nd->mnt;
+	if (!IS_MNT_SHARED(dest_mnt) && !tree_contains_propagation(source_mnt)) {
+		spin_lock(&vfsmount_lock);
+		attach_mnt(source_mnt, nd);
+		list_add_tail(&mnt_list_head, &source_mnt->mnt_list);
+		list_splice(&mnt_list_head, dest_mnt->mnt_namespace->list.prev);
+		clean_propagation_reference(source_mnt);
+		spin_unlock(&vfsmount_lock);
+		goto out;
+	}
+
+	p = NULL;
+	last = NULL;
+	list_add_tail(&mnt_list_head, &source_mnt->mnt_list);
+
+	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+
+		BUG_ON(IS_MNT_UNCLONABLE(m));
+
+		while (p && p != m->mnt_parent)
+			p = p->mnt_parent;
+
+		if (!p) {
+			dest_dentry = nd->dentry;
+			dest_mnt = nd->mnt;
+		} else {
+			dest_dentry = m->mnt_mountpoint;
+			dest_mnt = p;
+		}
+		p = m;
+
+		list_del_init(&m->mnt_list);
+		last = m;
+		if ((ret = propagate_prepare_mount(dest_mnt, dest_dentry, m)))
+			goto error;
+	}
+	commit_attach_recursive_mnt(source_mnt);
+      out:
+	mntget(source_mnt);
+	return 0;
+      error:
+	/*
+	 * ok we have errored out either because of memory exhaustion
+	 * or something else not in our control. Gracefully return
+	 * leaving no mess behind. Else it will haunt :(
+	 */
+	abort_attach_recursive_mnt(source_mnt, last, &mnt_list_head);
+	return 1;
+}
+
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
 	int err;
 	if (mnt->mnt_sb->s_flags & MS_NOUSER)
 		return -EINVAL;
@@ -599,21 +890,12 @@ static int graft_tree(struct vfsmount *m
 	err = security_sb_check_sb(mnt, nd);
 	if (err)
 		goto out_unlock;
 
 	err = -ENOENT;
-	spin_lock(&vfsmount_lock);
-	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
-		struct list_head head;
-
-		attach_mnt(mnt, nd);
-		list_add_tail(&head, &mnt->mnt_list);
-		list_splice(&head, current->namespace->list.prev);
-		mntget(mnt);
-		err = 0;
-	}
-	spin_unlock(&vfsmount_lock);
+	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry))
+		err = attach_recursive_mnt(mnt, nd);
       out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
 		security_sb_post_addmount(mnt, nd);
 	return err;
@@ -681,12 +963,16 @@ static int do_loopback(struct nameidata 
 		return -EINVAL;
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
-	down_write(&namespace_sem);
 	err = -EINVAL;
+	if (IS_MNT_UNCLONABLE(old_nd.mnt))
+		goto path_release;
+
+	down_write(&namespace_sem);
+
 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
 		err = -ENOMEM;
 		if (recurse)
 			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
 		else
@@ -700,17 +986,19 @@ static int do_loopback(struct nameidata 
 		spin_unlock(&vfsmount_lock);
 
 		err = graft_tree(mnt, nd);
 		if (err) {
 			spin_lock(&vfsmount_lock);
+			clean_propagation_reference(mnt);
 			umount_tree(mnt);
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
 	}
-
 	up_write(&namespace_sem);
+
+      path_release:
 	path_release(&old_nd);
 	return err;
 }
 
 /*
Index: 2.6.13.sharedsubtree/fs/pnode.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/pnode.c
+++ 2.6.13.sharedsubtree/fs/pnode.c
@@ -39,18 +39,28 @@ static void make_slave_of(struct vfsmoun
 	mnt->mnt_master = master;
 }
 
 static int __do_make_slave(struct vfsmount *mnt)
 {
-	struct vfsmount *peer_mnt, *master = mnt->mnt_master;
-	struct vfsmount *slave_mnt, *t_slave_mnt;
+	struct vfsmount *peer_mnt = mnt, *master = mnt->mnt_master;
+	struct vfsmount *slave_mnt, *t_mnt;
 
-	peer_mnt = next_shared(mnt);
-	if (peer_mnt == mnt)
-		peer_mnt = NULL;
+	/*
+	 * slave 'mnt' to a peer mount that has the
+	 * same root dentry. If none is available than
+	 * slave it to anything that is available.
+	 */
+	while ((peer_mnt = next_shared(peer_mnt)) != mnt &&
+	       peer_mnt->mnt_root != mnt->mnt_root) ;
 
+	if (peer_mnt == mnt) {
+		peer_mnt = next_shared(mnt);
+		if (peer_mnt == mnt)
+			peer_mnt = NULL;
+	}
 	list_del_init(&mnt->mnt_share);
+
 	/*
 	 * first we will attempt to move 'mnt' and its slaves
 	 * under 'peer_mnt'. if that is not possible we will
 	 * try to move them under the 'master'. And if this
 	 * is also not possible than we make them all
@@ -66,11 +76,11 @@ static int __do_make_slave(struct vfsmou
 			make_slave_of(peer_mnt, master);
 		}
 		master = peer_mnt;
 	}
 
-	list_for_each_entry_safe(slave_mnt, t_slave_mnt,
+	list_for_each_entry_safe(slave_mnt, t_mnt,
 				 &mnt->mnt_slave_list, mnt_slave)
 	    make_slave_of(slave_mnt, master);
 
 	make_slave_of(mnt, master);
 	CLEAR_MNT_SHARED(mnt);
@@ -97,39 +107,471 @@ int do_make_slave(struct vfsmount *mnt)
       out:
 	spin_unlock(&vfspnode_lock);
 	return err;
 }
 
+static void __do_make_private(struct vfsmount *mnt)
+{
+	__do_make_slave(mnt);
+	list_del_init(&mnt->mnt_slave);
+	mnt->mnt_master = NULL;
+	set_mnt_private(mnt);
+}
+
 int do_make_private(struct vfsmount *mnt)
 {
 	/*
 	 * a private mount is nothing but a
 	 * slave mount with no incoming
 	 * propagations.
 	 */
 	spin_lock(&vfspnode_lock);
-	__do_make_slave(mnt);
-	list_del_init(&mnt->mnt_slave);
+	__do_make_private(mnt);
 	spin_unlock(&vfspnode_lock);
-	mnt->mnt_master = NULL;
-	set_mnt_private(mnt);
 	return 0;
 }
 
 /*
  * a unclonable mount does not receive and forward
  * propagations and cannot be cloned(bind mounted).
  */
 int do_make_unclonable(struct vfsmount *mnt)
 {
 	/*
-	 * a unclonable mount is nothing but a
+	 * a unclonable mount is a
 	 * private mount which is unclonnable.
 	 */
 	spin_lock(&vfspnode_lock);
-	__do_make_slave(mnt);
-	list_del_init(&mnt->mnt_slave);
+	__do_make_private(mnt);
 	spin_unlock(&vfspnode_lock);
-	mnt->mnt_master = NULL;
 	set_mnt_unclonable(mnt);
 	return 0;
 }
+
+/*
+ * merge 'first' mount and the 'second' into being peers
+ * of the propagation tree.
+ * @first: the source mount
+ * @second: the destination mount
+ */
+void pnode_merge_mount(struct vfsmount *first, struct vfsmount *second)
+{
+	LIST_HEAD(mnt_list_head);
+	spin_lock(&vfspnode_lock);
+	list_add_tail(&mnt_list_head, &first->mnt_share);
+	list_splice(&mnt_list_head, second->mnt_share.prev);
+	spin_unlock(&vfspnode_lock);
+	set_mnt_shared(first);
+	set_mnt_shared(second);
+}
+
+/*
+ * make 'first' mount a slave peer of the 'second' mount.
+ * @first: the source mount
+ * @second: the destination mount
+ */
+void pnode_slave_mount(struct vfsmount *first, struct vfsmount *second)
+{
+	spin_lock(&vfspnode_lock);
+	first->mnt_master = second->mnt_master;
+	list_add(&first->mnt_slave, &second->mnt_slave);
+	spin_unlock(&vfspnode_lock);
+}
+
+static int check_peer(struct vfsmount *start, struct vfsmount *orig)
+{
+	struct vfsmount *m = start;
+	do {
+		m = next_shared(m);
+		if (m == orig)
+			return 1;
+	} while (m != start);
+	return 0;
+}
+
+/*
+ * get the next mount in the propagation tree.
+ * @m: the mount seen last
+ * @origin: the original mount from where the tree walk initiated
+ */
+static struct vfsmount *propagation_next(struct vfsmount *m,
+					 struct vfsmount *origin)
+{
+	/* are there any slaves of this mount? */
+	if (!list_empty(&m->mnt_slave_list))
+		return first_slave(m);
+
+	while (1) {
+		/* get the next mount belonging to the same pnode */
+		m = next_shared(m);
+
+		if (m == origin)
+			break;
+
+		if (!m->mnt_master)
+			return m;
+
+		if (check_peer(m, origin))
+			return m;
+
+		/* more slaves? */
+		if (m->mnt_slave.next != &m->mnt_master->mnt_slave_list)
+			return next_slave(m);
+
+		/* back at master */
+		m = m->mnt_master;
+	}
+	return NULL;
+}
+
+/*
+ * skip the propagation subtree tree rooted at @m
+ */
+static struct vfsmount *skip_propagation_tree(struct vfsmount *m)
+{
+	struct list_head *prev = m->mnt_slave_list.prev;
+	while (prev != &m->mnt_slave_list) {
+		m = list_entry(prev, struct vfsmount, mnt_slave);
+		m = prev_shared(m);
+		prev = m->mnt_slave_list.prev;
+	}
+	return m;
+}
+
+/*
+ * commit the operations done by propagate_prepare_mount()
+ * @mnt: the root of the mount tree.
+ * 'vfspnode_lock' need not be held before calling this function, if the
+ * propogation tree is local to the caller.
+ */
+int propagate_commit_mount(struct vfsmount *mnt)
+{
+	struct vfsmount *m;
+	LIST_HEAD(mnt_list_head);
+
+	list_add_tail(&mnt_list_head, &mnt->mnt_list);
+	while (!list_empty(&mnt_list_head)) {
+		m = list_entry(mnt_list_head.next, struct vfsmount, mnt_list);
+		list_del_init(&m->mnt_list);
+		do_attach_commit_mnt(m);
+
+		if (IS_MNT_SHARED(m->mnt_parent))
+			set_mnt_shared(m);
+		else if (m != mnt)
+			CLEAR_MNT_SHARED(m);
+	}
+
+	return 0;
+}
+
+/*
+ * abort the operations done by propagate_prepare_mount()
+ * @mnt: the root of the mount tree.
+ * vfspnode_lock need not be held before calling this function, if the
+ * propogation tree is local to the caller.
+ */
+int propagate_abort_mount(struct vfsmount *mnt)
+{
+	struct vfsmount *m;
+	LIST_HEAD(mnt_list_head);
+
+	list_add_tail(&mnt_list_head, &mnt->mnt_list);
+	while (!list_empty(&mnt_list_head)) {
+		m = list_entry(mnt_list_head.next, struct vfsmount, mnt_list);
+		list_del_init(&m->mnt_list);
+		do_detach_prepare_mnt(m);
+		BUG_ON(atomic_read(&m->mnt_count) != 1);
+		list_del_init(&m->mnt_share);
+		list_del_init(&m->mnt_slave);
+		mntput(m);
+	}
+	return 0;
+}
+
+/*
+ * return the number of mounts in the propagation tree
+ * starting at @mnt
+ */
+static int propagation_tree_size(struct vfsmount *mnt,
+				 struct dentry *dest_dentry,
+				 int use_propagation_tree)
+{
+	int i = 0;
+	struct vfsmount *m;
+	if (use_propagation_tree) {
+		for (m = mnt; m; m = propagation_next(m, mnt))
+			i++;
+	} else {
+		LIST_HEAD(mnt_list_head);
+		/*
+		 * here we know for sure that we are looping through
+		 * mounts that are yet to be comitted. Hence their
+		 * mnt_list field comes in handy.
+		 */
+		list_add_tail(&mnt_list_head, &mnt->mnt_list);
+		list_for_each_entry(m, &mnt_list_head, mnt_list)
+		    i++;
+		list_del_init(&mnt_list_head);
+	}
+	return i;
+}
+
+/*
+ * release all the mounts held in the list headed
+ * at @head
+ */
+static void free_mnt_list(struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct vfsmount *child = list_entry(head->next,
+						    struct vfsmount, mnt_list);
+		list_del_init(&child->mnt_list);
+		mntput(child);
+	}
+}
+
+/*
+ *  allocate @total number of vfsmount structures and link them
+ *  into a list headed at @list.
+ *  note: @mnt is the first element of the linked list.
+ */
+static int dup_mnt(struct vfsmount *mnt, int total, struct list_head *list)
+{
+	while (total--) {
+		struct vfsmount *child = clone_mnt(mnt, mnt->mnt_root);
+		if (!child)
+			goto child_error;
+		if (child->mnt_master) {
+			mntput(child->mnt_master);
+			child->mnt_master = NULL;
+		}
+		list_add(&child->mnt_list, list);
+	}
+	INIT_LIST_HEAD(&mnt->mnt_list);
+	list_add(&mnt->mnt_list, list);
+	return 0;
+
+      child_error:
+	free_mnt_list(list);
+	return 1;
+}
+
+/*
+ * create a list of children headed at source_mnt.
+ * Take the list of mounts linked togather through mnt_mounts, headed
+ * at @head, and make a new list of the same mounts headed at source_mnt
+ * linked togather through mnt_list.
+ */
+static void create_child_list(struct vfsmount *source_mnt,
+			      struct list_head *head)
+{
+	struct vfsmount *m;
+	INIT_LIST_HEAD(&source_mnt->mnt_list);
+	while (!list_empty(head)) {
+		m = list_entry(head->next, struct vfsmount, mnt_mounts);
+		list_del_init(&m->mnt_mounts);
+		list_add_tail(&m->mnt_list, &source_mnt->mnt_list);
+	}
+}
+
+static struct vfsmount *get_allocated_child(struct list_head *child_list_head)
+{
+	struct vfsmount *child;
+	if (list_empty(child_list_head))
+		return NULL;
+	child = list_entry(child_list_head->next, struct vfsmount, mnt_list);
+	list_del_init(&child->mnt_list);
+	return child;
+}
+
+/*
+ * prepare to attach @child to @m at dentry @dest_dentry.
+ * @root_mnt is the * first mount in parent's propagation tree.
+ * @p contains the last processed child mount.
+ *
+ * NOTE: @slave_list_head keeps track of the child mount that forms the pivot
+ * at each level of the newly constructed child propagation tree. The pivot
+ * child mount links togather all the shared mounts at that level through
+ * ->mnt_share and all slave mounts at that level through ->mnt_slave
+ */
+static void __propagate_prepare_mount(struct vfsmount *m,
+				      struct dentry *dest_dentry,
+				      struct vfsmount *child,
+				      struct vfsmount *p,
+				      struct vfsmount *root_mnt,
+				      struct list_head *slave_list_head)
+{
+	struct vfsmount *c = m;
+	struct vfsmount *pivot;
+	int peer = check_peer(c, root_mnt);
+	/*
+	 * walk 'p' up the tree until it either becomes the master of 'c' or if
+	 * 'c' does not have a master, until it becomes 'c'.  As 'p' is walked
+	 * up the propagation tree through each level, the pivot mount at that
+	 * level is trimmed off the slave_list_head.
+	 */
+	while ((peer && c != root_mnt) || (!peer && !c->mnt_master))
+		c = next_shared(c);
+	while (p && p != c && p != c->mnt_master) {
+		peer = check_peer(p, root_mnt);
+		while ((peer && p != root_mnt) || (!peer && !p->mnt_master))
+			p = next_shared(p);
+		if (p != c)
+			list_del_init(slave_list_head->next);
+		p = p->mnt_master;
+	}
+
+	if ((m != root_mnt) || (child == child->mnt_parent)) {
+		if (is_subdir(dest_dentry, m->mnt_root))
+			do_attach_prepare_mnt(m, dest_dentry, child);
+		else
+			child->mnt_mountpoint = NULL;
+	}
+
+	if ((m == root_mnt) || m->mnt_master) {
+		if (!list_empty(slave_list_head)) {
+			pivot = list_entry(slave_list_head->next,
+					   struct vfsmount, mnt_list);
+			BUG_ON(!pivot);
+			child->mnt_master = pivot;
+			list_add_tail(&child->mnt_slave,
+				      &pivot->mnt_slave_list);
+			if (pivot->mnt_parent->mnt_master == m->mnt_master)
+				list_del_init(slave_list_head->next);
+		}
+	} else {
+		pivot = list_entry(slave_list_head->next, struct vfsmount,
+				   mnt_list);
+		list_add_tail(&child->mnt_share, &pivot->mnt_share);
+		list_del_init(slave_list_head->next);
+	}
+	list_add(&child->mnt_list, slave_list_head);
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
+ *
+ * Steps:
+ * 1) find the number of mounts residing in the propagation tree of 'dest_mnt'.
+ * 2) Allocate that many number of new struct vfsmounts (without holding
+ * 		the vfspnode_lock).
+ * 3) walk through the propagation tree of 'dest_mnt' and for each mount P
+ * 	a) attach a newly allocated struct vfsmount (mount C)
+ * 	b) i)   if the mount P is shared and the shared list is pivoted at P'
+ * 		put C in the ->mnt_share of C' where C' is the
+ *		child mount of P'
+ *	   ii)  if the mount P is a slave and resides in the slave list
+ *   		pivoted at P', put C in the ->mnt_slave_list of C'
+ *   		where C' is the child mount of P'
+ */
+int propagate_prepare_mount(struct vfsmount *dest_mnt,
+			    struct dentry *dest_dentry,
+			    struct vfsmount *source_mnt)
+{
+	struct vfsmount *p, *m, *child;
+	int total;
+	LIST_HEAD(slave_list_head);	/* the actively constructed propagation
+					 * tree branch corresponding to child
+					 * mounts */
+	LIST_HEAD(child_list_head);
+	LIST_HEAD(tmp_list);
+
+	spin_lock(&vfspnode_lock);
+	total = propagation_tree_size(dest_mnt, dest_dentry,
+				      (source_mnt->mnt_parent == source_mnt));
+	spin_unlock(&vfspnode_lock);
+
+	/*
+	 * allocate enough number of child mounts to satisfy the request
+	 * without holding locks.
+	 */
+	if (dup_mnt(source_mnt, --total, &child_list_head))
+		goto error;
+
+	p = NULL;
+	spin_lock(&vfspnode_lock);
+	if (source_mnt->mnt_parent == source_mnt) {
+		for (m = dest_mnt; m; m = propagation_next(m, dest_mnt)) {
+			/*
+			 * restrict propagation only to existing mounts.  NOTE:
+			 * a newly created child mount may end up being shared
+			 * with the parent. This can lead to infinite loop.
+			 * Ideally we should put all the mounts that receive
+			 * propagation in a  list and than iterate over the
+			 * list mounting the new child mounts. Because of lack
+			 * of a suitable field in struct vfsmount which is not
+			 * actively used; we use this approach.
+			 */
+			if (m != dest_mnt && m != source_mnt
+			    && list_empty(&m->mnt_child)) {
+				m = skip_propagation_tree(m);
+				continue;
+			}
+			if (!(child = get_allocated_child(&child_list_head)))
+				goto error;
+			__propagate_prepare_mount(m, dest_dentry, child,
+						  p, dest_mnt,
+						  &slave_list_head);
+			p = m;
+			if (m != dest_mnt) {
+				BUG_ON(child == source_mnt);
+				list_add_tail(&child->mnt_mounts, &tmp_list);
+			}
+		}
+		/*
+		 * prune the mounts in the child propagation tree that do not
+		 * have a dentry to mount. This can happen if the parent
+		 * mount was cloned of some subdirectory of a shared/slave
+		 * mount.
+		 */
+		list_for_each_entry_safe(child, p, &tmp_list, mnt_mounts) {
+			if (!child->mnt_mountpoint) {
+				list_del_init(&child->mnt_mounts);
+				__do_make_private(child);
+				mntput(child);
+			}
+		}
+	} else {
+		LIST_HEAD(head);
+		/*
+		 * here we know for sure that we are looping through
+		 * mounts that are yet to be comitted. Hence their
+		 * mnt_list field comes in handy.
+		 */
+		list_add_tail(&head, &dest_mnt->mnt_list);
+		list_for_each_entry(m, &head, mnt_list) {
+			if (!(child = get_allocated_child(&child_list_head)))
+				goto error;
+			__propagate_prepare_mount(m, dest_dentry, child,
+						  p, dest_mnt,
+						  &slave_list_head);
+			p = m;
+			if (m != dest_mnt) {
+				BUG_ON(child == source_mnt);
+				list_add_tail(&child->mnt_mounts, &tmp_list);
+			}
+		}
+		list_del_init(&head);
+	}
+	list_del_init(slave_list_head.next);
+	create_child_list(source_mnt, &tmp_list);
+	spin_unlock(&vfspnode_lock);
+	free_mnt_list(&child_list_head);
+	return 0;
+
+      error:
+	while (!list_empty(&slave_list_head))
+		list_del_init(slave_list_head.next);
+	create_child_list(source_mnt, &tmp_list);
+	propagate_abort_mount(source_mnt);
+	spin_unlock(&vfspnode_lock);
+	return -ENOMEM;
+}
Index: 2.6.13.sharedsubtree/include/linux/pnode.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/pnode.h
+++ 2.6.13.sharedsubtree/include/linux/pnode.h
@@ -35,10 +35,15 @@ static inline void set_mnt_unclonable(st
 static inline struct vfsmount *next_shared(struct vfsmount *p)
 {
 	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
 }
 
+static inline struct vfsmount *prev_shared(struct vfsmount *p)
+{
+	return list_entry(p->mnt_share.prev, struct vfsmount, mnt_share);
+}
+
 static inline struct vfsmount *first_slave(struct vfsmount *p)
 {
 	return list_entry(p->mnt_slave_list.next, struct vfsmount, mnt_slave);
 }
 
@@ -49,6 +54,12 @@ static inline struct vfsmount *next_slav
 
 int do_make_slave(struct vfsmount *);
 int do_make_shared(struct vfsmount *);
 int do_make_private(struct vfsmount *);
 int do_make_unclonable(struct vfsmount *);
+void pnode_merge_mount(struct vfsmount *, struct vfsmount *);
+void pnode_slave_mount(struct vfsmount *, struct vfsmount *);
+int propagate_commit_mount(struct vfsmount *);
+int propagate_abort_mount(struct vfsmount *);
+int propagate_prepare_mount(struct vfsmount *, struct dentry *,
+			    struct vfsmount *);
 #endif				/* _LINUX_PNODE_H */
Index: 2.6.13.sharedsubtree/include/linux/fs.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/fs.h
+++ 2.6.13.sharedsubtree/include/linux/fs.h
@@ -1244,10 +1244,16 @@ extern int register_filesystem(struct fi
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
+extern struct vfsmount *clone_mnt(struct vfsmount *, struct dentry *);
+extern void do_attach_prepare_mnt(struct vfsmount *, struct dentry *,
+				  struct vfsmount *);
+extern void do_attach_commit_mnt(struct vfsmount *);
+extern void do_detach_prepare_mnt(struct vfsmount *);
+extern void do_detach_mount(struct vfsmount *);
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
 #define FLOCK_VERIFY_READ  1
 #define FLOCK_VERIFY_WRITE 2
