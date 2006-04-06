Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWDFBaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWDFBaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDFBaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:30:05 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:40630 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751101AbWDFBaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:30:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Respin: [PATCH] mm: limit lowmem_reserve
Date: Thu, 6 Apr 2006 11:29:41 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200604041235.59876.kernel@kolivas.org> <200604061110.35789.kernel@kolivas.org>
In-Reply-To: <200604061110.35789.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061129.41658.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Err zone needs to have some pages too sorry.

Respin
---
It is possible with a low enough lowmem_reserve ratio to make
zone_watermark_ok fail repeatedly if the lower_zone is small enough.
Impose a lower limit on the ratio to only allow 1/4 of the lower_zone
size to be set as lowmem_reserve. This limit is hit in ZONE_DMA by changing
the default vmsplit on i386 even without changing the default sysctl values.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/page_alloc.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc1-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/mm/page_alloc.c	2006-04-06 10:32:31.000000000 +1000
+++ linux-2.6.17-rc1-mm1/mm/page_alloc.c	2006-04-06 11:28:11.000000000 +1000
@@ -2566,14 +2566,32 @@ static void setup_per_zone_lowmem_reserv
 			zone->lowmem_reserve[j] = 0;
 
 			for (idx = j-1; idx >= 0; idx--) {
+				unsigned long max_reserve;
+				unsigned long reserve;
 				struct zone *lower_zone;
 
+				lower_zone = pgdat->node_zones + idx;
+				/*
+				 * Put an upper limit on the reserve at 1/4
+				 * the lower_zone size. This prevents large
+				 * zone size differences such as 3G VMSPLIT
+				 * or low sysctl values from making
+				 * zone_watermark_ok always fail. This
+				 * enforces a lower limit on the reserve_ratio
+				 */
+				max_reserve = lower_zone->present_pages / 4;
+
 				if (sysctl_lowmem_reserve_ratio[idx] < 1)
 					sysctl_lowmem_reserve_ratio[idx] = 1;
-
-				lower_zone = pgdat->node_zones + idx;
-				lower_zone->lowmem_reserve[j] = present_pages /
+				reserve = present_pages /
 					sysctl_lowmem_reserve_ratio[idx];
+				if (max_reserve && reserve > max_reserve) {
+					reserve = max_reserve;
+					sysctl_lowmem_reserve_ratio[idx] =
+						present_pages / max_reserve;
+				}
+
+				lower_zone->lowmem_reserve[j] = reserve;
 				present_pages += lower_zone->present_pages;
 			}
 		}
