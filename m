Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319078AbSHNJbM>; Wed, 14 Aug 2002 05:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319079AbSHNJbM>; Wed, 14 Aug 2002 05:31:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27872 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319078AbSHNJbE>; Wed, 14 Aug 2002 05:31:04 -0400
Date: Wed, 14 Aug 2002 15:09:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Cc: Al Viro <viro@math.psu.edu>
Subject: dcache scalability patch [2.5]
Message-ID: <20020814150915.B23966@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Appended here is the dcache scalability patch for 2.5 version with 
performance numbers for dbench. dcache_rcu-12 gives consistently better results
than base. 

The patch can be downloaded from lse site at
http://prdownloads.sourceforge.net/lse/dcache_rcu-12-2.5.30.patch?download

The patch essentially does faster d_lookup() by not taking the global
dcache_lock and significantly brings down the contention for dcache_lock,
that is by 85%

While pathwalk'ing the dcache_lock is not held and dentires are kept
around by incrementing the ref count. This also helps in reducing the
hold time for dcache_lock by more than 50%.

dbench throughput (MB/sec) for varying #s of clients on 8-way
	2.5.30		dcache_rcu-12
	======		======
1 	78.76		81.43	
2 	139.06  	140.28 
4 	218.9   	227.43 
8 	241.64  	246.8	
10	255.56   	258.34
12 	255.89   	260.66
16 	246.57   	252.97
18 	250.82   	249.79
20 	252.05   	251.59
24 	243.03   	248.12
32 	243.17   	244.87
48 	227.09   	240.98
64 	209.62   	239.52
128 	59.17    	55.97

http://lse.sourceforge.net/locking/dcache/results/2.5.30/dbench/8-way.png

dbench Throughput (MB/sec) for 12 clients
		2.5.30		2.5.30 + dcache_rcu-12
		======		=======
Uni		82.405		82.65241
2-way SMP	141.914		141.1884
4-way SMP	226.664		227.287
8-way SMP	256.064		260.4548

http://lse.sourceforge.net/locking/dcache/results/2.5.30/dbench/cpus-thruput.png


Lockmeter statistics show reduction in dcache_lock contention, utilization
and hold times. 

Base (2.5.30)
=============
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
  3.3%  7.8%  2.1us(2437us)  4.8us(2415us)(0.02%)    309088 92.2%  7.8%    0%  dcache_lock

dcache_rcu-12
=============
 0.60%  1.1%  1.0us(1108us)  6.0us(1260us)(0.00%)    112929 98.9%  1.1%    0%  dcache_lock

Detailed lockmeter report 
http://lse.sourceforge.net/locking/dcache/results/2.5.30/dbench/baselkm-2.5.30
http://lse.sourceforge.net/locking/dcache/results/2.5.30/dbench/dc12lkm-2.5.30

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html


dcache_rcu-12-2.5.31.patch
--------------------------
Changes in this version:
o Instead of entierly backing out fastwalk code to 2.5.10 level, this patch
  brings the dcache_lock down to d_lookup level and has lesser changes.
o has to put back per dentry lock because of a race in dcache_rcu-11 in 
  d_delete.


diff -urN linux-2.5.30-base/fs/autofs4/root.c linux-2.5.30-dc12/fs/autofs4/root.c
--- linux-2.5.30-base/fs/autofs4/root.c	Fri Aug  2 02:46:03 2002
+++ linux-2.5.30-dc12/fs/autofs4/root.c	Fri Aug  2 17:03:18 2002
@@ -418,7 +418,7 @@
 		unlock_kernel();
 		return -ENOTEMPTY;
 	}
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
 
 	dput(ino->dentry);
diff -urN linux-2.5.30-base/fs/dcache.c linux-2.5.30-dc12/fs/dcache.c
--- linux-2.5.30-base/fs/dcache.c	Fri Aug  2 02:46:08 2002
+++ linux-2.5.30-dc12/fs/dcache.c	Fri Aug  2 17:03:18 2002
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/cache.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 
@@ -53,14 +54,21 @@
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
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
 
@@ -122,9 +130,13 @@
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
@@ -133,20 +145,29 @@
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
@@ -176,7 +197,7 @@
 	 * If it's already been dropped, return OK.
 	 */
 	spin_lock(&dcache_lock);
-	if (list_empty(&dentry->d_hash)) {
+	if (d_unhashed(dentry)) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
@@ -206,9 +227,9 @@
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
 
@@ -217,6 +238,7 @@
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
+	dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	if (atomic_read(&dentry->d_count) == 1) {
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
@@ -254,7 +276,7 @@
 		tmp = next;
 		next = tmp->next;
 		alias = list_entry(tmp, struct dentry, d_alias);
-		if (!list_empty(&alias->d_hash)) {
+ 		if (!d_unhashed(alias)) {
 			if (alias->d_flags & DCACHE_DISCONNECTED)
 				discon_alias = alias;
 			else {
@@ -284,8 +306,8 @@
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
 		if (!atomic_read(&dentry->d_count)) {
 			__dget_locked(dentry);
+			__d_drop(dentry);
 			spin_unlock(&dcache_lock);
-			d_drop(dentry);
 			dput(dentry);
 			goto restart;
 		}
@@ -303,8 +325,9 @@
 {
 	struct dentry * parent;
 
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
 	list_del(&dentry->d_child);
+	spin_unlock(&dentry->d_lock);
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -338,19 +361,20 @@
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
+		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
-
+		
+		spin_lock(&dentry->d_lock);
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
-			list_add(&dentry->d_lru, &dentry_unused);
+			if (!atomic_read(&dentry->d_count)) {
+				list_add(&dentry->d_lru, &dentry_unused);
+				dentry_stat.nr_unused++;
+			}
+			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		dentry_stat.nr_unused--;
-
-		/* Unused dentry with a count? */
-		if (atomic_read(&dentry->d_count))
-			BUG();
 
 		prune_one_dentry(dentry);
 		if (!--count)
@@ -413,10 +437,13 @@
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
@@ -496,8 +523,8 @@
 		struct list_head *tmp = next;
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
+		list_del_init(&dentry->d_lru);
 		if (!atomic_read(&dentry->d_count)) {
-			list_del(&dentry->d_lru);
 			list_add(&dentry->d_lru, dentry_unused.prev);
 			found++;
 		}
@@ -560,8 +587,8 @@
 		spin_lock(&dcache_lock);
 		list_for_each(lp, head) {
 			struct dentry *this = list_entry(lp, struct dentry, d_hash);
+			list_del(&this->d_lru);
 			if (!atomic_read(&this->d_count)) {
-				list_del(&this->d_lru);
 				list_add_tail(&this->d_lru, &dentry_unused);
 				found++;
 			}
@@ -641,7 +668,8 @@
 	str[name->len] = 0;
 
 	atomic_set(&dentry->d_count, 1);
-	dentry->d_vfs_flags = 0;
+	dentry->d_vfs_flags = DCACHE_UNHASHED;
+	dentry->d_lock = SPIN_LOCK_UNLOCKED;
 	dentry->d_flags = 0;
 	dentry->d_inode = NULL;
 	dentry->d_parent = NULL;
@@ -847,24 +875,14 @@
  
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
 
+	rcu_read_lock();
 	tmp = head->next;
 	for (;;) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
@@ -884,9 +902,14 @@
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
@@ -925,7 +948,7 @@
 	lhp = base = d_hash(dparent, dentry->d_name.hash);
 	while ((lhp = lhp->next) != base) {
 		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-			__dget_locked(dentry);
+			dget(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
 		}
@@ -962,17 +985,18 @@
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
@@ -985,9 +1009,10 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
 	spin_lock(&dcache_lock);
+	if (!list_empty(&entry->d_hash) && !d_unhashed(entry)) BUG();
 	list_add(&entry->d_hash, list);
+	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
 	spin_unlock(&dcache_lock);
 }
 
@@ -1057,7 +1082,7 @@
 	list_add(&dentry->d_hash, &target->d_hash);
 
 	/* Unhash the target: dput() will then get rid of it */
-	list_del_init(&target->d_hash);
+	__d_drop(target);
 
 	list_del(&dentry->d_child);
 	list_del(&target->d_child);
@@ -1109,7 +1134,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
+	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		memcpy(end, " (deleted)", 10);
@@ -1192,7 +1217,7 @@
 	error = -ENOENT;
 	/* Has the current directory has been unlinked? */
 	spin_lock(&dcache_lock);
-	if (pwd->d_parent == pwd || !list_empty(&pwd->d_hash)) {
+	if (pwd->d_parent == pwd || !d_unhashed(pwd)) {
 		unsigned long len;
 		char * cwd;
 
diff -urN linux-2.5.30-base/fs/driverfs/inode.c linux-2.5.30-dc12/fs/driverfs/inode.c
--- linux-2.5.30-base/fs/driverfs/inode.c	Fri Aug  2 02:46:08 2002
+++ linux-2.5.30-dc12/fs/driverfs/inode.c	Fri Aug  2 17:05:52 2002
@@ -231,7 +231,7 @@
 		if (atomic_read(&dentry->d_count) != 2)
 			break;
 	case 2:
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 	}
 	spin_unlock(&dcache_lock);
 }
diff -urN linux-2.5.30-base/fs/intermezzo/journal.c linux-2.5.30-dc12/fs/intermezzo/journal.c
--- linux-2.5.30-base/fs/intermezzo/journal.c	Fri Aug  2 02:46:03 2002
+++ linux-2.5.30-dc12/fs/intermezzo/journal.c	Fri Aug  2 17:03:18 2002
@@ -184,7 +184,7 @@
 
         *--end = '\0';
         buflen--;
-        if (dentry->d_parent != dentry && list_empty(&dentry->d_hash)) {
+        if (dentry->d_parent != dentry && d_unhashed(dentry)) {
                 buflen -= 10;
                 end -= 10;
                 memcpy(end, " (deleted)", 10);
diff -urN linux-2.5.30-base/fs/libfs.c linux-2.5.30-dc12/fs/libfs.c
--- linux-2.5.30-base/fs/libfs.c	Fri Aug  2 02:46:02 2002
+++ linux-2.5.30-dc12/fs/libfs.c	Fri Aug  2 17:03:18 2002
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
diff -urN linux-2.5.30-base/fs/namei.c linux-2.5.30-dc12/fs/namei.c
--- linux-2.5.30-base/fs/namei.c	Fri Aug  2 02:46:18 2002
+++ linux-2.5.30-dc12/fs/namei.c	Fri Aug  2 17:03:18 2002
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
@@ -488,17 +474,27 @@
 {
 	while(1) {
 		struct vfsmount *parent;
+		struct dentry *old = *dentry;
 		if (*dentry == current->fs->root &&
 		    *mnt == current->fs->rootmnt)
 			break;
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
@@ -515,14 +511,13 @@
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
@@ -530,36 +525,21 @@
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
 
@@ -573,7 +553,7 @@
  */
 int link_path_walk(const char * name, struct nameidata *nd)
 {
-	struct path next, pinned = {NULL, NULL};
+	struct path next;
 	struct inode *inode;
 	int err;
 	unsigned int lookup_flags = nd->flags;
@@ -594,10 +574,8 @@
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
@@ -648,7 +626,7 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		err = do_lookup(nd, &this, &next, &pinned, LOOKUP_CONTINUE);
+		err = do_lookup(nd, &this, &next, LOOKUP_CONTINUE);
 		if (err)
 			break;
 		/* Check mountpoints.. */
@@ -657,21 +635,16 @@
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
@@ -680,6 +653,7 @@
 			if (!inode->i_op)
 				break;
 		} else {
+			dput(nd->dentry);
 			nd->mnt = next.mnt;
 			nd->dentry = next.dentry;
 		}
@@ -711,24 +685,20 @@
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
@@ -751,23 +721,19 @@
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
 
@@ -855,8 +821,9 @@
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
@@ -865,18 +832,14 @@
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
@@ -1548,7 +1511,7 @@
 		if (atomic_read(&dentry->d_count) != 2)
 			break;
 	case 2:
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -2115,7 +2078,6 @@
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
-	lock_nd(nd);
 	res = link_path_walk(link, nd);
 out:
 	if (current->link_count || res || nd->last_type!=LAST_NORM)
diff -urN linux-2.5.30-base/fs/nfs/dir.c linux-2.5.30-dc12/fs/nfs/dir.c
--- linux-2.5.30-base/fs/nfs/dir.c	Fri Aug  2 02:46:25 2002
+++ linux-2.5.30-dc12/fs/nfs/dir.c	Fri Aug  2 17:05:38 2002
@@ -1002,7 +1002,7 @@
 		return error;
 	}
 	if (!d_unhashed(dentry)) {
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 		need_rehash = 1;
 	}
 	spin_unlock(&dcache_lock);
diff -urN linux-2.5.30-base/include/linux/dcache.h linux-2.5.30-dc12/include/linux/dcache.h
--- linux-2.5.30-base/include/linux/dcache.h	Fri Aug  2 02:46:53 2002
+++ linux-2.5.30-dc12/include/linux/dcache.h	Fri Aug  2 17:03:18 2002
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
 
@@ -132,6 +135,8 @@
       */
 
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
+#define DCACHE_UNHASHED		0x0010	
+#define DCACHE_FREEING		0x0020
 
 extern spinlock_t dcache_lock;
 extern rwlock_t dparent_lock;
@@ -153,11 +158,16 @@
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
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
+	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
 }
 
@@ -257,9 +267,8 @@
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
@@ -275,7 +284,7 @@
  
 static __inline__ int d_unhashed(struct dentry *dentry)
 {
-	return list_empty(&dentry->d_hash);
+	return (dentry->d_vfs_flags & DCACHE_UNHASHED);
 }
 
 extern void dput(struct dentry *);
diff -urN linux-2.5.30-base/include/linux/fs_struct.h linux-2.5.30-dc12/include/linux/fs_struct.h
--- linux-2.5.30-base/include/linux/fs_struct.h	Fri Aug  2 02:46:10 2002
+++ linux-2.5.30-dc12/include/linux/fs_struct.h	Fri Aug  2 17:03:18 2002
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
diff -urN linux-2.5.30-base/kernel/exit.c linux-2.5.30-dc12/kernel/exit.c
--- linux-2.5.30-base/kernel/exit.c	Fri Aug  2 02:46:18 2002
+++ linux-2.5.30-dc12/kernel/exit.c	Fri Aug  2 17:03:18 2002
@@ -40,9 +40,9 @@
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
