Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272274AbTHDXF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272284AbTHDXFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:05:25 -0400
Received: from zok.sgi.com ([204.94.215.101]:37056 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S272274AbTHDXFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:05:19 -0400
Date: Mon, 4 Aug 2003 16:05:11 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix free_all_bootmem_core for virtual memmap
Message-ID: <20030804230511.GA2478@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, free_all_bootmem_core() assumes that the bdata for a given
node will begin where the node's memory map begins.  This isn't
necessarily true on machines that use a virtual memory map (e.g. ia64
discontig machines), so we fix page to point to the first actual page of
RAM on the node, which _does_ contain the bdata struct.

Thanks,
Jesse


===== mm/bootmem.c 1.20 vs edited =====
--- 1.20/mm/bootmem.c	Fri Aug  1 03:01:02 2003
+++ edited/mm/bootmem.c	Mon Aug  4 16:01:22 2003
@@ -267,7 +267,7 @@
 
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
-	struct page *page = pgdat->node_mem_map;
+	struct page *page;
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
@@ -276,6 +276,8 @@
 	if (!bdata->node_bootmem_map) BUG();
 
 	count = 0;
+	/* first existant page of the node */
+	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
 	for (i = 0; i < idx; ) {
