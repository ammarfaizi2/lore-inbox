Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWBQN3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWBQN3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWBQN3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:29:38 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:32985 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964843AbWBQN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:29:30 -0500
Date: Fri, 17 Feb 2006 22:29:02 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 005/012] Memory hotplug for new nodes v.2.(pgdat alloc caller for x86-64)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217211729.4072.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is code for calling pgdat allocation function for x86_64.
Basically it is same with ia64. 

But, decision of ZONE_DMA32 or ZONE_NORMAL is necessary.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: linux-2.6.15/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.15.orig/arch/x86_64/mm/init.c	2006-02-16 20:21:29.000000000 +0900
+++ linux-2.6.15/arch/x86_64/mm/init.c	2006-02-16 21:34:29.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/memory_hotplug.h>
+#include <linux/acpi.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -494,12 +495,27 @@
 
 int add_memory(u64 start, u64 size)
 {
-	struct pglist_data *pgdat = NODE_DATA(0);
-	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
+	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
+	int ret, node, zone_type, new_pgdat = 0;
 
+	node = acpi_paddr_to_node(start, size);
+
+	if (node < 0)
+		node = 0; /* pxm is undefined in DSDT.
+			     This might be non NUMA case */
+
+	if (!node_online(node)) {
+		ret = new_pgdat_init(node, start_pfn, nr_pages);
+		if (ret)
+			goto error;
+		new_pgdat = 1;
+	}
+
+	zone_type = start_pfn < MAX_DMA32_PFN ?
+		    ZONE_DMA32 : ZONE_NORMAL;
+	zone = NODE_DATA(node)->node_zones + zone_type;
 	ret = __add_pages(zone, start_pfn, nr_pages);
 	if (ret)
 		goto error;
@@ -509,6 +525,9 @@
 	return ret;
 error:
 	printk("%s: Problem encountered in __add_pages!\n", __func__);
+	if (new_pgdat)
+		release_pgdat(NODE_DATA(node));
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(add_memory);

-- 
Yasunori Goto 


