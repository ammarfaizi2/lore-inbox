Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWBQNb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWBQNb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWBQNae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:34 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40401 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964916AbWBQNa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:30:27 -0500
Date: Fri, 17 Feb 2006 22:29:28 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 008/012] Memory hotplug for new nodes v.2(NODE_DATA array initalize for ia64).
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217213623.4078.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to register NODE_DATA() macro for ia64.
Ia64's node_data[] arrays are copied ON EACH NODES,
So, they must be updated all at once.
This use stop_machine_run() for safety update of them.

Other archtectures don't need like this code....

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat2/arch/ia64/mm/discontig.c
===================================================================
--- pgdat2.orig/arch/ia64/mm/discontig.c	2006-02-10 17:22:18.000000000 +0900
+++ pgdat2/arch/ia64/mm/discontig.c	2006-02-10 19:54:57.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/nodemask.h>
+#include <linux/stop_machine.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
@@ -114,11 +115,12 @@ static int __init early_nr_cpus_node(int
  * compute_pernodesize - compute size of pernode data
  * @node: the node id.
  */
-static unsigned long __init compute_pernodesize(int node)
+static unsigned long __meminit compute_pernodesize(int node)
 {
-	unsigned long pernodesize = 0, cpus;
+	unsigned long pernodesize = 0, cpus = 0;
 
-	cpus = early_nr_cpus_node(node);
+	if (system_state == SYSTEM_BOOTING)
+		cpus = early_nr_cpus_node(node);
 	pernodesize += PERCPU_PAGE_SIZE * cpus;
 	pernodesize += node * L1_CACHE_BYTES;
 	pernodesize += L1_CACHE_ALIGN(sizeof(pg_data_t));
@@ -753,3 +755,71 @@ void __init paging_init(void)
 
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+unsigned long arch_pernode_size(int nid)
+{
+	return compute_pernodesize(nid);
+}
+
+/*
+ *     NODE_DATA() array is replicated on each node as pg_data_ptrs[].
+ *     So, all of them must be updated.
+ *     This update is done when other cpu is stopped.
+ */
+static int __set_node_data_array(void *_pgdat)
+{
+	pg_data_t *new_pgdat = (pg_data_t *)_pgdat;
+	int new_node_id = new_pgdat->node_id;
+	int nid;
+	pg_data_t **pg_dat_ptrs, **dst, **src;
+
+	/* At first, Set other nodes' pg_data_ptrs. */
+	for_each_online_node(nid){
+		pg_dat_ptrs = LOCAL_DATA_ADDR(NODE_DATA(nid))->pg_data_ptrs;
+		*(pg_dat_ptrs + new_node_id) = new_pgdat;
+	}
+
+	/*
+	 * Then, set new node's pg_data_ptrs[].
+	 * All of them must be same. So, it can be copied from other node
+	 * to this new node.
+	 * The destination is simple. It is new node's local area.
+	 */
+        dst = LOCAL_DATA_ADDR(new_pgdat)->pg_data_ptrs;
+
+	/*
+	 * The source pg_data_ptrs[] is for the node which includes
+	 * current executing cpu. This array is updated at above for loop.
+	 * NODE_DATA(0) macro becomes the data of pg_data_ptrs[0] ON THIS NODE.
+	 * &(NODE_DATA(0) means address of pg_data_ptrs[0] on this node.
+	 */
+	src = &(NODE_DATA(0));
+	memcpy(dst, src, sizeof(pg_data_t *) * MAX_NUMNODES);
+
+	return 0;
+
+}
+void set_node_data_array(int nid, pg_data_t *pgdat)
+{
+	pgdat->node_id = nid;
+	stop_machine_run(__set_node_data_array, pgdat, NR_CPUS);
+}
+
+static int __clear_node_data_array(void *_pgdat)
+{
+	pg_data_t *clear_pgdat=(pg_data_t *)_pgdat, **pg_dat_ptrs;
+	int i;
+
+	for_each_online_node(i){
+		pg_dat_ptrs = LOCAL_DATA_ADDR(NODE_DATA(i))->pg_data_ptrs;
+		*(pg_dat_ptrs + clear_pgdat->node_id) = NULL;
+	}
+	return 0;
+}
+
+void clear_node_data_array(pg_data_t *pgdat)
+{
+	stop_machine_run(__clear_node_data_array, pgdat, NR_CPUS);
+}
+#endif
Index: pgdat2/include/asm-ia64/nodedata.h
===================================================================
--- pgdat2.orig/include/asm-ia64/nodedata.h	2006-02-10 16:46:50.000000000 +0900
+++ pgdat2/include/asm-ia64/nodedata.h	2006-02-10 17:40:05.000000000 +0900
@@ -47,6 +47,15 @@ struct ia64_node_data {
  */
 #define NODE_DATA(nid)		(local_node_data->pg_data_ptrs[nid])
 
+/*
+ * LOCAL_DATA_ADDR - This is to calculate each local_node_data address among hot-plug phase.
+ *                   When new node is hot-added, the addresses of local data for other nodes
+ *                   are necessary to be updated. In addtion, the cpu's on the new node
+ *                   will be initialized after this local_data initialization. So,
+ *                   per_cpu_page and local_node_data can't be used.
+ */
+#define LOCAL_DATA_ADDR(pgdat) ((struct ia64_node_data *)((u64)(pgdat) + L1_CACHE_ALIGN(sizeof(struct pglist_data))))
+
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_IA64_NODEDATA_H */
Index: pgdat2/arch/ia64/Kconfig
===================================================================
--- pgdat2.orig/arch/ia64/Kconfig	2006-02-10 17:22:18.000000000 +0900
+++ pgdat2/arch/ia64/Kconfig	2006-02-10 19:49:31.000000000 +0900
@@ -360,6 +360,14 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config ARCH_PERNODE_SIZE
+	def_bool y
+	depends on NUMA
+
+config ARCH_UPDATE_NODE_DATA
+	def_bool y
+	depends on NUMA
+
 config IA32_SUPPORT
 	bool "Support for Linux/x86 binaries"
 	help

-- 
Yasunori Goto 


