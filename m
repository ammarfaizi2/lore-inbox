Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBBTPI>; Fri, 2 Feb 2001 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129131AbRBBTO7>; Fri, 2 Feb 2001 14:14:59 -0500
Received: from front5m.grolier.fr ([195.36.216.55]:3276 "EHLO
	front5m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129129AbRBBTOu> convert rfc822-to-8bit; Fri, 2 Feb 2001 14:14:50 -0500
Date: Fri, 2 Feb 2001 19:12:52 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <Pine.GSO.3.96.1010202125033.28509C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.10.10102021848290.785-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Feb 2001, Maciej W. Rozycki wrote:

> On Thu, 1 Feb 2001, Andrew Morton wrote:

> +/*
> + * It appears there is an erratum which affects at least the 82093AA
> + * I/O APIC.  If a level-triggered interrupt input is being masked in
> + * the redirection entry while the interrupt is send pending (its
> + * delivery status bit is set), the interrupt is erroneously
> + * delivered as edge-triggered but the IRR bit gets set nevertheless.
> + * As a result the I/O unit expects an EOI message but it will never
> + * arrive and further interrupts are blocked for the source.
> + *
> + * A workaround is to set the trigger mode to edge when masking
> + * a level-triggered interrupt and to revert the mode when unmasking.
> + * The idea is from Manfred Spraul.  --macro
> + */

Is the below idea feasible or just stupid:

Once a level-sensitive interrupt has been accepted by a local APIC, the IO
APIC will wait for the EIO message prior to delivering again this
interrupt. Therefore masking a level-sensitive interrupt once it has been
delivered and prior to EIOing it should not race with the APIC hardware.

So, why not using a pure software flag in memory and only tampering the
things if the offending interrupt is actually delivered ? If the given
interrupt is delivered and the software mask is set we could simply do:

- MASK the given interrupt
- EOI it.
- return

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
