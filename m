Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUEaKKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUEaKKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 06:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEaKKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 06:10:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:42143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbUEaKKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 06:10:14 -0400
Date: Mon, 31 May 2004 03:09:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: ncunningham@linuxmail.org, cef-lkml@optusnet.com.au,
       linux-kernel@vger.kernel.org, rob@landley.net, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-Id: <20040531030914.0e20d2e0.akpm@osdl.org>
In-Reply-To: <20040529222308.GA1535@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net>
	<20040528215642.GA927@elf.ucw.cz>
	<200405291905.20925.cef-lkml@optusnet.com.au>
	<40B85024.2040505@linuxmail.org>
	<20040529222308.GA1535@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Right solution is to make sure that shrink_all_memory() works, no
>  matter how swappiness is set.

off-by-one in balance_pgdat() was the main problem.


--- 25/mm/vmscan.c~shrink_all_memory-fix	2004-05-31 03:04:05.669374824 -0700
+++ 25-akpm/mm/vmscan.c	2004-05-31 03:04:05.673374216 -0700
@@ -813,8 +813,7 @@ shrink_caches(struct zone **zones, int p
 		struct zone *zone = zones[i];
 		int max_scan;
 
-		if (zone->free_pages < zone->pages_high)
-			zone->temp_priority = priority;
+		zone->temp_priority = priority;
 
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
@@ -945,7 +944,7 @@ static int balance_pgdat(pg_data_t *pgda
 		zone->temp_priority = DEF_PRIORITY;
 	}
 
-	for (priority = DEF_PRIORITY; priority; priority--) {
+	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 
@@ -995,6 +994,8 @@ scan:
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
+			if (zone->prev_priority > priority)
+				zone->prev_priority = priority;
 			max_scan = (zone->nr_active + zone->nr_inactive)
 								>> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,
_

