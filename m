Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUK0EJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUK0EJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUK0EHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:07:51 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2498 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261232AbUKZTUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:20:38 -0500
Date: Fri, 26 Nov 2004 14:59:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Paul 'Rusty' Russell" <rusty@rustcorp.com.au>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Tweaks to ppc64 cpu sysfs information
Message-ID: <20041126035959.GK11370@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul 'Rusty' Russell <rusty@rustcorp.com.au>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Currently the ppc64 sysfs code registers an entry for each possible
cpu in sysfs, rather than just online cpus.  That makes sense, since
the sysfs entries are needed to control onlining of the cpus.
However, this is done even if CONFIG_HOTPLUG_CPU is not set, or if it
is not a hotplug capable (DLPAR) machine, which is a bit misleading.
Secondly it also registers all the other sysfs entries (mostly
performance monitoring controls) on all possible cpus, although they
are quite meaningless on non-online cpus.

This patch alters the code to only register sysfs directories at boot
for cpus which are either online or could be onlined (cpu is possible,
and CONFIG_HOTPLUG_CPU and an lpar machine).  Furthermore, the entries
apart from 'online' itself and 'physical_id' are only registered for
online CPUs (and deregistered again if a cpu goes offline).

Currently the ppc64 sysfs code registers an entry for each possible
cpu in sysfs, rather than just online cpus.  That makes sense, since
the sysfs entries are needed to control onlining of the cpus.
However, this is done even if CONFIG_HOTPLUG_CPU is not set, or if it
is not a hotplug capable (DLPAR) machine, which is a bit misleading.
Secondly it also registers all the other sysfs entries (mostly
performance monitoring controls) on all possible cpus, although they
are quite meaningless on non-online cpus.

This patch alters the code to only register sysfs directories at boot
for cpus which are either online or could be onlined (cpu is possible,
and CONFIG_HOTPLUG_CPU and an lpar machine).  Furthermore, the entries
apart from 'online' itself and 'physical_id' are only registered for
online CPUs (and deregistered again if a cpu goes offline).

Index: working-2.6/arch/ppc64/kernel/sysfs.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/sysfs.c	2004-11-17 11:19:38.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/sysfs.c	2004-11-26 12:28:39.064454600 +1100
@@ -7,6 +7,8 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/nodemask.h>
+#include <linux/cpumask.h>
+#include <linux/notifier.h>
 
 #include <asm/current.h>
 #include <asm/processor.h>
@@ -15,6 +17,8 @@
 #include <asm/prom.h>
 
 
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
+
 /* SMT stuff */
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
@@ -255,8 +259,18 @@
 static SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8);
 static SYSDEV_ATTR(purr, 0600, show_purr, NULL);
 
-static void __init register_cpu_pmc(struct sys_device *s)
+static void register_cpu_online(unsigned int cpu)
 {
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+	struct sys_device *s = &c->sysdev;
+
+#ifndef CONFIG_PPC_ISERIES
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		sysdev_create_file(s, &attr_smt_snooze_delay);
+#endif
+
+	/* PMC stuff */
+
 	sysdev_create_file(s, &attr_mmcr0);
 	sysdev_create_file(s, &attr_mmcr1);
 
@@ -279,6 +293,65 @@
 		sysdev_create_file(s, &attr_purr);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void unregister_cpu_online(unsigned int cpu)
+{
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+	struct sys_device *s = &c->sysdev;
+
+	BUG_ON(c->no_control);
+
+#ifndef CONFIG_PPC_ISERIES
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		sysdev_remove_file(s, &attr_smt_snooze_delay);
+#endif
+
+	/* PMC stuff */
+
+	sysdev_remove_file(s, &attr_mmcr0);
+	sysdev_remove_file(s, &attr_mmcr1);
+
+	if (cur_cpu_spec->cpu_features & CPU_FTR_MMCRA)
+		sysdev_remove_file(s, &attr_mmcra);
+
+	sysdev_remove_file(s, &attr_pmc1);
+	sysdev_remove_file(s, &attr_pmc2);
+	sysdev_remove_file(s, &attr_pmc3);
+	sysdev_remove_file(s, &attr_pmc4);
+	sysdev_remove_file(s, &attr_pmc5);
+	sysdev_remove_file(s, &attr_pmc6);
+
+	if (cur_cpu_spec->cpu_features & CPU_FTR_PMC8) {
+		sysdev_remove_file(s, &attr_pmc7);
+		sysdev_remove_file(s, &attr_pmc8);
+	}
+
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		sysdev_remove_file(s, &attr_purr);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static int __devinit sysfs_cpu_notify(struct notifier_block *self, 
+				      unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned int)(long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+		register_cpu_online(cpu);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		unregister_cpu_online(cpu);
+		break;
+#endif
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata sysfs_cpu_nb = {
+	.notifier_call	= sysfs_cpu_notify,
+};
 
 /* NUMA stuff */
 
@@ -308,8 +381,7 @@
 }
 #endif
 
-
-/* Only valid if CPU is online. */
+/* Only valid if CPU is present. */
 static ssize_t show_physical_id(struct sys_device *dev, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
@@ -318,9 +390,6 @@
 }
 static SYSDEV_ATTR(physical_id, 0444, show_physical_id, NULL);
 
-
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
-
 static int __init topology_init(void)
 {
 	int cpu;
@@ -328,6 +397,8 @@
 
 	register_nodes();
 
+	register_cpu_notifier(&sysfs_cpu_nb);
+
 	for_each_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
@@ -341,19 +412,19 @@
 		 * CPU.  For instance, the boot cpu might never be valid
 		 * for hotplugging.
 		 */
+#ifdef CONFIG_HOTPLUG_CPU
 		if (systemcfg->platform != PLATFORM_PSERIES_LPAR)
+#endif
 			c->no_control = 1;
 
-		register_cpu(c, cpu, parent);
-
-		register_cpu_pmc(&c->sysdev);
+		if (cpu_online(cpu) || (c->no_control == 0)) {
+			register_cpu(c, cpu, parent);
 
-		sysdev_create_file(&c->sysdev, &attr_physical_id);
+			sysdev_create_file(&c->sysdev, &attr_physical_id);
+		}
 
-#ifndef CONFIG_PPC_ISERIES
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-			sysdev_create_file(&c->sysdev, &attr_smt_snooze_delay);
-#endif
+		if (cpu_online(cpu))
+			register_cpu_online(cpu);
 	}
 
 	return 0;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
