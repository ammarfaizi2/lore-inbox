Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275257AbRIZPSK>; Wed, 26 Sep 2001 11:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275256AbRIZPSB>; Wed, 26 Sep 2001 11:18:01 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:22912 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S275255AbRIZPRu>; Wed, 26 Sep 2001 11:17:50 -0400
Message-ID: <3BB1F11B.296FE9CB@de.ibm.com>
Date: Wed, 26 Sep 2001 17:15:39 +0200
From: Juergen Doelle <jdoelle@de.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Mark Hemment <markhe@veritas.com>, "Steve Fox" <stevefx@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Align VM locks, new spinlock patch
X-MIMETrack: Itemize by SMTP Server on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 26/09/2001 17:16:32,
	Serialize by Router on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 26/09/2001 17:16:56,
	Serialize complete at 26/09/2001 17:16:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I think the coding can be simplified somewhat.  How does this
> look?
> ...

Looks fine, it makes the code more common between UP and SMP. 
I consolidated the changes and appended the new version below.


The peak throughput results (MB/sec) for dbench on 2.4.10:

CPU 2.4.10  2.4.10 +        improvement 
            spinlock patch  by patch    

 U  102,9   103,0          0,0%
 1   95,1    96,9          1,9%
 2  155,5   156,0          0,3%
 4  206,9   222,1          7,3%
 8  194,9   233,7         19,9%

Throughput (MB/sec) for dbench with 8 clients on 8 CPUs:
CPU 2.4.10  2.4.10 +        improvement 
            spinlock patch  by patch    
 8  173,9   223,0            28,2%


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
+} spinlock_cacheline_t __attribute__ ((aligned(SMP_CACHE_BYTES)));
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
