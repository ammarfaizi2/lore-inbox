Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTADAYU>; Fri, 3 Jan 2003 19:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTADAYT>; Fri, 3 Jan 2003 19:24:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8958 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267738AbTADAVM>;
	Fri, 3 Jan 2003 19:21:12 -0500
Message-ID: <3E162A8D.7BA28BA4@mvista.com>
Date: Fri, 03 Jan 2003 16:27:57 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 23
Content-Type: multipart/mixed;
 boundary="------------0073EC6479D1674740E75603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------0073EC6479D1674740E75603
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is the platform part of the high-res timers for the
x86.

Now for 2.5.54-bk1

Changes since last time:

Prior changes:
Changes to the .../arch/i386/kernel/time/Makefile
Moved the disable_tsc var to time.c so it can be shared.
Picked up the do_timer.h changes in two addional sub archs.

CONFIG dependency added to not turn on stuff only needed
when CONFIG_HIGH_RES = y.
----------

This patch, in conjunction with the "core" high-res-timers
patch implements high resolution timers on the i386
platforms.  The high-res-timers use the periodic interrupt
to "remind" the system to look at the clock.  The clock
should be relatively high resolution (1 micro second or
better).  This patch allows configuring of three possible
clocks, the TSC, the ACPI pm timer, or the Programmable
interrupt timer (PIT).  Most of the changes in this patch
are in the arch/i386/kernel/timer/* code.

This patch uses (if available) the APIC timer(s) to generate
1/HZ ticks and sub 1/HZ ticks as needed.  The PIT still
interrupts, but if the APIC timer is available, just causes
the wall clock update.  No attempt is made to make this
interrupt happen on jiffie boundaries, however, the APIC
timers are disciplined to expire on 1/HZ boundaries to give
consistent timer latencies WRT to the system time.

With this patch applied and enabled (at config time in the
processor feature section), the system clock will be the
specified clock.  The PIT is not used to keep track of time,
but only to remind the system to look at the clock.  Sub
jiffies are kept and available for code that knows how to
use them.

Depends on the core high res timers patch.

This patch as well as the POSIX clocks & timers patch is
available on the project site:
http://sourceforge.net/projects/high-res-timers/

The 3 parts to the high res timers are:
 core		The core kernel (i.e. platform independent) changes
*i386		The high-res changes for the i386 (x86) platform
 hrposix	The changes to the POSIX clocks & timers patch to
use high-res timers

Please apply.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------0073EC6479D1674740E75603
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-i386-2.5.54-bk1-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-i386-2.5.54-bk1-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2.5.54-bk1-core/arch/i386/Kconfig	Fri Jan  3 15:07:04 2003
+++ linux/arch/i386/Kconfig	Fri Jan  3 15:08:28 2003
@@ -393,6 +393,107 @@
 
 	  If you don't know what to do here, say N.
 
+config HIGH_RES_TIMERS
+	bool "Configure High-Resolution-Timers"
+	help
+	  POSIX timers are available by default.  This option enables
+	  high resolution POSIX timers.  With this option the resolution
+	  is at least 1 micro second.  High resolution is not free.  If
+	  enabled this option will add a small overhead each time a
+	  timer expires that is not on a 1/HZ tick boundry.  If no such
+	  timers are used the overhead is nil.
+
+	  This option enables two additional POSIX CLOCKS,
+	  CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR.  Note that this
+	  option does not change the resolution of CLOCK_REALTIME or
+	  CLOCK_MONOTONIC which remain at 1/HZ resolution.
+
+choice
+	prompt "Clock source?"
+	depends on HIGH_RES_TIMERS
+ 	default HIGH_RES_TIMER_TSC
+	help 
+	  This option allows you to choose the wall clock timer for your
+	  system.  With high resolution timers on the x86 platforms it
+	  is best to keep the interrupt generating timer separate from
+	  the time keeping timer.  On x86 platforms there are three
+	  possible sources implemented for the wall clock.  These are:
+ 
+  	  <timer>				<resolution>
+ 	  ACPI power management (pm) timer	~280 nano seconds
+  	  TSC (Time Stamp Counter)		1/CPU clock
+ 	  PIT (Programmable Interrupt Timer)	~838 nano seconds
+
+	  The PIT is always used to generate clock interrupts but, in
+	  SMP systems the APIC timers are used to drive the timer list
+	  code.  This means that, in SMP systems the PIT will not be
+	  programmed to generate sub jiffie events and can give
+	  reasonable service as the clock interrupt. In non SMP (UP)
+	  systems it will be programmed to interrupt when the next timer
+	  is to expire or on the next 1/HZ tick.  For this reason it is
+	  best to not use this timer as the wall clock timer in UP
+	  systems.  This timer has a resolution of 838 nano seconds.  IN
+	  UP SYSTEMS THIS OPTION SHOULD ONLY BE USED IF BOTH ACPI AND
+	  TSC ARE NOT AVAILABLE.
+
+	  The TSC runs at the cpu clock rate (i.e. its resolution is
+	  1/CPU clock) and it has a very low access time.  However, it
+	  is subject, in some (incorrect) processors, to throttling to
+	  cool the cpu, and to other slow downs during power management.
+	  If your system has power managment code active these changes
+	  are tracked by the TSC timer code.  If your cpu is correct and
+	  does not change the TSC frequency for throttling or power
+	  management outside of the power managment kernel code, this is
+	  the best clock timer.
+
+	  The ACPI pm timer is available on systems with Advanced
+	  Configuration and Power Interface support.  The pm timer is
+	  available on these systems even if you don't use or enable
+	  ACPI in the software or the BIOS (but see Default ACPI pm
+	  timer address).  The timer has a resolution of about 280
+	  nanoseconds, however, the access time is a bit higher than
+	  that of the TSC.  Since it is part of ACPI it is intended to
+	  keep track of time while the system is under power management,
+	  thus it is not subject to the power management problems of the
+	  TSC.
+
+	  If you enable the ACPI pm timer and it can not be found, it is
+	  possible that your BIOS is not producing the ACPI table or
+	  that your machine does not support ACPI.  In the former case,
+	  see "Default ACPI pm timer address".  If the timer is not
+	  found the boot will fail when trying to calibrate the 'delay'
+	  loop.
+
+config HIGH_RES_TIMER_ACPI_PM
+	bool "ACPI-pm-timer"
+	
+config HIGH_RES_TIMER_TSC
+	bool "Time-stamp-counter/TSC"
+	depends on X86_TSC
+
+config HIGH_RES_TIMER_PIT
+	bool "Programable-interrupt-timer/PIT"
+	  
+endchoice	  
+
+config HIGH_RES_TIMER_ACPI_PM_ADD
+	int "Default ACPI pm timer address"
+	depends on HIGH_RES_TIMER_ACPI_PM
+	default 0
+	help
+	  This option is available for use on systems where the BIOS
+	  does not generate the ACPI tables if ACPI is not enabled.  For
+	  example some BIOSes will not generate the ACPI tables if APM
+	  is enabled.  The ACPI pm timer is still available but can not
+	  be found by the software.  This option allows you to supply
+	  the needed address.  When the high resolution timers code
+	  finds a valid ACPI pm timer address it reports it in the boot
+	  messages log (look for lines that begin with
+	  "High-res-timers:").  You can turn on the ACPI support in the
+	  BIOS, boot the system and find this value.  You can then enter
+	  it at configure time.  Both the report and the entry are in
+	  decimal.
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/apic.c linux/arch/i386/kernel/apic.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/apic.c	Thu Jan  2 12:16:49 2003
+++ linux/arch/i386/kernel/apic.c	Fri Jan  3 15:08:32 2003
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/hrtime.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -786,7 +787,7 @@
  * P5 APIC double write bug.
  */
 
-#define APIC_DIVISOR 16
+#define APIC_DIVISOR 1
 
 void __setup_APIC_LVTT(unsigned int clocks)
 {
@@ -797,12 +798,12 @@
 	apic_write_around(APIC_LVTT, lvtt1_value);
 
 	/*
-	 * Divide PICLK by 16
+	 * Divide PICLK by 1
 	 */
 	tmp_value = apic_read(APIC_TDCR);
 	apic_write_around(APIC_TDCR, (tmp_value
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
-				| APIC_TDR_DIV_16);
+				| APIC_TDR_DIV_1);
 
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
@@ -900,7 +901,7 @@
 	return result;
 }
 
-static unsigned int calibration_result;
+static unsigned int calibration_result = 1000;
 
 int dont_use_local_apic_timer __initdata = 0;
 
@@ -921,6 +922,8 @@
 	 */
 	setup_APIC_timer(calibration_result);
 
+	compute_latch(calibration_result);
+
 	local_irq_enable();
 }
 
@@ -1011,6 +1014,8 @@
 			__setup_APIC_LVTT(calibration_result/prof_counter[cpu]);
 			prof_old_multiplier[cpu] = prof_counter[cpu];
 		}
+
+		discipline_timer(cpu);
 
 #ifdef CONFIG_SMP
 		update_process_times(user_mode(regs));
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/time.c	Fri Jan  3 15:07:33 2003
+++ linux/arch/i386/kernel/time.c	Fri Jan  3 15:08:32 2003
@@ -29,7 +29,10 @@
  *	Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
  *	serialize accesses to xtime/lost_ticks).
  */
-
+/* 2002-8-13 George Anzinger  Modified for High res timers: 
+ *                            Copyright (C) 2002 MontaVista Software
+*/
+#define _INCLUDED_FROM_TIME_C
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -60,6 +63,7 @@
 #include <linux/config.h>
 
 #include <asm/arch_hooks.h>
+#include <linux/hrtime.h>
 
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
@@ -73,7 +77,23 @@
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
+
+#ifndef CONFIG_HIGH_RES_TIMERS
+
+/* Number of usecs that the last interrupt was delayed */
+static int delay_at_last_interrupt;
+
+#endif  /* CONFIG_HIGH_RES_TIMERS */
+
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+/*
+ * We have three of these do_xxx_gettimeoffset() routines:
+ * do_fast_gettimeoffset(void) for TSC systems with out high-res-timers
+ * do_slow_gettimeoffset(void) for ~TSC systems with out high-res-timers
+ * do_highres__gettimeoffset(void) for systems with high-res-timers
+ *
+ * Pick the desired one at compile time...
+ */
 
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
@@ -92,16 +112,25 @@
 	read_lock_irqsave(&xtime_lock, flags);
 	usec = timer->get_offset();
 	{
+                /*
+                 * FIX ME***** Due to adjtime and such
+                 * this should be changed to actually update
+                 * wall time using the proper routine.
+                 * Otherwise we run the risk of time moving
+                 * backward due to different interpretations
+                 * of the jiffie.  I.e jiffie != 1/HZ
+                 * (but it is close).
+                 */
 		unsigned long lost = jiffies - wall_jiffies;
 		if (lost)
-			usec += lost * (1000000 / HZ);
+			usec += lost * (USEC_PER_SEC / HZ);
 	}
 	sec = xtime.tv_sec;
 	usec += (xtime.tv_nsec / 1000);
 	read_unlock_irqrestore(&xtime_lock, flags);
 
-	while (usec >= 1000000) {
-		usec -= 1000000;
+	while (usec >= USEC_PER_SEC) {
+		usec -= USEC_PER_SEC;
 		sec++;
 	}
 
@@ -213,7 +242,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -233,36 +262,29 @@
 
 	do_timer_interrupt_hook(regs);
 
-	/*
+        /* 
+         * This is dumb for two reasons.  
+         * 1.) it is based on wall time which has not yet been updated.
+         * 2.) it is checked each tick for something that happens each
+         *     10 min.  Why not use a timer for it?  Much lower overhead,
+         *     in fact, zero if STA_UNSYNC is set.
+         */
+        /*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
+	    (xtime.tv_nsec ) >= 500000000 - ((unsigned) tick_nsec) / 2 &&
+	    (xtime.tv_nsec ) <= 500000000 + ((unsigned) tick_nsec) / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
-			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
+                        /* do it again in 60 s */	
+			last_rtc_update = xtime.tv_sec - 600; 
 	}
 	    
-#ifdef CONFIG_MCA
-	if( MCA_bus ) {
-		/* The PS/2 uses level-triggered interrupts.  You can't
-		turn them off, nor would you want to (any attempt to
-		enable edge-triggered interrupts usually gets intercepted by a
-		special hardware circuit).  Hence we have to acknowledge
-		the timer interrupt.  Through some incredibly stupid
-		design idea, the reset for IRQ 0 is done by setting the
-		high bit of the PPI port B (0x61).  Note that some PS/2s,
-		notably the 55SX, work fine if this is removed.  */
-
-		irq = inb_p( 0x61 );	/* read the current state */
-		outb_p( irq|0x80, 0x61 );	/* reset the IRQ */
-	}
-#endif
 }
 
 /*
@@ -279,16 +301,66 @@
 	 * the irq version of write_lock because as just said we have irq
 	 * locally disabled. -arca
 	 */
+	discipline_timer(smp_processor_id());
 	write_lock(&xtime_lock);
 
 	timer->mark_offset();
  
-	do_timer_interrupt(irq, NULL, regs);
+	do_timer_interrupt(irq, regs);
 
 	write_unlock(&xtime_lock);
 
 }
+#ifdef CONFIG_HIGH_RES_TIMERS
+/*
 
+ * We always continue to provide interrupts even if they are not
+ * serviced.  To do this, we leave the chip in periodic mode programmed
+ * to interrupt every jiffie.  This is done by, for short intervals,
+ * programming a short time, waiting till it is loaded and then
+ * programming the 1/HZ.  The chip will not load the 1/HZ count till the
+ * short count expires.  If the last interrupt was programmed to be
+ * short, we need to program another short to cover the remaining part
+ * of the jiffie and can then just leave the chip alone.  Note that it
+ * is also a low overhead way of doing things as we do not have to mess
+ * with the chip MOST of the time. 
+ 
+  */
+
+int _schedule_next_int(unsigned long jiffie_f,long sub_jiffie_in, int always)
+{
+        long sub_jiff_offset; 
+	int * last_was_long = &__last_was_long;
+	if ((sub_jiffie_in == -1) && *last_was_long) return 0;
+        /* 
+         * First figure where we are in time. 
+         * A note on locking.  We are under the timerlist_lock here.  This
+         * means that interrupts are off already, so don't use irq versions.
+         */
+        IF_SMP( read_lock(&xtime_lock));
+
+        sub_jiff_offset = quick_update_jiffies_sub(jiffie_f);
+
+        IF_SMP( read_unlock(&xtime_lock));
+
+
+        if (( *last_was_long = (sub_jiffie_in == -1 ))) {
+
+                sub_jiff_offset = cycles_per_jiffies - sub_jiff_offset;
+        }else{
+		sub_jiff_offset = sub_jiffie_in - sub_jiff_offset;
+        }
+        /*
+         * If time is already passed, just return saying so.
+         */
+        if (! always && (sub_jiff_offset < 0)){
+                *last_was_long = 0;
+                return 1;
+        }
+        reload_timer_chip(sub_jiff_offset);
+        return 0;
+}
+#endif
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
@@ -353,6 +425,7 @@
 	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
+        IF_HIGH_RES(tick_nsec = NSEC_PER_SEC / HZ);
 
 
 	timer = select_timer();
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/Makefile linux/arch/i386/kernel/timers/Makefile
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/Makefile	Thu Jan  2 12:16:49 2003
+++ linux/arch/i386/kernel/timers/Makefile	Fri Jan  3 15:08:32 2003
@@ -1,7 +1,14 @@
 #
 # Makefile for x86 timers
 #
+obj-y := timer.o 
 
-obj-y := timer.o timer_tsc.o timer_pit.o
+ifndef CONFIG_HIGH_RES_TIMERS
+obj-y += timer_tsc.o timer_pit.o
+endif
 
 obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
+obj-$(CONFIG_HIGH_RES_TIMER_ACPI_PM) += hrtimer_pm.o
+obj-$(CONFIG_HIGH_RES_TIMER_ACPI_PM) += high-res-tbxfroot.o
+obj-$(CONFIG_HIGH_RES_TIMER_TSC) += hrtimer_tsc.o
+obj-$(CONFIG_HIGH_RES_TIMER_PIT) += hrtimer_pit.o
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/high-res-tbxfroot.c linux/arch/i386/kernel/timers/high-res-tbxfroot.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/high-res-tbxfroot.c	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/timers/high-res-tbxfroot.c	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,263 @@
+/******************************************************************************
+ *
+ * Module Name: tbxfroot - Find the root ACPI table (RSDT)
+ *              $Revision: 49 $
+ *
+ *****************************************************************************/
+
+/*
+ *  Copyright (C) 2000, 2001 R. Byron Moore
+
+ *  This code purloined and modified by George Anzinger
+ *                          Copyright (C) 2002 by MontaVista Software.
+ *  It is part of the high-res-timers ACPI option and its sole purpose is
+ *  to find the darn timer.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/* This is most annoying!  We want to find the address of the pm timer in the
+ * ACPI hardware package.  We know there is one if ACPI is available at all 
+ * as it is part of the basic ACPI hardware set. 
+ * However, the powers that be have conspired to make it a real
+ * pain to find the address.  We have written a minimal search routine
+ * that we use only once on boot up.  We try to cover all the bases including
+ * checksum, and version.  We will try to get some constants and structures
+ * from the ACPI code in an attempt to follow it, but darn, what a mess.
+ *
+ * First problem, the include files are in the driver package....
+ * and what a mess they are.  We pick up the kernel string and types first.
+
+ * But then there is the COMPILER_DEPENDENT_UINT64 ...
+ */
+#define ACPI_MACHINE_WIDTH	BITS_PER_LONG
+#define COMPILER_DEPENDENT_UINT64   unsigned long long
+#define COMPILER_DEPENDENT_INT64   long long
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <../drivers/acpi/include/actypes.h>
+#include <../drivers/acpi/include/actbl.h>
+#include <../drivers/acpi/include/acconfig.h>
+#include <linux/init.h>
+#include <asm/page.h>
+
+#define STRNCMP(d,s,n)  strncmp((d), (s), (NATIVE_INT)(n))
+#define RSDP_CHECKSUM_LENGTH 20
+
+#ifndef CONFIG_ACPI
+/*******************************************************************************
+ *
+ * FUNCTION:    hrt_acpi_checksum
+ *
+ * PARAMETERS:  Buffer              - Buffer to checksum
+ *              Length              - Size of the buffer
+ *
+ * RETURNS      8 bit checksum of buffer
+ *
+ * DESCRIPTION: Computes an 8 bit checksum of the buffer(length) and returns it.
+ *
+ ******************************************************************************/
+static __init u8
+hrt_acpi_checksum(void *buffer, u32 length)
+{
+	u8 *limit;
+	u8 *rover;
+	u8 sum = 0;
+
+	if (buffer && length) {
+		/*  Buffer and Length are valid   */
+
+		limit = (u8 *) buffer + length;
+
+		for (rover = buffer; rover < limit; rover++) {
+			sum = (u8) (sum + *rover);
+		}
+	}
+
+	return (sum);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    hrt_acpi_scan_memory_for_rsdp
+ *
+ * PARAMETERS:  Start_address       - Starting pointer for search
+ *              Length              - Maximum length to search
+ *
+ * RETURN:      Pointer to the RSDP if found, otherwise NULL.
+ *
+ * DESCRIPTION: Search a block of memory for the RSDP signature
+ *
+ ******************************************************************************/
+static __init u8 *
+hrt_acpi_scan_memory_for_rsdp(u8 * start_address, u32 length)
+{
+	u32 offset;
+	u8 *mem_rover;
+
+	/* Search from given start addr for the requested length  */
+
+	for (offset = 0, mem_rover = start_address;
+	     offset < length;
+	     offset += RSDP_SCAN_STEP, mem_rover += RSDP_SCAN_STEP) {
+
+		/* The signature and checksum must both be correct */
+
+		if (STRNCMP((NATIVE_CHAR *) mem_rover,
+			    RSDP_SIG, sizeof (RSDP_SIG) - 1) == 0 &&
+		    hrt_acpi_checksum(mem_rover, RSDP_CHECKSUM_LENGTH) == 0) {
+			/* If so, we have found the RSDP */
+
+			;
+			return (mem_rover);
+		}
+	}
+
+	/* Searched entire block, no RSDP was found */
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    hrt_acpi_find_rsdp
+ *
+ * PARAMETERS: 
+ *
+ * RETURN:      Logical address of rsdp
+ *
+ * DESCRIPTION: Search lower 1_mbyte of memory for the root system descriptor
+ *              pointer structure.  If it is found, return its address,
+ *              else return 0.
+ *
+ *              NOTE: The RSDP must be either in the first 1_k of the Extended
+ *              BIOS Data Area or between E0000 and FFFFF (ACPI 1.0 section
+ *              5.2.2; assertion #421).
+ *
+ ******************************************************************************/
+/* Constants used in searching for the RSDP in low memory */
+
+#define LO_RSDP_WINDOW_BASE         0	/* Physical Address */
+#define HI_RSDP_WINDOW_BASE         0xE0000	/* Physical Address */
+#define LO_RSDP_WINDOW_SIZE         0x400
+#define HI_RSDP_WINDOW_SIZE         0x20000
+#define RSDP_SCAN_STEP              16
+
+static __init RSDP_DESCRIPTOR *
+hrt_find_acpi_rsdp(void)
+{
+	u8 *mem_rover;
+
+	/*
+	 * 1) Search EBDA (low memory) paragraphs
+	 */
+	mem_rover =
+	    hrt_acpi_scan_memory_for_rsdp((u8 *) __va(LO_RSDP_WINDOW_BASE),
+					  LO_RSDP_WINDOW_SIZE);
+
+	if (!mem_rover) {
+		/*
+		 * 2) Search upper memory: 
+		 *    16-byte boundaries in E0000h-F0000h
+		 */
+		mem_rover =
+		    hrt_acpi_scan_memory_for_rsdp((u8 *)
+						  __va(HI_RSDP_WINDOW_BASE),
+						  HI_RSDP_WINDOW_SIZE);
+	}
+
+	if (mem_rover) {
+		/* Found it, return the logical address */
+
+		return (RSDP_DESCRIPTOR *) mem_rover;
+	}
+	return (RSDP_DESCRIPTOR *) 0;
+}
+
+__init u32 hrt_get_acpi_pm_ptr(void)
+{
+	fadt_descriptor_rev2 *fadt;
+	RSDT_DESCRIPTOR_REV2 *rsdt;
+	XSDT_DESCRIPTOR_REV2 *xsdt;
+	RSDP_DESCRIPTOR *rsdp = hrt_find_acpi_rsdp();
+
+	if (!rsdp) {
+		printk("ACPI: System description tables not found\n");
+		return 0;
+	}
+	/*
+	 * Now that we have that problem out of the way, lets set up this
+	 * timer.  We need to figure the addresses based on the revision
+	 * of ACPI, which is in this here table we just found.
+	 * We will not check the RSDT checksum, but will the FADT.
+	 */
+	if (rsdp->revision == 2) {
+		xsdt =
+		    (XSDT_DESCRIPTOR_REV2 *) __va(rsdp->xsdt_physical_address);
+		fadt =
+		    (fadt_descriptor_rev2 *) __va(xsdt->table_offset_entry[0]);
+	} else {
+		rsdt =
+		    (RSDT_DESCRIPTOR_REV2 *) __va(rsdp->rsdt_physical_address);
+		fadt =
+		    (fadt_descriptor_rev2 *) __va(rsdt->table_offset_entry[0]);
+	}
+	/*
+	 * Verify the signature and the checksum
+	 */
+	if (STRNCMP((NATIVE_CHAR *) fadt->header.signature,
+		    FADT_SIG, sizeof (FADT_SIG) - 1) == 0 &&
+	    hrt_acpi_checksum((NATIVE_CHAR *) fadt, fadt->header.length) == 0) {
+		/*
+		 * looks good.  Again, based on revision,
+		 * pluck the addresses we want and get out.
+		 */
+		if (rsdp->revision == 2) {
+			return (u32) fadt->Xpm_tmr_blk.address;
+		} else {
+			return (u32) fadt->V1_pm_tmr_blk;
+		}
+	}
+	printk("ACPI: Signature or checksum failed on FADT\n");
+	return 0;
+}
+
+#else
+int acpi_get_firmware_table(acpi_string signature,
+			    u32 instance,
+			    u32 flags, acpi_table_header ** table_pointer);
+
+extern fadt_descriptor_rev2 acpi_fadt;
+__init u32 hrt_get_acpi_pm_ptr(void)
+{
+	fadt_descriptor_rev2 *fadt = &acpi_fadt;
+	fadt_descriptor_rev2 local_fadt;
+
+	if (!fadt || !fadt->header.signature[0]) {
+		fadt = &local_fadt;
+		acpi_get_firmware_table("FACP", 1, 0,
+					(acpi_table_header **) & fadt);
+	}
+	if (!fadt || !fadt->header.signature[0]) {
+		printk("ACPI: Could not find the ACPI pm timer.");
+	}
+
+	if (fadt->header.revision == 2) {
+		return (u32) fadt->Xpm_tmr_blk.address;
+	} else {
+		return (u32) fadt->V1_pm_tmr_blk;
+	}
+}
+#endif
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/hrtimer_pit.c linux/arch/i386/kernel/timers/hrtimer_pit.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/hrtimer_pit.c	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/timers/hrtimer_pit.c	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,165 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
+#include <linux/cpufreq.h>
+#include <linux/hrtime.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+
+
+
+/* Cached *multiplier* to convert TSC counts to microseconds.
+ * (see the equation below).
+ * Equal to 2^32 * (1 / (clocks per usec) ).
+ * Initialized in time_init.
+ */
+extern unsigned long fast_gettimeoffset_quotient;
+
+extern unsigned long do_highres_gettimeoffset_pit(void)
+{
+        /*
+         * We are under the xtime_lock here.
+         */
+        long tmp = quick_get_cpuctr();
+        long rtn = arch_cycles_to_usec(tmp + sub_jiffie());
+	return rtn;
+}
+
+static void high_res_mark_offset_pit(void)
+{
+	return;
+}
+
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CAL_JIFS 5
+#define CALIBRATE_LATCH	(((CAL_JIFS * CLOCK_TICK_RATE) + HZ/2)/HZ)
+#define CALIBRATE_TIME	((CAL_JIFS * USEC_PER_SEC)/HZ)
+#define CALIBRATE_TIME_NSEC (CAL_JIFS * (NSEC_PER_SEC/HZ))
+
+
+static unsigned long __init calibrate_tsc(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 */
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+                /*
+                 * endlow at this point is CAL_JIFS * arch clocks
+                 * per jiffie.  Set up the value for 
+                 * high_res use. Note: keep the whole
+                 * value for now, we will do
+                 * the divide later (want that precision).
+                 */
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+        printk("******************** TSC calibrate failed!\n");
+	return 0;
+}
+
+
+
+#include <asm/kgdb.h>
+
+static int high_res_init_pit(void)
+{
+
+	//breakpoint();
+
+
+	/* report CPU clock rate in Hz.
+	 * The formula is:
+	 * (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+	 * clock/second. Our precision is about 100 ppm.
+	 */
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if(tsc_quotient){
+			fast_gettimeoffset_quotient = tsc_quotient;
+			cpu_khz = div_sc32( 1000, tsc_quotient);
+			{	
+				printk("Detected %lu.%03lu MHz processor.\n", 
+				       cpu_khz / 1000, cpu_khz % 1000);
+			}
+		}
+	}
+	start_PIT();
+	return 0;
+}
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+struct timer_opts hrtimer_pit = {
+	.init =		high_res_init_pit,
+	.mark_offset =	high_res_mark_offset_pit, 
+	.get_offset =	do_highres_gettimeoffset_pit,
+};
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/hrtimer_pm.c linux/arch/i386/kernel/timers/hrtimer_pm.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/hrtimer_pm.c	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/timers/hrtimer_pm.c	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,198 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
+#include <linux/cpufreq.h>
+#include <linux/hrtime.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+
+
+
+/* Cached *multiplier* to convert TSC counts to microseconds.
+ * (see the equation below).
+ * Equal to 2^32 * (1 / (clocks per usec) ).
+ * Initialized in time_init.
+ */
+extern unsigned long fast_gettimeoffset_quotient;
+
+extern unsigned long do_highres_gettimeoffset_pm(void)
+{
+        /*
+         * We are under the xtime_lock here.
+         */
+        long tmp = quick_get_cpuctr();
+        long rtn = arch_cycles_to_usec(tmp + sub_jiffie());
+	return rtn;
+}
+
+static void high_res_mark_offset_pm(void)
+{
+	return;
+}
+
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CAL_JIFS 5
+#define CALIBRATE_LATCH	(((CAL_JIFS * CLOCK_TICK_RATE) + HZ/2)/HZ)
+#define CALIBRATE_TIME	((CAL_JIFS * USEC_PER_SEC)/HZ)
+#define CALIBRATE_TIME_NSEC (CAL_JIFS * (NSEC_PER_SEC/HZ))
+
+static __initdata unsigned long tsc_cycles_per_5_jiffies;
+
+static unsigned long __init calibrate_tsc(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 */
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+                /*
+                 * endlow at this point is CAL_JIFS * arch clocks
+                 * per jiffie.  Set up the value for 
+                 * high_res use. Note: keep the whole
+                 * value for now, we will do
+                 * the divide later (want that precision).
+                 */
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+        printk("******************** TSC calibrate failed!\n");
+	return 0;
+}
+
+
+static inline __init void hrt_udelay(int usec)
+{
+        long now,end;
+        rdtscl(end);
+        end += (usec * tsc_cycles_per_5_jiffies) / (USEC_PER_JIFFIES * 5);
+        do {rdtscl(now);} while((end - now) > 0);
+
+}
+
+
+
+static int high_res_init_pm(void)
+{
+
+
+	/* report CPU clock rate in Hz.
+	 * The formula is:
+	 * (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+	 * clock/second. Our precision is about 100 ppm.
+	 */
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if(tsc_quotient){
+			fast_gettimeoffset_quotient = tsc_quotient;
+			cpu_khz = div_sc32( 1000, tsc_quotient);
+			{	
+				printk("Detected %lu.%03lu MHz processor.\n", 
+				       cpu_khz / 1000, cpu_khz % 1000);
+			}
+		}
+	}
+	start_PIT();
+        acpi_pm_tmr_address = hrt_get_acpi_pm_ptr(); 
+        if (!acpi_pm_tmr_address){                    
+                printk(message,default_pm_add);
+                if ( (acpi_pm_tmr_address = default_pm_add)){
+                        last_update +=  quick_get_cpuctr();
+                        hrt_udelay(4);
+			if (!quick_get_cpuctr()){
+                                printk("High-res-timers: No ACPI pm timer found at %d.\n",
+                                       acpi_pm_tmr_address);
+                                acpi_pm_tmr_address = 0;
+                        } 
+                } 
+        }else{
+                if (default_pm_add != acpi_pm_tmr_address) {
+                        printk("High-res-timers: Ignoring supplied default ACPI pm timer address.\n"); 
+                }
+                last_update +=  quick_get_cpuctr();
+        }
+        if (!acpi_pm_tmr_address){
+                printk(fail_message);
+		return -EINVAL;
+        }else{
+                printk("High-res-timers: Found ACPI pm timer at %d\n",
+                       acpi_pm_tmr_address);
+        }
+	return 0;
+}
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+struct timer_opts hrtimer_pm = {
+	.init =		high_res_init_pm,
+	.mark_offset =	high_res_mark_offset_pm, 
+	.get_offset =	do_highres_gettimeoffset_pm,
+};
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/hrtimer_tsc.c linux/arch/i386/kernel/timers/hrtimer_tsc.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/hrtimer_tsc.c	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/timers/hrtimer_tsc.c	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,289 @@
+/*
+ * This code largely moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
+#include <linux/cpufreq.h>
+#include <linux/hrtime.h>
+
+#include <asm/timer.h>
+#include <asm/io.h>
+
+extern int x86_udelay_tsc;
+extern spinlock_t i8253_lock;
+
+
+
+/* Cached *multiplier* to convert TSC counts to microseconds.
+ * (see the equation below).
+ * Equal to 2^32 * (1 / (clocks per usec) ).
+ * Initialized in time_init.
+ */
+extern unsigned long fast_gettimeoffset_quotient;
+
+static unsigned long do_highres_gettimeoffset(void)
+{
+        /*
+         * We are under the xtime_lock here.
+         */
+        long tmp = quick_get_cpuctr();
+        long rtn = arch_cycles_to_usec(tmp + sub_jiffie());
+	return rtn;
+}
+
+static void high_res_mark_offset_tsc(void)
+{
+	return;
+}
+
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CAL_JIFS 5
+#define CALIBRATE_LATCH	(((CAL_JIFS * CLOCK_TICK_RATE) + HZ/2)/HZ)
+#define CALIBRATE_TIME	((CAL_JIFS * USEC_PER_SEC)/HZ)
+#define CALIBRATE_TIME_NSEC (CAL_JIFS * (NSEC_PER_SEC/HZ))
+
+static __initdata unsigned long tsc_cycles_per_5_jiffies;
+
+static unsigned long __init calibrate_tsc(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 */
+	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+                /*
+                 * endlow at this point is CAL_JIFS * arch clocks
+                 * per jiffie.  Set up the value for 
+                 * high_res use. Note: keep the whole
+                 * value for now, we will do
+                 * the divide later (want that precision).
+                 */
+                tsc_cycles_per_5_jiffies = endlow;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+        printk("******************** TSC calibrate failed!\n");
+	return 0;
+}
+
+
+#ifdef CONFIG_CPU_FREQ
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+		       void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	unsigned int i;
+
+	if (!cpu_has_tsc)
+		return 0;
+
+	if((val == CPUFREQ_PRECHANGE && (freq->old < freq->new)) ||
+	   (val == CPUFREQ_POSTCHANGE && (freq->old > freq->new))){
+		if((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)){
+
+			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
+
+		        arch_to_usec = 
+				fast_gettimeoffset_quotient = 
+				cpufreq_scale(fast_gettimeoffset_quotient, 
+					      freq->new, freq->old);
+			arch_to_latch = 
+				cpufreq_scale(arch_to_latch, 
+					      freq->new, freq->old);
+			arch_to_nsec =
+				cpufreq_scale(arch_to_nsec, 
+					      freq->new, freq->old);
+			nsec_to_arch =
+				cpufreq_scale(nsec_to_arch, 
+					      freq->old, freq->new);
+			usec_to_arch =
+				cpufreq_scale(usec_to_arch, 
+					      freq->old, freq->new);
+			cycles_per_jiffies =
+				cpufreq_scale(cycles_per_jiffies, 
+					      freq->old, freq->new);
+		}
+		for (i=0; i<NR_CPUS; i++)
+			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
+				cpu_data[i].loops_per_jiffy = 
+					cpufreq_scale(
+						cpu_data[i].loops_per_jiffy, 
+						freq->old, freq->new);
+	}
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	notifier_call:	time_cpufreq_notifier
+};
+#endif
+
+
+static int high_res_init_tsc(void)
+{
+	/*
+	 * If we have APM enabled or the CPU clock speed is variable
+	 * (CPU stops clock on HLT or slows clock to save power)
+	 * then the TSC timestamps may diverge by up to 1 jiffy from
+	 * 'real time' but nothing will break.
+	 * The most frequent case is that the CPU is "woken" from a halt
+	 * state by the timer interrupt itself, so we get 0 error. In the
+	 * rare cases where a driver would "wake" the CPU and request a
+	 * timestamp, the maximum error is < 1 jiffy. But timestamps are
+	 * still perfectly ordered.
+	 * Note that the TSC counter will be reset if APM suspends
+	 * to disk; this won't break the kernel, though, 'cuz we're
+	 * smart.  See arch/i386/kernel/apm.c.
+	 */
+ 	/*
+ 	 *	Firstly we have to do a CPU check for chips with
+ 	 * 	a potentially buggy TSC. At this point we haven't run
+ 	 *	the ident/bugs checks so we must run this hook as it
+ 	 *	may turn off the TSC flag.
+ 	 *
+ 	 *	NOTE: this doesnt yet handle SMP 486 machines where only
+ 	 *	some CPU's have a TSC. Thats never worked and nobody has
+ 	 *	moaned if you have the only one in the world - you fix it!
+ 	 */
+ 
+ 	dodgy_tsc();
+ 	
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			fast_gettimeoffset_quotient = tsc_quotient;
+			/*
+			 *	We could be more selective here I suspect
+			 *	and just enable this for the next intel chips ?
+			 */
+			x86_udelay_tsc = 1;
+
+                        /*
+                         * Kick off the high res timers
+                         */
+			/*
+			 * The init_hrtimers macro is in the choosen
+			 * support package depending on the clock
+			 *  source, PIT, TSC, or ACPI pm timer.
+			 */
+			arch_to_usec = fast_gettimeoffset_quotient;
+ 
+			arch_to_latch = div_ll_X_l(
+				mpy_l_X_l_ll(fast_gettimeoffset_quotient,
+					     CLOCK_TICK_RATE),
+				(USEC_PER_SEC));
+
+			arch_to_nsec = div_sc_n(HR_TIME_SCALE_NSEC,
+						CALIBRATE_TIME * NSEC_PER_USEC,
+						tsc_cycles_per_5_jiffies);
+
+			nsec_to_arch = div_sc_n(HR_TIME_SCALE_NSEC,
+						tsc_cycles_per_5_jiffies,
+						CALIBRATE_TIME * NSEC_PER_USEC);
+
+			usec_to_arch = div_sc_n(HR_TIME_SCALE_USEC,
+						tsc_cycles_per_5_jiffies,
+						CALIBRATE_TIME );
+
+			cycles_per_jiffies = tsc_cycles_per_5_jiffies / 
+				CAL_JIFS;  
+
+			start_PIT();
+
+			/* report CPU clock rate in Hz.
+			 * The formula is:
+			 * (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			cpu_khz = div_sc32( 1000, tsc_quotient);
+			{	
+				printk("Detected %lu.%03lu MHz processor.\n", 
+				       cpu_khz / 1000, cpu_khz % 1000);
+			}
+#ifdef CONFIG_CPU_FREQ
+			cpufreq_register_notifier(&time_cpufreq_notifier_block,
+						  CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
+/************************************************************/
+
+/* tsc timer_opts struct */
+struct timer_opts hrtimer_tsc = {
+	.init =		high_res_init_tsc,
+	.mark_offset =	high_res_mark_offset_tsc, 
+	.get_offset =	do_highres_gettimeoffset,
+};
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/timer.c linux/arch/i386/kernel/timers/timer.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/timer.c	Thu Jan  2 12:16:49 2003
+++ linux/arch/i386/kernel/timers/timer.c	Fri Jan  3 15:08:32 2003
@@ -1,14 +1,36 @@
 #include <linux/kernel.h>
+#include <linux/hrtime.h>
 #include <asm/timer.h>
+/* processor.h for disable_tsc flag */
+#include <asm/processor.h>
+#include <linux/init.h>
+/*
+ * export these here so it can be used by more than one clock source
+ */
+unsigned long fast_gettimeoffset_quotient;
+int tsc_disable __initdata = 0;
 
 /* list of externed timers */
 extern struct timer_opts timer_pit;
 extern struct timer_opts timer_tsc;
+extern struct timer_opts hrtimer_tsc;
+extern struct timer_opts hrtimer_pm;
+extern struct timer_opts hrtimer_pit;
 
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
+#ifdef CONFIG_HIGH_RES_TIMERS
+#ifdef CONFIG_HIGH_RES_TIMER_ACPI_PM
+	&hrtimer_pm,
+#elif  CONFIG_HIGH_RES_TIMER_TSC
+	&hrtimer_tsc,
+#elif  CONFIG_HIGH_RES_TIMER_PIT
+	&hrtimer_pit,
+#endif
+#else
 	&timer_tsc,
 	&timer_pit,
+#endif
 	NULL,
 };
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/timer_pit.c linux/arch/i386/kernel/timers/timer_pit.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/timer_pit.c	Thu Jan  2 12:16:49 2003
+++ linux/arch/i386/kernel/timers/timer_pit.c	Fri Jan  3 15:08:32 2003
@@ -11,6 +11,7 @@
 #include <asm/timer.h>
 #include <asm/smp.h>
 #include <asm/io.h>
+#include <linux/hrtime.h>
 #include <asm/arch_hooks.h>
 
 extern spinlock_t i8259A_lock;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/arch/i386/kernel/timers/timer_tsc.c linux/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.54-bk1-core/arch/i386/kernel/timers/timer_tsc.c	Thu Jan  2 12:16:49 2003
+++ linux/arch/i386/kernel/timers/timer_tsc.c	Fri Jan  3 15:08:32 2003
@@ -14,7 +14,7 @@
 /* processor.h for distable_tsc flag */
 #include <asm/processor.h>
 
-int tsc_disable __initdata = 0;
+extern int tsc_disable;
 
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
@@ -30,7 +30,7 @@
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+extern unsigned long fast_gettimeoffset_quotient;
 
 static unsigned long get_offset_tsc(void)
 {
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/hrtime-M386.h linux/include/asm-i386/hrtime-M386.h
--- linux-2.5.54-bk1-core/include/asm-i386/hrtime-M386.h	Wed Dec 31 16:00:00 1969
+++ linux/include/asm-i386/hrtime-M386.h	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,272 @@
+/*
+ *
+ * File: include/asm-i386/hrtime-M386.h
+ * Copyright (C) 1999 by the University of Kansas Center for Research, Inc.
+ * Copyright (C) 2001 by MontaVista Software.
+ *
+ * This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ * 
+ * Authors: Balaji S., Raghavan Menon
+ *	    Furquan Ansari, Jason Keimig, Apurva Sheth
+ *
+ * Thanx to Michael Barabanov for helping me with the non-pentium code.
+ *
+ * Please send bug-reports/suggestions/comments to utime@ittc.ukans.edu
+ * 
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/utime/ 
+ *    or in the file Documentation/utime.txt
+ */
+/* This is in case its not a pentuim or a ppro.
+ * we dont have access to the cycle counters
+ */
+/* 
+ * This code swiped from the utime project to support high res timers
+ * Principle thief George Anzinger george@mvista.com
+ */
+#ifndef _ASM_HRTIME_M386_H
+#define _ASM_HRTIME_M386_H
+
+#ifdef __KERNEL__
+
+extern int base_c0, base_c0_offset;
+#define timer_latch_reset(x) _timer_latch_reset = x
+extern int _timer_latch_reset;
+
+/*
+ * Never call this routine with local ints on.
+ * update_jiffies_sub()
+ */
+
+extern inline unsigned int
+read_timer_chip(void)
+{
+	unsigned int next_intr;
+
+	LATCH_CNT0();
+	READ_CNT0(next_intr);
+	return next_intr;
+}
+
+#define HR_SCALE_ARCH_NSEC 20
+#define HR_SCALE_ARCH_USEC 30
+#define HR_SCALE_NSEC_ARCH 32
+#define HR_SCALE_USEC_ARCH 29
+
+#define cf_arch_to_usec (SC_n(HR_SCALE_ARCH_USEC,1000000)/ \
+                           (long long)CLOCK_TICK_RATE)
+
+extern inline int
+arch_cycles_to_usec(long update)
+{
+	return (mpy_sc_n(HR_SCALE_ARCH_USEC, update, arch_to_usec));
+}
+#define cf_arch_to_nsec (SC_n(HR_SCALE_ARCH_NSEC,1000000000)/ \
+                           (long long)CLOCK_TICK_RATE)
+
+extern inline int
+arch_cycles_to_nsec(long update)
+{
+	return mpy_sc_n(HR_SCALE_ARCH_NSEC, update, arch_to_nsec);
+}
+/* 
+ * And the other way...
+ */
+#define cf_usec_to_arch (SC_n( HR_SCALE_USEC_ARCH,CLOCK_TICK_RATE)/ \
+                                            (long long)1000000)
+extern inline int
+usec_to_arch_cycles(unsigned long usec)
+{
+	return mpy_sc_n(HR_SCALE_USEC_ARCH, usec, usec_to_arch);
+}
+#define cf_nsec_to_arch (SC_n( HR_SCALE_NSEC_ARCH,CLOCK_TICK_RATE)/ \
+                                            (long long)1000000000)
+extern inline int
+nsec_to_arch_cycles(long nsec)
+{
+	return (mpy_sc32(nsec, nsec_to_arch));
+}
+#ifndef CONFIG_SMP
+/*
+ * If this is defined otherwise to allow NTP adjusting, it should
+ * be scaled by about 16 bits (or so) to allow small percentage
+ * changes
+ */
+#define arch_cycles_to_latch(x) x
+
+#else
+/*
+ * APIC clocks run from a low of 33MH to say 200MH.  The PIT timer
+ * runs about 1.2 MH.  We want to scale so that ( APIC << scale )/PIT
+ * is less 2 ^ 32.  Lets use 2 ^ 19, leaves plenty of room.
+ */
+#define HR_SCALE_ARCH_LATCH 19
+
+#define compute_latch(APIC_clocks_jiffie) arch_to_latch = div_sc_n(   \
+                                                    HR_SCALE_ARCH_LATCH,   \
+				                    APIC_clocks_jiffie,   \
+				                    cycles_per_jiffies);
+extern inline int
+arch_cycles_to_latch(unsigned long update)
+{
+	return (mpy_sc_n(HR_SCALE_ARCH_LATCH, update, arch_to_latch));
+}
+
+#endif
+/*
+ * This function updates base_c0
+ * This function is always called under the write_lock_irq(&xtime_lock)
+ * It returns the number of "clocks" since the last call to it.
+ *
+ * There is a problem having a counter that has a period the same as it is
+ * interagated.  I.e. did it just roll over or has a very short time really
+ * elapsed.  (One of the reasons one should not use the PIT for both ints
+ * and time.)  We will take the occurance of an interrupt since last time
+ * to indicate that the counter has reset.  This will work for the 
+ * get_cpuctr() code but is flawed for the quick_get_cpuctr() as it is
+ * called when ever time is requested.  For that code, we make sure that
+ * we never move backward in time.
+ */
+extern inline unsigned long
+get_cpuctr(void)
+{
+	int c0;
+	long rtn;
+
+	spin_lock(&i8253_lock);
+	c0 = read_timer_chip();
+
+	rtn = base_c0 - c0 + _timer_latch_reset;
+
+//      if (rtn < 0) {
+//                rtn += _timer_latch_reset;
+//        }
+	base_c0 = c0;
+	base_c0_offset = 0;
+	spin_unlock(&i8253_lock);
+
+	return rtn;
+}
+/*
+ * In an SMP system this is called under the read_lock_irq(xtime_lock)
+ * In a UP system it is also called with this lock (PIT case only)
+ * It returns the number of "clocks" since the last call to get_cpuctr (above).
+ */
+extern inline unsigned long
+quick_get_cpuctr(void)
+{
+	register int c0;
+	long rtn;
+
+	spin_lock(&i8253_lock);
+	c0 = read_timer_chip();
+	/*
+	 * If the new count is greater than 
+	 * the last one (base_c0) the chip has just rolled and an 
+	 * interrupt is pending.  To get the time right. We need to add
+	 * _timer_latch_reset to the answer.  All this is true if only
+	 * one roll is involved, but base_co should be updated at least
+	 * every 1/HZ.
+	 */
+	rtn = base_c0 - c0;
+	if (rtn < base_c0_offset) {
+		rtn += _timer_latch_reset;
+	}
+	base_c0_offset = rtn;
+	spin_unlock(&i8253_lock);
+	return rtn;
+}
+
+#ifdef _INCLUDED_FROM_TIME_C
+int base_c0 = 0;
+int base_c0_offset = 0;
+struct timer_conversion_bits timer_conversion_bits = {
+	_cycles_per_jiffies:(LATCH),
+	_nsec_to_arch:cf_nsec_to_arch,
+	_usec_to_arch:cf_usec_to_arch,
+	_arch_to_nsec:cf_arch_to_nsec,
+	_arch_to_usec:cf_arch_to_usec,
+	_arch_to_latch:1
+};
+EXTERN int _timer_latch_reset = LATCH;
+
+#define set_last_timer_cc() (void)(1)
+
+/* This returns the correct cycles_per_sec from a calibrated one
+ */
+#define arch_hrtime_init(x) (CLOCK_TICK_RATE)
+
+/*
+ * The reload_timer_chip routine is called under the timerlist lock (irq off)
+ * and, in SMP, the xtime_lock.  We also take the i8253_lock for the chip access
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+
+extern inline void
+reload_timer_chip(int new_latch_value)
+{
+	int c1, c1new, delta;
+	unsigned char pit_status;
+	/*
+	 * In put value is in timer units for the 386 platform.
+	 * We must be called with irq disabled.
+	 */
+	spin_lock(&i8253_lock);
+	/*
+	 * we need to get this last value of the timer chip
+	 */
+	LATCH_CNT0_AND_CNT1();
+	READ_CNT0(delta);
+	READ_CNT1(c1);
+	base_c0 -= delta;
+
+	new_latch_value = arch_cycles_to_latch(new_latch_value);
+	if (new_latch_value < TIMER_DELTA) {
+		new_latch_value = TIMER_DELTA;
+	}
+	outb_p(PIT0_PERIODIC, PIT_COMMAND);
+	outb_p(new_latch_value & 0xff, PIT0);	/* LSB */
+	outb(new_latch_value >> 8, PIT0);	/* MSB */
+	do {
+		outb_p(PIT0_LATCH_STATUS, PIT_COMMAND);
+		pit_status = inb(PIT0);
+	} while (pit_status & PIT_NULL_COUNT);
+	do {
+		LATCH_CNT0_AND_CNT1();
+		READ_CNT0(delta);
+		READ_CNT1(c1new);
+	} while (!(((new_latch_value - delta) & 0xffff) < 15));
+
+	outb_p(LATCH & 0xff, PIT0);	/* LSB */
+	outb(LATCH >> 8, PIT0);	/* MSB */
+
+	/*
+	 * this is assuming that counter one is latched on with
+	 * 18 as the value
+	 * Most BIOSes do this i guess....
+	 */
+	c1 -= c1new;
+	base_c0 += ((c1 < 0) ? (c1 + 18) : (c1)) + delta;
+	if (base_c0 < 0) {
+		base_c0 += _timer_latch_reset;
+	}
+	spin_unlock(&i8253_lock);
+	return;
+}
+#endif
+/*
+ * No run time conversion factors need to be set up as the PIT has a fixed
+ * speed.
+ */
+#define init_hrtimers()
+
+#endif				/* _INCLUDED_FROM_HRTIME_C_ */
+#endif				/* __KERNEL__ */
+#endif				/* _ASM_HRTIME_M386_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/hrtime-M586.h linux/include/asm-i386/hrtime-M586.h
--- linux-2.5.54-bk1-core/include/asm-i386/hrtime-M586.h	Wed Dec 31 16:00:00 1969
+++ linux/include/asm-i386/hrtime-M586.h	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,170 @@
+/*
+ * UTIME: On-demand Microsecond Resolution Timers
+ * ----------------------------------------------
+ *
+ * File: include/asm-i586/hrtime-Macpi.h
+ * Copyright (C) 1999 by the University of Kansas Center for Research, Inc.
+ * Copyright (C) 2001 by MontaVista Software.
+ *
+ * This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ * 
+ * Authors: Balaji S., Raghavan Menon
+ *	    Furquan Ansari, Jason Keimig, Apurva Sheth
+ *
+ * Please send bug-reports/suggestions/comments to utime@ittc.ukans.edu
+ * 
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/utime/ 
+ *    or in the file Documentation/utime.txt
+ */
+/* 
+ * This code swiped from the utime project to support high res timers
+ * Principle thief George Anzinger george@mvista.com
+ */
+#include <asm/msr.h>
+#ifndef _ASM_HRTIME_M586_H
+#define _ASM_HRTIME_M586_H
+
+#ifdef __KERNEL__
+
+#ifdef _INCLUDED_FROM_TIME_C
+/*
+ * This gets redefined when we calibrate the TSC
+ */
+struct timer_conversion_bits timer_conversion_bits = {
+	_cycles_per_jiffies:LATCH
+};
+#endif
+
+/*
+ * This define avoids an ugly ifdef in time.c
+ */
+#define get_cpuctr_from_timer_interrupt()
+#define timer_latch_reset(s)
+
+/* NOTE: When trying to port this to other architectures define
+ * this to be (void)(1) (ie. #define set_last_timer_cc() (void)(1))
+ * otherwise sched.c would give an undefined reference
+ */
+
+// think this is old cruft... extern void set_last_timer_cc(void);
+/*
+ * These are specific to the pentium counters
+ */
+extern inline unsigned long
+get_cpuctr(void)
+{
+	/*
+	 * We are interested only in deltas so we just use the low bits
+	 * at 1GHZ this should be good for 4.2 seconds, at 100GHZ 42 ms
+	 */
+	unsigned long old = last_update;
+	rdtscl(last_update);
+	return last_update - old;
+}
+extern inline unsigned long
+quick_get_cpuctr(void)
+{
+	unsigned long value;
+	rdtscl(value);
+	return value - last_update;
+}
+#define arch_hrtime_init(x) (x)
+
+extern unsigned long long base_cpuctr;
+extern unsigned long base_jiffies;
+/* 
+ * We use various scaling.  The sc32 scales by 2**32, sc_n by the first parm.
+ * When working with constants, choose a scale such that x/n->(32-scale)< 1/2.
+ * So for 1/3 <1/2 so scale of 32, where as 3/1 must be shifted 3 times (3/8) to
+ * be less than 1/2 so scale should be 29
+ *
+ * The principle high end is when we can no longer keep 1/HZ worth of arch
+ * time (TSC counts) in an integer.  This will happen somewhere between 40GHz and
+ * 50GHz with HZ set to 100.  For now we are cool and the scale of 24 works for 
+ * the nano second to arch from 2MHz to 40+GHz.  
+ */
+#define HR_TIME_SCALE_NSEC 22
+#define HR_TIME_SCALE_USEC 14
+extern inline int
+arch_cycles_to_usec(unsigned long update)
+{
+	return (mpy_sc32(update, arch_to_usec));
+}
+/*
+ * We use the same scale for both the pit and the APIC
+ */
+extern inline int
+arch_cycles_to_latch(unsigned long update)
+{
+	return (mpy_sc32(update, arch_to_latch));
+}
+#define compute_latch(APIC_clocks_jiffie) arch_to_latch = \
+                                             div_sc32(APIC_clocks_jiffie, \
+				                      cycles_per_jiffies);
+
+extern inline int
+arch_cycles_to_nsec(long update)
+{
+	return mpy_sc_n(HR_TIME_SCALE_NSEC, update, arch_to_nsec);
+}
+/* 
+ * And the other way...
+ */
+extern inline int
+usec_to_arch_cycles(unsigned long usec)
+{
+	return mpy_sc_n(HR_TIME_SCALE_USEC, usec, usec_to_arch);
+}
+extern inline int
+nsec_to_arch_cycles(unsigned long nsec)
+{
+	return mpy_sc_n(HR_TIME_SCALE_NSEC, nsec, nsec_to_arch);
+}
+
+EXTERN int pit_pgm_correction;
+
+#ifdef _INCLUDED_FROM_TIME_C
+
+#include <asm/io.h>
+
+#ifndef USEC_PER_SEC
+#define USEC_PER_SEC 1000000
+#endif
+	/*
+	 * Code for runtime calibration of high res timers
+	 * Watch out, cycles_per_sec will overflow when we
+	 * get a ~ 2.14 GHz machine...
+	 * We are starting with tsc_cycles_per_5_jiffies set to 
+	 * 5 times the actual value (as set by 
+	 * calibrate_tsc() ).
+	 */
+#define init_hrtimers() \
+        arch_to_usec = fast_gettimeoffset_quotient; \
+ \
+        arch_to_latch = div_ll_X_l(mpy_l_X_l_ll(fast_gettimeoffset_quotient, \
+                                                CLOCK_TICK_RATE),           \
+                                   (USEC_PER_SEC));          \
+\
+        arch_to_nsec = div_sc_n(HR_TIME_SCALE_NSEC, \
+                               CALIBRATE_TIME * NSEC_PER_USEC, \
+                               tsc_cycles_per_5_jiffies); \
+ \
+        nsec_to_arch = div_sc_n(HR_TIME_SCALE_NSEC, \
+                                tsc_cycles_per_5_jiffies, \
+                                CALIBRATE_TIME * NSEC_PER_USEC); \
+        usec_to_arch = div_sc_n(HR_TIME_SCALE_USEC, \
+                                tsc_cycles_per_5_jiffies, \
+                                CALIBRATE_TIME ); \
+        cycles_per_jiffies = tsc_cycles_per_5_jiffies / CAL_JIFS;
+
+#endif				/* _INCLUDED_FROM_HRTIME_C */
+#endif				/* __KERNEL__ */
+#endif				/* _ASM_HRTIME-M586_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/hrtime-Macpi.h linux/include/asm-i386/hrtime-Macpi.h
--- linux-2.5.54-bk1-core/include/asm-i386/hrtime-Macpi.h	Wed Dec 31 16:00:00 1969
+++ linux/include/asm-i386/hrtime-Macpi.h	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,190 @@
+/*
+ *
+ * File: include/asm-i386/hrtime-Macpi.h 
+ * Copyright (C) 2001 by MontaVista Software,
+
+ * This software may be used and distributed according to the terms of
+ * the GNU Public License, incorporated herein by reference.
+
+ */
+#include <asm/msr.h>
+#include <asm/io.h>
+#ifndef _ASM_HRTIME_Macpi_H
+#define _ASM_HRTIME_Macpi_H
+
+#ifdef __KERNEL__
+
+/*
+ * This define avoids an ugly ifdef in time.c
+ */
+#define timer_latch_reset(s)
+
+/* NOTE: When trying to port this to other architectures define
+ * this to be (void)(1) (ie. #define set_last_timer_cc() (void)(1))
+ * otherwise sched.c would give an undefined reference
+ */
+
+extern void set_last_timer_cc(void);
+/*
+ * These are specific to the ACPI pm counter
+ * The spec says the counter can be either 32 or 24 bits wide.  We treat them
+ * both as 24 bits.  Its faster than doing the test.
+ */
+#define SIZE_MASK 0xffffff
+
+extern int acpi_pm_tmr_address;
+
+extern inline unsigned long
+get_cpuctr(void)
+{
+	static long old;
+
+	old = last_update;
+	last_update = inl(acpi_pm_tmr_address);
+	return (last_update - old) & SIZE_MASK;
+}
+extern inline unsigned long
+quick_get_cpuctr(void)
+{
+	return (inl(acpi_pm_tmr_address) - last_update) & SIZE_MASK;
+}
+#define arch_hrtime_init(x) (x)
+
+/* 
+ * We use various scaling.  The sc32 scales by 2**32, sc_n by the first parm.
+ * When working with constants, choose a scale such that x/n->(32-scale)< 1/2.
+ * So for 1/3 <1/2 so scale of 32, where as 3/1 must be shifted 3 times (3/8) to
+ * be less than 1/2 so scale should be 29
+ *
+ */
+#define HR_SCALE_ARCH_NSEC 22
+#define HR_SCALE_ARCH_USEC 32
+#define HR_SCALE_NSEC_ARCH 32
+#define HR_SCALE_USEC_ARCH 29
+
+#ifndef  PM_TIMER_FREQUENCY
+#define PM_TIMER_FREQUENCY  3579545	/*45   counts per second */
+#endif
+#define PM_TIMER_FREQUENCY_x_100  357954545	/* counts per second * 100 */
+
+#define cf_arch_to_usec (SC_32(100000000)/(long long)PM_TIMER_FREQUENCY_x_100)
+extern inline int
+arch_cycles_to_usec(unsigned long update)
+{
+	return (mpy_sc32(update, arch_to_usec));
+}
+/* 
+ * Note: In the SMP case this value will be overwritten when the 
+ * APIC clocks are figured out using the "compute_latch function below.
+ * If the system is not SMP, the PIT is the ticker and this is the 
+ * conversion for that.
+ */
+#define cf_arch_to_latch SC_32(CLOCK_TICK_RATE)/(long long)(CLOCK_TICK_RATE * 3)
+
+#ifndef CONFIG_SMP
+/*
+ * We need to take 1/3 of the presented value (or more exactly)
+ * CLOCK_TICK_RATE /PM_TIMER_FREQUENCY.  Note that these two timers
+ * are on the same cyrstal so will be EXACTLY 1/3.
+ */
+extern inline int
+arch_cycles_to_latch(unsigned long update)
+{
+	return (mpy_sc32(update, arch_to_latch));
+}
+#else
+/*
+ * APIC clocks run from a low of 33MH to say 200MH.  The PM timer
+ * runs about 3.5 MH.  We want to scale so that ( APIC << scale )/PM
+ * is less 2 ^ 32.  Lets use 2 ^ 19, leaves plenty of room.
+ */
+#define HR_SCALE_ARCH_LATCH 19
+
+#define compute_latch(APIC_clocks_jiffie) arch_to_latch = div_sc_n(   \
+                                                    HR_SCALE_ARCH_LATCH,   \
+				                    APIC_clocks_jiffie,   \
+				                    cycles_per_jiffies);
+extern inline int
+arch_cycles_to_latch(unsigned long update)
+{
+	return (mpy_sc_n(HR_SCALE_ARCH_LATCH, update, arch_to_latch));
+}
+
+#endif
+
+#define cf_arch_to_nsec (SC_n(HR_SCALE_ARCH_NSEC,100000000000LL)/ \
+                           (long long)PM_TIMER_FREQUENCY_x_100)
+
+extern inline int
+arch_cycles_to_nsec(long update)
+{
+	return mpy_sc_n(HR_SCALE_ARCH_NSEC, update, arch_to_nsec);
+}
+/* 
+ * And the other way...
+ */
+#define cf_usec_to_arch (SC_n( HR_SCALE_USEC_ARCH,PM_TIMER_FREQUENCY_x_100)/ \
+                                            (long long)100000000)
+extern inline int
+usec_to_arch_cycles(unsigned long usec)
+{
+	return mpy_sc_n(HR_SCALE_USEC_ARCH, usec, usec_to_arch);
+}
+#define cf_nsec_to_arch (SC_n( HR_SCALE_NSEC_ARCH,PM_TIMER_FREQUENCY)/ \
+                                            (long long)1000000000)
+extern inline int
+nsec_to_arch_cycles(unsigned long nsec)
+{
+	return mpy_sc32(nsec, nsec_to_arch);
+}
+
+extern int hrt_get_acpi_pm_ptr(void);
+//EXTERN int pit_pgm_correction;
+
+#ifdef _INCLUDED_FROM_TIME_C
+
+#include <asm/io.h>
+struct timer_conversion_bits timer_conversion_bits = {
+	_cycles_per_jiffies:((PM_TIMER_FREQUENCY + HZ / 2) / HZ),
+	_nsec_to_arch:cf_nsec_to_arch,
+	_usec_to_arch:cf_usec_to_arch,
+	_arch_to_nsec:cf_arch_to_nsec,
+	_arch_to_usec:cf_arch_to_usec,
+	_arch_to_latch:cf_arch_to_latch
+};
+int acpi_pm_tmr_address;
+
+#endif				/* _INCLUDED_FROM_TIME_C_ */
+
+/*
+ * No run time conversion factors need to be set up as the pm timer has a fixed
+ * speed.
+ */
+/*
+ * Here we have a local udelay for our init use only.  The system delay has
+ * has not yet been calibrated when we use this, however, we do know
+ * tsc_cycles_per_5_jiffies...
+ */
+
+#if defined( CONFIG_HIGH_RES_TIMER_ACPI_PM_ADD) && CONFIG_HIGH_RES_TIMER_ACPI_PM_ADD > 0
+#define default_pm_add CONFIG_HIGH_RES_TIMER_ACPI_PM_ADD
+#define message "High-res-timers: ACPI pm timer not found.  Trying specified address %d\n"
+#else
+#define default_pm_add 0
+#define message \
+        "High-res-timers: ACPI pm timer not found(%d) and no backup."\
+        "\nCheck BIOS settings or supply a backup.  See configure documentation.\n"
+#endif
+#define fail_message \
+"High-res-timers: >-<--><-->-<-->-<-->-<--><-->-<-->-<-->-<-->-<-->-<-->-<-->-<\n"\
+"High-res-timers: >Failed to find the ACPI pm timer                           <\n"\
+"High-res-timers: >-<--><-->-<-->-<-->-<-->Boot will fail in Calibrate Delay  <\n"\
+"High-res-timers: >Supply a valid default pm timer address                    <\n"\
+"High-res-timers: >or get your BIOS to turn on ACPI support.                  <\n"\
+"High-res-timers: >See CONFIGURE help for more information.                   <\n"\
+"High-res-timers: >-<--><-->-<-->-<-->-<--><-->-<-->-<-->-<-->-<-->-<-->-<-->-<\n"
+/*
+ * After we get the address, we set last_update to the current timer value
+ */
+#endif				/* __KERNEL__ */
+#endif				/* _ASM_HRTIME-Mapic_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/hrtime.h linux/include/asm-i386/hrtime.h
--- linux-2.5.54-bk1-core/include/asm-i386/hrtime.h	Wed Dec 31 16:00:00 1969
+++ linux/include/asm-i386/hrtime.h	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,523 @@
+/*
+ *
+ * File: include/asm-i386/hrtime.h
+ * Copyright (C) 1999 by the University of Kansas Center for Research, Inc.  
+ * Copyright (C) 2001 by MontaVista Software.
+ *
+ * This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. This
+ * software may be used and distributed according to the terms of the GNU
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus.
+ * 
+ * Authors: Balaji S., Raghavan Menon
+ *	    Furquan Ansari, Jason Keimig, Apurva Sheth
+ *
+ * Please send bug-reports/suggestions/comments to utime@ittc.ukans.edu
+ * 
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/utime/ 
+ *    or in the file Documentation/high-res-timers/
+ */
+/*
+ * This code purloined from the utime project for high res timers.
+ * Principle modifier George Anzinger george@mvista.com
+ */
+#ifndef _I386_HRTIME_H
+#define _I386_HRTIME_H
+#ifdef __KERNEL__
+
+#include <linux/config.h>	/* for CONFIG_APM etc... */
+#include <asm/types.h>		/* for u16s */
+#include <asm/io.h>
+#include <asm/sc_math.h>	/* scaling math routines */
+#include <asm/delay.h>
+#include <asm/smp.h>
+#include <linux/timex.h>	/* for LATCH */
+/*
+
+ * We always want the timer, if not touched otherwise, to give periodic
+ * 1/HZ interrupts.  This is done by programing the interrupt we want
+ * and, once it it loaded, (in the case of the PIT) dropping a 1/HZ
+ * program on top of it.  For other timers, other strategies are used,
+ * such as programming a 1/HZ interval on interrupt.  The The PIT will
+ * give us the desired interrupt and, at interrupt time, load the 1/HZ
+ * program.  So...
+
+ * If no sub 1/HZ ticks are needed AND we are aligned with the 1/HZ 
+ * boundry, we don't need to touch the PIT.  Otherwise we do the above.
+
+ * There are two reasons to keep this:
+ * 1. The NMI watchdog uses the timer interrupt to generate the NMI interrupts.
+ * 2. We don't have to touch the PIT unless we have a sub jiffie event in
+ *    the next 1/HZ interval (unless we drift away from the 1/HZ boundry).
+ */
+
+/*
+ * The high-res-timers option is set up to self configure with different 
+ * platforms.  It is up to the platform to provide certian macros which
+ * override the default macros defined in system without (or with disabled)
+ * high-res-timers.
+ *
+ * To do high-res-timers at some fundamental level the timer interrupt must
+ * be seperated from the time keeping tick.  A tick can still be generated
+ * by the timer interrupt, but it may be surrounded by non-tick interrupts.
+ * It is up to the platform to determine if a particular interrupt is a tick,
+ * and up to the timer code (in timer.c) to determine what time events have
+ * expired.
+ *
+ * Macros:
+ * update_jiffies()  This macro is to compute the new value of jiffie and 
+ *                   sub_jiffie.  If high-res-timers are not available it
+ *                   may be assumed that this macro will be called once
+ *                   every 1/HZ and so should reduce to:
+ *
+ * 	(*(u64 *)&jiffies_64)++;
+ *
+ * sub_jiffie, in this case will always be zero, and need not be addressed.
+ * It is assumed that the sub_jiffie is in platform defined units and runs
+ * from 0 to a value which represents 1/HZ on that platform.  (See conversion
+ * macro requirements below.)
+ * If high-res-timers are available, this macro will be called each timer
+ * interrupt which may be more often than 1/HZ.  It is up to the code to 
+ * determine if a new jiffie has just started and pass this info to:
+ *
+ * new_jiffie() which should return true if the last call to update_jiffie()
+ *              moved the jiffie count (as apposed to just the sub_jiffie).
+ *              For systems without high-res-timers the kernel will predefine
+ *              this to be 0 which will allow the compiler to optimize the code
+ *              for this case.  In SMP systems this should be set to all 1's
+ *              as it is used in a per cpu fashion to indicate that a paricular
+ *              cpu needs to run the accounting code.  It should result
+ *              in a variable that can be cast to a volital long and of
+ *              which the address can be taken.
+ *
+ * schedule_next_int(jiffie_f,sub_jiffie_v,always) is a macro that the 
+ *                                 platform should 
+ *                                 provide that will set up the timer interrupt 
+ *                                 hardware to interrupt at the absolute time
+ *                                 defined by jiffie_f,sub_jiffie_v where the 
+ *                                 units are 1/HZ and the platform defined 
+ *                                 sub_jiffie unit.  This function must 
+ *                                 determine the actual current time and the 
+ *                                 requested offset and act accordingly.  A 
+ *                                 sub_jiffie_v value of -1 should be 
+ *                                 understood to mean the next even jiffie 
+ *                                 regardless of the jiffie_f value.  If 
+ *                                 the current jiffie is not jiffie_f, it 
+ *                                 may be assumed that the requested time 
+ *                                 has passed and an immeadiate interrupt 
+ *                                 should be taken.  If high-res-timers are 
+ *                                 not available, this macro should evaluate 
+ *                                 to nil.  This macro may return 1 if always
+ *                                 if false AND the requested time has passed.
+ *                                 "Always" indicates that an interrupt is
+ *                                 required even if the time has already passed.
+ */
+
+/*
+ * no of usecs less than which events cannot be scheduled
+ */
+#define TIMER_DELTA  5
+#ifdef _INCLUDED_FROM_TIME_C
+#define EXTERN
+int timer_delta = TIMER_DELTA;
+#else
+#define EXTERN  extern
+extern int timer_delta;
+#endif
+
+/*
+
+ * Interrupt generators need to be disciplined to generate the interrupt
+ * on the 1/HZ boundry (assuming we don't need sub_jiffie interrupts) if
+ * the timer clock is other than the interrupt generator clock.  In the
+ * I386 case this includes the PIT and TSC or pm combinations and the
+ * apic and TSC or pm combinations, i.e. all but the PIT/PIT
+ * combination.
+
+ */
+#if defined(CONFIG_X86_LOCAL_APIC) || !defined(CONFIG_HIGH_RES_TIMER_PIT)
+#define TIMER_NEEDS_DISCIPLINE
+#define IF_DISCIPLINE(x) x
+EXTERN int timer_discipline_diff;
+EXTERN int min_hz_sub_jiffie;
+EXTERN int max_hz_sub_jiffie;
+EXTERN int _last_was_long[NR_CPUS];
+#define __last_was_long  _last_was_long[smp_processor_id()]
+#else
+#define IF_DISCIPLINE(x)
+EXTERN int _last_was_long;
+#define __last_was_long  _last_was_long
+#endif
+
+#define CONFIG_HIGH_RES_RESOLUTION 1000	// nano second resolution
+					   // we will use for high res.
+
+#define USEC_PER_JIFFIES  (1000000/HZ)
+/*
+ * This is really: x*(CLOCK_TICK_RATE+HZ/2)/1000000
+ * Note that we can not figure the constant part at
+ * compile time because we would loose precision.
+ */
+#define PIT0_LATCH_STATUS 0xc2
+#define PIT0 0x40
+#define PIT1 0x41
+#define PIT_COMMAND 0x43
+#define PIT0_ONE_SHOT 0x38
+#define PIT0_PERIODIC 0x34
+#define PIT0_LATCH_COUNT 0xd2
+#define PIT01_LATCH_COUNT 0xd6
+#define PIT_NULL_COUNT 0x40
+#define READ_CNT0(varr) {varr = inb(PIT0);varr += (inb(PIT0))<<8;}
+#define READ_CNT1(var) { var = inb(PIT1); }
+#define LATCH_CNT0() { outb(PIT0_LATCH_COUNT,PIT_COMMAND); }
+#define LATCH_CNT0_AND_CNT1() { outb(PIT01_LATCH_COUNT,PIT_COMMAND); }
+
+#define TO_LATCH(x) (((x)*LATCH)/USEC_PER_JIFFIES)
+
+#define sub_jiffie() _sub_jiffie
+#define schedule_next_int(a,b,c)  _schedule_next_int(a,b,c)
+
+#define update_jiffies() update_jiffies_sub()
+#define new_jiffie() _new_jiffie
+
+extern unsigned long next_intr;
+extern spinlock_t i8253_lock;
+extern rwlock_t xtime_lock;
+extern volatile unsigned long jiffies;
+extern u64 jiffies_64;
+
+extern int _schedule_next_int(unsigned long jiffie_f, long sub_jiffie_in,
+			      int always);
+
+extern unsigned int volatile latch_reload;
+
+EXTERN int jiffies_intr;
+EXTERN long volatile _new_jiffie;
+EXTERN int _sub_jiffie;
+EXTERN unsigned long volatile last_update;
+EXTERN int high_res_test_val;
+
+extern inline void
+start_PIT(void)
+{
+	spin_lock(&i8253_lock);
+	outb_p(PIT0_PERIODIC, PIT_COMMAND);
+	outb_p(LATCH & 0xff, PIT0);	/* LSB */
+	outb(LATCH >> 8, PIT0);	/* MSB */
+	spin_unlock(&i8253_lock);
+}
+
+/*
+ * Now go ahead and include the clock specific file 586/386/acpi
+ * These asm files have extern inline functions to do a lot of
+ * stuff as well as the conversion routines.
+ */
+#ifdef CONFIG_HIGH_RES_TIMER_ACPI_PM
+#include <asm/hrtime-Macpi.h>
+#elif defined(CONFIG_HIGH_RES_TIMER_PIT)
+#include <asm/hrtime-M386.h>
+#elif defined(CONFIG_HIGH_RES_TIMER_TSC)
+#include <asm/hrtime-M586.h>
+#else
+#error "Need one of: CONFIG_HIGH_RES_TIMER_ACPI_PM CONFIG_HIGH_RES_TIMER_TSC CONFIG_HIGH_RES_TIMER_PIT"
+#endif
+
+extern unsigned long long jiffiesll;
+
+/*
+ * We stole this routine from the Utime code, but there it
+ * calculated microseconds and here we calculate sub_jiffies
+ * which have (in this case) units of TSC count.  (If there
+ * is no TSC, see hrtime-M386.h where a different unit
+ * is used.  This allows the more expensive math (to get
+ * standard units) to be done only when needed.  Also this
+ * makes it as easy (and as efficient) to calculate nano
+ * as well as micro seconds.
+ */
+
+extern inline void
+arch_update_jiffies(unsigned long update)
+{
+	/*
+	 * update is the delta in sub_jiffies
+	 */
+	_sub_jiffie += update;
+	while ((unsigned long) _sub_jiffie > cycles_per_jiffies) {
+		_sub_jiffie -= cycles_per_jiffies;
+		_new_jiffie = ~0;
+		jiffies_intr++;
+		jiffies_64++;
+	}
+}
+
+#define SC_32_TO_USEC (SC_32(1000000)/ (long long)CLOCK_TICK_RATE)
+
+	/*
+	 * In the ALL_PERIODIC mode we program the PIT to give periodic
+	 * interrupts and, if no sub_jiffie timers are due, leave it alone.
+	 * This means that it can drift WRT the clock (TSC or pm timer).
+	 * What we are trying to do is to program the next interrupt to
+	 * occure on exactly the requested time.  If we are not doing 
+	 * sub HZ interrupts we expect to find a small excess of time
+	 * beyond the 1/HZ, i.e. _sub_jiffie will have some small value. 
+	 * This value will drift AND may jump upward from time to time. 
+	 * The drift is due to not having precise tracking between the 
+	 * two timers (the PIT and either the TSC or the PM timer) and
+	 * the jump is caused by interrupt delays, cache misses etc. 
+	 * We need to correct for the drift.  To correct all we need to 
+	 * do is to set "last_was_long" to zero and a new timer program 
+	 * will be started to "do the right thing".
+
+	 * Detecting the need to do this correction is another issue. 
+	 * Here is what we do:
+	 * Each interrupt where last_was_long is !=0 (indicates the
+	 * interrupt should be on a 1/HZ boundry) we check the resulting 
+	 * _sub_jiffie.  If it is smaller than some MIN value, we do
+	 * the correction.  (Note that drift that makes the value  
+	 * smaller is the easy one.)  We also require that
+	 * _sub_jiffie <= some max at least once over a period of 1 second. 
+	 * I.e.  with HZ = 100, we will allow up to 99 "late" interrupts
+	 * before we do a correction.
+
+	 * The values we use for min_hz_sub_jiffie and max_hz_sub_jiffie 
+	 * depend on the units and we will start by, during boot,
+	 * observing what MIN appears to be.  We will set max_hz_sub_jiffie
+	 * to be about 100 machine cycles more than this.
+
+	 * Note that with  min_hz_sub_jiffie and max_hz_sub_jiffie
+	 * set to 0, this code will reset the PIT every HZ.
+	 */
+#ifdef TIMER_NEEDS_DISCIPLINE
+extern inline void
+discipline_timer(int cpu)
+{
+	int *last_was_long = &_last_was_long[cpu];
+
+	if (!*last_was_long)
+		return;
+
+	timer_discipline_diff = quick_get_cpuctr() + _sub_jiffie;
+	while (timer_discipline_diff > cycles_per_jiffies) {
+		timer_discipline_diff -= cycles_per_jiffies;
+	}
+	if (timer_discipline_diff < min_hz_sub_jiffie) {
+		*last_was_long = 0;
+		return;
+	}
+	if (timer_discipline_diff <= max_hz_sub_jiffie) {
+		*last_was_long = 1;
+		return;
+	}
+	if (++*last_was_long > HZ) {
+		*last_was_long = 0;
+		return;
+	}
+}
+#else
+#define discipline_timer(a)
+#endif
+/*
+ * This routine is always called under the write_lockirq(xtime_lock)
+ */
+extern inline void
+update_jiffies_sub(void)
+{
+	unsigned long cycles_update;
+
+	cycles_update = get_cpuctr();
+
+	arch_update_jiffies(cycles_update);
+}
+
+/*
+ * quick_update_jiffies_sub returns the sub_jiffie offset of 
+ * current time from the "ref_jiff" jiffie value.  We do this
+ * with out updating any memory values and thus do not need to
+ * take any locks, if we are careful.
+ *
+ * I don't know how to eliminate the lock in the SMP case, so..
+ * Oh, and also the PIT case requires a lock anyway, so..
+ */
+#if defined (CONFIG_SMP) || defined(CONFIG_HIGH_RES_TIMER_PIT)
+static inline void
+get_rat_jiffies(unsigned long *jiffies_f,
+		long *_sub_jiffie_f, unsigned long *update)
+{
+	unsigned long flags;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	*jiffies_f = jiffies;
+	*_sub_jiffie_f = _sub_jiffie;
+	*update = quick_get_cpuctr();
+	read_unlock_irqrestore(&xtime_lock, flags);
+}
+
+#else
+static inline void
+get_rat_jiffies(unsigned long *jiffies_f, long *_sub_jiffie_f,
+		unsigned long *update)
+{
+	unsigned long last_update_f;
+	do {
+		*jiffies_f = jiffies;
+		last_update_f = last_update;
+		barrier();
+		*_sub_jiffie_f = _sub_jiffie;
+		*update = quick_get_cpuctr();
+		barrier();
+	} while (*jiffies_f != jiffies || last_update_f != last_update);
+}
+#endif				/* CONFIG_SMP */
+
+/*
+ * If smp, this must be called with the read_lockirq(&xtime_lock) held.
+ * No lock is needed if not SMP.
+ */
+
+extern inline long
+quick_update_jiffies_sub(unsigned long ref_jiff)
+{
+	unsigned long update;
+	unsigned long rtn;
+	unsigned long jiffies_f;
+	long _sub_jiffie_f;
+
+	get_rat_jiffies(&jiffies_f, &_sub_jiffie_f, &update);
+
+	rtn = _sub_jiffie_f + (unsigned long) update;
+	rtn += (jiffies_f - ref_jiff) * cycles_per_jiffies;
+	return rtn;
+
+}
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/apic.h>
+/*
+ * If we have a local APIC, we will use its counter to get the needed 
+ * interrupts.  Here is where we program it.
+ */
+extern int prof_counter[NR_CPUS];
+
+extern void __setup_APIC_LVTT(unsigned int);
+
+extern inline void
+reload_timer_chip(int new_latch_value)
+{
+	int new_latch = arch_cycles_to_latch(new_latch_value);
+	/*
+	 * We may want to do more in line code for speed here.
+	 * For now, however...
+
+	 * Note: The interrupt routine presets the counter for 1/HZ
+	 * each interrupt so we only deal with requested shorter times
+	 * either due to timer requests or drift.
+	 */
+	if (new_latch < timer_delta)
+		new_latch = timer_delta;
+	/*
+	 * The profile counter may be set causing us to ignor (or 
+	 * really just profile) the interrupt.  Force it to roll over
+	 * and give us the interrupt.  This may cause a hic cup in
+	 * the profile, but it will resume on the next tick.
+	 * There are, clearly, more complicated ways to deal with
+	 * profiling.
+	 */
+	prof_counter[smp_processor_id()] = 1;
+	apic_write_around(APIC_TMICT, new_latch);
+}
+
+#endif
+#ifndef CONFIG_HIGH_RES_TIMER_PIT
+#ifndef CONFIG_X86_LOCAL_APIC
+extern inline void
+reload_timer_chip(int new_latch_value)
+{
+	unsigned char pit_status;
+	/*
+	 * The input value is in arch cycles
+	 * We must be called with irq disabled.
+	 */
+
+	new_latch_value = arch_cycles_to_latch(new_latch_value);
+	if (new_latch_value < TIMER_DELTA) {
+		new_latch_value = TIMER_DELTA;
+	}
+	spin_lock(&i8253_lock);
+	outb_p(PIT0_PERIODIC, PIT_COMMAND);
+	outb_p(new_latch_value & 0xff, PIT0);	/* LSB */
+	outb(new_latch_value >> 8, PIT0);	/* MSB */
+	do {
+		outb_p(PIT0_LATCH_STATUS, PIT_COMMAND);
+		pit_status = inb(PIT0);
+	} while (pit_status & PIT_NULL_COUNT);
+	outb_p(LATCH & 0xff, PIT0);	/* LSB */
+	outb(LATCH >> 8, PIT0);	/* MSB */
+	spin_unlock(&i8253_lock);
+	return;
+}
+#endif				//  ! CONFIG_X86_LOCAL_APIC
+#endif				//  ! CONFIG_HIGH_RES_TIMER_PIT
+/*
+ * Time out for a discussion.  Because the PIT and TSC (or the PIT and
+ * pm timer) may drift WRT each other, we need a way to get the jiffie
+ * interrupt to happen as near to the jiffie roll as possible.  This
+ * insures that we will get the interrupt when the timer is to be
+ * delivered, not before (we would not deliver) or later, making the
+ * jiffie timers different from the sub_jiffie deliveries.  We would
+ * also like any latency between a "requested" interrupt and the
+ * automatic jiffie interrupts from the PIT to be the same.  Since it
+ * takes some time to set up the PIT, we assume that requested
+ * interrupts may be a bit late when compared to the automatic
+ * interrupts.  When we request a jiffie interrupt, we want the
+ * interrupt to happen at the requested time, which will be a bit before
+ * we get to the jiffies update code. 
+ *
+ * What we want to determine here is a.) how long it takes (min) to get
+ * from a requested interrupt to the jiffies update code and b.) how
+ * long it takes when the interrupt is automatic (i.e. from the PIT
+ * reset logic).  When we set "last_was_long" to zero, the next tick
+ * setup code will "request" a jiffies interrupt (as long as we do not
+ * have any sub jiffie timers pending).  The interrupt after the
+ * requested one will be automatic.  Ignoring drift over this 2/HZ time
+ * we then get two latency values, the requested latency and the
+ * automatic latency.  We set up the difference to correct the requested
+ * time and the second one as the center of a window which we will use
+ * to detect the need to resync the PIT.  We do this for HZ ticks and
+ * take the min.
+ */
+#ifdef TIMER_NEEDS_DISCIPLINE
+#define NANOSEC_SYNC_LIMIT 2000	// Try for 2 usec. max drift
+#define final_clock_init() \
+        { unsigned long end = jiffies + HZ + HZ; \
+          int min_a =  cycles_per_jiffies, min_b =  cycles_per_jiffies;  \
+          long flags;                         \
+          int * last_was_long = &_last_was_long[smp_processor_id()];   \
+          while (time_before(jiffies,end)){ \
+               unsigned long f_jiffies = jiffies;     \
+               while (jiffies == f_jiffies); \
+               *last_was_long = 0;            \
+               while (jiffies == f_jiffies + 1); \
+               read_lock_irqsave(&xtime_lock, flags); \
+               if (  timer_discipline_diff < min_a) \
+                     min_a =   timer_discipline_diff; \
+               read_unlock_irqrestore(&xtime_lock, flags); \
+               while (jiffies == f_jiffies + 2); \
+               read_lock_irqsave(&xtime_lock, flags); \
+               if (  timer_discipline_diff < min_b) \
+                     min_b =   timer_discipline_diff; \
+               read_unlock_irqrestore(&xtime_lock, flags); \
+          }                             \
+         min_hz_sub_jiffie = min_b -  nsec_to_arch_cycles(NANOSEC_SYNC_LIMIT);\
+          if( min_hz_sub_jiffie < 0)  min_hz_sub_jiffie = 0; \
+          max_hz_sub_jiffie = min_b +  nsec_to_arch_cycles(NANOSEC_SYNC_LIMIT);\
+       timer_delta = arch_cycles_to_latch(usec_to_arch_cycles(TIMER_DELTA)); \
+       }
+#else
+#define final_clock_init()
+#endif				// TIMER_NEEDS_DISCIPLINE
+#endif				/* __KERNEL__ */
+#endif				/* _I386_HRTIME_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/mach-default/do_timer.h linux/include/asm-i386/mach-default/do_timer.h
--- linux-2.5.54-bk1-core/include/asm-i386/mach-default/do_timer.h	Mon Dec 30 11:48:16 2002
+++ linux/include/asm-i386/mach-default/do_timer.h	Fri Jan  3 15:08:32 2003
@@ -16,7 +16,12 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
-/*
+        IF_HIGH_RES(
+                if (!(new_jiffie() & 1))
+                        return;
+                jiffies_intr = 0;
+                )
+ /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
  * system, in that case we have to call the local interrupt handler.
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/mach-visws/do_timer.h linux/include/asm-i386/mach-visws/do_timer.h
--- linux-2.5.54-bk1-core/include/asm-i386/mach-visws/do_timer.h	Mon Dec 30 14:56:47 2002
+++ linux/include/asm-i386/mach-visws/do_timer.h	Fri Jan  3 15:08:32 2003
@@ -9,6 +9,11 @@
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
 	do_timer(regs);
+        IF_HIGH_RES(
+                if (!(new_jiffie() & 1))
+                        return;
+                jiffies_intr = 0;
+                )
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/mach-voyager/do_timer.h linux/include/asm-i386/mach-voyager/do_timer.h
--- linux-2.5.54-bk1-core/include/asm-i386/mach-voyager/do_timer.h	Mon Dec 30 14:58:37 2002
+++ linux/include/asm-i386/mach-voyager/do_timer.h	Fri Jan  3 15:08:32 2003
@@ -4,6 +4,11 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
+        IF_HIGH_RES(
+                if (!(new_jiffie() & 1))
+                        return;
+                jiffies_intr = 0;
+                )
 
 	voyager_timer_interrupt(regs);
 }
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk1-core/include/asm-i386/sc_math.h linux/include/asm-i386/sc_math.h
--- linux-2.5.54-bk1-core/include/asm-i386/sc_math.h	Wed Dec 31 16:00:00 1969
+++ linux/include/asm-i386/sc_math.h	Fri Jan  3 15:08:32 2003
@@ -0,0 +1,139 @@
+#ifndef SC_MATH
+#define SC_MATH
+#define MATH_STR(X) #X
+#define MATH_NAME(X) X
+
+/*
+ * Pre scaling defines
+ */
+#define SC_32(x) ((long long)x<<32)
+#define SC_n(n,x) (((long long)x)<<n)
+/*
+ * This routine preforms the following calculation:
+ *
+ * X = (a*b)>>32
+ * we could, (but don't) also get the part shifted out.
+ */
+extern inline long
+mpy_sc32(long a, long b)
+{
+	long edx;
+      __asm__("imull %2":"=a"(a), "=d"(edx)
+      :	"rm"(b), "0"(a));
+	return edx;
+}
+/*
+ * X = (a/b)<<32 or more precisely x = (a<<32)/b
+ */
+
+extern inline long
+div_sc32(long a, long b)
+{
+	long dum;
+      __asm__("divl %2":"=a"(b), "=d"(dum)
+      :	"r"(b), "0"(0), "1"(a));
+
+	return b;
+}
+/*
+ * X = (a*b)>>24
+ * we could, (but don't) also get the part shifted out.
+ */
+
+#define mpy_ex24(a,b) mpy_sc_n(24,a,b)
+/*
+ * X = (a/b)<<24 or more precisely x = (a<<24)/b
+ */
+#define div_ex24(a,b) div_sc_n(24,a,b)
+
+/*
+ * The routines allow you to do x = (a/b) << N and
+ * x=(a*b)>>N for values of N from 1 to 32.
+ *
+ * These are handy to have to do scaled math.
+ * Scaled math has two nice features:
+ * A.) A great deal more precision can be maintained by
+ *     keeping more signifigant bits.
+ * B.) Often an in line div can be repaced with a mpy
+ *     which is a LOT faster.
+ */
+
+#define mpy_sc_n(N,aa,bb) ({long edx,a=aa,b=bb; \
+	__asm__("imull %2\n\t" \
+                "shldl $(32-"MATH_STR(N)"),%0,%1"    \
+		:"=a" (a), "=d" (edx)\
+		:"rm" (b),            \
+		 "0" (a)); edx;})
+
+#define div_sc_n(N,aa,bb) ({long dum=aa,dum2,b=bb; \
+        __asm__("shrdl $(32-"MATH_STR(N)"),%4,%3\n\t"  \
+                "sarl $(32-"MATH_STR(N)"),%4\n\t"      \
+                "divl %2"              \
+                :"=a" (dum2), "=d" (dum)      \
+                :"rm" (b), "0" (0), "1" (dum)); dum2;})
+
+/*
+ * (long)X = ((long long)divs) / (long)div
+ * (long)rem = ((long long)divs) % (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ */
+#define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
+
+extern inline long
+div_ll_X_l_rem(long long divs, long div, long *rem)
+{
+	long dum2;
+      __asm__("divl %2":"=a"(dum2), "=d"(*rem)
+      :	"rm"(div), "A"(divs));
+
+	return dum2;
+
+}
+/*
+ * same as above, but no remainder
+ */
+extern inline long
+div_ll_X_l(long long divs, long div)
+{
+	long dum;
+	return div_ll_X_l_rem(divs, div, &dum);
+}
+/*
+ * (long)X = (((long)divh<<32) | (long)divl) / (long)div
+ * (long)rem = (((long)divh<<32) % (long)divl) / (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ */
+extern inline long
+div_h_or_l_X_l_rem(long divh, long divl, long div, long *rem)
+{
+	long dum2;
+      __asm__("divl %2":"=a"(dum2), "=d"(*rem)
+      :	"rm"(div), "0"(divl), "1"(divh));
+
+	return dum2;
+
+}
+extern inline long long
+mpy_l_X_l_ll(long mpy1, long mpy2)
+{
+	long long eax;
+      __asm__("imull %1\n\t":"=A"(eax)
+      :	"rm"(mpy2), "a"(mpy1));
+
+	return eax;
+
+}
+extern inline long
+mpy_1_X_1_h(long mpy1, long mpy2, long *hi)
+{
+	long eax;
+      __asm__("imull %2\n\t":"=a"(eax), "=d"(*hi)
+      :	"rm"(mpy2), "0"(mpy1));
+
+	return eax;
+
+}
+
+#endif

--------------0073EC6479D1674740E75603--

