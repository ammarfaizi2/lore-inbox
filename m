Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWEWK7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWEWK7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 06:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEWK7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 06:59:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25007 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750959AbWEWK7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 06:59:41 -0400
Date: Tue, 23 May 2006 20:00:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com, ktokunag@redhat.com,
       ashok.raj@intel.com, akpm@osdl.org
Subject: [RFC][PATCH] node hotplug [1/3] register-cpu-remove-node-struct
Message-Id: <20060523200044.55c555a1.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes node arguments from register_cpu().

Now, register_cpu() requires 'struct node' as its argument.
But the array of struct node is now unified in driver/base/node.c now
(By Goto's node hotplug patch).
We can get struct node in generic way. So, this argument is not necessary now. 

This patch also guarantees add cpu under node only when node is onlined.
It is necessary for node-hot-add vs. cpu-hot-add patch following this.

Moreover, register_cpu calculates cpu->node_id by cpu_to_node() without regard
to its 'struct node *root' argument. This patch removes it.

Patches for fixing the caller of register_cpu() for each arch will follow this.

Signed-Off-By : KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 drivers/base/cpu.c   |   18 ++++++++----------
 drivers/base/node.c  |   32 ++++++++++++++++++++++++++++++++
 include/linux/cpu.h  |    2 +-
 include/linux/node.h |   13 +++++++++++++
 4 files changed, 54 insertions(+), 11 deletions(-)

Index: linux-2.6.17-rc4-mm3/drivers/base/cpu.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/base/cpu.c	2006-05-23 17:31:49.000000000 +0900
+++ linux-2.6.17-rc4-mm3/drivers/base/cpu.c	2006-05-23 19:18:18.000000000 +0900
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/device.h>
+#include <linux/node.h>
 
 #include "base.h"
 
@@ -57,13 +58,12 @@
 {
 	sysdev_create_file(&cpu->sysdev, &attr_online);
 }
-void unregister_cpu(struct cpu *cpu, struct node *root)
+void unregister_cpu(struct cpu *cpu)
 {
 	int logical_cpu = cpu->sysdev.id;
 
-	if (root)
-		sysfs_remove_link(&root->sysdev.kobj,
-				  kobject_name(&cpu->sysdev.kobj));
+	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
+
 	sysdev_remove_file(&cpu->sysdev, &attr_online);
 
 	sysdev_unregister(&cpu->sysdev);
@@ -109,23 +109,21 @@
  *
  * Initialize and register the CPU device.
  */
-int __devinit register_cpu(struct cpu *cpu, int num, struct node *root)
+int __devinit register_cpu(struct cpu *cpu, int num)
 {
 	int error;
-
 	cpu->node_id = cpu_to_node(num);
 	cpu->sysdev.id = num;
 	cpu->sysdev.cls = &cpu_sysdev_class;
 
 	error = sysdev_register(&cpu->sysdev);
-	if (!error && root)
-		error = sysfs_create_link(&root->sysdev.kobj,
-					  &cpu->sysdev.kobj,
-					  kobject_name(&cpu->sysdev.kobj));
+
 	if (!error && !cpu->no_control)
 		register_cpu_control(cpu);
 	if (!error)
 		cpu_sys_devices[num] = &cpu->sysdev;
+	if (!error)
+		register_cpu_under_node(num, cpu_to_node(num));
 
 #ifdef CONFIG_KEXEC
 	if (!error)
Index: linux-2.6.17-rc4-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/base/node.c	2006-05-23 17:33:00.000000000 +0900
+++ linux-2.6.17-rc4-mm3/drivers/base/node.c	2006-05-23 19:21:26.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/cpumask.h>
 #include <linux/topology.h>
 #include <linux/nodemask.h>
+#include <linux/cpu.h>
 
 static struct sysdev_class node_class = {
 	set_kset_name("node"),
@@ -192,6 +193,37 @@
 
 struct node node_devices[MAX_NUMNODES];
 
+/*
+ * register cpu under node
+ */
+int register_cpu_under_node(unsigned int cpu, unsigned int nid)
+{
+	struct sys_device *obj;
+	if (node_online(nid)) {
+		obj = get_cpu_sysdev(cpu);
+		if (!obj)
+			return 0;
+		return sysfs_create_link(&node_devices[nid].sysdev.kobj,
+					 &obj->kobj,
+					 kobject_name(&obj->kobj));
+	 }
+
+	return 0;
+}
+
+int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
+{
+	struct sys_device *obj;
+	if (node_online(nid)) {
+		obj = get_cpu_sysdev(cpu);
+		if (!obj)
+			return 0;
+		return sysfs_remove_link(&node_devices[nid].sysdev.kobj,
+					 kobject_name(&obj->kobj));
+	}
+	return 0;
+}
+
 int register_one_node(int nid)
 {
 	int error = 0;
Index: linux-2.6.17-rc4-mm3/include/linux/node.h
===================================================================
--- linux-2.6.17-rc4-mm3.orig/include/linux/node.h	2006-05-23 17:33:06.000000000 +0900
+++ linux-2.6.17-rc4-mm3/include/linux/node.h	2006-05-23 19:14:30.000000000 +0900
@@ -32,6 +32,19 @@
 extern void unregister_node(struct node *node);
 extern int register_one_node(int nid);
 extern void unregister_one_node(int nid);
+#ifdef CONFIG_NUMA
+extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
+extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
+#else
+static inline int register_cpu_under_node(unsigned int cpu, unsigned int nid)
+{
+	return 0;
+}
+static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
+{
+	return 0;
+}
+#endif
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 
Index: linux-2.6.17-rc4-mm3/include/linux/cpu.h
===================================================================
--- linux-2.6.17-rc4-mm3.orig/include/linux/cpu.h	2006-05-23 17:31:58.000000000 +0900
+++ linux-2.6.17-rc4-mm3/include/linux/cpu.h	2006-05-23 19:24:23.000000000 +0900
@@ -31,10 +31,10 @@
 	struct sys_device sysdev;
 };
 
-extern int register_cpu(struct cpu *, int, struct node *);
+extern int register_cpu(struct cpu *, int);
 extern struct sys_device *get_cpu_sysdev(unsigned cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-extern void unregister_cpu(struct cpu *, struct node *);
+extern void unregister_cpu(struct cpu *);
 #endif
 struct notifier_block;
 

