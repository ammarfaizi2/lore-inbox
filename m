Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTBHRGg>; Sat, 8 Feb 2003 12:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbTBHRGg>; Sat, 8 Feb 2003 12:06:36 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:48362 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267039AbTBHRGZ>; Sat, 8 Feb 2003 12:06:25 -0500
Date: Sat, 8 Feb 2003 18:13:58 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][RESEND] cpufreq: move /proc/cpufreq interface code to drivers/cpufreq
Message-ID: <20030208171358.GB1924@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The deprecated /proc/cpufreq interface can easily live outside the
cpufreq core now.

 arch/arm/Kconfig            |    4
 arch/i386/Kconfig           |    2
 arch/sparc64/Kconfig        |    3
 drivers/cpufreq/Kconfig     |   11 +
 drivers/cpufreq/Makefile    |    1
 drivers/cpufreq/proc_intf.c |  243 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h     |    2
 kernel/cpufreq.c            |  248 --------------------------------------------
 8 files changed, 263 insertions(+), 251 deletions(-)

diff -ruN linux-original/arch/arm/Kconfig linux/arch/arm/Kconfig
--- linux-original/arch/arm/Kconfig	2003-02-04 08:51:34.000000000 +0100
+++ linux/arch/arm/Kconfig	2003-02-04 09:06:54.000000000 +0100
@@ -539,8 +539,8 @@
 	depends on CPU_FREQ
 	default y
 
-config CPU_FREQ_26_API
-	bool
+config CPU_FREQ_PROC_INTF
+	tristate
 	depends on CPU_FREQ
 	default y
 
diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-02-04 09:09:20.000000000 +0100
+++ linux/arch/i386/Kconfig	2003-02-04 09:06:54.000000000 +0100
@@ -958,7 +958,7 @@
 	  If in doubt, say N.
 
 config CPU_FREQ_PROC_INTF
-	bool "/proc/cpufreq interface (DEPRECATED)"
+	tristate "/proc/cpufreq interface (DEPRECATED)"
 	depends on CPU_FREQ && PROC_FS
 	help
 	  This enables the /proc/cpufreq interface for controlling
diff -ruN linux-original/arch/sparc64/Kconfig linux/arch/sparc64/Kconfig
--- linux-original/arch/sparc64/Kconfig	2003-02-04 09:09:20.000000000 +0100
+++ linux/arch/sparc64/Kconfig	2003-02-04 09:06:54.000000000 +0100
@@ -151,7 +151,7 @@
 	  If in doubt, say N.
 
 config CPU_FREQ_PROC_INTF
-	bool "/proc/cpufreq interface (DEPRECATED)"
+	tristate "/proc/cpufreq interface (DEPRECATED)"
 	depends on CPU_FREQ && PROC_FS
 	help
 	  This enables the /proc/cpufreq interface for controlling
@@ -166,7 +166,6 @@
        tristate
        default y
 
-
 config US3_FREQ
 	tristate "UltraSPARC-III CPU Frequency driver"
 	depends on CPU_FREQ && CPU_FREQ_TABLE
diff -ruN linux-original/drivers/cpufreq/Kconfig linux/drivers/cpufreq/Kconfig
--- linux-original/drivers/cpufreq/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/cpufreq/Kconfig	2003-02-04 09:08:00.000000000 +0100
@@ -0,0 +1,11 @@
+config CPU_FREQ_PROC_INTF
+	tristate "/proc/cpufreq interface (deprecated)"
+	depends on CPU_FREQ && PROC_FS
+	help
+	  This enables the /proc/cpufreq interface for controlling
+	  CPUFreq. Please note that it is recommended to use the sysfs
+	  interface instead (which is built automatically). 
+	  
+	  For details, take a look at linux/Documentation/cpufreq. 
+	  
+	  If in doubt, say N.
diff -ruN linux-original/drivers/cpufreq/Makefile linux/drivers/cpufreq/Makefile
--- linux-original/drivers/cpufreq/Makefile	2003-02-04 09:09:20.000000000 +0100
+++ linux/drivers/cpufreq/Makefile	2003-02-04 09:07:13.000000000 +0100
@@ -1,2 +1,3 @@
 #CPUfreq governors and cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
+obj-$(CONFIG_CPU_FREQ_PROC_INTF)	+= proc_intf.o
diff -ruN linux-original/drivers/cpufreq/proc_intf.c linux/drivers/cpufreq/proc_intf.c
--- linux-original/drivers/cpufreq/proc_intf.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/cpufreq/proc_intf.c	2003-02-04 09:06:55.000000000 +0100
@@ -0,0 +1,244 @@
+/*
+ * linux/drivers/cpufreq/proc_intf.c
+ *
+ * Copyright (C) 2002 - 2003 Dominik Brodowski
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/ctype.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+
+/**
+ * cpufreq_parse_policy - parse a policy string
+ * @input_string: the string to parse.
+ * @policy: the policy written inside input_string
+ *
+ * This function parses a "policy string" - something the user echo'es into
+ * /proc/cpufreq or gives as boot parameter - into a struct cpufreq_policy.
+ * If there are invalid/missing entries, they are replaced with current
+ * cpufreq policy.
+ */
+static int cpufreq_parse_policy(char input_string[42], struct cpufreq_policy *policy)
+{
+	unsigned int            min = 0;
+	unsigned int            max = 0;
+	unsigned int            cpu = 0;
+	char			str_governor[16];
+	struct cpufreq_policy   current_policy;
+	unsigned int            result = -EFAULT;
+
+	if (!policy)
+		return -EINVAL;
+
+	policy->min = 0;
+	policy->max = 0;
+	policy->policy = 0;
+	policy->cpu = CPUFREQ_ALL_CPUS;
+
+	if (sscanf(input_string, "%d:%d:%d:%15s", &cpu, &min, &max, str_governor) == 4) 
+	{
+		policy->min = min;
+		policy->max = max;
+		policy->cpu = cpu;
+		result = 0;
+		goto scan_policy;
+	}
+	if (sscanf(input_string, "%d%%%d%%%d%%%15s", &cpu, &min, &max, str_governor) == 4)
+	{
+		if (!cpufreq_get_policy(&current_policy, cpu)) {
+			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
+			policy->max = (max * current_policy.cpuinfo.max_freq) / 100;
+			policy->cpu = cpu;
+			result = 0;
+			goto scan_policy;
+		}
+	}
+
+	if (sscanf(input_string, "%d:%d:%15s", &min, &max, str_governor) == 3) 
+	{
+		policy->min = min;
+		policy->max = max;
+		result = 0;
+		goto scan_policy;
+	}
+
+	if (sscanf(input_string, "%d%%%d%%%15s", &min, &max, str_governor) == 3)
+	{
+		if (!cpufreq_get_policy(&current_policy, cpu)) {
+			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
+			policy->max = (max * current_policy.cpuinfo.max_freq) / 100;
+			result = 0;
+			goto scan_policy;
+		}
+	}
+
+	return -EINVAL;
+
+scan_policy:
+	result = cpufreq_parse_governor(str_governor, &policy->policy, &policy->governor);
+
+	return result;
+}
+
+/**
+ * cpufreq_proc_read - read /proc/cpufreq
+ *
+ * This function prints out the current cpufreq policy.
+ */
+static int cpufreq_proc_read (
+	char			*page,
+	char			**start,
+	off_t			off,
+	int 			count,
+	int 			*eof,
+	void			*data)
+{
+	char			*p = page;
+	int			len = 0;
+	struct cpufreq_policy   policy;
+	unsigned int            min_pctg = 0;
+	unsigned int            max_pctg = 0;
+	unsigned int            i = 0;
+
+	if (off != 0)
+		goto end;
+
+	p += sprintf(p, "          minimum CPU frequency  -  maximum CPU frequency  -  policy\n");
+	for (i=0;i<NR_CPUS;i++) {
+		if (!cpu_online(i))
+			continue;
+
+		if (cpufreq_get_policy(&policy, i))
+			continue;
+
+		if (!policy.cpuinfo.max_freq)
+			continue;
+
+		min_pctg = (policy.min * 100) / policy.cpuinfo.max_freq;
+		max_pctg = (policy.max * 100) / policy.cpuinfo.max_freq;
+
+		p += sprintf(p, "CPU%3d    %9d kHz (%3d %%)  -  %9d kHz (%3d %%)  -  ",
+			     i , policy.min, min_pctg, policy.max, max_pctg);
+		switch (policy.policy) {
+		case CPUFREQ_POLICY_POWERSAVE:
+			p += sprintf(p, "powersave\n");
+			break;
+		case CPUFREQ_POLICY_PERFORMANCE:
+			p += sprintf(p, "performance\n");
+			break;
+		case CPUFREQ_POLICY_GOVERNOR:
+			p += snprintf(p, CPUFREQ_NAME_LEN, "%s\n", policy.governor->name);
+			break;
+		default:
+			p += sprintf(p, "INVALID\n");
+			break;
+		}
+	}
+end:
+	len = (p - page);
+	if (len <= off+count) 
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) 
+		len = count;
+	if (len<0) 
+		len = 0;
+
+	return len;
+}
+
+
+/**
+ * cpufreq_proc_write - handles writing into /proc/cpufreq
+ *
+ * This function calls the parsing script and then sets the policy
+ * accordingly.
+ */
+static int cpufreq_proc_write (
+        struct file		*file,
+        const char		*buffer,
+        unsigned long		count,
+        void			*data)
+{
+	int                     result = 0;
+	char			proc_string[42] = {'\0'};
+	struct cpufreq_policy   policy;
+	unsigned int            i = 0;
+
+
+	if ((count > sizeof(proc_string) - 1))
+		return -EINVAL;
+	
+	if (copy_from_user(proc_string, buffer, count))
+		return -EFAULT;
+	
+	proc_string[count] = '\0';
+
+	result = cpufreq_parse_policy(proc_string, &policy);
+	if (result)
+		return -EFAULT;
+
+	if (policy.cpu == CPUFREQ_ALL_CPUS)
+	{
+		for (i=0; i<NR_CPUS; i++) 
+		{
+			policy.cpu = i;
+			if (cpu_online(i))
+				cpufreq_set_policy(&policy);
+		}
+	} 
+	else
+		cpufreq_set_policy(&policy);
+
+	return count;
+}
+
+
+/**
+ * cpufreq_proc_init - add "cpufreq" to the /proc root directory
+ *
+ * This function adds "cpufreq" to the /proc root directory.
+ */
+static int __init cpufreq_proc_init (void)
+{
+	struct proc_dir_entry *entry = NULL;
+
+        /* are these acceptable values? */
+	entry = create_proc_entry("cpufreq", S_IFREG|S_IRUGO|S_IWUSR, 
+				  &proc_root);
+
+	if (!entry) {
+		printk(KERN_ERR "unable to create /proc/cpufreq entry\n");
+		return -EIO;
+	} else {
+		entry->read_proc = cpufreq_proc_read;
+		entry->write_proc = cpufreq_proc_write;
+	}
+
+	return 0;
+}
+
+
+/**
+ * cpufreq_proc_exit - removes "cpufreq" from the /proc root directory.
+ *
+ * This function removes "cpufreq" from the /proc root directory.
+ */
+static void __exit cpufreq_proc_exit (void)
+{
+	remove_proc_entry("cpufreq", &proc_root);
+	return;
+}
+
+MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION ("CPUfreq /proc/cpufreq interface");
+MODULE_LICENSE ("GPL");
+
+module_init(cpufreq_proc_init);
+module_exit(cpufreq_proc_exit);
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-02-04 09:09:20.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-02-04 09:06:55.000000000 +0100
@@ -205,6 +205,8 @@
 int cpufreq_restore(void);
 #endif
 
+/* the proc_intf.c needs this */
+int cpufreq_parse_governor (char *str_governor, unsigned int *policy, struct cpufreq_governor **governor);
 
 #ifdef CONFIG_CPU_FREQ_24_API
 /*********************************************************************
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-02-04 09:09:20.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-02-04 09:06:55.000000000 +0100
@@ -23,12 +23,6 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_CPU_FREQ_PROC_INTF
-#include <linux/ctype.h>
-#include <linux/proc_fs.h>
-#include <asm/uaccess.h>
-#endif
-
 #ifdef CONFIG_CPU_FREQ_24_API
 #include <linux/proc_fs.h>
 #include <linux/sysctl.h>
@@ -77,7 +71,7 @@
 /**
  * cpufreq_parse_governor - parse a governor string
  */
-static int cpufreq_parse_governor (char *str_governor, unsigned int *policy, struct cpufreq_governor **governor)
+int cpufreq_parse_governor (char *str_governor, unsigned int *policy, struct cpufreq_governor **governor)
 {
 	if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 		*policy = CPUFREQ_POLICY_PERFORMANCE;
@@ -103,6 +97,7 @@
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(cpufreq_parse_governor);
 
 
 /* forward declarations */
@@ -430,241 +425,6 @@
 
 
 /*********************************************************************
- *                      /proc/cpufreq INTERFACE                      *
- *********************************************************************/
-
-#ifdef CONFIG_CPU_FREQ_PROC_INTF
-
-/**
- * cpufreq_parse_policy - parse a policy string
- * @input_string: the string to parse.
- * @policy: the policy written inside input_string
- *
- * This function parses a "policy string" - something the user echo'es into
- * /proc/cpufreq or gives as boot parameter - into a struct cpufreq_policy.
- * If there are invalid/missing entries, they are replaced with current
- * cpufreq policy.
- */
-static int cpufreq_parse_policy(char input_string[42], struct cpufreq_policy *policy)
-{
-	unsigned int            min = 0;
-	unsigned int            max = 0;
-	unsigned int            cpu = 0;
-	char			str_governor[16];
-	struct cpufreq_policy   current_policy;
-	unsigned int            result = -EFAULT;
-
-	if (!policy)
-		return -EINVAL;
-
-	policy->min = 0;
-	policy->max = 0;
-	policy->policy = 0;
-	policy->cpu = CPUFREQ_ALL_CPUS;
-
-	if (sscanf(input_string, "%d:%d:%d:%15s", &cpu, &min, &max, str_governor) == 4) 
-	{
-		policy->min = min;
-		policy->max = max;
-		policy->cpu = cpu;
-		result = 0;
-		goto scan_policy;
-	}
-	if (sscanf(input_string, "%d%%%d%%%d%%%15s", &cpu, &min, &max, str_governor) == 4)
-	{
-		if (!cpufreq_get_policy(&current_policy, cpu)) {
-			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
-			policy->max = (max * current_policy.cpuinfo.max_freq) / 100;
-			policy->cpu = cpu;
-			result = 0;
-			goto scan_policy;
-		}
-	}
-
-	if (sscanf(input_string, "%d:%d:%15s", &min, &max, str_governor) == 3) 
-	{
-		policy->min = min;
-		policy->max = max;
-		result = 0;
-		goto scan_policy;
-	}
-
-	if (sscanf(input_string, "%d%%%d%%%15s", &min, &max, str_governor) == 3)
-	{
-		if (!cpufreq_get_policy(&current_policy, cpu)) {
-			policy->min = (min * current_policy.cpuinfo.max_freq) / 100;
-			policy->max = (max * current_policy.cpuinfo.max_freq) / 100;
-			result = 0;
-			goto scan_policy;
-		}
-	}
-
-	return -EINVAL;
-
-scan_policy:
-	result = cpufreq_parse_governor(str_governor, &policy->policy, &policy->governor);
-
-	return result;
-}
-
-/**
- * cpufreq_proc_read - read /proc/cpufreq
- *
- * This function prints out the current cpufreq policy.
- */
-static int cpufreq_proc_read (
-	char			*page,
-	char			**start,
-	off_t			off,
-	int 			count,
-	int 			*eof,
-	void			*data)
-{
-	char			*p = page;
-	int			len = 0;
-	struct cpufreq_policy   policy;
-	unsigned int            min_pctg = 0;
-	unsigned int            max_pctg = 0;
-	unsigned int            i = 0;
-
-	if (off != 0)
-		goto end;
-
-	p += sprintf(p, "          minimum CPU frequency  -  maximum CPU frequency  -  policy\n");
-	for (i=0;i<NR_CPUS;i++) {
-		if (!cpu_online(i))
-			continue;
-
-		if (cpufreq_get_policy(&policy, i))
-			continue;
-
-		if (!policy.cpuinfo.max_freq)
-			continue;
-
-		min_pctg = (policy.min * 100) / policy.cpuinfo.max_freq;
-		max_pctg = (policy.max * 100) / policy.cpuinfo.max_freq;
-
-		p += sprintf(p, "CPU%3d    %9d kHz (%3d %%)  -  %9d kHz (%3d %%)  -  ",
-			     i , policy.min, min_pctg, policy.max, max_pctg);
-		switch (policy.policy) {
-		case CPUFREQ_POLICY_POWERSAVE:
-			p += sprintf(p, "powersave\n");
-			break;
-		case CPUFREQ_POLICY_PERFORMANCE:
-			p += sprintf(p, "performance\n");
-			break;
-		case CPUFREQ_POLICY_GOVERNOR:
-			p += snprintf(p, CPUFREQ_NAME_LEN, "%s\n", policy.governor->name);
-			break;
-		default:
-			p += sprintf(p, "INVALID\n");
-			break;
-		}
-	}
-end:
-	len = (p - page);
-	if (len <= off+count) 
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) 
-		len = count;
-	if (len<0) 
-		len = 0;
-
-	return len;
-}
-
-
-/**
- * cpufreq_proc_write - handles writing into /proc/cpufreq
- *
- * This function calls the parsing script and then sets the policy
- * accordingly.
- */
-static int cpufreq_proc_write (
-        struct file		*file,
-        const char		*buffer,
-        unsigned long		count,
-        void			*data)
-{
-	int                     result = 0;
-	char			proc_string[42] = {'\0'};
-	struct cpufreq_policy   policy;
-	unsigned int            i = 0;
-
-
-	if ((count > sizeof(proc_string) - 1))
-		return -EINVAL;
-	
-	if (copy_from_user(proc_string, buffer, count))
-		return -EFAULT;
-	
-	proc_string[count] = '\0';
-
-	result = cpufreq_parse_policy(proc_string, &policy);
-	if (result)
-		return -EFAULT;
-
-	if (policy.cpu == CPUFREQ_ALL_CPUS)
-	{
-		for (i=0; i<NR_CPUS; i++) 
-		{
-			policy.cpu = i;
-			if (cpu_online(i))
-				cpufreq_set_policy(&policy);
-		}
-	} 
-	else
-		cpufreq_set_policy(&policy);
-
-	return count;
-}
-
-
-/**
- * cpufreq_proc_init - add "cpufreq" to the /proc root directory
- *
- * This function adds "cpufreq" to the /proc root directory.
- */
-static unsigned int cpufreq_proc_init (void)
-{
-	struct proc_dir_entry *entry = NULL;
-
-        /* are these acceptable values? */
-	entry = create_proc_entry("cpufreq", S_IFREG|S_IRUGO|S_IWUSR, 
-				  &proc_root);
-
-	if (!entry) {
-		printk(KERN_ERR "unable to create /proc/cpufreq entry\n");
-		return -EIO;
-	} else {
-		entry->read_proc = cpufreq_proc_read;
-		entry->write_proc = cpufreq_proc_write;
-	}
-
-	return 0;
-}
-
-
-/**
- * cpufreq_proc_exit - removes "cpufreq" from the /proc root directory.
- *
- * This function removes "cpufreq" from the /proc root directory.
- */
-static void cpufreq_proc_exit (void)
-{
-	remove_proc_entry("cpufreq", &proc_root);
-	return;
-}
-#else
-#define cpufreq_proc_init() do {} while(0)
-#define cpufreq_proc_exit() do {} while(0)
-#endif /* CONFIG_CPU_FREQ_PROC_INTF */
-
-
-
-/*********************************************************************
  *                      /proc/sys/cpu/ INTERFACE                     *
  *********************************************************************/
 
@@ -1485,8 +1245,6 @@
 	
 	up(&cpufreq_driver_sem);
 
-	cpufreq_proc_init();
-
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpufreq_sysctl_init();
 #endif
@@ -1516,8 +1274,6 @@
 		return -EINVAL;
 	}
 
-	cpufreq_proc_exit();
-
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpufreq_sysctl_exit();
 #endif
