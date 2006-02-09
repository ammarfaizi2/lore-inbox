Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWBIHH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWBIHH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 02:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWBIHHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 02:07:49 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43913 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422847AbWBIHH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 02:07:27 -0500
Date: Thu, 09 Feb 2006 16:06:44 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
       naveen.b.s@intel.com, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [RFC:PATCH(003/003)] Memory add to onlined node. (ver. 2) (For x86_64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060209153803.6CF4.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for x86_64 to add memory which belongs onlined node.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: node_simple3/arch/x86_64/mm/init.c
===================================================================
--- node_simple3.orig/arch/x86_64/mm/init.c	2006-02-09 12:01:47.000000000 +0900
+++ node_simple3/arch/x86_64/mm/init.c	2006-02-09 14:09:11.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/memory_hotplug.h>
+#include <linux/acpi.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -494,11 +495,20 @@ void online_page(struct page *page)
 
 int add_memory(u64 start, u64 size)
 {
-	struct pglist_data *pgdat = NODE_DATA(0);
-	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
+	struct pglist_data *pgdat;
+	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
+	int ret, node;
+
+	node = acpi_paddr_to_node(start, size);
+	if (node >= 0 && node_online(node))
+		pgdat = NODE_DATA(node);
+	else
+		/* New node's memory will be added to Node 0 temporally. */
+		pgdat = NODE_DATA(0);
+
+	zone = pgdat->node_zones + MAX_NR_ZONES - 2;
 
 	ret = __add_pages(zone, start_pfn, nr_pages);
 	if (ret)

-- 
Yasunori Goto 


