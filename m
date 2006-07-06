Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWGFAv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWGFAv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWGFAv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:51:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5785 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965102AbWGFAv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:51:57 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:51:54 -0700
Message-Id: <1152147114.24656.117.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 00:29 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 Jul 2006 03:13:39 +0200, Roman Zippel said:
> > Hi,
> > 
> > On Fri, 30 Jun 2006, Valdis.Kletnieks@vt.edu wrote:
> > 
> > > *AHA* I *found* the bugger, I think.
> > > 
> > > In kernel/timer.c, we have:
> > > 
> > > static void clocksource_adjust(struct clocksource *clock, s64 offset)
> > > (s64 used for offset in multiple places).
> > > 
> > > However, in other places, offset is a 'cycle_t', which is:
> > > 
> > > include/linux/clocksource.h:typedef u64 cycle_t;
> > > 
> > > So it looks like a signed/unsigned screwage.
> > 
> > It's a possibility, but the signed/unsigned usage is pretty much 
> > intentional. The assumptation is that time only goes forward so nothing 
> > there should become negative, only adjustments happen in both directions.
> > It's really weird why it's getting completely so out of control early 
> > during boot. It would be great if you could also test the patch below, it 
> > should trigger closer to when it goes wrong and help to analyze the 
> > problem (or at least rule out a number of possibilities).
> 
> Here you go.. For what it's worth, your debugging in clocksource_adjust seems
> to only pop before we start userspace, and get_realtime_clock_ts only once
> userspace starts.

Once again, thanks for the testing! My observations below...

> The dmesg, with all the suggested patches so far applied.  Looks like something
> starts off uninitialized - we get the first 'big adj' squawk right after we
> allocate the console - we don't allocate the tsc timesource for another 4
> seconds or so.
> 
> I'll bite - what *am* I using as a timesource for those first 4 seconds? :)

The jiffies clocksource.

> [    0.000000] Detected 1595.408 MHz processor.
...
>[   24.322196] CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
...
> [   29.528533] Time: tsc clocksource has been installed.
> [   29.552855] clock changed at -296333 (4294314460971008)
> [   29.577109] clock tsc: m:2628985,s:22,cl: ,ci:1595166,xn:0,xi:4193667486510,e:0

Ok, so here's our initial TSC state:

Verify the mult/shift pair:
2^s/m = 2^22/2628985 = 1.595408113777750729 cyc/ns => 1.595 GHz

Verify the cycle_interval/xtime_interval pair:
xi = ci*m = 1595166 * 2628985 = 4193667486510

Convert xi to ns:
xi>>s = 4193667486510>>22 = 999848.2433581352234 ns/interval

Convert ntp_tick to ns:
ntp_tick>>32 = 4294314460971008>>32 = 999848 ns/tick

Ok, that all looks pretty good...


> [   29.601869] big adj at -296332 (4294314460971008,-16,-25522656,-11031712)
> [   29.626688] clock tsc: m:2628985,s:22,cl:47288392250,ci:1595166,xn:148610636380190,xi:4193667486510,e:-76300711936

Now here's where things turn odd. Note that only one jiffy has passed
(-296332 - -296333 = 1).

However, looking at the difference between cycle_last:
47288392250 - 47171945132 = 116,447,118

That's *way* larger then the 1,595,166 value expected in ci!

Same thing is seen in the later data points:

47452694348 - 47368150550 = 84,543,798
47538833312 - 47452694348 = 86,138,964
etc.

So it seems either something is causing you to take interrupts at a
lower frequency then what is expected, or your cpu is ~50x faster then
advertised :)

This is probably not an issue w/ the timekeeping code, however as a
side-effect it appears to make the clocksource_adjust function oscillate
pretty severely. I've reproduced a similar hang (not completely sure, as
it occurred while X was loading) by adding the following to the top of
update_wall_time:

	static int droptick;
	if(droptick++%60)
		return;

Roman: While I'm not 100% confident about my assessment above, I worry
this is mimicking the problems I had been seeing in my simulator w/ your
clocksource_adjustment algorithm when I simulated dropping many ticks.
While currently this behavior points to some other problem, with the
dynticks patch, its much more likely that we will see 100s of ticks
skipped.

I quickly revived my P-D adjustment patch and it does not appear to
suffer from the same problem with the above droptick change (although
its only been lightly tested). 

I realize you may have a more trivial change to this issue, but would
you consider my method again?

Vladis: Mind trying the following patch to see if it affects the
behavior.

thanks
-john


Implement P-D control for clocksource_adjust()

diff --git a/kernel/timer.c b/kernel/timer.c
index 396a3c0..f4e7681 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1007,81 +1007,108 @@ static int __init timekeeping_init_devic
 
 device_initcall(timekeeping_init_device);
 
-/*
- * If the error is already larger, we look ahead another tick,
- * to compensate for late or lost adjustments.
- */
-static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 *interval, s64 *offset)
+static int error_aproximation(u64 error, u64 unit, int max)
 {
-	int adj;
-
-	/*
-	 * As soon as the machine is synchronized to the external time
-	 * source this should be the common case.
-	 */
-	error >>= 2;
-	if (likely(sign > 0 ? error <= *interval : error >= *interval))
-		return sign;
-
-	/*
-	 * An extra look ahead dampens the effect of the current error,
-	 * which can grow quite large with continously late updates, as
-	 * it would dominate the adjustment value and can lead to
-	 * oscillation.
-	 */
-	error += current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
-	error -= clock->xtime_interval >> 1;
-
-	adj = 0;
+	int adj = 0;
 	while (1) {
 		error >>= 1;
-		if (sign > 0 ? error <= *interval : error >= *interval)
-			break;
-		adj++;
+		if (error <= unit)
+			return adj;
+		if (!max || adj < max)
+			adj++;
 	}
-
-	/*
-	 * Add the current adjustments to the error and take the offset
-	 * into account, the latter can cause the error to be hardly
-	 * reduced at the next tick. Check the error again if there's
-	 * room for another adjustment, thus further reducing the error
-	 * which otherwise had to be corrected at the next update.
-	 */
-	error = (error << 1) - *interval + *offset;
-	if (sign > 0 ? error > *interval : error < *interval)
-		adj++;
-
-	*interval <<= adj;
-	*offset <<= adj;
-	return sign << adj;
 }
+#define MAXOFFADJ 4 /* vary max oscillation vs convergance speed */
 
 /*
  * Adjust the multiplier to reduce the error value,
  * this is optimized for the most common adjustments of -1,0,1,
  * for other values we can do a bit more work.
  */
-static void clocksource_adjust(struct clocksource *clock, s64 offset)
+static void clocksource_adjust(struct clocksource *clock, s64 offset,
+				s64 interval_cycs, s64 interval_error)
 {
 	s64 error, interval = clock->cycle_interval;
-	int adj;
-
-	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
-	if (error > interval) {
-		adj = clocksource_bigadjust(1, error, &interval, &offset);
-	} else if (error < -interval) {
-		interval = -interval;
-		offset = -offset;
-		adj = clocksource_bigadjust(-1, error, &interval, &offset);
-	} else
-		return;
+	
+	error = shift_right(clock->error, (TICK_LENGTH_SHIFT - clock->shift));
+	interval_error = shift_right(interval_error, 
+					(TICK_LENGTH_SHIFT - clock->shift));
+
+	if ((error > interval)
+		||(error < -(interval)) ) {
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
+						interval_cycs, 0);
+			multadj += 1 << adj;
+			snsec_update += interval << adj;
+			offset_update += offset << adj;
+		} else {
+			adj = error_aproximation(-interval_error, 
+						interval_cycs, 0);
+			multadj -= 1 << adj;
+			snsec_update -= interval << adj;
+			offset_update -= offset << adj;
+	        }
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
+					interval_cycs, MAXOFFADJ);
+			multadj += 1<<adj;
+			snsec_update += interval <<adj;
+			offset_update += offset << adj;
+		} else {
+			adj = error_aproximation(-error,
+						interval_cycs, MAXOFFADJ);
+			multadj -= 1<<adj;
+			snsec_update -= interval <<adj;
+			offset_update -= offset << adj;
+		}
 
-	clock->mult += adj;
-	clock->xtime_interval += interval;
-	clock->xtime_nsec -= offset;
-	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
+		clock->mult += multadj;
+		clock->xtime_interval += snsec_update;
+		clock->xtime_nsec -= offset_update;
+		clock->error += (offset_update) 
+					<< (TICK_LENGTH_SHIFT - clock->shift);
+	}
 }
 
+
 /*
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
@@ -1089,7 +1116,8 @@ static void clocksource_adjust(struct cl
  */
 static void update_wall_time(void)
 {
-	cycle_t offset;
+	cycle_t offset, interval_cycs = 0;
+	s64 interval_error = 0; 
 
 	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
 
@@ -1106,8 +1134,13 @@ static void update_wall_time(void)
 		/* accumulate one interval */
 		clock->xtime_nsec += clock->xtime_interval;
 		clock->cycle_last += clock->cycle_interval;
+		interval_cycs += clock->cycle_interval;
 		offset -= clock->cycle_interval;
 
+		/* accumulate error between NTP and clock interval */
+		interval_error += current_tick_length();
+		interval_error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
+
 		if (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
 			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
 			xtime.tv_sec++;
@@ -1119,14 +1152,10 @@ static void update_wall_time(void)
 						>> clock->shift);
 		/* increment the NTP state machine */
 		update_ntp_one_tick();
-
-		/* accumulate error between NTP and clock interval */
-		clock->error += current_tick_length();
-		clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
 	}
-
+	clock->error += interval_error;
 	/* correct the clock when NTP error is too big */
-	clocksource_adjust(clock, offset);
+	clocksource_adjust(clock, offset, interval_cycs, interval_error);
 
 	/* store full nanoseconds into xtime */
 	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;


