Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWEXBY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWEXBY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWEXBY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:24:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33769 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932534AbWEXBY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:24:26 -0400
Date: Wed, 24 May 2006 11:24:12 +1000
From: David Chinner <dgc@sgi.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524012412.GB7412499@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As originally described in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114491661527656&w=2

shrink_dcache_sb() becomes a severe bottleneck when the unused dentry
list becomes long and mounts and unmounts occur frequently on the
machine.

My initial attempt to solve the problem using per-node LRUs
(http://marc.theaimsgroup.com/?l=linux-kernel&m=114537118504917&w=2)
fell apart under the complexity of locking required. This approach can
probably be made to work in the long term, but we need a robust fix 
for now....

The patch attached below is based on the suggestion made by Andrew
Morton here:

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=114499224412427&w=2

This approach does not change any of the locking required, so avoids
the locking problems of the per-node lru implementation.

I've attempted to make reclaim fair by keeping track of the last superblock
we pruned, and starting from the next on in the list each time.

Signed-off-by: Dave Chinner <dgc@sgi.com>

---
The patch has been stress tested on single and multiple filesystems,
using dbench, postmark and parallel create/unlink load tests. It has also
been running on the problem server since last Saturday which currently
has ~11 million cached dentries, and a dentry_cache slab size of ~27 million
objects.

% diffstat patches/dcache-per-sb-lru
 fs/dcache.c        |  214 +++++++++++++++++++++++++++++------------------------
 fs/super.c         |    1
 include/linux/fs.h |    1
 3 files changed, 121 insertions(+), 95 deletions(-)


Index: 2.6.x-xfs-new/fs/dcache.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/dcache.c	2006-05-15 16:24:44.212207654 +1000
+++ 2.6.x-xfs-new/fs/dcache.c	2006-05-16 14:00:46.327462206 +1000
@@ -62,7 +62,6 @@ static kmem_cache_t *dentry_cache; 
 static unsigned int d_hash_mask;
 static unsigned int d_hash_shift;
 static struct hlist_head *dentry_hashtable;
-static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
@@ -114,6 +113,38 @@ static void dentry_iput(struct dentry * 
 	}
 }
 
+static void
+dentry_lru_add(struct dentry *dentry)
+{
+	list_add(&dentry->d_lru, &dentry->d_sb->s_dentry_lru);
+	dentry_stat.nr_unused++;
+}
+
+static void
+dentry_lru_add_tail(struct dentry *dentry)
+{
+	list_add_tail(&dentry->d_lru, &dentry->d_sb->s_dentry_lru);
+	dentry_stat.nr_unused++;
+}
+
+static void
+dentry_lru_del(struct dentry *dentry)
+{
+	if (!list_empty(&dentry->d_lru)) {
+		list_del(&dentry->d_lru);
+		dentry_stat.nr_unused--;
+	}
+}
+
+static void
+dentry_lru_del_init(struct dentry *dentry)
+{
+	if (likely(!list_empty(&dentry->d_lru))) {
+		list_del_init(&dentry->d_lru);
+		dentry_stat.nr_unused--;
+	}
+}
+
 /* 
  * This is dput
  *
@@ -173,8 +204,7 @@ repeat:
 		goto kill_it;
   	if (list_empty(&dentry->d_lru)) {
   		dentry->d_flags |= DCACHE_REFERENCED;
-  		list_add(&dentry->d_lru, &dentry_unused);
-  		dentry_stat.nr_unused++;
+		dentry_lru_add(dentry);
   	}
  	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
@@ -186,13 +216,8 @@ unhash_it:
 kill_it: {
 		struct dentry *parent;
 
-		/* If dentry was on d_lru list
-		 * delete it from there
-		 */
-  		if (!list_empty(&dentry->d_lru)) {
-  			list_del(&dentry->d_lru);
-  			dentry_stat.nr_unused--;
-  		}
+		/* If dentry was on d_lru list delete it from there */
+		dentry_lru_del(dentry);
   		list_del(&dentry->d_u.d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
@@ -268,10 +293,7 @@ int d_invalidate(struct dentry * dentry)
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
-	if (!list_empty(&dentry->d_lru)) {
-		dentry_stat.nr_unused--;
-		list_del_init(&dentry->d_lru);
-	}
+	dentry_lru_del_init(dentry);
 	return dentry;
 }
 
@@ -377,6 +399,48 @@ static inline void prune_one_dentry(stru
 	spin_lock(&dcache_lock);
 }
 
+/*
+ * Shrink the dentry LRU on æ given superblock.
+ */
+static void
+__shrink_dcache_sb(struct super_block *sb, int *count, int flags)
+{
+	struct dentry *dentry;
+	int cnt = (count == NULL) ? -1 : *count;
+
+	spin_lock(&dcache_lock);
+	while (!list_empty(&sb->s_dentry_lru) && cnt--) {
+		dentry = list_entry(sb->s_dentry_lru.prev,
+					struct dentry, d_lru);
+		dentry_lru_del_init(dentry);
+		BUG_ON(dentry->d_sb != sb);
+		prefetch(sb->s_dentry_lru.prev);
+
+		spin_lock(&dentry->d_lock);
+		/*
+		 * We found an inuse dentry which was not removed from
+		 * the LRU because of laziness during lookup.  Do not free
+		 * it - just keep it off the LRU list.
+		 */
+		if (atomic_read(&dentry->d_count)) {
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
+		/* If the dentry matches the flags passed in, don't free it.
+		 * clear the flags and put it back on the LRU */
+		if (flags && (dentry->d_flags & flags)) {
+			dentry->d_flags &= ~flags;
+			dentry_lru_add(dentry);
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
+		prune_one_dentry(dentry);
+	}
+	spin_unlock(&dcache_lock);
+	if (count)
+		*count = cnt;
+}
+
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
@@ -392,42 +456,44 @@ static inline void prune_one_dentry(stru
  
 static void prune_dcache(int count)
 {
-	spin_lock(&dcache_lock);
-	for (; count ; count--) {
-		struct dentry *dentry;
-		struct list_head *tmp;
-
-		cond_resched_lock(&dcache_lock);
+	struct super_block *sb;
+	static struct super_block *sb_hand = NULL;
+	int work_done = 0;
+
+	spin_lock(&sb_lock);
+	if (sb_hand == NULL)
+		sb_hand = sb_entry(super_blocks.next);
+restart:
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (sb != sb_hand)
+			continue;
+		/* Found the next superblock to work on.
+		 * Move the hand forwards so that parallel
+		 * pruners will work on a different sb */
+		work_done++;
+		sb_hand = sb_entry(sb->s_list.next);
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		/* we don't take the s_umount lock here because
+		 * because we can be called already holding a
+		 * write lock on a superblock */
+		if (!list_empty(&sb->s_dentry_lru))
+			__shrink_dcache_sb(sb, &count, DCACHE_REFERENCED);
 
-		tmp = dentry_unused.prev;
-		if (tmp == &dentry_unused)
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb) && count)
+			goto restart;
+		if (count <= 0)
 			break;
-		list_del_init(tmp);
-		prefetch(dentry_unused.prev);
- 		dentry_stat.nr_unused--;
-		dentry = list_entry(tmp, struct dentry, d_lru);
-
- 		spin_lock(&dentry->d_lock);
-		/*
-		 * We found an inuse dentry which was not removed from
-		 * dentry_unused because of laziness during lookup.  Do not free
-		 * it - just keep it off the dentry_unused list.
-		 */
- 		if (atomic_read(&dentry->d_count)) {
- 			spin_unlock(&dentry->d_lock);
-			continue;
-		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
-			dentry->d_flags &= ~DCACHE_REFERENCED;
- 			list_add(&dentry->d_lru, &dentry_unused);
- 			dentry_stat.nr_unused++;
- 			spin_unlock(&dentry->d_lock);
-			continue;
-		}
-		prune_one_dentry(dentry);
 	}
-	spin_unlock(&dcache_lock);
+	if (!work_done) {
+		/* sb_hand is stale. Start and the beginning of the
+		 * list again. */
+		sb_hand = sb_entry(super_blocks.next);
+		goto restart;
+	}
+	spin_unlock(&sb_lock);
 }
 
 /*
@@ -454,41 +520,7 @@ static void prune_dcache(int count)
 
 void shrink_dcache_sb(struct super_block * sb)
 {
-	struct list_head *tmp, *next;
-	struct dentry *dentry;
-
-	/*
-	 * Pass one ... move the dentries for the specified
-	 * superblock to the most recent end of the unused list.
-	 */
-	spin_lock(&dcache_lock);
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
-	}
-
-	/*
-	 * Pass two ... free the dentries for this superblock.
-	 */
-repeat:
-	list_for_each_safe(tmp, next, &dentry_unused) {
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
-		dentry_stat.nr_unused--;
-		list_del_init(tmp);
-		spin_lock(&dentry->d_lock);
-		if (atomic_read(&dentry->d_count)) {
-			spin_unlock(&dentry->d_lock);
-			continue;
-		}
-		prune_one_dentry(dentry);
-		goto repeat;
-	}
-	spin_unlock(&dcache_lock);
+	__shrink_dcache_sb(sb, NULL, 0);
 }
 
 /*
@@ -572,17 +604,13 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
 		next = tmp->next;
 
-		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat.nr_unused--;
-			list_del_init(&dentry->d_lru);
-		}
+		dentry_lru_del_init(dentry);
 		/* 
 		 * move only zero ref count dentries to the end 
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add(&dentry->d_lru, dentry_unused.prev);
-			dentry_stat.nr_unused++;
+			dentry_lru_add_tail(dentry);
 			found++;
 		}
 
@@ -657,18 +685,14 @@ void shrink_dcache_anon(struct hlist_hea
 		spin_lock(&dcache_lock);
 		hlist_for_each(lp, head) {
 			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
-			if (!list_empty(&this->d_lru)) {
-				dentry_stat.nr_unused--;
-				list_del_init(&this->d_lru);
-			}
 
+			dentry_lru_del_init(this);
 			/* 
 			 * move only zero ref count dentries to the end 
 			 * of the unused list for prune_dcache
 			 */
 			if (!atomic_read(&this->d_count)) {
-				list_add_tail(&this->d_lru, &dentry_unused);
-				dentry_stat.nr_unused++;
+				dentry_lru_add_tail(this);
 				found++;
 			}
 		}
@@ -1019,7 +1043,7 @@ struct dentry *d_splice_alias(struct ino
  * rcu_read_lock() and rcu_read_unlock() are used to disable preemption while
  * lookup is going on.
  *
- * dentry_unused list is not updated even if lookup finds the required dentry
+ * The dentry unused LRU is not updated even if lookup finds the required dentry
  * in there. It is updated in places such as prune_dcache, shrink_dcache_sb,
  * select_parent and __dget_locked. This laziness saves lookup from dcache_lock
  * acquisition.
Index: 2.6.x-xfs-new/include/linux/fs.h
===================================================================
--- 2.6.x-xfs-new.orig/include/linux/fs.h	2006-03-17 13:16:16.000000000 +1100
+++ 2.6.x-xfs-new/include/linux/fs.h	2006-05-15 17:14:53.532277564 +1000
@@ -831,6 +831,7 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	struct list_head	s_dentry_lru;	/* unused dentry lru */
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
Index: 2.6.x-xfs-new/fs/super.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/super.c	2006-03-17 13:16:12.000000000 +1100
+++ 2.6.x-xfs-new/fs/super.c	2006-05-15 17:49:59.009147060 +1000
@@ -71,6 +71,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
+		INIT_LIST_HEAD(&s->s_dentry_lru);
 		init_rwsem(&s->s_umount);
 		mutex_init(&s->s_lock);
 		down_write(&s->s_umount);
