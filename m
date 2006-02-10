Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWBJOYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWBJOYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWBJOVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:21:37 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32204 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751260AbWBJOV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:21:27 -0500
Date: Fri, 10 Feb 2006 23:21:02 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Subject: [RFC/PATCH: 004/010] Memory hotplug for new nodes with pgdat allocation. (pgdat alloc caller for x86_64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060210224257.C536.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is sample code of calling pgdat allocation function for x86_64.
Basically it is same with ia64. 

I've not tried this patch yet, due to I couldn't make emulation for
new node addtion for x86_64. This is just to reference. :-P

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat2/arch/x86_64/mm/init.c
===================================================================
--- pgdat2.orig/arch/x86_64/mm/init.c	2006-02-10 17:29:20.000000000 +0900
+++ pgdat2/arch/x86_64/mm/init.c	2006-02-10 17:30:42.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/memory_hotplug.h>
+#include <linux/acpi.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -494,11 +495,25 @@ void online_page(struct page *page)
 
 int add_memory(u64 start, u64 size)
 {
-	struct pglist_data *pgdat = NODE_DATA(0);
-	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
+	struct pglist_data *pgdat;
+	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
+	int ret, node, new_pgdat = 0;
+
+	node = acpi_paddr_to_node(start, size);
+
+	if (node < 0)
+		node = 0; /* pxm is undefined in DSDT.
+			     This might be non NUMA case */
+
+	if (!node_online(node)) {
+		ret = new_pgdat_init(node, start_pfn, nr_pages);
+		if (ret)
+			goto err;
+		new_pgdat = 1;
+	}
+
 
 	ret = __add_pages(zone, start_pfn, nr_pages);
 	if (ret)
@@ -509,6 +524,9 @@ int add_memory(u64 start, u64 size)
 	return ret;
 error:
 	printk("%s: Problem encountered in __add_pages!\n", __func__);
+	if (new_pgdat)
+		release_pgdat(ret);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(add_memory);

-- 
Yasunori Goto 


