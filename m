Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWDKMIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWDKMIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDKMIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:08:45 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:50103
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750792AbWDKMIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:08:44 -0400
Date: Tue, 11 Apr 2006 13:08:29 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 sparsemem does not need node_mem_map
Message-ID: <20060411120829.GA1394@shadowen.org>
References: <20060408031405.5e5131da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060408031405.5e5131da.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 sparsemem does not need node_mem_map

Seems we are trying to init the node_mem_map when we don't need to,
for example when SPARSEMEM is enabled.  This causes the error below
during compilation.  Use CONFIG_FLAT_NODE_MEM_MAP to gate allocation
and init.

  arch/x86_64/mm/numa.c: In function `setup_node_zones':
  arch/x86_64/mm/numa.c:191: error: structure has no member
                                                  named `node_mem_map'

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 numa.c |    2 ++
 1 files changed, 2 insertions(+)
diff -upN reference/arch/x86_64/mm/numa.c current/arch/x86_64/mm/numa.c
--- reference/arch/x86_64/mm/numa.c
+++ current/arch/x86_64/mm/numa.c
@@ -188,11 +188,13 @@ void __init setup_node_zones(int nodeid)
 	   memory. */
 	memmapsize = sizeof(struct page) * (end_pfn-start_pfn);
 	limit = end_pfn << PAGE_SHIFT;
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
 	NODE_DATA(nodeid)->node_mem_map = 
 		__alloc_bootmem_core(NODE_DATA(nodeid)->bdata, 
 				memmapsize, SMP_CACHE_BYTES, 
 				round_down(limit - memmapsize, PAGE_SIZE), 
 				limit);
+#endif
 
 	size_zones(zones, holes, start_pfn, end_pfn);
 	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
