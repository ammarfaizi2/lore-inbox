Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281799AbRK1GSn>; Wed, 28 Nov 2001 01:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281591AbRK1GSd>; Wed, 28 Nov 2001 01:18:33 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:47117 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281777AbRK1GSZ>;
	Wed, 28 Nov 2001 01:18:25 -0500
Date: Wed, 28 Nov 2001 17:13:07 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] introducing __cacheline_aligned_in_smp
Message-ID: <20011128171306.D22190@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here is a very simple patch that offers pretty substantial improvements
in scalability. Without the patch dbench shows inverse scalability from
5 to 12 cpus on this 12 way ppc64 machine. With the patch we are
still positively scaling at 12 cpus. Before the patch we were doing
212 MB/s at 12 clients, after the patch we do 320 MB/s.

Basically it creates __cacheline_aligned_in_smp which does the same
thing as __cacheline_aligned - ensures a spinlock gets an entire
cacheline to itself.

The results can be found here:

http://samba.org/~anton/linux/cacheline_aligned/

I think this is a candidate for 2.4, but it changes the alignment of
some things on UP (like softirq) so some testing would be a good idea :)

Anton


diff -urN linuxppc_2_4_devel/fs/block_dev.c linuxppc_2_4_devel_work/fs/block_dev.c
--- linuxppc_2_4_devel/fs/block_dev.c	Thu Nov 22 22:59:18 2001
+++ linuxppc_2_4_devel_work/fs/block_dev.c	Fri Nov 23 09:53:19 2001
@@ -234,7 +237,7 @@
 #define HASH_SIZE	(1UL << HASH_BITS)
 #define HASH_MASK	(HASH_SIZE-1)
 static struct list_head bdev_hashtable[HASH_SIZE];
-static spinlock_t bdev_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t bdev_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t * bdev_cachep;
 
 #define alloc_bdev() \
diff -urN linuxppc_2_4_devel/fs/buffer.c linuxppc_2_4_devel_work/fs/buffer.c
--- linuxppc_2_4_devel/fs/buffer.c	Thu Nov 22 22:59:18 2001
+++ linuxppc_2_4_devel_work/fs/buffer.c	Fri Nov 23 09:53:04 2001
@@ -73,7 +73,7 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t lru_list_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
diff -urN linuxppc_2_4_devel/include/linux/cache.h linuxppc_2_4_devel_work/include/linux/cache.h
--- linuxppc_2_4_devel/include/linux/cache.h	Wed Sep 26 15:19:58 2001
+++ linuxppc_2_4_devel_work/include/linux/cache.h	Thu Nov 15 16:22:43 2001
@@ -34,4 +34,12 @@
 #endif
 #endif /* __cacheline_aligned */
 
+#ifndef __cacheline_aligned_in_smp
+#ifdef CONFIG_SMP
+#define __cacheline_aligned_in_smp __cacheline_aligned
+#else
+#define __cacheline_aligned_in_smp
+#endif /* CONFIG_SMP */
+#endif
+
 #endif /* __LINUX_CACHE_H */
diff -urN linuxppc_2_4_devel/kernel/fork.c linuxppc_2_4_devel_work/kernel/fork.c
--- linuxppc_2_4_devel/kernel/fork.c	Thu Nov 22 22:59:18 2001
+++ linuxppc_2_4_devel_work/kernel/fork.c	Fri Nov 23 09:48:28 2001
@@ -206,7 +206,7 @@
 	return retval;
 }
 
-spinlock_t mmlist_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
+spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
diff -urN linuxppc_2_4_devel/kernel/softirq.c linuxppc_2_4_devel_work/kernel/softirq.c
--- linuxppc_2_4_devel/kernel/softirq.c	Sun Nov  4 16:25:02 2001
+++ linuxppc_2_4_devel_work/kernel/softirq.c	Thu Nov 15 16:22:43 2001
@@ -42,7 +42,7 @@
 
 irq_cpustat_t irq_stat[NR_CPUS];
 
-static struct softirq_action softirq_vec[32] __cacheline_aligned;
+static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
@@ -146,8 +146,8 @@
 
 /* Tasklets */
 
-struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned;
-struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
+struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned_in_smp;
+struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned_in_smp;
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {
diff -urN linuxppc_2_4_devel/mm/filemap.c linuxppc_2_4_devel_work/mm/filemap.c
--- linuxppc_2_4_devel/mm/filemap.c	Sun Nov 25 13:29:15 2001
+++ linuxppc_2_4_devel_work/mm/filemap.c	Sun Nov 25 13:36:43 2001
@@ -53,7 +54,7 @@
 EXPORT_SYMBOL(vm_min_readahead);
 
 
-spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagecache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
  *	with the pagecache_lock held.
@@ -63,7 +64,7 @@
  *		pagemap_lru_lock ->
  *			pagecache_lock
  */
-spinlock_t pagemap_lru_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
diff -urN linuxppc_2_4_devel/fs/dcache.c linuxppc_2_4_devel_work/fs/dcache.c
--- linuxppc_2_4_devel/fs/dcace.c	Wed Nov 28 16:48:23 2001
+++ linuxppc_2_4_devel_work/fs/dcache.c	Wed Nov 28 16:48:33 2001
@@ -29,7 +29,7 @@
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
 
-spinlock_t dcache_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Right now the dcache depends on the kernel lock */
 #define check_lock()	if (!kernel_locked()) BUG()
