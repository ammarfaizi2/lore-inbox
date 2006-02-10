Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWBJOVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWBJOVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWBJOVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:21:32 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32460 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751261AbWBJOV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:21:27 -0500
Date: Fri, 10 Feb 2006 23:20:54 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Subject: [RFC/PATCH: 003/010] Memory hotplug for new nodes with pgdat allocation. (pgdat alloc caller for ia64)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060210223859.C534.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is caller of pgdat allocation for ia64.
If new memory belongs to new nodes, pgdat is allocated...

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat2/arch/ia64/mm/init.c
===================================================================
--- pgdat2.orig/arch/ia64/mm/init.c	2006-02-10 17:03:43.000000000 +0900
+++ pgdat2/arch/ia64/mm/init.c	2006-02-10 17:29:30.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
 #include <linux/bitops.h>
+#include <linux/acpi.h>
 
 #include <asm/a.out.h>
 #include <asm/dma.h>
@@ -652,16 +653,32 @@ int add_memory(u64 start, u64 size)
 	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
+	int ret, node, new_pgdat = 0;
 
-	pgdat = NODE_DATA(0);
+	node = acpi_paddr_to_node(start, size);
+
+	if (node < 0)
+	        node = 0; /* pxm is undefined in DSDT.
+			     This might be non NUMA case */
+
+	if (!node_online(node)){
+		ret = new_pgdat_init(node, start_pfn, nr_pages);
+		if (ret)
+			return ret;
+
+		new_pgdat = 1;
+	}
+	pgdat = NODE_DATA(node);
 
 	zone = pgdat->node_zones + ZONE_NORMAL;
 	ret = __add_pages(zone, start_pfn, nr_pages);
 
-	if (ret)
+	if (ret){
 		printk("%s: Problem encountered in __add_pages() as ret=%d\n",
 		       __FUNCTION__,  ret);
+		if (new_pgdat)
+			release_pgdat(pgdat);
+	}
 
 	return ret;
 }

-- 
Yasunori Goto 


