Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWCQMWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCQMWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWCQMWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:22:11 -0500
Received: from fmr21.intel.com ([143.183.121.13]:21470 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932085AbWCQMWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:22:10 -0500
Date: Fri, 17 Mar 2006 04:21:54 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>,
       bryce@osdl.org
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060317042154.A13530@unix-os.sc.intel.com>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060317084653.GA4515@in.ibm.com>; from vatsa@in.ibm.com on Fri, Mar 17, 2006 at 12:46:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 12:46:53AM -0800, Srivatsa Vaddagiri wrote:
> 
> 
>    Well  ..other  arch-es need to have a similar check if they get around
>    to
>    implement physical hot-add (even if they allow offlining of all CPUs).
> 

This is really not for physical hotplug, but due to fact i386 startup code wasnt clean
enough. On x86_64 Andi cleaned this up and we dont need those hacks on x86_64.

>    +       if (cpu_online(cpu)) {

Should we add !cpu_present(cpu) check as well just to be consistent with checks 
in cpu_up() ? Probably better if we can move smp_prepare_cpu() to within cpu_up()?

How does the attached patch look.


Check if cpu can be onlined before calling smp_prepare_cpu()

- Moved check for online cpu out of smp_prepare_cpu()
- Moved default declaration of smp_prepare_cpu() to kernel/cpu.c
- Removed lock_cpu_hotplug() from smp_prepare_cpu() to around it, since
  its called from cpu_up() as well now.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------
 arch/i386/kernel/smpboot.c |    2 --
 drivers/base/cpu.c         |    9 +--------
 kernel/cpu.c               |    9 +++++++++
 kernel/power/smp.c         |    2 ++
 4 files changed, 12 insertions(+), 10 deletions(-)

Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/smpboot.c
@@ -1028,7 +1028,6 @@ int __devinit smp_prepare_cpu(int cpu)
 	struct work_struct task;
 	int	apicid, ret;
 
-	lock_cpu_hotplug();
 	apicid = x86_cpu_to_apicid[cpu];
 	if (apicid == BAD_APICID) {
 		ret = -ENODEV;
@@ -1053,7 +1052,6 @@ int __devinit smp_prepare_cpu(int cpu)
 	zap_low_mappings();
 	ret = 0;
 exit:
-	unlock_cpu_hotplug();
 	return ret;
 }
 #endif
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
Index: linux-2.6.16-rc6-mm1/kernel/cpu.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/cpu.c
+++ linux-2.6.16-rc6-mm1/kernel/cpu.c
@@ -198,6 +198,11 @@ out:
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
 
+int __attribute__((weak)) smp_prepare_cpu (int cpu)
+{
+	return 0;
+}
+
 int __devinit cpu_up(unsigned int cpu)
 {
 	int ret;
@@ -211,6 +216,10 @@ int __devinit cpu_up(unsigned int cpu)
 		goto out;
 	}
 
+	ret = smp_prepare_cpu(cpu);
+	if (ret)
+		goto out;
+
 	ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
Index: linux-2.6.16-rc6-mm1/kernel/power/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/power/smp.c
+++ linux-2.6.16-rc6-mm1/kernel/power/smp.c
@@ -49,7 +49,9 @@ void enable_nonboot_cpus(void)
 
 	printk("Thawing cpus ...\n");
 	for_each_cpu_mask(cpu, frozen_cpus) {
+		lock_cpu_hotplug();
 		error = smp_prepare_cpu(cpu);
+		unlock_cpu_hotplug();
 		if (!error)
 			error = cpu_up(cpu);
 		if (!error) {
