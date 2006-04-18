Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWDROiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWDROiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWDROiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:38:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65153 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932154AbWDROiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:38:08 -0400
Date: Wed, 19 Apr 2006 00:37:53 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC][PATCH] Re: shrink_dcache_sb scalability problem.
Message-ID: <20060418143753.GJ2732@melbourne.sgi.com>
References: <20060413082210.GM1484909@melbourne.sgi.com> <20060413015257.5b9d0972.akpm@osdl.org> <20060414034332.GN1484909@melbourne.sgi.com> <20060413222325.77f9ec9b.akpm@osdl.org> <20060418002928.GB7574742@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418002928.GB7574742@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 10:29:28AM +1000, David Chinner wrote:
> 
> The other thing that I thought of over the weekend is per-node LRU
> lists and a lock per node This will reduce the length of the lists,
> allow some parallelism even while we scan and purge each list
> using the existing algorithm, and not completely destroy the LRU-ness
> of the dcache.

Here's a patch that does that. It's rough, but it boots and i've run
some basic tests against it.  It doesn't survive dbench with 200
processes, though, as it crashes in prune_one_dentry() with a
corrupted d_child.

The logic in prune_dcache() is pretty grotesque atm, and I
doubt it's correct. Comments on how to fix it are welcome ;)

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group

Make the dentry unused lists per-node.

Signed-off-by: Dave Chinner <dgc@sgi.com>

Index: 2.6.x-xfs-new/fs/dcache.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/dcache.c	2006-04-18 10:35:10.000000000 +1000
+++ 2.6.x-xfs-new/fs/dcache.c	2006-04-18 22:23:04.603552947 +1000
@@ -62,7 +62,6 @@ static kmem_cache_t *dentry_cache; 
 static unsigned int d_hash_mask;
 static unsigned int d_hash_shift;
 static struct hlist_head *dentry_hashtable;
-static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
@@ -114,6 +113,72 @@ static void dentry_iput(struct dentry * 
 	}
 }
 
+static void
+dentry_unused_add(struct dentry *dentry)
+{
+	pg_data_t *pgdat = page_zone(virt_to_page(dentry))->zone_pgdat;
+
+	spin_lock(&pgdat->dentry_unused_lock);
+	list_add(&dentry->d_lru, &pgdat->dentry_unused);
+	spin_unlock(&pgdat->dentry_unused_lock);
+	dentry_stat.nr_unused++;
+}
+
+static void
+dentry_unused_add_tail(struct dentry *dentry)
+{
+	pg_data_t *pgdat = page_zone(virt_to_page(dentry))->zone_pgdat;
+
+	spin_lock(&pgdat->dentry_unused_lock);
+	list_add_tail(&dentry->d_lru, &pgdat->dentry_unused);
+	spin_unlock(&pgdat->dentry_unused_lock);
+	dentry_stat.nr_unused++;
+}
+
+/*
+ * Assumes external locks are already held
+ */
+static void
+dentry_unused_move(struct dentry *dentry, struct list_head *head)
+{
+	list_del(&dentry->d_lru);
+	list_add(&dentry->d_lru, head);
+}
+
+static void
+dentry_unused_del(struct dentry *dentry)
+{
+	if (!list_empty(&dentry->d_lru)) {
+		pg_data_t *pgdat = page_zone(virt_to_page(dentry))->zone_pgdat;
+
+		spin_lock(&pgdat->dentry_unused_lock);
+		list_del(&dentry->d_lru);
+		spin_unlock(&pgdat->dentry_unused_lock);
+		dentry_stat.nr_unused--;
+	}
+}
+
+static inline void
+__dentry_unused_del_init(struct dentry *dentry)
+{
+	if (likely(!list_empty(&dentry->d_lru)))
+		list_del_init(&dentry->d_lru);
+
+}
+
+static void
+dentry_unused_del_init(struct dentry *dentry)
+{
+	if (!list_empty(&dentry->d_lru)) {
+		pg_data_t *pgdat = page_zone(virt_to_page(dentry))->zone_pgdat;
+
+		spin_lock(&pgdat->dentry_unused_lock);
+		__dentry_unused_del_init(dentry);
+		spin_unlock(&pgdat->dentry_unused_lock);
+		dentry_stat.nr_unused--;
+	}
+}
+
 /* 
  * This is dput
  *
@@ -173,8 +238,7 @@ repeat:
 		goto kill_it;
   	if (list_empty(&dentry->d_lru)) {
   		dentry->d_flags |= DCACHE_REFERENCED;
-  		list_add(&dentry->d_lru, &dentry_unused);
-  		dentry_stat.nr_unused++;
+		dentry_unused_add(dentry);
   	}
  	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
@@ -186,13 +250,8 @@ unhash_it:
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
+		dentry_unused_del(dentry);
   		list_del(&dentry->d_u.d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
@@ -268,10 +327,7 @@ int d_invalidate(struct dentry * dentry)
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
-	if (!list_empty(&dentry->d_lru)) {
-		dentry_stat.nr_unused--;
-		list_del_init(&dentry->d_lru);
-	}
+	dentry_unused_del_init(dentry);
 	return dentry;
 }
 
@@ -392,42 +448,73 @@ static inline void prune_one_dentry(stru
  
 static void prune_dcache(int count)
 {
-	spin_lock(&dcache_lock);
-	for (; count ; count--) {
-		struct dentry *dentry;
-		struct list_head *tmp;
-
-		cond_resched_lock(&dcache_lock);
-
-		tmp = dentry_unused.prev;
-		if (tmp == &dentry_unused)
-			break;
-		list_del_init(tmp);
-		prefetch(dentry_unused.prev);
- 		dentry_stat.nr_unused--;
-		dentry = list_entry(tmp, struct dentry, d_lru);
+	int node_id = numa_node_id();
+	int	scan_low = 0;
+	int	c = count;
+	pg_data_t *pgdat;
+
+rescan:
+	for_each_pgdat(pgdat) {
+		if (!scan_low) {
+			if (pgdat->node_id < node_id)
+				continue;
+		} else {
+			if (pgdat->node_id >= node_id)
+				break;
+		}
+		for (c = count; c ; c--) {
+			struct dentry *dentry;
+			struct list_head *tmp;
+			spin_lock(&pgdat->dentry_unused_lock);
+
+			tmp = pgdat->dentry_unused.prev;
+			if (tmp == &pgdat->dentry_unused) {
+				spin_unlock(&pgdat->dentry_unused_lock);
+				break;
+			}
+			dentry = list_entry(tmp, struct dentry, d_lru);
+			__dentry_unused_del_init(dentry);
+			prefetch(&pgdat->dentry_unused.prev);
+			spin_unlock(&pgdat->dentry_unused_lock);
 
- 		spin_lock(&dentry->d_lock);
+			spin_lock(&dcache_lock);
+			spin_lock(&dentry->d_lock);
+			/*
+			 * We found an inuse dentry which was not removed from
+			 * dentry_unused because of laziness during lookup or
+			 * a dentry that has just been put back on the unused
+			 * list.  Do not free it - just leave it where it is.
+			 */
+			if (atomic_read(&dentry->d_count) ||
+			    !list_empty(&dentry->d_lru)) {
+				spin_unlock(&dentry->d_lock);
+				spin_unlock(&dcache_lock);
+				continue;
+			}
+			/* If the dentry was recently referenced, don't free it. */
+			if (dentry->d_flags & DCACHE_REFERENCED) {
+				dentry->d_flags &= ~DCACHE_REFERENCED;
+				dentry_unused_add(dentry);
+				spin_unlock(&dentry->d_lock);
+				spin_unlock(&dcache_lock);
+				continue;
+			}
+			prune_one_dentry(dentry);
+			spin_unlock(&dcache_lock);
+		}
 		/*
-		 * We found an inuse dentry which was not removed from
-		 * dentry_unused because of laziness during lookup.  Do not free
-		 * it - just keep it off the dentry_unused list.
+		 * shrink_parent needs to scan each list, and if it only
+		 * calls in with one count then we may never find it. So
+		 * if count ==1, scan each list once.
 		 */
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
+		if (count == 1)
+			c = 1;
+		if (!c)
+			break;
 	}
-	spin_unlock(&dcache_lock);
+	if (c && scan_low++ == 0)
+		goto rescan;
+
 }
 
 /*
@@ -456,39 +543,66 @@ void shrink_dcache_sb(struct super_block
 {
 	struct list_head *tmp, *next;
 	struct dentry *dentry;
+	pg_data_t *pgdat;
+	int found;
 
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
+	for_each_pgdat(pgdat) {
+		found = 0;
+		spin_lock(&pgdat->dentry_unused_lock);
+		/*
+		 * Pass one ... move the dentries for the specified
+		 * superblock to the most recent end of the unused list.
+		 */
+		list_for_each_safe(tmp, next, &pgdat->dentry_unused) {
+			dentry = list_entry(tmp, struct dentry, d_lru);
+			if (dentry->d_sb != sb)
+				continue;
+			dentry_unused_move(dentry, &pgdat->dentry_unused);
+			found++;
+		}
+		spin_unlock(&pgdat->dentry_unused_lock);
 
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
+		/*
+		 * Pass two ... free the dentries for this superblock.
+		 * use the output of the first pass to determine if we need
+		 * to run this pass.
+		 */
+		if (!found)
 			continue;
+repeat:
+		spin_lock(&pgdat->dentry_unused_lock);
+		list_for_each_safe(tmp, next, &pgdat->dentry_unused) {
+			dentry = list_entry(tmp, struct dentry, d_lru);
+			if (dentry->d_sb != sb)
+				continue;
+			__dentry_unused_del_init(dentry);
+
+			/*
+			 * We snoop on the d_count here so we can skip
+			 * dentries we can obviously not free right now
+			 * without dropping the list lock. This prevents us
+			 * from getting stuck on an in-use dentry on the unused
+			 * list.
+			 */
+			if (atomic_read(&dentry->d_count))
+				continue;
+
+			spin_unlock(&pgdat->dentry_unused_lock);
+			spin_lock(&dcache_lock);
+			spin_lock(&dentry->d_lock);
+			if (atomic_read(&dentry->d_count) ||
+			    (dentry->d_sb != sb) ||
+			    !list_empty(&dentry->d_lru)) {
+				spin_unlock(&dentry->d_lock);
+				spin_unlock(&dcache_lock);
+				goto repeat;
+			}
+			prune_one_dentry(dentry);
+			spin_unlock(&dcache_lock);
+			goto repeat;
 		}
-		prune_one_dentry(dentry);
-		goto repeat;
+		spin_unlock(&pgdat->dentry_unused_lock);
 	}
-	spin_unlock(&dcache_lock);
 }
 
 /*
@@ -572,17 +686,13 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
 		next = tmp->next;
 
-		if (!list_empty(&dentry->d_lru)) {
-			dentry_stat.nr_unused--;
-			list_del_init(&dentry->d_lru);
-		}
+		dentry_unused_del_init(dentry);
 		/* 
 		 * move only zero ref count dentries to the end 
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add(&dentry->d_lru, dentry_unused.prev);
-			dentry_stat.nr_unused++;
+			dentry_unused_add_tail(dentry);
 			found++;
 		}
 
@@ -657,18 +767,14 @@ void shrink_dcache_anon(struct hlist_hea
 		spin_lock(&dcache_lock);
 		hlist_for_each(lp, head) {
 			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
-			if (!list_empty(&this->d_lru)) {
-				dentry_stat.nr_unused--;
-				list_del_init(&this->d_lru);
-			}
 
+			dentry_unused_del_init(this);
 			/* 
 			 * move only zero ref count dentries to the end 
 			 * of the unused list for prune_dcache
 			 */
 			if (!atomic_read(&this->d_count)) {
-				list_add_tail(&this->d_lru, &dentry_unused);
-				dentry_stat.nr_unused++;
+				dentry_unused_add_tail(this);
 				found++;
 			}
 		}
@@ -1673,6 +1779,12 @@ static void __init dcache_init_early(voi
 static void __init dcache_init(unsigned long mempages)
 {
 	int loop;
+	pg_data_t *pgdat;
+
+	for_each_pgdat(pgdat) {
+		spin_lock_init(&pgdat->dentry_unused_lock);
+		INIT_LIST_HEAD(&pgdat->dentry_unused);
+	}
 
 	/* 
 	 * A constructor could be added for stable state like the lists,
Index: 2.6.x-xfs-new/include/linux/mmzone.h
===================================================================
--- 2.6.x-xfs-new.orig/include/linux/mmzone.h	2006-02-06 11:57:55.000000000 +1100
+++ 2.6.x-xfs-new/include/linux/mmzone.h	2006-04-18 18:04:22.378952121 +1000
@@ -311,6 +311,8 @@ typedef struct pglist_data {
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
+	spinlock_t dentry_unused_lock;
+	struct list_head dentry_unused;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
