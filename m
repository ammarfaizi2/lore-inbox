Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268016AbUHPXBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268016AbUHPXBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUHPXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:01:21 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:8079 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S268014AbUHPW6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:58:09 -0400
Date: Mon, 16 Aug 2004 15:57:42 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Fw: [Lhms-devel] Making hotremovable attribute with memory section[2/4]
Cc: mbligh@aracnet.com
Message-Id: <20040816155233.E6FB.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forwarded by Yasunori Goto <ygoto@us.fujitsu.com>
----------------------- Original Message -----------------------
 From:    Yasunori Goto <ygoto@us.fujitsu.com>
 To:      lhms-devel@lists.sourceforge.net
 Date:    Mon, 16 Aug 2004 14:36:42 -0700
 Subject: [Lhms-devel] Making hotremovable attribute with memory section[2/4]
----

This patch is to divide per_cpu_pages into removable/un-removable
attribute. 

Note: 
  The amount of pool of per_cpu_pages might not be good....

---

 hotremovable-goto/include/linux/mmzone.h |    3 +
 hotremovable-goto/mm/page_alloc.c        |   59 +++++++++++++++++--------------
 2 files changed, 36 insertions(+), 26 deletions(-)

diff -puN include/linux/mmzone.h~divide_pcp include/linux/mmzone.h
--- hotremovable/include/linux/mmzone.h~divide_pcp	Fri Aug 13 16:24:42 2004
+++ hotremovable-goto/include/linux/mmzone.h	Fri Aug 13 16:24:42 2004
@@ -67,7 +67,8 @@ struct per_cpu_pages {
 };
 
 struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+	struct per_cpu_pages pcp[4];	/* 0: hot-unremovable.  1: cold-unremovable
+					   2: hot-removable     3: cold-removable   */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
diff -puN mm/page_alloc.c~divide_pcp mm/page_alloc.c
--- hotremovable/mm/page_alloc.c~divide_pcp	Fri Aug 13 16:24:42 2004
+++ hotremovable-goto/mm/page_alloc.c	Fri Aug 13 16:24:42 2004
@@ -695,6 +695,7 @@ static void fastcall free_hot_cold_page(
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
+	int removable = page_is_removable(page);
 
 	arch_free_page(page, 0);
 
@@ -707,7 +708,7 @@ static void fastcall free_hot_cold_page(
 		capture_pages(page, 0);
 		return;
 	}
-	pcp = &zone->pageset[get_cpu()].pcp[cold];
+	pcp = &zone->pageset[get_cpu()].pcp[cold | removable << 1];
 	local_irq_save(flags);
 	if (pcp->count >= pcp->high)
 		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
@@ -744,7 +745,7 @@ buffered_rmqueue(struct zone *zone, int 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
 
-		pcp = &zone->pageset[get_cpu()].pcp[cold];
+		pcp = &zone->pageset[get_cpu()].pcp[cold | at << 1];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0, gfp_flags,
@@ -1225,7 +1226,7 @@ void si_meminfo_node(struct sysinfo *val
 void show_free_areas(void)
 {
 	struct page_state ps;
-	int cpu, temperature;
+	int cpu, temperature, removable;
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
@@ -1249,13 +1250,18 @@ void show_free_areas(void)
 
 			pageset = zone->pageset + cpu;
 
-			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: low %d, high %d, batch %d\n",
-					cpu,
-					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].low,
-					pageset->pcp[temperature].high,
-					pageset->pcp[temperature].batch);
+			for (removable = 0; removable < NUM_AREA_TYPE; removable++){
+				for (temperature = 0; temperature < 2; temperature++){
+					int index = removable << 1 | temperature;
+					printk("cpu %d %s %s: low %d, high %d, batch %d\n",
+					       cpu,
+					       temperature ? "cold" : "hot",
+					       removable ? "removable" : "Un-removable",
+					       pageset->pcp[index].low,
+					       pageset->pcp[index].high,
+					       pageset->pcp[index].batch);
+				}
+			}
 		}
 	}
 
@@ -1853,21 +1859,24 @@ static void __init free_area_init_core(s
 			batch = 1;
 
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &zone->pageset[cpu].pcp[0];	/* hot */
-			pcp->count = 0;
-			pcp->low = 2 * batch;
-			pcp->high = 6 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
-
-			pcp = &zone->pageset[cpu].pcp[1];	/* cold */
-			pcp->count = 0;
-			pcp->low = 0;
-			pcp->high = 2 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
+			int removable;
+			for(removable = 0; removable < NUM_AREA_TYPE; removable++){
+				struct per_cpu_pages *pcp;
+
+				pcp = &zone->pageset[cpu].pcp[0 | removable << 1];	/* hot */
+				pcp->count = 0;
+				pcp->low = 1 * batch;
+				pcp->high = 3 * batch;
+				pcp->batch = 1 * batch;
+				INIT_LIST_HEAD(&pcp->list);
+
+				pcp = &zone->pageset[cpu].pcp[1 | removable << 1];	/* cold */
+				pcp->count = 0;
+				pcp->low = 0;
+				pcp->high = 1 * batch;
+				pcp->batch = 1 * batch;
+				INIT_LIST_HEAD(&pcp->list);
+			}
 		}
 		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
_

-- 
Yasunori Goto <ygoto at us.fujitsu.com>




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Lhms-devel mailing list
Lhms-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lhms-devel

--------------------- Original Message Ends --------------------

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


