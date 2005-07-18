Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVGRHTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVGRHTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGRHKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:10:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51139 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261573AbVGRHHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:07:15 -0400
Message-Id: <20050718070701.849932000@localhost>
References: <20050718065311.210001000@localhost>
Date: Sun, 17 Jul 2005 23:53:16 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
       bfields@fieldses.org, Andrew Morton <akpm@osdl.org>,
       penberg@cs.helsinki.fi
Subject: [RFC-2 PATCH 5/8] shared subtree
Content-Type: text/x-patch; name=umount.patch
Content-Disposition: inline; filename=umount.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds ability to unmount a shared/slave/unclone/private tree

RP

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |   68 +++++++++++++++++++++++++-----
 fs/pnode.c            |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    3 +
 include/linux/pnode.h |    5 ++
 4 files changed, 177 insertions(+), 11 deletions(-)

Index: 2.6.12.work1/fs/pnode.c
===================================================================
--- 2.6.12.work1.orig/fs/pnode.c
+++ 2.6.12.work1/fs/pnode.c
@@ -273,6 +273,117 @@ int pnode_merge_pnode(struct vfspnode *p
 	return 0;
 }
 
+static int vfs_busy(struct vfsmount *mnt, struct dentry *dentry,
+		struct dentry *rootdentry, struct vfsmount *origmnt)
+{
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
+	int ret=0;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+
+	context.start = pnode;
+	context.pnode = NULL;
+	while (pnode_next(&context)) {
+		pnode = context.pnode;
+
+		// traverse member vfsmounts
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_busy(member_mnt, mntpt,
+					root, mnt)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_busy(slave_mnt, mntpt,
+					root, mnt)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		spin_unlock(&vfspnode_lock);
+	}
+out:
+	return ret;
+}
+
+int vfs_umount(struct vfsmount *mnt, struct dentry *dentry,
+		struct dentry *rootdentry)
+{
+	struct vfsmount *child_mnt;
+
+	spin_unlock(&vfsmount_lock);
+	child_mnt = __lookup_mnt(mnt, dentry, rootdentry);
+	spin_lock(&vfsmount_lock);
+	mntput(child_mnt);
+	if (child_mnt && list_empty(&child_mnt->mnt_mounts)) {
+		do_detach_mount(child_mnt);
+		if (child_mnt->mnt_pnode)
+			pnode_disassociate_mnt(child_mnt);
+	}
+	return 0;
+}
+
+int pnode_umount(struct vfspnode *pnode, struct dentry *dentry,
+			struct dentry *rootdentry)
+{
+	int ret=0;
+     	struct vfsmount *slave_mnt, *member_mnt, *t_m;
+	struct pcontext context;
+
+	context.start = pnode;
+	context.pnode = NULL;
+	while (pnode_next(&context)) {
+		pnode = context.pnode;
+		// traverse member vfsmounts
+		spin_lock(&vfspnode_lock);
+		list_for_each_entry_safe(member_mnt,
+			t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_umount(member_mnt,
+					dentry, rootdentry)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		list_for_each_entry_safe(slave_mnt, t_m,
+			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
+			spin_unlock(&vfspnode_lock);
+			if ((ret = vfs_umount(slave_mnt,
+					dentry, rootdentry)))
+				goto out;
+			spin_lock(&vfspnode_lock);
+		}
+		spin_unlock(&vfspnode_lock);
+	}
+out:
+	return ret;
+}
+
 /*
  * @pnode: pnode that contains the vfsmounts, on which the
  *  		new mount is created at dentry 'dentry'
@@ -532,6 +643,7 @@ int pnode_real_mount(struct vfspnode *pn
 			if ((ret = vfs_real_mount_func(member_mnt,
 							flag)))
 				goto out;
+			spin_lock(&vfspnode_lock);
 		}
 		list_for_each_entry_safe(slave_mnt, t_m,
 			&pnode->pnode_slavevfs, mnt_pnode_mntlist) {
Index: 2.6.12.work1/fs/namespace.c
===================================================================
--- 2.6.12.work1.orig/fs/namespace.c
+++ 2.6.12.work1/fs/namespace.c
@@ -352,6 +352,7 @@ struct seq_operations mounts_op = {
  * open files, pwds, chroots or sub mounts that are
  * busy.
  */
+//TOBEFIXED
 int may_umount_tree(struct vfsmount *mnt)
 {
 	struct list_head *next;
@@ -394,6 +395,20 @@ resume:
 
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
@@ -409,13 +424,27 @@ EXPORT_SYMBOL(may_umount_tree);
  */
 int may_umount(struct vfsmount *mnt)
 {
-	if (atomic_read(&mnt->mnt_count) > 2)
+	if (mount_busy(mnt))
 		return -EBUSY;
 	return 0;
 }
 
 EXPORT_SYMBOL(may_umount);
 
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
 void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
@@ -430,20 +459,35 @@ void umount_tree(struct vfsmount *mnt)
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_fslink);
-		if (mnt->mnt_parent == mnt) {
-			spin_unlock(&vfsmount_lock);
+		if (mnt->mnt_parent != mnt &&
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
@@ -524,7 +568,7 @@ static int do_umount(struct vfsmount *mn
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
+	if (flags & MNT_DETACH || !mount_busy(mnt)) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
@@ -900,7 +944,9 @@ detach_recursive_mnt(struct vfsmount *so
 
 	detach_mnt(source_mnt, nd);
 	for (m = source_mnt; m; m = next_mnt(m, source_mnt)) {
+		spin_lock(&vfspnode_lock);
 		list_del_init(&m->mnt_pnode_mntlist);
+		spin_unlock(&vfspnode_lock);
 	}
 	return;
 }
Index: 2.6.12.work1/include/linux/fs.h
===================================================================
--- 2.6.12.work1.orig/include/linux/fs.h
+++ 2.6.12.work1/include/linux/fs.h
@@ -1216,11 +1216,14 @@ extern struct vfsmount *kern_mount(struc
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
+extern int do_umount(struct vfsmount *, int);
 extern struct vfsmount *do_attach_prepare_mnt(struct vfsmount *,
 		struct dentry *, struct vfsmount *, int );
 extern void do_attach_real_mnt(struct vfsmount *);
 extern struct vfsmount *do_make_mounted(struct vfsmount *, struct dentry *);
 extern int do_make_unmounted(struct vfsmount *);
+extern void do_detach_mount(struct vfsmount *);
+extern int do_refcount_check(struct vfsmount *, int );
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
Index: 2.6.12.work1/include/linux/pnode.h
===================================================================
--- 2.6.12.work1.orig/include/linux/pnode.h
+++ 2.6.12.work1/include/linux/pnode.h
@@ -70,6 +70,9 @@ put_pnode_locked(struct vfspnode *pnode)
 
 void __init pnode_init(unsigned long );
 struct vfspnode * pnode_alloc(void);
+void pnode_free(struct vfspnode *);
+int pnode_is_busy(struct vfspnode *);
+int pnode_umount_vfs(struct vfspnode *, struct dentry *, struct dentry *, int);
 void pnode_add_slave_mnt(struct vfspnode *, struct vfsmount *);
 void pnode_add_member_mnt(struct vfspnode *, struct vfsmount *);
 void pnode_del_slave_mnt(struct vfsmount *);
@@ -82,4 +85,6 @@ int  pnode_make_unmounted(struct vfspnod
 int pnode_prepare_mount(struct vfspnode *, struct vfspnode *, struct dentry *,
 		struct vfsmount *, struct vfsmount *);
 int pnode_real_mount(struct vfspnode *, int);
+int pnode_umount(struct vfspnode *, struct dentry *, struct dentry *);
+int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *, struct vfsmount *);
 #endif /* _LINUX_PNODE_H */
