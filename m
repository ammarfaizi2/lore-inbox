Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWBIHHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWBIHHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 02:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422848AbWBIHHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 02:07:22 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29577 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422845AbWBIHHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 02:07:18 -0500
Date: Thu, 09 Feb 2006 16:06:37 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Brown, Len" <len.brown@intel.com>, naveen.b.s@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [RFC:PATCH(002/003)] Memory add to onlined node. (ver. 2) (For ia64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060209153743.6CF2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for ia64 to add memory which belongs onlined node.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: node_simple3/arch/ia64/mm/init.c
===================================================================
--- node_simple3.orig/arch/ia64/mm/init.c	2006-02-08 16:54:56.204707334 +0900
+++ node_simple3/arch/ia64/mm/init.c	2006-02-08 17:21:57.082617165 +0900
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
 #include <linux/bitops.h>
+#include <linux/acpi.h>
 
 #include <asm/a.out.h>
 #include <asm/dma.h>
@@ -652,9 +653,15 @@ int add_memory(u64 start, u64 size)
 	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
+	int ret, node;
 
-	pgdat = NODE_DATA(0);
+	node = acpi_paddr_to_node(start, size);
+
+	if (node >= 0 && node_online(node))
+		pgdat = NODE_DATA(node);
+	else
+		/* New node's memory will be added to Node 0 temporarll. */
+		pgdat = NODE_DATA(0);
 
 	zone = pgdat->node_zones + ZONE_NORMAL;
 	ret = __add_pages(zone, start_pfn, nr_pages);

-- 
Yasunori Goto 


