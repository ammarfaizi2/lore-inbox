Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWGMIvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWGMIvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWGMIvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:51:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4266 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751504AbWGMIvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:51:50 -0400
Date: Thu, 13 Jul 2006 10:46:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: [patch] lockdep: more annotations for mm/slab.c
Message-ID: <20060713084613.GA7177@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org> <20060713084213.GA6985@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713084213.GA6985@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > yeah, i'll fix this. Any suggestions of how to avoid the parameter 
> > > passing? (without ugly #ifdeffery)
> > 
> > No, I don't see a way apart from inlining __cache_free(), or inlining 
> > cache_free_alien() into both kfree() and kmem_cache_free(), both of 
> > which are unattractive.
> 
> Arjan has an idea that looks nice to me: passing the nesting level via 
> a special type that has zero size on non-lockdep. This means that the 
> current "nesting + 1" arithmetics has to be turned into something 
> like: lockdep_deeper_nesting(var), and that all explicit uses of '0' 
> have to become symbolic - the former is acceptable and the later is 
> desirable. This could possibly also be used to clean up some of the 
> VFS-internal nesting. Hm?

i'll work on that cleanup, but meanwhile could we apply the patch below, 
to fix the false positive? This patch (ontop of the slab.c fix-patch) 
should put us where we were before wrt lockdep, sans the spin-unlocking 
side-effect.

	Ingo

---------------->
Subject: lockdep: more annotations for mm/slab.c
From: Ingo Molnar <mingo@elte.hu>

the SLAB code can hold multiple slab locks at once,
for example at:

 [<c0105dd5>] show_trace+0xd/0x10
 [<c0105def>] dump_stack+0x17/0x1c
 [<c014182e>] __lock_acquire+0x7ab/0xa0e
 [<c0141d6e>] lock_acquire+0x5e/0x80
 [<c10b0d8e>] _spin_lock_nested+0x26/0x37
 [<c017178b>] __cache_free+0x30d/0x3d2
 [<c0171200>] slab_destroy+0xfd/0x11d
 [<c0171360>] free_block+0x140/0x17d
 [<c01717dd>] __cache_free+0x35f/0x3d2
 [<c01718cd>] kfree+0x7d/0x9a
 [<c0127889>] free_task+0xe/0x24
 [<c0127ee8>] __put_task_struct+0xc2/0xc7
 [<c012bc8f>] delayed_put_task_struct+0x1e/0x20
 [<c0139d94>] __rcu_process_callbacks+0xff/0x15d
 [<c0139e1a>] rcu_process_callbacks+0x28/0x40
 [<c012f125>] tasklet_action+0x6e/0xd1
 [<c012f2c7>] __do_softirq+0x6e/0xec
 [<c01061b7>] do_softirq+0x61/0xc7

so add the 'nested' parameter to the affected functions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 mm/slab.c |   45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -312,7 +312,7 @@ struct kmem_list3 __initdata initkmem_li
 static int drain_freelist(struct kmem_cache *cache,
 			struct kmem_list3 *l3, int tofree);
 static void free_block(struct kmem_cache *cachep, void **objpp, int len,
-			int node);
+		       int node, int nesting);
 static void enable_cpucache(struct kmem_cache *cachep);
 static void cache_reap(void *unused);
 
@@ -981,7 +981,7 @@ static void __drain_alien_cache(struct k
 		if (rl3->shared)
 			transfer_objects(rl3->shared, ac, ac->limit);
 
-		free_block(cachep, ac->entry, ac->avail, node);
+		free_block(cachep, ac->entry, ac->avail, node, 0);
 		ac->avail = 0;
 		spin_unlock(&rl3->list_lock);
 	}
@@ -1048,9 +1048,10 @@ static inline int cache_free_alien(struc
 		alien->entry[alien->avail++] = objp;
 		spin_unlock(&alien->lock);
 	} else {
-		spin_lock(&(cachep->nodelists[nodeid])->list_lock);
-		free_block(cachep, &objp, 1, nodeid);
-		spin_unlock(&(cachep->nodelists[nodeid])->list_lock);
+		spin_lock_nested(&cachep->nodelists[nodeid]->list_lock,
+				 nesting);
+		free_block(cachep, &objp, 1, nodeid, nesting + 1);
+		spin_unlock(&cachep->nodelists[nodeid]->list_lock);
 	}
 	return 1;
 }
@@ -1208,7 +1209,8 @@ static int __devinit cpuup_callback(stru
 			/* Free limit for this kmem_list3 */
 			l3->free_limit -= cachep->batchcount;
 			if (nc)
-				free_block(cachep, nc->entry, nc->avail, node);
+				free_block(cachep, nc->entry, nc->avail,
+					   node, 0);
 
 			if (!cpus_empty(mask)) {
 				spin_unlock_irq(&l3->list_lock);
@@ -1218,7 +1220,7 @@ static int __devinit cpuup_callback(stru
 			shared = l3->shared;
 			if (shared) {
 				free_block(cachep, l3->shared->entry,
-					   l3->shared->avail, node);
+					   l3->shared->avail, node, 0);
 				l3->shared = NULL;
 			}
 
@@ -1771,7 +1773,8 @@ static void __cache_free(struct kmem_cac
  * Before calling the slab must have been unlinked from the cache.  The
  * cache-lock is not held/needed.
  */
-static void slab_destroy(struct kmem_cache *cachep, struct slab *slabp)
+static void slab_destroy(struct kmem_cache *cachep, struct slab *slabp,
+			 int nesting)
 {
 	void *addr = slabp->s_mem - slabp->colouroff;
 
@@ -1793,7 +1796,7 @@ static void slab_destroy(struct kmem_cac
 			 * ac->lock, so pass in a nesting flag:
 			 */
 			local_irq_save(flags);
-			__cache_free(cachep->slabp_cache, slabp, 1);
+			__cache_free(cachep->slabp_cache, slabp, nesting + 1);
 			local_irq_restore(flags);
 		}
 	}
@@ -2249,7 +2252,7 @@ static void do_drain(void *arg)
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 	spin_lock(&cachep->nodelists[node]->list_lock);
-	free_block(cachep, ac->entry, ac->avail, node);
+	free_block(cachep, ac->entry, ac->avail, node, 0);
 	spin_unlock(&cachep->nodelists[node]->list_lock);
 	ac->avail = 0;
 }
@@ -2308,7 +2311,7 @@ static int drain_freelist(struct kmem_ca
 		 */
 		l3->free_objects -= cache->num;
 		spin_unlock_irq(&l3->list_lock);
-		slab_destroy(cache, slabp);
+		slab_destroy(cache, slabp, 0);
 		nr_freed++;
 	}
 out:
@@ -3077,7 +3080,7 @@ done:
  * Caller needs to acquire correct kmem_list's list_lock
  */
 static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects,
-		       int node)
+		       int node, int nesting)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -3100,7 +3103,7 @@ static void free_block(struct kmem_cache
 		if (slabp->inuse == 0) {
 			if (l3->free_objects > l3->free_limit) {
 				l3->free_objects -= cachep->num;
-				slab_destroy(cachep, slabp);
+				slab_destroy(cachep, slabp, nesting);
 			} else {
 				list_add(&slabp->list, &l3->slabs_free);
 			}
@@ -3114,7 +3117,8 @@ static void free_block(struct kmem_cache
 	}
 }
 
-static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
+static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac,
+			     int nesting)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -3126,7 +3130,7 @@ static void cache_flusharray(struct kmem
 #endif
 	check_irq_off();
 	l3 = cachep->nodelists[node];
-	spin_lock_nested(&l3->list_lock, SINGLE_DEPTH_NESTING);
+	spin_lock_nested(&l3->list_lock, nesting);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		int max = shared_array->limit - shared_array->avail;
@@ -3140,7 +3144,7 @@ static void cache_flusharray(struct kmem
 		}
 	}
 
-	free_block(cachep, ac->entry, batchcount, node);
+	free_block(cachep, ac->entry, batchcount, node, nesting);
 free_done:
 #if STATS
 	{
@@ -3185,7 +3189,7 @@ static void __cache_free(struct kmem_cac
 		return;
 	} else {
 		STATS_INC_FREEMISS(cachep);
-		cache_flusharray(cachep, ac);
+		cache_flusharray(cachep, ac, nesting);
 		ac->entry[ac->avail++] = objp;
 	}
 }
@@ -3512,7 +3516,7 @@ static int alloc_kmemlist(struct kmem_ca
 
 			if (shared)
 				free_block(cachep, shared->entry,
-						shared->avail, node);
+					   shared->avail, node, 0);
 
 			l3->shared = new_shared;
 			if (!l3->alien) {
@@ -3611,7 +3615,8 @@ static int do_tune_cpucache(struct kmem_
 		if (!ccold)
 			continue;
 		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
-		free_block(cachep, ccold->entry, ccold->avail, cpu_to_node(i));
+		free_block(cachep, ccold->entry, ccold->avail,
+			   cpu_to_node(i), 0);
 		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
 		kfree(ccold);
 	}
@@ -3700,7 +3705,7 @@ void drain_array(struct kmem_cache *cach
 			tofree = force ? ac->avail : (ac->limit + 4) / 5;
 			if (tofree > ac->avail)
 				tofree = (ac->avail + 1) / 2;
-			free_block(cachep, ac->entry, tofree, node);
+			free_block(cachep, ac->entry, tofree, node, 0);
 			ac->avail -= tofree;
 			memmove(ac->entry, &(ac->entry[tofree]),
 				sizeof(void *) * ac->avail);
