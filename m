Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSHEBAe>; Sun, 4 Aug 2002 21:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSHEBAe>; Sun, 4 Aug 2002 21:00:34 -0400
Received: from tomts26.bellnexxia.net ([209.226.175.189]:62402 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318282AbSHEBAV>; Sun, 4 Aug 2002 21:00:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] slablru_19-ac2
Date: Sun, 4 Aug 2002 21:03:36 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-mm@kvack.org, Andrew Morton <akpm@zip.com.au>,
       Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208042103.37069.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the current slablru patch.  This version improves the locking as per
a suggestion from Andrew Morton.  Rik my bk tree has been updated with
the locking changes.

If you are having slab memory problems or dcache/icache get too large and
seen not to be pruned 'correctly' - This patch may well help.  

Varients of this patch have been around since the begining of June.  It was
tested against 2.4 and with the port of the full rmap vm to 2.5 on 2.5.  Another 
varient is available for 2.5.30.  

Patch is against 2.4.19-ac2

Feedback very welcome,

Ed Tomlinson

---------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.667   -> 1.670  
#	         fs/dcache.c	1.20    -> 1.21   
#	          fs/dquot.c	1.18    -> 1.20   
#	         mm/vmscan.c	1.60    -> 1.63   
#	           mm/slab.c	1.17    -> 1.19   
#	include/linux/slab.h	1.9     -> 1.10   
#	include/linux/dcache.h	1.12    -> 1.13   
#	          fs/inode.c	1.36    -> 1.37   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/04	patch@oscar.et.ca	1.668
# slablru_19-1
# --------------------------------------------
# 02/08/04	patch@oscar.et.ca	1.669
# slablru_19-2
# --------------------------------------------
# 02/08/04	ed@oscar.et.ca	1.670
# fix syntax error
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Sun Aug  4 20:39:29 2002
+++ b/fs/dcache.c	Sun Aug  4 20:39:29 2002
@@ -321,7 +321,7 @@
 void prune_dcache(int count)
 {
 	spin_lock(&dcache_lock);
-	for (;;) {
+	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
 
@@ -345,8 +345,6 @@
 			BUG();
 
 		prune_one_dentry(dentry);
-		if (!--count)
-			break;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -538,19 +536,10 @@
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our dcache, but not
- * too much.
- *
- * Priority:
- *   0 - very urgent: shrink everything
- *  ...
- *   6 - base-level: try to shrink a bit.
+ * more memory. 
  */
-int shrink_dcache_memory(int priority, unsigned int gfp_mask)
+int age_dcache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
 {
-	int count = 0;
-
 	/*
 	 * Nasty deadlock avoidance.
 	 *
@@ -565,10 +554,11 @@
 	if (!(gfp_mask & __GFP_FS))
 		return 0;
 
-	count = dentry_stat.nr_unused / priority;
+	if (entries > dentry_stat.nr_unused)
+		entries = dentry_stat.nr_unused;
 
-	prune_dcache(count);
-	return kmem_cache_shrink(dentry_cache);
+	prune_dcache(entries);
+	return entries;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
@@ -1186,6 +1176,8 @@
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 
+	kmem_set_pruner(dentry_cache, (kmem_pruner_t)age_dcache_memory);
+
 #if PAGE_SHIFT < 13
 	mempages >>= (13 - PAGE_SHIFT);
 #endif
@@ -1279,6 +1271,9 @@
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!dquot_cachep)
 		panic("Cannot create dquot SLAB cache");
+	
+	kmem_set_pruner(dquot_cachep, (kmem_pruner_t)age_dqcache_memory);
+	
 #endif
 
 	dcache_init(mempages);
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Sun Aug  4 20:39:29 2002
+++ b/fs/dquot.c	Sun Aug  4 20:39:29 2002
@@ -503,15 +503,15 @@
  *   6 - base-level: try to shrink a bit.
  */
 
-int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
+int age_dqcache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
 {
-	int count = 0;
+	if (entries > nr_free_dquots)
+		entries = nr_free_dquots;
 
 	lock_kernel();
-	count = dqstats.free_dquots / priority;
-	prune_dqcache(count);
+	prune_dqcache(entries);
 	unlock_kernel();
-	return kmem_cache_shrink(dquot_cachep);
+	return entries;
 }
 
 /*
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sun Aug  4 20:39:29 2002
+++ b/fs/inode.c	Sun Aug  4 20:39:29 2002
@@ -672,10 +672,11 @@
 
 	count = 0;
 	entry = inode_unused.prev;
-	while (entry != &inode_unused)
-	{
+	for(; goal; goal--) {
 		struct list_head *tmp = entry;
 
+		if (entry == &inode_unused)
+			break;
 		entry = entry->prev;
 		inode = INODE(tmp);
 		if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
@@ -690,8 +691,6 @@
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
-		if (!--goal)
-			break;
 	}
 	inodes_stat.nr_unused -= count;
 	spin_unlock(&inode_lock);
@@ -708,10 +707,8 @@
 		schedule_task(&unused_inodes_flush_task);
 }
 
-int shrink_icache_memory(int priority, int gfp_mask)
+int age_icache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
 {
-	int count = 0;
-
 	/*
 	 * Nasty deadlock avoidance..
 	 *
@@ -722,10 +719,11 @@
 	if (!(gfp_mask & __GFP_FS))
 		return 0;
 
-	count = inodes_stat.nr_unused / priority;
+	if (entries > inodes_stat.nr_unused)
+		entries = inodes_stat.nr_unused;
 
-	prune_icache(count);
-	return kmem_cache_shrink(inode_cachep);
+	prune_icache(entries);
+	return entries;
 }
 
 /*
@@ -1172,6 +1170,8 @@
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
+
+	kmem_set_pruner(inode_cachep, (kmem_pruner_t)age_icache_memory);
 
 	unused_inodes_flush_task.routine = try_to_sync_unused_inodes;
 }
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Sun Aug  4 20:39:29 2002
+++ b/include/linux/dcache.h	Sun Aug  4 20:39:29 2002
@@ -172,15 +172,10 @@
 #define shrink_dcache() prune_dcache(0)
 struct zone_struct;
 /* dcache memory management */
-extern int shrink_dcache_memory(int, unsigned int);
 extern void prune_dcache(int);
 
 /* icache memory management (defined in linux/fs/inode.c) */
-extern int shrink_icache_memory(int, int);
 extern void prune_icache(int);
-
-/* quota cache memory management (defined in linux/fs/dquot.c) */
-extern int shrink_dqcache_memory(int, unsigned int);
 
 /* only used at mount-time */
 extern struct dentry * d_alloc_root(struct inode *);
diff -Nru a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h	Sun Aug  4 20:39:29 2002
+++ b/include/linux/slab.h	Sun Aug  4 20:39:29 2002
@@ -55,6 +55,26 @@
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+
+typedef int (*kmem_pruner_t)(kmem_cache_t *, int, int);
+
+extern void kmem_set_pruner(kmem_cache_t *, kmem_pruner_t);
+extern int kmem_do_prunes(int);
+extern int kmem_count_page(struct page *, int);
+#define kmem_touch_page(addr)                 SetPageReferenced(virt_to_page(addr));
+
+/* shrink a slab */
+extern int kmem_shrink_slab(struct page *);
+
+/* dcache prune ( defined in linux/fs/dcache.c) */
+extern int age_dcache_memory(kmem_cache_t *, int, int);
+
+/* icache prune (defined in linux/fs/inode.c) */
+extern int age_icache_memory(kmem_cache_t *, int, int);
+
+/* quota cache prune (defined in linux/fs/dquot.c) */
+extern int age_dqcache_memory(kmem_cache_t *, int, int);
+
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Sun Aug  4 20:39:29 2002
+++ b/mm/slab.c	Sun Aug  4 20:39:29 2002
@@ -72,6 +72,7 @@
 #include	<linux/slab.h>
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
+#include	<linux/mm_inline.h>
 #include	<linux/compiler.h>
 #include	<linux/seq_file.h>
 #include	<asm/uaccess.h>
@@ -214,6 +215,8 @@
 	kmem_cache_t		*slabp_cache;
 	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
+	kmem_pruner_t		pruner;	/* shrink callback */
+	int 			count;		/* count used to trigger shrink */
 
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
@@ -252,10 +255,12 @@
 
 /* c_dflags (dynamic flags). Need to hold the spinlock to access this member */
 #define	DFLGS_GROWN	0x000001UL	/* don't reap a recently grown */
+#define	DFLGS_NONLRU	0x000002UL	/* there are reciently allocated 
+					   non lru pages in this cache */
 
 #define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
 #define	OPTIMIZE(x)	((x)->flags & CFLGS_OPTIMIZE)
-#define	GROWN(x)	((x)->dlags & DFLGS_GROWN)
+#define	GROWN(x)	((x)->dflags & DFLGS_GROWN)
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -383,6 +388,67 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
 #endif
+ 
+/* 
+ * Note: in 2.5 we change the kmem_cache_create api, here we use this
+ */
+void kmem_set_pruner(kmem_cache_t * cachep, kmem_pruner_t thepruner) 
+{
+	cachep->pruner = thepruner;
+}
+
+/* 
+ * Used by refill_inactive_zone to determine caches that need pruning.
+ */
+int kmem_count_page(struct page *page, int cold)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+	int ret =0;
+	if (cachep->gfporder) {
+		struct page *bpage = virt_to_page(slabp->s_mem - slabp->colouroff);
+		if (bpage != page)
+			return 0;
+	}
+	spin_lock_irq(&cachep->spinlock);
+	if (cachep->pruner != NULL) {
+		cachep->count += slabp->inuse;
+		ret = !slabp->inuse;
+	} else 
+		ret = cold && !slabp->inuse;
+	spin_unlock_irq(&cachep->spinlock);
+	return ret;
+}
+
+
+/* Call the prune functions to age pruneable caches */
+int kmem_do_prunes(int gfp_mask) 
+{
+	struct list_head *p;
+	int nr;
+
+        if (gfp_mask & __GFP_WAIT)
+                down(&cache_chain_sem);
+        else
+                if (down_trylock(&cache_chain_sem))
+                        return 0;
+
+        list_for_each(p,&cache_chain) {
+                kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
+		if (cachep->pruner != NULL) {
+			spin_lock_irq(&cachep->spinlock);
+			nr = cachep->count;
+			cachep->count = 0;
+			spin_unlock_irq(&cachep->spinlock);
+			if (nr > 0)
+				(*cachep->pruner)(cachep, nr, gfp_mask);
+
+		}
+	}
+        up(&cache_chain_sem);
+	return 1;
+}
+
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void kmem_cache_estimate (unsigned long gfporder, size_t size,
@@ -481,7 +547,8 @@
 
 __initcall(kmem_cpucache_init);
 
-/* Interface to system's page allocator. No need to hold the cache-lock.
+/*
+ * Interface to system's page allocator. No need to hold the cache-lock.
  */
 static inline void * kmem_getpages (kmem_cache_t *cachep, unsigned long flags)
 {
@@ -514,10 +581,15 @@
 	 * but their 'struct page's might be accessed in
 	 * vm_scan(). Shouldn't be a worry.
 	 */
+	spin_lock(&pagemap_lru_lock);
 	while (i--) {
 		PageClearSlab(page);
+		if (PageActive(page))
+			del_page_from_active_list(page);
+		ClearPageReferenced(page);
 		page++;
 	}
+	spin_unlock(&pagemap_lru_lock);
 	free_pages((unsigned long)addr, cachep->gfporder);
 }
 
@@ -548,6 +620,7 @@
 }
 #endif
 
+
 /* Destroy all the objs in a slab, and release the mem back to the system.
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
@@ -782,6 +855,8 @@
 		flags |= CFLGS_OPTIMIZE;
 
 	cachep->flags = flags;
+	cachep->pruner = NULL;
+	cachep->count = 0;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
@@ -955,13 +1030,13 @@
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
-
+	
 /**
  * kmem_cache_shrink - Shrink a cache.
  * @cachep: The cache to shrink.
  *
  * Releases as many slabs as possible for a cache.
- * Returns number of pages released.
+ * Returns number of pages removed from the cache.
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
@@ -971,14 +1046,50 @@
 		BUG();
 
 	drain_cpu_caches(cachep);
-  
+ 
 	spin_lock_irq(&cachep->spinlock);
 	ret = __kmem_cache_shrink_locked(cachep);
 	spin_unlock_irq(&cachep->spinlock);
 
-	return ret << cachep->gfporder;
+	return ret<<cachep->gfporder;
+}
+
+
+/* 
+ * Used by refill_inactive_zone to try to shrink a cache.  The
+ * method we use to shrink depends on if we have added nonlru
+ * pages since the last time we shrunk this cache. 
+ * - shrink works and we return the pages shrunk
+ * - shrink fails because the slab is in use, we return 0
+ */
+int kmem_shrink_slab(struct page *page)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+
+	spin_lock_irq(&cachep->spinlock);
+	if (!slabp->inuse) {
+	 	if (!cachep->growing) {
+			if (cachep->dflags & DFLGS_NONLRU) {
+				int nr = __kmem_cache_shrink_locked(cachep);
+				cachep->dflags &= ~DFLGS_NONLRU;
+				spin_unlock_irq(&cachep->spinlock);
+				return nr<<cachep->gfporder;
+			} else {
+				list_del(&slabp->list);
+				spin_unlock_irq(&cachep->spinlock);
+				kmem_slab_destroy(cachep, slabp);
+				return 1<<cachep->gfporder;
+			}
+			if (PageActive(page))
+				BUG();
+		}
+	}
+	spin_unlock_irq(&cachep->spinlock);
+	return 0; 
 }
 
+
 /**
  * kmem_cache_destroy - delete a cache
  * @cachep: the cache to destroy
@@ -1108,7 +1219,7 @@
 	struct page	*page;
 	void		*objp;
 	size_t		 offset;
-	unsigned int	 i, local_flags;
+	unsigned int	 i, local_flags, locked = 0;
 	unsigned long	 ctor_flags;
 	unsigned long	 save_flags;
 
@@ -1165,6 +1276,19 @@
 	if (!(objp = kmem_getpages(cachep, flags)))
 		goto failed;
 
+	/* 
+	 * We want the pagemap_lru_lock, in UP spin locks to not 
+	 * protect us in interrupt context...  In SMP they do but,
+	 * optimizating for speed, we process if we do not get it. 
+	 */
+	if (!(cachep->flags & SLAB_NO_REAP)) {
+#ifdef CONFIG_SMP
+		locked = spin_trylock(&pagemap_lru_lock);
+#else
+		locked = !in_interrupt() && spin_trylock(&pagemap_lru_lock);
+#endif
+	}
+
 	/* Get slab management. */
 	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
@@ -1176,9 +1300,15 @@
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
 		PageSetSlab(page);
+		set_page_count(page, 1);
+		if (locked) 
+			add_page_to_active_list(page);
 		page++;
 	} while (--i);
 
+	if (locked)
+		spin_unlock(&pagemap_lru_lock);
+
 	kmem_cache_init_objs(cachep, slabp, ctor_flags);
 
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
@@ -1189,10 +1319,15 @@
 	STATS_INC_GROWN(cachep);
 	cachep->failures = 0;
 
+	/* The pagemap_lru_lock was not quickly/safely available */
+	if (!locked && !(cachep->flags & SLAB_NO_REAP))
+		cachep->dflags |= DFLGS_NONLRU;
+
 	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
 	return 1;
 opps1:
-	kmem_freepages(cachep, objp);
+	/* do not use kmem_freepages - we are not in the lru yet... */      
+	free_pages((unsigned long)objp, cachep->gfporder);
 failed:
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
 	cachep->growing--;
@@ -1257,6 +1392,12 @@
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
 	}
+
+	if (unlikely(cachep->gfporder)) {
+		void *objb = slabp->s_mem-slabp->colouroff;
+		kmem_touch_page(objb);
+	} else
+		kmem_touch_page(objp);
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
 		if (kmem_check_poison_obj(cachep, objp))
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Sun Aug  4 20:39:29 2002
+++ b/mm/vmscan.c	Sun Aug  4 20:39:29 2002
@@ -136,6 +136,10 @@
 			goto found_page;
 		}
 
+		/* should not be on this list... */
+		if (PageSlab(page))
+			BUG();
+
 		/* We should never ever get here. */
 		printk(KERN_ERR "VM: reclaim_page, found unknown page\n");
 		list_del(page_lru);
@@ -264,6 +268,10 @@
 		if (unlikely(TryLockPage(page)))
 			continue;
 
+		/* Slab pages should never get here... */
+		if (PageSlab(page))
+			BUG();
+
 		/*
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list and adjust the page age if needed.
@@ -469,6 +477,7 @@
  * This function will scan a portion of the active list of a zone to find
  * unused pages, those pages will then be moved to the inactive list.
  */
+
 int refill_inactive_zone(struct zone_struct * zone, int priority)
 {
 	int maxscan = zone->active_pages >> priority;
@@ -506,7 +515,7 @@
 		 * both PG_locked and the pte_chain_lock are held.
 		 */
 		pte_chain_lock(page);
-		if (!page_mapping_inuse(page)) {
+		if (!page_mapping_inuse(page) && !PageSlab(page)) {
 			pte_chain_unlock(page);
 			UnlockPage(page);
 			drop_page(page);
@@ -523,6 +532,31 @@
 		}
 
 		/* 
+		 * For slab pages we count entries for caches with their
+		 * own pruning/aging method.  If we can count a page or
+		 * its cold we try to free it.  We only use one aging
+		 * method otherwise we end up with caches with lots
+		 * of free pages...  kmem_shrink_slab frees slab(s)
+		 * and moves the page(s) to the inactive clean list. 
+		 */
+		if (PageSlab(page)) {
+			pte_chain_unlock(page);
+			UnlockPage(page);
+			spin_unlock(&pagemap_lru_lock);
+			if (kmem_count_page(page, !page->age))
+				if (nr_deactivated += kmem_shrink_slab(page)) {
+					if (nr_deactivated > target)
+						return nr_deactivated;
+	 				spin_lock(&pagemap_lru_lock);
+					continue;
+			}
+	 		spin_lock(&pagemap_lru_lock);
+			list_del(page_lru);
+			list_add(page_lru, &zone->active_list);
+			continue;
+		}
+
+		/* 
 		 * If the page age is 'hot' and the process using the
 		 * page doesn't exceed its RSS limit we keep the page.
 		 * Otherwise we move it to the inactive_dirty list.
@@ -551,10 +585,10 @@
 
 done:
 	spin_unlock(&pagemap_lru_lock);
-
 	return nr_deactivated;
 }
 
+
 /**
  * refill_inactive - checks all zones and refills the inactive list as needed
  *
@@ -619,24 +653,15 @@
 
 	/*
 	 * Eat memory from filesystem page cache, buffer cache,
-	 * dentry, inode and filesystem quota caches.
 	 */
 	ret += page_launder(gfp_mask);
-	ret += shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
-	ret += shrink_icache_memory(1, gfp_mask);
-#ifdef CONFIG_QUOTA
-	ret += shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
-#endif
 
 	/*
-	 * Move pages from the active list to the inactive list.
+	 * Move pages from the active list to the inactive list,
+	 * then prune the prunable caches, aging them.
 	 */
 	refill_inactive();
-
-	/* 	
-	 * Reclaim unused slab cache memory.
-	 */
-	ret += kmem_cache_reap(gfp_mask);
+	kmem_do_prunes(gfp_mask);
 
 	refill_freelist();
 
@@ -645,11 +670,13 @@
 		run_task_queue(&tq_disk);
 
 	/*
-	 * Hmm.. Cache shrink failed - time to kill something?
+	 * Hmm.. - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
 	 */
-	if (!ret && free_min(ANY_ZONE) > 0)
-		out_of_memory();
+	if (!ret && free_min(ANY_ZONE) > 0) {
+		if (!kmem_cache_reap(gfp_mask))
+			out_of_memory();
+	}
 
 	return ret;
 }
@@ -740,6 +767,7 @@
 
 			/* Do background page aging. */
 			background_aging(DEF_PRIORITY);
+			kmem_do_prunes(GFP_KSWAPD);
 		}
 
 		wakeup_memwaiters();

---------



