Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSJDR2D>; Fri, 4 Oct 2002 13:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSJDR2C>; Fri, 4 Oct 2002 13:28:02 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:61312 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262780AbSJDR1t>;
	Fri, 4 Oct 2002 13:27:49 -0400
Message-ID: <3D9DC978.5090004@colorfullife.com>
Date: Fri, 04 Oct 2002 19:01:44 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-02-SMP
Content-Type: multipart/mixed;
 boundary="------------040508020306090206020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508020306090206020701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

part 2:
[depends on -01-rename]

Always enable the cpu arrays. They provide LIFO ordering, which should 
improve cache hit rates. And the array allocator is slightly faster than 
the list operations.

Please apply

--
	Manfred

--------------040508020306090206020701
Content-Type: text/plain;
 name="patch-slab-split-02-SMP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-02-SMP"

--- 2.5/mm/slab.c	Fri Oct  4 18:55:20 2002
+++ build-2.5/mm/slab.c	Fri Oct  4 18:58:13 2002
@@ -198,9 +198,7 @@
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
 	spinlock_t		spinlock;
-#ifdef CONFIG_SMP
 	unsigned int		batchcount;
-#endif
 
 /* 2) slab additions /removals */
 	/* order of pgs per slab (2^n) */
@@ -227,10 +225,8 @@
 /* 3) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
-#ifdef CONFIG_SMP
 /* 4) per-cpu data */
 	cpucache_t		*cpudata[NR_CPUS];
-#endif
 #if STATS
 	unsigned long		num_active;
 	unsigned long		num_allocations;
@@ -238,13 +234,11 @@
 	unsigned long		grown;
 	unsigned long		reaped;
 	unsigned long 		errors;
-#ifdef CONFIG_SMP
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
 	atomic_t		freemiss;
 #endif
-#endif
 };
 
 /* internal c_flags */
@@ -278,7 +272,7 @@
 #define	STATS_INC_ERR(x)	do { } while (0)
 #endif
 
-#if STATS && defined(CONFIG_SMP)
+#if STATS
 #define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
 #define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
 #define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
@@ -402,7 +396,6 @@
 
 #define cache_chain (cache_cache.next)
 
-#ifdef CONFIG_SMP
 /*
  * chicken and egg problem: delay the per-cpu array allocation
  * until the general caches are up.
@@ -411,7 +404,6 @@
 
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
-#endif
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void cache_estimate (unsigned long gfporder, size_t size,
@@ -501,10 +493,8 @@
 
 int __init cpucache_init(void)
 {
-#ifdef CONFIG_SMP
 	g_cpucache_up = 1;
 	enable_all_cpucaches();
-#endif
 	return 0;
 }
 
@@ -832,10 +822,8 @@
 	cachep->dtor = dtor;
 	cachep->name = name;
 
-#ifdef CONFIG_SMP
 	if (g_cpucache_up)
 		enable_cpucache(cachep);
-#endif
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
 	{
@@ -900,7 +888,6 @@
 #define is_chained_cache(x) 1
 #endif
 
-#ifdef CONFIG_SMP
 /*
  * Waits for all CPUs to execute func().
  */
@@ -955,10 +942,6 @@
 	up(&cache_chain_sem);
 }
 
-#else
-#define drain_cpu_caches(cachep)	do { } while (0)
-#endif
-
 static int __cache_shrink(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
@@ -1044,13 +1027,11 @@
 		up(&cache_chain_sem);
 		return 1;
 	}
-#ifdef CONFIG_SMP
 	{
 		int i;
 		for (i = 0; i < NR_CPUS; i++)
 			kfree(cachep->cpudata[i]);
 	}
-#endif
 	kmem_cache_free(&cache_cache, cachep);
 
 	return 0;
@@ -1330,7 +1311,6 @@
 	cache_alloc_one_tail(cachep, slabp);		\
 })
 
-#ifdef CONFIG_SMP
 void* cache_alloc_batch(kmem_cache_t* cachep, int flags)
 {
 	int batchcount = cachep->batchcount;
@@ -1363,7 +1343,6 @@
 		return cc_entry(cc)[--cc->avail];
 	return NULL;
 }
-#endif
 
 static inline void * __cache_alloc (kmem_cache_t *cachep, int flags)
 {
@@ -1376,7 +1355,6 @@
 	cache_alloc_head(cachep, flags);
 try_again:
 	local_irq_save(save_flags);
-#ifdef CONFIG_SMP
 	{
 		cpucache_t *cc = cc_data(cachep);
 
@@ -1398,19 +1376,12 @@
 			spin_unlock(&cachep->spinlock);
 		}
 	}
-#else
-	objp = cache_alloc_one(cachep);
-#endif
 	local_irq_restore(save_flags);
 	return objp;
 alloc_new_slab:
-#ifdef CONFIG_SMP
 	spin_unlock(&cachep->spinlock);
-#endif
 	local_irq_restore(save_flags);
-#ifdef CONFIG_SMP
 alloc_new_slab_nolock:
-#endif
 	if (cache_grow(cachep, flags))
 		/* Someone may have stolen our objs.  Doesn't matter, we'll
 		 * just come back here again.
@@ -1512,7 +1483,6 @@
 	}
 }
 
-#ifdef CONFIG_SMP
 static inline void __free_block (kmem_cache_t* cachep,
 							void** objpp, int len)
 {
@@ -1526,7 +1496,6 @@
 	__free_block(cachep, objpp, len);
 	spin_unlock(&cachep->spinlock);
 }
-#endif
 
 /*
  * __cache_free
@@ -1534,7 +1503,6 @@
  */
 static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
-#ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
 
 	CHECK_PAGE(objp);
@@ -1554,9 +1522,6 @@
 	} else {
 		free_block(cachep, &objp, 1);
 	}
-#else
-	cache_free_one(cachep, objp);
-#endif
 }
 
 /**
@@ -1674,8 +1639,6 @@
 	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
 }
 
-#ifdef CONFIG_SMP
-
 /* called with cache_chain_sem acquired.  */
 static int tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
 {
@@ -1772,7 +1735,6 @@
 
 	up(&cache_chain_sem);
 }
-#endif
 
 /**
  * cache_reap - Reclaim memory from caches.
@@ -1816,7 +1778,6 @@
 			searchp->dflags &= ~DFLGS_GROWN;
 			goto next_unlock;
 		}
-#ifdef CONFIG_SMP
 		{
 			cpucache_t *cc = cc_data(searchp);
 			if (cc && cc->avail) {
@@ -1824,7 +1785,6 @@
 				cc->avail = 0;
 			}
 		}
-#endif
 
 		full_free = 0;
 		p = searchp->slabs_free.next;
@@ -1958,9 +1918,7 @@
 #if STATS
 				" (statistics)"
 #endif
-#ifdef CONFIG_SMP
 				" (SMP)"
-#endif
 				"\n");
 		return 0;
 	}
@@ -2018,7 +1976,6 @@
 				high, allocs, grown, reaped, errors);
 	}
 #endif
-#ifdef CONFIG_SMP
 	{
 		unsigned int batchcount = cachep->batchcount;
 		unsigned int limit;
@@ -2029,8 +1986,7 @@
 			limit = 0;
 		seq_printf(m, " : %4u %4u", limit, batchcount);
 	}
-#endif
-#if STATS && defined(CONFIG_SMP)
+#if STATS
 	{
 		unsigned long allochit = atomic_read(&cachep->allochit);
 		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
@@ -2077,7 +2033,6 @@
 ssize_t slabinfo_write(struct file *file, const char *buffer,
 				size_t count, loff_t *ppos)
 {
-#ifdef CONFIG_SMP
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
 	int limit, batchcount, res;
 	struct list_head *p;
@@ -2113,8 +2068,5 @@
 	if (res >= 0)
 		res = count;
 	return res;
-#else
-	return -EINVAL;
-#endif
 }
 #endif

--------------040508020306090206020701--


