Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291065AbSBLOJo>; Tue, 12 Feb 2002 09:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291066AbSBLOJ3>; Tue, 12 Feb 2002 09:09:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21239 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291062AbSBLOJM>;
	Tue, 12 Feb 2002 09:09:12 -0500
Date: Tue, 12 Feb 2002 19:41:34 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: lse-tech@in.ibm.com
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
        Paul.McKenney@us.ibm.com, viro@math.psu.edu, anton@samba.org,
        andrea@suse.de, tytso@mit.edu
Subject: [PATCH][RFC] Peeling off dcache_lock - Ver 2
Message-ID: <20020212194134.N4411@in.ibm.com>
Reply-To: maneesh@in.ibm.com
In-Reply-To: <20020121174039.D8289@in.ibm.com> <20020124180241.4d266b3e.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020124180241.4d266b3e.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Jan 24, 2002 at 06:02:41PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the cleaned up dcache patch using Read-Copy update and lazy lru list
updation logic from
	http://lse.sourceforge.net/locking/dcache/dcache_lock.html

The cleanups were suggested by Rusty Russell.
 
Change log:
o  New patch name.
o  Better name for DCACHE_DEFERRED_FREE, now it is DCACHE_UNLINKED
o  Removed d_nexthash from struct dentry and replaced all
   list_empty(dentry->d_hash) with d_unhashed(dentry).
o  Changed d_count to non-atomic as all updates to d_count are done under
   per dentry lock.
o  Changed unhash() & __unhash() to dentry_unhash() and __dentry_unhash().
   dentry_unhash() just calls __dentry_unhash() with per dentry lock held.

dcache_rcu-2.4.17-2.patch:

diff -urN linux-2.4.17/fs/autofs4/expire.c linux-2.4.17-dcache_rcu-2/fs/autofs4/expire.c
--- linux-2.4.17/fs/autofs4/expire.c	Tue Jun 12 07:45:27 2001
+++ linux-2.4.17-dcache_rcu-2/fs/autofs4/expire.c	Tue Feb 12 16:06:02 2002
@@ -84,7 +84,8 @@
 	struct list_head *next;
 	int count;
 
-	count = atomic_read(&top->d_count);
+	spin_lock(&top->d_lock);
+	count = top->d_count;
 	
 	DPRINTK(("is_tree_busy: top=%p initial count=%d\n", 
 		 top, count));
@@ -107,7 +108,8 @@
 						   d_child);
 		next = next->next;
 
-		count += atomic_read(&dentry->d_count) - 1;
+		spin_lock(&dentry->d_lock);
+		count += dentry->d_count - 1;
 
 		if (d_mountpoint(dentry))
 			adj += check_vfsmnt(topmnt, dentry);
@@ -121,15 +123,18 @@
 		count -= adj;
 
 		if (!list_empty(&dentry->d_subdirs)) {
+			spin_unlock(&dentry->d_lock);
 			this_parent = dentry;
 			goto repeat;
 		}
 
-		if (atomic_read(&dentry->d_count) != adj) {
+		if (dentry->d_count != adj) {
 			DPRINTK(("is_tree_busy: busy leaf (d_count=%d adj=%d)\n",
-				 atomic_read(&dentry->d_count), adj));
+				 dentry->d_count, adj));
+			spin_unlock(&dentry->d_lock);
 			return 1;
 		}
+		spin_unlock(&dentry->d_lock);
 	}
 
 	/* All done at this level ... ascend and resume the search. */
@@ -137,7 +142,8 @@
 		next = this_parent->d_child.next; 
 		this_parent = this_parent->d_parent;
 		goto resume;
-	}
+	}	
+	spin_unlock(&top->d_lock);
 
 	DPRINTK(("is_tree_busy: count=%d\n", count));
 	return count != 0; /* remaining users? */
diff -urN linux-2.4.17/fs/autofs4/root.c linux-2.4.17-dcache_rcu-2/fs/autofs4/root.c
--- linux-2.4.17/fs/autofs4/root.c	Tue Oct 24 10:27:38 2000
+++ linux-2.4.17-dcache_rcu-2/fs/autofs4/root.c	Tue Feb 12 19:00:56 2002
@@ -403,7 +403,7 @@
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
-	list_del_init(&dentry->d_hash);
+	dentry_unhash(dentry);
 	spin_unlock(&dcache_lock);
 
 	dput(ino->dentry);
diff -urN linux-2.4.17/fs/coda/dir.c linux-2.4.17-dcache_rcu-2/fs/coda/dir.c
--- linux-2.4.17/fs/coda/dir.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/coda/dir.c	Tue Feb 12 16:06:02 2002
@@ -464,7 +464,7 @@
         CDEBUG(D_INODE, "old: %s, (%d length), new: %s"
 	       "(%d length). old:d_count: %d, new:d_count: %d\n", 
 	       old_name, old_length, new_name, new_length,
-	       atomic_read(&old_dentry->d_count), atomic_read(&new_dentry->d_count));
+	       old_dentry->d_count, new_dentry->d_count);
 
         error = venus_rename(old_dir->i_sb, coda_i2f(old_dir), 
 			     coda_i2f(new_dir), old_length, new_length, 
@@ -666,7 +666,7 @@
 	if (cii->c_flags & C_FLUSH) 
 		coda_flag_inode_children(inode, C_FLUSH);
 
-	if (atomic_read(&de->d_count) > 1) {
+	if (de->d_count > 1) {
 		/* pretend it's valid, but don't change the flags */
 		CDEBUG(D_DOWNCALL, "BOOM for: ino %ld, %s\n",
 		       de->d_inode->i_ino, coda_f2s(&cii->c_fid));
diff -urN linux-2.4.17/fs/coda/file.c linux-2.4.17-dcache_rcu-2/fs/coda/file.c
--- linux-2.4.17/fs/coda/file.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/coda/file.c	Tue Feb 12 16:06:02 2002
@@ -105,7 +105,7 @@
 	coda_vfs_stat.open++;
 
 	CDEBUG(D_SPECIAL, "OPEN inode number: %ld, count %d, flags %o.\n", 
-	       f->f_dentry->d_inode->i_ino, atomic_read(&f->f_dentry->d_count), flags);
+	       f->f_dentry->d_inode->i_ino, f->f_dentry->d_count, flags);
 
 	error = venus_open(i->i_sb, coda_i2f(i), coda_flags, &fh); 
 	if (error || !fh) {
diff -urN linux-2.4.17/fs/coda/pioctl.c linux-2.4.17-dcache_rcu-2/fs/coda/pioctl.c
--- linux-2.4.17/fs/coda/pioctl.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/coda/pioctl.c	Tue Feb 12 16:06:02 2002
@@ -97,7 +97,7 @@
 
         CDEBUG(D_PIOCTL, "ioctl on inode %ld\n", target_inode->i_ino);
 	CDEBUG(D_DOWNCALL, "dput on ino: %ld, icount %d, dcount %d\n", target_inode->i_ino, 
-	       atomic_read(&target_inode->i_count), atomic_read(&nd.dentry->d_count));
+	       atomic_read(&target_inode->i_count), nd.dentry->d_count);
 	path_release(&nd);
         return error;
 }
diff -urN linux-2.4.17/fs/dcache.c linux-2.4.17-dcache_rcu-2/fs/dcache.c
--- linux-2.4.17/fs/dcache.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/dcache.c	Tue Feb 12 19:03:42 2002
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 
 #include <asm/uaccess.h>
+#include <linux/rcupdate.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -55,14 +56,20 @@
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
-/* no dcache_lock, please */
+static void d_callback(void *arg)
+{
+	struct dentry * dentry = (struct dentry *)arg;
+
+	if (dname_external(dentry)) 
+		kfree((void *) dentry->d_name.name);
+	kmem_cache_free(dentry_cache, dentry); 
+}
+
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
 
@@ -119,14 +126,15 @@
 {
 	if (!dentry)
 		return;
-
 repeat:
-	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
+	spin_lock(&dcache_lock);
+	spin_lock(&dentry->d_lock);
+	if (--dentry->d_count) {
+		spin_unlock(&dentry->d_lock);
+		spin_unlock(&dcache_lock);
 		return;
+	}
 
-	/* dput on a free dentry? */
-	if (!list_empty(&dentry->d_lru))
-		BUG();
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
@@ -135,18 +143,28 @@
 			goto unhash_it;
 	}
 	/* Unreachable? Get rid of it */
-	if (list_empty(&dentry->d_hash))
+	if (d_unhashed(dentry))
 		goto kill_it;
-	list_add(&dentry->d_lru, &dentry_unused);
-	dentry_stat.nr_unused++;
+
+	if (list_empty(&dentry->d_lru)) {
+		dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
+	}
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 	return;
 
 unhash_it:
-	list_del_init(&dentry->d_hash);
+	__dentry_unhash(dentry);
 
 kill_it: {
 		struct dentry *parent;
+		spin_unlock(&dentry->d_lock);
+		if (!list_empty(&dentry->d_lru)) {
+			list_del(&dentry->d_lru);
+			dentry_stat.nr_unused--;
+		}
 		list_del(&dentry->d_child);
 		/* drops the lock, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
@@ -177,7 +195,7 @@
 	 * If it's already been dropped, return OK.
 	 */
 	spin_lock(&dcache_lock);
-	if (list_empty(&dentry->d_hash)) {
+	if ( d_unhashed(dentry)) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
@@ -201,33 +219,24 @@
 	 * we might still populate it if it was a
 	 * working directory or similar).
 	 */
-	if (atomic_read(&dentry->d_count) > 1) {
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_count > 1) {
 		if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode)) {
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
 		}
 	}
-
-	list_del_init(&dentry->d_hash);
+	__dentry_unhash(dentry);
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
-	return 0;
-}
-
-/* This should be called _only_ with dcache_lock held */
 
-static inline struct dentry * __dget_locked(struct dentry *dentry)
-{
-	atomic_inc(&dentry->d_count);
-	if (atomic_read(&dentry->d_count) == 1) {
-		dentry_stat.nr_unused--;
-		list_del_init(&dentry->d_lru);
-	}
-	return dentry;
+	return 0;
 }
 
 struct dentry * dget_locked(struct dentry *dentry)
 {
-	return __dget_locked(dentry);
+	return dget(dentry);
 }
 
 /**
@@ -252,8 +261,8 @@
 		tmp = next;
 		next = tmp->next;
 		alias = list_entry(tmp, struct dentry, d_alias);
-		if (!list_empty(&alias->d_hash)) {
-			__dget_locked(alias);
+		if (!d_unhashed(alias)) {
+			dget(alias);
 			spin_unlock(&dcache_lock);
 			return alias;
 		}
@@ -263,7 +272,7 @@
 }
 
 /*
- *	Try to kill dentries associated with this inode.
+ * Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
  */
 void d_prune_aliases(struct inode *inode)
@@ -274,13 +283,16 @@
 	tmp = head;
 	while ((tmp = tmp->next) != head) {
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
-		if (!atomic_read(&dentry->d_count)) {
-			__dget_locked(dentry);
+		spin_lock(&dentry->d_lock);
+		if (!dentry->d_count) {
+			__dget(dentry);
+			__dentry_unhash(dentry);
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
-			d_drop(dentry);
 			dput(dentry);
 			goto restart;
 		}
+		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -295,7 +307,8 @@
 {
 	struct dentry * parent;
 
-	list_del_init(&dentry->d_hash);
+	__dentry_unhash(dentry);
+	spin_unlock(&dentry->d_lock);
 	list_del(&dentry->d_child);
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
@@ -331,19 +344,18 @@
 			break;
 		list_del_init(tmp);
 		dentry = list_entry(tmp, struct dentry, d_lru);
-
+		
+		spin_lock(&dentry->d_lock);
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
-			list_add(&dentry->d_lru, &dentry_unused);
+			if (!dentry->d_count)
+				list_add(&dentry->d_lru, &dentry_unused);
+			spin_unlock(&dentry->d_lock);
 			continue;
 		}
 		dentry_stat.nr_unused--;
 
-		/* Unused dentry with a count? */
-		if (atomic_read(&dentry->d_count))
-			BUG();
-
 		prune_one_dentry(dentry);
 		if (!--count)
 			break;
@@ -405,8 +417,11 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		if (atomic_read(&dentry->d_count))
+		spin_lock(&dentry->d_lock);
+		if (dentry->d_count) {
+			spin_unlock(&dentry->d_lock);
 			continue;
+		}
 		dentry_stat.nr_unused--;
 		list_del_init(tmp);
 		prune_one_dentry(dentry);
@@ -488,11 +503,14 @@
 		struct list_head *tmp = next;
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
-		if (!atomic_read(&dentry->d_count)) {
-			list_del(&dentry->d_lru);
+
+		list_del_init(&dentry->d_lru);
+		spin_lock(&dentry->d_lock);
+		if (!dentry->d_count) {
 			list_add(&dentry->d_lru, dentry_unused.prev);
 			found++;
 		}
+		spin_unlock(&dentry->d_lock);
 		/*
 		 * Descend a level if the d_subdirs list is non-empty.
 		 */
@@ -605,9 +623,10 @@
 	memcpy(str, name->name, name->len);
 	str[name->len] = 0;
 
-	atomic_set(&dentry->d_count, 1);
-	dentry->d_vfs_flags = 0;
+	dentry->d_count = 1;
+	dentry->d_vfs_flags = DCACHE_UNLINKED;
 	dentry->d_flags = 0;
+	dentry->d_lock = SPIN_LOCK_UNLOCKED;
 	dentry->d_inode = NULL;
 	dentry->d_parent = NULL;
 	dentry->d_sb = NULL;
@@ -708,8 +727,8 @@
 	const unsigned char *str = name->name;
 	struct list_head *head = d_hash(parent,hash);
 	struct list_head *tmp;
+	struct dentry * found = NULL;
 
-	spin_lock(&dcache_lock);
 	tmp = head->next;
 	for (;;) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
@@ -729,13 +748,16 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		__dget_locked(dentry);
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
-		return dentry;
+
+		spin_lock(&dentry->d_lock);
+		if (!(dentry->d_vfs_flags & DCACHE_UNLINKED)) {
+			found = __dget(dentry);
+		}
+		spin_unlock(&dentry->d_lock);
+		
+		return found;
 	}
-	spin_unlock(&dcache_lock);
-	return NULL;
+	return found;
 }
 
 /**
@@ -774,7 +796,7 @@
 	lhp = base = d_hash(dparent, dentry->d_name.hash);
 	while ((lhp = lhp->next) != base) {
 		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-			__dget_locked(dentry);
+			dget(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
 		}
@@ -811,7 +833,7 @@
 	 * Are we the only user?
 	 */
 	spin_lock(&dcache_lock);
-	if (atomic_read(&dentry->d_count) == 1) {
+	if (dentry->d_count == 1) {
 		dentry_iput(dentry);
 		return;
 	}
@@ -834,9 +856,12 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
 	spin_lock(&dcache_lock);
+	spin_lock(&entry->d_lock);
+	if (!list_empty(&entry->d_hash) && !d_unhashed(entry)) BUG();
 	list_add(&entry->d_hash, list);
+	entry->d_vfs_flags &= ~DCACHE_UNLINKED;
+	spin_unlock(&entry->d_lock);
 	spin_unlock(&dcache_lock);
 }
 
@@ -909,7 +934,7 @@
 	list_add(&dentry->d_hash, &target->d_hash);
 
 	/* Unhash the target: dput() will then get rid of it */
-	list_del_init(&target->d_hash);
+	dentry_unhash(target);
 
 	list_del(&dentry->d_child);
 	list_del(&target->d_child);
@@ -951,7 +976,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
+	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		memcpy(end, " (deleted)", 10);
@@ -1034,7 +1059,7 @@
 	error = -ENOENT;
 	/* Has the current directory has been unlinked? */
 	spin_lock(&dcache_lock);
-	if (pwd->d_parent == pwd || !list_empty(&pwd->d_hash)) {
+	if (pwd->d_parent == pwd || !d_unhashed(pwd)) {
 		unsigned long len;
 		char * cwd;
 
@@ -1111,11 +1136,11 @@
 			this_parent = dentry;
 			goto repeat;
 		}
-		atomic_dec(&dentry->d_count);
+		dentry->d_count--;
 	}
 	if (this_parent != root) {
 		next = this_parent->d_child.next; 
-		atomic_dec(&this_parent->d_count);
+		this_parent->d_count--;
 		this_parent = this_parent->d_parent;
 		goto resume;
 	}
diff -urN linux-2.4.17/fs/hpfs/namei.c linux-2.4.17-dcache_rcu-2/fs/hpfs/namei.c
--- linux-2.4.17/fs/hpfs/namei.c	Sat Dec 30 03:37:57 2000
+++ linux-2.4.17-dcache_rcu-2/fs/hpfs/namei.c	Tue Feb 12 16:06:02 2002
@@ -333,7 +333,7 @@
 		if (rep)
 			goto ret;
 		d_drop(dentry);
-		if (atomic_read(&dentry->d_count) > 1 ||
+		if (dentry->d_count > 1 ||
 		    permission(inode, MAY_WRITE) ||
 		    get_write_access(inode)) {
 			d_rehash(dentry);
diff -urN linux-2.4.17/fs/intermezzo/journal.c linux-2.4.17-dcache_rcu-2/fs/intermezzo/journal.c
--- linux-2.4.17/fs/intermezzo/journal.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/intermezzo/journal.c	Tue Feb 12 16:06:02 2002
@@ -186,7 +186,7 @@
 
         *--end = '\0';
         buflen--;
-        if (dentry->d_parent != dentry && list_empty(&dentry->d_hash)) {
+        if (dentry->d_parent != dentry && d_unhashed(dentry)) {
                 buflen -= 10;
                 end -= 10;
                 memcpy(end, " (deleted)", 10);
diff -urN linux-2.4.17/fs/intermezzo/presto.c linux-2.4.17-dcache_rcu-2/fs/intermezzo/presto.c
--- linux-2.4.17/fs/intermezzo/presto.c	Tue Nov 13 22:50:56 2001
+++ linux-2.4.17-dcache_rcu-2/fs/intermezzo/presto.c	Tue Feb 12 16:06:02 2002
@@ -473,7 +473,7 @@
 
         // XXX this check makes no sense as d_count can change anytime.
         /* indicate if we were the only users while changing the flag */
-        if ( atomic_read(&dentry->d_count) > 1 )
+        if ( dentry->d_count > 1 )
                 error = -EBUSY;
 
 out:
diff -urN linux-2.4.17/fs/intermezzo/vfs.c linux-2.4.17-dcache_rcu-2/fs/intermezzo/vfs.c
--- linux-2.4.17/fs/intermezzo/vfs.c	Tue Nov 13 22:50:56 2001
+++ linux-2.4.17-dcache_rcu-2/fs/intermezzo/vfs.c	Tue Feb 12 16:06:02 2002
@@ -1201,10 +1201,10 @@
 static void d_unhash(struct dentry *dentry)
 {
         dget(dentry);
-        switch (atomic_read(&dentry->d_count)) {
+        switch (dentry->d_count) {
         default:
                 shrink_dcache_parent(dentry);
-                if (atomic_read(&dentry->d_count) != 2)
+                if (dentry->d_count != 2)
                         break;
         case 2:
                 d_drop(dentry);
diff -urN linux-2.4.17/fs/locks.c linux-2.4.17-dcache_rcu-2/fs/locks.c
--- linux-2.4.17/fs/locks.c	Thu Oct 11 20:22:18 2001
+++ linux-2.4.17-dcache_rcu-2/fs/locks.c	Tue Feb 12 16:06:02 2002
@@ -1236,7 +1236,7 @@
 	 * FIXME: What about F_RDLCK and files open for writing?
 	 */
 	if ((arg == F_WRLCK)
-	    && ((atomic_read(&dentry->d_count) > 1)
+	    && ((dentry->d_count > 1)
 		|| (atomic_read(&inode->i_count) > 1)))
 		return -EAGAIN;
 
diff -urN linux-2.4.17/fs/namei.c linux-2.4.17-dcache_rcu-2/fs/namei.c
--- linux-2.4.17/fs/namei.c	Thu Oct 18 03:16:29 2001
+++ linux-2.4.17-dcache_rcu-2/fs/namei.c	Tue Feb 12 16:06:02 2002
@@ -1354,10 +1354,10 @@
 static void d_unhash(struct dentry *dentry)
 {
 	dget(dentry);
-	switch (atomic_read(&dentry->d_count)) {
+	switch (dentry->d_count) {
 	default:
 		shrink_dcache_parent(dentry);
-		if (atomic_read(&dentry->d_count) != 2)
+		if (dentry->d_count != 2)
 			break;
 	case 2:
 		d_drop(dentry);
diff -urN linux-2.4.17/fs/namespace.c linux-2.4.17-dcache_rcu-2/fs/namespace.c
--- linux-2.4.17/fs/namespace.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/namespace.c	Tue Feb 12 16:06:02 2002
@@ -1002,7 +1002,7 @@
 #if 1
 	shrink_dcache();
 	printk("change_root: old root has d_count=%d\n", 
-	       atomic_read(&old_rootmnt->mnt_root->d_count));
+	       old_rootmnt->mnt_root->d_count);
 #endif
 	mount_devfs_fs ();
 	/*
diff -urN linux-2.4.17/fs/nfs/dir.c linux-2.4.17-dcache_rcu-2/fs/nfs/dir.c
--- linux-2.4.17/fs/nfs/dir.c	Tue Jun 12 23:45:08 2001
+++ linux-2.4.17-dcache_rcu-2/fs/nfs/dir.c	Tue Feb 12 16:06:02 2002
@@ -754,9 +754,9 @@
 
 	dfprintk(VFS, "NFS: silly-rename(%s/%s, ct=%d)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name, 
-		atomic_read(&dentry->d_count));
+		dentry->d_count);
 
-	if (atomic_read(&dentry->d_count) == 1)
+	if (dentry->d_count == 1)
 		goto out;  /* No need to silly rename. */
 
 
@@ -833,11 +833,11 @@
 		d_drop(dentry);
 		rehash = 1;
 	}
-	if (atomic_read(&dentry->d_count) > 1) {
+	if (dentry->d_count > 1) {
 #ifdef NFS_PARANOIA
 		printk("nfs_safe_remove: %s/%s busy, d_count=%d\n",
 			dentry->d_parent->d_name.name, dentry->d_name.name,
-			atomic_read(&dentry->d_count));
+			dentry->d_count);
 #endif
 		goto out;
 	}
@@ -1005,7 +1005,7 @@
 	dfprintk(VFS, "NFS: rename(%s/%s -> %s/%s, ct=%d)\n",
 		 old_dentry->d_parent->d_name.name, old_dentry->d_name.name,
 		 new_dentry->d_parent->d_name.name, new_dentry->d_name.name,
-		 atomic_read(&new_dentry->d_count));
+		 new_dentry->d_count);
 
 	/*
 	 * First check whether the target is busy ... we can't
@@ -1019,7 +1019,7 @@
 		goto go_ahead;
 	if (S_ISDIR(new_inode->i_mode))
 		goto out;
-	else if (atomic_read(&new_dentry->d_count) > 1) {
+	else if (new_dentry->d_count > 1) {
 		int err;
 		/* copy the target dentry's name */
 		dentry = d_alloc(new_dentry->d_parent,
@@ -1037,12 +1037,12 @@
 		}
 
 		/* dentry still busy? */
-		if (atomic_read(&new_dentry->d_count) > 1) {
+		if (new_dentry->d_count > 1) {
 #ifdef NFS_PARANOIA
 			printk("nfs_rename: target %s/%s busy, d_count=%d\n",
 			       new_dentry->d_parent->d_name.name,
 			       new_dentry->d_name.name,
-			       atomic_read(&new_dentry->d_count));
+			       new_dentry->d_count);
 #endif
 			goto out;
 		}
@@ -1052,7 +1052,7 @@
 	/*
 	 * ... prune child dentries and writebacks if needed.
 	 */
-	if (atomic_read(&old_dentry->d_count) > 1) {
+	if (old_dentry->d_count > 1) {
 		nfs_wb_all(old_inode);
 		shrink_dcache_parent(old_dentry);
 	}
diff -urN linux-2.4.17/fs/nfsd/nfsfh.c linux-2.4.17-dcache_rcu-2/fs/nfsd/nfsfh.c
--- linux-2.4.17/fs/nfsd/nfsfh.c	Thu Oct  4 11:29:22 2001
+++ linux-2.4.17-dcache_rcu-2/fs/nfsd/nfsfh.c	Tue Feb 12 16:06:02 2002
@@ -348,7 +348,7 @@
 	spin_lock(&dcache_lock);
 	list_for_each(lp, &child->d_inode->i_dentry) {
 		struct dentry *tmp = list_entry(lp,struct dentry, d_alias);
-		if (!list_empty(&tmp->d_hash) &&
+		if (!d_unhashed(tmp) &&
 		    tmp->d_parent == parent) {
 			child = dget_locked(tmp);
 			spin_unlock(&dcache_lock);
diff -urN linux-2.4.17/fs/nfsd/vfs.c linux-2.4.17-dcache_rcu-2/fs/nfsd/vfs.c
--- linux-2.4.17/fs/nfsd/vfs.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dcache_rcu-2/fs/nfsd/vfs.c	Tue Feb 12 16:06:02 2002
@@ -1280,8 +1280,8 @@
 
 #ifdef MSNFS
 	if ((ffhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
-		((atomic_read(&odentry->d_count) > 1)
-		 || (atomic_read(&ndentry->d_count) > 1))) {
+		((odentry->d_count > 1)
+		 || (ndentry->d_count > 1))) {
 			err = nfserr_perm;
 	} else
 #endif
@@ -1348,7 +1348,7 @@
 	if (type != S_IFDIR) { /* It's UNLINK */
 #ifdef MSNFS
 		if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
-			(atomic_read(&rdentry->d_count) > 1)) {
+			(rdentry->d_count > 1)) {
 			err = nfserr_perm;
 		} else
 #endif
diff -urN linux-2.4.17/fs/readdir.c linux-2.4.17-dcache_rcu-2/fs/readdir.c
--- linux-2.4.17/fs/readdir.c	Mon Aug 13 03:29:08 2001
+++ linux-2.4.17-dcache_rcu-2/fs/readdir.c	Tue Feb 12 16:06:02 2002
@@ -79,7 +79,7 @@
 			while(1) {
 				struct dentry *de = list_entry(list, struct dentry, d_child);
 
-				if (!list_empty(&de->d_hash) && de->d_inode) {
+				if (!d_unhashed(de) && de->d_inode) {
 					spin_unlock(&dcache_lock);
 					if (filldir(dirent, de->d_name.name, de->d_name.len, filp->f_pos, de->d_inode->i_ino, DT_UNKNOWN) < 0)
 						break;
diff -urN linux-2.4.17/include/linux/dcache.h linux-2.4.17-dcache_rcu-2/include/linux/dcache.h
--- linux-2.4.17/include/linux/dcache.h	Fri Nov 23 01:16:18 2001
+++ linux-2.4.17-dcache_rcu-2/include/linux/dcache.h	Tue Feb 12 18:57:52 2002
@@ -5,6 +5,8 @@
 
 #include <asm/atomic.h>
 #include <linux/mount.h>
+#include <linux/rcupdate.h>
+#include <asm/system.h>
 
 /*
  * linux/include/linux/dcache.h
@@ -64,12 +66,14 @@
 #define DNAME_INLINE_LEN 16
 
 struct dentry {
-	atomic_t d_count;
+	unsigned int d_count;
+	spinlock_t d_lock;		/* lock for d_count & d_vfs_flags */
+	unsigned long d_vfs_flags;	/* moved here to be on same cacheline */
 	unsigned int d_flags;
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
 	struct dentry * d_parent;	/* parent directory */
 	struct list_head d_hash;	/* lookup hash list */
-	struct list_head d_lru;		/* d_count = 0 LRU list */
+	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
 	struct list_head d_alias;	/* inode alias list */
@@ -78,8 +82,8 @@
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations  *d_op;
 	struct super_block * d_sb;	/* The root of the dentry tree */
-	unsigned long d_vfs_flags;
 	void * d_fsdata;		/* fs-specific data */
+	struct rcu_head d_rcu;
 	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
 };
 
@@ -123,39 +127,16 @@
 					 * s_nfsd_free_path semaphore will be down
 					 */
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
+#define DCACHE_UNLINKED		0x0010	/* Marked for deferred freeing */
 
 extern spinlock_t dcache_lock;
 
-/**
- * d_drop - drop a dentry
- * @dentry: dentry to drop
- *
- * d_drop() unhashes the entry from the parent
- * dentry hashes, so that it won't be found through
- * a VFS lookup any more. Note that this is different
- * from deleting the dentry - d_delete will try to
- * mark the dentry negative if possible, giving a
- * successful _negative_ lookup, while d_drop will
- * just make the cache lookup fail.
- *
- * d_drop() is used mainly for stuff that wants
- * to invalidate a dentry for some reason (NFS
- * timeouts or autofs deletes).
- */
-
-static __inline__ void d_drop(struct dentry * dentry)
-{
-	spin_lock(&dcache_lock);
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
-	spin_unlock(&dcache_lock);
-}
-
 static __inline__ int dname_external(struct dentry *d)
 {
 	return d->d_name.name != d->d_iname; 
 }
 
+
 /*
  * These are the low-level FS interfaces to the dcache..
  */
@@ -227,6 +208,47 @@
   
 /* Allocation counts.. */
 
+extern struct dentry * dget_locked(struct dentry *);
+
+static inline void __dentry_unhash(struct dentry *d)
+{
+	d->d_vfs_flags |= DCACHE_UNLINKED;
+	wmb();
+	list_del(&d->d_hash);
+	wmb();
+}
+
+static inline void dentry_unhash(struct dentry *d)
+{
+	spin_lock(&d->d_lock);
+	__dentry_unhash(d);
+	spin_unlock(&d->d_lock);
+}
+
+/**
+ * d_drop - drop a dentry
+ * @dentry: dentry to drop
+ *
+ * d_drop() unhashes the entry from the parent
+ * dentry hashes, so that it won't be found through
+ * a VFS lookup any more. Note that this is different
+ * from deleting the dentry - d_delete will try to
+ * mark the dentry negative if possible, giving a
+ * successful _negative_ lookup, while d_drop will
+ * just make the cache lookup fail.
+ *
+ * d_drop() is used mainly for stuff that wants
+ * to invalidate a dentry for some reason (NFS
+ * timeouts or autofs deletes).
+ */
+
+static inline void d_drop(struct dentry * dentry)
+{
+	spin_lock(&dcache_lock);
+	dentry_unhash(dentry);
+	spin_unlock(&dcache_lock);
+}
+
 /**
  *	dget, dget_locked	-	get a reference to a dentry
  *	@dentry: dentry to get a reference to
@@ -240,17 +262,25 @@
  *	and call dget_locked() instead of dget().
  */
  
-static __inline__ struct dentry * dget(struct dentry *dentry)
+static inline struct dentry * dget(struct dentry *dentry)
 {
 	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
-		atomic_inc(&dentry->d_count);
+		spin_lock(&dentry->d_lock);
+		dentry->d_count++;
+		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		spin_unlock(&dentry->d_lock);
 	}
 	return dentry;
 }
 
-extern struct dentry * dget_locked(struct dentry *);
+static __inline__ struct dentry * __dget(struct dentry *dentry)
+{
+	if (dentry) {
+		dentry->d_count++;
+		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+	}
+	return dentry;
+}
 
 /**
  *	d_unhashed -	is dentry hashed
@@ -261,7 +291,7 @@
  
 static __inline__ int d_unhashed(struct dentry *dentry)
 {
-	return list_empty(&dentry->d_hash);
+	return (dentry->d_vfs_flags & DCACHE_UNLINKED);
 }
 
 extern void dput(struct dentry *);
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
