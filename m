Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTB0LBp>; Thu, 27 Feb 2003 06:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTB0LBp>; Thu, 27 Feb 2003 06:01:45 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:28300 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263366AbTB0LBn>; Thu, 27 Feb 2003 06:01:43 -0500
Date: Thu, 27 Feb 2003 12:11:54 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Mikael Pettersson <mikpe@csd.uu.se>,
       Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <Pine.LNX.4.44.0302260813510.1423-100000@home.transmeta.com>
Message-ID: <Pine.GSO.3.96.1030227112340.19733A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Linus Torvalds wrote:

> On Wed, 26 Feb 2003, Martin J. Bligh wrote:
> > 
> > Now in the case Rusty has, would be nice to find why it's changed, this was
> > just a workaround. On the NUMA-Qs, this always happened, so it's not so
> > interesting ;-)
> 
> Well, after having re-read the ESR description in the Intel manuals, and 
> looking at our code, I think the code has always been crap.
> 
> The manual clearly states that you clear the ESR by doing back-to-back
> writes, and that you read it by writing to it and then reading it. That's
> not at _all_ what we do at bootup. It's _also_ not what we do at 
> "clear_local_apic()".

 That is true for the P6+ APICs.  For the Pentium one, the semantics is a
bit different.  And there is an erratum causing the loss of the ESR
contents upon a write on early revisions.

> >From the description in the Intel docs, it really looks like the ESR works 
> as follows:
>  - reading ESR reads the "cached" register (which is nothing but a latch, 
>    and has no real "meaning" except as exactly that)
>  - writing to ESR moves the current real hardware register into the 
>    latched one and it resets the real hardware one.
> 
> In other words, you have three cases:
> 
>  - "read previous state" (which is only really useful for software that 
>    doesn't want to carry the state with it, ie things like status 
>    printing stuff in the error handler):
> 
> 	value = apic_read(APIC_ESR)
> 
>    This has _nothing_ to do with whatever the current ESR state is, and 
>    only reads the value as it was at the previous latch event.

 For Pentium it reads and clears the current value of the real ESR.

>  - latch current state and read it:
> 
> 	apic_write(0, APIC_ESR);	// I doubt the value matters
> 	value = apic_read(APIC_ESR);
> 
>    This reads the real "current state", leaving it in the latch.

 For Pentium a write is meant to be a noop (and mentioned in the manual to
be executed anyway for future compatibility), but due to the mentioned
erratum, it clears the ESR.  Thus the read always yields zero.  That's why
there is that "if (maxlvt > 3)" statement in the code -- which essentially
means "if (CPU > Pentium)".

>  - clear and read current state:
> 
> 	apic_write(0, APIC_ESR);
> 	value = apic_read(APIC_ESR);
> 	apic_write(0, APIC_ESR);
> 
>    (You probably might as well do this sequence to clear the thing even if
>    you don't actually care what the old value was, if only to make sure 
>    there are no write-buffer bugs).

 For Pentium you always read a zero as above.

 Of course all three sequences do clear ESR for Pentia properly.

> Also, I would _assume_ that the error interrupt is active based on the
> bit-wise "or" of both the latched and the real value, since the docs
> clearly say that it must be cleared by sw by back-to-back writes

 I believe only the real value matters.

> (rationale: if the error interrupt is only triggered by the latch it is
> obviously useless, since we wouldn't get an interrupt for new events. If
> the error interrupt is only triggered by the real value, we'd only need
> a single write to clear it).

 But it only refers to actions required upon a system initialization, when
the error interrupt is enabled in the LVT.

> Anyway, the above is clearly not what we're doing with the ESR right now.

 What we are doing is based on the Pentium specification.  Certainly
clear_local_APIC(), setup_local_APIC() and smp_error_interrupt() do their
things right for Pentia (the two latter read ESR twice merely for
debugging).  The code probably wasn't updated for P6 processors, because
the Pentium specification supposed to be upward compatible.  Basically
they stated to properly handle an error interrupt you need to execute:

1. Do a write to the ESR.  The value doesn't matter.  For Pentium it is a
noop, but future APICs will require it.

2. Read from the ESR.  This will provide the current state of error bits
and clear them at the same time.

Then the mentioned erratum (3AP in the Pentium spec update) is worked
around by skipping step #1 entirely for Pentium APICs as that's the
easiest way.  Why a second write would be needed after #2 for P6 isn't
clear to me and the doc part that you refer to, isn't written very well,
either.  I used to assume that another write to ESR would simply trigger a
next update of the software-visible latch and it would only be zero if no
other error happened meanwhile.

 I don't have the manual handy, but I can dig it from my archive if anyone
is interested.

 And finally, such docs need to be taken with a grain of salt and should
always be verified with real hardware if possible.  Unfortunately it's
hard to debug ESR problems without special equipment. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

