Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWFPDVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWFPDVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWFPDV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:21:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60318 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750923AbWFPDV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:21:29 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606151319440.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
	 <1149538810.9226.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606052226150.32445@scrub.home>
	 <1149622955.4266.84.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606070005550.32445@scrub.home>
	 <1149753904.2764.24.camel@leatherman>
	 <Pine.LNX.4.64.0606151319440.32445@scrub.home>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 20:21:24 -0700
Message-Id: <1150428084.15267.74.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 13:40 +0200, Roman Zippel wrote:
> On Thu, 8 Jun 2006, john stultz wrote:
> 
> > > This code gets only limited testing in -mm, it needs to run for weeks 
> > > or months, which I don't expect from the average -mm kernel. This makes 
> > > userspace simulations so damn important and if you don't do this, you're 
> > > playing a very risky game with a kernel which is supposed to be stable.
> > 
> > Agreed, simulation is nice. Thus, I've revived the old simulator which
> > builds using the existing code in -mm. Its a bit fast/dirty and isn't
> > exactly like your sim, but maybe you can take a look at it and send
> > patches to improve it?
> > 
> > You can find it at:
> > http://sr71.net/~jstultz/tod/simulator_C2.tar.bz2
> 
> At http://www.xs4all.nl/~zippel/ntp/simulator_C2+patches.tar.bz2 is my 
> version where I added a number of patches (all p? patches) to get it into 
> an acceptable state. You have a number of bugs which actually didn't let 
> the clock oscillate that much but instead added random jitter (and in some 
> cases a lot of it).

I've been working on the simulator as well, and you're right, it caught
a few problems. I appreciate your prodding me to get it running again.

My current version is here:
http://sr71.net/~jstultz/tod/gtod-sim_C2.1.tar.bz2


Some of the improvements :
o I've added random offsets so increment_simulator_time doesn't always
increment to a INTERVAL boundary. 

o Improved the random "tick dropping" (its a bad name, but it changes
the frequency at which update_wall_time is called) so you can specify
the frequency.

o Added a seed argument so the random results can be reproduced.

o Added the PPM randomization as suggested in your patch (I had to
implement it differently as it collided w/ the random offset code).



Just quickly so you don't have to read the README:

./todsim <drift> <seed> <droptick>

Where:
o drift is the ppm drift. if not specified or zero, it will be randomly
changed as the test runs.

o seed is seeds the random function. If not specified or zero time()
will be used.

o droptick is the frequency that ticks are taken. update_wall_time will
be called randomly w/ 1/<droptick> frequency. Thus if droptick is 1000,
we will on average only call update_wall_time once per 1000 ticks. If
not specified, it will be set to one.



> I disabled the lost interrupt simulation, so the effect of adjustments are 
> better visible, the error should return to near zero after it. Look for 
> the "ppm" prints and watch the time difference.
> In the series file you can enable some debug patches (d?) to add extra 
> prints or simulate large update delays to see the effect on the error 
> difference.

Very cool. I appreciate the small incremental patches. I've looked over
them and am trying to see which ones make sense in light of the
following info.

I've also been working on improving the adjustment algorithm. Paul
Mckenney enlightened me to the established concepts in control theory, I
started reading up on PID control (see:
http://en.wikipedia.org/wiki/PID_controller ). While I have understood
the basic concept, it was useful to read up on it. I've tried to rework
the adjustment code accordingly.

The method I came up with is really just P-D (proportional-derivative)
control, but that should be ok since the adjustments are all linear so I
don't think the integral control is necessary (control theorists can
pipe in here).


The basic algorithm is as follows:

	update_error =0;
	interval_cycs = 0;
	while (offset >= clock->interval_cycles) {
		/* accumulate one interval */
		remainder_snsecs += clock->interval_snsecs;
		...
		/* accumulate error between NTP and clock interval */
		update_error += current_tick_length(clock->shift);
		update_error -= clock->interval_snsecs;
		interval_cycs += clock->interval_cycles;

		...
	}
	/* add error accumulated since last interrupt */
	total_error += update_error;

	if (total_error > (s64)clock->interval_cycles
			|| total_error < -((s64)clock->interval_cycles)) {

		/* derivative control: fix the slope */
		freqadj = update_error/((s64)interval_cycs);

		/* proportional control: converge to zero */
		offadj = total_error/(s64)interval_cycs;

		/* limiter to avoid oscillation */
		if (offadj > MAXOFFADJ)
			offadj = MAXOFFADJ;
		else if(offadj < -MAXOFFADJ)
			offadj = -MAXOFFADJ;

		/* make the adjustment */	
		multadj = freqadj + offadj;
		clock->mult += multadj;
		clock->interval_snsecs = clock->mult * clock->interval_cycles;
		remainder_snsecs -= multadj * (s64)offset;
		total_error += multadj * offset;
	}

Then using the same method in your bigadjust function, I can approximate
the divides and the rest is very similar to your suggestions.

The full patch for -mm is attached below (Andrew, please don't take this
just yet, I'm doing more testing and I'd like Roman's feedback first).

After applying this to -mm and generating the simulator from the result,
I've found this to be *very* robust (it keeps proportionally close with
the frequency of lost ticks, and doesn't have issue w/ ppm changes).
Please take a look at it and let me know what you think.

thanks
-john


diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 4bc9428..2993521 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -181,46 +181,57 @@ static inline void clocksource_calculate
  *
  * @error:	Error value (unsigned)
  * @unit:	Adjustment unit
+ * @max:	Limit on adjustment unit
  *
  * For a given error value, this function takes the adjustment unit
  * and uses binary approximation to return a power of two adjustment value.
  *
- * This function is only for use by the the make_ntp_adj() function
- * and you must hold a write on the xtime_lock when calling.
  */
-static inline int error_aproximation(u64 error, u64 unit)
+static int error_aproximation(u64 error, u64 unit, int max)
 {
-	static int saved_adj = 0;
-	u64 adjusted_unit = unit << saved_adj;
-
-	if (error > (adjusted_unit * 2)) {
-		/* large error, so increment the adjustment factor */
-		saved_adj++;
-	} else if (error > adjusted_unit) {
-		/* just right, don't touch it */
-	} else if (saved_adj) {
-		/* small error, so drop the adjustment factor */
-		saved_adj--;
-		return 0;
+	int adj = 0;
+	while (1) {
+		error >>= 1;
+		if (error <= unit)
+			return adj;
+		if (!max || adj < max)
+			adj++;
 	}
-
-	return saved_adj;
 }
 
 
+#define MAXOFFADJ 4 /* vary max oscillation vs convergance speed */
+
 /**
- * make_ntp_adj - Adjusts the specified clocksource for a given error
+ * clocksource_adj - Adjusts the specified clocksource for a given error
  *
  * @clock:		Pointer to clock to be adjusted
- * @cycles_delta:	Current unacounted cycle delta
- * @error:		Pointer to current error value
+ * @cycles_delta:	Current unaccumulated cycle delta
+ * @total_error:	Pointer to current total error value
+ * @interval_error:	Error accumulated since the last sample
+ * @interval_cycs:      Accumulated cycles since the last sample
  *
  * Returns clock shifted nanosecond adjustment to be applied against
  * the accumulated time value (ie: xtime).
  *
- * If the error value is large enough, this function calulates the
- * (power of two) adjustment value, and adjusts the clock's mult and
- * interval_snsecs values accordingly.
+ * If the error value is large enough, this function aproximates
+ * the frequency and offset adjustment, and applies it to the 
+ * clock's mult and interval_snsecs values accordingly.
+ *
+ * This method of adjustment is similar to PID control.
+ * See http://en.wikipedia.org/wiki/PID_controller for more info.
+ * However we are really just doing P-D control, as since are adjustments
+ * are liniar, there is no need for the integral component of PID.
+ * The P-D control is done in two steps:
+ *    1) Proportonal control: (offset adjustment)
+ *         This makes adjustment based on the current error from NTP.
+ *         This adjustment is limited to avoid oscillation from missed
+ *         ticks.
+ *    2) Derivative control:
+ *         This makes adjustments based on the error accumulated in 
+ *         the last period (in otherwords, the different in error from 
+ *         the last period). This provides a frequency correction so no
+ *         additional error should be accumulated in the next period.
  *
  * However, since there may be some unaccumulated cycles, to avoid
  * time inconsistencies we must adjust the accumulation value
@@ -238,35 +249,89 @@ static inline int error_aproximation(u64
  *
  * Where mult_delta is the adjustment value made to mult
  *
+ * An aditional complication: Since we are adjusting the base value,
+ * we must also adjust the total_error value, as it is the distance
+ * of the base time from the NTP time. Thus we adjust the total_error
+ * by the negative amount we adjusted the base.
  */
-static inline s64 make_ntp_adj(struct clocksource *clock,
-				cycles_t cycles_delta, s64* error)
+static inline s64 clocksource_adj(struct clocksource *clock,
+				cycle_t cycles_delta, s64* total_error,
+				s64 interval_error, s64 interval_cycs)
 {
 	s64 ret = 0;
-	if (*error  > ((s64)clock->interval_cycles+1)/2) {
-		/* calculate adjustment value */
-		int adjustment = error_aproximation(*error,
-						clock->interval_cycles);
-		/* adjust clock */
-		clock->mult += 1 << adjustment;
-		clock->interval_snsecs += clock->interval_cycles << adjustment;
-
-		/* adjust the base and error for the adjustment */
-		ret =  -(cycles_delta << adjustment);
-		*error -= clock->interval_cycles << adjustment;
-		/* XXX adj error for cycle_delta offset? */
-	} else if ((-(*error))  > ((s64)clock->interval_cycles+1)/2) {
-		/* calculate adjustment value */
-		int adjustment = error_aproximation(-(*error),
-						clock->interval_cycles);
-		/* adjust clock */
-		clock->mult -= 1 << adjustment;
-		clock->interval_snsecs -= clock->interval_cycles << adjustment;
-
-		/* adjust the base and error for the adjustment */
-		ret =  cycles_delta << adjustment;
-		*error += clock->interval_cycles << adjustment;
-		/* XXX adj error for cycle_delta offset? */
+	s64 error = *total_error;
+		
+	if ((error > (s64)clock->interval_cycles)
+		||(error < -((s64)clock->interval_cycles)) ) {
+
+		int adj, multadj = 0;
+		s64 offset_update = 0, snsec_update = 0;
+
+		/* First do the frequency adjustment:
+		 *   The idea here is to look at the error 
+		 *   accumulated since the last call to 
+		 *   update_wall_time to determine the 
+		 *   frequency adjustment needed so no new
+		 *   error will be incurred in the next
+		 *   interval.
+		 *
+		 *   This is basically derivative control
+		 *   using the PID terminology (we're calculating
+		 *   the derivative of the slope and correcting it).
+		 *
+		 *   The math is basically:
+		 *      multadj = interval_error/interval_cycles
+		 *   Which we fudge using binary approximation.
+		 */
+		if(interval_error >= 0) {
+			adj = error_aproximation(interval_error,
+						 interval_cycs, 0);
+			multadj += 1 << adj;
+			snsec_update += clock->interval_cycles << adj;
+			offset_update += cycles_delta << adj;
+		} else {
+			adj = error_aproximation(-interval_error, 
+						interval_cycs, 0);
+			multadj -= 1 << adj;
+			snsec_update -= clock->interval_cycles << adj;
+			offset_update -= cycles_delta << adj;
+		}
+		/* Now do the offset adjustment:
+		 *   Now that the frequncy is fixed, we
+		 *   want to look at the total error accumulated
+		 *   to move us back in sync using the same method.
+		 *   However, we must be careful as if we make too 
+		 *   sudden an adjustment we might overshoot. So we 
+		 *   limit the amount of change to spread the 
+		 *   adjustment (using MAXOFFADJ) over a longer 
+		 *   period of time.
+		 *
+		 *   This is basically proportional control
+		 *   using the PID terminology.
+		 *
+		 *   We use interval_cycs here as the divisor, which
+		 *   hopes that the next sample will be similar in 
+		 *   distance from the last.
+		 */
+		if(error >= 0) {
+			adj = error_aproximation(error, 
+						interval_cycs, MAXOFFADJ);
+			multadj += 1<<adj;
+			snsec_update += clock->interval_cycles <<adj;
+			offset_update += cycles_delta << adj;
+		} else {
+			adj = error_aproximation(-error,
+						interval_cycs, MAXOFFADJ);
+			multadj -= 1<<adj;
+			snsec_update -= clock->interval_cycles <<adj;
+			offset_update -= cycles_delta << adj;
+		}
+
+		clock->mult += multadj;
+		clock->interval_snsecs += snsec_update;;		
+		ret -= offset_update;
+		*total_error += offset_update;
+
 	}
 	return ret;
 }
diff --git a/kernel/timer.c b/kernel/timer.c
index 0569d40..1345759 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1025,9 +1025,9 @@ device_initcall(timekeeping_init_device)
  */
 static void update_wall_time(void)
 {
-	static s64 remainder_snsecs, error;
-	s64 snsecs_per_sec;
-	cycle_t now, offset;
+	static s64 remainder_snsecs, total_error;
+	s64 snsecs_per_sec, interval_error = 0;
+	cycle_t now, offset, interval_cycs = 0; 
 
 	snsecs_per_sec = (s64)NSEC_PER_SEC << clock->shift;
 	remainder_snsecs += (s64)xtime.tv_nsec << clock->shift;
@@ -1038,7 +1038,7 @@ static void update_wall_time(void)
 	/* normally this loop will run just once, however in the
 	 * case of lost or late ticks, it will accumulate correctly.
 	 */
-	while (offset > clock->interval_cycles) {
+	while (offset >= clock->interval_cycles) {
 		/* get the ntp interval in clock shifted nanoseconds */
 		s64 ntp_snsecs	= current_tick_length(clock->shift);
 
@@ -1054,10 +1054,8 @@ static void update_wall_time(void)
 		update_ntp_one_tick();
 
 		/* accumulate error between NTP and clock interval */
-		error += (ntp_snsecs - (s64)clock->interval_snsecs);
-
-		/* correct the clock when NTP error is too big */
-		remainder_snsecs += make_ntp_adj(clock, offset, &error);
+		interval_error += (ntp_snsecs - (s64)clock->interval_snsecs);
+		interval_cycs += clock->interval_cycles;
 
 		if (remainder_snsecs >= snsecs_per_sec) {
 			remainder_snsecs -= snsecs_per_sec;
@@ -1065,13 +1063,20 @@ static void update_wall_time(void)
 			second_overflow();
 		}
 	}
+
+	total_error += interval_error;
+
+	/* correct the clock when NTP error is too big */
+	remainder_snsecs += clocksource_adj(clock, offset, &total_error,
+					interval_error, interval_cycs);
+
 	/* store full nanoseconds into xtime */
 	xtime.tv_nsec = remainder_snsecs >> clock->shift;
 	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
 
 	/* check to see if there is a new clocksource to use */
 	if (change_clocksource()) {
-		error = 0;
+		total_error = 0;
 		remainder_snsecs = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}


