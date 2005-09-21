Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVIUTHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVIUTHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVIUTHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:07:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751371AbVIUTHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:07:18 -0400
Message-ID: <4331AF5D.8060105@redhat.com>
Date: Wed, 21 Sep 2005 15:07:09 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc1-mm1] mm: OVERCOMMIT_GUESS considers lowmem_reserve_ratio.
Content-Type: multipart/mixed;
 boundary="------------050603000508070300020009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603000508070300020009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Attached patch is an enhancement to avoid overcommitting anonymous 
pages. Please review.

BTW, does anyone know any good tools to test overcommitted situation?

Best regards,
Hideo Aoki

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------050603000508070300020009
Content-Type: text/x-patch;
 name="mm_overcommit_guess_fix1_take1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm_overcommit_guess_fix1_take1.patch"

This patch is an enhancement of OVERCOMMIT_GUESS algorithm in
__vm_enough_memory(). 


- why the kernel needed patching

  In the OVERCOMMIT_GUESS algorithm, when page caches and swapable
  pages are not enough, the algorithm calculates number of free
  pages. If the number of free pages is more than required pages, the
  algorithm judges to be able to overcommit. 

  However, there are reserved free pages in free pages. The number of
  reserved pages is specified by /proc/sys/vm/lowmem_reserve_ratio. If
  all free pages are assigned to anonymous pages, the VM has to
  reclaim free pages and VM pressure probably rises. 
  

- the overall design approach in the patch

  When the OVERCOMMET_GUESS algorithm calculates number of free pages,
  the reserved free pages regard for non-free pages.


- implementation details

  This patch changes the following two things.

  1) When the OVERCOMMIT_GUESS algorithm calculates the number of free
     pages, the algorithm subtracts the number of reserved pages from 
     the result nr_free_pages().

  2) Adding a global variable, totalreserve_pages, to store the number
     of reserved pages. The variable is calculated when the VM
     initializes and /proc/sys/vm/lowmem_reserve_ratio is changed.


- testing results

  I checked that this patch can pass compile. 
 
---

Signed-off-by: Hideo Aoki <haoki@redhat.com>

---

 include/linux/swap.h |    1 +
 mm/mmap.c            |   13 +++++++++++++
 mm/page_alloc.c      |    4 ++++
 3 files changed, 18 insertions(+)

diff -uprN linux-2.6.14-rc1-mm1/include/linux/swap.h linux-2.6.14-rc1-mm1-vm-overcommit-fix/include/linux/swap.h
--- linux-2.6.14-rc1-mm1/include/linux/swap.h	2005-09-19 16:05:19.000000000 -0400
+++ linux-2.6.14-rc1-mm1-vm-overcommit-fix/include/linux/swap.h	2005-09-19 16:15:21.000000000 -0400
@@ -155,6 +155,7 @@ extern void swapin_readahead(swp_entry_t
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
+extern unsigned long totalreserve_pages;
 extern long nr_swap_pages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
diff -uprN linux-2.6.14-rc1-mm1/mm/mmap.c linux-2.6.14-rc1-mm1-vm-overcommit-fix/mm/mmap.c
--- linux-2.6.14-rc1-mm1/mm/mmap.c	2005-09-19 16:11:45.000000000 -0400
+++ linux-2.6.14-rc1-mm1-vm-overcommit-fix/mm/mmap.c	2005-09-19 16:15:21.000000000 -0400
@@ -120,6 +120,19 @@ int __vm_enough_memory(long pages, int c
 		 * only call if we're about to fail.
 		 */
 		n = nr_free_pages();
+
+		/*
+		 * Leave the lowmem_reserve pages. The pages are not
+		 * for anonymous pages.
+		 */
+		if (n <= totalreserve_pages)
+			return 0;
+		else
+			n -= totalreserve_pages;
+
+		/*
+		 * Leave the last 3% for root
+		 */
 		if (!cap_sys_admin)
 			n -= n / 32;
 		free += n;
diff -uprN linux-2.6.14-rc1-mm1/mm/page_alloc.c linux-2.6.14-rc1-mm1-vm-overcommit-fix/mm/page_alloc.c
--- linux-2.6.14-rc1-mm1/mm/page_alloc.c	2005-09-19 16:11:45.000000000 -0400
+++ linux-2.6.14-rc1-mm1-vm-overcommit-fix/mm/page_alloc.c	2005-09-19 16:22:09.000000000 -0400
@@ -51,6 +51,7 @@ EXPORT_SYMBOL(node_possible_map);
 struct pglist_data *pgdat_list __read_mostly;
 unsigned long totalram_pages __read_mostly;
 unsigned long totalhigh_pages __read_mostly;
+unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 
 /*
@@ -2454,6 +2455,7 @@ void __init page_alloc_init(void)
 static void setup_per_zone_lowmem_reserve(void)
 {
 	struct pglist_data *pgdat;
+	unsigned long reserve_pages = 0;
 	int j, idx;
 
 	for_each_pgdat(pgdat) {
@@ -2472,10 +2474,12 @@ static void setup_per_zone_lowmem_reserv
 				lower_zone = pgdat->node_zones + idx;
 				lower_zone->lowmem_reserve[j] = present_pages /
 					sysctl_lowmem_reserve_ratio[idx];
+				reserve_pages += lower_zone->lowmem_reserve[j];
 				present_pages += lower_zone->present_pages;
 			}
 		}
 	}
+	totalreserve_pages = reserve_pages;
 }
 
 /*

--------------050603000508070300020009--
