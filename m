Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVHYCQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVHYCQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVHYCQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:16:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53432 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932484AbVHYCQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:16:42 -0400
Subject: [PATCH] NTP ntp-helper functions
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 19:16:21 -0700
Message-Id: <1124936181.20820.158.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,

	This patch cleans up a commonly repeated set of changes to the NTP
state variables by adding two helper inline functions:
	
ntp_clear(): Clears the ntp state variables
ntp_synced(): Returns 1 if the system is synced with a time server.

This was compile tested for alpha, arm, i386, x86-64, ppc64, s390,
sparc, sparc64.

Please consider for inclusion into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.13-rc7_ntp-helpers_A0.patch
=====================================
diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -149,7 +149,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0
+	if (ntp_synced()
 	    && xtime.tv_sec > state.last_rtc_update + 660
 	    && xtime.tv_nsec >= 500000 - ((unsigned) TICK_SIZE) / 2
 	    && xtime.tv_nsec <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -502,10 +502,7 @@ do_settimeofday(struct timespec *tv)
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
@@ -102,7 +102,7 @@ static unsigned long next_rtc_update;
  */
 static inline void do_set_rtc(void)
 {
-	if (time_status & STA_UNSYNC || set_rtc == NULL)
+	if (!ntp_synced() || set_rtc == NULL)
 		return;
 
 	if (next_rtc_update &&
@@ -292,10 +292,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -114,7 +114,7 @@ static unsigned long next_rtc_update;
  */
 static inline void do_set_rtc(void)
 {
-	if (time_status & STA_UNSYNC || set_rtc == NULL)
+	if (!ntp_synced() || set_rtc == NULL)
 		return;
 
 //FIXME - timespec.tv_sec is a time_t not unsigned long
@@ -189,10 +189,7 @@ int do_settimeofday(struct timespec *tv)
 
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
@@ -114,10 +114,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -85,7 +85,7 @@ static irqreturn_t timer_interrupt(int i
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2
@@ -216,10 +216,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -116,10 +116,7 @@ int do_settimeofday(struct timespec *tv)
 
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
@@ -194,10 +194,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -348,7 +345,7 @@ static void sync_cmos_clock(unsigned lon
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
@@ -171,10 +171,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
@@ -221,7 +218,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
 	write_seqlock(&xtime_lock);
-	if ((time_status & STA_UNSYNC) == 0
+	if (ntp_synced()
 		&& xtime.tv_sec > last_rtc_update + 660
 		&& (xtime.tv_nsec / 1000) >= 500000 - ((unsigned)TICK_SIZE) / 2
 		&& (xtime.tv_nsec / 1000) <= 500000 + ((unsigned)TICK_SIZE) / 2)
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -166,10 +166,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -68,7 +68,7 @@ static irqreturn_t timer_interrupt(int i
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec  / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -178,10 +178,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -632,10 +632,7 @@ asmlinkage int irix_stime(int value)
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
@@ -223,10 +223,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;			/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
@@ -442,7 +439,7 @@ irqreturn_t timer_interrupt(int irq, voi
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
@@ -118,7 +118,7 @@ again:
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
@@ -188,10 +188,7 @@ do_settimeofday (struct timespec *tv)
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
@@ -169,7 +169,7 @@ void timer_interrupt(struct pt_regs * re
 		 * We should have an rtc call that only sets the minutes and
 		 * seconds like on Intel to avoid problems with non UTC clocks.
 		 */
-		if ( ppc_md.set_rtc_time && (time_status & STA_UNSYNC) == 0 &&
+		if ( ppc_md.set_rtc_time && ntp_synced() &&
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
@@ -271,10 +271,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -128,7 +128,7 @@ static __inline__ void timer_check_rtc(v
          * We should have an rtc call that only sets the minutes and
          * seconds like on Intel to avoid problems with non UTC clocks.
          */
-        if ( (time_status & STA_UNSYNC) == 0 &&
+        if (ntp_synced() &&
              xtime.tv_sec - last_rtc_update >= 659 &&
              abs((xtime.tv_nsec/1000) - (1000000-1000000/HZ)) < 500000/HZ &&
              jiffies - wall_jiffies == 1) {
@@ -437,10 +437,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -139,10 +139,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -215,10 +215,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
@@ -252,7 +249,7 @@ static inline void do_timer_interrupt(in
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
@@ -247,10 +247,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 
@@ -328,7 +325,7 @@ static inline void do_timer_interrupt(in
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
@@ -840,10 +840,7 @@ static int pci_do_settimeofday(struct ti
 
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
@@ -140,7 +140,7 @@ irqreturn_t timer_interrupt(int irq, voi
 
 
 	/* Determine when to update the Mostek clock. */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -555,10 +555,7 @@ static int sbus_do_settimeofday(struct t
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
@@ -449,7 +449,7 @@ static inline void timer_check_rtc(void)
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
@@ -66,7 +66,7 @@ static irqreturn_t timer_interrupt (int 
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
+	if (ntp_synced() &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
@@ -169,10 +169,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -176,10 +176,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_clear();
 
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
@@ -471,7 +468,7 @@ static irqreturn_t timer_interrupt(int i
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
@@ -122,10 +122,7 @@ int do_settimeofday(struct timespec *tv)
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
@@ -184,7 +181,7 @@ again:
 		next += CCOUNT_PER_JIFFY;
 		do_timer (regs); /* Linux handler in kernel/timer.c */
 
-		if ((time_status & STA_UNSYNC) == 0 &&
+		if (ntp_synced() &&
 		    xtime.tv_sec - last_rtc_update >= 659 &&
 		    abs((xtime.tv_nsec/1000)-(1000000-1000000/HZ))<5000000/HZ &&
 		    jiffies - wall_jiffies == 1) {
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -260,6 +260,29 @@ extern long pps_calcnt;		/* calibration 
 extern long pps_errcnt;		/* calibration errors */
 extern long pps_stbcnt;		/* stability limit exceeded */
 
+/**
+ * ntp_clear - Clears the NTP state variables
+ *
+ * Must be called while holding a write on the xtime_lock
+ */
+static inline void ntp_clear(void)
+{
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+}
+
+/**
+ * ntp_synced - Returns 1 if the NTP status is not UNSYNC
+ *
+ */
+static inline int ntp_synced(void)
+{
+	return !(time_status & STA_UNSYNC);
+}
+
+
 #ifdef CONFIG_TIME_INTERPOLATION
 
 #define TIME_SOURCE_CPU 0


