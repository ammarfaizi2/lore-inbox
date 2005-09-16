Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbVIPS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbVIPS2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbVIPS2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:28:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22151 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161241AbVIPS1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:27:45 -0400
Date: Fri, 16 Sep 2005 11:26:20 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 9/10] vfs: shared subtree automounter helper functions 
Message-ID: <20050916182620.GA28546@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that makes the automounter helper functions aware of the propagations
associated with mounts.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |   73 +++++++++++++++++++-------------------------------
 fs/pnode.c            |    8 ++++-
 include/linux/pnode.h |    2 -
 3 files changed, 35 insertions(+), 48 deletions(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -220,17 +220,10 @@ struct vfsmount *clone_mnt(struct vfsmou
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
 		mnt->mnt_namespace = current->namespace;
 		mnt->mnt_master = mntget(old);
-
-		/* stick the duplicate mount on the same expiry list
-		 * as the original if that was on one */
-		spin_lock(&vfsmount_lock);
-		if (!list_empty(&old->mnt_expire))
-			list_add(&mnt->mnt_expire, &old->mnt_expire);
-		spin_unlock(&vfsmount_lock);
 	}
 	return mnt;
 }
 
 static void inline clean_propagation_reference(struct vfsmount *mnt)
@@ -341,40 +334,18 @@ struct seq_operations mounts_op = {
  * open files, pwds, chroots or sub mounts that are
  * busy.
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
-      repeat:
-	next = this_parent->mnt_mounts.next;
-      resume:
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
 
 	if (actual_refs > minimum_refs)
 		return -EBUSY;
@@ -401,10 +372,24 @@ void do_detach_mount(struct vfsmount *mn
 	spin_unlock(&vfsmount_lock);
 	mntput(mnt);
 	spin_lock(&vfsmount_lock);
 }
 
+static void update_expiry_list(struct vfsmount *mnt)
+{
+	struct vfsmount *master, *m;
+	for (m = mnt; m; m = next_mnt(m, mnt)) {
+		master = m->mnt_master;
+		if (master) {
+			if (!list_empty(&master->mnt_expire))
+				list_add(&m->mnt_expire, &master->mnt_expire);
+			mntput(master);
+			m->mnt_master = NULL;
+		}
+	}
+}
+
 /**
  * may_umount - check if a mount point is busy
  * @mnt: root of mount
  *
  * This is called to check if a mount point has any
@@ -416,13 +401,16 @@ void do_detach_mount(struct vfsmount *mn
  * give false negatives. The main reason why it's here is that we need
  * a non-destructive way to look for easily umountable filesystems.
  */
 int may_umount(struct vfsmount *mnt)
 {
-	if (atomic_read(&mnt->mnt_count) > 2)
-		return -EBUSY;
-	return 0;
+	int ret = 0;
+	spin_lock(&vfsmount_lock);
+	if (propagate_mount_busy(mnt, 2))
+		ret = -EBUSY;
+	spin_unlock(&vfsmount_lock);
+	return ret;
 }
 
 EXPORT_SYMBOL(may_umount);
 
 static void umount_tree(struct vfsmount *mnt)
@@ -727,11 +715,11 @@ static void commit_attach_recursive_mnt(
 			list_del_init(&nextmnt->mnt_mounts);
 			list_add_tail(&m->mnt_list, &nextmnt->mnt_list);
 		}
 
 		spin_lock(&vfspnode_lock);
-		propagate_commit_mount(m);
+		propagate_commit_mount(m, move);
 		spin_unlock(&vfspnode_lock);
 
 		if (!move && (master = m->mnt_master)) {
 			m->mnt_master = NULL;
 			if (IS_MNT_SHARED(master))
@@ -891,11 +879,11 @@ static int attach_recursive_mnt(struct v
 		spin_lock(&vfsmount_lock);
 		attach_mnt(source_mnt, nd);
 		list_add_tail(&mnt_list_head, &source_mnt->mnt_list);
 		list_splice(&mnt_list_head, dest_mnt->mnt_namespace->list.prev);
 		if (!move)
-			clean_propagation_reference(source_mnt);
+			update_expiry_list(source_mnt);
 		spin_unlock(&vfsmount_lock);
 		goto out;
 	}
 
 	p = NULL;
@@ -1066,15 +1054,10 @@ static int do_loopback(struct nameidata 
 		else
 			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
 	}
 
 	if (mnt) {
-		/* stop bind mounts from expiring */
-		spin_lock(&vfsmount_lock);
-		list_del_init(&mnt->mnt_expire);
-		spin_unlock(&vfsmount_lock);
-
 		err = graft_tree(mnt, nd);
 		if (err) {
 			spin_lock(&vfsmount_lock);
 			clean_propagation_reference(mnt);
 			umount_tree(mnt);
@@ -1298,17 +1281,17 @@ static void expire_mount(struct vfsmount
 
 	/*
 	 * Check that it is still dead: the count should now be 2 - as
 	 * contributed by the vfsmount parent and the mntget above
 	 */
-	if (atomic_read(&mnt->mnt_count) == 2) {
+	if (!propagate_mount_busy(mnt, 2)) {
 		struct nameidata old_nd;
 
 		/* delete from the namespace */
 		list_del_init(&mnt->mnt_list);
 		mnt->mnt_namespace = NULL;
-		detach_mnt(mnt, &old_nd);
+		propagate_umount(mnt);
 		spin_unlock(&vfsmount_lock);
 		path_release(&old_nd);
 
 		/*
 		 * Now lay it to rest if this was the last ref on the superblock
Index: 2.6.13.sharedsubtree/fs/pnode.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/pnode.c
+++ 2.6.13.sharedsubtree/fs/pnode.c
@@ -258,14 +258,15 @@ static struct vfsmount *skip_propagation
  * commit the operations done by propagate_prepare_mount()
  * @mnt: the root of the mount tree.
  * 'vfspnode_lock' need not be held before calling this function, if the
  * propogation tree is local to the caller.
  */
-int propagate_commit_mount(struct vfsmount *mnt)
+int propagate_commit_mount(struct vfsmount *mnt, int move)
 {
 	struct vfsmount *m;
 	LIST_HEAD(mnt_list_head);
+	struct vfsmount *master = move ? mnt : mnt->mnt_master;
 
 	list_add_tail(&mnt_list_head, &mnt->mnt_list);
 	while (!list_empty(&mnt_list_head)) {
 		m = list_entry(mnt_list_head.next, struct vfsmount, mnt_list);
 		list_del_init(&m->mnt_list);
@@ -273,12 +274,15 @@ int propagate_commit_mount(struct vfsmou
 
 		if (IS_MNT_SHARED(m->mnt_parent))
 			set_mnt_shared(m);
 		else if (m != mnt)
 			CLEAR_MNT_SHARED(m);
-	}
 
+		if (((move && m != mnt) || !move) && master &&
+		    !list_empty(&master->mnt_expire))
+			list_add(&m->mnt_expire, &master->mnt_expire);
+	}
 	return 0;
 }
 
 /*
  * abort the operations done by propagate_prepare_mount()
Index: 2.6.13.sharedsubtree/include/linux/pnode.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/pnode.h
+++ 2.6.13.sharedsubtree/include/linux/pnode.h
@@ -56,11 +56,11 @@ int do_make_slave(struct vfsmount *);
 int do_make_shared(struct vfsmount *);
 int do_make_private(struct vfsmount *);
 int do_make_unclonable(struct vfsmount *);
 void pnode_merge_mount(struct vfsmount *, struct vfsmount *);
 void pnode_slave_mount(struct vfsmount *, struct vfsmount *);
-int propagate_commit_mount(struct vfsmount *);
+int propagate_commit_mount(struct vfsmount *, int);
 int propagate_abort_mount(struct vfsmount *);
 int propagate_prepare_mount(struct vfsmount *, struct dentry *,
 			    struct vfsmount *);
 int propagate_umount(struct vfsmount *);
 int propagate_mount_busy(struct vfsmount *, int);
