Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSJOPZs>; Tue, 15 Oct 2002 11:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSJOPZs>; Tue, 15 Oct 2002 11:25:48 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:43781 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264630AbSJOPZi>; Tue, 15 Oct 2002 11:25:38 -0400
Date: Tue, 15 Oct 2002 16:31:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015163121.B27906@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015131507.GC31235@think.thunk.org>; from tytso@mit.edu on Tue, Oct 15, 2002 at 09:15:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 09:15:07AM -0400, Theodore Ts'o wrote:
> Actually, I did, for those comments that made sense.  The fs/Config.in
> logic has been cleaned up, as well as removing excess header files,
> stray LINUX_VERSION_CODE #ifdef's that I had missed the first time
> around, etc.
> 
> fs/mbcache.c is still there because it applies to both ext2 and ext3
> filesystems, and so your suggestion of moving it into the ext2 and
> ext3 directories would cause code duplication and maintenance
> headaches.  It also *can* be used by other filesystems, as it is
> written in a generic way.  The fs/Config.in only compiles it in if
> necessary (i.e., if ext2/3 extended attribute is enabled) so it won't
> cause code bloat for other filesystems if it is not needed.
> 
> The superblock fields are more of an issue with the posix acl changes
> than for the extended attribute patches.  I had wanted to get the
> extended attribute changes in first, since they stand alone, and so I
> have fewer patches to juggle.

Patch 2: mbcache (all against 2.5.42-mm3):

o remove LINUX_VERSION_CODE mess
o cleanup mb_cache_lock/mb_cache_unlock mess
o use list_move
o use list_del_init/list_empty instead of messing with .prev directly
o remove useless MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT


--- linux-2.5.42-mm3-plain/fs/mbcache.c	Tue Oct 15 17:05:09 2002
+++ linux-2.5.42-mm3/fs/mbcache.c	Tue Oct 15 17:26:53 2002
@@ -27,12 +27,10 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/mbcache.h>
 
@@ -56,9 +54,7 @@
 		
 MODULE_AUTHOR("Andreas Gruenbacher <a.gruenbacher@computer.org>");
 MODULE_DESCRIPTION("Meta block cache (for extended attributes)");
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 MODULE_LICENSE("GPL");
-#endif
 
 EXPORT_SYMBOL(mb_cache_create);
 EXPORT_SYMBOL(mb_cache_shrink);
@@ -87,18 +83,6 @@
 static spinlock_t mb_cache_spinlock = SPIN_LOCK_UNLOCKED;
 static struct shrinker *mb_shrinker;
 
-static inline void
-mb_cache_lock(void)
-{
-	spin_lock(&mb_cache_spinlock);
-}
-
-static inline void
-mb_cache_unlock(void)
-{
-	spin_unlock(&mb_cache_spinlock);
-}
-
 static inline int
 mb_cache_indexes(struct mb_cache *cache)
 {
@@ -118,10 +102,8 @@
 static inline void
 __mb_cache_entry_takeout_lru(struct mb_cache_entry *ce)
 {
-	if (ce->e_lru_list.prev) {
-		list_del(&ce->e_lru_list);
-		ce->e_lru_list.prev = NULL;
-	}
+	if (!list_empty(&ce->e_lru_list))
+		list_del_init(&ce->e_lru_list);
 }
 
 
@@ -135,7 +117,7 @@
 static inline int
 __mb_cache_entry_in_lru(struct mb_cache_entry *ce)
 {
-	return (ce->e_lru_list.prev != NULL);
+	return (!list_empty(&ce->e_lru_list));
 }
 
 
@@ -167,9 +149,8 @@
 {
 	int n;
 
-	list_del(&ce->e_block_list);
-	ce->e_block_list.prev = NULL;
-	for (n=0; n<mb_cache_indexes(ce->e_cache); n++)
+	list_del_init(&ce->e_block_list);
+	for (n = 0; n < mb_cache_indexes(ce->e_cache); n++)
 		list_del(&ce->e_indexes[n].o_list);
 }
 
@@ -177,7 +158,7 @@
 static inline int
 __mb_cache_entry_is_linked(struct mb_cache_entry *ce)
 {
-	return (ce->e_block_list.prev != NULL);
+	return (!list_empty(&ce->e_block_list));
 }
 
 
@@ -207,15 +188,15 @@
 __mb_cache_entry_release_unlock(struct mb_cache_entry *ce)
 {
 	if (atomic_dec_and_test(&ce->e_used)) {
-		if (__mb_cache_entry_is_linked(ce))
-			__mb_cache_entry_into_lru(ce);
-		else {
-			mb_cache_unlock();
-			__mb_cache_entry_forget(ce);
-			return;
-		}
+		if (!__mb_cache_entry_is_linked(ce))
+			goto forget;
 	}
-	mb_cache_unlock();
+
+	spin_unlock(&mb_cache_spinlock);
+	return;
+ forget:
+	spin_unlock(&mb_cache_spinlock);
+	__mb_cache_entry_forget(ce);
 }
 
 
@@ -237,7 +218,7 @@
 	struct list_head *l;
 	int count = 0;
 
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	list_for_each_prev(l, &mb_cache_list) {
 		struct mb_cache *cache =
 			list_entry(l, struct mb_cache, c_cache_list);
@@ -247,20 +228,20 @@
 	}
 	mb_debug("trying to free %d entries", nr_to_scan);
 	if (nr_to_scan == 0) {
-		mb_cache_unlock();
+		spin_unlock(&mb_cache_spinlock);
 		goto out;
 	}
 	while (nr_to_scan && !list_empty(&mb_cache_lru_list)) {
 		struct mb_cache_entry *ce =
 			list_entry(mb_cache_lru_list.prev,
 				   struct mb_cache_entry, e_lru_list);
-		list_del(&ce->e_lru_list);
-		list_add(&ce->e_lru_list, &free_list);
+		list_move(&ce->e_lru_list, &free_list);
 		if (__mb_cache_entry_is_linked(ce))
 			__mb_cache_entry_unlink(ce);
 		nr_to_scan--;
 	}
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
+
 	l = free_list.prev;
 	while (l != &free_list) {
 		struct mb_cache_entry *ce = list_entry(l,
@@ -303,7 +284,6 @@
 	   indexes_count * sizeof(struct mb_cache_entry_index))
 		return NULL;
 
-	MOD_INC_USE_COUNT;
 	cache = kmalloc(sizeof(struct mb_cache) +
 	                indexes_count * sizeof(struct list_head), GFP_KERNEL);
 	if (!cache)
@@ -340,7 +320,7 @@
 	if (!cache->c_entry_cache)
 		goto fail;
 
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	if (list_empty(&mb_cache_list)) {
 		if (mb_shrinker) {
 			printk(KERN_ERR "%s: already have a shrinker!\n",
@@ -350,7 +330,7 @@
 		mb_shrinker = set_shrinker(DEFAULT_SEEKS, mb_cache_shrink_fn);
 	}
 	list_add(&cache->c_cache_list, &mb_cache_list);
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 	return cache;
 
 fail:
@@ -361,7 +341,6 @@
 			kfree(cache->c_block_hash);
 		kfree(cache);
 	}
-	MOD_DEC_USE_COUNT;
 	return NULL;
 }
 
@@ -382,20 +361,19 @@
 	LIST_HEAD(free_list);
 	struct list_head *l;
 
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	l = mb_cache_lru_list.prev;
 	while (l != &mb_cache_lru_list) {
 		struct mb_cache_entry *ce =
 			list_entry(l, struct mb_cache_entry, e_lru_list);
 		l = l->prev;
 		if (ce->e_dev == dev) {
-			list_del(&ce->e_lru_list);
-			list_add(&ce->e_lru_list, &free_list);
+			list_move(&ce->e_lru_list, &free_list);
 			if (__mb_cache_entry_is_linked(ce))
 				__mb_cache_entry_unlink(ce);
 		}
 	}
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 	l = free_list.prev;
 	while (l != &free_list) {
 		struct mb_cache_entry *ce =
@@ -420,15 +398,14 @@
 	struct list_head *l;
 	int n;
 
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	l = mb_cache_lru_list.prev;
 	while (l != &mb_cache_lru_list) {
 		struct mb_cache_entry *ce =
 			list_entry(l, struct mb_cache_entry, e_lru_list);
 		l = l->prev;
 		if (ce->e_cache == cache) {
-			list_del(&ce->e_lru_list);
-			list_add(&ce->e_lru_list, &free_list);
+			list_move(&ce->e_lru_list, &free_list);
 			if (__mb_cache_entry_is_linked(ce))
 				__mb_cache_entry_unlink(ce);
 		}
@@ -438,7 +415,7 @@
 		remove_shrinker(mb_shrinker);
 		mb_shrinker = 0;
 	}
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 
 	l = free_list.prev;
 	while (l != &free_list) {
@@ -454,19 +431,12 @@
 			  atomic_read(&cache->c_entry_count));
 	}
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
-	/* We don't have kmem_cache_destroy() in 2.2.x */
-	kmem_cache_shrink(cache->c_entry_cache);
-#else
 	kmem_cache_destroy(cache->c_entry_cache);
-#endif
 	for (n=0; n < mb_cache_indexes(cache); n++)
 		kfree(cache->c_indexes_hash[n]);
 	kfree(cache->c_block_hash);
 
 	kfree(cache);
-
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -486,8 +456,8 @@
 	atomic_inc(&cache->c_entry_count);
 	ce = kmem_cache_alloc(cache->c_entry_cache, GFP_KERNEL);
 	if (ce) {
-		ce->e_lru_list.prev = NULL;
-		ce->e_block_list.prev = NULL;
+		INIT_LIST_HEAD(&ce->e_lru_list);
+		INIT_LIST_HEAD(&ce->e_block_list);
 		ce->e_cache = cache;
 		atomic_set(&ce->e_used, 1);
 	}
@@ -519,7 +489,7 @@
 	struct list_head *l;
 	int error = -EBUSY, n;
 
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	list_for_each_prev(l, &cache->c_block_hash[bucket]) {
 		struct mb_cache_entry *ce =
 			list_entry(l, struct mb_cache_entry, e_block_list);
@@ -533,7 +503,7 @@
 		ce->e_indexes[n].o_key = keys[n];
 	__mb_cache_entry_link(ce);
 out:
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 	return error;
 }
 
@@ -548,7 +518,7 @@
 void
 mb_cache_entry_release(struct mb_cache_entry *ce)
 {
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	__mb_cache_entry_release_unlock(ce);
 }
 
@@ -563,11 +533,11 @@
 void
 mb_cache_entry_takeout(struct mb_cache_entry *ce)
 {
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	mb_assert(!__mb_cache_entry_in_lru(ce));
 	if (__mb_cache_entry_is_linked(ce))
 		__mb_cache_entry_unlink(ce);
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 }
 
 
@@ -580,7 +550,7 @@
 void
 mb_cache_entry_free(struct mb_cache_entry *ce)
 {
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	mb_assert(!__mb_cache_entry_in_lru(ce));
 	if (__mb_cache_entry_is_linked(ce))
 		__mb_cache_entry_unlink(ce);
@@ -616,7 +586,7 @@
 	struct list_head *l;
 	struct mb_cache_entry *ce;
 
-	mb_cache_lock();
+	spin_lock(&mb_cache_spinlock);
 	list_for_each(l, &cache->c_block_hash[bucket]) {
 		ce = list_entry(l, struct mb_cache_entry, e_block_list);
 		if (ce->e_dev == dev && ce->e_block == block) {
@@ -627,7 +597,7 @@
 	ce = NULL;
 
 cleanup:
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 	return ce;
 }
 
@@ -674,11 +644,12 @@
 	struct mb_cache_entry *ce;
 
 	mb_assert(index < mb_cache_indexes(cache));
-	mb_cache_lock();
+
+	spin_lock(&mb_cache_spinlock);
 	l = cache->c_indexes_hash[index][bucket].next;
 	ce = __mb_cache_entry_find(l, &cache->c_indexes_hash[index][bucket],
 	                           index, dev, key);
-	mb_cache_unlock();
+	spin_unlock(&mb_cache_spinlock);
 	return ce;
 }
 
@@ -712,7 +683,8 @@
 	struct mb_cache_entry *ce;
 
 	mb_assert(index < mb_cache_indexes(cache));
-	mb_cache_lock();
+
+	spin_lock(&mb_cache_spinlock);
 	l = prev->e_indexes[index].o_list.next;
 	ce = __mb_cache_entry_find(l, &cache->c_indexes_hash[index][bucket],
 	                           index, dev, key);
