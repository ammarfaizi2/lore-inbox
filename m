Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBCLaO>; Sat, 3 Feb 2001 06:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbRBCLaE>; Sat, 3 Feb 2001 06:30:04 -0500
Received: from front7.grolier.fr ([194.158.96.57]:59824 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S129224AbRBCL3x> convert rfc822-to-8bit; Sat, 3 Feb 2001 06:29:53 -0500
Date: Sat, 3 Feb 2001 11:28:02 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <3A7B3204.6A433394@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102031117430.893-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Feb 2001, Manfred Spraul wrote:

> Gérard Roudier wrote:
> > 
> > So, why not using a pure software flag in memory and only tampering the
> > things if the offending interrupt is actually delivered ? If the given
> > interrupt is delivered and the software mask is set we could simply do:
> > 
> > - MASK the given interrupt
> > - EOI it.
> > - return
> >
> Good idea.
> I implemented it, and it was a full success: not it always locks up :-(
> 
> If I apply the attached patch, then I get a lockup after ~ 100 packets
> flood ping.
> I've also attached the dmesg print.
> I know that startup is currently wrong (must set trigger to level), but
> that doesn't matter since I only ifup once.
> 
> But I think we can change the bug description:
> 
> If an io apic io redirection entry is unmasked while the irq pin is
> active, then the io apic sends out the interrupt as edge triggered, but
> nevertheless sets the IRR bit.

Interesting.

My little finger tells me that O/Ses that thread interrupts might well
want to rely on MASK + EOI in order to quiesce incoming level-sensitive
interrupts.

Note that tampering the IO/APIC after initializations looks extremally
ugly to me. In my opinion, only the local APIC was intended by Intel
designers to be accessed by CPU after initialization (I may be wrong
here).

> In a second test run I checked the TMR bit in the local apics: the bit
> on the cpu that received the last interrupt is really 0.
> 
> I'll not try a 2 step enable:
> * unmask.
> * io_apic_sync()
> * set trigger mode to level.

Thanks for having tried my suggestion.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
