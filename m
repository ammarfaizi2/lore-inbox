Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVGYW7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVGYW7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVGYW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:59:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63110 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261259AbVGYW7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:59:22 -0400
Message-Id: <20050725225908.458209000@localhost>
References: <20050725224417.501066000@localhost>
Date: Mon, 25 Jul 2005 15:44:22 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Avantika Mathur <mathurav@us.ibm.com>, Mike Waychison <mike@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

, miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] shared subtree
Content-Type: text/x-patch; name=umount.patch
Content-Disposition: inline; filename=umount.patch

Adds ability to unmount a shared/slave/unclone/private tree

RP

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |   76 ++++++++++++++++++++++++++++++++++++++++----------
 fs/pnode.c            |   66 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    3 +
 include/linux/pnode.h |    9 ++++-
 4 files changed, 138 insertions(+), 16 deletions(-)

Index: 2.6.12.work2/fs/pnode.c
===================================================================
--- 2.6.12.work2.orig/fs/pnode.c
+++ 2.6.12.work2/fs/pnode.c
@@ -666,3 +666,69 @@ int pnode_abort_mount(struct vfspnode *p
 			NULL, (void *)NULL, NULL, NULL,
 			vfs_abort_mount_func, exception_mnt);
 }
+
+static int vfs_busy(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		void *indata, va_list args)
+{
+	struct dentry *dentry = va_arg(args, struct dentry *);
+	struct dentry *rootdentry = va_arg(args, struct dentry *);
+	struct vfsmount *origmnt = va_arg(args, struct vfsmount *);
+	struct vfsmount *child_mnt;
+	int ret=0;
+
+	spin_unlock(&vfsmount_lock);
+	child_mnt = __lookup_mnt(mnt, dentry, rootdentry);
+	spin_lock(&vfsmount_lock);
+
+	if (!child_mnt)
+		return 0;
+
+	if (list_empty(&child_mnt->mnt_mounts)) {
+		if (origmnt == child_mnt)
+			ret = do_refcount_check(child_mnt, 3);
+		else
+			ret = do_refcount_check(child_mnt, 2);
+	}
+	mntput(child_mnt);
+	return ret;
+}
+
+int pnode_mount_busy(struct vfspnode *pnode, struct dentry *mntpt,
+		struct dentry *root, struct vfsmount *mnt)
+{
+	return pnode_traverse(pnode, NULL, NULL,
+			NULL, NULL, vfs_busy, mntpt, root, mnt);
+}
+
+
+int vfs_umount(struct vfsmount *mnt, enum pnode_vfs_type flag,
+		void *indata, va_list args)
+{
+	struct vfsmount *child_mnt;
+	struct dentry *dentry, *rootdentry;
+
+
+	dentry = va_arg(args, struct dentry *);
+	rootdentry = va_arg(args, struct dentry *);
+
+	spin_unlock(&vfsmount_lock);
+	child_mnt = __lookup_mnt(mnt, dentry, rootdentry);
+	spin_lock(&vfsmount_lock);
+	mntput(child_mnt);
+	if (child_mnt && list_empty(&child_mnt->mnt_mounts)) {
+		if (IS_MNT_SHARED(child_mnt) ||
+				IS_MNT_SLAVE(child_mnt)) {
+			BUG_ON(!child_mnt->mnt_pnode);
+			pnode_disassociate_mnt(child_mnt);
+		}
+		do_detach_mount(child_mnt);
+	}
+	return 0;
+}
+
+int pnode_umount(struct vfspnode *pnode, struct dentry *dentry,
+			struct dentry *rootdentry)
+{
+	return pnode_traverse(pnode, NULL, (void *)NULL,
+			NULL, NULL, vfs_umount, dentry, rootdentry);
+}
Index: 2.6.12.work2/fs/namespace.c
===================================================================
--- 2.6.12.work2.orig/fs/namespace.c
+++ 2.6.12.work2/fs/namespace.c
@@ -395,6 +395,20 @@ resume:
 
 EXPORT_SYMBOL(may_umount_tree);
 
+int mount_busy(struct vfsmount *mnt)
+{
+	struct vfspnode *parent_pnode;
+
+	if (mnt == mnt->mnt_parent || !IS_MNT_SHARED(mnt->mnt_parent))
+		return do_refcount_check(mnt, 2);
+
+	parent_pnode = mnt->mnt_parent->mnt_pnode;
+	BUG_ON(!parent_pnode);
+	return pnode_mount_busy(parent_pnode,
+			mnt->mnt_mountpoint,
+			mnt->mnt_root, mnt);
+}
+
 /**
  * may_umount - check if a mount point is busy
  * @mnt: root of mount
@@ -410,14 +424,28 @@ EXPORT_SYMBOL(may_umount_tree);
  */
 int may_umount(struct vfsmount *mnt)
 {
-	if (atomic_read(&mnt->mnt_count) > 2)
+	if (mount_busy(mnt))
 		return -EBUSY;
 	return 0;
 }
 
 EXPORT_SYMBOL(may_umount);
 
-void umount_tree(struct vfsmount *mnt)
+void do_detach_mount(struct vfsmount *mnt)
+{
+	struct nameidata old_nd;
+	if (mnt != mnt->mnt_parent) {
+		detach_mnt(mnt, &old_nd);
+		path_release(&old_nd);
+	}
+	list_del_init(&mnt->mnt_list);
+	list_del_init(&mnt->mnt_fslink);
+	spin_unlock(&vfsmount_lock);
+	mntput(mnt);
+	spin_lock(&vfsmount_lock);
+}
+
+void __umount_tree(struct vfsmount *mnt, int propogate)
 {
 	struct vfsmount *p;
 	LIST_HEAD(kill);
@@ -431,20 +459,40 @@ void umount_tree(struct vfsmount *mnt)
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_fslink);
-		if (mnt->mnt_parent == mnt) {
-			spin_unlock(&vfsmount_lock);
+		if (propogate && mnt->mnt_parent != mnt &&
+			IS_MNT_SHARED(mnt->mnt_parent)) {
+			struct vfspnode *parent_pnode
+				= mnt->mnt_parent->mnt_pnode;
+			BUG_ON(!parent_pnode);
+			pnode_umount(parent_pnode,
+				mnt->mnt_mountpoint,
+				mnt->mnt_root);
 		} else {
-			struct nameidata old_nd;
-			detach_mnt(mnt, &old_nd);
-			spin_unlock(&vfsmount_lock);
-			path_release(&old_nd);
+			if (IS_MNT_SHARED(mnt) || IS_MNT_SLAVE(mnt)) {
+				BUG_ON(!mnt->mnt_pnode);
+				pnode_disassociate_mnt(mnt);
+			}
+			do_detach_mount(mnt);
 		}
-		mntput(mnt);
-		spin_lock(&vfsmount_lock);
 	}
 }
 
-static int do_umount(struct vfsmount *mnt, int flags)
+void umount_tree(struct vfsmount *mnt)
+{
+	__umount_tree(mnt, 1);
+}
+
+/*
+ * return true if the refcount is greater than count
+ */
+int do_refcount_check(struct vfsmount *mnt, int count)
+{
+
+	int mycount = atomic_read(&mnt->mnt_count);
+	return (mycount > count);
+}
+
+int do_umount(struct vfsmount *mnt, int flags)
 {
 	struct super_block * sb = mnt->mnt_sb;
 	int retval;
@@ -525,7 +573,7 @@ static int do_umount(struct vfsmount *mn
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
+	if (flags & MNT_DETACH || !mount_busy(mnt)) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
@@ -659,7 +707,7 @@ static struct vfsmount *copy_tree(struct
  Enomem:
 	if (res) {
 		spin_lock(&vfsmount_lock);
-		umount_tree(res);
+		__umount_tree(res, 0);
 		spin_unlock(&vfsmount_lock);
 	}
 	return NULL;
@@ -1341,7 +1389,7 @@ static int do_loopback(struct nameidata 
 		err = graft_tree(mnt, nd);
 		if (err) {
  			spin_lock(&vfsmount_lock);
- 			umount_tree(mnt);
+ 			__umount_tree(mnt, 0);
  			spin_unlock(&vfsmount_lock);
 			/*
 			 * ok we failed! so undo any overlay
Index: 2.6.12.work2/include/linux/fs.h
===================================================================
--- 2.6.12.work2.orig/include/linux/fs.h
+++ 2.6.12.work2/include/linux/fs.h
@@ -1216,12 +1216,15 @@ extern struct vfsmount *kern_mount(struc
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
+extern int do_umount(struct vfsmount *, int);
 extern struct vfsmount *do_attach_prepare_mnt(struct vfsmount *,
 		struct dentry *, struct vfsmount *, int);
 extern void do_attach_commit_mnt(struct vfsmount *);
 extern struct vfsmount *do_make_mounted(struct vfsmount *, struct dentry *);
 extern int do_make_unmounted(struct vfsmount *);
 extern void do_detach_prepare_mnt(struct vfsmount *, int);
+extern void do_detach_mount(struct vfsmount *);
+extern int do_refcount_check(struct vfsmount *, int );
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
Index: 2.6.12.work2/include/linux/pnode.h
===================================================================
--- 2.6.12.work2.orig/include/linux/pnode.h
+++ 2.6.12.work2/include/linux/pnode.h
@@ -63,13 +63,15 @@ put_pnode_locked(struct vfspnode *pnode)
 {
 	if (!pnode)
 		return;
-	if (atomic_dec_and_test(&pnode->pnode_count)) {
+	if (atomic_dec_and_test(&pnode->pnode_count))
 		__put_pnode(pnode);
-	}
 }
 
 void __init pnode_init(unsigned long );
 struct vfspnode * pnode_alloc(void);
+void pnode_free(struct vfspnode *);
+int pnode_is_busy(struct vfspnode *);
+int pnode_umount_vfs(struct vfspnode *, struct dentry *, struct dentry *, int);
 void pnode_add_slave_mnt(struct vfspnode *, struct vfsmount *);
 void pnode_add_member_mnt(struct vfspnode *, struct vfsmount *);
 void pnode_del_slave_mnt(struct vfsmount *);
@@ -87,4 +89,7 @@ int pnode_prepare_mount(struct vfspnode 
 		struct vfsmount *, struct vfsmount *);
 int pnode_commit_mount(struct vfspnode *, int);
 int pnode_abort_mount(struct vfspnode *, struct vfsmount *);
+int pnode_umount(struct vfspnode *, struct dentry *, struct dentry *);
+int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *,
+		struct vfsmount *);
 #endif /* _LINUX_PNODE_H */
