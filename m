Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbVIPS02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbVIPS02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbVIPS01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:26:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51133 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161229AbVIPS0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:26:24 -0400
Date: Fri, 16 Sep 2005 11:26:20 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 7/10] vfs: shared subtree aware unmounts 
Message-ID: <20050916182620.GA28518@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that help umount a mount. The mount can either be shared,slave,private or
unclonable.

An unmount of a mount creates a umount event on the parent. If the parent is
a shared mount, it gets propagated to all mounts down the propagation tree.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c         |   68 ++++++++++++++++++++++++++++++-----------
 fs/pnode.c             |   80 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |    1 
 include/linux/fs.h     |    1 
 include/linux/pnode.h  |    2 +
 5 files changed, 134 insertions(+), 18 deletions(-)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -84,35 +84,48 @@ void free_vfsmnt(struct vfsmount *mnt)
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
 }
 
 /*
- * Now, lookup_mnt increments the ref count before returning
- * the vfsmount struct.
+ * find the first or last mount at @dentry on vfsmount @mnt depending on
+ * @dir. If @dir is set return the first mount else return the last mount.
  */
-struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
+struct vfsmount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry,
+			      int dir)
 {
 	struct list_head *head = mount_hashtable + hash(mnt, dentry);
 	struct list_head *tmp = head;
 	struct vfsmount *p, *found = NULL;
 
-	spin_lock(&vfsmount_lock);
 	for (;;) {
-		tmp = tmp->next;
+		tmp = dir ? tmp->next : tmp->prev;
 		p = NULL;
 		if (tmp == head)
 			break;
 		p = list_entry(tmp, struct vfsmount, mnt_hash);
 		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
-			found = mntget(p);
+			found = p;
 			break;
 		}
 	}
-	spin_unlock(&vfsmount_lock);
 	return found;
 }
 
+/*
+ * lookup_mnt increments the ref count before returning
+ * the vfsmount struct.
+ */
+struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct vfsmount *child_mnt;
+	spin_lock(&vfsmount_lock);
+	if ((child_mnt = __lookup_mnt(mnt, dentry, 1)))
+		mntget(child_mnt);
+	spin_unlock(&vfsmount_lock);
+	return child_mnt;
+}
+
 static inline int check_mnt(struct vfsmount *mnt)
 {
 	return mnt->mnt_namespace == current->namespace;
 }
 
@@ -369,10 +382,29 @@ int may_umount_tree(struct vfsmount *mnt
 	return 0;
 }
 
 EXPORT_SYMBOL(may_umount_tree);
 
+int mount_busy(struct vfsmount *mnt)
+{
+	return propagate_mount_busy(mnt, 2);
+}
+
+void do_detach_mount(struct vfsmount *mnt)
+{
+	struct nameidata old_nd;
+	if (mnt != mnt->mnt_parent) {
+		detach_mnt(mnt, &old_nd);
+		path_release(&old_nd);
+	}
+	list_del_init(&mnt->mnt_list);
+	list_del_init(&mnt->mnt_expire);
+	spin_unlock(&vfsmount_lock);
+	mntput(mnt);
+	spin_lock(&vfsmount_lock);
+}
+
 /**
  * may_umount - check if a mount point is busy
  * @mnt: root of mount
  *
  * This is called to check if a mount point has any
@@ -406,23 +438,23 @@ static void umount_tree(struct vfsmount 
 
 	while (!list_empty(&kill)) {
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_expire);
-		if (mnt->mnt_parent == mnt) {
-			spin_unlock(&vfsmount_lock);
-		} else {
-			struct nameidata old_nd;
-			detach_mnt(mnt, &old_nd);
-			spin_unlock(&vfsmount_lock);
-			path_release(&old_nd);
-		}
-		mntput(mnt);
-		spin_lock(&vfsmount_lock);
+		propagate_umount(mnt);
 	}
 }
 
+/*
+ * return true if the refcount is greater than count
+ */
+int do_refcount_check(struct vfsmount *mnt, int count)
+{
+	int mycount = atomic_read(&mnt->mnt_count);
+	return (mycount > count);
+}
+
 static int do_umount(struct vfsmount *mnt, int flags)
 {
 	struct super_block *sb = mnt->mnt_sb;
 	int retval;
 
@@ -500,11 +532,11 @@ static int do_umount(struct vfsmount *mn
 		unlock_kernel();
 		security_sb_umount_close(mnt);
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
+	if (flags & MNT_DETACH || !propagate_mount_busy(mnt, 2)) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
 	}
 	spin_unlock(&vfsmount_lock);
Index: 2.6.13.sharedsubtree/fs/pnode.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/pnode.c
+++ 2.6.13.sharedsubtree/fs/pnode.c
@@ -573,5 +573,85 @@ int propagate_prepare_mount(struct vfsmo
 	create_child_list(source_mnt, &tmp_list);
 	propagate_abort_mount(source_mnt);
 	spin_unlock(&vfspnode_lock);
 	return -ENOMEM;
 }
+
+/*
+ * check if the mount 'mnt' can be unmounted successfully.
+ * @mnt: the mount to be checked for unmount
+ * NOTE: unmounting 'mnt' would naturally propagate to all
+ * other mounts its parent propagates to. Hence those mounts
+ * are also to be checked for unmount.
+ */
+int propagate_mount_busy(struct vfsmount *mnt, int refcnt)
+{
+	struct vfsmount *m, *child;
+	struct vfsmount *parent = mnt->mnt_parent;
+	int ret = 0;
+
+	if (mnt == parent)
+		return do_refcount_check(mnt, refcnt);
+
+	/*
+	 * quickly check if the current mount can be unmounted.
+	 * If not, we don't have to go checking for all other
+	 * mounts
+	 */
+	if (!list_empty(&mnt->mnt_mounts) || do_refcount_check(mnt, refcnt))
+		return 1;
+
+	spin_lock(&vfspnode_lock);
+	for (m = propagation_next(parent, parent); m;
+	     m = propagation_next(m, parent)) {
+		child = __lookup_mnt(m, mnt->mnt_mountpoint, 0);
+		if (child && list_empty(&child->mnt_mounts) &&
+		    (ret = do_refcount_check(child, 1)))
+			break;
+	}
+	spin_unlock(&vfspnode_lock);
+	return ret;
+}
+
+/*
+ * umount 'mnt' and also umount any mounts that gets the propagation.
+ * @mnt: the mount to be unmounted.
+ * NOTE: unmounting 'mnt' would naturally propagate to all
+ * other mounts its parent propagates to.
+ */
+int propagate_umount(struct vfsmount *mnt)
+{
+	struct vfsmount *m, *child;
+	struct vfsmount *parent = mnt->mnt_parent;
+	LIST_HEAD(mnt_list_head);
+
+	if (mnt == parent) {
+		do_detach_mount(mnt);
+		return 0;
+	}
+
+	list_del(&mnt->mnt_list);
+	list_add(&mnt->mnt_list, &mnt_list_head);
+
+	spin_lock(&vfspnode_lock);
+	for (m = propagation_next(parent, parent); m;
+	     m = propagation_next(m, parent)) {
+		child = __lookup_mnt(m, mnt->mnt_mountpoint, 0);
+		/*
+		 * unmount the child only if the child has no
+		 * other children
+		 */
+		if (child && list_empty(&child->mnt_mounts)) {
+			list_del(&child->mnt_list);
+			list_add(&child->mnt_list, &mnt_list_head);
+		}
+	}
+	spin_unlock(&vfspnode_lock);
+
+	while (!list_empty(&mnt_list_head)) {
+		m = list_entry(mnt_list_head.next, struct vfsmount, mnt_list);
+		list_del_init(&m->mnt_list);
+		do_make_private(m);
+		do_detach_mount(m);
+	}
+	return 0;
+}
Index: 2.6.13.sharedsubtree/include/linux/pnode.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/pnode.h
+++ 2.6.13.sharedsubtree/include/linux/pnode.h
@@ -60,6 +60,8 @@ void pnode_merge_mount(struct vfsmount *
 void pnode_slave_mount(struct vfsmount *, struct vfsmount *);
 int propagate_commit_mount(struct vfsmount *);
 int propagate_abort_mount(struct vfsmount *);
 int propagate_prepare_mount(struct vfsmount *, struct dentry *,
 			    struct vfsmount *);
+int propagate_umount(struct vfsmount *);
+int propagate_mount_busy(struct vfsmount *, int);
 #endif				/* _LINUX_PNODE_H */
Index: 2.6.13.sharedsubtree/include/linux/fs.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/fs.h
+++ 2.6.13.sharedsubtree/include/linux/fs.h
@@ -1250,10 +1250,11 @@ extern struct vfsmount *clone_mnt(struct
 extern void do_attach_prepare_mnt(struct vfsmount *, struct dentry *,
 				  struct vfsmount *);
 extern void do_attach_commit_mnt(struct vfsmount *);
 extern void do_detach_prepare_mnt(struct vfsmount *);
 extern void do_detach_mount(struct vfsmount *);
+extern int do_refcount_check(struct vfsmount *, int);
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
 #define FLOCK_VERIFY_READ  1
 #define FLOCK_VERIFY_WRITE 2
Index: 2.6.13.sharedsubtree/include/linux/dcache.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/dcache.h
+++ 2.6.13.sharedsubtree/include/linux/dcache.h
@@ -327,10 +327,11 @@ static inline int d_mountpoint(struct de
 {
 	return dentry->d_mounted;
 }
 
 extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
+extern struct vfsmount *__lookup_mnt(struct vfsmount *, struct dentry *, int);
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 
 extern int sysctl_vfs_cache_pressure;
 
 #endif /* __KERNEL__ */
