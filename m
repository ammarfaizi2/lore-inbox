Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVESFI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVESFI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 01:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVESFI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 01:08:28 -0400
Received: from graphe.net ([209.204.138.32]:5138 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262370AbVESFHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 01:07:37 -0400
Date: Wed, 18 May 2005 22:07:14 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Dave Hansen <haveblue@us.ibm.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <Pine.LNX.4.62.0505181439080.10598@graphe.net>
Message-ID: <Pine.LNX.4.62.0505182105310.17811@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Christoph Lameter wrote:

> Fixes to the slab allocator in 2.6.12-rc4-mm2
> - Remove MAX_NUMNODES check
> - use for_each_node/cpu
> - Fix determination of INDEX_AC

Rats! The whole thing with cpu online and node online is not as easy as I 
thought. There may be bugs in V3 of the numa slab allocator 
because offline cpus and offline are not properly handled. Maybe 
that also contributed to the ppc64 issues. 
 
The earlier patch fails if I boot an x86_64 NUMA kernel on a x86_64 single 
processor system.

Here is a revised patch. Would be good if someone could review my use 
of online_cpu / online_node etc. Is there some way to bring cpus 
online and offline to test if this really works? Seems that the code in 
alloc_percpu is suspect even in the old allocator because it may have
to allocate memory for non present cpus.

-----
Fixes to the slab allocator in 2.6.12-rc4-mm2

- Remove MAX_NUMNODES check
- use for_each_node/cpu
- Fix determination of INDEX_AC

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>

Index: linux-2.6.12-rc4/mm/slab.c
===================================================================
--- linux-2.6.12-rc4.orig/mm/slab.c	2005-05-18 21:20:49.000000000 -0700
+++ linux-2.6.12-rc4/mm/slab.c	2005-05-18 21:57:11.000000000 -0700
@@ -108,17 +108,6 @@
 #include	<asm/page.h>
 
 /*
- * Some Linux kernels currently have weird notions of NUMA. Make sure that
- * there is only a single node if CONFIG_NUMA is not set. Remove this check
- * after the situation has stabilized.
- */
-#ifndef CONFIG_NUMA
-#if MAX_NUMNODES != 1
-#error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
-#endif
-#endif
-
-/*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
  *		  0 for faster, smaller code (especially in the critical paths).
@@ -341,7 +330,7 @@ static inline int index_of(const size_t 
 	}
 }
 
-#define INDEX_AC index_of(sizeof(struct array_cache))
+#define INDEX_AC index_of(sizeof(struct arraycache_init))
 #define INDEX_L3 index_of(sizeof(struct kmem_list3))
 
 #ifdef CONFIG_NUMA
@@ -800,7 +789,7 @@ static inline struct array_cache **alloc
 		limit = 12;
 	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
 	if (ac_ptr) {
-		for (i = 0; i < MAX_NUMNODES; i++) {
+		for_each_online_node(i) {
 			if (i == node) {
 				ac_ptr[i] = NULL;
 				continue;
@@ -823,7 +812,8 @@ static inline void free_alien_cache(stru
 
 	if (!ac_ptr)
 		return;
-	for (i = 0; i < MAX_NUMNODES; i++)
+
+	for_each_online_node(i)
 		kfree(ac_ptr[i]);
 
 	kfree(ac_ptr);
@@ -847,7 +837,7 @@ static void drain_alien_cache(kmem_cache
 	struct array_cache *ac;
 	unsigned long flags;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_online_node(i) {
 		ac = l3->alien[i];
 		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
@@ -1197,10 +1187,8 @@ static int __init cpucache_init(void)
 	 * Register the timers that return unneeded
 	 * pages to gfp.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
-			start_cpu_timer(cpu);
-	}
+	for_each_online_cpu(cpu)
+		start_cpu_timer(cpu);
 
 	return 0;
 }
@@ -1986,7 +1974,7 @@ static int __cache_shrink(kmem_cache_t *
 	drain_cpu_caches(cachep);
 
 	check_irq_on();
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_online_node(i) {
 		l3 = cachep->nodelists[i];
 		if (l3) {
 			spin_lock_irq(&l3->list_lock);
@@ -2061,14 +2049,11 @@ int kmem_cache_destroy(kmem_cache_t * ca
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))
 		synchronize_rcu();
 
-	/* no cpu_online check required here since we clear the percpu
-	 * array on cpu offline and set this to NULL.
-	 */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_online_cpu(i)
 		kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_online_node(i) {
 		if ((l3 = cachep->nodelists[i])) {
 			kfree(l3->shared);
 #ifdef CONFIG_NUMA
@@ -2975,9 +2960,12 @@ void *__alloc_percpu(size_t size, size_t
 	if (!pdata)
 		return NULL;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	/*
+	 * Cannot use for_each_online cpus since a cpu may come online
+	 * and we have no way of figuring out how to fix the array
+	 * that we have allocated then....
+	 */
+	for_each_cpu (i) {
 		pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL,
 						cpu_to_node(i));
 
@@ -3075,11 +3063,11 @@ free_percpu(const void *objp)
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	/*
+	 * We allocate for all cpus so we cannot use for online cpu here.
+	 */
+	for_each_cpu(i)
 		kfree(p->ptrs[i]);
-	}
 	kfree(p);
 }
 EXPORT_SYMBOL(free_percpu);
@@ -3189,65 +3177,63 @@ static int alloc_kmemlist(kmem_cache_t *
 	struct kmem_list3 *l3;
 	int err = 0;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i)) {
-			struct array_cache *nc = NULL, *new;
+	for_each_online_cpu(i) {
+		struct array_cache *nc = NULL, *new;
 #ifdef CONFIG_NUMA
-			struct array_cache **new_alien = NULL;
+		struct array_cache **new_alien = NULL;
 #endif
-			node = cpu_to_node(i);
+		node = cpu_to_node(i);
 #ifdef CONFIG_NUMA
-			if (!(new_alien = alloc_alien_cache(i, cachep->limit)))
-				goto fail;
+		if (!(new_alien = alloc_alien_cache(i, cachep->limit)))
+			goto fail;
 #endif
-			if (!(new = alloc_arraycache(i, (cachep->shared*
-					cachep->batchcount), 0xbaadf00d)))
-				goto fail;
-			if ((l3 = cachep->nodelists[node])) {
+		if (!(new = alloc_arraycache(i, (cachep->shared*
+				cachep->batchcount), 0xbaadf00d)))
+			goto fail;
+		if ((l3 = cachep->nodelists[node])) {
 
-				spin_lock_irq(&l3->list_lock);
+			spin_lock_irq(&l3->list_lock);
 
-				if ((nc = cachep->nodelists[node]->shared))
-					free_block(cachep, nc->entry,
+			if ((nc = cachep->nodelists[node]->shared))
+				free_block(cachep, nc->entry,
 							nc->avail);
 
-				l3->shared = new;
-#ifdef CONFIG_NUMA
-				if (!cachep->nodelists[node]->alien) {
-					l3->alien = new_alien;
-					new_alien = NULL;
-				}
-				l3->free_limit = (1 + nr_cpus_node(node))*
-					cachep->batchcount + cachep->num;
-#else
-				l3->free_limit = (1 + num_online_cpus())*
-					cachep->batchcount + cachep->num;
-#endif
-				spin_unlock_irq(&l3->list_lock);
-				kfree(nc);
-#ifdef CONFIG_NUMA
-				free_alien_cache(new_alien);
-#endif
-				continue;
-			}
-			if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
-							GFP_KERNEL, node)))
-				goto fail;
-
-			LIST3_INIT(l3);
-			l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-				((unsigned long)cachep)%REAPTIMEOUT_LIST3;
 			l3->shared = new;
 #ifdef CONFIG_NUMA
-			l3->alien = new_alien;
+			if (!cachep->nodelists[node]->alien) {
+				l3->alien = new_alien;
+				new_alien = NULL;
+			}
 			l3->free_limit = (1 + nr_cpus_node(node))*
 				cachep->batchcount + cachep->num;
 #else
 			l3->free_limit = (1 + num_online_cpus())*
 				cachep->batchcount + cachep->num;
 #endif
-			cachep->nodelists[node] = l3;
+			spin_unlock_irq(&l3->list_lock);
+			kfree(nc);
+#ifdef CONFIG_NUMA
+			free_alien_cache(new_alien);
+#endif
+			continue;
 		}
+		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
+						GFP_KERNEL, node)))
+			goto fail;
+
+		LIST3_INIT(l3);
+		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+		l3->shared = new;
+#ifdef CONFIG_NUMA
+		l3->alien = new_alien;
+		l3->free_limit = (1 + nr_cpus_node(node))*
+			cachep->batchcount + cachep->num;
+#else
+		l3->free_limit = (1 + num_online_cpus())*
+			cachep->batchcount + cachep->num;
+#endif
+		cachep->nodelists[node] = l3;
 	}
 	return err;
 fail:
@@ -3280,15 +3266,11 @@ static int do_tune_cpucache(kmem_cache_t
 	int i, err;
 
 	memset(&new.new,0,sizeof(new.new));
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i)) {
-			new.new[i] = alloc_arraycache(i, limit, batchcount);
-			if (!new.new[i]) {
-				for (i--; i >= 0; i--) kfree(new.new[i]);
-				return -ENOMEM;
-			}
-		} else {
-			new.new[i] = NULL;
+	for_each_online_cpu(i) {
+		new.new[i] = alloc_arraycache(i, limit, batchcount);
+		if (!new.new[i]) {
+			for (i--; i >= 0; i--) kfree(new.new[i]);
+			return -ENOMEM;
 		}
 	}
 	new.cachep = cachep;
@@ -3302,7 +3284,7 @@ static int do_tune_cpucache(kmem_cache_t
 	cachep->shared = shared;
 	spin_unlock_irq(&cachep->spinlock);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_online_cpu(i) {
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
