Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272365AbTGYUsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272321AbTGYUr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:47:57 -0400
Received: from zok.SGI.COM ([204.94.215.101]:21183 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S272365AbTGYUpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:45:24 -0400
Date: Fri, 25 Jul 2003 14:00:29 -0700
To: linux-kernel@vger.kernel.org, akpm@digeo.com, mbligh@aracnet.com
Subject: [PATCH] fix alloc_bootmem_low_pages
Message-ID: <20030725210029.GA17016@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@digeo.com,
	mbligh@aracnet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is needed for some discontig boxes since the memory maps may
be built out-of-order.

Jesse

diff -Nru a/mm/bootmem.c b/mm/bootmem.c
--- a/mm/bootmem.c	Thu Jul 17 16:59:05 2003
+++ b/mm/bootmem.c	Thu Jul 17 16:59:05 2003
@@ -48,8 +48,24 @@
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
 
-	pgdat->pgdat_next = pgdat_list;
-	pgdat_list = pgdat;
+
+	/*
+	 * sort pgdat_list so that the lowest one comes first,
+	 * which makes alloc_bootmem_low_pages work as desired.
+	 */
+	if (!pgdat_list || pgdat_list->node_start_pfn > pgdat->node_start_pfn) {
+		pgdat->pgdat_next = pgdat_list;
+		pgdat_list = pgdat;
+	} else {
+		pg_data_t *tmp = pgdat_list;
+		while (tmp->pgdat_next) {
+			if (tmp->pgdat_next->node_start_pfn > pgdat->node_start_pfn)
+				break;
+			tmp = tmp->pgdat_next;
+		}
+		pgdat->pgdat_next = tmp->pgdat_next;
+		tmp->pgdat_next = pgdat;
+	}
 
 	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
