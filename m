Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUJHDdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUJHDdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUJHDdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:33:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:26828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267576AbUJHDcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:32:43 -0400
Date: Thu, 7 Oct 2004 20:30:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: chrisw@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007203048.298029ab.akpm@osdl.org>
In-Reply-To: <416605CC.2080204@cyberone.com.au>
References: <20041007142019.D2441@build.pdx.osdl.net>
	<20041007164044.23bac609.akpm@osdl.org>
	<4165E0A7.7080305@yahoo.com.au>
	<20041007174242.3dd6facd.akpm@osdl.org>
	<20041007184134.S2357@build.pdx.osdl.net>
	<20041007185131.T2357@build.pdx.osdl.net>
	<20041007185352.60e07b2f.akpm@osdl.org>
	<4165FF7B.1070302@cyberone.com.au>
	<20041007200109.57ce24ae.akpm@osdl.org>
	<416605CC.2080204@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >> Ah, free_pages <= pages_high, ie. 0 <= 0, which is true;
>  >> commence spinning.
>  >>
>  >
>  >Maybe.  It requires that the zonelists be screwy:
>  >
>  > Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
>  > protections[]: 0 0 0
>  > Node 1 Normal free:25272kB min:1020kB low:2040kB high:3060kB active:624172kB inactive:282700kB present:1047936kB
>  > protections[]: 0 0 0
>  > Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
>  > protections[]: 0 0 0
>  > Node 0 DMA free:728kB min:12kB low:24kB high:36kB active:788kB inactive:7848kB present:16384kB
>  > protections[]: 0 0 0
>  > Node 0 Normal free:27200kB min:1004kB low:2008kB high:3012kB active:332792kB inactive:422744kB present:1032188kB
>  > protections[]: 0 0 0
>  > Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
>  > protections[]: 0 0 0
>  >
>  >See that DMA zone on node 1?  Wonder how it got like that.  It
>  >should not be inside pgdat->nrzones anyway.
>  >
>  >
>  Oh? Why not? I didn't think empty zones were filtered out?

That ininitialised zone should be outside pgdat->nr_zones, no?

>  (perhaps they should be).

They will be.

Chris, do you have time to test this, against -linus?

diff -puN mm/vmscan.c~vmscan-handle-empty-zones mm/vmscan.c
--- 25/mm/vmscan.c~vmscan-handle-empty-zones	2004-10-07 19:10:52.844797784 -0700
+++ 25-akpm/mm/vmscan.c	2004-10-07 19:11:49.804138648 -0700
@@ -851,6 +851,9 @@ shrink_caches(struct zone **zones, struc
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
+		if (zone->present_pages == 0)
+			continue;
+
 		zone->temp_priority = sc->priority;
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
@@ -999,6 +1002,9 @@ static int balance_pgdat(pg_data_t *pgda
 			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 				struct zone *zone = pgdat->node_zones + i;
 
+				if (zone->present_pages == 0)
+					continue;
+
 				if (zone->all_unreclaimable &&
 						priority != DEF_PRIORITY)
 					continue;
@@ -1033,6 +1039,9 @@ static int balance_pgdat(pg_data_t *pgda
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
+			if (zone->present_pages == 0)
+				continue;
+
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
_

