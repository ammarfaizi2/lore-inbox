Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTDVUs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTDVUrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:47:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31433 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263857AbTDVUps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:45:48 -0400
Date: Tue, 22 Apr 2003 13:59:07 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: hannal@us.ibm.com, andmike@us.ibm.com
Subject: [RFC] Device class rework [4/5]
Message-ID: <20030422205907.GE4701@kroah.com>
References: <20030422205545.GA4701@kroah.com> <20030422205719.GB4701@kroah.com> <20030422205749.GC4701@kroah.com> <20030422205827.GD4701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422205827.GD4701@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:55:45PM -0700, Greg KH wrote:
>  - cpufreq changes.  This converts the cpufreq code to the new driver
>    class changes.


diff -Nru a/include/linux/cpufreq.h b/include/linux/cpufreq.h
--- a/include/linux/cpufreq.h	Tue Apr 22 13:07:50 2003
+++ b/include/linux/cpufreq.h	Tue Apr 22 13:07:50 2003
@@ -68,7 +68,6 @@
         unsigned int            policy; /* see above */
 	struct cpufreq_governor *governor; /* see below */
 	struct cpufreq_cpuinfo  cpuinfo;     /* see above */
-	struct device		* dev;
 	struct kobject		kobj;
  	struct semaphore	lock;   /* CPU ->setpolicy or ->target may
 					   only be called once a time */
diff -Nru a/kernel/cpufreq.c b/kernel/cpufreq.c
--- a/kernel/cpufreq.c	Tue Apr 22 13:07:50 2003
+++ b/kernel/cpufreq.c	Tue Apr 22 13:07:50 2003
@@ -49,23 +49,17 @@
 static LIST_HEAD(cpufreq_governor_list);
 static DECLARE_MUTEX		(cpufreq_governor_sem);
 
-static struct device_interface cpufreq_interface;
+static struct class_interface cpufreq_interface;
 
 static int cpufreq_cpu_get(unsigned int cpu) {
 	if (cpu >= NR_CPUS)
 		return 0;
 
-	if (!kset_get(&cpufreq_interface.kset))
-		return 0;
-
-	if (!try_module_get(cpufreq_driver->owner)) {
-		kset_put(&cpufreq_interface.kset);
+	if (!try_module_get(cpufreq_driver->owner))
 		return 0;
-	}
 
 	if (!kobject_get(&cpufreq_driver->policy[cpu].kobj)) {
 		module_put(cpufreq_driver->owner);
-		kset_put(&cpufreq_interface.kset);
 		return 0;
 	}
 
@@ -75,7 +69,6 @@
 static void cpufreq_cpu_put(unsigned int cpu) {
 	kobject_put(&cpufreq_driver->policy[cpu].kobj);
 	module_put(cpufreq_driver->owner);
-	kset_put(&cpufreq_interface.kset);
 }
 
 /*********************************************************************
@@ -115,24 +108,20 @@
 
 
 /* forward declarations */
-static int cpufreq_add_dev (struct device * dev);
-static int cpufreq_remove_dev (struct device * dev);
+static int cpufreq_add_dev (struct class_device * dev);
+static int cpufreq_remove_dev (struct class_device * dev);
 
 /* drivers/base/cpu.c */
 extern struct device_class cpu_devclass;
 
-static struct device_interface cpufreq_interface = {
-        .name = "cpufreq",
-        .devclass = &cpu_devclass,
-        .add_device = &cpufreq_add_dev,
-        .remove_device = &cpufreq_remove_dev,
-	.kset = { .subsys = &cpu_devclass.subsys, },
-        .devnum = 0,
+static struct class_interface cpufreq_interface = {
+        .add =		&cpufreq_add_dev,
+        .remove =	&cpufreq_remove_dev,
 };
 
-static inline int to_cpu_nr (struct device *dev)
+static inline int to_cpu_nr (struct class_device *dev)
 {
-	struct sys_device * cpu_sys_dev = container_of(dev, struct sys_device, dev);
+	struct sys_device * cpu_sys_dev = container_of(dev->dev, struct sys_device, dev);
 	return (cpu_sys_dev->id);
 }
 
@@ -334,21 +323,16 @@
  *
  * Adds the cpufreq interface for a CPU device. 
  */
-static int cpufreq_add_dev (struct device * dev)
+static int cpufreq_add_dev (struct class_device * class_dev)
 {
-	unsigned int cpu = to_cpu_nr(dev);
+	unsigned int cpu = to_cpu_nr(class_dev);
 	int ret = 0;
 	struct cpufreq_policy new_policy;
 	struct cpufreq_policy *policy;
 	struct freq_attr **drv_attr;
 
-	if (!kset_get(&cpufreq_interface.kset))
-		return -EINVAL;
-
-	if (!try_module_get(cpufreq_driver->owner)) {
-		kset_put(&cpufreq_interface.kset);
+	if (!try_module_get(cpufreq_driver->owner))
 		return -EINVAL;
-	}
 
 	/* call driver. From then on the cpufreq must be able
 	 * to accept all calls to ->verify and ->setpolicy for this CPU
@@ -366,15 +350,15 @@
 	memcpy(&new_policy, 
 	       policy, 
 	       sizeof(struct cpufreq_policy));
+	class_set_devdata(class_dev, policy);
 	up(&cpufreq_driver_sem);
 
 	init_MUTEX(&policy->lock);
 	/* prepare interface data */
-	policy->kobj.parent = &dev->kobj;
+	policy->kobj.parent = &class_dev->kobj;
 	policy->kobj.ktype = &ktype_cpufreq;
-	policy->dev = dev;
-	strncpy(policy->kobj.name, 
-		cpufreq_interface.name, KOBJ_NAME_LEN);
+//	policy->dev = dev->dev;
+	strncpy(policy->kobj.name, "cpufreq", KOBJ_NAME_LEN);
 
 	ret = kobject_register(&policy->kobj);
 	if (ret)
@@ -385,7 +369,9 @@
 		sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
 		drv_attr++;
 	}
+	/* set up files for this cpu device */
 
+	
 	/* set default policy */
 	ret = cpufreq_set_policy(&new_policy);
 	if (ret)
@@ -393,7 +379,6 @@
 
  out:
 	module_put(cpufreq_driver->owner);
-	kset_put(&cpufreq_interface.kset);
 	return ret;
 }
 
@@ -403,18 +388,13 @@
  *
  * Removes the cpufreq interface for a CPU device.
  */
-static int cpufreq_remove_dev (struct device * dev)
+static int cpufreq_remove_dev (struct class_device * class_dev)
 {
-	unsigned int cpu = to_cpu_nr(dev);
+	unsigned int cpu = to_cpu_nr(class_dev);
 
-	if (!kset_get(&cpufreq_interface.kset))
+	if (!kobject_get(&cpufreq_driver->policy[cpu].kobj))
 		return -EINVAL;
 
-	if (!kobject_get(&cpufreq_driver->policy[cpu].kobj)) {
-		kset_put(&cpufreq_interface.kset);
-		return -EINVAL;
-	}
-
 	down(&cpufreq_driver_sem);
 	if ((cpufreq_driver->target) && 
 	    (cpufreq_driver->policy[cpu].policy == CPUFREQ_POLICY_GOVERNOR)) {
@@ -433,7 +413,6 @@
 
 	up(&cpufreq_driver_sem);
 	kobject_put(&cpufreq_driver->policy[cpu].kobj);
-	kset_put(&cpufreq_interface.kset);
 	return 0;
 }
 
@@ -840,12 +819,6 @@
 	    ((!driver_data->setpolicy) && (!driver_data->target)))
 		return -EINVAL;
 
-
-	if (kset_get(&cpufreq_interface.kset)) {
-		kset_put(&cpufreq_interface.kset);
-		return -EBUSY;
-	}
-
 	down(&cpufreq_driver_sem);
 	if (cpufreq_driver) {
 		up(&cpufreq_driver_sem);		
@@ -862,7 +835,7 @@
 
 	memset(cpufreq_driver->policy, 0, NR_CPUS * sizeof(struct cpufreq_policy));
 
-	return interface_register(&cpufreq_interface);
+	return class_interface_register(&cpufreq_interface);
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 
@@ -877,16 +850,10 @@
  */
 int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 {
-	if (!kset_get(&cpufreq_interface.kset))
-		return 0;
-
-	if (!cpufreq_driver || (driver != cpufreq_driver)) {
-		kset_put(&cpufreq_interface.kset);
+	if (!cpufreq_driver || (driver != cpufreq_driver))
 		return -EINVAL;
-	}
 
-	kset_put(&cpufreq_interface.kset);
-	interface_unregister(&cpufreq_interface);
+	class_interface_unregister(&cpufreq_interface);
 
 	down(&cpufreq_driver_sem);
 	kfree(cpufreq_driver->policy);
@@ -914,9 +881,6 @@
 	if (in_interrupt())
 		panic("cpufreq_restore() called from interrupt context!");
 
-	if (!kset_get(&cpufreq_interface.kset))
-		return 0;
-
 	if (!try_module_get(cpufreq_driver->owner))
 		goto error_out;
 
@@ -934,8 +898,6 @@
 
 	module_put(cpufreq_driver->owner);
  error_out:
-	kset_put(&cpufreq_interface.kset);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_restore);
