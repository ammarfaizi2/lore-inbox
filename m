Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268211AbTAMUov>; Mon, 13 Jan 2003 15:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268301AbTAMUou>; Mon, 13 Jan 2003 15:44:50 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:60845 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268211AbTAMUon>; Mon, 13 Jan 2003 15:44:43 -0500
Date: Mon, 13 Jan 2003 21:54:46 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.57] cpufreq: per-CPU initialization
Message-ID: <20030113205446.GC10365@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(depends on the "cpufreq: add sysfs interface" patch)

Allow for per-CPU initialization of CPUfreq. Therefore, it's not
necessary any longer to kmalloc the per-CPU policy struct. To use
this, cpufreq_driver->policy has to be set to NULL. Of course, 
cpufreq_driver->init is needed then, which is the appropriate function
for CPU initialization. cpufreq_driver->exit is available for cleanup.

All existing drivers continue to work without any changes, just for
clarity ->init and ->exit are set to NULL, and the names accordingly.

	Dominik

diff -ruN linux-original/arch/arm/mach-integrator/cpu.c linux/arch/arm/mach-integrator/cpu.c
--- linux-original/arch/arm/mach-integrator/cpu.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/arm/mach-integrator/cpu.c	2003-01-13 21:45:03.000000000 +0100
@@ -166,6 +166,7 @@
 	.verify		= integrator_verify_speed,
 	.setpolicy	= integrator_set_policy,
 	.policy		= &integrator_policy,
+	.name		= "integrator\0",
 };
 #endif
 
diff -ruN linux-original/arch/arm/mach-sa1100/cpu-sa1100.c linux/arch/arm/mach-sa1100/cpu-sa1100.c
--- linux-original/arch/arm/mach-sa1100/cpu-sa1100.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1100.c	2003-01-13 21:45:03.000000000 +0100
@@ -214,6 +214,7 @@
 	.verify		= sa11x0_verify_speed,
 	.setpolicy	= sa1100_setspeed,
 	.policy		= &sa1100_policy,
+	.name		= "sa1100\0",
 };
 
 static int __init sa1100_dram_init(void)
diff -ruN linux-original/arch/arm/mach-sa1100/cpu-sa1110.c linux/arch/arm/mach-sa1100/cpu-sa1110.c
--- linux-original/arch/arm/mach-sa1100/cpu-sa1110.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/arm/mach-sa1100/cpu-sa1110.c	2003-01-13 21:45:03.000000000 +0100
@@ -309,6 +309,7 @@
 	.verify		 = sa11x0_verify_speed,
 	.setpolicy	 = sa1110_setspeed,
 	.policy		 = &sa1110_policy,
+	.name		= "sa1110\0",
 };
 
 static int __init sa1110_clk_init(void)
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-13 21:45:03.000000000 +0100
@@ -260,6 +260,9 @@
 
 	driver->verify        = &elanfreq_verify;
 	driver->setpolicy     = &elanfreq_setpolicy;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "elanfrep\0", CPUFREQ_NAME_LEN);
 
 	driver->policy[0].cpu    = 0;
 	ret = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &elanfreq_table[0]);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-01-13 21:15:55.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-01-13 21:45:03.000000000 +0100
@@ -482,6 +482,9 @@
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	driver->verify = &cpufreq_gx_verify;
 	driver->setpolicy = &cpufreq_gx_setpolicy;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "gx-suspmod\0", CPUFREQ_NAME_LEN);
 
 	gx_driver = driver;
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-01-13 21:45:03.000000000 +0100
@@ -771,6 +771,9 @@
 
 	driver->verify    = &longhaul_verify;
 	driver->setpolicy = &longhaul_setpolicy;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "longhaul\0", CPUFREQ_NAME_LEN);
 
 	driver->policy[0].cpu = 0;
 	driver->policy[0].min = (unsigned int) lowest_speed;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-01-13 21:45:03.000000000 +0100
@@ -251,6 +251,9 @@
 	driver->policy[0].cpuinfo.min_freq = longrun_low_freq;
 	driver->policy[0].cpuinfo.max_freq = longrun_high_freq;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "longrun\0", CPUFREQ_NAME_LEN);
 
 	longrun_get_policy(&driver->policy[0]);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-13 21:45:03.000000000 +0100
@@ -240,6 +240,9 @@
 
 	driver->verify        = &cpufreq_p4_verify;
 	driver->setpolicy     = &cpufreq_p4_setpolicy;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "p4-clockmod\0", CPUFREQ_NAME_LEN);
 
 	for (i=0;i<NR_CPUS;i++) {
 		driver->policy[i].cpu    = i;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-01-13 21:45:03.000000000 +0100
@@ -184,6 +184,9 @@
 
 	driver->verify        = &powernow_k6_verify;
 	driver->setpolicy     = &powernow_k6_setpolicy;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "powernow-k6\0", CPUFREQ_NAME_LEN);
 
 	/* cpuinfo and default policy values */
 	driver->policy[0].cpu    = 0;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-13 21:08:03.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-13 21:45:03.000000000 +0100
@@ -690,6 +690,9 @@
 
 	driver->verify      = &speedstep_verify;
 	driver->setpolicy   = &speedstep_setpolicy;
+	driver->init = NULL;
+	driver->exit = NULL;
+	strncpy(driver->name, "speedstep\0", CPUFREQ_NAME_LEN);
 
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2003-01-13 21:08:11.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-01-13 21:45:03.000000000 +0100
@@ -1823,6 +1823,9 @@
 
 	driver->verify      = &acpi_cpufreq_verify;
 	driver->setpolicy   = &acpi_cpufreq_setpolicy;
+	driver->init        = NULL;
+	driver->exit        = NULL;
+	strncpy(driver->name, "acpi-processor\0", CPUFREQ_NAME_LEN);
 
 	for (i=0;i<NR_CPUS;i++) {
 		driver->policy[i].cpu    = pr->id;
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-01-13 21:37:56.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-01-13 21:45:03.000000000 +0100
@@ -109,19 +109,29 @@
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
 
+#define CPUFREQ_NAME_LEN 16
+
 struct cpufreq_driver {
 	/* needed by all drivers */
 	int     (*verify)       (struct cpufreq_policy *policy);
 	int     (*setpolicy)    (struct cpufreq_policy *policy);
 	struct cpufreq_policy   *policy;
+	char           		name[CPUFREQ_NAME_LEN];
+	/* optional, for the moment */
+	int     (*init)        (struct cpufreq_policy *policy);
+	int     (*exit)        (struct cpufreq_policy *policy);
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
 	unsigned int            cpu_cur_freq[NR_CPUS];
 #endif
 };
 
-int cpufreq_register(struct cpufreq_driver *driver_data);
-int cpufreq_unregister(void);
+int cpufreq_register_driver(struct cpufreq_driver *driver_data);
+int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
+/* deprecated */
+#define cpufreq_register(x)   cpufreq_register_driver(x)
+#define cpufreq_unregister(x) cpufreq_unregister_driver(NULL)
+
 
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state);
 
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-13 21:37:56.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-13 21:45:03.000000000 +0100
@@ -57,18 +57,6 @@
 static DECLARE_MUTEX            (cpufreq_notifier_sem);
 
 
-/**
- * The cpufreq default policy. Can be set by a "cpufreq=..." command
- * line option.
- */
-static struct cpufreq_policy default_policy = {
-	.cpu    = CPUFREQ_ALL_CPUS,
-	.min    = 0,
-	.max    = 0,
-	.policy = 0,
-};
-
-
 #ifdef CONFIG_CPU_FREQ_24_API
 /**
  * A few values needed by the 2.4.-compatible API
@@ -234,6 +222,25 @@
 
 
 /**
+ * show_scaling_governor - show the current policy for the specified CPU
+ */
+static ssize_t show_scaling_driver (struct device *dev, char *buf)
+{
+	char value[CPUFREQ_NAME_LEN];
+
+	if (!dev)
+		return 0;
+
+	down(&cpufreq_driver_sem);
+	if (cpufreq_driver)
+		strncpy(value, cpufreq_driver->name, CPUFREQ_NAME_LEN);
+	up(&cpufreq_driver_sem);
+
+	return sprintf(buf, "%s\n", value);
+}
+
+
+/**
  * cpufreq_per_cpu_attr_ro - read-only cpufreq per-CPU file
  */
 #define cpufreq_per_cpu_attr_ro(file_name, object)			\
@@ -257,6 +264,7 @@
 cpufreq_per_cpu_attr_rw(scaling_max_freq, max);
 
 static DEVICE_ATTR(scaling_governor, (S_IRUGO | S_IWUSR), show_scaling_governor, store_scaling_governor);
+static DEVICE_ATTR(scaling_driver, S_IRUGO, show_scaling_driver, NULL);
 
 
 /**
@@ -268,6 +276,7 @@
 {
 	unsigned int cpu = to_cpu_nr(dev);
 	int ret = 0;
+	struct cpufreq_policy policy;
 
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver) {
@@ -275,6 +284,37 @@
 		return -EINVAL;
 	}
 
+	/* call driver. From then on the cpufreq must be able
+	 * to accept all calls to ->verify and ->setpolicy for this CPU
+	 */
+	cpufreq_driver->policy[cpu].cpu = cpu;
+	if (cpufreq_driver->init) {
+		ret = cpufreq_driver->init(&cpufreq_driver->policy[cpu]);
+		if (ret) {
+			up(&cpufreq_driver_sem);
+			return -ENODEV;
+		}
+	}
+
+	/* set default policy on this CPU */
+	policy.policy = cpufreq_driver->policy[cpu].policy;
+	policy.min    = cpufreq_driver->policy[cpu].min;
+	policy.max    = cpufreq_driver->policy[cpu].max;
+	policy.cpu    = cpu;
+
+	up(&cpufreq_driver_sem);
+	ret = cpufreq_set_policy(&policy);
+	if (ret)
+		return -EINVAL;
+	down(&cpufreq_driver_sem);
+
+	/* 2.4-API init for this CPU */
+#ifdef CONFIG_CPU_FREQ_24_API
+	cpu_min_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.min_freq;
+	cpu_max_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.max_freq;
+	cpu_cur_freq[cpu] = cpufreq_driver->cpu_cur_freq[cpu];
+#endif
+
 	/* prepare interface data */
 	cpufreq_driver->policy[cpu].intf.dev  = dev;
 	cpufreq_driver->policy[cpu].intf.intf = &cpufreq_interface;
@@ -296,6 +336,7 @@
 	device_create_file (dev, &dev_attr_scaling_min_freq);
 	device_create_file (dev, &dev_attr_scaling_max_freq);
 	device_create_file (dev, &dev_attr_scaling_governor);
+	device_create_file (dev, &dev_attr_scaling_driver);
 
 	up(&cpufreq_driver_sem);
 	return ret;
@@ -311,12 +352,17 @@
 static int cpufreq_remove_dev (struct intf_data *intf)
 {
 	struct device * dev = intf->dev;
+	unsigned int cpu = to_cpu_nr(dev);
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(&cpufreq_driver->policy[cpu]);
 
 	device_remove_file (dev, &dev_attr_cpuinfo_min_freq);
 	device_remove_file (dev, &dev_attr_cpuinfo_max_freq);
 	device_remove_file (dev, &dev_attr_scaling_min_freq);
 	device_remove_file (dev, &dev_attr_scaling_max_freq);
 	device_remove_file (dev, &dev_attr_scaling_governor);
+	device_remove_file (dev, &dev_attr_scaling_governor);
 
 	return 0;
 }
@@ -401,20 +447,6 @@
 }
 
 
-/*
- * cpufreq command line parameter.  Must be hard values (kHz)
- *  cpufreq=1000000:2000000:PERFORMANCE   
- * to set the default CPUFreq policy.
- */
-static int __init cpufreq_setup(char *str)
-{
-	cpufreq_parse_policy(str, &default_policy);
-	default_policy.cpu = CPUFREQ_ALL_CPUS;
-	return 1;
-}
-__setup("cpufreq=", cpufreq_setup);
-
-
 /**
  * cpufreq_proc_read - read /proc/cpufreq
  *
@@ -1202,19 +1234,18 @@
  *********************************************************************/
 
 /**
- * cpufreq_register - register a CPU Frequency driver
- * @driver_data: A struct cpufreq_driver containing the values submitted by the CPU Frequency driver.
+ * cpufreq_register_driver - register a CPU Frequency driver
+ * @driver_data: A struct cpufreq_driver containing the values#
+ * submitted by the CPU Frequency driver.
  *
  *   Registers a CPU Frequency driver to this core code. This code 
  * returns zero on success, -EBUSY when another driver got here first
  * (and isn't unregistered in the meantime). 
  *
  */
-int cpufreq_register(struct cpufreq_driver *driver_data)
+int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 {
-	unsigned int            ret;
-	unsigned int            i;
-	struct cpufreq_policy   policy;
+	int ret = 0;
 
 	if (cpufreq_driver)
 		return -EBUSY;
@@ -1224,53 +1255,27 @@
 		return -EINVAL;
 
 	down(&cpufreq_driver_sem);
-	cpufreq_driver        = driver_data;
-	
-	/* check for a default policy - if it exists, use it on _all_ CPUs*/
-	for (i=0; i<NR_CPUS; i++)
-	{
-		if (default_policy.policy)
-			cpufreq_driver->policy[i].policy = default_policy.policy;
-		if (default_policy.min)
-			cpufreq_driver->policy[i].min = default_policy.min;
-		if (default_policy.max)
-			cpufreq_driver->policy[i].max = default_policy.max;
-	}
 
-	/* set default policy on all CPUs. Must be called per-CPU and not
-	 * with CPUFREQ_ALL_CPUs as there might be no common policy for all
-	 * CPUs (UltraSPARC etc.)
-	 */
-	for (i=0; i<NR_CPUS; i++)
-	{
-		policy.policy = cpufreq_driver->policy[i].policy;
-		policy.min    = cpufreq_driver->policy[i].min;
-		policy.max    = cpufreq_driver->policy[i].max;
-		policy.cpu    = i;
-		up(&cpufreq_driver_sem);
-		ret = cpufreq_set_policy(&policy);
-		down(&cpufreq_driver_sem);
-		if (ret) {
-			cpufreq_driver = NULL;
+	cpufreq_driver = driver_data;
+
+	if (!cpufreq_driver->policy) {
+		/* then we need per-CPU init */
+		if (!cpufreq_driver->init) {
 			up(&cpufreq_driver_sem);
-			return ret;
+			return -EINVAL;
+		}
+		cpufreq_driver->policy = kmalloc(NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
+		if (!cpufreq_driver->policy) {
+			up(&cpufreq_driver_sem);
+			return -ENOMEM;
 		}
 	}
-
+	
 	up(&cpufreq_driver_sem);
 
 	cpufreq_proc_init();
 
 #ifdef CONFIG_CPU_FREQ_24_API
- 	down(&cpufreq_driver_sem);
-	for (i=0; i<NR_CPUS; i++) 
-	{
-		cpu_min_freq[i] = driver_data->policy[i].cpuinfo.min_freq;
-		cpu_max_freq[i] = driver_data->policy[i].cpuinfo.max_freq;
-		cpu_cur_freq[i] = driver_data->cpu_cur_freq[i];
-	}
-	up(&cpufreq_driver_sem);
-
 	cpufreq_sysctl_init();
 #endif
 
@@ -1278,40 +1283,53 @@
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpufreq_register);
+EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 
 
 /**
- * cpufreq_unregister - unregister the current CPUFreq driver
+ * cpufreq_unregister_driver - unregister the current CPUFreq driver
  *
  *    Unregister the current CPUFreq driver. Only call this if you have 
  * the right to do so, i.e. if you have succeeded in initialising before!
  * Returns zero if successful, and -EINVAL if the cpufreq_driver is
  * currently not initialised.
  */
-int cpufreq_unregister(void)
+int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 {
 	down(&cpufreq_driver_sem);
 
-	if (!cpufreq_driver) {
+	if (!cpufreq_driver || 
+	    ((driver != cpufreq_driver) && (driver != NULL))) { /* compat */
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
 	}
 
-	interface_unregister(&cpufreq_interface);
-	cpufreq_driver = NULL;
-
-	up(&cpufreq_driver_sem);
-
 	cpufreq_proc_exit();
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpufreq_sysctl_exit();
 #endif
 
+	/* remove this workaround as soon as interface_add_data works */
+	{
+		unsigned int i;
+		for (i=0; i<NR_CPUS; i++) {
+			if (cpu_online(i)) 
+				cpufreq_remove_dev(&cpufreq_driver->policy[i].intf);
+		}
+	}
+
+	interface_unregister(&cpufreq_interface);
+
+	if (driver)
+		kfree(cpufreq_driver->policy);
+	cpufreq_driver = NULL;
+
+	up(&cpufreq_driver_sem);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpufreq_unregister);
+EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 
 
 #ifdef CONFIG_PM
