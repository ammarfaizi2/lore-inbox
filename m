Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbRAGUia>; Sun, 7 Jan 2001 15:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132933AbRAGUiU>; Sun, 7 Jan 2001 15:38:20 -0500
Received: from inje.iskon.hr ([213.191.128.16]:22546 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S132672AbRAGUiO>;
	Sun, 7 Jan 2001 15:38:14 -0500
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch] mm-cleanup-1 (2.4.0)
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 07 Jan 2001 21:36:40 +0100
Message-ID: <87snmv9k13.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch cleans up some obsolete structures from the mm &
proc code.

Beside that it also fixes what I think is a bug:

        if ((rw == WRITE) && atomic_read(&nr_async_pages) >
                       pager_daemon.swap_cluster * (1 << page_cluster))

In that (swapout logic) it effectively says swap out 512KB at once (at
least on my memory configuration). I think that is a little too much.
I modified it to be a little bit more conservative and send only
(1 << page_cluster) to the swap at a time. Same applies to the
swapin_readahead() function. Comments welcome.

Index: 0.2/mm/oom_kill.c
--- 0.2/mm/oom_kill.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/0_oom_kill.c 1.1 644)
+++ 0.6/mm/oom_kill.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/0_oom_kill.c 1.2 644)
@@ -18,7 +18,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/timex.h>
 
 /* #define DEBUG */
Index: 0.2/mm/bootmem.c
--- 0.2/mm/bootmem.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/3_bootmem.c 1.1 644)
+++ 0.6/mm/bootmem.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/3_bootmem.c 1.2 644)
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
Index: 0.2/mm/swap_state.c
--- 0.2/mm/swap_state.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/6_swap_state 1.1 644)
+++ 0.6/mm/swap_state.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/6_swap_state 1.2 644)
@@ -10,7 +10,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
Index: 0.2/mm/swapfile.c
--- 0.2/mm/swapfile.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/8_swapfile.c 1.1 644)
+++ 0.6/mm/swapfile.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/8_swapfile.c 1.2 644)
@@ -9,7 +9,6 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/blkdev.h> /* for blk_size */
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
Index: 0.2/mm/vmscan.c
--- 0.2/mm/vmscan.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/9_vmscan.c 1.1 644)
+++ 0.6/mm/vmscan.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/9_vmscan.c 1.2 644)
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
Index: 0.2/mm/page_io.c
--- 0.2/mm/page_io.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/10_page_io.c 1.1 644)
+++ 0.6/mm/page_io.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/10_page_io.c 1.3 644)
@@ -14,7 +14,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/locks.h>
-#include <linux/swapctl.h>
 
 #include <asm/pgtable.h>
 
@@ -44,7 +43,7 @@
 
 	/* Don't allow too many pending pages in flight.. */
 	if ((rw == WRITE) && atomic_read(&nr_async_pages) >
-			pager_daemon.swap_cluster * (1 << page_cluster))
+	    (1 << page_cluster))
 		wait = 1;
 
 	if (rw == READ) {
Index: 0.2/mm/filemap.c
--- 0.2/mm/filemap.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/12_filemap.c 1.1 644)
+++ 0.6/mm/filemap.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/12_filemap.c 1.2 644)
@@ -18,7 +18,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/file.h>
-#include <linux/swapctl.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/mm.h>
Index: 0.2/mm/page_alloc.c
--- 0.2/mm/page_alloc.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/14_page_alloc 1.1 644)
+++ 0.6/mm/page_alloc.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/14_page_alloc 1.2 644)
@@ -12,7 +12,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
Index: 0.2/mm/mmap.c
--- 0.2/mm/mmap.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/16_mmap.c 1.1 644)
+++ 0.6/mm/mmap.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/16_mmap.c 1.2 644)
@@ -8,7 +8,6 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/file.h>
Index: 0.2/mm/swap.c
--- 0.2/mm/swap.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/17_swap.c 1.1 644)
+++ 0.6/mm/swap.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/17_swap.c 1.4 644)
@@ -10,13 +10,11 @@
  * linux/Documentation/sysctl/vm.txt.
  * Started 18.12.91
  * Swap aging added 23.2.95, Stephen Tweedie.
- * Buffermem limits added 12.3.98, Rik van Riel.
  */
 
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 
@@ -42,6 +40,10 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
+/* We track the number of pages currently being asynchronously swapped
+   out, so that we don't try to swap TOO many pages out at once */
+atomic_t nr_async_pages = ATOMIC_INIT(0);
+
 /*
  * This variable contains the amount of page steals the system
  * is doing, averaged over a minute. We use this to determine how
@@ -52,28 +54,6 @@
  * In recalculate_vm_stats the value is decayed (once a second)
  */
 int memory_pressure;
-
-/* We track the number of pages currently being asynchronously swapped
-   out, so that we don't try to swap TOO many pages out at once */
-atomic_t nr_async_pages = ATOMIC_INIT(0);
-
-buffer_mem_t buffer_mem = {
-	2,	/* minimum percent buffer */
-	10,	/* borrow percent buffer */
-	60	/* maximum percent buffer */
-};
-
-buffer_mem_t page_cache = {
-	2,	/* minimum percent page cache */
-	15,	/* borrow percent page cache */
-	75	/* maximum */
-};
-
-pager_daemon_t pager_daemon = {
-	512,	/* base number for calculating the number of tries */
-	SWAP_CLUSTER_MAX,	/* minimum number of tries */
-	8,	/* do swap I/O in clusters of this size */
-};
 
 /**
  * age_page_{up,down} -	page aging helper functions
Index: 0.2/mm/memory.c
--- 0.2/mm/memory.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/18_memory.c 1.1 644)
+++ 0.6/mm/memory.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/18_memory.c 1.3 644)
@@ -40,7 +40,6 @@
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/smp_lock.h>
-#include <linux/swapctl.h>
 #include <linux/iobuf.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1000,8 +999,7 @@
 	num = valid_swaphandles(entry, &offset);
 	for (i = 0; i < num; offset++, i++) {
 		/* Don't block on I/O for read-ahead */
-		if (atomic_read(&nr_async_pages) >= pager_daemon.swap_cluster
-				* (1 << page_cluster)) {
+		if (atomic_read(&nr_async_pages) >= (1 << page_cluster)) {
 			while (i++ < num)
 				swap_free(SWP_ENTRY(SWP_TYPE(entry), offset++));
 			break;
Index: 0.2/kernel/sysctl.c
--- 0.2/kernel/sysctl.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/38_sysctl.c 1.1 644)
+++ 0.6/kernel/sysctl.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/38_sysctl.c 1.1.1.3 644)
@@ -20,8 +20,8 @@
 
 #include <linux/config.h>
 #include <linux/malloc.h>
+#include <linux/swap.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
@@ -241,18 +241,12 @@
 
 static ctl_table vm_table[] = {
 	{VM_FREEPG, "freepages", 
-	 &freepages, sizeof(freepages_t), 0444, NULL, &proc_dointvec},
+	 &freepages, 3*sizeof(int), 0444, NULL, &proc_dointvec},
 	{VM_BDFLUSH, "bdflush", &bdf_prm, 9*sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
-	{VM_BUFFERMEM, "buffermem",
-	 &buffer_mem, sizeof(buffer_mem_t), 0644, NULL, &proc_dointvec},
-	{VM_PAGECACHE, "pagecache",
-	 &page_cache, sizeof(buffer_mem_t), 0644, NULL, &proc_dointvec},
-	{VM_PAGERDAEMON, "kswapd",
-	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PGT_CACHE, "pagetable_cache", 
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
Index: 0.2/include/linux/swap.h
--- 0.2/include/linux/swap.h Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/d/b/26_swap.h 1.1 644)
+++ 0.6/include/linux/swap.h Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/d/b/26_swap.h 1.2 644)
@@ -63,6 +63,15 @@
 	int next;			/* next entry on swap list */
 };
 
+typedef struct freepages_v1
+{
+	unsigned int	min;
+	unsigned int	low;
+	unsigned int	high;
+} freepages_v1;
+typedef freepages_v1 freepages_t;
+extern freepages_t freepages;
+
 extern int nr_swap_pages;
 FASTCALL(unsigned int nr_free_pages(void));
 FASTCALL(unsigned int nr_inactive_clean_pages(void));
@@ -80,7 +89,6 @@
 struct task_struct;
 struct vm_area_struct;
 struct sysinfo;
-
 struct zone_t;
 
 /* linux/mm/swap.c */
Index: 0.2/include/linux/sysctl.h
--- 0.2/include/linux/sysctl.h Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/e/b/38_sysctl.h 1.1 644)
+++ 0.6/include/linux/sysctl.h Sun, 07 Jan 2001 19:16:44 +0100 zcalusic (linux24/e/b/38_sysctl.h 1.1.1.2 644)
@@ -128,9 +128,9 @@
 	VM_FREEPG=3,		/* struct: Set free page thresholds */
 	VM_BDFLUSH=4,		/* struct: Control buffer cache flushing */
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
-	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
-	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
-	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
+/* was	VM_BUFFERMEM */
+/* was	VM_PAGECACHE */
+/* was	VM_PAGERDAEMON */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
 	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
 };
Index: 0.2/include/linux/mm.h
--- 0.2/include/linux/mm.h Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/g/b/6_mm.h 1.1 644)
+++ 0.6/include/linux/mm.h Sun, 07 Jan 2001 18:42:20 +0100 zcalusic (linux24/g/b/6_mm.h 1.2 644)
@@ -521,11 +521,6 @@
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-#define buffer_under_min()	(atomic_read(&buffermem_pages) * 100 < \
-				buffer_mem.min_percent * num_physpages)
-#define pgcache_under_min()	(atomic_read(&page_cache_size) * 100 < \
-				page_cache.min_percent * num_physpages)
-
 #endif /* __KERNEL__ */
 
 #endif
Index: 0.2/fs/coda/sysctl.c
--- 0.2/fs/coda/sysctl.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/j/b/38_sysctl.c 1.1 644)
+++ 0.6/fs/coda/sysctl.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/j/b/38_sysctl.c 1.2 644)
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/malloc.h>
 #include <linux/stat.h>
Index: 0.2/fs/buffer.c
--- 0.2/fs/buffer.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/p/b/15_buffer.c 1.1 644)
+++ 0.6/fs/buffer.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/p/b/15_buffer.c 1.2 644)
@@ -35,7 +35,6 @@
 #include <linux/locks.h>
 #include <linux/errno.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
Index: 0.2/arch/mips64/mm/init.c
--- 0.2/arch/mips64/mm/init.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/o/c/30_init.c 1.1 644)
+++ 0.6/arch/mips64/mm/init.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/o/c/30_init.c 1.2 644)
@@ -22,7 +22,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
Index: 0.2/arch/arm/mm/init.c
--- 0.2/arch/arm/mm/init.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/v/c/33_init.c 1.1 644)
+++ 0.6/arch/arm/mm/init.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/v/c/33_init.c 1.2 644)
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
Index: 0.2/arch/sparc64/mm/init.c
--- 0.2/arch/sparc64/mm/init.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/y/c/18_init.c 1.1 644)
+++ 0.6/arch/sparc64/mm/init.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/y/c/18_init.c 1.2 644)
@@ -15,7 +15,6 @@
 #include <linux/malloc.h>
 #include <linux/blk.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 
 #include <asm/head.h>
 #include <asm/system.h>
Index: 0.2/arch/mips/mm/init.c
--- 0.2/arch/mips/mm/init.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/M/c/40_init.c 1.1 644)
+++ 0.6/arch/mips/mm/init.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/M/c/40_init.c 1.2 644)
@@ -22,7 +22,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
Index: 0.2/arch/sparc/mm/init.c
--- 0.2/arch/sparc/mm/init.c Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/N/c/32_init.c 1.1 644)
+++ 0.6/arch/sparc/mm/init.c Sun, 07 Jan 2001 20:17:13 +0100 zcalusic (linux24/N/c/32_init.c 1.2 644)
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
Index: 0.6/include/linux/swapctl.h
--- 0.2/include/linux/swapctl.h Sat, 06 Jan 2001 01:48:21 +0100 zcalusic (linux24/c/b/36_swapctl.h 1.1 644)
+++ 0.6/include/linux/swapctl.h Sun, 07 Jan 2001 21:30:32 +0100 zcalusic ()
@@ -1,35 +0,0 @@
-#ifndef _LINUX_SWAPCTL_H
-#define _LINUX_SWAPCTL_H
-
-#include <asm/page.h>
-#include <linux/fs.h>
-
-typedef struct buffer_mem_v1
-{
-	unsigned int	min_percent;
-	unsigned int	borrow_percent;
-	unsigned int	max_percent;
-} buffer_mem_v1;
-typedef buffer_mem_v1 buffer_mem_t;
-extern buffer_mem_t buffer_mem;
-extern buffer_mem_t page_cache;
-
-typedef struct freepages_v1
-{
-	unsigned int	min;
-	unsigned int	low;
-	unsigned int	high;
-} freepages_v1;
-typedef freepages_v1 freepages_t;
-extern freepages_t freepages;
-
-typedef struct pager_daemon_v1
-{
-	unsigned int	tries_base;
-	unsigned int	tries_min;
-	unsigned int	swap_cluster;
-} pager_daemon_v1;
-typedef pager_daemon_v1 pager_daemon_t;
-extern pager_daemon_t pager_daemon;
-
-#endif /* _LINUX_SWAPCTL_H */

-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
