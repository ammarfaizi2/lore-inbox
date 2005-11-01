Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVKAFS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVKAFS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVKAFS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:18:56 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:40042 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965030AbVKAFSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:18:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=ur4ikEyggqSOPbYg+z121vL0FNxrXU+gEmLfufgWSGMQY5nqwy9UEUiL/7j/6zu+iBuFdOZBP0BVEkoxmZvE91ccBwZ/ir3ei1zgUNdUZbUSj8iTmttp6nNGgz/qS7gO9RM6XRHhg+YyvEIxDuhlnCPa/azoeuV8WsK+WbLxBYI=  ;
Message-ID: <4366FB24.5010507@yahoo.com.au>
Date: Tue, 01 Nov 2005 16:20:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] vm: highmem watermarks
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au>
In-Reply-To: <4366FAF5.8020908@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080700000002070900050002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700000002070900050002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/3

-- 
SUSE Labs, Novell Inc.


--------------080700000002070900050002
Content-Type: text/plain;
 name="vm-highmem-watermarks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-highmem-watermarks.patch"

The pages_high - pages_low and pages_low - pages_min deltas are the asynch
reclaim watermarks. As such, the should be in the same ratios as any other
zone for highmem zones. It is the pages_min - 0 delta which is the PF_MEMALLOC
reserve, and this is the region that isn't very useful for highmem.

This patch ensures highmem systems have similar characteristics as non highmem
ones with the same amount of memory, and also that highmem zones get similar
reclaim pressures to other zones.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2005-11-01 13:42:35.000000000 +1100
+++ linux-2.6/mm/page_alloc.c	2005-11-01 14:29:07.000000000 +1100
@@ -2374,13 +2374,18 @@ static void setup_per_zone_pages_min(voi
 	}
 
 	for_each_zone(zone) {
+		unsigned long tmp;
 		spin_lock_irqsave(&zone->lru_lock, flags);
+		tmp = (pages_min * zone->present_pages) / lowmem_pages;
 		if (is_highmem(zone)) {
 			/*
-			 * Often, highmem doesn't need to reserve any pages.
-			 * But the pages_min/low/high values are also used for
-			 * batching up page reclaim activity so we need a
-			 * decent value here.
+			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
+			 * need highmem pages, so cap pages_min to a small
+			 * value here.
+			 *
+			 * The (pages_high-pages_low) and (pages_low-pages_min)
+			 * deltas controls asynch page reclaim, and so should
+			 * not be capped for highmem.
 			 */
 			int min_pages;
 
@@ -2391,19 +2396,15 @@ static void setup_per_zone_pages_min(voi
 				min_pages = 128;
 			zone->pages_min = min_pages;
 		} else {
-			/* if it's a lowmem zone, reserve a number of pages
+			/*
+			 * If it's a lowmem zone, reserve a number of pages
 			 * proportionate to the zone's size.
 			 */
-			zone->pages_min = (pages_min * zone->present_pages) /
-			                   lowmem_pages;
+			zone->pages_min = tmp;
 		}
 
-		/*
-		 * When interpreting these watermarks, just keep in mind that:
-		 * zone->pages_min == (zone->pages_min * 4) / 4;
-		 */
-		zone->pages_low   = (zone->pages_min * 5) / 4;
-		zone->pages_high  = (zone->pages_min * 6) / 4;
+		zone->pages_low   = zone->pages_min + tmp / 4;
+		zone->pages_high  = zone->pages_min + tmp / 2;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 }

--------------080700000002070900050002--
Send instant messages to your online friends http://au.messenger.yahoo.com 
