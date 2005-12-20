Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVLTPoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVLTPoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVLTPoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:44:46 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10389 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751101AbVLTPop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:44:45 -0500
Subject: [PATCH RT 02/02] SLOB - break SLOB up by caches
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 10:44:27 -0500
Message-Id: <1135093467.13138.304.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch breaks up the SLOBs by caches, and also uses the mem_map
pages to find the cache descriptor.


Once again:

TODO:  IMPORTANT!!!

1) I haven't cleaned up the kmem_cache_destroy yet, so every time that
happens, there's a memory leak.

2) I need to test on SMP.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rc5-rt2/mm/slob.c
===================================================================
--- linux-2.6.15-rc5-rt2.orig/mm/slob.c	2005-12-19 18:00:01.000000000 -0500
+++ linux-2.6.15-rc5-rt2/mm/slob.c	2005-12-20 10:16:39.000000000 -0500
@@ -27,6 +27,20 @@
  * are allocated by calling __get_free_pages. As SLAB objects know
  * their size, no separate size bookkeeping is necessary and there is
  * essentially no allocation space overhead.
+ *
+ * Modified by: Steven Rostedt <rostedt@goodmis.org> 12/20/05
+ *
+ * Now we take advantage of the kmem_cache usage.  I've removed
+ * the global slobfree, and created one for every cache.
+ *
+ * For kmalloc/kfree I've reintroduced the usage of cache_sizes,
+ * but only for sizes 32 through PAGE_SIZE >> 1 by order of 2.
+ *
+ * Having the SLOB alloc per size of the cache should speed things up
+ * greatly, not only by making the search paths smaller, but also by
+ * keeping all the caches of similar units.  This way the fragmentation
+ * should not be as big of a problem.
+ *
  */
 
 #include <linux/config.h>
@@ -37,6 +51,8 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 
+#undef DEBUG_CACHE
+
 struct slob_block {
 	int units;
 	struct slob_block *next;
@@ -53,17 +69,66 @@
 };
 typedef struct bigblock bigblock_t;
 
-static slob_t arena = { .next = &arena, .units = 1 };
-static slob_t *slobfree = &arena;
-static DEFINE_SPINLOCK(slob_lock);
+struct kmem_cache {
+	unsigned int size, align;
+	const char *name;
+	slob_t *slobfree;
+	slob_t arena;
+	spinlock_t lock;
+	void (*ctor)(void *, struct kmem_cache *, unsigned long);
+	void (*dtor)(void *, struct kmem_cache *, unsigned long);
+	atomic_t items;
+	unsigned int free;
+	struct list_head list;
+};
 
-#define __get_slob_block(b) ((unsigned long)(b) & ~(PAGE_SIZE-1))
+#define NR_SLOB_CACHES ((PAGE_SHIFT) - 5) /* 32 to PAGE_SIZE-1 by order of 2 */
+#define MAX_SLOB_CACHE_SIZE (PAGE_SIZE >> 1)
 
-static inline struct page *get_slob_page(const void *mem)
+static struct kmem_cache *cache_sizes[NR_SLOB_CACHES];
+static struct kmem_cache *bb_cache;
+
+static struct semaphore	cache_chain_sem;
+static struct list_head cache_chain;
+
+#ifdef DEBUG_CACHE
+static void test_cache(kmem_cache_t *c)
 {
-	void *virt = (void*)__get_slob_block(mem);
+	slob_t *cur = c->slobfree;
+	unsigned int x = -1 >> 2;
 
-	return virt_to_page(virt);
+	do {
+		BUG_ON(!cur->next);
+		cur = cur->next;
+	} while (cur != c->slobfree && --x);
+	BUG_ON(!x);
+}
+#else
+#define test_cache(x) do {} while(0)
+#endif
+
+/*
+ * Here we take advantage of the lru field of the pages that
+ * map to the pages we use in the SLOB.  This is done similar
+ * to what is done with SLAB.
+ *
+ * The lru.next field is used to get the bigblock descriptor
+ *    for large blocks larger than PAGE_SIZE >> 1.
+ *
+ * Set and retrieved by set_slob_block and get_slob_block
+ * respectively.
+ *
+ * The lru.prev field is used to find the cache descriptor
+ *   for small blocks smaller than or equal to PAGE_SIZE >> 1.
+ *
+ * Set and retrieved by set_slob_ptr and get_slob_ptr
+ * respectively.
+ *
+ * The use of lru.next tells us in kmalloc that the page is large.
+ */
+static inline struct page *get_slob_page(const void *mem)
+{
+	return virt_to_page(mem);
 }
 
 static inline void zero_slob_block(const void *b)
@@ -87,18 +152,39 @@
 	page->lru.next = data;
 }
 
-static void slob_free(void *b, int size);
+static inline void *get_slob_ptr(const void *b)
+{
+	struct page *page;
+	page = get_slob_page(b);
+	return page->lru.prev;
+}
+
+static inline void set_slob_ptr(const void *b, void *data)
+{
+	struct page *page;
+	page = get_slob_page(b);
+	page->lru.prev = data;
+}
+
+static void slob_free(kmem_cache_t *cachep, void *b, int size);
 
-static void *slob_alloc(size_t size, gfp_t gfp, int align)
+static void *slob_alloc(kmem_cache_t *cachep, gfp_t gfp, int align)
 {
+	size_t size;
 	slob_t *prev, *cur, *aligned = 0;
-	int delta = 0, units = SLOB_UNITS(size);
+	int delta = 0, units;
 	unsigned long flags;
 
-	spin_lock_irqsave(&slob_lock, flags);
-	prev = slobfree;
+	size = cachep->size;
+	units = SLOB_UNITS(size);
+	BUG_ON(!units);
+
+	spin_lock_irqsave(&cachep->lock, flags);
+	prev = cachep->slobfree;
 	for (cur = prev->next; ; prev = cur, cur = cur->next) {
 		if (align) {
+			while (align < SLOB_UNIT)
+				align <<= 1;
 			aligned = (slob_t *)ALIGN((unsigned long)cur, align);
 			delta = aligned - cur;
 		}
@@ -121,12 +207,16 @@
 				cur->units = units;
 			}
 
-			slobfree = prev;
-			spin_unlock_irqrestore(&slob_lock, flags);
+			cachep->slobfree = prev;
+			test_cache(cachep);
+			if (prev < prev->next)
+				BUG_ON(cur + cur->units > prev->next);
+			spin_unlock_irqrestore(&cachep->lock, flags);
 			return cur;
 		}
-		if (cur == slobfree) {
-			spin_unlock_irqrestore(&slob_lock, flags);
+		if (cur == cachep->slobfree) {
+			test_cache(cachep);
+			spin_unlock_irqrestore(&cachep->lock, flags);
 
 			if (size == PAGE_SIZE) /* trying to shrink arena? */
 				return 0;
@@ -136,14 +226,15 @@
 				return 0;
 
 			zero_slob_block(cur);
-			slob_free(cur, PAGE_SIZE);
-			spin_lock_irqsave(&slob_lock, flags);
-			cur = slobfree;
+			set_slob_ptr(cur, cachep);
+			slob_free(cachep, cur, PAGE_SIZE);
+			spin_lock_irqsave(&cachep->lock, flags);
+			cur = cachep->slobfree;
 		}
 	}
 }
 
-static void slob_free(void *block, int size)
+static void slob_free(kmem_cache_t *cachep, void *block, int size)
 {
 	slob_t *cur, *b = (slob_t *)block;
 	unsigned long flags;
@@ -155,26 +246,29 @@
 		b->units = SLOB_UNITS(size);
 
 	/* Find reinsertion point */
-	spin_lock_irqsave(&slob_lock, flags);
-	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
+	spin_lock_irqsave(&cachep->lock, flags);
+	for (cur = cachep->slobfree; !(b > cur && b < cur->next); cur = cur->next)
 		if (cur >= cur->next && (b > cur || b < cur->next))
 			break;
 
 	if (b + b->units == cur->next) {
 		b->units += cur->next->units;
 		b->next = cur->next->next;
+		BUG_ON(cur->next == &cachep->arena);
 	} else
 		b->next = cur->next;
 
 	if (cur + cur->units == b) {
 		cur->units += b->units;
 		cur->next = b->next;
+		BUG_ON(b == &cachep->arena);
 	} else
 		cur->next = b;
 
-	slobfree = cur;
+	cachep->slobfree = cur;
 
-	spin_unlock_irqrestore(&slob_lock, flags);
+	test_cache(cachep);
+	spin_unlock_irqrestore(&cachep->lock, flags);
 }
 
 static int FASTCALL(find_order(int size));
@@ -188,15 +282,24 @@
 
 void *kmalloc(size_t size, gfp_t gfp)
 {
-	slob_t *m;
 	bigblock_t *bb;
 
-	if (size < PAGE_SIZE - SLOB_UNIT) {
-		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
-		return m ? (void *)(m + 1) : 0;
+	/*
+	 * If the size is less than PAGE_SIZE >> 1 then
+	 * we use the generic caches.  Otherwise, we
+	 * just allocate the necessary pages.
+	 */
+	if (size <= MAX_SLOB_CACHE_SIZE) {
+		int i;
+		int order;
+		for (i=0, order=32; i < NR_SLOB_CACHES; i++, order <<= 1)
+			if (size <= order)
+				break;
+		BUG_ON(i == NR_SLOB_CACHES);
+		return kmem_cache_alloc(cache_sizes[i], gfp);
 	}
 
-	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
+	bb = slob_alloc(bb_cache, gfp, 0);
 	if (!bb)
 		return 0;
 
@@ -208,7 +311,7 @@
 		return bb->pages;
 	}
 
-	slob_free(bb, sizeof(bigblock_t));
+	slob_free(bb_cache, bb, sizeof(bigblock_t));
 	return 0;
 }
 
@@ -216,19 +319,26 @@
 
 void kfree(const void *block)
 {
+	kmem_cache_t *c;
 	bigblock_t *bb;
 
 	if (!block)
 		return;
 
+	/*
+	 * look into the page of the allocated block to
+	 * see if this is a big allocation or not.
+	 */
 	bb = get_slob_block(block);
 	if (bb) {
 		free_pages((unsigned long)block, bb->order);
-		slob_free(bb, sizeof(bigblock_t));
+		slob_free(bb_cache, bb, sizeof(bigblock_t));
 		return;
 	}
 
-	slob_free((slob_t *)block - 1, 0);
+	c = get_slob_ptr(block);
+	kmem_cache_free(c, (void *)block);
+
 	return;
 }
 
@@ -237,6 +347,7 @@
 unsigned int ksize(const void *block)
 {
 	bigblock_t *bb;
+	kmem_cache_t *c;
 
 	if (!block)
 		return 0;
@@ -245,14 +356,16 @@
 	if (bb)
 		return PAGE_SIZE << bb->order;
 
-	return ((slob_t *)block - 1)->units * SLOB_UNIT;
+	c = get_slob_ptr(block);
+	return c->size;
 }
 
-struct kmem_cache {
-	unsigned int size, align;
-	const char *name;
-	void (*ctor)(void *, struct kmem_cache *, unsigned long);
-	void (*dtor)(void *, struct kmem_cache *, unsigned long);
+static slob_t cache_arena = { .next = &cache_arena, .units = 0 };
+struct kmem_cache cache_cache = {
+	.name = "cache",
+	.slobfree = &cache_cache.arena,
+	.arena = { .next = &cache_cache.arena, .units = 0 },
+	.lock = SPIN_LOCK_UNLOCKED(cache_cache.lock)
 };
 
 struct kmem_cache *kmem_cache_create(const char *name, size_t size,
@@ -261,8 +374,22 @@
 	void (*dtor)(void*, struct kmem_cache *, unsigned long))
 {
 	struct kmem_cache *c;
+	void *p;
+
+	c = slob_alloc(&cache_cache, flags, 0);
+
+	memset(c, 0, sizeof(*c));
 
-	c = slob_alloc(sizeof(struct kmem_cache), flags, 0);
+	c->size = PAGE_SIZE;
+	c->arena.next = &c->arena;
+	c->arena.units = 0;
+	c->slobfree = &c->arena;
+	atomic_set(&c->items, 0);
+	spin_lock_init(&c->lock);
+
+	p = slob_alloc(c, 0, PAGE_SIZE-1);
+	if (p)
+		free_page((unsigned long)p);
 
 	if (c) {
 		c->name = name;
@@ -274,6 +401,9 @@
 		if (c->align < align)
 			c->align = align;
 	}
+	down(&cache_chain_sem);
+	list_add_tail(&c->list, &cache_chain);
+	up(&cache_chain_sem);
 
 	return c;
 }
@@ -281,7 +411,17 @@
 
 int kmem_cache_destroy(struct kmem_cache *c)
 {
-	slob_free(c, sizeof(struct kmem_cache));
+	down(&cache_chain_sem);
+	list_del(&c->list);
+	up(&cache_chain_sem);
+
+	BUG_ON(atomic_read(&c->items));
+
+	/*
+	 * WARNING!!! Memory leak!
+	 */
+	printk("FIX ME: need to free memory\n");
+	slob_free(&cache_cache, c, sizeof(struct kmem_cache));
 	return 0;
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
@@ -290,11 +430,16 @@
 {
 	void *b;
 
-	if (c->size < PAGE_SIZE)
-		b = slob_alloc(c->size, flags, c->align);
+	atomic_inc(&c->items);
+
+	if (c->size <= MAX_SLOB_CACHE_SIZE)
+		b = slob_alloc(c, flags, c->align);
 	else
 		b = (void *)__get_free_pages(flags, find_order(c->size));
 
+	if (!b)
+		return 0;
+
 	if (c->ctor)
 		c->ctor(b, c, SLAB_CTOR_CONSTRUCTOR);
 
@@ -304,11 +449,13 @@
 
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
+	atomic_dec(&c->items);
+
 	if (c->dtor)
 		c->dtor(b, c, 0);
 
-	if (c->size < PAGE_SIZE)
-		slob_free(b, c->size);
+	if (c->size <= MAX_SLOB_CACHE_SIZE)
+		slob_free(c, b, c->size);
 	else
 		free_pages((unsigned long)b, find_order(c->size));
 }
@@ -326,22 +473,62 @@
 }
 EXPORT_SYMBOL(kmem_cache_name);
 
-static struct timer_list slob_timer = TIMER_INITIALIZER(
-	(void (*)(unsigned long))kmem_cache_init, 0, 0);
+static char cache_names[NR_SLOB_CACHES][15];
 
 void kmem_cache_init(void)
 {
-	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
+	static int done;
+	void *p;
 
-	if (p)
-		free_page((unsigned long)p);
-
-	mod_timer(&slob_timer, jiffies + HZ);
+	if (!done) {
+		int i;
+		int size = 32;
+		done = 1;
+
+		init_MUTEX(&cache_chain_sem);
+		INIT_LIST_HEAD(&cache_chain);
+
+		cache_cache.size = PAGE_SIZE;
+		p = slob_alloc(&cache_cache, 0, PAGE_SIZE-1);
+		if (p)
+			free_page((unsigned long)p);
+		cache_cache.size = sizeof(struct kmem_cache);
+
+		bb_cache = kmem_cache_create("bb_cache",sizeof(bigblock_t), 0,
+					     GFP_KERNEL, NULL, NULL);
+		for (i=0; i < NR_SLOB_CACHES; i++, size <<= 1)
+			cache_sizes[i] = kmem_cache_create(cache_names[i], size, 0,
+							   GFP_KERNEL, NULL, NULL);
+	}
 }
 
 atomic_t slab_reclaim_pages = ATOMIC_INIT(0);
 EXPORT_SYMBOL(slab_reclaim_pages);
 
+static void test_slob(slob_t *s)
+{
+	slob_t *p;
+	long x = 0;
+
+	for (p=s->next; p != s && x < 10000; p = p->next, x++)
+		printk(".");
+}
+
+void print_slobs(void)
+{
+	struct list_head *curr;
+
+	list_for_each(curr, &cache_chain) {
+		kmem_cache_t *c = list_entry(curr, struct kmem_cache, list);
+
+		printk("%s items:%d",
+		       c->name?:"<none>",
+		       atomic_read(&c->items));
+		test_slob(&c->arena);
+		printk("\n");
+	}
+}
+
 #ifdef CONFIG_SMP
 
 void *__alloc_percpu(size_t size, size_t align)


