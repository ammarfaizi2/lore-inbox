Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSJJGvW>; Thu, 10 Oct 2002 02:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSJJGvW>; Thu, 10 Oct 2002 02:51:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:13475 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263256AbSJJGvP>;
	Thu, 10 Oct 2002 02:51:15 -0400
Message-ID: <3DA524B4.230C2011@digeo.com>
Date: Wed, 09 Oct 2002 23:56:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Ed Tomlinson <tomlins@cam.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
References: <E17yymB-00021j-00@think.thunk.org> <20021008191900.A12912@infradead.org> <3DA32623.C1126CF1@digeo.com> <200210082047.04594.agruen@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 06:56:52.0574 (UTC) FILETIME=[3689E7E0:01C2702A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> 
> Switching to Ed's code once it's in the kernel may be worthwhile; until then
> the dumb shrinking approaah doesn't to do much harm IMHO.

I've done another round on Ed's registration and shrinking
API.  Here's what we have.  The reiserfs team need the shrinker
registration API as well.

(Some of the below code still has wet paint ;))





>From Ed Tomlinson, then mauled by yours truly.

The current shrinking of the dentry, inode and dquot caches seems to
work OK, but it is slightly CPU-inefficient: we call the shrinking
functions many times, for tiny numbers of objects.

So here, we just batch that up - shrinking happens at the same rate but
we perform it in larger units of work.

To do this, we need a way of knowing how many objects are currently in
use by individual caches.  slab does not actually track this
information, but the existing shrinkable caches do have this on hand. 
So rather than adding the counters to slab, we require that the
shrinker callback functions keep their own count - we query that via
the callback.

We add a simple registration API which is exported to modules.  A
subsystem may register its own callback function via set_shrinker().

set_shrinker() simply takes a function pointer.  The function is called
with

	int (*shrinker)(int nr_to_shrink, unsigned int gfp_mask);

The shrinker callback must scan `nr_to_scan' objects and free all
freeable scanned objects.  Note: it doesn't have to *free* `nr_to_scan'
objects.  It need only scan that many.  Which is a fairly pedantic
detail, really.

The shrinker callback must return the number of objects which are in
its cache at the end of the scanning attempt.  It will be called with
nr_to_scan == 0 when we're just querying the cache size.

The set_shrinker() registration API is passed a hint as to how many
disk seeks a single cache object is worth.  Everything uses "2" at
present.


- shrink_icache_memory() is no longer exported to modules.

- shrink_icache_memory() is now static to fs/inode.c

- prune_icache() is now static to fs/inode.c, and made inline (single caller)

- shrink_dcache_memory() is made static to fs/dcache.c

- prune_dcache() is no longer exported to modules

- prune_dcache() is made static to fs/dcache.c

- shrink_dqcache_memory() is made static to fs/dquot.c

- All the quota init code has been moved from fs/dcache.c into fs/dquot.c

- All modifications to inodes_stat.nr_inodes are now inside
  inode_lock - the dispose_list one was racy.




 fs/dcache.c            |   50 ++++++++------------
 fs/dquot.c             |   28 ++++++++---
 fs/inode.c             |   49 ++++++++++----------
 include/linux/dcache.h |   11 ----
 include/linux/mm.h     |   23 +++++++++
 kernel/ksyms.c         |    3 -
 mm/vmscan.c            |  119 ++++++++++++++++++++++++++++++++++++-------------
 7 files changed, 179 insertions(+), 104 deletions(-)

--- 2.5.41/fs/dcache.c~batched-slab-asap	Wed Oct  9 22:59:10 2002
+++ 2.5.41-akpm/fs/dcache.c	Wed Oct  9 23:13:04 2002
@@ -328,7 +328,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-void prune_dcache(int count)
+static void prune_dcache(int count)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
@@ -572,25 +572,24 @@ void shrink_dcache_anon(struct list_head
  * This is called from kswapd when we think we need some
  * more memory. 
  */
-int shrink_dcache_memory(int ratio, unsigned int gfp_mask)
+static int shrink_dcache_memory(int nr, unsigned int gfp_mask)
 {
-	int entries = dentry_stat.nr_dentry / ratio + 1;
-	/*
-	 * Nasty deadlock avoidance.
-	 *
-	 * ext2_new_block->getblk->GFP->shrink_dcache_memory->prune_dcache->
-	 * prune_one_dentry->dput->dentry_iput->iput->inode->i_sb->s_op->
-	 * put_inode->ext2_discard_prealloc->ext2_free_blocks->lock_super->
-	 * DEADLOCK.
-	 *
-	 * We should make sure we don't hold the superblock lock over
-	 * block allocations, but for now:
-	 */
-	if (!(gfp_mask & __GFP_FS))
-		return 0;
-
-	prune_dcache(entries);
-	return entries;
+	if (nr) {
+		/*
+		 * Nasty deadlock avoidance.
+		 *
+	 	 * ext2_new_block->getblk->GFP->shrink_dcache_memory->
+		 * prune_dcache->prune_one_dentry->dput->dentry_iput->iput->
+		 * inode->i_sb->s_op->put_inode->ext2_discard_prealloc->
+		 * ext2_free_blocks->lock_super->DEADLOCK.
+	 	 *
+	 	 * We should make sure we don't hold the superblock lock over
+	 	 * block allocations, but for now:
+		 */
+		if (gfp_mask & __GFP_FS)
+			prune_dcache(nr);
+	}
+	return dentry_stat.nr_dentry;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
@@ -1330,6 +1329,8 @@ static void __init dcache_init(unsigned 
 					 NULL, NULL);
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
+	
+	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
 #if PAGE_SHIFT < 13
 	mempages >>= (13 - PAGE_SHIFT);
@@ -1375,9 +1376,6 @@ kmem_cache_t *names_cachep;
 /* SLAB cache for file structures */
 kmem_cache_t *filp_cachep;
 
-/* SLAB cache for dquot structures */
-kmem_cache_t *dquot_cachep;
-
 EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
@@ -1397,14 +1395,6 @@ void __init vfs_caches_init(unsigned lon
 	if(!filp_cachep)
 		panic("Cannot create filp SLAB cache");
 
-#if defined (CONFIG_QUOTA)
-	dquot_cachep = kmem_cache_create("dquot", 
-			sizeof(struct dquot), sizeof(unsigned long) * 4,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
-	if (!dquot_cachep)
-		panic("Cannot create dquot SLAB cache");
-#endif
-
 	dcache_init(mempages);
 	inode_init(mempages);
 	files_init(mempages); 
--- 2.5.41/fs/dquot.c~batched-slab-asap	Wed Oct  9 22:59:10 2002
+++ 2.5.41-akpm/fs/dquot.c	Wed Oct  9 23:14:10 2002
@@ -55,6 +55,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -481,14 +482,14 @@ static void prune_dqcache(int count)
  * more memory
  */
 
-int shrink_dqcache_memory(int ratio, unsigned int gfp_mask)
+static int shrink_dqcache_memory(int nr, unsigned int gfp_mask)
 {
-	int entries = dqstats.allocated_dquots / ratio + 1;
-
-	lock_kernel();
-	prune_dqcache(entries);
-	unlock_kernel();
-	return entries;
+	if (nr) {
+		lock_kernel();
+		prune_dqcache(nr);
+		unlock_kernel();
+	}
+	return dqstats.allocated_dquots;
 }
 
 /*
@@ -1490,6 +1491,9 @@ static ctl_table sys_table[] = {
 	{},
 };
 
+/* SLAB cache for dquot structures */
+kmem_cache_t *dquot_cachep;
+
 static int __init dquot_init(void)
 {
 	int i;
@@ -1499,9 +1503,17 @@ static int __init dquot_init(void)
 		INIT_LIST_HEAD(dquot_hash + i);
 	printk(KERN_NOTICE "VFS: Disk quotas v%s\n", __DQUOT_VERSION__);
 
+	dquot_cachep = kmem_cache_create("dquot", 
+			sizeof(struct dquot), sizeof(unsigned long) * 4,
+			SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!dquot_cachep)
+		panic("Cannot create dquot SLAB cache");
+
+	set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+
 	return 0;
 }
-__initcall(dquot_init);
+module_init(dquot_init);
 
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
--- 2.5.41/fs/inode.c~batched-slab-asap	Wed Oct  9 22:59:10 2002
+++ 2.5.41-akpm/fs/inode.c	Wed Oct  9 23:27:19 2002
@@ -243,22 +243,25 @@ void clear_inode(struct inode *inode)
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
-static void dispose_list(struct list_head * head)
+static void dispose_list(struct list_head *head)
 {
-	struct list_head * inode_entry;
-	struct inode * inode;
+	int nr_disposed = 0;
+
+	while (!list_empty(head)) {
+		struct inode *inode;
 
-	while ((inode_entry = head->next) != head)
-	{
-		list_del(inode_entry);
+		inode = list_entry(head->next, struct inode, i_list);
+		list_del(&inode->i_list);
 
-		inode = list_entry(inode_entry, struct inode, i_list);
 		if (inode->i_data.nrpages)
 			truncate_inode_pages(&inode->i_data, 0);
 		clear_inode(inode);
 		destroy_inode(inode);
-		inodes_stat.nr_inodes--;
+		nr_disposed++;
 	}
+	spin_lock(&inode_lock);
+	inodes_stat.nr_inodes -= nr_disposed;
+	spin_unlock(&inode_lock);
 }
 
 /*
@@ -377,7 +380,7 @@ int invalidate_device(kdev_t dev, int do
 	 !inode_has_buffers(inode))
 #define INODE(entry)	(list_entry(entry, struct inode, i_list))
 
-void prune_icache(int goal)
+static inline void prune_icache(int goal)
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
@@ -417,23 +420,19 @@ void prune_icache(int goal)
  * This is called from kswapd when we think we need some
  * more memory. 
  */
-int shrink_icache_memory(int ratio, unsigned int gfp_mask)
+static int shrink_icache_memory(int nr, unsigned int gfp_mask)
 {
-	int entries = inodes_stat.nr_inodes / ratio + 1;
-	/*
-	 * Nasty deadlock avoidance..
-	 *
-	 * We may hold various FS locks, and we don't
-	 * want to recurse into the FS that called us
-	 * in clear_inode() and friends..
-	 */
-	if (!(gfp_mask & __GFP_FS))
-		return 0;
-
-	prune_icache(entries);
-	return entries;
+	if (nr) {
+		/*
+		 * Nasty deadlock avoidance.  We may hold various FS locks,
+		 * and we don't want to recurse into the FS that called us
+		 * in clear_inode() and friends..
+	 	 */
+		if (gfp_mask & __GFP_FS)
+			prune_icache(nr);
+	}
+	return inodes_stat.nr_inodes;
 }
-EXPORT_SYMBOL(shrink_icache_memory);
 
 /*
  * Called with the inode lock held.
@@ -1096,4 +1095,6 @@ void __init inode_init(unsigned long mem
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
+
+	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 }
--- 2.5.41/include/linux/mm.h~batched-slab-asap	Wed Oct  9 22:59:10 2002
+++ 2.5.41-akpm/include/linux/mm.h	Wed Oct  9 22:59:10 2002
@@ -392,6 +392,29 @@ extern	int free_hugepages(struct vm_area
 
 
 /*
+ * Prototype to add a shrinker callback for ageable caches.
+ * 
+ * These functions are passed a count `nr_to_scan' and a gfpmask.  They should
+ * scan `nr_to_scan' objects, attempting to free them.
+ *
+ * The callback must the number of objects which remain in the cache.
+ *
+ * The callback will be passes nr_to_scan == 0 when the VM is querying the
+ * cache size, so a fastpath for that case is appropriate.
+ */
+typedef int (*shrinker_t)(int nr_to_scan, unsigned int gfp_mask);
+
+/*
+ * Add an aging callback.  The int is the number of 'seeks' it takes
+ * to recreate one of the objects that these functions age.
+ */
+
+#define DEFAULT_SEEKS 2
+struct shrinker;
+extern struct shrinker *set_shrinker(int, shrinker_t);
+extern void remove_shrinker(struct shrinker *shrinker);
+
+/*
  * If the mapping doesn't provide a set_page_dirty a_op, then
  * just fall through and assume that it wants buffer_heads.
  * FIXME: make the method unconditional.
--- 2.5.41/mm/vmscan.c~batched-slab-asap	Wed Oct  9 22:59:10 2002
+++ 2.5.41-akpm/mm/vmscan.c	Wed Oct  9 22:59:10 2002
@@ -77,9 +77,94 @@ static long total_memory;
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
-#ifndef CONFIG_QUOTA
-#define shrink_dqcache_memory(ratio, gfp_mask) do { } while (0)
-#endif
+/*
+ * The list of shrinker callbacks used by to apply pressure to
+ * ageable caches.
+ */
+struct shrinker {
+	shrinker_t		shrinker;
+	struct list_head	list;
+	int			seeks;	/* seeks to recreate an obj */
+	int			nr;	/* objs pending delete */
+};
+
+static LIST_HEAD(shrinker_list);
+static DECLARE_MUTEX(shrinker_sem);
+
+/*
+ * Add a shrinker callback to be called from the vm
+ */
+struct shrinker *set_shrinker(int seeks, shrinker_t theshrinker)
+{
+        struct shrinker *shrinker;
+
+        shrinker = kmalloc(sizeof(*shrinker), GFP_KERNEL);
+        if (shrinker) {
+	        shrinker->shrinker = theshrinker;
+	        shrinker->seeks = seeks;
+	        shrinker->nr = 0;
+	        down(&shrinker_sem);
+	        list_add(&shrinker->list, &shrinker_list);
+	        up(&shrinker_sem);
+	}
+	return shrinker;
+}
+
+/*
+ * Remove one
+ */
+void remove_shrinker(struct shrinker *shrinker)
+{
+	down(&shrinker_sem);
+	list_del(&shrinker->list);
+	up(&shrinker_sem);
+	kfree(shrinker);
+}
+ 
+#define SHRINK_BATCH 32
+/*
+ * Call the shrink functions to age shrinkable caches
+ *
+ * Here we assume it costs one seek to replace a lru page and that it also
+ * takes a seek to recreate a cache object.  With this in mind we age equal
+ * percentages of the lru and ageable caches.  This should balance the seeks
+ * generated by these structures.
+ *
+ * If the vm encounted mapped pages on the LRU it increase the pressure on
+ * slab to avoid swapping.
+ *
+ * FIXME: do not do for zone highmem
+ */
+static int shrink_slab(int scanned,  unsigned int gfp_mask)
+{
+	struct list_head *lh;
+	int pages;
+
+	if (down_trylock(&shrinker_sem))
+		return 0;
+
+	pages = nr_used_zone_pages();
+	list_for_each(lh, &shrinker_list) {
+		struct shrinker *shrinker;
+		int entries;
+		unsigned long delta;
+
+		shrinker = list_entry(lh, struct shrinker, list);
+		entries = (*shrinker->shrinker)(0, gfp_mask);
+		if (!entries)
+			continue;
+		delta = scanned * shrinker->seeks * entries;
+		shrinker->nr += delta / (pages + 1);
+		if (shrinker->nr > SHRINK_BATCH) {
+			int nr = shrinker->nr;
+
+			shrinker->nr = 0;
+			(*shrinker->shrinker)(nr, gfp_mask);
+		}
+	}
+	up(&shrinker_sem);
+	return 0;
+}
 
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
@@ -647,32 +732,6 @@ shrink_zone(struct zone *zone, int max_s
 }
 
 /*
- * FIXME: don't do this for ZONE_HIGHMEM
- */
-/*
- * Here we assume it costs one seek to replace a lru page and that it also
- * takes a seek to recreate a cache object.  With this in mind we age equal
- * percentages of the lru and ageable caches.  This should balance the seeks
- * generated by these structures.
- *
- * NOTE: for now I do this for all zones.  If we find this is too aggressive
- * on large boxes we may want to exclude ZONE_HIGHMEM.
- *
- * If we're encountering mapped pages on the LRU then increase the pressure on
- * slab to avoid swapping.
- */
-static void shrink_slab(int total_scanned, int gfp_mask)
-{
-	int shrink_ratio;
-	int pages = nr_used_zone_pages();
-
-	shrink_ratio = (pages / (total_scanned + 1)) + 1;
-	shrink_dcache_memory(shrink_ratio, gfp_mask);
-	shrink_icache_memory(shrink_ratio, gfp_mask);
-	shrink_dqcache_memory(shrink_ratio, gfp_mask);
-}
-
-/*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
  * request.
@@ -715,7 +774,7 @@ shrink_caches(struct zone *classzone, in
 	}
 	return ret;
 }
-
+ 
 /*
  * This is the main entry point to direct page reclaim.
  *
--- 2.5.41/kernel/ksyms.c~batched-slab-asap	Wed Oct  9 22:59:10 2002
+++ 2.5.41-akpm/kernel/ksyms.c	Wed Oct  9 23:09:23 2002
@@ -105,6 +105,8 @@ EXPORT_SYMBOL(kmem_cache_shrink);
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
 EXPORT_SYMBOL(kmem_cache_size);
+EXPORT_SYMBOL(set_shrinker);
+EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
@@ -248,7 +250,6 @@ EXPORT_SYMBOL(dput);
 EXPORT_SYMBOL(have_submounts);
 EXPORT_SYMBOL(d_find_alias);
 EXPORT_SYMBOL(d_prune_aliases);
-EXPORT_SYMBOL(prune_dcache);
 EXPORT_SYMBOL(shrink_dcache_sb);
 EXPORT_SYMBOL(shrink_dcache_parent);
 EXPORT_SYMBOL(shrink_dcache_anon);
--- 2.5.41/include/linux/dcache.h~batched-slab-asap	Wed Oct  9 23:03:05 2002
+++ 2.5.41-akpm/include/linux/dcache.h	Wed Oct  9 23:14:02 2002
@@ -180,17 +180,6 @@ extern void shrink_dcache_parent(struct 
 extern void shrink_dcache_anon(struct list_head *);
 extern int d_invalidate(struct dentry *);
 
-/* dcache memory management */
-extern int shrink_dcache_memory(int, unsigned int);
-extern void prune_dcache(int);
-
-/* icache memory management (defined in linux/fs/inode.c) */
-extern int shrink_icache_memory(int, unsigned int);
-extern void prune_icache(int);
-
-/* quota cache memory management (defined in linux/fs/dquot.c) */
-extern int shrink_dqcache_memory(int, unsigned int);
-
 /* only used at mount-time */
 extern struct dentry * d_alloc_root(struct inode *);
 

.
