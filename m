Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbTCIT3m>; Sun, 9 Mar 2003 14:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbTCIT2x>; Sun, 9 Mar 2003 14:28:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34834 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262583AbTCIT0A>; Sun, 9 Mar 2003 14:26:00 -0500
Date: Sun, 9 Mar 2003 19:36:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (4/7): updated cpufreq ref-counting and locking scheme
Message-ID: <20030309193636.E26266@flint.arm.linux.org.uk>
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
Subject: [PATCH] cpufreq (4/7): updated cpufreq ref-counting and locking scheme
Date: Fri, 7 Mar 2003 11:09:10 +0100

Hi Linus,

This patch takes use of the now-working cpufreq_interface.kset and
cpufreq_policy.kobj to use reference counting within the cpufreq core
wherever this is more appropriate than the previous approach -- using one
semaphore. Additionally, the callbacks to the driver modules are protected 
now.

Please apply,
	Dominik

 arch/i386/kernel/cpu/cpufreq/acpi.c        |    1
 arch/i386/kernel/cpu/cpufreq/elanfreq.c    |    1
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c  |    1
 arch/i386/kernel/cpu/cpufreq/longhaul.c    |    1
 arch/i386/kernel/cpu/cpufreq/longrun.c     |    1
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |    1
 arch/i386/kernel/cpu/cpufreq/powernow-k6.c |    1
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |    1
 arch/i386/kernel/cpu/cpufreq/speedstep.c   |    1
 arch/sparc64/kernel/us3_cpufreq.c          |    1
 drivers/cpufreq/userspace.c                |    2
 include/linux/cpufreq.h                    |   10
 kernel/cpufreq.c                           |  357 ++++++++++++++++-------------
 13 files changed, 216 insertions(+), 163 deletions(-)


diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2003-03-06 21:19:15.000000000 +0100
@@ -619,6 +619,7 @@
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
 	.name		= "acpi-cpufreq",
+	.owner		= THIS_MODULE,
 };
 
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-03-06 21:19:15.000000000 +0100
@@ -250,6 +250,7 @@
 	.target 	= elanfreq_target,
 	.init		= elanfreq_cpu_init,
 	.name		= "elanfreq",
+	.owner		= THIS_MODULE,
 };
 
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-03-06 21:19:15.000000000 +0100
@@ -451,6 +451,7 @@
 	.target		= cpufreq_gx_target,
 	.init		= cpufreq_gx_cpu_init,
 	.name		= "gx-suspmod",
+	.owner		= THIS_MODULE,
 };
 
 static int __init cpufreq_gx_init(void)
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-03-06 21:19:15.000000000 +0100
@@ -649,6 +649,7 @@
 	.target 	= longhaul_target,
 	.init		= longhaul_cpu_init,
 	.name		= "longhaul",
+	.owner		= THIS_MODULE,
 };
 
 static int __init longhaul_init (void)
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-03-06 21:19:15.000000000 +0100
@@ -253,6 +253,7 @@
 	.setpolicy 	= longrun_set_policy,
 	.init		= longrun_cpu_init,
 	.name		= "longrun",
+	.owner		= THIS_MODULE,
 };
 
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-03-06 21:19:15.000000000 +0100
@@ -236,6 +236,7 @@
 	.init		= cpufreq_p4_cpu_init,
 	.exit		= cpufreq_p4_cpu_exit,
 	.name		= "p4-clockmod",
+	.owner		= THIS_MODULE,
 };
 
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-03-06 21:19:15.000000000 +0100
@@ -190,6 +190,7 @@
 	.init		= powernow_k6_cpu_init,
 	.exit		= powernow_k6_cpu_exit,
 	.name		= "powernow-k6",
+	.owner		= THIS_MODULE,
 };
 
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-03-06 21:19:15.000000000 +0100
@@ -377,6 +377,7 @@
 	.target 	= powernow_target,
 	.init		= powernow_cpu_init,
 	.name		= "powernow-k7",
+	.owner		= THIS_MODULE,
 };
 
 static int __init powernow_init (void)
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-03-06 21:19:15.000000000 +0100
@@ -658,6 +658,7 @@
 	.verify 	= speedstep_verify,
 	.target 	= speedstep_target,
 	.init		= speedstep_cpu_init,
+	.owner		= THIS_MODULE,
 };
 
 
diff -ruN linux-original/arch/sparc64/kernel/us3_cpufreq.c linux/arch/sparc64/kernel/us3_cpufreq.c
--- linux-original/arch/sparc64/kernel/us3_cpufreq.c	2003-03-06 19:13:31.000000000 +0100
+++ linux/arch/sparc64/kernel/us3_cpufreq.c	2003-03-06 21:19:16.000000000 +0100
@@ -276,6 +276,7 @@
 		driver->target = us3freq_target;
 		driver->init = us3freq_cpu_init;
 		driver->exit = us3freq_cpu_exit;
+		driver->owner = THIS_MODULE,
 		strcpy(driver->name, "UltraSPARC-III");
 
 		cpufreq_us3_driver = driver;
diff -ruN linux-original/drivers/cpufreq/userspace.c linux/drivers/cpufreq/userspace.c
--- linux-original/drivers/cpufreq/userspace.c	2003-03-06 21:18:02.000000000 +0100
+++ linux/drivers/cpufreq/userspace.c	2003-03-06 21:19:16.000000000 +0100
@@ -113,7 +113,7 @@
 	if (freq > cpu_max_freq[cpu])
 		freq = cpu_max_freq[cpu];
 
-	ret = cpufreq_driver_target_l(&current_policy[cpu], freq, 
+	ret = cpufreq_driver_target(&current_policy[cpu], freq, 
 	      CPUFREQ_RELATION_L);
 
  err:
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-03-06 21:19:04.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-03-06 21:19:16.000000000 +0100
@@ -70,6 +70,8 @@
 	struct cpufreq_cpuinfo  cpuinfo;     /* see above */
 	struct device		* dev;
 	struct kobject		kobj;
+ 	struct semaphore	lock;   /* CPU ->setpolicy or ->target may
+					   only be called once a time */
 };
 
 #define CPUFREQ_ADJUST          (0)
@@ -132,18 +134,13 @@
 };
 
 /* pass a target to the cpufreq driver 
- * _l : (cpufreq_driver_sem is not held)
  */
 inline int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
 
-inline int cpufreq_driver_target_l(struct cpufreq_policy *policy,
-				   unsigned int target_freq,
-				   unsigned int relation);
-
 /* pass an event to the cpufreq governor */
-int cpufreq_governor_l(unsigned int cpu, unsigned int event);
+int cpufreq_governor(unsigned int cpu, unsigned int event);
 
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
@@ -165,6 +162,7 @@
 	int	(*target)	(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
+	struct module           *owner;
 	/* optional, for the moment */
 	int	(*init)		(struct cpufreq_policy *policy);
 	int	(*exit)		(struct cpufreq_policy *policy);
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-03-06 21:19:04.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-03-06 21:23:33.000000000 +0100
@@ -43,12 +43,40 @@
  */
 static struct notifier_block    *cpufreq_policy_notifier_list;
 static struct notifier_block    *cpufreq_transition_notifier_list;
-static DECLARE_MUTEX            (cpufreq_notifier_sem);
+static DECLARE_RWSEM		(cpufreq_notifier_rwsem);
 
 
 LIST_HEAD(cpufreq_governor_list);
+static DECLARE_MUTEX		(cpufreq_governor_sem);
 
-static int cpufreq_governor(unsigned int cpu, unsigned int event);
+static struct device_interface cpufreq_interface;
+
+static int cpufreq_cpu_get(unsigned int cpu) {
+	if (cpu >= NR_CPUS)
+		return 0;
+
+	if (!kset_get(&cpufreq_interface.kset))
+		return 0;
+
+	if (!try_module_get(cpufreq_driver->owner)) {
+		kset_put(&cpufreq_interface.kset);
+		return 0;
+	}
+
+	if (!kobject_get(&cpufreq_driver->policy[cpu].kobj)) {
+		module_put(cpufreq_driver->owner);
+		kset_put(&cpufreq_interface.kset);
+		return 0;
+	}
+
+	return 1;
+}
+
+static void cpufreq_cpu_put(unsigned int cpu) {
+	kobject_put(&cpufreq_driver->policy[cpu].kobj);
+	module_put(cpufreq_driver->owner);
+	kset_put(&cpufreq_interface.kset);
+}
 
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
@@ -67,19 +95,19 @@
 		return 0;
 	} else 	{
 		struct cpufreq_governor *t;
-		down(&cpufreq_driver_sem);
+		down(&cpufreq_governor_sem);
 		if (!cpufreq_driver || !cpufreq_driver->target)
 			goto out;
 		list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
 			if (!strnicmp(str_governor,t->name,CPUFREQ_NAME_LEN)) {
 				*governor = t;
 				*policy = CPUFREQ_POLICY_GOVERNOR;
-				up(&cpufreq_driver_sem);
+				up(&cpufreq_governor_sem);
 				return 0;
 			}
 		}
 	out:
-		up(&cpufreq_driver_sem);
+		up(&cpufreq_governor_sem);
 	}
 	return -EINVAL;
 }
@@ -120,14 +148,7 @@
 static ssize_t show_##file_name 					\
 (struct cpufreq_policy * policy, char *buf)				\
 {									\
-	unsigned int value = 0;						\
-									\
-	down(&cpufreq_driver_sem);					\
-	if (cpufreq_driver)						\
-		value = policy->object;					\
-	up(&cpufreq_driver_sem);					\
-									\
-	return sprintf (buf, "%u\n", value);				\
+	return sprintf (buf, "%u\n", policy->object);			\
 }
 
 show_one(cpuinfo_min_freq, cpuinfo.min_freq);
@@ -147,7 +168,7 @@
 									\
 	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
 	if (ret)							\
-		return ret;						\
+		return -EINVAL;						\
 									\
 	ret = sscanf (buf, "%u", &new_policy.object);			\
 	if (ret != 1)							\
@@ -166,26 +187,16 @@
  */
 static ssize_t show_scaling_governor (struct cpufreq_policy * policy, char *buf)
 {
-	unsigned int value = 0;
-	char value2[CPUFREQ_NAME_LEN];
-
-	down(&cpufreq_driver_sem);
-	if (cpufreq_driver)
-		value = policy->policy;
-	if (value == CPUFREQ_POLICY_GOVERNOR)
-		strncpy(value2, policy->governor->name, CPUFREQ_NAME_LEN);
-	up(&cpufreq_driver_sem);
-
-	switch (value) {
+	switch (policy->policy) {
 	case CPUFREQ_POLICY_POWERSAVE:
 		return sprintf(buf, "powersave\n");
 	case CPUFREQ_POLICY_PERFORMANCE:
 		return sprintf(buf, "performance\n");
 	case CPUFREQ_POLICY_GOVERNOR:
-		return sprintf(buf, "%s\n", value2);
+		return snprintf(buf, CPUFREQ_NAME_LEN, "%s\n", policy->governor->name);
+	default:
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 
@@ -220,14 +231,7 @@
  */
 static ssize_t show_scaling_driver (struct cpufreq_policy * policy, char *buf)
 {
-	char value[CPUFREQ_NAME_LEN];
-
-	down(&cpufreq_driver_sem);
-	if (cpufreq_driver)
-		strncpy(value, cpufreq_driver->name, CPUFREQ_NAME_LEN);
-	up(&cpufreq_driver_sem);
-
-	return sprintf(buf, "%s\n", value);
+	return snprintf(buf, CPUFREQ_NAME_LEN, "%s\n", cpufreq_driver->name);
 }
 
 /**
@@ -240,8 +244,7 @@
 
 	i += sprintf(buf, "performance powersave");
 
-	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver || !cpufreq_driver->target)
+	if (!cpufreq_driver->target)
 		goto out;
 
 	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
@@ -250,7 +253,6 @@
 		i += snprintf(&buf[i], CPUFREQ_NAME_LEN, " %s", t->name);
 	}
  out:
-	up(&cpufreq_driver_sem);
 	i += sprintf(&buf[i], "\n");
 	return i;
 }
@@ -288,7 +290,6 @@
 	NULL
 };
 
-
 #define to_policy(k) container_of(k,struct cpufreq_policy,kobj)
 #define to_attr(a) container_of(a,struct freq_attr,attr)
 
@@ -296,7 +297,12 @@
 {
 	struct cpufreq_policy * policy = to_policy(kobj);
 	struct freq_attr * fattr = to_attr(attr);
-	return fattr->show ? fattr->show(policy,buf) : 0;
+	ssize_t ret;
+	if (!cpufreq_cpu_get(policy->cpu))
+		return -EINVAL;
+	ret = fattr->show ? fattr->show(policy,buf) : 0;
+	cpufreq_cpu_put(policy->cpu);
+	return ret;
 }
 
 static ssize_t store(struct kobject * kobj, struct attribute * attr, 
@@ -304,7 +310,12 @@
 {
 	struct cpufreq_policy * policy = to_policy(kobj);
 	struct freq_attr * fattr = to_attr(attr);
-	return fattr->store ? fattr->store(policy,buf,count) : 0;
+	ssize_t ret;
+	if (!cpufreq_cpu_get(policy->cpu))
+		return -EINVAL;
+	ret = fattr->store ? fattr->store(policy,buf,count) : 0;
+	cpufreq_cpu_put(policy->cpu);
+	return ret;
 }
 
 static struct sysfs_ops sysfs_ops = {
@@ -330,9 +341,11 @@
 	struct cpufreq_policy new_policy;
 	struct cpufreq_policy *policy;
 
-	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver) {
-		up(&cpufreq_driver_sem);
+	if (!kset_get(&cpufreq_interface.kset))
+		return -EINVAL;
+
+	if (!try_module_get(cpufreq_driver->owner)) {
+		kset_put(&cpufreq_interface.kset);
 		return -EINVAL;
 	}
 
@@ -343,26 +356,18 @@
 	policy->cpu = cpu;
 	if (cpufreq_driver->init) {
 		ret = cpufreq_driver->init(policy);
-		if (ret) {
-			up(&cpufreq_driver_sem);
-			return -ENODEV;
-		}
+		if (ret)
+			goto out;
 	}
 
 	/* set default policy on this CPU */
+	down(&cpufreq_driver_sem);
 	memcpy(&new_policy, 
 	       policy, 
 	       sizeof(struct cpufreq_policy));
-
-	if (cpufreq_driver->target)
-		cpufreq_governor(cpu, CPUFREQ_GOV_START);
-
 	up(&cpufreq_driver_sem);
-	ret = cpufreq_set_policy(&new_policy);
-	if (ret)
-		return -EINVAL;
-	down(&cpufreq_driver_sem);
 
+	init_MUTEX(&policy->lock);
 	/* prepare interface data */
 	policy->kobj.parent = &dev->kobj;
 	policy->kobj.ktype = &ktype_cpufreq;
@@ -371,8 +376,17 @@
 		cpufreq_interface.name, KOBJ_NAME_LEN);
 
 	ret = kobject_register(&policy->kobj);
+	if (ret)
+		goto out;
+		
+	/* set default policy */
+	ret = cpufreq_set_policy(&new_policy);
+	if (ret)
+		kobject_unregister(&policy->kobj);
 
-	up(&cpufreq_driver_sem);
+ out:
+	module_put(cpufreq_driver->owner);
+	kset_put(&cpufreq_interface.kset);
 	return ret;
 }
 
@@ -380,21 +394,39 @@
 /**
  * cpufreq_remove_dev - remove a CPU device
  *
- * Removes the cpufreq interface for a CPU device. Is called with
- * cpufreq_driver_sem locked.
+ * Removes the cpufreq interface for a CPU device.
  */
 static int cpufreq_remove_dev (struct device * dev)
 {
 	unsigned int cpu = to_cpu_nr(dev);
 
-	if (cpufreq_driver->target)
-		cpufreq_governor(cpu, CPUFREQ_GOV_STOP);
+	if (!kset_get(&cpufreq_interface.kset))
+		return -EINVAL;
 
+	if (!kobject_get(&cpufreq_driver->policy[cpu].kobj)) {
+		kset_put(&cpufreq_interface.kset);
+		return -EINVAL;
+	}
+
+	down(&cpufreq_driver_sem);
+	if ((cpufreq_driver->target) && 
+	    (cpufreq_driver->policy[cpu].policy == CPUFREQ_POLICY_GOVERNOR)) {
+		cpufreq_driver->policy[cpu].governor->governor(&cpufreq_driver->policy[cpu], CPUFREQ_GOV_STOP);
+		module_put(cpufreq_driver->policy[cpu].governor->owner);
+	}
+
+	/* we may call driver->exit here without checking for try_module_exit
+	 * as it's either the driver which wants to unload or we have a CPU
+	 * removal AND driver removal at the same time...
+	 */
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(&cpufreq_driver->policy[cpu]);
 
 	kobject_unregister(&cpufreq_driver->policy[cpu].kobj);
 
+	up(&cpufreq_driver_sem);
+	kobject_put(&cpufreq_driver->policy[cpu].kobj);
+	kset_put(&cpufreq_interface.kset);
 	return 0;
 }
 
@@ -420,7 +452,7 @@
 {
 	int ret;
 
-	down(&cpufreq_notifier_sem);
+	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = notifier_chain_register(&cpufreq_transition_notifier_list, nb);
@@ -431,7 +463,7 @@
 	default:
 		ret = -EINVAL;
 	}
-	up(&cpufreq_notifier_sem);
+	up_write(&cpufreq_notifier_rwsem);
 
 	return ret;
 }
@@ -452,7 +484,7 @@
 {
 	int ret;
 
-	down(&cpufreq_notifier_sem);
+	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = notifier_chain_unregister(&cpufreq_transition_notifier_list, nb);
@@ -463,7 +495,7 @@
 	default:
 		ret = -EINVAL;
 	}
-	up(&cpufreq_notifier_sem);
+	up_write(&cpufreq_notifier_rwsem);
 
 	return ret;
 }
@@ -474,71 +506,72 @@
  *                              GOVERNORS                            *
  *********************************************************************/
 
-inline int cpufreq_driver_target_l(struct cpufreq_policy *policy,
-				   unsigned int target_freq,
-				   unsigned int relation)
-{
-	unsigned int ret;
-	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver)
-		ret = -EINVAL;
-	else
-		ret = cpufreq_driver->target(policy, target_freq, relation);
-	up(&cpufreq_driver_sem);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cpufreq_driver_target_l);
-
-
 inline int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation)
 {
-	return cpufreq_driver->target(policy, target_freq, relation);
+	unsigned int ret;
+	unsigned int cpu = policy->cpu;
+
+	if (!cpufreq_cpu_get(cpu))
+		return -EINVAL;
+
+	down(&cpufreq_driver->policy[cpu].lock);
+
+	ret = cpufreq_driver->target(policy, target_freq, relation);
+
+	up(&cpufreq_driver->policy[cpu].lock);
+
+	cpufreq_cpu_put(cpu);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
 
-static int cpufreq_governor(unsigned int cpu, unsigned int event)
+int cpufreq_governor(unsigned int cpu, unsigned int event)
 {
 	int ret = 0;
 	struct cpufreq_policy *policy = &cpufreq_driver->policy[cpu];
 
+	if (!cpufreq_cpu_get(cpu))
+		return -EINVAL;
+
 	switch (policy->policy) {
 	case CPUFREQ_POLICY_POWERSAVE: 
-		if ((event == CPUFREQ_GOV_LIMITS) || (event == CPUFREQ_GOV_START))
+		if ((event == CPUFREQ_GOV_LIMITS) || (event == CPUFREQ_GOV_START)) {
+			down(&cpufreq_driver->policy[cpu].lock);
 			ret = cpufreq_driver->target(policy, policy->min, CPUFREQ_RELATION_L);
+			up(&cpufreq_driver->policy[cpu].lock);
+		}
 		break;
 	case CPUFREQ_POLICY_PERFORMANCE:
-		if ((event == CPUFREQ_GOV_LIMITS) || (event == CPUFREQ_GOV_START))
+		if ((event == CPUFREQ_GOV_LIMITS) || (event == CPUFREQ_GOV_START)) {
+			down(&cpufreq_driver->policy[cpu].lock);
 			ret = cpufreq_driver->target(policy, policy->max, CPUFREQ_RELATION_H);
+			up(&cpufreq_driver->policy[cpu].lock);
+		}
 		break;
 	case CPUFREQ_POLICY_GOVERNOR:
 		ret = -EINVAL;
-		if (event == CPUFREQ_GOV_START)
-			if (!try_module_get(cpufreq_driver->policy[cpu].governor->owner))
-				break;
+		if (!try_module_get(cpufreq_driver->policy[cpu].governor->owner))
+			break;
 		ret = cpufreq_driver->policy[cpu].governor->governor(policy, event);
-		if ((event == CPUFREQ_GOV_STOP) ||
-			(ret && (event == CPUFREQ_GOV_START)))
+		/* we keep one module reference alive for each CPU governed by this CPU */
+		if ((event != CPUFREQ_GOV_START) || ret)
+			module_put(cpufreq_driver->policy[cpu].governor->owner);
+		if ((event == CPUFREQ_GOV_STOP) && !ret)
 			module_put(cpufreq_driver->policy[cpu].governor->owner);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-	return ret;
-}
 
+	cpufreq_cpu_put(cpu);
 
-int cpufreq_governor_l(unsigned int cpu, unsigned int event)
-{
-	int ret = 0;
-	down(&cpufreq_driver_sem);
-	ret = cpufreq_governor(cpu, event);
-	up(&cpufreq_driver_sem);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpufreq_governor_l);
+EXPORT_SYMBOL_GPL(cpufreq_governor);
 
 
 int cpufreq_register_governor(struct cpufreq_governor *governor)
@@ -553,16 +586,17 @@
 	if (!strnicmp(governor->name,"performance",CPUFREQ_NAME_LEN))
 		return -EBUSY;
 
-	down(&cpufreq_driver_sem);
+	down(&cpufreq_governor_sem);
 	
 	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
 		if (!strnicmp(governor->name,t->name,CPUFREQ_NAME_LEN)) {
-			up(&cpufreq_driver_sem);
+			up(&cpufreq_governor_sem);
 			return -EBUSY;
 		}
 	}
 	list_add(&governor->governor_list, &cpufreq_governor_list);
- 	up(&cpufreq_driver_sem);
+
+ 	up(&cpufreq_governor_sem);
 
 	return 0;
 }
@@ -576,7 +610,8 @@
 	if (!governor)
 		return;
 
-	down(&cpufreq_driver_sem);
+	down(&cpufreq_governor_sem);
+
 	/* 
 	 * Unless the user uses rmmod -f, we can be safe. But we never
 	 * know, so check whether if it's currently used. If so,
@@ -584,17 +619,21 @@
 	 */
 	for (i=0; i<NR_CPUS; i++)
 	{
-		if (cpufreq_driver && 
-		    (cpufreq_driver->policy[i].policy == CPUFREQ_POLICY_GOVERNOR) && 
+		if (!cpufreq_cpu_get(i))
+			continue;
+		if ((cpufreq_driver->policy[i].policy == CPUFREQ_POLICY_GOVERNOR) && 
 		    (cpufreq_driver->policy[i].governor == governor)) {
 			cpufreq_governor(i, CPUFREQ_GOV_STOP);
 			cpufreq_driver->policy[i].policy = CPUFREQ_POLICY_PERFORMANCE;
 			cpufreq_governor(i, CPUFREQ_GOV_START);
+			cpufreq_governor(i, CPUFREQ_GOV_LIMITS);
 		}
+		cpufreq_cpu_put(i);
 	}
+
 	/* now we can safely remove it from the list */
 	list_del(&governor->governor_list);
-	up(&cpufreq_driver_sem);
+	up(&cpufreq_governor_sem);
 	return;
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
@@ -613,19 +652,17 @@
  */
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 {
-	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver  || !policy || 
-	    (cpu >= NR_CPUS) || (!cpu_online(cpu))) {
-		up(&cpufreq_driver_sem);
+	if (!policy || !cpufreq_cpu_get(cpu))
 		return -EINVAL;
-	}
 
+	down(&cpufreq_driver_sem);
 	memcpy(policy, 
 	       &cpufreq_driver->policy[cpu], 
 	       sizeof(struct cpufreq_policy));
-	
 	up(&cpufreq_driver_sem);
 
+	cpufreq_cpu_put(cpu);
+
 	return 0;
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
@@ -639,27 +676,23 @@
  */
 int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
-	int ret;
+	int ret = 0;
 
-	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver || !policy ||
-	    (policy->cpu >= NR_CPUS) || (!cpu_online(policy->cpu))) {
-		up(&cpufreq_driver_sem);
+	if (!policy || !cpufreq_cpu_get(policy->cpu))
 		return -EINVAL;
-	}
 
+	down(&cpufreq_driver_sem);
 	memcpy(&policy->cpuinfo, 
 	       &cpufreq_driver->policy[policy->cpu].cpuinfo, 
 	       sizeof(struct cpufreq_cpuinfo));
+	up(&cpufreq_driver_sem);
 
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(policy);
-	if (ret) {
-		up(&cpufreq_driver_sem);
-		return ret;
-	}
+	if (ret)
+		goto error_out;
 
-	down(&cpufreq_notifier_sem);
+	down_read(&cpufreq_notifier_rwsem);
 
 	/* adjust if necessary - all reasons */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_ADJUST,
@@ -673,17 +706,18 @@
 	   which might be different to the first one */
 	ret = cpufreq_driver->verify(policy);
 	if (ret) {
-		up(&cpufreq_notifier_sem);
-		up(&cpufreq_driver_sem);
-		return ret;
+		up_read(&cpufreq_notifier_rwsem);
+		goto error_out;
 	}
 
 	/* notification of the new policy */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_NOTIFY,
 			    policy);
 
-	up(&cpufreq_notifier_sem);
+	up_read(&cpufreq_notifier_rwsem);
 
+	/* from here on we limit it to one limit and/or governor change running at the moment */
+	down(&cpufreq_driver_sem);
 	cpufreq_driver->policy[policy->cpu].min    = policy->min;
 	cpufreq_driver->policy[policy->cpu].max    = policy->max;
 
@@ -711,9 +745,11 @@
 			cpufreq_governor(policy->cpu, CPUFREQ_GOV_LIMITS);
 		}
 	}
-	
 	up(&cpufreq_driver_sem);
 
+ error_out:	
+	cpufreq_cpu_put(policy->cpu);
+
 	return ret;
 }
 EXPORT_SYMBOL(cpufreq_set_policy);
@@ -759,7 +795,7 @@
  */
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 {
-	down(&cpufreq_notifier_sem);
+	down_read(&cpufreq_notifier_rwsem);
 	switch (state) {
 	case CPUFREQ_PRECHANGE:
 		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_PRECHANGE, freqs);
@@ -771,7 +807,7 @@
 		cpufreq_driver->policy[freqs->cpu].cur = freqs->new;
 		break;
 	}
-	up(&cpufreq_notifier_sem);
+	up_read(&cpufreq_notifier_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
 
@@ -793,30 +829,33 @@
  */
 int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 {
-	int ret = 0;
-
-	if (cpufreq_driver)
-		return -EBUSY;
-	
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
 	    ((!driver_data->setpolicy) && (!driver_data->target)))
 		return -EINVAL;
 
-	down(&cpufreq_driver_sem);
 
+	if (kset_get(&cpufreq_interface.kset)) {
+		kset_put(&cpufreq_interface.kset);
+		return -EBUSY;
+	}
+
+	down(&cpufreq_driver_sem);
+	if (cpufreq_driver) {
+		up(&cpufreq_driver_sem);		
+		return -EBUSY;
+	}
 	cpufreq_driver = driver_data;
+	up(&cpufreq_driver_sem);
 
 	cpufreq_driver->policy = kmalloc(NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!cpufreq_driver->policy) {
-		up(&cpufreq_driver_sem);
+		cpufreq_driver = NULL;
 		return -ENOMEM;
 	}
-	memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
-	up(&cpufreq_driver_sem);
 
-	ret = interface_register(&cpufreq_interface);
+	memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
 
-	return ret;
+	return interface_register(&cpufreq_interface);
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 
@@ -831,20 +870,20 @@
  */
 int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 {
-	down(&cpufreq_driver_sem);
+	if (!kset_get(&cpufreq_interface.kset))
+		return 0;
 
-	if (!cpufreq_driver ||
-	    (driver != cpufreq_driver)) { 
-		up(&cpufreq_driver_sem);
+	if (!cpufreq_driver || (driver != cpufreq_driver)) {
+		kset_put(&cpufreq_interface.kset);
 		return -EINVAL;
 	}
 
+	kset_put(&cpufreq_interface.kset);
 	interface_unregister(&cpufreq_interface);
 
-	if (driver)
-		kfree(cpufreq_driver->policy);
+	down(&cpufreq_driver_sem);
+	kfree(cpufreq_driver->policy);
 	cpufreq_driver = NULL;
-
 	up(&cpufreq_driver_sem);
 
 	return 0;
@@ -868,22 +907,28 @@
 	if (in_interrupt())
 		panic("cpufreq_restore() called from interrupt context!");
 
+	if (!kset_get(&cpufreq_interface.kset))
+		return 0;
+
+	if (!try_module_get(cpufreq_driver->owner))
+		goto error_out;
+
 	for (i=0;i<NR_CPUS;i++) {
-		if (!cpu_online(i))
+		if (!cpu_online(i) || !cpufreq_cpu_get(i))
 			continue;
 
 		down(&cpufreq_driver_sem);
-		if (!cpufreq_driver) {
-			up(&cpufreq_driver_sem);
-			return 0;
-		}
-
 		memcpy(&policy, &cpufreq_driver->policy[i], sizeof(struct cpufreq_policy));
 		up(&cpufreq_driver_sem);
-
 		ret += cpufreq_set_policy(&policy);
+
+		cpufreq_cpu_put(i);
 	}
 
+	module_put(cpufreq_driver->owner);
+ error_out:
+	kset_put(&cpufreq_interface.kset);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_restore);

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

