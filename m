Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWBFNjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWBFNjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWBFNiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:38:06 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34475 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932092AbWBFNiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:38:00 -0500
Date: Mon, 06 Feb 2006 22:37:25 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Brown, Len" <len.brown@intel.com>, naveen.b.s@intel.com
Subject: [RFC:PATCH(002/003)] Memory add to onlined node.(For ia64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.062
Message-Id: <20060206222320.0609.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for ia64 to add memory which belongs onlined node.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: node_add2/arch/ia64/mm/init.c
===================================================================
--- node_add2.orig/arch/ia64/mm/init.c	2006-02-03 20:51:48.000000000 +0900
+++ node_add2/arch/ia64/mm/init.c	2006-02-03 21:39:21.000000000 +0900
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
+		/* New node's memory will be added to Node 0 temporally. */
+		pgdat = NODE_DATA(0);
 
 	zone = pgdat->node_zones + ZONE_NORMAL;
 	ret = __add_pages(zone, start_pfn, nr_pages);

-- 
Yasunori Goto 


