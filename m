Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263704AbVCEEfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbVCEEfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbVCDXUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:20:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:49818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263233AbVCDVRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:17:19 -0500
Message-Id: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net>
Subject: [patch 2/5] setup_per_zone_lowmem_reserve() oops fix
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
From: akpm@osdl.org
Date: Fri, 04 Mar 2005 13:16:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If you do 'echo 0 0 > /proc/sys/vm/lowmem_reserve_ratio' the kernel gets a
divide-by-zero.

Prevent that, and fiddle with some whitespace too.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/page_alloc.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff -puN mm/page_alloc.c~setup_per_zone_lowmem_reserve-oops-fix mm/page_alloc.c
--- 25/mm/page_alloc.c~setup_per_zone_lowmem_reserve-oops-fix	2005-03-04 13:16:10.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2005-03-04 13:16:10.000000000 -0800
@@ -37,13 +37,17 @@
 #include <asm/tlbflush.h>
 #include "internal.h"
 
-/* MCD - HACK: Find somewhere to initialize this EARLY, or make this initializer cleaner */
+/*
+ * MCD - HACK: Find somewhere to initialize this EARLY, or make this
+ * initializer cleaner
+ */
 nodemask_t node_online_map = { { [0] = 1UL } };
 nodemask_t node_possible_map = NODE_MASK_ALL;
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 long nr_swap_pages;
+
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -1924,15 +1928,20 @@ static void setup_per_zone_lowmem_reserv
 
 	for_each_pgdat(pgdat) {
 		for (j = 0; j < MAX_NR_ZONES; j++) {
-			struct zone * zone = pgdat->node_zones + j;
+			struct zone *zone = pgdat->node_zones + j;
 			unsigned long present_pages = zone->present_pages;
 
 			zone->lowmem_reserve[j] = 0;
 
 			for (idx = j-1; idx >= 0; idx--) {
-				struct zone * lower_zone = pgdat->node_zones + idx;
+				struct zone *lower_zone;
+
+				if (sysctl_lowmem_reserve_ratio[idx] < 1)
+					sysctl_lowmem_reserve_ratio[idx] = 1;
 
-				lower_zone->lowmem_reserve[j] = present_pages / sysctl_lowmem_reserve_ratio[idx];
+				lower_zone = pgdat->node_zones + idx;
+				lower_zone->lowmem_reserve[j] = present_pages /
+					sysctl_lowmem_reserve_ratio[idx];
 				present_pages += lower_zone->present_pages;
 			}
 		}
@@ -2039,7 +2048,7 @@ module_init(init_per_zone_pages_min)
  *	changes.
  */
 int min_free_kbytes_sysctl_handler(ctl_table *table, int write, 
-		struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
 {
 	proc_dointvec(table, write, file, buffer, length, ppos);
 	setup_per_zone_pages_min();
@@ -2056,7 +2065,7 @@ int min_free_kbytes_sysctl_handler(ctl_t
  * if in function of the boot time zone sizes.
  */
 int lowmem_reserve_ratio_sysctl_handler(ctl_table *table, int write,
-		 struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
 {
 	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
 	setup_per_zone_lowmem_reserve();
_
