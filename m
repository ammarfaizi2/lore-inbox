Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRDPW2T>; Mon, 16 Apr 2001 18:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131988AbRDPW2K>; Mon, 16 Apr 2001 18:28:10 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:51705 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131672AbRDPW1z>; Mon, 16 Apr 2001 18:27:55 -0400
Message-ID: <3ADB7159.63B7D2EC@mvista.com>
Date: Mon, 16 Apr 2001 15:25:29 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Mark Salisbury <mbs@mc.com>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <200104162045.f3GKjd4522374@saturn.cs.uml.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> > CLOCK_10MS a wall clock supporting timers with 10 ms resolution (same as
> > linux today).
> 
> Except on the Alpha, and on some ARM systems, etc.
> The HZ constant varies from 10 to 1200.

I suspect we will want to use 10 ms resolution for a clock named
CLOCK_10MS :)
On the other hand we could have a CLOCK_1_OVER_HZ...  Actually with
high-res-timers the actual HZ value becomes a bit less important.  It
would be "nice" to keep 1/HZ == jiffie, however.
> 
> > At the same time we will NOT support the following clocks:
> >
> > CLOCK_VIRTUAL a clock measuring the elapsed execution time (real or
> > wall) of a given task.
> ...
> > For tick less systems we will need to provide code to collect execution
> > times.  For the ticked system the current method of collection these
> > times will be used.  This project will NOT attempt to improve the
> > resolution of these timers, however, the high speed, high resolution
> > access to the current time will allow others to augment the system in
> > this area.
> ...
> > This project will NOT provide higher resolution accounting (i.e. user
> > and system execution times).
> 
> It is nice to have accurate per-process user/system accounting.
> Since you'd be touching the code anyway...

Yeah sure... and will you pick up the ball on all the platform dependent
code to get high-res-timers on all the other platforms?  On second
thought I am reminded of the corollary to the old saw:  "The squeaking
wheel get the grease."  Which is: "He who complains most about the
squeaking gets to do the greasing."  Hint  hint.
> 
> > The POSIX interface provides for "absolute" timers relative to a given
> > clock.  When these timers are related to a "wall" clock they will need
> > adjusting when the wall clock time is adjusted.  These adjustments are
> > done for "leap seconds" and the date command.
> 
> This is a BIG can of worms. You have UTC, TAI, GMT, and a loosely
> defined POSIX time that is none of the above. This is a horrid mess,
> even ignoring gravity and speed. :-)
> 
> Can a second be 2 billion nanoseconds?
> Can a nanosecond be twice as long as normal?
> Can a second appear twice, with the nanoseconds getting reset?
> Can a second never appear at all?
> Can you compute times more than 6 months into the future?
> How far does time deviate from solar time? Is this constrained?
> 
> If you deal with leap seconds, you have to have a table of them.
> This table grows with time, with adjustments being made with only
> about 6 months notice. So the user upgrades after a year or two,
> and the installer discovers that the user has been running a
> system that is unaware of the most recent leap second. Arrrgh.
> 
> Sure you want to touch this? The Austin group argued over it for
> a very long time and never did find a really good solution.
> Maybe you should just keep the code simple and fast, without any
> concern for clock adjustments.

There is a relatively simple way to handle this, at least from the
high-res-timers point of view.  First we convert all timers to absolute
uptime.  This is a nice well behaved time.  At boot time we peg the wall
clock to the uptime.  Then at any given time, wall time is boot wall
time + uptime.  Then date, leap seconds, etc. affect the pegged value of
boot wall time.  Using the POSIX CLOCK id we allow the user to ask for
either version of time.  Now if we define an array of struc clock_id
which contains pointers to such things as functions to return time, any
algorithm you might want can be plugged in to bend time as needed.  The
only fly in this mess is the NTP rate adjustment stuff.  This code is
supposed to allow the system to adjust its ticker to produce accurate
seconds and so gets at the root of the uptime counter be it in hardware
or software or some combination of the two.  But then that's what makes
life interesting :)
> 
> > In either a ticked or tick less system, it is expected that resolutions
> > higher than 1/HZ will come with some additional overhead.  For this
> > reason, the CLOCK resolution will be used to round up times for each
> > timer.  When the CLOCK provides 1/HZ (or coarser) resolution, the
> > project will attempt to meet or exceed the current systems timer
> > performance.
> 
> Within the kernel at least, it would be good to let drivers specify
> desired resolution. Then a near-by value could be selected, perhaps
> with some consideration for event type. (for cache reasons)

This could be done, however, I would prefer to provide CLOCK_s to do
this as per the standard.  What does the community say?  In either case
you get different resolutions, but in the latter case the possible
values are fixed at least at configure time.

George
