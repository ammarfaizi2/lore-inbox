Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUJHCwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUJHCwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 22:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUJHCtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 22:49:14 -0400
Received: from mail-02.iinet.net.au ([203.59.3.34]:24286 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267445AbUJHCqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 22:46:30 -0400
Message-ID: <4165FF7B.1070302@cyberone.com.au>
Date: Fri, 08 Oct 2004 12:46:19 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chris Wright <chrisw@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
References: <20041007142019.D2441@build.pdx.osdl.net>	<20041007164044.23bac609.akpm@osdl.org>	<4165E0A7.7080305@yahoo.com.au>	<20041007174242.3dd6facd.akpm@osdl.org>	<20041007184134.S2357@build.pdx.osdl.net>	<20041007185131.T2357@build.pdx.osdl.net> <20041007185352.60e07b2f.akpm@osdl.org>
In-Reply-To: <20041007185352.60e07b2f.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030302050909060000020608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030302050909060000020608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Andrew Morton wrote:

>Chris Wright <chrisw@osdl.org> wrote:
>
>>(whereas I could get the mainline code, and the
>> one-liner to spin right off).  
>>
>
>How?  (up to and including .config please).
>
>
>

Ah, free_pages <= pages_high, ie. 0 <= 0, which is true;
commence spinning.

How's this go?



--------------030302050909060000020608
Content-Type: text/x-patch;
 name="vm-fix-empty-zones.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-fix-empty-zones.patch"



Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/mm/vmscan.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~vm-fix-empty-zones mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-fix-empty-zones	2004-10-08 12:44:14.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-10-08 12:44:48.000000000 +1000
@@ -1003,7 +1003,7 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
+				if (zone->free_pages < zone->pages_high) {
 					end_zone = i;
 					goto scan;
 				}
@@ -1035,7 +1035,7 @@ scan:
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
+				if (zone->free_pages < zone->pages_high)
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
@@ -1142,7 +1142,7 @@ static int kswapd(void *p)
  */
 void wakeup_kswapd(struct zone *zone)
 {
-	if (zone->free_pages > zone->pages_low)
+	if (zone->free_pages >= zone->pages_low)
 		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;

_

--------------030302050909060000020608--
