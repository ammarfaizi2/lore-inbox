Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUKCQ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUKCQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUKCQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:26:42 -0500
Received: from fmr06.intel.com ([134.134.136.7]:25059 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261688AbUKCQ0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:26:33 -0500
Date: Wed, 3 Nov 2004 08:47:48 -0800
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200411031647.iA3GlmBm016951@snoqualmie.dp.intel.com>
To: ak@suse.de
Subject: [patch] remove direct mem_map refs for x86-64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

No real functional change here.  Just use the pfn_to_page
macros instead of directly indexing into the mem_map. 
Patch is against 2.6.10-rc1-mm2.  Please consider...

matt

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>

This removes all but one direct reference to mem_map
for x86-64.  This is needed on systems where we 
break the mem_map up and directly indexing into 
mem_map to get the page structure doesn't work anymore.


diff -urN linux-2.6.10-rc1-mm2-vanilla/arch/x86_64/mm/init.c linux-2.6.10-rc1-mm2/arch/x86_64/mm/init.c
--- linux-2.6.10-rc1-mm2-vanilla/arch/x86_64/mm/init.c	2004-11-03 06:40:21.501214144 -0500
+++ linux-2.6.10-rc1-mm2/arch/x86_64/mm/init.c	2004-11-03 06:20:34.000000000 -0500
@@ -68,8 +68,8 @@
 
 	for_each_pgdat(pgdat) {
                for (i = 0; i < pgdat->node_spanned_pages; ++i) {
-                       page = pgdat->node_mem_map + i;
-		total++;
+			page = pfn_to_page(pgdat->node_start_pfn + i);
+			total++;
                        if (PageReserved(page))
 			reserved++;
                        else if (PageSwapCache(page))
@@ -466,7 +466,7 @@
 		/*
 		 * Only count reserved RAM pages
 		 */
-		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
+		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
 			reservedpages++;
 #endif
 
