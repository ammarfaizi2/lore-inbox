Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSJHSDC>; Tue, 8 Oct 2002 14:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSJHSDB>; Tue, 8 Oct 2002 14:03:01 -0400
Received: from thunk.org ([140.239.227.29]:16067 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261339AbSJHSCe>;
	Tue, 8 Oct 2002 14:02:34 -0400
To: linux-kernel@vger.kernel.org
cc: ext2-devel@lists.sourceforge.net
Subject: [RFC] [PATCH 2/4] Add extended attributes to ext2/3
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17yymE-00021l-00@think.thunk.org>
Date: Tue, 08 Oct 2002 14:08:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the second of four patches which add extended attribute support
to the ext2 and ext3 filesystems.  Please comment and bleed.

This patch creates a meta block cache which is utilized by the ext3 and
ext2 extended attribute patch (patches 3 and 4, respectively).  This
cache allows directory blocks to be indexed by multiple keys.  In the
case of the extended attribute patches, it is used to look up blocks by
both the block number and by the hash of the extended attributes.  This
is extremely important to allow the sharing of acl's when stored as
extended attributes.  Otherwise every single file would require its own,
separate, one block overhead to store then ACL, even though there might
be a large number of files that have the same ACL.  


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#
# fs/Config.in            |    4 
# fs/Makefile             |    4 
# fs/mbcache.c            |  716 ++++++++++++++++++++++++++++++++++++++++++++++++
# include/linux/mbcache.h |   69 ++++
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	tytso@think.thunk.org	1.666
# Port of the 0.8.50 xattr-mbcache patch to 2.5.
# --------------------------------------------
#
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Oct  8 13:52:15 2002
+++ b/fs/Config.in	Tue Oct  8 13:52:15 2002
@@ -168,6 +168,10 @@
    define_tristate CONFIG_ZISOFS_FS n
 fi
 
+# Meta block cache for Extended Attributes (ext2/ext3)
+#tristate 'Meta block cache' CONFIG_FS_MBCACHE
+define_tristate CONFIG_FS_MBCACHE y
+
 mainmenu_option next_comment
 comment 'Partition Types'
 source fs/partitions/Config.in
diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Tue Oct  8 13:52:15 2002
+++ b/fs/Makefile	Tue Oct  8 13:52:15 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o
+                fcntl.o mbcache.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
@@ -29,6 +29,8 @@
 obj-y				+= binfmt_script.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
+
+obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
diff -Nru a/fs/mbcache.c b/fs/mbcache.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/mbcache.c	Tue Oct  8 13:52:15 2002
@@ -0,0 +1,716 @@
+/*
+ * linux/fs/mbcache.c
+ * (C) 2001-2002 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+/*
+ * Filesystem Meta Information Block Cache (mbcache)
+ *
+ * The mbcache caches blocks of block devices that need to be located
+ * by their device/block number, as well as by other criteria (such
+ * as the block's contents).
+ *
+ * There can only be one cache entry in a cache per device and block number.
+ * Additional indexes need not be unique in this sense. The number of
+ * additional indexes (=other criteria) can be hardwired (at compile time)
+ * or specified at cache create time.
+ *
+ * Each cache entry is of fixed size. An entry may be `valid' or `invalid'
+ * in the cache. A valid entry is in the main hash tables of the cache,
+ * and may also be in the lru list. An invalid entry is not in any hashes
+ * or lists.
+ *
+ * A valid cache entry is only in the lru list if no handles refer to it.
+ * Invalid cache entries will be freed when the last handle to the cache
+ * entry is released.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/cache_def.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/mbcache.h>
+
+
+#ifdef MB_CACHE_DEBUG
+# define mb_debug(f...) do { \
+		printk(KERN_DEBUG f); \
+		printk("\n"); \
+	} while (0)
+#define mb_assert(c) do { if (!(c)) \
+		printk(KERN_ERR "assertion " #c " failed\n"); \
+	} while(0)
+#else
+# define mb_debug(f...) do { } while(0)
+# define mb_assert(c) do { } while(0)
+#endif
+#define mb_error(f...) do { \
+		printk(KERN_ERR f); \
+		printk("\n"); \
+	} while(0)
+		
+MODULE_AUTHOR("Andreas Gruenbacher <a.gruenbacher@computer.org>");
+MODULE_DESCRIPTION("Meta block cache (for extended attributes)");
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+MODULE_LICENSE("GPL");
+#endif
+
+EXPORT_SYMBOL(mb_cache_create);
+EXPORT_SYMBOL(mb_cache_shrink);
+EXPORT_SYMBOL(mb_cache_destroy);
+EXPORT_SYMBOL(mb_cache_entry_alloc);
+EXPORT_SYMBOL(mb_cache_entry_insert);
+EXPORT_SYMBOL(mb_cache_entry_release);
+EXPORT_SYMBOL(mb_cache_entry_takeout);
+EXPORT_SYMBOL(mb_cache_entry_free);
+EXPORT_SYMBOL(mb_cache_entry_dup);
+EXPORT_SYMBOL(mb_cache_entry_get);
+#if !defined(MB_CACHE_INDEXES_COUNT) || (MB_CACHE_INDEXES_COUNT > 0)
+EXPORT_SYMBOL(mb_cache_entry_find_first);
+EXPORT_SYMBOL(mb_cache_entry_find_next);
+#endif
+
+
+/*
+ * Global data: list of all mbcache's, lru list, and a spinlock for
+ * accessing cache data structures on SMP machines. (The lru list is
+ * global across all mbcaches.)
+ */
+
+static LIST_HEAD(mb_cache_list);
+static LIST_HEAD(mb_cache_lru_list);
+static spinlock_t mb_cache_spinlock = SPIN_LOCK_UNLOCKED;
+
+static inline void
+mb_cache_lock(void)
+{
+	spin_lock(&mb_cache_spinlock);
+}
+
+static inline void
+mb_cache_unlock(void)
+{
+	spin_unlock(&mb_cache_spinlock);
+}
+
+static inline int
+mb_cache_indexes(struct mb_cache *cache)
+{
+#ifdef MB_CACHE_INDEXES_COUNT
+	return MB_CACHE_INDEXES_COUNT;
+#else
+	return cache->c_indexes_count;
+#endif
+}
+
+/*
+ * What the mbcache registers as to get shrunk dynamically.
+ */
+
+static void
+mb_cache_memory_pressure(int priority, unsigned int gfp_mask);
+
+static struct cache_definition mb_cache_definition = {
+	"mb_cache",
+	mb_cache_memory_pressure
+};
+
+
+static inline void
+__mb_cache_entry_takeout_lru(struct mb_cache_entry *ce)
+{
+	if (ce->e_lru_list.prev) {
+		list_del(&ce->e_lru_list);
+		ce->e_lru_list.prev = NULL;
+	}
+}
+
+
+static inline void
+__mb_cache_entry_into_lru(struct mb_cache_entry *ce)
+{
+	list_add(&ce->e_lru_list, &mb_cache_lru_list);
+}
+
+
+static inline int
+__mb_cache_entry_in_lru(struct mb_cache_entry *ce)
+{
+	return (ce->e_lru_list.prev != NULL);
+}
+
+
+/*
+ * Insert the cache entry into all hashes.
+ */
+static inline void
+__mb_cache_entry_link(struct mb_cache_entry *ce)
+{
+	struct mb_cache *cache = ce->e_cache;
+	unsigned int bucket = (ce->e_dev + ce->e_block) %
+	                      cache->c_bucket_count;
+	int n;
+	
+	list_add(&ce->e_block_list, &cache->c_block_hash[bucket]);
+	for (n=0; n<mb_cache_indexes(cache); n++) {
+		bucket = ce->e_indexes[n].o_key % cache->c_bucket_count;
+		list_add(&ce->e_indexes[n].o_list,
+		         &cache->c_indexes_hash[n][bucket]);
+	}
+}
+
+
+/*
+ * Remove the cache entry from all hashes.
+ */
+static inline void
+__mb_cache_entry_unlink(struct mb_cache_entry *ce)
+{
+	int n;
+
+	list_del(&ce->e_block_list);
+	ce->e_block_list.prev = NULL;
+	for (n=0; n<mb_cache_indexes(ce->e_cache); n++)
+		list_del(&ce->e_indexes[n].o_list);
+}
+
+
+static inline int
+__mb_cache_entry_is_linked(struct mb_cache_entry *ce)
+{
+	return (ce->e_block_list.prev != NULL);
+}
+
+
+static inline struct mb_cache_entry *
+__mb_cache_entry_read(struct mb_cache_entry *ce)
+{
+	__mb_cache_entry_takeout_lru(ce);
+	atomic_inc(&ce->e_used);
+	return ce;
+}
+
+
+static inline void
+__mb_cache_entry_forget(struct mb_cache_entry *ce)
+{
+	struct mb_cache *cache = ce->e_cache;
+
+	mb_assert(atomic_read(&ce->e_used) == 0);
+	atomic_dec(&cache->c_entry_count);
+	if (cache->c_op.free)
+		cache->c_op.free(ce);
+	kmem_cache_free(cache->c_entry_cache, ce);
+}
+
+
+static inline void
+__mb_cache_entry_release_unlock(struct mb_cache_entry *ce)
+{
+	if (atomic_dec_and_test(&ce->e_used)) {
+		if (__mb_cache_entry_is_linked(ce))
+			__mb_cache_entry_into_lru(ce);
+		else {
+			mb_cache_unlock();
+			__mb_cache_entry_forget(ce);
+			return;
+		}
+	}
+	mb_cache_unlock();
+}
+
+
+/*
+ * mb_cache_memory_pressure()  memory pressure callback
+ *
+ * This function is called by the kernel memory management when memory
+ * gets low.
+ *
+ * @priority: Amount by which to shrink the cache (0 = highes priority)
+ * @gfp_mask: (ignored)
+ */
+static void
+mb_cache_memory_pressure(int priority, unsigned int gfp_mask)
+{
+	LIST_HEAD(free_list);
+	struct list_head *l;
+	int count = 0;
+
+	mb_cache_lock();
+	list_for_each_prev(l, &mb_cache_list) {
+		struct mb_cache *cache =
+			list_entry(l, struct mb_cache, c_cache_list);
+		mb_debug("cache %s (%d)", cache->c_name,
+			  atomic_read(&cache->c_entry_count));
+		count += atomic_read(&cache->c_entry_count);
+	}
+	mb_debug("trying to free %d of %d entries",
+		  count / (priority ? priority : 1), count);
+	if (priority)
+		count /= priority;
+	while (count && !list_empty(&mb_cache_lru_list)) {
+		struct mb_cache_entry *ce =
+			list_entry(mb_cache_lru_list.prev,
+				   struct mb_cache_entry, e_lru_list);
+		list_del(&ce->e_lru_list);
+		list_add(&ce->e_lru_list, &free_list);
+		if (__mb_cache_entry_is_linked(ce))
+			__mb_cache_entry_unlink(ce);
+		count--;
+	}
+	mb_cache_unlock();
+	l = free_list.prev;
+	while (l != &free_list) {
+		struct mb_cache_entry *ce = list_entry(l,
+			struct mb_cache_entry, e_lru_list);
+		l = l->prev;
+		__mb_cache_entry_forget(ce);
+	}
+	if (count)
+		mb_debug("%d fewer entries freed", count);
+}
+
+
+/*
+ * mb_cache_create()  create a new cache
+ *
+ * All entries in one cache are equal size. Cache entries may be from
+ * multiple devices. If this is the first mbcache created, registers
+ * the cache with kernel memory management. Returns NULL if no more
+ * memory was available.
+ *
+ * @name: name of the cache (informal)
+ * @cache_op: contains the callback called when freeing a cache entry
+ * @entry_size: The size of a cache entry, including
+ *              struct mb_cache_entry
+ * @indexes_count: number of additional indexes in the cache. Must equal
+ *                 MB_CACHE_INDEXES_COUNT if the number of indexes is
+ *                 hardwired.
+ * @bucket_count: number of hash buckets
+ */
+struct mb_cache *
+mb_cache_create(const char *name, struct mb_cache_op *cache_op,
+		size_t entry_size, int indexes_count, int bucket_count)
+{
+	int m=0, n;
+	struct mb_cache *cache = NULL;
+
+	if(entry_size < sizeof(struct mb_cache_entry) +
+	   indexes_count * sizeof(struct mb_cache_entry_index))
+		return NULL;
+
+	MOD_INC_USE_COUNT;
+	cache = kmalloc(sizeof(struct mb_cache) +
+	                indexes_count * sizeof(struct list_head), GFP_KERNEL);
+	if (!cache)
+		goto fail;
+	cache->c_name = name;
+	if (cache_op)
+		cache->c_op.free = cache_op->free;
+	else
+		cache->c_op.free = NULL;
+	atomic_set(&cache->c_entry_count, 0);
+	cache->c_bucket_count = bucket_count;
+#ifdef MB_CACHE_INDEXES_COUNT
+	mb_assert(indexes_count == MB_CACHE_INDEXES_COUNT);
+#else
+	cache->c_indexes_count = indexes_count;
+#endif
+	cache->c_block_hash = kmalloc(bucket_count * sizeof(struct list_head),
+	                              GFP_KERNEL);
+	if (!cache->c_block_hash)
+		goto fail;
+	for (n=0; n<bucket_count; n++)
+		INIT_LIST_HEAD(&cache->c_block_hash[n]);
+	for (m=0; m<indexes_count; m++) {
+		cache->c_indexes_hash[m] = kmalloc(bucket_count *
+		                                 sizeof(struct list_head),
+		                                 GFP_KERNEL);
+		if (!cache->c_indexes_hash[m])
+			goto fail;
+		for (n=0; n<bucket_count; n++)
+			INIT_LIST_HEAD(&cache->c_indexes_hash[m][n]);
+	}
+	cache->c_entry_cache = kmem_cache_create(name, entry_size, 0,
+		0 /*SLAB_POISON | SLAB_RED_ZONE*/, NULL, NULL);
+	if (!cache->c_entry_cache)
+		goto fail;
+
+	mb_cache_lock();
+	if (list_empty(&mb_cache_list))
+		register_cache(&mb_cache_definition);
+	list_add(&cache->c_cache_list, &mb_cache_list);
+	mb_cache_unlock();
+	return cache;
+
+fail:
+	if (cache) {
+		while (--m >= 0)
+			kfree(cache->c_indexes_hash[m]);
+		if (cache->c_block_hash)
+			kfree(cache->c_block_hash);
+		kfree(cache);
+	}
+	MOD_DEC_USE_COUNT;
+	return NULL;
+}
+
+
+/*
+ * mb_cache_shrink()
+ *
+ * Removes all cache entires of a device from the cache. All cache entries
+ * currently in use cannot be freed, and thus remain in the cache. All others
+ * are freed.
+ *
+ * @cache: which cache to shrink
+ * @dev: which device's cache entries to shrink
+ */
+void
+mb_cache_shrink(struct mb_cache *cache, dev_t dev)
+{
+	LIST_HEAD(free_list);
+	struct list_head *l;
+
+	mb_cache_lock();
+	l = mb_cache_lru_list.prev;
+	while (l != &mb_cache_lru_list) {
+		struct mb_cache_entry *ce =
+			list_entry(l, struct mb_cache_entry, e_lru_list);
+		l = l->prev;
+		if (ce->e_dev == dev) {
+			list_del(&ce->e_lru_list);
+			list_add(&ce->e_lru_list, &free_list);
+			if (__mb_cache_entry_is_linked(ce))
+				__mb_cache_entry_unlink(ce);
+		}
+	}
+	mb_cache_unlock();
+	l = free_list.prev;
+	while (l != &free_list) {
+		struct mb_cache_entry *ce =
+			list_entry(l, struct mb_cache_entry, e_lru_list);
+		l = l->prev;
+		__mb_cache_entry_forget(ce);
+	}
+}
+
+
+/*
+ * mb_cache_destroy()
+ *
+ * Shrinks the cache to its minimum possible size (hopefully 0 entries),
+ * and then destroys it. If this was the last mbcache, un-registers the
+ * mbcache from kernel memory management.
+ */
+void
+mb_cache_destroy(struct mb_cache *cache)
+{
+	LIST_HEAD(free_list);
+	struct list_head *l;
+	int n;
+
+	mb_cache_lock();
+	l = mb_cache_lru_list.prev;
+	while (l != &mb_cache_lru_list) {
+		struct mb_cache_entry *ce =
+			list_entry(l, struct mb_cache_entry, e_lru_list);
+		l = l->prev;
+		if (ce->e_cache == cache) {
+			list_del(&ce->e_lru_list);
+			list_add(&ce->e_lru_list, &free_list);
+			if (__mb_cache_entry_is_linked(ce))
+				__mb_cache_entry_unlink(ce);
+		}
+	}
+	list_del(&cache->c_cache_list);
+	if (list_empty(&mb_cache_list))
+		unregister_cache(&mb_cache_definition);
+	mb_cache_unlock();
+
+	l = free_list.prev;
+	while (l != &free_list) {
+		struct mb_cache_entry *ce =
+			list_entry(l, struct mb_cache_entry, e_lru_list);
+		l = l->prev;
+		__mb_cache_entry_forget(ce);
+	}
+
+	if (atomic_read(&cache->c_entry_count) > 0) {
+		mb_error("cache %s: %d orphaned entries",
+			  cache->c_name,
+			  atomic_read(&cache->c_entry_count));
+	}
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
+	/* We don't have kmem_cache_destroy() in 2.2.x */
+	kmem_cache_shrink(cache->c_entry_cache);
+#else
+	kmem_cache_destroy(cache->c_entry_cache);
+#endif
+	for (n=0; n < mb_cache_indexes(cache); n++)
+		kfree(cache->c_indexes_hash[n]);
+	kfree(cache->c_block_hash);
+
+	kfree(cache);
+
+	MOD_DEC_USE_COUNT;
+}
+
+
+/*
+ * mb_cache_entry_alloc()
+ *
+ * Allocates a new cache entry. The new entry will not be valid initially,
+ * and thus cannot be looked up yet. It should be filled with data, and
+ * then inserted into the cache using mb_cache_entry_insert(). Returns NULL
+ * if no more memory was available.
+ */
+struct mb_cache_entry *
+mb_cache_entry_alloc(struct mb_cache *cache)
+{
+	struct mb_cache_entry *ce;
+
+	atomic_inc(&cache->c_entry_count);
+	ce = kmem_cache_alloc(cache->c_entry_cache, GFP_KERNEL);
+	if (ce) {
+		ce->e_lru_list.prev = NULL;
+		ce->e_block_list.prev = NULL;
+		ce->e_cache = cache;
+		atomic_set(&ce->e_used, 1);
+	}
+	return ce;
+}
+
+
+/*
+ * mb_cache_entry_insert()
+ *
+ * Inserts an entry that was allocated using mb_cache_entry_alloc() into
+ * the cache. After this, the cache entry can be looked up, but is not yet
+ * in the lru list as the caller still holds a handle to it. Returns 0 on
+ * success, or -EBUSY if a cache entry for that device + inode exists
+ * already (this may happen after a failed lookup, but when another process
+ * has inserted the same cache entry in the meantime).
+ *
+ * @dev: device the cache entry belongs to
+ * @block: block number
+ * @keys: array of additional keys. There must be indexes_count entries
+ *        in the array (as specified when creating the cache).
+ */
+int
+mb_cache_entry_insert(struct mb_cache_entry *ce, dev_t dev,
+		      unsigned long block, unsigned int keys[])
+{
+	struct mb_cache *cache = ce->e_cache;
+	unsigned int bucket = (dev + block) % cache->c_bucket_count;
+	struct list_head *l;
+	int error = -EBUSY, n;
+
+	mb_cache_lock();
+	list_for_each_prev(l, &cache->c_block_hash[bucket]) {
+		struct mb_cache_entry *ce =
+			list_entry(l, struct mb_cache_entry, e_block_list);
+		if (ce->e_dev == dev && ce->e_block == block)
+			goto out;
+	}
+	mb_assert(!__mb_cache_entry_is_linked(ce));
+	ce->e_dev = dev;
+	ce->e_block = block;
+	for (n=0; n<mb_cache_indexes(cache); n++)
+		ce->e_indexes[n].o_key = keys[n];
+	__mb_cache_entry_link(ce);
+out:
+	mb_cache_unlock();
+	return error;
+}
+
+
+/*
+ * mb_cache_entry_release()
+ *
+ * Release a handle to a cache entry. When the last handle to a cache entry
+ * is released it is either freed (if it is invalid) or otherwise inserted
+ * in to the lru list.
+ */
+void
+mb_cache_entry_release(struct mb_cache_entry *ce)
+{
+	mb_cache_lock();
+	__mb_cache_entry_release_unlock(ce);
+}
+
+
+/*
+ * mb_cache_entry_takeout()
+ *
+ * Take a cache entry out of the cache, making it invalid. The entry can later
+ * be re-inserted using mb_cache_entry_insert(), or released using
+ * mb_cache_entry_release().
+ */
+void
+mb_cache_entry_takeout(struct mb_cache_entry *ce)
+{
+	mb_cache_lock();
+	mb_assert(!__mb_cache_entry_in_lru(ce));
+	if (__mb_cache_entry_is_linked(ce))
+		__mb_cache_entry_unlink(ce);
+	mb_cache_unlock();
+}
+
+
+/*
+ * mb_cache_entry_free()
+ *
+ * This is equivalent to the sequence mb_cache_entry_takeout() --
+ * mb_cache_entry_release().
+ */
+void
+mb_cache_entry_free(struct mb_cache_entry *ce)
+{
+	mb_cache_lock();
+	mb_assert(!__mb_cache_entry_in_lru(ce));
+	if (__mb_cache_entry_is_linked(ce))
+		__mb_cache_entry_unlink(ce);
+	__mb_cache_entry_release_unlock(ce);
+}
+
+
+/*
+ * mb_cache_entry_dup()
+ *
+ * Duplicate a handle to a cache entry (does not duplicate the cache entry
+ * itself). After the call, both the old and the new handle must be released.
+ */
+struct mb_cache_entry *
+mb_cache_entry_dup(struct mb_cache_entry *ce)
+{
+	atomic_inc(&ce->e_used);
+	return ce;
+}
+
+
+/*
+ * mb_cache_entry_get()
+ *
+ * Get a cache entry  by device / block number. (There can only be one entry
+ * in the cache per device and block.) Returns NULL if no such cache entry
+ * exists.
+ */
+struct mb_cache_entry *
+mb_cache_entry_get(struct mb_cache *cache, dev_t dev, unsigned long block)
+{
+	unsigned int bucket = (dev + block) % cache->c_bucket_count;
+	struct list_head *l;
+	struct mb_cache_entry *ce;
+
+	mb_cache_lock();
+	list_for_each(l, &cache->c_block_hash[bucket]) {
+		ce = list_entry(l, struct mb_cache_entry, e_block_list);
+		if (ce->e_dev == dev && ce->e_block == block) {
+			ce = __mb_cache_entry_read(ce);
+			goto cleanup;
+		}
+	}
+	ce = NULL;
+
+cleanup:
+	mb_cache_unlock();
+	return ce;
+}
+
+#if !defined(MB_CACHE_INDEXES_COUNT) || (MB_CACHE_INDEXES_COUNT > 0)
+
+static struct mb_cache_entry *
+__mb_cache_entry_find(struct list_head *l, struct list_head *head,
+		      int index, dev_t dev, unsigned int key)
+{
+	while (l != head) {
+		struct mb_cache_entry *ce =
+			list_entry(l, struct mb_cache_entry,
+			           e_indexes[index].o_list);
+		if (ce->e_dev == dev &&
+		    ce->e_indexes[index].o_key == key) {
+			ce = __mb_cache_entry_read(ce);
+			if (ce)
+				return ce;
+		}
+		l = l->next;
+	}
+	return NULL;
+}
+
+
+/*
+ * mb_cache_entry_find_first()
+ *
+ * Find the first cache entry on a given device with a certain key in
+ * an additional index. Additonal matches can be found with
+ * mb_cache_entry_find_next(). Returns NULL if no match was found.
+ *
+ * @cache: the cache to search
+ * @index: the number of the additonal index to search (0<=index<indexes_count)
+ * @dev: the device the cache entry should belong to
+ * @key: the key in the index
+ */
+struct mb_cache_entry *
+mb_cache_entry_find_first(struct mb_cache *cache, int index, dev_t dev,
+			  unsigned int key)
+{
+	unsigned int bucket = key % cache->c_bucket_count;
+	struct list_head *l;
+	struct mb_cache_entry *ce;
+
+	mb_assert(index < mb_cache_indexes(cache));
+	mb_cache_lock();
+	l = cache->c_indexes_hash[index][bucket].next;
+	ce = __mb_cache_entry_find(l, &cache->c_indexes_hash[index][bucket],
+	                           index, dev, key);
+	mb_cache_unlock();
+	return ce;
+}
+
+
+/*
+ * mb_cache_entry_find_next()
+ *
+ * Find the next cache entry on a given device with a certain key in an
+ * additional index. Returns NULL if no match could be found. The previous
+ * entry is atomatically released, so that mb_cache_entry_find_next() can
+ * be called like this:
+ *
+ * entry = mb_cache_entry_find_first();
+ * while (entry) {
+ * 	...
+ *	entry = mb_cache_entry_find_next(entry, ...);
+ * }
+ *
+ * @prev: The previous match
+ * @index: the number of the additonal index to search (0<=index<indexes_count)
+ * @dev: the device the cache entry should belong to
+ * @key: the key in the index
+ */
+struct mb_cache_entry *
+mb_cache_entry_find_next(struct mb_cache_entry *prev, int index, dev_t dev,
+			 unsigned int key)
+{
+	struct mb_cache *cache = prev->e_cache;
+	unsigned int bucket = key % cache->c_bucket_count;
+	struct list_head *l;
+	struct mb_cache_entry *ce;
+
+	mb_assert(index < mb_cache_indexes(cache));
+	mb_cache_lock();
+	l = prev->e_indexes[index].o_list.next;
+	ce = __mb_cache_entry_find(l, &cache->c_indexes_hash[index][bucket],
+	                           index, dev, key);
+	__mb_cache_entry_release_unlock(prev);
+	return ce;
+}
+
+#endif  /* !defined(MB_CACHE_INDEXES_COUNT) || (MB_CACHE_INDEXES_COUNT > 0) */
diff -Nru a/include/linux/mbcache.h b/include/linux/mbcache.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/mbcache.h	Tue Oct  8 13:52:15 2002
@@ -0,0 +1,69 @@
+/*
+  File: linux/mbcache.h
+
+  (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+/* Hardwire the number of additional indexes */
+#define MB_CACHE_INDEXES_COUNT 1
+
+struct mb_cache_entry;
+
+struct mb_cache_op {
+	void (*free)(struct mb_cache_entry *);
+};
+
+struct mb_cache {
+	struct list_head		c_cache_list;
+	const char			*c_name;
+	struct mb_cache_op		c_op;
+	atomic_t			c_entry_count;
+	int				c_bucket_count;
+#ifndef MB_CACHE_INDEXES_COUNT
+	int				c_indexes_count;
+#endif
+	kmem_cache_t			*c_entry_cache;
+	struct list_head		*c_block_hash;
+	struct list_head		*c_indexes_hash[0];
+};
+
+struct mb_cache_entry_index {
+	struct list_head		o_list;
+	unsigned int			o_key;
+};
+
+struct mb_cache_entry {
+	struct list_head		e_lru_list;
+	struct mb_cache			*e_cache;
+	atomic_t			e_used;
+	dev_t				e_dev;
+	unsigned long			e_block;
+	struct list_head		e_block_list;
+	struct mb_cache_entry_index	e_indexes[0];
+};
+
+/* Functions on caches */
+
+struct mb_cache * mb_cache_create(const char *, struct mb_cache_op *, size_t,
+				  int, int);
+void mb_cache_shrink(struct mb_cache *, dev_t);
+void mb_cache_destroy(struct mb_cache *);
+
+/* Functions on cache entries */
+
+struct mb_cache_entry *mb_cache_entry_alloc(struct mb_cache *);
+int mb_cache_entry_insert(struct mb_cache_entry *, dev_t, unsigned long,
+			  unsigned int[]);
+void mb_cache_entry_rehash(struct mb_cache_entry *, unsigned int[]);
+void mb_cache_entry_release(struct mb_cache_entry *);
+void mb_cache_entry_takeout(struct mb_cache_entry *);
+void mb_cache_entry_free(struct mb_cache_entry *);
+struct mb_cache_entry *mb_cache_entry_dup(struct mb_cache_entry *);
+struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *, dev_t,
+					  unsigned long);
+#if !defined(MB_CACHE_INDEXES_COUNT) || (MB_CACHE_INDEXES_COUNT > 0)
+struct mb_cache_entry *mb_cache_entry_find_first(struct mb_cache *cache, int,
+						 dev_t, unsigned int);
+struct mb_cache_entry *mb_cache_entry_find_next(struct mb_cache_entry *, int,
+						dev_t, unsigned int);
+#endif

