Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971249-26836>; Sat, 11 Jul 1998 05:50:23 -0400
Received: from noc.nyx.net ([206.124.29.3]:3249 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <971721-26836>; Sat, 11 Jul 1998 05:49:57 -0400
Date: Sat, 11 Jul 1998 04:57:52 -0600 (MDT)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199807111057.EAA14133@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sat Jul 11 04:57:52 1998, Sender=colin, Recipient=, Valsender=colin@localhost
To: root@chaos.analogic.com
Subject: Re: Future time
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Regarding improving the clock handling...

I'm working on it.  See http://phk.freebsd.dk/rover.html for what *can*
be done if you try, and have a few hundred dollars in timekeeping
hardware added to your PC (upshot: he currently can't distinguish the
performance of his PC from a Cesium atomic frequency standard, and is
looking to borrow one so he can measure more accurately), and I'm free
to steal his ideas.

I'm trying for good performance from existing PC hardware though.
Thanks for the heads-up on the even crappier main oscillators.
(If you can get an Allan variance curve out of the manufacturers,
it would be very nice.)

For folks who don't know, a typical current PC has two crystals.
a 14.318 MHz "colour burst*4" crystal at 315/22 MHz that drives the
programmable timer (IRQ 0) directly, and the processor's 60/66 MHz
clock and the serial port's 12 MHz clock through a PLL chip.

Secondly, a 32768 Hz crystal for the battery-backed clock.  This is
actually shaped like a miniature quartz tuning fork, and is a low 
frequency to reduce power consumption in the attached circuitry.
Every quartz wristwatch in the world runs off such a crystal.

Although theoretically the higher-frequency crystal has less loss
than the tuning fork (which has arms waving in the air), which results
in greater frequency precision, in practice the tuning forks are
optimized for timekeeping and tolerances are tighter, while the higher
frequency clocks are built to just (barely) make it within spec.

The link on the rover.html page to John R. Vig's paper will tell you
more than you probably ever wanted to know about Quartz oscillators.


Anyway, Alan Cox was nice enough to point out to me that there are some
embedded systems where the RTC interrupt is wired to RESET rather than
IRQ 8 so the system can use it as a watchdog timer.  This makes using
that source for interrupts somewhat impractical.  The code has to adapt
to a wide variety of brokenness.  (It's still doable, although precision 
suffers.)


The idea I'm working on is to use the cycle counter as much as possible,
but to calibrate it against the battery-backed RTC (which will also
detect all kinds of APM events), and calibrate that whole mess against
external sources with NTP.


I've been working on code to take RDTSC readings from successive interrupts
and strip out the noise.  Since the noise is one-sided (interrupts are
only ever late, not early), averaging doesn't get rid of it too well.
Since the noise depends on what you're doing (when the make -j finishes,
things change), using averages isn't even stable, let alone precise.


Right now I'm trying to deal with SMP issues.  If any SMP hackers would
like to guide me through SMP interrupt handling on *all* Linux platforms,
I'd like to ask a few questions.  Please email me.  (E.g. I don't understand
the APIC stuff at all.)
-- 
	-Colin

(P.S. This all started when David Miller complained to me about how
long secure TCP sequence number generation was taking.  I looked, and
gettimeofday() was taking half of the time.  So I set out to fix it.
Fixing it *right* is a lot harder than it seems.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
