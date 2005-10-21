Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVJXSCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVJXSCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJXSCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:02:46 -0400
Received: from fmr21.intel.com ([143.183.121.13]:48102 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751209AbVJXSCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:02:16 -0400
Message-Id: <20051021204327.523491000@araj-sfield>
References: <20051021203818.753754000@araj-sfield>
Date: Fri, 21 Oct 2005 13:38:19 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org, linux@brodo.de
Cc: davej@redhat.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 1/4] introduce get_cpu_sysdev() to retrieve a sysfs entry for a cpu.
Content-Disposition: inline; filename=get-cpu-sysdev
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some modules creating sysfs entries under /sys/devices/system/cpu/cpuX/
need to know the parent sysfs entry to make devices under them. This will
just return the sysfs entry for a given cpu.

sysfs entries showing under each cpu sysfs can be easily created if such
entries can be created by registering a sysfs driver for cpuclass. The issue
is when the entry is created the CPU may not be online, hence we would need to 
defer the creation until the online notification comes.

Current users: cache entries for Intel CPU's and cpufreq subsystem.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
----------------------------------------------------
 drivers/base/cpu.c  |   17 +++++++++++++++++
 include/linux/cpu.h |    1 +
 2 files changed, 18 insertions(+)

Index: linux-2.6.14-rc4-mm1/drivers/base/cpu.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/base/cpu.c
+++ linux-2.6.14-rc4-mm1/drivers/base/cpu.c
@@ -9,6 +9,16 @@
 #include <linux/topology.h>
 #include <linux/device.h>
 
+static struct sys_device	*cpu_sys_devices[NR_CPUS];
+
+struct sys_device *get_cpu_sysdev(int cpu)
+{
+	if (cpu < NR_CPUS)
+		return cpu_sys_devices[cpu];
+	else
+		return NULL;
+}
+EXPORT_SYMBOL(get_cpu_sysdev);
 
 struct sysdev_class cpu_sysdev_class = {
 	set_kset_name("cpu"),
@@ -64,12 +74,15 @@ static void __devinit register_cpu_contr
 void unregister_cpu(struct cpu *cpu, struct node *root)
 {
 
+	int logical_cpu = cpu->sysdev.id;
+
 	if (root)
 		sysfs_remove_link(&root->sysdev.kobj,
 				  kobject_name(&cpu->sysdev.kobj));
 	sysdev_remove_file(&cpu->sysdev, &attr_online);
 
 	sysdev_unregister(&cpu->sysdev);
+	cpu_sys_devices[logical_cpu] = NULL;
 
 	return;
 }
@@ -102,6 +115,10 @@ int __devinit register_cpu(struct cpu *c
 					  kobject_name(&cpu->sysdev.kobj));
 	if (!error && !cpu->no_control)
 		register_cpu_control(cpu);
+
+	if (!error)
+		cpu_sys_devices[num] = &cpu->sysdev;
+
 	return error;
 }
 
Index: linux-2.6.14-rc4-mm1/include/linux/cpu.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/cpu.h
+++ linux-2.6.14-rc4-mm1/include/linux/cpu.h
@@ -32,6 +32,7 @@ struct cpu {
 };
 
 extern int register_cpu(struct cpu *, int, struct node *);
+extern struct sys_device *get_cpu_sysdev(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif

--

