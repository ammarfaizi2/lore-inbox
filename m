Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbULBKLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbULBKLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbULBKLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:11:00 -0500
Received: from aun.it.uu.se ([130.238.12.36]:64487 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261272AbULBKKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:10:32 -0500
Date: Thu, 2 Dec 2004 11:10:24 +0100 (MET)
Message-Id: <200412021010.iB2AAORk004531@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 1/4: core
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch set changes perfctr to publish its global
information via a textual sysfs interface instead of
passing binary structs via sys_perfctr_info(). We can
now remove sys_perfctr_info().

Perfctr sysfs update part 1/4:
- Publish global information via text files in sysfs.
- Remove sys_perfctr_info() from arch-neutral code.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/init.c    |  117 ++++++++++++++++++++++++++++++----------------
 drivers/perfctr/version.h |    2 
 include/linux/perfctr.h   |    3 -
 kernel/sys_ni.c           |    1 
 4 files changed, 79 insertions(+), 44 deletions(-)

diff -rupN linux-2.6.10-rc2-mm4/drivers/perfctr/init.c linux-2.6.10-rc2-mm4.perfctr-core-update/drivers/perfctr/init.c
--- linux-2.6.10-rc2-mm4/drivers/perfctr/init.c	2004-11-30 23:53:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-core-update/drivers/perfctr/init.c	2004-12-02 02:43:52.000000000 +0100
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include <linux/perfctr.h>
 
 #include <asm/uaccess.h>
@@ -21,51 +22,84 @@ struct perfctr_info perfctr_info = {
 	.driver_version = VERSION,
 };
 
-char *perfctr_cpu_name __initdata;
+static struct class perfctr_class = {
+	.name		= "perfctr",
+};
 
-static int cpus_copy_to_user(struct perfctr_cpu_mask __user *argp, const cpumask_t *cpus)
+static ssize_t
+perfctr_show_driver_version(struct class *class, char *buf)
 {
-	const unsigned int k_nrwords = PERFCTR_CPUMASK_NRLONGS*(sizeof(long)/sizeof(int));
-	unsigned int u_nrwords;
-	unsigned int ui, ki, j;
-
-	if (get_user(u_nrwords, &argp->nrwords))
-		return -EFAULT;
-	if (put_user(k_nrwords, &argp->nrwords))
-		return -EFAULT;
-	if (u_nrwords < k_nrwords)
-		return -EOVERFLOW;
-	for(ui = 0, ki = 0; ki < PERFCTR_CPUMASK_NRLONGS; ++ki) {
-		unsigned long mask = cpus_addr(*cpus)[ki];
-		for(j = 0; j < sizeof(long)/sizeof(int); ++j) {
-			if (put_user((unsigned int)mask, &argp->mask[ui]))
-				return -EFAULT;
-			++ui;
-			mask = (mask >> (8*sizeof(int)-1)) >> 1;
-		}
-	}
-	return 0;
+	return sprintf(buf, "%s\n", perfctr_info.driver_version);
 }
+static CLASS_ATTR(driver_version,0444,perfctr_show_driver_version,NULL);
 
-asmlinkage long sys_perfctr_info(struct perfctr_info __user *infop,
-				 struct perfctr_cpu_mask __user *cpusp,
-				 struct perfctr_cpu_mask __user *forbiddenp)
-{
-	if (infop && copy_to_user(infop, &perfctr_info, sizeof perfctr_info))
-		return -EFAULT;
-	if (cpusp) {
-		int err = cpus_copy_to_user(cpusp, &cpu_online_map);
-		if (err)
-			return err;
-	}
-	if (forbiddenp) {
-		int err = cpus_copy_to_user(forbiddenp, &perfctr_cpus_forbidden_mask);
-		if (err)
-			return err;
-	}
-	return 0;
+static ssize_t
+perfctr_show_cpu_type(struct class *class, char *buf)
+{
+	return sprintf(buf, "%#x\n", perfctr_info.cpu_type);
+}
+static CLASS_ATTR(cpu_type,0444,perfctr_show_cpu_type,NULL);
+
+static ssize_t
+perfctr_show_cpu_features(struct class *class, char *buf)
+{
+	return sprintf(buf, "%#x\n", perfctr_info.cpu_features);
+}
+static CLASS_ATTR(cpu_features,0444,perfctr_show_cpu_features,NULL);
+
+static ssize_t
+perfctr_show_cpu_khz(struct class *class, char *buf)
+{
+	return sprintf(buf, "%u\n", perfctr_info.cpu_khz);
+}
+static CLASS_ATTR(cpu_khz,0444,perfctr_show_cpu_khz,NULL);
+
+static ssize_t
+perfctr_show_tsc_to_cpu_mult(struct class *class, char *buf)
+{
+	return sprintf(buf, "%u\n", perfctr_info.tsc_to_cpu_mult);
+}
+static CLASS_ATTR(tsc_to_cpu_mult,0444,perfctr_show_tsc_to_cpu_mult,NULL);
+
+static ssize_t
+perfctr_show_cpus_online(struct class *class, char *buf)
+{
+	int ret = cpumask_scnprintf(buf, PAGE_SIZE-1, cpu_online_map);
+	buf[ret++] = '\n';
+	return ret;
+}
+static CLASS_ATTR(cpus_online,0444,perfctr_show_cpus_online,NULL);
+
+static ssize_t
+perfctr_show_cpus_forbidden(struct class *class, char *buf)
+{
+	int ret = cpumask_scnprintf(buf, PAGE_SIZE-1, perfctr_cpus_forbidden_mask);
+	buf[ret++] = '\n';
+	return ret;
+}
+static CLASS_ATTR(cpus_forbidden,0444,perfctr_show_cpus_forbidden,NULL);
+
+static int __init perfctr_class_init(void)
+{
+	int ret;
+
+	ret = class_register(&perfctr_class);
+	if (ret)
+		return ret;
+	ret |= class_create_file(&perfctr_class, &class_attr_driver_version);
+	ret |= class_create_file(&perfctr_class, &class_attr_cpu_type);
+	ret |= class_create_file(&perfctr_class, &class_attr_cpu_features);
+	ret |= class_create_file(&perfctr_class, &class_attr_cpu_khz);
+	ret |= class_create_file(&perfctr_class, &class_attr_tsc_to_cpu_mult);
+	ret |= class_create_file(&perfctr_class, &class_attr_cpus_online);
+	ret |= class_create_file(&perfctr_class, &class_attr_cpus_forbidden);
+	if (ret)
+		class_unregister(&perfctr_class);
+	return ret;
 }
 
+char *perfctr_cpu_name __initdata;
+
 static int __init perfctr_init(void)
 {
 	int err;
@@ -78,6 +112,11 @@ static int __init perfctr_init(void)
 	err = vperfctr_init();
 	if (err)
 		return err;
+	err = perfctr_class_init();
+	if (err) {
+		printk(KERN_ERR "perfctr: class initialisation failed\n");
+		return err;
+	}
 	printk(KERN_INFO "perfctr: driver %s, cpu type %s at %u kHz\n",
 	       perfctr_info.driver_version,
 	       perfctr_cpu_name,
diff -rupN linux-2.6.10-rc2-mm4/drivers/perfctr/version.h linux-2.6.10-rc2-mm4.perfctr-core-update/drivers/perfctr/version.h
--- linux-2.6.10-rc2-mm4/drivers/perfctr/version.h	2004-11-30 23:53:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-core-update/drivers/perfctr/version.h	2004-12-02 02:43:52.000000000 +0100
@@ -1 +1 @@
-#define VERSION "2.7.8"
+#define VERSION "2.7.9"
diff -rupN linux-2.6.10-rc2-mm4/include/linux/perfctr.h linux-2.6.10-rc2-mm4.perfctr-core-update/include/linux/perfctr.h
--- linux-2.6.10-rc2-mm4/include/linux/perfctr.h	2004-11-30 23:53:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-core-update/include/linux/perfctr.h	2004-12-02 02:43:52.000000000 +0100
@@ -71,9 +71,6 @@ struct vperfctr_control;
 /*
  * The perfctr system calls.
  */
-asmlinkage long sys_perfctr_info(struct perfctr_info __user*,
-				 struct perfctr_cpu_mask __user*,
-				 struct perfctr_cpu_mask __user*);
 asmlinkage long sys_vperfctr_open(int tid, int creat);
 asmlinkage long sys_vperfctr_control(int fd,
 				     const struct vperfctr_control __user *argp,
diff -rupN linux-2.6.10-rc2-mm4/kernel/sys_ni.c linux-2.6.10-rc2-mm4.perfctr-core-update/kernel/sys_ni.c
--- linux-2.6.10-rc2-mm4/kernel/sys_ni.c	2004-11-30 23:53:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-core-update/kernel/sys_ni.c	2004-12-02 02:43:52.000000000 +0100
@@ -83,7 +83,6 @@ cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
 cond_syscall(sys_pciconfig_iobase)
 
-cond_syscall(sys_perfctr_info)
 cond_syscall(sys_vperfctr_open)
 cond_syscall(sys_vperfctr_control)
 cond_syscall(sys_vperfctr_unlink)
