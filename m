Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRJ2Q5m>; Mon, 29 Oct 2001 11:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276576AbRJ2Q5d>; Mon, 29 Oct 2001 11:57:33 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:16001 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S276552AbRJ2Q5R>; Mon, 29 Oct 2001 11:57:17 -0500
Message-ID: <3BDD8241.8002B946@de.ibm.com>
Date: Mon, 29 Oct 2001 17:22:25 +0100
From: Juergen Doelle <jdoelle@de.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Pls apply this spinlock patch to the kernel
X-MIMETrack: Itemize by SMTP Server on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 29/10/2001 17:23:25,
	Serialize by Router on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 29/10/2001 17:57:39,
	Serialize complete at 29/10/2001 17:57:39
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I had created a patch for improving the spinlock behavior on IA32 SMP 
systems for file system work load created with dbench 
(ftp://samba.org/pub/tridge/dbench). The work load is a mix of create, 
delete, write, and read operations executed from a scalable number of 
clients. It is mainly handled in buffer cache.

The patch introduces a new spinlock type, which is cacheline aligned
and occupies the full cacheline. The five hottest spinlocks for this 
work load are set to that type (kmap_lock, lru_list_lock, 
pagecache_lock, kernel_flag, pagemap_lru_lock)  The change is done in 
the common code, except for the kernel_flag. 

Due to that each lock has now a separate cacheline, the communication 
overhead for L1 cache synchronization is at the minimum for these 
spinlocks. This results in significant improvement on an IA32 system 
(PIII Xeon 700 MHz) for 4 and 8 CPUs.

The improvement by the patch on 2.4.12-ac5 is:

#CPU peak throughput	average from 8,10,12,..20 clients
 U	 0.0%			 0.1%        
 1	-0.1%			 0.0% 
 2	-0.8%			-1.2% 
 4	 3.7%			 4.4% 
 8	16.5%			23.2% 

Note:
o Differences of 0.1% can be considered as noise. UP should behave 
  unchanged.
o The throughput for 8 CPUs on the base kernel immediately declines
  after the maximum at 6 clients. 

With that patch the 8-way does not really scale, but it is not longer 
worse than a 4-way for that kind of workload.

I already have posted detailed measurement results and the patch to
the lse-tech mailing list and LKML. The current state of the patch 
has feedback from Steven Tweedie, Daniel Phillips, Andrea Arcangeli 
and Andrew Morton included.

Because the patch modifies common code, I also verified it on linux/390.
On that architecture it does not change the results. It seems that the 
overhead for cache synchronization is already minimal, because the CPUs 
are sharing one L2 cache. But this shows that the patch runs on other 
architectures, and in the worst case it does not disturb, even for on 
a system with a 256 byte cacheline.

I think this change is worth to go into the kernel, because it improves 
scaling for servers with 4 and more CPUs and the degradation for 2 CPU
systems is really small. 

Can you apply it to your kernel?

Thanks!
Juergen

______________________________________________________________
Juergen Doelle
IBM Linux Technology Center - kernel performance
jdoelle@de.ibm.com


= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

--- linux/include/linux/spinlock.h.orig	Tue Sep 25 09:05:09 2001
+++ linux/include/linux/spinlock.h	Tue Sep 25 11:42:51 2001
@@ -133,4 +133,20 @@
 extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #endif
 
+#ifdef CONFIG_SMP
+#include <linux/cache.h>
+
+typedef union {
+    spinlock_t lock;
+    char fill_up[(SMP_CACHE_BYTES)];
+} __attribute__ ((aligned(SMP_CACHE_BYTES))) spinlock_cacheline_t;
+
+#else	/* SMP */
+
+typedef struct {
+    spinlock_t lock;
+} spinlock_cacheline_t;
+
+
+#endif
 #endif /* __LINUX_SPINLOCK_H */
--- linux/include/linux/swap.h.orig	Tue Sep 25 09:59:15 2001
+++ linux/include/linux/swap.h	Tue Sep 25 11:42:51 2001
@@ -86,7 +86,10 @@
 extern atomic_t nr_async_pages;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
-extern spinlock_t pagecache_lock;
+
+extern spinlock_cacheline_t pagecache_lock_cacheline;
+#define pagecache_lock (pagecache_lock_cacheline.lock)
+
 extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
@@ -159,7 +162,8 @@
 extern unsigned long swap_cache_find_success;
 #endif
 
-extern spinlock_t pagemap_lru_lock;
+extern spinlock_cacheline_t pagemap_lru_lock_cacheline;
+#define pagemap_lru_lock pagemap_lru_lock_cacheline.lock
 
 extern void FASTCALL(mark_page_accessed(struct page *));
 
--- linux/include/asm-i386/smplock.h.orig	Tue Sep 25 11:29:51 2001
+++ linux/include/asm-i386/smplock.h	Tue Sep 25 11:42:52 2001
@@ -8,7 +8,8 @@
 #include <linux/sched.h>
 #include <asm/current.h>
 
-extern spinlock_t kernel_flag;
+extern spinlock_cacheline_t kernel_flag_cacheline;  
+#define kernel_flag kernel_flag_cacheline.lock      
 
 #define kernel_locked()		spin_is_locked(&kernel_flag)
 
--- linux/arch/i386/kernel/i386_ksyms.c.orig	Tue Sep 25 09:14:57 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Tue Sep 25 10:13:06 2001
@@ -120,7 +120,7 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(kernel_flag);
+EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
--- linux/arch/i386/kernel/smp.c.orig	Tue Sep 25 09:15:16 2001
+++ linux/arch/i386/kernel/smp.c	Tue Sep 25 10:13:06 2001
@@ -101,7 +101,7 @@
  */
 
 /* The 'big kernel lock' */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_cacheline_t kernel_flag_cacheline = {SPIN_LOCK_UNLOCKED};
 
 struct tlb_state cpu_tlbstate[NR_CPUS] = {[0 ... NR_CPUS-1] = { &init_mm, 0 }};
 
--- linux/fs/buffer.c.orig	Tue Sep 25 09:15:47 2001
+++ linux/fs/buffer.c	Wed Sep 26 12:17:29 2001
@@ -81,7 +81,10 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+
+static spinlock_cacheline_t lru_list_lock_cacheline = {SPIN_LOCK_UNLOCKED};
+#define lru_list_lock  lru_list_lock_cacheline.lock
+
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
--- linux/mm/filemap.c.orig	Tue Sep 25 09:16:06 2001
+++ linux/mm/filemap.c	Tue Sep 25 10:13:06 2001
@@ -46,12 +46,13 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;
 
-spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_cacheline_t pagecache_lock_cacheline  = {SPIN_LOCK_UNLOCKED};
+
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagecache_lock with
  *       the pagemap_lru_lock held.
  */
-spinlock_t pagemap_lru_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_cacheline_t pagemap_lru_lock_cacheline = {SPIN_LOCK_UNLOCKED};
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
--- linux/mm/highmem.c.orig	Tue Sep 25 09:29:49 2001
+++ linux/mm/highmem.c	Tue Sep 25 10:21:14 2001
@@ -32,7 +32,8 @@
  */
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
-static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_cacheline_t kmap_lock_cacheline = {SPIN_LOCK_UNLOCKED};
+#define kmap_lock  kmap_lock_cacheline.lock
 
 pte_t * pkmap_page_table;
