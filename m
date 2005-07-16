Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVGPC7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVGPC7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 22:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGPC7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 22:59:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:24463 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262049AbVGPC54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:57:56 -0400
Subject: [RFC][PATCH - 2/12] NTP cleanup: Move arches to new ntp interfaces
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482620.25236.31.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 19:57:52 -0700
Message-Id: <1121482672.25236.33.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch converts all of arch specific code to use the new ntp_synced
() and ntp_clear() interfaces. This patch is required for the patch 1 of
the series to build. 

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part2_B4.patch
============================================
diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/bcd.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -149,7 +150,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0
+	if (ntp_synced()
 	    && xtime.tv_sec > state.last_rtc_update + 660
 	    && xtime.tv_nsec >= 500000 - ((unsigned) TICK_SIZE) / 2
 	    && xtime.tv_nsec <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -502,10 +503,7 @@ do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
+#include <linux/ntp.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -102,7 +103,7 @@ static unsigned long next_rtc_update;
  */
 static inline void do_set_rtc(void)
 {
-	if (time_status & STA_UNSYNC || set_rtc == NULL)
+	if (!ntp_synced() || set_rtc == NULL)
 		return;
 
 	if (next_rtc_update &&
@@ -292,10 +293,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/arm26/kernel/time.c b/arch/arm26/kernel/time.c
--- a/arch/arm26/kernel/time.c
+++ b/arch/arm26/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -114,7 +115,7 @@ static unsigned long next_rtc_update;
  */
 static inline void do_set_rtc(void)
 {
-	if (time_status & STA_UNSYNC || set_rtc == NULL)
+	if (!ntp_synced() || set_rtc == NULL)
 		return;
 
 //FIXME - timespec.tv_sec is a time_t not unsigned long
@@ -189,10 +190,7 @@ int do_settimeofday(struct timespec *tv)
 
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = tv->tv_nsec;
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/cris/arch-v10/kernel/time.c b/arch/cris/arch-v10/kernel/time.c
--- a/arch/cris/arch-v10/kernel/time.c
+++ b/arch/cris/arch-v10/kernel/time.c
@@ -240,7 +240,7 @@ timer_interrupt(int irq, void *dev_id, s
 	 * The division here is not time critical since it will run once in 
 	 * 11 minutes
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - (tick_nsec / 1000) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + (tick_nsec / 1000) / 2) {
diff --git a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
--- a/arch/cris/kernel/time.c
+++ b/arch/cris/kernel/time.c
@@ -30,6 +30,7 @@
 #include <linux/bcd.h>
 #include <linux/timex.h>
 #include <linux/init.h>
+#include <linux/ntp.h>
 
 u64 jiffies_64 = INITIAL_JIFFIES;
 
@@ -113,10 +114,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -21,6 +21,7 @@
 #include <linux/profile.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/ntp.h>
 
 #include <asm/io.h>
 #include <asm/timer-regs.h>
@@ -85,7 +86,7 @@ static irqreturn_t timer_interrupt(int i
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2
@@ -216,10 +217,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/h8300/kernel/time.c b/arch/h8300/kernel/time.c
--- a/arch/h8300/kernel/time.c
+++ b/arch/h8300/kernel/time.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/timex.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/io.h>
 #include <asm/target_time.h>
@@ -116,10 +117,7 @@ int do_settimeofday(struct timespec *tv)
 
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = tv->tv_nsec;
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/ntp.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -194,10 +195,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
@@ -348,7 +346,7 @@ static void sync_cmos_clock(unsigned lon
 	 * This code is run on a timer.  If the clock is set, that timer
 	 * may not expire at the correct time.  Thus, we adjust...
 	 */
-	if ((time_status & STA_UNSYNC) != 0)
+	if (!ntp_synced())
 		/*
 		 * Not synced, exit, do not restart a timer (if one is
 		 * running, let it run out).
diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
--- a/arch/m32r/kernel/time.c
+++ b/arch/m32r/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/io.h>
 #include <asm/m32r.h>
@@ -171,10 +172,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
@@ -221,7 +219,7 @@ do_timer_interrupt(int irq, void *dev_id
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0
+	if (ntp_synced()
 		&& xtime.tv_sec > last_rtc_update + 660
 		&& (xtime.tv_nsec / 1000) >= 500000 - ((unsigned)TICK_SIZE) / 2
 		&& (xtime.tv_nsec / 1000) <= 500000 + ((unsigned)TICK_SIZE) / 2)
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/rtc.h>
+#include <linux/ntp.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -166,10 +167,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/m68knommu/kernel/time.c b/arch/m68knommu/kernel/time.c
--- a/arch/m68knommu/kernel/time.c
+++ b/arch/m68knommu/kernel/time.c
@@ -21,6 +21,7 @@
 #include <linux/profile.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/ntp.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -68,7 +69,7 @@ static irqreturn_t timer_interrupt(int i
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec  / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -178,10 +179,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
--- a/arch/mips/kernel/sysirix.c
+++ b/arch/mips/kernel/sysirix.c
@@ -30,6 +30,7 @@
 #include <linux/socket.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ntp.h>
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
@@ -632,10 +633,7 @@ asmlinkage int irix_stime(int value)
 	write_seqlock_irq(&xtime_lock);
 	xtime.tv_sec = value;
 	xtime.tv_nsec = 0;
-	time_adjust = 0;			/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 
 	return 0;
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/ntp.h>
 
 #include <asm/bootinfo.h>
 #include <asm/compiler.h>
@@ -223,10 +224,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;			/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
@@ -442,7 +440,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
 	write_seqlock(&xtime_lock);
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -12,6 +12,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/mm.h>
+#include <linux/ntp.h>
 
 #include <asm/time.h>
 #include <asm/pgtable.h>
@@ -118,7 +119,7 @@ again:
 	 * RTC clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to when a second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -188,10 +189,7 @@ do_settimeofday (struct timespec *tv)
 		set_normalized_timespec(&xtime, sec, nsec);
 		set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-		time_adjust = 0;		/* stop active adjtime() */
-		time_status |= STA_UNSYNC;
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_esterror = NTP_PHASE_LIMIT;
+		ntp_clear();
 	}
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -57,6 +57,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -169,7 +170,7 @@ void timer_interrupt(struct pt_regs * re
 		 * We should have an rtc call that only sets the minutes and
 		 * seconds like on Intel to avoid problems with non UTC clocks.
 		 */
-		if ( ppc_md.set_rtc_time && (time_status & STA_UNSYNC) == 0 &&
+		if ( ppc_md.set_rtc_time && ntp_synced() &&
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
@@ -271,10 +272,7 @@ int do_settimeofday(struct timespec *tv)
 	 */
 	last_rtc_update = new_sec - 658;
 
-	time_adjust = 0;                /* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	clock_was_set();
 	return 0;
diff --git a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c
+++ b/arch/ppc64/kernel/time.c
@@ -50,6 +50,7 @@
 #include <linux/profile.h>
 #include <linux/cpu.h>
 #include <linux/security.h>
+#include <linux/ntp.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -128,7 +129,7 @@ static __inline__ void timer_check_rtc(v
          * We should have an rtc call that only sets the minutes and
          * seconds like on Intel to avoid problems with non UTC clocks.
          */
-        if ( (time_status & STA_UNSYNC) == 0 &&
+        if (ntp_synced() &&
              xtime.tv_sec - last_rtc_update >= 659 &&
              abs((xtime.tv_nsec/1000) - (1000000-1000000/HZ)) < 500000/HZ &&
              jiffies - wall_jiffies == 1) {
@@ -437,10 +438,7 @@ int do_settimeofday(struct timespec *tv)
 	 */
 	last_rtc_update = new_sec - 658;
 
-	time_adjust = 0;                /* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	delta_xsec = mulhdu( (tb_last_stamp-do_gtod.varp->tb_orig_stamp),
 			     do_gtod.varp->tb_to_xs );
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -29,6 +29,7 @@
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
+#include <linux/ntp.h>
 
 #include <asm/uaccess.h>
 #include <asm/delay.h>
@@ -139,10 +140,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -215,10 +216,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
@@ -252,7 +250,7 @@ static inline void do_timer_interrupt(in
 	 * RTC clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
diff --git a/arch/sh64/kernel/time.c b/arch/sh64/kernel/time.c
--- a/arch/sh64/kernel/time.c
+++ b/arch/sh64/kernel/time.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
+#include <linux/ntp.h>
 
 #include <asm/registers.h>	 /* required by inline __asm__ stmt. */
 
@@ -247,10 +248,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
@@ -328,7 +326,7 @@ static inline void do_timer_interrupt(in
 	 * RTC clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/ntp.h>
 
 #include <asm/ebus.h>
 #include <asm/sbus.h> /* for sanity check... */
@@ -840,10 +841,7 @@ static int pci_do_settimeofday(struct ti
 
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = tv->tv_nsec;
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	return 0;
 }
 
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -30,6 +30,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/oplib.h>
 #include <asm/segment.h>
@@ -140,7 +141,7 @@ irqreturn_t timer_interrupt(int irq, voi
 
 
 	/* Determine when to update the Mostek clock. */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -555,10 +556,7 @@ static int sbus_do_settimeofday(struct t
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	return 0;
 }
 
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -30,6 +30,7 @@
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -449,7 +450,7 @@ static inline void timer_check_rtc(void)
 	static long last_rtc_update;
 
 	/* Determine when to update the Mostek clock. */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
diff --git a/arch/v850/kernel/time.c b/arch/v850/kernel/time.c
--- a/arch/v850/kernel/time.c
+++ b/arch/v850/kernel/time.c
@@ -21,6 +21,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/profile.h>
+#include <linux/ntp.h>
 
 #include <asm/io.h>
 
@@ -66,7 +67,7 @@ static irqreturn_t timer_interrupt (int 
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -169,10 +170,7 @@ int do_settimeofday(struct timespec *tv)
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = tv->tv_nsec;
 
-	time_adjust = 0;		/* stop active adjtime () */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	write_sequnlock_irq (&xtime_lock);
 	clock_was_set();
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -27,6 +27,8 @@
 #include <linux/bcd.h>
 #include <linux/kallsyms.h>
 #include <linux/acpi.h>
+#include <linux/ntp.h>
+
 #ifdef CONFIG_ACPI
 #include <acpi/achware.h>	/* for PM timer frequency */
 #endif
@@ -176,10 +178,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
@@ -471,7 +470,7 @@ static irqreturn_t timer_interrupt(int i
  * off) isn't likely to go away much sooner anyway.
  */
 
-	if ((~time_status & STA_UNSYNC) && xtime.tv_sec > rtc_update &&
+	if (ntp_synced() && xtime.tv_sec > rtc_update &&
 		abs(xtime.tv_nsec - 500000000) <= tick_nsec / 2) {
 		set_rtc_mmss(xtime.tv_sec);
 		rtc_update = xtime.tv_sec + 660;
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
+#include <linux/ntp.h>
 
 #include <asm/timex.h>
 #include <asm/platform.h>
@@ -122,10 +123,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;                /* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	return 0;
 }
@@ -184,7 +182,7 @@ again:
 		next += CCOUNT_PER_JIFFY;
 		do_timer (regs); /* Linux handler in kernel/timer.c */
 
-		if ((time_status & STA_UNSYNC) == 0 &&
+		if (ntp_synced() &&
 		    xtime.tv_sec - last_rtc_update >= 659 &&
 		    abs((xtime.tv_nsec/1000)-(1000000-1000000/HZ))<5000000/HZ &&
 		    jiffies - wall_jiffies == 1) {


