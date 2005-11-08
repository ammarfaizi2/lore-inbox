Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVKHCH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVKHCH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVKHCBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23757 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965175AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 4/18] make /proc/mounts pollable
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ej-9n@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1131401749 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c            |   30 +++++++++++++++++++++-
 fs/proc/base.c            |   62 ++++++++++++++++++++++++++++++++++-----------
 include/linux/namespace.h |    2 +
 3 files changed, 78 insertions(+), 16 deletions(-)

c98fca13440a0bbf547987f418e36e2e486e842c
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -37,7 +37,9 @@ static inline int sysfs_init(void)
 #endif
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
- __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
+__cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
+
+static int event;
 
 static struct list_head *mount_hashtable;
 static int hash_mask __read_mostly, hash_bits __read_mostly;
@@ -111,6 +113,22 @@ static inline int check_mnt(struct vfsmo
 	return mnt->mnt_namespace == current->namespace;
 }
 
+static void touch_namespace(struct namespace *ns)
+{
+	if (ns) {
+		ns->event = ++event;
+		wake_up_interruptible(&ns->poll);
+	}
+}
+
+static void __touch_namespace(struct namespace *ns)
+{
+	if (ns && ns->event != event) {
+		ns->event = event;
+		wake_up_interruptible(&ns->poll);
+	}
+}
+
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
 	old_nd->dentry = mnt->mnt_mountpoint;
@@ -384,6 +402,7 @@ static void umount_tree(struct vfsmount 
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		list_del(&p->mnt_list);
 		list_add(&p->mnt_list, &kill);
+		__touch_namespace(p->mnt_namespace);
 		p->mnt_namespace = NULL;
 	}
 
@@ -473,6 +492,7 @@ static int do_umount(struct vfsmount *mn
 
 	down_write(&current->namespace->sem);
 	spin_lock(&vfsmount_lock);
+	event++;
 
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
@@ -634,6 +654,7 @@ static int graft_tree(struct vfsmount *m
 		list_splice(&head, current->namespace->list.prev);
 		mntget(mnt);
 		err = 0;
+		touch_namespace(current->namespace);
 	}
 	spin_unlock(&vfsmount_lock);
 out_unlock:
@@ -771,6 +792,7 @@ static int do_move_mount(struct nameidat
 
 	detach_mnt(old_nd.mnt, &parent_nd);
 	attach_mnt(old_nd.mnt, nd);
+	touch_namespace(current->namespace);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
@@ -877,6 +899,7 @@ static void expire_mount(struct vfsmount
 		struct nameidata old_nd;
 
 		/* delete from the namespace */
+		touch_namespace(mnt->mnt_namespace);
 		list_del_init(&mnt->mnt_list);
 		mnt->mnt_namespace = NULL;
 		detach_mnt(mnt, &old_nd);
@@ -1114,6 +1137,8 @@ int copy_namespace(int flags, struct tas
 	atomic_set(&new_ns->count, 1);
 	init_rwsem(&new_ns->sem);
 	INIT_LIST_HEAD(&new_ns->list);
+	init_waitqueue_head(&new_ns->poll);
+	new_ns->event = 0;
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
@@ -1377,6 +1402,7 @@ asmlinkage long sys_pivot_root(const cha
 	detach_mnt(user_nd.mnt, &root_parent);
 	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
 	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
+	touch_namespace(current->namespace);
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);
@@ -1413,6 +1439,8 @@ static void __init init_mount_tree(void)
 	atomic_set(&namespace->count, 1);
 	INIT_LIST_HEAD(&namespace->list);
 	init_rwsem(&namespace->sem);
+	init_waitqueue_head(&namespace->poll);
+	namespace->event = 0;
 	list_add(&mnt->mnt_list, &namespace->list);
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
diff --git a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -70,6 +70,7 @@
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
+#include <linux/poll.h>
 #include "internal.h"
 
 /*
@@ -660,26 +661,38 @@ static struct file_operations proc_smaps
 #endif
 
 extern struct seq_operations mounts_op;
+struct proc_mounts {
+	struct seq_file m;
+	int event;
+};
+
 static int mounts_open(struct inode *inode, struct file *file)
 {
 	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, &mounts_op);
+	struct namespace *namespace;
+	struct proc_mounts *p;
+	int ret = -EINVAL;
 
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		struct namespace *namespace;
-		task_lock(task);
-		namespace = task->namespace;
-		if (namespace)
-			get_namespace(namespace);
-		task_unlock(task);
-
-		if (namespace)
-			m->private = namespace;
-		else {
-			seq_release(inode, file);
-			ret = -EINVAL;
+	task_lock(task);
+	namespace = task->namespace;
+	if (namespace)
+		get_namespace(namespace);
+	task_unlock(task);
+
+	if (namespace) {
+		ret = -ENOMEM;
+		p = kmalloc(sizeof(struct proc_mounts), GFP_KERNEL);
+		if (p) {
+			file->private_data = &p->m;
+			ret = seq_open(file, &mounts_op);
+			if (!ret) {
+				p->m.private = namespace;
+				p->event = namespace->event;
+				return 0;
+			}
+			kfree(p);
 		}
+		put_namespace(namespace);
 	}
 	return ret;
 }
@@ -692,11 +705,30 @@ static int mounts_release(struct inode *
 	return seq_release(inode, file);
 }
 
+static unsigned mounts_poll(struct file *file, poll_table *wait)
+{
+	struct proc_mounts *p = file->private_data;
+	struct namespace *ns = p->m.private;
+	unsigned res = 0;
+
+	poll_wait(file, &ns->poll, wait);
+
+	spin_lock(&vfsmount_lock);
+	if (p->event != ns->event) {
+		p->event = ns->event;
+		res = POLLERR;
+	}
+	spin_unlock(&vfsmount_lock);
+
+	return res;
+}
+
 static struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
+	.poll		= mounts_poll,
 };
 
 #define PROC_BLOCK_SIZE	(3*1024)		/* 4K page size but our output routines use some slack for overruns */
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -10,6 +10,8 @@ struct namespace {
 	struct vfsmount *	root;
 	struct list_head	list;
 	struct rw_semaphore	sem;
+	wait_queue_head_t poll;
+	int event;
 };
 
 extern int copy_namespace(int, struct task_struct *);
