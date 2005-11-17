Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbVKQA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbVKQA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbVKQA0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:26:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29911 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030581AbVKQA0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:26:15 -0500
Date: Wed, 16 Nov 2005 16:26:03 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, kiran@scalex86.org
Subject: [PATCH] preserve irq status in  release_pages(), __pagevec_lru_add()
 and __pagevec_lru_active()
Message-ID: <Pine.LNX.4.62.0511161622200.17573@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make release_pages(), __pagevec_lru_add() and __pagevec_lru_active() preserve irq status

The swap migration code calls drain_lru_pages() to be able to push pages off the
LRU in order to cleanly remove a page from the LRU. It uses smp_call_function()
for this purpose which uses IPIs to notify other processors. On IA64 IPIs are
processes with enabled interrupts. However, other architectures like 
x86_64, i386 and powerpc keep the interrupts disabled during IPI 
processing. One solution would be to verify that these platforms also 
allow the enabling of interrupts during IPIs but there is f.e. a plethora 
of methods to send IPIs under i386 that may make that endeavor difficult.

This patch makes the functions called in mm/swap.c preserve the interrupt
state so that it is safe to call drain_lru_pages() during IPI on all platforms.

The preservation of the interrupt state may allow the functions to be used in other
contexts in the future.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm2/mm/swap.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/swap.c	2005-11-15 10:29:53.000000000 -0800
+++ linux-2.6.14-mm2/mm/swap.c	2005-11-16 16:05:07.000000000 -0800
@@ -102,15 +102,16 @@ int rotate_reclaimable_page(struct page 
 void fastcall activate_page(struct page *page)
 {
 	struct zone *zone = page_zone(page);
+	unsigned long flags;
 
-	spin_lock_irq(&zone->lru_lock);
+	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(zone, page);
 		SetPageActive(page);
 		add_page_to_active_list(zone, page);
 		inc_page_state(pgactivate);
 	}
-	spin_unlock_irq(&zone->lru_lock);
+	spin_unlock_irqrestore(&zone->lru_lock, flags);
 }
 
 /*
@@ -209,6 +210,7 @@ void release_pages(struct page **pages, 
 	int i;
 	struct pagevec pages_to_free;
 	struct zone *zone = NULL;
+	unsigned long flags = 0;	/* GCC warning */
 
 	pagevec_init(&pages_to_free, cold);
 	for (i = 0; i < nr; i++) {
@@ -221,15 +223,15 @@ void release_pages(struct page **pages, 
 		pagezone = page_zone(page);
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock_irqrestore(&zone->lru_lock, flags);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock_irqsave(&zone->lru_lock, flags);
 		}
 		if (TestClearPageLRU(page))
 			del_page_from_lru(zone, page);
 		if (page_count(page) == 0) {
 			if (!pagevec_add(&pages_to_free, page)) {
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock_irqrestore(&zone->lru_lock, flags);
 				__pagevec_free(&pages_to_free);
 				pagevec_reinit(&pages_to_free);
 				zone = NULL;	/* No lock is held */
@@ -237,7 +239,7 @@ void release_pages(struct page **pages, 
 		}
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
 
 	pagevec_free(&pages_to_free);
 }
@@ -291,6 +293,7 @@ void __pagevec_lru_add(struct pagevec *p
 {
 	int i;
 	struct zone *zone = NULL;
+	unsigned long flags = 0;	/* GCC warning */
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
@@ -298,16 +301,16 @@ void __pagevec_lru_add(struct pagevec *p
 
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock_irqrestore(&zone->lru_lock, flags);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock_irqsave(&zone->lru_lock, flags);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
@@ -318,6 +321,7 @@ void __pagevec_lru_add_active(struct pag
 {
 	int i;
 	struct zone *zone = NULL;
+	unsigned long flags = 0;	/* GCC warning */
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
@@ -325,9 +329,9 @@ void __pagevec_lru_add_active(struct pag
 
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock_irqrestore(&zone->lru_lock, flags);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock_irqsave(&zone->lru_lock, flags);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
@@ -336,7 +340,7 @@ void __pagevec_lru_add_active(struct pag
 		add_page_to_active_list(zone, page);
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
