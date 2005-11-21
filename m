Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVKULl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVKULl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVKULl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:41:59 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:58497 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932267AbVKULl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:41:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=tut1v53kKxtBfo+72Bvo7ONDvnIwK8PS3wrB2mUlxeQTNlOHamDq7XP2FDsfl/vqx1mfDxetXFg0Q1fj3DC4ZSWHmDxIP7A6OSRH1HOyxP4Hci4NFaWB7qMPOwexPb4doM6UG54zfn13U/aX7pl1J6wvPWV3zljoa3p2qbsdu/o=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124347.14370.69250.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 11/12] mm: page_alloc cleanups
Date: Mon, 21 Nov 2005 06:41:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanups that does not change generated code with the gcc's
I've tested with.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -438,8 +438,7 @@ void __free_pages_ok(struct page *page, 
  *
  * -- wli
  */
-static inline struct page *
-expand(struct zone *zone, struct page *page,
+static inline void expand(struct zone *zone, struct page *page,
  	int low, int high, struct free_area *area)
 {
 	unsigned long size = 1 << high;
@@ -453,7 +452,6 @@ expand(struct zone *zone, struct page *p
 		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
-	return page;
 }
 
 /*
@@ -505,7 +503,8 @@ static struct page *__rmqueue(struct zon
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, order, current_order, area);
+		expand(zone, page, order, current_order, area);
+		return page;
 	}
 
 	return NULL;
@@ -520,19 +519,16 @@ static int rmqueue_bulk(struct zone *zon
 			unsigned long count, struct list_head *list)
 {
 	int i;
-	int allocated = 0;
-	struct page *page;
 	
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
-		if (page == NULL)
+		struct page *page = __rmqueue(zone, order);
+		if (unlikely(page == NULL))
 			break;
-		allocated++;
 		list_add_tail(&page->lru, list);
 	}
 	spin_unlock(&zone->lock);
-	return allocated;
+	return i;
 }
 
 #ifdef CONFIG_NUMA
Send instant messages to your online friends http://au.messenger.yahoo.com 
