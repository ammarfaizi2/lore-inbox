Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWBAMhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWBAMhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBAMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:37:10 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59603 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932446AbWBAMhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:37:06 -0500
Date: Wed, 01 Feb 2006 21:36:28 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:001/004] Unify pxm_to_node id ver.2. (generic code)
Cc: "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>,
       Andi Kleen <ak@suse.de>, Bob Picco <bob.picco@hp.com>,
       Paul Jackson <pj@sgi.com>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.062
Message-Id: <20060201205204.41E8.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is new generic code for pxm_to_node_map.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/numa.c      |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_numa.h |   18 ++++++++++++++++
 include/linux/acpi.h     |    1 
 3 files changed, 69 insertions(+)

Index: pxm_ver2/drivers/acpi/numa.c
===================================================================
--- pxm_ver2.orig/drivers/acpi/numa.c	2006-02-01 18:53:46.000000000 +0900
+++ pxm_ver2/drivers/acpi/numa.c	2006-02-01 18:53:53.000000000 +0900
@@ -36,12 +36,62 @@
 #define _COMPONENT	ACPI_NUMA
 ACPI_MODULE_NAME("numa")
 
+static nodemask_t nodes_found_map = NODE_MASK_NONE;
+#define PXM_INVAL	0xff
+#define NID_INVAL	0xff
+
+/* maps to convert between proximity domain and logical node ID */
+u8 __cpuinitdata pxm_to_node_map[MAX_PXM_DOMAINS]
+				= { [0 ... MAX_PXM_DOMAINS - 1] = NID_INVAL };
+u8 __cpuinitdata node_to_pxm_map[MAX_NUMNODES]
+				= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
+
 extern int __init acpi_table_parse_madt_family(enum acpi_table_id id,
 					       unsigned long madt_size,
 					       int entry_id,
 					       acpi_madt_entry_handler handler,
 					       unsigned int max_entries);
 
+int __cpuinit pxm_to_node(int pxm)
+{
+	if ((unsigned)pxm >= 256)
+		return -1;
+	/* Extent 0xff to (int)-1 */
+	return (signed char)pxm_to_node_map[pxm];
+}
+
+int __cpuinit node_to_pxm(int node)
+{
+	if ((unsigned)node >= 256)
+		return -1;
+	/* Extent 0xff to (int)-1 */
+	return (signed char)node_to_pxm_map[node];
+}
+
+int __cpuinit acpi_map_pxm_to_node(u8 pxm)
+{
+	u8 node = pxm_to_node_map[pxm];
+
+	if (node == NID_INVAL){
+		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
+			return -1;
+		node = first_unset_node(nodes_found_map);
+		pxm_to_node_map[pxm] = node;
+		node_to_pxm_map[node] = pxm;
+		node_set(node, nodes_found_map);
+	}
+
+	return (int)node;
+}
+
+void __cpuinit acpi_unmap_pxm_to_node(int node)
+{
+	u8 pxm = node_to_pxm_map[node];
+	pxm_to_node_map[pxm] = NID_INVAL;
+	node_to_pxm_map[node] = PXM_INVAL;
+	node_clear(node, nodes_found_map);
+}
+
 void __init acpi_table_print_srat_entry(acpi_table_entry_header * header)
 {
 
Index: pxm_ver2/include/acpi/acpi_numa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ pxm_ver2/include/acpi/acpi_numa.h	2006-02-01 18:53:53.000000000 +0900
@@ -0,0 +1,18 @@
+#ifndef __ACPI_NUMA_H
+#define __ACPI_NUMA_H
+
+#ifdef CONFIG_ACPI_NUMA
+#include <linux/kernel.h>
+
+/* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
+#define MAX_PXM_DOMAINS (256)
+extern u8 __cpuinitdata pxm_to_node_map[MAX_PXM_DOMAINS];
+extern u8 __cpuinitdata node_to_pxm_map[MAX_NUMNODES];
+
+extern int __cpuinit pxm_to_node(int);
+extern int __cpuinit node_to_pxm(int);
+extern int __cpuinit acpi_map_pxm_to_node(u8);
+extern void __cpuinit acpi_unmap_pxm_to_node(int);
+
+#endif				/* CONFIG_ACPI_NUMA */
+#endif				/* __ACP_NUMA_H */
Index: pxm_ver2/include/linux/acpi.h
===================================================================
--- pxm_ver2.orig/include/linux/acpi.h	2006-02-01 18:53:46.000000000 +0900
+++ pxm_ver2/include/linux/acpi.h	2006-02-01 18:53:53.000000000 +0900
@@ -38,6 +38,7 @@
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_numa.h>
 #include <asm/acpi.h>
 
 

-- 
Yasunori Goto 


