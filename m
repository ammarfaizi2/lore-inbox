Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbWHUPDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWHUPDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWHUPDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:03:50 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:38094 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030511AbWHUPDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:03:48 -0400
Date: Tue, 22 Aug 2006 00:05:30 +0900 (JST)
Message-Id: <20060822.000530.12190855.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org
Subject: [PATCH -mm] kill wall_jiffies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend, adding CC: linux-arch@vger.kernel.org)

With 2.6.18-rc4-mm2, now wall_jiffies will always be the same as jiffies.
So we can kill wall_jiffies completely.

This is just a cleanup and logically should not change any real
behavior except for one thing: RTC updating code in (old) ppc and
xtensa use a condition "jiffies - wall_jiffies == 1".  This condition
is never met so I suppose it is just a bug.  I just remove that
condition only instead of kill the whole "if" block.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/alpha/kernel/time.c                |   15 +++++----------
 arch/arm/kernel/time.c                  |   10 +---------
 arch/arm26/kernel/time.c                |   12 ++----------
 arch/cris/kernel/time.c                 |    7 -------
 arch/frv/kernel/time.c                  |   11 -----------
 arch/i386/kernel/time.c                 |    3 ---
 arch/ia64/kernel/time.c                 |    2 --
 arch/m32r/kernel/time.c                 |   11 +----------
 arch/m68k/kernel/time.c                 |   16 +++-------------
 arch/m68knommu/kernel/time.c            |    7 +------
 arch/mips/galileo-boards/ev96100/time.c |    1 -
 arch/mips/kernel/time.c                 |   12 +-----------
 arch/mips/sgi-ip27/ip27-timer.c         |    2 --
 arch/parisc/kernel/time.c               |    7 ++-----
 arch/powerpc/kernel/time.c              |    7 -------
 arch/ppc/kernel/time.c                  |   11 +++--------
 arch/s390/kernel/time.c                 |    4 ----
 arch/sh/kernel/time.c                   |   10 +---------
 arch/sh64/kernel/time.c                 |   12 +-----------
 arch/sparc/kernel/pcic.c                |   16 ++--------------
 arch/sparc/kernel/time.c                |   18 +++---------------
 arch/sparc64/kernel/time.c              |    2 --
 arch/x86_64/kernel/time.c               |   12 +++---------
 arch/x86_64/kernel/vmlinux.lds.S        |    3 ---
 arch/x86_64/kernel/vsyscall.c           |    3 +--
 arch/xtensa/kernel/time.c               |   13 +++----------
 include/asm-x86_64/vsyscall.h           |    3 ---
 kernel/timer.c                          |    6 +-----
 28 files changed, 34 insertions(+), 202 deletions(-)

diff -urNp linux-2.6.18-rc4-mm2.org/arch/alpha/kernel/time.c linux-2.6.18-rc4-mm2/arch/alpha/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/alpha/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/alpha/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -54,8 +54,6 @@
 #include "proto.h"
 #include "irq_impl.h"
 
-extern unsigned long wall_jiffies;	/* kernel/timer.c */
-
 static int set_rtc_mmss(unsigned long);
 
 DEFINE_SPINLOCK(rtc_lock);
@@ -413,7 +411,7 @@ void
 do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	unsigned long sec, usec, lost, seq;
+	unsigned long sec, usec, seq;
 	unsigned long delta_cycles, delta_usec, partial_tick;
 
 	do {
@@ -423,14 +421,13 @@ do_gettimeofday(struct timeval *tv)
 		sec = xtime.tv_sec;
 		usec = (xtime.tv_nsec / 1000);
 		partial_tick = state.partial_tick;
-		lost = jiffies - wall_jiffies;
 
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 #ifdef CONFIG_SMP
 	/* Until and unless we figure out how to get cpu cycle counters
 	   in sync and keep them there, we can't use the rpcc tricks.  */
-	delta_usec = lost * (1000000 / HZ);
+	delta_usec = 0;
 #else
 	/*
 	 * usec = cycles * ticks_per_cycle * 2**48 * 1e6 / (2**48 * ticks)
@@ -446,8 +443,7 @@ do_gettimeofday(struct timeval *tv)
 	 */
 
 	delta_usec = (delta_cycles * state.scaled_ticks_per_cycle 
-		      + partial_tick
-		      + (lost << FIX_SHIFT)) * 15625;
+		      + partial_tick) * 15625;
 	delta_usec = ((delta_usec / ((1UL << (FIX_SHIFT-6-1)) * HZ)) + 1) / 2;
 #endif
 
@@ -480,12 +476,11 @@ do_settimeofday(struct timespec *tv)
 	   time.  Without this, a full-tick error is possible.  */
 
 #ifdef CONFIG_SMP
-	delta_nsec = (jiffies - wall_jiffies) * (NSEC_PER_SEC / HZ);
+	delta_nsec = 0;
 #else
 	delta_nsec = rpcc() - state.last_time;
 	delta_nsec = (delta_nsec * state.scaled_ticks_per_cycle 
-		      + state.partial_tick
-		      + ((jiffies - wall_jiffies) << FIX_SHIFT)) * 15625;
+		      + state.partial_tick) * 15625;
 	delta_nsec = ((delta_nsec / ((1UL << (FIX_SHIFT-6-1)) * HZ)) + 1) / 2;
 	delta_nsec *= 1000;
 #endif
diff -urNp linux-2.6.18-rc4-mm2.org/arch/arm/kernel/time.c linux-2.6.18-rc4-mm2/arch/arm/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/arm/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/arm/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -37,8 +37,6 @@
  */
 struct sys_timer *system_timer;
 
-extern unsigned long wall_jiffies;
-
 /* this needs a better home */
 DEFINE_SPINLOCK(rtc_lock);
 
@@ -234,16 +232,11 @@ void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
 	unsigned long seq;
-	unsigned long usec, sec, lost;
+	unsigned long usec, sec;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = system_timer->offset();
-
-		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * USECS_PER_JIFFY;
-
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec / 1000;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
@@ -276,7 +269,6 @@ int do_settimeofday(struct timespec *tv)
 	 * done, and then undo it!
 	 */
 	nsec -= system_timer->offset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/arm26/kernel/time.c linux-2.6.18-rc4-mm2/arch/arm26/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/arm26/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/arm26/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -33,8 +33,6 @@
 #include <asm/irq.h>
 #include <asm/ioc.h>
 
-extern unsigned long wall_jiffies;
-
 /* this needs a better home */
 DEFINE_SPINLOCK(rtc_lock);
 
@@ -136,16 +134,11 @@ void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
 	unsigned long seq;
-	unsigned long usec, sec, lost;
+	unsigned long usec, sec;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = gettimeoffset();
-
-		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * USECS_PER_JIFFY;
-
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec / 1000;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
@@ -174,8 +167,7 @@ int do_settimeofday(struct timespec *tv)
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * done, and then undo it!
 	 */
-	tv->tv_nsec -= 1000 * (gettimeoffset() +
-			(jiffies - wall_jiffies) * USECS_PER_JIFFY);
+	tv->tv_nsec -= 1000 * gettimeoffset();
 
 	while (tv->tv_nsec < 0) {
 		tv->tv_nsec += NSEC_PER_SEC;
diff -urNp linux-2.6.18-rc4-mm2.org/arch/cris/kernel/time.c linux-2.6.18-rc4-mm2/arch/cris/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/cris/kernel/time.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/cris/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -37,7 +37,6 @@ int have_rtc;  /* used to remember if we
 
 #define TICK_SIZE tick
 
-extern unsigned long wall_jiffies;
 extern unsigned long loops_per_jiffy; /* init/main.c */
 unsigned long loops_per_usec;
 
@@ -58,11 +57,6 @@ void do_gettimeofday(struct timeval *tv)
 	local_irq_save(flags);
 	local_irq_disable();
 	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
 
         /*
 	 * If time_adjust is negative then NTP is slowing the clock
@@ -103,7 +97,6 @@ int do_settimeofday(struct timespec *tv)
 	 * made, and then undo it!
 	 */
 	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/frv/kernel/time.c linux-2.6.18-rc4-mm2/arch/frv/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/frv/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/frv/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -31,8 +31,6 @@
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-extern unsigned long wall_jiffies;
-
 unsigned long __nongprelbss __clkin_clock_speed_HZ;
 unsigned long __nongprelbss __ext_bus_clock_speed_HZ;
 unsigned long __nongprelbss __res_bus_clock_speed_HZ;
@@ -153,12 +151,9 @@ void do_gettimeofday(struct timeval *tv)
 	unsigned long max_ntp_tick;
 
 	do {
-		unsigned long lost;
-
 		seq = read_seqbegin(&xtime_lock);
 
 		usec = 0;
-		lost = jiffies - wall_jiffies;
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
@@ -168,12 +163,7 @@ void do_gettimeofday(struct timeval *tv)
 		if (unlikely(time_adjust < 0)) {
 			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
 			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
 		}
-		else if (unlikely(lost))
-			usec += lost * (USEC_PER_SEC / HZ);
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
@@ -206,7 +196,6 @@ int do_settimeofday(struct timespec *tv)
 	 * made, and then undo it!
 	 */
 	nsec -= 0 * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/i386/kernel/time.c linux-2.6.18-rc4-mm2/arch/i386/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/i386/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/i386/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -76,8 +76,6 @@ int pit_latch_buggy;              /* ext
 unsigned int cpu_khz;	/* Detected as we calibrate the TSC */
 EXPORT_SYMBOL(cpu_khz);
 
-extern unsigned long wall_jiffies;
-
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
@@ -329,7 +327,6 @@ static int timer_resume(struct sys_devic
 	do_settimeofday(&ts);
 	write_seqlock_irqsave(&xtime_lock, flags);
 	jiffies_64 += sleep_length;
-	wall_jiffies += sleep_length;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	touch_softlockup_watchdog();
 	return 0;
diff -urNp linux-2.6.18-rc4-mm2.org/arch/ia64/kernel/time.c linux-2.6.18-rc4-mm2/arch/ia64/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/ia64/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/ia64/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -29,8 +29,6 @@
 #include <asm/sections.h>
 #include <asm/system.h>
 
-extern unsigned long wall_jiffies;
-
 volatile int time_keeper_id = 0; /* smp_processor_id() of time-keeper */
 
 #ifdef CONFIG_IA64_DEBUG_IRQ
diff -urNp linux-2.6.18-rc4-mm2.org/arch/m32r/kernel/time.c linux-2.6.18-rc4-mm2/arch/m32r/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/m32r/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/m32r/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -38,7 +38,6 @@ extern void send_IPI_allbutself(int, int
 extern void smp_local_timer_interrupt(struct pt_regs *);
 #endif
 
-extern unsigned long wall_jiffies;
 #define TICK_SIZE	(tick_nsec / 1000)
 
 /*
@@ -108,24 +107,17 @@ void do_gettimeofday(struct timeval *tv)
 	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
-		unsigned long lost;
-
 		seq = read_seqbegin(&xtime_lock);
 
 		usec = do_gettimeoffset();
-		lost = jiffies - wall_jiffies;
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(time_adjust < 0))
 			usec = min(usec, max_ntp_tick);
-			if (lost)
-				usec += lost * max_ntp_tick;
-		} else if (unlikely(lost))
-			usec += lost * tick_usec;
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
@@ -158,7 +150,6 @@ int do_settimeofday(struct timespec *tv)
 	 * made, and then undo it!
 	 */
 	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
 	wtm_sec = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/m68k/kernel/time.c linux-2.6.18-rc4-mm2/arch/m68k/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/m68k/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/m68k/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -95,31 +95,23 @@ void time_init(void)
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	extern unsigned long wall_jiffies;
 	unsigned long seq;
-	unsigned long usec, sec, lost;
+	unsigned long usec, sec;
 	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 
 		usec = mach_gettimeoffset();
-		lost = jiffies - wall_jiffies;
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(time_adjust < 0))
 			usec = min(usec, max_ntp_tick);
 
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * tick_usec;
-
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec/1000;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
@@ -140,7 +132,6 @@ int do_settimeofday(struct timespec *tv)
 {
 	time_t wtm_sec, sec = tv->tv_sec;
 	long wtm_nsec, nsec = tv->tv_nsec;
-	extern unsigned long wall_jiffies;
 
 	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
@@ -152,8 +143,7 @@ int do_settimeofday(struct timespec *tv)
 	 * Discover what correction gettimeofday
 	 * would have done, and then undo it!
 	 */
-	nsec -= 1000 * (mach_gettimeoffset() +
-			(jiffies - wall_jiffies) * (1000000 / HZ));
+	nsec -= 1000 * mach_gettimeoffset();
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/m68knommu/kernel/time.c linux-2.6.18-rc4-mm2/arch/m68knommu/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/m68knommu/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/m68knommu/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -26,8 +26,6 @@
 
 #define	TICK_SIZE (tick_nsec / 1000)
 
-extern unsigned long wall_jiffies;
-
 
 static inline int set_rtc_mmss(unsigned long nowtime)
 {
@@ -124,15 +122,12 @@ void time_init(void)
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	unsigned long lost, seq;
+	unsigned long seq;
 	unsigned long usec, sec;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = mach_gettimeoffset ? mach_gettimeoffset() : 0;
-		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
diff -urNp linux-2.6.18-rc4-mm2.org/arch/mips/galileo-boards/ev96100/time.c linux-2.6.18-rc4-mm2/arch/mips/galileo-boards/ev96100/time.c
--- linux-2.6.18-rc4-mm2.org/arch/mips/galileo-boards/ev96100/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/mips/galileo-boards/ev96100/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -46,7 +46,6 @@
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
-extern volatile unsigned long wall_jiffies;
 unsigned long missed_heart_beats = 0;
 
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
diff -urNp linux-2.6.18-rc4-mm2.org/arch/mips/kernel/time.c linux-2.6.18-rc4-mm2/arch/mips/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/mips/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/mips/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -47,8 +47,6 @@
 /*
  * forward reference
  */
-extern volatile unsigned long wall_jiffies;
-
 DEFINE_SPINLOCK(rtc_lock);
 
 /*
@@ -159,7 +157,6 @@ void (*mips_hpt_init)(unsigned int);
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long seq;
-	unsigned long lost;
 	unsigned long usec, sec;
 	unsigned long max_ntp_tick;
 
@@ -168,8 +165,6 @@ void do_gettimeofday(struct timeval *tv)
 
 		usec = do_gettimeoffset();
 
-		lost = jiffies - wall_jiffies;
-
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
@@ -178,11 +173,7 @@ void do_gettimeofday(struct timeval *tv)
 		if (unlikely(time_adjust < 0)) {
 			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
 			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
-		} else if (unlikely(lost))
-			usec += lost * (USEC_PER_SEC / HZ);
+		}
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
@@ -217,7 +208,6 @@ int do_settimeofday(struct timespec *tv)
 	 * made, and then undo it!
 	 */
 	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * tick_nsec;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/mips/sgi-ip27/ip27-timer.c linux-2.6.18-rc4-mm2/arch/mips/sgi-ip27/ip27-timer.c
--- linux-2.6.18-rc4-mm2.org/arch/mips/sgi-ip27/ip27-timer.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/mips/sgi-ip27/ip27-timer.c	2006-08-20 23:07:03.000000000 +0900
@@ -42,8 +42,6 @@
 static unsigned long ct_cur[NR_CPUS];	/* What counter should be at next timer irq */
 static long last_rtc_update;		/* Last time the rtc clock got updated */
 
-extern volatile unsigned long wall_jiffies;
-
 #if 0
 static int set_rtc_mmss(unsigned long nowtime)
 {
diff -urNp linux-2.6.18-rc4-mm2.org/arch/parisc/kernel/time.c linux-2.6.18-rc4-mm2/arch/parisc/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/parisc/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/parisc/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -32,9 +32,6 @@
 
 #include <linux/timex.h>
 
-/* xtime and wall_jiffies keep wall-clock time */
-extern unsigned long wall_jiffies;
-
 static long clocktick __read_mostly;	/* timer cycles per tick */
 static long halftick __read_mostly;
 
@@ -112,7 +109,7 @@ EXPORT_SYMBOL(profile_pc);
 /*** converted from ia64 ***/
 /*
  * Return the number of micro-seconds that elapsed since the last
- * update to wall time (aka xtime aka wall_jiffies).  The xtime_lock
+ * update to wall time (aka xtime).  The xtime_lock
  * must be at least read-locked when calling this routine.
  */
 static inline unsigned long
@@ -134,7 +131,7 @@ gettimeoffset (void)
 	 * when we expected the tick and when it actually arrived.
 	 * (aka wall vs real)
 	 */
-	last_tick -= clocktick * (jiffies - wall_jiffies + 1);
+	last_tick -= clocktick;
 	elapsed_cycles = mfctl(16) - last_tick;
 
 	/* the precision of this math could be improved */
diff -urNp linux-2.6.18-rc4-mm2.org/arch/powerpc/kernel/time.c linux-2.6.18-rc4-mm2/arch/powerpc/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/powerpc/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/powerpc/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -117,8 +117,6 @@ unsigned tb_to_ns_shift;
 
 struct gettimeofday_struct do_gtod;
 
-extern unsigned long wall_jiffies;
-
 extern struct timezone sys_tz;
 static long timezone_offset;
 
@@ -815,11 +813,6 @@ int do_settimeofday(struct timespec *tv)
 	/*
 	 * Subtract off the number of nanoseconds since the
 	 * beginning of the last tick.
-	 * Note that since we don't increment jiffies_64 anywhere other
-	 * than in do_timer (since we don't have a lost tick problem),
-	 * wall_jiffies will always be the same as jiffies,
-	 * and therefore the (jiffies - wall_jiffies) computation
-	 * has been removed.
 	 */
 	tb_delta = tb_ticks_since(tb_last_stamp);
 	tb_delta = mulhdu(tb_delta, do_gtod.varp->tb_to_xs); /* in xsec */
diff -urNp linux-2.6.18-rc4-mm2.org/arch/ppc/kernel/time.c linux-2.6.18-rc4-mm2/arch/ppc/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/ppc/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/ppc/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -80,8 +80,6 @@ unsigned tb_to_us;
 unsigned tb_last_stamp;
 unsigned long tb_to_ns_scale;
 
-extern unsigned long wall_jiffies;
-
 /* used for timezone offset */
 static long timezone_offset;
 
@@ -173,8 +171,7 @@ void timer_interrupt(struct pt_regs * re
 		 */
 		if ( ppc_md.set_rtc_time && ntp_synced() &&
 		     xtime.tv_sec - last_rtc_update >= 659 &&
-		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
-		     jiffies - wall_jiffies == 1) {
+		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ) {
 		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
@@ -200,7 +197,7 @@ void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
 	unsigned long seq;
-	unsigned delta, lost_ticks, usec, sec;
+	unsigned delta, usec, sec;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
@@ -214,10 +211,9 @@ void do_gettimeofday(struct timeval *tv)
 		if (!smp_tb_synchronized)
 			delta = 0;
 #endif /* CONFIG_SMP */
-		lost_ticks = jiffies - wall_jiffies;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
-	usec += mulhwu(tb_to_us, tb_ticks_per_jiffy * lost_ticks + delta);
+	usec += mulhwu(tb_to_us, delta);
 	while (usec >= 1000000) {
 	  	sec++;
 		usec -= 1000000;
@@ -258,7 +254,6 @@ int do_settimeofday(struct timespec *tv)
 	 * still reasonable when gettimeofday resolution is 1 jiffy.
 	 */
 	tb_delta = tb_ticks_since(last_jiffy_stamp(smp_processor_id()));
-	tb_delta += (jiffies - wall_jiffies) * tb_ticks_per_jiffy;
 
 	new_nsec -= 1000 * mulhwu(tb_to_us, tb_delta);
 
diff -urNp linux-2.6.18-rc4-mm2.org/arch/s390/kernel/time.c linux-2.6.18-rc4-mm2/arch/s390/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/s390/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/s390/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -53,8 +53,6 @@ static u64 init_timer_cc;
 static u64 jiffies_timer_cc;
 static u64 xtime_cc;
 
-extern unsigned long wall_jiffies;
-
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -88,8 +86,6 @@ static inline unsigned long do_gettimeof
 	__u64 now;
 
         now = (get_clock() - jiffies_timer_cc) >> 12;
-	/* We require the offset from the latest update of xtime */
-	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
 	return (unsigned long) now;
 }
 
diff -urNp linux-2.6.18-rc4-mm2.org/arch/sh/kernel/time.c linux-2.6.18-rc4-mm2/arch/sh/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/sh/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/sh/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -19,7 +19,6 @@
 #include <asm/timer.h>
 #include <asm/kgdb.h>
 
-extern unsigned long wall_jiffies;
 struct sys_timer *sys_timer;
 
 /* Move this somewhere more sensible.. */
@@ -48,16 +47,10 @@ void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long seq;
 	unsigned long usec, sec;
-	unsigned long lost;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
 		usec = get_timer_offset();
-
-		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec / 1000;
 	} while (read_seqretry(&xtime_lock, seq));
@@ -88,8 +81,7 @@ int do_settimeofday(struct timespec *tv)
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	nsec -= 1000 * (get_timer_offset() +
-				(jiffies - wall_jiffies) * (1000000 / HZ));
+	nsec -= 1000 * get_timer_offset();
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/sh64/kernel/time.c linux-2.6.18-rc4-mm2/arch/sh64/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/sh64/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/sh64/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -107,8 +107,6 @@
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-extern unsigned long wall_jiffies;
-
 static unsigned long tmu_base, rtc_base;
 unsigned long cprc_base;
 
@@ -194,13 +192,6 @@ void do_gettimeofday(struct timeval *tv)
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = usecs_since_tick();
-		{
-			unsigned long lost = jiffies - wall_jiffies;
-
-			if (lost)
-				usec += lost * (1000000 / HZ);
-		}
-
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec / 1000;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
@@ -229,8 +220,7 @@ int do_settimeofday(struct timespec *tv)
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	nsec -= 1000 * (usecs_since_tick() +
-				(jiffies - wall_jiffies) * (1000000 / HZ));
+	nsec -= 1000 * usecs_since_tick();
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/sparc/kernel/pcic.c linux-2.6.18-rc4-mm2/arch/sparc/kernel/pcic.c
--- linux-2.6.18-rc4-mm2.org/arch/sparc/kernel/pcic.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/sparc/kernel/pcic.c	2006-08-20 23:07:03.000000000 +0900
@@ -765,8 +765,6 @@ static __inline__ unsigned long do_getti
 	return count;
 }
 
-extern unsigned long wall_jiffies;
-
 static void pci_do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
@@ -775,26 +773,17 @@ static void pci_do_gettimeofday(struct t
 	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
-		unsigned long lost;
-
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = do_gettimeoffset();
-		lost = jiffies - wall_jiffies;
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(time_adjust < 0))
 			usec = min(usec, max_ntp_tick);
 
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * tick_usec;
-
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
@@ -819,8 +808,7 @@ static int pci_do_settimeofday(struct ti
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	tv->tv_nsec -= 1000 * (do_gettimeoffset() + 
-				(jiffies - wall_jiffies) * (USEC_PER_SEC / HZ));
+	tv->tv_nsec -= 1000 * do_gettimeoffset();
 	while (tv->tv_nsec < 0) {
 		tv->tv_nsec += NSEC_PER_SEC;
 		tv->tv_sec--;
diff -urNp linux-2.6.18-rc4-mm2.org/arch/sparc/kernel/time.c linux-2.6.18-rc4-mm2/arch/sparc/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/sparc/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/sparc/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -43,8 +43,6 @@
 #include <asm/pcic.h>
 #include <asm/of_device.h>
 
-extern unsigned long wall_jiffies;
-
 DEFINE_SPINLOCK(rtc_lock);
 enum sparc_clock_type sp_clock_typ;
 DEFINE_SPINLOCK(mostek_lock);
@@ -449,7 +447,7 @@ unsigned long long sched_clock(void)
 
 /* Ok, my cute asm atomicity trick doesn't work anymore.
  * There are just too many variables that need to be protected
- * now (both members of xtime, wall_jiffies, et al.)
+ * now (both members of xtime, et al.)
  */
 void do_gettimeofday(struct timeval *tv)
 {
@@ -459,26 +457,17 @@ void do_gettimeofday(struct timeval *tv)
 	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
-		unsigned long lost;
-
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = do_gettimeoffset();
-		lost = jiffies - wall_jiffies;
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(time_adjust < 0))
 			usec = min(usec, max_ntp_tick);
 
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * tick_usec;
-
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
@@ -521,8 +510,7 @@ static int sbus_do_settimeofday(struct t
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	nsec -= 1000 * (do_gettimeoffset() +
-			(jiffies - wall_jiffies) * (USEC_PER_SEC / HZ));
+	nsec -= 1000 * do_gettimeoffset();
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
diff -urNp linux-2.6.18-rc4-mm2.org/arch/sparc64/kernel/time.c linux-2.6.18-rc4-mm2/arch/sparc64/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/sparc64/kernel/time.c	2006-08-20 23:03:53.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/sparc64/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -53,8 +53,6 @@ void __iomem *mstk48t02_regs = NULL;
 unsigned long ds1287_regs = 0UL;
 #endif
 
-extern unsigned long wall_jiffies;
-
 static void __iomem *mstk48t08_regs;
 static void __iomem *mstk48t59_regs;
 
diff -urNp linux-2.6.18-rc4-mm2.org/arch/x86_64/kernel/time.c linux-2.6.18-rc4-mm2/arch/x86_64/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/x86_64/kernel/time.c	2006-08-20 23:03:54.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/x86_64/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -77,7 +77,6 @@ unsigned long long monotonic_base;
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
 volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
-unsigned long __wall_jiffies __section_wall_jiffies = INITIAL_JIFFIES;
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
 
@@ -119,7 +118,7 @@ unsigned int (*do_gettimeoffset)(void) =
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long seq, t;
+	unsigned long seq;
  	unsigned int sec, usec;
 
 	do {
@@ -136,10 +135,7 @@ void do_gettimeofday(struct timeval *tv)
 		   be found. Note when you fix it here you need to do the same
 		   in arch/x86_64/kernel/vsyscall.c and export all needed
 		   variables in vmlinux.lds. -AK */ 
-
-		t = (jiffies - wall_jiffies) * USEC_PER_TICK +
-			do_gettimeoffset();
-		usec += t;
+		usec += do_gettimeoffset();
 
 	} while (read_seqretry(&xtime_lock, seq));
 
@@ -165,8 +161,7 @@ int do_settimeofday(struct timespec *tv)
 
 	write_seqlock_irq(&xtime_lock);
 
-	nsec -= do_gettimeoffset() * NSEC_PER_USEC +
-		(jiffies - wall_jiffies) * NSEC_PER_TICK;
+	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
@@ -1073,7 +1068,6 @@ static int timer_resume(struct sys_devic
 		vxtime.last_tsc = get_cycles_sync();
 	write_sequnlock_irqrestore(&xtime_lock,flags);
 	jiffies += sleep_length;
-	wall_jiffies += sleep_length;
 	monotonic_base += sleep_length * (NSEC_PER_SEC/HZ);
 	touch_softlockup_watchdog();
 	return 0;
diff -urNp linux-2.6.18-rc4-mm2.org/arch/x86_64/kernel/vmlinux.lds.S linux-2.6.18-rc4-mm2/arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.18-rc4-mm2.org/arch/x86_64/kernel/vmlinux.lds.S	2006-08-20 23:03:54.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/x86_64/kernel/vmlinux.lds.S	2006-08-20 23:07:03.000000000 +0900
@@ -95,9 +95,6 @@ SECTIONS
   .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
   vgetcpu_mode = VVIRT(.vgetcpu_mode);
 
-  .wall_jiffies : AT(VLOAD(.wall_jiffies)) { *(.wall_jiffies) }
-  wall_jiffies = VVIRT(.wall_jiffies);
-
   .sys_tz : AT(VLOAD(.sys_tz)) { *(.sys_tz) }
   sys_tz = VVIRT(.sys_tz);
 
diff -urNp linux-2.6.18-rc4-mm2.org/arch/x86_64/kernel/vsyscall.c linux-2.6.18-rc4-mm2/arch/x86_64/kernel/vsyscall.c
--- linux-2.6.18-rc4-mm2.org/arch/x86_64/kernel/vsyscall.c	2006-08-20 23:03:54.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/x86_64/kernel/vsyscall.c	2006-08-20 23:07:03.000000000 +0900
@@ -66,8 +66,7 @@ static __always_inline void do_vgettimeo
 		sequence = read_seqbegin(&__xtime_lock);
 		
 		sec = __xtime.tv_sec;
-		usec = (__xtime.tv_nsec / 1000) +
-			(__jiffies - __wall_jiffies) * (1000000 / HZ);
+		usec = __xtime.tv_nsec / 1000;
 
 		if (__vxtime.mode != VXTIME_HPET) {
 			t = get_cycles_sync();
diff -urNp linux-2.6.18-rc4-mm2.org/arch/xtensa/kernel/time.c linux-2.6.18-rc4-mm2/arch/xtensa/kernel/time.c
--- linux-2.6.18-rc4-mm2.org/arch/xtensa/kernel/time.c	2006-08-20 23:03:54.000000000 +0900
+++ linux-2.6.18-rc4-mm2/arch/xtensa/kernel/time.c	2006-08-20 23:07:03.000000000 +0900
@@ -26,8 +26,6 @@
 #include <asm/platform.h>
 
 
-extern volatile unsigned long wall_jiffies;
-
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
@@ -110,7 +108,6 @@ int do_settimeofday(struct timespec *tv)
 	 */
 	ccount = get_ccount();
 	nsec -= (ccount - last_ccount_stamp) * CCOUNT_NSEC;
-	nsec -= (jiffies - wall_jiffies) * CCOUNT_PER_JIFFY * CCOUNT_NSEC;
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
@@ -129,7 +126,7 @@ EXPORT_SYMBOL(do_settimeofday);
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	unsigned long sec, usec, delta, lost, seq;
+	unsigned long sec, usec, delta, seq;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
@@ -137,12 +134,9 @@ void do_gettimeofday(struct timeval *tv)
 		delta = get_ccount() - last_ccount_stamp;
 		sec = xtime.tv_sec;
 		usec = (xtime.tv_nsec / NSEC_PER_USEC);
-
-		lost = jiffies - wall_jiffies;
-
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
-	usec += lost * (1000000UL/HZ) + (delta * CCOUNT_NSEC) / NSEC_PER_USEC;
+	usec += (delta * CCOUNT_NSEC) / NSEC_PER_USEC;
 	for (; usec >= 1000000; sec++, usec -= 1000000)
 		;
 
@@ -179,8 +173,7 @@ again:
 
 		if (ntp_synced() &&
 		    xtime.tv_sec - last_rtc_update >= 659 &&
-		    abs((xtime.tv_nsec/1000)-(1000000-1000000/HZ))<5000000/HZ &&
-		    jiffies - wall_jiffies == 1) {
+		    abs((xtime.tv_nsec/1000)-(1000000-1000000/HZ))<5000000/HZ) {
 
 			if (platform_set_rtc_time(xtime.tv_sec+1) == 0)
 				last_rtc_update = xtime.tv_sec+1;
diff -urNp linux-2.6.18-rc4-mm2.org/include/asm-x86_64/vsyscall.h linux-2.6.18-rc4-mm2/include/asm-x86_64/vsyscall.h
--- linux-2.6.18-rc4-mm2.org/include/asm-x86_64/vsyscall.h	2006-08-20 23:04:03.000000000 +0900
+++ linux-2.6.18-rc4-mm2/include/asm-x86_64/vsyscall.h	2006-08-20 23:07:03.000000000 +0900
@@ -18,7 +18,6 @@ enum vsyscall_num {
 
 #define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
 #define __section_vgetcpu_mode __attribute__ ((unused, __section__ (".vgetcpu_mode"), aligned(16)))
-#define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies"), aligned(16)))
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
 #define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
@@ -49,14 +48,12 @@ extern struct vxtime_data __vxtime;
 extern int __vgetcpu_mode;
 extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
-extern unsigned long __wall_jiffies;
 extern struct timezone __sys_tz;
 extern seqlock_t __xtime_lock;
 
 /* kernel space (writeable) */
 extern struct vxtime_data vxtime;
 extern int vgetcpu_mode;
-extern unsigned long wall_jiffies;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
 extern seqlock_t xtime_lock;
diff -urNp linux-2.6.18-rc4-mm2.org/kernel/timer.c linux-2.6.18-rc4-mm2/kernel/timer.c
--- linux-2.6.18-rc4-mm2.org/kernel/timer.c	2006-08-20 23:04:03.000000000 +0900
+++ linux-2.6.18-rc4-mm2/kernel/timer.c	2006-08-20 23:07:03.000000000 +0900
@@ -768,7 +768,7 @@ static int timekeeping_suspended;
  * @dev:	unused
  *
  * This is for the generic clocksource timekeeping.
- * xtime/wall_to_monotonic/jiffies/wall_jiffies/etc are
+ * xtime/wall_to_monotonic/jiffies/etc are
  * still managed by arch specific suspend/resume code.
  */
 static int timekeeping_resume(struct sys_device *dev)
@@ -1016,9 +1016,6 @@ static inline void calc_load(unsigned lo
 	}
 }
 
-/* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies = INITIAL_JIFFIES;
-
 /*
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.
@@ -1056,7 +1053,6 @@ void run_local_timers(void)
  */
 static inline void update_times(unsigned long ticks)
 {
-	wall_jiffies += ticks;
 	update_wall_time();
 	calc_load(ticks);
 }
