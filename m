Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268144AbTAKV2z>; Sat, 11 Jan 2003 16:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbTAKV2z>; Sat, 11 Jan 2003 16:28:55 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:57540 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268144AbTAKV2s>; Sat, 11 Jan 2003 16:28:48 -0500
Date: Sat, 11 Jan 2003 22:38:14 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk, mochel@osdl.org
Subject: [PATCH 2.5.56] cpufreq: sysfs interface
Message-ID: <20030111213814.GA2385@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a sysfs interface to the cpufreq core, and marks the
previous /proc/cpufreq interface as deprecated. 

As in drivers/base/cpu.c a "CPU driver" is registered, cpufreq acts as
"interface" to this, offering the following files for each CPU 
(in /system/devices/sys/cpu.../) where CPUfreq support is present

cpuinfo_min_freq (ro)	- minimum frequency (in kHz) the CPU supports
cpuinfo_max_freq (ro)	- maximum frequency (in kHz) the CPU supports
scaling_min_freq (rw)	- minimum frequency (in kHz) cpufreq may scale
			     the CPU core to
scaling_max_freq (rw)	- maximum frequency (in kHz) cpufreq may scale
			     the CPU core to
scaling_governor (rw)	- governor == "A feedback device on a machine 
			      or engine that is used to provide
			      automatic control, as of speed,
			      pressure, or temperature" [1, as noted
			      by David Kimdon]. Decides what frequency
			      is used. Currently, only "performance"
			      and "powersave" are supported, more may
			      be added later.

(In future, a file scaling_driver (ro) which shows what CPUfreq driver
is used (arm-sa1100,  gx-suspmod, speedstep, longrun, powernow-k6,
...) might be added, and this driver will be allowed to add files
scaling_driver_* for driver-specific settings like "prefer fast FSB". 
And scaling_governor_* files might offer settings for the governor.)

To implement this sysfs interface, the driver model "interface" code
is used. Unfortunately, it has a non-trivial locking bug in 
drivers/base/intf.c: there's a down_write call for
cls->subsys.rwsem in add_intf(), which then calls add(), which may call
intf->add_device(), which may call interface_add_data(), which calls
kobject_register(), which calls kobject_add(), which then tries to
down_write cls->subsys.rwsem. Remember, that was already locked writable
in add_intf().

Because of that, interface_add_data() is commented out; this means
that no link in /system/class/cpu/cpufreq is added, and that the
dev-removal code isn't called. This shouldn't be a problem yet,
though; as no cpufreq driver I know of is capable of CPU hotplugging.

    Dominik

[1] http://dictionary.reference.com/search?q=governor

diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-01-10 22:16:19.000000000 +0100
+++ linux/arch/i386/Kconfig	2003-01-11 19:54:24.000000000 +0100
@@ -937,15 +937,27 @@
 
 	  If in doubt, say N.
 
+config CPU_FREQ_PROC_INTF
+	bool "/proc/cpufreq interface (DEPRECATED)"
+	depends on CPU_FREQ
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
 
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-01-11 20:10:15.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-01-11 20:02:47.000000000 +0100
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
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-11 20:10:15.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-11 20:09:06.000000000 +0100
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
 
@@ -75,11 +79,253 @@
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
+int cpufreq_add_dev (struct device * dev);
+int cpufreq_remove_dev (struct intf_data * dev);
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
+(struct device *dev, char *buf, size_t count, loff_t off) 		\
+{									\
+	unsigned int value = 0;						\
+									\
+	if (!dev || off)						\
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
+(struct device *dev, const char *buf, size_t count, loff_t off)		\
+{									\
+	unsigned int ret = -EINVAL;					\
+	struct cpufreq_policy policy;					\
+									\
+	if (!dev || off)						\
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
+static ssize_t show_scaling_governor (struct device *dev, char *buf, 
+				      size_t count, loff_t off)
+{
+	unsigned int value = 0;
+
+	if (!dev || off)
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
+	return 0;
+}
+
+
+/**
+ * store_scaling_governor - store policy for the specified CPU
+ */
+static ssize_t store_scaling_governor (struct device *dev, const char *buf, 
+				       size_t count, loff_t off)
+{
+	unsigned int ret = -EINVAL;
+	char	str_governor[16];
+	struct cpufreq_policy policy;
+
+	if (!dev || off)
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
+int cpufreq_add_dev (struct device * dev)
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
+int cpufreq_remove_dev (struct intf_data *intf)
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
@@ -95,10 +341,9 @@
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
@@ -108,7 +353,7 @@
 	policy->policy = 0;
 	policy->cpu = CPUFREQ_ALL_CPUS;
 
-	if (sscanf(input_string, "%d:%d:%d:%s", &cpu, &min, &max, policy_string) == 4) 
+	if (sscanf(input_string, "%d:%d:%d:%15s", &cpu, &min, &max, str_governor) == 4) 
 	{
 		policy->min = min;
 		policy->max = max;
@@ -116,7 +361,7 @@
 		result = 0;
 		goto scan_policy;
 	}
-	if (sscanf(input_string, "%d%%%d%%%d%%%s", &cpu, &min, &max, policy_string) == 4)
+	if (sscanf(input_string, "%d%%%d%%%d%%%15s", &cpu, &min, &max, str_governor) == 4)
 	{
 		if (!cpufreq_get_policy(&current_policy, cpu)) {
 			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
@@ -127,7 +372,7 @@
 		}
 	}
 
-	if (sscanf(input_string, "%d:%d:%s", &min, &max, policy_string) == 3) 
+	if (sscanf(input_string, "%d:%d:%15s", &min, &max, str_governor) == 3) 
 	{
 		policy->min = min;
 		policy->max = max;
@@ -135,7 +380,7 @@
 		goto scan_policy;
 	}
 
-	if (sscanf(input_string, "%d%%%d%%%s", &min, &max, policy_string) == 3)
+	if (sscanf(input_string, "%d%%%d%%%15s", &min, &max, str_governor) == 3)
 	{
 		if (!cpufreq_get_policy(&current_policy, cpu)) {
 			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
@@ -148,36 +393,7 @@
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
@@ -345,12 +561,17 @@
 	remove_proc_entry("cpufreq", &proc_root);
 	return;
 }
+#else
+#define cpufreq_proc_init() do {} while(0)
+#define cpufreq_proc_exit() do {} while(0)
 #endif /* CONFIG_PROC_FS */
 
+#endif /* CONFIG_CPU_FREQ_PROC_INTF */
+
 
 
 /*********************************************************************
- *                        2.4. COMPATIBLE API                        *
+ *                      /proc/sys/cpu/ INTERFACE                     *
  *********************************************************************/
 
 #ifdef CONFIG_CPU_FREQ_24_API
@@ -1040,7 +1261,9 @@
 
 	up(&cpufreq_driver_sem);
 
+#ifdef CONFIG_CPU_FREQ_PROC_INTF
 	cpufreq_proc_init();
+#endif
 
 #ifdef CONFIG_CPU_FREQ_24_API
  	down(&cpufreq_driver_sem);
@@ -1055,7 +1278,9 @@
 	cpufreq_sysctl_init();
 #endif
 
-	return 0;
+	ret = interface_register(&cpufreq_interface);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register);
 
@@ -1077,11 +1302,14 @@
 		return -EINVAL;
 	}
 
+	interface_unregister(&cpufreq_interface);
 	cpufreq_driver = NULL;
 
 	up(&cpufreq_driver_sem);
 
+#ifdef CONFIG_CPU_FREQ_PROC_INTF
 	cpufreq_proc_exit();
+#endif
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpufreq_sysctl_exit();
