Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWGMMud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWGMMud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWGMMud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:50:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61827 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932450AbWGMMub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:50:31 -0400
Date: Thu, 13 Jul 2006 14:44:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: [patch] lockdep: undo mm/slab.c annotation
Message-ID: <20060713124438.GA18936@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713004445.cf7d1d96.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5340]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lockdep: undo mm/slab.c annotation
From: Ingo Molnar <mingo@elte.hu>

undo existing mm/slab.c lock-validator annotations, in preparation
of a new, less intrusive annotation patch.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 mm/slab.c |   33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -1021,8 +1021,7 @@ static void drain_alien_cache(struct kme
 	}
 }
 
-static inline int cache_free_alien(struct kmem_cache *cachep, void *objp,
-				   int nesting)
+static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
 {
 	struct slab *slabp = virt_to_slab(objp);
 	int nodeid = slabp->nodeid;
@@ -1040,7 +1039,7 @@ static inline int cache_free_alien(struc
 	STATS_INC_NODEFREES(cachep);
 	if (l3->alien && l3->alien[nodeid]) {
 		alien = l3->alien[nodeid];
-		spin_lock_nested(&alien->lock, nesting);
+		spin_lock(&alien->lock);
 		if (unlikely(alien->avail == alien->limit)) {
 			STATS_INC_ACOVERFLOW(cachep);
 			__drain_alien_cache(cachep, alien, nodeid);
@@ -1069,8 +1068,7 @@ static inline void free_alien_cache(stru
 {
 }
 
-static inline int cache_free_alien(struct kmem_cache *cachep, void *objp,
-				   int nesting)
+static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
 {
 	return 0;
 }
@@ -1760,8 +1758,6 @@ static void slab_destroy_objs(struct kme
 }
 #endif
 
-static void __cache_free(struct kmem_cache *cachep, void *objp, int nesting);
-
 /**
  * slab_destroy - destroy and release all objects in a slab
  * @cachep: cache pointer being destroyed
@@ -1785,17 +1781,8 @@ static void slab_destroy(struct kmem_cac
 		call_rcu(&slab_rcu->head, kmem_rcu_free);
 	} else {
 		kmem_freepages(cachep, addr);
-		if (OFF_SLAB(cachep)) {
-			unsigned long flags;
-
-			/*
-		 	 * lockdep: we may nest inside an already held
-			 * ac->lock, so pass in a nesting flag:
-			 */
-			local_irq_save(flags);
-			__cache_free(cachep->slabp_cache, slabp, 1);
-			local_irq_restore(flags);
-		}
+		if (OFF_SLAB(cachep))
+			kmem_cache_free(cachep->slabp_cache, slabp);
 	}
 }
 
@@ -3126,7 +3113,7 @@ static void cache_flusharray(struct kmem
 #endif
 	check_irq_off();
 	l3 = cachep->nodelists[node];
-	spin_lock_nested(&l3->list_lock, SINGLE_DEPTH_NESTING);
+	spin_lock(&l3->list_lock);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		int max = shared_array->limit - shared_array->avail;
@@ -3169,14 +3156,14 @@ free_done:
  * Release an obj back to its cache. If the obj has a constructed state, it must
  * be in this state _before_ it is released.  Called with disabled ints.
  */
-static void __cache_free(struct kmem_cache *cachep, void *objp, int nesting)
+static inline void __cache_free(struct kmem_cache *cachep, void *objp)
 {
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
-	if (cache_free_alien(cachep, objp, nesting))
+	if (cache_free_alien(cachep, objp))
 		return;
 
 	if (likely(ac->avail < ac->limit)) {
@@ -3415,7 +3402,7 @@ void kmem_cache_free(struct kmem_cache *
 	BUG_ON(virt_to_cache(objp) != cachep);
 
 	local_irq_save(flags);
-	__cache_free(cachep, objp, 0);
+	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(kmem_cache_free);
@@ -3440,7 +3427,7 @@ void kfree(const void *objp)
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
 	debug_check_no_locks_freed(objp, obj_size(c));
-	__cache_free(c, (void *)objp, 0);
+	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(kfree);
