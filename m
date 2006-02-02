Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423390AbWBBI76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423390AbWBBI76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423391AbWBBI76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:59:58 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:32464 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1423390AbWBBI75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:59:57 -0500
Date: Thu, 2 Feb 2006 10:59:51 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: kevin@koconnor.net, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       manfred@colorfullife.com, davej@redhat.com
Subject: Re: [PATCH] slab leak detector (Was: Size-128 slab leak)
In-Reply-To: <20060202004415.28249549.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0602021050480.934@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI>
 <20060202004415.28249549.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> >  Here's a version that uses dbg_userword() instead of overriding bufctls 
> >  and adds a CONFIG_DEBUG_SLAB_LEAK config option. Upside is that this works 
> >  with the slab verifier patch and is less invasive.

On Thu, 2 Feb 2006, Andrew Morton wrote:
> What is the slab verifier patch?

See the included (untested) patch. I got it from Davej who got it from 
Manfred and cleaned it up a bit. The verifier checks slab red zones during 
cache_reap() to catch slab corruption early.

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > Downside is that now 
> >  some slabs don't get leak reports (those that don't get SLAB_STORE_USER 
> >  enabled in kmem_cache_create).

On Thu, 2 Feb 2006, Andrew Morton wrote:
> Which slabs are those?  SLAB_HWCACHE_ALIGN?  If so, that's quite a lot of
> them (more than needed, probably).

It's for those caches that don't get red-zoning now. I am not sure how far 
it extends but kmem_cache_create() tries to avoid worst-case scenarios 
where internal fragmentation would be too much.

			Pekka

---

 mm/slab.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 3 deletions(-)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -202,7 +202,7 @@
 
 typedef unsigned int kmem_bufctl_t;
 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
-#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
+#define BUFCTL_ALLOC	(((kmem_bufctl_t)(~0U))-1)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.
@@ -430,6 +430,11 @@ struct kmem_cache {
 	 */
 	int obj_offset;
 	int obj_size;
+
+	/*
+	 * Time for next cache verification.
+	 */
+	unsigned long next_verify;
 #endif
 };
 
@@ -445,6 +450,7 @@ struct kmem_cache {
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
 #define REAPTIMEOUT_LIST3	(4*HZ)
+#define REDZONETIMEOUT		(300*HZ)
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -1923,6 +1929,11 @@ kmem_cache_create (const char *name, siz
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
 	}
 
+#if DEBUG
+	cachep->next_verify = jiffies + REDZONETIMEOUT +
+		((unsigned long)cachep/L1_CACHE_BYTES)%REDZONETIMEOUT;
+#endif
+
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
 	unlock_cpu_hotplug();
@@ -2251,7 +2262,7 @@ static void *slab_get_obj(struct kmem_ca
 	slabp->inuse++;
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
 	WARN_ON(slabp->nodeid != nodeid);
 #endif
 	slabp->free = next;
@@ -2268,7 +2279,7 @@ static void slab_put_obj(struct kmem_cac
 	/* Verify that the slab belongs to the intended node */
 	WARN_ON(slabp->nodeid != nodeid);
 
-	if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
+	if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
 		printk(KERN_ERR "slab: double free detected in cache "
 		       "'%s', objp %p\n", cachep->name, objp);
 		BUG();
@@ -3266,6 +3277,116 @@ static int alloc_kmemlist(struct kmem_ca
 	return err;
 }
 
+#if DEBUG
+
+static void verify_slab_redzone(struct kmem_cache *cache, struct slab *slab)
+{
+	int i;
+
+	if (!(cache->flags & SLAB_RED_ZONE))
+		return;
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	/* Page alloc debugging on for this cache. Mapping & Unmapping happens
+	 * without any locking, thus parallel checks are impossible.
+	 */
+	if ((cache->buffer_size % PAGE_SIZE) == 0 && OFF_SLAB(cache))
+		return;
+#endif
+
+	for (i = 0; i < cache->num; i++) {
+		unsigned long red1, red2;
+		void *obj = slab->s_mem + cache->buffer_size * i;
+
+		red1 = *dbg_redzone1(cache, obj);
+		red2 = *dbg_redzone2(cache, obj);
+
+		/* Simplest case: redzones marked as inactive.  */
+		if (red1 == RED_INACTIVE && red2 == RED_INACTIVE)
+			continue;
+
+		/*
+		 * Tricky case: if the bufctl value is BUFCTL_ALLOC, then
+		 * the object is either allocated or somewhere in a cpu
+		 * cache. The cpu caches are lockless and there might be
+		 * a concurrent alloc/free call, thus we must accept random
+		 * combinations of RED_ACTIVE and _INACTIVE
+		 */
+		if (slab_bufctl(slab)[i] == BUFCTL_ALLOC &&
+				(red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
+				(red2 == RED_INACTIVE || red2 == RED_ACTIVE))
+			continue;
+
+		printk(KERN_ERR "slab %s: redzone mismatch in slab %p,"
+		       " obj %p, bufctl 0x%lx\n", cache->name, slab, obj,
+		       slab_bufctl(slab)[i]);
+
+		print_objinfo(cache, obj, 2);
+	}
+}
+
+static void print_invalid_slab(const char *list_name, struct kmem_cache *cache,
+			       struct slab *slab)
+{
+	printk(KERN_ERR "slab %s: invalid slab found in %s list at %p (%d/%d).\n",
+	       cache->name, list_name, slab, slab->inuse, cache->num);
+}
+
+static void verify_nodelists(struct kmem_cache *cache,
+			     struct kmem_list3 *lists)
+{
+	struct list_head *q;
+	struct slab *slab;
+
+	list_for_each(q, &lists->slabs_full) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse != cache->num)
+			print_invalid_slab("full", cache, slab);
+
+		check_slabp(cache, slab);
+		verify_slab_redzone(cache, slab);
+	}
+	list_for_each(q, &lists->slabs_partial) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse == cache->num || slab->inuse == 0)
+			print_invalid_slab("partial", cache, slab);
+
+		check_slabp(cache, slab);
+		verify_slab_redzone(cache, slab);
+	}
+	list_for_each(q, &lists->slabs_free) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse != 0)
+			print_invalid_slab("free", cache, slab);
+
+		check_slabp(cache, slab);
+		verify_slab_redzone(cache, slab);
+	}
+}
+
+/*
+ * Perform a self test on all slabs from a cache
+ */
+static void verify_cache(struct kmem_cache *cache)
+{
+	int node;
+
+	check_spinlock_acquired(cache);
+
+	for_each_online_node(node) {
+		struct kmem_list3 *lists = cache->nodelists[node];
+
+		if (!lists)
+			continue;
+		verify_nodelists(cache, lists);
+	}
+}
+
+#endif
+
 struct ccupdate_struct {
 	struct kmem_cache *cachep;
 	struct array_cache *new[NR_CPUS];
@@ -3446,6 +3567,13 @@ static void cache_reap(void *unused)
 		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
 				   numa_node_id());
 
+#if DEBUG
+		if (time_before(searchp->next_verify, jiffies)) {
+			searchp->next_verify = jiffies + REDZONETIMEOUT;
+			verify_cache(searchp);
+		}
+#endif
+
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
 
