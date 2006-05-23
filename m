Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWEWLAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWEWLAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 07:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWEWLAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 07:00:48 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22430 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932165AbWEWLAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 07:00:47 -0400
Date: Tue, 23 May 2006 20:02:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com, ktokunag@redhat.com,
       ashok.raj@intel.com, akpm@osdl.org
Subject: [RFC][PATCH] node hotplug [2/3] fixes callres of register_cpu
Message-Id: <20060523200205.a2f3b845.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies caller of register_cpu()/unregister_cpu, whose args are
changed by register-cpu-remove-node-struct patch.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.ocm>

 arch/arm/kernel/setup.c        |    2 +-
 arch/i386/kernel/topology.c    |   18 ++----------------
 arch/ia64/kernel/topology.c    |   17 ++---------------
 arch/m32r/kernel/setup.c       |    2 +-
 arch/mips/kernel/smp.c         |    2 +-
 arch/parisc/kernel/topology.c  |    3 +--
 arch/powerpc/kernel/setup_32.c |    2 +-
 arch/powerpc/kernel/sysfs.c    |   10 +---------
 arch/ppc/kernel/setup.c        |    2 +-
 arch/s390/kernel/smp.c         |    2 +-
 arch/sh/kernel/setup.c         |    2 +-
 arch/sh64/kernel/setup.c       |    2 +-
 arch/sparc64/kernel/setup.c    |    2 +-
 13 files changed, 15 insertions(+), 51 deletions(-)

Index: linux-2.6.17-rc4-mm3/arch/arm/kernel/setup.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/arm/kernel/setup.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/arm/kernel/setup.c	2006-05-23 19:27:16.000000000 +0900
@@ -838,7 +838,7 @@
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		register_cpu(&per_cpu(cpu_data, cpu).cpu, cpu, NULL);
+		register_cpu(&per_cpu(cpu_data, cpu).cpu, cpu);
 
 	return 0;
 }
Index: linux-2.6.17-rc4-mm3/arch/i386/kernel/topology.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/topology.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/i386/kernel/topology.c	2006-05-23 19:27:16.000000000 +0900
@@ -35,12 +35,6 @@
 int arch_register_cpu(int num){
 	struct node *parent = NULL;
 
-#ifdef CONFIG_NUMA
-	int node = cpu_to_node(num);
-	if (node_online(node))
-		parent = &node_devices[parent_node(node)];
-#endif /* CONFIG_NUMA */
-
 	/*
 	 * CPU0 cannot be offlined due to several
 	 * restrictions and assumptions in kernel. This basically
@@ -50,21 +44,13 @@
 	if (!num)
 		cpu_devices[num].cpu.no_control = 1;
 
-	return register_cpu(&cpu_devices[num].cpu, num, parent);
+	return register_cpu(&cpu_devices[num].cpu, num);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 
 void arch_unregister_cpu(int num) {
-	struct node *parent = NULL;
-
-#ifdef CONFIG_NUMA
-	int node = cpu_to_node(num);
-	if (node_online(node))
-		parent = &node_devices[parent_node(node)];
-#endif /* CONFIG_NUMA */
-
-	return unregister_cpu(&cpu_devices[num].cpu, parent);
+	return unregister_cpu(&cpu_devices[num].cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
Index: linux-2.6.17-rc4-mm3/arch/m32r/kernel/setup.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/m32r/kernel/setup.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/m32r/kernel/setup.c	2006-05-23 19:27:16.000000000 +0900
@@ -275,7 +275,7 @@
 	int i;
 
 	for_each_present_cpu(i)
-		register_cpu(&cpu_devices[i], i, NULL);
+		register_cpu(&cpu_devices[i], i);
 
 	return 0;
 }
Index: linux-2.6.17-rc4-mm3/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/mips/kernel/smp.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/mips/kernel/smp.c	2006-05-23 19:27:16.000000000 +0900
@@ -443,7 +443,7 @@
 	int ret;
 
 	for_each_possible_cpu(cpu) {
-		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu, NULL);
+		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "
 			       "failed (%d)\n", cpu, ret);
Index: linux-2.6.17-rc4-mm3/arch/parisc/kernel/topology.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/parisc/kernel/topology.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/parisc/kernel/topology.c	2006-05-23 19:27:16.000000000 +0900
@@ -26,11 +26,10 @@
 
 static int __init topology_init(void)
 {
-	struct node *parent = NULL;
 	int num;
 
 	for_each_present_cpu(num) {
-		register_cpu(&cpu_devices[num], num, parent);
+		register_cpu(&cpu_devices[num], num);
 	}
 	return 0;
 }
Index: linux-2.6.17-rc4-mm3/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/powerpc/kernel/setup_32.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/powerpc/kernel/setup_32.c	2006-05-23 19:27:16.000000000 +0900
@@ -215,7 +215,7 @@
 
 	/* register CPU devices */
 	for_each_possible_cpu(i)
-		register_cpu(&cpu_devices[i], i, NULL);
+		register_cpu(&cpu_devices[i], i);
 
 	/* call platform init */
 	if (ppc_md.init != NULL) {
Index: linux-2.6.17-rc4-mm3/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/powerpc/kernel/sysfs.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/powerpc/kernel/sysfs.c	2006-05-23 19:27:16.000000000 +0900
@@ -357,14 +357,6 @@
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
-#ifdef CONFIG_NUMA
-		/* The node to which a cpu belongs can't be known
-		 * until the cpu is made present.
-		 */
-		parent = NULL;
-		if (cpu_present(cpu))
-			parent = &node_devices[cpu_to_node(cpu)];
-#endif
 		/*
 		 * For now, we just see if the system supports making
 		 * the RTAS calls for CPU hotplug.  But, there may be a
@@ -376,7 +368,7 @@
 			c->no_control = 1;
 
 		if (cpu_online(cpu) || (c->no_control == 0)) {
-			register_cpu(c, cpu, parent);
+			register_cpu(c, cpu);
 
 			sysdev_create_file(&c->sysdev, &attr_physical_id);
 		}
Index: linux-2.6.17-rc4-mm3/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/ppc/kernel/setup.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/ppc/kernel/setup.c	2006-05-23 19:27:16.000000000 +0900
@@ -475,7 +475,7 @@
 
 	/* register CPU devices */
 	for_each_possible_cpu(i)
-		register_cpu(&cpu_devices[i], i, NULL);
+		register_cpu(&cpu_devices[i], i);
 
 	/* call platform init */
 	if (ppc_md.init != NULL) {
Index: linux-2.6.17-rc4-mm3/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/s390/kernel/smp.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/s390/kernel/smp.c	2006-05-23 19:27:16.000000000 +0900
@@ -869,7 +869,7 @@
 	int ret;
 
 	for_each_possible_cpu(cpu) {
-		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu, NULL);
+		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "
 			       "failed (%d)\n", cpu, ret);
Index: linux-2.6.17-rc4-mm3/arch/sh/kernel/setup.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/sh/kernel/setup.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/sh/kernel/setup.c	2006-05-23 19:27:16.000000000 +0900
@@ -402,7 +402,7 @@
 	int cpu_id;
 
 	for_each_possible_cpu(cpu_id)
-		register_cpu(&cpu[cpu_id], cpu_id, NULL);
+		register_cpu(&cpu[cpu_id], cpu_id);
 
 	return 0;
 }
Index: linux-2.6.17-rc4-mm3/arch/sh64/kernel/setup.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/sh64/kernel/setup.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/sh64/kernel/setup.c	2006-05-23 19:27:16.000000000 +0900
@@ -309,7 +309,7 @@
 
 static int __init topology_init(void)
 {
-	return register_cpu(cpu, 0, NULL);
+	return register_cpu(cpu, 0);
 }
 
 subsys_initcall(topology_init);
Index: linux-2.6.17-rc4-mm3/arch/sparc64/kernel/setup.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/sparc64/kernel/setup.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/sparc64/kernel/setup.c	2006-05-23 19:27:16.000000000 +0900
@@ -514,7 +514,7 @@
 	for_each_possible_cpu(i) {
 		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (p) {
-			register_cpu(p, i, NULL);
+			register_cpu(p, i);
 			err = 0;
 		}
 	}
Index: linux-2.6.17-rc4-mm3/arch/ia64/kernel/topology.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/ia64/kernel/topology.c	2006-05-23 19:23:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/ia64/kernel/topology.c	2006-05-23 19:27:16.000000000 +0900
@@ -30,12 +30,6 @@
 
 int arch_register_cpu(int num)
 {
-	struct node *parent = NULL;
-	
-#ifdef CONFIG_NUMA
-	parent = &node_devices[cpu_to_node(num)];
-#endif /* CONFIG_NUMA */
-
 #if defined (CONFIG_ACPI) && defined (CONFIG_HOTPLUG_CPU)
 	/*
 	 * If CPEI cannot be re-targetted, and this is
@@ -45,21 +39,14 @@
 		sysfs_cpus[num].cpu.no_control = 1;
 #endif
 
-	return register_cpu(&sysfs_cpus[num].cpu, num, parent);
+	return register_cpu(&sysfs_cpus[num].cpu, num);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 
 void arch_unregister_cpu(int num)
 {
-	struct node *parent = NULL;
-
-#ifdef CONFIG_NUMA
-	int node = cpu_to_node(num);
-	parent = &node_devices[node];
-#endif /* CONFIG_NUMA */
-
-	return unregister_cpu(&sysfs_cpus[num].cpu, parent);
+	return unregister_cpu(&sysfs_cpus[num].cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);

