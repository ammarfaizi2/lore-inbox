Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132817AbRDQTEh>; Tue, 17 Apr 2001 15:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132819AbRDQTE3>; Tue, 17 Apr 2001 15:04:29 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:35211 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132817AbRDQTEW>; Tue, 17 Apr 2001 15:04:22 -0400
Message-ID: <3ADC912A.B497B724@mvista.com>
Date: Tue, 17 Apr 2001 11:53:30 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Salisbury <mbs@mc.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <0104160841431V.01893@pc-eng24.mc.com> <3ADB45C0.E3F32257@mvista.com> <01041710225227.01893@pc-eng24.mc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Salisbury wrote:
> 
> > Functional Specification for the high-res-timers project.
> >
> > In addition we expect that we will provide a high resolution timer for
> > kernel use (heck, we may provide several).
> 
> what we do here determines what we can do for the user..

I was thinking that it might be good to remove the POSIX API for the
kernel and allow a somewhat simplified interface.  For example, the user
gets to resolution by specifying a CLOCK, where we MAY want to allow the
kernel call to directly specify the resolution.  This has already been
suggested.  I suppose you could say the functional spec should define
the kernel PI (KPI?) as well as the user API, but that is a bit fuzzy at
this time as I think it will depend on how we actually code the user
functionality.  Another example: I am leaning toward using a two word
uptime composed of jiffies (i.e. 1/HZ since boot) and a machine
dependent sub jiffie unit.  Each ARCH would then define this unit as
well as the conversion routines to move it back and forth to
nanoseconds, microseconds, and 1/HZ.  I think this format would play
well in task time accounting, as well as in the timer management.  

For calls to something like delay(), however, it sucks.  I think these
calls want a single word, possibly microsecond, time specification. 
This gives a 16 or 17 minutes max and 1 microsecond min. which probably
covers 99.99% of all kernel delay needs.  

Another kernel internal interface should allow the user specified
structures (timespec and timeval).  The notion is to put all the
conversion routines in the timer code to maintain the specified
resolution, and (more importantly), to avoid conversion to a format that
just needs an additional conversion.

To summarize,

I think there is a need for two classes of timer interfaces in the
kernel:

a.) For drivers and others that need "delay()" sorts of things, and
b.) For system calls that handle user specified times.
> 
> > We will provide several "clocks" as defined by the standard.  In
> > particular, the following capabilities will be attached to some clock,
> > regardless of the actual clock "name" we end up using:
> >
> > CLOCK_10MS a wall clock supporting timers with 10 ms resolution (same as
> > linux today).
> >
> > CLOCK_HIGH_RES a wall clock supporting timers with the highest
> > resolution the hardware supports.
> >
> > CLOCK_1US a wall clock supporting timers with 1 micro second resolution
> > (if the hardware allows it).
> >
> > CLOCK_UPTIME a clock that give the system up time.  (Does this clock
> > need to support timers?)
> >
> > CLOCK_REALTIME a wall clock supporting timers with 1/HZ resolution.
> >
> 
> Too many clocks.  we should have CLOCK_REALTIME and CLOCK_UPTIME for sure, but
> the others are just fluff.  we should have 1 single clock mechanism for the
> whole system with it's resolution and tick/tickless characteristics determined
> at compile time.

I think you already have let the nose of the camel into the tent :) 
Here is what I am thinking:

Suppose an array of structures of type clock.  Clock_id is an index into
this array.  Here is what is in the structure:

struct clock{
	int resolution;
	int *gettime();
	int *settime();
	int *convert_to_uptime();
	int *convert_from_uptime();
	<room for more bright ideas>;
};

Now the difference between CLOCK_UPTIME and CLOCK_REALTIME is surly in
the gettime/settime and possibly in the resolution.  But the difference
between CLOCK_REALTIME and CLOCK_1US, CLOCK_HIGH_RES, CLOCK_10MS is JUST
the resolution!  In other words, all they cost is the table entry.  Note
that CLOCK_GMT, CLOCK_UST, and CLOCK_GPS, etc. all fit nicely into this
same structure.

We should also provide a way to "register" a new clock so the user can
easily configure in additional clocks.  There are ways of doing this
that are really easy to use, e.g. the module_init() macro.
> 
> also CLOCK_UPTIME should be the "true" clock, with CLOCK_REALTIME just a
> convenience/compliance offset.

If you mean by "true" that this clock can not be set, starts at 0 at
boot time and can only be affected by rate adjustments to get it to pass
a real second every second, I agree.
> 
> > At the same time we will NOT support the following clocks:
> >
> > CLOCK_VIRTUAL a clock measuring the elapsed execution time (real or
> > wall) of a given task.
> >
> > CLOCK_PROFILE a clock used to generate profiling events.
> >
> > CLOCK_???  any clock keyed to a task.
> 
> we could do some KOOL things here but they are more related to process time
> accounting and should be dealt with in that context and as a separate project.
> 
> however our design should take these concepts into account and allow for easy
> integration of these types of functionality.

I agree.
> 
> >
> > (Note that this does not mean that the clock system will not support the
> > virtual and profile clocks, but that they will not be accessible thru
> > the POSIX timer interface.)
> 
> I think that should sombody choose to implement them, they should be available
> at least through the clock_xxx interfaces..

With care, this could be done.  We might need to add an item to the
structure saying if the clock supports timers.  If you want timers on
these clocks you would need a different way of clocking them (or so I
think, haven't thought about this in much detail).
> 
> >
> > It would be NICE if we could provide a way to hook other time support
> > into the system.  In particular a
> >
> > CLOCK_WWV or CLOCK_GPS
> >
> 
> CLOCK_NNTP
> 
> > might be nice.  The problem with these sorts of clocks is that they
> > imply an array of function pointers for each clock and function pointers
> > slow the code down because of their non predictability.  Never the less,
> > we will attempt to allow easy expansion in this direction.
> >
> > Implications on the current kernel:
> >
> > The high resolution timers will require a fast clock access with the
> > maximum supported resolution in order to convert relative times to
> > absolute times.  This same fast clock will be used to support the
> > various user and system time requests.
> >
> > There are two ways to provide timers to the kernel.  For lack of a
> > better term we will refer to them as "ticked" and "tick less".  Until we
> > have performance information that implies that one or the other of these
> > methods is better in all cases we will provide both ticked and tick less
> > systems.  The variety to be used will be selected at configure time.
> >
> > For tick less systems we will need to provide code to collect execution
> > times.  For the ticked system the current method of collection these
> > times will be used.  This project will NOT attempt to improve the
> > resolution of these timers, however, the high speed, high resolution
> > access to the current time will allow others to augment the system in
> > this area.
> 
> huh? why not?

Well, first accounting (as I call this usage) is not part of the POSIX
API the project is working on.  Second, it is in a real way
independent.  That is to say, it can be done today with the current
clock system as well as any new one.  And Third, more work is needed in 
areas of the system we would not otherwise touch to do them, (wait() 
for example).
> 
> >
> > For the tick less system the project will also provide a time slice
> > expiration interrupt.
> >
> > The timer list(s) (all pending timers) need to be organized so that the
> > following operations are fast:
> >
> > a.) list insertion of an arbitrary timer,
> should be O(log(n)) at worst
> 
> > b.) removal of canceled and expired timers, and
> easy to make O(1)

I thought this was true also, but the priority heap structure that has
been discussed here has a O(log(n)) removal time.
> 
> > c.) finding the timer for "NOW" and its immediate followers.
> head of list or top of tree or top of heap or whatever, O(1)
> 
> > Times in the timer list will be absolute and related to system up time.
> > These times will be converted to wall time as needed.
> 
> and ONLY when needed by users
> 
> >
> > The POSIX interface provides for "absolute" timers relative to a given
> 
> do you mean "relative" timers?
No, the user specifies a wall time for the event.
> 
> > clock.  When these timers are related to a "wall" clock they will need
> > adjusting when the wall clock time is adjusted.  These adjustments are
> > done for "leap seconds" and the date command.  (Note, we are keeping
> > timers relative to "uptime" which can not be adjusted.  This means that
> > relative timers and absolute timers related to CLOCK_UPTIME are not
> > affected by the above wall time adjustments.)
> 
> absolute timers will automatically fall out when you adjust CLOCK_UPTIME...
> i.e.  an absolute time is an absolute time and since CLOCK_UPTIME is the
> ultimate arbiter of what absolute time it is, adjusting CLOCK_UPTIME will cause
> the absolute times in the timer list to be handled properly without modifying
> them. (am I makeing myself clear?  I will try to come up with a better
> description of what I mean)

I don't read the spec this way.  In my reading, the user can specify
that a timer expire at some fixed wall time based on a given clock.  If
that clock moves past that time, we had better expire that timer.  It
doesn't matter if the clock moved because of STD to DST or a leap second
or the date command.  Likewise, if we have converted that CLOCK time to
CLOCK_UPTIME (as we will when we put the timer in the list) we will need
to redo the calculation when any of the above events occur.  Also, as
said earlier, CLOCK_UPTIME can only be set by booting the system.  (By
the way, somewhere in the high-res-timer mailing list archive is a note
requesting (as I read it) CLOCK_UPTIME, a clock that never gives the
same time twice (within resolution/ cpu speed limits), never moves
backward, etc.  See TIME_MONOTONIC at
http://www.cl.cam.ac.uk/~mgk25/c-time/ 
but the whole thing is a good read.)
> 
> > In either a ticked or tick less system, it is expected that resolutions
> > higher than 1/HZ will come with some additional overhead.  For this
> > reason, the CLOCK resolution will be used to round up times for each
> > timer.  When the CLOCK provides 1/HZ (or coarser) resolution, the
> > project will attempt to meet or exceed the current systems timer
> > performance.
> 
> ONLY in a ticked system.

I am not sure what you mean here.  The resolution round up will tend to
group timers and thus, given the same timer expiration rate, cause fewer
interrupts.  This is true in both systems, with the exception that in
ticked systems the improvement goes flat once the resolution becomes
less than or equal to the tick rate.
> 
> >
> > Safe guards:
> >
> > Given a system speed, there is a repeating timer rate which will consume
> > 100% of the system in handling the timer interrupts.  An attempt will
> > be made to detect this rate and adjust the timer to prevent system
> > lockup.  This adjustment will look like timer overruns to the user
> > (i.e. we will take a percent of the interrupts and record the untaken
> > interrupts as overruns).
> 
> see my earlier e-mail, although it is a simple matter to enforce a minimum
> allowable interval by parameter checking.
> 
> >
> > What the project will NOT do:
> >
> > This project will NOT provide higher resolution accounting (i.e. user
> > and system execution times).
> >
> > The project will NOT provide higher resolution VIRTUAL or PROFILE timers.
> 
> as I said, there are some kool things we could do here, and we should design in
> allowances for future upgrades which implement these things and let it get done
> as a followon.
> 
Right.  Remember Linus seems to like small patches.

George
