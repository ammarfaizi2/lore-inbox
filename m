Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbTCIT0s>; Sun, 9 Mar 2003 14:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbTCIT0K>; Sun, 9 Mar 2003 14:26:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33298 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262581AbTCITZp>; Sun, 9 Mar 2003 14:25:45 -0500
Date: Sun, 9 Mar 2003 19:36:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (1/7): fix cpufreq core breakage(s)
Message-ID: <20030309193622.B26266@flint.arm.linux.org.uk>
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
Subject: [PATCH] cpufreq (1/7): fix cpufreq core breakage(s)
Date: Fri, 7 Mar 2003 11:08:26 +0100

- update two more cpufreq-related sysfs files to the new interface
  code
- always store the new, user-requested policy in another struct
  cpufreq_policy so that we can safely fall back to the old one in
  case something fails (this equals the behaviour before Pat's patch)
- the kobject which was registered in cpufreq_add_dev was inside a variable
  private to this function -- so the whole cpufreq sysfs interface returned
  -EINVAL.

 cpufreq.c |  136 ++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 71 insertions(+), 65 deletions(-)
(only so large as some code had to be moved up in order to avoid
 forward declarations)

Please apply,
       Dominik

--- linux-original/kernel/cpufreq.c	2003-03-07 10:54:08.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-03-07 10:56:53.000000000 +0100
@@ -143,12 +143,17 @@
 (struct cpufreq_policy * policy, const char *buf, size_t count)		\
 {									\
 	unsigned int ret = -EINVAL;					\
+	struct cpufreq_policy new_policy;				\
 									\
-	ret = sscanf (buf, "%u", &policy->object);			\
+	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
+	if (ret)							\
+		return ret;						\
+									\
+	ret = sscanf (buf, "%u", &new_policy.object);			\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	ret = cpufreq_set_policy(policy);				\
+	ret = cpufreq_set_policy(&new_policy);				\
 									\
 	return ret ? ret : count;					\
 }
@@ -192,19 +197,64 @@
 {
 	unsigned int ret = -EINVAL;
 	char	str_governor[16];
+	struct cpufreq_policy new_policy;
+
+	ret = cpufreq_get_policy(&new_policy, policy->cpu);
+	if (ret)
+		return ret;
 
 	ret = sscanf (buf, "%15s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
 
-	if (cpufreq_parse_governor(str_governor, &policy->policy, &policy->governor))
+	if (cpufreq_parse_governor(str_governor, &new_policy.policy, &new_policy.governor))
 		return -EINVAL;
 
-	ret = cpufreq_set_policy(policy);
+	ret = cpufreq_set_policy(&new_policy);
 
 	return ret ? ret : count;
 }
 
+/**
+ * show_scaling_driver - show the cpufreq driver currently loaded
+ */
+static ssize_t show_scaling_driver (struct cpufreq_policy * policy, char *buf)
+{
+	char value[CPUFREQ_NAME_LEN];
+
+	down(&cpufreq_driver_sem);
+	if (cpufreq_driver)
+		strncpy(value, cpufreq_driver->name, CPUFREQ_NAME_LEN);
+	up(&cpufreq_driver_sem);
+
+	return sprintf(buf, "%s\n", value);
+}
+
+/**
+ * show_scaling_available_governors - show the available CPUfreq governors
+ */
+static ssize_t show_scaling_available_governors(struct cpufreq_policy * policy, char *buf)
+{
+	ssize_t i = 0;
+	struct cpufreq_governor *t;
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
 
 struct freq_attr {
 	struct attribute attr;
@@ -227,6 +277,8 @@
 
 define_one_ro(cpuinfo_min_freq);
 define_one_ro(cpuinfo_max_freq);
+define_one_ro(scaling_available_governors);
+define_one_ro(scaling_driver);
 define_one_rw(scaling_min_freq);
 define_one_rw(scaling_max_freq);
 define_one_rw(scaling_governor);
@@ -237,6 +289,8 @@
 	&scaling_min_freq.attr,
 	&scaling_max_freq.attr,
 	&scaling_governor.attr,
+	&scaling_driver.attr,
+	&scaling_available_governors.attr,
 	NULL
 };
 
@@ -271,56 +325,6 @@
 
 
 /**
- * show_scaling_governor - show the current policy for the specified CPU
- */
-static ssize_t show_scaling_driver (struct device *dev, char *buf)
-{
-	char value[CPUFREQ_NAME_LEN];
-
-	if (!dev)
-		return 0;
-
-	down(&cpufreq_driver_sem);
-	if (cpufreq_driver)
-		strncpy(value, cpufreq_driver->name, CPUFREQ_NAME_LEN);
-	up(&cpufreq_driver_sem);
-
-	return sprintf(buf, "%s\n", value);
-}
-
-/**
- * show_available_govs - show the available CPUfreq governors
- */
-static ssize_t show_available_govs(struct device *dev, char *buf)
-{
-	ssize_t i = 0;
-	struct cpufreq_governor *t;
-
-	if (!dev)
-		return 0;
-
-	i += sprintf(buf, "performance powersave");
-
-	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver || !cpufreq_driver->target)
-		goto out;
-
-	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
-		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char)) - (CPUFREQ_NAME_LEN + 2)))
-			goto out;
-		i += snprintf(&buf[i], CPUFREQ_NAME_LEN, " %s", t->name);
-	}
- out:
-	up(&cpufreq_driver_sem);
-	i += sprintf(&buf[i], "\n");
-	return i;
-}
-
-
-static DEVICE_ATTR(scaling_driver, S_IRUGO, show_scaling_driver, NULL);
-static DEVICE_ATTR(available_scaling_governors, S_IRUGO, show_available_govs, NULL);
-
-/**
  * cpufreq_add_dev - add a CPU device
  *
  * Adds the cpufreq interface for a CPU device. 
@@ -329,7 +333,8 @@
 {
 	unsigned int cpu = to_cpu_nr(dev);
 	int ret = 0;
-	struct cpufreq_policy policy;
+	struct cpufreq_policy new_policy;
+	struct cpufreq_policy *policy;
 
 	down(&cpufreq_driver_sem);
 	if (!cpufreq_driver) {
@@ -340,9 +345,10 @@
 	/* call driver. From then on the cpufreq must be able
 	 * to accept all calls to ->verify and ->setpolicy for this CPU
 	 */
-	cpufreq_driver->policy[cpu].cpu = cpu;
+	policy = &cpufreq_driver->policy[cpu];
+	policy->cpu = cpu;
 	if (cpufreq_driver->init) {
-		ret = cpufreq_driver->init(&cpufreq_driver->policy[cpu]);
+		ret = cpufreq_driver->init(policy);
 		if (ret) {
 			up(&cpufreq_driver_sem);
 			return -ENODEV;
@@ -350,34 +356,27 @@
 	}
 
 	/* set default policy on this CPU */
-	memcpy(&policy, 
-	       &cpufreq_driver->policy[cpu], 
+	memcpy(&new_policy, 
+	       policy, 
 	       sizeof(struct cpufreq_policy));
 
-	/* 2.4-API init for this CPU */
-#ifdef CONFIG_CPU_FREQ_24_API
-	cpu_min_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.min_freq;
-	cpu_max_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.max_freq;
-	cpu_cur_freq[cpu] = cpufreq_driver->cpu_cur_freq[cpu];
-#endif
-
 	if (cpufreq_driver->target)
 		cpufreq_governor(cpu, CPUFREQ_GOV_START);
 
 	up(&cpufreq_driver_sem);
-	ret = cpufreq_set_policy(&policy);
+	ret = cpufreq_set_policy(&new_policy);
 	if (ret)
 		return -EINVAL;
 	down(&cpufreq_driver_sem);
 
 	/* prepare interface data */
-	policy.kobj.parent = &dev->kobj;
-	policy.kobj.ktype = &ktype_cpufreq;
-	policy.dev = dev;
-	strncpy(policy.kobj.name, 
+	policy->kobj.parent = &dev->kobj;
+	policy->kobj.ktype = &ktype_cpufreq;
+	policy->dev = dev;
+	strncpy(policy->kobj.name, 
 		cpufreq_interface.name, KOBJ_NAME_LEN);
 
-	ret = kobject_register(&policy.kobj);
+	ret = kobject_register(&policy->kobj);
 
 	up(&cpufreq_driver_sem);
 	return ret;

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

