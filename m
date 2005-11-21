Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVKUMA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVKUMA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVKUMA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:00:58 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:42164 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932274AbVKUMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:00:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=SRb5L+RZoyrdCeqEc39RvW/pzCjKXbg3hZGLwX5nwozABuNYV6ZVrSOGik9nk6DzMzGLlNsvjGcJ2bSfXDIcHW8VF3DJUHkwxNore+DmtWFGfd/MSsTYz1zv+RNS/uWc3IuWVEp29B3PDZpQA2azLKIz7Sszg2EQuf6yOYGdbQc=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124212.14370.53831.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 8/12] mm: remove pcp low
Date: Mon, 21 Nov 2005 07:00:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

struct per_cpu_pages.low is useless. Remove it.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -46,7 +46,6 @@ struct zone_padding {
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
-	int low;		/* low watermark, refill needed */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
 	struct list_head list;	/* the list of pages */
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -719,7 +719,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
+		if (!pcp->count)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 		if (likely(pcp->count)) {
@@ -1314,10 +1314,9 @@ void show_free_areas(void)
 			pageset = zone_pcp(zone, cpu);
 
 			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: low %d, high %d, batch %d used:%d\n",
+				printk("cpu %d %s: high %d, batch %d used:%d\n",
 					cpu,
 					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
 					pageset->pcp[temperature].count);
@@ -1761,14 +1760,12 @@ inline void setup_pageset(struct per_cpu
 
 	pcp = &p->pcp[0];		/* hot */
 	pcp->count = 0;
-	pcp->low = 0;
 	pcp->high = 6 * batch;
 	pcp->batch = max(1UL, 1 * batch);
 	INIT_LIST_HEAD(&pcp->list);
 
 	pcp = &p->pcp[1];		/* cold*/
 	pcp->count = 0;
-	pcp->low = 0;
 	pcp->high = 2 * batch;
 	pcp->batch = max(1UL, batch/2);
 	INIT_LIST_HEAD(&pcp->list);
@@ -2164,12 +2161,10 @@ static int zoneinfo_show(struct seq_file
 				seq_printf(m,
 					   "\n    cpu: %i pcp: %i"
 					   "\n              count: %i"
-					   "\n              low:   %i"
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
 					   pageset->pcp[j].count,
-					   pageset->pcp[j].low,
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
 			}
Send instant messages to your online friends http://au.messenger.yahoo.com 
