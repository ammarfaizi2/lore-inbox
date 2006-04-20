Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWDTKLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDTKLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWDTKLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:11:31 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57029 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750827AbWDTKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:11:15 -0400
Date: Thu, 20 Apr 2006 19:10:13 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch: 003/006] pgdat allocation for new node add (generic alloc node_data)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
References: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060420190547.EE4E.Y-GOTO@jp.fujitsu.com>
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

 include/linux/memory_hotplug.h |   55 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+)

Index: pgdat11/include/linux/memory_hotplug.h
===================================================================
--- pgdat11.orig/include/linux/memory_hotplug.h	2006-04-20 11:00:09.000000000 +0900
+++ pgdat11/include/linux/memory_hotplug.h	2006-04-20 11:00:23.000000000 +0900
@@ -73,6 +73,61 @@ static inline int memofy_add_physaddr_to
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
+ * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
+ *
+ */
+static inline pg_data_t * arch_alloc_nodedata(int nid)
+{
+	return NULL;
+}
+static inline void arch_free_nodedata(pg_data_t *pgdat)
+{
+}
+
+#else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
+
+#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
+#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
+
+#ifdef CONFIG_NUMA
+/*
+ * If ARCH_HAS_NODEDATA_EXTENSION=n, this func is used to allocate pgdat.
+ * XXX: kmalloc_node() can't work well to get new node's memory at this time.
+ *	Because, pgdat for the new node is not allocated/initialized yet itself.
+ *	To use new node's memory, more consideration will be necessary.
+ */
+#define generic_alloc_nodedata(nid)				\
+({								\
+	(pg_data_t *)kzalloc(sizeof(pg_data_t), GFP_KERNEL);	\
+})
+/*
+ * This definition is just for error path in node hotadd.
+ * For node hotremove, we have to replace this.
+ */
+#define generic_free_nodedata(pgdat)	kfree(pgdat)
+
+#else /* !CONFIG_NUMA */
+
+/* never called */
+static inline pg_data_t *generic_alloc_nodedata(int nid)
+{
+	BUG();
+	return NULL;
+}
+static inline void generic_free_nodedata(pg_data_t *pgdat)
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


