Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWHWGZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWHWGZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWHWGZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:25:48 -0400
Received: from science.horizon.com ([192.35.100.1]:14144 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932365AbWHWGZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:25:47 -0400
Date: 23 Aug 2006 02:25:46 -0400
Message-ID: <20060823062546.12798.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux time code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to summarize the kernel/NTP interaction for those not familiar....

The NTP daemon exchanges pings with a number of time sources.  Each ping
produces a round-trip time and a time offset; the latter is computed by
assuming that the one-way trip times are equal.  This is of course not
true, but is closest to true for pings with the shortest round-trip time,
and NTP tries to use those.

The sources are individually sanity-checked, then checked against each
other, in a rather complex way that has proved to be robust in practice.

I don't want to go into it in great detail, but there are three stages of
filtering after the per-source processing:
1) Selection, which takes all the sources' claims for the right time and
   the error in their claims, and finds the interval where the largest
   possible number of them overlap.  Sources that do not participate in
   the overlap do not proceed to clustering.
2) Clustering, where sources that are furthest from the average are
   repeatedly dropped to decrease the standard deviation.
3) Combining, where the remaining sources are averaged, weighted by
   their quality claims.

Note that a tight accuracy claim increases a source's weight in the third
stage, but makes it more likely that it'll be excluded by the first and
second stage filters.

The above operation is run periodically (whenever there is new data from
one of the sources), and the output is a report on the amount by which
the local clock disagrees with the "right time", and a few associated
quality metrics.

This single time offset (and associated quality estimates) is the input
to "clock disipline algorithm".  This is where it starts to get relevant
to the kernel.

NTP needs to divide the observed error into two categories: phase error
and frequency error.  The former is time offset that is uncorrelated
from sample to sample, and can be reduced by longer averaging.

The latter is due to the local clock's frequency changing, and cannot be
reduced by averaging.  Indeed, if you try to average together successive
errors of +1 ms, +2 ms, +3 ms, +4 ms, etc, the longer you average the
worse off you'll be before you start correcting and doing something
about the problem.

Now, phase error, a.k.a. jitter, is dominant over short time spans.
One simple source is the measurement granularity of your clock.
If you can only measure with 1 us resolution, you'll have +/-0.5 us of
jitter just from that.

Frequency error, a.k.a. wander, accumulates with time, so is dominant
over longer time intervals, particular intervals over 1000 seconds.


When NTP first starts up, it considers all error to be frequency error,
to get the clock into approximately the right range.  This is not
terribly accurate, but numerically very stable; it never oscillates.
After a while, it shifts to a phase-locked loop where most of the error
is deemed to be phase error, and only a bit is frequency error.  This can
produce the best time, but can freak out and overshoot if the offsets
used as input are bizarrely behaved.  NTP adjusts the polling interval,
to check with the clock sources more frequently, if it notices that
things are getting a bit weird, and falls back to the frequency-locked
loop if it notices that things have gotten really bad.


Anyway, at the end of this computation, you get a frequency and phase
(time) correction to be applied to the local clock.  This is then applied
by adjusting the frequency of the system clock.  The frequency correction
is applied permanently; the phase correction is applied by adjusting
the frequency a bit more for a short while.

To be precise, 1/64 of the current phase error estimate is corrected
per second, and the phase error estimate is reduced accordingly.
This continues until the phase error is reduced to zero, or a new phase
error is computed.  So if the phase error is 64 microseconds, the clock is
adjusted by 1 ppm for one second, then by 64/64 ppm for the next second,
and so on.  This gives a half-life of 44 seconds.


Anyway, implementing the exponential phase correction in the kernel is
optional; when NTP really wants is a knob to adjust the clock frequency.
It can just call that once per second to make phase corrections if
requited.

In practice, we pass the frequency and phase corrections into the
kernel via the adjtimex() call and let it amortize the phase correction.
Although more than strictly necessary, this is not all bad, as it avoids
the need to wake up a daemon every second to fiddle the clock frequency.
Theoretically, you can code all of this to not wake the kernel up every
tick, although it's not implemented that way right now.

Also note that the current exponential-average way of making gradual
phase corrections is not very critical.  You want to get the total
right, but typical closed-loop time-sync applications aren't even
very sensitive to errors there.  The details of the amortization
schedule are quite non-critical.

So if a tickless user-mode Linux instance is woken up after
a long sleep, it would be more than good enough to process the interval as:

	half_lives = interval / 44;
	interval -= half_lives * 44;
	correction = time_offset;
	correction -= time_offset >>= half_lives;
	xtime += correction;

	/* ... other necessary stuff from second_overflow */

	while (interval--)
		second_overflow();

--- Postscript: Tangents ---

My pet idea on how to do precision timestamping is to separate grabbing
a low-level timer read from converting to portable time units.  If you
can bound the time elapsed between those two events, you can just
keep the information needed to do the conversion around for that long.
If you can tolerate some slop in old time conversions, you can easily do
lossy compression on old conversion parameters.  If you use an piecewise
linear transformation between raw and portable timestamps (seconds =
raw * period + offset, valid for some interval), then you can collapse
two such segments into one by a suitable average of the clock periods.

The one problem there is that, given two adjacent raw samples, if one
is delayed a long time before being converted to a portable timestamp,
the lossy compression can violate monotonicity; i.e. the portable
timestamps might come out in the wrong order.  I have to confess, I
can't think of a 100% fix other than a hard bound on time to convert,
or a probably-messier-than-it's-worth registration of unconverted raw
timestamps which can be converted as part of pushing the conversion
parameters out of scope.  (The whole idea is to move work out of
hardirq handlers.)

However, is this sort of large conversion-delay skew for closely-spaced
timestamps likely?  It seems that they would have to come through
different code paths, and then does the ordering at the microsecond
level matter?


Oh, and if you're going to implement Posix gettimeofday(), have a look at
Markus Kuhn's UTS proposal (http://www.cl.cam.ac.uk/~mgk25/uts.txt).
Given that Posix mandates that days have 86400 seconds
(http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap04.html#tag_04_14),
but the UTC standard maintained by the BIPM
(http://www.bipm.fr/en/scientific/tai/time_server.html) mandates
that days sometimes have 86401 seconds, his system is arguably
the least insane way to reconcile the irreconcilable.
(See also http://www.cl.cam.ac.uk/~mgk25/volatile/ITU-R-TF.460-4.pdf)

E.g.  The follwing handles positive leap seconds (only).
next_leap_second is the Posix timestamp of the next leap
second (23:59:60), which is always a multiple of 86400.
(http://hpiers.obspm.fr/eop-pc/earthor/utc/TAI-UTC_tab.html)

If you wanted to add the (strictly theoretical and never likely to be
used) negative leap second code, you could distinguish negative leap
seconds by the fact that next_leap_second is odd (congruent to -1
mod 86400).

#define MILLION 1000000
#define BILLION 1000000000

extern unsigned tai_minus_utc;	/* Currently 33 */
extern time_t next_leap_second;	/* UTC time after which tai_minus_utc++ */

	switch (clk_id) {
	case CLOCK_UTC:
		clock_gettime(CLOCK_TAI, tp);
		tp->tv_sec -= tai_minus_utc;
		/* Leap seconds per http://www.cl.cam.ac.uk/~mgk25/time/c/ */
		if (tp->tv_sec >= next_leap_second) {
			if (tp->tv_sec == next_leap_second)
				tp->tv_nsec += BILLION;
			tp->tv_sec--;
		}
		break;
	case CLOCK_UTS:
		/* Recommended for gettimeofday() & time() */
		/* See http://www.cl.cam.ac.uk/~mgk25/uts.txt */
		clock_gettime(CLOCK_TAI, tp);
		tp->tv_sec -= tai_minus_utc;
		if (tp->tv_sec > next_leap_second) {
			tp->tv_sec--;
		} else if (next_leap_second - tp->tv_sec < 1000) {
			/* 1000 UTC/TAI seconds = 999 UTS seconds */
			uint32_t offset = next_leap_second - tp->tv_sec + 1;
			offset *= MILLION;
			offset += (uint32_t)(BILLION - tp->tv_nsec)/1000;
			if ((tp->tv_nsec -= offset) < 0) {
				tp->tv_nsec += BILLION;
				tp->tv_sec--;
			}
		}
		break;
	}
