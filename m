Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVCYV42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVCYV42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVCYV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:56:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50913 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261832AbVCYVy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:54:56 -0500
Subject: [RFC][PATCH 4/4] Introduce new Kconfig option for NUMA or DISCONTIG
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 13:54:54 -0800
Message-Id: <E1DEwla-0006Xi-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is some confusion that arose when working on SPARSEMEM patch
between what is needed for DISCONTIG vs. NUMA.

Multiple pg_data_t's are needed for DISCONTIGMEM or NUMA,
independently.  All of the current NUMA implementations require an
implementation of DISCONTIG.  Because of this, quite a lot of code
which is really needed for NUMA is actually under DISCONTIG #ifdefs.
For SPARSEMEM, we changed some of these #ifdefs to CONFIG_NUMA, but
that broke the DISCONTIG=y and NUMA=n case.

Introducing this new NEED_MULTIPLE_NODES config option allows code
that is needed for both NUMA or DISCONTIG to be separated out from
code that is specific to DISCONTIG.

One great advantage of this approach is that it doesn't require
every architecture to be converted over.  All of the current
implementations should "just work", only the ones implementing
SPARSEMEM will have to be fixed up.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/mmzone.h |    6 +++---
 memhotplug-dave/mm/page_alloc.c        |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -puN include/linux/mmzone.h~B-sparse-140-separate-NUMA-DISCONTIG include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~B-sparse-140-separate-NUMA-DISCONTIG	2005-03-25 08:08:25.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-03-25 08:08:25.000000000 -0800
@@ -385,7 +385,7 @@ int lowmem_reserve_ratio_sysctl_handler(
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(_smp_processor_id()))
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 
 extern struct pglist_data contig_page_data;
 #define NODE_DATA(nid)		(&contig_page_data)
@@ -393,11 +393,11 @@ extern struct pglist_data contig_page_da
 #define MAX_NODES_SHIFT		1
 #define pfn_to_nid(pfn)		(0)
 
-#else /* CONFIG_DISCONTIGMEM */
+#else /* CONFIG_NEED_MULTIPLE_NODES */
 
 #include <asm/mmzone.h>
 
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
diff -puN mm/page_alloc.c~B-sparse-140-separate-NUMA-DISCONTIG mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B-sparse-140-separate-NUMA-DISCONTIG	2005-03-25 08:08:25.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-03-25 08:08:25.000000000 -0800
@@ -1765,18 +1765,18 @@ void __init free_area_init_node(int nid,
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 static bootmem_data_t contig_bootmem_data;
 struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
 
 EXPORT_SYMBOL(contig_page_data);
+#endif
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, &contig_page_data, zones_size,
+	free_area_init_node(0, NODE_DATA(0), zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
-#endif
 
 #ifdef CONFIG_PROC_FS
 
_
