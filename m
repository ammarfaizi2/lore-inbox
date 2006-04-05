Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWDEXrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWDEXrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWDEXrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:47:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29899 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751194AbWDEXro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:47:44 -0400
Message-ID: <4434570F.9030507@redhat.com>
Date: Wed, 05 Apr 2006 19:47:27 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch 1/3] mm: An enhancement of OVERCOMMIT_GUESS 
Content-Type: multipart/mixed;
 boundary="------------090003060702020707060208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003060702020707060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrew,

Could you apply my patches to your tree?

These patches are an enhancement of OVERCOMMIT_GUESS algorithm in
__vm_enough_memory(). The detailed description is in attached patch.

Actually, these are the revised patch which I sent to lkml in the last
year.
http://marc.theaimsgroup.com/?l=linux-kernel&m=112993489022427&w=2

I wrote a test kernel module to show the result of the patches.
For your information, I also would like to send the module in later e-mail.

Best regards,
Hideo Aoki

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------090003060702020707060208
Content-Type: text/x-patch;
 name="mm-add-totalreserve_pages.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-add-totalreserve_pages.patch"

These patches are an enhancement of OVERCOMMIT_GUESS algorithm in
__vm_enough_memory().

- why the kernel needed patching

  When the kernel can't allocate anonymous pages in practice, currnet
  OVERCOMMIT_GUESS could return success. This implementation might be
  the cause of oom kill in memory pressure situation.

  If the Linux runs with page reservation features like
  /proc/sys/vm/lowmem_reserve_ratio and without swap region, I think
  the oom kill occurs easily.


- the overall design approach in the patch

  When the OVERCOMMET_GUESS algorithm calculates number of free pages,
  the reserved free pages are regarded as non-free pages.

  This change helps to avoid the pitfall that the number of free pages
  become less than the number which the kernel tries to keep free.


- testing results

  I tested the patches using my test kernel module.

  If the patches aren't applied to the kernel, __vm_enough_memory()
  returns success in the situation but autual page allocation is
  failed.

  On the other hand, if the patches are applied to the kernel, memory
  allocation failure is avoided since __vm_enough_memory() returns
  failure in the situation.

  I checked that on i386 SMP 16GB memory machine. I haven't tested on
  nommu environment currently.


- changelog

  v5:
    - updated to 2.6.17-rc1-mm1
    - did more strict tests.
    - added the enhancement to mm/nommu.c too

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


This patch adds totalreserve_pages for __vm_enough_memory().

Calculate_totalreserve_pages() checks maximum lowmem_reserve pages and
pages_high in each zone. Finally, the function stores the sum of each
zone to totalreserve_pages.

The totalreserve_pages is calculated when the VM is initilized.
And the variable is updated when /proc/sys/vm/lowmem_reserve_raito
or /proc/sys/vm/min_free_kbytes are changed.


Signed-off-by: Hideo Aoki <haoki@redhat.com>
---

 include/linux/swap.h |    1 +
 mm/page_alloc.c      |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff -purN linux-2.6.17-rc1-mm1/include/linux/swap.h linux-2.6.17-rc1-mm1-idea6/include/linux/swap.h
--- linux-2.6.17-rc1-mm1/include/linux/swap.h	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-idea6/include/linux/swap.h	2006-04-04 15:13:26.000000000 -0400
@@ -155,6 +155,7 @@ extern void swapin_readahead(swp_entry_t
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
+extern unsigned long totalreserve_pages;
 extern long nr_swap_pages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
diff -purN linux-2.6.17-rc1-mm1/mm/page_alloc.c linux-2.6.17-rc1-mm1-idea6/mm/page_alloc.c
--- linux-2.6.17-rc1-mm1/mm/page_alloc.c	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-idea6/mm/page_alloc.c	2006-04-04 15:13:26.000000000 -0400
@@ -51,6 +51,7 @@ nodemask_t node_possible_map __read_most
 EXPORT_SYMBOL(node_possible_map);
 unsigned long totalram_pages __read_mostly;
 unsigned long totalhigh_pages __read_mostly;
+unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 int percpu_pagelist_fraction;
 
@@ -2548,6 +2549,38 @@ void __init page_alloc_init(void)
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
+	for_each_online_pgdat(pgdat) {
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
+			/* we treat pages_high as reserved pages. */
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
@@ -2578,6 +2611,9 @@ static void setup_per_zone_lowmem_reserv
 			}
 		}
 	}
+
+	/* update totalreserve_pages */
+	calculate_totalreserve_pages();
 }
 
 /*
@@ -2632,6 +2668,9 @@ void setup_per_zone_pages_min(void)
 		zone->pages_high  = zone->pages_min + tmp / 2;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
+
+	/* update totalreserve_pages */
+	calculate_totalreserve_pages();
 }
 
 /*

--------------090003060702020707060208--
