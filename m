Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTEFUEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTEFUEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:04:07 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:5024 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261364AbTEFUDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:03:55 -0400
Message-ID: <3EB81809.4080003@colorfullife.com>
Date: Tue, 06 May 2003 22:16:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: initcall kmem_cache cpu 1 oops
References: <Pine.LNX.4.44.0305061319190.1821-100000@localhost.localdomain> <3EB7D6BD.6040101@colorfullife.com>
In-Reply-To: <3EB7D6BD.6040101@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------010503060307050801010307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010503060307050801010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

attached is the promised cleanup/bugfix patch for the slab bootstrap:

Changes:
- kmem_cache_init & kmem_cache_sizes_init merged into one function, 
called after mem_init(). It's impossible to bring slab to an operational 
state without working gfp, thus the early partial initialization is not 
necessary.
- g_cpucache_up set to FULL at the end of kmem_cache_init instead of the 
module init call. This is a bugfix: slab was completely initialized, 
just the update of the state was missing.
- some documentation for the bootstrap added.

Patch against 2.5.69-mm1, tested with UP and SMP on i386 (with 
s/read_lock/spin_lock/ in filetable.c).

Andrew, what do you think? The minimal fix for the bug is a two-liner: 
move g_cpucache_up=FULL from cpucache_init to kmem_cache_sizes_init, but 
I want to get rid of kmem_cache_sizes_init, too.

--
    Manfred

--------------010503060307050801010307
Content-Type: text/plain;
 name="patch-slab-FULL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-FULL"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 69
//  EXTRAVERSION = -mm1
--- 2.5/include/linux/slab.h	2003-05-05 20:27:16.000000000 +0200
+++ build-2.5/include/linux/slab.h	2003-05-06 21:04:24.000000000 +0200
@@ -49,7 +49,6 @@
 
 /* prototypes */
 extern void kmem_cache_init(void);
-extern void kmem_cache_sizes_init(void);
 
 extern kmem_cache_t *kmem_find_general_cachep(size_t, int gfpflags);
 extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
--- 2.5/mm/slab.c	2003-05-06 21:01:42.000000000 +0200
+++ build-2.5/mm/slab.c	2003-05-06 21:17:57.000000000 +0200
@@ -571,11 +571,40 @@
 	return cachep->array[smp_processor_id()];
 }
 
-/* Initialisation - setup the `cache' cache. */
+/* Initialisation.
+ * Called after the gfp() functions have been enabled, and before smp_init().
+ */
 void __init kmem_cache_init(void)
 {
 	size_t left_over;
+	struct cache_sizes *sizes;
+	struct cache_names *names;
+
+	/*
+	 * Fragmentation resistance on low memory - only use bigger
+	 * page orders on machines with more than 32MB of memory.
+	 */
+	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
+		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
 
+	
+	/* Bootstrap is tricky, because several objects are allocated
+	 * from caches that do not exist yet:
+	 * 1) initialize the cache_cache cache: it contains the kmem_cache_t
+	 *    structures of all caches, except cache_cache itself: cache_cache
+	 *    is statically allocated.
+	 *    Initially an __init data area is used for the head array, it's
+	 *    replaced with a kmalloc allocated array at the end of the bootstrap.
+	 * 2) Create the first kmalloc cache.
+	 *    The kmem_cache_t for the new cache is allocated normally. An __init
+	 *    data area is used for the head array.
+	 * 3) Create the remaining kmalloc caches, with minimally sized head arrays.
+	 * 4) Replace the __init data head arrays for cache_cache and the first
+	 *    kmalloc cache with kmalloc allocated arrays.
+	 * 5) Resize the head arrays of the kmalloc caches to their final sizes.
+	 */
+
+	/* 1) create the cache_cache */
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
 	list_add(&cache_cache.next, &cache_chain);
@@ -589,27 +618,10 @@
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
 
-	/* Register a cpu startup notifier callback
-	 * that initializes ac_data for all new cpus
-	 */
-	register_cpu_notifier(&cpucache_notifier);
-}
-
 
-/* Initialisation - setup remaining internal and general caches.
- * Called after the gfp() functions have been enabled, and before smp_init().
- */
-void __init kmem_cache_sizes_init(void)
-{
-	struct cache_sizes *sizes = malloc_sizes;
-	struct cache_names *names = cache_names;
-
-	/*
-	 * Fragmentation resistance on low memory - only use bigger
-	 * page orders on machines with more than 32MB of memory.
-	 */
-	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
-		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
+	/* 2+3) create the kmalloc caches */
+	sizes = malloc_sizes;
+	names = cache_names;
 
 	while (sizes->cs_size) {
 		/* For performance, all the general caches are L1 aligned.
@@ -638,10 +650,7 @@
 		sizes++;
 		names++;
 	}
-	/*
-	 * The generic caches are running - time to kick out the
-	 * bootstrap cpucaches.
-	 */
+	/* 4) Replace the bootstrap head arrays */
 	{
 		void * ptr;
 		
@@ -660,29 +669,42 @@
 		malloc_sizes[0].cs_cachep->array[smp_processor_id()] = ptr;
 		local_irq_enable();
 	}
+
+	/* 5) resize the head arrays to their final sizes */
+	{
+		kmem_cache_t *cachep;
+		down(&cache_chain_sem);
+		list_for_each_entry(cachep, &cache_chain, next)
+			enable_cpucache(cachep);
+		up(&cache_chain_sem);
+	}
+
+	/* Done! */
+	g_cpucache_up = FULL;
+
+	/* Register a cpu startup notifier callback
+	 * that initializes ac_data for all new cpus
+	 */
+	register_cpu_notifier(&cpucache_notifier);
+	
+
+	/* The reap timers are started later, with a module init call:
+	 * That part of the kernel is not yet operational.
+	 */
 }
 
 int __init cpucache_init(void)
 {
-	kmem_cache_t *cachep;
 	int cpu;
 
-	down(&cache_chain_sem);
-	g_cpucache_up = FULL;
-
-	list_for_each_entry(cachep, &cache_chain, next)
-		enable_cpucache(cachep);
-	
 	/* 
 	 * Register the timers that return unneeded
 	 * pages to gfp.
 	 */
-
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (cpu_online(cpu))
 			start_cpu_timer(cpu);
 	}
-	up(&cache_chain_sem);
 
 	return 0;
 }
--- 2.5/init/main.c	2003-05-06 21:01:41.000000000 +0200
+++ build-2.5/init/main.c	2003-05-06 21:04:10.000000000 +0200
@@ -424,7 +424,6 @@
 	 */
 	console_init();
 	profile_init();
-	kmem_cache_init();
 	local_irq_enable();
 	calibrate_delay();
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -437,7 +436,7 @@
 #endif
 	page_address_init();
 	mem_init();
-	kmem_cache_sizes_init();
+	kmem_cache_init();
 	pidmap_init();
 	pgtable_cache_init();
 	pte_chain_init();

--------------010503060307050801010307--

