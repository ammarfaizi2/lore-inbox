Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268232AbTCFRan>; Thu, 6 Mar 2003 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268233AbTCFRan>; Thu, 6 Mar 2003 12:30:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268232AbTCFRai>;
	Thu, 6 Mar 2003 12:30:38 -0500
Date: Thu, 6 Mar 2003 11:16:40 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Russell King <rmk@arm.linux.org.uk>
cc: Adrian Bunk <bunk@fs.tum.de>, Dominik Brodowski <linux@brodo.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64: cpufreq "userspace" governor doesn't compile
In-Reply-To: <20030306172803.D838@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0303061111530.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Russell King wrote:

> On Wed, Mar 05, 2003 at 08:53:12PM +0100, Adrian Bunk wrote:
> >   gcc -Wp,-MD,drivers/cpufreq/.userspace.o.d -D__KERNEL__ -Iinclude 
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> > -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
> > -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
> > -DKBUILD_BASENAME=userspace -DKBUILD_MODNAME=userspace -c -o 
> > drivers/cpufreq/userspace.o drivers/cpufreq/userspace.c
> > drivers/cpufreq/userspace.c: In function `cpufreq_governor_userspace':
> > drivers/cpufreq/userspace.c:514: structure has no member named `intf'
> > drivers/cpufreq/userspace.c:523: structure has no member named `intf'
> > make[2]: *** [drivers/cpufreq/userspace.o] Error 1
> 
> Dominik sent this patch to the cpufreq list to fix this.  I'm not
> sure if it fixes this exact problem, but from reading the patch I
> think its worth a try.  (its currently building here.)
> 
> --- Dominik's message follows ---
> 
> Forgot to cc the cpufreq list...: I just sent this patch to Linus:
> 
> - update the userspace governor sysfs interface to get along with the
>   new "device interface" model
> 
>  drivers/cpufreq/userspace.c |   29 ++++++++++++-----------------
>  include/linux/cpufreq.h     |   10 +++++++++-
>  kernel/cpufreq.c            |    6 ------
>  3 files changed, 21 insertions(+), 24 deletions(-)

I sent a patch to Linus last night that fixed the compile error, since I
broke it, but wasn't as complete a fix as this.

Dominik, the patch below is the patch just sent, relative to the current
BK tree. Sorry about this..

	-pat

===== drivers/cpufreq/userspace.c 1.2 vs edited =====
--- 1.2/drivers/cpufreq/userspace.c	Wed Mar  5 17:44:20 2003
+++ edited/drivers/cpufreq/userspace.c	Thu Mar  6 11:11:49 2003
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
===== include/linux/cpufreq.h 1.18 vs edited =====
--- 1.18/include/linux/cpufreq.h	Mon Mar  3 16:38:51 2003
+++ edited/include/linux/cpufreq.h	Thu Mar  6 11:09:36 2003
@@ -18,7 +18,8 @@
 #include <linux/notifier.h>
 #include <linux/threads.h>
 #include <linux/device.h>
-
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 #define CPUFREQ_NAME_LEN 16
 
@@ -193,6 +194,13 @@
 		policy->min = policy->max;
 	return;
 }
+
+struct freq_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpufreq_policy *, char *);
+	ssize_t (*store)(struct cpufreq_policy *, const char *, size_t count);
+};
+
 
 /*********************************************************************
  *                        CPUFREQ 2.6. INTERFACE                     *
===== kernel/cpufreq.c 1.21 vs edited =====
--- 1.21/kernel/cpufreq.c	Mon Mar  3 16:38:51 2003
+++ edited/kernel/cpufreq.c	Thu Mar  6 11:09:36 2003
@@ -206,12 +206,6 @@
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

