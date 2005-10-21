Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVJXSCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVJXSCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJXSCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:02:16 -0400
Received: from fmr22.intel.com ([143.183.121.14]:25571 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751210AbVJXSCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:02:15 -0400
Message-Id: <20051021204327.725306000@araj-sfield>
References: <20051021203818.753754000@araj-sfield>
Date: Fri, 21 Oct 2005 13:38:21 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org, linux@brodo.de
Cc: davej@redhat.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 3/4] Remove cpu_sys_devices in cpufreq subsystem.
Content-Disposition: inline; filename=remove-cpufreq-cpu-sysdev
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_sys_devices is redundant with the new API get_cpu_sysdev().
So nuking this usage since its not needed.

Depends on: get_cpu_sysdev() patch.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
------------------------------------------------------------
 drivers/cpufreq/cpufreq.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

Index: linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
@@ -36,13 +36,6 @@ static struct cpufreq_policy	*cpufreq_cp
 static DEFINE_SPINLOCK(cpufreq_driver_lock);
 
 
-/* we keep a copy of all ->add'ed CPU's struct sys_device here;
- * as it is only accessed in ->add and ->remove, no lock or reference
- * count is necessary.
- */
-static struct sys_device	*cpu_sys_devices[NR_CPUS];
-
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static void handle_update(void *data);
@@ -582,7 +575,6 @@ static int cpufreq_add_dev (struct sys_d
 	 * CPU because it is in the same boat. */
 	policy = cpufreq_cpu_get(cpu);
 	if (unlikely(policy)) {
-		cpu_sys_devices[cpu] = sys_dev;
 		dprintk("CPU already managed, adding link\n");
 		sysfs_create_link(&sys_dev->kobj, &policy->kobj, "cpufreq");
 		cpufreq_debug_enable_ratelimit();
@@ -656,7 +648,6 @@ static int cpufreq_add_dev (struct sys_d
 	}
 
 	module_put(cpufreq_driver->owner);
-	cpu_sys_devices[cpu] = sys_dev;
 	dprintk("initialization complete\n");
 	cpufreq_debug_enable_ratelimit();
 	
@@ -697,6 +688,7 @@ static int cpufreq_remove_dev (struct sy
 	unsigned int cpu = sys_dev->id;
 	unsigned long flags;
 	struct cpufreq_policy *data;
+	struct sys_device *cpu_sys_dev;
 #ifdef CONFIG_SMP
 	unsigned int j;
 #endif
@@ -709,7 +701,6 @@ static int cpufreq_remove_dev (struct sy
 
 	if (!data) {
 		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-		cpu_sys_devices[cpu] = NULL;
 		cpufreq_debug_enable_ratelimit();
 		return -EINVAL;
 	}
@@ -724,14 +715,12 @@ static int cpufreq_remove_dev (struct sy
 		dprintk("removing link\n");
 		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 		sysfs_remove_link(&sys_dev->kobj, "cpufreq");
-		cpu_sys_devices[cpu] = NULL;
 		cpufreq_cpu_put(data);
 		cpufreq_debug_enable_ratelimit();
 		return 0;
 	}
 #endif
 
-	cpu_sys_devices[cpu] = NULL;
 
 	if (!kobject_get(&data->kobj)) {
 		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
@@ -760,7 +749,8 @@ static int cpufreq_remove_dev (struct sy
 			if (j == cpu)
 				continue;
 			dprintk("removing link for cpu %u\n", j);
-			sysfs_remove_link(&cpu_sys_devices[j]->kobj, "cpufreq");
+			cpu_sys_dev = get_cpu_sysdev(j);
+			sysfs_remove_link(&cpu_sys_dev->kobj, "cpufreq");
 			cpufreq_cpu_put(data);
 		}
 	}

--

