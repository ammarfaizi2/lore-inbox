Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWCMSUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWCMSUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWCMSUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:20:48 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:53262 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932315AbWCMSUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:20:46 -0500
Date: Mon, 13 Mar 2006 10:17:46 -0800
Message-Id: <200603131817.k2DIHkMa005792@zach-dev.vmware.com>
Subject: [RFC, PATCH 24/24] i386 Vmi no idle hz
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:17:53.0888 (UTC) FILETIME=[72231E00:01C646CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A NO_IDLE_HZ implementation is provided for i386 VMI builds.

When a VCPU enters its idle loop, it disables its periodic
alarm and sets up a one shot alarm for the next time event.
That way, it does not become ready to run just to service
the periodic alarm interrupt. Instead, it can remain halted
until there is some real work pending for it.  This allows
the hypervisor to use the physical resources more
effectively since idle VCPUs will have lower overhead.

Signed-off-by: Dan Hecht <dhecht@vmware.com>

Index: linux-2.6.16-rc6/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/Kconfig	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/Kconfig	2006-03-12 19:57:53.000000000 -0800
@@ -193,6 +193,23 @@ config VMI_REQUIRE_HYPERVISOR
           This option forces the kernel to run with a hypervisor present.
           The kernel will panic if booted on native hardware.
 
+config NO_IDLE_HZ
+	bool "No HZ timer ticks in idle"
+	default y
+	help
+	  Switches the regular HZ timer off when the system is going idle.
+          This reduces the overhead of an idle system.  Also, this causes 
+          the guest to voluntarily block until it has some useful work to do,
+          rather than running in order to just handle timer interrupts.
+
+	  The HZ timer can be switched on/off via /proc/sys/kernel/hz_timer.
+	  hz_timer=0 means HZ timer is disabled. hz_timer=1 means HZ
+	  timer is active.
+
+          In order for this option to take effect, the kernel must be running
+          on a hypervisor.  This option has no effect when running on native 
+          hardware.
+
 choice 
 	prompt "VMI alarm rate"
 	default VMI_ALARM_HZ_100
Index: linux-2.6.16-rc6/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/apic.c	2006-03-12 19:57:42.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/apic.c	2006-03-12 19:57:53.000000000 -0800
@@ -40,6 +40,7 @@
 #include <mach_apic.h>
 #include <mach_ipi.h>
 #include <mach_apictimer.h>
+#include <mach_idletimer.h>
 
 #include "io_ports.h"
 
@@ -1193,6 +1194,7 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+	restart_hz_timer(regs);
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
@@ -1242,6 +1244,7 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+	restart_hz_timer(regs);
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1266,6 +1269,7 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+	restart_hz_timer(regs);
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.16-rc6/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/irq.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/irq.c	2006-03-12 19:57:53.000000000 -0800
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <mach_idletimer.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_internodealigned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +77,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	restart_hz_timer(regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.16-rc6/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/process.c	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/process.c	2006-03-12 19:57:53.000000000 -0800
@@ -57,6 +57,8 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <mach_idletimer.h>
+
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
@@ -107,9 +109,10 @@ void default_idle(void)
 		smp_mb__after_clear_bit();
 		while (!need_resched()) {
 			local_irq_disable();
-			if (!need_resched())
+			if (!need_resched()) {
+				stop_hz_timer();
 				safe_halt();
-			else
+			} else
 				local_irq_enable();
 		}
 		set_thread_flag(TIF_POLLING_NRFLAG);
Index: linux-2.6.16-rc6/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/smp.c	2006-03-12 19:57:39.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/smp.c	2006-03-12 19:57:53.000000000 -0800
@@ -24,6 +24,7 @@
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
 #include <mach_apic.h>
+#include <mach_idletimer.h>
 
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
@@ -313,6 +314,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
 
+	restart_hz_timer(regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -601,6 +604,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	restart_hz_timer(regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -610,6 +615,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	restart_hz_timer(regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_vmi.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_vmi.c	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_vmi.c	2006-03-12 19:57:53.000000000 -0800
@@ -26,6 +26,7 @@
 
 /*
  * Portions of this code from arch/i386/kernel/timers/timer_tsc.c.
+ * Portions of the CONFIG_NO_IDLE_HZ code from arch/s390/kernel/time.c.
  * See comments there for proper credits.
  */
 
@@ -46,6 +47,7 @@
 #include <mach_timer.h>
 #include <mach_apictimer.h>
 #include <mach_schedclock.h>
+#include <mach_idletimer.h>
 #include <io_ports.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -54,6 +56,18 @@
 #define VMI_ALARM_WIRING VMI_ALARM_WIRED_IRQ0
 #endif 
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+#define VMI_MIN_NO_IDLE_HZ_SKIPPED_TICKS 1
+
+/* /proc/sys/kernel/hz_timer state. */
+int sysctl_hz_timer;
+/* Some stats, printed in /proc/vmi/info. */
+DEFINE_PER_CPU(unsigned long, vmi_idle_no_hz_irqs);
+DEFINE_PER_CPU(unsigned long, vmi_idle_no_hz_jiffies);
+static DEFINE_PER_CPU(unsigned long, idle_start_jiffies);
+#endif /* CONFIG_NO_IDLE_HZ */
+
 /* Number of alarms per second. By default this is CONFIG_VMI_ALARM_HZ. */
 static int alarm_hz = CONFIG_VMI_ALARM_HZ; 
 
@@ -324,6 +338,29 @@ static inline void vmi_account_process_t
 	}
 }
 
+/* Update per-cpu idle times.  Used when a no-hz halt is ended. */
+static inline void vmi_account_no_hz_idle_cycles(struct pt_regs *regs,
+						 int cpu,
+						 unsigned long long cur_process_times_cycles)
+{
+	long long cycles_not_accounted;
+	unsigned long no_idle_hz_jiffies = 0;
+
+	cycles_not_accounted = cur_process_times_cycles - 
+		per_cpu(process_times_cycles_accounted_cpu, cpu);
+	
+	while (cycles_not_accounted >= cycles_per_jiffy) {
+		/* XXXPara: handle /proc/profile multiplier.  */
+		profile_tick(CPU_PROFILING, regs);
+
+		no_idle_hz_jiffies++;
+		cycles_not_accounted -= cycles_per_jiffy;
+		per_cpu(process_times_cycles_accounted_cpu, cpu) += cycles_per_jiffy;
+	}
+	/* Account time to the idle process.  Also checks for expired timers, etc. */
+	update_idle_times(jiffies_to_cputime(no_idle_hz_jiffies));
+}
+
 /* Update per-cpu stolen time. */
 static inline void vmi_account_stolen_cycles(int cpu,
 					     unsigned long long cur_real_cycles,
@@ -362,6 +399,87 @@ static void vmi_local_timer_interrupt(st
 	vmi_account_stolen_cycles(cpu, cur_real_cycles, cur_process_times_cycles);
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/* Must be called only from idle loop, with interrupts disabled. */
+void vmi_stop_hz_timer(void)
+{
+	/* Note that cpu_set, cpu_clear are (SMP safe) atomic on x86. */
+
+	unsigned long seq, next;
+	unsigned long long real_cycles_expiry;
+	int cpu = smp_processor_id();
+
+	/* Allow disabling via /proc/sys/kernel/hz_timer. */
+	if (sysctl_hz_timer != 0)
+		return;
+
+	/* Set nohz_cpu_mask, check rcu_pending in same order as S390. */
+	cpu_set(cpu, nohz_cpu_mask);
+	if (rcu_pending(cpu) || local_softirq_pending()) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		return;
+	}
+
+	next = next_timer_interrupt();
+
+	if (jiffies + VMI_MIN_NO_IDLE_HZ_SKIPPED_TICKS >= next) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		return;
+	}
+
+	/* This cpu is going really idle. Disable the periodic alarm. */
+	vmi_cancel_alarm(VMI_CYCLES_AVAILABLE);
+
+	/* Convert jiffies to the real cycle counter. */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		real_cycles_expiry = real_cycles_accounted_system + 
+			(next - jiffies) * cycles_per_jiffy;
+	} while (read_seqretry(&xtime_lock, seq));
+	
+	/* For /proc/vmi/info idle_hz stat. */
+	per_cpu(idle_start_jiffies, cpu) = jiffies;
+
+	/* Set the real time alarm to expire at the next event. */
+	vmi_set_alarm(VMI_ALARM_WIRING | VMI_ALARM_IS_ONESHOT | VMI_CYCLES_REAL,
+		      real_cycles_expiry, 0);
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
+	vmi_set_alarm(VMI_ALARM_WIRING | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+		      per_cpu(process_times_cycles_accounted_cpu, cpu) + cycles_per_alarm, 
+		      cycles_per_alarm);
+	/* Indicate this cpu is no longer nohz idle. */
+	cpu_clear(cpu, nohz_cpu_mask);
+}
+
+/* Called from interrupt handlers when (local) HZ timer is disabled. */
+void vmi_account_time_restart_hz_timer(struct pt_regs *regs, int cpu)
+{
+	unsigned long long cur_real_cycles, cur_process_times_cycles;
+	/* Account the time during which the HZ timer was disabled. */
+	cur_real_cycles = vmi_get_real_cycles();
+	cur_process_times_cycles = vmi_get_available_cycles();
+	/* Update system wide (real) time state (xtime, jiffies). */
+	vmi_account_real_cycles(regs, cur_real_cycles);
+	/* Update per-cpu idle times. */
+	vmi_account_no_hz_idle_cycles(regs, cpu, cur_process_times_cycles);
+        /* Update time stolen from this cpu by the hypervisor. */
+	vmi_account_stolen_cycles(cpu, cur_real_cycles, cur_process_times_cycles);
+	/* Reenable the hz timer. */
+	vmi_reenable_hz_timer(cpu);
+}
+
+#endif /* CONFIG_NO_IDLE_HZ */
+
 /* UP (and no local-APIC) VMI-timer alarm interrupt handler. 
  * Handler for IRQ0. Not used when SMP or X86_LOCAL_APIC after
  * APIC setup and setup_boot_vmi_alarm() is called.  */
@@ -396,6 +514,7 @@ fastcall void smp_apic_vmi_timer_interru
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+	restart_hz_timer(regs);
 
 	vmi_local_timer_interrupt(regs, cpu);
 
Index: linux-2.6.16-rc6/arch/i386/mach-vmi/proc.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mach-vmi/proc.c	2006-03-12 19:57:41.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mach-vmi/proc.c	2006-03-12 19:57:53.000000000 -0800
@@ -49,6 +49,11 @@ struct pnp_header {
 	unsigned short product_offset;
 } __attribute__((packed));
 
+#ifdef CONFIG_NO_IDLE_HZ
+extern DEFINE_PER_CPU(unsigned long, vmi_idle_no_hz_irqs);
+extern DEFINE_PER_CPU(unsigned long, vmi_idle_no_hz_jiffies);
+#endif
+
 /* XXX This hack can only be used with passthrough TSC */
 static inline unsigned long long get_tsc(void)
 {
@@ -123,6 +128,21 @@ static int proc_vmi_info_show(struct seq
 	time_page_fault();
 	seq_printf(m, "Kernel #PF cycle count: %lld\n", page_fault_cycles);
 
+#ifdef CONFIG_NO_IDLE_HZ 
+ {
+	int i;
+	seq_printf(m, "Idle HZ:");
+	for_each_cpu(i) {
+		/* Shouldn't go idle now, so no extra synchronization needed. */
+		unsigned int irqs_per_ks = 0;
+		if (per_cpu(vmi_idle_no_hz_jiffies, i)) 
+			irqs_per_ks = 1000 * HZ * per_cpu(vmi_idle_no_hz_irqs, i) /
+				per_cpu(vmi_idle_no_hz_jiffies, i);
+		seq_printf(m, " %u.%03u", irqs_per_ks/1000, irqs_per_ks%1000);
+	}
+	seq_printf(m, "\n");
+ }
+#endif
 	return 0;
 }
 
Index: linux-2.6.16-rc6/kernel/sysctl.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/sysctl.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/kernel/sysctl.c	2006-03-12 19:57:53.000000000 -0800
@@ -560,16 +560,6 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_NO_IDLE_HZ
-	{
-		.ctl_name       = KERN_HZ_TIMER,
-		.procname       = "hz_timer",
-		.data           = &sysctl_hz_timer,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = &proc_dointvec,
-	},
-#endif
 	{
 		.ctl_name	= KERN_S390_USER_DEBUG_LOGGING,
 		.procname	= "userprocess_debug",
@@ -579,6 +569,17 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#if defined(CONFIG_NO_IDLE_HZ) && (defined(CONFIG_ARCH_S390) || \
+				   defined(CONFIG_X86) && defined(CONFIG_X86_VMI))
+	{
+		.ctl_name       = KERN_HZ_TIMER,
+		.procname       = "hz_timer",
+		.data           = &sysctl_hz_timer,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = &proc_dointvec,
+	},
+#endif
 	{
 		.ctl_name	= KERN_PIDMAX,
 		.procname	= "pid_max",
Index: linux-2.6.16-rc6/kernel/timer.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/timer.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/kernel/timer.c	2006-03-12 19:57:53.000000000 -0800
@@ -823,6 +823,17 @@ static void update_wall_time(unsigned lo
 	} while (ticks);
 }
 
+static inline void after_process_times_updated(int user_tick, struct task_struct *p)
+{
+	int cpu = smp_processor_id();
+
+	run_local_timers();
+	if (rcu_pending(cpu))
+		rcu_check_callbacks(cpu, user_tick);
+	scheduler_tick();
+ 	run_posix_cpu_timers(p);
+}
+
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -830,18 +841,23 @@ static void update_wall_time(unsigned lo
 void update_process_times(int user_tick)
 {
 	struct task_struct *p = current;
-	int cpu = smp_processor_id();
 
 	/* Note: this timer irq context must be accounted for as well. */
 	if (user_tick)
 		account_user_time(p, jiffies_to_cputime(1));
 	else
 		account_system_time(p, HARDIRQ_OFFSET, jiffies_to_cputime(1));
-	run_local_timers();
-	if (rcu_pending(cpu))
-		rcu_check_callbacks(cpu, user_tick);
-	scheduler_tick();
- 	run_posix_cpu_timers(p);
+
+	after_process_times_updated(user_tick, p);
+}
+
+void update_idle_times(cputime_t idle_time)
+{
+	/* current should be the idle task. */
+	struct task_struct *p = current;
+
+	account_system_time(p, HARDIRQ_OFFSET, idle_time);
+	after_process_times_updated(0, p);
 }
 
 /*
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_idletimer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/mach_idletimer.h	2006-03-12 19:57:53.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_idletimer.h	2006-03-12 19:57:53.000000000 -0800
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
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
+ * NO_IDLE_HZ callbacks.
+ */
+
+#ifndef __ASM_MACH_IDLETIMER_H
+#define __ASM_MACH_IDLETIMER_H
+
+#include <vmi.h>
+
+#if !defined(CONFIG_X86_VMI)
+# error invalid sub-arch include
+#endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+
+extern void vmi_stop_hz_timer(void);
+extern void vmi_account_time_restart_hz_timer(struct pt_regs *regs, int cpu);
+
+static inline void stop_hz_timer(void)
+{
+	if (vmi_timer_used())
+		vmi_stop_hz_timer();
+}
+
+static inline void restart_hz_timer(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	/* nohz_cpu_mask bit set also implies vmi_timer_used(). */
+	if (cpu_isset(cpu, nohz_cpu_mask))
+		vmi_account_time_restart_hz_timer(regs, cpu);
+}
+
+#else /* CONFIG_NO_IDLE_HZ */
+
+static inline void stop_hz_timer(void) 
+{
+}
+
+static inline void restart_hz_timer(struct pt_regs *regs)
+{
+}
+
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#endif /* __ASM_MACH_IDLETIMER_H */
Index: linux-2.6.16-rc6/include/asm-i386/mach-default/mach_idletimer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-default/mach_idletimer.h	2006-03-12 19:57:53.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-default/mach_idletimer.h	2006-03-12 19:57:53.000000000 -0800
@@ -0,0 +1,19 @@
+
+/*
+ * NO_IDLE_HZ callbacks.
+ */
+
+#ifndef __ASM_MACH_IDLETIMER_H
+#define __ASM_MACH_IDLETIMER_H
+
+static inline void stop_hz_timer(void) 
+{
+
+}
+
+static inline void restart_hz_timer(struct pt_regs *regs)
+{
+
+}
+
+#endif /* __ASM_MACH_IDLETIMER_H */
Index: linux-2.6.16-rc6/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6.orig/include/linux/sched.h	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/include/linux/sched.h	2006-03-12 19:57:53.000000000 -0800
@@ -203,6 +203,7 @@ long io_schedule_timeout(long timeout);
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
+extern void update_idle_times(cputime_t idle_time);
 extern void scheduler_tick(void);
 
 #ifdef CONFIG_DETECT_SOFTLOCKUP
