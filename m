Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWHDNPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWHDNPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWHDNOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:14:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16087 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030329AbWHDNOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:14:19 -0400
Date: Fri, 4 Aug 2006 07:14:15 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131415.21401.20437.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 5/10] hot-add-mem x86_64: memory_add_physaddr_to_nid enable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

  The api for hot-add memory already has a construct for finding nodes based on
an address, memory_add_physaddr_to_nid.  This patch allows the fucntion to do 
something besides return 0.  It uses the nodes_add infomation to lookup to node 
info for a hot add event. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 init.c |   20 +++++++-------------
 srat.c |   13 ++++++++++++-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff -urN linux-2.6.17/arch/x86_64/mm/init.c current/arch/x86_64/mm/init.c
--- linux-2.6.17/arch/x86_64/mm/init.c	2006-08-04 01:30:39.000000000 -0400
+++ current/arch/x86_64/mm/init.c	2006-08-04 01:24:04.000000000 -0400
@@ -517,19 +517,6 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
- * XXX: memory_add_physaddr_to_nid() is to find node id from physical address
- *	via probe interface of sysfs. If acpi notifies hot-add event, then it
- *	can tell node id by searching dsdt. But, probe interface doesn't have
- *	node id. So, return 0 as node id at this time.
- */
-#ifdef CONFIG_NUMA
-int memory_add_physaddr_to_nid(u64 start)
-{
-	return 0;
-}
-#endif
-
-/*
  * Memory is added always to NORMAL zone. This means you will never get
  * additional DMA/DMA32 memory.
  */
@@ -560,6 +547,13 @@
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 
+#ifndef CONFIG_ACPI_NUMA
+int memory_add_physaddr_to_nid(u64 start)
+{
+	return 0;
+}
+#endif 
+
 #else /* CONFIG_MEMORY_HOTPLUG */
 /*
  * Memory Hotadd without sparsemem. The mem_maps have been allocated in advance,
diff -urN linux-2.6.17/arch/x86_64/mm/srat.c current/arch/x86_64/mm/srat.c
--- linux-2.6.17/arch/x86_64/mm/srat.c	2006-08-04 01:31:44.000000000 -0400
+++ current/arch/x86_64/mm/srat.c	2006-08-04 01:24:04.000000000 -0400
@@ -25,7 +25,7 @@
 
 static nodemask_t nodes_parsed __initdata;
 static struct bootnode nodes[MAX_NUMNODES] __initdata;
-static struct bootnode nodes_add[MAX_NUMNODES] __initdata;
+static struct bootnode nodes_add[MAX_NUMNODES];
 static int found_add_area __initdata;
 int hotadd_percent __initdata = 0;
 
@@ -457,3 +457,14 @@
 }
 
 EXPORT_SYMBOL(__node_distance);
+
+int memory_add_physaddr_to_nid(u64 start)
+{
+	int i, ret = 0;
+	
+	for_each_node(i) 
+		if (nodes_add[i].start <= start && nodes_add[i].end > start)
+			ret = i;
+
+	return ret;
+}
