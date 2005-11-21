Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVKUPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVKUPLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVKUPLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:11:04 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:52389 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932325AbVKUPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:10:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=fuVZvdFaCveztdnA0CYyCXT3sQOzS+h71msRupYKG58RO+1+KJHpd+QY/MecIo2iR6EEnVF3BzkD4aWb/PHRIIKMMvwTwUyF+RA+vXhXOIv4wmdDXcGeB59gCo/mVbpc8nUe8vkaMvErtR09a2YFUUHizf+109dJgAh6WTJB1/0=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124025.14370.8515.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 3/12] mm: release opt
Date: Mon, 21 Nov 2005 10:10:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise some pagevec functions by not reenabling irqs while
switching lru locks.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -220,10 +220,13 @@ void release_pages(struct page **pages, 
 
 		pagezone = page_zone(page);
 		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+			spin_lock_prefetch(&pagezone->lru_lock);
+			if (!zone)
+				local_irq_disable();
+			else
+				spin_unlock(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock(&zone->lru_lock);
 		}
 		if (TestClearPageLRU(page))
 			del_page_from_lru(zone, page);
@@ -297,10 +300,12 @@ void __pagevec_lru_add(struct pagevec *p
 		struct zone *pagezone = page_zone(page);
 
 		if (pagezone != zone) {
+			if (!zone)
+				local_irq_disable();
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
@@ -324,10 +329,12 @@ void __pagevec_lru_add_active(struct pag
 		struct zone *pagezone = page_zone(page);
 
 		if (pagezone != zone) {
+			if (!zone)
+				local_irq_disable();
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
Send instant messages to your online friends http://au.messenger.yahoo.com 
