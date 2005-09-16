Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbVIPS1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbVIPS1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbVIPS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:27:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:64173 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161233AbVIPS1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:27:41 -0400
Date: Fri, 16 Sep 2005 11:26:19 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 4/10] vfs: global namespace semaphore 
Message-ID: <20050916182619.GA28474@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the per-namespace semaphore in favor of a global
semaphore.  This can have an effect on namespace scalability.


Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

 fs/namespace.c            |   44 ++++++++++++++++++++++----------------------
 include/linux/namespace.h |    1 -
 2 files changed, 22 insertions(+), 23 deletions(-)

Index: 2.6.13.sharedsubtree/include/linux/namespace.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/namespace.h
+++ 2.6.13.sharedsubtree/include/linux/namespace.h
@@ -7,11 +7,10 @@
 
 struct namespace {
 	atomic_t		count;
 	struct vfsmount *	root;
 	struct list_head	list;
-	struct rw_semaphore	sem;
 };
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
 
Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -41,10 +41,11 @@ static inline int sysfs_init(void)
 __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
 
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache;
+static struct rw_semaphore namespace_sem;
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long)mnt / L1_CACHE_BYTES);
 	tmp += ((unsigned long)dentry / L1_CACHE_BYTES);
@@ -190,11 +191,11 @@ static void *m_start(struct seq_file *m,
 {
 	struct namespace *n = m->private;
 	struct list_head *p;
 	loff_t l = *pos;
 
-	down_read(&n->sem);
+	down_read(&namespace_sem);
 	list_for_each(p, &n->list)
 	    if (!l--)
 		return list_entry(p, struct vfsmount, mnt_list);
 	return NULL;
 }
@@ -207,12 +208,11 @@ static void *m_next(struct seq_file *m, 
 	return p == &n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct namespace *n = m->private;
-	up_read(&n->sem);
+	up_read(&namespace_sem);
 }
 
 static inline void mangle(struct seq_file *m, const char *s)
 {
 	seq_escape(m, s, " \t\n\\");
@@ -434,11 +434,11 @@ static int do_umount(struct vfsmount *mn
 		}
 		up_write(&sb->s_umount);
 		return retval;
 	}
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 
 	if (atomic_read(&sb->s_active) == 1) {
 		/* last instance - try to be smart */
 		spin_unlock(&vfsmount_lock);
@@ -456,11 +456,11 @@ static int do_umount(struct vfsmount *mn
 		retval = 0;
 	}
 	spin_unlock(&vfsmount_lock);
 	if (retval)
 		security_sb_umount_busy(mnt);
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	return retval;
 }
 
 /*
  * Now umount can handle mount points as well as block devices.
@@ -681,11 +681,11 @@ static int do_loopback(struct nameidata 
 		return -EINVAL;
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	err = -EINVAL;
 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
 		err = -ENOMEM;
 		if (recurse)
 			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
@@ -706,11 +706,11 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
 	}
 
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	path_release(&old_nd);
 	return err;
 }
 
 /*
@@ -754,11 +754,11 @@ static int do_move_mount(struct nameidat
 		return -EINVAL;
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
 		goto out;
 
@@ -797,11 +797,11 @@ static int do_move_mount(struct nameidat
       out2:
 	spin_unlock(&vfsmount_lock);
       out1:
 	up(&nd->dentry->d_inode->i_sem);
       out:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	if (!err)
 		path_release(&parent_nd);
 	path_release(&old_nd);
 	return err;
 }
@@ -836,11 +836,11 @@ static int do_new_mount(struct nameidata
 int do_add_mount(struct vfsmount *newmnt, struct nameidata *nd,
 		 int mnt_flags, struct list_head *fslist)
 {
 	int err;
 
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	/* Something was mounted here while we slept */
 	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;
 	err = -EINVAL;
 	if (!check_mnt(nd->mnt))
 		goto unlock;
@@ -865,11 +865,11 @@ int do_add_mount(struct vfsmount *newmnt
 		list_add_tail(&newmnt->mnt_expire, fslist);
 		spin_unlock(&vfsmount_lock);
 	}
 
       unlock:
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	mntput(newmnt);
 	return err;
 }
 
 EXPORT_SYMBOL_GPL(do_add_mount);
@@ -969,13 +969,13 @@ void mark_mounts_for_expiry(struct list_
 		if (!namespace || !namespace->root)
 			continue;
 		get_namespace(namespace);
 
 		spin_unlock(&vfsmount_lock);
-		down_write(&namespace->sem);
+		down_write(&namespace_sem);
 		expire_mount(mnt, mounts);
-		up_write(&namespace->sem);
+		up_write(&namespace_sem);
 
 		mntput(mnt);
 		put_namespace(namespace);
 
 		spin_lock(&vfsmount_lock);
@@ -1141,18 +1141,17 @@ int copy_namespace(int flags, struct tas
 	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
 
 	atomic_set(&new_ns->count, 1);
-	init_rwsem(&new_ns->sem);
 	INIT_LIST_HEAD(&new_ns->list);
 
-	down_write(&tsk->namespace->sem);
+	down_write(&namespace_sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
 	if (!new_ns->root) {
-		up_write(&tsk->namespace->sem);
+		up_write(&namespace_sem);
 		kfree(new_ns);
 		goto out;
 	}
 	spin_lock(&vfsmount_lock);
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
@@ -1182,11 +1181,11 @@ int copy_namespace(int flags, struct tas
 			}
 		}
 		p = next_mnt(p, namespace->root);
 		q = next_mnt(q, new_ns->root);
 	}
-	up_write(&tsk->namespace->sem);
+	up_write(&namespace_sem);
 
 	tsk->namespace = new_ns;
 
 	if (rootmnt)
 		mntput(rootmnt);
@@ -1368,11 +1367,11 @@ asmlinkage long sys_pivot_root(const cha
 
 	read_lock(&current->fs->lock);
 	user_nd.mnt = mntget(current->fs->rootmnt);
 	user_nd.dentry = dget(current->fs->root);
 	read_unlock(&current->fs->lock);
-	down_write(&current->namespace->sem);
+	down_write(&namespace_sem);
 	down(&old_nd.dentry->d_inode->i_sem);
 	error = -EINVAL;
 	if (!check_mnt(user_nd.mnt))
 		goto out2;
 	error = -ENOENT;
@@ -1414,11 +1413,11 @@ asmlinkage long sys_pivot_root(const cha
 	error = 0;
 	path_release(&root_parent);
 	path_release(&parent_nd);
       out2:
 	up(&old_nd.dentry->d_inode->i_sem);
-	up_write(&current->namespace->sem);
+	up_write(&namespace_sem);
 	path_release(&user_nd);
 	path_release(&old_nd);
       out1:
 	path_release(&new_nd);
       out0:
@@ -1441,11 +1440,10 @@ static void __init init_mount_tree(void)
 	namespace = kmalloc(sizeof(*namespace), GFP_KERNEL);
 	if (!namespace)
 		panic("Can't allocate initial namespace");
 	atomic_set(&namespace->count, 1);
 	INIT_LIST_HEAD(&namespace->list);
-	init_rwsem(&namespace->sem);
 	list_add(&mnt->mnt_list, &namespace->list);
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
 
 	init_task.namespace = namespace;
@@ -1465,10 +1463,12 @@ void __init mnt_init(unsigned long mempa
 {
 	struct list_head *d;
 	unsigned int nr_hash;
 	int i;
 
+	init_rwsem(&namespace_sem);
+
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
 				      0, SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL,
 				      NULL);
 
 	mount_hashtable = (struct list_head *)
@@ -1514,12 +1514,12 @@ void __init mnt_init(unsigned long mempa
 void __put_namespace(struct namespace *namespace)
 {
 	struct vfsmount *root = namespace->root;
 	namespace->root = NULL;
 	spin_unlock(&vfsmount_lock);
-	down_write(&namespace->sem);
+	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
 	umount_tree(root);
 	spin_unlock(&vfsmount_lock);
-	up_write(&namespace->sem);
+	up_write(&namespace_sem);
 	kfree(namespace);
 }
