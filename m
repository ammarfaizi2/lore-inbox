Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbTCFX1W>; Thu, 6 Mar 2003 18:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbTCFX0s>; Thu, 6 Mar 2003 18:26:48 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:43513 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261273AbTCFXZt>; Thu, 6 Mar 2003 18:25:49 -0500
Date: Fri, 7 Mar 2003 00:31:04 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq (2/7): fix userspace governor [Was: Re: 2.5.64: cpufreq "userspace" governor doesn't compile]
Message-ID: <20030306233104.GD1016@brodo.de>
References: <20030306172803.D838@flint.arm.linux.org.uk> <Pine.LNX.4.33.0303061111530.994-100000@localhost.localdomain> <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com> <20030305195311.GH20423@fs.tum.de> <20030306172803.D838@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303061111530.994-100000@localhost.localdomain> <20030306172803.D838@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
