Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284541AbRLIWLg>; Sun, 9 Dec 2001 17:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284542AbRLIWL1>; Sun, 9 Dec 2001 17:11:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60433 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284541AbRLIWLP>; Sun, 9 Dec 2001 17:11:15 -0500
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: _deepfire@mail.ru (Samium Gromoff)
Date: Sun, 9 Dec 2001 22:18:18 +0000 (GMT)
Cc: hahn@physics.mcmaster.ca (Mark Hahn), linux-kernel@vger.kernel.org
In-Reply-To: <200112092150.fB9Lot906422@vegae.deep.net> from "Samium Gromoff" at Dec 10, 2001 12:50:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DCH5-00080o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > right, so more fragmentation-assembly increases the CPU load,
> > no surprise there.
>     damn, i have a mtu of 1500 and i dont quite see abt what frag/reassembly
>    are you talking about while the problems start to pop out on _256_ bytes
>    large packets (yes 256+smth like 32 or more)

Its nothing to do with reassembly. My guess is that the irq handling or the
other driver locks on the ISA driver are holding off the sound.

>    look: we have 2.0 serving NIC interrupts more efficintly than 2.4, and you
>    say that we even dont need to know _why_ its so!?

Oh thats easy. 2.0 performs like crap on SMP boxes. 

The newer code is intended to do sensible things for NE2K drivers however so
I am curious what is fouling up. It even goes to the trouble to avoid
disabling all interrupts during a transmit event.

What might be interesting would be to edit 8390.c and change

        /* Mask interrupts from the ethercard.
           SMP: We have to grab the lock here otherwise the IRQ handler
           on another CPU can flip window and race the IRQ mask set. We end
           up trashing the mcast filter not disabling irqs if we dont lock
	*/

        spin_lock_irqsave(&ei_local->page_lock, flags);
        outb_p(0x00, e8390_base + EN0_IMR);
        spin_unlock_irqrestore(&ei_local->page_lock, flags);
 
to use 

	/* this is the missing spin_trylock_irqsave longhand.. */
	save_flags(flags);
	__cli();
	if(!spin_trylock(&ei_local->page_lock))
	{
		restore_flags(flags);
		return 1;
	}
        outb_p(0x00, e8390_base + EN0_IMR);
        spin_unlock_irqrestore(&ei_local->page_lock, flags);

