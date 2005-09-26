Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVIZUTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVIZUTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVIZUTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:19:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37584 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932505AbVIZUTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:19:34 -0400
Message-ID: <433857D1.3050903@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:19:29 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 10/9] percpu splitout
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080704080107060702020707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704080107060702020707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

NOT READY FOR MERGING!
Only works with NUMA off on 2.6.13.  On 2.6.13 with NUMA on free_hot_cold_page
calls __free_pages_bulk, which then trips BUG_ON(bad_range(zone,page));  This
does not happen on 2.6.13-rc1 kernels. Released under the release early
release often doctrine.

This patch splits the percpu allocations into two types.  Kernel reclaimable
and kernel non-reclaimable types are considered one PCPU_KERNEL type and user
types are PCPU_USER type.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>


--------------080704080107060702020707
Content-Type: text/plain;
 name="10_percpu_splitout"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10_percpu_splitout"

Index: 2.6.13-joel2/include/linux/mmzone.h
===================================================================
--- 2.6.13-joel2.orig/include/linux/mmzone.h	2005-09-26 13:58:59.%N -0500
+++ 2.6.13-joel2/include/linux/mmzone.h	2005-09-26 13:59:38.%N -0500
@@ -57,13 +57,28 @@ struct zone_padding {
 #else
 #define ZONE_PADDING(name)
 #endif
+/*
+ * The pcpu_list is to keep kernel and userrclm allocations
+ * apart while still allowing all allocation types to have
+ * per-cpu lists
+ */
+struct pcpu_list {
+	int count;
+	struct list_head list;
+} ____cacheline_aligned_in_smp;
+
+
+/* Indices into pcpu_list */
+#define PCPU_KERN 0
+#define PCPU_USER 1
+#define PCPU_LIST_SIZE 2
 
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
-	int low;		/* low watermark, refill needed */
-	int high;		/* high watermark, emptying needed */
-	int batch;		/* chunk size for buddy add/remove */
-	struct list_head list;	/* the list of pages */
+	int count;			/* number of pages in the list */
+	struct pcpu_list pcpu_list[PCPU_LIST_SIZE];
+	int low;			/* low watermark, refill needed */
+	int high;			/* high watermark, emptying needed */
+	int batch;			/* chunk size for buddy add/remove */
 };
 
 struct per_cpu_pageset {
Index: 2.6.13-joel2/mm/page_alloc.c
===================================================================
--- 2.6.13-joel2.orig/mm/page_alloc.c	2005-09-26 13:59:27.%N -0500
+++ 2.6.13-joel2/mm/page_alloc.c	2005-09-26 13:59:38.%N -0500
@@ -775,9 +775,18 @@ void drain_remote_pages(void)
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			if (pcp->count)
-				pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			if (pcp->pcpu_list[PCPU_KERN].count)
+				pcp->pcpu_list[PCPU_KERN].count -=
+					free_pages_bulk(zone,
+							pcp->pcpu_list[PCPU_KERN].count,
+							&pcp->pcpu_list[PCPU_KERN].list,
+							0);
+			if (pcp->pcpu_list[PCPU_USER].count)
+				pcp->pcpu_list[PCPU_USER].count -=
+					free_pages_bulk(zone,
+							pcp->pcpu_list[PCPU_USER].count,
+							&pcp->pcpu_list[PCPU_USER].list,
+							0);
 		}
 	}
 	local_irq_restore(flags);
@@ -798,8 +807,18 @@ static void __drain_pages(unsigned int c
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			pcp->count -= free_pages_bulk(zone, pcp->count,
-						&pcp->list, 0);
+			pcp->pcpu_list[PCPU_KERN].count -=
+				free_pages_bulk(zone,
+						pcp->pcpu_list[PCPU_KERN].count,
+						&pcp->pcpu_list[PCPU_KERN].list,
+						0);
+
+			pcp->pcpu_list[PCPU_USER].count -=
+				free_pages_bulk(zone,
+						pcp->pcpu_list[PCPU_USER].count,
+						&pcp->pcpu_list[PCPU_USER].list,
+						0);
+
 		}
 	}
 }
@@ -881,6 +900,7 @@ static void fastcall free_hot_cold_page(
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
+	struct pcpu_list *plist;
 
 	arch_free_page(page, 0);
 
@@ -890,11 +910,24 @@ static void fastcall free_hot_cold_page(
 		page->mapping = NULL;
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+
+	/*
+	 * Strictly speaking, we should not be accessing the zone information
+	 * here wihtout the zone lock. In this case, it does not matter if 
+	 * the read is incorrect.
+	 */
+	if (get_pageblock_type(zone, page) == RCLM_USER)
+		plist = &pcp->pcpu_list[PCPU_USER];
+	else
+		plist = &pcp->pcpu_list[PCPU_KERN];
+
+	if (plist->count >= pcp->high)
+		plist->count -= free_pages_bulk(zone, pcp->batch,
+						&plist->list, 0);
+
 	local_irq_save(flags);
-	list_add(&page->lru, &pcp->list);
-	pcp->count++;
-	if (pcp->count >= pcp->high)
-		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
+	list_add(&page->lru, &plist->list);
+	plist->count++;
 	local_irq_restore(flags);
 	put_cpu();
 }
@@ -930,19 +963,28 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	struct pcpu_list *plist;
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, pcp->batch,
-						   &pcp->list, alloctype);
-		if (pcp->count) {
-			page = list_entry(pcp->list.next, struct page, lru);
+
+		if (alloctype == __GFP_USER)
+			plist = &pcp->pcpu_list[PCPU_USER];
+		else
+			plist = &pcp->pcpu_list[PCPU_KERN];
+
+		if (plist->count <= pcp->low)
+			plist->count += rmqueue_bulk(zone,
+						     pcp->batch,
+						     &plist->list,
+						     alloctype);
+		if (plist->count) {
+			page = list_entry(plist->list.next, struct page, lru);
 			list_del(&page->lru);
-			pcp->count--;
+			plist->count--;
 		}
 		local_irq_restore(flags);
 		put_cpu();
@@ -2001,18 +2043,23 @@ inline void setup_pageset(struct per_cpu
 	struct per_cpu_pages *pcp;
 
 	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
+	pcp->pcpu_list[PCPU_KERN].count = 0;
+	pcp->pcpu_list[PCPU_USER].count = 0;
 	pcp->low = 2 * batch;
 	pcp->high = 6 * batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->pcpu_list[PCPU_KERN].list);
+	INIT_LIST_HEAD(&pcp->pcpu_list[PCPU_USER].list);
 
 	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
+	pcp->pcpu_list[PCPU_KERN].count = 0;
+	pcp->pcpu_list[PCPU_USER].count = 0;
 	pcp->low = 0;
 	pcp->high = 2 * batch;
 	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
+	INIT_LIST_HEAD(&pcp->pcpu_list[PCPU_KERN].list);
+	INIT_LIST_HEAD(&pcp->pcpu_list[PCPU_USER].list);
+
 }
 
 #ifdef CONFIG_NUMA

--------------080704080107060702020707--
