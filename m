Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285128AbRLFNGV>; Thu, 6 Dec 2001 08:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLFNGE>; Thu, 6 Dec 2001 08:06:04 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:46092 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285128AbRLFNFw>;
	Thu, 6 Dec 2001 08:05:52 -0500
Date: Fri, 7 Dec 2001 00:02:26 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Yusuf Goolamabbas <yusufg@outblaze.com>, ext3-users@redhat.com,
        linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: 2.4.17-pre2+ext3-0.9.16+anton's cache aligned smp
Message-ID: <20011206130226.GC28024@krispykreme>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <1007595740.818.2.camel@phantasy> <20011206163056.A15550@outblaze.com> <3C0F301D.3368595@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0F301D.3368595@zip.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> omigod look at that graph.

:) Well its probably worth explaining the results a bit. This machine has
a 128 byte cacheline and ppc uses a load with reservation, store
conditional pair to do atomic operations. The reservation granularity is
one cacheline and if another cpu stores into the cacheline we lose
the reservation. If this is the case its easy to see why forcing
hot locks into their own cacheline makes a big difference.

> Excuse me while I get frustrated.  Will someone *please* send that
> damn patch to marcelo@conectiva.com.br?

Marcelo had some concerns with my original patch (I changed some things
in UP too). I redid the patch (aligning kernel_flag too as suggested
by you) which does not affect UP, I'll forward it on :)

> (It can be improved further by putting padding *behind* the lock
> but hey).

Well since we put these spinlocks into the cachline_aligned section I
dont think we need any padding behind the lock, can you check out the
offsets in System.map, it looks ok on ppc64 at least :)

> Really?  The spinlock cacheline alignment alone made that
> difference?  I wonder why.

Im guessing xeon cannot satisfy a cacheline miss by stealing directly from
another cpus cache. If that is the case it could be quite expensive to
bounce a cacheline between cpus. But I am also suprised it made that
much difference.

Anton

diff -ru 2.4.17-pre2/arch/alpha/kernel/smp.c 2.4.17-pre2_work/arch/alpha/kernel/smp.c
--- 2.4.17-pre2/arch/alpha/kernel/smp.c	Fri Nov 23 18:12:35 2001
+++ 2.4.17-pre2_work/arch/alpha/kernel/smp.c	Thu Dec  6 22:47:23 2001
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/irq.h>
+#include <linux/cache.h>
 
 #include <asm/hwrpb.h>
 #include <asm/ptrace.h>
@@ -65,7 +66,7 @@
 	IPI_CPU_STOP,
 };
 
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Set to a secondary's cpuid when it comes online.  */
 static unsigned long smp_secondary_alive;
diff -ru 2.4.17-pre2/arch/i386/kernel/smp.c 2.4.17-pre2_work/arch/i386/kernel/smp.c
--- 2.4.17-pre2/arch/i386/kernel/smp.c	Thu Oct 25 11:29:51 2001
+++ 2.4.17-pre2_work/arch/i386/kernel/smp.c	Thu Dec  6 22:47:26 2001
@@ -17,6 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
+#include <linux/cache.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -102,7 +103,7 @@
  */
 
 /* The 'big kernel lock' */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 struct tlb_state cpu_tlbstate[NR_CPUS] = {[0 ... NR_CPUS-1] = { &init_mm, 0 }};
 
diff -ru 2.4.17-pre2/arch/ia64/kernel/smp.c 2.4.17-pre2_work/arch/ia64/kernel/smp.c
--- 2.4.17-pre2/arch/ia64/kernel/smp.c	Fri Nov 23 18:12:36 2001
+++ 2.4.17-pre2_work/arch/ia64/kernel/smp.c	Thu Dec  6 22:47:29 2001
@@ -30,6 +30,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/cache.h>
 
 #include <asm/atomic.h>
 #include <asm/bitops.h>
@@ -51,7 +52,7 @@
 #include <asm/mca.h>
 
 /* The 'big kernel lock' */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /*
  * Structure and data for smp_call_function(). This is designed to minimise static memory
diff -ru 2.4.17-pre2/arch/mips/kernel/smp.c 2.4.17-pre2_work/arch/mips/kernel/smp.c
--- 2.4.17-pre2/arch/mips/kernel/smp.c	Fri Nov 23 18:12:37 2001
+++ 2.4.17-pre2_work/arch/mips/kernel/smp.c	Thu Dec  6 22:47:37 2001
@@ -31,6 +31,7 @@
 #include <linux/timex.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/cache.h>
 
 #include <asm/atomic.h>
 #include <asm/processor.h>
@@ -52,7 +53,7 @@
 
 
 /* Ze Big Kernel Lock! */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int smp_threads_ready;  /* Not used */
 int smp_num_cpus;    
 int global_irq_holder = NO_PROC_ID;
diff -ru 2.4.17-pre2/arch/mips64/kernel/smp.c 2.4.17-pre2_work/arch/mips64/kernel/smp.c
--- 2.4.17-pre2/arch/mips64/kernel/smp.c	Thu Oct 25 11:29:20 2001
+++ 2.4.17-pre2_work/arch/mips64/kernel/smp.c	Thu Dec  6 22:47:44 2001
@@ -5,6 +5,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
+#include <linux/cache.h>
 
 #include <asm/atomic.h>
 #include <asm/processor.h>
@@ -52,7 +53,7 @@
 #endif /* CONFIG_SGI_IP27 */
 
 /* The 'big kernel lock' */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int smp_threads_ready;	/* Not used */
 atomic_t smp_commenced = ATOMIC_INIT(0);
 struct cpuinfo_mips cpu_data[NR_CPUS];
diff -ru 2.4.17-pre2/arch/ppc/kernel/smp.c 2.4.17-pre2_work/arch/ppc/kernel/smp.c
--- 2.4.17-pre2/arch/ppc/kernel/smp.c	Tue Nov 27 01:12:08 2001
+++ 2.4.17-pre2_work/arch/ppc/kernel/smp.c	Thu Dec  6 22:47:54 2001
@@ -23,6 +23,7 @@
 #include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/cache.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -45,7 +46,7 @@
 struct klock_info_struct klock_info = { KLOCK_CLEAR, 0 };
 atomic_t ipi_recv;
 atomic_t ipi_sent;
-spinlock_t kernel_flag __cacheline_aligned = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 unsigned int prof_multiplier[NR_CPUS];
 unsigned int prof_counter[NR_CPUS];
 cycles_t cacheflush_time;
diff -ru 2.4.17-pre2/arch/s390/kernel/smp.c 2.4.17-pre2_work/arch/s390/kernel/smp.c
--- 2.4.17-pre2/arch/s390/kernel/smp.c	Fri Nov 23 18:12:37 2001
+++ 2.4.17-pre2_work/arch/s390/kernel/smp.c	Thu Dec  6 22:48:00 2001
@@ -29,6 +29,7 @@
 #include <linux/smp_lock.h>
 
 #include <linux/delay.h>
+#include <linux/cache.h>
 
 #include <asm/sigp.h>
 #include <asm/pgalloc.h>
@@ -55,7 +56,7 @@
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
 static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
-spinlock_t       kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t       kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 unsigned long	 cpu_online_map;
 
diff -ru 2.4.17-pre2/arch/s390x/kernel/smp.c 2.4.17-pre2_work/arch/s390x/kernel/smp.c
--- 2.4.17-pre2/arch/s390x/kernel/smp.c	Fri Nov 23 18:12:37 2001
+++ 2.4.17-pre2_work/arch/s390x/kernel/smp.c	Thu Dec  6 22:48:10 2001
@@ -29,6 +29,7 @@
 #include <linux/smp_lock.h>
 
 #include <linux/delay.h>
+#include <linux/cache.h>
 
 #include <asm/sigp.h>
 #include <asm/pgalloc.h>
@@ -55,7 +56,7 @@
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
 static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
-spinlock_t       kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t       kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 unsigned long	 cpu_online_map;
 
diff -ru 2.4.17-pre2/arch/sparc/kernel/smp.c 2.4.17-pre2_work/arch/sparc/kernel/smp.c
--- 2.4.17-pre2/arch/sparc/kernel/smp.c	Fri Nov 23 18:12:37 2001
+++ 2.4.17-pre2_work/arch/sparc/kernel/smp.c	Thu Dec  6 22:48:17 2001
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/cache.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -66,7 +67,7 @@
  */
 
 /* Kernel spinlock */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Used to make bitops atomic */
 unsigned char bitops_spinlock = 0;
diff -ru 2.4.17-pre2/arch/sparc64/kernel/smp.c 2.4.17-pre2_work/arch/sparc64/kernel/smp.c
--- 2.4.17-pre2/arch/sparc64/kernel/smp.c	Thu Dec  6 22:50:55 2001
+++ 2.4.17-pre2_work/arch/sparc64/kernel/smp.c	Thu Dec  6 22:48:23 2001
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/cache.h>
 
 #include <asm/head.h>
 #include <asm/ptrace.h>
@@ -49,7 +50,7 @@
 static int smp_activated = 0;
 
 /* Kernel spinlock */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 volatile int smp_processors_ready = 0;
 unsigned long cpu_present_map = 0;
diff -ru 2.4.17-pre2/fs/block_dev.c 2.4.17-pre2_work/fs/block_dev.c
--- 2.4.17-pre2/fs/block_dev.c	Fri Nov 23 18:12:43 2001
+++ 2.4.17-pre2_work/fs/block_dev.c	Thu Dec  6 22:28:01 2001
@@ -234,7 +234,7 @@
 #define HASH_SIZE	(1UL << HASH_BITS)
 #define HASH_MASK	(HASH_SIZE-1)
 static struct list_head bdev_hashtable[HASH_SIZE];
-static spinlock_t bdev_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t bdev_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t * bdev_cachep;
 
 #define alloc_bdev() \
diff -ru 2.4.17-pre2/fs/buffer.c 2.4.17-pre2_work/fs/buffer.c
--- 2.4.17-pre2/fs/buffer.c	Thu Dec  6 22:50:56 2001
+++ 2.4.17-pre2_work/fs/buffer.c	Thu Dec  6 22:28:01 2001
@@ -73,7 +73,7 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t lru_list_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
diff -ru 2.4.17-pre2/fs/dcache.c 2.4.17-pre2_work/fs/dcache.c
--- 2.4.17-pre2/fs/dcache.c	Thu Oct 25 11:29:42 2001
+++ 2.4.17-pre2_work/fs/dcache.c	Thu Dec  6 22:28:01 2001
@@ -29,7 +29,7 @@
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
 
-spinlock_t dcache_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Right now the dcache depends on the kernel lock */
 #define check_lock()	if (!kernel_locked()) BUG()
diff -ru 2.4.17-pre2/include/linux/cache.h 2.4.17-pre2_work/include/linux/cache.h
--- 2.4.17-pre2/include/linux/cache.h	Thu Oct 25 11:29:44 2001
+++ 2.4.17-pre2_work/include/linux/cache.h	Thu Dec  6 22:28:01 2001
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
diff -ru 2.4.17-pre2/mm/filemap.c 2.4.17-pre2_work/mm/filemap.c
--- 2.4.17-pre2/mm/filemap.c	Tue Nov 27 01:12:08 2001
+++ 2.4.17-pre2_work/mm/filemap.c	Thu Dec  6 22:28:01 2001
@@ -53,7 +53,7 @@
 EXPORT_SYMBOL(vm_min_readahead);
 
 
-spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagecache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
  *	with the pagecache_lock held.
@@ -63,7 +63,7 @@
  *		pagemap_lru_lock ->
  *			pagecache_lock
  */
-spinlock_t pagemap_lru_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
diff -ru 2.4.17-pre2/mm/highmem.c 2.4.17-pre2_work/mm/highmem.c
--- 2.4.17-pre2/mm/highmem.c	Thu Oct 25 11:29:54 2001
+++ 2.4.17-pre2_work/mm/highmem.c	Thu Dec  6 22:34:47 2001
@@ -32,7 +32,7 @@
  */
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
-static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t kmap_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 pte_t * pkmap_page_table;
 
