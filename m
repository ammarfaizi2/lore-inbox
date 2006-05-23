Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWEWIa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWEWIa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWEWIa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:30:27 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30104 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932115AbWEWIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:30:26 -0400
Date: Tue, 23 May 2006 17:29:32 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch]Fix spanned_pages is not updated at a case of memory hot-add.
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060523170830.97E1.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I found there is a bug in grow_zone_span() and grow_pgdat_span().

Please apply.

---------
If hot-added memory's address is smaller than old area,
spanned_pages will not be updated. It must be fixed.

example) Old zone_start_pfn = 0x60000, and spanned_pages = 0x10000
         Added new memory's start_pfn = 0x50000, and end_pfn = 0x60000

  new spanned_pages will be still 0x10000 by old code.
  (It should be updated to 0x20000.) Because old_zone_end_pfn will be
  0x70000, and end_pfn smaller than it. So, spanned_pages will not be
  updated.
  
In current code, spanned_pages is updated only when end_pfn is updated.
But, it should be updated even if end_pfn is not updated, because
start_pfn might be changed.

This is for 2.6.17-rc4-mm3.
I tested this patch on Tiger4 with my node emulation.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

------------------------------------------------

 mm/memory_hotplug.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

Index: pgdat15/mm/memory_hotplug.c
===================================================================
--- pgdat15.orig/mm/memory_hotplug.c	2006-05-23 14:58:21.000000000 +0900
+++ pgdat15/mm/memory_hotplug.c	2006-05-23 14:58:29.000000000 +0900
@@ -95,16 +95,18 @@ EXPORT_SYMBOL_GPL(__add_pages);
 static void grow_zone_span(struct zone *zone,
 		unsigned long start_pfn, unsigned long end_pfn)
 {
-	unsigned long old_zone_end_pfn;
+	unsigned long new_zone_end_pfn;
 
 	zone_span_writelock(zone);
 
-	old_zone_end_pfn = zone->zone_start_pfn + zone->spanned_pages;
+	new_zone_end_pfn = zone->zone_start_pfn + zone->spanned_pages;
 	if (start_pfn < zone->zone_start_pfn)
 		zone->zone_start_pfn = start_pfn;
 
-	if (end_pfn > old_zone_end_pfn)
-		zone->spanned_pages = end_pfn - zone->zone_start_pfn;
+	if (end_pfn > new_zone_end_pfn)
+		 new_zone_end_pfn = end_pfn;
+
+	zone->spanned_pages = new_zone_end_pfn - zone->zone_start_pfn;
 
 	zone_span_writeunlock(zone);
 }
@@ -112,14 +114,16 @@ static void grow_zone_span(struct zone *
 static void grow_pgdat_span(struct pglist_data *pgdat,
 		unsigned long start_pfn, unsigned long end_pfn)
 {
-	unsigned long old_pgdat_end_pfn =
+	unsigned long new_pgdat_end_pfn =
 		pgdat->node_start_pfn + pgdat->node_spanned_pages;
 
 	if (start_pfn < pgdat->node_start_pfn)
 		pgdat->node_start_pfn = start_pfn;
 
-	if (end_pfn > old_pgdat_end_pfn)
-		pgdat->node_spanned_pages = end_pfn - pgdat->node_start_pfn;
+	if (end_pfn > new_pgdat_end_pfn)
+		new_pgdat_end_pfn = end_pfn;
+
+	pgdat->node_spanned_pages = new_pgdat_end_pfn - pgdat->node_start_pfn;
 }
 
 int online_pages(unsigned long pfn, unsigned long nr_pages)

-- 
Yasunori Goto 


