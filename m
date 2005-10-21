Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVJUWn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVJUWn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVJUWn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 18:43:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37523 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964897AbVJUWnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 18:43:55 -0400
Message-ID: <43596F1E.4070805@redhat.com>
Date: Fri, 21 Oct 2005 18:43:42 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] OVERCOMMIT_GUESS considers reserved pages
Content-Type: multipart/mixed;
 boundary="------------050402090303060003080503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402090303060003080503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is the latest patch that OVERCOMMIT_GUESS in
__vm_enough_memory() considers reserved pages.

I think the patch is useful to avoid invoking oom killer, while
the patch is not the perfect solution of oom issues.

I checked that the patch works well when requirement of large
mount anonymous pages is occurred frequently. Otherwise the patch
can not fully avoid oom killer.

I think the reason is the following. Current OVERCOMMIT_GUESS
does not refer number of free pages, if the sum of page caches,
swap pages, and slab reclaim pages is greater than number of
required pages. However, when number of free pages is small,
the VM seems to get behind in page reclaiming and to invoke oom
killer.

Therefore, I want to change the code to check number of free
pages if number of required pages is relatively large. I think
ideally the best condition is when number of the required pages
exceeds number of reclaimable pages at one time. However, I don't
conceive implementation of such good condition yet.

Please let me know if you have any ideas about it.

Best regards,
Hide Aoki

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------050402090303060003080503
Content-Type: text/x-patch;
 name="mm-overcommit_guess-considers-reserved-pages_v4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-overcommit_guess-considers-reserved-pages_v4.patch"

This patch is an enhancement of OVERCOMMIT_GUESS algorithm in
__vm_enough_memory().

- changelog

  v4:
    - dealing with pages_high as reserved pages
    - updated the code for 2.6.14-rc4-mm1

  v3 (private): 
    - enhanced error handling in __vm_enough_memory
    - fixed an issue related calculation of totalreserve_pages 

  v2 (private):
    - fixed error handling bug
    - updated test results
    - updated the code for 2.6.14-rc2-mm2 


- why the kernel needed patching

  An application program sometimes are killed by oom killer, when
  the application accesses the memory region which was succeeded to
  allocate. If the Linux runs with page reservation features like
  /proc/sys/vm/lowmem_reserve_ratio and without swap region, the
  killing occurs easily.

  Since the current OVERCOMMET_GUESS algorithm does not consider 
  any reserved pages, the VM might assign a part of reserved pages
  to anonymous pages and have to reclaim the pages immediately. 


- the overall design approach in the patch

  When the OVERCOMMET_GUESS algorithm calculates number of free pages,
  the reserved free pages regard for non-free pages.


- implementation details

  This patch changes the following two things.

  1) Counting free pages in OVERCOMMIT_GUESS algorithm
     When the OVERCOMMIT_GUESS algorithm calculates the number of free
     pages, the algorithm subtracts the number of reserved pages from
     the result nr_free_pages().

  2) Adding a global variable: totalreserve_pages.
     The variable keeps the sum of the most highest lowmem_reserve[]
     and pages_high in each zone. The variable is calculated when the
     VM is initialized. And the variable is updated when  
     /proc/sys/vm/lowmem_reserve_ratio or /proc/sys/vm/min_free_kbytes
     is changed.


- testing results

  I checked that this patch can pass compile. And I tested that the
  patch can avoid to invoke oom killer if number of required pages is
  higher than the sum of cache pages, swap pages, and slab_reclaim_pages. 

---
Signed-off-by: Hideo Aoki <haoki@redhat.com>
---

 include/linux/swap.h |    1 +
 mm/mmap.c            |   19 ++++++++++++++++---
 mm/page_alloc.c      |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff -uprN linux-2.6.14-rc4-mm1/include/linux/swap.h linux-2.6.14-rc4-mm1-mm-fix_v4/include/linux/swap.h
--- linux-2.6.14-rc4-mm1/include/linux/swap.h	2005-10-18 20:53:25.000000000 -0400
+++ linux-2.6.14-rc4-mm1-mm-fix_v4/include/linux/swap.h	2005-10-18 21:33:15.000000000 -0400
@@ -155,6 +155,7 @@ extern void swapin_readahead(swp_entry_t
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
+extern unsigned long totalreserve_pages;
 extern long nr_swap_pages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
diff -uprN linux-2.6.14-rc4-mm1/mm/mmap.c linux-2.6.14-rc4-mm1-mm-fix_v4/mm/mmap.c
--- linux-2.6.14-rc4-mm1/mm/mmap.c	2005-10-18 20:53:25.000000000 -0400
+++ linux-2.6.14-rc4-mm1-mm-fix_v4/mm/mmap.c	2005-10-18 21:33:15.000000000 -0400
@@ -120,14 +120,27 @@ int __vm_enough_memory(long pages, int c
 		 * only call if we're about to fail.
 		 */
 		n = nr_free_pages();
+
+		/*
+		 * Leave the lowmem_reserve pages. The pages are not
+		 * for anonymous pages.
+		 */
+		if (n <= totalreserve_pages)
+			goto error;
+		else
+			n -= totalreserve_pages;
+
+		/*
+		 * Leave the last 3% for root
+		 */
 		if (!cap_sys_admin)
 			n -= n / 32;
 		free += n;
 
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
-		return -ENOMEM;
+
+		goto error;
 	}
 
 	allowed = (totalram_pages - hugetlb_total_pages())
@@ -149,7 +162,7 @@ int __vm_enough_memory(long pages, int c
 	 */
 	if (atomic_read(&vm_committed_space) < (long)allowed)
 		return 0;
-
+error:
 	vm_unacct_memory(pages);
 
 	return -ENOMEM;
diff -uprN linux-2.6.14-rc4-mm1/mm/page_alloc.c linux-2.6.14-rc4-mm1-mm-fix_v4/mm/page_alloc.c
--- linux-2.6.14-rc4-mm1/mm/page_alloc.c	2005-10-18 20:53:25.000000000 -0400
+++ linux-2.6.14-rc4-mm1-mm-fix_v4/mm/page_alloc.c	2005-10-19 19:08:15.000000000 -0400
@@ -51,6 +51,7 @@ EXPORT_SYMBOL(node_possible_map);
 struct pglist_data *pgdat_list __read_mostly;
 unsigned long totalram_pages __read_mostly;
 unsigned long totalhigh_pages __read_mostly;
+unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 
 /*
@@ -2444,6 +2445,38 @@ void __init page_alloc_init(void)
 }
 
 /*
+ * calculate_totalreserve_pages - called when sysctl_lower_zone_reserve_ratio
+ *	or min_free_kbytes changes.
+ */
+static void calculate_totalreserve_pages(void)
+{
+	struct pglist_data *pgdat;
+	unsigned long reserve_pages = 0;
+	int i, j;
+
+	for_each_pgdat(pgdat) {
+		for (i = 0; i < MAX_NR_ZONES; i++) {
+			struct zone *zone = pgdat->node_zones + i;
+			unsigned long max = 0;
+
+			/* Find valid and maximum lowmem_reserve in the zone */
+			for (j = i; j < MAX_NR_ZONES; j++) {
+				if (zone->lowmem_reserve[j] > max)
+					max = zone->lowmem_reserve[j];
+			}
+
+			/* We treat pages_high as reserved pages. */
+			max += zone->pages_high;
+
+			if (max > zone->present_pages)
+				max = zone->present_pages;
+			reserve_pages += max;
+		}
+	}
+	totalreserve_pages = reserve_pages;
+}
+
+/*
  * setup_per_zone_lowmem_reserve - called whenever
  *	sysctl_lower_zone_reserve_ratio changes.  Ensures that each zone
  *	has a correct pages reserved value, so an adequate number of
@@ -2474,6 +2507,9 @@ static void setup_per_zone_lowmem_reserv
 			}
 		}
 	}
+
+	/* update totalreserve_pages */
+	calculate_totalreserve_pages();
 }
 
 /*
@@ -2527,6 +2563,9 @@ void setup_per_zone_pages_min(void)
 		zone->pages_high  = (zone->pages_min * 6) / 4;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
+
+	/* update totalreserve_pages */
+	calculate_totalreserve_pages();
 }
 
 /*

--------------050402090303060003080503--
