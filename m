Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVD2Www@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVD2Www (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbVD2Www
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:52:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61694 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263046AbVD2Wq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:46:56 -0400
Subject: [RFC][PATCH (2/4)] new timeofday arch specific hooks (v A4)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: albert@users.sourceforge.net, paulus@samba.org, schwidefsky@de.ibm.com,
       mahuja@us.ibm.com, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 15:46:51 -0700
Message-Id: <1114814811.28231.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
        This patch implements the minimal architecture specific hooks to
enable the new time of day subsystem code for i386, x86-64, ia64, ppc32,
ppc64 and s390. It applies on top of my linux-2.6.12-rc2_timeofday-
core_A4 patch and with this patch applied, you can test the new time of
day subsystem. 

Basically it configs in the NEWTOD code and cuts alot of code out of the
build via #ifdefs. I know, I know, #ifdefs' are ugly and bad, and the
final patch will just remove the old code. For now this allows us to be
flexible and easily switch between the two implementations with a single
define.

While there is code for all of the arches above, I am unable to fully
test all of them with the limited time I have to spend on this work.
i386 and x86-64 are reasonably well tested, ppc32 less so and the others
hopefully still compile :)

New in this version:
o s390 arch support! (Big thanks to Martin Schwidefsky!)

Items still on the TODO list:
o Break up each arch into its own patch
o Get rid of #ifdefs

I look forward to your comments and feedback.

thanks
-john

linux-2.6.12-rc2_timeofday-arch_A4.patch
========================================
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-04-29 15:16:59 -07:00
+++ b/arch/i386/Kconfig	2005-04-29 15:16:59 -07:00
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
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2005-04-29 15:16:59 -07:00
+++ b/arch/i386/kernel/apm.c	2005-04-29 15:16:59 -07:00
@@ -224,6 +224,7 @@
 #include <linux/smp_lock.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
+#include <linux/timeofday.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -1205,6 +1206,7 @@
 	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
 
+	timeofday_suspend_hook();
 	/* serialize with the timer interrupt */
 	write_seqlock(&xtime_lock);
 
@@ -1234,6 +1236,7 @@
 	spin_unlock(&i8253_lock);
 	write_sequnlock(&xtime_lock);
 
+	timeofday_resume_hook();
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/i386/kernel/time.c	2005-04-29 15:16:59 -07:00
@@ -68,6 +68,8 @@
 
 #include "io_ports.h"
 
+#include <linux/timeofday.h>
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -117,6 +119,7 @@
 }
 EXPORT_SYMBOL(rtc_cmos_write);
 
+#ifndef CONFIG_NEWTOD
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
@@ -199,20 +202,21 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
 static int set_rtc_mmss(unsigned long nowtime)
 {
 	int retval;
-
-	WARN_ON(irqs_disabled());
+	unsigned long flags;
 
 	/* gets recalled with irq locally disabled */
-	spin_lock_irq(&rtc_lock);
+	/* XXX - does irqsave resolve this? -johnstul */
+	spin_lock_irqsave(&rtc_lock, flags);
 	if (efi_enabled)
 		retval = efi_set_rtc_mmss(nowtime);
 	else
 		retval = mach_set_rtc_mmss(nowtime);
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return retval;
 }
@@ -220,6 +224,7 @@
 
 int timer_ack;
 
+#ifndef CONFIG_NEWTOD
 /* monotonic_clock(): returns # of nanoseconds passed since time_init()
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
@@ -229,6 +234,7 @@
 	return cur_timer->monotonic_clock();
 }
 EXPORT_SYMBOL(monotonic_clock);
+#endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 unsigned long profile_pc(struct pt_regs *regs)
@@ -300,7 +306,9 @@
 	 */
 	write_seqlock(&xtime_lock);
 
+#ifndef CONFIG_NEWTOD
 	cur_timer->mark_offset();
+#endif
  
 	do_timer_interrupt(irq, NULL, regs);
 
@@ -324,6 +332,8 @@
 
 	return retval;
 }
+
+#ifndef CONFIG_NEWTOD
 static void sync_cmos_clock(unsigned long dummy);
 
 static struct timer_list sync_cmos_timer =
@@ -373,7 +383,38 @@
 {
 	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
+#endif
+
+/* arch specific timeofday hooks */
+nsec_t read_persistent_clock(void)
+{
+	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
+}
 
+void sync_persistent_clock(struct timespec ts)
+{
+	static unsigned long last_rtc_update;
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 */
+	if (ts.tv_sec <= last_rtc_update + 660)
+		return;
+
+	if((ts.tv_nsec / 1000) >= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
+		(ts.tv_nsec / 1000) <= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
+		/* horrible...FIXME */
+		if (set_rtc_mmss(ts.tv_sec) == 0)
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
@@ -407,6 +448,23 @@
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
@@ -436,17 +494,21 @@
 /* Duplicate of time_init() below, with hpet_enable part added */
 static void __init hpet_time_init(void)
 {
+#ifndef CONFIG_NEWTOD
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	set_normalized_timespec(&wall_to_monotonic,
 		-xtime.tv_sec, -xtime.tv_nsec);
+#endif
 
 	if (hpet_enable() >= 0) {
 		printk("Using HPET for base-timer\n");
 	}
 
+#ifndef CONFIG_NEWTOD
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
+#endif
 
 	time_init_hook();
 }
@@ -464,6 +526,7 @@
 		return;
 	}
 #endif
+#ifndef CONFIG_NEWTOD
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	set_normalized_timespec(&wall_to_monotonic,
@@ -471,6 +534,7 @@
 
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
+#endif
 
 	time_init_hook();
 }
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	2005-04-29 15:16:59 -07:00
+++ b/arch/i386/lib/delay.c	2005-04-29 15:16:59 -07:00
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
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	2005-04-29 15:16:59 -07:00
+++ b/arch/ia64/Kconfig	2005-04-29 15:16:59 -07:00
@@ -18,6 +18,10 @@
 	  page at <http://www.linuxia64.org/> and a mailing list at
 	  <linux-ia64@vger.kernel.org>.
 
+config NEWTOD
+        bool
+        default y
+
 config 64BIT
 	bool
 	default y
@@ -36,7 +40,7 @@
 
 config TIME_INTERPOLATION
 	bool
-	default y
+	default n
 
 config EFI
 	bool
diff -Nru a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
--- a/arch/ia64/kernel/asm-offsets.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ia64/kernel/asm-offsets.c	2005-04-29 15:16:59 -07:00
@@ -222,6 +222,7 @@
 	DEFINE(IA64_MCA_CPU_INIT_STACK_OFFSET,
 	       offsetof (struct ia64_mca_cpu, init_stack));
 	BLANK();
+#ifndef CONFIG_NEWTOD
 	/* used by fsys_gettimeofday in arch/ia64/kernel/fsys.S */
 	DEFINE(IA64_TIME_INTERPOLATOR_ADDRESS_OFFSET, offsetof (struct time_interpolator, addr));
 	DEFINE(IA64_TIME_INTERPOLATOR_SOURCE_OFFSET, offsetof (struct time_interpolator, source));
@@ -235,5 +236,6 @@
 	DEFINE(IA64_TIME_SOURCE_CPU, TIME_SOURCE_CPU);
 	DEFINE(IA64_TIME_SOURCE_MMIO64, TIME_SOURCE_MMIO64);
 	DEFINE(IA64_TIME_SOURCE_MMIO32, TIME_SOURCE_MMIO32);
+#endif /* CONFIG_NEWTOD */
 	DEFINE(IA64_TIMESPEC_TV_NSEC_OFFSET, offsetof (struct timespec, tv_nsec));
 }
diff -Nru a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
--- a/arch/ia64/kernel/fsys.S	2005-04-29 15:16:59 -07:00
+++ b/arch/ia64/kernel/fsys.S	2005-04-29 15:16:59 -07:00
@@ -145,6 +145,7 @@
 	FSYS_RETURN
 END(fsys_set_tid_address)
 
+#ifndef CONFIG_NEWTOD
 /*
  * Ensure that the time interpolator structure is compatible with the asm code
  */
@@ -326,6 +327,7 @@
 EX(.fail_efault, st8 [r31] = r9)
 EX(.fail_efault, st8 [r23] = r21)
 	FSYS_RETURN
+#endif /* !CONFIG_NEWTOD */
 .fail_einval:
 	mov r8 = EINVAL
 	mov r10 = -1
@@ -334,6 +336,7 @@
 	mov r8 = EFAULT
 	mov r10 = -1
 	FSYS_RETURN
+#ifndef CONFIG_NEWTOD
 END(fsys_gettimeofday)
 
 ENTRY(fsys_clock_gettime)
@@ -347,6 +350,7 @@
 	shl r30 = r32,15
 	br.many .gettime
 END(fsys_clock_gettime)
+#endif /* !CONFIG_NEWTOD */
 
 /*
  * long fsys_rt_sigprocmask (int how, sigset_t *set, sigset_t *oset, size_t sigsetsize).
@@ -687,7 +691,11 @@
 	data8 0				// setrlimit
 	data8 0				// getrlimit		// 1085
 	data8 0				// getrusage
+#ifdef CONFIG_NEWTOD
+	data8 0				// gettimeofday
+#else
 	data8 fsys_gettimeofday		// gettimeofday
+#endif
 	data8 0				// settimeofday
 	data8 0				// select
 	data8 0				// poll			// 1090
@@ -854,7 +862,11 @@
 	data8 0				// timer_getoverrun
 	data8 0				// timer_delete
 	data8 0				// clock_settime
+#ifdef CONFIG_NEWTOD
+	data8 0				// clock_gettime
+#else
 	data8 fsys_clock_gettime	// clock_gettime
+#endif
 	data8 0				// clock_getres		// 1255
 	data8 0				// clock_nanosleep
 	data8 0				// fstatfs64
diff -Nru a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
--- a/arch/ia64/kernel/time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ia64/kernel/time.c	2005-04-29 15:16:59 -07:00
@@ -21,6 +21,7 @@
 #include <linux/efi.h>
 #include <linux/profile.h>
 #include <linux/timex.h>
+#include <linux/timeofday.h>
 
 #include <asm/machvec.h>
 #include <asm/delay.h>
@@ -45,11 +46,13 @@
 
 #endif
 
+#ifndef CONFIG_NEWTOD
 static struct time_interpolator itc_interpolator = {
 	.shift = 16,
 	.mask = 0xffffffffffffffffLL,
 	.source = TIME_SOURCE_CPU
 };
+#endif /* CONFIG_NEWTOD */
 
 static irqreturn_t
 timer_interrupt (int irq, void *dev_id, struct pt_regs *regs)
@@ -211,6 +214,7 @@
 	local_cpu_data->nsec_per_cyc = ((NSEC_PER_SEC<<IA64_NSEC_PER_CYC_SHIFT)
 					+ itc_freq/2)/itc_freq;
 
+#ifndef CONFIG_NEWTOD
 	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
 		itc_interpolator.frequency = local_cpu_data->itc_freq;
 		itc_interpolator.drift = itc_drift;
@@ -229,6 +233,7 @@
 #endif
 		register_time_interpolator(&itc_interpolator);
 	}
+#endif /* CONFIG_NEWTOD */
 
 	/* Setup the CPU local timer tick */
 	ia64_cpu_local_tick();
@@ -253,3 +258,17 @@
 	 */
 	set_normalized_timespec(&wall_to_monotonic, -xtime.tv_sec, -xtime.tv_nsec);
 }
+
+/* arch specific timeofday hooks */
+nsec_t read_persistent_clock(void)
+{
+        struct timespec ts;
+        efi_gettimeofday(&ts);
+        return (nsec_t)(ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec);
+}
+
+void sync_persistent_clock(struct timespec ts)
+{
+	/* XXX - Something should go here, no? */
+}
+
diff -Nru a/arch/ia64/sn/kernel/sn2/timer.c b/arch/ia64/sn/kernel/sn2/timer.c
--- a/arch/ia64/sn/kernel/sn2/timer.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ia64/sn/kernel/sn2/timer.c	2005-04-29 15:16:59 -07:00
@@ -19,6 +19,7 @@
 #include <asm/sn/shub_mmr.h>
 #include <asm/sn/clksupport.h>
 
+#ifndef CONFIG_NEWTOD
 extern unsigned long sn_rtc_cycles_per_second;
 
 static struct time_interpolator sn2_interpolator = {
@@ -34,3 +35,8 @@
 	sn2_interpolator.addr = RTC_COUNTER_ADDR;
 	register_time_interpolator(&sn2_interpolator);
 }
+#else
+void __init sn_timer_init(void)
+{
+}
+#endif
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-04-29 15:16:59 -07:00
+++ b/arch/ppc/Kconfig	2005-04-29 15:16:59 -07:00
@@ -8,6 +8,10 @@
 	bool
 	default y
 
+config NEWTOD
+	bool
+	default y
+
 config UID16
 	bool
 
diff -Nru a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ppc/kernel/time.c	2005-04-29 15:16:59 -07:00
@@ -57,6 +57,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/timeofday.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -95,6 +96,46 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
+#ifdef CONFIG_NEWTOD
+nsec_t read_persistent_clock(void)
+{
+	if (ppc_md.get_rtc_time) {
+		return (nsec_t)ppc_md.get_rtc_time() * NSEC_PER_SEC;
+	} else {
+		printk(KERN_ERR "ppc_md.get_rtc_time does not exist???\n");
+		return 0;
+	}
+}
+
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
+	if ( ppc_md.set_rtc_time && ts.tv_sec - last_rtc_update >= 659 &&
+		abs((ts.tv_nsec/1000) - (1000000-1000000/HZ)) < 500000/HZ) {
+		if (ppc_md.set_rtc_time(ts.tv_sec + 1 + time_offset) == 0)
+			last_rtc_update = ts.tv_sec+1;
+		else
+			/* Try again one minute later */
+			last_rtc_update += 60;
+	}
+}
+#endif /* CONFIG_NEWTOD */
+
 /* Timer interrupt helper function */
 static inline int tb_delta(unsigned *jiffy_stamp) {
 	int delta;
@@ -152,6 +193,7 @@
 		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
 
+#ifndef CONFIG_NEWTOD
 		/*
 		 * update the rtc when needed, this should be performed on the
 		 * right fraction of a second. Half or full second ?
@@ -178,6 +220,7 @@
 				/* Try again one minute later */
 				last_rtc_update += 60;
 		}
+#endif
 		write_sequnlock(&xtime_lock);
 	}
 	if ( !disarm_decr[smp_processor_id()] )
@@ -193,6 +236,7 @@
 /*
  * This version of gettimeofday has microsecond resolution.
  */
+#ifndef CONFIG_NEWTOD
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
@@ -281,6 +325,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
 /* This function is only called on the boot processor */
 void __init time_init(void)
@@ -422,6 +467,8 @@
 	return mlt;
 }
 
+/* XXX - sched_clock mess needs to be sorted out */
+#ifndef CONFIG_NEWTOD
 unsigned long long sched_clock(void)
 {
 	unsigned long lo, hi, hi2;
@@ -445,3 +492,4 @@
 	}
 	return tb;
 }
+#endif
diff -Nru a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ppc/platforms/chrp_time.c	2005-04-29 15:16:59 -07:00
@@ -115,8 +115,10 @@
 	chrp_cmos_clock_write(save_control, RTC_CONTROL);
 	chrp_cmos_clock_write(save_freq_select, RTC_FREQ_SELECT);
 
+#ifndef CONFIG_NEWTOD
 	if ( (time_state == TIME_ERROR) || (time_state == TIME_BAD) )
 		time_state = TIME_OK;
+#endif
 	spin_unlock(&rtc_lock);
 	return 0;
 }
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	2005-04-29 15:16:59 -07:00
+++ b/arch/ppc64/Kconfig	2005-04-29 15:16:59 -07:00
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
--- a/arch/ppc64/kernel/sys_ppc32.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ppc64/kernel/sys_ppc32.c	2005-04-29 15:16:59 -07:00
@@ -322,8 +322,10 @@
 
 	ret = do_adjtimex(&txc);
 
+#ifndef CONFIG_NEWTOD
 	/* adjust the conversion of TB to time of day to track adjtimex */
 	ppc_adjtimex();
+#endif
 
 	if(put_user(txc.modes, &utp->modes) ||
 	   __put_user(txc.offset, &utp->offset) ||
diff -Nru a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/ppc64/kernel/time.c	2005-04-29 15:16:59 -07:00
@@ -50,6 +50,7 @@
 #include <linux/profile.h>
 #include <linux/cpu.h>
 #include <linux/security.h>
+#include <linux/timeofday.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -107,6 +108,7 @@
 
 static unsigned adjusting_time = 0;
 
+#ifndef CONFIG_NEWTOD
 static __inline__ void timer_check_rtc(void)
 {
         /*
@@ -140,6 +142,52 @@
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
@@ -171,12 +219,14 @@
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
 
@@ -350,11 +400,15 @@
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			timer_recalc_offset(lpaca->next_jiffy_update_tb);
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
@@ -385,6 +439,7 @@
 	return 1;
 }
 
+#ifndef CONFIG_NEWTOD
 /*
  * Scheduler clock - returns current time in nanosec units.
  *
@@ -473,6 +528,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif /* !CONFIG_NEWTOD */
 
 void __init time_init(void)
 {
@@ -525,7 +581,9 @@
 	systemcfg->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
 	systemcfg->tb_to_xs = tb_to_xs;
 
+#ifndef CONFIG_NEWTOD
 	time_freq = 0;
+#endif
 
 	xtime.tv_nsec = 0;
 	last_rtc_update = xtime.tv_sec;
@@ -548,6 +606,7 @@
 
 /* #define DEBUG_PPC_ADJTIMEX 1 */
 
+#ifndef CONFIG_NEWTOD
 void ppc_adjtimex(void)
 {
 	unsigned long den, new_tb_ticks_per_sec, tb_ticks, old_xsec, new_tb_to_xs, new_xsec, new_stamp_xsec;
@@ -671,6 +730,7 @@
 	write_sequnlock_irqrestore( &xtime_lock, flags );
 
 }
+#endif /* !CONFIG_NEWTOD */
 
 
 #define TICK_SIZE tick
diff -Nru a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2005-04-29 15:16:59 -07:00
+++ b/arch/s390/Kconfig	2005-04-29 15:16:59 -07:00
@@ -127,6 +127,10 @@
 	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
 	  in 64 bit mode. Everybody wants this; say Y.
 
+config NEWTOD
+	bool
+	default y
+
 comment "Code generation options"
 
 choice
diff -Nru a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
--- a/arch/s390/kernel/time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/s390/kernel/time.c	2005-04-29 15:16:59 -07:00
@@ -29,6 +29,7 @@
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
+#include <linux/timeofday.h>
 
 #include <asm/uaccess.h>
 #include <asm/delay.h>
@@ -89,6 +90,7 @@
 	return (unsigned long) now;
 }
 
+#ifndef CONFIG_NEWTOD
 /*
  * This version of gettimeofday has microsecond resolution.
  */
@@ -149,7 +151,27 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
+nsec_t read_persistent_clock(void)
+{
+	unsigned long long nsecs;
+	/*
+	 * The TOD clock counts from 1900-01-01. Bit 2^12 of the
+	 * 64 bit register is micro-seconds.
+	 */
+	nsecs = get_clock() - 0x7d91048bca000000LL;
+	/*
+	 * Calc nsecs * 1000 / 4096 without overflow and
+	 * without loosing too many bits.
+	 */
+	nsecs = (((((nsecs >> 3) * 5) >> 3) * 5) >> 3) * 5;
+	return (nsec_t) nsecs;
+}
+
+void sync_persistent_clock(struct timespec ts)
+{
+}
 
 #ifdef CONFIG_PROFILING
 #define s390_do_profile(regs)	profile_tick(CPU_PROFILING, regs)
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2005-04-29 15:16:59 -07:00
+++ b/arch/x86_64/Kconfig	2005-04-29 15:16:59 -07:00
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
--- a/arch/x86_64/kernel/time.c	2005-04-29 15:16:59 -07:00
+++ b/arch/x86_64/kernel/time.c	2005-04-29 15:16:59 -07:00
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
@@ -458,7 +467,8 @@
 		set_rtc_mmss(xtime.tv_sec);
 		rtc_update = xtime.tv_sec + 660;
 	}
- 
+#endif /* CONFIG_NEWTOD */
+
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
@@ -477,6 +487,7 @@
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }
 
+#ifndef CONFIG_NEWTOD
 unsigned long long sched_clock(void)
 {
 	unsigned long a = 0;
@@ -498,6 +509,7 @@
 	rdtscll(a);
 	return cycles_2_ns(a);
 }
+#endif /* CONFIG_NEWTOD */
 
 unsigned long get_cmos_time(void)
 {
@@ -559,6 +571,30 @@
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
@@ -954,6 +990,7 @@
 
 __setup("report_lost_ticks", time_setup);
 
+#ifndef CONFIG_NEWTOD
 static long clock_cmos_diff;
 static unsigned long sleep_start;
 
@@ -991,6 +1028,24 @@
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
+	else
+		i8254_timer_resume();
+
+	timeofday_resume_hook();
+	return 0;
+}
+#endif
 
 static struct sysdev_class timer_sysclass = {
 	.resume = timer_resume,
diff -Nru a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
--- a/arch/x86_64/kernel/vsyscall.c	2005-04-29 15:16:59 -07:00
+++ b/arch/x86_64/kernel/vsyscall.c	2005-04-29 15:16:59 -07:00
@@ -217,8 +217,13 @@
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
+/* XXX - disable vsyscall gettimeofday for now */
+#ifndef CONFIG_NEWTOD
 	sysctl_vsyscall = 1;
 	register_sysctl_table(kernel_root_table2, 0);
+#else
+	sysctl_vsyscall = 0;
+#endif
 	return 0;
 }
 
diff -Nru a/include/asm-generic/div64.h b/include/asm-generic/div64.h
--- a/include/asm-generic/div64.h	2005-04-29 15:16:59 -07:00
+++ b/include/asm-generic/div64.h	2005-04-29 15:16:59 -07:00
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
diff -Nru a/include/asm-ppc64/time.h b/include/asm-ppc64/time.h
--- a/include/asm-ppc64/time.h	2005-04-29 15:16:59 -07:00
+++ b/include/asm-ppc64/time.h	2005-04-29 15:16:59 -07:00
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/paca.h>
 #include <asm/iSeries/HvCall.h>
+#include <asm/percpu.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;
diff -Nru a/include/linux/timeofday.h b/include/linux/timeofday.h
--- a/include/linux/timeofday.h	2005-04-29 15:16:59 -07:00
+++ b/include/linux/timeofday.h	2005-04-29 15:16:59 -07:00
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/jiffies.h>	/* For div_long_long_rem */
 #include <asm/div64.h>
 
 #ifdef CONFIG_NEWTOD


