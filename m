Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVGYW7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVGYW7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGYW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:59:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61934 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261256AbVGYW7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:59:20 -0400
Message-Id: <20050725225908.819495000@localhost>
References: <20050725224417.501066000@localhost>
Date: Mon, 25 Jul 2005 15:44:24 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Avantika Mathur <mathurav@us.ibm.com>, Mike Waychison <mike@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

, miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] shared subtree
Content-Type: text/x-patch; name=automount.patch
Content-Disposition: inline; filename=automount.patch

adds support for mount/umount propogation for autofs initiated operations,
RP

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |  176 +++++++++++++++++++-------------------------------
 fs/pnode.c            |   12 +--
 include/linux/pnode.h |    3 
 3 files changed, 76 insertions(+), 115 deletions(-)

Index: 2.6.12.work2/fs/namespace.c
===================================================================
--- 2.6.12.work2.orig/fs/namespace.c
+++ 2.6.12.work2/fs/namespace.c
@@ -202,6 +202,9 @@ struct vfsmount *do_attach_prepare_mnt(s
 		if(!(child_mnt = clone_mnt(template_mnt,
 				template_mnt->mnt_root)))
 			return NULL;
+		spin_lock(&vfsmount_lock);
+		list_del_init(&child_mnt->mnt_fslink);
+		spin_unlock(&vfsmount_lock);
 	} else
 		child_mnt = template_mnt;
 
@@ -355,35 +358,14 @@ struct seq_operations mounts_op = {
  */
 int may_umount_tree(struct vfsmount *mnt)
 {
-	struct list_head *next;
-	struct vfsmount *this_parent = mnt;
-	int actual_refs;
-	int minimum_refs;
+	int actual_refs=0;
+	int minimum_refs=0;
+	struct vfsmount *p;
 
 	spin_lock(&vfsmount_lock);
-	actual_refs = atomic_read(&mnt->mnt_count);
-	minimum_refs = 2;
-repeat:
-	next = this_parent->mnt_mounts.next;
-resume:
-	while (next != &this_parent->mnt_mounts) {
-		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
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
 
@@ -395,18 +377,18 @@ resume:
 
 EXPORT_SYMBOL(may_umount_tree);
 
-int mount_busy(struct vfsmount *mnt)
+int mount_busy(struct vfsmount *mnt, int refcnt)
 {
 	struct vfspnode *parent_pnode;
 
 	if (mnt == mnt->mnt_parent || !IS_MNT_SHARED(mnt->mnt_parent))
-		return do_refcount_check(mnt, 2);
+		return do_refcount_check(mnt, refcnt);
 
 	parent_pnode = mnt->mnt_parent->mnt_pnode;
 	BUG_ON(!parent_pnode);
 	return pnode_mount_busy(parent_pnode,
 			mnt->mnt_mountpoint,
-			mnt->mnt_root, mnt);
+			mnt->mnt_root, mnt, refcnt);
 }
 
 /**
@@ -424,9 +406,12 @@ int mount_busy(struct vfsmount *mnt)
  */
 int may_umount(struct vfsmount *mnt)
 {
-	if (mount_busy(mnt))
-		return -EBUSY;
-	return 0;
+	int ret=0;
+	spin_lock(&vfsmount_lock);
+	if (mount_busy(mnt, 2))
+		ret = -EBUSY;
+	spin_unlock(&vfsmount_lock);
+	return ret;
 }
 
 EXPORT_SYMBOL(may_umount);
@@ -445,7 +430,26 @@ void do_detach_mount(struct vfsmount *mn
 	spin_lock(&vfsmount_lock);
 }
 
-void __umount_tree(struct vfsmount *mnt, int propogate)
+void umount_mnt(struct vfsmount *mnt, int propogate)
+{
+	if (propogate && mnt->mnt_parent != mnt &&
+		IS_MNT_SHARED(mnt->mnt_parent)) {
+		struct vfspnode *parent_pnode
+			= mnt->mnt_parent->mnt_pnode;
+		BUG_ON(!parent_pnode);
+		pnode_umount(parent_pnode,
+			mnt->mnt_mountpoint,
+			mnt->mnt_root);
+	} else {
+		if (IS_MNT_SHARED(mnt) || IS_MNT_SLAVE(mnt)) {
+			BUG_ON(!mnt->mnt_pnode);
+			pnode_disassociate_mnt(mnt);
+		}
+		do_detach_mount(mnt);
+	}
+}
+
+static void __umount_tree(struct vfsmount *mnt, int propogate)
 {
 	struct vfsmount *p;
 	LIST_HEAD(kill);
@@ -459,21 +463,7 @@ void __umount_tree(struct vfsmount *mnt,
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_fslink);
-		if (propogate && mnt->mnt_parent != mnt &&
-			IS_MNT_SHARED(mnt->mnt_parent)) {
-			struct vfspnode *parent_pnode
-				= mnt->mnt_parent->mnt_pnode;
-			BUG_ON(!parent_pnode);
-			pnode_umount(parent_pnode,
-				mnt->mnt_mountpoint,
-				mnt->mnt_root);
-		} else {
-			if (IS_MNT_SHARED(mnt) || IS_MNT_SLAVE(mnt)) {
-				BUG_ON(!mnt->mnt_pnode);
-				pnode_disassociate_mnt(mnt);
-			}
-			do_detach_mount(mnt);
-		}
+		umount_mnt(mnt, propogate);
 	}
 }
 
@@ -573,7 +563,7 @@ int do_umount(struct vfsmount *mnt, int 
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (flags & MNT_DETACH || !mount_busy(mnt)) {
+	if (flags & MNT_DETACH || !mount_busy(mnt, 2)) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
@@ -755,8 +745,11 @@ static void commit_attach_recursive_mnt(
 
 			if (slave_flag)
 				pnode_add_slave_pnode(master_pnode, tmp_pnode);
-			else
+			else {
+				spin_lock(&vfspnode_lock);
 				pnode_merge_pnode(tmp_pnode, master_pnode);
+				spin_unlock(&vfspnode_lock);
+			}
 
 			/*
 			 * we don't need the extra reference to
@@ -820,7 +813,6 @@ static void abort_attach_recursive_mnt(s
 	list_del_init(head);
 }
 
-
  /*
  *  @source_mnt : mount tree to be attached
  *  @nd		: place the mount tree @source_mnt is attached
@@ -1518,8 +1510,9 @@ static int do_move_mount(struct nameidat
 	detach_recursive_mnt(old_nd.mnt, &parent_nd);
 	spin_unlock(&vfsmount_lock);
 	if ((err = attach_recursive_mnt(old_nd.mnt, nd, 1))) {
+		spin_lock(&vfsmount_lock);
 		undo_detach_recursive_mnt(old_nd.mnt, &parent_nd);
-		goto out1;
+		goto out2;
 	}
 	spin_lock(&vfsmount_lock);
 	mntput(old_nd.mnt);
@@ -1621,6 +1614,8 @@ void mark_mounts_for_expiry(struct list_
 	if (list_empty(mounts))
 		return;
 
+	down_write(&namespace_sem);
+
 	spin_lock(&vfsmount_lock);
 
 	/* extract from the expiration list every vfsmount that matches the
@@ -1630,8 +1625,7 @@ void mark_mounts_for_expiry(struct list_
 	 *   cleared by mntput())
 	 */
 	list_for_each_entry_safe(mnt, next, mounts, mnt_fslink) {
-		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
-		    atomic_read(&mnt->mnt_count) != 1)
+		if (!xchg(&mnt->mnt_expiry_mark, 1) || mount_busy(mnt, 1))
 			continue;
 
 		mntget(mnt);
@@ -1639,12 +1633,13 @@ void mark_mounts_for_expiry(struct list_
 	}
 
 	/*
-	 * go through the vfsmounts we've just consigned to the graveyard to
-	 * - check that they're still dead
+	 * go through the vfsmounts we've just consigned to the graveyard
 	 * - delete the vfsmount from the appropriate namespace under lock
 	 * - dispose of the corpse
 	 */
 	while (!list_empty(&graveyard)) {
+		struct super_block *sb;
+
 		mnt = list_entry(graveyard.next, struct vfsmount, mnt_fslink);
 		list_del_init(&mnt->mnt_fslink);
 
@@ -1655,60 +1650,25 @@ void mark_mounts_for_expiry(struct list_
 			continue;
 		get_namespace(namespace);
 
-		spin_unlock(&vfsmount_lock);
-		down_write(&namespace_sem);
-		spin_lock(&vfsmount_lock);
-
-		/* check that it is still dead: the count should now be 2 - as
-		 * contributed by the vfsmount parent and the mntget above */
-		if (atomic_read(&mnt->mnt_count) == 2) {
-			struct vfsmount *xdmnt;
-			struct dentry *xdentry;
-
-			/* delete from the namespace */
-			list_del_init(&mnt->mnt_list);
-			list_del_init(&mnt->mnt_child);
-			list_del_init(&mnt->mnt_hash);
-			mnt->mnt_mountpoint->d_mounted--;
-
-			xdentry = mnt->mnt_mountpoint;
-			mnt->mnt_mountpoint = mnt->mnt_root;
-			xdmnt = mnt->mnt_parent;
-			mnt->mnt_parent = mnt;
-
-			spin_unlock(&vfsmount_lock);
-
-			mntput(xdmnt);
-			dput(xdentry);
-
-			/* now lay it to rest if this was the last ref on the
-			 * superblock */
-			if (atomic_read(&mnt->mnt_sb->s_active) == 1) {
-				/* last instance - try to be smart */
-				lock_kernel();
-				DQUOT_OFF(mnt->mnt_sb);
-				acct_auto_close(mnt->mnt_sb);
-				unlock_kernel();
-			}
-
-			mntput(mnt);
-		} else {
-			/* someone brought it back to life whilst we didn't
-			 * have any locks held so return it to the expiration
-			 * list */
-			list_add_tail(&mnt->mnt_fslink, mounts);
-			spin_unlock(&vfsmount_lock);
+		sb = mnt->mnt_sb;
+		umount_mnt(mnt, 1);
+		/*
+		 * now lay it to rest if this was the last ref on the
+		 * superblock
+		 */
+		if (atomic_read(&sb->s_active) == 1) {
+			/* last instance - try to be smart */
+			lock_kernel();
+			DQUOT_OFF(sb);
+			acct_auto_close(sb);
+			unlock_kernel();
 		}
-
-		up_write(&namespace_sem);
-
 		mntput(mnt);
-		put_namespace(namespace);
 
-		spin_lock(&vfsmount_lock);
+		put_namespace(namespace);
 	}
-
 	spin_unlock(&vfsmount_lock);
+	up_write(&namespace_sem);
 }
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
@@ -2149,24 +2109,24 @@ asmlinkage long sys_pivot_root(const cha
 	detach_recursive_mnt(new_nd.mnt, &parent_nd);
 
 	spin_unlock(&vfsmount_lock);
- 	if ((error = attach_recursive_mnt(user_nd.mnt, &old_nd, 1))) {
+ 	if ((error = attach_recursive_mnt(new_nd.mnt, &root_parent, 1))) {
 		spin_lock(&vfsmount_lock);
 		undo_detach_recursive_mnt(new_nd.mnt, &parent_nd);
 		undo_detach_recursive_mnt(user_nd.mnt, &root_parent);
 		goto out3;
 	}
 	spin_lock(&vfsmount_lock);
- 	mntput(user_nd.mnt);
+ 	mntput(new_nd.mnt);
 
 	spin_unlock(&vfsmount_lock);
- 	if ((error = attach_recursive_mnt(new_nd.mnt, &root_parent, 1))) {
+ 	if ((error = attach_recursive_mnt(user_nd.mnt, &old_nd, 1))) {
 		spin_lock(&vfsmount_lock);
 		undo_detach_recursive_mnt(new_nd.mnt, &parent_nd);
 		undo_detach_recursive_mnt(user_nd.mnt, &root_parent);
 		goto out3;
 	}
 	spin_lock(&vfsmount_lock);
- 	mntput(new_nd.mnt);
+ 	mntput(user_nd.mnt);
 
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
Index: 2.6.12.work2/fs/pnode.c
===================================================================
--- 2.6.12.work2.orig/fs/pnode.c
+++ 2.6.12.work2/fs/pnode.c
@@ -29,7 +29,7 @@
 static kmem_cache_t * pnode_cachep;
 
 /* spinlock for pnode related operations */
- __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
+  __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
 
 enum pnode_vfs_type {
 	PNODE_MEMBER_VFS = 0x01,
@@ -673,6 +673,7 @@ static int vfs_busy(struct vfsmount *mnt
 	struct dentry *dentry = va_arg(args, struct dentry *);
 	struct dentry *rootdentry = va_arg(args, struct dentry *);
 	struct vfsmount *origmnt = va_arg(args, struct vfsmount *);
+	int    refcnt = va_arg(args, int);
 	struct vfsmount *child_mnt;
 	int ret=0;
 
@@ -685,22 +686,21 @@ static int vfs_busy(struct vfsmount *mnt
 
 	if (list_empty(&child_mnt->mnt_mounts)) {
 		if (origmnt == child_mnt)
-			ret = do_refcount_check(child_mnt, 3);
+			ret = do_refcount_check(child_mnt, refcnt+1);
 		else
-			ret = do_refcount_check(child_mnt, 2);
+			ret = do_refcount_check(child_mnt, refcnt);
 	}
 	mntput(child_mnt);
 	return ret;
 }
 
 int pnode_mount_busy(struct vfspnode *pnode, struct dentry *mntpt,
-		struct dentry *root, struct vfsmount *mnt)
+		struct dentry *root, struct vfsmount *mnt, int refcnt)
 {
 	return pnode_traverse(pnode, NULL, NULL,
-			NULL, NULL, vfs_busy, mntpt, root, mnt);
+			NULL, NULL, vfs_busy, mntpt, root, mnt, refcnt);
 }
 
-
 int vfs_umount(struct vfsmount *mnt, enum pnode_vfs_type flag,
 		void *indata, va_list args)
 {
Index: 2.6.12.work2/include/linux/pnode.h
===================================================================
--- 2.6.12.work2.orig/include/linux/pnode.h
+++ 2.6.12.work2/include/linux/pnode.h
@@ -77,6 +77,7 @@ void pnode_add_member_mnt(struct vfspnod
 void pnode_del_slave_mnt(struct vfsmount *);
 void pnode_del_member_mnt(struct vfsmount *);
 void pnode_disassociate_mnt(struct vfsmount *);
+void pnode_member_to_slave(struct vfsmount *);
 void pnode_add_slave_pnode(struct vfspnode *, struct vfspnode *);
 struct vfsmount * pnode_make_mounted(struct vfspnode *, struct vfsmount *,
 		struct dentry *);
@@ -91,5 +92,5 @@ int pnode_commit_mount(struct vfspnode *
 int pnode_abort_mount(struct vfspnode *, struct vfsmount *);
 int pnode_umount(struct vfspnode *, struct dentry *, struct dentry *);
 int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *,
-		struct vfsmount *);
+		struct vfsmount *, int);
 #endif /* _LINUX_PNODE_H */
