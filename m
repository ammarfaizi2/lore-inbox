Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVKFISE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVKFISE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVKFISE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:18:04 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:25265 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932293AbVKFISD (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:18:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=C3B/crl5TALrSu/hsIs5MdKE9yC6yhdwHP8Z5ABX/bDQJlssZ4CaHv4VKuCT8SDheBVyn60CSPZK6jwyAWyzQb4ql8AlFgfDs0EIfyG46YfbSNw8yliTlgbauv0ZGSxQrP2sS2jYaTUG8/r9fTmrfwL0pSO2oEOAqf8cL89SRyo=  ;
Message-ID: <436DBCBC.5000906@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:20:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 1/14] mm: opt rmqueue
References: <436DBAC3.7090902@yahoo.com.au>
In-Reply-To: <436DBAC3.7090902@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090904010002080101060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090904010002080101060307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/14

-- 
SUSE Labs, Novell Inc.


--------------090904010002080101060307
Content-Type: text/plain;
 name="mm-pagealloc-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-pagealloc-opt.patch"

Slightly optimise some page allocation and freeing functions by
taking advantage of knowing whether or not interrupts are disabled.

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -373,11 +373,10 @@ static int
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
@@ -387,12 +386,13 @@ free_pages_bulk(struct zone *zone, int c
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
 
@@ -410,7 +410,9 @@ void __free_pages_ok(struct page *page, 
 		free_pages_check(__FUNCTION__, page + i);
 	list_add(&page->lru, &list);
 	kernel_map_pages(page, 1<<order, 0);
+	local_irq_save(flags);
 	free_pages_bulk(page_zone(page), 1, &list, order);
+	local_irq_restore(flags);
 }
 
 
@@ -526,12 +528,11 @@ static struct page *__rmqueue(struct zon
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
@@ -539,7 +540,7 @@ static int rmqueue_bulk(struct zone *zon
 		allocated++;
 		list_add_tail(&page->lru, list);
 	}
-	spin_unlock_irqrestore(&zone->lock, flags);
+	spin_unlock(&zone->lock);
 	return allocated;
 }
 
@@ -576,6 +577,7 @@ void drain_remote_pages(void)
 #if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
 static void __drain_pages(unsigned int cpu)
 {
+	unsigned long flags;
 	struct zone *zone;
 	int i;
 
@@ -587,8 +589,10 @@ static void __drain_pages(unsigned int c
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
+			local_irq_save(flags);
 			pcp->count -= free_pages_bulk(zone, pcp->count,
 						&pcp->list, 0);
+			local_irq_restore(flags);
 		}
 	}
 }
@@ -726,16 +730,14 @@ buffered_rmqueue(struct zone *zone, int 
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
-		if (pcp->count) {
+		if (likely(pcp->count)) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
 			pcp->count--;
 		}
 		local_irq_restore(flags);
 		put_cpu();
-	}
-
-	if (page == NULL) {
+	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order);
 		spin_unlock_irqrestore(&zone->lock, flags);

--------------090904010002080101060307--
Send instant messages to your online friends http://au.messenger.yahoo.com 
