Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284741AbRLEVV0>; Wed, 5 Dec 2001 16:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLEVVS>; Wed, 5 Dec 2001 16:21:18 -0500
Received: from [217.9.226.246] ([217.9.226.246]:19584 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S284750AbRLEVVB>; Wed, 5 Dec 2001 16:21:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Slab cache bulk alloc/free
From: Momchil Velikov <velco@fadata.bg>
Date: 05 Dec 2001 23:17:55 +0200
Message-ID: <871yi9tlh8.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This patch adds two new functions

    int kmem_cache_alloc_bulk (kmem_cache_t *, int, unsigned int, void **);
    void kmem_cache_free_bulk (kmem_cache_t *, unsigned int, void **);

to slab.c, which provide for allocation/deallocation of several
objects at once.  These functions can speed up allocation in cases
where it is know in advance that several objects will be allocated, or
to preallocate several objects for later use, when an allocation would
be impossible, e.g. with spin lock held.

BTW, the latter is the case with the (hopefully) upcoming page cache
patch, which uses per-mapping radix trees, which need allocation
during insertion and the maximum possible number of allocations is
known at compile time and that number is small, say, 3 - 7.

Regards,
-velco

diff -Nru a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h	Wed Dec  5 23:03:27 2001
+++ b/include/linux/slab.h	Wed Dec  5 23:03:27 2001
@@ -56,7 +56,9 @@
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
+extern int kmem_cache_alloc_bulk (kmem_cache_t *, int, unsigned int, void **);
 extern void kmem_cache_free(kmem_cache_t *, void *);
+extern void kmem_cache_free_bulk (kmem_cache_t *, unsigned int, void **);
 
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Wed Dec  5 23:03:27 2001
+++ b/mm/slab.c	Wed Dec  5 23:03:27 2001
@@ -278,14 +278,22 @@
 
 #if STATS && defined(CONFIG_SMP)
 #define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
+#define STATS_ADD_ALLOCHIT(x,y)	atomic_add(y, &(x)->allochit)
 #define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
+#define STATS_ADD_ALLOCMISS(x,y) atomic_add(y, &(x)->allocmiss)
 #define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
+#define STATS_ADD_FREEHIT(x,y)	atomic_add(y, &(x)->freehit)
 #define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
+#define STATS_ADD_FREEMISS(x,y)	atomic_add(y, &(x)->freemiss)
 #else
-#define STATS_INC_ALLOCHIT(x)	do { } while (0)
-#define STATS_INC_ALLOCMISS(x)	do { } while (0)
-#define STATS_INC_FREEHIT(x)	do { } while (0)
-#define STATS_INC_FREEMISS(x)	do { } while (0)
+#define STATS_INC_ALLOCHIT(x)   do { } while (0)
+#define STATS_ADD_ALLOCHIT(x,y) do { } while (0)
+#define STATS_INC_ALLOCMISS(x)  do { } while (0)
+#define STATS_ADD_ALLOCMISS(x,y) do { } while (0)
+#define STATS_INC_FREEHIT(x)    do { } while (0)
+#define STATS_ADD_FREEHIT(x,y)  do { } while (0)
+#define STATS_INC_FREEMISS(x)   do { } while (0)
+#define STATS_ADD_FREEMISS(x,y) do { } while (0)
 #endif
 
 #if DEBUG
@@ -1281,14 +1289,12 @@
 	kmem_cache_alloc_one_tail(cachep, slabp);		\
 })
 
-#ifdef CONFIG_SMP
-void* kmem_cache_alloc_batch(kmem_cache_t* cachep, int flags)
+int __kmem_cache_alloc_bulk (kmem_cache_t* cachep, int flags, unsigned int bulkcount, void **buf)
 {
-	int batchcount = cachep->batchcount;
-	cpucache_t* cc = cc_data(cachep);
+	int count = 0;
 
 	spin_lock(&cachep->spinlock);
-	while (batchcount--) {
+	while (bulkcount--) {
 		struct list_head * slabs_partial, * entry;
 		slab_t *slabp;
 		/* Get slab alloc is to come from. */
@@ -1305,16 +1311,12 @@
 		}
 
 		slabp = list_entry(entry, slab_t, list);
-		cc_entry(cc)[cc->avail++] =
-				kmem_cache_alloc_one_tail(cachep, slabp);
+		buf [count++] = kmem_cache_alloc_one_tail(cachep, slabp);
 	}
 	spin_unlock(&cachep->spinlock);
 
-	if (cc->avail)
-		return cc_entry(cc)[--cc->avail];
-	return NULL;
+	return count;
 }
-#endif
 
 static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
@@ -1334,9 +1336,12 @@
 				objp = cc_entry(cc)[--cc->avail];
 			} else {
 				STATS_INC_ALLOCMISS(cachep);
-				objp = kmem_cache_alloc_batch(cachep,flags);
-				if (!objp)
+				cc->avail += __kmem_cache_alloc_bulk (cachep, flags,
+								      cachep->batchcount,
+								      cc_entry (cc));
+				if (cc->avail == 0)
 					goto alloc_new_slab_nolock;
+				objp = cc_entry(cc) [--cc->avail];
 			}
 		} else {
 			spin_lock(&cachep->spinlock);
@@ -1370,18 +1375,18 @@
  */
 
 #if DEBUG
-# define CHECK_NR(pg)						\
+# define CHECK_NR(objp)						\
 	do {							\
-		if (!VALID_PAGE(pg)) {				\
+		if (!VALID_PAGE(virt_to_page (objp))) {		\
 			printk(KERN_ERR "kfree: out of range ptr %lxh.\n", \
 				(unsigned long)objp);		\
 			BUG();					\
 		} \
 	} while (0)
-# define CHECK_PAGE(page)					\
+# define CHECK_PAGE(objp)					\
 	do {							\
-		CHECK_NR(page);					\
-		if (!PageSlab(page)) {				\
+		CHECK_NR(objp);					\
+		if (!PageSlab(virt_to_page(objp))) {		\
 			printk(KERN_ERR "kfree: bad ptr %lxh.\n", \
 				(unsigned long)objp);		\
 			BUG();					\
@@ -1396,7 +1401,7 @@
 {
 	slab_t* slabp;
 
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	/* reduces memory footprint
 	 *
 	if (OPTIMIZE(cachep))
@@ -1451,7 +1456,6 @@
 	}
 }
 
-#ifdef CONFIG_SMP
 static inline void __free_block (kmem_cache_t* cachep,
 							void** objpp, int len)
 {
@@ -1465,7 +1469,6 @@
 	__free_block(cachep, objpp, len);
 	spin_unlock(&cachep->spinlock);
 }
-#endif
 
 /*
  * __kmem_cache_free
@@ -1476,7 +1479,7 @@
 #ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
 
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	if (cc) {
 		int batchcount;
 		if (cc->avail < cc->limit) {
@@ -1513,6 +1516,65 @@
 }
 
 /**
+ * kmem_cache_alloc_bulk - Allocate several objects
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ * @size: number of objects to allocate, size of the buffer
+ * @buf: buffer to store allocated object into
+ *
+ * Allocate several object from this cache.  The flags are only
+ * relevant if the cache has no available objects.  Returns the number
+ * of objects allocated.
+ */
+int kmem_cache_alloc_bulk (kmem_cache_t *cachep, int flags, unsigned int size, void **buf)
+{
+#ifdef CONFIG_SMP
+	cpucache_t *cc = cc_data (cachep);
+#endif
+	int count;
+	unsigned long save_flags;
+
+	kmem_cache_alloc_head(cachep, flags);
+	count = 0;
+try_again:
+	local_irq_save(save_flags);
+#ifdef CONFIG_SMP
+	if (cc) {
+		if (cc->avail) {
+			STATS_ADD_ALLOCHIT(cachep, min (size - count, cc->avail));
+			while (count < size && cc->avail)
+				buf [count++] = cc_entry (cc) [--cc->avail];
+		} else {
+			cc->avail += __kmem_cache_alloc_bulk (cachep, flags, cachep->batchcount,
+							      cc_entry (cc));
+			if (!cc->avail)
+				goto alloc_new_slab;
+
+			STATS_ADD_ALLOCMISS(cachep, min (size - count, cc->avail));
+			while (count < size && cc->avail)
+				buf [count++] = cc_entry (cc) [--cc->avail];
+		}
+	} else {
+		count += __kmem_cache_alloc_bulk (cachep, flags, size - count, buf + count);
+	}
+#else
+	count += __kmem_cache_alloc_bulk (cachep, flags, size - count, buf + count);
+#endif
+	if (count < size)
+	  goto alloc_new_slab;
+	local_irq_restore(save_flags);
+	return count;
+alloc_new_slab:
+	local_irq_restore(save_flags);
+	if (kmem_cache_grow(cachep, flags))
+		/* Someone may have stolen our objs.  Doesn't matter, we'll
+		 * just come back here again.
+		 */
+		goto try_again;
+	return count;
+}
+
+/**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
@@ -1558,7 +1620,7 @@
 {
 	unsigned long flags;
 #if DEBUG
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
 		BUG();
 #endif
@@ -1569,6 +1631,49 @@
 }
 
 /**
+ * kmem_cache_free_bulk - Deallocate several objects
+ * @cachep: The cache the allocation was from.
+ * @count: number of objects the deallocate.
+ * @buf: array of pointer to objects to deallocate.
+ *
+ * Free several objects which were previously allocated from this
+ * cache.
+ */
+void kmem_cache_free_bulk (kmem_cache_t *cachep, unsigned int count, void **buf)
+{
+	unsigned long flags;
+#ifdef CONFIG_SMP
+	cpucache_t *cc = cc_data(cachep);
+
+	local_irq_save(flags);
+
+	if (cc) {
+		STATS_ADD_FREEHIT (cachep, min (count, cc->limit - cc->avail));
+		while (count > 0 && cc->avail < cc->limit) {
+			CHECK_PAGE (buf [count - 1]);
+			cc_entry(cc)[cc->avail++] = buf [--count];
+		}
+
+		if (count == 0)
+			return;
+
+		STATS_ADD_FREEMISS(cachep, count);
+	}
+#else
+	local_irq_save(flags);
+#endif
+#if DEBUG
+	{
+		int i = count;
+		while (i-- > 0)
+			CHECK_PAGE (buf [i]);
+	}
+#endif
+	free_block(cachep, buf, count);
+	local_irq_restore(flags);
+}
+
+/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
@@ -1583,7 +1688,7 @@
 	if (!objp)
 		return;
 	local_irq_save(flags);
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
