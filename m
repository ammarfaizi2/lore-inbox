Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280782AbRKOI3k>; Thu, 15 Nov 2001 03:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280781AbRKOI3b>; Thu, 15 Nov 2001 03:29:31 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:7940 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280779AbRKOI3T>;
	Thu, 15 Nov 2001 03:29:19 -0500
Date: Thu, 15 Nov 2001 19:19:59 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] create __cacheline_aligned_in_smp
Message-ID: <20011115191959.H22552@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On large machines (I have found this on 8 and 16 way) performance
suffers because ____cacheline_aligned_in_smp does not prevent other
data from sharing the cacheline. This has been brought up a number of
times in the past.

Also on UP machines we waste memory because we use __cacheline_aligned
all over the place. In all the places I found, it was an SMP
optimisation and there was no need for it on UP.

This patch introduces __cacheline_aligned_in_smp which has the same
behaviour as __cacheline_aligned. I also changed a number of
__cacheline_aligned -> __cacheline_aligned_in_smp.

Anton


diff -ru 2.4.15-pre4/fs/buffer.c 2.4.15-pre4_work/fs/buffer.c
--- 2.4.15-pre4/fs/buffer.c	Thu Nov 15 13:38:03 2001
+++ 2.4.15-pre4_work/fs/buffer.c	Thu Nov 15 15:55:34 2001
@@ -73,7 +73,7 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t lru_list_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
diff -ru 2.4.15-pre4/fs/dcache.c 2.4.15-pre4_work/fs/dcache.c
--- 2.4.15-pre4/fs/dcache.c	Thu Oct 25 11:29:42 2001
+++ 2.4.15-pre4_work/fs/dcache.c	Thu Nov 15 15:50:43 2001
@@ -29,7 +29,7 @@
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
 
-spinlock_t dcache_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Right now the dcache depends on the kernel lock */
 #define check_lock()	if (!kernel_locked()) BUG()
diff -ru 2.4.15-pre4/include/linux/cache.h 2.4.15-pre4_work/include/linux/cache.h
--- 2.4.15-pre4/include/linux/cache.h	Thu Oct 25 11:29:44 2001
+++ 2.4.15-pre4_work/include/linux/cache.h	Thu Nov 15 15:45:34 2001
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
diff -ru 2.4.15-pre4/kernel/fork.c 2.4.15-pre4_work/kernel/fork.c
--- 2.4.15-pre4/kernel/fork.c	Thu Oct 25 11:29:44 2001
+++ 2.4.15-pre4_work/kernel/fork.c	Thu Nov 15 16:17:30 2001
@@ -206,7 +206,7 @@
 	return retval;
 }
 
-spinlock_t mmlist_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
+spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
diff -ru 2.4.15-pre4/kernel/sched.c 2.4.15-pre4_work/kernel/sched.c
--- 2.4.15-pre4/kernel/sched.c	Thu Nov 15 13:38:04 2001
+++ 2.4.15-pre4_work/kernel/sched.c	Thu Nov 15 16:16:31 2001
@@ -88,8 +88,8 @@
  *
  * task->alloc_lock nests inside tasklist_lock.
  */
-spinlock_t runqueue_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;  /* inner */
-rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;	/* outer */
+spinlock_t runqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED; /* inner */
+rwlock_t tasklist_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED; /* outer */
 
 static LIST_HEAD(runqueue_head);
 
diff -ru 2.4.15-pre4/kernel/softirq.c 2.4.15-pre4_work/kernel/softirq.c
--- 2.4.15-pre4/kernel/softirq.c	Tue Nov  6 11:13:56 2001
+++ 2.4.15-pre4_work/kernel/softirq.c	Thu Nov 15 16:16:49 2001
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
diff -ru 2.4.15-pre4/mm/filemap.c 2.4.15-pre4_work/mm/filemap.c
--- 2.4.15-pre4/mm/filemap.c	Thu Nov 15 13:38:04 2001
+++ 2.4.15-pre4_work/mm/filemap.c	Thu Nov 15 15:49:34 2001
@@ -47,7 +47,7 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;
 
-spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagecache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
  *	with the pagecache_lock held.
@@ -57,7 +57,7 @@
  *		pagemap_lru_lock ->
  *			pagecache_lock
  */
-spinlock_t pagemap_lru_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
