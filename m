Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVENHnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVENHnN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 03:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVENHnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 03:43:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:39103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262698AbVENHmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 03:42:49 -0400
Date: Sat, 14 May 2005 00:42:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
Message-Id: <20050514004204.2302dc52.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505131823210.12315@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	<20050512000444.641f44a9.akpm@osdl.org>
	<Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
	<20050513000648.7d341710.akpm@osdl.org>
	<Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
	<20050513043311.7961e694.akpm@osdl.org>
	<Pine.LNX.4.62.0505131823210.12315@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> This patch allows kmalloc_node to be as fast as kmalloc by introducing
> node specific page lists for partial, free and full slabs.

Oh drat - what happened to all the coding-style fixups?  Redone patch
below.  Please merge - slab.c is already not a nice place to visit.

> +#ifndef CONFIG_NUMA
> +#if MAX_NUMNODES != 1
> +#error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
> +#endif
> +#endif

Well that's doing to make it fail to compile at all on ppc64.

>  {
>  #ifdef CONFIG_SMP
>  	check_irq_off();
> -	BUG_ON(spin_trylock(&cachep->spinlock));
> +	BUG_ON(spin_trylock(&list3_data(cachep)->list_lock));
> +#endif

We can use assert_spin_lcoked() here now btw.


I hacked things to compile by setting NDOES_SHIFT to zero and the machine
boots.  I'll leave that hack in place for the while, so -mm is busted on
ppc64 NUMA.  Please sort things out with the ppc64 guys?


diff -puN mm/slab.c~numa-aware-slab-allocator-v2-tidy mm/slab.c
--- 25/mm/slab.c~numa-aware-slab-allocator-v2-tidy	2005-05-14 00:08:02.000000000 -0700
+++ 25-akpm/mm/slab.c	2005-05-14 00:16:41.000000000 -0700
@@ -356,7 +356,7 @@ static inline int index_of(const size_t 
 		(parent)->list_lock = SPIN_LOCK_UNLOCKED;	\
 		(parent)->free_objects = 0;	\
 		(parent)->free_touched = 0;	\
-	} while(0)
+	} while (0)
 #else
 
 #define LIST3_INIT(parent) \
@@ -368,21 +368,21 @@ static inline int index_of(const size_t 
 		(parent)->list_lock = SPIN_LOCK_UNLOCKED;	\
 		(parent)->free_objects = 0;	\
 		(parent)->free_touched = 0;	\
-	} while(0)
+	} while (0)
 #endif
 
 #define MAKE_LIST(cachep, listp, slab, nodeid)	\
 	do {	\
 		INIT_LIST_HEAD(listp);		\
 		list_splice(&(cachep->nodelists[nodeid]->slab), listp); \
-	}while(0)
+	} while (0)
 
 #define	MAKE_ALL_LISTS(cachep, ptr, nodeid)			\
 	do {					\
 	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
-	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid);	\
+	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
 	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
-	}while(0)
+	} while (0)
 
 #define list3_data(cachep) \
 	((cachep->nodelists[numa_node_id()]))
@@ -807,15 +807,15 @@ static inline struct array_cache **alloc
 	if (limit > 1)
 		limit = 12;
 	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
-	if(ac_ptr) {
+	if (ac_ptr) {
 		for (i = 0; i < MAX_NUMNODES; i++) {
 			if (i == node) {
 				ac_ptr[i] = NULL;
 				continue;
 			}
 			ac_ptr[i] = alloc_arraycache(cpu, limit, 0xbaadf00d);
-			if(!ac_ptr[i]) {
-				for(i--; i <=0; i--)
+			if (!ac_ptr[i]) {
+				for (i--; i <=0; i--)
 					kfree(ac_ptr[i]);
 				kfree(ac_ptr);
 				return NULL;
@@ -829,7 +829,7 @@ static inline void free_alien_cache(stru
 {
 	int i;
 
-	if(!ac_ptr)
+	if (!ac_ptr)
 		return;
 	for (i = 0; i < MAX_NUMNODES; i++)
 		kfree(ac_ptr[i]);
@@ -841,7 +841,7 @@ static inline void __drain_alien_cache(k
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
-	if(ac->avail) {
+	if (ac->avail) {
 		spin_lock(&rl3->list_lock);
 		free_block(cachep, ac->entry, ac->avail);
 		ac->avail = 0;
@@ -857,7 +857,7 @@ static void drain_alien_cache(kmem_cache
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		ac = l3->alien[i];
-		if(ac) {
+		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
 			__drain_alien_cache(cachep, ac, i);
 			spin_unlock_irqrestore(&ac->lock, flags);
@@ -891,12 +891,12 @@ static int __devinit cpuup_callback(stru
 			 * node has not already allocated this
 			 */
 			if (!cachep->nodelists[node]) {
-				if(!(l3 = kmalloc_node(memsize,
+				if (!(l3 = kmalloc_node(memsize,
 						GFP_KERNEL, node)))
 					goto bad;
 				LIST3_INIT(l3);
 				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+				  ((unsigned long)cachep)%REAPTIMEOUT_LIST3;
 
 				cachep->nodelists[node] = l3;
 			}
@@ -919,8 +919,8 @@ static int __devinit cpuup_callback(stru
 
 			l3 = cachep->nodelists[node];
 			BUG_ON(!l3);
-			if(!l3->shared) {
-				if(!(nc = alloc_arraycache(cpu,
+			if (!l3->shared) {
+				if (!(nc = alloc_arraycache(cpu,
 					cachep->shared*cachep->batchcount,
 					0xbaadf00d)))
 					goto  bad;
@@ -952,29 +952,29 @@ static int __devinit cpuup_callback(stru
 			cachep->array[cpu] = NULL;
 			l3 = cachep->nodelists[node];
 
-			if(!l3)
+			if (!l3)
 				goto unlock_cache;
 
 			spin_lock(&l3->list_lock);
 
 			/* Free limit for this kmem_list3 */
 			l3->free_limit -= cachep->batchcount;
-			if(nc)
+			if (nc)
 				free_block(cachep, nc->entry, nc->avail);
 
-			if(!cpus_empty(mask)) {
+			if (!cpus_empty(mask)) {
                                 spin_unlock(&l3->list_lock);
                                 goto unlock_cache;
                         }
 
-			if(l3->shared) {
+			if (l3->shared) {
 				free_block(cachep, l3->shared->entry,
 						l3->shared->avail);
 				kfree(l3->shared);
 				l3->shared = NULL;
 			}
 #ifdef CONFIG_NUMA
-			if(l3->alien) {
+			if (l3->alien) {
 				drain_alien_cache(cachep, l3);
 				free_alien_cache(l3->alien);
 				l3->alien = NULL;
@@ -982,13 +982,13 @@ static int __devinit cpuup_callback(stru
 #endif
 
 			/* free slabs belonging to this node */
-			if(__node_shrink(cachep, node)) {
+			if (__node_shrink(cachep, node)) {
 				cachep->nodelists[node] = NULL;
 				spin_unlock(&l3->list_lock);
 				kfree(l3);
-			}
-			else
+			} else {
 				spin_unlock(&l3->list_lock);
+			}
 unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
@@ -1034,7 +1034,7 @@ void __init kmem_cache_init(void)
 	struct cache_names *names;
 	int i;
 
-	for(i = 0; i < NUM_INIT_LISTS; i++) {
+	for (i = 0; i < NUM_INIT_LISTS; i++) {
 		LIST3_INIT(&initkmem_list3[i]);
 		if (i < MAX_NUMNODES)
 			cache_cache.nodelists[i] = NULL;
@@ -1101,16 +1101,19 @@ void __init kmem_cache_init(void)
 				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
 
 	if (INDEX_AC != INDEX_L3)
-		sizes[INDEX_L3].cs_cachep = kmem_cache_create(names[INDEX_L3].name,
-					 sizes[INDEX_L3].cs_size, ARCH_KMALLOC_MINALIGN,
-					 (ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+		sizes[INDEX_L3].cs_cachep =
+			kmem_cache_create(names[INDEX_L3].name,
+				sizes[INDEX_L3].cs_size, ARCH_KMALLOC_MINALIGN,
+				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
 
 	while (sizes->cs_size != ULONG_MAX) {
-		/* For performance, all the general caches are L1 aligned.
+		/*
+		 * For performance, all the general caches are L1 aligned.
 		 * This should be particularly beneficial on SMP boxes, as it
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
-		 * allow tighter packing of the smaller caches. */
+		 * allow tighter packing of the smaller caches.
+		 */
 		if(!sizes->cs_cachep)
 			sizes->cs_cachep = kmem_cache_create(names->name,
 				sizes->cs_size, ARCH_KMALLOC_MINALIGN,
@@ -1150,7 +1153,8 @@ void __init kmem_cache_init(void)
 				!= &initarray_generic.cache);
 		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
 				sizeof(struct arraycache_init));
-		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] = ptr;
+		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
+						ptr;
 		local_irq_enable();
 	}
 	/* 5) Replace the bootstrap kmem_list3's */
@@ -1160,8 +1164,8 @@ void __init kmem_cache_init(void)
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
 				numa_node_id());
 
-		for (j=0; j < MAX_NUMNODES; j++) {
-			if(is_node_online(j))
+		for (j = 0; j < MAX_NUMNODES; j++) {
+			if (is_node_online(j))
 				init_list(malloc_sizes[INDEX_L3].cs_cachep,
 						&initkmem_list3[SIZE_L3+j], j);
 		}
@@ -1489,8 +1493,9 @@ static void slab_destroy (kmem_cache_t *
 static inline void set_up_list3s(kmem_cache_t *cachep)
 {
 	int i;
-	for(i = 0; i < MAX_NUMNODES; i++) {
-		if(is_node_online(i)) {
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (is_node_online(i)) {
 			cachep->nodelists[i] = &initkmem_list3[SIZE_L3+i];
 			cachep->nodelists[i]->next_reap = jiffies +
 				REAPTIMEOUT_LIST3 +
@@ -1939,14 +1944,14 @@ static void drain_cpu_caches(kmem_cache_
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	for(i = 0; i < MAX_NUMNODES; i++)  {
+	for (i = 0; i < MAX_NUMNODES; i++)  {
 		l3 = cachep->nodelists[i];
 		if (l3) {
 			spin_lock(&l3->list_lock);
 			drain_array_locked(cachep, l3->shared, 1, i);
 			spin_unlock(&l3->list_lock);
 #ifdef CONFIG_NUMA
-			if(l3->alien)
+			if (l3->alien)
 				drain_alien_cache(cachep, l3);
 #endif
 		}
@@ -2074,7 +2079,7 @@ int kmem_cache_destroy(kmem_cache_t * ca
 		kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
-	for(i = 0; i < MAX_NUMNODES; i++) {
+	for (i = 0; i < MAX_NUMNODES; i++) {
 		if ((l3 = cachep->nodelists[i])) {
 			kfree(l3->shared);
 #ifdef CONFIG_NUMA
@@ -2092,8 +2097,8 @@ int kmem_cache_destroy(kmem_cache_t * ca
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep,
-			void *objp, int colour_off, unsigned int __nocast local_flags)
+static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
+			int colour_off, unsigned int __nocast local_flags)
 {
 	struct slab *slabp;
 	
@@ -2124,7 +2129,7 @@ static void cache_init_objs(kmem_cache_t
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void* objp = slabp->s_mem+cachep->objsize*i;
+		void *objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -2806,8 +2811,7 @@ static inline void __cache_free(kmem_cac
 							alien, nodeid);
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
-			}
-			else {
+			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
 						list_lock);
 				free_block(cachep, &objp, 1);
@@ -3196,7 +3200,7 @@ static int alloc_kmemlist(kmem_cache_t *
 	struct kmem_list3 *l3;
 	int err = 0;
 
-	for(i=0; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS; i++) {
 		if (cpu_online(i)) {
 			struct array_cache *nc = NULL, *new;
 #ifdef CONFIG_NUMA
_

