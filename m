Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWDCUIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWDCUIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 16:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWDCUIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 16:08:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6377 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964870AbWDCUIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 16:08:47 -0400
Date: Mon, 3 Apr 2006 22:08:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
Message-ID: <Pine.LNX.4.64.0604032200020.17704@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is a first draft of some documentation which hopefully helps to
better understand the clock update function. It tries to introduce the 
various concepts in small logical steps from the basic xtime updates to 
the continuous clocks with full error adjustment.
It's still rather raw, but it contains all the information one has to 
understand to adjust and customize the clock update code.

Feedback welcome. :)

bye, Roman



There are three basic time variables related to time management:

- cycles: managed by the hardware clock
- ntp_time: managed by the NTP system and is updated in regular
  intervals (ticks)
- xtime: local base time as used by gettimeofday

Each variable is regularly updated:

- cycle_update: defines the basic tick frequency and is initialized with
  (frequency / HZ)
- ntp_update: is calculated by the NTP system
- xtime_update: is derived from cycle_update using a conversion factor
  (cycle_update*mult)

gettimeofday uses xtime and the cycle counter to calculate the current
time:

	timeofday = xtime + cycle_offset * mult;

cycle_offset is the offset to the last timer tick and mult is a fixed
point conversion factor from cycles to seconds. mult is initialized
based on the equivalence of 1 sec to frequency cycles:

	1 sec = frequency * mult
	mult = 10^9 nsec / frequency

Time is updated at every tick (after cycle_update cycles), which for a
simple system system looks like this:

	xtime = ntp_time += ntp_update;
	if (xtime.tv_nsec >= NSEC_PER_SEC) {
		ntp_time -= NSEC_PER_SEC;
		xtime.tv_nsec -= NSEC_PER_SEC;
		xtime.tv_sec++;
		second_overflow();
	}

xtime and ntp_time are basically identical, which means at every update
step gettimeofday can jump by a small error value (ntp_update -
xtime_update). To avoid this jump we have to update ntp_time and xtime
separately:

	ntp_time += ntp_update;
	xtime += cycle_update * mult;
	if (xtime.tv_nsec >= NSEC_PER_SEC) {
		ntp_time -= NSEC_PER_SEC;
		xtime.tv_nsec -= NSEC_PER_SEC;
		xtime.tv_sec++;
		second_overflow();
	}
	error = ntp_time - xtime;
	mult_adj = error / cycle_update;
	mult += mult_adj;

This produces an error between ntp_time and xtime and to keep both
synchronized, we have to modify mult (the only other variable in the
timeofday calculation).  mult_adj is the difference between the new and
old multiplier and is derived from:

	cycle_update * mult_new = cycle_update * mult + error

One big problem with this is that we only look at the current error,
which causes the multiplier to oscillate if ntp_update changes (the
adjustments are applied too late), so it's better to look ahead to the
next update:

	ntp_time += ntp_update;
	xtime += cycle_update * mult;
	if (xtime.tv_nsec >= NSEC_PER_SEC) {
		ntp_time -= NSEC_PER_SEC;
		xtime.tv_nsec -= NSEC_PER_SEC;
		xtime.tv_sec++;
		second_overflow();
	}
	error = (ntp_time + ntp_update) - (xtime + cycle_update * mult);
	mult_adj = error / cycle_update;
	mult += mult_adj;

The important thing here is that the error calculation happens after
calling second_overflow(), which is the main callback for the NTP system
to update ntp_update.
Instead of calculating the complete error every time, we can also update
the error incrementally and avoid maintaining ntp_time:

	xtime += cycle_update * mult;
	if (xtime.tv_nsec >= NSEC_PER_SEC) {
		xtime.tv_nsec -= NSEC_PER_SEC;
		xtime.tv_sec++;
		second_overflow();
	}
	error += ntp_update - cycle_update * mult;
	mult_adj = error / cycle_update;
	mult += mult_adj;
	error -= cycle_update * mult_adj;

This is probably the step, which makes the calculation less obvious as
there is no explicit ntp_time anymore and is instead maintained via the
difference to xtime. It's very important to keep in mind that the error
is for the next update step, so if we change the multiplier for the next
tick, we also have to adjust the error:

	cycle_update * mult - cycle_update * mult_new

as at the next step xtime is not advanced by (cycle_update * mult)
anymore but (cycle_update * mult_new) instead.

Note that although we don't maintain the ntp_time value anymore, the
complexity has only shifted to the error calculation, but since under
normal circumstances (clock is synchronized and stable) adjustments to
the multiplier are less common events, the calculation becomes cheaper
with a simple error update and occasional error adjustments.

This is already sufficient for simple systems, but interrupts can delay
the update step, so that we can see small time jumps due to the
multiplier adjustments. To avoid this we have to include the current
cycle_offset into the calculation:

	xtime += cycle_update * mult;
	if (xtime.tv_nsec >= NSEC_PER_SEC) {
		xtime.tv_nsec -= NSEC_PER_SEC;
		xtime.tv_sec++;
		second_overflow();
	}
	error += ntp_update - cycle_update * mult;
	mult_adj = error / cycle_update;
	mult += mult_adj;
	xtime -= cycle_offset * mult_adj;
	error -= (cycle_update - cycle_offset) * mult_adj;

We adjust xtime to keep the current time the same after the multiplier
change:

	xtime_new + cycle_offset * mult_new = xtime + cycle_offset * mult

Since we change xtime, we don't have to forget to also adjust the error
by the same amount.


If the time is now updated in very irregular intervals, it can happen
that we skipped an update step, where we can either just repeat
everything or skip a few error adjustment steps and do them at the end
instead:

	while (cycle_offset >= cycle_update) {
		cycles_last += cycle_update;
		cycle_offset -= cycle_update;
		xtime += cycle_update * mult;
		if (xtime.tv_nsec >= NSEC_PER_SEC) {
			xtime.tv_nsec -= NSEC_PER_SEC;
			xtime.tv_sec++;
			second_overflow();
		}
		error += ntp_update - cycle_update * mult;
	}
	mult_adj = error / cycle_update;
	mult += mult_adj;
	xtime -= cycle_offset * mult_adj;
	error -= (cycle_update - cycle_offset) * mult_adj;



