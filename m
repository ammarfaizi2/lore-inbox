Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbSIYRnd>; Wed, 25 Sep 2002 13:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSIYRnd>; Wed, 25 Sep 2002 13:43:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13729 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262037AbSIYRm5>; Wed, 25 Sep 2002 13:42:57 -0400
Date: Wed, 25 Sep 2002 23:23:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>
Subject: [PATCH] dcache_rcu and its locking model
Message-ID: <20020925232346.A14518@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Here is the dcache_rcu patch written by Maneesh. We have been using
it with good benefits in large smp boxes (webserver, kernel compilation,
dbench) and no regression in small smp boxes. I am including below
a description of the dcache locking model used by dcache_rcu.

dcache_rcu : dcache locking model
---------------------------------
Prior to 2.5.10, dcache_lock was acquired in d_lookup and thus
in every component during path lookup. Since 2.5.10 onwards, 
fastwalk algorithm changed this by holding the dcache_lock
at the beginning and walking as many cached path component
dentries as possible. This signficantly decreases the number
of acquisition of dcache_lock. However it also increases the
lock hold time signficantly and affects performance in large
SMP machines. dcache_rcu works around it by not holding
the dcache_lock while walking the path as much as possible, but
uses pre-2.5.10 model for returned refcounted dentries for
walking the path.

dcache_rcu locking model is not very different from the existing
dcache locking model. Apart from the hash chain, in existing
code dcache_lock protects the d_alias, d_lru etc. lists as well
as d_inode and several other things like mount lookup. dcache_rcu
affects only the way the hash chain is protected. For everything
else the dcache_lock must be taken (like existing code) for both 
traversing as well as updating. The hash chain updations too
take the dcache_lock. The significant change is the way d_lookup
traverses the hash chain, it doesn't acquire the dcache_lock for
this and rely on RCU to ensure that the dentry has not been
*freed*. The various important issues in the dcache_rcu locking
model are -

1. The deletion from hash chain is done using list_del_rcu() macro which
doesn't initialize next pointer of the deleted dentry and this
allows us to walk safely lockfree while a deletion is happening.

2. Insertion of a dentry into the hash table is done using
list_add_rcu() which take care of ordering the writes -
the writes to the dentry must be visible before the dentry
is inserted. This works in conjuction with list_for_each_rcu()
while walking the hash chain. The only requirement is that
all initialization to the dentry must be done before list_add_rcu()
since we don't have dcache_lock protection while traversing
the hash chain. This isn't different from the existing code.

3. The dentry looked up by d_lookup cannot be returned for walking if it is
stale. It then may have a NULL d_inode or other bogosity since
RCU doesn't protect the other fields in the dentry. We therefore
use a flag DCACHE_UNHASHED to indicate unhashed (stale) dentries and use
this in conjunction with a per-dentry lock.

4. Once a dentry is looked up, it must be ensured during the path
walk for that component it doesn't go away. In pre-2.5.10 code, this was done
holding a reference to the dentry. dcache_rcu does the same.
In some sense, dcache_rcu path walking looks like the pre-2.5.10
version.

5. All dentry hash chain updations must take the dcache_lock as well as 
the per-dentry lock in that order. dput() does this to ensure that a 
dentry that has just been looked up in another CPU but dget() hasn't happend,
doesn't get deleted before the dget(). IOW, no race between getting
deleted vs. looked up.

6. Existing dcache interfaces exported to filesystem don't change. 
Only dcache internal implementation changes.
-----------------------------------------------------

We also did some microbenchmarking with test that does a large number
of file operations to exercise dcache in a 4x SMP and the profiles
of some interesting routines look like this -
                                Base    dcache_rcu
                                ------------------
.text.lock.dcache               19586    1569
.text.lock.namei                12892     984
link_path_walk                  15017   13256
follow_mount                     1851   11027
__d_lookup                      10084    --- 
d_lookup                         2885   30067
path_lookup                      6934    9283
.text.lock.dec_and_lock         3994     1568
                            -------------------
                                73243   67754

Of these, the significant cost in d_lookup for dcache_rcu is coming from 
the dentry cacheline miss while taking the per-dentry lock.
Subsequent dget() cost for that dentry is not as significant.
So it becomes a tradeoff between dentry cache miss cost vs.
dcache_lock cost. What we see is that while at lower end SMP
it tends to even out, in larger SMP boxes dcache_lock cost increase
very significantly and seems to far outweigh the cost of dentry 
cacheline misses during lookup.

So, dcache_rcu seems to be a reasonable compromise to solve this
problem. If you have any other suggestions or a cleaner way to
do dcache_rcu, we will give them a try.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

dcache_rcu-12-2.5.38.patch
--------------------------

diff -urN linux-2.5.38-base/fs/autofs4/root.c linux-2.5.38-rcu/fs/autofs4/root.c
--- linux-2.5.38-base/fs/autofs4/root.c	Sun Sep 22 09:54:58 2002
+++ linux-2.5.38-rcu/fs/autofs4/root.c	Tue Sep 24 16:11:01 2002
@@ -418,7 +418,7 @@
 		unlock_kernel();
 		return -ENOTEMPTY;
 	}
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
 
 	dput(ino->dentry);
diff -urN linux-2.5.38-base/fs/dcache.c linux-2.5.38-rcu/fs/dcache.c
--- linux-2.5.38-base/fs/dcache.c	Sun Sep 22 09:55:01 2002
+++ linux-2.5.38-rcu/fs/dcache.c	Tue Sep 24 16:15:59 2002
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
@@ -847,30 +875,16 @@
  
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
+	list_for_each_rcu(tmp, head) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
-		if (tmp == head)
-			break;
-		tmp = tmp->next;
 		if (dentry->d_name.hash != hash)
 			continue;
 		if (dentry->d_parent != parent)
@@ -884,9 +898,14 @@
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
@@ -925,7 +944,7 @@
 	lhp = base = d_hash(dparent, dentry->d_name.hash);
 	while ((lhp = lhp->next) != base) {
 		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-			__dget_locked(dentry);
+			dget(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
 		}
@@ -962,17 +981,18 @@
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
@@ -985,9 +1005,10 @@
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
 
@@ -1057,7 +1078,7 @@
 	list_add(&dentry->d_hash, &target->d_hash);
 
 	/* Unhash the target: dput() will then get rid of it */
-	list_del_init(&target->d_hash);
+	__d_drop(target);
 
 	list_del(&dentry->d_child);
 	list_del(&target->d_child);
@@ -1109,7 +1130,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
+	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		memcpy(end, " (deleted)", 10);
@@ -1192,7 +1213,7 @@
 	error = -ENOENT;
 	/* Has the current directory has been unlinked? */
 	spin_lock(&dcache_lock);
-	if (pwd->d_parent == pwd || !list_empty(&pwd->d_hash)) {
+	if (pwd->d_parent == pwd || !d_unhashed(pwd)) {
 		unsigned long len;
 		char * cwd;
 
diff -urN linux-2.5.38-base/fs/intermezzo/journal.c linux-2.5.38-rcu/fs/intermezzo/journal.c
--- linux-2.5.38-base/fs/intermezzo/journal.c	Sun Sep 22 09:54:58 2002
+++ linux-2.5.38-rcu/fs/intermezzo/journal.c	Tue Sep 24 16:11:01 2002
@@ -184,7 +184,7 @@
 
         *--end = '\0';
         buflen--;
-        if (dentry->d_parent != dentry && list_empty(&dentry->d_hash)) {
+        if (dentry->d_parent != dentry && d_unhashed(dentry)) {
                 buflen -= 10;
                 end -= 10;
                 memcpy(end, " (deleted)", 10);
diff -urN linux-2.5.38-base/fs/libfs.c linux-2.5.38-rcu/fs/libfs.c
--- linux-2.5.38-base/fs/libfs.c	Sun Sep 22 09:54:58 2002
+++ linux-2.5.38-rcu/fs/libfs.c	Tue Sep 24 16:11:01 2002
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
diff -urN linux-2.5.38-base/fs/namei.c linux-2.5.38-rcu/fs/namei.c
--- linux-2.5.38-base/fs/namei.c	Sun Sep 22 09:55:06 2002
+++ linux-2.5.38-rcu/fs/namei.c	Tue Sep 24 16:11:01 2002
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
diff -urN linux-2.5.38-base/fs/nfs/dir.c linux-2.5.38-rcu/fs/nfs/dir.c
--- linux-2.5.38-base/fs/nfs/dir.c	Sun Sep 22 09:55:10 2002
+++ linux-2.5.38-rcu/fs/nfs/dir.c	Tue Sep 24 16:11:01 2002
@@ -1002,7 +1002,7 @@
 		return error;
 	}
 	if (!d_unhashed(dentry)) {
-		list_del_init(&dentry->d_hash);
+		__d_drop(dentry);
 		need_rehash = 1;
 	}
 	spin_unlock(&dcache_lock);
diff -urN linux-2.5.38-base/include/linux/dcache.h linux-2.5.38-rcu/include/linux/dcache.h
--- linux-2.5.38-base/include/linux/dcache.h	Sun Sep 22 09:55:31 2002
+++ linux-2.5.38-rcu/include/linux/dcache.h	Tue Sep 24 16:11:01 2002
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
@@ -153,11 +157,16 @@
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
 
@@ -255,9 +264,8 @@
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
@@ -273,7 +281,7 @@
  
 static __inline__ int d_unhashed(struct dentry *dentry)
 {
-	return list_empty(&dentry->d_hash);
+	return (dentry->d_vfs_flags & DCACHE_UNHASHED);
 }
 
 extern void dput(struct dentry *);
diff -urN linux-2.5.38-base/include/linux/fs_struct.h linux-2.5.38-rcu/include/linux/fs_struct.h
--- linux-2.5.38-base/include/linux/fs_struct.h	Sun Sep 22 09:55:02 2002
+++ linux-2.5.38-rcu/include/linux/fs_struct.h	Tue Sep 24 16:11:01 2002
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
diff -urN linux-2.5.38-base/include/linux/namei.h linux-2.5.38-rcu/include/linux/namei.h
--- linux-2.5.38-base/include/linux/namei.h	Sun Sep 22 09:55:05 2002
+++ linux-2.5.38-rcu/include/linux/namei.h	Tue Sep 24 16:11:01 2002
@@ -11,8 +11,6 @@
 	struct qstr	last;
 	unsigned int	flags;
 	int		last_type;
-	struct dentry	*old_dentry;
-	struct vfsmount	*old_mnt;
 };
 
 /*
diff -urN linux-2.5.38-base/kernel/exit.c linux-2.5.38-rcu/kernel/exit.c
--- linux-2.5.38-base/kernel/exit.c	Sun Sep 22 09:55:05 2002
+++ linux-2.5.38-rcu/kernel/exit.c	Tue Sep 24 16:11:01 2002
@@ -44,9 +44,9 @@
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
