Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273511AbRIUNRl>; Fri, 21 Sep 2001 09:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273509AbRIUNRZ>; Fri, 21 Sep 2001 09:17:25 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:26241 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S273511AbRIUNRD>; Fri, 21 Sep 2001 09:17:03 -0400
Message-ID: <3BAB3D65.2FDD170C@de.ibm.com>
Date: Fri, 21 Sep 2001 15:15:17 +0200
From: Juergen Doelle <jdoelle@de.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Mark Hemment <markhe@veritas.com>, lse-tech@lists.sourceforge.net,
        "Steve Fox" <stevefx@us.ibm.com>
Subject: Re: [PATCH] Align VM locks, new spinlock patch
X-MIMETrack: Itemize by SMTP Server on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 21/09/2001 15:16:09,
	Serialize by Router on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 21/09/2001 15:16:32,
	Serialize complete at 21/09/2001 15:16:32
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Thu, Aug 16, 2001 at 12:14:23PM -0700, Andrew Morton wrote:
> > Problem with this approach is that it doesn't prevent the linker
> > from placing other data in the same cacheline as the aligned
> > lock, at higher addresses.
> 
> that was partly intentional, but ok we can be more aggressive on that
> side ;).
> 
> > Juergen, I'd suggest you dust off that patch, add the conditionals
> > which make it a no-op on uniprocessor and submit it.  It's such a
> 
> agreed, btw it is just a noop on up but it is undefined for __GNUC__ >
> 2, also it would be nice if he could do it in linux/ instead of asm/, it
> should not need special arch trick (spinlock_t and SMP_CACHE_SIZE are
> the only thing it needs).


Sorry, it tooks some time, because of my vacation and then the disk drive
I used for testing gets damaged.

I changed the spinlock patch according to your suggestions. 

Description
-----------

The patch introduces a new type spinlock_cacheline_t which 
o aligns the spinlock to a cacheline and 
o avoids that this spinlock shares the cacheline with other data
This type is now hardware independent.

It declares following spinlocks from type spinlock_cacheline_t:
o kmap_lock         
o pagecache_lock    
o pagemap_lru_lock  
o lru_list_lock     
o kernel_flag  
Where the kernel_flag is modified only for i386 architecture, because
the spinlock itself is hardware dependent implemented. 

I tested the patch on 2.4.5, 2.4.8, and 2.4.10-pre7. 
Kernel 2.4.10-pre7 requires a separate version of the patch, because 
the pagecache_lock and the lru_list_lock are already aligned.


The peak throughput results with dbench:

    2.4.10  2.4.10 +        improvement 
            spinlock patch  by patch    

 U  103.77  102.14          - 1.6%
 1   96.82   96.77          - 0.1%
 2  155.32  155.62            0.2%
 4  209.45  222.11            6.0%
 8  208.06  234.82           12.9%

The improvement is less than in previous posted results, because the 
pagemap_lru_lock and the lru_list_lock are already cacheline aligned
in 2.4.10 (2.4.9).

I attached two versions of the patch, one which applies for 2.4.x-2.4.8
and below a version for 2.4.10 (heading: Spinlock patch for kernel 2.4.10),
which applies also to 2.4.9, but I didn't test it.

Juergen 

______________________________________________________________
Juergen Doelle
IBM Linux Technology Center - kernel performance
jdoelle@de.ibm.com




= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Spinlock patch for kernel 2.4.x-2.4.8
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

--- linux/include/asm-i386/smplock.h.orig	Thu Sep  6 14:46:25 2001
+++ linux/include/asm-i386/smplock.h	Thu Sep  6 16:38:02 2001
@@ -8,7 +8,13 @@
 #include <linux/sched.h>
 #include <asm/current.h>
 
-extern spinlock_t kernel_flag;
+
+#ifdef CONFIG_SMP
+    extern spinlock_cacheline_t kernel_flag_cacheline; 
+    #define kernel_flag kernel_flag_cacheline.lock     
+#else
+    extern spinlock_t kernel_flag;
+#endif
 
 #define kernel_locked()		spin_is_locked(&kernel_flag)
 
--- linux/arch/i386/kernel/i386_ksyms.c.orig	Thu Sep  6 16:00:29 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Thu Sep  6 16:03:07 2001
@@ -120,7 +120,7 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(kernel_flag);
+EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
--- linux/include/linux/spinlock.h.orig	Thu Sep  6 14:30:41 2001
+++ linux/include/linux/spinlock.h	Thu Sep  6 16:38:02 2001
@@ -34,6 +34,13 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
+#include <linux/cache.h>
+typedef union {                                                    
+    spinlock_t lock;                                               
+    char fill_up[(SMP_CACHE_BYTES)];                               
+} spinlock_cacheline_t __attribute__ ((aligned(SMP_CACHE_BYTES))); 
+                                                                   
+
 #elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
                                   defined (e.g. by including asm/spinlock.h */
 
--- linux/include/linux/swap.h.orig	Thu Sep  6 14:38:01 2001
+++ linux/include/linux/swap.h	Thu Sep  6 16:38:02 2001
@@ -88,7 +88,13 @@
 extern struct address_space swapper_space;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
-extern spinlock_t pagecache_lock;
+#ifdef CONFIG_SMP
+    extern spinlock_cacheline_t pagecache_lock_cacheline;  
+    #define pagecache_lock (pagecache_lock_cacheline.lock) 
+#else
+    extern spinlock_t pagecache_lock;
+#endif
+
 extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
@@ -179,7 +185,12 @@
 extern unsigned long swap_cache_find_success;
 #endif
 
-extern spinlock_t pagemap_lru_lock;
+#ifdef CONFIG_SMP
+    extern spinlock_cacheline_t pagemap_lru_lock_cacheline;  
+    #define pagemap_lru_lock pagemap_lru_lock_cacheline.lock 
+#else
+    extern spinlock_t pagemap_lru_lock;
+#endif
 
 /*
  * Page aging defines.
--- linux/fs/buffer.c.orig	Thu Sep  6 15:10:07 2001
+++ linux/fs/buffer.c	Thu Sep  6 15:54:00 2001
@@ -83,13 +83,22 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+
+#ifdef CONFIG_SMP
+    static spinlock_cacheline_t lru_list_lock_cacheline = {SPIN_LOCK_UNLOCKED}; 
+    #ifndef lru_list_lock                                                       
+        #define lru_list_lock  lru_list_lock_cacheline.lock                       
+    #endif                                                                      
+#else
+    static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;    
+#endif
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
 static struct buffer_head * unused_list;
 static int nr_unused_buffer_heads;
 static spinlock_t unused_list_lock = SPIN_LOCK_UNLOCKED;
+
 static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
 
 struct bh_free_head {
--- linux/mm/filemap.c.orig	Thu Sep  6 14:55:44 2001
+++ linux/mm/filemap.c	Thu Sep  6 15:06:21 2001
@@ -45,12 +45,28 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;
 
-spinlock_t pagecache_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+    spinlock_cacheline_t pagecache_lock_cacheline  = {SPIN_LOCK_UNLOCKED};  
+    #ifndef pagecache_lock                                                  
+        #define pagecache_lock  pagecache_lock_cacheline.lock                 
+    #endif                                                                  
+#else
+    spinlock_t pagecache_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagecache_lock with
  *       the pagemap_lru_lock held.
  */
-spinlock_t pagemap_lru_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+    spinlock_cacheline_t pagemap_lru_lock_cacheline = {SPIN_LOCK_UNLOCKED};  
+    #ifndef pagemap_lru_lock                                                 
+        #define pagemap_lru_lock  pagemap_lru_lock_cacheline.lock             
+    #endif                                                                   
+#else
+    spinlock_t pagemap_lru_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
--- linux/mm/highmem.c.orig	Thu Sep  6 14:55:54 2001
+++ linux/mm/highmem.c	Thu Sep  6 15:08:22 2001
@@ -32,7 +32,14 @@
  */
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
-static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+    static spinlock_cacheline_t kmap_lock_cacheline = {SPIN_LOCK_UNLOCKED}; 
+    #ifndef kmap_lock                                                       
+        #define kmap_lock  kmap_lock_cacheline.lock                           
+    #endif                                                                  
+#else
+    static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+#endif
 
 pte_t * pkmap_page_table;
 
--- linux/arch/i386/kernel/smp.c.orig	Thu Sep  6 14:52:01 2001
+++ linux/arch/i386/kernel/smp.c	Thu Sep  6 16:04:38 2001
@@ -101,7 +101,14 @@
  */
 
 /* The 'big kernel lock' */
+#ifdef CONFIG_SMP
+    spinlock_cacheline_t kernel_flag_cacheline = {SPIN_LOCK_UNLOCKED}; 
+    #ifndef kernel_flag                                                
+        #define kernel_flag  kernel_flag_cacheline.lock                  
+    #endif
+#else                                              
 spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+#endif
 
 struct tlb_state cpu_tlbstate[NR_CPUS] = {[0 ... NR_CPUS-1] = { &init_mm, 0 }};
 

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Spinlock patch for kernel 2.4.10 (2.4.9)
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

--- linux/include/asm-i386/smplock.h.orig	Thu Sep  6 14:46:25 2001
+++ linux/include/asm-i386/smplock.h	Thu Sep  6 16:38:02 2001
@@ -8,7 +8,13 @@
 #include <linux/sched.h>
 #include <asm/current.h>
 
-extern spinlock_t kernel_flag;
+
+#ifdef CONFIG_SMP
+    extern spinlock_cacheline_t kernel_flag_cacheline; 
+    #define kernel_flag kernel_flag_cacheline.lock     
+#else
+    extern spinlock_t kernel_flag;
+#endif
 
 #define kernel_locked()		spin_is_locked(&kernel_flag)
 
--- linux/arch/i386/kernel/i386_ksyms.c.orig	Thu Sep  6 16:00:29 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Thu Sep  6 16:03:07 2001
@@ -120,7 +120,7 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(kernel_flag);
+EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
--- linux/include/linux/spinlock.h.orig	Thu Sep  6 14:30:41 2001
+++ linux/include/linux/spinlock.h	Thu Sep  6 16:38:02 2001
@@ -34,6 +34,13 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
+#include <linux/cache.h>
+typedef union {                                                    
+    spinlock_t lock;                                               
+    char fill_up[(SMP_CACHE_BYTES)];                               
+} spinlock_cacheline_t __attribute__ ((aligned(SMP_CACHE_BYTES))); 
+                                                                   
+
 #elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
                                   defined (e.g. by including asm/spinlock.h */
 
--- linux/include/linux/swap.h.orig	Thu Sep  6 14:38:01 2001
+++ linux/include/linux/swap.h	Thu Sep  6 16:38:02 2001
@@ -88,7 +88,13 @@
 extern struct address_space swapper_space;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
-extern spinlock_t pagecache_lock;
+#ifdef CONFIG_SMP
+    extern spinlock_cacheline_t pagecache_lock_cacheline;  
+    #define pagecache_lock (pagecache_lock_cacheline.lock) 
+#else
+    extern spinlock_t pagecache_lock;
+#endif
+
 extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
@@ -179,7 +185,12 @@
 extern unsigned long swap_cache_find_success;
 #endif
 
-extern spinlock_t pagemap_lru_lock;
+#ifdef CONFIG_SMP
+    extern spinlock_cacheline_t pagemap_lru_lock_cacheline;  
+    #define pagemap_lru_lock pagemap_lru_lock_cacheline.lock 
+#else
+    extern spinlock_t pagemap_lru_lock;
+#endif
 
 /*
  * Page aging defines.
--- linux/fs/buffer.c.orig	Thu Sep  6 15:10:07 2001
+++ linux/fs/buffer.c	Thu Sep  6 15:54:00 2001
@@ -83,13 +83,22 @@
 static rwlock_t hash_table_lock = RW_LOCK_UNLOCKED;
 
 static struct buffer_head *lru_list[NR_LIST];
-static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;
+
+#ifdef CONFIG_SMP
+    static spinlock_cacheline_t lru_list_lock_cacheline = {SPIN_LOCK_UNLOCKED}; 
+    #ifndef lru_list_lock                                                       
+        #define lru_list_lock  lru_list_lock_cacheline.lock                       
+    #endif                                                                      
+#else
+    static spinlock_t lru_list_lock = SPIN_LOCK_UNLOCKED;    
+#endif
 static int nr_buffers_type[NR_LIST];
 static unsigned long size_buffers_type[NR_LIST];
 
 static struct buffer_head * unused_list;
 static int nr_unused_buffer_heads;
 static spinlock_t unused_list_lock = SPIN_LOCK_UNLOCKED;
+
 static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
 
 struct bh_free_head {
--- linux/mm/filemap.c.orig	Thu Sep  6 14:55:44 2001
+++ linux/mm/filemap.c	Thu Sep  6 15:06:21 2001
@@ -45,12 +45,28 @@
 unsigned int page_hash_bits;
 struct page **page_hash_table;
 
-spinlock_t __cacheline_aligned pagecache_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+    spinlock_cacheline_t pagecache_lock_cacheline  = {SPIN_LOCK_UNLOCKED};  
+    #ifndef pagecache_lock                                                  
+        #define pagecache_lock  pagecache_lock_cacheline.lock                 
+    #endif                                                                  
+#else
+    spinlock_t pagecache_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagecache_lock with
  *       the pagemap_lru_lock held.
  */
-spinlock_t __cacheline_aligned pagemap_lru_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+    spinlock_cacheline_t pagemap_lru_lock_cacheline = {SPIN_LOCK_UNLOCKED};  
+    #ifndef pagemap_lru_lock                                                 
+        #define pagemap_lru_lock  pagemap_lru_lock_cacheline.lock             
+    #endif                                                                   
+#else
+    spinlock_t pagemap_lru_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
--- linux/mm/highmem.c.orig	Thu Sep  6 14:55:54 2001
+++ linux/mm/highmem.c	Thu Sep  6 15:08:22 2001
@@ -32,7 +32,14 @@
  */
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
-static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+    static spinlock_cacheline_t kmap_lock_cacheline = {SPIN_LOCK_UNLOCKED}; 
+    #ifndef kmap_lock                                                       
+        #define kmap_lock  kmap_lock_cacheline.lock                           
+    #endif                                                                  
+#else
+    static spinlock_t kmap_lock = SPIN_LOCK_UNLOCKED;
+#endif
 
 pte_t * pkmap_page_table;
 
--- linux/arch/i386/kernel/smp.c.orig	Thu Sep  6 14:52:01 2001
+++ linux/arch/i386/kernel/smp.c	Thu Sep  6 16:04:38 2001
@@ -101,7 +101,14 @@
  */
 
 /* The 'big kernel lock' */
+#ifdef CONFIG_SMP
+    spinlock_cacheline_t kernel_flag_cacheline = {SPIN_LOCK_UNLOCKED}; 
+    #ifndef kernel_flag                                                
+        #define kernel_flag  kernel_flag_cacheline.lock                  
+    #endif
+#else                                                             
 spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
+#endif
 
 struct tlb_state cpu_tlbstate[NR_CPUS] = {[0 ... NR_CPUS-1] = { &init_mm, 0 }};
