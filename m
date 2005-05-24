Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVEXIPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVEXIPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEXIPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:15:52 -0400
Received: from fmr17.intel.com ([134.134.136.16]:35804 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261435AbVEXIOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:14:00 -0400
Message-Id: <20050524080801.185401000@csdlinux-2.jf.intel.com>
References: <20050524075201.351504000@csdlinux-2.jf.intel.com>
Date: Tue, 24 May 2005 00:27:53 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de, akpm@osdl.org
Cc: zwane@arm.linux.org.uk, rusty@rustycorp.com.au, vatsa@in.ibm.com,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com
Subject: [patch 4/4] CPU Hotplug support for X86_64
Content-Disposition: inline; filename=fix_ipi_race_in_cpuhotplug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch 4/4] x86_64: Replace IPI Broadcast when using CPU hotplug.
From: Ashok Raj <ashok.raj@intel.com>

This patch tries to eliminate a race condition with IPI broadcast and 
CPU hotplug. Since when we broadcast we dont have control on what cpus
see a spurious intr, or possiblity of receiving an intr when the cpu is
just in process of comming up, we choose to send targetted IPI only to online
cpus.

This same workaround could be done in other places too, like genapic
locations, but this is a simpler change done here. 

for the time being: we do the send_IPI_mask() version if CPU hotplug is
selected by default.

Use both CONFIG option if CPU_HOTPLUG is selected, and  a cmdline option
to turn it on during startup if necessary.

1. Bringup cpu in complete cli state, and also hold call_lock when we 
   update online_map. (Not sure if the IPI would be pended and delivered
   later causing trouble)
2. SledgeHammer approach to use stop_machine() to achive automicity. 
   *Very Undesirable*
3. May be setup intr_gate a little later just before setting online_map.
   [still ugly bandaid, but may work] online_map should still be updated 
   under call_lock for safety.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------
 Kconfig      |    4 ++++
 kernel/smp.c |   24 +++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smp.c
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smp.c
@@ -43,6 +43,13 @@ static cpumask_t flush_cpumask;
 static struct mm_struct * flush_mm;
 static unsigned long flush_va;
 static DEFINE_SPINLOCK(tlbstate_lock);
+
+#ifdef CONFIG_SAFE_IPI_CALLFUNC
+static int safe_ipi_call = 1;
+#else
+static int safe_ipi_call = 0;
+#endif
+
 #define FLUSH_ALL	-1ULL
 
 /*
@@ -307,6 +314,15 @@ unlock_ipi_calllock(void)
 	spin_unlock_irq(&call_lock);
 }
 
+static int __init safe_ipi_setup(char *s)
+{ 
+     safe_ipi_call = 1; 
+	 printk ("Turning off broadcast IPI in smp_call_function\n");
+     return 0; 
+} 
+
+__setup("safe_ipi", safe_ipi_setup); 
+
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
@@ -330,7 +346,13 @@ static void __smp_call_function (void (*
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+
+	if (safe_ipi_call) {
+		cpumask_t cpu_mask = cpu_online_map;
+		cpu_clear(smp_processor_id(), cpu_mask);
+		send_IPI_mask(cpu_mask, CALL_FUNCTION_VECTOR);
+	} else
+		send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)
Index: linux-2.6.12-rc4-mm2/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/Kconfig
+++ linux-2.6.12-rc4-mm2/arch/x86_64/Kconfig
@@ -302,6 +302,10 @@ config HOTPLUG_CPU
 		can be controlled through /sys/devices/system/cpu/cpu#.
 		Say N if you want to disable CPU hotplug.
 
+config SAFE_IPI_CALLFUNC
+	bool 
+	default y
+	depends on HOTPLUG_CPU
 
 config HPET_TIMER
 	bool

--
