Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVFHBrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVFHBrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVFHBrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 21:47:41 -0400
Received: from graphe.net ([209.204.138.32]:9439 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262061AbVFHBrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 21:47:25 -0400
Date: Tue, 7 Jun 2005 18:47:23 -0700 (PDT)
From: Christoph Lameter <christoph@graphe.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Reduce size of huge boot per_cpu_pageset in rc6-mm1 (V2)
Message-ID: <Pine.LNX.4.62.0506071836440.1802@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce size of the huge per_cpu_pageset structure in __initdata
introduced into mm1 with the pageset localization patchset.
Use one specially configured pageset per cpu for all zones
and nodes during bootup.

- Avoid duplication of pageset initialization code.
- do the adding to the pageset list before potential free_pages_bulk
  in free_hot_cold_page (otherwise we would have to hold a page
  in a pageset during the period that the boot pagesets are in use).
- remove mistaken __cpuinitdata attribute and revert back to __initdata
  for the boot pageset. A boot pageset is not necessary for cpu hotplug.

Tested for UP SMP NUMA on x86_64 (2.6.12-rc6-mm1): UP SMP NUMA
Tested on IA64 (2.6.12-rc5-mm2): NUMA (2.6.12-rc6-mm1 broken for IA64 
because of sparsemem patches)

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.12-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/mm/page_alloc.c	2005-06-08 00:46:35.000000000 +0000
+++ linux-2.6.12-rc6-mm1/mm/page_alloc.c	2005-06-08 00:53:43.000000000 +0000
@@ -70,11 +70,6 @@
 struct zone *zone_table[1 << ZONETABLE_SHIFT];
 EXPORT_SYMBOL(zone_table);
 
-#ifdef CONFIG_NUMA
-static struct per_cpu_pageset
-	pageset_table[MAX_NR_ZONES*MAX_NUMNODES*NR_CPUS] __cpuinitdata;
-#endif
-
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
@@ -656,10 +651,10 @@
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
-	if (pcp->count >= pcp->high)
-		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
+	if (pcp->count >= pcp->high)
+		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
 	local_irq_restore(flags);
 	put_cpu();
 }
@@ -1795,57 +1790,55 @@
 	return batch;
 }
 
+inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+{
+	struct per_cpu_pages *pcp;
+
+	pcp = &p->pcp[0];		/* hot */
+	pcp->count = 0;
+	pcp->low = 2 * batch;
+	pcp->high = 6 * batch;
+	pcp->batch = max(1UL, 1 * batch);
+	INIT_LIST_HEAD(&pcp->list);
+
+	pcp = &p->pcp[1];		/* cold*/
+	pcp->count = 0;
+	pcp->low = 0;
+	pcp->high = 2 * batch;
+	pcp->batch = max(1UL, 1 * batch);
+	INIT_LIST_HEAD(&pcp->list);
+}
+
 #ifdef CONFIG_NUMA
 /*
- * Dynamicaly allocate memory for the
+ * Boot pageset table. One per cpu which is going to be used for all
+ * zones and all nodes. The parameters will be set in such a way
+ * that an item put on a list will immediately be handed over to
+ * the buddy list. This is safe since pageset manipulation is done
+ * with interrupts disabled.
+ *
+ * Some NUMA counter updates may also be caught by the boot pagesets.
+ * These will be discarded when bootup is complete.
+ */
+static struct per_cpu_pageset
+	boot_pageset[NR_CPUS] __initdata;
+
+/*
+ * Dynamically allocate memory for the
  * per cpu pageset array in struct zone.
  */
 static int __devinit process_zones(int cpu)
 {
 	struct zone *zone, *dzone;
-	int i;
 
 	for_each_zone(zone) {
-		struct per_cpu_pageset *npageset = NULL;
 
-		npageset = kmalloc_node(sizeof(struct per_cpu_pageset),
+		zone->pageset[cpu] = kmalloc_node(sizeof(struct per_cpu_pageset),
 					 GFP_KERNEL, cpu_to_node(cpu));
-		if (!npageset) {
-			zone->pageset[cpu] = NULL;
+		if (!zone->pageset[cpu])
 			goto bad;
-		}
-
-		if (zone->pageset[cpu]) {
-			memcpy(npageset, zone->pageset[cpu],
-					sizeof(struct per_cpu_pageset));
-
-			/* Relocate lists */
-			for (i = 0; i < 2; i++) {
-				INIT_LIST_HEAD(&npageset->pcp[i].list);
-				list_splice(&zone->pageset[cpu]->pcp[i].list,
-					&npageset->pcp[i].list);
-			}
- 		} else {
-			struct per_cpu_pages *pcp;
-			unsigned long batch;
 
-			batch = zone_batchsize(zone);
-
-			pcp = &npageset->pcp[0];		/* hot */
-			pcp->count = 0;
-			pcp->low = 2 * batch;
-			pcp->high = 6 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
-
-			pcp = &npageset->pcp[1];		/* cold*/
-			pcp->count = 0;
-			pcp->low = 0;
-			pcp->high = 2 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
-		}
-		zone->pageset[cpu] = npageset;
+		setup_pageset(zone->pageset[cpu], zone_batchsize(zone));
 	}
 
 	return 0;
@@ -1958,30 +1951,13 @@
 		batch = zone_batchsize(zone);
 
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			struct per_cpu_pages *pcp;
 #ifdef CONFIG_NUMA
-			struct per_cpu_pageset *pgset;
-			pgset = &pageset_table[nid*MAX_NR_ZONES*NR_CPUS +
-					(j * NR_CPUS) + cpu];
-
-			zone->pageset[cpu] = pgset;
+			/* Early boot. Slab allocator not functional yet */
+			zone->pageset[cpu] = &boot_pageset[cpu];
+			setup_pageset(&boot_pageset[cpu],0);
 #else
-			struct per_cpu_pageset *pgset = zone_pcp(zone, cpu);
+			setup_pageset(zone_pcp(zone,cpu), batch);
 #endif
-
-			pcp = &pgset->pcp[0];			/* hot */
-			pcp->count = 0;
-			pcp->low = 2 * batch;
-			pcp->high = 6 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
-
-			pcp = &pgset->pcp[1];			/* cold */
-			pcp->count = 0;
-			pcp->low = 0;
-			pcp->high = 2 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
 		}
 		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
