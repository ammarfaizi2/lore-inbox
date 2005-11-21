Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVKUNHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVKUNHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVKUNHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:07:22 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:26702 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932293AbVKUNHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:07:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=WKjn4U5XeSkwHTN2uuRMHjA3KcEhvfU6Q5Gj/TpGsCk1gct8fom9ufAd4cNrKYoUUVws5DkSp761AgVKnCQkEBZASpBKLNJ91bgQwlje7+zESLokp3cfhA35a6bfi9RRgQe/ot1zUAcSSd2nLP6rb2DHkei7Gyk4dK10OkSvRpI=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124008.14370.97101.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 2/12] mm: pagealloc opt
Date: Mon, 21 Nov 2005 08:07:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly optimise some page allocation and freeing functions by
taking advantage of knowing whether or not interrupts are disabled.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -375,11 +375,10 @@ static int
 free_pages_bulk(struct zone *zone, int count,
 		struct list_head *list, unsigned int order)
 {
-	unsigned long flags;
 	struct page *page = NULL;
 	int ret = 0;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	spin_lock(&zone->lock);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
 	while (!list_empty(list) && count--) {
@@ -389,12 +388,13 @@ free_pages_bulk(struct zone *zone, int c
 		__free_pages_bulk(page, zone, order);
 		ret++;
 	}
-	spin_unlock_irqrestore(&zone->lock, flags);
+	spin_unlock(&zone->lock);
 	return ret;
 }
 
 void __free_pages_ok(struct page *page, unsigned int order)
 {
+	unsigned long flags;
 	LIST_HEAD(list);
 	int i;
 
@@ -412,7 +412,9 @@ void __free_pages_ok(struct page *page, 
 		free_pages_check(__FUNCTION__, page + i);
 	list_add(&page->lru, &list);
 	kernel_map_pages(page, 1<<order, 0);
+	local_irq_save(flags);
 	free_pages_bulk(page_zone(page), 1, &list, order);
+	local_irq_restore(flags);
 }
 
 
@@ -528,12 +530,11 @@ static struct page *__rmqueue(struct zon
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
 			unsigned long count, struct list_head *list)
 {
-	unsigned long flags;
 	int i;
 	int allocated = 0;
 	struct page *page;
 	
-	spin_lock_irqsave(&zone->lock, flags);
+	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
 		page = __rmqueue(zone, order);
 		if (page == NULL)
@@ -541,7 +542,7 @@ static int rmqueue_bulk(struct zone *zon
 		allocated++;
 		list_add_tail(&page->lru, list);
 	}
-	spin_unlock_irqrestore(&zone->lock, flags);
+	spin_unlock(&zone->lock);
 	return allocated;
 }
 
@@ -578,6 +579,7 @@ void drain_remote_pages(void)
 #if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
 static void __drain_pages(unsigned int cpu)
 {
+	unsigned long flags;
 	struct zone *zone;
 	int i;
 
@@ -589,8 +591,10 @@ static void __drain_pages(unsigned int c
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
+			local_irq_save(flags);
 			pcp->count -= free_pages_bulk(zone, pcp->count,
 						&pcp->list, 0);
+			local_irq_restore(flags);
 		}
 	}
 }
@@ -728,7 +732,7 @@ buffered_rmqueue(struct zone *zone, int 
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
-		if (pcp->count) {
+		if (likely(pcp->count)) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
 			pcp->count--;
Send instant messages to your online friends http://au.messenger.yahoo.com 
