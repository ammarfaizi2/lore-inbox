Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRDPTV5>; Mon, 16 Apr 2001 15:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131983AbRDPTVr>; Mon, 16 Apr 2001 15:21:47 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:43674 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131979AbRDPTVi>; Mon, 16 Apr 2001 15:21:38 -0400
Message-ID: <3ADB45C0.E3F32257@mvista.com>
Date: Mon, 16 Apr 2001 12:19:28 -0700
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
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3ADA60C6.1593A2BF@candelatech.com> <20010416044630.A18776@pcep-jamie.cern.ch> <0104160841431V.01893@pc-eng24.mc.com>
Content-Type: multipart/mixed;
 boundary="------------23B87CF0E772A96C4C51064B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------23B87CF0E772A96C4C51064B
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Mark Salisbury wrote:
> 
> all this talk about which data structure to use and how to allocate memory is
> waaaay premature.
> 
> there needs to be a clear definition of the requirements that we wish to meet,
> including whether we are going to do ticked, tickless, or both
> 
> a func spec, for lack of a better term needs to be developed
> 
> then, when we go to design the thing, THEN is when we decide on the particular
> flavor of list/tree/heap/array/dbase that we use.
> 
> let's engineer this thing instead of hacking it.

Absolutely, find first draft attached.

Comments please.

George


~snip~
--------------23B87CF0E772A96C4C51064B
Content-Type: text/plain; charset=iso-8859-15;
 name="high-res-timers-fun-spec.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="high-res-timers-fun-spec.txt"

Functional Specification for the high-res-timers project.

http://sourceforge.net/projects/high-res-timers

We are developing code to implement the POSIX clocks & timers as defined
by IEEE Std 1003.1b-1993 Section 14.  (For an on line reference see our
home page: http://high-res-timers.sourceforge.net/ )
  
The API specifies the following functions (for details please see the spec):

int clock_settime(clockid_t clock_id, const struct timespec *tp);
int clock_gettime(clockid_t clock_id, struct timespec *tp);
int clock_getres(clockid_t clock_id, struct timespec *res);

int timer_creat(clockid_t clock_id, struct sigevent *evp,
                timer_t *timerid);
int timer_delete(timer_t *timerid);

int timer_settime(timer_t *timerid, int flags, 
                  const struct itimerspec *value,
                  struct itimerspec *ovalue);
int timer_gettime(timer_t *timerid, struct itimerspec *value);
int timer_getoverrun(timer_t *timerid);

int nanosleep( const struct timesped *rqtp, struct timespec *rmtp);

In addition we expect that we will provide a high resolution timer for
kernel use (heck, we may provide several).

In all this code we will code to allow resolutions to 1 nanosecond second (the
max provided by the timespec structure).  The actual resolution of
any given clock will be fixed at compile time and the code will do its
work at a higher resolution to avoid round off errors as much as
possible.

We will provide several "clocks" as defined by the standard.  In
particular, the following capabilities will be attached to some clock,
regardless of the actual clock "name" we end up using:

CLOCK_10MS a wall clock supporting timers with 10 ms resolution (same as
linux today). 

CLOCK_HIGH_RES a wall clock supporting timers with the highest
resolution the hardware supports.

CLOCK_1US a wall clock supporting timers with 1 micro second resolution
(if the hardware allows it).

CLOCK_UPTIME a clock that give the system up time.  (Does this clock
need to support timers?)

CLOCK_REALTIME a wall clock supporting timers with 1/HZ resolution.

At the same time we will NOT support the following clocks:

CLOCK_VIRTUAL a clock measuring the elapsed execution time (real or
wall) of a given task.  

CLOCK_PROFILE a clock used to generate profiling events. 

CLOCK_???  any clock keyed to a task.

(Note that this does not mean that the clock system will not support the
virtual and profile clocks, but that they will not be accessible thru
the POSIX timer interface.)

It would be NICE if we could provide a way to hook other time support
into the system.  In particular a

CLOCK_WWV or CLOCK_GPS

might be nice.  The problem with these sorts of clocks is that they
imply an array of function pointers for each clock and function pointers
slow the code down because of their non predictability.  Never the less,
we will attempt to allow easy expansion in this direction.

Implications on the current kernel:

The high resolution timers will require a fast clock access with the
maximum supported resolution in order to convert relative times to
absolute times.  This same fast clock will be used to support the
various user and system time requests.

There are two ways to provide timers to the kernel.  For lack of a
better term we will refer to them as "ticked" and "tick less".  Until we
have performance information that implies that one or the other of these
methods is better in all cases we will provide both ticked and tick less
systems.  The variety to be used will be selected at configure time.

For tick less systems we will need to provide code to collect execution
times.  For the ticked system the current method of collection these
times will be used.  This project will NOT attempt to improve the
resolution of these timers, however, the high speed, high resolution
access to the current time will allow others to augment the system in
this area.

For the tick less system the project will also provide a time slice
expiration interrupt.

The timer list(s) (all pending timers) need to be organized so that the
following operations are fast:

a.) list insertion of an arbitrary timer,
b.) removal of canceled and expired timers, and
c.) finding the timer for "NOW" and its immediate followers.

Times in the timer list will be absolute and related to system up time.
These times will be converted to wall time as needed.

The POSIX interface provides for "absolute" timers relative to a given
clock.  When these timers are related to a "wall" clock they will need
adjusting when the wall clock time is adjusted.  These adjustments are
done for "leap seconds" and the date command.  (Note, we are keeping
timers relative to "uptime" which can not be adjusted.  This means that
relative timers and absolute timers related to CLOCK_UPTIME are not
affected by the above wall time adjustments.)

In either a ticked or tick less system, it is expected that resolutions
higher than 1/HZ will come with some additional overhead.  For this
reason, the CLOCK resolution will be used to round up times for each
timer.  When the CLOCK provides 1/HZ (or coarser) resolution, the
project will attempt to meet or exceed the current systems timer
performance.

Safe guards:

Given a system speed, there is a repeating timer rate which will consume
100% of the system in handling the timer interrupts.  An attempt will
be made to detect this rate and adjust the timer to prevent system
lockup.  This adjustment will look like timer overruns to the user
(i.e. we will take a percent of the interrupts and record the untaken
interrupts as overruns).

What the project will NOT do:

This project will NOT provide higher resolution accounting (i.e. user
and system execution times).

The project will NOT provide higher resolution VIRTUAL or PROFILE timers.




--------------23B87CF0E772A96C4C51064B--

