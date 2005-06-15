Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVFOG2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFOG2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVFOG2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:28:47 -0400
Received: from fmr19.intel.com ([134.134.136.18]:30160 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261505AbVFOG2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:28:40 -0400
Subject: [PATCH] set cpu_state for CPU hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 14:36:05 +0800
Message-Id: <1118817365.3896.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Dead CPU notify online CPU it's dead using cpu_state variable. After
switching to physical cpu hotplug, we forgot setting the variable. This
patch fixes it. Currently only __cpu_die uses it. We changed other
locations for consistency in case others use it.

Thanks,
Shaohua

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
Acked-by: Ashok Raj<ashok.raj@intel.com>
---

 linux-2.6.12-rc6-mm1-root/arch/i386/kernel/smpboot.c   |    7 ++++++-
 linux-2.6.12-rc6-mm1-root/arch/ia64/kernel/smpboot.c   |    3 +++
 linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/smpboot.c |    7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~cpu_state_fix arch/i386/kernel/smpboot.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/smpboot.c~cpu_state_fix	2005-06-14 11:23:31.000000000 +0800
+++ linux-2.6.12-rc6-mm1-root/arch/i386/kernel/smpboot.c	2005-06-15 08:50:54.122672032 +0800
@@ -514,6 +514,7 @@ static void __devinit start_secondary(vo
 	lock_ipi_call_lock();
 	cpu_set(smp_processor_id(), cpu_online_map);
 	unlock_ipi_call_lock();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 
 	/* We can take interrupts now: we're officially "up". */
 	local_irq_enable();
@@ -1270,6 +1271,7 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 	cpu_set(smp_processor_id(), cpu_present_map);
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1327,8 +1329,10 @@ void __cpu_die(unsigned int cpu)
 
 	for (i = 0; i < 10; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
-		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
+			printk ("CPU %d is now offline\n", cpu);
 			return;
+		}
 		current->state = TASK_UNINTERRUPTIBLE;
 		schedule_timeout(HZ/10);
 	}
@@ -1357,6 +1361,7 @@ int __devinit __cpu_up(unsigned int cpu)
 	}
 
 	local_irq_enable();
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
 	while (!cpu_isset(cpu, cpu_online_map))
diff -puN arch/x86_64/kernel/smpboot.c~cpu_state_fix arch/x86_64/kernel/smpboot.c
--- linux-2.6.12-rc6-mm1/arch/x86_64/kernel/smpboot.c~cpu_state_fix	2005-06-14 11:25:04.000000000 +0800
+++ linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/smpboot.c	2005-06-15 08:51:17.743081184 +0800
@@ -511,6 +511,7 @@ void __cpuinit start_secondary(void)
 	 * Allow the master to continue.
 	 */
 	cpu_set(smp_processor_id(), cpu_online_map);
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 	mb();
 
 	/* Wait for TSC sync to not schedule things before.
@@ -1038,6 +1039,7 @@ void __init smp_prepare_boot_cpu(void)
 	cpu_set(me, cpu_callout_map);
 	cpu_set(0, cpu_sibling_map[0]);
 	cpu_set(0, cpu_core_map[0]);
+	per_cpu(cpu_state, me) = CPU_ONLINE;
 }
 
 /*
@@ -1066,6 +1068,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
  		return -ENOSYS;
 	}
 
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
 	/* Boot it! */
 	err = do_boot_cpu(cpu, apicid);
 	if (err < 0) {
@@ -1170,8 +1173,10 @@ void __cpu_die(unsigned int cpu)
 
 	for (i = 0; i < 10; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
-		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
+			printk ("CPU %d is now offline\n", cpu);
 			return;
+		}
 		current->state = TASK_UNINTERRUPTIBLE;
 		schedule_timeout(HZ/10);
 	}
diff -puN arch/ia64/kernel/smpboot.c~cpu_state_fix arch/ia64/kernel/smpboot.c
--- linux-2.6.12-rc6-mm1/arch/ia64/kernel/smpboot.c~cpu_state_fix	2005-06-14 11:25:53.000000000 +0800
+++ linux-2.6.12-rc6-mm1-root/arch/ia64/kernel/smpboot.c	2005-06-15 08:51:37.199123416 +0800
@@ -346,6 +346,7 @@ smp_callin (void)
 	lock_ipi_calllock();
 	cpu_set(cpuid, cpu_online_map);
 	unlock_ipi_calllock();
+	per_cpu(cpu_state, cpuid) = CPU_ONLINE;
 
 	smp_setup_percpu_timer();
 
@@ -611,6 +612,7 @@ void __devinit smp_prepare_boot_cpu(void
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callin_map);
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 }
 
 /*
@@ -775,6 +777,7 @@ __cpu_up (unsigned int cpu)
 	if (cpu_isset(cpu, cpu_callin_map))
 		return -EINVAL;
 
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
 	/* Processor goes to start_secondary(), sets online flag */
 	ret = do_boot_cpu(sapicid, cpu);
 	if (ret < 0)
_


