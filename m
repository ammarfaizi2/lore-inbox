Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUJXJmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUJXJmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUJXJmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:42:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61411 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261406AbUJXJm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:42:28 -0400
Date: Sun, 24 Oct 2004 05:42:17 -0400
From: Nathan Lynch <nathanl@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rusty@rustcorp.com.au,
       Nathan Lynch <nathanl@austin.ibm.com>, mochel@digitalimplant.org,
       anton@samba.org
Message-Id: <20041024094559.28808.12445.63352@biclops>
In-Reply-To: <20041024094551.28808.28284.87316@biclops>
References: <20041024094551.28808.28284.87316@biclops>
Subject: [RFC/PATCH 1/4] dynamic cpu registration - core changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Register cpu system devices in the core code instead of leaving it to
the architecture.  At boot, allocate an array of num_possible_cpus()
cpu sysdevs, and register sysdevs for cpus which are marked present.
Also, leave to the node "driver" the creation of symlinks from node to
cpu devices.

Change register_cpu so that it no longer requires struct cpu* and
struct node * arguments, only a logical cpu number.  Break the weird
cpu->no_control semantics (for now).  Introduce unregister_cpu, which
removes the cpu entry from sysfs.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN drivers/base/cpu.c~dynamic-cpu-registration drivers/base/cpu.c
--- 2.6.10-rc1/drivers/base/cpu.c~dynamic-cpu-registration	2004-10-24 00:09:39.000000000 -0500
+++ 2.6.10-rc1-nathanl/drivers/base/cpu.c	2004-10-24 03:50:13.000000000 -0500
@@ -56,35 +56,60 @@ static inline void register_cpu_control(
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static struct cpu *cpu_devices;
+
 /*
  * register_cpu - Setup a driverfs device for a CPU.
- * @cpu - Callers can set the cpu->no_control field to 1, to indicate not to
- *		  generate a control file in sysfs for this CPU.
  * @num - CPU number to use when creating the device.
  *
  * Initialize and register the CPU device.
  */
-int __init register_cpu(struct cpu *cpu, int num, struct node *root)
+int register_cpu(int num)
 {
 	int error;
+	struct cpu *cpu = &cpu_devices[num];
+
+	memset(cpu, 0, sizeof(*cpu));
 
 	cpu->node_id = cpu_to_node(num);
 	cpu->sysdev.id = num;
 	cpu->sysdev.cls = &cpu_sysdev_class;
 
 	error = sysdev_register(&cpu->sysdev);
-	if (!error && root)
-		error = sysfs_create_link(&root->sysdev.kobj,
-					  &cpu->sysdev.kobj,
-					  kobject_name(&cpu->sysdev.kobj));
+
+	/* XXX FIXME: cpu->no_control is always zero...
+	 * Maybe should introduce an arch-overridable "hotpluggable" map.
+	 */
 	if (!error && !cpu->no_control)
 		register_cpu_control(cpu);
 	return error;
 }
 
+void unregister_cpu(int num)
+{
+	struct cpu *cpu = &cpu_devices[num];
 
+	sysdev_remove_file(&cpu->sysdev, &attr_online);
+	sysdev_unregister(&cpu->sysdev);
+}
 
 int __init cpu_dev_init(void)
 {
-	return sysdev_class_register(&cpu_sysdev_class);
+	unsigned int cpu;
+	int ret = -ENOMEM;
+	size_t size = sizeof(*cpu_devices) * num_possible_cpus();
+
+	cpu_devices = kmalloc(size, GFP_KERNEL);
+	if (!cpu_devices)
+		goto out;
+
+	sysdev_class_register(&cpu_sysdev_class);
+
+	for_each_present_cpu(cpu) {
+		ret = register_cpu(cpu);
+		if (ret)
+			goto out;
+	}
+out:
+	return ret;
 }
diff -puN include/linux/cpu.h~dynamic-cpu-registration include/linux/cpu.h
--- 2.6.10-rc1/include/linux/cpu.h~dynamic-cpu-registration	2004-10-24 00:09:39.000000000 -0500
+++ 2.6.10-rc1-nathanl/include/linux/cpu.h	2004-10-24 03:52:43.000000000 -0500
@@ -31,7 +31,8 @@ struct cpu {
 	struct sys_device sysdev;
 };
 
-extern int register_cpu(struct cpu *, int, struct node *);
+extern int register_cpu(int);
+extern void unregister_cpu(int);
 struct notifier_block;
 
 #ifdef CONFIG_SMP

_
