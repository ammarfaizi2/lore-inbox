Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTGHKry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbTGHKrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:47:53 -0400
Received: from tmi.comex.ru ([217.10.33.92]:30084 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261985AbTGHKrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:47:00 -0400
Subject: [RFC] parallel directory operations
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net, Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Tue, 08 Jul 2003 15:01:05 +0000
Message-ID: <87wuetukpa.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


hi all!

this time linux can't perform many operations in the single directory.
following patches are intended to solve this limitation. locking is
broken into two stages: at first we protect dcache locking 'part of
directory' using hash, at second (inside ext3) we protect htree structure.
in both cases I use dynamic locks. there are several know issues to be
solved yet (say, this patches don't let several renames in single dir).

Designed by Peter Braam.


simple benchmarks:

creation of 500K files by two processes:
before: 1m41.744s
after:  1m28.837s

creation of 250K files by two processes:
before: 0m28.913s
after:  0m20.851s

creation of 500K hardlinks by two processes:
before: 1m3.126s
after:  0m48.669s

creation of 250K hardlinks by two processes:
before: 0m17.874s
after:  0m10.427s


I would to like to see any comments/suggestions.

with best regards, Alex





--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=dynamic-locks.patch


dynamic locks. supports exclusive and shared locks. exclusive lock may
be taken several times by first owner.



diff -puN /dev/null include/linux/dynlocks.h
--- /dev/null	Sun Jul 17 23:46:18 1994
+++ linux-2.5.73-alexey/include/linux/dynlocks.h	Mon Jul  7 00:12:21 2003
@@ -0,0 +1,35 @@
+#ifndef _LINUX_DYNLOCKS_H
+#define _LINUX_DYNLOCKS_H
+
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+
+struct dynlock_member {
+	struct list_head	dl_list;
+	unsigned long		dl_value;	/* lock value */
+	int			dl_refcount;	/* number of users */
+	int			dl_readers;
+	int			dl_writers;
+	int			dl_pid;		/* holder of the lock */
+	wait_queue_head_t	dl_wait;
+};
+
+/*
+ * lock's namespace:
+ *   - list of locks
+ *   - lock to protect this list
+ */
+struct dynlock {
+	struct list_head dl_list;
+	spinlock_t dl_list_lock;
+};
+
+void dynlock_init(struct dynlock *dl);
+void *dynlock_lock(struct dynlock *dl, unsigned long value, int rw, int gfp);
+void dynlock_unlock(struct dynlock *dl, void *lock);
+
+
+#endif
+
diff -puN /dev/null lib/dynlocks.c
--- /dev/null	Sun Jul 17 23:46:18 1994
+++ linux-2.5.73-alexey/lib/dynlocks.c	Mon Jul  7 00:23:47 2003
@@ -0,0 +1,150 @@
+/*
+ * Dynamic Locks
+ *
+ * struct dynlock is lockspace
+ * one may request lock (exclusive or shared) for some value
+ * in that lockspace
+ *
+ */
+
+#include <linux/dynlocks.h>
+#include <linux/module.h>
+
+/*
+ * dynlock_init
+ *
+ * initialize lockspace
+ *
+ */
+void dynlock_init(struct dynlock *dl)
+{
+	spin_lock_init(&dl->dl_list_lock);
+	INIT_LIST_HEAD(&dl->dl_list);
+}
+
+/*
+ * dynlock_lock
+ *
+ * acquires lock (exclusive or shared) in specified lockspace
+ * each lock in lockspace is allocated separately, so user have
+ * to specify GFP flags.
+ * routine returns pointer to lock. this pointer is intended to
+ * be passed to dynlock_unlock
+ *
+ */
+void *dynlock_lock(struct dynlock *dl, unsigned long value, int rw, int gfp)
+{
+	struct dynlock_member *nhl = NULL; 
+	struct dynlock_member *hl; 
+	struct list_head *cur;
+
+repeat:
+	/* find requested lock in lockspace */
+	spin_lock(&dl->dl_list_lock);
+	list_for_each(cur, &dl->dl_list) {
+		hl = list_entry(cur, struct dynlock_member, dl_list);
+		if (hl->dl_value == value) {
+			/* lock is found */
+			if (nhl) {
+				/* someone else just allocated
+				 * lock we didn't find and just created
+				 * so, we drop our lock
+				 */
+				kfree(nhl);
+				nhl = NULL;
+			}
+			hl->dl_refcount++;
+			goto found;
+		}
+	}
+	/* lock not found */
+	if (nhl) {
+		/* we already have allocated lock. use it */
+		hl = nhl;
+		nhl = NULL;
+		list_add(&hl->dl_list, &dl->dl_list);
+		goto found;
+	}
+	spin_unlock(&dl->dl_list_lock);
+	
+	/* lock not found and we haven't allocated lock yet. allocate it */
+	nhl = kmalloc(sizeof(struct dynlock_member), gfp);
+	if (nhl == NULL)
+		return NULL;
+	nhl->dl_refcount = 1;
+	nhl->dl_value = value;
+	nhl->dl_readers = 0;
+	nhl->dl_writers = 0;
+	init_waitqueue_head(&nhl->dl_wait);
+
+	/* while lock is being allocated, someone else may allocate it
+	 * and put onto to list. check this situation
+	 */
+	goto repeat;
+
+found:
+	if (rw) {
+		/* exclusive lock: user don't want to share lock at all
+		 * NOTE: one process may take the same lock several times
+		 * this functionaly is useful for rename operations */
+		while ((hl->dl_writers && hl->dl_pid != current->pid) ||
+				hl->dl_readers) {
+			spin_unlock(&dl->dl_list_lock);
+			wait_event(hl->dl_wait,
+				hl->dl_writers == 0 && hl->dl_readers == 0);
+			spin_lock(&dl->dl_list_lock);
+		}
+		hl->dl_writers++;
+	} else {
+		/* shared lock: user do not want to share lock with writer */
+		while (hl->dl_writers) {
+			spin_unlock(&dl->dl_list_lock);
+			wait_event(hl->dl_wait, hl->dl_writers == 0);
+			spin_lock(&dl->dl_list_lock);
+		}
+		hl->dl_readers++;
+	}
+	hl->dl_pid = current->pid;
+	spin_unlock(&dl->dl_list_lock);
+
+	return hl;
+}
+
+
+/*
+ * dynlock_unlock
+ *
+ * user have to specify lockspace (dl) and pointer to lock structure
+ * returned by dynlock_lock()
+ *
+ */
+void dynlock_unlock(struct dynlock *dl, void *lock)
+{
+	struct dynlock_member *hl = lock;
+	int wakeup = 0;
+	
+	spin_lock(&dl->dl_list_lock);
+	if (hl->dl_writers) {
+		hl->dl_writers--;
+		if (hl->dl_writers == 0)
+			wakeup = 1;
+	} else {
+		hl->dl_readers--;
+		if (hl->dl_readers == 0)
+			wakeup = 1;
+	}
+	if (wakeup) {
+		hl->dl_pid = 0;
+		wake_up(&hl->dl_wait);
+	}
+	if (--(hl->dl_refcount) == 0) 
+		list_del(&hl->dl_list);
+	spin_unlock(&dl->dl_list_lock);
+	if (hl->dl_refcount == 0)
+		kfree(hl);
+}
+
+EXPORT_SYMBOL(dynlock_init);
+EXPORT_SYMBOL(dynlock_lock);
+EXPORT_SYMBOL(dynlock_unlock);
+
diff -puN lib/Makefile~dynamic-locks lib/Makefile
--- linux-2.5.73/lib/Makefile~dynamic-locks	Mon Jul  7 00:12:21 2003
+++ linux-2.5.73-alexey/lib/Makefile	Mon Jul  7 00:12:21 2003
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o
+	 kobject.o idr.o dynlocks.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o

_

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=vfs-pdirops.patch


support for parallel directory operations for VFS




diff -puN fs/namei.c~vfs-pdirops fs/namei.c
--- linux-2.5.73/fs/namei.c~vfs-pdirops	Mon Jul  7 00:00:25 2003
+++ linux-2.5.73-alexey/fs/namei.c	Mon Jul  7 00:00:25 2003
@@ -27,6 +27,7 @@
 #include <linux/mount.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
+#include <linux/dynlocks.h>
 
 #define ACC_MODE(x) ("\000\004\002\006"[(x)&O_ACCMODE])
 
@@ -108,6 +109,37 @@
  * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
  * PATH_MAX includes the nul terminator --RR.
  */
+
+static void *lock_dir(struct inode *dir, struct qstr *name)
+{
+	unsigned long hash;
+	
+	if (!IS_PDIROPS(dir)) {
+		down(&dir->i_sem);
+		return 0;
+	}
+
+	/* OK. fs understands parallel directory operations.
+	 * so, we try to acquire lock for hash of requested
+	 * filename in order to prevent any operations with
+	 * same name in same time -bzzz */
+
+	/* calculate name hash */
+	hash = full_name_hash(name->name, name->len);
+
+	/* lock this hash */
+	return dynlock_lock(&dir->i_dcache_lock, hash, 1, GFP_KERNEL);
+}
+
+static void unlock_dir(struct inode *dir, void *lock)
+{
+	if (!IS_PDIROPS(dir)) {
+		up(&dir->i_sem);
+		return;
+	}
+	dynlock_unlock(&dir->i_dcache_lock, lock);
+}
+
 static inline int do_getname(const char __user *filename, char *page)
 {
 	int retval;
@@ -340,8 +372,9 @@ static struct dentry * real_lookup(struc
 {
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
+	void *lock;
 
-	down(&dir->i_sem);
+	lock = lock_dir(dir, name);
 	/*
 	 * First re-do the cached lookup just in case it was created
 	 * while we waited for the directory semaphore..
@@ -367,7 +400,7 @@ static struct dentry * real_lookup(struc
 			else
 				result = dentry;
 		}
-		up(&dir->i_sem);
+		unlock_dir(dir, lock);
 		return result;
 	}
 
@@ -375,7 +408,7 @@ static struct dentry * real_lookup(struc
 	 * Uhhuh! Nasty case: the cache was re-populated while
 	 * we waited on the semaphore. Need to revalidate.
 	 */
-	up(&dir->i_sem);
+	unlock_dir(dir, lock);
 	if (result->d_op && result->d_op->d_revalidate) {
 		if (!result->d_op->d_revalidate(result, flags) && !d_invalidate(result)) {
 			dput(result);
@@ -1056,12 +1089,19 @@ static inline int lookup_flags(unsigned 
 /*
  * p1 and p2 should be directories on the same fs.
  */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+struct dentry *lock_rename(struct nameidata *newnd, struct nameidata *oldnd)
 {
+	struct dentry *p1 = newnd->dentry;
+	struct dentry *p2 = oldnd->dentry;
 	struct dentry *p;
 
 	if (p1 == p2) {
-		down(&p1->d_inode->i_sem);
+		if (!IS_PDIROPS(p1->d_inode)) {
+			down(&p1->d_inode->i_sem);
+			return NULL;
+		}
+		oldnd->lock = lock_dir(p2->d_inode, &oldnd->last);
+		newnd->lock = lock_dir(p1->d_inode, &newnd->last);
 		return NULL;
 	}
 
@@ -1069,32 +1109,42 @@ struct dentry *lock_rename(struct dentry
 
 	for (p = p1; p->d_parent != p; p = p->d_parent) {
 		if (p->d_parent == p2) {
-			down(&p2->d_inode->i_sem);
-			down(&p1->d_inode->i_sem);
+			oldnd->lock = lock_dir(p2->d_inode, &oldnd->last);
+			newnd->lock = lock_dir(p1->d_inode, &newnd->last);
 			return p;
 		}
 	}
 
 	for (p = p2; p->d_parent != p; p = p->d_parent) {
 		if (p->d_parent == p1) {
-			down(&p1->d_inode->i_sem);
-			down(&p2->d_inode->i_sem);
+			newnd->lock = lock_dir(p1->d_inode, &newnd->last);
+			oldnd->lock = lock_dir(p2->d_inode, &oldnd->last);
 			return p;
 		}
 	}
 
-	down(&p1->d_inode->i_sem);
-	down(&p2->d_inode->i_sem);
+	newnd->lock = lock_dir(p1->d_inode, &newnd->last);
+	oldnd->lock = lock_dir(p2->d_inode, &oldnd->last);
 	return NULL;
 }
 
-void unlock_rename(struct dentry *p1, struct dentry *p2)
+void unlock_rename(struct nameidata *newnd, struct nameidata *oldnd)
 {
-	up(&p1->d_inode->i_sem);
-	if (p1 != p2) {
-		up(&p2->d_inode->i_sem);
-		up(&p1->d_inode->i_sb->s_vfs_rename_sem);
-	}
+	struct dentry *p1 = newnd->dentry;
+	struct dentry *p2 = oldnd->dentry;
+
+	if (p1 == p2) {
+		if (!IS_PDIROPS(p1->d_inode)) {
+			up(&p1->d_inode->i_sem);
+			return;
+		}
+		unlock_dir(p2->d_inode, oldnd->lock);
+		unlock_dir(p1->d_inode, newnd->lock);
+		return;
+	}
+	unlock_dir(p1->d_inode, newnd->lock);
+	unlock_dir(p2->d_inode, oldnd->lock);
+	up(&p1->d_inode->i_sb->s_vfs_rename_sem);
 }
 
 int vfs_create(struct inode *dir, struct dentry *dentry, int mode)
@@ -1214,6 +1264,7 @@ int open_namei(const char * pathname, in
 	struct dentry *dentry;
 	struct dentry *dir;
 	int count = 0;
+	void *lock;
 
 	acc_mode = ACC_MODE(flag);
 
@@ -1250,13 +1301,13 @@ int open_namei(const char * pathname, in
 		goto exit;
 
 	dir = nd->dentry;
-	down(&dir->d_inode->i_sem);
+	lock = lock_dir(dir->d_inode, &nd->last);
 	dentry = lookup_hash(&nd->last, nd->dentry);
 
 do_last:
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry)) {
-		up(&dir->d_inode->i_sem);
+		unlock_dir(dir->d_inode, lock);
 		goto exit;
 	}
 
@@ -1265,7 +1316,7 @@ do_last:
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
 		error = vfs_create(dir->d_inode, dentry, mode);
-		up(&dir->d_inode->i_sem);
+		unlock_dir(dir->d_inode, lock);
 		dput(nd->dentry);
 		nd->dentry = dentry;
 		if (error)
@@ -1279,7 +1330,7 @@ do_last:
 	/*
 	 * It already exists.
 	 */
-	up(&dir->d_inode->i_sem);
+	unlock_dir(dir->d_inode, lock);
 
 	error = -EEXIST;
 	if (flag & O_EXCL)
@@ -1353,7 +1404,7 @@ do_link:
 		goto exit;
 	}
 	dir = nd->dentry;
-	down(&dir->d_inode->i_sem);
+	lock = lock_dir(dir->d_inode, &nd->last);
 	dentry = lookup_hash(&nd->last, nd->dentry);
 	putname(nd->last.name);
 	goto do_last;
@@ -1364,7 +1415,7 @@ static struct dentry *lookup_create(stru
 {
 	struct dentry *dentry;
 
-	down(&nd->dentry->d_inode->i_sem);
+	nd->lock = lock_dir(nd->dentry->d_inode, &nd->last);
 	dentry = ERR_PTR(-EEXIST);
 	if (nd->last_type != LAST_NORM)
 		goto fail;
@@ -1444,7 +1495,7 @@ asmlinkage long sys_mknod(const char __u
 		}
 		dput(dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, nd.lock);
 	path_release(&nd);
 out:
 	putname(tmp);
@@ -1498,7 +1549,7 @@ asmlinkage long sys_mkdir(const char __u
 			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
 			dput(dentry);
 		}
-		up(&nd.dentry->d_inode->i_sem);
+		unlock_dir(nd.dentry->d_inode, nd.lock);
 		path_release(&nd);
 out:
 		putname(tmp);
@@ -1542,6 +1593,7 @@ static void d_unhash(struct dentry *dent
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int error = may_delete(dir, dentry, 1);
+	void *lock;
 
 	if (error)
 		return error;
@@ -1551,7 +1603,7 @@ int vfs_rmdir(struct inode *dir, struct 
 
 	DQUOT_INIT(dir);
 
-	down(&dentry->d_inode->i_sem);
+	lock = lock_dir(dentry->d_inode, &dentry->d_name);
 	d_unhash(dentry);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
@@ -1563,7 +1615,7 @@ int vfs_rmdir(struct inode *dir, struct 
 				dentry->d_inode->i_flags |= S_DEAD;
 		}
 	}
-	up(&dentry->d_inode->i_sem);
+	unlock_dir(dentry->d_inode, lock);
 	if (!error) {
 		inode_dir_notify(dir, DN_DELETE);
 		d_delete(dentry);
@@ -1599,14 +1651,14 @@ asmlinkage long sys_rmdir(const char __u
 			error = -EBUSY;
 			goto exit1;
 	}
-	down(&nd.dentry->d_inode->i_sem);
+	nd.lock = lock_dir(nd.dentry->d_inode, &nd.last);
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
 		dput(dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, nd.lock);
 exit1:
 	path_release(&nd);
 exit:
@@ -1617,6 +1669,7 @@ exit:
 int vfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error = may_delete(dir, dentry, 0);
+	void *lock;
 
 	if (error)
 		return error;
@@ -1626,7 +1679,7 @@ int vfs_unlink(struct inode *dir, struct
 
 	DQUOT_INIT(dir);
 
-	down(&dentry->d_inode->i_sem);
+	lock = lock_dir(dentry->d_inode, &dentry->d_name);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
@@ -1634,7 +1687,7 @@ int vfs_unlink(struct inode *dir, struct
 		if (!error)
 			error = dir->i_op->unlink(dir, dentry);
 	}
-	up(&dentry->d_inode->i_sem);
+	unlock_dir(dentry->d_inode, lock);
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
@@ -1668,7 +1721,7 @@ asmlinkage long sys_unlink(const char __
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
-	down(&nd.dentry->d_inode->i_sem);
+	nd.lock = lock_dir(nd.dentry->d_inode, &nd.last);
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
@@ -1682,7 +1735,7 @@ asmlinkage long sys_unlink(const char __
 	exit2:
 		dput(dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, nd.lock);
 exit1:
 	path_release(&nd);
 exit:
@@ -1745,7 +1798,7 @@ asmlinkage long sys_symlink(const char _
 			error = vfs_symlink(nd.dentry->d_inode, dentry, from);
 			dput(dentry);
 		}
-		up(&nd.dentry->d_inode->i_sem);
+		unlock_dir(nd.dentry->d_inode, nd.lock);
 		path_release(&nd);
 out:
 		putname(to);
@@ -1758,6 +1811,7 @@ int vfs_link(struct dentry *old_dentry, 
 {
 	struct inode *inode = old_dentry->d_inode;
 	int error;
+	void *lock;
 
 	if (!inode)
 		return -ENOENT;
@@ -1783,10 +1837,10 @@ int vfs_link(struct dentry *old_dentry, 
 	if (error)
 		return error;
 
-	down(&old_dentry->d_inode->i_sem);
+	lock = lock_dir(old_dentry->d_inode, &old_dentry->d_name);
 	DQUOT_INIT(dir);
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
-	up(&old_dentry->d_inode->i_sem);
+	unlock_dir(old_dentry->d_inode, lock);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_link(old_dentry, dir, new_dentry);
@@ -1829,7 +1883,7 @@ asmlinkage long sys_link(const char __us
 		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
 		dput(new_dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, nd.lock);
 out_release:
 	path_release(&nd);
 out:
@@ -2017,7 +2071,7 @@ static inline int do_rename(const char *
 	if (newnd.last_type != LAST_NORM)
 		goto exit2;
 
-	trap = lock_rename(new_dir, old_dir);
+	trap = lock_rename(&newnd, &oldnd);
 
 	old_dentry = lookup_hash(&oldnd.last, old_dir);
 	error = PTR_ERR(old_dentry);
@@ -2055,7 +2109,7 @@ exit5:
 exit4:
 	dput(old_dentry);
 exit3:
-	unlock_rename(new_dir, old_dir);
+	unlock_rename(&newnd, &oldnd);
 exit2:
 	path_release(&newnd);
 exit1:
diff -puN include/linux/fs.h~vfs-pdirops include/linux/fs.h
--- linux-2.5.73/include/linux/fs.h~vfs-pdirops	Mon Jul  7 00:00:25 2003
+++ linux-2.5.73-alexey/include/linux/fs.h	Mon Jul  7 00:00:25 2003
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/dynlocks.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -136,6 +137,7 @@ extern int leases_enable, dir_notify_ena
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
 #define S_DIRSYNC	128	/* Directory modifications are synchronous */
+#define S_PDIROPS	256	/* Parallel directory operations */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -167,6 +169,7 @@ extern int leases_enable, dir_notify_ena
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 #define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
+#define IS_PDIROPS(inode)	__IS_FLG(inode, S_PDIROPS)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 
@@ -396,6 +399,7 @@ struct inode {
 	atomic_t		i_writecount;
 	void			*i_security;
 	__u32			i_generation;
+	struct dynlock		i_dcache_lock;	/* for parallel directory ops */
 	union {
 		void		*generic_ip;
 	} u;
diff -puN include/linux/namei.h~vfs-pdirops include/linux/namei.h
--- linux-2.5.73/include/linux/namei.h~vfs-pdirops	Mon Jul  7 00:00:25 2003
+++ linux-2.5.73-alexey/include/linux/namei.h	Mon Jul  7 00:00:25 2003
@@ -11,6 +11,7 @@ struct nameidata {
 	struct qstr	last;
 	unsigned int	flags;
 	int		last_type;
+	void		*lock;
 };
 
 /*
@@ -49,7 +50,7 @@ extern struct dentry * lookup_hash(struc
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
 
-extern struct dentry *lock_rename(struct dentry *, struct dentry *);
-extern void unlock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename(struct nameidata *, struct nameidata *);
+extern void unlock_rename(struct nameidata *, struct nameidata *);
 
 #endif /* _LINUX_NAMEI_H */
diff -puN fs/inode.c~vfs-pdirops fs/inode.c
--- linux-2.5.73/fs/inode.c~vfs-pdirops	Mon Jul  7 00:00:25 2003
+++ linux-2.5.73-alexey/fs/inode.c	Mon Jul  7 00:00:25 2003
@@ -19,6 +19,7 @@
 #include <linux/swap.h>
 #include <linux/security.h>
 #include <linux/cdev.h>
+#include <linux/dynlocks.h>
 
 /*
  * This is needed for the following functions:
@@ -149,6 +150,7 @@ static struct inode *alloc_inode(struct 
 			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
+		dynlock_init(&inode->i_dcache_lock);
 	}
 	return inode;
 }

_

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=ext3-pdirops.patch


parallel directory operations for EXT3.


htree consists of index blocks and leaves. leaves are protected against
modifications and lookups. so, any process which wants to operate on some
leaf have to lock this leaf. in order to decrease lock collisions while
splitting we use bit-based spinlock to protect index blocks. this mean
we can't sleep in the middle of index block modification and we have to
make modifications in strict order, so that any user walking through the
htree will not lose any leaf and will not select wrong leaf.




diff -puN fs/ext3/namei.c~ext3-pdirops fs/ext3/namei.c
--- linux-2.5.73/fs/ext3/namei.c~ext3-pdirops	Mon Jul  7 00:00:24 2003
+++ linux-2.5.73-alexey/fs/ext3/namei.c	Mon Jul  7 00:10:33 2003
@@ -53,6 +53,9 @@ static struct buffer_head *ext3_append(h
 {
 	struct buffer_head *bh;
 
+	/* with parallel dir operations all appends
+	 * have to be serialized -bzzz */
+	down(&EXT3_I(inode)->i_append_sem);
 	*block = inode->i_size >> inode->i_sb->s_blocksize_bits;
 
 	if ((bh = ext3_bread(handle, inode, *block, 1, err))) {
@@ -60,6 +63,8 @@ static struct buffer_head *ext3_append(h
 		EXT3_I(inode)->i_disksize = inode->i_size;
 		ext3_journal_get_write_access(handle,bh);
 	}
+	up(&EXT3_I(inode)->i_append_sem);
+	
 	return bh;
 }
 
@@ -136,6 +141,8 @@ struct dx_frame
 	struct buffer_head *bh;
 	struct dx_entry *entries;
 	struct dx_entry *at;
+	unsigned long leaf;
+	unsigned int curidx;
 };
 
 struct dx_map_entry
@@ -144,6 +151,32 @@ struct dx_map_entry
 	u32 offs;
 };
 
+/* FIXME: this should be reworked using bb_spin_lock
+ * introduced in -mm tree
+ */
+#define BH_DXLock	25
+
+static inline void dx_lock_bh(struct buffer_head volatile *bh)
+{
+        preempt_disable();
+#ifdef CONFIG_SMP
+        while (test_and_set_bit(BH_DXLock, &bh->b_state)) {
+                while (test_bit(BH_DXLock, &bh->b_state))
+                        cpu_relax();
+        }
+#endif
+}
+
+static inline void dx_unlock_bh(struct buffer_head *bh)
+{
+#ifdef CONFIG_SMP
+        smp_mb__before_clear_bit();
+        clear_bit(BH_DXLock, &bh->b_state);
+#endif
+        preempt_enable();
+}
+
+
 #ifdef CONFIG_EXT3_INDEX
 static inline unsigned dx_get_block (struct dx_entry *entry);
 static void dx_set_block (struct dx_entry *entry, unsigned value);
@@ -155,7 +188,7 @@ static void dx_set_count (struct dx_entr
 static void dx_set_limit (struct dx_entry *entries, unsigned value);
 static unsigned dx_root_limit (struct inode *dir, unsigned infosize);
 static unsigned dx_node_limit (struct inode *dir);
-static struct dx_frame *dx_probe(struct dentry *dentry,
+static struct dx_frame *dx_probe(struct qstr *name,
 				 struct inode *dir,
 				 struct dx_hash_info *hinfo,
 				 struct dx_frame *frame,
@@ -167,15 +200,19 @@ static void dx_sort_map(struct dx_map_en
 static struct ext3_dir_entry_2 *dx_move_dirents (char *from, char *to,
 		struct dx_map_entry *offsets, int count);
 static struct ext3_dir_entry_2* dx_pack_dirents (char *base, int size);
-static void dx_insert_block (struct dx_frame *frame, u32 hash, u32 block);
+static void dx_insert_block (struct inode *, struct dx_frame *, u32, u32, u32);
 static int ext3_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
 				 struct dx_frame *frames, 
 				 __u32 *start_hash);
 static struct buffer_head * ext3_dx_find_entry(struct dentry *dentry,
-		       struct ext3_dir_entry_2 **res_dir, int *err);
+		       struct ext3_dir_entry_2 **res_dir, int *err,
+		       int rwlock, void **lock);
 static int ext3_dx_add_entry(handle_t *handle, struct dentry *dentry,
 			     struct inode *inode);
+static inline void *ext3_lock_htree(struct inode *, unsigned long, int);
+static inline void ext3_unlock_htree(struct inode *, void *);
+
 
 /*
  * Future: use high four bits of block for coalesce-on-delete flags
@@ -319,6 +356,94 @@ struct stats dx_show_entries(struct dx_h
 #endif /* DX_DEBUG */
 
 /*
+ * dx_find_position
+ *
+ * search position of specified hash in index
+ *
+ */
+
+struct dx_entry * dx_find_position(struct dx_entry * entries, u32 hash)
+{
+	struct dx_entry *p, *q, *m;
+	int count;
+
+	count = dx_get_count(entries);
+	p = entries + 1;
+	q = entries + count - 1;
+	while (p <= q)
+	{
+		m = p + (q - p)/2;
+		if (dx_get_hash(m) > hash)
+			q = m - 1;
+		else
+			p = m + 1;
+	}
+	return p - 1;
+}
+
+/*
+ * returns 1 if path is unchanged
+ */
+int dx_check_path(struct dx_frame *frame, u32 hash)
+{
+	struct dx_entry *p;
+	int ret = 1;
+
+	dx_lock_bh(frame->bh);
+	p = dx_find_position(frame->entries, hash);
+	if (frame->leaf != dx_get_block(p))
+		ret = 0;
+	dx_unlock_bh(frame->bh);
+	
+	return ret;
+}
+
+/*
+ * 0 - changed
+ * 1 - hasn't changed
+ */
+static int
+dx_check_full_path(struct dx_frame *frames, struct dx_hash_info *hinfo)
+{
+	struct dx_entry *p;
+	struct dx_frame *frame = frames;
+	u32 leaf;
+
+	/* check first level */
+	dx_lock_bh(frame->bh);
+	p = dx_find_position(frame->entries, hinfo->hash);
+	leaf = dx_get_block(p);
+	dx_unlock_bh(frame->bh);
+	
+	if (leaf != frame->leaf) 
+		return 0;
+	
+	/* is there 2nd level? */
+	frame++;
+	if (frame->bh == NULL)
+		return 1;
+
+	/* check second level */
+	dx_lock_bh(frame->bh);
+
+	/* probably 1st level got changed, check it */
+	if (!dx_check_path(frames, hinfo->hash)) {
+		/* path changed */
+		dx_unlock_bh(frame->bh);
+		return 0;
+	}
+
+	p = dx_find_position(frame->entries, hinfo->hash);
+	leaf = dx_get_block(p);
+	dx_unlock_bh(frame->bh);
+	
+	if (leaf != frame->leaf)
+		return 0;
+
+	return 1;
+}
+
+/*
  * Probe for a directory leaf block to search.
  *
  * dx_probe can return ERR_BAD_DX_DIR, which means there was a format
@@ -328,19 +453,20 @@ struct stats dx_show_entries(struct dx_h
  * back to userspace.
  */
 static struct dx_frame *
-dx_probe(struct dentry *dentry, struct inode *dir,
+dx_probe(struct qstr *name, struct inode *dir,
 	 struct dx_hash_info *hinfo, struct dx_frame *frame_in, int *err)
 {
-	unsigned count, indirect;
-	struct dx_entry *at, *entries, *p, *q, *m;
+	unsigned indirect;
+	struct dx_entry *at, *entries;
 	struct dx_root *root;
 	struct buffer_head *bh;
 	struct dx_frame *frame = frame_in;
 	u32 hash;
+	unsigned int curidx;
 
 	frame->bh = NULL;
-	if (dentry)
-		dir = dentry->d_parent->d_inode;
+	frame[1].bh = NULL;
+
 	if (!(bh = ext3_bread (NULL,dir, 0, 0, err)))
 		goto fail;
 	root = (struct dx_root *) bh->b_data;
@@ -356,8 +482,8 @@ dx_probe(struct dentry *dentry, struct i
 	}
 	hinfo->hash_version = root->info.hash_version;
 	hinfo->seed = EXT3_SB(dir->i_sb)->s_hash_seed;
-	if (dentry)
-		ext3fs_dirhash(dentry->d_name.name, dentry->d_name.len, hinfo);
+	if (name)
+		ext3fs_dirhash(name->name, name->len, hinfo);
 	hash = hinfo->hash;
 
 	if (root->info.unused_flags & 1) {
@@ -369,7 +495,19 @@ dx_probe(struct dentry *dentry, struct i
 		goto fail;
 	}
 
+repeat:
+	curidx = 0;
+	entries = (struct dx_entry *) (((char *)&root->info) +
+				       root->info.info_length);
+	assert(dx_get_limit(entries) == dx_root_limit(dir,
+						      root->info.info_length));
+	dxtrace (printk("Look up %x", hash));
+	dx_lock_bh(bh);
+	/* indirect must be initialized under bh lock because
+	 * 2nd level creation procedure may change it and dx_probe()
+	 * will suggest htree is still single-level -bzzz */
 	if ((indirect = root->info.indirect_levels) > 1) {
+		dx_unlock_bh(bh);
 		ext3_warning(dir->i_sb, __FUNCTION__,
 			     "Unimplemented inode hash depth: %#06x",
 			     root->info.indirect_levels);
@@ -377,56 +515,46 @@ dx_probe(struct dentry *dentry, struct i
 		*err = ERR_BAD_DX_DIR;
 		goto fail;
 	}
-
-	entries = (struct dx_entry *) (((char *)&root->info) +
-				       root->info.info_length);
-	assert(dx_get_limit(entries) == dx_root_limit(dir,
-						      root->info.info_length));
-	dxtrace (printk("Look up %x", hash));
+	
 	while (1)
 	{
-		count = dx_get_count(entries);
-		assert (count && count <= dx_get_limit(entries));
-		p = entries + 1;
-		q = entries + count - 1;
-		while (p <= q)
-		{
-			m = p + (q - p)/2;
-			dxtrace(printk("."));
-			if (dx_get_hash(m) > hash)
-				q = m - 1;
-			else
-				p = m + 1;
-		}
-
-		if (0) // linear search cross check
-		{
-			unsigned n = count - 1;
-			at = entries;
-			while (n--)
-			{
-				dxtrace(printk(","));
-				if (dx_get_hash(++at) > hash)
-				{
-					at--;
-					break;
-				}
-			}
-			assert (at == p - 1);
-		}
-
-		at = p - 1;
-		dxtrace(printk(" %x->%u\n", at == entries? 0: dx_get_hash(at), dx_get_block(at)));
+		at = dx_find_position(entries, hinfo->hash);
+		dxtrace(printk(" %x->%u\n",
+				at == entries? 0: dx_get_hash(at),
+				dx_get_block(at)));
 		frame->bh = bh;
 		frame->entries = entries;
 		frame->at = at;
-		if (!indirect--) return frame;
-		if (!(bh = ext3_bread (NULL,dir, dx_get_block(at), 0, err)))
+		frame->curidx = curidx;
+		frame->leaf = dx_get_block(at);
+		if (!indirect--) {
+			dx_unlock_bh(bh);
+			return frame;
+		}
+		
+		/* step into next htree level */
+		curidx = dx_get_block(at);
+		dx_unlock_bh(bh);
+		if (!(bh = ext3_bread (NULL,dir, frame->leaf, 0, err)))
 			goto fail2;
+		
+		dx_lock_bh(bh);
+		/* splitting may change root index block and move
+		 * hash we're looking for into another index block
+		 * so, we have to check this situation and repeat
+		 * from begining if path got changed -bzzz */
+		if (!dx_check_path(frame, hash)) {
+			dx_unlock_bh(bh);
+			bh = frame->bh;
+			indirect++;
+			goto repeat;
+		}
+		
 		at = entries = ((struct dx_node *) bh->b_data)->entries;
 		assert (dx_get_limit(entries) == dx_node_limit (dir));
 		frame++;
 	}
+	dx_unlock_bh(bh);
 fail2:
 	while (frame >= frame_in) {
 		brelse(frame->bh);
@@ -440,8 +568,7 @@ static void dx_release (struct dx_frame 
 {
 	if (frames[0].bh == NULL)
 		return;
-
-	if (((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels)
+	if (frames[1].bh != NULL)
 		brelse(frames[1].bh);
 	brelse(frames[0].bh);
 }
@@ -482,8 +609,10 @@ static int ext3_htree_next_block(struct 
 	 * nodes need to be read.
 	 */
 	while (1) {
-		if (++(p->at) < p->entries + dx_get_count(p->entries))
+		if (++(p->at) < p->entries + dx_get_count(p->entries)) {
+			p->leaf = dx_get_block(p->at);
 			break;
+		}
 		if (p == frames)
 			return 0;
 		num_frames++;
@@ -509,13 +638,18 @@ static int ext3_htree_next_block(struct 
 	 * block so no check is necessary
 	 */
 	while (num_frames--) {
-		if (!(bh = ext3_bread(NULL, dir, dx_get_block(p->at),
+		u32 idx;
+		
+		idx = p->leaf = dx_get_block(p->at);
+		if (!(bh = ext3_bread(NULL, dir, p->leaf,
 				      0, &err)))
 			return err; /* Failure */
 		p++;
 		brelse (p->bh);
 		p->bh = bh;
 		p->at = p->entries = ((struct dx_node *) bh->b_data)->entries;
+		p->curidx = idx;
+		p->leaf = dx_get_block(p->at);
 	}
 	return 1;
 }
@@ -602,7 +736,7 @@ int ext3_htree_fill_tree(struct file *di
 	}
 	hinfo.hash = start_hash;
 	hinfo.minor_hash = 0;
-	frame = dx_probe(0, dir_file->f_dentry->d_inode, &hinfo, frames, &err);
+	frame = dx_probe(NULL, dir_file->f_dentry->d_inode, &hinfo, frames, &err);
 	if (!frame)
 		return err;
 
@@ -674,7 +808,8 @@ static int dx_make_map (struct ext3_dir_
 			count++;
 		}
 		/* XXX: do we need to check rec_len == 0 case? -Chris */
-		de = (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
+		de = (struct ext3_dir_entry_2 *)((char*)de +
+				le16_to_cpu(de->rec_len));
 	}
 	return count;
 }
@@ -707,7 +842,8 @@ static void dx_sort_map (struct dx_map_e
 	} while(more);
 }
 
-static void dx_insert_block(struct dx_frame *frame, u32 hash, u32 block)
+static void dx_insert_block(struct inode *dir, struct dx_frame *frame,
+			u32 hash, u32 block, u32 idx)
 {
 	struct dx_entry *entries = frame->entries;
 	struct dx_entry *old = frame->at, *new = old + 1;
@@ -719,6 +855,7 @@ static void dx_insert_block(struct dx_fr
 	dx_set_hash(new, hash);
 	dx_set_block(new, block);
 	dx_set_count(entries, count + 1);
+	
 }
 #endif
 
@@ -799,7 +936,8 @@ static inline int search_dirblock(struct
  * to brelse() it when appropriate.
  */
 static struct buffer_head * ext3_find_entry (struct dentry *dentry,
-					struct ext3_dir_entry_2 ** res_dir)
+					struct ext3_dir_entry_2 ** res_dir,
+					int rwlock, void **lock)
 {
 	struct super_block * sb;
 	struct buffer_head * bh_use[NAMEI_RA_SIZE];
@@ -815,6 +953,7 @@ static struct buffer_head * ext3_find_en
 	int namelen;
 	const u8 *name;
 	unsigned blocksize;
+	int do_not_use_dx = 0;
 
 	*res_dir = NULL;
 	sb = dir->i_sb;
@@ -823,9 +962,10 @@ static struct buffer_head * ext3_find_en
 	name = dentry->d_name.name;
 	if (namelen > EXT3_NAME_LEN)
 		return NULL;
+repeat:
 #ifdef CONFIG_EXT3_INDEX
 	if (is_dx(dir)) {
-		bh = ext3_dx_find_entry(dentry, res_dir, &err);
+		bh = ext3_dx_find_entry(dentry, res_dir, &err, rwlock, lock);
 		/*
 		 * On success, or if the error was file not found,
 		 * return.  Otherwise, fall back to doing a search the
@@ -834,8 +974,14 @@ static struct buffer_head * ext3_find_en
 		if (bh || (err != ERR_BAD_DX_DIR))
 			return bh;
 		dxtrace(printk("ext3_find_entry: dx failed, falling back\n"));
+		do_not_use_dx = 1;
 	}
 #endif
+	*lock = ext3_lock_htree(dir, 0, rwlock);
+	if (is_dx(dir) && !do_not_use_dx) {
+		ext3_unlock_htree(dir, *lock);
+		goto repeat;
+	}
 	nblocks = dir->i_size >> EXT3_BLOCK_SIZE_BITS(sb);
 	start = EXT3_I(dir)->i_dir_start_lookup;
 	if (start >= nblocks)
@@ -906,12 +1052,17 @@ cleanup_and_exit:
 	/* Clean up the read-ahead blocks */
 	for (; ra_ptr < ra_max; ra_ptr++)
 		brelse (bh_use[ra_ptr]);
+	if (!ret) {
+		ext3_unlock_htree(dir, *lock);
+		*lock = NULL;
+	}
 	return ret;
 }
 
 #ifdef CONFIG_EXT3_INDEX
 static struct buffer_head * ext3_dx_find_entry(struct dentry *dentry,
-		       struct ext3_dir_entry_2 **res_dir, int *err)
+		       struct ext3_dir_entry_2 **res_dir, int *err,
+		       int rwlock, void **lock)
 {
 	struct super_block * sb;
 	struct dx_hash_info	hinfo;
@@ -920,34 +1071,47 @@ static struct buffer_head * ext3_dx_find
 	struct ext3_dir_entry_2 *de, *top;
 	struct buffer_head *bh;
 	unsigned long block;
-	int retval;
+	int retval, offset;
 	int namelen = dentry->d_name.len;
 	const u8 *name = dentry->d_name.name;
 	struct inode *dir = dentry->d_parent->d_inode;
 
 	sb = dir->i_sb;
-	if (!(frame = dx_probe (dentry, 0, &hinfo, frames, err)))
+repeat:
+	if (!(frame = dx_probe (&dentry->d_name, dir, &hinfo, frames, err)))
 		return NULL;
+	
+	*lock = ext3_lock_htree(dir, frame->leaf, rwlock);
+	/* while locking leaf we just found may get splitted
+	 * so, we need another leaf. check this */
+	if (!dx_check_full_path(frames, &hinfo)) {
+		ext3_unlock_htree(dir, *lock);
+		dx_release(frames);
+		goto repeat;
+	}
+	
 	hash = hinfo.hash;
 	do {
-		block = dx_get_block(frame->at);
+		block = frame->leaf;
 		if (!(bh = ext3_bread (NULL,dir, block, 0, err)))
 			goto errout;
 		de = (struct ext3_dir_entry_2 *) bh->b_data;
 		top = (struct ext3_dir_entry_2 *) ((char *) de + sb->s_blocksize -
 				       EXT3_DIR_REC_LEN(0));
-		for (; de < top; de = ext3_next_entry(de))
-		if (ext3_match (namelen, name, de)) {
-			if (!ext3_check_dir_entry("ext3_find_entry",
-						  dir, de, bh,
-				  (block<<EXT3_BLOCK_SIZE_BITS(sb))
-					  +((char *)de - bh->b_data))) {
-				brelse (bh);
-				goto errout;
+		for (offset = 0; de < top; de = ext3_next_entry(de)) {
+			if (ext3_match (namelen, name, de)) {
+				if (!ext3_check_dir_entry("ext3_find_entry",
+						dir, de, bh,
+						(block<<EXT3_BLOCK_SIZE_BITS(sb))
+						+((char *)de - bh->b_data))) {
+					brelse (bh);
+					goto errout;
+				}
+				*res_dir = de;
+				dx_release (frames);
+				return bh;
 			}
-			*res_dir = de;
-			dx_release (frames);
-			return bh;
+			offset += le16_to_cpu(de->rec_len);
 		}
 		brelse (bh);
 		/* Check to see if we should continue to search */
@@ -965,6 +1129,8 @@ static struct buffer_head * ext3_dx_find
 	*err = -ENOENT;
 errout:
 	dxtrace(printk("%s not found\n", name));
+	ext3_unlock_htree(dir, *lock);
+	*lock = NULL;
 	dx_release (frames);
 	return NULL;
 }
@@ -975,14 +1141,16 @@ static struct dentry *ext3_lookup(struct
 	struct inode * inode;
 	struct ext3_dir_entry_2 * de;
 	struct buffer_head * bh;
+	void *lock;
 
 	if (dentry->d_name.len > EXT3_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	bh = ext3_find_entry(dentry, &de);
+	bh = ext3_find_entry(dentry, &de, 0, &lock);
 	inode = NULL;
 	if (bh) {
 		unsigned long ino = le32_to_cpu(de->inode);
+		ext3_unlock_htree(dir, lock);
 		brelse (bh);
 		inode = iget(dir->i_sb, ino);
 
@@ -995,7 +1163,6 @@ static struct dentry *ext3_lookup(struct
 	return NULL;
 }
 
-
 struct dentry *ext3_get_parent(struct dentry *child)
 {
 	unsigned long ino;
@@ -1004,16 +1171,18 @@ struct dentry *ext3_get_parent(struct de
 	struct dentry dotdot;
 	struct ext3_dir_entry_2 * de;
 	struct buffer_head *bh;
+	void *lock;
 
 	dotdot.d_name.name = "..";
 	dotdot.d_name.len = 2;
 	dotdot.d_parent = child; /* confusing, isn't it! */
 
-	bh = ext3_find_entry(&dotdot, &de);
+	bh = ext3_find_entry(&dotdot, &de, 0, &lock);
 	inode = NULL;
 	if (!bh)
 		return ERR_PTR(-ENOENT);
 	ino = le32_to_cpu(de->inode);
+	ext3_unlock_htree(child->d_inode, lock);
 	brelse(bh);
 	inode = iget(child->d_inode->i_sb, ino);
 
@@ -1053,7 +1222,8 @@ dx_move_dirents(char *from, char *to, st
 	unsigned rec_len = 0;
 
 	while (count--) {
-		struct ext3_dir_entry_2 *de = (struct ext3_dir_entry_2 *) (from + map->offs);
+		struct ext3_dir_entry_2 *de =
+			(struct ext3_dir_entry_2 *) (from + map->offs);
 		rec_len = EXT3_DIR_REC_LEN(de->name_len);
 		memcpy (to, de, rec_len);
 		((struct ext3_dir_entry_2 *) to)->rec_len =
@@ -1067,7 +1237,8 @@ dx_move_dirents(char *from, char *to, st
 
 static struct ext3_dir_entry_2* dx_pack_dirents(char *base, int size)
 {
-	struct ext3_dir_entry_2 *next, *to, *prev, *de = (struct ext3_dir_entry_2 *) base;
+	struct ext3_dir_entry_2 *next, *to, *prev;
+	struct ext3_dir_entry_2 *de = (struct ext3_dir_entry_2 *) base;
 	unsigned rec_len = 0;
 
 	prev = to = de;
@@ -1089,7 +1260,8 @@ static struct ext3_dir_entry_2* dx_pack_
 
 static struct ext3_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 			struct buffer_head **bh,struct dx_frame *frame,
-			struct dx_hash_info *hinfo, int *error)
+			struct dx_hash_info *hinfo, void **target,
+			int *error)
 {
 	unsigned blocksize = dir->i_sb->s_blocksize;
 	unsigned count, continued;
@@ -1136,23 +1308,30 @@ static struct ext3_dir_entry_2 *do_split
 	hash2 = map[split].hash;
 	continued = hash2 == map[split - 1].hash;
 	dxtrace(printk("Split block %i at %x, %i/%i\n",
-		dx_get_block(frame->at), hash2, split, count-split));
-
+		frame->leaf, hash2, split, count-split));
+	
 	/* Fancy dance to stay within two buffers */
 	de2 = dx_move_dirents(data1, data2, map + split, count - split);
 	de = dx_pack_dirents(data1,blocksize);
 	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
 	de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
-	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data1, blocksize, 1));
-	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data2, blocksize, 1));
+	dxtrace(dx_show_leaf(hinfo,(struct ext3_dir_entry_2*) data1, blocksize, 1));
+	dxtrace(dx_show_leaf(hinfo,(struct ext3_dir_entry_2*) data2, blocksize, 1));
 
 	/* Which block gets the new entry? */
+	*target = NULL;
 	if (hinfo->hash >= hash2)
 	{
 		swap(*bh, bh2);
 		de = de2;
-	}
-	dx_insert_block (frame, hash2 + continued, newblock);
+
+		/* entry will be stored into new block
+		 * we have to lock it before add_dirent_to_buf */
+		*target = ext3_lock_htree(dir, newblock, 1);
+	}
+	dx_lock_bh(frame->bh);
+	dx_insert_block (dir, frame, hash2 + continued, newblock, frame->curidx);
+	dx_unlock_bh(frame->bh);
 	err = ext3_journal_dirty_metadata (handle, bh2);
 	if (err)
 		goto journal_error;
@@ -1226,7 +1405,8 @@ static int add_dirent_to_buf(handle_t *h
 	nlen = EXT3_DIR_REC_LEN(de->name_len);
 	rlen = le16_to_cpu(de->rec_len);
 	if (de->inode) {
-		struct ext3_dir_entry_2 *de1 = (struct ext3_dir_entry_2 *)((char *)de + nlen);
+		struct ext3_dir_entry_2 *de1 =
+			(struct ext3_dir_entry_2 *)((char *)de + nlen);
 		de1->rec_len = cpu_to_le16(rlen - nlen);
 		de->rec_len = cpu_to_le16(nlen);
 		de = de1;
@@ -1284,7 +1464,8 @@ static int make_indexed_dir(handle_t *ha
 	unsigned	blocksize;
 	struct dx_hash_info hinfo;
 	u32		block;
-
+	void		*lock, *new_lock;
+	
 	blocksize =  dir->i_sb->s_blocksize;
 	dxtrace(printk("Creating index\n"));
 	retval = ext3_journal_get_write_access(handle, bh);
@@ -1295,7 +1476,6 @@ static int make_indexed_dir(handle_t *ha
 	}
 	root = (struct dx_root *) bh->b_data;
 
-	EXT3_I(dir)->i_flags |= EXT3_INDEX_FL;
 	bh2 = ext3_append (handle, dir, &block, &retval);
 	if (!(bh2)) {
 		brelse(bh);
@@ -1303,6 +1483,8 @@ static int make_indexed_dir(handle_t *ha
 	}
 	data1 = bh2->b_data;
 
+	lock = ext3_lock_htree(dir, block, 1);
+
 	/* The 0th block becomes the root, move the dirents out */
 	de = (struct ext3_dir_entry_2 *) &root->info;
 	len = ((char *) root) + blocksize - (char *) de;
@@ -1331,13 +1513,25 @@ static int make_indexed_dir(handle_t *ha
 	frame->entries = entries;
 	frame->at = entries;
 	frame->bh = bh;
+	frame->curidx = 0;
+	frame->leaf = 0;
+	frame[1].bh = NULL;
 	bh = bh2;
-	de = do_split(handle,dir, &bh, frame, &hinfo, &retval);
+	de = do_split(handle,dir, &bh, frame, &hinfo, &new_lock, &retval);
 	dx_release (frames);
 	if (!(de))
-		return retval;
+		goto cleanup;
 
-	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+	retval = add_dirent_to_buf(handle, dentry, inode, de, bh);
+cleanup:
+	if (new_lock)
+		ext3_unlock_htree(dir, new_lock);
+	/* we mark directory indexed in order to
+	 * avoid races while htree being created -bzzz */
+	EXT3_I(dir)->i_flags |= EXT3_INDEX_FL;
+	ext3_unlock_htree(dir, lock);
+
+	return retval;
 }
 #endif
 
@@ -1366,11 +1560,13 @@ static int ext3_add_entry (handle_t *han
 	unsigned blocksize;
 	unsigned nlen, rlen;
 	u32 block, blocks;
+	void *lock;
 
 	sb = dir->i_sb;
 	blocksize = sb->s_blocksize;
 	if (!dentry->d_name.len)
 		return -EINVAL;
+repeat:
 #ifdef CONFIG_EXT3_INDEX
 	if (is_dx(dir)) {
 		retval = ext3_dx_add_entry(handle, dentry, inode);
@@ -1381,36 +1577,53 @@ static int ext3_add_entry (handle_t *han
 		ext3_mark_inode_dirty(handle, dir);
 	}
 #endif
+	lock = ext3_lock_htree(dir, 0, 1);
+	if (is_dx(dir)) {
+		/* we got lock for block 0
+		 * probably previous holder of the lock
+		 * created htree -bzzz */
+		ext3_unlock_htree(dir, lock);
+		goto repeat;
+	}
+	
 	blocks = dir->i_size >> sb->s_blocksize_bits;
 	for (block = 0, offset = 0; block < blocks; block++) {
 		bh = ext3_bread(handle, dir, block, 0, &retval);
-		if(!bh)
+		if(!bh) {
+			ext3_unlock_htree(dir, lock);
 			return retval;
+		}
 		retval = add_dirent_to_buf(handle, dentry, inode, 0, bh);
-		if (retval != -ENOSPC)
+		if (retval != -ENOSPC) {
+			ext3_unlock_htree(dir, lock);
 			return retval;
+		}
 
 #ifdef CONFIG_EXT3_INDEX
 		if (blocks == 1 && !dx_fallback &&
-		    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_DIR_INDEX))
-			return make_indexed_dir(handle, dentry, inode, bh);
+		    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_DIR_INDEX)) {
+			retval = make_indexed_dir(handle, dentry, inode, bh);
+			ext3_unlock_htree(dir, lock);
+			return retval;
+		}
 #endif
 		brelse(bh);
 	}
 	bh = ext3_append(handle, dir, &block, &retval);
-	if (!bh)
+	if (!bh) {
+		ext3_unlock_htree(dir, lock);
 		return retval;
+	}
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
 	de->inode = 0;
 	de->rec_len = cpu_to_le16(rlen = blocksize);
 	nlen = 0;
-	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+	retval = add_dirent_to_buf(handle, dentry, inode, de, bh);
+	ext3_unlock_htree(dir, lock);
+	return retval;
 }
 
 #ifdef CONFIG_EXT3_INDEX
-/*
- * Returns 0 for success, or a negative error value
- */
 static int ext3_dx_add_entry(handle_t *handle, struct dentry *dentry,
 			     struct inode *inode)
 {
@@ -1422,15 +1635,28 @@ static int ext3_dx_add_entry(handle_t *h
 	struct super_block * sb = dir->i_sb;
 	struct ext3_dir_entry_2 *de;
 	int err;
+	int curidx;
+	void *idx_lock, *leaf_lock, *newleaf_lock;
 
-	frame = dx_probe(dentry, 0, &hinfo, frames, &err);
+repeat:
+	frame = dx_probe(&dentry->d_name, dir, &hinfo, frames, &err);
 	if (!frame)
 		return err;
-	entries = frame->entries;
-	at = frame->at;
 
-	if (!(bh = ext3_bread(handle,dir, dx_get_block(frame->at), 0, &err)))
+	/* we're going to chage leaf, so lock it first */
+	leaf_lock = ext3_lock_htree(dir, frame->leaf, 1);
+
+	/* while locking leaf we just found may get splitted
+	 * so we need to check this */
+	if (!dx_check_full_path(frames, &hinfo)) {
+		ext3_unlock_htree(dir, leaf_lock);
+		dx_release(frames);
+		goto repeat;
+	}
+	if (!(bh = ext3_bread(handle,dir, frame->leaf, 0, &err))) {
+		printk("can't ext3_bread(%d) = %d\n", (int) frame->leaf, err);
 		goto cleanup;
+	}
 
 	BUFFER_TRACE(bh, "get_write_access");
 	err = ext3_journal_get_write_access(handle, bh);
@@ -1443,6 +1669,35 @@ static int ext3_dx_add_entry(handle_t *h
 		goto cleanup;
 	}
 
+	/* our leaf has no enough space. hence, we have to
+	 * split it. so lock index for this leaf first */
+	curidx = frame->curidx;
+	idx_lock = ext3_lock_htree(dir, curidx, 1);
+
+	/* now check did path get changed? */
+	dx_release(frames);
+
+	frame = dx_probe(&dentry->d_name, dentry->d_parent->d_inode,
+			&hinfo, frames, &err);
+	if (!frame) {
+		/* FIXME: error handling here */
+		brelse(bh);
+		ext3_unlock_htree(dir, idx_lock);
+		return err;
+	}
+	
+	if (frame->curidx != curidx) {
+		/* path has been changed. we have to drop old lock
+		 * and repeat */
+		brelse(bh);
+		ext3_unlock_htree(dir, idx_lock);
+		ext3_unlock_htree(dir, leaf_lock);
+		dx_release(frames);
+		goto repeat;
+	}
+	entries = frame->entries;
+	at = frame->at;
+
 	/* Block full, should compress but for now just split */
 	dxtrace(printk("using %u of %u node entries\n",
 		       dx_get_count(entries), dx_get_limit(entries)));
@@ -1454,7 +1709,8 @@ static int ext3_dx_add_entry(handle_t *h
 		struct dx_entry *entries2;
 		struct dx_node *node2;
 		struct buffer_head *bh2;
-
+		void *nb_lock;
+		
 		if (levels && (dx_get_count(frames->entries) ==
 			       dx_get_limit(frames->entries))) {
 			ext3_warning(sb, __FUNCTION__,
@@ -1465,6 +1721,7 @@ static int ext3_dx_add_entry(handle_t *h
 		bh2 = ext3_append (handle, dir, &newblock, &err);
 		if (!(bh2))
 			goto cleanup;
+		nb_lock = ext3_lock_htree(dir, newblock, 1);
 		node2 = (struct dx_node *)(bh2->b_data);
 		entries2 = node2->entries;
 		node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
@@ -1476,27 +1733,73 @@ static int ext3_dx_add_entry(handle_t *h
 		if (levels) {
 			unsigned icount1 = icount/2, icount2 = icount - icount1;
 			unsigned hash2 = dx_get_hash(entries + icount1);
-			dxtrace(printk("Split index %i/%i\n", icount1, icount2));
+			void *ri_lock;
 
-			BUFFER_TRACE(frame->bh, "get_write_access"); /* index root */
+			/* we have to protect root htree index against
+			 * another dx_add_entry() which would want to
+			 * split it too -bzzz */
+			ri_lock = ext3_lock_htree(dir, 0, 1);
+
+			/* as root index block blocked we must repeat
+			 * searching for current position of our 2nd index -bzzz */
+			dx_lock_bh(frame->bh);
+			frames->at = dx_find_position(frames->entries, hinfo.hash);
+			dx_unlock_bh(frame->bh);
+			
+			dxtrace(printk("Split index %i/%i\n", icount1, icount2));
+	
+			BUFFER_TRACE(frame->bh, "get_write_access");
 			err = ext3_journal_get_write_access(handle,
 							     frames[0].bh);
 			if (err)
 				goto journal_error;
-
+			
+			/* copy index into new one */
 			memcpy ((char *) entries2, (char *) (entries + icount1),
 				icount2 * sizeof(struct dx_entry));
-			dx_set_count (entries, icount1);
 			dx_set_count (entries2, icount2);
 			dx_set_limit (entries2, dx_node_limit(dir));
 
 			/* Which index block gets the new entry? */
 			if (at - entries >= icount1) {
+				/* unlock index we won't use */
+				ext3_unlock_htree(dir, idx_lock);
+				idx_lock = nb_lock;
 				frame->at = at = at - entries - icount1 + entries2;
-				frame->entries = entries = entries2;
+				frame->entries = entries2;
+				frame->curidx = curidx = newblock;
 				swap(frame->bh, bh2);
+			} else {
+				/* we'll use old index,so new one may be freed */
+				ext3_unlock_htree(dir, nb_lock);
 			}
-			dx_insert_block (frames + 0, hash2, newblock);
+		
+			/* NOTE: very subtle piece of code
+			 * competing dx_probe() may find 2nd level index in root
+			 * index, then we insert new index here and set new count
+			 * in that 2nd level index. so, dx_probe() may see 2nd
+			 * level index w/o hash it looks for. the solution is
+			 * to check root index after we locked just founded 2nd
+			 * level index -bzzz */
+			dx_lock_bh(frames[0].bh);
+			dx_insert_block (dir, frames + 0, hash2, newblock, 0);
+			dx_unlock_bh(frames[0].bh);
+			
+			/* now old and new 2nd level index blocks contain
+			 * all pointers, so dx_probe() may find it in the both.
+			 * it's OK -bzzz */
+			
+			dx_lock_bh(frame->bh);
+			dx_set_count(entries, icount1);
+			dx_unlock_bh(frame->bh);
+
+			/* now old 2nd level index block points to first half
+			 * of leafs. it's importand that dx_probe() must
+			 * check root index block for changes under
+			 * dx_lock_bh(frame->bh) -bzzz */
+
+			ext3_unlock_htree(dir, ri_lock);
+		
 			dxtrace(dx_show_index ("node", frames[1].entries));
 			dxtrace(dx_show_index ("node",
 			       ((struct dx_node *) bh2->b_data)->entries));
@@ -1505,38 +1808,62 @@ static int ext3_dx_add_entry(handle_t *h
 				goto journal_error;
 			brelse (bh2);
 		} else {
+			unsigned long leaf = frame->leaf;
+
 			dxtrace(printk("Creating second level index...\n"));
 			memcpy((char *) entries2, (char *) entries,
 			       icount * sizeof(struct dx_entry));
 			dx_set_limit(entries2, dx_node_limit(dir));
-
+	
 			/* Set up root */
+			dx_lock_bh(frames[0].bh);
 			dx_set_count(entries, 1);
 			dx_set_block(entries + 0, newblock);
 			((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels = 1;
+			dx_unlock_bh(frames[0].bh);
 
 			/* Add new access path frame */
 			frame = frames + 1;
 			frame->at = at = at - entries + entries2;
 			frame->entries = entries = entries2;
 			frame->bh = bh2;
+			frame->curidx = newblock;
+			frame->leaf = leaf;
 			err = ext3_journal_get_write_access(handle,
 							     frame->bh);
 			if (err)
 				goto journal_error;
+
+			/* first level index was root. it's already initialized */
+			/* we my unlock it now */
+			ext3_unlock_htree(dir, idx_lock);
+
+			/* current index is just created 2nd level index */
+			curidx = newblock;
+			idx_lock = nb_lock;
 		}
+		
 		ext3_journal_dirty_metadata(handle, frames[0].bh);
 	}
-	de = do_split(handle, dir, &bh, frame, &hinfo, &err);
+	de = do_split(handle, dir, &bh, frame, &hinfo, &newleaf_lock, &err);
 	if (!de)
 		goto cleanup;
+
+	/* index splitted */
+	ext3_unlock_htree(dir, idx_lock);
+	
 	err = add_dirent_to_buf(handle, dentry, inode, de, bh);
+
+	if (newleaf_lock)
+		ext3_unlock_htree(dir, newleaf_lock);
+	
 	bh = 0;
 	goto cleanup;
 
 journal_error:
 	ext3_std_error(dir->i_sb, err);
 cleanup:
+	ext3_unlock_htree(dir, leaf_lock);
 	if (bh)
 		brelse(bh);
 	dx_release(frames);
@@ -1967,13 +2294,14 @@ static int ext3_rmdir (struct inode * di
 	struct buffer_head * bh;
 	struct ext3_dir_entry_2 * de;
 	handle_t *handle;
+	void *lock;
 
 	handle = ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
 	retval = -ENOENT;
-	bh = ext3_find_entry (dentry, &de);
+	bh = ext3_find_entry (dentry, &de, 1, &lock);
 	if (!bh)
 		goto end_rmdir;
 
@@ -1984,14 +2312,19 @@ static int ext3_rmdir (struct inode * di
 	DQUOT_INIT(inode);
 
 	retval = -EIO;
-	if (le32_to_cpu(de->inode) != inode->i_ino)
+	if (le32_to_cpu(de->inode) != inode->i_ino) {
+		ext3_unlock_htree(dir, lock);
 		goto end_rmdir;
+	}
 
 	retval = -ENOTEMPTY;
-	if (!empty_dir (inode))
+	if (!empty_dir (inode)) {
+		ext3_unlock_htree(dir, lock);
 		goto end_rmdir;
+	}
 
 	retval = ext3_delete_entry(handle, dir, de, bh);
+	ext3_unlock_htree(dir, lock);
 	if (retval)
 		goto end_rmdir;
 	if (inode->i_nlink != 2)
@@ -2024,6 +2357,7 @@ static int ext3_unlink(struct inode * di
 	struct buffer_head * bh;
 	struct ext3_dir_entry_2 * de;
 	handle_t *handle;
+	void *lock;
 
 	handle = ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
 	if (IS_ERR(handle))
@@ -2033,7 +2367,7 @@ static int ext3_unlink(struct inode * di
 		handle->h_sync = 1;
 
 	retval = -ENOENT;
-	bh = ext3_find_entry (dentry, &de);
+	bh = ext3_find_entry (dentry, &de, 1, &lock);
 	if (!bh)
 		goto end_unlink;
 
@@ -2041,8 +2375,10 @@ static int ext3_unlink(struct inode * di
 	DQUOT_INIT(inode);
 
 	retval = -EIO;
-	if (le32_to_cpu(de->inode) != inode->i_ino)
+	if (le32_to_cpu(de->inode) != inode->i_ino) {
+		ext3_unlock_htree(dir, lock);
 		goto end_unlink;
+	}
 
 	if (!inode->i_nlink) {
 		ext3_warning (inode->i_sb, "ext3_unlink",
@@ -2051,6 +2387,7 @@ static int ext3_unlink(struct inode * di
 		inode->i_nlink = 1;
 	}
 	retval = ext3_delete_entry(handle, dir, de, bh);
+	ext3_unlock_htree(dir, lock);
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -2163,6 +2500,7 @@ static int ext3_rename (struct inode * o
 	struct buffer_head * old_bh, * new_bh, * dir_bh;
 	struct ext3_dir_entry_2 * old_de, * new_de;
 	int retval;
+	void *lock1 = NULL, *lock2 = NULL, *lock3 = NULL;
 
 	old_bh = new_bh = dir_bh = NULL;
 
@@ -2174,7 +2512,10 @@ static int ext3_rename (struct inode * o
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		handle->h_sync = 1;
 
-	old_bh = ext3_find_entry (old_dentry, &old_de);
+	if (old_dentry->d_parent == new_dentry->d_parent)
+		down(&EXT3_I(old_dentry->d_parent->d_inode)->i_rename_sem);
+
+	old_bh = ext3_find_entry (old_dentry, &old_de, 1, &lock1 /* FIXME */);
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
 	 *  We might rmdir the source, keep it as pwd of some process
@@ -2187,7 +2528,7 @@ static int ext3_rename (struct inode * o
 		goto end_rename;
 
 	new_inode = new_dentry->d_inode;
-	new_bh = ext3_find_entry (new_dentry, &new_de);
+	new_bh = ext3_find_entry (new_dentry, &new_de, 1, &lock2 /* FIXME */);
 	if (new_bh) {
 		if (!new_inode) {
 			brelse (new_bh);
@@ -2250,7 +2591,7 @@ static int ext3_rename (struct inode * o
 		struct buffer_head *old_bh2;
 		struct ext3_dir_entry_2 *old_de2;
 
-		old_bh2 = ext3_find_entry(old_dentry, &old_de2);
+		old_bh2 = ext3_find_entry(old_dentry, &old_de2, 1, &lock3 /* FIXME */);
 		if (old_bh2) {
 			retval = ext3_delete_entry(handle, old_dir,
 						   old_de2, old_bh2);
@@ -2293,11 +2634,43 @@ static int ext3_rename (struct inode * o
 	retval = 0;
 
 end_rename:
+	if (lock1)
+		ext3_unlock_htree(old_dentry->d_parent->d_inode, lock1);
+	if (lock2)
+		ext3_unlock_htree(new_dentry->d_parent->d_inode, lock2);
+	if (lock3)
+		ext3_unlock_htree(old_dentry->d_parent->d_inode, lock3);
+	if (old_dentry->d_parent == new_dentry->d_parent)
+		up(&EXT3_I(old_dentry->d_parent->d_inode)->i_rename_sem);
 	brelse (dir_bh);
 	brelse (old_bh);
 	brelse (new_bh);
 	ext3_journal_stop(handle);
 	return retval;
+}
+
+/*
+ * this locking primitives are used to protect parts
+ * of dir's htree. protection unit is block: leaf or index
+ */
+static inline void *ext3_lock_htree(struct inode *dir,
+					unsigned long value, int rwlock)
+{
+	void *lock;
+	
+	if (!test_opt(dir->i_sb, PDIROPS))
+		return NULL;
+	lock = dynlock_lock(&EXT3_I(dir)->i_htree_lock,
+				value, rwlock, GFP_KERNEL);
+	return lock;
+}
+
+static inline void ext3_unlock_htree(struct inode *dir,
+					void *lock)
+{
+	if (!test_opt(dir->i_sb, PDIROPS))
+		return;
+	dynlock_unlock(&EXT3_I(dir)->i_htree_lock, lock);
 }
 
 /*
diff -puN fs/ext3/super.c~ext3-pdirops fs/ext3/super.c
--- linux-2.5.73/fs/ext3/super.c~ext3-pdirops	Mon Jul  7 00:00:24 2003
+++ linux-2.5.73-alexey/fs/ext3/super.c	Mon Jul  7 00:00:24 2003
@@ -504,6 +504,9 @@ static struct inode *ext3_alloc_inode(st
 	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
 #endif
 	ei->vfs_inode.i_version = 1;
+	dynlock_init(&ei->i_htree_lock);
+	sema_init(&ei->i_append_sem, 1);
+	sema_init(&ei->i_rename_sem, 1);
 	return &ei->vfs_inode;
 }
 
@@ -712,6 +715,8 @@ static int parse_options (char * options
 				return 0;
 			}
 		}
+		else if (!strcmp (this_char, "pdirops"))
+			set_opt (sbi->s_mount_opt, PDIROPS);
 		else if (!strcmp (this_char, "grpid") ||
 			 !strcmp (this_char, "bsdgroups"))
 			set_opt (sbi->s_mount_opt, GRPID);
@@ -890,6 +895,10 @@ static int ext3_setup_super(struct super
 		ext3_check_blocks_bitmap (sb);
 		ext3_check_inodes_bitmap (sb);
 	}
+#endif
+#ifdef S_PDIROPS
+	if (test_opt (sb, PDIROPS))
+		sb->s_flags |= S_PDIROPS;
 #endif
 	setup_ro_after(sb);
 	return res;
diff -puN include/linux/ext3_fs.h~ext3-pdirops include/linux/ext3_fs.h
--- linux-2.5.73/include/linux/ext3_fs.h~ext3-pdirops	Mon Jul  7 00:00:24 2003
+++ linux-2.5.73-alexey/include/linux/ext3_fs.h	Mon Jul  7 00:00:24 2003
@@ -312,6 +312,7 @@ struct ext3_inode {
 /*
  * Mount flags
  */
+#define EXT3_MOUNT_PDIROPS		0x800000/* Parallel dir operations */
 #define EXT3_MOUNT_CHECK		0x0001	/* Do mount-time checks */
 #define EXT3_MOUNT_OLDALLOC		0x0002  /* Don't use the new Orlov allocator */
 #define EXT3_MOUNT_GRPID		0x0004	/* Create files with directory's group */
diff -puN include/linux/ext3_fs_i.h~ext3-pdirops include/linux/ext3_fs_i.h
--- linux-2.5.73/include/linux/ext3_fs_i.h~ext3-pdirops	Mon Jul  7 00:00:24 2003
+++ linux-2.5.73-alexey/include/linux/ext3_fs_i.h	Mon Jul  7 00:00:24 2003
@@ -17,6 +17,7 @@
 #define _LINUX_EXT3_FS_I
 
 #include <linux/rwsem.h>
+#include <linux/dynlocks.h>
 
 /*
  * second extended file system inode data in memory
@@ -98,6 +99,11 @@ struct ext3_inode_info {
 	 */
 	struct rw_semaphore truncate_sem;
 	struct inode vfs_inode;
+
+	/* following fields for parallel directory operations -bzzz */
+	struct dynlock i_htree_lock;
+	struct semaphore i_append_sem;
+	struct semaphore i_rename_sem;
 };
 
 #endif	/* _LINUX_EXT3_FS_I */

_

--=-=-=--

