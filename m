Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTERIzv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 04:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTERIzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 04:55:51 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:1994 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261243AbTERIzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 04:55:45 -0400
Message-ID: <3EC74622.9070805@colorfullife.com>
Date: Sun, 18 May 2003 10:36:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Improve inter-cpu object passing in slab 1/3
Content-Type: multipart/mixed;
 boundary="------------020003070304050805040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020003070304050805040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

slab.c is not very efficient for passing objects between cpu. Usually 
this is a rare event, but with network routing and cpu bound interrupt 
handlers, it's possible that all alloc operations happen on one cpu, and 
all free operations on another cpu.

The attached patch solves that by adding a shared array for fast object 
transfer.

What do you think? The patch is against 2.5.69-bk12, it's already 
included in 2.5.69-mm6.

--
    Manfred

--------------020003070304050805040109
Content-Type: text/plain;
 name="slab-magazine-layer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab-magazine-layer.patch"


 mm/slab.c |  142 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 113 insertions(+), 29 deletions(-)

diff -puN mm/slab.c~slab-magazine-layer mm/slab.c
--- 25/mm/slab.c~slab-magazine-layer	2003-05-08 00:25:52.000000000 -0700
+++ 25-akpm/mm/slab.c	2003-05-08 00:25:52.000000000 -0700
@@ -201,6 +201,7 @@ struct arraycache_init {
  * into this structure, too. Figure out what causes
  * fewer cross-node spinlock operations.
  */
+#define SHARED_ARRAY_FACTOR	16
 struct kmem_list3 {
 	struct list_head	slabs_partial;	/* partial list first, better asm code */
 	struct list_head	slabs_full;
@@ -208,6 +209,7 @@ struct kmem_list3 {
 	unsigned long	free_objects;
 	int		free_touched;
 	unsigned long	next_reap;
+	struct array_cache	*shared;
 };
 
 #define LIST3_INIT(parent) \
@@ -1195,6 +1197,7 @@ static void smp_call_function_all_cpus(v
 }
 
 static void free_block (kmem_cache_t* cachep, void** objpp, int len);
+static void drain_array_locked(kmem_cache_t* cachep, struct array_cache *ac);
 
 static void do_drain(void *arg)
 {
@@ -1203,13 +1206,20 @@ static void do_drain(void *arg)
 
 	check_irq_off();
 	ac = ac_data(cachep);
+	spin_lock(&cachep->spinlock);
 	free_block(cachep, &ac_entry(ac)[0], ac->avail);
+	spin_unlock(&cachep->spinlock);
 	ac->avail = 0;
 }
 
 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
 	smp_call_function_all_cpus(do_drain, cachep);
+	check_irq_on();
+	spin_lock_irq(&cachep->spinlock);
+	if (cachep->lists.shared)
+		drain_array_locked(cachep, cachep->lists.shared);
+	spin_unlock_irq(&cachep->spinlock);
 }
 
 
@@ -1307,6 +1317,8 @@ int kmem_cache_destroy (kmem_cache_t * c
 		for (i = 0; i < NR_CPUS; i++)
 			kfree(cachep->array[i]);
 		/* NUMA: free the list3 structures */
+		kfree(cachep->lists.shared);
+		cachep->lists.shared = NULL;
 	}
 	kmem_cache_free(&cache_cache, cachep);
 
@@ -1649,6 +1661,19 @@ retry:
 
 	BUG_ON(ac->avail > 0);
 	spin_lock(&cachep->spinlock);
+	if (l3->shared) {
+		struct array_cache *shared_array = l3->shared;
+		if (shared_array->avail) {
+			if (batchcount > shared_array->avail)
+				batchcount = shared_array->avail;
+			shared_array->avail -= batchcount;
+			ac->avail = batchcount;
+			memcpy(ac_entry(ac), &ac_entry(shared_array)[shared_array->avail],
+					sizeof(void*)*batchcount);
+			shared_array->touched = 1;
+			goto alloc_done;
+		}
+	}
 	while (batchcount > 0) {
 		struct list_head *entry;
 		struct slab *slabp;
@@ -1672,6 +1697,7 @@ retry:
 
 must_grow:
 	l3->free_objects -= ac->avail;
+alloc_done:
 	spin_unlock(&cachep->spinlock);
 
 	if (unlikely(!ac->avail)) {
@@ -1770,13 +1796,11 @@ static inline void * __cache_alloc (kmem
  * the l3 structure
  */
 
-static inline void
-__free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
+static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
 {
 	int i;
 
-	check_irq_off();
-	spin_lock(&cachep->spinlock);
+	check_spinlock_acquired(cachep);
 
 	/* NUMA: move add into loop */
 	cachep->lists.free_objects += nr_objects;
@@ -1814,12 +1838,6 @@ __free_block(kmem_cache_t *cachep, void 
 				&list3_data_ptr(cachep, objp)->slabs_partial);
 		}
 	}
-	spin_unlock(&cachep->spinlock);
-}
-
-static void free_block(kmem_cache_t* cachep, void** objpp, int len)
-{
-	__free_block(cachep, objpp, len);
 }
 
 static void cache_flusharray (kmem_cache_t* cachep, struct array_cache *ac)
@@ -1831,14 +1849,28 @@ static void cache_flusharray (kmem_cache
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	__free_block(cachep, &ac_entry(ac)[0], batchcount);
+	spin_lock(&cachep->spinlock);
+	if (cachep->lists.shared) {
+		struct array_cache *shared_array = cachep->lists.shared;
+		int max = shared_array->limit-shared_array->avail;
+		if (max) {
+			if (batchcount > max)
+				batchcount = max;
+			memcpy(&ac_entry(shared_array)[shared_array->avail],
+					&ac_entry(ac)[0],
+					sizeof(void*)*batchcount);
+			shared_array->avail += batchcount;
+			goto free_done;
+		}
+	}
 
+	free_block(cachep, &ac_entry(ac)[0], batchcount);
+free_done:
 #if STATS
 	{
 		int i = 0;
 		struct list_head *p;
 
-		spin_lock(&cachep->spinlock);
 		p = list3_data(cachep)->slabs_free.next;
 		while (p != &(list3_data(cachep)->slabs_free)) {
 			struct slab *slabp;
@@ -1850,9 +1882,9 @@ static void cache_flusharray (kmem_cache
 			p = p->next;
 		}
 		STATS_SET_FREEABLE(cachep, i);
-		spin_unlock(&cachep->spinlock);
 	}
 #endif
+	spin_unlock(&cachep->spinlock);
 	ac->avail -= batchcount;
 	memmove(&ac_entry(ac)[0], &ac_entry(ac)[batchcount],
 			sizeof(void*)*ac->avail);
@@ -2096,6 +2128,7 @@ static void do_ccupdate_local(void *info
 static int do_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
 {
 	struct ccupdate_struct new;
+	struct array_cache *new_shared;
 	int i;
 
 	memset(&new.new,0,sizeof(new.new));
@@ -2129,11 +2162,29 @@ static int do_tune_cpucache (kmem_cache_
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
-		local_irq_disable();
+		spin_lock_irq(&cachep->spinlock);
 		free_block(cachep, ac_entry(ccold), ccold->avail);
-		local_irq_enable();
+		spin_unlock_irq(&cachep->spinlock);
 		kfree(ccold);
 	}
+	new_shared = kmalloc(sizeof(void*)*batchcount*SHARED_ARRAY_FACTOR+
+				sizeof(struct array_cache), GFP_KERNEL);
+	if (new_shared) {
+		struct array_cache *old;
+		new_shared->avail = 0;
+		new_shared->limit = batchcount*SHARED_ARRAY_FACTOR;
+		new_shared->batchcount = 0xbaadf00d;
+		new_shared->touched = 0;
+
+		spin_lock_irq(&cachep->spinlock);
+		old = cachep->lists.shared;
+		cachep->lists.shared = new_shared;
+		if (old)
+			free_block(cachep, ac_entry(old), old->avail);
+		spin_unlock_irq(&cachep->spinlock);
+		kfree(old);
+	}
+
 	return 0;
 }
 
@@ -2176,6 +2227,47 @@ static void enable_cpucache (kmem_cache_
 					cachep->name, -err);
 }
 
+static void drain_array(kmem_cache_t *cachep, struct array_cache *ac)
+{
+	int tofree;
+
+	check_irq_off();
+	if (ac->touched) {
+		ac->touched = 0;
+	} else if (ac->avail) {
+		tofree = (ac->limit+4)/5;
+		if (tofree > ac->avail) {
+			tofree = (ac->avail+1)/2;
+		}
+		spin_lock(&cachep->spinlock);
+		free_block(cachep, ac_entry(ac), tofree);
+		spin_unlock(&cachep->spinlock);
+		ac->avail -= tofree;
+		memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
+					sizeof(void*)*ac->avail);
+	}
+}
+
+static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac)
+{
+	int tofree;
+
+	check_spinlock_acquired(cachep);
+	if (ac->touched) {
+		ac->touched = 0;
+	} else if (ac->avail) {
+		tofree = (ac->limit+4)/5;
+		if (tofree > ac->avail) {
+			tofree = (ac->avail+1)/2;
+		}
+		free_block(cachep, ac_entry(ac), tofree);
+		ac->avail -= tofree;
+		memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
+					sizeof(void*)*ac->avail);
+	}
+}
+
+
 /**
  * cache_reap - Reclaim memory from caches.
  *
@@ -2202,7 +2294,6 @@ static inline void cache_reap (void)
 		kmem_cache_t *searchp;
 		struct list_head* p;
 		int tofree;
-		struct array_cache *ac;
 		struct slab *slabp;
 
 		searchp = list_entry(walk, kmem_cache_t, next);
@@ -2212,19 +2303,8 @@ static inline void cache_reap (void)
 
 		check_irq_on();
 		local_irq_disable();
-		ac = ac_data(searchp);
-		if (ac->touched) {
-			ac->touched = 0;
-		} else if (ac->avail) {
-			tofree = (ac->limit+4)/5;
-			if (tofree > ac->avail) {
-				tofree = (ac->avail+1)/2;
-			}
-			free_block(searchp, ac_entry(ac), tofree);
-			ac->avail -= tofree;
-			memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
-					sizeof(void*)*ac->avail);
-		}
+		drain_array(searchp, ac_data(searchp));
+
 		if(time_after(searchp->lists.next_reap, jiffies))
 			goto next_irqon;
 
@@ -2233,6 +2313,10 @@ static inline void cache_reap (void)
 			goto next_unlock;
 		}
 		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
+
+		if (searchp->lists.shared)
+			drain_array_locked(searchp, searchp->lists.shared);
+
 		if (searchp->lists.free_touched) {
 			searchp->lists.free_touched = 0;
 			goto next_unlock;

_

--------------020003070304050805040109--


