Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWACU1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWACU1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWACU0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:26:08 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964787AbWACU0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:26:02 -0500
Subject: [patch 9/9] slab: rename ac_data to cpu_cache_get
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:26:00 +0200
Message-Id: <1136319961.8629.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch renames the ac_data() function to more descriptive cpu_cache_get().

Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -677,7 +677,7 @@ static void enable_cpucache (kmem_cache_
 static void cache_reap (void *unused);
 static int __node_shrink(kmem_cache_t *cachep, int node);
 
-static inline struct array_cache *ac_data(kmem_cache_t *cachep)
+static inline struct array_cache *cpu_cache_get(kmem_cache_t *cachep)
 {
 	return cachep->array[smp_processor_id()];
 }
@@ -1173,8 +1173,8 @@ void __init kmem_cache_init(void)
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
 		local_irq_disable();
-		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
-		memcpy(ptr, ac_data(&cache_cache),
+		BUG_ON(cpu_cache_get(&cache_cache) != &initarray_cache.cache);
+		memcpy(ptr, cpu_cache_get(&cache_cache),
 				sizeof(struct arraycache_init));
 		cache_cache.array[smp_processor_id()] = ptr;
 		local_irq_enable();
@@ -1182,9 +1182,9 @@ void __init kmem_cache_init(void)
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
 		local_irq_disable();
-		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)
+		BUG_ON(cpu_cache_get(malloc_sizes[INDEX_AC].cs_cachep)
 				!= &initarray_generic.cache);
-		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
+		memcpy(ptr, cpu_cache_get(malloc_sizes[INDEX_AC].cs_cachep),
 				sizeof(struct arraycache_init));
 		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
 						ptr;
@@ -1881,11 +1881,11 @@ next:
 			jiffies + REAPTIMEOUT_LIST3 +
 			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
 
-		BUG_ON(!ac_data(cachep));
-		ac_data(cachep)->avail = 0;
-		ac_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
-		ac_data(cachep)->batchcount = 1;
-		ac_data(cachep)->touched = 0;
+		BUG_ON(!cpu_cache_get(cachep));
+		cpu_cache_get(cachep)->avail = 0;
+		cpu_cache_get(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
+		cpu_cache_get(cachep)->batchcount = 1;
+		cpu_cache_get(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
 	} 
@@ -1964,7 +1964,7 @@ static void do_drain(void *arg)
 	int node = numa_node_id();
 
 	check_irq_off();
-	ac = ac_data(cachep);
+	ac = cpu_cache_get(cachep);
 	spin_lock(&cachep->nodelists[node]->list_lock);
 	free_block(cachep, ac->entry, ac->avail, node);
 	spin_unlock(&cachep->nodelists[node]->list_lock);
@@ -2477,7 +2477,7 @@ static void *cache_alloc_refill(kmem_cac
 	struct array_cache *ac;
 
 	check_irq_off();
-	ac = ac_data(cachep);
+	ac = cpu_cache_get(cachep);
 retry:
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
@@ -2549,7 +2549,7 @@ alloc_done:
 		x = cache_grow(cachep, flags, numa_node_id());
 
 		// cache_grow can reenable interrupts, then ac could change.
-		ac = ac_data(cachep);
+		ac = cpu_cache_get(cachep);
 		if (!x && ac->avail == 0)	// no objects in sight? abort
 			return NULL;
 
@@ -2621,7 +2621,7 @@ static inline void *____cache_alloc(kmem
 	struct array_cache *ac;
 
 	check_irq_off();
-	ac = ac_data(cachep);
+	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
 		STATS_INC_ALLOCHIT(cachep);
 		ac->touched = 1;
@@ -2815,7 +2815,7 @@ free_done:
  */
 static inline void __cache_free(kmem_cache_t *cachep, void *objp)
 {
-	struct array_cache *ac = ac_data(cachep);
+	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
@@ -3212,7 +3212,7 @@ static void do_ccupdate_local(void *info
 	struct array_cache *old;
 
 	check_irq_off();
-	old = ac_data(new->cachep);
+	old = cpu_cache_get(new->cachep);
 
 	new->cachep->array[smp_processor_id()] = new->new[smp_processor_id()];
 	new->new[smp_processor_id()] = old;
@@ -3377,7 +3377,7 @@ static void cache_reap(void *unused)
 			drain_alien_cache(searchp, l3);
 		spin_lock_irq(&l3->list_lock);
 
-		drain_array_locked(searchp, ac_data(searchp), 0,
+		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
 				numa_node_id());
 
 		if (time_after(l3->next_reap, jiffies))

--


