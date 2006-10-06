Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWJFOz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWJFOz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWJFOz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:55:57 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:64425 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422697AbWJFOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:55:45 -0400
Date: Fri, 6 Oct 2006 16:55:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] Use CONFIG_GENERIC_TIME and define TOD clock source.
Message-ID: <20061006145546.GF26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] Use CONFIG_GENERIC_TIME and define TOD clock source.

Fix too slow clock by using CONFIG_GENERIC_TIME and adding a
clock source for the s390 time-of-day clock. As added benefit
we get rid of the s390 specific definition of do_gettimeofday
and do_settimeofday.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig       |    3 +
 arch/s390/defconfig     |    1 
 arch/s390/kernel/time.c |   88 ++++++++++--------------------------------------
 3 files changed, 24 insertions(+), 68 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-10-06 16:29:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2006-10-06 16:30:02.000000000 +0200
@@ -9,6 +9,7 @@ CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-10-06 16:29:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-10-06 16:30:02.000000000 +0200
@@ -30,6 +30,9 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config GENERIC_TIME
+	def_bool y
+
 config GENERIC_BUST_SPINLOCK
 	bool
 
diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-10-06 16:30:00.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-10-06 16:30:02.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
+#include <linux/clocksource.h>
 
 #include <asm/uaccess.h>
 #include <asm/delay.h>
@@ -82,74 +83,6 @@ void tod_to_timeval(__u64 todval, struct
 	xtime->tv_nsec = ((todval * 1000) >> 12);
 }
 
-static inline unsigned long do_gettimeoffset(void) 
-{
-	__u64 now;
-
-	now = (get_clock() - jiffies_timer_cc) >> 12;
-	now -= (__u64) jiffies * USECS_PER_JIFFY;
-	return (unsigned long) now;
-}
-
-/*
- * This version of gettimeofday has microsecond resolution.
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long flags;
-	unsigned long seq;
-	unsigned long usec, sec;
-
-	do {
-		seq = read_seqbegin_irqsave(&xtime_lock, flags);
-
-		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
-	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-	/* This is revolting. We need to set the xtime.tv_nsec
-	 * correctly. However, the value in this location is
-	 * is value at the last tick.
-	 * Discover what correction gettimeofday
-	 * would have done, and then undo it!
-	 */
-	nsec -= do_gettimeoffset() * 1000;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
-
 #ifdef CONFIG_PROFILING
 #define s390_do_profile()	profile_tick(CPU_PROFILING)
 #else
@@ -340,6 +273,22 @@ void init_cpu_timer(void)
 
 extern void vtime_init(void);
 
+static cycle_t read_tod_clock(void)
+{
+	return get_clock();
+}
+
+static struct clocksource clocksource_tod = {
+	.name		= "tod",
+	.rating		= 100,
+	.read		= read_tod_clock,
+	.mask		= -1ULL,
+	.mult		= 1000,
+	.shift		= 12,
+	.is_continuous	= 1,
+};
+
+
 /*
  * Initialize the TOD clock and the CPU timer of
  * the boot cpu.
@@ -384,6 +333,9 @@ void __init time_init(void)
 					      &ext_int_info_cc) != 0)
                 panic("Couldn't request external interrupt 0x1004");
 
+	if (clocksource_register(&clocksource_tod) != 0)
+		panic("Could not register TOD clock source");
+
         init_cpu_timer();
 
 #ifdef CONFIG_NO_IDLE_HZ
