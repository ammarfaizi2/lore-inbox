Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750708AbWFEUxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWFEUxk (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFEUxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:53:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:53462 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750708AbWFEUxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:53:39 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1149538810.9226.29.camel@localhost.localdomain>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
	 <1149538810.9226.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 13:53:32 -0700
Message-Id: <1149540812.11470.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 13:20 -0700, john stultz wrote:
> On Mon, 2006-06-05 at 01:50 +0200, Roman Zippel wrote:
> > > time-let-user-request-precision-from-current_tick_length.patch
> > 
> > This is broken, as it simply throws away resolution depending on the 
> > clock.
> 
> So if the clock shift value is less then 12 (SHIFT_SCALE - 10), this is
> true, and currently that's only the jiffies case.
> 
> Just to be clear, are you then suggesting that the accumulation in
> update_wall_time should be done in a fixed shifted nanosecond unit
> regardless of the clock shift value? Is SHIFT_SCALE-10, good enough in
> your mind for this?
> 
> That seems not too difficult to do, and can be done w/ an incremental
> patch. I'll try to crank that out today.

Just to quickly get some feedback on this. Currently untested (I'm
working on that part now - Andrew, I'll send it to once it clears), but
it builds.

Roman: Your thoughts? Does it cover your concern?

thanks
-john


diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 4bc9428..884980a 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -146,14 +146,17 @@ static inline s64 cyc2ns(struct clocksou
 	return ret;
 }
 
+
+#define CLOCKSOURCE_INTERVAL_SHIFT (SHIFT_SCALE - 10)
+
 /**
  * clocksource_calculate_interval - Calculates a clocksource interval struct
  *
  * @c:		Pointer to clocksource.
  * @length_nsec: Desired interval length in nanoseconds.
  *
- * Calculates a fixed cycle/nsec interval for a given clocksource/adjustment
- * pair and interval request.
+ * Calculates a fixed cycle/nsec interval (in CLOCKSOURCE_INTERVAL_SHIFT units)
+ * for a given clocksource/adjustment pair and interval request.
  *
  * Unless you're the timekeeping code, you should not be using this!
  */
@@ -164,7 +167,7 @@ static inline void clocksource_calculate
 
 	/* XXX - All of this could use a whole lot of optimization */
 	tmp = length_nsec;
-	tmp <<= c->shift;
+	tmp <<= CLOCKSOURCE_INTERVAL_SHIFT;
 	tmp += c->mult/2;
 	do_div(tmp, c->mult);
 
@@ -215,8 +218,8 @@ static inline int error_aproximation(u64
  * @cycles_delta:	Current unacounted cycle delta
  * @error:		Pointer to current error value
  *
- * Returns clock shifted nanosecond adjustment to be applied against
- * the accumulated time value (ie: xtime).
+ * Returns CLOCKSOURCE_INTERVAL_SHIFT shifted nanosecond adjustment to be
+ * applied against the accumulated time value (ie: xtime).
  *
  * If the error value is large enough, this function calulates the
  * (power of two) adjustment value, and adjusts the clock's mult and
diff --git a/kernel/timer.c b/kernel/timer.c
index 0569d40..588bfcd 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1029,8 +1029,8 @@ static void update_wall_time(void)
 	s64 snsecs_per_sec;
 	cycle_t now, offset;
 
-	snsecs_per_sec = (s64)NSEC_PER_SEC << clock->shift;
-	remainder_snsecs += (s64)xtime.tv_nsec << clock->shift;
+	snsecs_per_sec = (s64)NSEC_PER_SEC << CLOCKSOURCE_INTERVAL_SHIFT;
+	remainder_snsecs += (s64)xtime.tv_nsec << CLOCKSOURCE_INTERVAL_SHIFT;
 
 	now = clocksource_read(clock);
 	offset = (now - last_clock_cycle)&clock->mask;
@@ -1039,8 +1039,11 @@ static void update_wall_time(void)
 	 * case of lost or late ticks, it will accumulate correctly.
 	 */
 	while (offset > clock->interval_cycles) {
-		/* get the ntp interval in clock shifted nanoseconds */
-		s64 ntp_snsecs	= current_tick_length(clock->shift);
+		/* get the ntp interval in CLOCKSOURCE_INTERVAL_SHIFT 
+		 * shifted nanoseconds:
+		 */
+		s64 ntp_snsecs =
+			current_tick_length(CLOCKSOURCE_INTERVAL_SHIFT);
 
 		/* accumulate one interval */
 		remainder_snsecs += clock->interval_snsecs;
@@ -1049,7 +1052,7 @@ static void update_wall_time(void)
 
 		/* interpolator bits */
 		time_interpolator_update(clock->interval_snsecs
-						>> clock->shift);
+						>> CLOCKSOURCE_INTERVAL_SHIFT);
 		/* increment the NTP state machine */
 		update_ntp_one_tick();
 
@@ -1066,8 +1069,8 @@ static void update_wall_time(void)
 		}
 	}
 	/* store full nanoseconds into xtime */
-	xtime.tv_nsec = remainder_snsecs >> clock->shift;
-	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
+	xtime.tv_nsec = remainder_snsecs >> CLOCKSOURCE_INTERVAL_SHIFT;
+	remainder_snsecs -= (s64)xtime.tv_nsec << CLOCKSOURCE_INTERVAL_SHIFT;
 
 	/* check to see if there is a new clocksource to use */
 	if (change_clocksource()) {


