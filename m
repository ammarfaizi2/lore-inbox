Return-Path: <linux-kernel-owner+w=401wt.eu-S932505AbWLLWfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWLLWfL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWLLWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:34:49 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:38120 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbWLLWei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:34:38 -0500
Date: Tue, 12 Dec 2006 14:34:36 -0800
Message-Id: <200612122234.kBCMYakp023339@zach-dev.vmware.com>
Subject: [PATCH 5/5] Vmi timer.patch
From: Zachary Amsden <zach@vmware.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 12 Dec 2006 22:34:36.0418 (UTC) FILETIME=[B3F22E20:01C71E3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VMI timer code.  It works by taking over the local APIC clock when APIC is
configured, which requires a couple hooks into the APIC code.  The backend
timer code could be commonized into the timer infrastructure, but there are
some pieces missing (stolen time, in particular), and the exact semantics
of when to do accounting for NO_IDLE need to be shared between different
hypervisors as well.  So for now, VMI timer is a separate module.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r d1ec5a6e3e8c arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/Kconfig	Tue Dec 12 13:55:41 2006 -0800
@@ -1221,3 +1221,12 @@ config KTIME_SCALAR
 config KTIME_SCALAR
 	bool
 	default y
+
+config NO_IDLE_HZ
+	bool
+	depends on PARAVIRT
+	default y
+	help
+	  Switches the regular HZ timer off when the system is going idle.
+	  This helps a hypervisor detect that the Linux system is idle,
+	  reducing the overhead of idle systems.
diff -r d1ec5a6e3e8c arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/Makefile	Tue Dec 12 13:53:15 2006 -0800
@@ -40,7 +40,7 @@ obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
 
-obj-$(CONFIG_VMI)		+= vmi.o
+obj-$(CONFIG_VMI)		+= vmi.o vmitime.o
 
 # Make sure this is linked after any other paravirt_ops structs: see head.S
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
diff -r d1ec5a6e3e8c arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/apic.c	Tue Dec 12 13:53:15 2006 -0800
@@ -1395,7 +1395,7 @@ int __init APIC_init_uniprocessor (void)
 		if (!skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
 #endif
-	setup_boot_APIC_clock();
+	setup_boot_clock();
 
 	return 0;
 }
diff -r d1ec5a6e3e8c arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/entry.S	Tue Dec 12 13:53:15 2006 -0800
@@ -622,6 +622,11 @@ ENTRY(name)				\
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
+/* This alternate entry is needed because we hijack the apic LVTT */
+#if defined(CONFIG_VMI) && defined(CONFIG_X86_LOCAL_APIC)
+BUILD_INTERRUPT(apic_vmi_timer_interrupt,LOCAL_TIMER_VECTOR)
+#endif
+
 KPROBE_ENTRY(page_fault)
 	RING0_EC_FRAME
 	pushl $do_page_fault
diff -r d1ec5a6e3e8c arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/paravirt.c	Tue Dec 12 13:53:15 2006 -0800
@@ -544,6 +544,8 @@ struct paravirt_ops paravirt_ops = {
 	.apic_write = native_apic_write,
 	.apic_write_atomic = native_apic_write_atomic,
 	.apic_read = native_apic_read,
+	.setup_boot_clock = setup_boot_APIC_clock,
+	.setup_secondary_clock = setup_secondary_APIC_clock,
 #endif
 	.set_lazy_mode = (void *)native_nop,
 
diff -r d1ec5a6e3e8c arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/smpboot.c	Tue Dec 12 13:53:15 2006 -0800
@@ -556,7 +556,7 @@ static void __devinit start_secondary(vo
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
-	setup_secondary_APIC_clock();
+	setup_secondary_clock();
 	if (nmi_watchdog == NMI_IO_APIC) {
 		disable_8259A_irq(0);
 		enable_NMI_through_LVT0(NULL);
@@ -1328,7 +1328,7 @@ static void __init smp_boot_cpus(unsigne
 
 	smpboot_setup_io_apic();
 
-	setup_boot_APIC_clock();
+	setup_boot_clock();
 
 	/*
 	 * Synchronize the TSC with the AP
diff -r d1ec5a6e3e8c arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/time.c	Tue Dec 12 13:53:15 2006 -0800
@@ -232,6 +232,7 @@ static void sync_cmos_clock(unsigned lon
 static void sync_cmos_clock(unsigned long dummy);
 
 static DEFINE_TIMER(sync_cmos_timer, sync_cmos_clock, 0, 0);
+int no_sync_cmos_clock;
 
 static void sync_cmos_clock(unsigned long dummy)
 {
@@ -275,7 +276,8 @@ static void sync_cmos_clock(unsigned lon
 
 void notify_arch_cmos_timer(void)
 {
-	mod_timer(&sync_cmos_timer, jiffies + 1);
+	if (!no_sync_cmos_clock)
+		mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
 static long clock_cmos_diff;
diff -r d1ec5a6e3e8c arch/i386/kernel/tsc.c
--- a/arch/i386/kernel/tsc.c	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/tsc.c	Tue Dec 12 13:53:15 2006 -0800
@@ -23,6 +23,7 @@
  * an extra value to store the TSC freq
  */
 unsigned int tsc_khz;
+unsigned long long (*custom_sched_clock)(void);
 
 int tsc_disable __cpuinitdata = 0;
 
@@ -107,6 +108,9 @@ unsigned long long sched_clock(void)
 {
 	unsigned long long this_offset;
 
+	if (unlikely(custom_sched_clock))
+		return (*custom_sched_clock)();
+
 	/*
 	 * in the NUMA case we dont use the TSC as they are not
 	 * synchronized across all CPUs.
diff -r d1ec5a6e3e8c arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Tue Dec 12 13:53:09 2006 -0800
+++ b/arch/i386/kernel/vmi.c	Tue Dec 12 13:53:15 2006 -0800
@@ -34,6 +34,7 @@
 #include <asm/apic.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/vmi_time.h>
 
 /* Convenient for calling VMI functions indirectly in the ROM */
 typedef u32 __attribute__((regparm(1))) (VROMFUNC)(void);
@@ -67,6 +68,7 @@ struct {
 	void (fastcall *set_linear_mapping)(int, u32, u32, u32);
 	void (fastcall *flush_tlb)(int);
 	void (fastcall *set_initial_ap_state)(int, int);
+	void (fastcall *halt)(void);
 } vmi_ops;
  
 /* XXX move this to alternative.h */
@@ -252,7 +254,20 @@ static void vmi_nop(void)
 {
 }
 
-  
+/* For NO_IDLE_HZ, we stop the clock when halting the kernel */
+#ifdef CONFIG_NO_IDLE_HZ
+static fastcall void vmi_safe_halt(void)
+{
+	int idle = vmi_stop_hz_timer();
+	vmi_ops.halt();
+	if (idle) {
+		local_irq_disable();
+		vmi_account_time_restart_hz_timer();
+		local_irq_enable();
+	}
+}
+#endif
+
 #ifdef CONFIG_DEBUG_PAGE_TYPE
 
 #ifdef CONFIG_X86_PAE
@@ -726,7 +741,12 @@ static inline int __init activate_vmi(vo
 		     (char *)paravirt_ops.save_fl);
 	patch_offset(&irq_save_disable_callout[IRQ_PATCH_DISABLE],
 		     (char *)paravirt_ops.irq_disable);
+#ifndef CONFIG_NO_IDLE_HZ
 	para_fill(safe_halt, Halt);
+#else
+	vmi_ops.halt = vmi_get_function(VMI_CALL_Halt);
+	paravirt_ops.safe_halt = vmi_safe_halt;
+#endif
 	para_fill(wbinvd, WBINVD);
 	/* paravirt_ops.read_msr = vmi_rdmsr */
 	/* paravirt_ops.write_msr = vmi_wrmsr */
@@ -835,6 +855,31 @@ static inline int __init activate_vmi(vo
 	paravirt_ops.apic_write = vmi_get_function(VMI_CALL_APICWrite);
 	paravirt_ops.apic_write_atomic = vmi_get_function(VMI_CALL_APICWrite);
 #endif
+
+	/*
+	 * Check for VMI timer functionality by probing for a cycle frequency method
+	 */
+	reloc = call_vrom_long_func(vmi_rom, get_reloc, VMI_CALL_GetCycleFrequency);
+	if (rel->type != VMI_RELOCATION_NONE) {
+		vmi_timer_ops.get_cycle_frequency = (void *)rel->eip;
+		vmi_timer_ops.get_cycle_counter = 
+			vmi_get_function(VMI_CALL_GetCycleCounter);
+		vmi_timer_ops.get_wallclock =
+			vmi_get_function(VMI_CALL_GetWallclockTime);
+		vmi_timer_ops.wallclock_updated =
+			vmi_get_function(VMI_CALL_WallclockUpdated);
+		vmi_timer_ops.set_alarm = vmi_get_function(VMI_CALL_SetAlarm);
+		vmi_timer_ops.cancel_alarm =
+			 vmi_get_function(VMI_CALL_CancelAlarm);
+		paravirt_ops.time_init = vmi_time_init;
+		paravirt_ops.get_wallclock = vmi_get_wallclock;
+		paravirt_ops.set_wallclock = vmi_set_wallclock;
+#ifdef CONFIG_X86_LOCAL_APIC
+		paravirt_ops.setup_boot_clock = vmi_timer_setup_boot_alarm;
+		paravirt_ops.setup_secondary_clock = vmi_timer_setup_secondary_alarm;
+#endif
+		custom_sched_clock = vmi_sched_clock;
+	}
 
 	/*
 	 * Alternative instruction rewriting doesn't happen soon enough
diff -r d1ec5a6e3e8c include/asm-i386/apic.h
--- a/include/asm-i386/apic.h	Tue Dec 12 13:53:09 2006 -0800
+++ b/include/asm-i386/apic.h	Tue Dec 12 13:53:15 2006 -0800
@@ -43,6 +43,8 @@ extern void generic_apic_probe(void);
 #define apic_write native_apic_write
 #define apic_write_atomic native_apic_write_atomic
 #define apic_read native_apic_read
+#define setup_boot_clock setup_boot_APIC_clock
+#define setup_secondary_clock setup_secondary_APIC_clock
 #endif
 
 static __inline fastcall void native_apic_write(unsigned long reg,
diff -r d1ec5a6e3e8c include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Tue Dec 12 13:53:09 2006 -0800
+++ b/include/asm-i386/paravirt.h	Tue Dec 12 13:53:15 2006 -0800
@@ -121,6 +121,8 @@ struct paravirt_ops
 	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
 	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
 	unsigned long (fastcall *apic_read)(unsigned long reg);
+	void (*setup_boot_clock)(void);
+	void (*setup_secondary_clock)(void);
 #endif
 
 	void (fastcall *flush_tlb_user)(void);
@@ -323,6 +325,16 @@ static inline unsigned long apic_read(un
 {
 	return paravirt_ops.apic_read(reg);
 }
+
+static inline void setup_boot_clock(void)
+{
+	paravirt_ops.setup_boot_clock();
+}
+
+static inline void setup_secondary_clock(void)
+{
+	paravirt_ops.setup_secondary_clock();
+}
 #endif
 
 
diff -r d1ec5a6e3e8c include/asm-i386/time.h
--- a/include/asm-i386/time.h	Tue Dec 12 13:53:09 2006 -0800
+++ b/include/asm-i386/time.h	Tue Dec 12 13:53:15 2006 -0800
@@ -30,6 +30,7 @@ static inline int native_set_wallclock(u
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
+extern unsigned long long native_sched_clock(void);
 #else /* !CONFIG_PARAVIRT */
 
 #define get_wallclock() native_get_wallclock()
diff -r d1ec5a6e3e8c include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Tue Dec 12 13:53:09 2006 -0800
+++ b/include/asm-i386/timer.h	Tue Dec 12 13:53:15 2006 -0800
@@ -9,6 +9,8 @@ extern int pit_latch_buggy;
 extern int pit_latch_buggy;
 extern int timer_ack;
 extern int no_timer_check;
+extern unsigned long long (*custom_sched_clock)(void);
+extern int no_sync_cmos_clock;
 extern int recalibrate_cpu_khz(void);
 
 #endif
diff -r d1ec5a6e3e8c arch/i386/kernel/vmitime.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/kernel/vmitime.c	Tue Dec 12 13:53:15 2006 -0800
@@ -0,0 +1,494 @@
+/*
+ * VMI paravirtual timer support routines.
+ *
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to dhecht@vmware.com
+ *
+ */
+
+/*
+ * Portions of this code from arch/i386/kernel/timers/timer_tsc.c.
+ * Portions of the CONFIG_NO_IDLE_HZ code from arch/s390/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/rcupdate.h>
+#include <linux/clocksource.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+#include <asm/apic.h>
+#include <asm/div64.h>
+#include <asm/timer.h>
+#include <asm/desc.h>
+
+#include <asm/vmi.h>
+#include <asm/vmi_time.h>
+
+#include <mach_timer.h>
+#include <io_ports.h>
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#define VMI_ALARM_WIRING VMI_ALARM_WIRED_LVTT
+#else 
+#define VMI_ALARM_WIRING VMI_ALARM_WIRED_IRQ0
+#endif 
+
+/* Cached VMI operations */
+struct vmi_timer_ops vmi_timer_ops;
+
+#ifdef CONFIG_NO_IDLE_HZ
+
+/* /proc/sys/kernel/hz_timer state. */
+int sysctl_hz_timer;
+
+/* Some stats */
+DEFINE_PER_CPU(unsigned long, vmi_idle_no_hz_irqs);
+DEFINE_PER_CPU(unsigned long, vmi_idle_no_hz_jiffies);
+static DEFINE_PER_CPU(unsigned long, idle_start_jiffies);
+
+#endif /* CONFIG_NO_IDLE_HZ */
+
+/* Number of alarms per second. By default this is CONFIG_VMI_ALARM_HZ. */
+static int alarm_hz = CONFIG_VMI_ALARM_HZ; 
+
+/* Cache of the value get_cycle_frequency / HZ. */
+static signed long long cycles_per_jiffy;
+
+/* Cache of the value get_cycle_frequency / alarm_hz. */
+static signed long long cycles_per_alarm;
+
+/* The number of cycles accounted for by the 'jiffies'/'xtime' count.
+ * Protected by xtime_lock. */
+static unsigned long long real_cycles_accounted_system;
+
+/* The number of cycles accounted for by update_process_times(), per cpu. */
+static DEFINE_PER_CPU(unsigned long long, process_times_cycles_accounted_cpu);
+
+/* The number of stolen cycles accounted, per cpu. */
+static DEFINE_PER_CPU(unsigned long long, stolen_cycles_accounted_cpu);
+
+/* Clock source. */
+static inline cycle_t read_real_cycles(void)
+{
+	return vmi_timer_ops.get_cycle_counter(VMI_CYCLES_REAL);
+}
+
+static inline cycle_t read_available_cycles(void)
+{
+	return vmi_timer_ops.get_cycle_counter(VMI_CYCLES_AVAILABLE);
+}
+
+static inline cycle_t read_stolen_cycles(void)
+{
+	return vmi_timer_ops.get_cycle_counter(VMI_CYCLES_STOLEN);
+}
+
+static struct clocksource clocksource_vmi = {
+	.name			= "vmi-timer",
+	.rating			= 450,
+	.read			= read_real_cycles,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.mult			= 0, /* to be set */
+	.shift			= 22,
+	.is_continuous		= 1,
+};
+
+
+/* Timer interrupt handler. */
+static irqreturn_t vmi_timer_interrupt(int irq, void *dev_id);
+
+struct irqaction vmi_timer_irq  = {
+	vmi_timer_interrupt,
+	SA_INTERRUPT,
+	CPU_MASK_NONE,
+	"VMI-alarm",
+	NULL,
+	NULL
+};
+
+/* Alarm rate */
+static int __init vmi_timer_alarm_rate_setup(char* str)
+{
+	int alarm_rate;
+	if (get_option(&str, &alarm_rate) == 1 && alarm_rate > 0) {
+		alarm_hz = alarm_rate;
+		printk(KERN_WARNING "VMI timer alarm HZ set to %d\n", alarm_hz);
+	}
+	return 1;
+}
+__setup("vmi_timer_alarm_hz=", vmi_timer_alarm_rate_setup);
+
+
+/* Initialization */
+static inline void vmi_get_wallclock_ts(struct timespec *ts)
+{
+	unsigned long long wallclock;
+	wallclock = vmi_timer_ops.get_wallclock(); // nsec units
+	ts->tv_nsec = do_div(wallclock, 1000000000);
+	ts->tv_sec = wallclock;	
+}
+
+static inline void update_xtime_from_wallclock(void)
+{
+	struct timespec ts;
+	vmi_get_wallclock_ts(&ts);
+	do_settimeofday(&ts);
+}
+
+unsigned long vmi_get_wallclock(void)
+{
+	struct timespec ts;
+	vmi_get_wallclock_ts(&ts);
+	return ts.tv_sec;
+}
+
+int vmi_set_wallclock(unsigned long now)
+{
+	return -1;
+}
+
+unsigned long long vmi_sched_clock(void)
+{
+	return read_available_cycles();
+}
+
+void __init vmi_time_init(void)
+{
+	unsigned long long cycles_per_sec, cycles_per_msec;
+
+	setup_irq(0, &vmi_timer_irq);
+#ifdef CONFIG_X86_LOCAL_APIC
+	set_intr_gate(LOCAL_TIMER_VECTOR, apic_vmi_timer_interrupt);
+#endif
+
+	no_sync_cmos_clock = 1;
+
+	vmi_get_wallclock_ts(&xtime);
+	set_normalized_timespec(&wall_to_monotonic,
+		-xtime.tv_sec, -xtime.tv_nsec);
+
+	real_cycles_accounted_system = read_real_cycles();
+	update_xtime_from_wallclock();
+	per_cpu(process_times_cycles_accounted_cpu, 0) = read_available_cycles();
+
+	cycles_per_sec = vmi_timer_ops.get_cycle_frequency();
+
+	cycles_per_jiffy = cycles_per_sec;
+	(void)do_div(cycles_per_jiffy, HZ);
+	cycles_per_alarm = cycles_per_sec;
+	(void)do_div(cycles_per_alarm, alarm_hz);
+	cycles_per_msec = cycles_per_sec;
+	(void)do_div(cycles_per_msec, 1000);
+	cpu_khz = cycles_per_msec;
+
+	printk(KERN_WARNING "VMI timer cycles/sec = %llu ; cycles/jiffy = %llu ;"
+	       "cycles/alarm = %llu\n", cycles_per_sec, cycles_per_jiffy, 
+	       cycles_per_alarm);
+
+	clocksource_vmi.mult = clocksource_khz2mult(cycles_per_msec, 
+						    clocksource_vmi.shift);
+	if (clocksource_register(&clocksource_vmi))
+		printk(KERN_WARNING "Error registering VMITIME clocksource.");
+
+	/* Disable PIT. */
+	outb_p(0x3a, PIT_MODE); /* binary, mode 5, LSB/MSB, ch 0 */
+
+	/* schedule the alarm. do this in phase with process_times_cycles_accounted_cpu
+	 * reduce the latency calling update_process_times. */
+	vmi_timer_ops.set_alarm(
+		      VMI_ALARM_WIRED_IRQ0 | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+		      per_cpu(process_times_cycles_accounted_cpu, 0) + cycles_per_alarm, 
+		      cycles_per_alarm);
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+void __init vmi_timer_setup_boot_alarm(void)
+{
+	local_irq_disable();
+
+	/* Route the interrupt to the correct vector. */
+	apic_write_around(APIC_LVTT, LOCAL_TIMER_VECTOR);
+
+	/* Cancel the IRQ0 wired alarm, and setup the LVTT alarm. */
+	vmi_timer_ops.cancel_alarm(VMI_CYCLES_AVAILABLE);
+	vmi_timer_ops.set_alarm(
+		      VMI_ALARM_WIRED_LVTT | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+		      per_cpu(process_times_cycles_accounted_cpu, 0) + cycles_per_alarm,
+		      cycles_per_alarm);
+	local_irq_enable();
+}
+
+/* Initialize the time accounting variables for an AP on an SMP system.
+ * Also, set the local alarm for the AP. */
+void __init vmi_timer_setup_secondary_alarm(void)
+{
+	int cpu = smp_processor_id();
+
+	/* Route the interrupt to the correct vector. */
+	apic_write_around(APIC_LVTT, LOCAL_TIMER_VECTOR);
+	
+	per_cpu(process_times_cycles_accounted_cpu, cpu) = read_available_cycles();
+	
+	vmi_timer_ops.set_alarm(
+		      VMI_ALARM_WIRED_LVTT | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+		      per_cpu(process_times_cycles_accounted_cpu, cpu) + cycles_per_alarm, 
+		      cycles_per_alarm);
+}
+
+#endif
+
+/* Update system wide (real) time accounting (e.g. jiffies, xtime). */
+static inline void vmi_account_real_cycles(unsigned long long cur_real_cycles)
+{
+	long long cycles_not_accounted;
+
+	write_seqlock(&xtime_lock);
+
+	cycles_not_accounted = cur_real_cycles - real_cycles_accounted_system;
+	while (cycles_not_accounted >= cycles_per_jiffy) {
+		/* systems wide jiffies and wallclock. */
+		do_timer(1);
+		
+		cycles_not_accounted -= cycles_per_jiffy;
+		real_cycles_accounted_system += cycles_per_jiffy;
+	}
+	
+	if (vmi_timer_ops.wallclock_updated())
+		update_xtime_from_wallclock();
+
+	write_sequnlock(&xtime_lock);
+}
+
+/* Update per-cpu process times. */
+static inline void vmi_account_process_times_cycles(struct pt_regs *regs,
+						    int cpu,
+						    unsigned long long cur_process_times_cycles)
+{
+	long long cycles_not_accounted;
+	cycles_not_accounted = cur_process_times_cycles - 
+		per_cpu(process_times_cycles_accounted_cpu, cpu);
+	
+	while (cycles_not_accounted >= cycles_per_jiffy) {
+		/* Account time to the current process.  This includes
+		 * calling into the scheduler to decrement the timeslice
+		 * and possibly reschedule.*/
+		update_process_times(user_mode(regs));
+		/* XXX handle /proc/profile multiplier.  */
+		profile_tick(CPU_PROFILING);
+
+		cycles_not_accounted -= cycles_per_jiffy;
+		per_cpu(process_times_cycles_accounted_cpu, cpu) += cycles_per_jiffy;
+	}
+}
+
+#ifdef CONFIG_NO_IDLE_HZ
+/* Update per-cpu idle times.  Used when a no-hz halt is ended. */
+static inline void vmi_account_no_hz_idle_cycles(int cpu,
+						 unsigned long long cur_process_times_cycles)
+{
+	long long cycles_not_accounted;
+	unsigned long no_idle_hz_jiffies = 0;
+
+	cycles_not_accounted = cur_process_times_cycles - 
+		per_cpu(process_times_cycles_accounted_cpu, cpu);
+	
+	while (cycles_not_accounted >= cycles_per_jiffy) {
+		no_idle_hz_jiffies++;
+		cycles_not_accounted -= cycles_per_jiffy;
+		per_cpu(process_times_cycles_accounted_cpu, cpu) += cycles_per_jiffy;
+	}
+	/* Account time to the idle process. */
+	account_steal_time(idle_task(cpu), jiffies_to_cputime(no_idle_hz_jiffies));
+}
+#endif
+
+/* Update per-cpu stolen time. */
+static inline void vmi_account_stolen_cycles(int cpu,
+					     unsigned long long cur_real_cycles,
+					     unsigned long long cur_avail_cycles)
+{
+	long long stolen_cycles_not_accounted;
+	unsigned long stolen_jiffies = 0;
+
+	if (cur_real_cycles < cur_avail_cycles)
+		return;
+
+	stolen_cycles_not_accounted = cur_real_cycles - cur_avail_cycles - 
+		per_cpu(stolen_cycles_accounted_cpu, cpu);
+
+	while (stolen_cycles_not_accounted >= cycles_per_jiffy) {
+		stolen_jiffies++;
+		stolen_cycles_not_accounted -= cycles_per_jiffy;
+		per_cpu(stolen_cycles_accounted_cpu, cpu) += cycles_per_jiffy;
+	}
+	/* HACK: pass NULL to force time onto cpustat->steal. */
+	account_steal_time(NULL, jiffies_to_cputime(stolen_jiffies));
+}
+
+/* Body of either IRQ0 interrupt handler (UP no local-APIC) or 
+ * local-APIC LVTT interrupt handler (UP & local-APIC or SMP). */
+static void vmi_local_timer_interrupt(int cpu)
+{
+	unsigned long long cur_real_cycles, cur_process_times_cycles;
+
+	cur_real_cycles = read_real_cycles();
+	cur_process_times_cycles = read_available_cycles();
+	/* Update system wide (real) time state (xtime, jiffies). */
+	vmi_account_real_cycles(cur_real_cycles);
+	/* Update per-cpu process times. */
+	vmi_account_process_times_cycles(get_irq_regs(), cpu, cur_process_times_cycles);
+        /* Update time stolen from this cpu by the hypervisor. */
+	vmi_account_stolen_cycles(cpu, cur_real_cycles, cur_process_times_cycles);
+}
+
+#ifdef CONFIG_NO_IDLE_HZ
+
+/* Must be called only from idle loop, with interrupts disabled. */
+int vmi_stop_hz_timer(void)
+{
+	/* Note that cpu_set, cpu_clear are (SMP safe) atomic on x86. */
+
+	unsigned long seq, next;
+	unsigned long long real_cycles_expiry;
+	int cpu = smp_processor_id();
+	int idle;
+
+	BUG_ON(!irqs_disabled());
+	if (sysctl_hz_timer != 0)
+		return 0;
+
+	cpu_set(cpu, nohz_cpu_mask);
+	smp_mb();
+	if (rcu_needs_cpu(cpu) || local_softirq_pending() ||
+	    (next = next_timer_interrupt(), time_before_eq(next, jiffies))) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		next = jiffies;
+		idle = 0;
+	} else
+		idle = 1;
+
+	/* Convert jiffies to the real cycle counter. */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		real_cycles_expiry = real_cycles_accounted_system + 
+			(long)(next - jiffies) * cycles_per_jiffy;
+	} while (read_seqretry(&xtime_lock, seq));
+	
+	/* This cpu is going idle. Disable the periodic alarm. */
+	if (idle) {
+		vmi_timer_ops.cancel_alarm(VMI_CYCLES_AVAILABLE);
+		per_cpu(idle_start_jiffies, cpu) = jiffies;
+	}
+
+	/* Set the real time alarm to expire at the next event. */
+	vmi_timer_ops.set_alarm(
+		      VMI_ALARM_WIRING | VMI_ALARM_IS_ONESHOT | VMI_CYCLES_REAL,
+		      real_cycles_expiry, 0);
+
+	return idle;
+}
+
+static inline void vmi_reenable_hz_timer(int cpu)
+{
+	/* For /proc/vmi/info idle_hz stat. */
+	per_cpu(vmi_idle_no_hz_jiffies, cpu) += jiffies - per_cpu(idle_start_jiffies, cpu);
+	per_cpu(vmi_idle_no_hz_irqs, cpu)++;
+
+	/* Don't bother explicitly cancelling the one-shot alarm -- at
+	 * worse we will receive a spurious timer interrupt. */
+	vmi_timer_ops.set_alarm(
+		      VMI_ALARM_WIRING | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+		      per_cpu(process_times_cycles_accounted_cpu, cpu) + cycles_per_alarm, 
+		      cycles_per_alarm);
+	/* Indicate this cpu is no longer nohz idle. */
+	cpu_clear(cpu, nohz_cpu_mask);
+}
+
+/* Called from interrupt handlers when (local) HZ timer is disabled. */
+void vmi_account_time_restart_hz_timer(void)
+{
+	unsigned long long cur_real_cycles, cur_process_times_cycles;
+	int cpu = smp_processor_id();
+
+	BUG_ON(!irqs_disabled());
+	/* Account the time during which the HZ timer was disabled. */
+	cur_real_cycles = read_real_cycles();
+	cur_process_times_cycles = read_available_cycles();
+	/* Update system wide (real) time state (xtime, jiffies). */
+	vmi_account_real_cycles(cur_real_cycles);
+	/* Update per-cpu idle times. */
+	vmi_account_no_hz_idle_cycles(cpu, cur_process_times_cycles);
+        /* Update time stolen from this cpu by the hypervisor. */
+	vmi_account_stolen_cycles(cpu, cur_real_cycles, cur_process_times_cycles);
+	/* Reenable the hz timer. */
+	vmi_reenable_hz_timer(cpu);
+}
+
+#endif /* CONFIG_NO_IDLE_HZ */
+
+/* UP (and no local-APIC) VMI-timer alarm interrupt handler. 
+ * Handler for IRQ0. Not used when SMP or X86_LOCAL_APIC after
+ * APIC setup and setup_boot_vmi_alarm() is called.  */
+static irqreturn_t vmi_timer_interrupt(int irq, void *dev_id)
+{
+	vmi_local_timer_interrupt(smp_processor_id());
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+/* SMP VMI-timer alarm interrupt handler. Handler for LVTT vector.
+ * Also used in UP when CONFIG_X86_LOCAL_APIC.
+ * The wrapper code is from arch/i386/kernel/apic.c#smp_apic_timer_interrupt. */
+fastcall void smp_apic_vmi_timer_interrupt(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	int cpu = smp_processor_id();
+
+	/*
+	 * the NMI deadlock-detector uses this.
+	 */
+        per_cpu(irq_stat,cpu).apic_timer_irqs++;
+
+	/*
+	 * NOTE! We'd better ACK the irq immediately,
+	 * because timer handling can be slow.
+	 */
+	ack_APIC_irq();
+
+	/*
+	 * update_process_times() expects us to have done irq_enter().
+	 * Besides, if we don't timer interrupts ignore the global
+	 * interrupt lock, which is the WrongThing (tm) to do.
+	 */
+	irq_enter();
+	vmi_local_timer_interrupt(cpu);
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+
+#endif  /* CONFIG_X86_LOCAL_APIC */
diff -r d1ec5a6e3e8c include/asm-i386/vmi_time.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/vmi_time.h	Tue Dec 12 13:53:15 2006 -0800
@@ -0,0 +1,103 @@
+/*
+ * VMI Time wrappers
+ *
+ * Copyright (C) 2006, VMware, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to dhecht@vmware.com
+ *
+ */
+
+#ifndef __VMI_TIME_H
+#define __VMI_TIME_H
+
+/*
+ * Raw VMI call indices for timer functions
+ */
+#define VMI_CALL_GetCycleFrequency	66
+#define VMI_CALL_GetCycleCounter	67
+#define VMI_CALL_SetAlarm		68
+#define VMI_CALL_CancelAlarm		69
+#define VMI_CALL_GetWallclockTime	70
+#define VMI_CALL_WallclockUpdated	71
+
+/* Cached VMI timer operations */
+extern struct vmi_timer_ops {
+	u64 (fastcall *get_cycle_frequency)(void);
+	u64 (fastcall *get_cycle_counter)(int);
+	u64 (fastcall *get_wallclock)(void);
+	int (fastcall *wallclock_updated)(void);
+	void (fastcall *set_alarm)(u32 flags, u64 expiry, u64 period);
+	void (fastcall *cancel_alarm)(u32 flags);
+} vmi_timer_ops;
+ 
+/* Prototypes */
+extern void __init vmi_time_init(void);
+extern unsigned long vmi_get_wallclock(void);
+extern int vmi_set_wallclock(unsigned long now);
+extern unsigned long long vmi_sched_clock(void);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+extern void __init vmi_timer_setup_boot_alarm(void);
+extern void __init vmi_timer_setup_secondary_alarm(void);
+extern fastcall void apic_vmi_timer_interrupt(void);
+#endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern int vmi_stop_hz_timer(void);
+extern void vmi_account_time_restart_hz_timer(void);
+#endif
+
+/*
+ * When run under a hypervisor, a vcpu is always in one of three states:
+ * running, halted, or ready.  The vcpu is in the 'running' state if it
+ * is executing.  When the vcpu executes the halt interface, the vcpu
+ * enters the 'halted' state and remains halted until there is some work
+ * pending for the vcpu (e.g. an alarm expires, host I/O completes on
+ * behalf of virtual I/O).  At this point, the vcpu enters the 'ready'
+ * state (waiting for the hypervisor to reschedule it).  Finally, at any
+ * time when the vcpu is not in the 'running' state nor the 'halted'
+ * state, it is in the 'ready' state.
+ *
+ * Real time is advances while the vcpu is 'running', 'ready', or
+ * 'halted'.  Stolen time is the time in which the vcpu is in the
+ * 'ready' state.  Available time is the remaining time -- the vcpu is
+ * either 'running' or 'halted'.
+ *
+ * All three views of time are accessible through the VMI cycle
+ * counters.
+ */
+
+/* The cycle counters. */
+#define VMI_CYCLES_REAL         0
+#define VMI_CYCLES_AVAILABLE    1
+#define VMI_CYCLES_STOLEN       2
+
+/* The alarm interface 'flags' bits */
+#define VMI_ALARM_COUNTERS      2
+
+#define VMI_ALARM_COUNTER_MASK  0x000000ff
+
+#define VMI_ALARM_WIRED_IRQ0    0x00000000
+#define VMI_ALARM_WIRED_LVTT    0x00010000
+
+#define VMI_ALARM_IS_ONESHOT    0x00000000
+#define VMI_ALARM_IS_PERIODIC   0x00000100
+
+#define CONFIG_VMI_ALARM_HZ	100
+
+#endif
