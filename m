Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUCAKaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCAKaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:30:12 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:15561 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261179AbUCAKaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:30:00 -0500
Message-ID: <40431084.2060708@cyberone.com.au>
Date: Mon, 01 Mar 2004 21:29:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: mfedyk@matchmail.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc1-mm1: vm-kswapd-incremental-min (was Re: MM
 VM patches was: 2.6.3-mm4)
References: <20040225185536.57b56716.akpm@osdl.org>	<4042F38B.8020307@matchmail.com>	<4042F7E6.1050904@cyberone.com.au>	<4042FE0D.5030603@cyberone.com.au>	<404307D7.8090102@cyberone.com.au> <20040301021855.0c0f994e.akpm@osdl.org>
In-Reply-To: <20040301021855.0c0f994e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060508050209070100070008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508050209070100070008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>Andrew, I think you had kswapd scanning in the direction opposite the
>> one indicated by your comments. Or maybe I've just confused myself?
>>
>>
>
>Nope, the node_zones[] array is indexed by
>
>

OK. Mike, could you try this patch instead after testing rc1-mm1.
Thanks.


--------------060508050209070100070008
Content-Type: text/plain;
 name="vm-kswapd-incremental-min.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-kswapd-incremental-min.patch"

 linux-2.6-npiggin/mm/vmscan.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff -puN mm/vmscan.c~vm-kswapd-incremental-min mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-kswapd-incremental-min	2004-03-01 20:29:18.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-03-01 21:27:24.000000000 +1100
@@ -889,6 +889,8 @@ out:
 	return ret;
 }
 
+extern int sysctl_lower_zone_protection;
+
 /*
  * For kswapd, balance_pgdat() will work across all this node's zones until
  * they are all at pages_high.
@@ -907,12 +909,9 @@ out:
  * dead and from now on, only perform a short scan.  Basically we're polling
  * the zone for when the problem goes away.
  *
- * kswapd scans the zones in the highmem->normal->dma direction.  It skips
- * zones which have free_pages > pages_high, but once a zone is found to have
- * free_pages <= pages_high, we scan that zone and the lower zones regardless
- * of the number of free pages in the lower zones.  This interoperates with
- * the page allocator fallback scheme to ensure that aging of pages is balanced
- * across the zones.
+ * balance_pgdat tries to coexist with the INFAMOUS "incremental min" by
+ * trying to free lower zones a bit harder if higher zones are low too.
+ * See mm/page_alloc.c
  */
 static int balance_pgdat(pg_data_t *pgdat, int nr_pages, struct page_state *ps)
 {
@@ -930,8 +929,10 @@ static int balance_pgdat(pg_data_t *pgda
 	}
 
 	for (priority = DEF_PRIORITY; priority; priority--) {
+		unsigned long min;
 		int all_zones_ok = 1;
 		int pages_scanned = 0;
+		min = 0; /* Shut up gcc */
 
 		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 			struct zone *zone = pgdat->node_zones + i;
@@ -939,15 +940,26 @@ static int balance_pgdat(pg_data_t *pgda
 			int max_scan;
 			int reclaimed;
 
-			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
-				continue;
-
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
-					all_zones_ok = 0;
+				/* "incremental min" right here */
 				if (all_zones_ok)
+					min = zone->pages_high;
+				else
+					min += zone->pages_high;
+
+				if (zone->free_pages <= min)
+					all_zones_ok = 0;
+				else
 					continue;
+
+				min += zone->pages_high *
+						sysctl_lower_zone_protection;
 			}
+
+			/* Note: this is checked *after* min is incremented */
+			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
+				continue;
+
 			zone->temp_priority = priority;
 			max_scan = zone->nr_inactive >> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,

_

--------------060508050209070100070008--
