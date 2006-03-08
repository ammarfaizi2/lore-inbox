Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWCHNls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWCHNls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWCHNls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:41:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46985 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751819AbWCHNli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:41:38 -0500
Date: Wed, 08 Mar 2006 22:41:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 004/017](RFC) Memory hotplug for new nodes v.3. (generic alloc pgdat)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212719.002A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For node hotplug, basically we have to allocate new pgdat.
But, there are several types of implementations of pgdat.

1. Allocate only pgdat.
   This style allocate only pgdat area.
   And its address is recorded in node_data[].
   It is most popular style.

2. Static array of pgdat
   In this case, all of pgdats are static array.
   Some archs use this style.

3. Allocate not only pgdat, but also per node data.
   To increase performance, each node has copy of some data as
   a per node data. So, this area must be allocated too.

   Ia64 is this style. Ia64 has the copies of node_data[] array
   on each per node data to increase performance.

In this series of patches, treat (1) as generic arch.

generic archs can use generic function. (2) and (3) should have
its own if necessary. 

This patch defines pgdat allocator.
Updating NODE_DATA() macro function is in other patch.

( I'll post another patch for (3).
  I don't know (2) which can use memory hotplug.
  So, there is not patch for (2). )

Signed-off-by: Yasonori Goto     <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: pgdat6/include/linux/memory_hotplug.h
===================================================================
--- pgdat6.orig/include/linux/memory_hotplug.h	2006-03-06 19:40:57.000000000 +0900
+++ pgdat6/include/linux/memory_hotplug.h	2006-03-06 19:42:21.000000000 +0900
@@ -72,6 +72,56 @@ static inline int arch_nid_probe(u64 sta
 }
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
+/*
+ * For supporint node-hotadd, we have to allocate new pgdat.
+ *
+ * If an arch have generic style NODE_DATA(),
+ * node_data[nid] = kzalloc() works well . But it depends on each arch.
+ *
+ * In general, generic_alloc_nodedata() is used.
+ * generic...is a local function in mm/memory_hotplug.c
+ *
+ * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
+ *
+ */
+extern struct pglist_data * arch_alloc_nodedata(int nid);
+extern void arch_free_nodedata(pg_data_t *pgdat);
+
+#else /* !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
+#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
+#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
+
+#ifdef CONFIG_NUMA
+/*
+ * If ARCH_HAS_NODEDATA_EXTENSION=n, this func is used to allocate pgdat.
+ */
+static inline struct pglist_data *generic_alloc_nodedata(int nid)
+{
+	return kzalloc(sizeof(struct pglist_data), GFP_ATOMIC);
+}
+/*
+ * This definition is just for error path in node hotadd.
+ * For node hotremove, we have to replace this.
+ */
+static inline void generic_free_nodedata(struct pglist_data *pgdat)
+{
+	kfree(pgdat);
+}
+
+#else /* !CONFIG_NUMA */
+/* never called */
+static inline struct pglist_data *generic_alloc_nodedata(int nid)
+{
+	BUG();
+	return NULL;
+}
+static inline void generic_free_nodedata(struct pglist_data *pgdat)
+{
+}
+#endif /* CONFIG_NUMA */
+#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
+
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off

-- 
Yasunori Goto 


