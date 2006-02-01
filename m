Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWBAMiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWBAMiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWBAMiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:38:07 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22741 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932457AbWBAMh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:37:56 -0500
Date: Wed, 01 Feb 2006 21:36:56 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:004/004] Unify pxm_to_node id ver.2. (For i386)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>, Bob Picco <bob.picco@hp.com>,
       Paul Jackson <pj@sgi.com>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.062
Message-Id: <20060201205415.41EE.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to remove the code of pxm_to_nid_map from i386 code.
And, some of changing Kconfig and dummy function for compile.


Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/i386/Kconfig       |    6 ++++++
 arch/i386/kernel/srat.c |   19 ++-----------------
 drivers/acpi/Kconfig    |    2 +-
 include/linux/acpi.h    |    8 ++++++++
 4 files changed, 17 insertions(+), 18 deletions(-)

Index: pxm_ver2/arch/i386/kernel/srat.c
===================================================================
--- pxm_ver2.orig/arch/i386/kernel/srat.c	2006-02-01 18:53:44.000000000 +0900
+++ pxm_ver2/arch/i386/kernel/srat.c	2006-02-01 18:54:36.000000000 +0900
@@ -39,7 +39,6 @@
 #define NODE_ARRAY_OFFSET(x)	((x) % 8)	/* 8 bits/char */
 #define BMAP_SET(bmap, bit)	((bmap)[NODE_ARRAY_INDEX(bit)] |= 1 << NODE_ARRAY_OFFSET(bit))
 #define BMAP_TEST(bmap, bit)	((bmap)[NODE_ARRAY_INDEX(bit)] & (1 << NODE_ARRAY_OFFSET(bit)))
-#define MAX_PXM_DOMAINS		256	/* 1 byte and no promises about values */
 /* bitmap length; _PXM is at most 255 */
 #define PXM_BITMAP_LEN (MAX_PXM_DOMAINS / 8) 
 static u8 pxm_bitmap[PXM_BITMAP_LEN];	/* bitmap of proximity domains */
@@ -213,19 +212,11 @@ static __init void node_read_chunk(int n
 		node_end_pfn[nid] = memory_chunk->end_pfn;
 }
 
-static u8 pxm_to_nid_map[MAX_PXM_DOMAINS];/* _PXM to logical node ID map */
-
-int pxm_to_node(int pxm)
-{
-	return pxm_to_nid_map[pxm];
-}
-
 /* Parse the ACPI Static Resource Affinity Table */
 static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
 {
 	u8 *start, *end, *p;
 	int i, j, nid;
-	u8 nid_to_pxm_map[MAX_NUMNODES];/* logical node ID to _PXM map */
 
 	start = (u8 *)(&(sratp->reserved) + 1);	/* skip header */
 	p = start;
@@ -235,10 +226,6 @@ static int __init acpi20_parse_srat(stru
 	memset(node_memory_chunk, 0, sizeof(node_memory_chunk));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
-	/* -1 in these maps means not available */
-	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
-	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
-
 	num_memory_chunks = 0;
 	while (p < end) {
 		switch (*p) {
@@ -278,9 +265,7 @@ static int __init acpi20_parse_srat(stru
 	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (BMAP_TEST(pxm_bitmap, i)) {
-			nid = num_online_nodes();
-			pxm_to_nid_map[i] = nid;
-			nid_to_pxm_map[nid] = i;
+			int nid = acpi_map_pxm_to_node(i);
 			node_set_online(nid);
 		}
 	}
@@ -288,7 +273,7 @@ static int __init acpi20_parse_srat(stru
 
 	/* set cnode id in memory chunk structure */
 	for (i = 0; i < num_memory_chunks; i++)
-		node_memory_chunk[i].nid = pxm_to_nid_map[node_memory_chunk[i].pxm];
+		node_memory_chunk[i].nid = pxm_to_node(node_memory_chunk[i].pxm);
 
 	printk("pxm bitmap: ");
 	for (i = 0; i < sizeof(pxm_bitmap); i++) {
Index: pxm_ver2/arch/i386/Kconfig
===================================================================
--- pxm_ver2.orig/arch/i386/Kconfig	2006-02-01 18:53:44.000000000 +0900
+++ pxm_ver2/arch/i386/Kconfig	2006-02-01 18:54:36.000000000 +0900
@@ -139,6 +139,12 @@ config ACPI_SRAT
 	bool
 	default y
 	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
+	select ACPI_NUMA
+
+config HAVE_ARCH_PARSE_SRAT
+       bool
+       default y
+       depends on ACPI_SRAT
 
 config X86_SUMMIT_NUMA
 	bool
Index: pxm_ver2/drivers/acpi/Kconfig
===================================================================
--- pxm_ver2.orig/drivers/acpi/Kconfig	2006-02-01 18:53:44.000000000 +0900
+++ pxm_ver2/drivers/acpi/Kconfig	2006-02-01 18:54:36.000000000 +0900
@@ -162,7 +162,7 @@ config ACPI_THERMAL
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (IA64 || X86_64)
+	depends on (X86_32 || IA64 || X86_64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
 config ACPI_ASUS
Index: pxm_ver2/include/linux/acpi.h
===================================================================
--- pxm_ver2.orig/include/linux/acpi.h	2006-02-01 18:53:53.000000000 +0900
+++ pxm_ver2/include/linux/acpi.h	2006-02-01 18:54:36.000000000 +0900
@@ -409,10 +409,18 @@ void acpi_table_print_madt_entry (acpi_t
 void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
 
 /* the following four functions are architecture-dependent */
+#ifdef CONFIG_HAVE_ARCH_PARSE_SRAT
+#define NR_NODE_MEMBLKS MAX_NUMNODES
+#define acpi_numa_slit_init(slit) do {} while (0)
+#define acpi_numa_processor_affinity_init(pa) do {} while (0)
+#define acpi_numa_memory_affinity_init(ma) do {} while (0)
+#define acpi_numa_arch_fixup() do {} while (0)
+#else
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa);
 void acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
 void acpi_numa_arch_fixup(void);
+#endif
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */

-- 
Yasunori Goto 


