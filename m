Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUJXJsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUJXJsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUJXJqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:46:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41617 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261408AbUJXJmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:42:47 -0400
Date: Sun, 24 Oct 2004 05:42:38 -0400
From: Nathan Lynch <nathanl@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rusty@rustcorp.com.au, mochel@digitalimplant.org,
       Nathan Lynch <nathanl@austin.ibm.com>, anton@samba.org
Message-Id: <20041024094620.28808.11564.28125@biclops>
In-Reply-To: <20041024094551.28808.28284.87316@biclops>
References: <20041024094551.28808.28284.87316@biclops>
Subject: [RFC/PATCH 4/4] ppc64: convert to sysdev_driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert arch/ppc64/kernel/sysfs.c to use a sysdev_driver for setting
up platform-specific cpu attributes.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN arch/ppc64/kernel/sysfs.c~ppc64-convert-to-sysdev_driver arch/ppc64/kernel/sysfs.c
--- 2.6.10-rc1/arch/ppc64/kernel/sysfs.c~ppc64-convert-to-sysdev_driver	2004-10-24 03:57:05.000000000 -0500
+++ 2.6.10-rc1-nathanl/arch/ppc64/kernel/sysfs.c	2004-10-24 03:57:05.000000000 -0500
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/module.h>
-#include <linux/nodemask.h>
 
 #include <asm/current.h>
 #include <asm/processor.h>
@@ -261,7 +260,7 @@ static SYSDEV_ATTR(pmc7, 0600, show_pmc7
 static SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8);
 static SYSDEV_ATTR(purr, 0600, show_purr, NULL);
 
-static void __init register_cpu_pmc(struct sys_device *s)
+static void register_cpu_pmc(struct sys_device *s)
 {
 	sysdev_create_file(s, &attr_mmcr0);
 	sysdev_create_file(s, &attr_mmcr1);
@@ -285,37 +284,32 @@ static void __init register_cpu_pmc(stru
 		sysdev_create_file(s, &attr_purr);
 }
 
-
-/* NUMA stuff */
-
-#ifdef CONFIG_NUMA
-static struct node node_devices[MAX_NUMNODES];
-
-static void register_nodes(void)
+#ifdef CONFIG_HOTPLUG_CPU
+static void unregister_cpu_pmc(struct sys_device *s)
 {
-	int i;
+	sysdev_remove_file(s, &attr_mmcr0);
+	sysdev_remove_file(s, &attr_mmcr1);
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (node_online(i)) {
-			int p_node = parent_node(i);
-			struct node *parent = NULL;
+	if (cur_cpu_spec->cpu_features & CPU_FTR_MMCRA)
+		sysdev_remove_file(s, &attr_mmcra);
 
-			if (p_node != i)
-				parent = &node_devices[p_node];
+	sysdev_remove_file(s, &attr_pmc1);
+	sysdev_remove_file(s, &attr_pmc2);
+	sysdev_remove_file(s, &attr_pmc3);
+	sysdev_remove_file(s, &attr_pmc4);
+	sysdev_remove_file(s, &attr_pmc5);
+	sysdev_remove_file(s, &attr_pmc6);
 
-			register_node(&node_devices[i], i, parent);
-		}
+	if (cur_cpu_spec->cpu_features & CPU_FTR_PMC8) {
+		sysdev_remove_file(s, &attr_pmc7);
+		sysdev_remove_file(s, &attr_pmc8);
 	}
-}
-#else
-static void register_nodes(void)
-{
-	return;
-}
-#endif
 
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		sysdev_remove_file(s, &attr_purr);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 
-/* Only valid if CPU is online. */
 static ssize_t show_physical_id(struct sys_device *dev, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
@@ -324,44 +318,44 @@ static ssize_t show_physical_id(struct s
 }
 static SYSDEV_ATTR(physical_id, 0444, show_physical_id, NULL);
 
-
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
-
-static int __init topology_init(void)
+static int ppc64_cpu_add_dev(struct sys_device *sys_dev)
 {
-	int cpu;
-	struct node *parent = NULL;
-
-	register_nodes();
+	register_cpu_pmc(sys_dev);
 
-	for_each_cpu(cpu) {
-		struct cpu *c = &per_cpu(cpu_devices, cpu);
+	sysdev_create_file(sys_dev, &attr_physical_id);
 
-#ifdef CONFIG_NUMA
-		parent = &node_devices[cpu_to_node(cpu)];
+#ifndef CONFIG_PPC_ISERIES
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		sysdev_create_file(sys_dev, &attr_smt_snooze_delay);
 #endif
-		/*
-		 * For now, we just see if the system supports making
-		 * the RTAS calls for CPU hotplug.  But, there may be a
-		 * more comprehensive way to do this for an individual
-		 * CPU.  For instance, the boot cpu might never be valid
-		 * for hotplugging.
-		 */
-		if (systemcfg->platform != PLATFORM_PSERIES_LPAR)
-			c->no_control = 1;
-
-		register_cpu(c, cpu, parent);
+	return 0;
+}
 
-		register_cpu_pmc(&c->sysdev);
+#ifdef CONFIG_HOTPLUG_CPU
+static int ppc64_cpu_remove_dev (struct sys_device * sys_dev)
+{
+	unregister_cpu_pmc(sys_dev);
 
-		sysdev_create_file(&c->sysdev, &attr_physical_id);
+	sysdev_remove_file(sys_dev, &attr_physical_id);
 
 #ifndef CONFIG_PPC_ISERIES
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-			sysdev_create_file(&c->sysdev, &attr_smt_snooze_delay);
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		sysdev_remove_file(sys_dev, &attr_smt_snooze_delay);
 #endif
-	}
-
 	return 0;
 }
+#else
+#define ppc64_cpu_remove_dev NULL
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static struct sysdev_driver ppc64_cpu_sysdev_driver = {
+	.add		= ppc64_cpu_add_dev,
+	.remove		= ppc64_cpu_remove_dev,
+};
+
+static int __init topology_init(void)
+{
+	return sysdev_driver_register(&cpu_sysdev_class,
+				      &ppc64_cpu_sysdev_driver);
+}
 __initcall(topology_init);

_
