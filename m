Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUEHKMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUEHKMi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUEHKMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:12:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:59093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbUEHKMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:12:31 -0400
Date: Sat, 8 May 2004 03:11:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: manfred@colorfullife.com, davej@redhat.com, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508031159.782d6a46.akpm@osdl.org>
In-Reply-To: <20040508022304.17779635.akpm@osdl.org>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Here be another patch.


Can't help myself!


- d_vfs_flags can be removed - just use d_flags.  It looks like someone
  added d_vfs_flags with the intent of doing bitops on it, but all
  modifications are under dcache_lock.  4 bytes saved.

- make d_flags a ushort.

- Assume that nobody wants filenames longer than 64k and make qstr.len
  unsigned short too.

- Pack things so that dentry.d_name.len and dentry.d_flags occupy the same
  word.  4 bytes saved.

- NFS and AFS are modifying d_flags without dcache_lock.


On x86 this takes the internal string size up to 44 bytes.  The
internal/external ratio on my 1.5M files hits 96%.



---

 25-akpm/fs/dcache.c            |   17 ++++++++---------
 25-akpm/include/linux/dcache.h |   33 +++++++++++++++++----------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff -puN include/linux/dcache.h~dentry-more-shrinkage include/linux/dcache.h
--- 25/include/linux/dcache.h~dentry-more-shrinkage	2004-05-08 02:46:53.134693712 -0700
+++ 25-akpm/include/linux/dcache.h	2004-05-08 02:56:16.687020736 -0700
@@ -30,9 +30,9 @@ struct vfsmount;
  */
 struct qstr {
 	const unsigned char *name;
-	unsigned int len;
 	unsigned int hash;
-};
+	unsigned short len;
+} __attribute__((packed));
 
 struct dentry_stat_t {
 	int nr_dentry;
@@ -77,28 +77,29 @@ struct dcookie_struct;
  
 struct dentry {
 	atomic_t d_count;
-	unsigned long d_vfs_flags;	/* moved here to be on same cacheline */
 	spinlock_t d_lock;		/* per dentry lock */
-	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
+	struct inode *d_inode;		/* Where the name belongs to - NULL is
+					 * negative */
 	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
 	struct list_head d_alias;	/* inode alias list */
 	unsigned long d_time;		/* used by d_revalidate */
-	struct dentry_operations  *d_op;
-	struct super_block * d_sb;	/* The root of the dentry tree */
-	unsigned int d_flags;
+	struct dentry_operations *d_op;
+	struct super_block *d_sb;	/* The root of the dentry tree */
 	int d_mounted;
-	void * d_fsdata;		/* fs-specific data */
+	void *d_fsdata;			/* fs-specific data */
  	struct rcu_head d_rcu;
-	struct dcookie_struct * d_cookie; /* cookie, if any */
-	unsigned long d_move_count;	/* to indicated moved dentry while lockless lookup */
-	struct dentry * d_parent;	/* parent directory */
+	struct dcookie_struct *d_cookie; /* cookie, if any */
+	unsigned long d_move_count;	/* to indicated moved dentry while
+					 * lockless lookup */
+	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
+	unsigned short d_flags;
 	struct hlist_node d_hash;	/* lookup hash list */	
-	struct hlist_head * d_bucket;	/* lookup hash bucket */
+	struct hlist_head *d_bucket;	/* lookup hash bucket */
 	unsigned char d_iname[0];	/* small names */
-};
+} __attribute__((packed));
 
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, struct nameidata *);
@@ -169,8 +170,8 @@ extern spinlock_t dcache_lock;
 
 static inline void __d_drop(struct dentry *dentry)
 {
-	if (!(dentry->d_vfs_flags & DCACHE_UNHASHED)) {
-		dentry->d_vfs_flags |= DCACHE_UNHASHED;
+	if (!(dentry->d_flags & DCACHE_UNHASHED)) {
+		dentry->d_flags |= DCACHE_UNHASHED;
 		hlist_del_rcu(&dentry->d_hash);
 	}
 }
@@ -281,7 +282,7 @@ extern struct dentry * dget_locked(struc
  
 static inline int d_unhashed(struct dentry *dentry)
 {
-	return (dentry->d_vfs_flags & DCACHE_UNHASHED);
+	return (dentry->d_flags & DCACHE_UNHASHED);
 }
 
 static inline struct dentry *dget_parent(struct dentry *dentry)
diff -puN fs/dcache.c~dentry-more-shrinkage fs/dcache.c
--- 25/fs/dcache.c~dentry-more-shrinkage	2004-05-08 02:55:55.284274448 -0700
+++ 25-akpm/fs/dcache.c	2004-05-08 02:57:10.581827480 -0700
@@ -168,7 +168,7 @@ repeat:
  	if (d_unhashed(dentry))
 		goto kill_it;
   	if (list_empty(&dentry->d_lru)) {
-  		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+  		dentry->d_flags |= DCACHE_REFERENCED;
   		list_add(&dentry->d_lru, &dentry_unused);
   		dentry_stat.nr_unused++;
   	}
@@ -401,8 +401,8 @@ static void prune_dcache(int count)
 			continue;
 		}
 		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
-			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+		if (dentry->d_flags & DCACHE_REFERENCED) {
+			dentry->d_flags &= ~DCACHE_REFERENCED;
  			list_add(&dentry->d_lru, &dentry_unused);
  			dentry_stat.nr_unused++;
  			spin_unlock(&dentry->d_lock);
@@ -707,9 +707,8 @@ struct dentry *d_alloc(struct dentry * p
 	dname[name->len] = 0;
 
 	atomic_set(&dentry->d_count, 1);
-	dentry->d_vfs_flags = DCACHE_UNHASHED;
+	dentry->d_flags = DCACHE_UNHASHED;
 	dentry->d_lock = SPIN_LOCK_UNLOCKED;
-	dentry->d_flags = 0;
 	dentry->d_inode = NULL;
 	dentry->d_parent = NULL;
 	dentry->d_move_count = 0;
@@ -855,7 +854,7 @@ struct dentry * d_alloc_anon(struct inod
 			res->d_inode = inode;
 			res->d_bucket = d_hash(res, res->d_name.hash);
 			res->d_flags |= DCACHE_DISCONNECTED;
-			res->d_vfs_flags &= ~DCACHE_UNHASHED;
+			res->d_flags &= ~DCACHE_UNHASHED;
 			list_add(&res->d_alias, &inode->i_dentry);
 			hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
 			spin_unlock(&res->d_lock);
@@ -1117,7 +1116,7 @@ void d_rehash(struct dentry * entry)
 {
 	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
 	spin_lock(&dcache_lock);
- 	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
+ 	entry->d_flags &= ~DCACHE_UNHASHED;
 	entry->d_bucket = list;
  	hlist_add_head_rcu(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
@@ -1214,14 +1213,14 @@ void d_move(struct dentry * dentry, stru
 	}
 
 	/* Move the dentry to the target hash queue, if on different bucket */
-	if (dentry->d_vfs_flags & DCACHE_UNHASHED)
+	if (dentry->d_flags & DCACHE_UNHASHED)
 		goto already_unhashed;
 	if (dentry->d_bucket != target->d_bucket) {
 		hlist_del_rcu(&dentry->d_hash);
 already_unhashed:
 		dentry->d_bucket = target->d_bucket;
 		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
-		dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
+		dentry->d_flags &= ~DCACHE_UNHASHED;
 	}
 
 	/* Unhash the target: dput() will then get rid of it */

_

