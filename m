Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933181AbWFZWgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933181AbWFZWgB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933163AbWFZWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:32 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36767 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933123AbWFZWfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:15 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/20] [Suspend2] Generate free page bitmap.
Date: Tue, 27 Jun 2006 08:35:14 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223512.4050.21951.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generate a bitmap of pages that are free (including in pcp lists).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   53 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index e54865a..bf38334 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -169,3 +169,56 @@ static void display_stats(int always, in
 		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 1, buffer);
 }
 
+/* generate_free_page_map
+ *
+ * Description:	This routine generates a bitmap of free pages from the
+ * 		lists used by the memory manager. We then use the bitmap
+ * 		to quickly calculate which pages to save and in which
+ * 		pagesets.
+ */
+static void generate_free_page_map(void) 
+{
+	int i, order, loop, cpu;
+	struct page *page;
+	unsigned long flags;
+	struct zone *zone;
+	struct per_cpu_pageset *pset;
+
+	for_each_zone(zone) {
+		if (!zone->present_pages)
+			continue;
+		for(i=0; i < zone->spanned_pages; i++)
+			SetPageInUse(pfn_to_page(zone->zone_start_pfn + i));
+	}
+	
+	for_each_zone(zone) {
+		if (!zone->present_pages)
+			continue;
+		spin_lock_irqsave(&zone->lock, flags);
+		for (order = MAX_ORDER - 1; order >= 0; --order) {
+			list_for_each_entry(page, &zone->free_area[order].free_list, lru)
+				for(loop=0; loop < (1 << order); loop++)
+					ClearPageInUse(page+loop);
+		}
+
+		
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			if (!cpu_possible(cpu))
+				continue;
+
+			pset = zone_pcp(zone, cpu);
+
+			for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
+				struct per_cpu_pages *pcp;
+				struct page *page;
+
+				pcp = &pset->pcp[i];
+				list_for_each_entry(page, &pcp->list, lru)
+					ClearPageInUse(page);
+			}
+		}
+		
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
