Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316657AbSERELU>; Sat, 18 May 2002 00:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSERELU>; Sat, 18 May 2002 00:11:20 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:57590 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316657AbSERELP>; Sat, 18 May 2002 00:11:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] using page aging to shrink caches
Date: Sat, 18 May 2002 00:10:51 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-mm@kvack.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205180010.51382.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have never been happy with the way slab cache shrinking worked.  This is an
attempt to make it better.  Working with the rmap vm on pre7-ac2, I have done
the following.

1. Moved reapable slab pages on to the active and inactive dirty lists.
2. When slab pages enter the inactive dirty list I count the number of pages
    seen on a per cache basis.
3. If slab pages manage to reach the front of the inactive dirty list I count
    the pages seen on a per cache basis.
4. After inactive_refill/inactive_refill_zone calls I scan the slab caches and,
    via a callback, shrink the caches using the number of pages from 3 & 4
    as a goal for each cache.
5. kmem_cache_reap is called as a last ditch effort before declaring a oom.
6. Since slab pages are kernel map via 8M pages on i386, the hardware 
    page reference bit is fairly much useless.  When a slab is created it pages
    are marked as referenced.  I also mark pages in the lookup/get functions
    for inodes, dentries, dquota and buffer_heads.

A few comments.

#1 avoids the need to create mappings for the slab pages by intercepting them
in page_launder_zone and refill_inactive_zone before we start really playing
with the pages.

#2 was done to avoid having 500,000 plus dentry/inodes on a lightly loaded
system.  Seems with low vm pressure rmap can supply enough free pages via
background aging.  This process avoids page_launder but does call refill_inactive...

#4 uses ends up using kmem_cache_shrink_nr to shrink caches.  For the 
caches that require pruning this call gets wraped.  The calling sequence
for icache, dcache and dquoto shrinking now only prunes when it cannot
get enought pages via a simple shrink.

Comments?
Ed Tomlinson

PS.  I may not see replies until Tuesday.

-----------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.422   -> 1.432  
#	         fs/buffer.c	1.63    -> 1.64   
#	         fs/dcache.c	1.18    -> 1.24   
#	          fs/dquot.c	1.18    -> 1.22   
#	         mm/vmscan.c	1.60    -> 1.68   
#	include/linux/slab.h	1.9     -> 1.14   
#	include/linux/dcache.h	1.11    -> 1.14   
#	           mm/slab.c	1.16    -> 1.22   
#	          fs/inode.c	1.35    -> 1.41   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/10	ed@oscar.et.ca	1.423
# Use the vm's page aging to tell us when we need to shrink the caches.
# The vm uses callbacks to tell the slabs caches its time to shrink.
# --------------------------------------------
# 02/05/10	ed@oscar.et.ca	1.424
# Change the way process_shrinks is called so refill_invalid does not
# need to be changed.
# --------------------------------------------
# 02/05/11	ed@oscar.et.ca	1.426
# Simplify the scheme.  Use per cache callbacks instead of per family.
# This lets us target specific caches instead of being generic.  We
# still include a generic call (kmem_cache_reap) as a failsafe
# before ooming.
# --------------------------------------------
# 02/05/11	ed@oscar.et.ca	1.428
# Change factoring, removing changes from background_aging and putting
# the kmem_call_shrinkers call in kswapd.
# --------------------------------------------
# 02/05/11	ed@oscar.et.ca	1.429
# Base the number of pages a cache is shrunk on the number of pages the
# vm sees in refill_inactive_zone instead of on a magic priority.
# --------------------------------------------
# 02/05/12	ed@oscar.et.ca	1.430
# improve shrink methods for dcache, dquota and icache
# --------------------------------------------
# 02/05/12	ed@oscar.et.ca	1.428.1.1
# The icache is a slave of the dcache.  We will not reuse the inodes so
# lets clean them all.
# --------------------------------------------
# 02/05/12	ed@oscar.et.ca	1.428.1.2
# Only call shrink callback if we have seen a slab's worth of pages
# --------------------------------------------
# 02/05/13	ed@oscar.et.ca	1.428.1.3
# Andrew Morton pointed out that kernal pages are big (8M) and the 
# hardware reference bit is working with these big pages.  This makes 
# aging slabs on 4K pages a little more difficult.  Andrew suggested 
# hooking into the kmem_cache_alloc process and set the bit(s) there.  
# This changeset does this.
# --------------------------------------------
# 02/05/16	ed@oscar.et.ca	1.428.1.6
# Improve aging for dcache, inode and dquota pages by setting the ref
# bits in the various lookup/get code.
# --------------------------------------------
# 02/05/16	ed@oscar.et.ca	1.428.1.7
# Add another kmem_touch_page in getblk for buffer_heads.  Convert
# kmem_touch_page to a macro.
# --------------------------------------------
# 02/05/17	ed@oscar.et.ca	1.432
# Use the number of slab pages that enter or are requeued in the 
# inactive dirty list as the goal for the number of pages to shrink 
# a slab cache.  Each cache can have its own shrink callback, though
# only caches that need 'pruning' require specialized functions.
# --------------------------------------------
#
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri May 17 23:36:37 2002
+++ b/fs/buffer.c	Fri May 17 23:36:37 2002
@@ -1059,8 +1059,10 @@
 		struct buffer_head * bh;
 
 		bh = get_hash_table(dev, block, size);
-		if (bh)
+		if (bh) {
+			kmem_touch_page(bh);
 			return bh;
+		}
 
 		if (!grow_buffers(dev, block, size))
 			free_more_memory();
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri May 17 23:36:37 2002
+++ b/fs/dcache.c	Fri May 17 23:36:37 2002
@@ -538,18 +538,11 @@
 
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
+int shrink_dcache_memory(kmem_cache_t *cachep, int pages, int priority, int gfp_mask)
 {
-	int count = 0;
+	int count = kmem_cache_shrink_nr(cachep, pages);
 
 	/*
 	 * Nasty deadlock avoidance.
@@ -563,12 +556,13 @@
 	 * block allocations, but for now:
 	 */
 	if (!(gfp_mask & __GFP_FS))
-		return 0;
+		return count;
 
-	count = dentry_stat.nr_unused / priority;
-
-	prune_dcache(count);
-	return kmem_cache_shrink_nr(dentry_cache);
+	if (count < pages) {
+		prune_dcache(dentry_stat.nr_unused/priority);
+		count += kmem_cache_shrink_nr(cachep, pages-count);
+	}
+	return count;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
@@ -730,6 +724,7 @@
 		}
 		__dget_locked(dentry);
 		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		kmem_touch_page(dentry);
 		spin_unlock(&dcache_lock);
 		return dentry;
 	}
@@ -1186,6 +1181,8 @@
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 
+	kmem_set_shrinker(dentry_cache, (shrinker_t)shrink_dcache_memory);
+
 #if PAGE_SHIFT < 13
 	mempages >>= (13 - PAGE_SHIFT);
 #endif
@@ -1278,6 +1275,9 @@
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!dquot_cachep)
 		panic("Cannot create dquot SLAB cache");
+	
+	kmem_set_shrinker(dquot_cachep, (shrinker_t)shrink_dqcache_memory);
+	
 #endif
 
 	dcache_init(mempages);
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Fri May 17 23:36:37 2002
+++ b/fs/dquot.c	Fri May 17 23:36:37 2002
@@ -1024,12 +1024,17 @@
 	}
 }
 
-int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
+int shrink_dqcache_memory(kmem_cache_t *cachep, int pages, int priority, unsigned int gfp_mask)
 {
-	lock_kernel();
-	prune_dqcache(nr_free_dquots / (priority + 1));
-	unlock_kernel();
-	return kmem_cache_shrink_nr(dquot_cachep);
+	int count = kmem_cache_shrink_nr(cachep, pages);
+
+	if (count < pages) {
+		lock_kernel();
+		prune_dqcache(nr_free_dquots);
+		unlock_kernel();
+		count += kmem_cache_shrink_nr(cachep, pages-count);
+	}
+	return count;
 }
 
 /*
@@ -1148,6 +1153,7 @@
 #endif
 	dquot->dq_referenced++;
 	dqstats.lookups++;
+	kmem_touch_page(dquot);
 
 	return dquot;
 }
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri May 17 23:36:37 2002
+++ b/fs/inode.c	Fri May 17 23:36:37 2002
@@ -193,6 +193,7 @@
 
 static inline void __iget(struct inode * inode)
 {
+	kmem_touch_page(inode);
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
@@ -708,9 +709,9 @@
 		schedule_task(&unused_inodes_flush_task);
 }
 
-int shrink_icache_memory(int priority, int gfp_mask)
+int shrink_icache_memory(kmem_cache_t *cachep, int pages, int priority, int gfp_mask)
 {
-	int count = 0;
+	int count = kmem_cache_shrink_nr(cachep, pages);
 
 	/*
 	 * Nasty deadlock avoidance..
@@ -720,12 +721,13 @@
 	 * in clear_inode() and friends..
 	 */
 	if (!(gfp_mask & __GFP_FS))
-		return 0;
+		return count;
 
-	count = inodes_stat.nr_unused / priority;
-
-	prune_icache(count);
-	return kmem_cache_shrink_nr(inode_cachep);
+	if (count < pages) {
+		prune_icache(inodes_stat.nr_unused);
+		count += kmem_cache_shrink_nr(cachep, pages-count);
+	}
+	return count;
 }
 
 /*
@@ -1172,6 +1174,8 @@
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
+
+	kmem_set_shrinker(inode_cachep, (shrinker_t)shrink_icache_memory);
 
 	unused_inodes_flush_task.routine = try_to_sync_unused_inodes;
 }
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Fri May 17 23:36:37 2002
+++ b/include/linux/dcache.h	Fri May 17 23:36:37 2002
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
--- a/include/linux/slab.h	Fri May 17 23:36:37 2002
+++ b/include/linux/slab.h	Fri May 17 23:36:37 2002
@@ -55,7 +55,27 @@
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
-extern int kmem_cache_shrink_nr(kmem_cache_t *);
+
+typedef int (*shrinker_t)(kmem_cache_t *, int, int, int);
+
+extern void kmem_set_shrinker(kmem_cache_t *, shrinker_t);
+extern int kmem_call_shrinkers(int, int);
+extern void kmem_count_page(struct page *);
+#define kmem_touch_page(addr) 		SetPageReferenced(virt_to_page(addr));
+
+/* shrink drivers */
+extern int kmem_shrink_pages(kmem_cache_t *, int, int, int);
+
+/* dcache shrinker ( defined in linux/fs/dcache.c) */
+extern int shrink_dcache_memory(kmem_cache_t *, int, int, int);
+
+/* icache shrinker (defined in linux/fs/inode.c) */
+extern int shrink_icache_memory(kmem_cache_t *, int, int, int);
+
+/* quota cache shrinker (defined in linux/fs/dquot.c) */
+extern int shrink_dqcache_memory(kmem_cache_t *, int, int, int);
+
+extern int kmem_cache_shrink_nr(kmem_cache_t *, int);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Fri May 17 23:36:37 2002
+++ b/mm/slab.c	Fri May 17 23:36:37 2002
@@ -213,6 +213,8 @@
 	kmem_cache_t		*slabp_cache;
 	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
+	shrinker_t		shrinker;	/* shrink callback */
+	int 			count;		/* count used to trigger shrink */
 
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
@@ -382,6 +384,54 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
 #endif
+ 
+/* set the shrink call back function */
+void kmem_set_shrinker(kmem_cache_t * cachep, shrinker_t theshrinker) 
+{
+	cachep->shrinker = theshrinker;
+}
+
+/* used by refill_inactive_zone to determine caches that need shrinking */
+void kmem_count_page(struct page *page)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	cachep->count++;
+}
+
+/* call the shrink functions */
+int kmem_call_shrinkers(int priority, int gfp_mask) 
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
+		int pgs = (1<<cachep->gfporder);
+		if (cachep->count >= pgs) {
+			if (cachep->shrinker == NULL)
+				BUG();
+			pgs = pgs*(cachep->count+pgs-1)/pgs;
+			ret += (*cachep->shrinker)(cachep, pgs, priority, gfp_mask);
+			cachep->count = 0;
+		}		
+        }
+        up(&cache_chain_sem);
+	return ret;
+}
+
+
+/* Default shrink method - try to shrink the pages requested  */
+int kmem_shrink_pages(kmem_cache_t * cachep, int pages, int priority, int gfp_mask) 
+{
+	return kmem_cache_shrink_nr(cachep, pages);
+}
+
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void kmem_cache_estimate (unsigned long gfporder, size_t size,
@@ -514,12 +564,31 @@
 	 * vm_scan(). Shouldn't be a worry.
 	 */
 	while (i--) {
+		if (!(cachep->flags & SLAB_NO_REAP))
+			lru_cache_del(page);
 		PageClearSlab(page);
 		page++;
 	}
 	free_pages((unsigned long)addr, cachep->gfporder);
 }
 
+/*
+ * kernel pages are 8M so 4k page ref bit is not set - we need to
+ * do it manually...
+ */
+void kmem_set_referenced(kmem_cache_t *cachep, slab_t *slabp)
+{
+        if (!(cachep->flags & SLAB_NO_REAP)) {
+        	unsigned long i = (1<<cachep->gfporder);
+        	struct page *page = virt_to_page(slabp->s_mem-slabp->colouroff);
+        	while (i--) {
+			SetPageReferenced(page);
+                	page++;
+		}
+        }
+}
+
+
 #if DEBUG
 static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
 {
@@ -781,6 +850,8 @@
 		flags |= CFLGS_OPTIMIZE;
 
 	cachep->flags = flags;
+	cachep->shrinker = ( shrinker_t)(kmem_shrink_pages);
+	cachep->count = 0;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
@@ -912,8 +983,9 @@
 
 /**
  * Called with the &cachep->spinlock held, returns number of slabs released
+ * Use 0 to release all the slabs we can.
  */
-static int __kmem_cache_shrink_locked(kmem_cache_t *cachep)
+static int __kmem_cache_shrink_locked(kmem_cache_t *cachep, int slabs)
 {
         slab_t *slabp;
         int ret = 0;
@@ -935,8 +1007,10 @@
 
                 spin_unlock_irq(&cachep->spinlock);
                 kmem_slab_destroy(cachep, slabp);
-		ret++;
                 spin_lock_irq(&cachep->spinlock);
+
+		if (++ret == slabs)
+			break;
         }
         return ret;
 }
@@ -948,7 +1022,7 @@
 	drain_cpu_caches(cachep);
 
 	spin_lock_irq(&cachep->spinlock);
-	__kmem_cache_shrink_locked(cachep);
+	__kmem_cache_shrink_locked(cachep, 0);
 	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
@@ -972,7 +1046,7 @@
 /**
  * kmem_cache_shrink_nr - Shrink a cache returning pages released
  */
-int kmem_cache_shrink_nr(kmem_cache_t *cachep)
+int kmem_cache_shrink_nr(kmem_cache_t *cachep, int pages)
 {
         int ret;
 
@@ -982,7 +1056,7 @@
 	drain_cpu_caches(cachep);
 
 	spin_lock_irq(&cachep->spinlock);
-	ret = __kmem_cache_shrink_locked(cachep);
+	ret = __kmem_cache_shrink_locked(cachep, pages>>cachep->gfporder);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret<<(cachep->gfporder);
 }
@@ -1184,6 +1258,8 @@
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
 		PageSetSlab(page);
+		if (!(cachep->flags & SLAB_NO_REAP))
+			lru_cache_add(page);
 		page++;
 	} while (--i);
 
@@ -1265,6 +1341,7 @@
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
 	}
+	kmem_set_referenced(cachep, slabp);
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
 		if (kmem_check_poison_obj(cachep, objp))
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri May 17 23:36:37 2002
+++ b/mm/vmscan.c	Fri May 17 23:36:37 2002
@@ -102,6 +102,9 @@
 			continue;
 		}
 
+		if (PageSlab(page))
+			BUG();
+
 		/* Page is being freed */
 		if (unlikely(page_count(page)) == 0) {
 			list_del(page_lru);
@@ -244,7 +247,8 @@
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list and adjust the page age if needed.
 		 */
-		if (page_referenced(page) && page_mapping_inuse(page) &&
+		if (page_referenced(page) &&
+				(page_mapping_inuse(page) || PageSlab(page)) &&
 				!page_over_rsslimit(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
@@ -253,6 +257,15 @@
 		}
 
 		/*
+		 * These pages are 'naked' - we do not want any other tests
+		 * done on them...
+		 */
+		if (PageSlab(page)) {
+			kmem_count_page(page);
+			continue;
+		}
+
+		/*
 		 * Page is being freed, don't worry about it.
 		 */
 		if (unlikely(page_count(page)) == 0)
@@ -446,6 +459,7 @@
  * This function will scan a portion of the active list of a zone to find
  * unused pages, those pages will then be moved to the inactive list.
  */
+
 int refill_inactive_zone(struct zone_struct * zone, int priority)
 {
 	int maxscan = zone->active_pages >> priority;
@@ -473,7 +487,7 @@
 		 * bother with page aging.  If the page is touched again
 		 * while on the inactive_clean list it'll be reactivated.
 		 */
-		if (!page_mapping_inuse(page)) {
+		if (!page_mapping_inuse(page) && !PageSlab(page)) {
 			drop_page(page);
 			continue;
 		}
@@ -497,8 +511,12 @@
 			list_add(page_lru, &zone->active_list);
 		} else {
 			deactivate_page_nolock(page);
-			if (++nr_deactivated > target)
+			if (PageSlab(page))
+				kmem_count_page(page);
+			else {
+				if (++nr_deactivated > target)
 				break;
+			}
 		}
 
 		/* Low latency reschedule point */
@@ -513,6 +531,7 @@
 	return nr_deactivated;
 }
 
+
 /**
  * refill_inactive - checks all zones and refills the inactive list as needed
  *
@@ -577,24 +596,15 @@
 
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
+	 * Move pages from the active list to the inactive list and
+	 * shrink caches return pages gained by shrink
 	 */
 	refill_inactive();
-
-	/* 	
-	 * Reclaim unused slab cache memory.
-	 */
-	ret += kmem_cache_reap(gfp_mask);
+	ret += kmem_call_shrinkers(DEF_PRIORITY, gfp_mask);
 
 	refill_freelist();
 
@@ -603,11 +613,14 @@
 		run_task_queue(&tq_disk);
 
 	/*
-	 * Hmm.. Cache shrink failed - time to kill something?
+	 * Hmm.. - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
 	 */
-	if (!ret && free_min(ANY_ZONE) > 0)
-		out_of_memory();
+	if (!ret && free_min(ANY_ZONE) > 0) {
+		ret += kmem_cache_reap(gfp_mask);
+		if (!ret)
+			out_of_memory();
+	}
 
 	return ret;
 }
@@ -700,6 +713,7 @@
 
 			/* Do background page aging. */
 			background_aging(DEF_PRIORITY);
+			kmem_call_shrinkers(DEF_PRIORITY, GFP_KSWAPD);
 		}
 
 		wakeup_memwaiters();

-----------
