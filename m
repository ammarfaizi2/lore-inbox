Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUHQUPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUHQUPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUHQUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:15:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13304 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266250AbUHQUOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:14:40 -0400
Subject: [RFC] New timeofday implementation proposal
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <1092773244.2429.170.camel@cog.beaverton.ibm.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
	 <412151CA.4060902@mvista.com>
	 <Pine.LNX.4.53.0408170851020.15157@gockel.physik3.uni-rostock.de>
	 <1092773244.2429.170.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1092773633.2429.176.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 13:13:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, here is my proposal for overhauling the time of day
subsystem. This would likely be 2.7 material.

Any comments and suggestions would be appreciated.
thanks
-john


Proposal for an architecture independent time of day implementation.
-------------------------------------------------------------------
John Stultz (johnstul@us.ibm.com)
DRAFT
Tue Aug 17 12:50:34 PDT 2004

Credits:
	Keith Mannthey:	Aided initial design.
			Aided greatly to implementation details.
	George Anzinger: Initial review and corrections.
	Ulrich Windl: Review and suggestions for clarity.

	Many of the time of day related issues that cropped up in 2.5
development occurred where a fix or change was made to a number of
architectures, but missed a few others. Currently every architecture has
its own set of timekeeping functions that basically do the same thing,
only using different (or frequently, not so different) types of
hardware. As hardware has changed, many architectures have had to
re-engineer their time system to handle multiple time and interrupt
sources. With little common infrastructure, either each separate
implementation has its own quirks and bugs, or we end up with a
reasonable quantity of duplicated code. Additionally the lack of a clear
time of day interface has led developers to use jiffies, HZ, and the raw
xtime values to calculate the time of day themselves. This has lead to a
number of troublesome bugs.

	With the goal to simplify, streamline and consolidate the time-of-day
infrastructure, I propose the following common implementation across all
arches. This will allow generic bugs to be fixed once, reduce code
duplication, and with many architectures sharing the same time source,
this allows drivers to be written once for multiple architectures.
Additionally it will better delineate the lines between the timer
subsystem and the time-of-day subsystem, opening the door for more
flexible and better timekeeping.

Features of this design:
========================

o Splits time of day management from timer interrupts:
	This is necessary for virtualization & tickless systems. It allows us
to no longer care how often clock_interrupt() is called. Missing, early
or lost interrupts do not affect time keeping (within bounds - ie: the
time source cannot overflow). This isolates HZ and jiffies to the timer
subsystem (mostly), as they are frequently and incorrectly used to
calculate time.
	Additionally, it allows for dynamic tick interrupts / high-res ticks.
Avoid the need to interpolate between multiple shoddy time sources, and
lets us be agnostic to where the periodic interrupts come from (cleans
up i386 HPET interrupt code).

o Consolidates a large amount of code:
	Allows for shared times source implementations, such as: i386, x86-64
and ia64 all use HPET, i386 and x86-64 both have ACPI PM timers, and
i386 and ia64 both have cyclone counters. Time sources are just drivers!
Also work for user space gettimeofday implementations will be able to be
shared across all arches (assuming the hardware time source can be
safely accessed from user space).

o Generic algorithms which use time-source drivers chosen at runtime:
	Drivers are just simple hw accessors functions with no internal state
needed. They can be loaded and changed while the system is running, like
normal modules.

o More consistent and readable code:
	Drop wall_to_monotonic & xtime in favor of a more simple system_time
and wall_time_offset variables. Where system_time is the monotonically
increasing nanoseconds since boot time and wall_time_offset is the
offset added to system_time to calculate time of day.

o Uses nanoseconds as the kernel's base time unit.
	Rather then doing ugly manipulations to timevals or timespecs, this
simplifies math, and gives us plenty of room to grow (64bits of
nanoseconds ~= 584 years).

o Clearly separates the NTP code from the time code:
	Creates a clean and clear interface, keeping all the NTP related code
in a single place. Save brains, normal people shouldn't have to think
about the in kernel ntp machinery.


Brief Psudo-code to illustrate the design:
==========================================

Globals:
--------
offset_base: timesource cycle value at last call to timeofday_hook()
system_time: time in ns calculated at last call to timeofday_hook()
wall_offset: offset to monotonic_clock() to get current time of day

Functions:
----------
timeofday_hook()
	now = read();			/* read the timesource */
	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
	system_time += ntp_ns;		/* add scaled value to system_time */
	ntp_advance(ns);		/* advance ntp state machine by ns */
	offset_base = now;		/* set new offset_base */

monotonic_clock()
	now = read();			/* read the timesource */
	ns = cyc2ns(now - offset_base);	/* calculate nsecs since last hook */
	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
	return system_time + ntp_ns; 	/* return system_time and scaled value
					 */

settimeofday(desired)
	wall_offset = desired - monotonic_clock(); /* set wall offset */

gettimeofday()
	return wall_offset + monotonic_clock();	/* return current timeofday */


Points I'm glossing over for now:
====================================================

o Have to convert back to time_val for syscall interface

o ntp_scale(ns):  scales ns by NTP scaling factor
	- costly, but correct.

o ntp_advance(ns): advances NTP state machine by ns
	- we have to do the whole NTP state machine

o What is the cost of throwing around 64bit values for everything?
	- Do we need an arch specific time structure that varies size
accordingly?

o Some arches (arm, for example) do not have high res  timing hardware
	- In this case we can have a "jiffies" timesource
		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
		- doesn't work for tickless systems

o vsyscalls/userspace gettimeofday()
	- Mark functions and data w/  __vsyscall attribute
	- Use linker to put all __vsyscall data in the same set of pages
	- Mark those pages user-executable
	- Should work for all arches

o suspend/resume
	- need to pause and restart the timesource reads
	- we don't want a gigantic or negative offset!

Anything else? What am I missing or just being ignorant of?



