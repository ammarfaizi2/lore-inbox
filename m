Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBCMPJ>; Sat, 3 Feb 2001 07:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129073AbRBCMO6>; Sat, 3 Feb 2001 07:14:58 -0500
Received: from colorfullife.com ([216.156.138.34]:44305 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129031AbRBCMOh>;
	Sat, 3 Feb 2001 07:14:37 -0500
Message-ID: <3A7BF62D.74B81526@colorfullife.com>
Date: Sat, 03 Feb 2001 13:14:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Gérard Roudier <groudier@club-internet.fr>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <Pine.LNX.4.10.10102021848290.785-100000@linux.local> <3A7B3204.6A433394@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> But I think we can change the bug description:
> 
> If an io apic io redirection entry is unmasked while the irq pin is
> active, then the io apic sends out the interrupt as edge triggered, but
> nevertheless sets the IRR bit.
>

I found another workaround:
8390.c currently calls

	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
	enable_irq(dev->irq);

and locks up after ~ 100 packets flood ping.

If I reorder these calls to

	enable_irq(dev->irq);
	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
	(and the correct spin_lock()'s)

the lockup disappears.

But I have no idea how io_apic.c could prevent lockups.

Playing with the trigger mode is not 100% reliable - I assume it kicks
the io apic only after several changes of the trigger mode bit. Maciej's
patch switches that bit twice during every start_tx operation and thus
doesn't lock up, my patch touches the redirection entry exactly once and
reliably locks up - even if I change trigger mode, polarity, delivery
mode and vector during enable_level_irq().

Any ideas?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
