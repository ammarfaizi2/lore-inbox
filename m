Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSGOIBP>; Mon, 15 Jul 2002 04:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317369AbSGOIBO>; Mon, 15 Jul 2002 04:01:14 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:16624 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317367AbSGOIBK>; Mon, 15 Jul 2002 04:01:10 -0400
Date: Mon, 15 Jul 2002 13:40:22 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Al Viro <viro@math.psu.edu>
Subject: Re: [Lse-tech] [RFC] dcache scalability patch (2.4.17)
Message-ID: <20020715134021.D13618@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20020712193935.B13618@in.ibm.com> <20020712151322.B31480@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712151322.B31480@infradead.org>; from hch@infradead.org on Fri, Jul 12, 2002 at 03:13:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 03:13:22PM +0100, Christoph Hellwig wrote:
> > diff -urN linux-2.4.17-base/fs/dcache.c linux-2.4.17-dc8/fs/dcache.c
> > --- linux-2.4.17-base/fs/dcache.c	Fri Dec 21 23:11:55 2001
> > +++ linux-2.4.17-dc8/fs/dcache.c	Fri Jul 12 16:18:39 2002
> > @@ -25,6 +25,7 @@
> >  #include <linux/module.h>
> >  
> >  #include <asm/uaccess.h>
> > +#include <linux/rcupdate.h>
> 
> Please try to include <linux/*.h> before <asm/*.h> headers.
Ok.. no problem.

> 
> > +static void d_callback(void *arg)
> > +{
> > +	struct dentry * dentry = (struct dentry *)arg;
> > +
> > +	if (dname_external(dentry)) 
> > +		kfree((void *) dentry->d_name.name);
> > +	kmem_cache_free(dentry_cache, dentry); 
> > +}
> 
> why do you cast to void * before calling kfree?
I think this got left over becasue of some intermediate trials.. I have
removed this now.

> 
> > -	/* dput on a free dentry? */
> > -	if (!list_empty(&dentry->d_lru))
> > -		BUG();
> > +	spin_lock(&dentry->d_lock);
> > +        if (atomic_read(&dentry->d_count)) {
> > +                spin_unlock(&dentry->d_lock);
> > +                spin_unlock(&dcache_lock);
> > +                return;
> > +        }
> > +
> 
> Please use tabs instead of eight spaces in kernel code.
Sure..
 
> Another implementation details is whether we shouldn't spin on a bit of
> ->d_vfs_flags instead of increasing struct dentry further.  Maybe the
> spin_lock_bit interface that wli prototypes might be a godd choise.
I have note seen this but it should not be impossible.

> Else the patch looks fine to me, although I'm wondering why you target 2.4.17

Thanks for the review. I corrected the above two problems.. new patch is as
below. As Dipankr said 2.4 version can be taken just as proof of concept and 
for disscussion.

Regards,
Maneesh


diff -urN linux-2.4.17-base/fs/autofs4/root.c linux-2.4.17-dc8/fs/autofs4/root.c
--- linux-2.4.17-base/fs/autofs4/root.c	Tue Oct 24 10:27:38 2000
+++ linux-2.4.17-dc8/fs/autofs4/root.c	Fri Jul 12 10:59:38 2002
@@ -403,7 +403,7 @@
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
-	list_del_init(&dentry->d_hash);
+	d_drop_locked(dentry);
 	spin_unlock(&dcache_lock);
 
 	dput(ino->dentry);
diff -urN linux-2.4.17-base/fs/dcache.c linux-2.4.17-dc8/fs/dcache.c
--- linux-2.4.17-base/fs/dcache.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dc8/fs/dcache.c	Mon Jul 15 13:20:29 2002
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/cache.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 
@@ -55,14 +56,21 @@
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
@@ -135,18 +147,28 @@
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
+	__d_drop(dentry);
 
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
@@ -177,7 +199,7 @@
 	 * If it's already been dropped, return OK.
 	 */
 	spin_lock(&dcache_lock);
-	if (list_empty(&dentry->d_hash)) {
+	if (d_unhashed(dentry)) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
@@ -201,15 +223,18 @@
 	 * we might still populate it if it was a
 	 * working directory or similar).
 	 */
+	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) > 1) {
 		if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode)) {
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
 		}
 	}
-
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
+
 	return 0;
 }
 
@@ -217,11 +242,14 @@
 
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
+	spin_lock(&dentry->d_lock);
 	atomic_inc(&dentry->d_count);
+	dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	if (atomic_read(&dentry->d_count) == 1) {
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
 	}
+	spin_unlock(&dentry->d_lock);
 	return dentry;
 }
 
@@ -252,8 +280,8 @@
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
@@ -263,7 +291,7 @@
 }
 
 /*
- *	Try to kill dentries associated with this inode.
+ *     Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
  */
 void d_prune_aliases(struct inode *inode)
@@ -274,13 +302,16 @@
 	tmp = head;
 	while ((tmp = tmp->next) != head) {
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
+		spin_lock(&dentry->d_lock);
 		if (!atomic_read(&dentry->d_count)) {
-			__dget_locked(dentry);
+			__dget(dentry);
+			__d_drop(dentry);
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
@@ -295,7 +326,8 @@
 {
 	struct dentry * parent;
 
-	list_del_init(&dentry->d_hash);
+	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	list_del(&dentry->d_child);
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
@@ -330,19 +362,20 @@
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
+		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
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
@@ -405,10 +438,13 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		if (atomic_read(&dentry->d_count))
-			continue;
+		spin_lock(&dentry->d_lock);
 		dentry_stat.nr_unused--;
 		list_del_init(tmp);
+		if (atomic_read(&dentry->d_count)) {
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
 		prune_one_dentry(dentry);
 		goto repeat;
 	}
@@ -488,11 +524,13 @@
 		struct list_head *tmp = next;
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
+		list_del_init(&dentry->d_lru);
+		spin_lock(&dentry->d_lock);
 		if (!atomic_read(&dentry->d_count)) {
-			list_del(&dentry->d_lru);
 			list_add(&dentry->d_lru, dentry_unused.prev);
 			found++;
 		}
+		spin_unlock(&dentry->d_lock);
 		/*
 		 * Descend a level if the d_subdirs list is non-empty.
 		 */
@@ -606,8 +644,9 @@
 	str[name->len] = 0;
 
 	atomic_set(&dentry->d_count, 1);
-	dentry->d_vfs_flags = 0;
+	dentry->d_vfs_flags = DCACHE_UNHASHED;
 	dentry->d_flags = 0;
+	dentry->d_lock = SPIN_LOCK_UNLOCKED;
 	dentry->d_inode = NULL;
 	dentry->d_parent = NULL;
 	dentry->d_sb = NULL;
@@ -709,7 +748,7 @@
 	struct list_head *head = d_hash(parent,hash);
 	struct list_head *tmp;
 
-	spin_lock(&dcache_lock);
+	/* rcu_read_lock(); for pre-emptible kernel */
 	tmp = head->next;
 	for (;;) {
 		struct dentry * dentry = list_entry(tmp, struct dentry, d_hash);
@@ -729,12 +768,15 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		__dget_locked(dentry);
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
-		spin_unlock(&dcache_lock);
+		spin_lock(&dentry->d_lock);
+		if (!(dentry->d_vfs_flags & DCACHE_UNHASHED)) {
+			dentry = __dget(dentry);
+		}
+		spin_unlock(&dentry->d_lock);
+		/* rcu_read_unlock(); for pre-emptible kernel */
 		return dentry;
 	}
-	spin_unlock(&dcache_lock);
+	/* rcu_read_unlock(); for pre-emptible kernel */
 	return NULL;
 }
 
@@ -774,7 +816,7 @@
 	lhp = base = d_hash(dparent, dentry->d_name.hash);
 	while ((lhp = lhp->next) != base) {
 		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-			__dget_locked(dentry);
+			dget(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
 		}
@@ -834,9 +876,12 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
 	spin_lock(&dcache_lock);
+	spin_lock(&entry->d_lock);
+	if (!list_empty(&entry->d_hash) && !d_unhashed(entry)) BUG();
 	list_add(&entry->d_hash, list);
+	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
+	spin_unlock(&entry->d_lock);
 	spin_unlock(&dcache_lock);
 }
 
@@ -909,7 +954,7 @@
 	list_add(&dentry->d_hash, &target->d_hash);
 
 	/* Unhash the target: dput() will then get rid of it */
-	list_del_init(&target->d_hash);
+	d_drop_locked(target);
 
 	list_del(&dentry->d_child);
 	list_del(&target->d_child);
@@ -951,7 +996,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
+	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		memcpy(end, " (deleted)", 10);
@@ -1034,7 +1079,7 @@
 	error = -ENOENT;
 	/* Has the current directory has been unlinked? */
 	spin_lock(&dcache_lock);
-	if (pwd->d_parent == pwd || !list_empty(&pwd->d_hash)) {
+	if (pwd->d_parent == pwd || !d_unhashed(pwd)) {
 		unsigned long len;
 		char * cwd;
 
diff -urN linux-2.4.17-base/fs/intermezzo/journal.c linux-2.4.17-dc8/fs/intermezzo/journal.c
--- linux-2.4.17-base/fs/intermezzo/journal.c	Fri Dec 21 23:11:55 2001
+++ linux-2.4.17-dc8/fs/intermezzo/journal.c	Mon Jul  8 16:18:43 2002
@@ -186,7 +186,7 @@
 
         *--end = '\0';
         buflen--;
-        if (dentry->d_parent != dentry && list_empty(&dentry->d_hash)) {
+        if (dentry->d_parent != dentry && d_unhashed(dentry)) {
                 buflen -= 10;
                 end -= 10;
                 memcpy(end, " (deleted)", 10);
diff -urN linux-2.4.17-base/fs/nfsd/nfsfh.c linux-2.4.17-dc8/fs/nfsd/nfsfh.c
--- linux-2.4.17-base/fs/nfsd/nfsfh.c	Thu Oct  4 11:29:22 2001
+++ linux-2.4.17-dc8/fs/nfsd/nfsfh.c	Mon Jul  8 16:18:43 2002
@@ -348,7 +348,7 @@
 	spin_lock(&dcache_lock);
 	list_for_each(lp, &child->d_inode->i_dentry) {
 		struct dentry *tmp = list_entry(lp,struct dentry, d_alias);
-		if (!list_empty(&tmp->d_hash) &&
+		if (!d_unhashed(tmp) &&
 		    tmp->d_parent == parent) {
 			child = dget_locked(tmp);
 			spin_unlock(&dcache_lock);
diff -urN linux-2.4.17-base/fs/readdir.c linux-2.4.17-dc8/fs/readdir.c
--- linux-2.4.17-base/fs/readdir.c	Mon Aug 13 03:29:08 2001
+++ linux-2.4.17-dc8/fs/readdir.c	Mon Jul  8 16:18:43 2002
@@ -79,7 +79,7 @@
 			while(1) {
 				struct dentry *de = list_entry(list, struct dentry, d_child);
 
-				if (!list_empty(&de->d_hash) && de->d_inode) {
+  				if (!d_unhashed(de) && de->d_inode) {
 					spin_unlock(&dcache_lock);
 					if (filldir(dirent, de->d_name.name, de->d_name.len, filp->f_pos, de->d_inode->i_ino, DT_UNKNOWN) < 0)
 						break;
diff -urN linux-2.4.17-base/include/linux/dcache.h linux-2.4.17-dc8/include/linux/dcache.h
--- linux-2.4.17-base/include/linux/dcache.h	Fri Nov 23 01:16:18 2001
+++ linux-2.4.17-dc8/include/linux/dcache.h	Fri Jul 12 10:59:09 2002
@@ -5,6 +5,8 @@
 
 #include <asm/atomic.h>
 #include <linux/mount.h>
+#include <linux/rcupdate.h>
+#include <asm/system.h>
 
 /*
  * linux/include/linux/dcache.h
@@ -65,11 +67,13 @@
 
 struct dentry {
 	atomic_t d_count;
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
 
@@ -123,10 +127,23 @@
 					 * s_nfsd_free_path semaphore will be down
 					 */
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
+#define DCACHE_UNHASHED		0x0010	
 
 extern spinlock_t dcache_lock;
 
 /**
+ *	d_unhashed -	is dentry hashed
+ *	@dentry: entry to check
+ *
+ *	Returns true if the dentry passed is not currently hashed.
+ */
+ 
+static __inline__ int d_unhashed(struct dentry *dentry)
+{
+	return (dentry->d_vfs_flags & DCACHE_UNHASHED);
+}
+
+/**
  * d_drop - drop a dentry
  * @dentry: dentry to drop
  *
@@ -143,14 +160,32 @@
  * timeouts or autofs deletes).
  */
 
+static __inline__ void __d_drop(struct dentry * dentry)
+{
+	if (!d_unhashed(dentry)) {
+		dentry->d_vfs_flags |= DCACHE_UNHASHED;
+		wmb();
+		list_del(&dentry->d_hash);
+		wmb();
+	}
+}
+
 static __inline__ void d_drop(struct dentry * dentry)
 {
 	spin_lock(&dcache_lock);
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
+	spin_lock(&dentry->d_lock);
+	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 }
 
+static __inline__ void d_drop_locked(struct dentry * dentry)
+{
+	spin_lock(&dentry->d_lock);
+	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
+}
+
 static __inline__ int dname_external(struct dentry *d)
 {
 	return d->d_name.name != d->d_iname; 
@@ -243,27 +278,25 @@
 static __inline__ struct dentry * dget(struct dentry *dentry)
 {
 	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
+		spin_lock(&dentry->d_lock);
 		atomic_inc(&dentry->d_count);
+		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		spin_unlock(&dentry->d_lock);
 	}
 	return dentry;
 }
 
-extern struct dentry * dget_locked(struct dentry *);
-
-/**
- *	d_unhashed -	is dentry hashed
- *	@dentry: entry to check
- *
- *	Returns true if the dentry passed is not currently hashed.
- */
- 
-static __inline__ int d_unhashed(struct dentry *dentry)
+static __inline__ struct dentry * __dget(struct dentry *dentry)
 {
-	return list_empty(&dentry->d_hash);
+	if (dentry) {
+		atomic_inc(&dentry->d_count);
+		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+	}
+	return dentry;
 }
 
+extern struct dentry * dget_locked(struct dentry *);
+
 extern void dput(struct dentry *);
 
 static __inline__ int d_mountpoint(struct dentry *dentry)
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
