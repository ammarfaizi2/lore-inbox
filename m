Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313559AbSDMGGS>; Sat, 13 Apr 2002 02:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314191AbSDMGGR>; Sat, 13 Apr 2002 02:06:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313559AbSDMGGP>;
	Sat, 13 Apr 2002 02:06:15 -0400
Message-ID: <3CB7CAF0.FC2768B8@zip.com.au>
Date: Fri, 12 Apr 2002 23:06:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] move the mempool list_head out of the managed elements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The mempool code embeds a list_head inside the managed objects.

This is a problem when the mempool client wishes that memory to be in a
known state.  For example, the radix-tree pagecache code backs the
mempool by a slab cache allocator, with a constructor which clears the
memory.

But when the page allocator starts failing, and radix tree node
allocations are satisfied from the mempool, they come back with a
defunct list_head at the first eight bytes, and the ratcache dies
in subtle ways.

A nasty part about this is that the problem only exhibits under very
high load.

I considered extending mempool so the client could pass in a special
constructor which just puts those eight bytes into a known state, but
this is not really adequate because that memory may simply not be
reconstructable in that context.

In highmem.c, the object being managed is actually a struct page.  So
the mempool code is overwriting the page frame structure with a
list_head.  This just happens to work, because that part of the page
struct is the page's own list_head, which is not used at that time. 
But ugh.

Also, RAID1 is assuming that the mempooled memory is all zeroed,
but that will not the case when page allocations start to fail.



The patch converts the mempool's intrusive list into a non-intrusive
one.  So mempool never alters the objects which it is managing.


--- 2.5.8-pre3/include/linux/mempool.h~mempool-node	Fri Apr 12 22:59:29 2002
+++ 2.5.8-pre3-akpm/include/linux/mempool.h	Fri Apr 12 22:59:30 2002
@@ -7,13 +7,27 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 
-struct mempool_s;
-typedef struct mempool_s mempool_t;
-
 typedef void * (mempool_alloc_t)(int gfp_mask, void *pool_data);
 typedef void (mempool_free_t)(void *element, void *pool_data);
 
-struct mempool_s {
+/*
+ * A structure for linking multiple client objects into
+ * a mempool_t
+ */
+typedef struct mempool_node_s {
+	struct list_head list;
+	void *element;
+} mempool_node_t;
+
+/*
+ * The elements list has full mempool_node_t's at ->next, and empty ones
+ * at ->prev.  Emptiness is signified by mempool_node_t.element == NULL.
+ *
+ * curr_nr refers to how many full mempool_node_t's are at ->elements.
+ * We don't track the total number of mempool_node_t's at ->elements;
+ * it is always equal to min_nr.
+ */
+typedef struct mempool_s {
 	spinlock_t lock;
 	int min_nr, curr_nr;
 	struct list_head elements;
@@ -22,7 +36,7 @@ struct mempool_s {
 	mempool_alloc_t *alloc;
 	mempool_free_t *free;
 	wait_queue_head_t wait;
-};
+} mempool_t;
 extern mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				 mempool_free_t *free_fn, void *pool_data);
 extern void mempool_resize(mempool_t *pool, int new_min_nr, int gfp_mask);
--- 2.5.8-pre3/mm/mempool.c~mempool-node	Fri Apr 12 22:59:30 2002
+++ 2.5.8-pre3-akpm/mm/mempool.c	Fri Apr 12 22:59:30 2002
@@ -25,8 +25,7 @@
  * memory pool. The pool can be used from the mempool_alloc and mempool_free
  * functions. This function might sleep. Both the alloc_fn() and the free_fn()
  * functions might sleep - as long as the mempool_alloc function is not called
- * from IRQ contexts. The element allocated by alloc_fn() must be able to
- * hold a struct list_head. (8 bytes on x86.)
+ * from IRQ contexts.
  */
 mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
@@ -51,28 +50,36 @@ mempool_t * mempool_create(int min_nr, m
 	pool->free = free_fn;
 
 	/*
-	 * First pre-allocate the guaranteed number of buffers.
+	 * First pre-allocate the guaranteed number of buffers
+	 * and nodes for them.
 	 */
 	for (i = 0; i < min_nr; i++) {
 		void *element;
-		struct list_head *tmp;
-		element = pool->alloc(GFP_KERNEL, pool->pool_data);
+		mempool_node_t *node;
+
+		node = kmalloc(sizeof(*node), GFP_KERNEL);
+		element = NULL;
+		if (node)
+			element = pool->alloc(GFP_KERNEL, pool->pool_data);
 
 		if (unlikely(!element)) {
 			/*
 			 * Not enough memory - free the allocated ones
-			 * and return:
+			 * and return.  `node' may be NULL here.
 			 */
-			list_for_each(tmp, &pool->elements) {
-				element = tmp;
-				pool->free(element, pool->pool_data);
+			kfree(node);
+			while (!list_empty(&pool->elements)) {
+				node = list_entry(pool->elements.next,
+						mempool_node_t, list);
+				list_del(&node->list);
+				pool->free(node->element, pool->pool_data);
+				kfree(node);
 			}
 			kfree(pool);
-
 			return NULL;
 		}
-		tmp = element;
-		list_add(tmp, &pool->elements);
+		node->element = element;
+		list_add(&node->list, &pool->elements);
 		pool->curr_nr++;
 	}
 	return pool;
@@ -97,9 +104,7 @@ mempool_t * mempool_create(int min_nr, m
 void mempool_resize(mempool_t *pool, int new_min_nr, int gfp_mask)
 {
 	int delta;
-	void *element;
 	unsigned long flags;
-	struct list_head *tmp;
 
 	if (new_min_nr <= 0)
 		BUG();
@@ -111,16 +116,19 @@ void mempool_resize(mempool_t *pool, int
 		 * Free possible excess elements.
 		 */
 		while (pool->curr_nr > pool->min_nr) {
-			tmp = pool->elements.next;
-			if (tmp == &pool->elements)
+			mempool_node_t *node;
+
+			if (list_empty(&pool->elements))
+				BUG();
+			node = list_entry(pool->elements.next,
+					mempool_node_t, list);
+			if (node->element == NULL)
 				BUG();
-			list_del(tmp);
-			element = tmp;
+			list_del(&node->list);
 			pool->curr_nr--;
 			spin_unlock_irqrestore(&pool->lock, flags);
-
-			pool->free(element, pool->pool_data);
-
+			pool->free(node->element, pool->pool_data);
+			kfree(node);
 			spin_lock_irqsave(&pool->lock, flags);
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
@@ -135,12 +143,23 @@ void mempool_resize(mempool_t *pool, int
 	 * (cannot) guarantee that the refill succeeds.
 	 */
 	while (delta) {
-		element = pool->alloc(gfp_mask, pool->pool_data);
-		if (!element)
+		mempool_node_t *node;
+
+		node = kmalloc(sizeof(*node), gfp_mask);
+		if (!node)
 			break;
-		mempool_free(element, pool);
+		node->element = pool->alloc(gfp_mask, pool->pool_data);
+		if (!node->element) {
+			kfree(node);
+			break;
+		}
+		spin_lock_irqsave(&pool->lock, flags);
+		list_add(&node->list, &pool->elements);
+		pool->curr_nr++;
+		spin_unlock_irqrestore(&pool->lock, flags);
 		delta--;
 	}
+	wake_up(&pool->wait);
 }
 
 /**
@@ -151,21 +170,27 @@ void mempool_resize(mempool_t *pool, int
  * this function only sleeps if the free_fn() function sleeps. The caller
  * has to guarantee that no mempool_alloc() nor mempool_free() happens in
  * this pool when calling this function.
+ *
+ * This function will go BUG() if there are outstanding elements in the
+ * pool.  The mempool client must put them all back before destroying the
+ * mempool.
  */
 void mempool_destroy(mempool_t *pool)
 {
-	void *element;
-	struct list_head *head, *tmp;
-
 	if (!pool)
 		return;
 
-	head = &pool->elements;
-	for (tmp = head->next; tmp != head; ) {
-		element = tmp;
-		tmp = tmp->next;
-		pool->free(element, pool->pool_data);
-		pool->curr_nr--;
+	while (!list_empty(&pool->elements)) {
+		mempool_node_t *node;
+
+		node = list_entry(pool->elements.prev,
+				mempool_node_t, list);
+		list_del(&node->list);
+		if (node->element) {
+			pool->curr_nr--;
+			pool->free(node->element, pool->pool_data);
+		}
+		kfree(node);
 	}
 	if (pool->curr_nr)
 		BUG();
@@ -187,7 +212,6 @@ void * mempool_alloc(mempool_t *pool, in
 {
 	void *element;
 	unsigned long flags;
-	struct list_head *tmp;
 	int curr_nr;
 	DECLARE_WAITQUEUE(wait, current);
 	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
@@ -214,9 +238,16 @@ repeat_alloc:
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {
-		tmp = pool->elements.next;
-		list_del(tmp);
-		element = tmp;
+		mempool_node_t *node;
+
+		node = list_entry(pool->elements.next,
+				mempool_node_t, list);
+		list_del(&node->list);
+		element = node->element;
+		if (element == NULL)
+			BUG();
+		node->element = NULL;
+		list_add_tail(&node->list, &pool->elements);
 		pool->curr_nr--;
 		spin_unlock_irqrestore(&pool->lock, flags);
 		return element;
@@ -262,7 +293,15 @@ void mempool_free(void *element, mempool
 	if (pool->curr_nr < pool->min_nr) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (pool->curr_nr < pool->min_nr) {
-			list_add(element, &pool->elements);
+			mempool_node_t *node;
+
+			node = list_entry(pool->elements.prev,
+					mempool_node_t, list);
+			list_del(&node->list);
+			if (node->element)
+				BUG();
+			node->element = element;
+			list_add(&node->list, &pool->elements);
 			pool->curr_nr++;
 			spin_unlock_irqrestore(&pool->lock, flags);
 			wake_up(&pool->wait);

-
