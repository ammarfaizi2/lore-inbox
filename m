Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVDDR5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVDDR5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDDRyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:54:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:725 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261311AbVDDRu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:50:27 -0400
Subject: [PATCH 4/4] Introduce new Kconfig option for NUMA or DISCONTIG
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 04 Apr 2005 10:50:20 -0700
Message-Id: <E1DIViP-0006dF-00@kernel.beaverton.ibm.com>
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

The change to free_area_init() makes it work inside, or out of the
new config option.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/mmzone.h |    6 +++---
 memhotplug-dave/mm/Kconfig             |    8 ++++++++
 memhotplug-dave/mm/page_alloc.c        |    6 +++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff -puN include/linux/mmzone.h~A9-separate-NUMA-DISCONTIG include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~A9-separate-NUMA-DISCONTIG	2005-04-04 10:15:39.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-04-04 10:15:39.000000000 -0700
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
diff -puN mm/page_alloc.c~A9-separate-NUMA-DISCONTIG mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~A9-separate-NUMA-DISCONTIG	2005-04-04 10:15:39.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-04-04 10:15:39.000000000 -0700
@@ -1768,18 +1768,18 @@ void __init free_area_init_node(int nid,
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
 
diff -puN mm/Kconfig~A9-separate-NUMA-DISCONTIG mm/Kconfig
--- memhotplug/mm/Kconfig~A9-separate-NUMA-DISCONTIG	2005-04-04 10:15:39.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-04-04 10:15:39.000000000 -0700
@@ -23,3 +23,11 @@ config DISCONTIGMEM
 
 endchoice
 
+#
+# Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
+# to represent different areas of memory.  This variable allows
+# those dependencies to exist individually.
+#
+config NEED_MULTIPLE_NODES
+	def_bool y
+	depends on DISCONTIGMEM || NUMA
_
