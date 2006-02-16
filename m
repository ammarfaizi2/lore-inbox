Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWBPXah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWBPXah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWBPXah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:30:37 -0500
Received: from ozlabs.org ([203.10.76.45]:46723 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932516AbWBPXag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:30:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17397.2831.48980.367714@cargo.ozlabs.ibm.com>
Date: Fri, 17 Feb 2006 10:30:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH v2] Provide an interface for getting the current tick length
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This provides an interface for arch code to find out how many
nanoseconds are going to be added on to xtime by the next call to
do_timer.  The value returned is a fixed-point number in 52.12 format
in nanoseconds.  The reason for this format is that it gives the
full precision that the timekeeping code is using internally.

The motivation for this is to fix a problem that has arisen on 32-bit
powerpc in that the value returned by do_gettimeofday drifts apart
from xtime if NTP is being used.  PowerPC is now using a lockless
do_gettimeofday based on reading the timebase register and performing
some simple arithmetic.  (This method of getting the time is also
exported to userspace via the VDSO.)  However, the factor and offset
it uses were calculated based on the nominal tick length and weren't
being adjusted when NTP varied the tick length.

Note that 64-bit powerpc has had the lockless do_gettimeofday for a
long time now.  It also had an extremely hairy routine that got called
from the 32-bit compat routine for adjtimex, which adjusted the
factor and offset according to what it thought the timekeeping code
was going to do.  Not only was this only called if a 32-bit task did
adjtimex (i.e. not if a 64-bit task did adjtimex), it was also
duplicating computations from kernel/timer.c and it wasn't clear that
it was (still) correct.

The simple solution is to ask the timekeeping code how long the
current jiffy will be on each timer interrupt, after calling
do_timer.  If this jiffy will be a different length from the last one,
we then need to compute new values for the factor and offset used in
the lockless do_gettimeofday.  In this way we can keep xtime and
do_gettimeofday in sync, even when NTP is varying the tick length.

Note that when adjtimex varies the tick length, it almost always
introduces the variation from the next tick on.  The only case I could
see where adjtimex would vary the length of the current tick is when
an old-style adjtime adjustment is being cancelled.  (It's not clear
to me why the adjustment has to be cancelled immediately rather than
from the next tick on.)  Thus I don't see any real need for a hook in
adjtimex; the rare case of an old-style adjustment being cancelled can
be fixed up at the next tick.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
This version of the patch has the adjtime calculation factored out and
the assignments inside if statements removed, as requested.

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 04a4a8c..b7ca120 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -345,6 +345,9 @@ time_interpolator_reset(void)
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
 
+/* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
+extern u64 current_tick_length(void);
+
 #endif /* KERNEL */
 
 #endif /* LINUX_TIMEX_H */
diff --git a/kernel/timer.c b/kernel/timer.c
index b9dad39..fe3a9a9 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -717,12 +717,16 @@ static void second_overflow(void)
 #endif
 }
 
-/* in the NTP reference this is called "hardclock()" */
-static void update_wall_time_one_tick(void)
+/*
+ * Returns how many microseconds we need to add to xtime this tick
+ * in doing an adjustment requested with adjtime.
+ */
+static long adjtime_adjustment(void)
 {
-	long time_adjust_step, delta_nsec;
+	long time_adjust_step;
 
-	if ((time_adjust_step = time_adjust) != 0 ) {
+	time_adjust_step = time_adjust;
+	if (time_adjust_step) {
 		/*
 		 * We are doing an adjtime thing.  Prepare time_adjust_step to
 		 * be within bounds.  Note that a positive time_adjust means we
@@ -733,10 +737,19 @@ static void update_wall_time_one_tick(vo
 		 */
 		time_adjust_step = min(time_adjust_step, (long)tickadj);
 		time_adjust_step = max(time_adjust_step, (long)-tickadj);
+	}
+	return time_adjust_step;
+}
 
+/* in the NTP reference this is called "hardclock()" */
+static void update_wall_time_one_tick(void)
+{
+	long time_adjust_step, delta_nsec;
+
+	time_adjust_step = adjtime_adjustment();
+	if (time_adjust_step)
 		/* Reduce by this step the amount of time left  */
 		time_adjust -= time_adjust_step;
-	}
 	delta_nsec = tick_nsec + time_adjust_step * 1000;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
@@ -759,6 +772,22 @@ static void update_wall_time_one_tick(vo
 }
 
 /*
+ * Return how long ticks are at the moment, that is, how much time
+ * update_wall_time_one_tick will add to xtime next time we call it
+ * (assuming no calls to do_adjtimex in the meantime).
+ * The return value is in fixed-point nanoseconds with SHIFT_SCALE-10
+ * bits to the right of the binary point.
+ * This function has no side-effects.
+ */
+u64 current_tick_length(void)
+{
+	long delta_nsec;
+
+	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
+	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
+}
+
+/*
  * Using a loop looks inefficient, but "ticks" is
  * usually just one (we shouldn't be losing ticks,
  * we're doing this this way mainly for interrupt
