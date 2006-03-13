Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWCMSUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWCMSUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWCMSUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:20:20 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:37646 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932312AbWCMSUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:20:18 -0500
Date: Mon, 13 Mar 2006 10:16:59 -0800
Message-Id: <200603131816.k2DIGxnW005785@zach-dev.vmware.com>
Subject: [RFC, PATCH 23/24] i386 Vmi timer patch
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
X-OriginalArrivalTime: 13 Mar 2006 18:16:59.0669 (UTC) FILETIME=[51D1F450:01C646CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a virtualized environment, virtual machines will time share the system
with each other and with other processes running on the host system.
Therefore, a VM's virtual CPUs (VCPUs) will be executing on the host's
physical CPUs (pcpus) for only some portion of time.

The VMI exposes a paravirtual view of time to the guest operating systems
so that they may operate more effectively in a virtual environment.  The
interface also provides a way for the VCPUs to set alarms in this
paravirtual view of time.

A VCPU is always in one of three states: running, halted, or ready.  The
VCPU is in the 'running' state if it is executing.  When the VCPU executes
the Halt interface, the VCPU enters the 'halted' state and remains halted
until there is some work pending for the VCPU (e.g. an alarm expires,
host I/O completes on behalf of virtual I/O).  At this point, the VCPU
enters the 'ready' state (waiting for the hypervisor to reschedule it).
Finally, at any time when the VCPU is not in the 'running' state nor the
'halted' state, it is in the 'ready' state.

The VMI provides cycle counters for three time domains: real time, available
time and stolen time.  Real time progresses when the VCPU is in the 'halted',
'ready' and 'running' states.  Stolen time is defined per VCPU to progress at
the rate of real time when the VCPU is in the 'ready' state, and does not
progress otherwise. Available time is defined per VCPU to progress at the rate
of real time when the VCPU is in the 'running' and 'halted' states, and does
not progress when the VCPU is in the 'ready' state.  Additionally, the
wallclock time is provided by the VMI.  See the VMI specification for more
details.

This patch provides a Linux time source, the VMI Time device, that is
programmed against the cycle counters and alarms provided by the VMI. It is
used as the time source when the kernel detects the presence of a hypervisor.

Some noteworthy characteristics of the VMI Time device code are:

1) Cycle counter frequency is indicated by the VMI rather than needing to be
   calculated by comparing the counter rate to a known interrupt rate.

   On native hardware, the TSC frequency is calculated by comparing the rate
   at which the TSC advances with the (known) rate of a timer interrupt.
   This method for determining a cycle counter frequency is unreliable on
   virtual hardware since the VCPU may be preempted by the hypervisor during
   this calculation.

   Instead, the VMI Time device determines the frequency of the VMI cycle
   counters by querying the VMI.

2) The timer_irq_works() algorithm is problematic in a virtual environment for
   various reasons, and is avoided.  When running on a hypervisor, the kernel
   can assume that the alarm will be wired up correctly to the interrupt
   controller and this logic is avoided altogether.

3) Rather than keeping kernel time state (e.g. jiffies, xtime, time slices) up
   to date by counting interrupts, the state is updated based on the values of
   the VMI cycle counters.

   Therefore, a VCPU only needs to receive timer interrupts while it is
   running.  This leads to better scaling of the number of virtual machines
   that can be run on a single host.

4) As a consequence of #3, the interrupt rate of the alarm can be dropped
   lower than HZ.  It may be beneficial for the guest to request a lower
   alarm rate to decrease the overhead of delivering virtual interrupts.
   With #3, this is possible without changing the HZ constant (which is
   important in order to allow for transparency with native hardware using
   the normal HZ rate).

5) System wide time state (e.g. jiffies, xtime) is updated by all VCPUs.

   With the native x86 timer interrupts, only the boot processor's PIT
   interrupt updates jiffies and xtime.  With the VMI Time device, jiffies
   and xtime are updated by all the VCPUs of a VM.  This is important since
   the VCPUs may be independently scheduled.  Also, it allows for a simpler
   NO_IDLE_HZ implementation.

6) The xtime counter is kept up with the wallclock time.

7) The jiffies counter is kept up with the real time cycle counter.

8) Scheduler time slices and sched_clock() are kept up with the available
   time cycle counter.

   When using the VMI Time device as the time source, the scheduler runs
   in available time.  Otherwise, processes would be charged for time stolen
   from the VCPU (time in which the VCPU isn't even running).  The
   scheduler_tick() interface is called only for every tick of available time.
   Also, sched_clock() is implemented using the available time counter so that
   the scheduler's calculations of a process' run-time does not charge stolen
   time.

9) Stolen time is computed by the hypervisor, not the Linux guest.

   Only the hypervisor can accurately compute stolen time.  On some
   hypervisors, stolen time is computed by the guest by subtracting the
   amount of time a VCPU has run on a PCPU from the amount of real time
   that has passed.  Then, the routine account_steal_time() is used to
   charge this time difference to
     a) steal time, if the current process is not the idle process, or
     b) idle time, if the current process is the idle process.

   The problem with that calculation is that when a VCPU's halt ends,
   it will not necessarily run immediately.  Instead, it will be
   transitioned from the 'halted' state to the 'ready' state (i.e. added
   to the hypervisor's runqueue) until the hypervisor chooses to run it.
   The time  the VCPU is 'ready' is not idle time, but instead stolen time.
   But, implementations using account_steal_time() will account all of this
   time to idle time, rather than partitioning the time such that the time
   spent in the 'halted' state is idle time and the time spent in the
   'ready' state is stolen time.

   Only the hypervisor can determine when the transition from 'halted' to
   'ready' occurred (due to work becoming pending for the VCPU).  So, the
   VMI Time device queries the stolen time from the VMI rather than using
   the faulty account_steal_time() algorithm. 

Signed-off-by: Dan Hecht <dhecht@vmware.com>

Index: linux-2.6.16-rc6/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/Kconfig	2006-03-12 19:57:31.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/Kconfig	2006-03-12 19:57:48.000000000 -0800
@@ -193,6 +193,37 @@ config VMI_REQUIRE_HYPERVISOR
           This option forces the kernel to run with a hypervisor present.
           The kernel will panic if booted on native hardware.
 
+choice 
+	prompt "VMI alarm rate"
+	default VMI_ALARM_HZ_100
+
+config VMI_ALARM_HZ_100
+	bool "Use 100 hz"
+        help
+          Sets the interrupt rate for the VMI-timer alarm, which is the
+          timer device that is used when running on a hypervisor.
+
+          Sets the alarm rate to 100 interrupts per second.
+
+          This option has no effect when running on native hardware.
+
+config VMI_ALARM_HZ_HZ
+	bool "Use HZ"
+	help
+          Sets the interrupt rate for the VMI-timer alarm, which is the
+          timer device that is used when running on a hypervisor.
+
+          Sets the alarm rate to HZ interrupts per second.
+
+          This option has no effect when running on native hardware.
+
+endchoice
+
+config VMI_ALARM_HZ
+        int
+        default 100 if VMI_ALARM_HZ_100
+        default HZ if VMI_ALARM_HZ_HZ
+
 config VMI_DEBUG
 	bool "VMI debugging"
 	default n
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/Makefile
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/Makefile	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/Makefile	2006-03-12 19:57:48.000000000 -0800
@@ -7,3 +7,4 @@ obj-y := timer.o timer_none.o timer_tsc.
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
 obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
+obj-$(CONFIG_X86_VMI)           += timer_vmi.o
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer.c	2006-03-12 19:57:48.000000000 -0800
@@ -13,6 +13,9 @@
 #endif
 /* list of timers, ordered by preference, NULL terminated */
 static struct init_timer_opts* __initdata timers[] = {
+#ifdef CONFIG_X86_VMI
+	&timer_vmi_init,
+#endif
 #ifdef CONFIG_X86_CYCLONE_TIMER
 	&timer_cyclone_init,
 #endif
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_tsc.c	2006-03-12 19:57:42.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_tsc.c	2006-03-12 19:57:48.000000000 -0800
@@ -22,6 +22,7 @@
 
 #include "io_ports.h"
 #include "mach_timer.h"
+#include "mach_schedclock.h"
 
 #include <asm/hpet.h>
 #include <asm/i8253.h>
@@ -36,6 +37,7 @@ static inline void cpufreq_delayed_get(v
 
 int tsc_disable __devinitdata = 0;
 
+int use_sched_clock_cycles;
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
@@ -116,23 +118,17 @@ static unsigned long long monotonic_cloc
  */
 unsigned long long sched_clock(void)
 {
-	unsigned long long this_offset;
-
 	/*
 	 * In the NUMA case we dont use the TSC as they are not
 	 * synchronized across all CPUs.
 	 */
 #ifndef CONFIG_NUMA
-	if (!use_tsc)
+	if (!use_sched_clock_cycles)
 #endif
 		/* no locking but a rare wrong value is not a big deal */
 		return jiffies_64 * (1000000000 / HZ);
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
 	/* return the value in ns */
-	return cycles_2_ns(this_offset);
+	return cycles_2_ns(sched_clock_cycles());
 }
 
 static void delay_tsc(unsigned long loops)
@@ -510,6 +506,7 @@ static int __init init_tsc(char* overrid
 			init_xtime_from_cmos();
 			fast_gettimeoffset_quotient = tsc_quotient;
 			use_tsc = 1;
+			use_sched_clock_cycles = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_vmi.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_vmi.c	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_vmi.c	2006-03-12 19:57:48.000000000 -0800
@@ -0,0 +1,421 @@
+/*
+ * VMI timer support routines.
+ *
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
+ * Portions of this code from arch/i386/kernel/timers/timer_tsc.c.
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
+
+#include <asm/timer.h>
+#include <asm/io.h>
+#include <asm/apic.h>
+#include <asm/div64.h>
+
+#include <vmi_time.h>
+#include <mach_timer.h>
+#include <mach_apictimer.h>
+#include <mach_schedclock.h>
+#include <io_ports.h>
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#define VMI_ALARM_WIRING VMI_ALARM_WIRED_LVTT
+#else 
+#define VMI_ALARM_WIRING VMI_ALARM_WIRED_IRQ0
+#endif 
+
+/* Number of alarms per second. By default this is CONFIG_VMI_ALARM_HZ. */
+static int alarm_hz = CONFIG_VMI_ALARM_HZ; 
+
+/* Cache of the value vmi_get_cycle_frequency / HZ. */
+static signed long long cycles_per_jiffy;
+
+/* Cache of the value vmi_get_cycle_frequency / alarm_hz. */
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
+static unsigned long get_offset_vmi(void)
+{
+	unsigned long long cur_cycles;
+
+	cur_cycles = vmi_get_real_cycles();
+
+	/* real_cycles_accounted_system is safe to read because this 
+	 * routine is always called with at least the xtime_lock read lock. */
+	if (cur_cycles < real_cycles_accounted_system) {
+		return 0;
+	}
+	return cycles_2_us(cur_cycles - real_cycles_accounted_system);
+}
+
+static unsigned long long monotonic_clock_vmi(void)
+{
+	return cycles_2_ns(vmi_get_real_cycles());
+}
+
+static void delay_vmi(unsigned long loops)
+{
+#ifdef CONFIG_SMP
+	/* SMP needs a delay for smpboot.c. */
+	unsigned long bclock, now;
+	
+	bclock = (unsigned long)vmi_get_real_cycles();
+	do
+	{
+		rep_nop();
+		now = (unsigned long)vmi_get_real_cycles();
+	} while ((now-bclock) < loops);
+#endif
+	/* No delay on virtual hardware. */
+}
+
+static void mark_offset_vmi(void)
+{
+	/* Not used by vmi timer handler. */
+	BUG();
+}
+
+void __init setup_vmi_timer(void)
+{
+	/* Fall back to PIT timer -- for transparent para-virt. */
+	if (!vmi_timer_used())
+		setup_pit_timer();
+}
+
+static inline void update_xtime_from_wallclock(long long cycles_offset)
+{
+	unsigned long long wallclock;
+	time_t wtm_sec, wall_sec;
+	long wtm_nsec, wall_nsec;
+
+	wallclock = vmi_get_wallclock(); // nsec units
+
+	/* Adjust wallclock time to the value it would have had on the
+	 * last accounted xtime tick. */
+	if (cycles_offset > 0) 
+		wallclock -= cycles_2_ns(cycles_offset);
+
+	wall_nsec = do_div(wallclock, 1000000000);
+	wall_sec = wallclock;
+	
+	wtm_sec = wall_to_monotonic.tv_sec + (xtime.tv_sec - wall_sec);
+	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - wall_nsec);
+
+	xtime.tv_sec = wall_sec;
+	xtime.tv_nsec = wall_nsec;
+
+	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
+	ntp_clear();
+}
+
+static int __init vmi_alarm_rate_setup(char* str)
+{
+	int alarm_rate;
+	if (get_option(&str, &alarm_rate) == 1 && alarm_rate > 0) {
+		alarm_hz = alarm_rate;
+		printk(KERN_WARNING "VMI Timer alarm HZ set to %d\n", alarm_hz);
+	}
+	return 1;
+}
+__setup("vmi_alarm_hz=", vmi_alarm_rate_setup);
+
+void __init probe_vmi_timer(void)
+{
+	/*
+	 * Use frequency of 0 to indicate vmi timer is disabled. 
+	 */
+	if (vmi_get_cycle_frequency()) {
+		printk(KERN_WARNING "VMI Timer active.\n");
+		hypervisor_timer_found = 1;
+	}
+}
+
+static int __init init_vmi_timer(char* override)
+{
+	unsigned long long cycles_per_sec, cycles_per_usec, cycles_per_msec;
+
+	if (!vmi_timer_used()) 
+		return -ENODEV;
+
+	no_sync_cmos_timer = 1;
+	use_sched_clock_cycles = 1;
+
+	wall_to_monotonic.tv_sec = 0;
+	wall_to_monotonic.tv_nsec = 0;
+
+	real_cycles_accounted_system = vmi_get_real_cycles();
+	update_xtime_from_wallclock(0);
+	per_cpu(process_times_cycles_accounted_cpu, 0) = vmi_get_available_cycles();
+
+	cycles_per_sec = vmi_get_cycle_frequency();
+
+	cycles_per_jiffy = cycles_per_sec;
+	(void)do_div(cycles_per_jiffy, HZ);
+	cycles_per_alarm = cycles_per_sec;
+	(void)do_div(cycles_per_alarm, alarm_hz);
+	cycles_per_usec = cycles_per_sec;
+	(void)do_div(cycles_per_usec, 1000000);
+	cycles_per_msec = cycles_per_sec;
+	(void)do_div(cycles_per_msec, 1000);
+	cpu_khz = cycles_per_msec;
+
+	set_cyc_scales((unsigned long)cycles_per_usec);
+		
+	printk(KERN_WARNING "VMI Timer cycles/sec = %llu ; cycles/jiffy = %llu ;"
+	       "cycles/alarm = %llu", cycles_per_sec, cycles_per_jiffy, cycles_per_alarm);
+	
+	/* Disable PIT. */
+	outb_p(0x3a, PIT_MODE); /* binary, mode 5, LSB/MSB, ch 0 */
+
+	/* schedule the alarm. do this in phase with process_times_cycles_accounted_cpu
+	 * reduce the latency calling update_process_times. */
+	vmi_set_alarm(VMI_ALARM_WIRED_IRQ0 | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+		      per_cpu(process_times_cycles_accounted_cpu, 0) + cycles_per_alarm, 
+		      cycles_per_alarm);
+
+	/* this routine is called after setup_vmi_timer -- too late to 
+	 * fall back to the PIT for timer interrupts. */
+	if (override[0] && strncmp(override,"vmi",3))
+		printk(KERN_ERR "Warning: clock= override failed. Defaulting to vmi.\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+void __init setup_boot_vmi_alarm(void)
+{
+	if (vmi_timer_used()) {
+		/* Not really the apic timer, but from the apic's
+		 *  perspective, it looks like the apic timer... */
+		using_apic_timer = 1;
+
+		local_irq_disable();
+
+		apic_write_around(APIC_LVTT, LOCAL_TIMER_VECTOR);
+		/* Cancel the IRQ0 wired alarm, and setup the LVTT alarm. */
+		vmi_cancel_alarm(VMI_CYCLES_AVAILABLE);
+		vmi_set_alarm(VMI_ALARM_WIRED_LVTT | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+			      per_cpu(process_times_cycles_accounted_cpu, 0) + cycles_per_alarm,
+			      cycles_per_alarm);
+		local_irq_enable();
+	} else
+		/* Fall back to the local apic clock. */
+		setup_boot_APIC_clock();
+}
+
+/* Initialize the time accounting variables for an AP on an SMP system.
+ * Also, set the local alarm for the AP. */
+void __init setup_secondary_vmi_alarm(void)
+{
+	if (vmi_timer_used()) {
+		int cpu = smp_processor_id();
+	
+		/* Route the interrupt to the correct vector. */
+		apic_write_around(APIC_LVTT, LOCAL_TIMER_VECTOR);
+		
+		per_cpu(process_times_cycles_accounted_cpu, cpu) = vmi_get_available_cycles();
+		
+		vmi_set_alarm(VMI_ALARM_WIRED_LVTT | VMI_ALARM_IS_PERIODIC | VMI_CYCLES_AVAILABLE,
+			      per_cpu(process_times_cycles_accounted_cpu, cpu) + cycles_per_alarm, 
+			      cycles_per_alarm);
+	} else
+		/* Fall back to the local apic clock. */
+		setup_secondary_APIC_clock();
+}
+
+int __init vmi_timer_irq_works(void)
+{
+#ifdef CONFIG_X86_IO_APIC
+	if (vmi_timer_used())
+		return 1;
+	else
+		return timer_irq_works();
+#else
+	return 1;
+#endif
+}
+
+#endif
+
+/* Update system wide (real) time accounting (e.g. jiffies, xtime). */
+static inline void vmi_account_real_cycles(struct pt_regs *regs,
+					   unsigned long long cur_real_cycles)
+{
+	long long cycles_not_accounted;
+
+	write_seqlock(&xtime_lock);
+
+	cycles_not_accounted = cur_real_cycles - real_cycles_accounted_system;
+	while (cycles_not_accounted >= cycles_per_jiffy) {
+		/* systems wide jiffies and wallclock. */
+		do_timer(regs);
+		
+		cycles_not_accounted -= cycles_per_jiffy;
+		real_cycles_accounted_system += cycles_per_jiffy;
+	}
+	
+	if (vmi_wallclock_updated()) {
+		update_xtime_from_wallclock(cycles_not_accounted);
+		clock_was_set();
+	}
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
+		/* XXXPara: handle /proc/profile multiplier.  */
+		profile_tick(CPU_PROFILING, regs);
+
+		cycles_not_accounted -= cycles_per_jiffy;
+		per_cpu(process_times_cycles_accounted_cpu, cpu) += cycles_per_jiffy;
+	}
+}
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
+	account_cpu_steal_time(jiffies_to_cputime(stolen_jiffies));
+}
+
+/* Body of either IRQ0 interrupt handler (UP no local-APIC) or 
+ * local-APIC LVTT interrupt handler (UP & local-APIC or SMP). */
+static void vmi_local_timer_interrupt(struct pt_regs *regs, int cpu)
+{
+	unsigned long long cur_real_cycles, cur_process_times_cycles;
+
+	cur_real_cycles = vmi_get_real_cycles();
+	cur_process_times_cycles = vmi_get_available_cycles();
+	/* Update system wide (real) time state (xtime, jiffies). */
+	vmi_account_real_cycles(regs, cur_real_cycles);
+	/* Update per-cpu process times. */
+	vmi_account_process_times_cycles(regs, cpu, cur_process_times_cycles);
+        /* Update time stolen from this cpu by the hypervisor. */
+	vmi_account_stolen_cycles(cpu, cur_real_cycles, cur_process_times_cycles);
+}
+
+/* UP (and no local-APIC) VMI-timer alarm interrupt handler. 
+ * Handler for IRQ0. Not used when SMP or X86_LOCAL_APIC after
+ * APIC setup and setup_boot_vmi_alarm() is called.  */
+irqreturn_t vmi_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	vmi_local_timer_interrupt(regs, smp_processor_id());
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
+	/*
+	 * update_process_times() expects us to have done irq_enter().
+	 * Besides, if we don't timer interrupts ignore the global
+	 * interrupt lock, which is the WrongThing (tm) to do.
+	 */
+	irq_enter();
+
+	vmi_local_timer_interrupt(regs, cpu);
+
+	irq_exit();
+}
+
+#endif  /* CONFIG_X86_LOCAL_APIC */
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+static struct timer_opts timer_vmi = {
+	.name = "vmi",
+	.mark_offset = mark_offset_vmi,
+	.get_offset = get_offset_vmi,
+	.monotonic_clock = monotonic_clock_vmi,
+	.delay = delay_vmi,
+};
+
+struct init_timer_opts __initdata timer_vmi_init = {
+	.init = init_vmi_timer,
+	.opts = &timer_vmi,
+};
Index: linux-2.6.16-rc6/arch/i386/mach-vmi/setup.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/mach-vmi/setup.c	2006-03-12 19:57:36.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/mach-vmi/setup.c	2006-03-12 19:57:48.000000000 -0800
@@ -41,12 +41,16 @@
 #include <asm/pgtable.h>
 #include <vmi.h>
 
+extern irqreturn_t vmi_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern fastcall void apic_vmi_timer_interrupt(void);
+
 extern char __VMI_END;
 extern char __VMI_START;
 extern char __VMI_SHARED;
 VROMHeader *vmi_rom = NULL;
 
 VMI_UINT8 hypervisor_found;
+VMI_UINT8 hypervisor_timer_found;
 
 /* Convenient macro for calling VMI functions indirectly in the ROM */
 typedef VMI_UINT32 __attribute__((regparm(1))) (VROMFUNC)(void);
@@ -201,6 +205,11 @@ void __init intr_init_hook(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
 	apic_intr_init();
+
+	/* if the VMI-timer is used, redirect the local APIC timer interrupt
+	 * gate to point to the vmi interrupt handler. */
+	if (vmi_timer_used())
+		set_intr_gate(LOCAL_TIMER_VECTOR, apic_vmi_timer_interrupt);
 #endif
 
 	setup_irq(2, &irq2);
@@ -275,8 +284,10 @@ void __init vmi_init(void)
 		       " - falling back to native mode\n",
 		       VMI_API_REV_MAJOR, MIN_VMI_API_REV_MINOR);
 
-	if (hypervisor_found)
+	if (hypervisor_found) {
 		pm_power_off = vmi_power_off;
+		probe_vmi_timer();
+	}
 }
 
 
@@ -306,6 +317,8 @@ void __init trap_init_hook(void)
 
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
 
+static struct irqaction vmi_irq0  = { vmi_timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "VMI-alarm", NULL, NULL};
+
 /**
  * time_init_hook - do any specific initialisations for the system timer.
  *
@@ -315,5 +328,8 @@ static struct irqaction irq0  = { timer_
  **/
 void __init time_init_hook(void)
 {
-	setup_irq(0, &irq0);
+	if (vmi_timer_used())
+		setup_irq(0, &vmi_irq0);
+	else
+		setup_irq(0, &irq0);
 }
Index: linux-2.6.16-rc6/include/asm-i386/timer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/timer.h	2006-03-12 19:57:42.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/timer.h	2006-03-12 19:57:48.000000000 -0800
@@ -48,6 +48,8 @@ extern int pit_latch_buggy;
 extern struct timer_opts *cur_timer;
 extern int timer_ack;
 
+extern int use_sched_clock_cycles;
+
 /* list of externed timers */
 extern struct timer_opts timer_none;
 extern struct timer_opts timer_pit;
@@ -70,9 +72,18 @@ extern unsigned long calibrate_tsc_hpet(
 extern struct init_timer_opts timer_pmtmr_init;
 #endif
 
+#ifdef CONFIG_X86_VMI
+extern struct init_timer_opts timer_vmi_init;
+void setup_vmi_timer(void);
+#endif
+
 static inline void setup_system_timer(void) 
 {
+#ifdef CONFIG_X86_VMI
+	setup_vmi_timer();
+#else
 	setup_pit_timer();
+#endif
 }
 
 /* convert from cycles(64bits) => nanoseconds (64bits)
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_apictimer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/mach_apictimer.h	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_apictimer.h	2006-03-12 19:57:48.000000000 -0800
@@ -0,0 +1,58 @@
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
+ * Initiation routines related to the APIC timer.
+ */
+
+#ifndef __ASM_MACH_APICTIMER_H
+#define __ASM_MACH_APICTIMER_H
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+extern int using_apic_timer;
+
+extern void __init setup_boot_vmi_alarm(void);
+extern void __init setup_secondary_vmi_alarm(void);
+extern int __init vmi_timer_irq_works(void);
+extern int __init timer_irq_works(void);
+
+static inline void mach_setup_boot_local_clock(void)
+{
+	setup_boot_vmi_alarm();
+}
+
+static inline void mach_setup_secondary_local_clock(void)
+{
+	setup_secondary_vmi_alarm();
+}
+
+static inline int mach_timer_irq_works(void)
+{
+	return vmi_timer_irq_works();
+}
+
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+#endif /* __ASM_MACH_APICTIMER_H */
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_schedclock.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/mach_schedclock.h	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/mach_schedclock.h	2006-03-12 19:57:48.000000000 -0800
@@ -0,0 +1,43 @@
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
+ * Machine specific sched_clock routines.
+ */
+
+#ifndef __ASM_MACH_SCHEDCLOCK_H
+#define __ASM_MACH_SCHEDCLOCK_H
+
+#include <vmi_time.h>
+
+#if !defined(CONFIG_X86_VMI)
+# error invalid sub-arch include
+#endif
+
+static inline unsigned long long sched_clock_cycles(void)
+{
+	return vmi_get_available_cycles();
+}
+
+#endif /* __ASM_MACH_SCHEDCLOCK_H */
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/entry_arch.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/entry_arch.h	2006-03-12 19:57:32.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/entry_arch.h	2006-03-12 19:57:48.000000000 -0800
@@ -24,6 +24,7 @@ BUILD_INTERRUPT(call_function_interrupt,
  */
 #ifdef CONFIG_X86_LOCAL_APIC
 BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_INTERRUPT(apic_vmi_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
 
Index: linux-2.6.16-rc6/include/asm-i386/mach-vmi/vmi_time.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-vmi/vmi_time.h	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-vmi/vmi_time.h	2006-03-12 19:57:48.000000000 -0800
@@ -0,0 +1,142 @@
+//depot/Proj/monitor/opensource/triumph/paravirtual/linux/linux-2.6.16-rc1/include/asm-i386/mach-vmi/vmi_time.h#1 - add change 322982 (text)
+/*
+ * VMI Time wrappers
+ *
+ * Copyright (C) 2006, VMware, Inc.
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
+#ifndef __MACH_VMI_TIME_H
+#define __MACH_VMI_TIME_H
+
+#include "vmi.h"
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
+static inline VMI_CYCLES vmi_get_cycle_frequency(void)
+{
+	VMI_CYCLES ret;
+	vmi_wrap_call(
+		GetCycleFrequency, "xor %%eax, %%eax;"
+				   "xor %%edx, %%edx;",
+		VMI_OREG64 (ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+static inline VMI_CYCLES vmi_get_real_cycles(void)
+{
+	VMI_CYCLES ret;
+	vmi_wrap_call(
+		GetCycleCounter, "rdtsc",
+		VMI_OREG64 (ret),
+		1, VMI_IREG1(VMI_CYCLES_REAL),
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+static inline VMI_CYCLES vmi_get_available_cycles(void)
+{
+	VMI_CYCLES ret;
+	vmi_wrap_call(
+		GetCycleCounter, "rdtsc",
+		VMI_OREG64 (ret),
+		1, VMI_IREG1(VMI_CYCLES_AVAILABLE),
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+static inline VMI_CYCLES vmi_get_stolen_cycles(void)
+{
+	VMI_CYCLES ret;
+	vmi_wrap_call(
+		GetCycleCounter, "xor %%eax, %%eax;"
+				 "xor %%edx, %%edx;",
+		VMI_OREG64 (ret),
+		1, VMI_IREG1(VMI_CYCLES_STOLEN),
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+static inline VMI_UINT64 vmi_get_wallclock(void)
+{
+	VMI_UINT64 ret;
+	vmi_wrap_call(
+		GetWallclockTime, "xor %%eax, %%eax;"
+				  "xor %%edx, %%edx;",
+		VMI_OREG64 (ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+static inline VMI_BOOL vmi_wallclock_updated(void)
+{
+	VMI_BOOL ret;
+	vmi_wrap_call(
+		WallclockUpdated, "xor %%eax, %%eax;",
+		VMI_OREG1 (ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+static inline void vmi_set_alarm(VMI_UINT32 flags, VMI_CYCLES expiry, VMI_CYCLES period)
+{
+	vmi_wrap_call(
+		SetAlarm, "",
+		VMI_NO_OUTPUT,
+		5, XCONC(VMI_IREG1(flags),
+			 VMI_IREG2((VMI_UINT32)expiry), VMI_IREG3((VMI_UINT32)(expiry >> 32)),
+			 VMI_IREG4((VMI_UINT32)period), VMI_IREG5((VMI_UINT32)(period >> 32))),
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+static inline void vmi_cancel_alarm(VMI_UINT32 flags)
+{
+	vmi_wrap_call(
+		CancelAlarm, "",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1(flags),
+		VMI_CLOBBER(ONE_RETURN));
+}
+
+#endif
Index: linux-2.6.16-rc6/include/asm-i386/mach-default/mach_schedclock.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-default/mach_schedclock.h	2006-03-12 19:57:48.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-default/mach_schedclock.h	2006-03-12 19:57:48.000000000 -0800
@@ -0,0 +1,18 @@
+
+/*
+ * Machine specific sched_clock routines.
+ */
+
+#ifndef __ASM_MACH_SCHEDCLOCK_H
+#define __ASM_MACH_SCHEDCLOCK_H
+
+#include <mach_msr.h>
+
+static inline unsigned long long sched_clock_cycles(void)
+{
+	unsigned long long cycles;
+	rdtscll(cycles);
+	return cycles;
+}
+
+#endif /* __ASM_MACH_SCHEDCLOCK_H */
Index: linux-2.6.16-rc6/include/linux/kernel_stat.h
===================================================================
--- linux-2.6.16-rc6.orig/include/linux/kernel_stat.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/include/linux/kernel_stat.h	2006-03-12 19:57:48.000000000 -0800
@@ -55,5 +55,6 @@ static inline int kstat_irqs(int irq)
 extern void account_user_time(struct task_struct *, cputime_t);
 extern void account_system_time(struct task_struct *, int, cputime_t);
 extern void account_steal_time(struct task_struct *, cputime_t);
+extern void account_cpu_steal_time(cputime_t);
 
 #endif /* _LINUX_KERNEL_STAT_H */
Index: linux-2.6.16-rc6/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/sched.c	2006-03-12 19:49:58.000000000 -0800
+++ linux-2.6.16-rc6/kernel/sched.c	2006-03-12 19:57:48.000000000 -0800
@@ -2535,18 +2535,33 @@ void account_system_time(struct task_str
  */
 void account_steal_time(struct task_struct *p, cputime_t steal)
 {
-	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
-	cputime64_t tmp = cputime_to_cputime64(steal);
+	struct cpu_usage_stat *cpustat;
+	cputime64_t tmp;
 	runqueue_t *rq = this_rq();
 
 	if (p == rq->idle) {
+		cpustat = &kstat_this_cpu.cpustat;
+		tmp = cputime_to_cputime64(steal);
+		
 		p->stime = cputime_add(p->stime, steal);
 		if (atomic_read(&rq->nr_iowait) > 0)
 			cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 		else
 			cpustat->idle = cputime64_add(cpustat->idle, tmp);
 	} else
-		cpustat->steal = cputime64_add(cpustat->steal, tmp);
+		account_cpu_steal_time(steal);
+}
+
+/*
+ * Account for involuntary wait time for this cpu.
+ * @steal: the cpu time spent in involuntary wait
+ */
+void account_cpu_steal_time(cputime_t steal)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	cputime64_t tmp = cputime_to_cputime64(steal);
+
+	cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
 /*
