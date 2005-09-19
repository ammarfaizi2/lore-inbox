Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVISQsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVISQsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVISQsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 12:48:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:28626
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932478AbVISQsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 12:48:41 -0400
Message-ID: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: [ANNOUNCE] ktimers subsystem
Date: Mon, 19 Sep 2005 18:48:41 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ktimers seperate the "timer API" from the "timeout API". ktimers are 
used for:
- nanosleep
- posixtimers
- itimers

The following text explains the rationale behind ktimers. It contains

- a general analysis of the current Linux time(r) core system and
patches / projects related to it.  

- a detailed description of necessary changes to the Linux time(r)
core system

- detailed explanation of the ktimer subsystem

- a short explanation of possible follow up patches to demonstrate the
  further possibilities of the ktimers subsystem implementation


Why do we need ktimers ?
========================

Authors: Thomas Gleixner, Ingo Molnar

A lot of discussion took place about Linux timekeeping and timers 
recently. The efforts to integrate the High Resolution Timer patches 
into the -rt tree gave a deep insight into the big picture and initiated 
the ktimers implementation. This document is an analysis of all related 
issues, with the goal of inclusion of ktimers into mainline.


Linux time(rs) status, very short summary
-----------------------------------------

The current upstream timer implementation of Linux is based on a 
periodic system tick (jiffy). This periodic tick initially had a period 
of 10ms. During the 2.5 development series this was changed for some 
architectures to 1ms and recently corrected to 4ms.

The upstream "time of day" (tod) timekeeping code builds on top of the 
periodic ticks and takes architecture dependent sub-tick resolution 
mechanisms into account to provide finer resolution. It also implements 
synchronization with external time sources such as NTP.


Patches and projects related to timers and timekeeping, in history order
------------------------------------------------------------------------

- UTIME   Usec Resolution Timers
- HRT     High Resolution Timers
- VST     Variable Scheduling Timeouts
- DTCK    Dynamic Ticks
- NEWTOD  New timeofday core including reworked NTP

- some related architecture specific code already integrated into the
  kernel (mostly s390 related time interpolator code)
- a couple of others - rather odd attempts to change timer
  resolution. Mostly single purpose patches.

All of those patches have one thing in common. They are restricted to a 
few architectures and address only single problems of timers and 
timekeeping.


UTIME: Microsecond resolution timers 
-------------------------------------

The patch history goes back to Linux 2.0 and is maintained by Dr.  
Douglas Niehaus at Kansas University as part of the KURT (Kansas 
University Realtime) project.

Supported platforms: x86, (PPC, ARM partial)

Implementation:

Originally the usec resolution support was available for all users of 
the timer core system, but during the course of development it turned 
out to be a waste of resources and was restricted to realtime processes.  
The implementation is restricted to nanosleep and itimers. Posix timer 
support is planned. Initially it was implemented on top of the timer 
wheel, but recently converted to a seperate list for high resolution 
timers.

A related and quite interesting point of activity in this project is the 
research on fine granular synchronization of machines in a network.


HRT: High Resolution Timers
---------------------------

George Anzinger forked the UTIME parts of KURT some years ago and 
started the High Resolution Timer project. The usage is restricted to 
posix timers with clock = CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR.

Supported platforms: x86, PPC, PPC, PPC64, SH, ARM partial

Implementation:

High resolution timers are kept in the timer wheel until they reach the 
jiffy where they expire. On expiry they are moved to a seperate list and 
arm the high resolution timer source. The timer function is handled in a 
seperate softirq. The high resolution portion of the timers is managed 
as a seperate field in the timer structure which holds the fractional 
part. Initially implemented as subjiffies with a given resolution it 
changed to a variable holding the time source cycles to reduce 
conversion overhead. This has impact on the accuracy of cyclic 
schedules and also has some limitations for high resolution time sources
with variable frequencies, e.g. TSC on x86.
Possible changes are work in progress.


VST: Variable Scheduling Timeouts
---------------------------------

A patch closely related to and depending on HRT, also maintained by 
George Anzinger. It provides the suppression of timer ticks during idle 
periods.

Supported platforms: x86, (One ARM platform supported, a related patch 
snippet recently sneaked into the ARM core interrupt handling code)

Implementation:

Whenever the system goes into idle state the timer list(s) are scanned 
to find the next timer and, if it is reasonably far away, VST turns off 
the periodic 1/HZ timer interrupts and sets up a timer interrupt at the 
expiry time of said timer. VST also provides a callback list which is 
used to notify about idle enter / leave events. On the next interrupt, 
be it the VST timer or some other interrupt, the periodic 1/HZ timer is 
restarted and the elapsed time (ticks) is properly accounted for.


DTCK: Dynamic Ticks
-------------------

An implementation similar to VST, but not depending on other patches.  
Maintained by Con Kolivas. It also provides the suppression of timer 
ticks during idle periods.

Supported platforms: x86

Implementation:

Similar to VST, but completely jiffy bound. Very actively maintained in 
recent months, with good progress. The core implementation is leaner 
than VST. It contains some x86 specific bits which have to be seperated 
out. It uses the already existing NO_IDLE_HZ code (s390) instead of 
introducing new duplicated functionality. The configuration interface is 
integrated into sysfs. A generic notification interface is not available 
(yet?).


NEWTOD: New timeofday core including reworked NTP
-------------------------------------------------

John Stultz maintains a set of patches which are related, but have been 
split for easier review and discussion.

- Reworked implementation of NTP synchronization
- Seperation of time of day timekeeping from the timer core

Supported platforms: x86

Implementation:

The time of day code is completely seperated from the periodic tick. The 
code provides a runtime configurable time source selection, which is 
intended to be of generic (architecture spanning) use. One of the 
possible time sources is the periodic tick of course.

The code gets rid of one of the fundamental flaws of Linux time keeping: 
the wrong order of deduction. The current upstream code derives almost 
everything except jiffies from the wall clock time (xtime). This is 
controversial to almost every time reference in the world. Usually time 
references are built on a raw hardware clock which provides a more or 
less accurate monotonic time source. This time source is corrected vs.  
frequency skew. On top of resulting "constant frequency" monotonic time 
source the human time conversions are implemented, e.g. timezones.  
John's patch addresses this nicely and builds the correct order of clock 
source -> frequency correction -> wall clock adjustment. This is one of 
the essential preliminaries to implement nonintrusive, simple and 
effective high resolution time support.

The lively discussion of the patch is not questioning the general idea.  
The main point of criticizm is related to the enforced usage of 64-bit 
variables and 64-bit arithmetic in hot execution paths. This is seen as 
a penalty for 32-bit architectures and for low computing power CPUs 
which are often used in embedded devices, but architectural simplicity 
is a strong argument in favor of 64-bit arithmetics and we have not seen 
a substantial proof of the overhead. (See also the detailed comparison 
of timespec versus 64-bit nsec_t further below.)


Timer related observations
--------------------------

Ticks are a convenient mechanism for a lot of time triggered functions 
like scheduler-ticks, timeouts etc. which require limited resolution and 
precision.

For time of day timekeeping, which requires sub tick resolution 
preferrable in human time units, ticks introduce a bunch of ugliness 
especially when it comes to time synchronizing with high resolution time 
sources. Another astonishing implementation detail of the current time 
keeping is the fact that we get the monotonic clock (defined by POSIX as 
a continous clock source which can not be set) by subtracting a variable 
offset from the real time clock, which can be set by the user and 
corrected by NTP or other mechanisms.

Another well-known drawback of the current tick based implementation is 
the fact that ticks happen even on a completely idle system. This is an 
undesired behaviour for battery powered devices. Resolving this 
currently needs a lot of quirks to the upstream time(rs) system.

The current POSIX timer implementation is also quite complex due to its 
implementation on top of the tick timers. We are forced to e.g. keep 
track of armed CLOCK_REALTIME timers to readjust them when the clock has 
been set. The POSIX timer API, as defined by Posix Specification 1003.1, 
is inconsistent in the treatment of relative and absolute CLOCK_REALTIME 
timers. Absolute timers are influenced by clock_set, relative timers are 
not. This also applies to nanosleep. The specification of nanosleep 
states on the other hand that the sleeping time must not be less than 
the given timeout measured by CLOCK_REALTIME. Setting the clock while a 
nanosleep is scheduled leads to an interesting situation:

 Process 1           Process2
 t1=get_timeofday()
 nanosleep(20s)
                     set_timeofday(relative -20s)
 t2=get_timeofday()
 t2 - t1 =~ 0s

Implementing high resolution timers on top of a the current system also 
requires a lot of quirks to keep the timer API usable for both high 
resolution and tick based timers.

Such kinds of 'interaction artifacts' between the tick based data 
structures and algorithms and the high-resolution data structures, even 
if looked at without knowing anything about the time(r) subsystem, 
already point in the direction of separating 'high resolution time(r)' 
and 'low resolution timeout' APIs and subsystems.

As mentioned earlier, the switch to 1ms ticks during 2.5 development 
series turned out to cause certain regressions and was recently 
corrected to 4ms. One common type of regression was 'timer 
soft-interrupt overrun', i.e. when processing related to a timer tick 
did not finish within one jiffy, causing a domino effect on the timing 
quality of the system.

What are the reasons? During the work on integrating high resolution 
timers into the -rt tree we observed a lot of details related to this 
problem. When changing the period of the timer tick (changing HZ) the 
size of the primary timer wheel in the core code remains unchanged. This 
results in the fact that the primary timer wheel [into which wheel the 
secondary wheels are 'cascaded' periodically] becomes capable of 
handling a smaller time span than before. The CONFIG_BASE_SMALL option 
makes it even worse. Here is a table of the capacity limits of the 
primary wheel:

 HZ     CONFIG_BASE_SMALL=n     CONFIG_BASE_SMALL=y

 100    2560 ms                 640 ms
 250    1024 ms                 256 ms
 1000    256 ms                  64 ms

So one source of regression is the increased necessity to move 
non-expired timers from the outer wheels to the primary wheel.

This alone does not explain all the regressions yet though. We did some 
instrumentation and statistics on the timer code related to common use 
cases, where the regressions showed up - machines with high networking 
and/or disk I/O load.

This revealed a reasonable explanation for this behaviour. Both 
networking and disk I/O arm a lot of timeout timers (the maximum number 
of armed timers during the tests observed was ~400000). The majority of 
those timeouts are in the range of 0.5 seconds. As frequently seen with 
timeout timers, most of those timers never expire, but under high load 
they get easily into a time line where they have to be moved from the 
outer wheel to the primary timer wheel, when HZ=1000. Have a look at the 
timer cascading code [cascade() in kernel/timer.c] to see the penalty...

Another source of regression is the fact that quite a lot of timer 
functions execute long lasting codepaths. E.g. in the networking code 
rt_secret_rebuild() does a loop over rt_hash_mask (1024 in my case), 
over entries and over some subsequent variable sized loops inside each 
step. On a 300MHZ PPC system this accumulated to a worst case total of
>5ms (!). The networking code contains more of those loops in timer
functions and the worst case szenario is when all of those loops happen 
in the same jiffy and block the timely delivery of other timers. There 
are other culprits, but those in the networking code are the most 
obvious ones. This went almost unnoticed on HZ=100 systems, but on 
HZ=1000 based machines those effects surfaced. The change to HZ=250 is 
just hiding the problem rather than solving it.

Another weird effect of the changes to the time tick period is the fact 
that a lot of places in the code are using HZ incorrectly. Even today, 
more than a year after the switchover. Many of those usages still assume 
HZ=100 or even have a completely wrong understanding of the mechanism 
provided by the Linux kernel timer API (which is unrelated to the HZ 
changes of course).

These observations together finally led to the complete seperation of 
the high resolution timer data structures from the jiffy wheel, in the 
HRT-RT integration work. (to further reduce latencies we also separated 
softirq threads, but that is another topic.)


What is solved by the available patches ?
-----------------------------------------

As said before each of the patches addresses a particular part of the 
time(r) related problems. Some of them are competing implementations.

We don't want to put down the efforts of the particular projects, but one 
outstanding patch is John Stultz's work on the new time of day 
subsystem. It really addresses one of the substantial linux time(r) 
problems in a very generic and architecture-independent way, upon which 
the other efforts can build cleanly.

The other patches mostly relate to tickless systems and high resolution 
timers, and are providing great proof of concept implementations but 
suffer from the bindings to particular architectures and the 
restrictions that the current upstream Linux timer core code imposes 
upon them.


What changes are required?
--------------------------

The conclusions of my recent work on Linux time(rs) related problems and 
the analysis of related patches are:

1. The HZ/jiffy based usage of time in the kernel code has to be
   converted to human time units.

2. A clean seperation of all related APIs and subsystems is necessary 
   even if they have interdependencies and shared functionality


| HZ/jiffy conversion

The conversion of users of HZ/jiffy based timing to human time units is 
necessary to allow changes to the core timer subsystem without breaking 
the users all over the kernel. Looking at the code most HZ/jiffie timers 
are using more or less correct conversions from human time units anyway.  
A positive side effect of such a cleanup is the necessary auditing for 
correctness.


| API seperation

- time sources
- time synchronization
- time of day API
- timers API
- timeout API

- time sources:

The number and the resolution of available time sources varies a lot 
over architectures and particular architecture specific platform 
implementations. Some of them are only run time detectable. NEWTOD 
provides a excellent code base for time source abstraction, but a couple 
of details have to be discussed:

  - resolution selection
  - resolution and architecture dependend interface
  - support for tick bound and tick less systems including a clean
    integration into the interrupt handling code.
  - usability of timesources for differrent purposes (timekeeping,
    high/low res event scheduling)
  - 32- vs. 64-bit arithmetic
  
- time synchronisation:

Time syncronization corrects the frequency skew of the time source. It 
must provide a plugable interface for time synchronisation mechanisms to 
allow the flexible implementation of time synchronization sources:

  - None
  - NTP
  - GPS
  - RTC
  - ...

- time of day API:

The time of day API makes use of the eventually frequency corrected time 
sources to implement the "human readable" interface. It is also 
responsible for the translation of the monotonic time source - time 
since system (re)booted - to the wall clock - real time - time. (Real 
time in this context must not be confused with "real time" in the sense 
of determinism.)


- timer API:

The timer API provides finegrained precision timers with relation to the 
time of day subsystem. It provides the functionality of:

- precise interval scheduling
- precise timeouts

with or without high resolution timing support depending on system 
configuration and system capabilities.


- timeout API:

The timeout API provides a coarse resolution interface for timeout 
purposes. As pointed out before the majority of timers are related to 
timeouts. What's the nature of timeouts ?

  - Timeout timers are usually armed to cover an error condition

  - Most of those timers never expire (the non timer related good
    condition arrives before expiry)

  - The demands on resolution are usually quite low. It does not make
    any difference if an error condition is detected a few or even a
    few hundred milliseconds earlier or later. The relevant point is
    that the error is detected at all.

On a heavy loaded web server ~95%+ of all timers (almost all of them 
armed by network or I/O kernel code) are removed before expiry. The 
remaining timers which really expire are mostly timers requested from 
application code. The major usage there is some periodic supervisor 
code, which checks program status or other application relevant
information, and delays.


Conclusion
----------

Before inclusion of extensions to the current timer implementation e.g. 
dynamic ticks, a API seperation and cleanup has to be done. Integrating 
new functionality on top of the current code will just introduce a lot 
of quirks and oddities which make the necessary cleanup and rework 
harder.

John Stultz timeofday patches provide an excellent and solid base to 
solve the first 3 of 5 points of the API seperation changes.

Ktimers add the timer API seperation with a clean way to integrate high 
resolution time keeping.

The combination of both patches provides the grounds and leads the way 
to the cleanup of the timeout API and the implementation of 
dyntick/tickless support without introducing additional ugliness.


What is solved by ktimers ?
===========================

ktimers seperate the "timer API" from the "timeout API". ktimers are 
used for:

- nanosleep
- posixtimers
- itimers

The implementation was done with following constraints in mind:

- Not bound to jiffies
- Multiple time sources
- Per CPU timer queues
- Simplification of absolute CLOCK_REALTIME posix timers
- High resolution timer aware
- Allows the timeout API to reschedule the next event 
  (for tickless systems)

Ktimers enqueue the timers into a time sorted list, which is implemented 
with a rbtree, which is effiecient and already used in other performance 
critical parts of the kernel. This is a bit slower than the timer wheel, 
but due to the fact that the vast majority of timers is actually 
expiring it has to be waged versus the cascading penalty.

The code supports multiple time sources. Currently implemented are 
CLOCK_REALTIME and CLOCK_MONOTONIC. They provide seperate timer queues 
and support functions.

The time ordered implementation and storage of the expiry time as the
time of the selected time source removes the hard work of
reprogramming all armed absolute CLOCK_REALTIME posix timers when the
clock was set

During the initial implementation phase the choice of a time storage 
format had to be done. Dispite the previous discussion about 64-bit time 
storage vs. timespec structures, the decision was made to use plain 
64-bit variables. The rationale behind this is:

1. Simple calculations (add, sub, compare), which are the ones used in
   the fastpaths are simpler and better to handle than struct
   timespec.  

2. The storage size is the same for 32-bit systems, but half the size
   on 64-bit machines

3. The resulting binary code size is smaller due to the simpler fast
   path operations. The comparison of the resulting binary code size
   of a function which resembles parts of the hotpaths in the
   enqueue and expiry code make this very clear. All compiled with
   gcc-3.4 -O2.

	        AMD64	 I386	     ARM	  PPC32	      M68K
   nsec_t_ops	 e2	 11c	      fc	  1ac	       ce
   timespec_ops	19c	 144	     1c0	  280	      156

   Smaller binary code usually executes faster.

4. The kludge introduced by timespec arithmetics is horrible to
   maintain. The simple and straight forward 64-bit calculation have
   much less of surprises and potential error sources hidden.

5. The areas where the 64-bit nsec_t value has to be converted to
   timespec / timeval are very restricted and can be optimized
   further. Except for one odd POSIX timer related case (cyclic timer
   with no signal delivery) the calculation is simple and straight
   forward. The most discussed code in John Stultz timeofday patch is
   the conversion in gettimeofday(). This can be easily solved by a
   low overhead storage in both formats. The POSIX timespec / timeval
   interface to userspace for the apparently often used gettimeofday
   syscall must not be used as an red herring to clutter the complete
   kernel timer and time keeping subsystems with this uneffective
   representation of time.

ktimers are available in a patch series for easier review:

- ktimer_base.patch 

  The basic implementation of ktimers. The timer queues are called
  inside the existing timer softirq. The time ordered queue
  implementation allows to remove all the abs_list functionality from
  posix-timers.c. Converted interfaces: itimers, nanosleep, posix
  timers. There is no change to the current kernel time keeping system
  required. The base patch utilizes existing interfaces. 

The following add on patches are not provided for ad hoc inclusion as
they contain third party patches. The reason for providing this series
is to demonstrate the future use of ktimers and the simple
extensibility for the impelemtation of high resolution timers.
Especially John Stultz timeofday patch is a complete seperate issue
and just used due to the ability to provide high resolution timers in
a simple and non intrusive way.

The full patch series is available from 
http://www.tglx.de/private/tglx/ktimers/patches-ktimer-tod-hrt.tar.bz2

- ktimer_hres.patch

  Generic extension to the base patch to support high resolution
  timers. The high resolution changes are the seperation of the
  softirq, the high resolution interrupt function and the timer
  reprogramming management.
  
- timeofday_b5 patch
  
  Integration of John Stultz timeofday patches to have a clean
  abstraction of time sources for a non intrusive implementation of
  high resolution timers. This patch will be replaced by the reworked
  version which is currently developed by John Stultz.

- timeofday_fixup patch

  Fixup clashing inlines 

- ktimer_tod.patch

  extend the timeofday API and switch ktimers to use the timeofday API

- hres_i386_support.patch

  Patch to support high resolution timers on i386 with local APIC
  timer used for high resolution events. Proof of concept with the
  restriction to local APIC as high resolution event source at the
  moment. The main point is to prove that high resolution timers do
  not require large and intrusive patches anymore due to the cleanup
  of the time system.

Test coverage: 

  The complete patch is tested with the posix timer tests, which all
  pass. It survives a couple of stress tests and shows no flaws when
  integrated into the -rt tree. Of course this is brand new code, but
  it is designed simple and robust from ground and got a thorough
  review by a couple of people.

Some notes to the patch size(s):

  - ktimer_base.patch:
    17 files changed, 1328 insertions(+), 859 deletions(-)
    code     (-)  642 (+) 1058
    comments (-)  217 (+)  270
    The added code is mostly the base functionality of the ktimers
    itself.  The most cleanups happen in posix-timers.c, where all the
    code related to the clock_was_set adjustment of absolute
    CLOCK_REALTIME timers is removed.  Converts itimers, nanosleep and
    posixtimers to ktimer users

  - ktimer_hres_patch  
    3 files changed, 330 insertions(+), 7 deletions(-)
    code     (-)    6 (+)  232
    comments (-)    1 (+)   98
    Add the generic infrastructure for high resolution timers. No non
    POSIX clocks introduced, all ktimer users are automatically converted

  - timeofday_b5.patch
    73 files changed, 2926 insertions(+), 2675 deletions(-)
    code     (-) 2100 (+) 2146
    comments (-)  575 (+)  780
    A balanced patch providing a great improvement of functionality and 
    abstraction.

  - hres_i386_support.patch
    13 files changed, 635 insertions(+), 10 deletions(-)
    code     (-)    9 (+)  386
    comments (-)    1 (+)  249
    The largest addon is a header file containing scaled math operations, which
    needs to be cleaned up.

  - Total patch size  
    97 files changed, 5238 insertions(+), 3544 deletions(-)
    code     (-) 2751 (+) 3829
    comments (-)  793 (+) 1409

  Comparision numbers:
  - hrt-common.patch
    13 files changed, 1464 insertions(+), 108 deletions(-)
    code     (-)   91 (+)  879
    comments (-)   17 (+)  585
    Most code is added to the 
    Only posixtimers are supported. Add seperate non POSIX clocks 
    (CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR)
    
  - i386-hrt.patch (reduced to apic code)
    13 files changed, 1371 insertions(+), 63 deletions(-)
    code     (-)   51 (+)  910
    comments (-)   12 (+)  461
    
  - combined   
    26 files changed, 2835 insertions(+), 171 deletions(-)
    code     (-)  142 (+) 1789
    comments (-)   29 (+) 1046

  Summary: 

  The ktimer/timeofday/hrt combination adds ~1050 lines of source and
  provides a clean API seperation and a lot of code/functionality
  cleanup.

  The high resolution timer patches add ~1750 lines of code for high
  resolution time keeping without further functional improvements or
  API cleanups.


