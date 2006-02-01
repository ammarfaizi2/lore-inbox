Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWBARJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWBARJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBARJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:09:28 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:33720 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932446AbWBARJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:09:27 -0500
Subject: Re: 2.6.16rc1-git4 slab corruption.
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Dave Jones <davej@redhat.com>
Cc: Chris Mason <mason@suse.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       manfred@colorfullife.com
In-Reply-To: <20060201160921.GC5875@redhat.com>
References: <20060131180319.GA18948@redhat.com>
	 <200601311408.35771.mason@suse.com> <20060131221542.GC29937@redhat.com>
	 <84144f020601312327t490dcf4fi6fb09942a0f3dd87@mail.gmail.com>
	 <20060201160921.GC5875@redhat.com>
Date: Wed, 01 Feb 2006 19:09:23 +0200
Message-Id: <1138813763.8604.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-02-01 at 11:09 -0500, Dave Jones wrote:
> Here's the last version that I had that was rediffed against
> 2.6.13 or .14 (I forget which, it's been a while since I used it).

Here's an untested rediff for 2.6.16-rc1-mm4. The patch should apply to
mainline when Linus merges the slab bits from Andrew. I am wondering if
this should be a separate config option, CONFIG_VERIFY_SLAB?

			Pekka

 mm/slab.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 3 deletions(-)

Index: 2.6-mm/mm/slab.c
===================================================================
--- 2.6-mm.orig/mm/slab.c
+++ 2.6-mm/mm/slab.c
@@ -202,7 +202,7 @@
 
 typedef unsigned long kmem_bufctl_t;
 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
-#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
+#define BUFCTL_ALLOC	(((kmem_bufctl_t)(~0U))-1)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.
@@ -433,6 +433,7 @@ struct kmem_cache {
 	 */
 	int obj_offset;
 	int obj_size;
+	unsigned long redzonetest;
 #endif
 };
 
@@ -448,6 +449,7 @@ struct kmem_cache {
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
 #define REAPTIMEOUT_LIST3	(4*HZ)
+#define REDZONETIMEOUT		(300*HZ)
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -1932,6 +1934,11 @@ kmem_cache_create (const char *name, siz
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
 	}
 
+#if DEBUG
+	cachep->redzonetest = jiffies + REDZONETIMEOUT +
+		((unsigned long)cachep/L1_CACHE_BYTES)%REDZONETIMEOUT;
+#endif
+
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
       oops:
@@ -2261,7 +2268,7 @@ static void *slab_get_obj(struct kmem_ca
 	slabp->inuse++;
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
 	WARN_ON(slabp->nodeid != nodeid);
 #endif
 	slabp->free = next;
@@ -2278,7 +2285,7 @@ static void slab_put_obj(struct kmem_cac
 	/* Verify that the slab belongs to the intended node */
 	WARN_ON(slabp->nodeid != nodeid);
 
-	if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
+	if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
 		printk(KERN_ERR "slab: double free detected in cache "
 		       "'%s', objp %p\n", cachep->name, objp);
 		BUG();
@@ -3285,6 +3292,113 @@ static int alloc_kmemlist(struct kmem_ca
 	return err;
 }
 
+#if DEBUG
+
+static void check_slabuse(kmem_cache_t *cachep, struct slab *slabp)
+{
+	int i;
+
+	if (!(cachep->flags & SLAB_RED_ZONE))
+		return;	/* no redzone data to check */
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	/* Page alloc debugging on for this cache. Mapping & Unmapping happens
+	 * without any locking, thus parallel checks are impossible.
+	 */
+	if ((cachep->buffer_size % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
+		return;
+#endif
+
+	for (i=0;i<cachep->num;i++) {
+		void *objp = slabp->s_mem + cachep->buffer_size * i;
+		unsigned long red1, red2;
+
+		red1 = *dbg_redzone1(cachep, objp);
+		red2 = *dbg_redzone2(cachep, objp);
+
+		/* simplest case: marked as inactive */
+		if (red1 == RED_INACTIVE && red2 == RED_INACTIVE)
+			continue;
+
+		/* tricky case: if the bufctl value is BUFCTL_ALLOC, then
+		 * the object is either allocated or somewhere in a cpu
+		 * cache. The cpu caches are lockless and there might be
+		 * a concurrent alloc/free call, thus we must accept random
+		 * combinations of RED_ACTIVE and _INACTIVE
+		 */
+		if (slab_bufctl(slabp)[i] == BUFCTL_ALLOC &&
+				(red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
+				(red2 == RED_INACTIVE || red2 == RED_ACTIVE))
+			continue;
+
+		printk(KERN_ERR "slab %s: redzone mismatch in slabp %p, objp %p, bufctl 0x%lx\n",
+				cachep->name, slabp, objp, slab_bufctl(slabp)[i]);
+		print_objinfo(cachep, objp, 2);
+	}
+}
+
+static void print_invalid_slab(const char *list_name, struct kmem_cache *cache,
+			     struct slab *slab)
+{
+	printk(KERN_ERR "slab %s: invalid slab found in %s list at %p (%d/%d).\n",
+	       cache->name, list_name, slab, slab->inuse, cache->num);
+}
+
+static void verify_node_redzone(struct kmem_cache *cache,
+				struct kmem_list3 *lists)
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
+		check_slabuse(cache, slab);
+	}
+	list_for_each(q, &lists->slabs_partial) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse == cache->num || slab->inuse == 0)
+			print_invalid_slab("partial", cache, slab);
+
+		check_slabp(cache, slab);
+		check_slabuse(cache, slab);
+	}
+	list_for_each(q, &lists->slabs_free) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse != 0)
+			print_invalid_slab("free", cache, slab);
+
+		check_slabp(cache, slab);
+		check_slabuse(cache, slab);
+	}
+}
+
+/*
+ * Perform a self test on all slabs from a cache
+ */
+static void verify_redzone(struct kmem_cache *cache)
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
+		verify_node_redzone(cache, lists);
+	}
+}
+
+#endif
+
 struct ccupdate_struct {
 	struct kmem_cache *cachep;
 	struct array_cache *new[NR_CPUS];
@@ -3465,6 +3579,13 @@ static void cache_reap(void *unused)
 		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
 				   numa_node_id());
 
+#if DEBUG
+		if (time_before(searchp->redzonetest, jiffies)) {
+			searchp->redzonetest = jiffies + REDZONETIMEOUT;
+			verify_redzone(searchp);
+		}
+#endif
+
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
 


