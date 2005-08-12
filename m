Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVHLOsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVHLOsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVHLOsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:48:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:64410 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750947AbVHLOrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:24 -0400
Subject: [RFC][PATCH 03/12] memory hotplug prep: zone wait table at runtime
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:21 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144721.3FC6AF04@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add an if() to the wait-table init code to allow runtime
allocations to call kmalloc() instead of using the
bootmem allocator

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 ./arch/sparc64/kernel/dtlb_base.S |    0 
 memhotplug-dave/mm/page_alloc.c   |   10 +++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff -puN mm/sparse.c~C2-kmalloc-zone_wait_table-at-runtime mm/sparse.c
diff -L mm/memory_hotplug.c -puN /dev/null /dev/null
diff -L drivers/base/memory.c -puN /dev/null /dev/null
diff -puN mm/page_alloc.c~C2-kmalloc-zone_wait_table-at-runtime mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~C2-kmalloc-zone_wait_table-at-runtime	2005-08-12 07:43:44.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-12 07:43:44.000000000 -0700
@@ -1854,6 +1854,7 @@ static __devinit
 void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
 	int i;
+	unsigned long size_bytes;
 
 	/*
 	 * The per-page waitqueue mechanism uses hashed waitqueues
@@ -1861,9 +1862,12 @@ void zone_wait_table_init(struct zone *z
 	 */
 	zone->wait_table_size = wait_table_size(zone_size_pages);
 	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
-	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_size
-					* sizeof(wait_queue_head_t));
+	size_bytes = zone->wait_table_size * sizeof(wait_queue_head_t);
+	if (system_state >= SYSTEM_RUNNING)
+		zone->wait_table = kmalloc(size_bytes, GFP_KERNEL);
+	else
+		zone->wait_table = alloc_bootmem_node(zone->zone_pgdat,
+						      size_bytes);
 
 	for(i = 0; i < zone->wait_table_size; ++i)
 		init_waitqueue_head(zone->wait_table + i);
diff -L serq -puN /dev/null /dev/null
diff -puN ./arch/sparc64/kernel/dtlb_base.S~C2-kmalloc-zone_wait_table-at-runtime ./arch/sparc64/kernel/dtlb_base.S
_
