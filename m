Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUJIA07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUJIA07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUJIA06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:26:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:5569 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266274AbUJIA0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:26:55 -0400
Date: Fri, 8 Oct 2004 17:26:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
Message-ID: <20041008172651.F2441@build.pdx.osdl.net>
References: <41672D4A.4090200@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41672D4A.4090200@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Fri, Oct 08, 2004 at 06:14:02PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen (cfriesen@nortelnetworks.com) wrote:
> 
> I have an Xserve running 2.6.9-rc3 and patched to run the ppc kernel rather than 
> the ppc64 kernel.  It's configured with 2GB of memory, no swap.
> 
> If I run one instance of the following program, it allocates all but about 3MB 
> of memory, and the memory hog spins with 100% of the cpu.
> 
> If I run two instances of the program, the machine locks up, doesn't respond to 
> pings, and is basically dead to the world.
> 
> Shouldn't the oom-killer be kicking in?

Kicks in for me (albeit the world comes to a screeching halt for a few
moments before it kicks in).  I'm using this patch below from Andrew.
Does it help you?

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

