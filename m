Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWERFvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWERFvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWERFvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:51:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:4051 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750998AbWERFvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:51:40 -0400
Date: Thu, 18 May 2006 14:50:58 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Register sysfs file for hotpluged new node take 2.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060518143742.E2FB.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is the last part of patches for new nodes addition v4.
It is to create sysfs file for new node when new node is enabled.

This version makes generic function register_one_node() instead of
arch_register_node(). 
I386's old arch_register_node() is removed. 
(This means include/asm-i386/node.h is not necessary.)
Powerpc's same code is consolidated into driver/base/node.c

This patch is for 2.6.17-rc4-mm1 too.

Please apply.

-------------------------------------
Change log from v1 of register_node()
  - make generic function register_one_node() from arch_register_node().

Change log from v4 of node hot-add.
  - update for 2.6.17-rc4-mm1.
  - define arch_register_node() for not only ia64 but also powerpc and x86.

V4 of post is here.
<description>
http://marc.theaimsgroup.com/?l=linux-mm&m=114258404023573&w=2
<patches>
http://marc.theaimsgroup.com/?l=linux-mm&w=2&r=1&s=memory+hotplug+node+v.4.&q=b


Signed-off-by: Keiichiro Tokunaga <tokuanga.keiich@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


 include/asm-i386/node.h     |   29 -----------------------------
 arch/i386/kernel/topology.c |    9 +++------
 arch/powerpc/kernel/sysfs.c |   15 ++-------------
 drivers/base/node.c         |   25 +++++++++++++++++++++++++
 include/asm-i386/cpu.h      |    2 --
 include/linux/node.h        |    4 ++++
 mm/memory_hotplug.c         |   12 +++++++++++-
 7 files changed, 45 insertions(+), 51 deletions(-)

Index: pgdat14/arch/i386/kernel/topology.c
===================================================================
--- pgdat14.orig/arch/i386/kernel/topology.c	2006-05-18 10:38:50.000000000 +0900
+++ pgdat14/arch/i386/kernel/topology.c	2006-05-18 10:38:54.000000000 +0900
@@ -38,7 +38,7 @@ int arch_register_cpu(int num){
 #ifdef CONFIG_NUMA
 	int node = cpu_to_node(num);
 	if (node_online(node))
-		parent = &node_devices[node].node;
+		parent = &node_devices[parent_node(node)];
 #endif /* CONFIG_NUMA */
 
 	/*
@@ -61,7 +61,7 @@ void arch_unregister_cpu(int num) {
 #ifdef CONFIG_NUMA
 	int node = cpu_to_node(num);
 	if (node_online(node))
-		parent = &node_devices[node].node;
+		parent = &node_devices[parent_node(node)];
 #endif /* CONFIG_NUMA */
 
 	return unregister_cpu(&cpu_devices[num].cpu, parent);
@@ -74,16 +74,13 @@ EXPORT_SYMBOL(arch_unregister_cpu);
 
 #ifdef CONFIG_NUMA
 #include <linux/mmzone.h>
-#include <asm/node.h>
-
-struct i386_node node_devices[MAX_NUMNODES];
 
 static int __init topology_init(void)
 {
 	int i;
 
 	for_each_online_node(i)
-		arch_register_node(i);
+		register_one_node(i);
 
 	for_each_present_cpu(i)
 		arch_register_cpu(i);
Index: pgdat14/arch/powerpc/kernel/sysfs.c
===================================================================
--- pgdat14.orig/arch/powerpc/kernel/sysfs.c	2006-05-18 10:38:50.000000000 +0900
+++ pgdat14/arch/powerpc/kernel/sysfs.c	2006-05-18 10:38:54.000000000 +0900
@@ -304,23 +304,12 @@ static struct notifier_block sysfs_cpu_n
 /* NUMA stuff */
 
 #ifdef CONFIG_NUMA
-static struct node node_devices[MAX_NUMNODES];
-
 static void register_nodes(void)
 {
 	int i;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (node_online(i)) {
-			int p_node = parent_node(i);
-			struct node *parent = NULL;
-
-			if (p_node != i)
-				parent = &node_devices[p_node];
-
-			register_node(&node_devices[i], i, parent);
-		}
-	}
+	for (i = 0; i < MAX_NUMNODES; i++)
+		register_one_node(i);
 }
 
 int sysfs_add_device_to_node(struct sys_device *dev, int nid)
Index: pgdat14/drivers/base/node.c
===================================================================
--- pgdat14.orig/drivers/base/node.c	2006-05-18 10:38:50.000000000 +0900
+++ pgdat14/drivers/base/node.c	2006-05-18 10:38:54.000000000 +0900
@@ -190,6 +190,31 @@ void unregister_node(struct node *node)
 	sysdev_unregister(&node->sysdev);
 }
 
+struct node node_devices[MAX_NUMNODES];
+
+int register_one_node(int nid)
+{
+	int error = 0;
+
+	if (node_online(nid)) {
+		int p_node = parent_node(nid);
+		struct node *parent = NULL;
+
+		if (p_node != nid)
+			parent = &node_devices[p_node];
+
+		error = register_node(&node_devices[nid], nid, parent);
+	}
+
+	return error;
+
+}
+
+void unregister_one_node(int nid)
+{
+	unregister_node(&node_devices[nid]);
+}
+
 static int __init register_node_type(void)
 {
 	return sysdev_class_register(&node_class);
Index: pgdat14/include/asm-i386/node.h
===================================================================
--- pgdat14.orig/include/asm-i386/node.h	2006-05-18 10:38:50.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,29 +0,0 @@
-#ifndef _ASM_I386_NODE_H_
-#define _ASM_I386_NODE_H_
-
-#include <linux/device.h>
-#include <linux/mmzone.h>
-#include <linux/node.h>
-#include <linux/topology.h>
-#include <linux/nodemask.h>
-
-struct i386_node {
-	struct node node;
-};
-extern struct i386_node node_devices[MAX_NUMNODES];
-
-static inline int arch_register_node(int num){
-	int p_node;
-	struct node *parent = NULL;
-
-	if (!node_online(num))
-		return 0;
-	p_node = parent_node(num);
-
-	if (p_node != num)
-		parent = &node_devices[p_node].node;
-
-	return register_node(&node_devices[num].node, num, parent);
-}
-
-#endif /* _ASM_I386_NODE_H_ */
Index: pgdat14/mm/memory_hotplug.c
===================================================================
--- pgdat14.orig/mm/memory_hotplug.c	2006-05-18 10:38:50.000000000 +0900
+++ pgdat14/mm/memory_hotplug.c	2006-05-18 12:00:48.000000000 +0900
@@ -256,9 +256,19 @@ int add_memory(int nid, u64 start, u64 s
 	if (ret < 0)
 		goto error;
 
-	/* we online node here. we have no error path from here. */
+	/* we online node here. we can't roll back from here. */
 	node_set_online(nid);
 
+	if (new_pgdat) {
+		ret = register_one_node(nid);
+		/*
+		 * If sysfs file of new node can't create, cpu on the node
+		 * can't be hot-added. There is no rollback way now.
+		 * So, check by BUG_ON() to catch it reluctantly..
+		 */
+		BUG_ON(ret);
+	}
+
 	/* register this memory as resource */
 	register_memory_resource(start, size);
 
Index: pgdat14/include/asm-i386/cpu.h
===================================================================
--- pgdat14.orig/include/asm-i386/cpu.h	2006-05-18 10:38:50.000000000 +0900
+++ pgdat14/include/asm-i386/cpu.h	2006-05-18 10:38:54.000000000 +0900
@@ -7,8 +7,6 @@
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
 
-#include <asm/node.h>
-
 struct i386_cpu {
 	struct cpu cpu;
 };
Index: pgdat14/include/linux/node.h
===================================================================
--- pgdat14.orig/include/linux/node.h	2006-05-18 10:38:50.000000000 +0900
+++ pgdat14/include/linux/node.h	2006-05-18 10:38:54.000000000 +0900
@@ -26,8 +26,12 @@ struct node {
 	struct sys_device	sysdev;
 };
 
+extern struct node node_devices[];
+
 extern int register_node(struct node *, int, struct node *);
 extern void unregister_node(struct node *node);
+extern int register_one_node(int nid);
+extern void unregister_one_node(int nid);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

-- 
Yasunori Goto 


