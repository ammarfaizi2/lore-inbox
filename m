Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbTAMVR2>; Mon, 13 Jan 2003 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268346AbTAMVR2>; Mon, 13 Jan 2003 16:17:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268343AbTAMVRT>;
	Mon, 13 Jan 2003 16:17:19 -0500
Date: Mon, 13 Jan 2003 14:27:45 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Dominik Brodowski <linux@brodo.de>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH 2.5.57] cpufreq: add sysfs interface
In-Reply-To: <20030113205346.GB10365@brodo.de>
Message-ID: <Pine.LNX.4.33.0301131425450.1136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jan 2003, Dominik Brodowski wrote:

> rediffed for 2.5.57
> 
> This patch adds a sysfs interface to the cpufreq core, and marks the
> previous /proc/cpufreq interface as deprecated. 

The following updates the patch to reflect the sysfs changes currently in 
Linus's BK tree (reinstating the count parameter to sysfs store() 
methods).


	-pat

===== arch/i386/Kconfig 1.30 vs edited =====
--- 1.30/arch/i386/Kconfig	Mon Jan 13 11:08:12 2003
+++ edited/arch/i386/Kconfig	Mon Jan 13 14:15:39 2003
@@ -949,15 +949,27 @@
 
 	  If in doubt, say N.
 
+config CPU_FREQ_PROC_INTF
+	bool "/proc/cpufreq interface (DEPRECATED)"
+	depends on CPU_FREQ && PROC_FS
+	help
+	  This enables the /proc/cpufreq interface for controlling
+	  CPUFreq. Please note that it is recommended to use the sysfs
+	  interface instead (which is built automatically). 
+	  
+	  For details, take a look at linux/Documentation/cpufreq. 
+	  
+	  If in doubt, say N.
+
 config CPU_FREQ_24_API
 	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
 	depends on CPU_FREQ
 	help
 	  This enables the /proc/sys/cpu/ sysctl interface for controlling
 	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
-	  uses /proc/cpufreq instead. Please note that some drivers do not 
-	  work well with the 2.4. /proc/sys/cpu sysctl interface, so if in
-	  doubt, say N here.
+	  uses a sysfs interface instead. Please note that some drivers do 
+	  not work well with the 2.4. /proc/sys/cpu sysctl interface,
+	  so if in doubt, say N here.
 
 	  For details, take a look at linux/Documentation/cpufreq. 
 
===== include/linux/cpufreq.h 1.9 vs edited =====
--- 1.9/include/linux/cpufreq.h	Fri Jan 10 15:16:10 2003
+++ edited/include/linux/cpufreq.h	Mon Jan 13 14:15:39 2003
@@ -17,6 +17,7 @@
 #include <linux/config.h>
 #include <linux/notifier.h>
 #include <linux/threads.h>
+#include <linux/device.h>
 
 
 /*********************************************************************
@@ -57,6 +58,7 @@
 	unsigned int            max;    /* in kHz */
         unsigned int            policy; /* see above */
 	struct cpufreq_cpuinfo  cpuinfo;     /* see above */
+	struct intf_data        intf;   /* interface data */
 };
 
 #define CPUFREQ_ADJUST          (0)
===== kernel/cpufreq.c 1.10 vs edited =====
--- 1.10/kernel/cpufreq.c	Fri Jan 10 15:16:10 2003
+++ edited/kernel/cpufreq.c	Mon Jan 13 14:25:01 2003
@@ -20,12 +20,16 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/device.h>
+
+#ifdef CONFIG_CPU_FREQ_PROC_INTF
 #include <linux/ctype.h>
 #include <linux/proc_fs.h>
-
 #include <asm/uaccess.h>
+#endif
 
 #ifdef CONFIG_CPU_FREQ_24_API
+#include <linux/proc_fs.h>
 #include <linux/sysctl.h>
 #endif
 
@@ -75,11 +79,256 @@
 #endif
 
 
+/*********************************************************************
+ *                          SYSFS INTERFACE                          *
+ *********************************************************************/
+
+/**
+ * cpufreq_parse_governor - parse a governor string
+ */
+static int cpufreq_parse_governor (char *str_governor, unsigned int *governor)
+{
+	if (!strnicmp(str_governor, "performance", 11)) {
+		*governor = CPUFREQ_POLICY_PERFORMANCE;
+		return 0;
+	} else if (!strnicmp(str_governor, "powersave", 9)) {
+		*governor = CPUFREQ_POLICY_POWERSAVE;
+		return 0;
+	} else
+		return -EINVAL;
+}
+
+
+/* forward declarations */
+static int cpufreq_add_dev (struct device * dev);
+static int cpufreq_remove_dev (struct intf_data * dev);
+
+/* drivers/base/cpu.c */
+extern struct device_class cpu_devclass;
+
+static struct device_interface cpufreq_interface = {
+        .name = "cpufreq",
+        .devclass = &cpu_devclass,
+        .add_device = &cpufreq_add_dev,
+        .remove_device = &cpufreq_remove_dev,
+	.kset = { .subsys = &cpu_devclass.subsys, },
+        .devnum = 0,
+};
+
+static inline int to_cpu_nr (struct device *dev)
+{
+	struct sys_device * cpu_sys_dev = container_of(dev, struct sys_device, dev);
+	return (cpu_sys_dev->id);
+}
+
+
+/**
+ * cpufreq_per_cpu_attr_read() / show_##file_name() - print out cpufreq information
+ *
+ * Write out information from cpufreq_driver->policy[cpu]; object must be
+ * "unsigned int".
+ */
+
+#define cpufreq_per_cpu_attr_read(file_name, object) 			\
+static ssize_t show_##file_name 					\
+(struct device *dev, char *buf)						\
+{									\
+	unsigned int value = 0;						\
+									\
+	if (!dev)							\
+		return 0;						\
+									\
+	down(&cpufreq_driver_sem);					\
+	if (cpufreq_driver)						\
+		value = cpufreq_driver->policy[to_cpu_nr(dev)].object;	\
+	up(&cpufreq_driver_sem);					\
+									\
+	return sprintf (buf, "%u\n", value);				\
+}
+
+
+/**
+ * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
+ */
+#define cpufreq_per_cpu_attr_write(file_name, object)			\
+static ssize_t store_##file_name					\
+(struct device *dev, const char *buf, size_t count)			\
+{									\
+	unsigned int ret = -EINVAL;					\
+	struct cpufreq_policy policy;					\
+									\
+	if (!dev)							\
+		return 0;						\
+									\
+	ret = cpufreq_get_policy(&policy, to_cpu_nr(dev));		\
+	if (ret)							\
+		return ret;						\
+									\
+	ret = sscanf (buf, "%u", &policy.object);			\
+	if (ret != 1)							\
+		return -EINVAL;						\
+									\
+	ret = cpufreq_set_policy(&policy);				\
+	if (ret)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+
+/**
+ * show_scaling_governor - show the current policy for the specified CPU
+ */
+static ssize_t show_scaling_governor (struct device *dev, char *buf)
+{
+	unsigned int value = 0;
+
+	if (!dev)
+		return 0;
+
+	down(&cpufreq_driver_sem);
+	if (cpufreq_driver)
+		value = cpufreq_driver->policy[to_cpu_nr(dev)].policy;
+	up(&cpufreq_driver_sem);
+
+	switch (value) {
+	case CPUFREQ_POLICY_POWERSAVE:
+		return sprintf(buf, "powersave\n");
+	case CPUFREQ_POLICY_PERFORMANCE:
+		return sprintf(buf, "performance\n");
+	}
+
+	return -EINVAL;
+}
+
+
+/**
+ * store_scaling_governor - store policy for the specified CPU
+ */
+static ssize_t 
+store_scaling_governor (struct device *dev, const char *buf, size_t count) 
+{
+	unsigned int ret = -EINVAL;
+	char	str_governor[16];
+	struct cpufreq_policy policy;
+
+	if (!dev)
+		return 0;
+
+	ret = cpufreq_get_policy(&policy, to_cpu_nr(dev));
+	if (ret)
+		return ret;
+
+	ret = sscanf (buf, "%15s", str_governor);
+	if (ret != 1)
+		return -EINVAL;
+
+	if (cpufreq_parse_governor(str_governor, &policy.policy))
+		return -EINVAL;
+
+	ret = cpufreq_set_policy(&policy);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+
+/**
+ * cpufreq_per_cpu_attr_ro - read-only cpufreq per-CPU file
+ */
+#define cpufreq_per_cpu_attr_ro(file_name, object)			\
+cpufreq_per_cpu_attr_read(file_name, object) 				\
+static DEVICE_ATTR(file_name, S_IRUGO, show_##file_name, NULL);
+
+
+/**
+ * cpufreq_per_cpu_attr_rw - read-write cpufreq per-CPU file
+ */
+#define cpufreq_per_cpu_attr_rw(file_name, object) 			\
+cpufreq_per_cpu_attr_read(file_name, object) 				\
+cpufreq_per_cpu_attr_write(file_name, object) 				\
+static DEVICE_ATTR(file_name, (S_IRUGO | S_IWUSR), show_##file_name, store_##file_name);
+
+
+/* create the file functions */
+cpufreq_per_cpu_attr_ro(cpuinfo_min_freq, cpuinfo.min_freq);
+cpufreq_per_cpu_attr_ro(cpuinfo_max_freq, cpuinfo.max_freq);
+cpufreq_per_cpu_attr_rw(scaling_min_freq, min);
+cpufreq_per_cpu_attr_rw(scaling_max_freq, max);
+
+static DEVICE_ATTR(scaling_governor, (S_IRUGO | S_IWUSR), show_scaling_governor, store_scaling_governor);
+
+
+/**
+ * cpufreq_add_dev - add a CPU device
+ *
+ * Adds the cpufreq interface for a CPU device. 
+ */
+static int cpufreq_add_dev (struct device * dev)
+{
+	unsigned int cpu = to_cpu_nr(dev);
+	int ret = 0;
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+
+	/* prepare interface data */
+	cpufreq_driver->policy[cpu].intf.dev  = dev;
+	cpufreq_driver->policy[cpu].intf.intf = &cpufreq_interface;
+	strncpy(cpufreq_driver->policy[cpu].intf.kobj.name, cpufreq_interface.name, KOBJ_NAME_LEN);
+	cpufreq_driver->policy[cpu].intf.kobj.parent = &(dev->kobj);
+	cpufreq_driver->policy[cpu].intf.kobj.kset = &(cpufreq_interface.kset);
+
+	/* add interface */
+	/* currently commented out due to deadlock */
+	//ret = interface_add_data(&(cpufreq_driver->policy[cpu].intf));
+	if (ret) {
+		up(&cpufreq_driver_sem);
+		return ret;
+	}
+
+	/* create files */
+	device_create_file (dev, &dev_attr_cpuinfo_min_freq);
+	device_create_file (dev, &dev_attr_cpuinfo_max_freq);
+	device_create_file (dev, &dev_attr_scaling_min_freq);
+	device_create_file (dev, &dev_attr_scaling_max_freq);
+	device_create_file (dev, &dev_attr_scaling_governor);
+
+	up(&cpufreq_driver_sem);
+	return ret;
+}
+
+
+/**
+ * cpufreq_remove_dev - remove a CPU device
+ *
+ * Removes the cpufreq interface for a CPU device. Is called with
+ * cpufreq_driver_sem locked.
+ */
+static int cpufreq_remove_dev (struct intf_data *intf)
+{
+	struct device * dev = intf->dev;
+
+	device_remove_file (dev, &dev_attr_cpuinfo_min_freq);
+	device_remove_file (dev, &dev_attr_cpuinfo_max_freq);
+	device_remove_file (dev, &dev_attr_scaling_min_freq);
+	device_remove_file (dev, &dev_attr_scaling_max_freq);
+	device_remove_file (dev, &dev_attr_scaling_governor);
+
+	return 0;
+}
+
 
 /*********************************************************************
- *                              2.6. API                             *
+ *                      /proc/cpufreq INTERFACE                      *
  *********************************************************************/
 
+#ifdef CONFIG_CPU_FREQ_PROC_INTF
+
 /**
  * cpufreq_parse_policy - parse a policy string
  * @input_string: the string to parse.
@@ -95,10 +344,9 @@
 	unsigned int            min = 0;
 	unsigned int            max = 0;
 	unsigned int            cpu = 0;
-	char			policy_string[42] = {'\0'};
+	char			str_governor[16];
 	struct cpufreq_policy   current_policy;
 	unsigned int            result = -EFAULT;
-	unsigned int            i = 0;
 
 	if (!policy)
 		return -EINVAL;
@@ -108,7 +356,7 @@
 	policy->policy = 0;
 	policy->cpu = CPUFREQ_ALL_CPUS;
 
-	if (sscanf(input_string, "%d:%d:%d:%s", &cpu, &min, &max, policy_string) == 4) 
+	if (sscanf(input_string, "%d:%d:%d:%15s", &cpu, &min, &max, str_governor) == 4) 
 	{
 		policy->min = min;
 		policy->max = max;
@@ -116,7 +364,7 @@
 		result = 0;
 		goto scan_policy;
 	}
-	if (sscanf(input_string, "%d%%%d%%%d%%%s", &cpu, &min, &max, policy_string) == 4)
+	if (sscanf(input_string, "%d%%%d%%%d%%%15s", &cpu, &min, &max, str_governor) == 4)
 	{
 		if (!cpufreq_get_policy(&current_policy, cpu)) {
 			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
@@ -127,7 +375,7 @@
 		}
 	}
 
-	if (sscanf(input_string, "%d:%d:%s", &min, &max, policy_string) == 3) 
+	if (sscanf(input_string, "%d:%d:%15s", &min, &max, str_governor) == 3) 
 	{
 		policy->min = min;
 		policy->max = max;
@@ -135,7 +383,7 @@
 		goto scan_policy;
 	}
 
-	if (sscanf(input_string, "%d%%%d%%%s", &min, &max, policy_string) == 3)
+	if (sscanf(input_string, "%d%%%d%%%15s", &min, &max, str_governor) == 3)
 	{
 		if (!cpufreq_get_policy(&current_policy, cpu)) {
 			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
@@ -148,36 +396,7 @@
 	return -EINVAL;
 
 scan_policy:
-
-	for (i=0;i<sizeof(policy_string);i++){
-		if (policy_string[i]=='\0')
-			break;
-		policy_string[i] = tolower(policy_string[i]);
-	}
-
-	if (!strncmp(policy_string, "powersave", 6) ||  
-            !strncmp(policy_string, "eco", 3) ||       
-	    !strncmp(policy_string, "batter", 6) ||
-	    !strncmp(policy_string, "low", 3)) 
-	{
-		result = 0;
-		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-	}
-	else if (!strncmp(policy_string, "performance",6) ||
-	    !strncmp(policy_string, "high",4) ||
-	    !strncmp(policy_string, "full",4))
-	{
-		result = 0;
-		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	}
-	else if (!cpufreq_get_policy(&current_policy, policy->cpu))
-	{
-		policy->policy = current_policy.policy;
-	}
-	else
-	{
-		policy->policy = 0;
-	}
+	result = cpufreq_parse_governor(str_governor, &policy->policy);
 
 	return result;
 }
@@ -197,8 +416,6 @@
 __setup("cpufreq=", cpufreq_setup);
 
 
-#ifdef CONFIG_PROC_FS
-
 /**
  * cpufreq_proc_read - read /proc/cpufreq
  *
@@ -345,12 +562,15 @@
 	remove_proc_entry("cpufreq", &proc_root);
 	return;
 }
-#endif /* CONFIG_PROC_FS */
+#else
+#define cpufreq_proc_init() do {} while(0)
+#define cpufreq_proc_exit() do {} while(0)
+#endif /* CONFIG_CPU_FREQ_PROC_INTF */
 
 
 
 /*********************************************************************
- *                        2.4. COMPATIBLE API                        *
+ *                      /proc/sys/cpu/ INTERFACE                     *
  *********************************************************************/
 
 #ifdef CONFIG_CPU_FREQ_24_API
@@ -1055,7 +1275,9 @@
 	cpufreq_sysctl_init();
 #endif
 
-	return 0;
+	ret = interface_register(&cpufreq_interface);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register);
 
@@ -1077,6 +1299,7 @@
 		return -EINVAL;
 	}
 
+	interface_unregister(&cpufreq_interface);
 	cpufreq_driver = NULL;
 
 	up(&cpufreq_driver_sem);

