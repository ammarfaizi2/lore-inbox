Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUJ0Ber@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUJ0Ber (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 21:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUJ0Ber
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 21:34:47 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:8379 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261557AbUJ0Be0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 21:34:26 -0400
Date: Wed, 27 Oct 2004 03:35:22 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027013522.GR14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <20041027005637.GP14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027005637.GP14325@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this _incremental_ 2/? patch should fix the longtanding kswapd issue
vs protection algorithm, now lowmem_reserve (partly hidden by the lack
of lowmem_reserve/protection or equivalent band-aid enabled in 2.6.9).

--- 2-kswapd-balance/include/linux/mmzone.h.~1~	2004-10-27 03:17:07.207812600 +0200
+++ 2-kswapd-balance/include/linux/mmzone.h	2004-10-27 03:26:22.673369000 +0200
@@ -273,7 +273,7 @@ void __get_zone_counts(unsigned long *ac
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
 void build_all_zonelists(void);
-void wakeup_kswapd(struct zone *zone);
+void wakeup_kswapd(struct zone *zone, int classzone_idx);
 
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
--- 2-kswapd-balance/mm/page_alloc.c.~1~	2004-10-27 03:17:07.215811384 +0200
+++ 2-kswapd-balance/mm/page_alloc.c	2004-10-27 03:24:31.351292528 +0200
@@ -641,7 +641,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
-		wakeup_kswapd(z);
+		wakeup_kswapd(z, classzone_idx);
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
--- 2-kswapd-balance/mm/vmscan.c.~1~	2004-10-27 03:14:22.563842288 +0200
+++ 2-kswapd-balance/mm/vmscan.c	2004-10-27 03:26:57.462080312 +0200
@@ -1169,11 +1169,11 @@ static int kswapd(void *p)
 /*
  * A zone is low on free memory, so wake its kswapd task to service it.
  */
-void wakeup_kswapd(struct zone *zone)
+void wakeup_kswapd(struct zone *zone, int classzone_idx)
 {
 	if (zone->present_pages == 0)
 		return;
-	if (zone->free_pages > zone->pages_low)
+	if (zone->free_pages > zone->pages_low + zone->lowmem_reserve[classzone_idx])
 		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
