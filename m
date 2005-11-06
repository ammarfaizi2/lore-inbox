Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVKFIYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVKFIYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVKFIYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:24:07 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:23651 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932327AbVKFIYF (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:24:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=kg2WjDqGyo7DHPhvB8RvfggjPnFDJl/LfPLj58K+eCMFgE899SvY8KQ+hghYGRJfI1eJ62HjcMDfWkCvArl2Yz85DV2LPGc69Q3YcJzRhqKJlH5XU9RnmUzWZzvbBNOM/r8mQP6cL/Mn9Xvn1mDQl64RFfaQ/Dk+2xx144heGQs=  ;
Message-ID: <436DBE26.5080504@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:26:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 10/14] mm: single pcp list
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <436DBDE5.2010405@yahoo.com.au> <436DBE03.90009@yahoo.com.au>
In-Reply-To: <436DBE03.90009@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020701030601090007020406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701030601090007020406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

10/14

-- 
SUSE Labs, Novell Inc.


--------------020701030601090007020406
Content-Type: text/plain;
 name="mm-single-pcp-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-single-pcp-list.patch"

Use a single pcp list.

Having a hot and a cold pcp list means that cold pages are overlooked
when when a hot page is needed but none available. So a workload that is
doing heavy page reclaim will not take much advantage of the pcps for
minimising zone lock contention for the pages it is freeing up.

The same wastage applies the other way (eg. when the hot list fills up
and cold list is empty). The patch also takes care of that.

Disallow cold page allocation from taking hot pages though.

Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -44,15 +44,13 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
-struct per_cpu_pages {
+struct per_cpu_pageset {
+	struct list_head list;	/* the list of pages */
 	int count;		/* number of pages in the list */
+	int cold_count;		/* number of cold pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
-};
 
-struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -533,10 +533,8 @@ static int rmqueue_bulk(struct zone *zon
 void drain_remote_pages(void)
 {
 	struct zone *zone;
-	int i;
 	unsigned long flags;
 
-	local_irq_save(flags);
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
 
@@ -544,17 +542,16 @@ void drain_remote_pages(void)
 		if (zone->zone_pgdat->node_id == numa_node_id())
 			continue;
 
-		pset = zone->pageset[smp_processor_id()];
-		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &pset->pcp[i];
-			if (pcp->count)
-				pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+		local_irq_save(flags);
+		if (zone->zone_pgdat->node_id != numa_node_id()) {
+			pset = zone->pageset[smp_processor_id()];
+			if (pset->count)
+				pset->count -= free_pages_bulk(zone,
+						pset->count, &pset->list, 0);
+			pset->cold_count = min(pset->cold_count, pset->count);
 		}
+		local_irq_restore(flags);
 	}
-	local_irq_restore(flags);
 }
 #endif
 
@@ -563,21 +560,16 @@ static void __drain_pages(unsigned int c
 {
 	unsigned long flags;
 	struct zone *zone;
-	int i;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
 
 		pset = zone_pcp(zone, cpu);
-		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &pset->pcp[i];
-			local_irq_save(flags);
-			pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
-			local_irq_restore(flags);
-		}
+		local_irq_save(flags);
+		pset->count -= free_pages_bulk(zone, pset->count,
+							&pset->list, 0);
+		pset->cold_count = min(pset->cold_count, pset->count);
+		local_irq_restore(flags);
 	}
 }
 #endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
@@ -655,7 +647,8 @@ static void FASTCALL(free_hot_cold_page(
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
-	struct per_cpu_pages *pcp;
+	struct per_cpu_pageset *pset;
+	struct list_head *entry;
 	unsigned long flags;
 
 	arch_free_page(page, 0);
@@ -664,13 +657,21 @@ static void fastcall free_hot_cold_page(
 	if (PageAnon(page))
 		page->mapping = NULL;
 	free_pages_check(page);
-	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+	pset = zone_pcp(zone, get_cpu());
 	local_irq_save(flags);
 	page_state(pgfree)++;
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high)
-		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
+	pset->count++;
+	entry = &pset->list;
+	if (cold) {
+		pset->cold_count++;
+		entry = entry->prev; /* tail */
+	}
+	list_add(&page->lru, entry);
+	if (pset->count > pset->high) {
+		pset->count -= free_pages_bulk(zone, pset->batch,
+							&pset->list, 0);
+		pset->cold_count = min(pset->cold_count, pset->count);
+	}
 	local_irq_restore(flags);
 	put_cpu();
 }
@@ -708,19 +709,31 @@ buffered_rmqueue(struct zone *zone, int 
 	int cpu = get_cpu();
 
 	if (order == 0) {
-		struct per_cpu_pages *pcp;
+		struct per_cpu_pageset *pset;
+		struct list_head *entry;
 
-		pcp = &zone_pcp(zone, cpu)->pcp[cold];
+		pset = zone_pcp(zone, cpu);
 		local_irq_save(flags);
-		if (!pcp->count) {
-			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
-			if (unlikely(!pcp->count))
+		if (!pset->count || (cold && !pset->cold_count &&
+				pset->count <= pset->high - (pset->high>>2))) {
+			int count;
+			count = rmqueue_bulk(zone, 0,pset->batch, &pset->list);
+			if (unlikely(!count))
 				goto failed;
+			pset->count += count;
+			pset->cold_count += count;
 		}
-		page = list_entry(pcp->list.next, struct page, lru);
+
+		pset->count--;
+		entry = pset->list.next;
+		if (cold) {
+			if (pset->cold_count)
+				pset->cold_count--;
+			entry = pset->list.prev;
+		}
+		pset->cold_count = min(pset->cold_count, pset->count);
+		page = list_entry(entry, struct page, lru);
 		list_del(&page->lru);
-		pcp->count--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order);
@@ -1318,7 +1331,7 @@ void si_meminfo_node(struct sysinfo *val
 void show_free_areas(void)
 {
 	struct page_state ps;
-	int cpu, temperature;
+	int cpu;
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
@@ -1335,17 +1348,11 @@ void show_free_areas(void)
 			printk("\n");
 
 		for_each_cpu(cpu) {
-			struct per_cpu_pageset *pageset;
+			struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
 
-			pageset = zone_pcp(zone, cpu);
-
-			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: high %d, batch %d used:%d\n",
-					cpu,
-					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].high,
-					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+			printk("cpu %d: high %d, batch %d, pages %d, cold %d\n",
+				cpu, pset->high, pset->batch,
+				pset->count, pset->cold_count);
 		}
 	}
 
@@ -1774,21 +1781,12 @@ static int __devinit zone_batchsize(stru
 
 inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
 {
-	struct per_cpu_pages *pcp;
-
 	memset(p, 0, sizeof(*p));
-
-	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
-	pcp->high = 4 * batch;
-	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
-
-	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
-	pcp->high = 2 * batch;
-	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
+	p->count = 0;
+	p->cold_count = 0;
+	p->high = 6 * batch;
+	p->batch = max(1UL, 1 * batch);
+	INIT_LIST_HEAD(&p->list);
 }
 
 #ifdef CONFIG_NUMA
@@ -2168,27 +2166,15 @@ static int zoneinfo_show(struct seq_file
 			   ")"
 			   "\n  pagesets");
 		for (i = 0; i < ARRAY_SIZE(zone->pageset); i++) {
-			struct per_cpu_pageset *pageset;
-			int j;
+			struct per_cpu_pageset *pset;
 
-			pageset = zone_pcp(zone, i);
-			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				if (pageset->pcp[j].count)
-					break;
-			}
-			if (j == ARRAY_SIZE(pageset->pcp))
-				continue;
-			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				seq_printf(m,
-					   "\n    cpu: %i pcp: %i"
-					   "\n              count: %i"
-					   "\n              high:  %i"
-					   "\n              batch: %i",
-					   i, j,
-					   pageset->pcp[j].count,
-					   pageset->pcp[j].high,
-					   pageset->pcp[j].batch);
-			}
+			pset = zone_pcp(zone, i);
+			seq_printf(m,
+				   "\n    cpu: %i"
+				   "\n              count: %i"
+				   "\n              high:  %i"
+				   "\n              batch: %i",
+				   i, pset->count, pset->high, pset->batch);
 #ifdef CONFIG_NUMA
 			seq_printf(m,
 				   "\n            numa_hit:       %lu"
@@ -2197,12 +2183,12 @@ static int zoneinfo_show(struct seq_file
 				   "\n            interleave_hit: %lu"
 				   "\n            local_node:     %lu"
 				   "\n            other_node:     %lu",
-				   pageset->numa_hit,
-				   pageset->numa_miss,
-				   pageset->numa_foreign,
-				   pageset->interleave_hit,
-				   pageset->local_node,
-				   pageset->other_node);
+				   pset->numa_hit,
+				   pset->numa_miss,
+				   pset->numa_foreign,
+				   pset->interleave_hit,
+				   pset->local_node,
+				   pset->other_node);
 #endif
 		}
 		seq_printf(m,

--------------020701030601090007020406--
Send instant messages to your online friends http://au.messenger.yahoo.com 
