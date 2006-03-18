Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWCROKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWCROKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWCROKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:10:15 -0500
Received: from fmr18.intel.com ([134.134.136.17]:32957 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751536AbWCROKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:10:13 -0500
Date: Sat, 18 Mar 2006 06:09:58 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com, bryce@osdl.org,
       ashok.raj@intel.com
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060318060958.A31112@unix-os.sc.intel.com>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20060317141322.GB27325@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060317141322.GB27325@in.ibm.com>; from vatsa@in.ibm.com on Fri, Mar 17, 2006 at 07:43:22PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 07:43:22PM +0530, Srivatsa Vaddagiri wrote:
> On Fri, Mar 17, 2006 at 01:04:12AM -0800, Andrew Morton wrote:
> > OK..  I guess we should fix those architectures while we're thinking about it.
> 
> Only x86 has this bug, so only x86 needs to be fixed. Neverthless
> Ashok's patch [1] should address all architectures that may implement
> smp_prepare_cpu() in future as well.
> 
Hi Vatsa

Since smp_prepare_cpu was introduced only to work around warm-boot on i386 due to the
strange kickstart process of AP's. I have moved this al-together within __cpu_up()
i386 arch code, so its less confusing to other arch's that have done it right already.

Here is the updated patch, it removes smp_prepare_cpu() from  being called from generic
core cpuhotplug code, and moved it to i386 side.

I did some basic up/down testing on a 2 way PIII box.

Shaohua, could you take a look at this code, and also check suspend/resume is not 
affected?

Andrew, could we queue it to -mm for some exposure before inclusion.

thanks

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Check if cpu can be onlined before calling smp_prepare_cpu()

- Moved check for online cpu out of smp_prepare_cpu()
- Moved default declaration of smp_prepare_cpu() to kernel/cpu.c
- Removed lock_cpu_hotplug() from smp_prepare_cpu() to around it, since
  its called from cpu_up() as well now.
- Removed clearing from cpu_present_map during cpu_offline as it breaks using cpu_up() 
  directly during a subsequent online operation.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------
 arch/i386/kernel/smpboot.c |   21 +++++++++++++++++----
 drivers/base/cpu.c         |    9 +--------
 include/linux/cpu.h        |    1 -
 kernel/power/smp.c         |    4 +---
 4 files changed, 19 insertions(+), 16 deletions(-)

Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/smpboot.c
@@ -1002,7 +1002,6 @@ void cpu_exit_clear(void)
 
 	cpu_clear(cpu, cpu_callout_map);
 	cpu_clear(cpu, cpu_callin_map);
-	cpu_clear(cpu, cpu_present_map);
 
 	cpu_clear(cpu, smp_commenced_mask);
 	unmap_cpu_to_logical_apicid(cpu);
@@ -1021,14 +1020,13 @@ static void __devinit do_warm_boot_cpu(v
 	complete(info->complete);
 }
 
-int __devinit smp_prepare_cpu(int cpu)
+static int __devinit __smp_prepare_cpu(int cpu)
 {
 	DECLARE_COMPLETION(done);
 	struct warm_boot_cpu_info info;
 	struct work_struct task;
 	int	apicid, ret;
 
-	lock_cpu_hotplug();
 	apicid = x86_cpu_to_apicid[cpu];
 	if (apicid == BAD_APICID) {
 		ret = -ENODEV;
@@ -1053,7 +1051,6 @@ int __devinit smp_prepare_cpu(int cpu)
 	zap_low_mappings();
 	ret = 0;
 exit:
-	unlock_cpu_hotplug();
 	return ret;
 }
 #endif
@@ -1379,6 +1376,22 @@ void __cpu_die(unsigned int cpu)
 
 int __devinit __cpu_up(unsigned int cpu)
 {
+	int ret=0;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/*
+	 * We do warm boot only on cpus that had booted earlier
+	 * Otherwise cold boot is all handled from smp_boot_cpus().
+	 * cpu_callin_map is set during AP kickstart process. Its reset
+	 * when a cpu is taken offline from cpu_exit_clear().
+	 */
+	if (!cpu_isset(cpu, cpu_callin_map))
+		ret = __smp_prepare_cpu(cpu);
+
+	if (ret)
+		return -EIO;
+#endif
+
 	/* In case one didn't come up */
 	if (!cpu_isset(cpu, cpu_callin_map)) {
 		printk(KERN_DEBUG "skipping cpu%d, didn't come online\n", cpu);
Index: linux-2.6.16-rc6-mm1/drivers/base/cpu.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/drivers/base/cpu.c
+++ linux-2.6.16-rc6-mm1/drivers/base/cpu.c
@@ -19,11 +19,6 @@ EXPORT_SYMBOL(cpu_sysdev_class);
 static struct sys_device *cpu_sys_devices[NR_CPUS];
 
 #ifdef CONFIG_HOTPLUG_CPU
-int __attribute__((weak)) smp_prepare_cpu (int cpu)
-{
-	return 0;
-}
-
 static ssize_t show_online(struct sys_device *dev, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
@@ -44,9 +39,7 @@ static ssize_t store_online(struct sys_d
 			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 		break;
 	case '1':
-		ret = smp_prepare_cpu(cpu->sysdev.id);
-		if (!ret)
-			ret = cpu_up(cpu->sysdev.id);
+		ret = cpu_up(cpu->sysdev.id);
 		if (!ret)
 			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 		break;
Index: linux-2.6.16-rc6-mm1/include/linux/cpu.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/cpu.h
+++ linux-2.6.16-rc6-mm1/include/linux/cpu.h
@@ -74,7 +74,6 @@ extern int lock_cpu_hotplug_interruptibl
 	register_cpu_notifier(&fn##_nb);			\
 }
 int cpu_down(unsigned int cpu);
-extern int __attribute__((weak)) smp_prepare_cpu(int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
 #define lock_cpu_hotplug()	do { } while (0)
Index: linux-2.6.16-rc6-mm1/kernel/power/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/power/smp.c
+++ linux-2.6.16-rc6-mm1/kernel/power/smp.c
@@ -49,9 +49,7 @@ void enable_nonboot_cpus(void)
 
 	printk("Thawing cpus ...\n");
 	for_each_cpu_mask(cpu, frozen_cpus) {
-		error = smp_prepare_cpu(cpu);
-		if (!error)
-			error = cpu_up(cpu);
+		error = cpu_up(cpu);
 		if (!error) {
 			printk("CPU%d is up\n", cpu);
 			continue;
