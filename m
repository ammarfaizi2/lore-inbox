Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUGPMNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUGPMNB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 08:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUGPMNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 08:13:01 -0400
Received: from zero.aec.at ([193.170.194.10]:49674 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266531AbUGPMM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 08:12:59 -0400
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, gone@us.ibm.com
Subject: [PATCH] Fix i386 bootup with HIGHMEM+SLAB_DEBUG+NUMA and no real
 highmem
From: Andi Kleen <ak@muc.de>
Date: Fri, 16 Jul 2004 14:11:22 +0200
Message-ID: <m3fz7s2lud.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reason I booted a NUMA and SLAB_DEBUG i386 kernel on a non
NUMA 512MB machine.  This caused an oops at bootup in change_page_attr.
The reason was that highmem_start_start page ended up zero and 
that triggered the highmem check in change_page_attr when the 
slab debug code would unmap a kernel mapping.

Fix is straightforward: if there is no highmem set highmem_start_page
to max_low_pfn+1

-Andi

diff -u linux-2.6.8rc1-work/arch/i386/mm/discontig.c-o linux-2.6.8rc1-work/arch/i386/mm/discontig.c
--- linux-2.6.8rc1-work/arch/i386/mm/discontig.c-o	2004-07-15 08:41:17.000000000 +0200
+++ linux-2.6.8rc1-work/arch/i386/mm/discontig.c	2004-07-16 12:21:37.000000000 +0200
@@ -448,7 +448,11 @@
 void __init set_max_mapnr_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-	highmem_start_page = NODE_DATA(0)->node_zones[ZONE_HIGHMEM].zone_mem_map;
+	struct zone *high0 = &NODE_DATA(0)->node_zones[ZONE_HIGHMEM];
+	if (high0->spanned_pages > 0)
+	      	highmem_start_page = high0->zone_mem_map;
+	else
+		highmem_start_page = pfn_to_page(max_low_pfn+1); 
 	num_physpages = highend_pfn;
 #else
 	num_physpages = max_low_pfn;


