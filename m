Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWEBLg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWEBLg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWEBLg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:36:26 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38540 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964779AbWEBLgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:36:25 -0400
Date: Tue, 02 May 2006 20:35:54 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch 002/003] pgdat allocation and update for ia64 of memory hotplug. (update pgdat address array)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060502201614.CF14.Y-GOTO@jp.fujitsu.com>
References: <20060502201614.CF14.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060502203247.CF1A.Y-GOTO@jp.fujitsu.com>
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

At v2 of node_add, this function used stop_machine_run() to update them.
(I wished that they were copied safety as much as possible.)
But, in this patch, this arrays are just copied simply, and
set node_online_map bit after completion of pgdat initialization.

So, kernel must touch NODE_DATA() macro after checking 
node_online_map(). (Current code has already done it.)
This is more simple way for just hot-add.....

Note : It will be problem when hot-remove will occur,
       because, even if online_map bit is set, kernel may
       touch NODE_DATA() due to race condition. :-(


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/ia64/mm/discontig.c       |   24 +++++++++++++++++++-----
 include/asm-ia64/nodedata.h    |   12 ++++++++++++
 include/linux/memory_hotplug.h |    4 +---
 3 files changed, 32 insertions(+), 8 deletions(-)

Index: pgdat12/arch/ia64/mm/discontig.c
===================================================================
--- pgdat12.orig/arch/ia64/mm/discontig.c	2006-04-28 10:24:56.000000000 +0900
+++ pgdat12/arch/ia64/mm/discontig.c	2006-04-28 10:31:49.000000000 +0900
@@ -308,6 +308,17 @@ static void __init reserve_pernode_space
 	}
 }
 
+static void __meminit scatter_node_data(void)
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
@@ -783,3 +791,9 @@ void __init paging_init(void)
 
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
+
+void arch_refresh_nodedata(int update_node, pg_data_t *update_pgdat)
+{
+	pgdat_list[update_node] = update_pgdat;
+	scatter_node_data();
+}
Index: pgdat12/include/asm-ia64/nodedata.h
===================================================================
--- pgdat12.orig/include/asm-ia64/nodedata.h	2006-04-28 10:24:51.000000000 +0900
+++ pgdat12/include/asm-ia64/nodedata.h	2006-04-28 10:27:40.000000000 +0900
@@ -47,6 +47,18 @@ struct ia64_node_data {
  */
 #define NODE_DATA(nid)		(local_node_data->pg_data_ptrs[nid])
 
+/*
+ * LOCAL_DATA_ADDR - This is to calculate the address of other node's
+ *		     "local_node_data" at hot-plug phase. The local_node_data
+ *		     is pointed by per_cpu_page. Kernel usually use it for
+ *		     just executing cpu. However, when new node is hot-added,
+ *		     the addresses of local data for other nodes are necessary
+ *		     to update all of them.
+ */
+#define LOCAL_DATA_ADDR(pgdat)  			\
+	((struct ia64_node_data *)((u64)(pgdat) + 	\
+				   L1_CACHE_ALIGN(sizeof(struct pglist_data))))
+
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_IA64_NODEDATA_H */
Index: pgdat12/include/linux/memory_hotplug.h
===================================================================
--- pgdat12.orig/include/linux/memory_hotplug.h	2006-04-28 10:24:51.000000000 +0900
+++ pgdat12/include/linux/memory_hotplug.h	2006-04-28 10:31:49.000000000 +0900
@@ -91,9 +91,7 @@ static inline pg_data_t *arch_alloc_node
 static inline void arch_free_nodedata(pg_data_t *pgdat)
 {
 }
-static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-}
+extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
 
 #else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 

-- 
Yasunori Goto 


