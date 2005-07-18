Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVGRHMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVGRHMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVGRHKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:10:16 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35976 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261572AbVGRHHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:15 -0400
Message-Id: <20050718070702.149068000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:18 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 7/8] shared subtree
Content-Type: text/x-patch; name=automount.patch
Content-Disposition: inline; filename=automount.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adds support for mount/umount propogation for autofs initiated operations,
RP


 fs/namespace.c        |  151 +++++++++++++++++---------------------------------
 fs/pnode.c            |   13 ++--
 include/linux/pnode.h |    3 
 3 files changed, 61 insertions(+), 106 deletions(-)

Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
@@ -215,6 +215,9 @@ struct vfsmount *do_attach_prepare_mnt(s
 		if(!(child_mnt = clone_mnt(template_mnt,
 				template_mnt->mnt_root)))
 			return NULL;
+		spin_lock(&vfsmount_lock);
+		list_del_init(&child_mnt->mnt_fslink);
+		spin_unlock(&vfsmount_lock);
 	} else
 		child_mnt = template_mnt;
 
@@ -352,38 +355,16 @@ struct seq_operations mounts_op = {
  * open files, pwds, chroots or sub mounts that are
  * busy.
  */
-//TOBEFIXED
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
 
@@ -395,18 +376,18 @@ resume:
 
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
@@ -424,7 +405,7 @@ int mount_busy(struct vfsmount *mnt)
  */
 int may_umount(struct vfsmount *mnt)
 {
-	if (mount_busy(mnt))
+	if (mount_busy(mnt, 2))
 		return -EBUSY;
 	return 0;
 }
@@ -445,6 +426,25 @@ void do_detach_mount(struct vfsmount *mn
 	spin_lock(&vfsmount_lock);
 }
 
+void umount_mnt(struct vfsmount *mnt)
+{
+	if (mnt->mnt_parent != mnt &&
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
 void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
@@ -459,21 +459,7 @@ void umount_tree(struct vfsmount *mnt)
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_fslink);
-		if (mnt->mnt_parent != mnt &&
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
+		umount_mnt(mnt);
 	}
 }
 
@@ -568,7 +554,7 @@ int do_umount(struct vfsmount *mnt, int 
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (flags & MNT_DETACH || !mount_busy(mnt)) {
+	if (flags & MNT_DETACH || !mount_busy(mnt, 2)) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
@@ -1490,6 +1476,8 @@ void mark_mounts_for_expiry(struct list_
 	if (list_empty(mounts))
 		return;
 
+	down_write(&namespace_sem);
+
 	spin_lock(&vfsmount_lock);
 
 	/* extract from the expiration list every vfsmount that matches the
@@ -1499,8 +1487,7 @@ void mark_mounts_for_expiry(struct list_
 	 *   cleared by mntput())
 	 */
 	list_for_each_entry_safe(mnt, next, mounts, mnt_fslink) {
-		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
-		    atomic_read(&mnt->mnt_count) != 1)
+		if (!xchg(&mnt->mnt_expiry_mark, 1) || mount_busy(mnt, 1))
 			continue;
 
 		mntget(mnt);
@@ -1508,12 +1495,13 @@ void mark_mounts_for_expiry(struct list_
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
 
@@ -1524,60 +1512,25 @@ void mark_mounts_for_expiry(struct list_
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
+		umount_mnt(mnt);
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
Index: 2.6.12.work1/fs/pnode.c
===================================================================
--- 2.6.12.work1.orig/fs/pnode.c
+++ 2.6.12.work1/fs/pnode.c
@@ -34,7 +34,7 @@ enum pnode_vfs_type {
 static kmem_cache_t * pnode_cachep;
 
 /* spinlock for pnode related operations */
- __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
+  __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
 
 
 void __init pnode_init(unsigned long mempages)
@@ -274,7 +274,8 @@ int pnode_merge_pnode(struct vfspnode *p
 }
 
 static int vfs_busy(struct vfsmount *mnt, struct dentry *dentry,
-		struct dentry *rootdentry, struct vfsmount *origmnt)
+		struct dentry *rootdentry, struct vfsmount *origmnt,
+		int refcnt)
 {
 	struct vfsmount *child_mnt;
 	int ret=0;
@@ -288,16 +289,16 @@ static int vfs_busy(struct vfsmount *mnt
 
 	if (list_empty(&child_mnt->mnt_mounts)) {
 		if (origmnt == child_mnt)
-			ret = do_refcount_check(child_mnt, 3);
-		else
-			ret = do_refcount_check(child_mnt, 2);
+			ret = do_refcount_check(child_mnt, refcnt+1);
+  		else
+			ret = do_refcount_check(child_mnt, refcnt);
 	}
 	mntput(child_mnt);
 	return ret;
 }
 
 int pnode_mount_busy(struct vfspnode *pnode, struct dentry *mntpt,
-		struct dentry *root, struct vfsmount *mnt)
+		struct dentry *root, struct vfsmount *mnt, int refcnt)
 {
 	int ret=0;
      	struct vfsmount *slave_mnt, *member_mnt, *t_m;
Index: 2.6.12.work1/include/linux/pnode.h
===================================================================
--- 2.6.12.work1.orig/include/linux/pnode.h
+++ 2.6.12.work1/include/linux/pnode.h
@@ -86,5 +86,6 @@ int pnode_prepare_mount(struct vfspnode 
 		struct vfsmount *, struct vfsmount *);
 int pnode_real_mount(struct vfspnode *, int);
 int pnode_umount(struct vfspnode *, struct dentry *, struct dentry *);
-int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *, struct vfsmount *);
+int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *,
+		struct vfsmount *, int);
 #endif /* _LINUX_PNODE_H */
