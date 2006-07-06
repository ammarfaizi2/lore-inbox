Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWGFJvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWGFJvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWGFJvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:51:09 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:25010 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1030196AbWGFJvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:51:08 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       vagabon.xyz@gmail.com
Message-Id: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
Date: Thu,  6 Jul 2006 10:51:03 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The FLATMEM memory model assumes that memory is one contiguous region based
at PFN 0 and uses the NODE_DATA(0)->node_mem_map as the global mem_map. As
NODE_DATA(0)->node_mem_map may not be PFN 0, architectures optionally define
ARCH_PFN_OFFSET as the offset between NODE_DATA(0)->node_mem_map and PFN 0.
This offset is used every time page_to_pfn() or pfn_to_page() is called
resulting in a small amount of code bloat and overhead.

This patch changes ARCH_PFN_OFFSET so that it is used only once during
memory initialisation when working out where mem_map is. This gives
a very small reduction in zImage size for architectures using
ARCH_PFN_OFFSET. The patch also adds a small amount of documentation
on what ARCH_PFN_OFFSET is for.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

 include/asm-generic/memory_model.h |    5 ++---
 mm/page_alloc.c                    |    8 ++++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/include/asm-generic/memory_model.h linux-2.6.17-mm6-archpfnoffset_optimise/include/asm-generic/memory_model.h
--- linux-2.6.17-mm6-clean/include/asm-generic/memory_model.h	2006-07-05 14:31:17.000000000 +0100
+++ linux-2.6.17-mm6-archpfnoffset_optimise/include/asm-generic/memory_model.h	2006-07-05 14:36:04.000000000 +0100
@@ -28,9 +28,8 @@
  */
 #if defined(CONFIG_FLATMEM)
 
-#define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
-#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
-				 ARCH_PFN_OFFSET)
+#define __pfn_to_page(pfn)	(mem_map + (pfn))
+#define __page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #elif defined(CONFIG_DISCONTIGMEM)
 
 #define __pfn_to_page(pfn)			\
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/mm/page_alloc.c linux-2.6.17-mm6-archpfnoffset_optimise/mm/page_alloc.c
--- linux-2.6.17-mm6-clean/mm/page_alloc.c	2006-07-05 14:31:18.000000000 +0100
+++ linux-2.6.17-mm6-archpfnoffset_optimise/mm/page_alloc.c	2006-07-05 17:01:01.000000000 +0100
@@ -2157,10 +2157,14 @@ static void __init alloc_node_mem_map(st
 	}
 #ifdef CONFIG_FLATMEM
 	/*
-	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 * With FLATMEM, the global mem_map is just set as node 0's. The
+	 * FLATMEM memory model assumes that memory is in one contiguous area
+	 * starting at PFN 0. Architectures that do not start NODE 0 at PFN 0
+	 * must define ARCH_PFN_OFFSET as the offset between
+	 * NODE_DATA(0)->node_mem_map and PFN 0.
 	 */
 	if (pgdat == NODE_DATA(0))
-		mem_map = NODE_DATA(0)->node_mem_map;
+		mem_map = NODE_DATA(0)->node_mem_map - ARCH_PFN_OFFSET;
 #endif
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
 
