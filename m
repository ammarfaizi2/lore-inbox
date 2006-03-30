Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWC3Lzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWC3Lzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWC3Lzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:55:39 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20677 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932071AbWC3Lzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:55:38 -0500
Date: Thu, 30 Mar 2006 20:55:20 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:001/004]Unify pxm_to_node id ver.4. (generic part)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
References: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330204947.A4F7.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is new generic code for pxm_to_node_map.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/numa.c      |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_numa.h |   23 ++++++++++++++++++++++
 include/linux/acpi.h     |    1 
 3 files changed, 72 insertions(+)

Index: pxm_ver4/drivers/acpi/numa.c
===================================================================
--- pxm_ver4.orig/drivers/acpi/numa.c	2006-03-29 22:11:18.000000000 +0900
+++ pxm_ver4/drivers/acpi/numa.c	2006-03-29 22:12:41.000000000 +0900
@@ -36,12 +36,60 @@
 #define _COMPONENT	ACPI_NUMA
 ACPI_MODULE_NAME("numa")
 
+static nodemask_t nodes_found_map = NODE_MASK_NONE;
+#define PXM_INVAL	-1
+#define NID_INVAL	-1
+
+/* maps to convert between proximity domain and logical node ID */
+int __cpuinitdata pxm_to_node_map[MAX_PXM_DOMAINS]
+				= { [0 ... MAX_PXM_DOMAINS - 1] = NID_INVAL };
+int __cpuinitdata node_to_pxm_map[MAX_NUMNODES]
+				= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
+
 extern int __init acpi_table_parse_madt_family(enum acpi_table_id id,
 					       unsigned long madt_size,
 					       int entry_id,
 					       acpi_madt_entry_handler handler,
 					       unsigned int max_entries);
 
+int __cpuinit pxm_to_node(int pxm)
+{
+	if (pxm < 0)
+		return NID_INVAL;
+	return pxm_to_node_map[pxm];
+}
+
+int __cpuinit node_to_pxm(int node)
+{
+	if (node < 0)
+		return PXM_INVAL;
+	return node_to_pxm_map[node];
+}
+
+int __cpuinit acpi_map_pxm_to_node(int pxm)
+{
+	int node = pxm_to_node_map[pxm];
+
+	if (node < 0){
+		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
+			return NID_INVAL;
+		node = first_unset_node(nodes_found_map);
+		pxm_to_node_map[pxm] = node;
+		node_to_pxm_map[node] = pxm;
+		node_set(node, nodes_found_map);
+	}
+
+	return node;
+}
+
+void __cpuinit acpi_unmap_pxm_to_node(int node)
+{
+	int pxm = node_to_pxm_map[node];
+	pxm_to_node_map[pxm] = NID_INVAL;
+	node_to_pxm_map[node] = PXM_INVAL;
+	node_clear(node, nodes_found_map);
+}
+
 void __init acpi_table_print_srat_entry(acpi_table_entry_header * header)
 {
 
Index: pxm_ver4/include/acpi/acpi_numa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ pxm_ver4/include/acpi/acpi_numa.h	2006-03-29 22:19:30.000000000 +0900
@@ -0,0 +1,23 @@
+#ifndef __ACPI_NUMA_H
+#define __ACPI_NUMA_H
+
+#ifdef CONFIG_ACPI_NUMA
+#include <linux/kernel.h>
+
+/* Proximity bitmap length */
+#if MAX_NUMNODES > 256
+#define MAX_PXM_DOMAINS MAX_NUMNODES
+#else
+#define MAX_PXM_DOMAINS (256) /* Old pxm spec is defined 8 bit */
+#endif
+
+extern int __cpuinitdata pxm_to_node_map[MAX_PXM_DOMAINS];
+extern int __cpuinitdata node_to_pxm_map[MAX_NUMNODES];
+
+extern int __cpuinit pxm_to_node(int);
+extern int __cpuinit node_to_pxm(int);
+extern int __cpuinit acpi_map_pxm_to_node(int);
+extern void __cpuinit acpi_unmap_pxm_to_node(int);
+
+#endif				/* CONFIG_ACPI_NUMA */
+#endif				/* __ACP_NUMA_H */
Index: pxm_ver4/include/linux/acpi.h
===================================================================
--- pxm_ver4.orig/include/linux/acpi.h	2006-03-29 22:11:18.000000000 +0900
+++ pxm_ver4/include/linux/acpi.h	2006-03-29 22:12:41.000000000 +0900
@@ -38,6 +38,7 @@
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_numa.h>
 #include <asm/acpi.h>
 
 

-- 
Yasunori Goto 


