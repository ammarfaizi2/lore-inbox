Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVAXW56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVAXW56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVAXW5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:57:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:6649 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261713AbVAXWwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:52:40 -0500
Subject: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 14:52:33 -0800
Message-Id: <1106607153.30884.12.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements the minimal architecture specific hooks to enable
the new time of day subsystem code for i386, x86-64, and ppc64. It
applies on top of my linux-2.6.11-rc1_timeofday-core_A2 patch and with
this patch applied, you can test the new time of day subsystem. 

	Basically it adds the call to timeofday_interrupt_hook() and cuts alot
of code out of the build via #ifdefs. I know, I know, #ifdefs' are ugly
and bad, and the final patch will just remove the old code. For now this
allows us to be flexible and easily switch between the two
implementations with a single define. Also it makes the patch a bit
easier to read.

New in this version:
o more i386 cleanups
o added arch specific read_persistent_clock interface
o ppc64 hooks!

I look forward to your comments and feedback.

thanks
-john

linux-2.6.11-rc2_timeofday-arch_A2.patch
=======================================
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-01-24 13:33:59 -08:00
+++ b/arch/i386/Kconfig	2005-01-24 13:33:59 -08:00
@@ -14,6 +14,10 @@
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config NEWTOD
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-01-24 13:33:59 -08:00
+++ b/arch/i386/kernel/Makefile	2005-01-24 13:33:59 -08:00
@@ -10,7 +10,7 @@
 		doublefault.o quirks.o
 
 obj-y				+= cpu/
-obj-y				+= timers/
+obj-$(!CONFIG_NEWTOD)		+= timers/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2005-01-24 13:33:59 -08:00
+++ b/arch/i386/kernel/apm.c	2005-01-24 13:33:59 -08:00
@@ -224,6 +224,7 @@
 #include <linux/smp_lock.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
+#include <linux/timeofday.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -1204,6 +1205,7 @@
 	device_suspend(PMSG_SUSPEND);
 	device_power_down(PMSG_SUSPEND);
 
+	timeofday_suspend_hook();
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 
@@ -1231,6 +1233,7 @@
 	spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);
 
+	timeofday_resume_hook();
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
diff -Nru a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c	2005-01-24 13:33:59 -08:00
+++ b/arch/i386/kernel/i8259.c	2005-01-24 13:33:59 -08:00
@@ -388,6 +388,48 @@
 	}
 }
 
+#ifdef CONFIG_NEWTOD
+void setup_pit_timer(void)
+{
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
+	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+	udelay(10);
+	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int timer_resume(struct sys_device *dev)
+{
+	setup_pit_timer();
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer_pit"),
+	.resume	= timer_resume,
+};
+
+static struct sys_device device_timer = {
+	.id	= 0,
+	.cls	= &timer_sysclass,
+};
+
+static int __init init_timer_sysfs(void)
+{
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(init_timer_sysfs);
+#endif
+
 void __init init_IRQ(void)
 {
 	int i;
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-01-24 13:33:59 -08:00
+++ b/arch/i386/kernel/time.c	2005-01-24 13:33:59 -08:00
@@ -68,6 +68,8 @@
 
 #include "io_ports.h"
 
+#include <linux/timeofday.h>
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -86,6 +88,7 @@
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+#ifndef CONFIG_NEWTOD
 struct timer_opts *cur_timer = &timer_none;
 
 /*
@@ -170,6 +173,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
 static int set_rtc_mmss(unsigned long nowtime)
 {
@@ -195,11 +199,13 @@
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
  */
+#ifndef CONFIG_NEWTOD
 unsigned long long monotonic_clock(void)
 {
 	return cur_timer->monotonic_clock();
 }
 EXPORT_SYMBOL(monotonic_clock);
+#endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 unsigned long profile_pc(struct pt_regs *regs)
@@ -239,6 +245,7 @@
 
 	do_timer_interrupt_hook(regs);
 
+#ifndef CONFIG_NEWTOD
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
@@ -261,6 +268,7 @@
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+#endif
 
 	if (MCA_bus) {
 		/* The PS/2 uses level-triggered interrupts.  You can't
@@ -293,11 +301,15 @@
 	 */
 	write_seqlock(&xtime_lock);
 
+#ifndef CONFIG_NEWTOD
 	cur_timer->mark_offset();
+#endif
  
 	do_timer_interrupt(irq, NULL, regs);
 
 	write_sequnlock(&xtime_lock);
+
+	timeofday_interrupt_hook();
 	return IRQ_HANDLED;
 }
 
@@ -318,6 +330,40 @@
 	return retval;
 }
 
+/* arch specific timeofday hooks */
+nsec_t read_persistent_clock(void)
+{
+	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
+}
+
+void sync_persistent_clock(struct timespec ts)
+{
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 */
+	if (ts.tv_sec > last_rtc_update + 660 &&
+	    (ts.tv_nsec / 1000)
+			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
+	    (ts.tv_nsec / 1000)
+			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
+		/* horrible...FIXME */
+		if (efi_enabled) {
+	 		if (efi_set_rtc_mmss(ts.tv_sec) == 0)
+				last_rtc_update = ts.tv_sec;
+			else
+				last_rtc_update = ts.tv_sec - 600;
+		} else if (set_rtc_mmss(ts.tv_sec) == 0)
+			last_rtc_update = ts.tv_sec;
+		else
+			last_rtc_update = ts.tv_sec - 600; /* do it again in 60 s */
+	}
+}
+
+
+
+#ifndef CONFIG_NEWTOD
 static long clock_cmos_diff, sleep_start;
 
 static int timer_suspend(struct sys_device *dev, u32 state)
@@ -351,6 +397,23 @@
 	wall_jiffies += sleep_length;
 	return 0;
 }
+#else /* !CONFIG_NEWTOD */
+static int timer_suspend(struct sys_device *dev, u32 state)
+{
+	timeofday_suspend_hook();
+	return 0;
+}
+
+static int timer_resume(struct sys_device *dev)
+{
+#ifdef CONFIG_HPET_TIMER
+	if (is_hpet_enabled())
+		hpet_reenable();
+#endif
+	timeofday_resume_hook();
+	return 0;
+}
+#endif
 
 static struct sysdev_class timer_sysclass = {
 	.resume = timer_resume,
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	2005-01-24 13:33:59 -08:00
+++ b/arch/i386/lib/delay.c	2005-01-24 13:33:59 -08:00
@@ -23,10 +23,29 @@
 
 extern struct timer_opts* timer;
 
+#ifndef CONFIG_NEWTOD
 void __delay(unsigned long loops)
 {
 	cur_timer->delay(loops);
 }
+#else
+#include <linux/timeofday.h>
+/* XXX - For now just use a simple loop delay
+ *  This has cpufreq issues, but so did the old method.
+ */
+void __delay(unsigned long loops)
+{
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (loops));
+}
+#endif
 
 inline void __const_udelay(unsigned long xloops)
 {
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	2005-01-24 13:33:59 -08:00
+++ b/arch/ppc64/Kconfig	2005-01-24 13:33:59 -08:00
@@ -10,6 +10,10 @@
 	bool
 	default y
 
+config NEWTOD
+	bool
+	default y
+
 config UID16
 	bool
 
diff -Nru a/arch/ppc64/kernel/sys_ppc32.c b/arch/ppc64/kernel/sys_ppc32.c
--- a/arch/ppc64/kernel/sys_ppc32.c	2005-01-24 13:33:59 -08:00
+++ b/arch/ppc64/kernel/sys_ppc32.c	2005-01-24 13:33:59 -08:00
@@ -322,8 +322,10 @@
 
 	ret = do_adjtimex(&txc);
 
+#ifndef CONFIG_NEWTOD
 	/* adjust the conversion of TB to time of day to track adjtimex */
 	ppc_adjtimex();
+#endif
 
 	if(put_user(txc.modes, &utp->modes) ||
 	   __put_user(txc.offset, &utp->offset) ||
diff -Nru a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c	2005-01-24 13:33:59 -08:00
+++ b/arch/ppc64/kernel/time.c	2005-01-24 13:33:59 -08:00
@@ -50,6 +50,7 @@
 #include <linux/profile.h>
 #include <linux/cpu.h>
 #include <linux/security.h>
+#include <linux/timeofday.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -108,6 +109,7 @@
 
 static unsigned adjusting_time = 0;
 
+#ifndef CONFIG_NEWTOD
 static __inline__ void timer_check_rtc(void)
 {
         /*
@@ -141,6 +143,52 @@
                 last_rtc_update += 60;
         }
 }
+#else /* CONFIG_NEWTOD */
+nsec_t read_persistent_clock(void)
+{
+	struct rtc_time tm;
+	unsigned long sec;
+#ifdef CONFIG_PPC_ISERIES
+	if (!piranha_simulator)
+#endif
+		ppc_md.get_boot_time(&tm);
+
+	sec = mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			      tm.tm_hour, tm.tm_min, tm.tm_sec);
+	return (nsec_t)sec * NSEC_PER_SEC;
+}
+void sync_persistent_clock(struct timespec ts)
+{
+	/*
+	 * update the rtc when needed, this should be performed on the
+	 * right fraction of a second. Half or full second ?
+	 * Full second works on mk48t59 clocks, others need testing.
+	 * Note that this update is basically only used through
+	 * the adjtimex system calls. Setting the HW clock in
+	 * any other way is a /dev/rtc and userland business.
+	 * This is still wrong by -0.5/+1.5 jiffies because of the
+	 * timer interrupt resolution and possible delay, but here we
+	 * hit a quantization limit which can only be solved by higher
+	 * resolution timers and decoupling time management from timer
+	 * interrupts. This is also wrong on the clocks
+	 * which require being written at the half second boundary.
+	 * We should have an rtc call that only sets the minutes and
+	 * seconds like on Intel to avoid problems with non UTC clocks.
+	 */
+	if ( ts.tv_sec - last_rtc_update >= 659 &&
+		abs((ts.tv_nsec/1000) - (1000000-1000000/HZ)) < 500000/HZ) {
+		struct rtc_time tm;
+		to_tm(ts.tv_sec+1, &tm);
+		tm.tm_year -= 1900;
+		tm.tm_mon -= 1;
+		if (ppc_md.set_rtc_time(&tm) == 0)
+			last_rtc_update = ts.tv_sec+1;
+		else
+			/* Try again one minute later */
+			last_rtc_update += 60;
+	}
+}
+#endif /* CONFIG_NEWTOD */
 
 /*
  * This version of gettimeofday has microsecond resolution.
@@ -172,12 +220,14 @@
 	tv->tv_usec = usec;
 }
 
+#ifndef CONFIG_NEWTOD
 void do_gettimeofday(struct timeval *tv)
 {
 	__do_gettimeofday(tv, get_tb());
 }
 
 EXPORT_SYMBOL(do_gettimeofday);
+#endif
 
 /* Synchronize xtime with do_gettimeofday */ 
 
@@ -312,11 +362,15 @@
 			write_seqlock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			do_timer(regs);
+#ifndef CONFIG_NEWTOD
 			timer_sync_xtime(lpaca->next_jiffy_update_tb);
 			timer_check_rtc();
+#endif
 			write_sequnlock(&xtime_lock);
+#ifndef CONFIG_NEWTOD
 			if ( adjusting_time && (time_adjust == 0) )
 				ppc_adjtimex();
+#endif
 		}
 		lpaca->next_jiffy_update_tb += tb_ticks_per_jiffy;
 	}
@@ -334,6 +388,7 @@
 	}
 #endif
 
+	timeofday_interrupt_hook();
 	irq_exit();
 
 	return 1;
@@ -350,6 +405,7 @@
 {
 	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
 }
+#ifndef CONFIG_NEWTOD
 
 int do_settimeofday(struct timespec *tv)
 {
@@ -425,6 +481,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif /* !CONFIG_NEWTOD */
 
 void __init time_init(void)
 {
@@ -480,7 +537,9 @@
 	xtime_sync_interval = tb_ticks_per_sec - (tb_ticks_per_sec/8);
 	next_xtime_sync_tb = tb_last_stamp + xtime_sync_interval;
 
+#ifndef CONFIG_NEWTOD
 	time_freq = 0;
+#endif
 
 	xtime.tv_nsec = 0;
 	last_rtc_update = xtime.tv_sec;
@@ -503,6 +562,7 @@
 
 /* #define DEBUG_PPC_ADJTIMEX 1 */
 
+#ifndef CONFIG_NEWTOD
 void ppc_adjtimex(void)
 {
 	unsigned long den, new_tb_ticks_per_sec, tb_ticks, old_xsec, new_tb_to_xs, new_xsec, new_stamp_xsec;
@@ -630,6 +690,7 @@
 	write_sequnlock_irqrestore( &xtime_lock, flags );
 
 }
+#endif /* !CONFIG_NEWTOD */
 
 
 #define TICK_SIZE tick
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2005-01-24 13:33:59 -08:00
+++ b/arch/x86_64/Kconfig	2005-01-24 13:33:59 -08:00
@@ -24,6 +24,10 @@
 	bool
 	default y
 
+config NEWTOD
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2005-01-24 13:33:59 -08:00
+++ b/arch/x86_64/kernel/time.c	2005-01-24 13:33:59 -08:00
@@ -35,6 +35,7 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
+#include <linux/timeofday.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -106,6 +107,7 @@
 
 unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
 
+#ifndef CONFIG_NEWTOD
 /*
  * This version of gettimeofday() has microsecond resolution and better than
  * microsecond precision, as we're using at least a 10 MHz (usually 14.31818
@@ -180,6 +182,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif /* CONFIG_NEWTOD */
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -281,6 +284,7 @@
 }
 
 
+#ifndef CONFIG_NEWTOD
 /* monotonic_clock(): returns # of nanoseconds passed since time_init()
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
@@ -357,6 +361,8 @@
     }
 #endif
 }
+#endif /* CONFIG_NEWTOD */
+
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -373,6 +379,7 @@
 
 	write_seqlock(&xtime_lock);
 
+#ifndef CONFIG_NEWTOD
 	if (vxtime.hpet_address) {
 		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		delay = hpet_readl(HPET_COUNTER) - offset;
@@ -422,6 +429,7 @@
 		handle_lost_ticks(lost, regs);
 		jiffies += lost;
 	}
+#endif /* CONFIG_NEWTOD */
 
 /*
  * Do the timer stuff.
@@ -445,6 +453,7 @@
 		smp_local_timer_interrupt(regs);
 #endif
 
+#ifndef CONFIG_NEWTOD
 /*
  * If we have an externally synchronized Linux clock, then update CMOS clock
  * accordingly every ~11 minutes. set_rtc_mmss() will be called in the jiffy
@@ -458,9 +467,11 @@
 		set_rtc_mmss(xtime.tv_sec);
 		rtc_update = xtime.tv_sec + 660;
 	}
- 
+#endif /* CONFIG_NEWTOD */
+
 	write_sequnlock(&xtime_lock);
 
+	timeofday_interrupt_hook();
 	return IRQ_HANDLED;
 }
 
@@ -560,6 +571,30 @@
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+/* arch specific timeofday hooks */
+nsec_t read_persistent_clock(void)
+{
+	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
+}
+
+void sync_persistent_clock(struct timespec ts)
+{
+	static unsigned long rtc_update = 0;
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. set_rtc_mmss() will
+	 * be called in the jiffy closest to exactly 500 ms before the
+	 * next second. If the update fails, we don't care, as it'll be
+	 * updated on the next turn, and the problem (time way off) isn't
+	 * likely to go away much sooner anyway.
+	 */
+	if (ts.tv_sec > rtc_update &&
+		abs(ts.tv_nsec - 500000000) <= tick_nsec / 2) {
+		set_rtc_mmss(xtime.tv_sec);
+		rtc_update = xtime.tv_sec + 660;
+	}
+}
+
 #ifdef CONFIG_CPU_FREQ
 
 /* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
@@ -955,6 +990,7 @@
 
 __setup("report_lost_ticks", time_setup);
 
+#ifndef CONFIG_NEWTOD
 static long clock_cmos_diff;
 static unsigned long sleep_start;
 
@@ -990,6 +1026,21 @@
 	wall_jiffies += sleep_length;
 	return 0;
 }
+#else /* !CONFIG_NEWTOD */
+static int timer_suspend(struct sys_device *dev, u32 state)
+{
+	timeofday_suspend_hook();
+	return 0;
+}
+
+static int timer_resume(struct sys_device *dev)
+{
+	if (vxtime.hpet_address)
+		hpet_reenable();
+	timeofday_resume_hook();
+	return 0;
+}
+#endif
 
 static struct sysdev_class timer_sysclass = {
 	.resume = timer_resume,
diff -Nru a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
--- a/arch/x86_64/kernel/vsyscall.c	2005-01-24 13:33:59 -08:00
+++ b/arch/x86_64/kernel/vsyscall.c	2005-01-24 13:33:59 -08:00
@@ -171,8 +171,12 @@
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
+/* XXX - disable vsyscall gettimeofday for now */
+#ifndef CONFIG_NEWTOD
 	sysctl_vsyscall = 1; 
-
+#else
+	sysctl_vsyscall = 0;
+#endif
 	return 0;
 }
 
diff -Nru a/include/asm-generic/div64.h b/include/asm-generic/div64.h
--- a/include/asm-generic/div64.h	2005-01-24 13:33:59 -08:00
+++ b/include/asm-generic/div64.h	2005-01-24 13:33:59 -08:00
@@ -55,4 +55,13 @@
 
 #endif /* BITS_PER_LONG */
 
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend,divisor,remainder) \
+({							\
+	u64 result = dividend;				\
+	*remainder = do_div(result,divisor);		\
+	result;						\
+})
+#endif
+
 #endif /* _ASM_GENERIC_DIV64_H */
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	2005-01-24 13:33:59 -08:00
+++ b/include/asm-i386/timer.h	2005-01-24 13:33:59 -08:00
@@ -2,6 +2,13 @@
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
 
+#define TICK_SIZE (tick_nsec / 1000)
+void setup_pit_timer(void);
+/* Modifiers for buggy PIT handling */
+extern int pit_latch_buggy;
+extern int timer_ack;
+
+#ifndef CONFIG_NEWTOD
 /**
  * struct timer_ops - used to define a timer source
  *
@@ -29,18 +36,10 @@
 	struct timer_opts *opts;
 };
 
-#define TICK_SIZE (tick_nsec / 1000)
-
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
-void setup_pit_timer(void);
-
-/* Modifiers for buggy PIT handling */
-
-extern int pit_latch_buggy;
 
 extern struct timer_opts *cur_timer;
-extern int timer_ack;
 
 /* list of externed timers */
 extern struct timer_opts timer_none;
@@ -60,5 +59,6 @@
 
 #ifdef CONFIG_X86_PM_TIMER
 extern struct init_timer_opts timer_pmtmr_init;
+#endif
 #endif
 #endif


