Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSGQFUX>; Wed, 17 Jul 2002 01:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSGQFUV>; Wed, 17 Jul 2002 01:20:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318213AbSGQFSw>;
	Wed, 17 Jul 2002 01:18:52 -0400
Message-ID: <3D3500C3.4E7264EA@zip.com.au>
Date: Tue, 16 Jul 2002 22:29:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/13] VM instrumentation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A patch from Rik which adds some operational statitics to the VM.

They appear in /proc/meminfo and /proc/stat.  We have:


In /proc/meminfo:

PageTables:	Amount of memory used for process pagetables
PteChainTot:	Amount of memory allocated for pte_chain objects
PteChainUsed:	Amount of memory currently in use for pte chains.

In /proc/stat:

pageallocs:	Number of pages allocated in the page allocator
pagefrees:	Number of pages returned to the page allocator

		(These can be used to measure the allocation rate)
		
pageactiv:	Number of pages activated (moved to the active list)
pagedeact:	Number of pages deactivated (moved to the inactive list)
pagefault:	Total pagefaults
majorfault:	Major pagefaults
pagescan:	Number of pages which shrink_cache looked at
pagesteal:	Number of pages which shrink_cache freed
pageoutrun:	Number of calls to try_to_free_pages()
allocstall:	Number of calls to balance_classzone()


Rik will be writing a userspace app which interprets these things.

The /proc/meminfo stats are efficient, but the /proc/stat accumulators
will cause undesirable cacheline bouncing.  We need to break the disk
statistics out of struct kernel_stat and make everything else in there
per-cpu.  If that doesn't happen in time for 2.6 then we disable
KERNEL_STAT_INC().




 fs/proc/proc_misc.c              |   32 +++++++++++++++++++++++++++++---
 include/asm-arm/proc-armv/rmap.h |    2 ++
 include/asm-generic/rmap.h       |    2 ++
 include/linux/kernel_stat.h      |   12 ++++++++++++
 include/linux/page-flags.h       |    3 +++
 init/main.c                      |    3 +++
 mm/filemap.c                     |    2 ++
 mm/memory.c                      |    3 +++
 mm/page_alloc.c                  |    9 +++++++++
 mm/rmap.c                        |    3 +++
 mm/swap.c                        |    1 +
 mm/vmscan.c                      |    9 +++++++++
 12 files changed, 78 insertions(+), 3 deletions(-)

--- 2.5.26/fs/proc/proc_misc.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/fs/proc/proc_misc.c	Tue Jul 16 21:46:30 2002
@@ -159,7 +159,10 @@ static int meminfo_read_proc(char *page,
 		"SwapTotal:    %8lu kB\n"
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
-		"Writeback:    %8lu kB\n",
+		"Writeback:    %8lu kB\n"
+		"PageTables:   %8lu kB\n"
+		"PteChainTot:  %8lu kB\n"
+		"PteChainUsed: %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -174,7 +177,10 @@ static int meminfo_read_proc(char *page,
 		K(i.totalswap),
 		K(i.freeswap),
 		K(ps.nr_dirty),
-		K(ps.nr_writeback)
+		K(ps.nr_writeback),
+		K(ps.nr_page_table_pages),
+		K(ps.nr_pte_chain_pages),
+		ps.used_pte_chains_bytes >> 10
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
@@ -347,9 +353,29 @@ static int kstat_read_proc(char *page, c
 	}
 
 	len += sprintf(page + len,
-		"\nctxt %lu\n"
+		"\npageallocs %u\n"
+		"pagefrees %u\n"
+		"pageactiv %u\n"
+		"pagedeact %u\n"
+		"pagefault %u\n"
+		"majorfault %u\n"
+		"pagescan %u\n"
+		"pagesteal %u\n"
+		"pageoutrun %u\n"
+		"allocstall %u\n"
+		"ctxt %lu\n"
 		"btime %lu\n"
 		"processes %lu\n",
+		kstat.pgalloc,
+		kstat.pgfree,
+		kstat.pgactivate,
+		kstat.pgdeactivate,
+		kstat.pgfault,
+		kstat.pgmajfault,
+		kstat.pgscan,
+		kstat.pgsteal,
+		kstat.pageoutrun,
+		kstat.allocstall,
 		nr_context_switches(),
 		xtime.tv_sec - jif / HZ,
 		total_forks);
--- 2.5.26/include/asm-arm/proc-armv/rmap.h~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/include/asm-arm/proc-armv/rmap.h	Tue Jul 16 21:46:30 2002
@@ -17,6 +17,7 @@ static inline void pgtable_add_rmap(pte_
 
 	page->mm = mm;
 	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
+	inc_page_state(nr_page_table_pages);
 }
 
 static inline void pgtable_remove_rmap(pte_t * ptep)
@@ -25,6 +26,7 @@ static inline void pgtable_remove_rmap(p
 
 	page->mm = NULL;
 	page->index = 0;
+	dec_page_state(nr_page_table_pages);
 }
 
 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
--- 2.5.26/include/asm-generic/rmap.h~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/include/asm-generic/rmap.h	Tue Jul 16 21:46:30 2002
@@ -27,12 +27,14 @@ static inline void pgtable_add_rmap(stru
 #endif
 	page->mapping = (void *)mm;
 	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
+	inc_page_state(nr_page_table_pages);
 }
 
 static inline void pgtable_remove_rmap(struct page * page)
 {
 	page->mapping = NULL;
 	page->index = 0;
+	dec_page_state(nr_page_table_pages);
 }
 
 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
--- 2.5.26/include/linux/kernel_stat.h~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/include/linux/kernel_stat.h	Tue Jul 16 21:46:30 2002
@@ -26,6 +26,11 @@ struct kernel_stat {
 	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
+	unsigned int pgalloc, pgfree;
+	unsigned int pgactivate, pgdeactivate;
+	unsigned int pgfault, pgmajfault;
+	unsigned int pgscan, pgsteal;
+	unsigned int pageoutrun, allocstall;
 #if !defined(CONFIG_ARCH_S390)
 	unsigned int irqs[NR_CPUS][NR_IRQS];
 #endif
@@ -35,6 +40,13 @@ extern struct kernel_stat kstat;
 
 extern unsigned long nr_context_switches(void);
 
+/*
+ * Maybe we need to smp-ify kernel_stat some day. It would be nice to do
+ * that without having to modify all the code that increments the stats.
+ */
+#define KERNEL_STAT_INC(x) kstat.x++
+#define KERNEL_STAT_ADD(x, y) kstat.x += y
+
 #if !defined(CONFIG_ARCH_S390)
 /*
  * Number of interrupts per specific IRQ source, since bootup
--- 2.5.26/init/main.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/init/main.c	Tue Jul 16 21:46:30 2002
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/tty.h>
 #include <linux/percpu.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -502,6 +503,8 @@ static int init(void * unused)
 	free_initmem();
 	unlock_kernel();
 
+	kstat.pgfree = 0;
+
 	if (open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
 
--- 2.5.26/mm/filemap.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/mm/filemap.c	Tue Jul 16 21:59:37 2002
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -1533,6 +1534,7 @@ no_cached_page:
 	return NULL;
 
 page_not_uptodate:
+	KERNEL_STAT_INC(pgmajfault);
 	lock_page(page);
 
 	/* Did it get unhashed while we waited for it? */
--- 2.5.26/mm/memory.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/mm/memory.c	Tue Jul 16 21:46:30 2002
@@ -36,6 +36,7 @@
  *		(Gerhard.Wichert@pdb.siemens.de)
  */
 
+#include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
@@ -1177,6 +1178,7 @@ static int do_swap_page(struct mm_struct
 
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
+		KERNEL_STAT_INC(pgmajfault);
 	}
 
 	lock_page(page);
@@ -1419,6 +1421,7 @@ int handle_mm_fault(struct mm_struct *mm
 	current->state = TASK_RUNNING;
 	pgd = pgd_offset(mm, address);
 
+	KERNEL_STAT_INC(pgfault);
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
--- 2.5.26/mm/page_alloc.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/mm/page_alloc.c	Tue Jul 16 21:59:38 2002
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/interrupt.h>
@@ -86,6 +87,8 @@ static void __free_pages_ok (struct page
 	struct page *base;
 	zone_t *zone;
 
+	KERNEL_STAT_ADD(pgfree, 1<<order);
+
 	BUG_ON(PagePrivate(page));
 	BUG_ON(page->mapping != NULL);
 	BUG_ON(PageLocked(page));
@@ -324,6 +327,8 @@ struct page * __alloc_pages(unsigned int
 	struct page * page;
 	int freed;
 
+	KERNEL_STAT_ADD(pgalloc, 1<<order);
+
 	zone = zonelist->zones;
 	classzone = *zone;
 	if (classzone == NULL)
@@ -393,6 +398,7 @@ nopage:
 	if (!(gfp_mask & __GFP_WAIT))
 		goto nopage;
 
+	KERNEL_STAT_INC(allocstall);
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;
@@ -563,6 +569,9 @@ void get_page_state(struct page_state *r
 		ret->nr_pagecache += ps->nr_pagecache;
 		ret->nr_active += ps->nr_active;
 		ret->nr_inactive += ps->nr_inactive;
+		ret->nr_page_table_pages += ps->nr_page_table_pages;
+		ret->nr_pte_chain_pages += ps->nr_pte_chain_pages;
+		ret->used_pte_chains_bytes += ps->used_pte_chains_bytes;
 	}
 }
 
--- 2.5.26/mm/rmap.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/mm/rmap.c	Tue Jul 16 21:46:30 2002
@@ -391,6 +391,7 @@ static inline struct pte_chain * pte_cha
 static inline void pte_chain_free(struct pte_chain * pte_chain,
 		struct pte_chain * prev_pte_chain, struct page * page)
 {
+	mod_page_state(used_pte_chains_bytes, -sizeof(struct pte_chain));
 	if (prev_pte_chain)
 		prev_pte_chain->next = pte_chain->next;
 	else if (page)
@@ -423,6 +424,7 @@ static inline struct pte_chain * pte_cha
 
 	spin_unlock(&pte_chain_freelist_lock);
 
+	mod_page_state(used_pte_chains_bytes, sizeof(struct pte_chain));
 	return pte_chain;
 }
 
@@ -443,6 +445,7 @@ static void alloc_new_pte_chains()
 	int i = PAGE_SIZE / sizeof(struct pte_chain);
 
 	if (pte_chain) {
+		inc_page_state(nr_pte_chain_pages);
 		for (; i-- > 0; pte_chain++)
 			pte_chain_push(pte_chain);
 	} else {
--- 2.5.26/mm/swap.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/mm/swap.c	Tue Jul 16 21:46:30 2002
@@ -41,6 +41,7 @@ static inline void activate_page_nolock(
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(page);
 		add_page_to_active_list(page);
+		KERNEL_STAT_INC(pgactivate);
 	}
 }
 
--- 2.5.26/mm/vmscan.c~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/mm/vmscan.c	Tue Jul 16 21:46:30 2002
@@ -92,6 +92,7 @@ shrink_cache(int nr_pages, zone_t *class
 
 		list_del(entry);
 		list_add(entry, &inactive_list);
+		KERNEL_STAT_INC(pgscan);
 
 		/*
 		 * Zero page counts can happen because we unlink the pages
@@ -142,6 +143,7 @@ shrink_cache(int nr_pages, zone_t *class
 			add_page_to_active_list(page);
 			pte_chain_unlock(page);
 			unlock_page(page);
+			KERNEL_STAT_INC(pgactivate);
 			continue;
 		}
 
@@ -302,6 +304,7 @@ page_freeable:
 
 		/* effectively free the page here */
 		page_cache_release(page);
+		KERNEL_STAT_INC(pgsteal);
 		if (--nr_pages)
 			continue;
 		goto out;
@@ -315,6 +318,7 @@ page_active:
 		add_page_to_active_list(page);
 		pte_chain_unlock(page);
 		unlock_page(page);
+		KERNEL_STAT_INC(pgactivate);
 	}
 out:	spin_unlock(&pagemap_lru_lock);
 	return nr_pages;
@@ -339,6 +343,8 @@ static void refill_inactive(int nr_pages
 		page = list_entry(entry, struct page, lru);
 		entry = entry->prev;
 
+		KERNEL_STAT_INC(pgscan);
+
 		pte_chain_lock(page);
 		if (page->pte.chain && page_referenced(page)) {
 			list_del(&page->lru);
@@ -349,6 +355,7 @@ static void refill_inactive(int nr_pages
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
 		pte_chain_unlock(page);
+		KERNEL_STAT_INC(pgdeactivate);
 	}
 	spin_unlock(&pagemap_lru_lock);
 }
@@ -398,6 +405,8 @@ int try_to_free_pages(zone_t *classzone,
 	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;
 
+	KERNEL_STAT_INC(pageoutrun);
+
 	do {
 		nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);
 		if (nr_pages <= 0)
--- 2.5.26/include/linux/page-flags.h~vm-stats	Tue Jul 16 21:46:30 2002
+++ 2.5.26-akpm/include/linux/page-flags.h	Tue Jul 16 21:46:30 2002
@@ -78,6 +78,9 @@ extern struct page_state {
 	unsigned long nr_pagecache;
 	unsigned long nr_active;	/* on active_list LRU */
 	unsigned long nr_inactive;	/* on inactive_list LRU */
+	unsigned long nr_page_table_pages;
+	unsigned long nr_pte_chain_pages;
+	unsigned long used_pte_chains_bytes;
 } ____cacheline_aligned_in_smp page_states[NR_CPUS];
 
 extern void get_page_state(struct page_state *ret);

.
