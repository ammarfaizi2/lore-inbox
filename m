Return-Path: <linux-kernel-owner+w=401wt.eu-S965074AbWLTOLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWLTOLL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWLTOLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:11:11 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:51074 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965075AbWLTOLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:11:09 -0500
Date: Wed, 20 Dec 2006 23:09:58 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch](memory hotplug) fix compile error for i386 with NUMA config (take 3).
Cc: David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Randy Dunlap <randy.dunlap@oracle.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061220225927.F016.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is take 3 patch to fix compile error when config
memory hotplug with numa on i386.

The cause of compile error was missing of arch_add_memory(), remove_memory(),
and memory_add_physaddr_to_nid().

I fixed some bad points, and tested no compile error of it.

This is for 2.6.20-rc1. 

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 arch/i386/mm/discontig.c |   28 ++++++++++++++++++++++++++++
 arch/i386/mm/init.c      |   10 ++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

Index: linux-2.6.20-rc1/arch/i386/mm/init.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/i386/mm/init.c	2006-12-20 22:12:07.000000000 +0900
+++ linux-2.6.20-rc1/arch/i386/mm/init.c	2006-12-20 22:12:09.000000000 +0900
@@ -673,16 +673,10 @@
 #endif
 }
 
-/*
- * this is for the non-NUMA, single node SMP system case.
- * Specifically, in the case of x86, we will always add
- * memory to the highmem for now.
- */
 #ifdef CONFIG_MEMORY_HOTPLUG
-#ifndef CONFIG_NEED_MULTIPLE_NODES
 int arch_add_memory(int nid, u64 start, u64 size)
 {
-	struct pglist_data *pgdata = &contig_page_data;
+	struct pglist_data *pgdata = NODE_DATA(nid);
 	struct zone *zone = pgdata->node_zones + ZONE_HIGHMEM;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -694,7 +688,7 @@
 {
 	return -EINVAL;
 }
-#endif
+EXPORT_SYMBOL_GPL(remove_memory);
 #endif
 
 struct kmem_cache *pgd_cache;
Index: linux-2.6.20-rc1/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/i386/mm/discontig.c	2006-12-20 22:12:07.000000000 +0900
+++ linux-2.6.20-rc1/arch/i386/mm/discontig.c	2006-12-20 22:37:54.000000000 +0900
@@ -405,3 +405,31 @@
 	totalram_pages += totalhigh_pages;
 #endif
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int paddr_to_nid(u64 addr)
+{
+	int nid;
+	unsigned long pfn = PFN_DOWN(addr);
+
+	for_each_node(nid)
+		if (node_start_pfn[nid] <= pfn &&
+		    pfn < node_end_pfn[nid])
+			return nid;
+
+	return -1;
+}
+
+/*
+ * This function is used to ask node id BEFORE memmap and mem_section's
+ * initialization (pfn_to_nid() can't be used yet).
+ * If _PXM is not defined on ACPI's DSDT, node id must be found by this.
+ */
+int memory_add_physaddr_to_nid(u64 addr)
+{
+	int nid = paddr_to_nid(addr);
+	return (nid >= 0) ? nid : 0;
+}
+
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+#endif

-- 
Yasunori Goto 


