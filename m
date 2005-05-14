Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVENAei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVENAei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVENAee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:34:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5763 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262642AbVENAW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:22:26 -0400
Subject: [RFC][PATCH (5/7)] new timeofday ia64,ppc32,ppc64 and s390 arch
	specific hooks (v A5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1116030058.26454.10.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 17:22:19 -0700
Message-Id: <1116030139.26454.13.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements the minimal architecture specific hooks to enable
the new time of day subsystem code for ia64, ppc32, ppc64 and s390. It
applies on top of my linux-2.6.12-rc4_timeofday-core_A5 patch and with
this patch applied, you can test the new time of day subsystem on these
arches.

	Basically it configs in the NEWTOD code and cuts alot of code out of
the build via #ifdefs. I know, I know, #ifdefs' are ugly and bad, and
the final patch for each arch will just remove the old code. Don't
worry, I'm not going to push this to Andrew anytime soon. For now this
allows us to be flexible and easily switch between the two
implementations with a single define.

This code is largely untested, but I tried to make sure ia64, ppc32 and
ppc64 compiled without warnings.

I'd like to thank the following folks for their work in providing these
arch implementations:
o Max Asbock for the ia64 work
o Darrick Wong for the ppc32 work
o Martin Schwidefsky! for the s390 work

Items still on the TODO list:
o More testing
o arch specific vsyscall/fsyscall interface
o other arch ports

I look forward to your comments and feedback.

thanks
-john

linux-2.6.12-rc4_timeofday-arch-other_A5.patch
==============================================
Index: arch/ia64/Kconfig
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ia64/Kconfig  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ia64/Kconfig  (mode:100644)
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
Index: arch/ia64/kernel/asm-offsets.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ia64/kernel/asm-offsets.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ia64/kernel/asm-offsets.c  (mode:100644)
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
Index: arch/ia64/kernel/cyclone.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ia64/kernel/cyclone.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ia64/kernel/cyclone.c  (mode:100644)
@@ -17,7 +17,7 @@
 	use_cyclone = 1;
 }
 
-
+#ifndef CONFIG_NEWTOD
 struct time_interpolator cyclone_interpolator = {
 	.source =	TIME_SOURCE_MMIO64,
 	.shift =	16,
@@ -107,3 +107,4 @@
 }
 
 __initcall(init_cyclone_clock);
+#endif /* !CONFIG_NEWTOD */
Index: arch/ia64/kernel/fsys.S
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ia64/kernel/fsys.S  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ia64/kernel/fsys.S  (mode:100644)
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
@@ -689,7 +693,11 @@
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
@@ -856,7 +864,11 @@
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
Index: arch/ia64/kernel/time.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ia64/kernel/time.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ia64/kernel/time.c  (mode:100644)
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
Index: arch/ia64/sn/kernel/sn2/timer.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ia64/sn/kernel/sn2/timer.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ia64/sn/kernel/sn2/timer.c  (mode:100644)
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
Index: arch/ppc/Kconfig
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ppc/Kconfig  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ppc/Kconfig  (mode:100644)
@@ -8,6 +8,10 @@
 	bool
 	default y
 
+config NEWTOD
+	bool
+	default y
+
 config UID16
 	bool
 
Index: arch/ppc/kernel/time.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ppc/kernel/time.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ppc/kernel/time.c  (mode:100644)
@@ -57,6 +57,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/timeofday.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -76,6 +77,8 @@
 
 extern struct timezone sys_tz;
 
+static unsigned long time_offset;
+
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
 
@@ -93,6 +96,46 @@
 
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
@@ -150,6 +193,7 @@
 		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
 
+#ifndef CONFIG_NEWTOD
 		/*
 		 * update the rtc when needed, this should be performed on the
 		 * right fraction of a second. Half or full second ?
@@ -176,6 +220,7 @@
 				/* Try again one minute later */
 				last_rtc_update += 60;
 		}
+#endif
 		write_sequnlock(&xtime_lock);
 	}
 	if ( !disarm_decr[smp_processor_id()] )
@@ -191,6 +236,7 @@
 /*
  * This version of gettimeofday has microsecond resolution.
  */
+#ifndef CONFIG_NEWTOD
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
@@ -278,6 +324,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
 /* This function is only called on the boot processor */
 void __init time_init(void)
Index: arch/ppc64/Kconfig
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ppc64/Kconfig  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ppc64/Kconfig  (mode:100644)
@@ -10,6 +10,10 @@
 	bool
 	default y
 
+config NEWTOD
+	bool
+	default y
+
 config UID16
 	bool
 
Index: arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ppc64/kernel/sys_ppc32.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ppc64/kernel/sys_ppc32.c  (mode:100644)
@@ -322,8 +322,10 @@
 
 	ret = do_adjtimex(&txc);
 
+#ifndef CONFIG_NEWTOD
 	/* adjust the conversion of TB to time of day to track adjtimex */
 	ppc_adjtimex();
+#endif
 
 	if(put_user(txc.modes, &utp->modes) ||
 	   __put_user(txc.offset, &utp->offset) ||
Index: arch/ppc64/kernel/time.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/ppc64/kernel/time.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/ppc64/kernel/time.c  (mode:100644)
@@ -50,6 +50,7 @@
 #include <linux/profile.h>
 #include <linux/cpu.h>
 #include <linux/security.h>
+#include <linux/timeofday.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -105,6 +106,7 @@
 
 void ppc_adjtimex(void);
 
+#ifndef CONFIG_NEWTOD
 static unsigned adjusting_time = 0;
 
 static __inline__ void timer_check_rtc(void)
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
@@ -397,6 +451,7 @@
 	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
 }
 
+#ifndef CONFIG_NEWTOD
 int do_settimeofday(struct timespec *tv)
 {
 	time_t wtm_sec, new_sec = tv->tv_sec;
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
Index: arch/s390/Kconfig
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/s390/Kconfig  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/s390/Kconfig  (mode:100644)
@@ -127,6 +127,10 @@
 	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
 	  in 64 bit mode. Everybody wants this; say Y.
 
+config NEWTOD
+	bool
+	default y
+
 comment "Code generation options"
 
 choice
Index: arch/s390/kernel/time.c
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/arch/s390/kernel/time.c  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/arch/s390/kernel/time.c  (mode:100644)
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
+
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
 
+void sync_persistent_clock(struct timespec ts)
+{
+}
 
 #ifdef CONFIG_PROFILING
 #define s390_do_profile(regs)	profile_tick(CPU_PROFILING, regs)
Index: include/asm-ppc64/time.h
===================================================================
--- d68b09f31fa98801ead715e9281a2e4676b770a5/include/asm-ppc64/time.h  (mode:100644)
+++ f86144e80c5de25e7bea135a07a5635205be4cf3/include/asm-ppc64/time.h  (mode:100644)
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/paca.h>
 #include <asm/iSeries/HvCall.h>
+#include <asm/percpu.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;


