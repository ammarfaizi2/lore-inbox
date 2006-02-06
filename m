Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWBFNia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWBFNia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWBFNiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:38:08 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50413 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932101AbWBFNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:38:05 -0500
Date: Mon, 06 Feb 2006 22:37:31 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
       naveen.b.s@intel.com, Andi Kleen <ak@suse.de>
Subject: [RFC:PATCH(003/003)] Memory add to onlined node.(For x86_64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.062
Message-Id: <20060206222347.060B.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for x86_64 to add memory which belongs onlined node.
This patch is just confirmed compile completion.
If there is no objection, I would like to test this.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: linux-2.6.15/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.15.orig/arch/x86_64/mm/init.c	2006-02-06 16:47:41.000000000 +0900
+++ linux-2.6.15/arch/x86_64/mm/init.c	2006-02-06 18:31:52.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/memory_hotplug.h>
+#include <linux/acpi.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -494,11 +495,20 @@
 
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


