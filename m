Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRDPUsO>; Mon, 16 Apr 2001 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDPUrz>; Mon, 16 Apr 2001 16:47:55 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:57348 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132054AbRDPUrn>;
	Mon, 16 Apr 2001 16:47:43 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104162045.f3GKjd4522374@saturn.cs.uml.edu>
Subject: Re: No 100 HZ timer!
To: george@mvista.com (george anzinger)
Date: Mon, 16 Apr 2001 16:45:39 -0400 (EDT)
Cc: mbs@mc.com (Mark Salisbury), lk@tantalophile.demon.co.uk (Jamie Lokier),
        greearb@candelatech.com (Ben Greear),
        vonbrand@sleipnir.valparaiso.cl (Horst von Brand),
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
In-Reply-To: <3ADB45C0.E3F32257@mvista.com> from "george anzinger" at Apr 16, 2001 12:19:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CLOCK_10MS a wall clock supporting timers with 10 ms resolution (same as
> linux today). 

Except on the Alpha, and on some ARM systems, etc.
The HZ constant varies from 10 to 1200.

> At the same time we will NOT support the following clocks:
> 
> CLOCK_VIRTUAL a clock measuring the elapsed execution time (real or
> wall) of a given task.  
...
> For tick less systems we will need to provide code to collect execution
> times.  For the ticked system the current method of collection these
> times will be used.  This project will NOT attempt to improve the
> resolution of these timers, however, the high speed, high resolution
> access to the current time will allow others to augment the system in
> this area.
...
> This project will NOT provide higher resolution accounting (i.e. user
> and system execution times).

It is nice to have accurate per-process user/system accounting.
Since you'd be touching the code anyway...

> The POSIX interface provides for "absolute" timers relative to a given
> clock.  When these timers are related to a "wall" clock they will need
> adjusting when the wall clock time is adjusted.  These adjustments are
> done for "leap seconds" and the date command.

This is a BIG can of worms. You have UTC, TAI, GMT, and a loosely
defined POSIX time that is none of the above. This is a horrid mess,
even ignoring gravity and speed. :-)

Can a second be 2 billion nanoseconds?
Can a nanosecond be twice as long as normal?
Can a second appear twice, with the nanoseconds getting reset?
Can a second never appear at all?
Can you compute times more than 6 months into the future?
How far does time deviate from solar time? Is this constrained?

If you deal with leap seconds, you have to have a table of them.
This table grows with time, with adjustments being made with only
about 6 months notice. So the user upgrades after a year or two,
and the installer discovers that the user has been running a
system that is unaware of the most recent leap second. Arrrgh.

Sure you want to touch this? The Austin group argued over it for
a very long time and never did find a really good solution.
Maybe you should just keep the code simple and fast, without any
concern for clock adjustments.

> In either a ticked or tick less system, it is expected that resolutions
> higher than 1/HZ will come with some additional overhead.  For this
> reason, the CLOCK resolution will be used to round up times for each
> timer.  When the CLOCK provides 1/HZ (or coarser) resolution, the
> project will attempt to meet or exceed the current systems timer
> performance.

Within the kernel at least, it would be good to let drivers specify
desired resolution. Then a near-by value could be selected, perhaps
with some consideration for event type. (for cache reasons)

