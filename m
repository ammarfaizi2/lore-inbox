Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbSJNTZe>; Mon, 14 Oct 2002 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbSJNTZd>; Mon, 14 Oct 2002 15:25:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56825 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262120AbSJNTZP>; Mon, 14 Oct 2002 15:25:15 -0400
Date: Tue, 15 Oct 2002 01:05:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>
Subject: [PATCH] dcache_rcu-12 2.5.42
Message-ID: <20021015010511.A21105@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Here is the latest dcache_rcu patch written by Maneesh Soni. The
locking model remains same as described by this earlier mail.

     http://marc.theaimsgroup.com/?l=linux-kernel&m=103297624704747&w=2

The latest code fully utilizes RCU list macros to simplify
the code. Also, used the noprefetch version of list_for_each_rcu
macro since prefetch was costlier.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


diff -urN linux-2.5.42-base/drivers/usb/core/inode.c linux-2.5.42-dc12/drivers/usb/core/inode.c
--- linux-2.5.42-base/drivers/usb/core/inode.c	Sat Oct 12 09:51:31 2002
+++ linux-2.5.42-dc12/drivers/usb/core/inode.c	Mon Oct 14 19:07:07 2002
@@ -253,7 +253,7 @@
 		if (atomic_read(&dentry->d_count) != 2)
 			break;
 	case 2:
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 	}
 	spin_unlock(&dcache_lock);
 }
diff -urN linux-2.5.42-base/fs/autofs4/root.c linux-2.5.42-dc12/fs/autofs4/root.c
--- linux-2.5.42-base/fs/autofs4/root.c	Sat Oct 12 09:51:03 2002
+++ linux-2.5.42-dc12/fs/autofs4/root.c	Mon Oct 14 19:07:07 2002
@@ -418,7 +418,7 @@
 		unlock_kernel();
 		return -ENOTEMPTY;
 	}
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
 
 	dput(ino->dentry);
diff -urN linux-2.5.42-base/fs/dcache.c linux-2.5.42-dc12/fs/dcache.c
--- linux-2.5.42-base/fs/dcache.c	Sat Oct 12 09:51:33 2002
+++ linux-2.5.42-dc12/fs/dcache.c	Mon Oct 14 19:07:07 2002
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/cache.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 
@@ -55,14 +56,21 @@
 	.age_limit = 45,
 };
 
+static void d_callback(void *arg)
+{
+	struct dentry * dentry = (struct dentry *)arg;
+
+	if (dname_external(dentry)) 
+		kfree(dentry->d_name.name);
+	kmem_cache_free(dentry_cache, dentry); 
+}
+
 /* no dcache_lock, please */
 static inline void d_free(struct dentry *dentry)
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
-	if (dname_external(dentry)) 
-		kfree(dentry->d_name.name);
-	kmem_cache_free(dentry_cache, dentry); 
+	call_rcu(&dentry->d_rcu, d_callback, dentry);
 	dentry_stat.nr_dentry--;
 }
 
@@ -124,9 +132,13 @@
 	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
 		return;
 
-	/* dput on a free dentry? */
-	if (!list_empty(&dentry->d_lru))
-		BUG();
+	spin_lock(&dentry->d_lock);
+	if (atomic_read(&dentry->d_count)) {
+		spin_unlock(&dentry->d_lock);
+		spin_unlock(&dcache_lock);
+		return;
+	}
+			
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
@@ -135,20 +147,29 @@
 			goto unhash_it;
 	}
 	/* Unreachable? Get rid of it */
-	if (list_empty(&dentry->d_hash))
+ 	if (d_unhashed(dentry))
 		goto kill_it;
-	list_add(&dentry->d_lru, &dentry_unused);
-	dentry_stat.nr_unused++;
-	dentry->d_vfs_flags |= DCACHE_REFERENCED;
+ 	if (list_empty(&dentry->d_lru)) {
+ 		dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+ 		list_add(&dentry->d_lru, &dentry_unused);
+ 		dentry_stat.nr_unused++;
+ 	}
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 	return;
 
 unhash_it:
-	list_del_init(&dentry->d_hash);
+	dentry->d_vfs_flags |= DCACHE_UNHASHED;
+	list_del_rcu(&dentry->d_hash);
 
 kill_it: {
 		struct dentry *parent;
+ 		if (!list_empty(&dentry->d_lru)) {
+ 			list_del(&dentry->d_lru);
+ 			dentry_stat.nr_unused--;
+ 		}
 		list_del(&dentry->d_child);
+		spin_unlock(&dentry->d_lock);
 		/* drops the lock, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
@@ -178,7 +199,7 @@
 	 * If it's already been dropped, return OK.
 	 */
 	spin_lock(&dcache_lock);
-	if (list_empty(&dentry->d_hash)) {
+	if (d_unhashed(dentry)) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
@@ -208,9 +229,9 @@
 			return -EBUSY;
 		}
 	}
-
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
+
 	return 0;
 }
 
@@ -219,6 +240,7 @@
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
+	dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	if (atomic_read(&dentry->d_count) == 1) {
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
@@ -256,7 +278,7 @@
 		tmp = next;
 		next = tmp->next;
 		alias = list_entry(tmp, struct dentry, d_alias);
-		if (!list_empty(&alias->d_hash)) {
+ 		if (!d_unhashed(alias)) {
 			if (alias->d_flags & DCACHE_DISCONNECTED)
 				discon_alias = alias;
 			else {
@@ -286,8 +308,8 @@
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
 		if (!atomic_read(&dentry->d_count)) {
 			__dget_locked(dentry);
+			__d_drop(dentry);
 			spin_unlock(&dcache_lock);
-			d_drop(dentry);
 			dput(dentry);
 			goto restart;
 		}
@@ -305,8 +327,9 @@
 {
 	struct dentry * parent;
 
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
 	list_del(&dentry->d_child);
+	spin_unlock(&dentry->d_lock);
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -339,18 +362,20 @@
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
+ 		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
+ 		spin_lock(&dentry->d_lock);
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
-			list_add(&dentry->d_lru, &dentry_unused);
+ 			if (!atomic_read(&dentry->d_count)) {
+ 				list_add(&dentry->d_lru, &dentry_unused);
+ 				dentry_stat.nr_unused++;
+ 			}
+ 			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		dentry_stat.nr_unused--;
-
-		/* Unused dentry with a count? */
-		BUG_ON(atomic_read(&dentry->d_count));
 		prune_one_dentry(dentry);
 	}
 	spin_unlock(&dcache_lock);
@@ -410,10 +435,13 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		if (atomic_read(&dentry->d_count))
-			continue;
 		dentry_stat.nr_unused--;
 		list_del_init(tmp);
+		spin_lock(&dentry->d_lock);
+		if (atomic_read(&dentry->d_count)) {
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
 		prune_one_dentry(dentry);
 		goto repeat;
 	}
@@ -493,8 +521,8 @@
 		struct list_head *tmp = next;
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
+		list_del_init(&dentry->d_lru);
 		if (!atomic_read(&dentry->d_count)) {
-			list_del(&dentry->d_lru);
 			list_add(&dentry->d_lru, dentry_unused.prev);
 			found++;
 		}
@@ -557,8 +585,8 @@
 		spin_lock(&dcache_lock);
 		list_for_each(lp, head) {
 			struct dentry *this = list_entry(lp, struct dentry, d_hash);
+			list_del(&this->d_lru);
 			if (!atomic_read(&this->d_count)) {
-				list_del(&this->d_lru);
 				list_add_tail(&this->d_lru, &dentry_unused);
 				found++;
 			}
@@ -627,7 +655,8 @@
 	str[name->len] = 0;
 
 	atomic_set(&dentry->d_count, 1);
-	dentry->d_vfs_flags = 0;
+	dentry->d_vfs_flags = DCACHE_UNHASHED;
+	dentry->d_lock = SPIN_LOCK_UNLOCKED;
 	dentry->d_flags = 0;
 	dentry->d_inode = NULL;
 	dentry->d_parent = NULL;
@@ -833,30 +862,16 @@
  
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
-	struct dentry * dentry;
-	spin_lock(&dcache_lock);
-	dentry = __d_lookup(parent,name);
-	if (dentry)
-		__dget_locked(dentry);
-	spin_unlock(&dcache_lock);
-	return dentry;
-}
-
-struct dentry * __d_lookup(struct dentry * parent, struct qstr * name)  
-{
-
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
 	const unsigned char *str = name->name;
 	struct list_head *head = d_hash(parent,hash);
 	struct list_head *tmp;
+	struct dentry *found = NULL;
 
-	tmp = head->next;
-	for (;;) {
+	rcu_read_lock();
+	__list_for_each_rcu(tmp, head) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
-		if (tmp == head)
-			break;
-		tmp = tmp->next;
 		if (dentry->d_name.hash != hash)
 			continue;
 		if (dentry->d_parent != parent)
@@ -870,9 +885,14 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		return dentry;
-	}
-	return NULL;
+		spin_lock(&dentry->d_lock);
+		if (!d_unhashed(dentry))
+			found = dget(dentry);
+		spin_unlock(&dentry->d_lock);
+		break;
+ 	}
+ 	rcu_read_unlock();
+ 	return found;
 }
 
 /**
@@ -911,7 +931,7 @@
 	lhp = base = d_hash(dparent, dentry->d_name.hash);
 	while ((lhp = lhp->next) != base) {
 		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-			__dget_locked(dentry);
+			dget(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
 		}
@@ -948,17 +968,18 @@
 	 * Are we the only user?
 	 */
 	spin_lock(&dcache_lock);
+	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) == 1) {
+		spin_unlock(&dentry->d_lock);
 		dentry_iput(dentry);
 		return;
 	}
-	spin_unlock(&dcache_lock);
 
-	/*
-	 * If not, just drop the dentry and let dput
-	 * pick up the tab..
-	 */
-	d_drop(dentry);
+	if (!d_unhashed(dentry))
+		__d_drop(dentry);
+
+	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dcache_lock);
 }
 
 /**
@@ -971,9 +992,10 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
 	spin_lock(&dcache_lock);
-	list_add(&entry->d_hash, list);
+	if (!list_empty(&entry->d_hash) && !d_unhashed(entry)) BUG();
+	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
+	list_add_rcu(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
 }
 
@@ -1043,7 +1065,7 @@
 	list_add(&dentry->d_hash, &target->d_hash);
 
 	/* Unhash the target: dput() will then get rid of it */
-	list_del_init(&target->d_hash);
+	__d_drop(target);
 
 	list_del(&dentry->d_child);
 	list_del(&target->d_child);
@@ -1095,7 +1117,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
+	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		memcpy(end, " (deleted)", 10);
@@ -1178,7 +1200,7 @@
 	error = -ENOENT;
 	/* Has the current directory has been unlinked? */
 	spin_lock(&dcache_lock);
-	if (pwd->d_parent == pwd || !list_empty(&pwd->d_hash)) {
+	if (pwd->d_parent == pwd || !d_unhashed(pwd)) {
 		unsigned long len;
 		char * cwd;
 
diff -urN linux-2.5.42-base/fs/exec.c linux-2.5.42-dc12/fs/exec.c
--- linux-2.5.42-base/fs/exec.c	Sat Oct 12 09:51:41 2002
+++ linux-2.5.42-dc12/fs/exec.c	Mon Oct 14 19:23:14 2002
@@ -499,9 +499,9 @@
 
 	if (proc_dentry) {
 		spin_lock(&dcache_lock);
-		if (!list_empty(&proc_dentry->d_hash)) {
+		if (!d_unhashed(proc_dentry)) {
 			dget_locked(proc_dentry);
-			list_del_init(&proc_dentry->d_hash);
+			__d_drop(proc_dentry);
 		} else
 			proc_dentry = NULL;
 		spin_unlock(&dcache_lock);
diff -urN linux-2.5.42-base/fs/intermezzo/journal.c linux-2.5.42-dc12/fs/intermezzo/journal.c
--- linux-2.5.42-base/fs/intermezzo/journal.c	Sat Oct 12 09:51:03 2002
+++ linux-2.5.42-dc12/fs/intermezzo/journal.c	Mon Oct 14 19:07:07 2002
@@ -184,7 +184,7 @@
 
         *--end = '\0';
         buflen--;
-        if (dentry->d_parent != dentry && list_empty(&dentry->d_hash)) {
+        if (dentry->d_parent != dentry && d_unhashed(dentry)) {
                 buflen -= 10;
                 end -= 10;
                 memcpy(end, " (deleted)", 10);
diff -urN linux-2.5.42-base/fs/libfs.c linux-2.5.42-dc12/fs/libfs.c
--- linux-2.5.42-base/fs/libfs.c	Sat Oct 12 09:51:03 2002
+++ linux-2.5.42-dc12/fs/libfs.c	Mon Oct 14 19:07:07 2002
@@ -70,7 +70,7 @@
 			while (n && p != &file->f_dentry->d_subdirs) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_child);
-				if (!list_empty(&next->d_hash) && next->d_inode)
+				if (!d_unhashed(next) && next->d_inode)
 					n--;
 				p = p->next;
 			}
@@ -127,7 +127,7 @@
 			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_child);
-				if (list_empty(&next->d_hash) || !next->d_inode)
+				if (d_unhashed(next) || !next->d_inode)
 					continue;
 
 				spin_unlock(&dcache_lock);
diff -urN linux-2.5.42-base/fs/namei.c linux-2.5.42-dc12/fs/namei.c
--- linux-2.5.42-base/fs/namei.c	Sat Oct 12 09:51:39 2002
+++ linux-2.5.42-dc12/fs/namei.c	Mon Oct 14 19:07:07 2002
@@ -286,27 +286,6 @@
 	return dentry;
 }
 
-/*for fastwalking*/
-static inline void unlock_nd(struct nameidata *nd)
-{
-	struct vfsmount *mnt = nd->old_mnt;
-	struct dentry *dentry = nd->old_dentry;
-	mntget(nd->mnt);
-	dget_locked(nd->dentry);
-	nd->old_mnt = NULL;
-	nd->old_dentry = NULL;
-	spin_unlock(&dcache_lock);
-	dput(dentry);
-	mntput(mnt);
-}
-
-static inline void lock_nd(struct nameidata *nd)
-{
-	spin_lock(&dcache_lock);
-	nd->old_mnt = nd->mnt;
-	nd->old_dentry = nd->dentry;
-}
-
 /*
  * Short-cut version of permission(), for calling by
  * path_walk(), when dcache lock is held.  Combines parts
@@ -451,11 +430,18 @@
 {
 	int res = 0;
 	while (d_mountpoint(*dentry)) {
-		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry);
-		if (!mounted)
+		struct vfsmount *mounted;
+		spin_lock(&dcache_lock);
+		mounted = lookup_mnt(*mnt, *dentry);
+		if (!mounted) {
+			spin_unlock(&dcache_lock);
 			break;
-		*mnt = mounted;
-		*dentry = mounted->mnt_root;
+		}
+		*mnt = mntget(mounted);
+		spin_unlock(&dcache_lock);
+		dput(*dentry);
+		mntput(mounted->mnt_parent);
+		*dentry = dget(mounted->mnt_root);
 		res = 1;
 	}
 	return res;
@@ -488,17 +474,32 @@
 {
 	while(1) {
 		struct vfsmount *parent;
+		struct dentry *old = *dentry;
+
+                read_lock(&current->fs->lock);
 		if (*dentry == current->fs->root &&
-		    *mnt == current->fs->rootmnt)
+		    *mnt == current->fs->rootmnt) {
+                        read_unlock(&current->fs->lock);
 			break;
+		}
+                read_unlock(&current->fs->lock);
+		spin_lock(&dcache_lock);
 		if (*dentry != (*mnt)->mnt_root) {
-			*dentry = (*dentry)->d_parent;
+			*dentry = dget((*dentry)->d_parent);
+			spin_unlock(&dcache_lock);
+			dput(old);
 			break;
 		}
-		parent=(*mnt)->mnt_parent;
-		if (parent == *mnt)
+		parent = (*mnt)->mnt_parent;
+		if (parent == *mnt) {
+			spin_unlock(&dcache_lock);
 			break;
-		*dentry=(*mnt)->mnt_mountpoint;
+		}
+		mntget(parent);
+		*dentry = dget((*mnt)->mnt_mountpoint);
+		spin_unlock(&dcache_lock);
+		dput(old);
+		mntput(*mnt);
 		*mnt = parent;
 	}
 	follow_mount(mnt, dentry);
@@ -515,14 +516,13 @@
  *  It _is_ time-critical.
  */
 static int do_lookup(struct nameidata *nd, struct qstr *name,
-		     struct path *path, struct path *cached_path,
-		     int flags)
+		     struct path *path, int flags)
 {
 	struct vfsmount *mnt = nd->mnt;
-	struct dentry *dentry = __d_lookup(nd->dentry, name);
+	struct dentry *dentry = d_lookup(nd->dentry, name);
 
 	if (!dentry)
-		goto dcache_miss;
+		goto need_lookup;
 	if (dentry->d_op && dentry->d_op->d_revalidate)
 		goto need_revalidate;
 done:
@@ -530,36 +530,21 @@
 	path->dentry = dentry;
 	return 0;
 
-dcache_miss:
-	unlock_nd(nd);
-
 need_lookup:
 	dentry = real_lookup(nd->dentry, name, LOOKUP_CONTINUE);
 	if (IS_ERR(dentry))
 		goto fail;
-	mntget(mnt);
-relock:
-	dput(cached_path->dentry);
-	mntput(cached_path->mnt);
-	cached_path->mnt = mnt;
-	cached_path->dentry = dentry;
-	lock_nd(nd);
 	goto done;
 
 need_revalidate:
-	mntget(mnt);
-	dget_locked(dentry);
-	unlock_nd(nd);
 	if (dentry->d_op->d_revalidate(dentry, flags))
-		goto relock;
+		goto done;
 	if (d_invalidate(dentry))
-		goto relock;
+		goto done;
 	dput(dentry);
-	mntput(mnt);
 	goto need_lookup;
 
 fail:
-	lock_nd(nd);
 	return PTR_ERR(dentry);
 }
 
@@ -573,7 +558,7 @@
  */
 int link_path_walk(const char * name, struct nameidata *nd)
 {
-	struct path next, pinned = {NULL, NULL};
+	struct path next;
 	struct inode *inode;
 	int err;
 	unsigned int lookup_flags = nd->flags;
@@ -594,10 +579,8 @@
 		unsigned int c;
 
 		err = exec_permission_lite(inode);
-		if (err == -EAGAIN) {
-			unlock_nd(nd);
+		if (err == -EAGAIN) { 
 			err = permission(inode, MAY_EXEC);
-			lock_nd(nd);
 		}
  		if (err)
 			break;
@@ -648,7 +631,7 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		err = do_lookup(nd, &this, &next, &pinned, LOOKUP_CONTINUE);
+		err = do_lookup(nd, &this, &next, LOOKUP_CONTINUE);
 		if (err)
 			break;
 		/* Check mountpoints.. */
@@ -657,21 +640,16 @@
 		err = -ENOENT;
 		inode = next.dentry->d_inode;
 		if (!inode)
-			break;
+			goto out_dput;
 		err = -ENOTDIR; 
 		if (!inode->i_op)
-			break;
+			goto out_dput;
 
 		if (inode->i_op->follow_link) {
-			mntget(next.mnt);
-			dget_locked(next.dentry);
-			unlock_nd(nd);
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
-			mntput(next.mnt);
 			if (err)
 				goto return_err;
-			lock_nd(nd);
 			err = -ENOENT;
 			inode = nd->dentry->d_inode;
 			if (!inode)
@@ -680,6 +658,7 @@
 			if (!inode->i_op)
 				break;
 		} else {
+			dput(nd->dentry);
 			nd->mnt = next.mnt;
 			nd->dentry = next.dentry;
 		}
@@ -711,24 +690,20 @@
 			if (err < 0)
 				break;
 		}
-		err = do_lookup(nd, &this, &next, &pinned, 0);
+		err = do_lookup(nd, &this, &next, 0);
 		if (err)
 			break;
 		follow_mount(&next.mnt, &next.dentry);
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
-			mntget(next.mnt);
-			dget_locked(next.dentry);
-			unlock_nd(nd);
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
-			mntput(next.mnt);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
-			lock_nd(nd);
 		} else {
+			dput(nd->dentry);
 			nd->mnt = next.mnt;
 			nd->dentry = next.dentry;
 		}
@@ -751,23 +726,19 @@
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
 return_base:
-		unlock_nd(nd);
-		dput(pinned.dentry);
-		mntput(pinned.mnt);
 		return 0;
+out_dput:
+		dput(next.dentry);
+		break;
 	}
-	unlock_nd(nd);
 	path_release(nd);
 return_err:
-	dput(pinned.dentry);
-	mntput(pinned.mnt);
 	return err;
 }
 
 int path_walk(const char * name, struct nameidata *nd)
 {
 	current->total_link_count = 0;
-	lock_nd(nd);
 	return link_path_walk(name, nd);
 }
 
@@ -855,8 +826,9 @@
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
+
+	read_lock(&current->fs->lock);
 	if (*name=='/') {
-		read_lock(&current->fs->lock);
 		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
 			nd->mnt = mntget(current->fs->altrootmnt);
 			nd->dentry = dget(current->fs->altroot);
@@ -865,18 +837,14 @@
 				return 0;
 			read_lock(&current->fs->lock);
 		}
-		read_unlock(&current->fs->lock);
-		spin_lock(&dcache_lock);
-		nd->mnt = current->fs->rootmnt;
-		nd->dentry = current->fs->root;
+		nd->mnt = mntget(current->fs->rootmnt);
+		nd->dentry = dget(current->fs->root);
 	}
 	else{
-		spin_lock(&dcache_lock);
-		nd->mnt = current->fs->pwdmnt;
-		nd->dentry = current->fs->pwd;
+		nd->mnt = mntget(current->fs->pwdmnt);
+		nd->dentry = dget(current->fs->pwd);
 	}
-	nd->old_mnt = NULL;
-	nd->old_dentry = NULL;
+	read_unlock(&current->fs->lock);
 	current->total_link_count = 0;
 	return link_path_walk(name, nd);
 }
@@ -1548,7 +1516,7 @@
 		if (atomic_read(&dentry->d_count) != 2)
 			break;
 	case 2:
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -2115,7 +2083,6 @@
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
-	lock_nd(nd);
 	res = link_path_walk(link, nd);
 out:
 	if (current->link_count || res || nd->last_type!=LAST_NORM)
diff -urN linux-2.5.42-base/fs/nfs/dir.c linux-2.5.42-dc12/fs/nfs/dir.c
--- linux-2.5.42-base/fs/nfs/dir.c	Sat Oct 12 09:52:07 2002
+++ linux-2.5.42-dc12/fs/nfs/dir.c	Mon Oct 14 19:07:07 2002
@@ -1001,7 +1001,7 @@
 		return error;
 	}
 	if (!d_unhashed(dentry)) {
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 		need_rehash = 1;
 	}
 	spin_unlock(&dcache_lock);
diff -urN linux-2.5.42-base/include/linux/dcache.h linux-2.5.42-dc12/include/linux/dcache.h
--- linux-2.5.42-base/include/linux/dcache.h	Sat Oct 12 09:52:45 2002
+++ linux-2.5.42-dc12/include/linux/dcache.h	Mon Oct 14 19:07:07 2002
@@ -7,6 +7,7 @@
 #include <linux/mount.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 #include <asm/page.h>			/* for BUG() */
 
 /*
@@ -68,11 +69,13 @@
 
 struct dentry {
 	atomic_t d_count;
+	unsigned long d_vfs_flags;	/* moved here to be on same cacheline */
+	spinlock_t d_lock;		/* per dentry lock */
 	unsigned int d_flags;
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
 	struct dentry * d_parent;	/* parent directory */
 	struct list_head d_hash;	/* lookup hash list */
-	struct list_head d_lru;		/* d_count = 0 LRU list */
+	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
 	struct list_head d_alias;	/* inode alias list */
@@ -81,8 +84,8 @@
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations  *d_op;
 	struct super_block * d_sb;	/* The root of the dentry tree */
-	unsigned long d_vfs_flags;
 	void * d_fsdata;		/* fs-specific data */
+	struct rcu_head d_rcu;
 	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
 };
 
@@ -132,6 +135,7 @@
       */
 
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
+#define DCACHE_UNHASHED		0x0010	
 
 extern spinlock_t dcache_lock;
 extern rwlock_t dparent_lock;
@@ -153,10 +157,16 @@
  * timeouts or autofs deletes).
  */
 
+static __inline__ void __d_drop(struct dentry * dentry)
+{
+	dentry->d_vfs_flags |= DCACHE_UNHASHED;
+	list_del_rcu(&dentry->d_hash);
+}
+
 static __inline__ void d_drop(struct dentry * dentry)
 {
 	spin_lock(&dcache_lock);
-	list_del_init(&dentry->d_hash);
+ 	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
 }
 
@@ -254,9 +264,8 @@
 static __inline__ struct dentry * dget(struct dentry *dentry)
 {
 	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
 		atomic_inc(&dentry->d_count);
+		dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	}
 	return dentry;
 }
@@ -272,7 +281,7 @@
  
 static __inline__ int d_unhashed(struct dentry *dentry)
 {
-	return list_empty(&dentry->d_hash);
+	return (dentry->d_vfs_flags & DCACHE_UNHASHED);
 }
 
 extern void dput(struct dentry *);
diff -urN linux-2.5.42-base/include/linux/fs_struct.h linux-2.5.42-dc12/include/linux/fs_struct.h
--- linux-2.5.42-base/include/linux/fs_struct.h	Sat Oct 12 09:52:14 2002
+++ linux-2.5.42-dc12/include/linux/fs_struct.h	Mon Oct 14 19:07:07 2002
@@ -35,12 +35,10 @@
 	struct dentry *old_root;
 	struct vfsmount *old_rootmnt;
 	write_lock(&fs->lock);
-	spin_lock(&dcache_lock);
 	old_root = fs->root;
 	old_rootmnt = fs->rootmnt;
 	fs->rootmnt = mntget(mnt);
 	fs->root = dget(dentry);
-	spin_unlock(&dcache_lock);
 	write_unlock(&fs->lock);
 	if (old_root) {
 		dput(old_root);
@@ -60,12 +58,10 @@
 	struct dentry *old_pwd;
 	struct vfsmount *old_pwdmnt;
 	write_lock(&fs->lock);
-	spin_lock(&dcache_lock);
 	old_pwd = fs->pwd;
 	old_pwdmnt = fs->pwdmnt;
 	fs->pwdmnt = mntget(mnt);
 	fs->pwd = dget(dentry);
-	spin_unlock(&dcache_lock);
 	write_unlock(&fs->lock);
 	if (old_pwd) {
 		dput(old_pwd);
diff -urN linux-2.5.42-base/include/linux/namei.h linux-2.5.42-dc12/include/linux/namei.h
--- linux-2.5.42-base/include/linux/namei.h	Sat Oct 12 09:51:38 2002
+++ linux-2.5.42-dc12/include/linux/namei.h	Mon Oct 14 19:07:07 2002
@@ -11,8 +11,6 @@
 	struct qstr	last;
 	unsigned int	flags;
 	int		last_type;
-	struct dentry	*old_dentry;
-	struct vfsmount	*old_mnt;
 };
 
 /*
diff -urN linux-2.5.42-base/kernel/exit.c linux-2.5.42-dc12/kernel/exit.c
--- linux-2.5.42-base/kernel/exit.c	Sat Oct 12 09:52:19 2002
+++ linux-2.5.42-dc12/kernel/exit.c	Mon Oct 14 19:07:07 2002
@@ -45,9 +45,9 @@
 	proc_dentry = p->proc_dentry;
 	if (unlikely(proc_dentry != NULL)) {
 		spin_lock(&dcache_lock);
-		if (!list_empty(&proc_dentry->d_hash)) {
+		if (!d_unhashed(proc_dentry)) {
 			dget_locked(proc_dentry);
-			list_del_init(&proc_dentry->d_hash);
+			__d_drop(proc_dentry);
 		} else
 			proc_dentry = NULL;
 		spin_unlock(&dcache_lock);
