Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317669AbSGOV6X>; Mon, 15 Jul 2002 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317671AbSGOV6W>; Mon, 15 Jul 2002 17:58:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45317 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317669AbSGOV6P>; Mon, 15 Jul 2002 17:58:15 -0400
Date: Mon, 15 Jul 2002 19:00:54 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] extended VM stats
Message-ID: <Pine.LNX.4.44L.0207151835120.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below (against 2.5.25 + minimal rmap) implements a
number of extra VM statistics, which should help us a lot in
finetuning the VM for 2.6.

The idea is to write a small vmstat-like program to display
these statistics so every sysadmin can send the developers
the information they need to get the VM finetuned for real
workloads.

Comments on the idea behind this patch or the implementation
of the patch are very welcome.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


===== fs/proc/proc_misc.c 1.30 vs edited =====
--- 1.30/fs/proc/proc_misc.c	Tue Jul  2 19:46:32 2002
+++ edited/fs/proc/proc_misc.c	Sun Jul 14 21:47:11 2002
@@ -159,7 +159,10 @@
 		"SwapTotal:    %8lu kB\n"
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
-		"Writeback:    %8lu kB\n",
+		"Writeback:    %8lu kB\n"
+		"PageTables:   %8u kB\n"
+		"PteChainTot:  %8u kB\n"
+		"PteChainUsed: %8u kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -174,7 +177,10 @@
 		K(i.totalswap),
 		K(i.freeswap),
 		K(ps.nr_dirty),
-		K(ps.nr_writeback)
+		K(ps.nr_writeback),
+		K(atomic_read(&nr_page_table_pages)),
+		K(atomic_read(&nr_pte_chain_pages)),
+		atomic_read(&used_pte_chains_bytes) >> 10
 		);

 	return proc_calc_metrics(page, start, off, count, eof, len);
@@ -347,9 +353,29 @@
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
===== include/asm-arm/proc-armv/rmap.h 1.2 vs edited =====
--- 1.2/include/asm-arm/proc-armv/rmap.h	Fri Jul  5 11:17:20 2002
+++ edited/include/asm-arm/proc-armv/rmap.h	Sun Jul 14 10:21:42 2002
@@ -17,6 +17,7 @@

 	page->mm = mm;
 	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
+	atomic_inc(&nr_page_table_pages);
 }

 static inline void pgtable_remove_rmap(pte_t * ptep)
@@ -25,6 +26,7 @@

 	page->mm = NULL;
 	page->index = 0;
+	atomic_dec(&nr_page_table_pages);
 }

 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
===== include/asm-generic/rmap.h 1.1 vs edited =====
--- 1.1/include/asm-generic/rmap.h	Fri Jun 21 19:42:48 2002
+++ edited/include/asm-generic/rmap.h	Sun Jul 14 10:22:04 2002
@@ -27,12 +27,14 @@
 #endif
 	page->mapping = (void *)mm;
 	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
+	atomic_inc(&nr_page_table_pages);
 }

 static inline void pgtable_remove_rmap(struct page * page)
 {
 	page->mapping = NULL;
 	page->index = 0;
+	atomic_dec(&nr_page_table_pages);
 }

 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
===== include/linux/kernel_stat.h 1.5 vs edited =====
--- 1.5/include/linux/kernel_stat.h	Tue Jun 18 02:25:22 2002
+++ edited/include/linux/kernel_stat.h	Mon Jul 15 17:19:16 2002
@@ -26,6 +26,11 @@
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
@@ -34,6 +39,13 @@
 extern struct kernel_stat kstat;

 extern unsigned long nr_context_switches(void);
+
+/*
+ * Maybe we need to smp-ify kernel_stat some day. It would be nice to do
+ * that without having to modify all the code that increments the stats.
+ */
+#define KERNEL_STAT_INC(x) kstat.x++
+#define KERNEL_STAT_ADD(x, y) kstat.x += y

 #if !defined(CONFIG_ARCH_S390)
 /*
===== include/linux/mm.h 1.57 vs edited =====
--- 1.57/include/linux/mm.h	Fri Jul  5 21:31:51 2002
+++ edited/include/linux/mm.h	Sun Jul 14 10:28:09 2002
@@ -22,6 +22,9 @@
 /* The inactive_clean lists are per zone. */
 extern struct list_head active_list;
 extern struct list_head inactive_list;
+extern atomic_t nr_page_table_pages;
+extern atomic_t nr_pte_chain_pages;
+extern atomic_t used_pte_chains_bytes;

 #include <asm/page.h>
 #include <asm/pgtable.h>
===== init/main.c 1.49 vs edited =====
--- 1.49/init/main.c	Mon Jun 10 07:30:35 2002
+++ edited/init/main.c	Fri Jul 12 15:04:36 2002
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/tty.h>
 #include <linux/percpu.h>
+#include <linux/kernel_stat.h>

 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -501,6 +502,8 @@
 	 */
 	free_initmem();
 	unlock_kernel();
+
+	kstat.pgfree = 0;

 	if (open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
===== mm/filemap.c 1.108 vs edited =====
--- 1.108/mm/filemap.c	Sat Jul  6 01:19:43 2002
+++ edited/mm/filemap.c	Fri Jul 12 10:57:04 2002
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -1546,6 +1547,7 @@
 	return NULL;

 page_not_uptodate:
+	KERNEL_STAT_INC(pgmajfault);
 	lock_page(page);

 	/* Did it get unhashed while we waited for it? */
===== mm/memory.c 1.74 vs edited =====
--- 1.74/mm/memory.c	Fri Jul  5 21:31:51 2002
+++ edited/mm/memory.c	Sun Jul 14 10:19:59 2002
@@ -36,6 +36,7 @@
  *		(Gerhard.Wichert@pdb.siemens.de)
  */

+#include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
@@ -58,6 +59,8 @@
 void * high_memory;
 struct page *highmem_start_page;

+atomic_t nr_page_table_pages = ATOMIC_INIT(0);
+
 /*
  * We special-case the C-O-W ZERO_PAGE, because it's such
  * a common occurrence (no need to read the page to know
@@ -1177,6 +1180,7 @@

 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
+		KERNEL_STAT_INC(pgmajfault);
 	}

 	lock_page(page);
@@ -1419,6 +1423,7 @@
 	current->state = TASK_RUNNING;
 	pgd = pgd_offset(mm, address);

+	KERNEL_STAT_INC(pgfault);
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
===== mm/page_alloc.c 1.76 vs edited =====
--- 1.76/mm/page_alloc.c	Fri Jul  5 21:31:51 2002
+++ edited/mm/page_alloc.c	Fri Jul 12 10:57:37 2002
@@ -13,6 +13,7 @@
  */

 #include <linux/config.h>
+#include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/interrupt.h>
@@ -86,6 +87,8 @@
 	struct page *base;
 	zone_t *zone;

+	KERNEL_STAT_ADD(pgfree, 1<<order);
+
 	BUG_ON(PagePrivate(page));
 	BUG_ON(page->mapping != NULL);
 	BUG_ON(PageLocked(page));
@@ -324,6 +327,8 @@
 	struct page * page;
 	int freed;

+	KERNEL_STAT_ADD(pgalloc, 1<<order);
+
 	zone = zonelist->zones;
 	classzone = *zone;
 	if (classzone == NULL)
@@ -393,6 +398,7 @@
 	if (!(gfp_mask & __GFP_WAIT))
 		goto nopage;

+	KERNEL_STAT_INC(allocstall);
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;
===== mm/rmap.c 1.3 vs edited =====
--- 1.3/mm/rmap.c	Sat Jul  6 00:23:20 2002
+++ edited/mm/rmap.c	Sun Jul 14 10:30:59 2002
@@ -32,6 +32,9 @@

 /* #define DEBUG_RMAP */

+atomic_t nr_pte_chain_pages = ATOMIC_INIT(0);
+atomic_t used_pte_chains_bytes = ATOMIC_INIT(0);
+
 /*
  * Shared pages have a chain of pte_chain structures, used to locate
  * all the mappings to this page. We only need a pointer to the pte
@@ -333,6 +336,7 @@
 static inline void pte_chain_free(struct pte_chain * pte_chain,
 		struct pte_chain * prev_pte_chain, struct page * page)
 {
+	atomic_sub(sizeof(struct pte_chain), &used_pte_chains_bytes);
 	if (prev_pte_chain)
 		prev_pte_chain->next = pte_chain->next;
 	else if (page)
@@ -365,6 +369,7 @@

 	spin_unlock(&pte_chain_freelist_lock);

+	atomic_add(sizeof(struct pte_chain), &used_pte_chains_bytes);
 	return pte_chain;
 }

@@ -385,6 +390,7 @@
 	int i = PAGE_SIZE / sizeof(struct pte_chain);

 	if (pte_chain) {
+		atomic_inc(&nr_pte_chain_pages);
 		for (; i-- > 0; pte_chain++)
 			pte_chain_push(pte_chain);
 	} else {
===== mm/swap.c 1.18 vs edited =====
--- 1.18/mm/swap.c	Fri Jul  5 15:36:07 2002
+++ edited/mm/swap.c	Fri Jul 12 00:09:23 2002
@@ -41,6 +41,7 @@
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(page);
 		add_page_to_active_list(page);
+		KERNEL_STAT_INC(pgactivate);
 	}
 }

===== mm/vmscan.c 1.81 vs edited =====
--- 1.81/mm/vmscan.c	Fri Jul  5 21:31:52 2002
+++ edited/mm/vmscan.c	Fri Jul 12 08:52:54 2002
@@ -92,6 +92,7 @@

 		list_del(entry);
 		list_add(entry, &inactive_list);
+		KERNEL_STAT_INC(pgscan);

 		/*
 		 * Zero page counts can happen because we unlink the pages
@@ -142,6 +143,7 @@
 			add_page_to_active_list(page);
 			pte_chain_unlock(page);
 			unlock_page(page);
+			KERNEL_STAT_INC(pgactivate);
 			continue;
 		}

@@ -310,6 +312,7 @@

 		/* effectively free the page here */
 		page_cache_release(page);
+		KERNEL_STAT_INC(pgsteal);
 		if (--nr_pages)
 			continue;
 		goto out;
@@ -323,6 +326,7 @@
 		add_page_to_active_list(page);
 		pte_chain_unlock(page);
 		unlock_page(page);
+		KERNEL_STAT_INC(pgactivate);
 	}
 out:	spin_unlock(&pagemap_lru_lock);
 	return nr_pages;
@@ -347,6 +351,8 @@
 		page = list_entry(entry, struct page, lru);
 		entry = entry->prev;

+		KERNEL_STAT_INC(pgscan);
+
 		pte_chain_lock(page);
 		if (page->pte_chain && page_referenced(page)) {
 			list_del(&page->lru);
@@ -357,6 +363,7 @@
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
 		pte_chain_unlock(page);
+		KERNEL_STAT_INC(pgdeactivate);
 	}
 	spin_unlock(&pagemap_lru_lock);
 }
@@ -405,6 +412,8 @@
 {
 	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;
+
+	KERNEL_STAT_INC(pageoutrun);

 	do {
 		nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);

