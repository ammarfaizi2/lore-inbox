Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUAVC0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 21:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUAVC0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 21:26:49 -0500
Received: from mail.shareable.org ([81.29.64.88]:6807 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266161AbUAVC0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 21:26:45 -0500
Date: Thu, 22 Jan 2004 02:26:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timing code in 2.6.1
Message-ID: <20040122022624.GA4392@mail.shareable.org>
References: <Pine.LNX.4.53.0401161150390.28039@chaos> <20040116153122.2c4adffe.akpm@osdl.org> <Pine.LNX.4.53.0401190849230.6524@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401190849230.6524@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > > Some drivers are being re-written for 2.6++. The following
> > > construct seems to work for "waiting for an event" in
> > > the kernel modules.
> > >
> > >         // No locks are being held
> > >         tim = jiffies + EVENT_TIMEOUT;
> > >         while(!event() && time_before(jiffies, tim))
> > >             schedule_timeout(0);
> > >
> > > Is there anything wrong?

Yes.

  1. The call to schedule_timeout(0) returns immediately, so you
     might as well have an empty loop body.

     See this from schedule_timeout's documentation:

       The routine will return immediately unless
       the current task state has been set (see set_current_state()).

     You need to call set_current_state(TASK_INTERRUPTIBLE) or
     set_current_state(TASK_UNINTERRUPTIBLE) inside the loop prior to
     calling schedule_timeout.

  2. With some experimental timer patches, schedule_timeout(0) could
     return immediately.  You should call schedule_timeout(1) instead to
     ensure at least some kind of yielding the CPU, assuming that's what
     you intended.

     It would be much better to work out how often you have to poll
     the event() function, and use that time interval as the argument
     to schedule_timeout().

     For example if you know you need to poll approximately every
     20ms, write schedule_timeout(HZ/50).

Some additional advice:

You are polling for an event.  If the event test is not complex, the
highest performance way to do it is to create a periodic timer and
have that check for the event, and use a waitqueue to wake the
sleeping task.  What you are doing is much simpler to write, though.

> Huh? The code that causes "event()" needs to get the CPU occasionally
> to check for the event. The hardware doesn't produce an interrupt
> upon that event.
> 
> The hardware designer has designed the hardware according to
> the requirements dictated by a government agency (the FDA).
> There was no requirement to make interface code simple. The
> interface code must check for multiple failure modes during
> every specific operation. Both the hardware and software
> check for these modes so that no single failure can cause
> injury to a patient. This is SOP for medical equipment.

When you call schedule_timeout(0), the scheduler _could_ delay your
process for an arbitrarily long time, unless you have set an
appropriate SCHED_FIFO or SCHED_RR policy.

For medical equipment which affects patient safety, usually _maximum_
polling intervals are required so that a dangerous operation is
aborted within a fixed time limit.

schedule_timeout(0) only guarantees a _minimum_ polling interval.
Please ensure you are doing this right.

> In the specific case, we operate a patient table. The operator
> presses an UP and DOWN button. These will produce interrupts.
> When an UP button is hit, thousands of interrupts are generated.

The hardware generates interrupts for button events but doesn't
produce interrupts for the periodic sampling that is monitoring the
table movement, is that right?

> This is because it is a mechanical operation. The same is true
> for the DOWN button. These events are filtered to determine
> the true intervals for "UP", "NOTHING", and "DOWN". When the
> "UP" button is pressed, the CPU servos position information
> from another driver and motor speed to to move the table to
> the commanded position. If the button is pressed for a short
> period of time, the table moves slowly. If it is pressed for
> a longer period, it moves quickly. It must accellerate according
> to a schedule and decellerate according to a schedule so that
> patients that weigh 350 lbs and patients that weigh 45 lbs are
> accellerated and decellerated at the same rate.
> 
> When the table is being moved, 12 different parameters are
> monitored. At least two parameters are actually calculated
> and filtered to predict where the patient will be if the
> button is released.

If you are periodically monitoring and filtering parameters, it seems
very likely that you need accurate and consistent time intervals
between each measurement, to ensure patient safety.

-- Jamie
