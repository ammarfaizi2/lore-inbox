Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131282AbRBELvC>; Mon, 5 Feb 2001 06:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131394AbRBELuw>; Mon, 5 Feb 2001 06:50:52 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:49377 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131282AbRBELuf>; Mon, 5 Feb 2001 06:50:35 -0500
Date: Mon, 5 Feb 2001 12:38:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Gérard Roudier <groudier@club-internet.fr>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <3A7BF62D.74B81526@colorfullife.com>
Message-ID: <Pine.GSO.3.96.1010205121318.18067F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, Manfred Spraul wrote:

> I found another workaround:
> 8390.c currently calls
> 
> 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
> 	enable_irq(dev->irq);
> 
> and locks up after ~ 100 packets flood ping.
> 
> If I reorder these calls to
> 
> 	enable_irq(dev->irq);
> 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
> 	(and the correct spin_lock()'s)
> 
> the lockup disappears.

 Is it possible that asserting the IRQ when the mask is active makes it be
mishandled?

> Playing with the trigger mode is not 100% reliable - I assume it kicks
> the io apic only after several changes of the trigger mode bit. Maciej's
> patch switches that bit twice during every start_tx operation and thus
> doesn't lock up, my patch touches the redirection entry exactly once and
> reliably locks up - even if I change trigger mode, polarity, delivery
> mode and vector during enable_level_irq().

 I believe I recover from the lockup -- it's the mask function that
recovers.  But another one happens at the unmask time, I suppose.

> Any ideas?

 I'll implement the IRQ unlocker I was thinking first.  The idea is not to
try to prevent the lockup from happening as it might even be impossible
but to make the unlocker trigger after a lockup happens instead.  I should
have an implementation ready soon.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
