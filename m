Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbULHBzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbULHBzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULHBzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:55:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:19906 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261994AbULHBz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:55:26 -0500
Subject: [RFC] New timeofday proposal (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tim@physik3.uni-rostock.de, george@mvista.com,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, len.brown@intel.com, linux@dominikbrodowski.de,
       davidm@hpl.hp.com, ak@suse.de, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Content-Type: text/plain
Message-Id: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 07 Dec 2004 17:55:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 	
	Once again here is my time of day proposal and code. I've not been able
to work too much on it since my last release in September, and not much
has changed in the proposal. However, since I'm doing another code
release, I figured I'd re-send the design/justification summary for
context.

New in this code release:
o Initial x86-64 port
o Re-worked the timesource structure as suggested by Christoph Lameter.
		
Any feedback or comments on this or the following code would be greatly
appreciated.
	
thanks
-john

Proposal for an architecture independent time of day implementation.
-------------------------------------------------------------------
John Stultz (johnstul@us.ibm.com)
DRAFT
Tue Dec  7 15:38:58 PST 2004

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
to no longer care how often clock_interrupt() is called. Queued, delayed
or lost interrupts do not affect time keeping (within bounds - ie: the
time source cannot overflow). This isolates HZ and jiffies to the timer
subsystem (mostly), as they are frequently and incorrectly used to
calculate time.
	Additionally, it allows for dynamic tick interrupts / high-res ticks.
It avoids the need to interpolate between multiple shoddy time sources,
and lets us be agnostic to where the periodic interrupts come from
(cleans up i386 HPET interrupt code).

o Consolidates a large amount of code:
	Allows for shared times source implementations, such as: i386, x86-64
and ia64 all use HPET, i386 and x86-64 both have ACPI PM timers, and
i386 and ia64 both have cyclone counters. Time sources are just drivers!

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
in a single place. Saves brains, normal people shouldn't have to think
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
	now = timesource_read();		/* read the timesource */
	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
	system_time += ntp_ns;		/* add scaled value to system_time */
	ntp_advance(ns);		/* advance ntp state machine by ns */
	offset_base = now;		/* set new offset_base */

monotonic_clock()
	now = timesource_read();	/* read the timesource */
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
	- see ntp.c for details
	- costly, but correct.

o ntp_advance(ns): advances NTP state machine by ns
	- see ntp.c for details

o What is the cost of throwing around 64bit values for everything?
	- Do we need an arch specific time structure that varies size
accordingly?

o Some arches (arm, for example) do not have high res timing hardware
	- In this case we can have a "jiffies" timesource
		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
		- doesn't work for tickless systems

o vsyscalls/userspace gettimeofday()
	- Still done on a per-arch basis
		- My earlier arch independent plan won't work
	- Exporting the full NTP logic is going to be annoying

o suspend/resume
	- not yet implemented, but shouldn't be hard
o cpufreq effects
	- handled in the timesource driver
	
Anything else? What am I missing or just being ignorant of?

