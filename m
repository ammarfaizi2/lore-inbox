Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTDUWYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTDUWYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:24:38 -0400
Received: from [12.47.58.203] ([12.47.58.203]:48264 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262633AbTDUWYf (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 21 Apr 2003 18:24:35 -0400
Date: Mon, 21 Apr 2003 15:34:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@Vger.Kernel.ORG
Subject: Re: zone->nr_inactive race?
Message-Id: <20030421153449.69b494fc.akpm@digeo.com>
In-Reply-To: <16036.12627.477016.967042@laputa.namesys.com>
References: <16036.12627.477016.967042@laputa.namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2003 22:36:33.0765 (UTC) FILETIME=[7612A950:01C30856]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> This fragment of refill_inactive_zone() looks strange:
> 
> 		list_move(&page->lru, &zone->inactive_list);
> 		if (!pagevec_add(&pvec, page)) {
> 			spin_unlock_irq(&zone->lru_lock);
> 			if (buffer_heads_over_limit)
> 				pagevec_strip(&pvec);
> 			__pagevec_release(&pvec);
> 			spin_lock_irq(&zone->lru_lock);
> 		}
> 

Thanks, you're dead right.  That's buggy.

I am fairly surprised that you were able to hit this.  How are you doing
it?  On a 1G machine with a teeny ZONE_HIGHMEM??

I haven't tested this yet, but it should fix it up.


diff -puN mm/vmscan.c~nr_inactive-race-fix mm/vmscan.c
--- 25/mm/vmscan.c~nr_inactive-race-fix	Mon Apr 21 15:15:48 2003
+++ 25-akpm/mm/vmscan.c	Mon Apr 21 15:30:33 2003
@@ -557,6 +557,7 @@ static void
 refill_inactive_zone(struct zone *zone, const int nr_pages_in,
 			struct page_state *ps, int priority)
 {
+	int pgmoved;
 	int pgdeactivate = 0;
 	int nr_pages = nr_pages_in;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
@@ -570,6 +571,7 @@ refill_inactive_zone(struct zone *zone, 
 	long swap_tendency;
 
 	lru_add_drain();
+	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (nr_pages && !list_empty(&zone->active_list)) {
 		page = list_entry(zone->active_list.prev, struct page, lru);
@@ -584,9 +586,12 @@ refill_inactive_zone(struct zone *zone, 
 		} else {
 			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
+			pgmoved++;
 		}
 		nr_pages--;
 	}
+	zone->nr_active -= pgmoved;
+	zone->nr_inactive += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	/*
@@ -646,10 +651,10 @@ refill_inactive_zone(struct zone *zone, 
 			continue;
 		}
 		list_add(&page->lru, &l_inactive);
-		pgdeactivate++;
 	}
 
 	pagevec_init(&pvec, 1);
+	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = list_entry(l_inactive.prev, struct page, lru);
@@ -659,19 +664,27 @@ refill_inactive_zone(struct zone *zone, 
 		if (!TestClearPageActive(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
+		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
+			zone->nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
+			pgdeactivate += pgmoved;
+			pgmoved = 0;
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
+	zone->nr_inactive += pgmoved;
+	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
 		spin_lock_irq(&zone->lru_lock);
 	}
+
+	pgmoved = 0;
 	while (!list_empty(&l_active)) {
 		page = list_entry(l_active.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &l_active, flags);
@@ -679,14 +692,16 @@ refill_inactive_zone(struct zone *zone, 
 			BUG();
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &zone->active_list);
+		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
+			zone->nr_active += pgmoved;
+			pgmoved = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active -= pgdeactivate;
-	zone->nr_inactive += pgdeactivate;
+	zone->nr_active += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 

_

