Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWCWDGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWCWDGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWCWDGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:06:33 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:22187 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932115AbWCWDGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:06:14 -0500
Date: Wed, 22 Mar 2006 20:06:07 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mackerras <paulus@samba.org>
Message-Id: <20060323030606.19338.46175.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 3/10] Time: Let user request precision from current_tick_length()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Change the current_tick_length() function so it takes an 
argument which specifies how much precision to return in shifted 
nanoseconds. This provides a simple way to convert between NTPs 
internal nanoseconds shifted by (SHIFT_SCALE - 10)  to other shifted 
nanosecond units that are used by the clocksource abstraction.

Signed-off-by John Stultz <johnstul@us.ibm.com>

 arch/powerpc/kernel/time.c |    2 +-
 include/linux/timex.h      |    2 +-
 kernel/timer.c             |   21 +++++++++++++++++----
 3 files changed, 19 insertions(+), 6 deletions(-)

linux-2.6.16_timeofday-core2_C1.patch
============================================
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 86f7e3d..08a53a4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -315,7 +315,7 @@ static __inline__ void timer_recalc_offs
 
 	if (__USE_RTC())
 		return;
-	tlen = current_tick_length();
+	tlen = current_tick_length(SHIFT_SCALE - 10);
 	offset = cur_tb - do_gtod.varp->tb_orig_stamp;
 	if (tlen == last_tick_len && offset < 0x80000000u)
 		return;
diff --git a/include/linux/timex.h b/include/linux/timex.h
index b7ca120..e239f2d 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -346,7 +346,7 @@ time_interpolator_reset(void)
 #endif /* !CONFIG_TIME_INTERPOLATION */
 
 /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
-extern u64 current_tick_length(void);
+extern u64 current_tick_length(long);
 
 #endif /* KERNEL */
 
diff --git a/kernel/timer.c b/kernel/timer.c
index 78a9d03..dc9b4ec 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -791,16 +791,29 @@ static void update_wall_time_one_tick(vo
  * Return how long ticks are at the moment, that is, how much time
  * update_wall_time_one_tick will add to xtime next time we call it
  * (assuming no calls to do_adjtimex in the meantime).
- * The return value is in fixed-point nanoseconds with SHIFT_SCALE-10
- * bits to the right of the binary point.
+ * The return value is in fixed-point nanoseconds shifted by the
+ * specified number of bits to the right of the binary point.
  * This function has no side-effects.
  */
-u64 current_tick_length(void)
+u64 current_tick_length(long shift)
 {
 	long delta_nsec;
+	u64 ret;
 
+	/* calculate the finest interval NTP will allow.
+	 *    ie: nanosecond value shifted by (SHIFT_SCALE - 10)
+	 */
 	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
-	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
+	ret = ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
+
+	/* convert from (SHIFT_SCALE - 10) to specified shift scale: */
+	shift = shift - (SHIFT_SCALE - 10);
+	if (shift < 0)
+		ret >>= -shift;
+	else
+		ret <<= shift;
+
+	return ret;
 }
 
 /* XXX - all of this timekeeping code should be later moved to time.c */
