Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVJXSCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVJXSCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVJXSCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:02:38 -0400
Received: from fmr24.intel.com ([143.183.121.16]:13232 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751213AbVJXSC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:02:29 -0400
Message-Id: <20051021204327.624207000@araj-sfield>
References: <20051021203818.753754000@araj-sfield>
Date: Fri, 21 Oct 2005 13:38:20 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org, linux@brodo.de
Cc: davej@redhat.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 2/4] create and destroy cache sysfs entries based on cpu notifiers.
Content-Disposition: inline; filename=dynamic-sysfs-cache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpu cache entries should be populated only when cpu is online and removed
when they are logically offlined. 

Without which entries are not removed when cpu is offlined, or dont 
appear when we boot with maxcpus=1 and then kick the rest of the cpus
via echo 1 to the sysfs online file.

- Changed __devinit to __cpuinit for consistency.
- Changed sysfs_driver_register to register_cpu_notifier.


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
----------------------------------------------------------------
 arch/i386/kernel/cpu/intel_cacheinfo.c |   60 ++++++++++++++++++++++++---------
 1 files changed, 44 insertions(+), 16 deletions(-)

Index: linux-2.6.14-rc4-mm1/arch/i386/kernel/cpu/intel_cacheinfo.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ linux-2.6.14-rc4-mm1/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -3,6 +3,7 @@
  *
  *      Changes:
  *      Venkatesh Pallipadi	: Adding cache identification through cpuid(4)
+ *		Ashok Raj <ashok.raj@intel.com>: Work with CPU hotplug infrastructure.
  */
 
 #include <linux/init.h>
@@ -29,7 +30,7 @@ struct _cache_table
 };
 
 /* all the cache descriptor types we care about (no TLB or trace cache entries) */
-static struct _cache_table cache_table[] __devinitdata =
+static struct _cache_table cache_table[] __cpuinitdata =
 {
 	{ 0x06, LVL_1_INST, 8 },	/* 4-way set assoc, 32 byte line size */
 	{ 0x08, LVL_1_INST, 16 },	/* 4-way set assoc, 32 byte line size */
@@ -120,7 +121,7 @@ struct _cpuid4_info {
 
 static unsigned short			num_cache_leaves;
 
-static int __devinit cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
+static int __cpuinit cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
 {
 	unsigned int		eax, ebx, ecx, edx;
 	union _cpuid4_leaf_eax	cache_eax;
@@ -155,7 +156,7 @@ static int __init find_num_cache_leaves(
 	return i;
 }
 
-unsigned int __devinit init_intel_cacheinfo(struct cpuinfo_x86 *c)
+unsigned int __cpuinit init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
@@ -290,7 +291,7 @@ static struct _cpuid4_info *cpuid4_info[
 #define CPUID4_INFO_IDX(x,y)    (&((cpuid4_info[x])[y]))
 
 #ifdef CONFIG_SMP
-static void __devinit cache_shared_cpu_map_setup(unsigned int cpu, int index)
+static void __cpuinit cache_shared_cpu_map_setup(unsigned int cpu, int index)
 {
 	struct _cpuid4_info	*this_leaf;
 	unsigned long num_threads_sharing;
@@ -323,7 +324,7 @@ static void free_cache_attributes(unsign
 	cpuid4_info[cpu] = NULL;
 }
 
-static int __devinit detect_cache_attributes(unsigned int cpu)
+static int __cpuinit detect_cache_attributes(unsigned int cpu)
 {
 	struct _cpuid4_info	*this_leaf;
 	unsigned long 		j;
@@ -500,7 +501,7 @@ static void cpuid4_cache_sysfs_exit(unsi
 	free_cache_attributes(cpu);
 }
 
-static int __devinit cpuid4_cache_sysfs_init(unsigned int cpu)
+static int __cpuinit cpuid4_cache_sysfs_init(unsigned int cpu)
 {
 
 	if (num_cache_leaves == 0)
@@ -531,7 +532,7 @@ err_out:
 }
 
 /* Add/Remove cache interface for CPU device */
-static int __devinit cache_add_dev(struct sys_device * sys_dev)
+static int __cpuinit cache_add_dev(struct sys_device * sys_dev)
 {
 	unsigned int cpu = sys_dev->id;
 	unsigned long i, j;
@@ -568,7 +569,7 @@ static int __devinit cache_add_dev(struc
 	return retval;
 }
 
-static int __devexit cache_remove_dev(struct sys_device * sys_dev)
+static void __cpuexit cache_remove_dev(struct sys_device * sys_dev)
 {
 	unsigned int cpu = sys_dev->id;
 	unsigned long i;
@@ -577,24 +578,51 @@ static int __devexit cache_remove_dev(st
 		kobject_unregister(&(INDEX_KOBJECT_PTR(cpu,i)->kobj));
 	kobject_unregister(cache_kobject[cpu]);
 	cpuid4_cache_sysfs_exit(cpu);
-	return 0;
+	return;
+}
+
+static int __cpuinit cacheinfo_cpu_callback(struct notifier_block *nfb,
+						unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct sys_device *sys_dev;
+
+	sys_dev = get_cpu_sysdev(cpu);
+	switch (action) {
+		case CPU_ONLINE:
+			(void) cache_add_dev(sys_dev);
+			break;
+		case CPU_DEAD:
+			cache_remove_dev(sys_dev);
+			break;
+	}
+	return NOTIFY_OK;
 }
 
-static struct sysdev_driver cache_sysdev_driver = {
-	.add = cache_add_dev,
-	.remove = __devexit_p(cache_remove_dev),
+static struct notifier_block cacheinfo_cpu_notifier =
+{
+    .notifier_call = cacheinfo_cpu_callback,
 };
 
-/* Register/Unregister the cpu_cache driver */
-static int __devinit cache_register_driver(void)
+static int __cpuinit cache_sysfs_init(void)
 {
+	int i;
+
 	if (num_cache_leaves == 0)
 		return 0;
 
-	return sysdev_driver_register(&cpu_sysdev_class,&cache_sysdev_driver);
+	register_cpu_notifier(&cacheinfo_cpu_notifier);
+
+	for_each_online_cpu(i) {
+		cacheinfo_cpu_callback(&cacheinfo_cpu_notifier, CPU_ONLINE,
+			(void *)(long)i);
+	}
+
+
+	return 0;
 }
 
-device_initcall(cache_register_driver);
+device_initcall(cache_sysfs_init);
 
 #endif
 

--

