Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSEXL3O>; Fri, 24 May 2002 07:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317099AbSEXL3N>; Fri, 24 May 2002 07:29:13 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:17121 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317096AbSEXL3G>; Fri, 24 May 2002 07:29:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)
Date: Fri, 24 May 2002 07:28:45 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-mm@kvack.org
In-Reply-To: <200205180010.51382.tomlins@cam.org> <20020521144759.B1153@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205240728.45558.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 21, 2002 02:47 pm, Benjamin LaHaise wrote:
> On Sat, May 18, 2002 at 12:10:51AM -0400, Ed Tomlinson wrote:
> > I have never been happy with the way slab cache shrinking worked.  This
> > is an attempt to make it better.  Working with the rmap vm on pre7-ac2, I
> > have done the following.
>
> Thank you!  This is should help greatly with some of the vm imbalances by
> making slab reclaim part of the self tuning dynamics instead of hard coded
> magic numbers.  Do you have any plans to port this patch to 2.5 for
> inclusion? It would be useful to get testing in the 2.5 before merging in
> 2.4.

Here is an improved version of the patch for pre8-ac5.  

This moves things towards having the vm do the work of freeing the pages.
I do wonder if it worth the effort in that slab pages are a bit different from
other pages and get treated a little differently.  For instance, we sometimes
free slab pages in refill_inactive.  Without this the caches can grow and grow
without any possibility of shrinking when under low loads.  By allowing freeing
we avoid getting into a situation where slab pages cause an artificial shortage.

Finding a good method of handling the dcache/icache and dquota  caches has 
been fun...  What I do now is factor the pruning and shrinking into different 
calls.  The puning, in effect, ages entries in the above caches.  The rate I 
prune is simply the rate I see entries for these slabs in refill_inactive_zone.
This is seems fair and, in my testing, works better than anything else I have tried
(I have have experimented quite a bit).  It also avoid using any magic numbers 
and is self tuning.

The logic has also be improved to free specific slabs instead of just freeing <n>
freeable slabs when <n> were encountered by the vm.  Now we try to free the
slabs we encounter as we find them (see kmem_shrink_slab).

It works well on my UP box running pre8-ac5 without problems.  

Think this is ready for wider testing.   If any of you have test boxes that are having
vm problems, especially if they are slab related, it would be interesting to see if this
helps.

Comments, questions and feedback very welcome,

Ed Tomlinson


Summary of changes.

fs/buffer.c
	touch the object's page when a buffer head is looked up

fs/dcache.c
	prune_cache now ages <n> entries instead of freeing <n>
	shrink_dcache_memory becomes age_dcache_memory and is called from the vm
		using kmem_do_prunes.
	set the pruner call backs for the dcache and dqcache
	touch the object's page when a dentry is looked up

fs/dquot.c
	shrink_dqcache_memory becomes age_dqcache_memory and is called from the vm.
	touch the objects's page when a dquot is found

fs/inode.c
	touch the object's page when a inode is found
	prune_inodes now ages <n> inodes instead of freeing <n>.
	shrink_icache_memory becomes age_icache_memory and is called from the vm.
	set the pruner call back for the icache to age_icache_memory.

include/linux/slab.h
	add types, macros, and externs needed for the slab pages in lru scheme.    To
	rationalise includes, the externs for the age_<x>_memory calls move here from 
	dcache.h

mm/slab.c
	add pruner and count to kmem_cache_t and set them up when creating a cache
	add kmem_set_pruner to set the pruner call back
	add kmem_count_page to count the entries in a slab page in cachep->count
	add keme_do_prunes to call the pruner call backs to age the slab cache entries
	add and remove reapable slab pages to the lru
	add kmem_shrink_slab to remove a slab and free its memory if possible
	touch the page when allocating an entry in a slab

mm/vmscan.c
	bug if we hit a slab page in the wrong list
	handle slab pages in page_launder_zone.  We either free the slab, if we cannot and
		the slab's cache is growing we requeue it in the inactive list otherwise we 
		move the page to the active list.
	handle slab pages in refill_inactive_zone.  We count the entries on the page for 
		kmem_do_prunes which gets called later.   If the slab page is eligible to be
		moved to the inactive list, first try to free it, if this fails move it to the inactive 
		list.  refill_inactive_zone now returns the number of pages freed.
	in do_try_to_free_pages account for the pages freed by refill_inactive and call
		kmem_do_prunes to age the slab caches in lock step with the vm scanning.
		A last ditch kmem_cache_reap is left before we conclude we are oom.
	in kswapd call kmem_do_prunes after each background_aging call.

--------------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.406   -> 1.408  
#	         fs/buffer.c	1.66    -> 1.67   
#	         fs/dcache.c	1.19    -> 1.20   
#	          fs/dquot.c	1.18    -> 1.19   
#	         mm/vmscan.c	1.60    -> 1.62   
#	           mm/slab.c	1.16    -> 1.18   
#	include/linux/slab.h	1.8     -> 1.9    
#	include/linux/dcache.h	1.11    -> 1.12   
#	          fs/inode.c	1.36    -> 1.37   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/23	ed@oscar.et.ca	1.407
# age_pressure_v7.diff
# --------------------------------------------
# 02/05/23	ed@oscar.et.ca	1.408
# Fix the locking in vmscan for slab pages in lru.  Improve the comments
# too.
# --------------------------------------------
#
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu May 23 21:38:19 2002
+++ b/fs/buffer.c	Thu May 23 21:38:19 2002
@@ -951,8 +951,10 @@
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
--- a/fs/dcache.c	Thu May 23 21:38:19 2002
+++ b/fs/dcache.c	Thu May 23 21:38:19 2002
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
@@ -730,6 +720,7 @@
 		}
 		__dget_locked(dentry);
 		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		kmem_touch_page(dentry);
 		spin_unlock(&dcache_lock);
 		return dentry;
 	}
@@ -1186,6 +1177,8 @@
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 
+	kmem_set_pruner(dentry_cache, (pruner_t)age_dcache_memory);
+
 #if PAGE_SHIFT < 13
 	mempages >>= (13 - PAGE_SHIFT);
 #endif
@@ -1279,6 +1272,9 @@
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!dquot_cachep)
 		panic("Cannot create dquot SLAB cache");
+	
+	kmem_set_pruner(dquot_cachep, (pruner_t)age_dqcache_memory);
+	
 #endif
 
 	dcache_init(mempages);
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Thu May 23 21:38:19 2002
+++ b/fs/dquot.c	Thu May 23 21:38:19 2002
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
@@ -1148,6 +1151,7 @@
 #endif
 	dquot->dq_referenced++;
 	dqstats.lookups++;
+	kmem_touch_page(dquot);
 
 	return dquot;
 }
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu May 23 21:38:19 2002
+++ b/fs/inode.c	Thu May 23 21:38:19 2002
@@ -193,6 +193,7 @@
 
 static inline void __iget(struct inode * inode)
 {
+	kmem_touch_page(inode);
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
 		return;
@@ -672,10 +673,11 @@
 
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
@@ -690,8 +692,6 @@
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
-		if (!--goal)
-			break;
 	}
 	inodes_stat.nr_unused -= count;
 	spin_unlock(&inode_lock);
@@ -708,10 +708,8 @@
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
@@ -722,10 +720,11 @@
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
@@ -1172,6 +1171,8 @@
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
+
+	kmem_set_pruner(inode_cachep, (pruner_t)age_icache_memory);
 
 	unused_inodes_flush_task.routine = try_to_sync_unused_inodes;
 }
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Thu May 23 21:38:19 2002
+++ b/include/linux/dcache.h	Thu May 23 21:38:19 2002
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
--- a/include/linux/slab.h	Thu May 23 21:38:19 2002
+++ b/include/linux/slab.h	Thu May 23 21:38:19 2002
@@ -55,6 +55,26 @@
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+
+typedef int (*pruner_t)(kmem_cache_t *, int, int);
+
+extern void kmem_set_pruner(kmem_cache_t *, pruner_t);
+extern int kmem_do_prunes(int);
+extern void kmem_count_page(struct page *);
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
--- a/mm/slab.c	Thu May 23 21:38:19 2002
+++ b/mm/slab.c	Thu May 23 21:38:19 2002
@@ -212,6 +212,8 @@
 	kmem_cache_t		*slabp_cache;
 	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
+	pruner_t		pruner;	/* shrink callback */
+	int 			count;		/* count used to trigger shrink */
 
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
@@ -381,6 +383,51 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
 #endif
+ 
+/* set the prune call back function */
+void kmem_set_pruner(kmem_cache_t * cachep, pruner_t thepruner) 
+{
+	cachep->pruner = thepruner;
+}
+
+/* used by refill_inactive_zone to determine caches that need pruning */
+void kmem_count_page(struct page *page)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+	if (cachep->pruner != NULL)
+		cachep->count += (slabp->inuse >> cachep->gfporder);
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
+				int nr = (*cachep->pruner)(cachep, cachep->count, gfp_mask);
+				cachep->count = 0;
+#ifdef DEBUG
+				printk("pruned %-17s %d\n",cachep->name, nr); 
+#endif
+
+			}
+		}
+        }
+        up(&cache_chain_sem);
+	return ret;
+}
+
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void kmem_cache_estimate (unsigned long gfporder, size_t size,
@@ -513,6 +560,10 @@
 	 * vm_scan(). Shouldn't be a worry.
 	 */
 	while (i--) {
+		if (!(cachep->flags & SLAB_NO_REAP)) {
+			set_page_count(page, 0);
+			lru_cache_del(page);
+		}
 		PageClearSlab(page);
 		page++;
 	}
@@ -588,6 +639,34 @@
 		kmem_cache_free(cachep->slabp_cache, slabp);
 }
 
+/* 
+ * Used by page_launder_zone and refill_inactive_zone to 
+ * try to shrink a slab.  There are three possible results:
+ * - shrink works and we return the pages shrunk
+ * - shrink fails due to a growing cache, we return 0
+ * - shrink fails because the slab is in use, we return 0
+ *   and set the page reference bit.
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
+	} else 
+		SetPageReferenced(page);
+	spin_unlock_irq(cachep->spinlock);
+	return 0; 
+}
+
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -780,6 +859,8 @@
 		flags |= CFLGS_OPTIMIZE;
 
 	cachep->flags = flags;
+	cachep->pruner = NULL;
+	cachep->count = 0;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
@@ -1174,6 +1255,10 @@
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
 		PageSetSlab(page);
+		if (!(cachep->flags & SLAB_NO_REAP)) {
+			set_page_count(page, 1);
+			lru_cache_add(page);
+		}
 		page++;
 	} while (--i);
 
@@ -1255,6 +1340,7 @@
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
 	}
+	kmem_touch_page(objp);
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
 		if (kmem_check_poison_obj(cachep, objp))
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu May 23 21:38:19 2002
+++ b/mm/vmscan.c	Thu May 23 21:38:19 2002
@@ -102,6 +102,9 @@
 			continue;
 		}
 
+		if (PageSlab(page))
+			BUG();
+
 		/* Page is being freed */
 		if (unlikely(page_count(page)) == 0) {
 			list_del(page_lru);
@@ -270,7 +273,8 @@
 		 * the active list and adjust the page age if needed.
 		 */
 		pte_chain_lock(page);
-		if (page_referenced(page) && page_mapping_inuse(page) &&
+		if (page_referenced(page) &&
+				(page_mapping_inuse(page) || PageSlab(page)) &&
 				!page_over_rsslimit(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
@@ -282,6 +286,25 @@
 		pte_chain_unlock(page);
 
 		/*
+		 * These pages are 'naked' - we do not want any other tests
+		 * done on them...  If kmem_shrink_slab finds the slab has
+		 * entries it will return 0 and set the page_refenence bit, 
+		 * in this case we want to activate the page.
+		 */
+		if (PageSlab(page)) {
+			int pages;
+			UnlockPage(page);
+			pages = kmem_shrink_slab(page);
+			if (!pages && PageTestandClearReferenced(page)) {
+	                        del_page_from_inactive_dirty_list(page);
+				add_page_to_active_list(page);
+				page->age = max((int)page->age, PAGE_AGE_START);
+			} else
+				cleaned_pages += pages;
+			continue;
+		}
+
+		/*
 		 * Anonymous process memory without backing store. Try to
 		 * allocate it some swap space here.
 		 *
@@ -470,12 +493,14 @@
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
@@ -507,7 +532,7 @@
 		 * both PG_locked and the pte_chain_lock are held.
 		 */
 		pte_chain_lock(page);
-		if (!page_mapping_inuse(page)) {
+		if (!page_mapping_inuse(page) && !PageSlab(page)) {
 			pte_chain_unlock(page);
 			UnlockPage(page);
 			drop_page(page);
@@ -524,14 +549,32 @@
 		}
 
 		/* 
+		 * Count the entries on the page for pruning caches.
+		 */
+		if (PageSlab(page))
+			kmem_count_page(page);
+
+		/* 
 		 * If the page age is 'hot' and the process using the
 		 * page doesn't exceed its RSS limit we keep the page.
-		 * Otherwise we move it to the inactive_dirty list.
+		 * Otherwise we move it to the inactive_dirty list.  
+		 * For slab pages if its not a hot page, we try to 
+		 * free it, failing it goes to the inactive_dirty list. 
 		 */
 		if (page->age && !page_over_rsslimit(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &zone->active_list);
 		} else {
+			if (PageSlab(page)) {
+				int pages = kmem_shrink_slab(page); 
+				if (pages) { 
+					nr_freed += pages;
+					pte_chain_unlock(page);
+					UnlockPage(page);
+					continue;
+				} else
+					ClearPageReferenced(page);
+			}		
 			deactivate_page_nolock(page);
 			if (++nr_deactivated > target) {
 				pte_chain_unlock(page);
@@ -553,9 +596,10 @@
 done:
 	spin_unlock(&pagemap_lru_lock);
 
-	return nr_deactivated;
+	return nr_freed;
 }
 
+
 /**
  * refill_inactive - checks all zones and refills the inactive list as needed
  *
@@ -620,24 +664,16 @@
 
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
+	 * Move pages from the active list to the inactive list and 
+	 * return pages gained by shrink.  Then prune caches to age
+	 * them. 
 	 */
-	ret += kmem_cache_reap(gfp_mask);
+	ret += refill_inactive();
+	kmem_do_prunes(gfp_mask);
 
 	refill_freelist();
 
@@ -646,11 +682,14 @@
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
@@ -744,6 +783,7 @@
 
 			/* Do background page aging. */
 			background_aging(DEF_PRIORITY);
+			kmem_do_prunes(GFP_KSWAPD);
 		}
 
 		wakeup_memwaiters();

--------------
