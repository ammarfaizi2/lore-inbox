Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWEPMXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWEPMXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWEPMXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:23:34 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30851 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751803AbWEPMXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:23:33 -0400
Date: Tue, 16 May 2006 21:23:00 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Register sysfs file for hotpluged new node
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060516210608.A3E5.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is the last part of patches for new nodes addition v4.
It is to create sysfs file for new node.

It adds arch specific functions 'arch_register_node()'
and 'arch_unregister_node()' to call the generic
function 'register_node()' and 'unregister_node()' respectively
for each architecture. 
The relationship between parent node and new node can/will be
updated at arch_register_node() for each arch.

I defined this function just for ia64 in the previous patch.
But, it would be compile error for other arch.
So, I add x86 and powerpc.

x86-64 uses i386's topology.c. But, current i386's arch_register_node()
is defined at include/asm-i386/node.h. x86-64 can't use it.
So, I moved i386's arch_register_node() from it to i386's topology.c.
Powerpc's one is just part of register_nodes().

Please apply.

-------------------------------------
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

 arch/i386/kernel/topology.c |   19 +++++++++++++++++++
 arch/ia64/kernel/topology.c |   11 +++++++++++
 arch/powerpc/kernel/sysfs.c |   33 +++++++++++++++++++++++----------
 include/asm-i386/node.h     |   14 --------------
 include/linux/node.h        |    2 ++
 mm/memory_hotplug.c         |   10 ++++++++++
 6 files changed, 65 insertions(+), 24 deletions(-)

Index: pgdat14/arch/ia64/kernel/topology.c
===================================================================
--- pgdat14.orig/arch/ia64/kernel/topology.c	2006-05-15 19:12:59.000000000 +0900
+++ pgdat14/arch/ia64/kernel/topology.c	2006-05-15 19:13:04.000000000 +0900
@@ -68,6 +68,17 @@ EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
+#ifdef CONFIG_NUMA
+int arch_register_node(int num)
+{
+	return register_node(&sysfs_nodes[num], num, 0);
+}
+
+void arch_unregister_node(int num)
+{
+	unregister_node(&sysfs_nodes[num]);
+}
+#endif
 
 static int __init topology_init(void)
 {
Index: pgdat14/include/linux/node.h
===================================================================
--- pgdat14.orig/include/linux/node.h	2006-05-15 19:12:59.000000000 +0900
+++ pgdat14/include/linux/node.h	2006-05-15 19:13:04.000000000 +0900
@@ -28,6 +28,8 @@ struct node {
 
 extern int register_node(struct node *, int, struct node *);
 extern void unregister_node(struct node *node);
+extern int arch_register_node(int num);
+extern void arch_unregister_node(int num);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 
Index: pgdat14/mm/memory_hotplug.c
===================================================================
--- pgdat14.orig/mm/memory_hotplug.c	2006-05-15 19:12:59.000000000 +0900
+++ pgdat14/mm/memory_hotplug.c	2006-05-16 12:06:16.000000000 +0900
@@ -259,6 +259,16 @@ int add_memory(int nid, u64 start, u64 s
 	/* we online node here. we have no error path from here. */
 	node_set_online(nid);
 
+	/*
+	 * register this node to sysfs.
+	 * this is depends on topology. So each arch has its own.
+	 */
+	if (new_pgdat){
+		ret = arch_register_node(nid);
+		BUG_ON(ret);
+	}
+
+
 	/* register this memory as resource */
 	register_memory_resource(start, size);
 
Index: pgdat14/arch/i386/kernel/topology.c
===================================================================
--- pgdat14.orig/arch/i386/kernel/topology.c	2006-05-15 19:12:59.000000000 +0900
+++ pgdat14/arch/i386/kernel/topology.c	2006-05-15 19:13:04.000000000 +0900
@@ -78,6 +78,25 @@ EXPORT_SYMBOL(arch_unregister_cpu);
 
 struct i386_node node_devices[MAX_NUMNODES];
 
+int arch_register_node(int num){
+	int p_node;
+	struct node *parent = NULL;
+
+	if (!node_online(num))
+		return 0;
+	p_node = parent_node(num);
+
+	if (p_node != num)
+		parent = &node_devices[p_node].node;
+
+	return register_node(&node_devices[num].node, num, parent);
+}
+
+void arch_unregister_node(int num)
+{
+	unregister_node(&node_devices[num].node);
+}
+
 static int __init topology_init(void)
 {
 	int i;
Index: pgdat14/include/asm-i386/node.h
===================================================================
--- pgdat14.orig/include/asm-i386/node.h	2006-05-15 19:12:59.000000000 +0900
+++ pgdat14/include/asm-i386/node.h	2006-05-15 19:13:04.000000000 +0900
@@ -12,18 +12,4 @@ struct i386_node {
 };
 extern struct i386_node node_devices[MAX_NUMNODES];
 
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
 #endif /* _ASM_I386_NODE_H_ */
Index: pgdat14/arch/powerpc/kernel/sysfs.c
===================================================================
--- pgdat14.orig/arch/powerpc/kernel/sysfs.c	2006-05-15 19:12:59.000000000 +0900
+++ pgdat14/arch/powerpc/kernel/sysfs.c	2006-05-15 19:13:04.000000000 +0900
@@ -306,21 +306,34 @@ static struct notifier_block sysfs_cpu_n
 #ifdef CONFIG_NUMA
 static struct node node_devices[MAX_NUMNODES];
 
+int arch_register_node(int i)
+{
+	int error = 0;
+
+	if (node_online(i)){
+		int p_node = parent_node(i);
+		struct node *parent = NULL;
+
+		if (p_node != i)
+			parent = &node_devices[p_node];
+		error = register_node(&node_devices[i], i, parent);
+	}
+
+	return error;
+}
+
+void arch_unregister_node(int i)
+{
+	unregister_node(&node_devices[i]);
+}
+
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
+	for (i = 0; i < MAX_NUMNODES; i++)
+		arch_register_node(i);
 
-			register_node(&node_devices[i], i, parent);
-		}
-	}
 }
 
 int sysfs_add_device_to_node(struct sys_device *dev, int nid)

-- 
Yasunori Goto 


