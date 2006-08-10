Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWHJUOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWHJUOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHJTfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:14315 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932468AbWHJTfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:41 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [26/145] x86_64: Add initalization of the RDTSCP auxilliary values
Message-Id: <20060810193539.7D01B13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:39 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Vojtech Pavlik <vojtech@suse.cz>
This patch adds initalization of the RDTSCP auxilliary values to CPU numbers
to time.c. If RDTSCP is available, the MSRs are written with the respective
values. It can be later used to initalize per-cpu timekeeping variables.

AK: Some cleanups. Move externs into headers and fix CPU hotplug.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/smpboot.c |    2 +
 arch/x86_64/kernel/time.c    |   47 ++++++++++++++++++++++++++++++++-----------
 include/asm-x86_64/proto.h   |    1 
 3 files changed, 38 insertions(+), 12 deletions(-)

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -24,6 +24,8 @@
 #include <linux/device.h>
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <linux/kallsyms.h>
 #include <linux/acpi.h>
 #ifdef CONFIG_ACPI
@@ -49,7 +51,7 @@ static void cpufreq_delayed_get(void);
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
-static char *time_init_gtod(void);
+static char *timename = NULL;
 
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
@@ -893,11 +895,21 @@ static struct irqaction irq0 = {
 	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
 
-void __init time_init(void)
+static int __cpuinit
+time_cpu_notifier(struct notifier_block *nb, unsigned long action, void *hcpu)
 {
-	char *timename;
-	char *gtod;
+	unsigned cpu = (unsigned long) hcpu;
+	if (action == CPU_ONLINE &&
+		cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
+		unsigned p;
+		p = smp_processor_id() | (cpu_to_node(smp_processor_id())<<12);
+		write_rdtscp_aux(p);
+	}
+	return NOTIFY_DONE;
+}
 
+void __init time_init(void)
+{
 	if (nohpet)
 		vxtime.hpet_address = 0;
 
@@ -931,18 +943,19 @@ void __init time_init(void)
 	}
 
 	vxtime.mode = VXTIME_TSC;
-	gtod = time_init_gtod();
-
-	printk(KERN_INFO "time.c: Using %ld.%06ld MHz WALL %s GTOD %s timer.\n",
-	       vxtime_hz / 1000000, vxtime_hz % 1000000, timename, gtod);
-	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
-		cpu_khz / 1000, cpu_khz % 1000);
 	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
 	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
 	vxtime.last_tsc = get_cycles_sync();
 	setup_irq(0, &irq0);
 
 	set_cyc2ns_scale(cpu_khz);
+
+	hotcpu_notifier(time_cpu_notifier, 0);
+	time_cpu_notifier(NULL, CPU_ONLINE, (void *)(long)smp_processor_id());
+
+#ifndef CONFIG_SMP
+	time_init_gtod();
+#endif
 }
 
 /*
@@ -973,12 +986,13 @@ __cpuinit int unsynchronized_tsc(void)
 /*
  * Decide what mode gettimeofday should use.
  */
-__init static char *time_init_gtod(void)
+void time_init_gtod(void)
 {
 	char *timetype;
 
 	if (unsynchronized_tsc())
 		notsc = 1;
+
 	if (vxtime.hpet_address && notsc) {
 		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
 		if (hpet_use_timer)
@@ -1001,7 +1015,16 @@ __init static char *time_init_gtod(void)
 		timetype = hpet_use_timer ? "HPET/TSC" : "PIT/TSC";
 		vxtime.mode = VXTIME_TSC;
 	}
-	return timetype;
+
+	printk(KERN_INFO "time.c: Using %ld.%06ld MHz WALL %s GTOD %s timer.\n",
+	       vxtime_hz / 1000000, vxtime_hz % 1000000, timename, timetype);
+	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
+		cpu_khz / 1000, cpu_khz % 1000);
+	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
+	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
+	vxtime.last_tsc = get_cycles_sync();
+
+	set_cyc2ns_scale(cpu_khz);
 }
 
 __setup("report_lost_ticks", time_setup);
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -1181,6 +1181,8 @@ void __init smp_cpus_done(unsigned int m
 #endif
 
 	check_nmi_watchdog();
+
+	time_init_gtod();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -51,6 +51,7 @@ extern unsigned long long monotonic_base
 extern int sysctl_vsyscall;
 extern int nohpet;
 extern unsigned long vxtime_hz;
+extern void time_init_gtod(void);
 
 extern int numa_setup(char *opt);
 
