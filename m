Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971941-26836>; Mon, 13 Jul 1998 08:03:12 -0400
Received: from miris.lcs.mit.edu ([18.111.0.89]:50304 "EHLO miris.lcs.mit.edu" ident: "cananian") by vger.rutgers.edu with ESMTP id <971968-26836>; Mon, 13 Jul 1998 08:01:54 -0400
Date: Mon, 13 Jul 1998 09:13:08 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: Andrew Derrick Balsa <andrebalsa@altern.org>
cc: linux-kernel@vger.rutgers.edu, Jamie Lokier <lkd@tantalophile.demon.co.uk>
Subject: Re: PATCH: time.c modifications for clock instability. 
In-Reply-To: <9807131210180A.00462@lw2l.bnc.interdrome.fr>
Message-ID: <Pine.GSO.3.96.980713090308.29036A-100000@miris.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 13 Jul 1998, Andrew Derrick Balsa wrote:

> Jamie Lokier wrote:

> > Does this mean the TSC is considered reliable after it is next read in a
> > timer interrupt? It seems to me, that the TSC can remain unreliable for
> > a while after the next timer interrupt, perhaps because the clock is
> > slowed, or maybe worse in the sleeping state between interrupt handlers.
[...]
> > I would guess that the TSC should be considered unreliable until the APM
> > code has done it's regular 1 second checking thing and ensured the
> > system is in a busy state. That's just a wild guess, mind.
> 
> Scott has included extra code that is supposed to tell the kernel when the TSC
> is considered reliable and when it is not. Remember this was experimental code
> that Scott hasn't had time to test.

The code referred to in my patch was designed to catch/fix cases where the
TSC was *reset* or *trashed*, not to fix TSCs whose *rate* varies.
Background info, for those who need it: Intel in their wisdom only
provided means to save/restore the low 32-bits of the 64-bit TSC.  So it
is impossible to restore it after a processor power-down -- for example,
an APM suspend event.  Intel clones often power-down the CPU as a
power-saving feature, as well.  This would wreak havoc on TSC-based
time-keeping; the patch addresses this potential and makes sure we don't
have any problems.  Jiffy interrupts are considered the canonical
timebase, and TSC time is measured from the TSC value at the last jiffy
(as was done in the old time.c code).  Thus, the next jiffy after a
TSC-trash event updates our state so that we can keep differential time
again.

You're right that the current code does not handle CPU clock speed
changes: it must have been one of the things I wanted to add before
releasing the patch some months ago.  It is trivial to add: simple add a
new call to tsc_calibrate after any event that might change the clock
speed (I'm thinking APM events here).  If the CPU is "smart" and changes
speed behind your back without telling anyone, then forget about using the
TSC for timekeeping.

This actually points out the need for a standard test suite for time
functions.  I've been running the above code for 1.5 months without any
noticible problems, and I really doubt that many people (without the use
of said test suite) would be able to tell that their sub-jiffy timings
were saturating early at the mark just before the next jiffy because the
CPU was slowing the clock.
  --Scott
                                                         @ @
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-oOO-(_)-OOo-=-=-=-=-=
 C. Scott Ananian: cananian@lcs.mit.edu  /  Declare the Truth boldly and
 Laboratory for Computer Science/Crypto /       without hindrance.
 Massachusetts Institute of Technology /META-PARRESIAS AKOLUTOS:Acts 28:31
 -.-. .-.. .. ..-. ..-. --- .-. -..  ... -.-. --- - -  .- -. .- -. .. .- -.
 PGP key available via finger and from http://www.pdos.lcs.mit.edu/~cananian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
