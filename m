Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWCHNqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWCHNqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWCHNqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:46:38 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:44938 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751834AbWCHNmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:42:06 -0500
Date: Wed, 08 Mar 2006 22:42:03 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 007/017](RFC) Memory hotplug for new nodes v.3. (refresh NODE_DATA() for ia64)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212941.0030.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is to refresh node_data[] array for ia64.
As I mentioned previous patches,
ia64 has copies of information of pgdat address array on each node
as per node data.

At v2, this function used stop_machine_run() to update them.
(I wished that they were copied safety as much as possible.)
But, in this patch, this arrays are just copied simply, and
set node_online_map bit after completion of pgdat initialization.

So, kernel must touch NODE_DATA() macro after checking 
node_online_map(). (Current code has already done it.)
This is more simple way for just hot-add.....

Note : It will be problem when hot-remove will occur,
       because, even if online_map bit is upset, kernel may
       touch NODE_DATA() due to race condition. :-(


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/arch/ia64/mm/discontig.c
===================================================================
--- pgdat6.orig/arch/ia64/mm/discontig.c	2006-03-06 18:26:07.000000000 +0900
+++ pgdat6/arch/ia64/mm/discontig.c	2006-03-06 18:26:11.000000000 +0900
@@ -308,6 +308,17 @@ static void __init reserve_pernode_space
 	}
 }
 
+void __meminit scatter_node_data(void)
+{
+	pg_data_t **dst;
+	int node;
+
+	for_each_online_node(node){
+		dst = LOCAL_DATA_ADDR(pgdat_list[node])->pg_data_ptrs;
+		memcpy(dst, pgdat_list, sizeof(pgdat_list));
+	}
+}
+
 /**
  * initialize_pernode_data - fixup per-cpu & per-node pointers
  *
@@ -320,11 +331,8 @@ static void __init initialize_pernode_da
 {
 	int cpu, node;
 
-	/* Copy the pg_data_t list to each node and init the node field */
-	for_each_online_node(node) {
-		memcpy(mem_data[node].node_data->pg_data_ptrs, pgdat_list,
-		       sizeof(pgdat_list));
-	}
+	scatter_node_data();
+
 #ifdef CONFIG_SMP
 	/* Set the node_data pointer for each per-cpu struct */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
@@ -719,3 +727,9 @@ void __init paging_init(void)
 
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
+
+void arch_refresh_nodedata(int update_node, pg_data_t *update_pgdat)
+{
+	pgdat_list[update_node] = update_pgdat;
+	scatter_node_data();
+}
Index: pgdat6/arch/ia64/Kconfig
===================================================================
--- pgdat6.orig/arch/ia64/Kconfig	2006-03-06 18:25:31.000000000 +0900
+++ pgdat6/arch/ia64/Kconfig	2006-03-06 18:26:11.000000000 +0900
@@ -364,6 +364,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config HAVE_ARCH_NODEDATA_EXTENSION
+	def_bool y
+	depends on NUMA
+
 config IA32_SUPPORT
 	bool "Support for Linux/x86 binaries"
 	help
Index: pgdat6/include/asm-ia64/nodedata.h
===================================================================
--- pgdat6.orig/include/asm-ia64/nodedata.h	2006-03-06 18:24:02.000000000 +0900
+++ pgdat6/include/asm-ia64/nodedata.h	2006-03-06 18:26:11.000000000 +0900
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

-- 
Yasunori Goto 


