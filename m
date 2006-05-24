Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWEXLAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWEXLAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWEXLAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:00:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28606 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932679AbWEXLA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:00:29 -0400
Date: Wed, 24 May 2006 21:00:01 +1000
From: David Chinner <dgc@sgi.com>
To: Balbir Singh <balbir@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH]  Per-superblock unused dentry LRU lists V2
Message-ID: <20060524110001.GU1331387@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per superblock dentry LRU lists.

As originally described in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114491661527656&w=2

shrink_dcache_sb() becomes a severe bottleneck when the unused dentry
list becomes long and mounts and unmounts occur frequently on the
machine.

The patch attached below is based on the suggestion made by Andrew
Morton here:

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=114499224412427&w=2

I've attempted to make reclaim fair by keeping track of the last superblock
we pruned, and starting from the next one in the list each time.

Signed-off-by: Dave Chinner <dgc@sgi.com>

Version 2:

o cleaned up coding style
o added comments where required
o ported to 2.6.17-rc4-mm3
o added s_umount locking to prune_dcache()
o added counter for number of dentries on a superblock

---
Note: compile tested only, sending out for review to determine
if s_umount locking is correct w.r.t the umount/prune_dcache
race fixed in the -mm tree.

 fs/dcache.c        |  291 +++++++++++++++++++++++++----------------------------
 fs/super.c         |    1 
 include/linux/fs.h |    2 
 3 files changed, 145 insertions(+), 149 deletions(-)

Index: linux-2.6.16/fs/dcache.c
===================================================================
--- linux-2.6.16.orig/fs/dcache.c	2006-05-24 19:16:10.906422272 +1000
+++ linux-2.6.16/fs/dcache.c	2006-05-24 20:32:25.510976672 +1000
@@ -61,7 +61,6 @@ static kmem_cache_t *dentry_cache __read
 static unsigned int d_hash_mask __read_mostly;
 static unsigned int d_hash_shift __read_mostly;
 static struct hlist_head *dentry_hashtable __read_mostly;
-static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
@@ -113,6 +112,38 @@ static void dentry_iput(struct dentry * 
 	}
 }
 
+static void dentry_lru_add(struct dentry *dentry)
+{
+	list_add(&dentry->d_lru, &dentry->d_sb->s_dentry_lru);
+	dentry->d_sb->s_dentry_lru_nr++;
+	dentry_stat.nr_unused++;
+}
+
+static void dentry_lru_add_tail(struct dentry *dentry)
+{
+	list_add_tail(&dentry->d_lru, &dentry->d_sb->s_dentry_lru);
+	dentry->d_sb->s_dentry_lru_nr++;
+	dentry_stat.nr_unused++;
+}
+
+static void dentry_lru_del(struct dentry *dentry)
+{
+	if (!list_empty(&dentry->d_lru)) {
+		list_del(&dentry->d_lru);
+		dentry->d_sb->s_dentry_lru_nr--;
+		dentry_stat.nr_unused--;
+	}
+}
+
+static void dentry_lru_del_init(struct dentry *dentry)
+{
+	if (likely(!list_empty(&dentry->d_lru))) {
+		list_del_init(&dentry->d_lru);
+		dentry->d_sb->s_dentry_lru_nr--;
+		dentry_stat.nr_unused--;
+	}
+}
+
 /* 
  * This is dput
  *
@@ -172,8 +203,7 @@ repeat:
 		goto kill_it;
   	if (list_empty(&dentry->d_lru)) {
   		dentry->d_flags |= DCACHE_REFERENCED;
-  		list_add(&dentry->d_lru, &dentry_unused);
-  		dentry_stat.nr_unused++;
+		dentry_lru_add(dentry);
   	}
  	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
@@ -185,13 +215,8 @@ unhash_it:
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
@@ -267,10 +292,7 @@ int d_invalidate(struct dentry * dentry)
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
 
@@ -380,6 +402,51 @@ static void prune_one_dentry(struct dent
 	spin_lock(&dcache_lock);
 }
 
+/*
+ * Shrink the dentry LRU on æ given superblock.
+ */
+static void
+__shrink_dcache_sb(struct super_block *sb, int *count, int flags)
+{
+	struct dentry *dentry;
+	int cnt = *count;
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
+		/*
+		 * If we are honouring the DCACHE_REFERENCED flag and it is
+		 * present on this dentry, clear the flag and put it back on
+		 * the lru.
+		 */
+		if ((flags & DCACHE_REFERENCED) &&
+		    (dentry->d_flags & DCACHE_REFERENCED)) {
+			dentry->d_flags &= ~DCACHE_REFERENCED;
+			dentry_lru_add(dentry);
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
+		prune_one_dentry(dentry);
+	}
+	spin_unlock(&dcache_lock);
+	*count = cnt;
+}
+
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
@@ -395,95 +462,61 @@ static void prune_one_dentry(struct dent
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count, struct super_block *sb)
+static void prune_dcache(int count)
 {
-	spin_lock(&dcache_lock);
-	for (; count ; count--) {
-		struct dentry *dentry;
-		struct list_head *tmp;
-		struct rw_semaphore *s_umount;
-
-		cond_resched_lock(&dcache_lock);
-
-		tmp = dentry_unused.prev;
-		if (unlikely(sb)) {
-			/* Try to find a dentry for this sb, but don't try
-			 * too hard, if they aren't near the tail they will
-			 * be moved down again soon
-			 */
-			int skip = count;
-			while (skip && tmp != &dentry_unused &&
-			    list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
-				skip--;
-				tmp = tmp->prev;
-			}
-		}
-		if (tmp == &dentry_unused)
-			break;
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
 			continue;
-		}
 		/*
-		 * If the dentry is not DCACHED_REFERENCED, it is time
-		 * to remove it from the dcache, provided the super block is
-		 * NULL (which means we are trying to reclaim memory)
-		 * or this dentry belongs to the same super block that
-		 * we want to shrink.
+		 * Found the next superblock to work on.  Move the hand
+		 * forwards so that parallel pruners work on a different sb
 		 */
+		work_done++;
+		sb_hand = sb_entry(sb->s_list.next);
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
 		/*
-		 * If this dentry is for "my" filesystem, then I can prune it
-		 * without taking the s_umount lock (I already hold it).
-		 */
-		if (sb && dentry->d_sb == sb) {
-			prune_one_dentry(dentry);
-			continue;
-		}
-		/*
-		 * ...otherwise we need to be sure this filesystem isn't being
-		 * unmounted, otherwise we could race with
-		 * generic_shutdown_super(), and end up holding a reference to
-		 * an inode while the filesystem is unmounted.
-		 * So we try to get s_umount, and make sure s_root isn't NULL.
-		 * (Take a local copy of s_umount to avoid a use-after-free of
-		 * `dentry').
+		 * We need to be sure this filesystem isn't being unmounted,
+		 * otherwise we could race with generic_shutdown_super(), and
+		 * end up holding a reference to an inode while the filesystem
+		 * is unmounted.  So we try to get s_umount, and make sure
+		 * s_root isn't NULL.
 		 */
-		s_umount = &dentry->d_sb->s_umount;
-		if (down_read_trylock(s_umount)) {
-			if (dentry->d_sb->s_root != NULL) {
-				prune_one_dentry(dentry);
-				up_read(s_umount);
-				continue;
+		if (down_read_trylock(&sb->s_umount)) {
+			if ((sb->s_root != NULL) &&
+			    (!list_empty(&sb->s_dentry_lru))) {
+				__shrink_dcache_sb(sb, &count,
+						DCACHE_REFERENCED);
 			}
-			up_read(s_umount);
+			up_read(&sb->s_umount);
 		}
-		spin_unlock(&dentry->d_lock);
-		/* Cannot remove the first dentry, and it isn't appropriate
-		 * to move it to the head of the list, so give up, and try
-		 * later
+
+		/*
+		 * Restart if more work to do and this sb has been
+		 * removed from the list
 		 */
-		break;
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb) && count)
+			goto restart;
+		if (count <= 0)
+ 			break;
+ 	}
+	if (!work_done) {
+		/* sb_hand is stale. Start and the beginning of the
+		 * list again. */
+		sb_hand = sb_entry(super_blocks.next);
+		goto restart;
 	}
-	spin_unlock(&dcache_lock);
+	spin_unlock(&sb_lock);
 }
 
 /*
@@ -510,41 +543,7 @@ static void prune_dcache(int count, stru
 
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
-		list_move(tmp, &dentry_unused);
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
-		cond_resched_lock(&dcache_lock);
-		goto repeat;
-	}
-	spin_unlock(&dcache_lock);
+	__shrink_dcache_sb(sb, &sb->s_dentry_lru_nr, 0);
 }
 
 /*
@@ -628,19 +627,14 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
 		next = tmp->next;
 
-		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat.nr_unused--;
-			list_del_init(&dentry->d_lru);
-		}
+		dentry_lru_del_init(dentry);
+
 		/* 
 		 * move only zero ref count dentries to the end 
 		 * of the unused list for prune_dcache
 		 */
-		if (!atomic_read(&dentry->d_count)) {
-			list_add_tail(&dentry->d_lru, &dentry_unused);
-			dentry_stat.nr_unused++;
-			found++;
-		}
+		if (!atomic_read(&dentry->d_count))
+			dentry_lru_add_tail(dentry);
 
 		/*
 		 * We can return to the caller if we have found some (this
@@ -680,10 +674,11 @@ out:
  
 void shrink_dcache_parent(struct dentry * parent)
 {
+	struct super_block *sb = parent->d_sb;
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found, parent->d_sb);
+		__shrink_dcache_sb(sb, &found, DCACHE_REFERENCED);
 }
 
 /**
@@ -701,29 +696,27 @@ void shrink_dcache_anon(struct super_blo
 	struct hlist_node *lp;
 	struct hlist_head *head = &sb->s_anon;
 	int found;
-	do {
+	for (;;) {
 		found = 0;
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
 		spin_unlock(&dcache_lock);
-		prune_dcache(found, sb);
-	} while(found);
+		if (!found)
+			break;
+		__shrink_dcache_sb(sb, &found, DCACHE_REFERENCED);
+	}
 }
 
 /*
@@ -743,7 +736,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr, NULL);
+		prune_dcache(nr);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }
@@ -1072,7 +1065,7 @@ struct dentry *d_splice_alias(struct ino
  * rcu_read_lock() and rcu_read_unlock() are used to disable preemption while
  * lookup is going on.
  *
- * dentry_unused list is not updated even if lookup finds the required dentry
+ * The dentry unused LRU is not updated even if lookup finds the required dentry
  * in there. It is updated in places such as prune_dcache, shrink_dcache_sb,
  * select_parent and __dget_locked. This laziness saves lookup from dcache_lock
  * acquisition.
Index: linux-2.6.16/include/linux/fs.h
===================================================================
--- linux-2.6.16.orig/include/linux/fs.h	2006-05-24 19:16:12.349202936 +1000
+++ linux-2.6.16/include/linux/fs.h	2006-05-24 20:28:50.268698472 +1000
@@ -846,6 +846,8 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	struct list_head	s_dentry_lru;	/* unused dentry lru */
+	int			s_dentry_lru_nr;/* # of dentries on lru */
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
Index: linux-2.6.16/fs/super.c
===================================================================
--- linux-2.6.16.orig/fs/super.c	2006-05-24 19:16:11.267367400 +1000
+++ linux-2.6.16/fs/super.c	2006-05-24 19:58:14.433787800 +1000
@@ -71,6 +71,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
+		INIT_LIST_HEAD(&s->s_dentry_lru);
 		init_rwsem(&s->s_umount);
 		mutex_init(&s->s_lock);
 		down_write(&s->s_umount);
