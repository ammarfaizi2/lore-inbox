Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbTCIT3l>; Sun, 9 Mar 2003 14:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTCIT3Z>; Sun, 9 Mar 2003 14:29:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262579AbTCITZu>; Sun, 9 Mar 2003 14:25:50 -0500
Date: Sun, 9 Mar 2003 19:36:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (2/7): fix userspace governor
Message-ID: <20030309193627.C26266@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Dominik Brodowski <linux@brodo.de> -----

From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq (2/7): fix userspace governor
Date: Fri, 7 Mar 2003 11:08:58 +0100

Let's put the sysfs file exported by the cpufreq userspace governor also
into the cpufreq/ - subdirectory of /sys/devices/sys/cpu0/.

 drivers/cpufreq/userspace.c |   29 ++++++++++++-----------------
 include/linux/cpufreq.h     |   10 +++++++++-
 kernel/cpufreq.c            |    6 ------
 3 files changed, 21 insertions(+), 24 deletions(-)


	Dominik

diff -u linux-original/drivers/cpufreq/userspace.c linux/drivers/cpufreq/userspace.c
--- linux-original/drivers/cpufreq/userspace.c	2003-03-06 20:38:35.000000000 +0100
+++ linux/drivers/cpufreq/userspace.c	2003-03-06 21:12:33.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/sysctl.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/sysfs.h>
 
 #include <asm/uaccess.h>
 
@@ -465,23 +466,14 @@
 
 
 /************************** sysfs interface ************************/
-static inline int to_cpu_nr (struct device *dev)
+static ssize_t show_speed (struct cpufreq_policy *policy, char *buf)
 {
-	struct sys_device * cpu_sys_dev = container_of(dev, struct sys_device, dev);
-	return (cpu_sys_dev->id);
-}
-
-static ssize_t show_speed (struct device *dev, char *buf)
-{
-	unsigned int cpu = to_cpu_nr(dev);
-
-	return sprintf (buf, "%u\n", cpu_cur_freq[cpu]);
+	return sprintf (buf, "%u\n", cpu_cur_freq[policy->cpu]);
 }
 
 static ssize_t 
-store_speed (struct device *dev, const char *buf, size_t count) 
+store_speed (struct cpufreq_policy *policy, const char *buf, size_t count) 
 {
-	unsigned int cpu = to_cpu_nr(dev);
 	unsigned int freq = 0;
 	unsigned int ret;
 
@@ -489,13 +481,16 @@
 	if (ret != 1)
 		return -EINVAL;
 
-	cpufreq_set(freq, cpu);
+	cpufreq_set(freq, policy->cpu);
 
 	return count;
 }
 
-static DEVICE_ATTR(scaling_setspeed, (S_IRUGO | S_IWUSR), show_speed, store_speed);
-
+static struct freq_attr freq_attr_scaling_setspeed = {
+	.attr = { .name = "scaling_setspeed", .mode = 0644 },
+	.show = show_speed,
+	.store = store_speed,
+};
 
 static int cpufreq_governor_userspace(struct cpufreq_policy *policy,
 				   unsigned int event)
@@ -511,7 +506,7 @@
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
 		cpu_cur_freq[cpu] = policy->cur;
-		device_create_file (policy->dev, &dev_attr_scaling_setspeed);
+		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		up(&userspace_sem);
 		break;
@@ -520,7 +515,7 @@
 		cpu_is_managed[cpu] = 0;
 		cpu_min_freq[cpu] = 0;
 		cpu_max_freq[cpu] = 0;
-		device_remove_file (policy->dev, &dev_attr_scaling_setspeed);
+		sysfs_remove_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		up(&userspace_sem);
 		module_put(THIS_MODULE);
 		break;
diff -u linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-03-06 19:13:52.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-03-06 21:08:24.000000000 +0100
@@ -18,7 +18,8 @@
 #include <linux/notifier.h>
 #include <linux/threads.h>
 #include <linux/device.h>
-
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 #define CPUFREQ_NAME_LEN 16
 
@@ -194,6 +195,13 @@
 	return;
 }
 
+struct freq_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpufreq_policy *, char *);
+	ssize_t (*store)(struct cpufreq_policy *, const char *, size_t count);
+};
+
+
 /*********************************************************************
  *                        CPUFREQ 2.6. INTERFACE                     *
  *********************************************************************/
diff -u linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-03-06 21:14:44.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-03-06 21:08:24.000000000 +0100
@@ -256,12 +256,6 @@
 }
 
 
-struct freq_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct cpufreq_policy *, char *);
-	ssize_t (*store)(struct cpufreq_policy *, const char *, size_t count);
-};
-
 #define define_one_ro(_name) \
 struct freq_attr _name = { \
 	.attr = { .name = __stringify(_name), .mode = 0444 }, \

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

