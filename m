Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbTBLU7D>; Wed, 12 Feb 2003 15:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTBLU7D>; Wed, 12 Feb 2003 15:59:03 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:24825 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267574AbTBLU6w>; Wed, 12 Feb 2003 15:58:52 -0500
Date: Wed, 12 Feb 2003 22:07:57 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.60] cpufreq: add support for cpufreq governors
Message-ID: <20030212210757.GB2098@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for "cpufreq governors". 

Most cpufreq drivers (in fact, all except one, longrun) or even most
cpu frequency scaling algorithms only offer the CPU to be set to one
frequency. In order to offer dynamic frequency scaling, the cpufreq
core must be able to tell these drivers of a "target frequency". So
these specific drivers will be transformed to offer a "->target"
call instead of the existing "->setpolicy" call. For "longrun", all
stays the same, though.

How to decide what frequency within the CPUfreq policy should be used?
That's done using "cpufreq governors". Two are already in this patch
-- they're the already existing "powersave" and "performance" which
set the frequency statically to the lowest or highest frequency,
respectively. At least two more such governors will be ready for
addition in the near future, but likely many more as there are various
different theories and models about dynamic frequency scaling
around. Using such a generic interface as cpufreq offers to scaling
governors, these can be tested extensively, and the best one can be
selected for each specific use.

Basically, it's the following flow graph:

CPU can be set to switch independetly	 |	   CPU can only be set
      within specific "limits"		 |       to specific frequencies

                                 "CPUfreq policy"
		consists of frequency limits (policy->{min,max})
  		     and CPUfreq governor to be used
			 /		      \
			/		       \
		       /		       the cpufreq governor decides
		      /			       (dynamically or statically)
		     /			       what target_freq to set within
		    /			       the limits of policy->{min,max}
		   /			            \
		  /				     \
	Using the ->setpolicy call,		 Using the ->target call,
	    the limits and the			  the frequency closest
	     "policy" is set.			  to target_freq is set.
						  It is assured that it
						  is within policy->{min,max}


 include/linux/cpufreq.h |   72 ++++++++-
 kernel/cpufreq.c        |  357 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 378 insertions(+), 51 deletions(-)

diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-01-27 17:25:23.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-01-27 17:25:53.000000000 +0100
@@ -2,10 +2,10 @@
  *  linux/include/linux/cpufreq.h
  *
  *  Copyright (C) 2001 Russell King
- *            (C) 2002 Dominik Brodowski <linux@brodo.de>
+ *            (C) 2002 - 2003 Dominik Brodowski <linux@brodo.de>
  *            
  *
- * $Id: cpufreq.h,v 1.29 2002/11/11 15:35:47 db Exp $
+ * $Id: cpufreq.h,v 1.36 2003/01/20 17:31:48 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -20,6 +20,9 @@
 #include <linux/device.h>
 
 
+#define CPUFREQ_NAME_LEN 16
+
+
 /*********************************************************************
  *                     CPUFREQ NOTIFIER INTERFACE                    *
  *********************************************************************/
@@ -37,14 +40,17 @@
 
 #define CPUFREQ_POLICY_POWERSAVE        (1)
 #define CPUFREQ_POLICY_PERFORMANCE      (2)
+#define CPUFREQ_POLICY_GOVERNOR         (3)
 
 /* Frequency values here are CPU kHz so that hardware which doesn't run 
  * with some frequencies can complain without having to guess what per 
  * cent / per mille means. 
- * Maximum transition latency is in nanoseconds - if it's unknown,
+ * Maximum transition latency is in microseconds - if it's unknown,
  * CPUFREQ_ETERNAL shall be used.
  */
 
+struct cpufreq_governor;
+
 #define CPUFREQ_ETERNAL (-1)
 struct cpufreq_cpuinfo {
 	unsigned int            max_freq;
@@ -57,6 +63,7 @@
 	unsigned int            min;    /* in kHz */
 	unsigned int            max;    /* in kHz */
         unsigned int            policy; /* see above */
+	struct cpufreq_governor *governor; /* see below */
 	struct cpufreq_cpuinfo  cpuinfo;     /* see above */
 	struct intf_data        intf;   /* interface data */
 };
@@ -104,25 +111,62 @@
 	return carry + val;
 };
 
+/*********************************************************************
+ *                          CPUFREQ GOVERNORS                        *
+ *********************************************************************/
+
+#define CPUFREQ_GOV_START  1
+#define CPUFREQ_GOV_STOP   2
+#define CPUFREQ_GOV_LIMITS 3
+
+struct cpufreq_governor {
+	char			name[CPUFREQ_NAME_LEN];
+	int	(*governor)	(struct cpufreq_policy *policy,
+				 unsigned int event);
+	struct list_head	governor_list;
+	struct module           *owner;
+};
+
+/* pass a target to the cpufreq driver 
+ * _l : (cpufreq_driver_sem is not held)
+ */
+inline int cpufreq_driver_target(struct cpufreq_policy *policy,
+				 unsigned int target_freq,
+				 unsigned int relation);
+
+inline int cpufreq_driver_target_l(struct cpufreq_policy *policy,
+				   unsigned int target_freq,
+				   unsigned int relation);
+
+/* pass an event to the cpufreq governor */
+int cpufreq_governor_l(unsigned int cpu, unsigned int event);
+
+int cpufreq_register_governor(struct cpufreq_governor *governor);
+void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
 /*********************************************************************
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
 
-#define CPUFREQ_NAME_LEN 16
+#define CPUFREQ_RELATION_L 0  /* lowest frequency at or above target */
+#define CPUFREQ_RELATION_H 1  /* highest frequency below or at target */
 
 struct cpufreq_driver {
 	/* needed by all drivers */
-	int     (*verify)       (struct cpufreq_policy *policy);
-	int     (*setpolicy)    (struct cpufreq_policy *policy);
-	struct cpufreq_policy   *policy;
-	char           		name[CPUFREQ_NAME_LEN];
+	int	(*verify)	(struct cpufreq_policy *policy);
+	struct cpufreq_policy	*policy;
+	char			name[CPUFREQ_NAME_LEN];
+	/* define one out of two */
+	int	(*setpolicy)	(struct cpufreq_policy *policy);
+	int	(*target)	(struct cpufreq_policy *policy,
+				 unsigned int target_freq,
+				 unsigned int relation);
 	/* optional, for the moment */
-	int     (*init)        (struct cpufreq_policy *policy);
-	int     (*exit)        (struct cpufreq_policy *policy);
+	int	(*init)		(struct cpufreq_policy *policy);
+	int	(*exit)		(struct cpufreq_policy *policy);
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
-	unsigned int            cpu_cur_freq[NR_CPUS];
+	unsigned int		cpu_cur_freq[NR_CPUS];
 #endif
 };
 
@@ -276,4 +320,10 @@
 				      struct cpufreq_frequency_table *table,
 				      unsigned int *index);
 
+int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
+				   struct cpufreq_frequency_table *table,
+				   unsigned int target_freq,
+				   unsigned int relation,
+				   unsigned int *index);
+
 #endif /* _LINUX_CPUFREQ_H */
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-27 17:25:27.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-27 17:43:41.000000000 +0100
@@ -2,9 +2,9 @@
  *  linux/kernel/cpufreq.c
  *
  *  Copyright (C) 2001 Russell King
- *            (C) 2002 Dominik Brodowski <linux@brodo.de>
+ *            (C) 2002 - 2003 Dominik Brodowski <linux@brodo.de>
  *
- *  $Id: cpufreq.c,v 1.50 2002/11/11 15:35:48 db Exp $
+ *  $Id: cpufreq.c,v 1.59 2003/01/20 17:31:48 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -34,7 +34,6 @@
 #include <linux/sysctl.h>
 #endif
 
-
 /**
  * The "cpufreq driver" - the arch- or hardware-dependend low
  * level driver of CPUFreq support, and its locking mutex. 
@@ -67,6 +66,9 @@
 static unsigned int     cpu_cur_freq[NR_CPUS];
 #endif
 
+LIST_HEAD(cpufreq_governor_list);
+
+static int cpufreq_governor(unsigned int cpu, unsigned int event);
 
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
@@ -75,16 +77,31 @@
 /**
  * cpufreq_parse_governor - parse a governor string
  */
-static int cpufreq_parse_governor (char *str_governor, unsigned int *governor)
+static int cpufreq_parse_governor (char *str_governor, unsigned int *policy, struct cpufreq_governor **governor)
 {
-	if (!strnicmp(str_governor, "performance", 11)) {
-		*governor = CPUFREQ_POLICY_PERFORMANCE;
+	if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
+		*policy = CPUFREQ_POLICY_PERFORMANCE;
 		return 0;
-	} else if (!strnicmp(str_governor, "powersave", 9)) {
-		*governor = CPUFREQ_POLICY_POWERSAVE;
+	} else if (!strnicmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
+		*policy = CPUFREQ_POLICY_POWERSAVE;
 		return 0;
-	} else
-		return -EINVAL;
+	} else 	{
+		struct cpufreq_governor *t;
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver || !cpufreq_driver->target)
+			goto out;
+		list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
+			if (!strnicmp(str_governor,t->name,CPUFREQ_NAME_LEN)) {
+				*governor = t;
+				*policy = CPUFREQ_POLICY_GOVERNOR;
+				up(&cpufreq_driver_sem);
+				return 0;
+			}
+		}
+	out:
+		up(&cpufreq_driver_sem);
+	}
+	return -EINVAL;
 }
 
 
@@ -171,6 +188,8 @@
 static ssize_t show_scaling_governor (struct device *dev, char *buf)
 {
 	unsigned int value = 0;
+	char value2[CPUFREQ_NAME_LEN];
+
 
 	if (!dev)
 		return 0;
@@ -178,6 +197,8 @@
 	down(&cpufreq_driver_sem);
 	if (cpufreq_driver)
 		value = cpufreq_driver->policy[to_cpu_nr(dev)].policy;
+	if (value == CPUFREQ_POLICY_GOVERNOR)
+		strncpy(value2, cpufreq_driver->policy[to_cpu_nr(dev)].governor->name, CPUFREQ_NAME_LEN);
 	up(&cpufreq_driver_sem);
 
 	switch (value) {
@@ -185,6 +206,8 @@
 		return sprintf(buf, "powersave\n");
 	case CPUFREQ_POLICY_PERFORMANCE:
 		return sprintf(buf, "performance\n");
+	case CPUFREQ_POLICY_GOVERNOR:
+		return sprintf(buf, "%s\n", value2);
 	}
 
 	return -EINVAL;
@@ -212,7 +235,7 @@
 	if (ret != 1)
 		return -EINVAL;
 
-	if (cpufreq_parse_governor(str_governor, &policy.policy))
+	if (cpufreq_parse_governor(str_governor, &policy.policy, &policy.governor))
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(&policy);
@@ -241,6 +264,34 @@
 	return sprintf(buf, "%s\n", value);
 }
 
+/**
+ * show_available_govs - show the available CPUfreq governors
+ */
+static ssize_t show_available_govs(struct device *dev, char *buf)
+{
+	ssize_t i = 0;
+	struct cpufreq_governor *t;
+
+	if (!dev)
+		return 0;
+
+	i += sprintf(buf, "performance powersave");
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver || !cpufreq_driver->target)
+		goto out;
+
+	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
+		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char)) - (CPUFREQ_NAME_LEN + 2)))
+			goto out;
+		i += snprintf(&buf[i], CPUFREQ_NAME_LEN, " %s", t->name);
+	}
+ out:
+	up(&cpufreq_driver_sem);
+	i += sprintf(&buf[i], "\n");
+	return i;
+}
+
 
 /**
  * cpufreq_per_cpu_attr_ro - read-only cpufreq per-CPU file
@@ -267,6 +318,7 @@
 
 static DEVICE_ATTR(scaling_governor, (S_IRUGO | S_IWUSR), show_scaling_governor, store_scaling_governor);
 static DEVICE_ATTR(scaling_driver, S_IRUGO, show_scaling_driver, NULL);
+static DEVICE_ATTR(available_scaling_governors, S_IRUGO, show_available_govs, NULL);
 
 
 /**
@@ -299,10 +351,12 @@
 	}
 
 	/* set default policy on this CPU */
-	policy.policy = cpufreq_driver->policy[cpu].policy;
-	policy.min    = cpufreq_driver->policy[cpu].min;
-	policy.max    = cpufreq_driver->policy[cpu].max;
-	policy.cpu    = cpu;
+	memcpy(&policy, 
+	       &cpufreq_driver->policy[cpu], 
+	       sizeof(struct cpufreq_policy));
+
+	if (cpufreq_driver->target)
+		cpufreq_governor(cpu, CPUFREQ_GOV_START);
 
 	up(&cpufreq_driver_sem);
 	ret = cpufreq_set_policy(&policy);
@@ -339,6 +393,7 @@
 	device_create_file (dev, &dev_attr_scaling_max_freq);
 	device_create_file (dev, &dev_attr_scaling_governor);
 	device_create_file (dev, &dev_attr_scaling_driver);
+	device_create_file (dev, &dev_attr_available_scaling_governors);
 
 	up(&cpufreq_driver_sem);
 	return ret;
@@ -356,6 +411,9 @@
 	struct device * dev = intf->dev;
 	unsigned int cpu = to_cpu_nr(dev);
 
+	if (cpufreq_driver->target)
+		cpufreq_governor(cpu, CPUFREQ_GOV_STOP);
+
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(&cpufreq_driver->policy[cpu]);
 
@@ -364,7 +422,8 @@
 	device_remove_file (dev, &dev_attr_scaling_min_freq);
 	device_remove_file (dev, &dev_attr_scaling_max_freq);
 	device_remove_file (dev, &dev_attr_scaling_governor);
-	device_remove_file (dev, &dev_attr_scaling_governor);
+	device_remove_file (dev, &dev_attr_scaling_driver);
+	device_remove_file (dev, &dev_attr_available_scaling_governors);
 
 	return 0;
 }
@@ -443,12 +502,11 @@
 	return -EINVAL;
 
 scan_policy:
-	result = cpufreq_parse_governor(str_governor, &policy->policy);
+	result = cpufreq_parse_governor(str_governor, &policy->policy, &policy->governor);
 
 	return result;
 }
 
-
 /**
  * cpufreq_proc_read - read /proc/cpufreq
  *
@@ -477,7 +535,8 @@
 		if (!cpu_online(i))
 			continue;
 
-		cpufreq_get_policy(&policy, i);
+		if (cpufreq_get_policy(&policy, i))
+			continue;
 
 		if (!policy.cpuinfo.max_freq)
 			continue;
@@ -494,6 +553,9 @@
 		case CPUFREQ_POLICY_PERFORMANCE:
 			p += sprintf(p, "performance\n");
 			break;
+		case CPUFREQ_POLICY_GOVERNOR:
+			p += snprintf(p, CPUFREQ_NAME_LEN, "%s\n", policy.governor->name);
+			break;
 		default:
 			p += sprintf(p, "INVALID\n");
 			break;
@@ -1065,6 +1127,136 @@
 EXPORT_SYMBOL(cpufreq_unregister_notifier);
 
 
+/*********************************************************************
+ *                              GOVERNORS                            *
+ *********************************************************************/
+
+inline int cpufreq_driver_target_l(struct cpufreq_policy *policy,
+				   unsigned int target_freq,
+				   unsigned int relation)
+{
+	unsigned int ret;
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		ret = -EINVAL;
+	else
+		ret = cpufreq_driver->target(policy, target_freq, relation);
+	up(&cpufreq_driver_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_target_l);
+
+
+inline int cpufreq_driver_target(struct cpufreq_policy *policy,
+				 unsigned int target_freq,
+				 unsigned int relation)
+{
+	return cpufreq_driver->target(policy, target_freq, relation);
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_target);
+
+
+static int cpufreq_governor(unsigned int cpu, unsigned int event)
+{
+	int ret = 0;
+	struct cpufreq_policy *policy = &cpufreq_driver->policy[cpu];
+
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_POWERSAVE: 
+		if ((event == CPUFREQ_GOV_LIMITS) || (event == CPUFREQ_GOV_START))
+			ret = cpufreq_driver->target(policy, policy->min, CPUFREQ_RELATION_L);
+		break;
+	case CPUFREQ_POLICY_PERFORMANCE:
+		if ((event == CPUFREQ_GOV_LIMITS) || (event == CPUFREQ_GOV_START))
+			ret = cpufreq_driver->target(policy, policy->max, CPUFREQ_RELATION_H);
+		break;
+	case CPUFREQ_POLICY_GOVERNOR:
+		ret = -EINVAL;
+		if (event == CPUFREQ_GOV_START)
+			if (!try_module_get(cpufreq_driver->policy[cpu].governor->owner))
+				break;
+		ret = cpufreq_driver->policy[cpu].governor->governor(policy, event);
+		if ((event == CPUFREQ_GOV_STOP) ||
+			(ret && (event == CPUFREQ_GOV_START)))
+			module_put(cpufreq_driver->policy[cpu].governor->owner);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+
+int cpufreq_governor_l(unsigned int cpu, unsigned int event)
+{
+	int ret = 0;
+	down(&cpufreq_driver_sem);
+	ret = cpufreq_governor(cpu, event);
+	up(&cpufreq_driver_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_governor_l);
+
+
+int cpufreq_register_governor(struct cpufreq_governor *governor)
+{
+	struct cpufreq_governor *t;
+
+	if (!governor)
+		return -EINVAL;
+
+	if (!strnicmp(governor->name,"powersave",CPUFREQ_NAME_LEN))
+		return -EBUSY;
+	if (!strnicmp(governor->name,"performance",CPUFREQ_NAME_LEN))
+		return -EBUSY;
+
+	down(&cpufreq_driver_sem);
+	
+	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
+		if (!strnicmp(governor->name,t->name,CPUFREQ_NAME_LEN)) {
+			up(&cpufreq_driver_sem);
+			return -EBUSY;
+		}
+	}
+	list_add(&governor->governor_list, &cpufreq_governor_list);
+ 	up(&cpufreq_driver_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_register_governor);
+
+
+void cpufreq_unregister_governor(struct cpufreq_governor *governor)
+{
+	unsigned int i;
+	
+	if (!governor)
+		return;
+
+	down(&cpufreq_driver_sem);
+	/* 
+	 * Unless the user uses rmmod -f, we can be safe. But we never
+	 * know, so check whether if it's currently used. If so,
+	 * stop it and replace it with the default governor.
+	 */
+	for (i=0; i<NR_CPUS; i++)
+	{
+		if (cpufreq_driver && 
+		    (cpufreq_driver->policy[i].policy == CPUFREQ_POLICY_GOVERNOR) && 
+		    (cpufreq_driver->policy[i].governor == governor)) {
+			cpufreq_governor(i, CPUFREQ_GOV_STOP);
+			cpufreq_driver->policy[i].policy = CPUFREQ_POLICY_PERFORMANCE;
+			cpufreq_governor(i, CPUFREQ_GOV_START);
+		}
+	}
+	/* now we can safely remove it from the list */
+	list_del(&governor->governor_list);
+	up(&cpufreq_driver_sem);
+	return;
+}
+EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
+
+
 
 /*********************************************************************
  *                          POLICY INTERFACE                         *
@@ -1084,15 +1276,11 @@
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
 	}
-	
-	policy->min    = cpufreq_driver->policy[cpu].min;
-	policy->max    = cpufreq_driver->policy[cpu].max;
-	policy->policy = cpufreq_driver->policy[cpu].policy;
-	policy->cpuinfo.max_freq       = cpufreq_driver->policy[cpu].cpuinfo.max_freq;
-	policy->cpuinfo.min_freq       = cpufreq_driver->policy[cpu].cpuinfo.min_freq;
-	policy->cpuinfo.transition_latency = cpufreq_driver->policy[cpu].cpuinfo.transition_latency;
-	policy->cpu    = cpu;
 
+	memcpy(policy, 
+	       &cpufreq_driver->policy[cpu], 
+	       sizeof(struct cpufreq_policy));
+	
 	up(&cpufreq_driver_sem);
 
 	return 0;
@@ -1111,16 +1299,15 @@
 	int ret;
 
 	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver || !cpufreq_driver->verify || 
-	    !cpufreq_driver->setpolicy || !policy ||
+	if (!cpufreq_driver || !policy ||
 	    (policy->cpu >= NR_CPUS) || (!cpu_online(policy->cpu))) {
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
 	}
 
-	policy->cpuinfo.max_freq       = cpufreq_driver->policy[policy->cpu].cpuinfo.max_freq;
-	policy->cpuinfo.min_freq       = cpufreq_driver->policy[policy->cpu].cpuinfo.min_freq;
-	policy->cpuinfo.transition_latency = cpufreq_driver->policy[policy->cpu].cpuinfo.transition_latency;
+	memcpy(&policy->cpuinfo, 
+	       &cpufreq_driver->policy[policy->cpu].cpuinfo, 
+	       sizeof(struct cpufreq_cpuinfo));
 
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(policy);
@@ -1156,13 +1343,35 @@
 
 	cpufreq_driver->policy[policy->cpu].min    = policy->min;
 	cpufreq_driver->policy[policy->cpu].max    = policy->max;
-	cpufreq_driver->policy[policy->cpu].policy = policy->policy;
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpu_cur_freq[policy->cpu] = policy->max;
 #endif
 
-	ret = cpufreq_driver->setpolicy(policy);
+	if (cpufreq_driver->setpolicy) {
+		cpufreq_driver->policy[policy->cpu].policy = policy->policy;
+		ret = cpufreq_driver->setpolicy(policy);
+	} else {
+		if ((policy->policy != cpufreq_driver->policy[policy->cpu].policy) || 
+		    ((policy->policy == CPUFREQ_POLICY_GOVERNOR) && (policy->governor != cpufreq_driver->policy[policy->cpu].governor))) {
+			unsigned int old_pol = cpufreq_driver->policy[policy->cpu].policy;
+			struct cpufreq_governor *old_gov = cpufreq_driver->policy[policy->cpu].governor;
+			/* end old governor */
+			cpufreq_governor(policy->cpu, CPUFREQ_GOV_STOP);
+			cpufreq_driver->policy[policy->cpu].policy = policy->policy;
+			cpufreq_driver->policy[policy->cpu].governor = policy->governor;
+			/* start new governor */
+			if (cpufreq_governor(policy->cpu, CPUFREQ_GOV_START)) {
+				cpufreq_driver->policy[policy->cpu].policy = old_pol;
+				cpufreq_driver->policy[policy->cpu].governor = old_gov;
+				cpufreq_governor(policy->cpu, CPUFREQ_GOV_START);
+			}
+			/* might be a policy change, too */
+			cpufreq_governor(policy->cpu, CPUFREQ_GOV_LIMITS);
+		} else {
+			cpufreq_governor(policy->cpu, CPUFREQ_GOV_LIMITS);
+		}
+	}
 	
 	up(&cpufreq_driver_sem);
 
@@ -1253,7 +1462,7 @@
 		return -EBUSY;
 	
 	if (!driver_data || !driver_data->verify || 
-	    !driver_data->setpolicy)
+	    ((!driver_data->setpolicy) && (!driver_data->target)))
 		return -EINVAL;
 
 	down(&cpufreq_driver_sem);
@@ -1271,6 +1480,7 @@
 			up(&cpufreq_driver_sem);
 			return -ENOMEM;
 		}
+		memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
 	}
 	
 	up(&cpufreq_driver_sem);
@@ -1359,11 +1569,8 @@
 			up(&cpufreq_driver_sem);
 			return 0;
 		}
-	
-		policy.min    = cpufreq_driver->policy[i].min;
-		policy.max    = cpufreq_driver->policy[i].max;
-		policy.policy = cpufreq_driver->policy[i].policy;
-		policy.cpu    = i;
+
+		memcpy(&policy, &cpufreq_driver->policy[i], sizeof(struct cpufreq_policy));
 		up(&cpufreq_driver_sem);
 
 		ret += cpufreq_set_policy(&policy);
@@ -1493,3 +1700,73 @@
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_setpolicy);
+
+int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
+				   struct cpufreq_frequency_table *table,
+				   unsigned int target_freq,
+				   unsigned int relation,
+				   unsigned int *index)
+{
+	struct cpufreq_frequency_table optimal = { .index = ~0, };
+	struct cpufreq_frequency_table suboptimal = { .index = ~0, };
+	unsigned int i;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_H:
+		optimal.frequency = 0;
+		suboptimal.frequency = ~0;
+		break;
+	case CPUFREQ_RELATION_L:
+		optimal.frequency = ~0;
+		suboptimal.frequency = 0;
+		break;
+	}
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+		switch(relation) {
+		case CPUFREQ_RELATION_H:
+			if (freq <= target_freq) {
+				if (freq >= optimal.frequency) {
+					optimal.frequency = freq;
+					optimal.index = i;
+				}
+			} else {
+				if (freq <= suboptimal.frequency) {
+					suboptimal.frequency = freq;
+					suboptimal.index = i;
+				}
+			}
+			break;
+		case CPUFREQ_RELATION_L:
+			if (freq >= target_freq) {
+				if (freq <= optimal.frequency) {
+					optimal.frequency = freq;
+					optimal.index = i;
+				}
+			} else {
+				if (freq >= suboptimal.frequency) {
+					suboptimal.frequency = freq;
+					suboptimal.index = i;
+				}
+			}
+			break;
+		}
+	}
+	if (optimal.index > i) {
+		if (suboptimal.index > i)
+			return -EINVAL;
+		*index = suboptimal.index;
+	} else
+		*index = optimal.index;
+	
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
