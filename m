Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbULHCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbULHCCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbULHCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:02:49 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34757 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261975AbULHB5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:57:49 -0500
Subject: [RFC] new timeofday arch specific hooks (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <1102470997.1281.30.camel@cog.beaverton.ibm.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <1102470997.1281.30.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1102471064.1281.32.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 07 Dec 2004 17:57:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements the minimal architecture specific hooks to enable
the new time of day subsystem code for i386 and x86-64. It applies on
top of my linux-2.6.10-rc3_timeofday-core_A1 patch and with this patch
applied, you can test the new time of day subsystem. 

	Basically it adds the call to timeofday_interrupt_hook() and cuts alot
of code out of the build via #ifdefs. I know, I know, #ifdefs' are ugly
and bad, and the final patch will just remove the old code. For now this
allows us to be flexible and easily switch between the two
implementations.

	The only new code is the sync_persistant_clock() function which is
mostly ripped out of do_timer_interrupt(). Pretty un-interesting.

New in this version:
o x86-64 hooks
o generic div_long_long_rem implementation (swiped from jiffies.h)

I look forward to your comments and feedback.

thanks
-john

linux-2.6.9-rc1_timeofday-arch_A1.patch
=======================================
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-12-07 16:47:46 -08:00
+++ b/arch/i386/Kconfig	2004-12-07 16:47:46 -08:00
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
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2004-12-07 16:47:46 -08:00
+++ b/arch/i386/kernel/time.c	2004-12-07 16:47:46 -08:00
@@ -67,6 +67,8 @@
 
 #include "io_ports.h"
 
+#include <linux/timeofday.h>
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -87,6 +89,7 @@
 
 struct timer_opts *cur_timer = &timer_none;
 
+#ifndef CONFIG_NEWTOD
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
@@ -169,6 +172,7 @@
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#endif
 
 static int set_rtc_mmss(unsigned long nowtime)
 {
@@ -194,11 +198,39 @@
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
+
+void sync_persistant_clock(struct timespec ts)
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
+
+}
 
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 unsigned long profile_pc(struct pt_regs *regs)
@@ -238,6 +270,7 @@
 
 	do_timer_interrupt_hook(regs);
 
+#ifndef CONFIG_NEWTOD
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
@@ -260,6 +293,7 @@
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+#endif
 
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
@@ -294,11 +328,15 @@
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
 
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2004-12-07 16:47:46 -08:00
+++ b/arch/x86_64/Kconfig	2004-12-07 16:47:46 -08:00
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
--- a/arch/x86_64/kernel/time.c	2004-12-07 16:47:46 -08:00
+++ b/arch/x86_64/kernel/time.c	2004-12-07 16:47:46 -08:00
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
@@ -357,6 +361,26 @@
     }
 #endif
 }
+#endif /* CONFIG_NEWTOD */
+
+
+void sync_persistant_clock(struct timespec ts)
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
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -373,6 +397,7 @@
 
 	write_seqlock(&xtime_lock);
 
+#ifndef CONFIG_NEWTOD
 	if (vxtime.hpet_address) {
 		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		delay = hpet_readl(HPET_COUNTER) - offset;
@@ -422,6 +447,7 @@
 		handle_lost_ticks(lost, regs);
 		jiffies += lost;
 	}
+#endif /* CONFIG_NEWTOD */
 
 /*
  * Do the timer stuff.
@@ -445,6 +471,7 @@
 		smp_local_timer_interrupt(regs);
 #endif
 
+#ifndef CONFIG_NEWTOD
 /*
  * If we have an externally synchronized Linux clock, then update CMOS clock
  * accordingly every ~11 minutes. set_rtc_mmss() will be called in the jiffy
@@ -458,9 +485,11 @@
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
 
diff -Nru a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
--- a/arch/x86_64/kernel/vsyscall.c	2004-12-07 16:47:46 -08:00
+++ b/arch/x86_64/kernel/vsyscall.c	2004-12-07 16:47:46 -08:00
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
--- a/include/asm-generic/div64.h	2004-12-07 16:47:46 -08:00
+++ b/include/asm-generic/div64.h	2004-12-07 16:47:46 -08:00
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


