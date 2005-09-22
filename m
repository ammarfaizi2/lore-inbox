Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVIVUC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVIVUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVIVUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030245AbVIVUC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:02:58 -0400
Date: Thu, 22 Sep 2005 13:01:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: vandrove@vc.cvut.cz, alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-Id: <20050922130150.0822b882.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz>
	<20050916023005.4146e499.akpm@osdl.org>
	<432AA00D.4030706@vc.cvut.cz>
	<20050916230809.789d6b0b.akpm@osdl.org>
	<432EE103.5020105@vc.cvut.cz>
	<20050919112912.18daf2eb.akpm@osdl.org>
	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	<20050919122847.4322df95.akpm@osdl.org>
	<Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
	<20050919221614.6c01c2d1.akpm@osdl.org>
	<43301578.8040305@vc.cvut.cz>
	<Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
	<4330B5C2.3080300@vc.cvut.cz>
	<Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Wed, 21 Sep 2005, Christoph Lameter wrote:
> 
>  > Hmm. This likely has something to do with debugging code. I was unable to 
>  > reproduce this on amd64 with your config. I get another failure with 
>  > 2.6.14-rc2 on ia64 if I enable all the debugging features that you have. 
>  > The system works fine if no debugging is configured:
>  > 
>  > kernel BUG at kernel/workqueue.c:541!
>  > swapper[1]: bugcheck! 0 [1]
> 
>  I fixed the above issue (a structure became larger than the maximum 
>  allowed by the slab allocator) and the kernel boots fine now on an 8 way 
>  ia64. Cannot reproduce the problem.

Petr can.  I think we're still waiting for him to test the below (please):




Begin forwarded message:

Date: Tue, 20 Sep 2005 18:03:54 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849


On Tue, 20 Sep 2005, Petr Vandrovec wrote:

> slab belonging to node#1, while having acquired lock for cachep belonging
> to node #0.  Due to this check_spinlock_acquired_node(cachep, nodeid) fails
> (check_spinlock_acquired_node(cachep, 0) would succeed).

Hmmm. If a node runs out of memory then pages from another node may end up 
on the slab list of a node. But it seems that free_block cannot handle 
that properly.

How are you producing the problem?

Could you try the following patch:

---

The numa slab allocator may allocate pages from foreign nodes onto the lists
for a particular node if a node runs out of memory. Inspecting the slab->nodeid
field will not reflect that the page is now in use for the slabs of another node.

This patch fixes that issue by adding a node field to free_block so that the caller
can indicate which node currently uses a slab.

Also removes the check for the current node from kmalloc_cache_node since the
process may shift later to another node which may lead to an allocation on another
node than intended.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc1/mm/slab.c
===================================================================
--- linux-2.6.14-rc1.orig/mm/slab.c	2005-09-21 00:09:05.000000000 +0000
+++ linux-2.6.14-rc1/mm/slab.c	2005-09-21 00:48:12.000000000 +0000
@@ -639,7 +639,7 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t* cachep, void** objpp, int len);
+static void free_block(kmem_cache_t* cachep, void** objpp, int len, int node);
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
 static int __node_shrink(kmem_cache_t *cachep, int node);
@@ -804,7 +804,7 @@ static inline void __drain_alien_cache(k
 
 	if (ac->avail) {
 		spin_lock(&rl3->list_lock);
-		free_block(cachep, ac->entry, ac->avail);
+		free_block(cachep, ac->entry, ac->avail, node);
 		ac->avail = 0;
 		spin_unlock(&rl3->list_lock);
 	}
@@ -925,7 +925,7 @@ static int __devinit cpuup_callback(stru
 			/* Free limit for this kmem_list3 */
 			l3->free_limit -= cachep->batchcount;
 			if (nc)
-				free_block(cachep, nc->entry, nc->avail);
+				free_block(cachep, nc->entry, nc->avail, node);
 
 			if (!cpus_empty(mask)) {
                                 spin_unlock(&l3->list_lock);
@@ -934,7 +934,7 @@ static int __devinit cpuup_callback(stru
 
 			if (l3->shared) {
 				free_block(cachep, l3->shared->entry,
-						l3->shared->avail);
+						l3->shared->avail, node);
 				kfree(l3->shared);
 				l3->shared = NULL;
 			}
@@ -1882,12 +1882,13 @@ static void do_drain(void *arg)
 {
 	kmem_cache_t *cachep = (kmem_cache_t*)arg;
 	struct array_cache *ac;
+	int node = numa_node_id();
 
 	check_irq_off();
 	ac = ac_data(cachep);
-	spin_lock(&cachep->nodelists[numa_node_id()]->list_lock);
-	free_block(cachep, ac->entry, ac->avail);
-	spin_unlock(&cachep->nodelists[numa_node_id()]->list_lock);
+	spin_lock(&cachep->nodelists[node]->list_lock);
+	free_block(cachep, ac->entry, ac->avail, node);
+	spin_unlock(&cachep->nodelists[node]->list_lock);
 	ac->avail = 0;
 }
 
@@ -2608,7 +2609,7 @@ done:
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
+static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects, int node)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2617,14 +2618,12 @@ static void free_block(kmem_cache_t *cac
 		void *objp = objpp[i];
 		struct slab *slabp;
 		unsigned int objnr;
-		int nodeid = 0;
 
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
-		nodeid = slabp->nodeid;
-		l3 = cachep->nodelists[nodeid];
+		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
-		check_spinlock_acquired_node(cachep, nodeid);
+		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 
 
@@ -2664,13 +2663,14 @@ static void cache_flusharray(kmem_cache_
 {
 	int batchcount;
 	struct kmem_list3 *l3;
+	int node = numa_node_id();
 
 	batchcount = ac->batchcount;
 #if DEBUG
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	l3 = cachep->nodelists[numa_node_id()];
+	l3 = cachep->nodelists[node];
 	spin_lock(&l3->list_lock);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
@@ -2686,7 +2686,7 @@ static void cache_flusharray(kmem_cache_
 		}
 	}
 
-	free_block(cachep, ac->entry, batchcount);
+	free_block(cachep, ac->entry, batchcount, node);
 free_done:
 #if STATS
 	{
@@ -2751,7 +2751,7 @@ static inline void __cache_free(kmem_cac
 			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
 						list_lock);
-				free_block(cachep, &objp, 1);
+				free_block(cachep, &objp, 1, nodeid);
 				spin_unlock(&(cachep->nodelists[nodeid])->
 						list_lock);
 			}
@@ -2844,7 +2844,7 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == numa_node_id() || nodeid == -1)
+	if (nodeid == -1)
 		return __cache_alloc(cachep, flags);
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
@@ -3079,7 +3079,7 @@ static int alloc_kmemlist(kmem_cache_t *
 
 			if ((nc = cachep->nodelists[node]->shared))
 				free_block(cachep, nc->entry,
-							nc->avail);
+							nc->avail, node);
 
 			l3->shared = new;
 			if (!cachep->nodelists[node]->alien) {
@@ -3160,7 +3160,7 @@ static int do_tune_cpucache(kmem_cache_t
 		if (!ccold)
 			continue;
 		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
-		free_block(cachep, ccold->entry, ccold->avail);
+		free_block(cachep, ccold->entry, ccold->avail, cpu_to_node(i));
 		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
 		kfree(ccold);
 	}
@@ -3240,7 +3240,7 @@ static void drain_array_locked(kmem_cach
 		if (tofree > ac->avail) {
 			tofree = (ac->avail+1)/2;
 		}
-		free_block(cachep, ac->entry, tofree);
+		free_block(cachep, ac->entry, tofree, node);
 		ac->avail -= tofree;
 		memmove(ac->entry, &(ac->entry[tofree]),
 					sizeof(void*)*ac->avail);
