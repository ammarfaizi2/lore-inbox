Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWEZEqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWEZEqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWEZEqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:46:40 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41440 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030427AbWEZEqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:46:40 -0400
Date: Fri, 26 May 2006 13:46:04 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch]Fix spanned_pages is not updated at a case of memory hot-add take 2..
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1148447148.8658.34.camel@localhost.localdomain>
References: <20060524100531.3468.Y-GOTO@jp.fujitsu.com> <1148447148.8658.34.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060526134039.EEA4.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I fixed redundant parentheses and tested this fix updating
spanned_pages patch.

Andrew-san.
Please apply.

------------------
If hot-added memory's address is smaller than old area,
spanned_pages will not be updated. It must be fixed.

example) Old zone_start_pfn = 0x60000, and spanned_pages = 0x10000
         Added new memory's start_pfn = 0x50000, and end_pfn = 0x60000

  new spanned_pages will be still 0x10000 by old code.
  (It should be updated to 0x20000.) Because old_zone_end_pfn will be
  0x70000, and end_pfn smaller than it. So, spanned_pages will not be
  updated.
  
In current code, spanned_pages is updated only when end_pfn is updated.
But, it should be updated by subtraction between bigger end_pfn and new
zone_start_pfn.

This is for 2.6.17-rc4-mm3.
I tested this patch on Tiger4 with my node emulation.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

 mm/memory_hotplug.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: pgdat15/mm/memory_hotplug.c
===================================================================
--- pgdat15.orig/mm/memory_hotplug.c	2006-05-25 12:22:54.000000000 +0900
+++ pgdat15/mm/memory_hotplug.c	2006-05-25 12:23:18.000000000 +0900
@@ -103,8 +103,8 @@ static void grow_zone_span(struct zone *
 	if (start_pfn < zone->zone_start_pfn)
 		zone->zone_start_pfn = start_pfn;
 
-	if (end_pfn > old_zone_end_pfn)
-		zone->spanned_pages = end_pfn - zone->zone_start_pfn;
+	zone->spanned_pages = max(old_zone_end_pfn, end_pfn) -
+				zone->zone_start_pfn;
 
 	zone_span_writeunlock(zone);
 }
@@ -118,8 +118,8 @@ static void grow_pgdat_span(struct pglis
 	if (start_pfn < pgdat->node_start_pfn)
 		pgdat->node_start_pfn = start_pfn;
 
-	if (end_pfn > old_pgdat_end_pfn)
-		pgdat->node_spanned_pages = end_pfn - pgdat->node_start_pfn;
+	pgdat->node_spanned_pages = max(old_pgdat_end_pfn, end_pfn) -
+					pgdat->node_start_pfn;
 }
 
 int online_pages(unsigned long pfn, unsigned long nr_pages)

-- 
Yasunori Goto 


