Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282990AbRK0XmD>; Tue, 27 Nov 2001 18:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282994AbRK0Xlu>; Tue, 27 Nov 2001 18:41:50 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32249 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S282984AbRK0XkZ>; Tue, 27 Nov 2001 18:40:25 -0500
Message-ID: <3C04244A.512E196B@mvista.com>
Date: Tue, 27 Nov 2001 15:39:54 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: softirq and high-res-timers  Oh what to do?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Ingo says your the man :)

First, a bit of back ground.  I am working on high resolution POSIX
timers.  The basic idea is to schedule Programmable Interrupt Timer
(PIT) interrupts as needed to pick off timers that are due between 1/HZ
ticks.  (A preliminary patch is available on sourceforge (see my
signature for the URL)).  

The problem I have encountered is that if the interrupt is "close in" it
could well happen while the previous run timer list code is still
running (or, since this code is called from do_softirq(), while some
other tasklet is being run by do_softirq()).  The result is that the
"pending" bit will be reset while in do_softirq.  With the current
version of
do_softirq (2.4.13/15) if this is the only new bit, it will not be
serviced, but will be handed off to ksoftirqd, which introduces three
problems:

1.) It delays what is supposed to be a high resolution timer and,
2.) If it occurs prior to ksoftirqd being started at boot up, the hand
off fails.
3.) If a real time program is running the hold off time could be VERY
high.

Problem 2.) stops the boot, because the PIT is reprogrammed at the
end of the "run_timer_list" code and with out this reprogramming, will
not interrupt again (guess how I found this).

Case 3.) implies timer interrupts will stop for an indefinite amount of
time!!!!!  They will restart only when either ksoftirqd gets cpu cycles
or another interrupt happens (which will trigger a new call to
do_softirq()).

Note, that we are not handling high resolution timers at boot up, but
just trying to catch up after an interrupt off state.  Each PIT program
attempts to put the next interrupt at the correct jiffies boundary and
if we are late but under 1/HZ sec late, the next interrupt will be
programmed to happen early to make up for it.

I have though about various solutions:

A) Except the timer tasklet/bh from the "don't repeat" test.  One way of
doing this is to define a new softirq handler for the timer only and
then modify do_softirq() to honor repeats on this handler.

B) And/or don't shift to the one shot PIT program until later in the
boot (after ksoftirqd is started).  (Currently the boot fails in
calibrate delay, long before we even have a scheduler...) While this
would allow the system to boot, there is still the problem of how to get
low latency on a high resolution timer interrupt.

The problem with both these solutions is that it is not clear that there
are not other bits of code run from do_softirq() that have the same
problem(s).

C) Go back to looping until all softirq work is done.  After all,
interrupts are on so it is not an interrupt latency problem.  There is a
potential preemption latency issue here but this, IMHO, will take a
great deal more work to fix (see side note below).

Do you have any thoughts on how I might proceed?

As a side note, I in general favor moving driver completion/ bottom
half/ tasklet sorts of things into kernel threads, however, IMHO this
needs to be done on a driver by driver case and the user needs to have
much better control over the priority of the kernel thread.  There are
cases where, for example, a user might want lan completion code to run
at a given real time priority so that he can put more important tasks in
front of it and less important tasks behind it.  There are other cases
where the priority of the thread needs to track the priority of the
caller (this is the case with timer interrupts, for example) in order to
prevent priority inversion.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
