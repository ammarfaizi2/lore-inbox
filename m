Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbRGMXkO>; Fri, 13 Jul 2001 19:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267549AbRGMXkG>; Fri, 13 Jul 2001 19:40:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44561 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267545AbRGMXjx>; Fri, 13 Jul 2001 19:39:53 -0400
Date: Fri, 13 Jul 2001 19:08:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] VM statistics code
Message-ID: <Pine.LNX.4.21.0107131856470.3716-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The following patch adds detailed VM statistics (reported via /proc/stats)
which is tunable on/off by the CONFIG_VM_STATS option.

There is a modified vmstat.c which is able to read the information
(URL/documentation about it is in the patch).

With this data we are able to know more about what is really going on in
the VM.


Please apply.


diff -Nur --exclude-from=exclude linux.orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux.orig/Documentation/Configure.help	Wed Jul 11 00:44:55 2001
+++ linux/Documentation/Configure.help	Fri Jul 13 00:59:41 2001
@@ -15656,6 +15656,14 @@
   keys are documented in Documentation/sysrq.txt. Don't say Y unless
   you really know what this hack does.
 
+VM statistics support
+CONFIG_VM_STATS
+  If you say Y here, the kernel will collect detailed information about 
+  the VM subsystem. This information will be available in /proc/stats. 
+  More documentation about this option can be found in 
+  Documentation/vm/statistics.
+  This is only useful for kernel hacking. If unsure, say N. 
+
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -Nur --exclude-from=exclude linux.orig/Documentation/vm/statistics linux/Documentation/vm/statistics
--- linux.orig/Documentation/vm/statistics	Wed Dec 31 21:00:00 1969
+++ linux/Documentation/vm/statistics	Fri Jul 13 01:04:59 2001
@@ -0,0 +1,46 @@
+
+Description of the additional fields in /proc/stats which are added by the 
+CONFIG_VM_STATS option:
+
+Global statistics:
+
+vm_pglaunder: nr of page_launder() calls 
+vm_pglaunder_write: nr of times page_launder() started writting out data to free 
+memory.
+vm_refill_inactive_scan: nr of refill_inactive_scan() calls
+vm_alloc_resched: nr of reschedule's in __alloc_pages() due to a memory shortage.
+vm_kswapd_wakeup: nr of kswapd wakeup's 
+vm_kreclaimd_wakeup: nr of kreclaimd wakeup's 
+vm_kflushd_wakeup: nr of kflushd wakeup's 
+
+Per-zone statistics:
+free shortage: per-zone free shortage
+inactive shortage: per-zone inactive shortage
+vm_launder_pgscan: number of pages scanned by page_launder
+vm_pgclean: number of pages cleaned (moved to the inactive clean list) by page_launder
+vm_pgskiplocked: number of locked pages skipped by page_launder
+vm_pgskipdirty: number of dirty pages skipped by page_launder
+vm_pglaundered: laundered pages by page_launder
+vm_pgreact: pages reactivated in page_launder
+vm_pgrescue: pages rescue in reclaim_page
+vm_pgagescan: pages scanned by refill_inactive_scan()
+vm_pgagedown: pages aged down by refill_inative_scan()
+vm_pgageup: pages aged up by refill_inactive_scan()/try_to_swap_out()
+vm_pgdeact: deactivated pages by deactivate_page
+vm_pgdeactfail_age: nr of deactivation failures on refill_inactive_scan() 
+due to >0 age
+vm_pgdeactfail_ref: nr of deactivation failures on refill_inactive_scan()
+due to zero aged pages with more users than the pagecache
+vm_reclaimfail: failures of reclaim_page() (no freeable clean pages in the inactive
+clean list for this zone)
+vm_ptescan: nr of present ptes scanned by swap_out()
+vm_pteunmap: nr of present ptes unmapped by swap_out()
+
+There is a modified version of vmstat from procps-2.0.7 at 
+http://bazar.conectiva.com.br/~marcelo/patches/procps/vmstat.c which is able to report
+these fields.
+
+Send questions, comments, etc to the linux-mm mailing list. (linux-mm@kvack.org)
+
+Author: Marcelo Tosatti <marcelo@conectiva.com.br>
+
diff -Nur --exclude-from=exclude linux.orig/arch/i386/config.in linux/arch/i386/config.in
--- linux.orig/arch/i386/config.in	Wed Jul 11 00:44:55 2001
+++ linux/arch/i386/config.in	Fri Jul 13 00:59:41 2001
@@ -388,4 +388,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'VM statistics' CONFIG_VM_STATS
 endmenu
diff -Nur --exclude-from=exclude linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Wed Jul 11 00:44:53 2001
+++ linux/fs/buffer.c	Fri Jul 13 00:59:08 2001
@@ -45,6 +45,7 @@
 #include <linux/quotaops.h>
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
+#include <linux/mm.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -2417,6 +2418,7 @@
 			goto cleaned_buffers_try_again;
 		}
 		wakeup_bdflush(0);
+		VM_STAT_INC_KFLUSHD_WAKEUP
 	}
 	return 0;
 }
diff -Nur --exclude-from=exclude linux.orig/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- linux.orig/fs/proc/proc_misc.c	Wed Jul 11 00:44:53 2001
+++ linux/fs/proc/proc_misc.c	Fri Jul 13 00:59:08 2001
@@ -27,6 +27,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/mmzone.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -335,6 +336,25 @@
 		kstat.context_swtch,
 		xtime.tv_sec - jif / HZ,
 		total_forks);
+#ifdef CONFIG_VM_STATS
+	len += sprintf(page + len,
+		       	"vm_pglaunder %u\n"
+			"vm_pglaunder_write %u\n"
+			"vm_refill_inactive_scan %u\n"
+			"vm_alloc_resched %u\n"
+			"vm_kswapd_wakeup %u\n"
+			"vm_kreclaimd_wakeup %u\n"
+			"vm_kflushd_wakeup %u\n", 
+			kstat.vm_pglaunder,
+			kstat.vm_pglaunder_write,
+			kstat.vm_refill_inactive_scan,
+			kstat.vm_alloc_resched,
+			kstat.vm_kswapd_wakeup,
+			kstat.vm_kreclaimd_wakeup,
+			kstat.vm_kflushd_wakeup);
+				
+	len = get_perzone_vm_stats(page, len);
+#endif
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
diff -Nur --exclude-from=exclude linux.orig/include/linux/kernel_stat.h linux/include/linux/kernel_stat.h
--- linux.orig/include/linux/kernel_stat.h	Wed Jul 11 00:44:53 2001
+++ linux/include/linux/kernel_stat.h	Fri Jul 13 00:59:08 2001
@@ -33,6 +33,15 @@
 	unsigned int ierrors, oerrors;
 	unsigned int collisions;
 	unsigned int context_swtch;
+#ifdef CONFIG_VM_STATS
+	unsigned int vm_pglaunder;
+	unsigned int vm_pglaunder_write;
+	unsigned int vm_refill_inactive_scan;
+	unsigned int vm_alloc_resched;
+	unsigned int vm_kswapd_wakeup;
+	unsigned int vm_kreclaimd_wakeup;
+	unsigned int vm_kflushd_wakeup;
+#endif
 };
 
 extern struct kernel_stat kstat;
@@ -50,6 +59,30 @@
 
 	return sum;
 }
+#endif
+#ifdef CONFIG_VM_STATS
+/*
+ * Information about these fields can be found at Documentation/vm/statistics
+ * If you change _anything_ here please update the documentation.
+ */
+struct vm_zone_stat {
+	unsigned int vm_launder_pgscan;
+	unsigned int vm_pgclean;
+	unsigned int vm_pgskiplocked;
+	unsigned int vm_pgskipdirty;
+	unsigned int vm_pglaundered;
+	unsigned int vm_pgreact;
+	unsigned int vm_pgrescue; 
+	unsigned int vm_pgagescan;
+	unsigned int vm_pgagedown;
+	unsigned int vm_pgageup;
+	unsigned int vm_pgdeact; 
+	unsigned int vm_pgdeactfail_age;
+	unsigned int vm_pgdeactfail_ref;
+	unsigned int vm_reclaimfail;
+	unsigned int vm_ptescan;
+	unsigned int vm_pteunmap;
+};
 #endif
 
 #endif /* _LINUX_KERNEL_STAT_H */
diff -Nur --exclude-from=exclude linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Wed Jul 11 00:44:53 2001
+++ linux/include/linux/mm.h	Fri Jul 13 00:59:08 2001
@@ -591,6 +591,66 @@
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
+#ifdef CONFIG_VM_STATS
+
+/* Global statistics */
+#define VM_STAT_INC_PGLAUNDER kstat.vm_pglaunder++;
+#define VM_STAT_INC_PGLAUNDER_WRITE kstat.vm_pglaunder_write++;
+#define VM_STAT_INC_REFILL_INACTIVE_SCAN kstat.vm_refill_inactive_scan++;
+#define VM_STAT_INC_ALLOC_RESCHED kstat.vm_alloc_resched++;
+#define VM_STAT_INC_KSWAPD_WAKEUP kstat.vm_kswapd_wakeup++;
+#define VM_STAT_INC_KRECLAIMD_WAKEUP kstat.vm_kreclaimd_wakeup++;
+#define VM_STAT_INC_KFLUSHD_WAKEUP kstat.vm_kflushd_wakeup++;
+
+/* Per-zone statistics */ 
+
+#define VM_STAT_INC_PGSCAN(zone) zone->stat.vm_launder_pgscan++;
+#define VM_STAT_INC_PGCLEAN(zone) zone->stat.vm_pgclean++;
+#define VM_STAT_INC_PGSKIPLOCKED(zone) zone->stat.vm_pgskiplocked++;
+#define VM_STAT_INC_PGSKIPDIRTY(zone) zone->stat.vm_pgskipdirty++;
+#define VM_STAT_INC_PGLAUNDERED(zone) zone->stat.vm_pglaundered++;
+#define VM_STAT_INC_PGREACT(zone) zone->stat.vm_pgreact++;
+#define VM_STAT_INC_PGRESCUE(zone) zone->stat.vm_pgrescue++;
+#define VM_STAT_INC_PGAGESCAN(zone) zone->stat.vm_pgagescan++;
+#define VM_STAT_INC_PGAGEDOWN(zone) zone->stat.vm_pgagedown++;
+#define VM_STAT_INC_PGAGEUP(zone) zone->stat.vm_pgageup++;
+#define VM_STAT_INC_PGDEACT(zone) zone->stat.vm_pgdeact++;
+#define VM_STAT_INC_PGDEACTFAIL_AGE(zone) zone->stat.vm_pgdeactfail_age++;
+#define VM_STAT_INC_PGDEACTFAIL_REF(zone) zone->stat.vm_pgdeactfail_ref++;
+#define VM_STAT_INC_RECLAIMFAIL(zone) zone->stat.vm_reclaimfail++;
+#define VM_STAT_INC_PTESCAN(zone) zone->stat.vm_ptescan++;
+#define VM_STAT_INC_PTEUNMAP(zone) zone->stat.vm_pteunmap++;
+
+#else
+#define VM_STAT_INC_PGLAUNDER do { } while (0);
+#define VM_STAT_INC_PGLAUNDER_WRITE do { } while (0);
+#define VM_STAT_INC_REFILL_INACTIVE_SCAN do { } while (0);
+#define VM_STAT_INC_ALLOC_RESCHED do { } while (0);
+#define VM_STAT_INC_KSWAPD_WAKEUP do { } while (0);
+#define VM_STAT_INC_KRECLAIMD_WAKEUP do { } while (0);
+#define VM_STAT_INC_KFLUSHD_WAKEUP do { } while (0);
+
+#define VM_STAT_INC_PGSCAN(zone) do { } while (0);
+#define VM_STAT_INC_PGCLEAN(zone)  do { } while (0);
+#define VM_STAT_INC_PGSKIPLOCKED(zone) do { } while (0);
+#define VM_STAT_INC_PGSKIPDIRTY(zone) do { } while (0);
+#define VM_STAT_INC_PGLAUNDERED(zone) do { } while (0);
+#define VM_STAT_INC_PGREACT(zone) do { } while (0);
+#define VM_STAT_INC_PGRESCUE(zone) do { } while (0);
+#define VM_STAT_INC_PGDEACT(zone) do { } while (0);
+#define VM_STAT_INC_PGAGESCAN(zone) do { } while (0);
+#define VM_STAT_INC_PGAGEDOWN(zone) do { } while (0);
+#define VM_STAT_INC_PGAGEUP(zone) do { } while (0);
+#define VM_STAT_INC_PGDEACT(zone) do { } while (0);
+#define VM_STAT_INC_PGDEACTFAIL_AGE(zone) do { } while (0);
+#define VM_STAT_INC_PGDEACTFAIL_REF(zone) do { } while (0);
+#define VM_STAT_INC_RECLAIMFAIL(zone) do { } while (0);
+#define VM_STAT_INC_PTESCAN(zone) do { } while (0);
+#define VM_STAT_INC_PTEUNMAP(zone) do { } while (0);
+
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nur --exclude-from=exclude linux.orig/include/linux/mmzone.h linux/include/linux/mmzone.h
--- linux.orig/include/linux/mmzone.h	Wed Jul 11 00:44:53 2001
+++ linux/include/linux/mmzone.h	Fri Jul 13 00:59:08 2001
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/kernel_stat.h>
 
 /*
  * Free memory management - zoned buddy allocator.
@@ -58,6 +59,9 @@
 	 */
 	char			*name;
 	unsigned long		size;
+#ifdef CONFIG_VM_STATS
+	struct vm_zone_stat stat;
+#endif
 } zone_t;
 
 #define ZONE_DMA		0
@@ -122,8 +126,12 @@
 extern void free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
   unsigned long *zones_size, unsigned long paddr, unsigned long *zholes_size,
   struct page *pmap);
+#ifdef CONFIG_VM_STATS
+extern int get_perzone_vm_stats(char *page, int len);
+#endif
 
 extern pg_data_t contig_page_data;
+
 
 #ifndef CONFIG_DISCONTIGMEM
 
diff -Nur --exclude-from=exclude linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Wed Jul 11 00:44:53 2001
+++ linux/include/linux/swap.h	Fri Jul 13 00:59:08 2001
@@ -125,6 +125,33 @@
 extern void wakeup_kswapd(void);
 extern int try_to_free_pages(unsigned int gfp_mask);
 
+#ifdef CONFIG_VM_STATS
+static inline int zone_free_shortage(zone_t *zone) 
+{
+	int sum = 0;
+	if (zone->inactive_clean_pages + zone->free_pages
+			< zone->pages_min) {
+		sum += zone->pages_min;
+		sum -= zone->free_pages;
+		sum -= zone->inactive_clean_pages;
+	}
+	return sum;
+}
+
+static inline int zone_inactive_shortage(zone_t *zone)
+{
+	int sum;
+
+	sum = zone->pages_high;
+	sum -= zone->inactive_dirty_pages; 
+	sum -= zone->inactive_clean_pages;
+	sum -= zone->free_pages;
+	
+	return (sum > 0 ? sum : 0);
+}
+#endif
+
+
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
 extern void rw_swap_page_nolock(int, swp_entry_t, char *);
diff -Nur --exclude-from=exclude linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Wed Jul 11 00:44:53 2001
+++ linux/mm/page_alloc.c	Fri Jul 13 00:59:08 2001
@@ -326,6 +326,7 @@
 				return page;
 		} else if (z->free_pages < z->pages_min &&
 					waitqueue_active(&kreclaimd_wait)) {
+				VM_STAT_INC_KRECLAIMD_WAKEUP
 				wake_up_interruptible(&kreclaimd_wait);
 		}
 	}
@@ -373,6 +374,7 @@
 	 */
 	wakeup_kswapd();
 	if (gfp_mask & __GFP_WAIT) {
+		VM_STAT_INC_ALLOC_RESCHED
 		__set_current_state(TASK_RUNNING);
 		current->policy |= SCHED_YIELD;
 		schedule();
@@ -619,6 +621,69 @@
 		pgdat = pgdat->node_next;
 	}
 	return pages;
+}
+#endif
+
+#ifdef CONFIG_VM_STATS
+int get_perzone_vm_stats (char *page, int len)
+{
+	unsigned type;	
+	int llen;
+	unsigned long flags;
+	pg_data_t *pgdat = pgdat_list;
+
+	llen = len;
+
+	for (type = 0; type < MAX_NR_ZONES; type++) {
+		zone_t *zone = pgdat->node_zones + type;
+		if (!zone->size)
+			break;
+
+
+		llen += sprintf(page + llen, "Zone: %s\n", zone->name);
+
+		llen += sprintf(page + llen, 
+				"free shortage: %u\n"
+				"inactive shortage: %u\n",
+				zone_free_shortage(zone),
+				zone_inactive_shortage(zone));
+
+		llen += sprintf(page + llen,
+			"vm_launder_pgscan %u\n"
+			"vm_pgclean %u\n"
+			"vm_pgskiplocked %u\n"
+			"vm_pgskipdirty %u\n"
+			"vm_pglaundered %u\n"
+			"vm_pgreact %u\n"
+			"vm_pgrescue %u\n"
+			"vm_pgagescan %u\n"
+			"vm_pgagedown %u\n"
+			"vm_pgageup %u\n"
+			"vm_pgdeact %u\n"
+			"vm_pgdeactfail_age %u\n"
+			"vm_pgdeactfail_ref %u\n"
+			"vm_reclaimfail %u\n"
+			"vm_ptescan %u\n"
+			"vm_pteunmap %u\n",
+			zone->stat.vm_launder_pgscan,
+			zone->stat.vm_pgclean,
+			zone->stat.vm_pgskiplocked, 
+			zone->stat.vm_pgskipdirty,
+			zone->stat.vm_pglaundered,
+			zone->stat.vm_pgreact, 
+			zone->stat.vm_pgrescue,
+			zone->stat.vm_pgagescan,
+			zone->stat.vm_pgagedown,
+			zone->stat.vm_pgageup,
+			zone->stat.vm_pgdeact,
+			zone->stat.vm_pgdeactfail_age,
+			zone->stat.vm_pgdeactfail_ref,
+			zone->stat.vm_reclaimfail,
+			zone->stat.vm_ptescan,
+			zone->stat.vm_pteunmap);
+	}
+
+	return llen;
 }
 #endif
 
diff -Nur --exclude-from=exclude linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Wed Jul 11 00:44:53 2001
+++ linux/mm/vmscan.c	Fri Jul 13 00:59:08 2001
@@ -41,11 +41,14 @@
 	pte_t pte;
 	swp_entry_t entry;
 
+	VM_STAT_INC_PTESCAN(page->zone)
+
 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
 		page->age += PAGE_AGE_ADV;
 		if (page->age > PAGE_AGE_MAX)
 			page->age = PAGE_AGE_MAX;
+		VM_STAT_INC_PGAGEUP(page->zone)
 		return;
 	}
 
@@ -73,6 +76,7 @@
 		swap_duplicate(entry);
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
+		VM_STAT_INC_PTEUNMAP(page->zone)
 		mm->rss--;
 		if (!page->age)
 			deactivate_page(page);
@@ -359,6 +363,7 @@
 				(!page->buffers && page_count(page) > 1)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_active_list(page);
+			VM_STAT_INC_PGRESCUE(page->zone)
 			continue;
 		}
 
@@ -388,6 +393,7 @@
 	}
 	/* Reset page pointer, maybe we encountered an unfreeable page. */
 	page = NULL;
+	VM_STAT_INC_RECLAIMFAIL(zone)
 	goto out;
 
 found_page:
@@ -436,6 +442,8 @@
 	maxlaunder = 0;
 	cleaned_pages = 0;
 
+	VM_STAT_INC_PGLAUNDER
+
 dirty_page_rescan:
 	spin_lock(&pagemap_lru_lock);
 	maxscan = nr_inactive_dirty_pages;
@@ -452,12 +460,15 @@
 			continue;
 		}
 
+		VM_STAT_INC_PGSCAN(page->zone)
+
 		/* Page is or was in use?  Move it to the active list. */
 		if (PageReferenced(page) || page->age > 0 ||
 				(!page->buffers && page_count(page) > 1) ||
 				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			VM_STAT_INC_PGREACT(page->zone)
 			continue;
 		}
 
@@ -468,6 +479,7 @@
 		if (TryLockPage(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &inactive_dirty_list);
+			VM_STAT_INC_PGSKIPLOCKED(page->zone)
 			continue;
 		}
 
@@ -485,6 +497,7 @@
 			if (!launder_loop || !CAN_DO_FS) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
+				VM_STAT_INC_PGSKIPDIRTY(page->zone)
 				UnlockPage(page);
 				continue;
 			}
@@ -497,6 +510,8 @@
 			writepage(page);
 			page_cache_release(page);
 
+			VM_STAT_INC_PGLAUNDERED(page->zone)
+
 			/* And re-start the thing.. */
 			spin_lock(&pagemap_lru_lock);
 			continue;
@@ -525,12 +540,18 @@
 			spin_unlock(&pagemap_lru_lock);
 
 			/* Will we do (asynchronous) IO? */
-			if (launder_loop && maxlaunder == 0 && sync)
-				buffer_mask = gfp_mask;				/* Do as much as we can */
-			else if (launder_loop && maxlaunder-- > 0)
-				buffer_mask = gfp_mask & ~__GFP_WAIT;			/* Don't wait, async write-out */
+			if (launder_loop && maxlaunder == 0 && sync) {
+				buffer_mask = gfp_mask;		
+				VM_STAT_INC_PGLAUNDERED(page->zone)
+				/* Do as much as we can */
+			} else if (launder_loop && maxlaunder-- > 0) {
+				buffer_mask = gfp_mask & ~__GFP_WAIT;	
+				VM_STAT_INC_PGLAUNDERED(page->zone)
+				/* Don't wait, async write-out */
+			}
 			else
-				buffer_mask = gfp_mask & ~(__GFP_WAIT | __GFP_IO);	/* Don't even start IO */
+				buffer_mask = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
+				/* Don't even start IO */
 
 			/* Try to free the page buffers. */
 			clearedbuf = try_to_free_buffers(page, buffer_mask);
@@ -559,6 +580,7 @@
 			/* OK, we "created" a freeable page. */
 			} else /* page->mapping && page_count(page) == 2 */ {
 				add_page_to_inactive_clean_list(page);
+				VM_STAT_INC_PGCLEAN(page->zone)
 				cleaned_pages++;
 			}
 
@@ -587,6 +609,7 @@
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_inactive_clean_list(page);
 			UnlockPage(page);
+			VM_STAT_INC_PGCLEAN(page->zone)
 			cleaned_pages++;
 		} else {
 page_active:
@@ -622,6 +645,7 @@
 		maxlaunder = MAX_LAUNDER;
 		/* Kflushd takes care of the rest. */
 		wakeup_bdflush(0);
+		VM_STAT_INC_PGLAUNDER_WRITE
 		goto dirty_page_rescan;
 	}
 
@@ -645,6 +669,8 @@
 	int page_active = 0;
 	int nr_deactivated = 0;
 
+	VM_STAT_INC_REFILL_INACTIVE_SCAN
+
 	/*
 	 * When we are background aging, we try to increase the page aging
 	 * information in the system.
@@ -652,6 +678,7 @@
 	if (!target)
 		maxscan = nr_active_pages >> 4;
 
+
 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
 	while (maxscan-- > 0 && (page_lru = active_list.prev) != &active_list) {
@@ -665,12 +692,16 @@
 			continue;
 		}
 
+		VM_STAT_INC_PGAGESCAN(page->zone)
+
 		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {
 			age_page_up_nolock(page);
 			page_active = 1;
+			VM_STAT_INC_PGAGEUP(page->zone)
 		} else {
 			age_page_down_ageonly(page);
+			VM_STAT_INC_PGAGEDOWN(page->zone)
 			/*
 			 * Since we don't hold a reference on the page
 			 * ourselves, we have to do our test a bit more
@@ -697,7 +728,21 @@
 		if (page_active || PageActive(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
+#ifdef CONFIG_VM_STATS
+			/*
+			 * The page deactivation can fail due to a page
+			 * with non zero age (accounted as DEACTFAIL_AGE) 
+			 * or due to a zero aged page with more users than 
+			 * the pagecache. (accounted as DEACTFAIL_REF)
+			 */
+			if (page->age)
+				VM_STAT_INC_PGDEACTFAIL_AGE(page->zone)
+			else
+				VM_STAT_INC_PGDEACTFAIL_REF(page->zone)
+#endif
+
 		} else {
+			VM_STAT_INC_PGDEACT(page->zone)
 			nr_deactivated++;
 			if (target && nr_deactivated >= target)
 				break;
@@ -963,8 +1008,10 @@
 
 void wakeup_kswapd(void)
 {
-	if (waitqueue_active(&kswapd_wait))
+	if (waitqueue_active(&kswapd_wait)) {
 		wake_up_interruptible(&kswapd_wait);
+		VM_STAT_INC_KSWAPD_WAKEUP
+	}
 }
 
 /*

