Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272286AbTHDXIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272289AbTHDXIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:08:25 -0400
Received: from rj.sgi.com ([192.82.208.96]:13803 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S272286AbTHDXIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:08:20 -0400
Date: Mon, 4 Aug 2003 16:08:15 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix free_all_bootmem_core for virtual memmap
Message-ID: <20030804230815.GA2551@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20030804230511.GA2478@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804230511.GA2478@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 04:05:11PM -0700, jbarnes wrote:
> Currently, free_all_bootmem_core() assumes that the bdata for a given
> node will begin where the node's memory map begins.  This isn't
> necessarily true on machines that use a virtual memory map (e.g. ia64
> discontig machines), so we fix page to point to the first actual page of
> RAM on the node, which _does_ contain the bdata struct.

Oops, fix a spelling error.

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
+	/* first extant page of the node */
+	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
 	for (i = 0; i < idx; ) {
