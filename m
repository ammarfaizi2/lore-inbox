Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSE2MBn>; Wed, 29 May 2002 08:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSE2MBm>; Wed, 29 May 2002 08:01:42 -0400
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:52678 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S314929AbSE2MBf>; Wed, 29 May 2002 08:01:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)
Date: Wed, 29 May 2002 08:01:16 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-mm@kvack.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200205180010.51382.tomlins@cam.org> <20020521144759.B1153@redhat.com> <200205240728.45558.tomlins@cam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205290800.22376.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an improved version of the patch.  It fixes a race in kmem_freepages (I do
not see why the race should not happen in straight ac) and makes the following 
changes:

Aging works a little differently for pruneable caches.  For these caches we use
pruning to do aging.  The rate we prune is simpily the rate we see objects on
pages processed by vmscan.  For the all other caches vm aging is used.  Without this
change two aging methods we being applied to the dcache/icache.  This favored
their pages and the vm was quite slow to trim them at times.

Second, since there is almost no overhead (ie no disk access), when refill_inactive_zone
sees a slab page it wants to free it releases the slab and moves the pages to the inactive
clean list.  

An interesting note.  If I directly free the pages in kmem_freepages I run into a race.
It seems that freepages can be lost...   To see the race I do the following.

find / -name "*" > /dev/null &
irman &
dbench 40 &

When irman start its memory stress test free pages are lost.  Its very easy to see this
using zlatko calusic's xmm utility.  With my patch the number of kernel pages should
be quite stable.  When the race occurs they jump and proc/meminfo shows missing
pages.  This is on UP with no preempth.

Patch applies to pre8-ac5.

Comments?

Ed Tomlinson

-----------------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.406   -> 1.412  
#	         fs/buffer.c	1.66    -> 1.68   
#	         fs/dcache.c	1.19    -> 1.21   
#	          fs/dquot.c	1.18    -> 1.20   
#	         mm/vmscan.c	1.60    -> 1.65   
#	           mm/slab.c	1.16    -> 1.21   
#	include/linux/slab.h	1.8     -> 1.10   
#	include/linux/dcache.h	1.11    -> 1.12   
#	          fs/inode.c	1.36    -> 1.38   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/24	ed@oscar.et.ca	1.407
# age_pressure_v8.diff
# --------------------------------------------
# 02/05/24	ed@oscar.et.ca	1.408
# Remove side effect from kmem_shrink_slab and fix vmscan to use the new
# return codes.
# --------------------------------------------
# 02/05/24	ed@oscar.et.ca	1.409
# Simpilify - try lates algorythm without touches in lookups.
# --------------------------------------------
# 02/05/24	ed@oscar.et.ca	1.410
# Use either vm aging or prune call back aging, not both.  Keep slab
# pages on the active list.
# --------------------------------------------
# 02/05/28	ed@oscar.et.ca	1.411
# fix locking in slab to use pagemap_lru_lock when shrinking or growing
# a cache.  Use the inactive clean list when freeing a slab's pages.
# This avoid a race so the vm does not lose track of pages.
# --------------------------------------------
# 02/05/29	ed@oscar.et.ca	1.412
# Prevent bug in page_launder from being hit due to a dangling 
# referencebit.  Improve accounting in refill_inactive.
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Wed May 29 07:35:03 2002
+++ b/fs/dcache.c	Wed May 29 07:35:03 2002
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
--- a/fs/dquot.c	Wed May 29 07:35:03 2002
+++ b/fs/dquot.c	Wed May 29 07:35:03 2002
@@ -1026,10 +1026,13 @@
 
 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
+	if (entries > nr_free_dquots)
+		entries = nr_free_dquots;
+
 	lock_kernel();
-	prune_dqcache(nr_free_dquots / (priority + 1));
+	prune_dqcache(entries);
 	unlock_kernel();
-	return kmem_cache_shrink(dquot_cachep);
+	return entries;
 }
 
 /*
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Wed May 29 07:35:03 2002
+++ b/fs/inode.c	Wed May 29 07:35:03 2002
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
--- a/include/linux/dcache.h	Wed May 29 07:35:03 2002
+++ b/include/linux/dcache.h	Wed May 29 07:35:03 2002
@@ -171,15 +171,10 @@
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
--- a/include/linux/slab.h	Wed May 29 07:35:03 2002
+++ b/include/linux/slab.h	Wed May 29 07:35:03 2002
@@ -55,6 +55,26 @@
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+
+typedef int (*kmem_pruner_t)(kmem_cache_t *, int, int);
+
+extern void kmem_set_pruner(kmem_cache_t *, kmem_pruner_t);
+extern int kmem_do_prunes(int);
+extern int kmem_count_page(struct page *);
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
--- a/mm/slab.c	Wed May 29 07:35:03 2002
+++ b/mm/slab.c	Wed May 29 07:35:03 2002
@@ -72,6 +72,7 @@
 #include	<linux/slab.h>
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
+#include	<linux/mm_inline.h>
 #include	<asm/uaccess.h>
 
 /*
@@ -212,6 +213,8 @@
 	kmem_cache_t		*slabp_cache;
 	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
+	kmem_pruner_t		pruner;	/* shrink callback */
+	int 			count;		/* count used to trigger shrink */
 
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
@@ -381,6 +384,54 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
 #endif
+ 
+/* set the prune call back function */
+void kmem_set_pruner(kmem_cache_t * cachep, kmem_pruner_t thepruner) 
+{
+	cachep->pruner = thepruner;
+}
+
+/* used by refill_inactive_zone to determine caches that need pruning */
+int kmem_count_page(struct page *page)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+	if (cachep->pruner != NULL)
+		cachep->count += (slabp->inuse >> cachep->gfporder);
+	return (cachep->pruner != NULL);
+}
+
+/* call the prune functions to age pruneable caches */
+int kmem_do_prunes(int gfp_mask) 
+{
+	int ret = 0;
+	struct list_head *p;
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
+			if (cachep->count > 0) {
+#ifdef DEBUGX
+				int nr = (*cachep->pruner)(cachep, cachep->count, gfp_mask);
+				printk("pruned %-17s %d\n",cachep->name, nr, gfp_mask)); 
+#else
+				(*cachep->pruner)(cachep, cachep->count, gfp_mask);
+#endif
+				cachep->count = 0;
+
+			}
+		}
+        }
+        up(&cache_chain_sem);
+	return 1;
+}
+
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void kmem_cache_estimate (unsigned long gfporder, size_t size,
@@ -479,7 +530,9 @@
 
 __initcall(kmem_cpucache_init);
 
-/* Interface to system's page allocator. No need to hold the cache-lock.
+/*
+ * Interface to system's page allocator. No need to hold the cache-lock.
+ * Call with pagemap_lru_lock held
  */
 static inline void * kmem_getpages (kmem_cache_t *cachep, unsigned long flags)
 {
@@ -513,10 +566,17 @@
 	 * vm_scan(). Shouldn't be a worry.
 	 */
 	while (i--) {
-		PageClearSlab(page);
+		if (cachep->flags & SLAB_NO_REAP) 
+			PageClearSlab(page);
+		else {
+			ClearPageReferenced(page);
+			del_page_from_active_list(page);
+			add_page_to_inactive_clean_list(page);
+		}
 		page++;
 	}
-	free_pages((unsigned long)addr, cachep->gfporder);
+	if (cachep->flags & SLAB_NO_REAP)
+		free_pages((unsigned long)addr, cachep->gfporder);
 }
 
 #if DEBUG
@@ -549,6 +609,7 @@
 /* Destroy all the objs in a slab, and release the mem back to the system.
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
+ * pagemap_lru_lock should be held for kmem_freepages
  */
 static void kmem_slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
 {
@@ -588,6 +649,32 @@
 		kmem_cache_free(cachep->slabp_cache, slabp);
 }
 
+/* 
+ * Used by page_launder_zone and refill_inactive_zone to 
+ * try to shrink a slab. 
+ * - shrink works and we return the pages shrunk
+ * - shrink fails because the slab is in use, we return 0
+ * called with pagemap_lru_lock held.
+ */
+int kmem_shrink_slab(struct page *page)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+
+	spin_lock_irq(cachep->spinlock);
+	if (!slabp->inuse) {
+	 	if (!cachep->growing) {
+			list_del(&slabp->list);
+			spin_unlock_irq(cachep->spinlock);
+			kmem_slab_destroy(cachep, slabp);
+			return 1<<cachep->gfporder;
+		}
+	}
+	spin_unlock_irq(cachep->spinlock);
+	return 0; 
+}
+
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -780,6 +867,8 @@
 		flags |= CFLGS_OPTIMIZE;
 
 	cachep->flags = flags;
+	cachep->pruner = NULL;
+	cachep->count = 0;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
@@ -946,11 +1035,13 @@
 
 	drain_cpu_caches(cachep);
 
+	spin_lock(&pagemap_lru_lock);
 	spin_lock_irq(&cachep->spinlock);
 	__kmem_cache_shrink_locked(cachep);
 	ret = !list_empty(&cachep->slabs_full) ||
 		!list_empty(&cachep->slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&pagemap_lru_lock);
 	return ret;
 }
 
@@ -969,10 +1060,12 @@
 		BUG();
 
 	drain_cpu_caches(cachep);
-  
+ 
+	spin_lock(&pagemap_lru_lock);
 	spin_lock_irq(&cachep->spinlock);
 	ret = __kmem_cache_shrink_locked(cachep);
 	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&pagemap_lru_lock);
 
 	return ret << cachep->gfporder;
 }
@@ -1163,6 +1256,14 @@
 	if (!(objp = kmem_getpages(cachep, flags)))
 		goto failed;
 
+	/* 
+	 * We need the pagemap_lru_lock - is there a way to wait here 
+	 * or could we just spinlock without deadlocking ???
+	 */
+	if (!(cachep->flags & SLAB_NO_REAP))
+		if (!spin_trylock(&pagemap_lru_lock))
+			goto opps1;
+
 	/* Get slab management. */
 	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
@@ -1174,9 +1275,16 @@
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
 		PageSetSlab(page);
+		if (!(cachep->flags & SLAB_NO_REAP)) {
+			set_page_count(page, 1);
+			add_page_to_active_list(page);
+		}
 		page++;
 	} while (--i);
 
+	if (!(cachep->flags & SLAB_NO_REAP))
+		spin_unlock(&pagemap_lru_lock);
+
 	kmem_cache_init_objs(cachep, slabp, ctor_flags);
 
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
@@ -1190,7 +1298,8 @@
 	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
 	return 1;
 opps1:
-	kmem_freepages(cachep, objp);
+	/* do not use kmem_freepages - we are not in the lru yet... */      
+	free_pages((unsigned long)objp, cachep->gfporder);
 failed:
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
 	cachep->growing--;
@@ -1255,6 +1364,7 @@
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
 	}
+	kmem_touch_page(objp);
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
 		if (kmem_check_poison_obj(cachep, objp))
@@ -1816,6 +1926,7 @@
 
 	spin_lock_irq(&best_cachep->spinlock);
 perfect:
+	spin_lock(&pagemap_lru_lock);
 	/* free only 50% of the free slabs */
 	best_len = (best_len + 1)/2;
 	for (scan = 0; scan < best_len; scan++) {
@@ -1841,6 +1952,7 @@
 		kmem_slab_destroy(best_cachep, slabp);
 		spin_lock_irq(&best_cachep->spinlock);
 	}
+	spin_unlock(&pagemap_lru_lock);
 	spin_unlock_irq(&best_cachep->spinlock);
 	ret = scan * (1 << best_cachep->gfporder);
 out:
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Wed May 29 07:35:03 2002
+++ b/mm/vmscan.c	Wed May 29 07:35:03 2002
@@ -137,6 +137,12 @@
 			goto found_page;
 		}
 
+		/* page just has the flag, its not in any cache/slab */
+		if (PageSlab(page)) {
+			PageClearSlab(page);
+			goto found_page;
+		}
+
 		/* We should never ever get here. */
 		printk(KERN_ERR "VM: reclaim_page, found unknown page\n");
 		list_del(page_lru);
@@ -265,6 +271,10 @@
 		if (unlikely(TryLockPage(page)))
 			continue;
 
+		/* Slab pages should never get here... */
+		if (PageSlab(page))
+			BUG();
+
 		/*
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list and adjust the page age if needed.
@@ -470,12 +480,14 @@
  * This function will scan a portion of the active list of a zone to find
  * unused pages, those pages will then be moved to the inactive list.
  */
+
 int refill_inactive_zone(struct zone_struct * zone, int priority)
 {
 	int maxscan = zone->active_pages >> priority;
 	int target = inactive_high(zone);
 	struct list_head * page_lru;
 	int nr_deactivated = 0;
+	int nr_freed = 0;
 	struct page * page;
 
 	/* Take the lock while messing with the list... */
@@ -507,7 +519,7 @@
 		 * both PG_locked and the pte_chain_lock are held.
 		 */
 		pte_chain_lock(page);
-		if (!page_mapping_inuse(page)) {
+		if (!page_mapping_inuse(page) && !PageSlab(page)) {
 			pte_chain_unlock(page);
 			UnlockPage(page);
 			drop_page(page);
@@ -524,6 +536,31 @@
 		}
 
 		/* 
+		 * For slab pages we count entries for caches with their
+		 * own pruning/aging method.  If we can count a page or
+		 * its cold we try to free it.  We only use one aging
+		 * method otherwise we end up with caches with lots
+		 * of free pages...  kmem_shrink_slab moves free the
+		 * slab and move the pages to the inactive clean list. 
+		 */
+		if (PageSlab(page)) {
+			pte_chain_unlock(page);
+			UnlockPage(page);
+			if (kmem_count_page(page) || !page->age) {
+				int pages = kmem_shrink_slab(page);
+				if (!pages) {
+					list_del(page_lru);
+					list_add(page_lru, &zone->active_list);
+				} else {
+					nr_freed += pages;
+					if (nr_deactivated+nr_freed > target)
+						goto done; 
+				}
+			}
+			continue;
+		}
+
+		/* 
 		 * If the page age is 'hot' and the process using the
 		 * page doesn't exceed its RSS limit we keep the page.
 		 * Otherwise we move it to the inactive_dirty list.
@@ -533,7 +570,7 @@
 			list_add(page_lru, &zone->active_list);
 		} else {
 			deactivate_page_nolock(page);
-			if (++nr_deactivated > target) {
+			if (++nr_deactivated+nr_freed > target) {
 				pte_chain_unlock(page);
 				UnlockPage(page);
 				goto done;
@@ -553,9 +590,10 @@
 done:
 	spin_unlock(&pagemap_lru_lock);
 
-	return nr_deactivated;
+	return nr_freed;
 }
 
+
 /**
  * refill_inactive - checks all zones and refills the inactive list as needed
  *
@@ -620,24 +658,15 @@
 
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
-	 */
-	refill_inactive();
-
-	/* 	
-	 * Reclaim unused slab cache memory.
+	 * Move pages from the active list to the inactive list,
+	 * then prune the prunable caches, aging them. 
 	 */
-	ret += kmem_cache_reap(gfp_mask);
+	ret += refill_inactive();
+	kmem_do_prunes(gfp_mask);
 
 	refill_freelist();
 
@@ -646,11 +675,13 @@
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
@@ -744,6 +775,7 @@
 
 			/* Do background page aging. */
 			background_aging(DEF_PRIORITY);
+			kmem_do_prunes(GFP_KSWAPD);
 		}
 
 		wakeup_memwaiters();

-----------------


