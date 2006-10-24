Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWJXQl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWJXQl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWJXQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:27380 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030417AbWJXQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:04 -0400
Message-Id: <20061024163816.460479000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:24 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 11/16] sysfs: add support for adding/removing spu sysfs attributes
Content-Disposition: inline; filename=cpu-add-attributes.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Krafft <krafft@de.ibm.com>

This patch adds two functions to create and remove sysfs attributes and
attribute_group to all cpus.  That allows to register sysfs attributes in
a subdirectory like: /sys/devices/system/cpu/cpuX/group_name/what_ever
This will be used by cbe_thermal to group all attributes dealing with
thermal support in one directory.

Signed-of-by: Christian Krafft <krafft@de.ibm.com>

Index: linux-2.6/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6/arch/powerpc/kernel/sysfs.c
@@ -299,6 +299,72 @@ static struct notifier_block __cpuinitda
 	.notifier_call	= sysfs_cpu_notify,
 };
 
+static DEFINE_MUTEX(cpu_mutex);
+
+int cpu_add_sysdev_attr(struct sysdev_attribute *attr)
+{
+	int cpu;
+
+	mutex_lock(&cpu_mutex);
+
+	for_each_possible_cpu(cpu) {
+		sysdev_create_file(get_cpu_sysdev(cpu), attr);
+	}
+
+	mutex_unlock(&cpu_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpu_add_sysdev_attr);
+
+int cpu_add_sysdev_attr_group(struct attribute_group *attrs)
+{
+	int cpu;
+	struct sys_device *sysdev;
+
+	mutex_lock(&cpu_mutex);
+
+	for_each_possible_cpu(cpu) {
+		sysdev = get_cpu_sysdev(cpu);
+		sysfs_create_group(&sysdev->kobj, attrs);
+	}
+
+	mutex_unlock(&cpu_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpu_add_sysdev_attr_group);
+
+
+void cpu_remove_sysdev_attr(struct sysdev_attribute *attr)
+{
+	int cpu;
+
+	mutex_lock(&cpu_mutex);
+
+	for_each_possible_cpu(cpu) {
+		sysdev_remove_file(get_cpu_sysdev(cpu), attr);
+	}
+
+	mutex_unlock(&cpu_mutex);
+}
+EXPORT_SYMBOL_GPL(cpu_remove_sysdev_attr);
+
+void cpu_remove_sysdev_attr_group(struct attribute_group *attrs)
+{
+	int cpu;
+	struct sys_device *sysdev;
+
+	mutex_lock(&cpu_mutex);
+
+	for_each_possible_cpu(cpu) {
+		sysdev = get_cpu_sysdev(cpu);
+		sysfs_remove_group(&sysdev->kobj, attrs);
+	}
+
+	mutex_unlock(&cpu_mutex);
+}
+EXPORT_SYMBOL_GPL(cpu_remove_sysdev_attr_group);
+
+
 /* NUMA stuff */
 
 #ifdef CONFIG_NUMA
Index: linux-2.6/include/linux/cpu.h
===================================================================
--- linux-2.6.orig/include/linux/cpu.h
+++ linux-2.6/include/linux/cpu.h
@@ -33,6 +33,14 @@ struct cpu {
 
 extern int register_cpu(struct cpu *cpu, int num);
 extern struct sys_device *get_cpu_sysdev(unsigned cpu);
+
+extern int cpu_add_sysdev_attr(struct sysdev_attribute *attr);
+extern void cpu_remove_sysdev_attr(struct sysdev_attribute *attr);
+
+extern int cpu_add_sysdev_attr_group(struct attribute_group *attrs);
+extern void cpu_remove_sysdev_attr_group(struct attribute_group *attrs);
+
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 #endif

--

