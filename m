Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbRIVXHo>; Sat, 22 Sep 2001 19:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272467AbRIVXHg>; Sat, 22 Sep 2001 19:07:36 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:27154 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272466AbRIVXHP>; Sat, 22 Sep 2001 19:07:15 -0400
Message-ID: <3BAD19A3.C57944E8@zip.com.au>
Date: Sat, 22 Sep 2001 16:07:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Juergen Doelle <jdoelle@de.ibm.com>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Mark Hemment <markhe@veritas.com>, lse-tech@lists.sourceforge.net,
        Steve Fox <stevefx@us.ibm.com>
Subject: Re: [PATCH] Align VM locks, new spinlock patch
In-Reply-To: <3BAB3D65.2FDD170C@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Doelle wrote:
> 
> ...
> The patch introduces a new type spinlock_cacheline_t which
> o aligns the spinlock to a cacheline and
> o avoids that this spinlock shares the cacheline with other data
> This type is now hardware independent.
> 
> It declares following spinlocks from type spinlock_cacheline_t:
> o kmap_lock
> o pagecache_lock
> o pagemap_lru_lock
> o lru_list_lock
> o kernel_flag
> Where the kernel_flag is modified only for i386 architecture, because
> the spinlock itself is hardware dependent implemented.
> 
> I tested the patch on 2.4.5, 2.4.8, and 2.4.10-pre7.
> Kernel 2.4.10-pre7 requires a separate version of the patch, because
> the pagecache_lock and the lru_list_lock are already aligned.
> 
> The peak throughput results with dbench:
> 
>     2.4.10  2.4.10 +        improvement
>             spinlock patch  by patch
> 
>  U  103.77  102.14          - 1.6%
>  1   96.82   96.77          - 0.1%
>  2  155.32  155.62            0.2%
>  4  209.45  222.11            6.0%
>  8  208.06  234.82           12.9%
> 

I guess the uniprocessor case is measurement error - spin_lock()
is a no-op on UP.

I think the coding can be simplified somewhat.  How does this
look?



--- linux-2.4.10-pre14/include/linux/spinlock.h	Mon Jul 30 20:55:14 2001
+++ linux-akpm/include/linux/spinlock.h	Sat Sep 22 14:15:25 2001
@@ -133,4 +133,20 @@ typedef struct {
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
--- linux-2.4.10-pre14/include/linux/swap.h	Sat Sep 22 13:58:05 2001
+++ linux-akpm/include/linux/swap.h	Sat Sep 22 14:15:25 2001
@@ -87,7 +87,10 @@ extern atomic_t nr_async_pages;
 extern struct address_space swapper_space;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
-extern spinlock_t pagecache_lock;
+
+extern spinlock_cacheline_t pagecache_lock_cacheline;  
+#define pagecache_lock (pagecache_lock_cacheline.lock) 
+
 extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
@@ -168,7 +171,8 @@ extern unsigned long swap_cache_find_tot
 extern unsigned long swap_cache_find_success;
 #endif
 
-extern spinlock_t pagemap_lru_lock;
+extern spinlock_cacheline_t pagemap_lru_lock_cacheline;  
+#define pagemap_lru_lock pagemap_lru_lock_cacheline.lock 
 
 extern void FASTCALL(mark_page_accessed(struct page *));
 
--- linux-2.4.10-pre14/arch/i386/kernel/i386_ksyms.c	Sat Sep 22 13:57:52 2001
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Sat Sep 22 13:42:22 2001
@@ -120,7 +120,7 @@ EXPORT_SYMBOL(mmx_copy_page);
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(kernel_flag);
+EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
--- linux-2.4.10-pre14/arch/i386/kernel/smp.c	Sat Sep 22 13:57:52 2001
+++ linux-akpm/arch/i386/kernel/smp.c	Sat Sep 22 13:42:22 2001
@@ -101,7 +101,7 @@
  */
 
 /* The 'big kernel lock' */
-spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+spinlock_cacheline_t kernel_flag_cacheline = {SPIN_LOCK_UNLOCKED}; 
 
 struct tlb_state cpu_tlbstate[NR_CPUS] = {[0 ... NR_CPUS-1] = { &init_mm, 0 }};
 
--- linux-2.4.10-pre14/fs/buffer.c	Sat Sep 22 13:58:00 2001
+++ linux-akpm/fs/buffer.c	Sat Sep 22 13:42:22 2001
@@ -81,13 +81,17 @@ static struct buffer_head **hash_table;
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+
+static spinlock_cacheline_t lru_list_lock_cacheline = {SPIN_LOCK_UNLOCKED}; 
+#define lru_list_lock  lru_list_lock_cacheline.lock                       
+
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
 static struct buffer_head * unused_list;
 static int nr_unused_buffer_heads;
 static spinlock_t unused_list_lock = SPIN_LOCK_UNLOCKED;
+
 static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
 
 struct bh_free_head {
--- linux-2.4.10-pre14/mm/filemap.c	Sat Sep 22 13:58:05 2001
+++ linux-akpm/mm/filemap.c	Sat Sep 22 13:42:22 2001
@@ -46,12 +46,13 @@ atomic_t page_cache_size = ATOMIC_INIT(0
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
--- linux-2.4.10-pre14/mm/highmem.c	Sat Sep 22 13:58:05 2001
+++ linux-akpm/mm/highmem.c	Sat Sep 22 13:42:22 2001
@@ -32,7 +32,7 @@
  */
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
-static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_cacheline_t kmap_lock_cacheline = {SPIN_LOCK_UNLOCKED}; 
 
 pte_t * pkmap_page_table;
