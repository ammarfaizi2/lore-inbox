Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRDQOcq>; Tue, 17 Apr 2001 10:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbRDQOcj>; Tue, 17 Apr 2001 10:32:39 -0400
Received: from iris.mc.com ([192.233.16.119]:36498 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S132668AbRDQOc0>;
	Tue, 17 Apr 2001 10:32:26 -0400
From: Mark Salisbury <mbs@mc.com>
To: george anzinger <george@mvista.com>
Subject: Re: No 100 HZ timer!
Date: Tue, 17 Apr 2001 08:51:32 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <0104160841431V.01893@pc-eng24.mc.com> <3ADB45C0.E3F32257@mvista.com>
In-Reply-To: <3ADB45C0.E3F32257@mvista.com>
MIME-Version: 1.0
Message-Id: <01041710225227.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Functional Specification for the high-res-timers project.
> 
> In addition we expect that we will provide a high resolution timer for
> kernel use (heck, we may provide several).
 
what we do here determines what we can do for the user..

> We will provide several "clocks" as defined by the standard.  In
> particular, the following capabilities will be attached to some clock,
> regardless of the actual clock "name" we end up using:
> 
> CLOCK_10MS a wall clock supporting timers with 10 ms resolution (same as
> linux today). 
> 
> CLOCK_HIGH_RES a wall clock supporting timers with the highest
> resolution the hardware supports.
> 
> CLOCK_1US a wall clock supporting timers with 1 micro second resolution
> (if the hardware allows it).
> 
> CLOCK_UPTIME a clock that give the system up time.  (Does this clock
> need to support timers?)
> 
> CLOCK_REALTIME a wall clock supporting timers with 1/HZ resolution.
> 

Too many clocks.  we should have CLOCK_REALTIME and CLOCK_UPTIME for sure, but
the others are just fluff.  we should have 1 single clock mechanism for the
whole system with it's resolution and tick/tickless characteristics determined
at compile time.

also CLOCK_UPTIME should be the "true" clock, with CLOCK_REALTIME just a
convenience/compliance offset.



> At the same time we will NOT support the following clocks:
> 
> CLOCK_VIRTUAL a clock measuring the elapsed execution time (real or
> wall) of a given task.  
> 
> CLOCK_PROFILE a clock used to generate profiling events. 
> 
> CLOCK_???  any clock keyed to a task.

we could do some KOOL things here but they are more related to process time
accounting and should be dealt with in that context and as a separate project.

however our design should take these concepts into account and allow for easy
integration of these types of functionality.

> 
> (Note that this does not mean that the clock system will not support the
> virtual and profile clocks, but that they will not be accessible thru
> the POSIX timer interface.)

I think that should sombody choose to implement them, they should be available
at least through the clock_xxx interfaces..

> 
> It would be NICE if we could provide a way to hook other time support
> into the system.  In particular a
> 
> CLOCK_WWV or CLOCK_GPS
> 

CLOCK_NNTP

> might be nice.  The problem with these sorts of clocks is that they
> imply an array of function pointers for each clock and function pointers
> slow the code down because of their non predictability.  Never the less,
> we will attempt to allow easy expansion in this direction.
> 
> Implications on the current kernel:
> 
> The high resolution timers will require a fast clock access with the
> maximum supported resolution in order to convert relative times to
> absolute times.  This same fast clock will be used to support the
> various user and system time requests.
> 
> There are two ways to provide timers to the kernel.  For lack of a
> better term we will refer to them as "ticked" and "tick less".  Until we
> have performance information that implies that one or the other of these
> methods is better in all cases we will provide both ticked and tick less
> systems.  The variety to be used will be selected at configure time.
> 
> For tick less systems we will need to provide code to collect execution
> times.  For the ticked system the current method of collection these
> times will be used.  This project will NOT attempt to improve the
> resolution of these timers, however, the high speed, high resolution
> access to the current time will allow others to augment the system in
> this area.

huh? why not?

> 
> For the tick less system the project will also provide a time slice
> expiration interrupt.
> 
> The timer list(s) (all pending timers) need to be organized so that the
> following operations are fast:
> 
> a.) list insertion of an arbitrary timer,
should be O(log(n)) at worst

> b.) removal of canceled and expired timers, and
easy to make O(1)

> c.) finding the timer for "NOW" and its immediate followers.
head of list or top of tree or top of heap or whatever, O(1)

> Times in the timer list will be absolute and related to system up time.
> These times will be converted to wall time as needed.
 
and ONLY when needed by users


> 
> The POSIX interface provides for "absolute" timers relative to a given

do you mean "relative" timers?

> clock.  When these timers are related to a "wall" clock they will need
> adjusting when the wall clock time is adjusted.  These adjustments are
> done for "leap seconds" and the date command.  (Note, we are keeping
> timers relative to "uptime" which can not be adjusted.  This means that
> relative timers and absolute timers related to CLOCK_UPTIME are not
> affected by the above wall time adjustments.)

absolute timers will automatically fall out when you adjust CLOCK_UPTIME...
i.e.  an absolute time is an absolute time and since CLOCK_UPTIME is the
ultimate arbiter of what absolute time it is, adjusting CLOCK_UPTIME will cause
the absolute times in the timer list to be handled properly without modifying
them. (am I makeing myself clear?  I will try to come up with a better
description of what I mean)

> In either a ticked or tick less system, it is expected that resolutions 
> higher than 1/HZ will come with some additional overhead.  For this 
> reason, the CLOCK resolution will be used to round up times for each 
> timer.  When the CLOCK provides 1/HZ (or coarser) resolution, the 
> project will attempt to meet or exceed the current systems timer 
> performance. 

ONLY in a ticked system.

> 
> Safe guards:
> 
> Given a system speed, there is a repeating timer rate which will consume
> 100% of the system in handling the timer interrupts.  An attempt will
> be made to detect this rate and adjust the timer to prevent system
> lockup.  This adjustment will look like timer overruns to the user
> (i.e. we will take a percent of the interrupts and record the untaken
> interrupts as overruns).

see my earlier e-mail, although it is a simple matter to enforce a minimum
allowable interval by parameter checking.


> 
> What the project will NOT do:
> 
> This project will NOT provide higher resolution accounting (i.e. user
> and system execution times).
> 
> The project will NOT provide higher resolution VIRTUAL or PROFILE timers.

as I said, there are some kool things we could do here, and we should design in
allowances for future upgrades which implement these things and let it get done
as a followon.



-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

