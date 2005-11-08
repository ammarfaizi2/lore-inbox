Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVKHCGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVKHCGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKHCBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:30413 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965258AbVKHCBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:37 -0500
To: torvalds@osdl.org
Subject: [PATCH 14/18] shared mounts handling: umount
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001F3-Av@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131402017 -0500

An unmount of a mount creates a umount event on the parent. If the parent is
a shared mount, it gets propagated to all mounts in the peer group.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c         |   56 +++++++++++++++++++++----------
 fs/pnode.c             |   87 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/pnode.h             |    2 +
 include/linux/dcache.h |    1 +
 include/linux/fs.h     |    2 +
 5 files changed, 128 insertions(+), 20 deletions(-)

9eeda77dfca5c1193fcf9702d2921e3545362c19
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -86,31 +86,44 @@ void free_vfsmnt(struct vfsmount *mnt)
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
@@ -404,9 +417,12 @@ EXPORT_SYMBOL(may_umount_tree);
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
@@ -433,7 +449,7 @@ void release_mounts(struct list_head *he
 	}
 }
 
-void umount_tree(struct vfsmount *mnt, struct list_head *kill)
+void umount_tree(struct vfsmount *mnt, int propagate, struct list_head *kill)
 {
 	struct vfsmount *p;
 
@@ -442,6 +458,9 @@ void umount_tree(struct vfsmount *mnt, s
 		list_add(&p->mnt_hash, kill);
 	}
 
+	if (propagate)
+		propagate_umount(kill);
+
 	list_for_each_entry(p, kill, mnt_hash) {
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
@@ -450,6 +469,7 @@ void umount_tree(struct vfsmount *mnt, s
 		list_del_init(&p->mnt_child);
 		if (p->mnt_parent != p)
 			mnt->mnt_mountpoint->d_mounted--;
+		change_mnt_propagation(p, MS_PRIVATE);
 	}
 }
 
@@ -526,9 +546,9 @@ static int do_umount(struct vfsmount *mn
 	event++;
 
 	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
+	if (flags & MNT_DETACH || !propagate_mount_busy(mnt, 2)) {
 		if (!list_empty(&mnt->mnt_list))
-			umount_tree(mnt, &umount_list);
+			umount_tree(mnt, 1, &umount_list);
 		retval = 0;
 	}
 	spin_unlock(&vfsmount_lock);
@@ -651,7 +671,7 @@ Enomem:
 	if (res) {
 		LIST_HEAD(umount_list);
 		spin_lock(&vfsmount_lock);
-		umount_tree(res, &umount_list);
+		umount_tree(res, 0, &umount_list);
 		spin_unlock(&vfsmount_lock);
 		release_mounts(&umount_list);
 	}
@@ -827,7 +847,7 @@ static int do_loopback(struct nameidata 
 	if (err) {
 		LIST_HEAD(umount_list);
 		spin_lock(&vfsmount_lock);
-		umount_tree(mnt, &umount_list);
+		umount_tree(mnt, 0, &umount_list);
 		spin_unlock(&vfsmount_lock);
 		release_mounts(&umount_list);
 	}
@@ -1023,12 +1043,12 @@ static void expire_mount(struct vfsmount
 	 * Check that it is still dead: the count should now be 2 - as
 	 * contributed by the vfsmount parent and the mntget above
 	 */
-	if (atomic_read(&mnt->mnt_count) == 2) {
+	if (!propagate_mount_busy(mnt, 2)) {
 		/* delete from the namespace */
 		touch_namespace(mnt->mnt_namespace);
 		list_del_init(&mnt->mnt_list);
 		mnt->mnt_namespace = NULL;
-		umount_tree(mnt, umounts);
+		umount_tree(mnt, 1, umounts);
 		spin_unlock(&vfsmount_lock);
 	} else {
 		/*
@@ -1647,7 +1667,7 @@ void __put_namespace(struct namespace *n
 	spin_unlock(&vfsmount_lock);
 	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
-	umount_tree(root, &umount_list);
+	umount_tree(root, 0, &umount_list);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace_sem);
 	release_mounts(&umount_list);
diff --git a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -99,9 +99,94 @@ out:
 	while (!list_empty(&tmp_list)) {
 		child = list_entry(tmp_list.next, struct vfsmount, mnt_hash);
 		list_del_init(&child->mnt_hash);
-		umount_tree(child, &umount_list);
+		umount_tree(child, 0, &umount_list);
 	}
 	spin_unlock(&vfsmount_lock);
 	release_mounts(&umount_list);
 	return ret;
 }
+
+/*
+ * return true if the refcount is greater than count
+ */
+static inline int do_refcount_check(struct vfsmount *mnt, int count)
+{
+	int mycount = atomic_read(&mnt->mnt_count);
+	return (mycount > count);
+}
+
+/*
+ * check if the mount 'mnt' can be unmounted successfully.
+ * @mnt: the mount to be checked for unmount
+ * NOTE: unmounting 'mnt' would naturally propagate to all
+ * other mounts its parent propagates to.
+ * Check if any of these mounts that **do not have submounts**
+ * have more references than 'refcnt'. If so return busy.
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
+	for (m = propagation_next(parent, parent); m;
+	     		m = propagation_next(m, parent)) {
+		child = __lookup_mnt(m, mnt->mnt_mountpoint, 0);
+		if (child && list_empty(&child->mnt_mounts) &&
+		    (ret = do_refcount_check(child, 1)))
+			break;
+	}
+	return ret;
+}
+
+/*
+ * NOTE: unmounting 'mnt' naturally propagates to all other mounts its
+ * parent propagates to.
+ */
+static void __propagate_umount(struct vfsmount *mnt)
+{
+	struct vfsmount *parent = mnt->mnt_parent;
+	struct vfsmount *m;
+
+	BUG_ON(parent == mnt);
+
+	for (m = propagation_next(parent, parent); m;
+			m = propagation_next(m, parent)) {
+
+		struct vfsmount *child = __lookup_mnt(m,
+					mnt->mnt_mountpoint, 0);
+		/*
+		 * umount the child only if the child has no
+		 * other children
+		 */
+		if (child && list_empty(&child->mnt_mounts)) {
+			list_del(&child->mnt_hash);
+			list_add_tail(&child->mnt_hash, &mnt->mnt_hash);
+		}
+	}
+}
+
+/*
+ * collect all mounts that receive propagation from the mount in @list,
+ * and return these additional mounts in the same list.
+ * @list: the list of mounts to be unmounted.
+ */
+int propagate_umount(struct list_head *list)
+{
+	struct vfsmount *mnt;
+
+	list_for_each_entry(mnt, list, mnt_hash)
+		__propagate_umount(mnt);
+	return 0;
+}
diff --git a/fs/pnode.h b/fs/pnode.h
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -29,4 +29,6 @@ static inline void set_mnt_shared(struct
 void change_mnt_propagation(struct vfsmount *, int);
 int propagate_mnt(struct vfsmount *, struct dentry *, struct vfsmount *,
 		struct list_head *);
+int propagate_umount(struct list_head *);
+int propagate_mount_busy(struct vfsmount *, int);
 #endif /* _LINUX_PNODE_H */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -329,6 +329,7 @@ static inline int d_mountpoint(struct de
 }
 
 extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
+extern struct vfsmount *__lookup_mnt(struct vfsmount *, struct dentry *, int);
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 
 extern int sysctl_vfs_cache_pressure;
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1251,7 +1251,7 @@ extern int unregister_filesystem(struct 
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
-extern void umount_tree(struct vfsmount *, struct list_head *);
+extern void umount_tree(struct vfsmount *, int, struct list_head *);
 extern void release_mounts(struct list_head *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
 extern struct vfsmount *copy_tree(struct vfsmount *, struct dentry *, int);
