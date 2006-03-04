Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWCDEn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWCDEn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWCDEn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:43:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:23267 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750905AbWCDEnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:43:25 -0500
Subject: [RFC][PATCHSET] Time: Generic Timeofday Subsystem (v B20)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, mingo@elte.hu,
       zippel@linux-m68k.org, rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       tony.luck@intel.com, davidm@hpl.hp.com, clameter@sgi.com,
       george@mvista.com, ak@suse.de, paulus@samba.org,
       benh@kernel.crashing.org, arnd@arndb.de
Content-Type: text/plain
Date: Fri, 03 Mar 2006 20:43:16 -0800
Message-Id: <1141447396.9727.139.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 13:15 -0800, Andrew Morton wrote:
> So we can do this, but the question is do we _want_ to do it?  If the arch
> maintainers can look at it from a high level and say "yup, I can use that
> and it'll improve/simplify/speedup/reduce my code" then yes, it's worth
> making the effort.
 
	So, with 2.6.16 closing out, its time to decide if the 
following generic timekeeping code is ready to go into 2.6.17.  I know 
this is pretty dull code, however if any of you arch maintainers could 
give it a quick once-over and let Andrew and me know if you have any 
positive or negative reaction to this code, I would really appreciate 
it.

(To avoid spamming important and busy arch maintainers, I've only CC'ed
them on this announcement. The full patchset can be found on lkml.)

Please note, that there are still improvements to be made. Roman, for
instance, has made some good suggestions that I'm working to implement.
However, I feel the code as it stands _is_ ready for inclusion, as it
resolves a number of issues that users are seeing, and has been in the
-rt and -mm trees for some time with few problem reports.


Summary:
	This patchset provides a generic timekeeping subsystem that is 
independent of the timer interrupt. This allows for robust and correct 
behavior in cases of late or lost ticks, avoids interpolation errors, 
reduces duplication in arch specific code, and allows or assists future 
changes such as high-res timers, dynamic ticks, or realtime preemption. 
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions.

Why do we need this?

Correctness: With the current tick-based interpolated timekeeping used 
in most architectures, there is the possibility for time inconsistencies
caused by NTP adjustment, less then perfect calibration of the highres 
time hardware, or late or missed ticks. Over time, a number of fixes 
have been added trying to minimize the effect of these errors, but as 
hardware gets faster, the observable window for time inconsistencies 
increases and the fixes are less effective. Further, correct 
timekeeping becomes even more difficult with future features like 
dynamic ticks or with realtime preemption when using the existing 
timekeeping code.

Consolidation: We have quite a bit of duplication between the arches in 
their timekeeping code. Many have chosen slightly different paths which 
can make it difficult to resolve bugs or enable new features that could 
be more generic. Additionally since the interaction between arch 
generic and arch specific code is not well specified, the code has 
become quite fragile as timekeeping fixes may or may not affect other 
arches and may not affect them in the same way.


Its a bit outdated, but my 2005 OLS presentation (basically more of the
same, but with a few pictures) on this code can be found here:
http://sr71.net/~jstultz/tod/ols-presentation-final.pdf


Overview of the code: 
This patchset that I'm submitting breaks up into a few basic chunks:

1) Minimal rework of the NTP code to isolate it so that it does not 
directly change the timekeeping variables as a side effect. Provides 
accessors to the NTP state machine that allows the timekeeping core to 
modify time accordingly.

2) Introduces the clocksource abstraction, which provides a generic 
method to register, select and use hardware specific clocksource 
drivers.

3) Introduces the generic timekeeping core that uses the clocksource 
infrastructure instead of the timer interrupt to maintain time and 
provides generic accessors to the system time and wall time. Also uses 
the NTP changes to scale time smoothly between ticks.

4) Patches to convert the i386 arch to use the timekeeping core

5) Finally a patch to provide clocksource drivers for i386 hardware

I also have patches that provide #4 and #5 for powerpc and x86-64, 
however they are not ready for submission, but you can find them at the 
link below.


Changes since the B19 release:
o Synced w/ changes from -mm
o jiffies/jiffies_64 and related locking fix (from Atsushi Nemoto)
o Dropped acpi_pm_buggy paranoia (Suggested by Adrian Bunk)
o Re-remove duplicate leapsecond code which accidentally got dropped.

Outstanding issues:
o No reported problem from testing in -mm

Still on my TODO list:
o Possible merge with Roman's NTP changes
o Continue working on improved ntp error accounting patch
o Squish any bugs that pop up from testing
o Clean and split up x86-64 and powerpc patches
o ppc, s390, arm, ia64, alpha, sparc, sparc64, etc work

The patchset applies against the current 2.6.16-rc5-git.

The complete patchset (including unsubmitted powerpc and x86-64 code)
can be found here:
	http://sr71.net/~jstultz/tod/

I'd like to thank the following people who have contributed ideas, 
criticism, testing and code that has helped shape this work: 
	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev, 
Dominik Brodowski, Adrian Bunk, Thomas Gleixner, Darren Hart, Christoph 
Lameter, Matt Mackal, Keith Mannthey, Ingo Molnar, Andrew Morton, Paul 
Munt, Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Jonathan 
Woithe, Darrick Wong, Roman Zippel and any others whom I've 
accidentally left off this list.

thanks 
-john


