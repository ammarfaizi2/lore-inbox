Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSKLCQC>; Mon, 11 Nov 2002 21:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbSKLCQC>; Mon, 11 Nov 2002 21:16:02 -0500
Received: from holomorphy.com ([66.224.33.161]:45240 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266113AbSKLCQA>;
	Mon, 11 Nov 2002 21:16:00 -0500
To: linux-kernel@vger.kernel.org
Subject: [6/9] NUMA-Q: mem_map placement
Message-Id: <E18BQf6-00041I-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the allocation of the local memory maps (accomplished by passing
the virtual address of the virtual remapped arena) so that there is a gap
of size (sizeof(pg_data_t) + PAGE_SIZE - 1) & PAGE_MASK between
node_remap_start_vaddr[nid] and NODE_DATA(nid)->node_mem_map.

 discontig.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff -urpN 04_larger_remap/arch/i386/mm/discontig.c 05_memmap_after/arch/i386/mm/discontig.c
--- 04_larger_remap/arch/i386/mm/discontig.c	2002-11-11 16:33:57.000000000 -0800
+++ 05_memmap_after/arch/i386/mm/discontig.c	2002-11-11 16:37:14.000000000 -0800
@@ -318,13 +318,18 @@ void __init zone_sizes_init(void)
 		 * normal bootmem allocator, but other nodes come from the
 		 * remapped KVA area - mbligh
 		 */
-		if (nid)
-			free_area_init_node(nid, NODE_DATA(nid), 
-				node_remap_start_vaddr[nid], zones_size, 
-				start, 0);
-		else
+		if (!nid)
 			free_area_init_node(nid, NODE_DATA(nid), 0, 
 				zones_size, start, 0);
+		else {
+			unsigned long lmem_map;
+			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
+			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
+			lmem_map &= PAGE_MASK;
+			free_area_init_node(nid, NODE_DATA(nid), 
+				(struct page *)lmem_map, zones_size, 
+				start, 0);
+		}
 	}
 	return;
 }
