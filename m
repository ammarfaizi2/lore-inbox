Return-Path: <linux-kernel-owner+w=401wt.eu-S932224AbXAQO4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXAQO4D (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbXAQO4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:56:03 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51815 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224AbXAQO4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:56:00 -0500
Date: Wed, 17 Jan 2007 20:25:15 +0530
To: Roy Huang <royhuang9@gmail.com>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, aubreylee@gmail.com,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
Subject: Re: [PATCH] Provide an interface to limit total page cache.
Message-ID: <20070117145515.GA446@drishya>
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com> <45AB6C25.1080804@linux.vnet.ibm.com> <afe668f90701151840tc8d7608sadccb3e39017d1ed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afe668f90701151840tc8d7608sadccb3e39017d1ed@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: svaidy@linux.vnet.ibm.com (Vaidyanathan Srinivasan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Roy,

I have added a different pagecache reclaim logic around your 
sysctl interface. This would ensure that only pagecache pages are 
reclaimed if the limit is exceeded.

--Vaidy

Pagecache pages in memory can be limited to a percentage of total 
RAM using this patch.

New sysctl entry /proc/sys/vm/pagecache_ratio has been added that 
holds the total percentage of RAM that the user wants as pagecache.  
The default percentage is 90.

Depending on the work load, any percentage value can be set to derive 
optimum overall performance. Minimum is 5 and max is 100.

balance_pagecache() routine is called on file backed access and the 
current pagecache_limit is checked against utilisation.

If the limit is exceeded, then shrink_all_pagecache_memory() is 
called that will walk the LRU list and remove unmapped pagecache 
pages.  New scancontrol fields have been added to make decisions 
in shrink_page_list() and shrink_active_list().

Pages counted under pagecache limit are file pages that are not mapped.  
Shared memory is mapped and not counted in the limit.

Test:

echo 40 > /proc/sys/vm/pagecache_ratio
(that is around 400MB on a 1GB RAM machine)

dd if=/dev/zero of=/tmp/foo bs=1M count=1024

cat /proc/meminfo
The "Cached: xxx" count should hit the set limit and not consume all
available memory.

Any feedback is appreciated.

Signed-off-by: Roy Huang <royhuang9@gmail.com>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 include/linux/pagemap.h |    6 +++
 include/linux/sysctl.h  |    1 
 kernel/sysctl.c         |    9 +++++
 mm/filemap.c            |   65 +++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c             |   79 +++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 156 insertions(+), 4 deletions(-)

--- linux-2.6.20-rc5.orig/include/linux/pagemap.h
+++ linux-2.6.20-rc5/include/linux/pagemap.h
@@ -12,6 +12,12 @@
 #include <asm/uaccess.h>
 #include <linux/gfp.h>
 
+extern int pagecache_ratio;
+extern unsigned int pagecache_limit;
+
+extern int pagecache_ratio_sysctl_handler(struct ctl_table *, int,
+			struct file *, void __user *, size_t *, loff_t *);
+
 /*
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
  * allocation mode flags.
--- linux-2.6.20-rc5.orig/include/linux/sysctl.h
+++ linux-2.6.20-rc5/include/linux/sysctl.h
@@ -202,6 +202,7 @@ enum
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
+	VM_PAGECACHE_RATIO=36,  /* Percent memory is used as page cache */
 };
 
 
--- linux-2.6.20-rc5.orig/kernel/sysctl.c
+++ linux-2.6.20-rc5/kernel/sysctl.c
@@ -1035,6 +1035,15 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 #endif
+	{
+		.ctl_name	= VM_PAGECACHE_RATIO,
+		.procname	= "pagecache_ratio",
+		.data		= &pagecache_ratio,
+		.maxlen		= sizeof(pagecache_ratio),
+		.mode		= 0644,
+		.proc_handler	= &pagecache_ratio_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+	},
 	{ .ctl_name = 0 }
 };
 
--- linux-2.6.20-rc5.orig/mm/filemap.c
+++ linux-2.6.20-rc5/mm/filemap.c
@@ -30,6 +30,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/cpuset.h>
+#include <linux/sysctl.h>
 #include "filemap.h"
 #include "internal.h"
 
@@ -108,6 +109,66 @@ generic_file_direct_IO(int rw, struct ki
  */
 
 /*
+ * Start release pagecache (via kswapd) at the percentage.
+ */
+int pagecache_ratio __read_mostly = 90;
+
+unsigned int pagecache_limit = 0;
+
+#define PAGECACHE_RECLAIM_THRESHOLD 64 /* Call reclaim after exceeding
+					  the limit by this threshold */
+
+int setup_pagecache_limit(void)
+{
+	if (pagecache_ratio > 100)
+		pagecache_ratio = 100;
+	if (pagecache_ratio < 5)
+		pagecache_ratio = 5;
+	pagecache_limit = pagecache_ratio * nr_free_pagecache_pages() / 100;
+	return 0;
+}
+
+int pagecache_ratio_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	setup_pagecache_limit();
+	return 0;
+}
+
+extern unsigned long shrink_all_pagecache_memory(unsigned long nr_pages);
+
+int check_pagecache_overlimit(void)
+{
+	unsigned long current_pagecache;
+	int nr_pages = 0;
+
+	current_pagecache = global_page_state(NR_FILE_PAGES) -
+		global_page_state(NR_FILE_MAPPED);
+	/* NR_FILE_PAGES includes shared memory, swap cache and
+	 * buffers.  Hence exclude NR_FILE_MAPPED, since we would
+	 * not reclaim mapped pages.  Unmapped pagecache pages
+	 * is what we really want to target */
+	if ( pagecache_limit && current_pagecache > pagecache_limit)
+		nr_pages = current_pagecache - pagecache_limit;
+
+	return nr_pages;
+}
+
+static inline int balance_pagecache(void)
+{
+	unsigned long nr_pages;
+	unsigned long ret;
+	nr_pages = check_pagecache_overlimit();
+	/* Don't call reclaim for each page */
+	if (nr_pages > PAGECACHE_RECLAIM_THRESHOLD)
+		ret = shrink_all_pagecache_memory(nr_pages);
+	return 0;
+}
+
+__initcall(setup_pagecache_limit);
+
+/*
  * Remove a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
  * is safe.  The caller must hold a write_lock on the mapping's tree_lock.
@@ -1085,6 +1146,8 @@ out:
 		page_cache_release(cached_page);
 	if (filp)
 		file_accessed(filp);
+
+	balance_pagecache();
 }
 EXPORT_SYMBOL(do_generic_mapping_read);
 
@@ -2212,6 +2275,8 @@ zero_length_segment:
 		status = filemap_write_and_wait(mapping);
 
 	pagevec_lru_add(&lru_pvec);
+	balance_pagecache();
+
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
--- linux-2.6.20-rc5.orig/mm/vmscan.c
+++ linux-2.6.20-rc5/mm/vmscan.c
@@ -45,6 +45,9 @@
 
 #include "internal.h"
 
+
+extern int check_pagecache_overlimit(void);
+
 struct scan_control {
 	/* Incremented by the number of inactive pages that were scanned */
 	unsigned long nr_scanned;
@@ -66,6 +69,10 @@ struct scan_control {
 	int swappiness;
 
 	int all_unreclaimable;
+
+	int reclaim_pagecache_only;  /* Set when called from
+					pagecache controller */
+
 };
 
 /*
@@ -470,7 +477,15 @@ static unsigned long shrink_page_list(st
 			goto keep;
 
 		VM_BUG_ON(PageActive(page));
-
+		/* Take it easy if we are doing only pagecache pages */
+		if (sc->reclaim_pagecache_only) {
+			/* Check if this is a pagecache page they are not mapped */
+			if (page_mapped(page))
+				goto keep_locked;
+			/* Check if pagecache limit is exceeded */
+			if (!check_pagecache_overlimit())
+				goto keep_locked;
+		}
 		sc->nr_scanned++;
 
 		if (!sc->may_swap && page_mapped(page))
@@ -518,7 +533,8 @@ static unsigned long shrink_page_list(st
 		}
 
 		if (PageDirty(page)) {
-			if (referenced)
+			/* Reclaim even referenced pagecache pages if over limit */
+			if (!check_pagecache_overlimit() && referenced)
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
@@ -832,6 +848,14 @@ force_reclaim_mapped:
 		cond_resched();
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
+		/* While reclaiming pagecache make it easy */
+		if (sc->reclaim_pagecache_only) {
+			if (page_mapped(page) || !check_pagecache_overlimit()) {
+				list_add(&page->lru, &l_active);
+				continue;
+			}
+		}
+
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
@@ -1027,6 +1051,7 @@ unsigned long try_to_free_pages(struct z
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.may_swap = 1,
 		.swappiness = vm_swappiness,
+		.reclaim_pagecache_only = 0,
 	};
 
 	count_vm_event(ALLOCSTALL);
@@ -1131,6 +1156,7 @@ static unsigned long balance_pgdat(pg_da
 		.may_swap = 1,
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.swappiness = vm_swappiness,
+		.reclaim_pagecache_only = 0,
 	};
 	/*
 	 * temp_priority is used to remember the scanning priority at which
@@ -1361,7 +1387,6 @@ void wakeup_kswapd(struct zone *zone, in
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
-#ifdef CONFIG_PM
 /*
  * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages' pages
  * from LRU lists system-wide, for given pass and priority, and returns the
@@ -1436,6 +1461,7 @@ unsigned long shrink_all_memory(unsigned
 		.swap_cluster_max = nr_pages,
 		.may_writepage = 1,
 		.swappiness = vm_swappiness,
+		.reclaim_pagecache_only = 0,
 	};
 
 	current->reclaim_state = &reclaim_state;
@@ -1510,7 +1536,52 @@ out:
 
 	return ret;
 }
-#endif
+
+unsigned long shrink_all_pagecache_memory(unsigned long nr_pages)
+{
+	unsigned long ret = 0;
+	int pass;
+	struct reclaim_state reclaim_state;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 0,
+		.swap_cluster_max = nr_pages,
+		.may_writepage = 1,
+		.swappiness = 0, /* Do not swap, only pagecache reclaim */
+		.reclaim_pagecache_only = 1, /* Flag it */
+	};
+
+	current->reclaim_state = &reclaim_state;
+
+	/*
+	 * We try to shrink LRUs in 5 passes:
+	 * 0 = Reclaim from inactive_list only
+	 * 1 = Reclaim from active list but don't reclaim mapped
+	 * 2 = 2nd pass of type 1
+	 * 3 = Reclaim mapped (normal reclaim)
+	 * 4 = 2nd pass of type 3
+	 */
+	for (pass = 0; pass < 5; pass++) {
+		int prio;
+
+		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
+			unsigned long nr_to_scan = nr_pages - ret;
+			sc.nr_scanned = 0;
+			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			if (ret >= nr_pages)
+				goto out;
+
+			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
+				congestion_wait(WRITE, HZ / 10);
+		}
+	}
+
+
+out:
+	current->reclaim_state = NULL;
+
+	return ret;
+}
 
 /* It's optimal to keep kswapds on the same CPUs as their memory, but
    not required for correctness.  So if the last cpu in a node goes

