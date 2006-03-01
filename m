Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWB1XYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWB1XYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWB1XYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:24:15 -0500
Received: from fmr22.intel.com ([143.183.121.14]:44952 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932719AbWB1XYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:24:12 -0500
Message-Id: <20060301001722.947908000@araj-sfield>
References: <20060301001557.318047000@araj-sfield>
Date: Tue, 28 Feb 2006 16:16:01 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Len Brown <len.brown@intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 4/5] Patch to limit present cpus to fake cpu hot-add testing.
Content-Disposition: inline; filename=x86_64-limit-cpus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[NOTE: Not for mainline inclusion.. only necessary for testing purposes]

Patch to limit cpu_present_map to less that what is physically present.
This is used to test physical CPU hotplug by hiding entries being created
and emulate a hot-add of the CPU.

enable CONFIG_LIMIT_CPUS, and use cmdline option limit_cpus=X, where X
indicates number of CPUs to mark present when booted.

for e.g with limit_cpus=2 on a 4 way system, you will only notice 2 cpus
in /sys/devices/system/cpu/.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-------------------------------------------------------------
 arch/i386/kernel/acpi/boot.c |    9 ++++++++-
 arch/x86_64/Kconfig          |    9 +++++++++
 arch/x86_64/kernel/mpparse.c |    2 +-
 arch/x86_64/kernel/smpboot.c |   26 ++++++++++++++++++++++++++
 init/main.c                  |   22 ++++++++++++++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc4-mm1/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.16-rc4-mm1/arch/i386/kernel/acpi/boot.c
@@ -540,6 +540,12 @@ int acpi_map_lsapic(acpi_handle handle, 
 	buffer.length = ACPI_ALLOCATE_BUFFER;
 	buffer.pointer = NULL;
 
+#ifdef CONFIG_LIMIT_CPUS
+	cpus_complement(tmp_map, cpu_present_map);
+	cpu = first_cpu(tmp_map);
+	physid = bios_cpu_apicid[cpu];
+	printk ("Limit-cpus... activating CPU %d APIC_ID = %d\n", cpu, physid);
+#endif
 	tmp_map = cpu_present_map;
 	mp_register_lapic(physid, lapic->flags.enabled);
 
@@ -563,8 +569,8 @@ EXPORT_SYMBOL(acpi_map_lsapic);
 
 int acpi_unmap_lsapic(int cpu)
 {
+#ifndef CONFIG_LIMIT_CPUS
 	int i;
-
 	for_each_cpu(i) {
 		if (x86_acpiid_to_apicid[i] == x86_cpu_to_apicid[cpu]) {
 			x86_acpiid_to_apicid[i] = -1;
@@ -572,6 +578,7 @@ int acpi_unmap_lsapic(int cpu)
 		}
 	}
 	x86_cpu_to_apicid[cpu] = -1;
+#endif
 	cpu_clear(cpu, cpu_present_map);
 	num_processors--;
 
Index: linux-2.6.16-rc4-mm1/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.16-rc4-mm1.orig/arch/x86_64/Kconfig
+++ linux-2.6.16-rc4-mm1/arch/x86_64/Kconfig
@@ -360,6 +360,15 @@ config HOTPLUG_CPU
 		Say N if you want to disable CPU hotplug.
 
 
+config LIMIT_CPUS
+   bool "Limits the present CPUs  at boot time"
+   depends on HOTPLUG_CPU
+   default n
+   ---help---
+   At boot time pass command line option "limit_cpus=xx" to start with
+   xx number of cpus. The cpu_present_map is trimmed to hide these CPUs
+   so they can be made to appear hotplugged for testing purposes.
+
 config HPET_TIMER
 	bool
 	default y
Index: linux-2.6.16-rc4-mm1/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/arch/x86_64/kernel/mpparse.c
+++ linux-2.6.16-rc4-mm1/arch/x86_64/kernel/mpparse.c
@@ -65,7 +65,7 @@ unsigned long mp_lapic_addr = 0;
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_id = -1U;
 /* Internal processor count */
-unsigned int num_processors __initdata = 0;
+unsigned int num_processors __cpuinitdata = 0;
 
 unsigned disabled_cpus __initdata;
 
Index: linux-2.6.16-rc4-mm1/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.16-rc4-mm1/arch/x86_64/kernel/smpboot.c
@@ -1006,6 +1006,32 @@ __init void prefill_possible_map(void)
 	for (i = 0; i < possible; i++)
 		cpu_set(i, cpu_possible_map);
 }
+
+#ifdef CONFIG_LIMIT_CPUS
+void __init limit_cpu_present_map(void)
+{
+   extern unsigned int limit_cpus;
+   char str[NR_CPUS];
+   unsigned int cnt;
+
+   if (num_processors <= limit_cpus)
+       return;
+
+   printk (KERN_INFO "cpu_present_map = %s\n",\
+       cpumask_scnprintf(str, NR_CPUS, cpu_present_map)? str : NULL);
+
+   printk (KERN_INFO "Limiting to %d CPUs\n", limit_cpus);
+
+   for (cnt=limit_cpus; (cnt < num_processors); cnt++)
+   {
+       cpu_clear(cnt, cpu_present_map);
+   }
+   printk(KERN_INFO "cpu_present_map = %s\n",
+       cpumask_scnprintf(str, NR_CPUS, cpu_present_map)? str : NULL);
+
+}
+#endif
+
 #endif
 
 /*
Index: linux-2.6.16-rc4-mm1/init/main.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/init/main.c
+++ linux-2.6.16-rc4-mm1/init/main.c
@@ -151,6 +151,23 @@ static int __init maxcpus(char *str)
 
 __setup("maxcpus=", maxcpus);
 
+#ifdef CONFIG_LIMIT_CPUS
+unsigned int limit_cpus=NR_CPUS;
+
+static int __init
+set_limit_cpus(char *str)
+{
+   int ncpus;
+   get_option (&str, &ncpus);
+   limit_cpus = ncpus;
+   printk (KERN_INFO "Limiting cpus present count to %d\n", ncpus);
+   return 1;
+}
+
+__setup("limit_cpus=", set_limit_cpus);
+#endif
+
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
@@ -357,6 +374,11 @@ static void __init smp_init(void)
 {
 	unsigned int i;
 
+#ifdef CONFIG_LIMIT_CPUS
+   extern __init void limit_cpu_present_map(void);
+   limit_cpu_present_map();
+#endif
+
 	/* FIXME: This should be done in userspace --RR */
 	for_each_present_cpu(i) {
 		if (num_online_cpus() >= max_cpus)

--

