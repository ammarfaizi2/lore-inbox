Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268177AbTCFRRs>; Thu, 6 Mar 2003 12:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTCFRRs>; Thu, 6 Mar 2003 12:17:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268177AbTCFRRh>; Thu, 6 Mar 2003 12:17:37 -0500
Date: Thu, 6 Mar 2003 17:28:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dominik Brodowski <linux@brodo.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64: cpufreq "userspace" governor doesn't compile
Message-ID: <20030306172803.D838@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Dominik Brodowski <linux@brodo.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com> <20030305195311.GH20423@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305195311.GH20423@fs.tum.de>; from bunk@fs.tum.de on Wed, Mar 05, 2003 at 08:53:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 08:53:12PM +0100, Adrian Bunk wrote:
>   gcc -Wp,-MD,drivers/cpufreq/.userspace.o.d -D__KERNEL__ -Iinclude 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=userspace -DKBUILD_MODNAME=userspace -c -o 
> drivers/cpufreq/userspace.o drivers/cpufreq/userspace.c
> drivers/cpufreq/userspace.c: In function `cpufreq_governor_userspace':
> drivers/cpufreq/userspace.c:514: structure has no member named `intf'
> drivers/cpufreq/userspace.c:523: structure has no member named `intf'
> make[2]: *** [drivers/cpufreq/userspace.o] Error 1

Dominik sent this patch to the cpufreq list to fix this.  I'm not
sure if it fixes this exact problem, but from reading the patch I
think its worth a try.  (its currently building here.)

--- Dominik's message follows ---

Forgot to cc the cpufreq list...: I just sent this patch to Linus:

- update the userspace governor sysfs interface to get along with the
  new "device interface" model

 drivers/cpufreq/userspace.c |   29 ++++++++++++-----------------
 include/linux/cpufreq.h     |   10 +++++++++-
 kernel/cpufreq.c            |    6 ------
 3 files changed, 21 insertions(+), 24 deletions(-)

Please apply,
       Dominik

diff -ruN linux-original/drivers/cpufreq/userspace.c linux/drivers/cpufreq/userspace.c
--- linux-original/drivers/cpufreq/userspace.c	2003-03-04 22:27:01.000000000 +0100
+++ linux/drivers/cpufreq/userspace.c	2003-03-04 22:45:43.000000000 +0100
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
-		device_create_file (policy->intf.dev, &dev_attr_scaling_setspeed);
+		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		up(&userspace_sem);
 		break;
@@ -520,7 +515,7 @@
 		cpu_is_managed[cpu] = 0;
 		cpu_min_freq[cpu] = 0;
 		cpu_max_freq[cpu] = 0;
-		device_remove_file (policy->intf.dev, &dev_attr_scaling_setspeed);
+		sysfs_remove_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		up(&userspace_sem);
 		module_put(THIS_MODULE);
 		break;
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-03-04 22:27:20.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-03-04 22:46:14.000000000 +0100
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
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-03-04 22:54:45.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-03-04 22:40:40.000000000 +0100
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

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

