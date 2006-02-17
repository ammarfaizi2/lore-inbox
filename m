Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWBQN3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWBQN3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBQN3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:29:14 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:729 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751411AbWBQN3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:29:10 -0500
Date: Fri, 17 Feb 2006 22:28:24 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 001/012] Memory hotplug for new nodes v.2. (pgdat allocation)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217210749.406A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is main patch for pgdat allocation for new node.
When, new pgdat is required, kernel allocates memory for it
and initialize it by calling free_area_init_node().

Finally, NODE_DATA() macro can use by registering node_data[] array.
Ia64 needs special code for node_data[], but 
  node_data[node] = pgdat;
is enough for other archtectures. 

To allocate pgdat, this patch use kmalloc() for it.
This means its place is not appropriate. 
Kmalloc() will use other node for new pgdat. Because new node's memory
management structure (it means new pgdat) must be initalized ITSELF
for kmalloc.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat3/mm/memory_hotplug.c
===================================================================
--- pgdat3.orig/mm/memory_hotplug.c	2006-02-17 15:51:08.000000000 +0900
+++ pgdat3/mm/memory_hotplug.c	2006-02-17 16:12:28.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
+#include <linux/kthread.h>
 
 #include <asm/tlbflush.h>
 
@@ -54,6 +55,53 @@ static int __add_section(struct zone *zo
 	return register_new_memory(__pfn_to_section(phys_start_pfn));
 }
 
+extern int kswapd(void *);
+int new_pgdat_init(int nid, unsigned long start_pfn, unsigned long nr_pages)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0};
+	unsigned long zholes_size[MAX_NR_ZONES] = {0};
+	unsigned long pernode_size = arch_pernode_size(nid);
+	pg_data_t *pgdat;
+	struct task_struct *p;
+
+	pgdat = kmalloc(pernode_size, GFP_KERNEL);
+	if (!pgdat){
+		printk(KERN_ERR "%s node_data allocation failed\n",
+			__FUNCTION__);
+		return -ENODEV;
+	}
+
+	memset(pgdat, 0, pernode_size);
+	set_node_data_array(nid, pgdat);
+	/* NODE_DATA(nid) macro can be used from here */
+
+	free_area_init_node(nid, pgdat, zones_size, start_pfn, zholes_size);
+
+	p = kthread_create(kswapd, pgdat, "kswapd%d", nid);
+	if (IS_ERR(p)){
+		printk(KERN_ERR "%s kswapd creation failed\n", __FUNCTION__);
+		clear_node_data_array(pgdat);
+		kfree(pgdat);
+		return PTR_ERR(p);
+	}
+
+	pgdat->kswapd = p;
+	node_set_online(nid);
+	arch_register_node(nid);
+
+	return 0;
+
+}
+
+void release_pgdat(pg_data_t *pgdat)
+{
+	arch_unregister_node(pgdat->node_id);
+	node_set_offline(pgdat->node_id);
+	clear_node_data_array(pgdat);
+	kfree(pgdat);
+}
+
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
Index: pgdat3/mm/vmscan.c
===================================================================
--- pgdat3.orig/mm/vmscan.c	2006-02-17 15:58:06.000000000 +0900
+++ pgdat3/mm/vmscan.c	2006-02-17 16:12:28.000000000 +0900
@@ -1699,7 +1699,7 @@ out:
  * If there are applications that are active memory-allocators
  * (most normal use), this basically shouldn't matter.
  */
-static int kswapd(void *p)
+int kswapd(void *p)
 {
 	unsigned long order;
 	pg_data_t *pgdat = (pg_data_t*)p;
Index: pgdat3/include/linux/memory_hotplug.h
===================================================================
--- pgdat3.orig/include/linux/memory_hotplug.h	2006-01-05 15:43:22.000000000 +0900
+++ pgdat3/include/linux/memory_hotplug.h	2006-02-17 16:12:28.000000000 +0900
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/mmzone.h>
 #include <linux/notifier.h>
+#include <asm/mmzone.h>
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
@@ -61,6 +62,34 @@ extern int online_pages(unsigned long, u
 /* reasonably generic interface to expand the physical pages in a zone  */
 extern int __add_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages);
+
+#ifdef CONFIG_ARCH_PERNODE_SIZE
+extern unsigned long arch_pernode_size(int node);
+#else /* CONFIG_ARCH_PERNODE_SIZE */
+static inline unsigned long arch_pernode_size(int node)
+{
+	return ALIGN(sizeof(pg_data_t), PAGE_SIZE);
+}
+#endif /* CONFIG_ARCH_PERNODE_SIZE */
+
+#ifdef CONFIG_ARCH_UPDATE_NODE_DATA
+extern void set_node_data_array(int, pg_data_t *);
+extern void clear_node_data_array(pg_data_t *);
+#else /* CONFIG_ARCH_UPDATE_NODE_DATA */
+static inline void set_node_data_array(int nid, pg_data_t *pgdat)
+{
+	NODE_DATA(nid) = pgdat;
+}
+
+static inline void clear_node_data_array(pg_data_t *pgdat)
+{
+	NODE_DATA(pgdat->node_id) = NULL;
+}
+#endif /* CONFIG_ARCH_UPDATE_NODE_DATA */
+
+extern int new_pgdat_init(int, unsigned long, unsigned long);
+extern void release_pgdat(pg_data_t *);
+
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off

-- 
Yasunori Goto 


