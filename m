Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWHDNPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWHDNPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWHDNPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:15:14 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:47513 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161137AbWHDNPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:15:10 -0400
Date: Fri, 4 Aug 2006 07:14:45 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131445.21401.73592.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 10/10] hot-add-mem x86_64: valid add range check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

  Introduce and implement valid_add_memory_range to MEMORY_HOTPLUG.  The
RESERVE path needs to be careful about check to make sure it only onlines
correct memory.  The SPASRMEM path is using resource code to do this so
it gets a no-op check. This frame work makes it was to add specific checks
for valid add memory ranges as the need arises. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 arch/x86_64/mm/srat.c          |    6 ++++++
 include/linux/memory_hotplug.h |    2 +-
 mm/memory_hotplug.c            |    8 ++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff -urN orig/arch/x86_64/mm/srat.c current/arch/x86_64/mm/srat.c
--- orig/arch/x86_64/mm/srat.c	2006-08-04 06:56:24.000000000 -0400
+++ current/arch/x86_64/mm/srat.c	2006-08-04 03:39:29.000000000 -0400
@@ -203,6 +203,12 @@
 {
 	return hotadd_percent > 0;
 }
+
+inline int valid_add_memory_range(int nid, u64 start, u64 size) {
+	if (nodes_add[nid].start <= start && nodes_add[nid].end >= (start+size))
+		return 1;
+	return 0;
+}
 #else
 int update_end_of_memory(unsigned long end) {return 0;}
 static int hotadd_enough_memory(struct bootnode *nd) {return 1;}
diff -urN orig/include/linux/memory_hotplug.h current/include/linux/memory_hotplug.h
--- orig/include/linux/memory_hotplug.h	2006-08-04 06:56:24.000000000 -0400
+++ current/include/linux/memory_hotplug.h	2006-08-04 02:08:45.000000000 -0400
@@ -159,7 +159,7 @@
 	dump_stack();
 	return -ENOSYS;
 }
-
+extern int valid_add_memory_range(int nid, u64 start, u64 size);
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 static inline int __remove_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages)
diff -urN orig/mm/memory_hotplug.c current/mm/memory_hotplug.c
--- orig/mm/memory_hotplug.c	2006-08-04 06:59:05.000000000 -0400
+++ current/mm/memory_hotplug.c	2006-08-04 03:08:23.000000000 -0400
@@ -220,6 +220,11 @@
 	vm_total_pages = nr_free_pagecache_pages();
 	return 0;
 }
+
+inline int valid_add_memory_range(int nid, u64 start, u64 size) {
+	return 1;	
+}
+
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
  
 static pg_data_t *hotadd_new_pgdat(int nid, u64 start)
@@ -257,6 +262,9 @@
 	int new_pgdat = 0;
 	struct resource *res;
 	int ret;
+	
+	if (!valid_add_memory_range(nid,start,size))
+		return -EINVAL;
 
 	res = register_memory_resource(start, size);
 	if (!res)
