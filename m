Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUJHEs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUJHEs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 00:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUJHEs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 00:48:58 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:50360 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267638AbUJHEsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 00:48:54 -0400
Message-ID: <41661C30.6070102@yahoo.com.au>
Date: Fri, 08 Oct 2004 14:48:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
References: <20041007142019.D2441@build.pdx.osdl.net>	<20041007164044.23bac609.akpm@osdl.org>	<4165E0A7.7080305@yahoo.com.au>	<20041007174242.3dd6facd.akpm@osdl.org>	<20041007184134.S2357@build.pdx.osdl.net>	<20041007185131.T2357@build.pdx.osdl.net>	<20041007185352.60e07b2f.akpm@osdl.org>	<4165FF7B.1070302@cyberone.com.au>	<20041007200109.57ce24ae.akpm@osdl.org>	<416605CC.2080204@cyberone.com.au> <20041007203048.298029ab.akpm@osdl.org> <41660F64.3090802@cyberone.com.au>
In-Reply-To: <41660F64.3090802@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------070106000206030001040605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106000206030001040605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> 
> I think my patch would be sufficient to handle the kswapd side
> (yours would be valid too, but no need to add the extra checks).

Here is the combined patch with Andrew's hunk added.

I guess it doesn't _really_ matter which gets tested, but this
one is probably the preferred way to go because it doesn't even
wake up kswapd for empty zones. Andrew, do you agree?

I guess it should get into -bk pretty soon if it passes testing.
It is fairly easy to see the failure cases that are fixed (and
hopefully it doesn't domino yet another latent bug :P).

--------------070106000206030001040605
Content-Type: text/x-patch;
 name="vm-fix-empty-zones.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-fix-empty-zones.patch"



Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/mm/vmscan.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~vm-fix-empty-zones mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-fix-empty-zones	2004-10-08 12:44:14.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-10-08 14:28:04.000000000 +1000
@@ -851,6 +851,9 @@ shrink_caches(struct zone **zones, struc
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
+		if (zone->present_pages == 0)
+			continue;
+
 		zone->temp_priority = sc->priority;
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
@@ -1003,7 +1006,7 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
+				if (zone->free_pages < zone->pages_high) {
 					end_zone = i;
 					goto scan;
 				}
@@ -1035,7 +1038,7 @@ scan:
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
+				if (zone->free_pages < zone->pages_high)
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
@@ -1142,7 +1145,7 @@ static int kswapd(void *p)
  */
 void wakeup_kswapd(struct zone *zone)
 {
-	if (zone->free_pages > zone->pages_low)
+	if (zone->free_pages >= zone->pages_low)
 		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;

_

--------------070106000206030001040605--
