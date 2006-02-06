Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWBFWvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWBFWvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWBFWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:51:11 -0500
Received: from ns1.siteground.net ([207.218.208.2]:14754 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964852AbWBFWvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:51:09 -0500
Date: Mon, 6 Feb 2006 14:51:17 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from cahep->spinlock to l3 lock
Message-ID: <20060206225117.GB3578@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain> <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com> <20060204010857.GG3653@localhost.localdomain> <20060204012800.GI3653@localhost.localdomain> <20060204014828.44792327.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204014828.44792327.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 01:48:28AM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > Earlier, we had to disable on chip interrupts while taking the cachep->spinlock
> >  because, at cache_grow, on every addition of a slab to a slab cache, we 
> >  incremented colour_next which was protected by the cachep->spinlock, and
> >  cache_grow could occur at interrupt context.  Since, now we protect the 
> >  per-node colour_next with the node's list_lock, we do not need to disable 
> >  on chip interrupts while taking the per-cache spinlock, but we
> >  just need to disable interrupts when taking the per-node kmem_list3 list_lock.
> 
> It'd be nice to have some comments describing what cachep->spinlock
> actually protects.

Actually, it does not protect much anymore.  Here's a cleanup+comments
patch (against current mainline).

The non atomic stats on the cachep structure now needs serialization though,
would a spinlock be better there instead of changing them over to atomic_t s
? I wonder...

> 
> Does __cache_shrink() need some locking to prevent nodes from going offline?

Looks like l3 list locking (which is already done) is sufficient, although
one of the two paths calling __cache_shrink takes the cpu hotplug lock
(kmem_cache_destroy()).  The other does not seem to be used much
(kmem_cache_shrink())

Thanks,
Kiran


Remove cachep->spinlock.  Locking has moved to the kmem_list3 and
most of the structures protected earlier by cachep->spinlock is
now protected by the l3->list_lock.  slab cache tunables like
batchcount are accessed always with the cache_chain_mutex held.

Patch tested on SMP and NUMA kernels with dbench processes
running, constant onlining/offlining, and constant cache tuning,
all at the same time.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-02-05 14:38:37.000000000 -0800
+++ linux-2.6/mm/slab.c	2006-02-06 12:05:26.000000000 -0800
@@ -373,17 +373,19 @@ static void kmem_list3_init(struct kmem_
 struct kmem_cache {
 /* 1) per-cpu data, touched during every alloc/free */
 	struct array_cache *array[NR_CPUS];
+/* 2) Cache tunables. Protected by cache_chain_mutex */
 	unsigned int batchcount;
 	unsigned int limit;
 	unsigned int shared;
+
 	unsigned int buffer_size;
-/* 2) touched by every alloc & free from the backend */
+/* 3) touched by every alloc & free from the backend */
 	struct kmem_list3 *nodelists[MAX_NUMNODES];
+
 	unsigned int flags;	/* constant flags */
 	unsigned int num;	/* # of objs per slab */
-	spinlock_t spinlock;
 
-/* 3) cache_grow/shrink */
+/* 4) cache_grow/shrink */
 	/* order of pgs per slab (2^n) */
 	unsigned int gfporder;
 
@@ -402,11 +404,11 @@ struct kmem_cache {
 	/* de-constructor func */
 	void (*dtor) (void *, struct kmem_cache *, unsigned long);
 
-/* 4) cache creation/removal */
+/* 5) cache creation/removal */
 	const char *name;
 	struct list_head next;
 
-/* 5) statistics */
+/* 6) statistics */
 #if STATS
 	unsigned long num_active;
 	unsigned long num_allocations;
@@ -643,7 +645,6 @@ static struct kmem_cache cache_cache = {
 	.shared = 1,
 	.buffer_size = sizeof(struct kmem_cache),
 	.flags = SLAB_NO_REAP,
-	.spinlock = SPIN_LOCK_UNLOCKED,
 	.name = "kmem_cache",
 #if DEBUG
 	.obj_size = sizeof(struct kmem_cache),
@@ -1909,7 +1910,6 @@ kmem_cache_create (const char *name, siz
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
-	spin_lock_init(&cachep->spinlock);
 	cachep->buffer_size = size;
 
 	if (flags & CFLGS_OFF_SLAB)
@@ -3334,6 +3334,7 @@ static void do_ccupdate_local(void *info
 	new->new[smp_processor_id()] = old;
 }
 
+/* Always called with the cache_chain_mutex held */
 static int do_tune_cpucache(struct kmem_cache *cachep, int limit, int batchcount,
 			    int shared)
 {
@@ -3355,11 +3356,9 @@ static int do_tune_cpucache(struct kmem_
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
 
 	check_irq_on();
-	spin_lock(&cachep->spinlock);
 	cachep->batchcount = batchcount;
 	cachep->limit = limit;
 	cachep->shared = shared;
-	spin_unlock(&cachep->spinlock);
 
 	for_each_online_cpu(i) {
 		struct array_cache *ccold = new.new[i];
@@ -3380,6 +3379,7 @@ static int do_tune_cpucache(struct kmem_
 	return 0;
 }
 
+/* Called with cache_chain_mutex held always */
 static void enable_cpucache(struct kmem_cache *cachep)
 {
 	int err;
@@ -3615,7 +3615,6 @@ static int s_show(struct seq_file *m, vo
 	int node;
 	struct kmem_list3 *l3;
 
-	spin_lock(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
 	for_each_online_node(node) {
@@ -3696,7 +3695,6 @@ static int s_show(struct seq_file *m, vo
 	}
 #endif
 	seq_putc(m, '\n');
-	spin_unlock(&cachep->spinlock);
 	return 0;
 }
 
