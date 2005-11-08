Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVKHCBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVKHCBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVKHCBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25549 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965187AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 9/18] making namespace_sem global
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Et-6y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401871 -0500

This patch removes the per-namespace semaphore in favor of a global
semaphore.  This can have an effect on namespace scalability.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c            |   46 +++++++++++++++++++++++----------------------
 include/linux/namespace.h |    1 -
 2 files changed, 23 insertions(+), 24 deletions(-)

8d434ff8a070f92db956b06f05459e5b7865cf7c
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -46,6 +46,7 @@ static int event;
 static struct list_head *mount_hashtable;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
 static kmem_cache_t *mnt_cache;
+static struct rw_semaphore namespace_sem;
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -250,7 +251,7 @@ static void *m_start(struct seq_file *m,
 	struct list_head *p;
 	loff_t l = *pos;
 
-	down_read(&n->sem);
+	down_read(&namespace_sem);
 	list_for_each(p, &n->list)
 		if (!l--)
 			return list_entry(p, struct vfsmount, mnt_list);
@@ -267,8 +268,7 @@ static void *m_next(struct seq_file *m, 
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct namespace *n = m->private;
-	up_read(&n->sem);
+	up_read(&namespace_sem);
 }
 
 static inline void mangle(struct seq_file *m, const char *s)
@@ -487,7 +487,7 @@ static int do_umount(struct vfsmount *mn
 		return retval;
 	}
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 	event++;
 
@@ -500,7 +500,7 @@ static int do_umount(struct vfsmount *mn
 	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	release_mounts(&umount_list);
 	return retval;
 }
@@ -678,7 +678,7 @@ static int do_loopback(struct nameidata 
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
 		goto out;
@@ -702,7 +702,7 @@ static int do_loopback(struct nameidata 
 	}
 
 out:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	path_release(&old_nd);
 	return err;
 }
@@ -750,7 +750,7 @@ static int do_move_mount(struct nameidat
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 	err = -EINVAL;
@@ -795,7 +795,7 @@ out2:
 out1:
 	up(&nd->dentry->d_inode->i_sem);
 out:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	if (!err)
 		path_release(&parent_nd);
 	path_release(&old_nd);
@@ -834,7 +834,7 @@ int do_add_mount(struct vfsmount *newmnt
 {
 	int err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	/* Something was mounted here while we slept */
 	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
@@ -862,11 +862,11 @@ int do_add_mount(struct vfsmount *newmnt
 		list_add_tail(&newmnt->mnt_expire, fslist);
 		spin_unlock(&vfsmount_lock);
 	}
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	return 0;
 
 unlock:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	mntput(newmnt);
 	return err;
 }
@@ -958,9 +958,9 @@ void mark_mounts_for_expiry(struct list_
 		get_namespace(namespace);
 
 		spin_unlock(&vfsmount_lock);
-		down_write(&namespace->sem);
+		down_write(&namespace_sem);
 		expire_mount(mnt, mounts, &umounts);
-		up_write(&namespace->sem);
+		up_write(&namespace_sem);
 		release_mounts(&umounts);
 		mntput(mnt);
 		put_namespace(namespace);
@@ -1127,17 +1127,16 @@ int copy_namespace(int flags, struct tas
 		goto out;
 
 	atomic_set(&new_ns->count, 1);
-	init_rwsem(&new_ns->sem);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
 	new_ns->event = 0;
 
-	down_write(&tsk->namespace->sem);
+	down_write(&namespace_sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root,
 					CL_EXPIRE);
 	if (!new_ns->root) {
-		up_write(&tsk->namespace->sem);
+		up_write(&namespace_sem);
 		kfree(new_ns);
 		goto out;
 	}
@@ -1171,7 +1170,7 @@ int copy_namespace(int flags, struct tas
 		p = next_mnt(p, namespace->root);
 		q = next_mnt(q, new_ns->root);
 	}
-	up_write(&tsk->namespace->sem);
+	up_write(&namespace_sem);
 
 	tsk->namespace = new_ns;
 
@@ -1356,7 +1355,7 @@ asmlinkage long sys_pivot_root(const cha
 	user_nd.mnt = mntget(current->fs->rootmnt);
 	user_nd.dentry = dget(current->fs->root);
 	read_unlock(&current->fs->lock);
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	down(&old_nd.dentry->d_inode->i_sem);
 	error = -EINVAL;
 	if (!check_mnt(user_nd.mnt))
@@ -1407,7 +1406,7 @@ asmlinkage long sys_pivot_root(const cha
 	path_release(&parent_nd);
 out2:
 	up(&old_nd.dentry->d_inode->i_sem);
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	path_release(&user_nd);
 	path_release(&old_nd);
 out1:
@@ -1434,7 +1433,6 @@ static void __init init_mount_tree(void)
 		panic("Can't allocate initial namespace");
 	atomic_set(&namespace->count, 1);
 	INIT_LIST_HEAD(&namespace->list);
-	init_rwsem(&namespace->sem);
 	init_waitqueue_head(&namespace->poll);
 	namespace->event = 0;
 	list_add(&mnt->mnt_list, &namespace->list);
@@ -1459,6 +1457,8 @@ void __init mnt_init(unsigned long mempa
 	unsigned int nr_hash;
 	int i;
 
+	init_rwsem(&namespace_sem);
+
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
 			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL, NULL);
 
@@ -1507,11 +1507,11 @@ void __put_namespace(struct namespace *n
 	LIST_HEAD(umount_list);
 	namespace->root = NULL;
 	spin_unlock(&vfsmount_lock);
-	down_write(&namespace->sem);
+	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 	umount_tree(root, &umount_list);
 	spin_unlock(&vfsmount_lock);
-	up_write(&namespace->sem);
+	up_write(&namespace_sem);
 	release_mounts(&umount_list);
 	kfree(namespace);
 }
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -9,7 +9,6 @@ struct namespace {
 	atomic_t		count;
 	struct vfsmount *	root;
 	struct list_head	list;
-	struct rw_semaphore	sem;
 	wait_queue_head_t poll;
 	int event;
 };
