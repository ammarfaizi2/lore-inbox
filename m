Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135846AbRAMAa3>; Fri, 12 Jan 2001 19:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbRAMAaU>; Fri, 12 Jan 2001 19:30:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2054 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135846AbRAMAaE>; Fri, 12 Jan 2001 19:30:04 -0500
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
To: frank@unternet.org (Frank de Lange)
Date: Sat, 13 Jan 2001 00:29:18 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), mingo@elte.hu (Ingo Molnar),
        manfred@colorfullife.com (Manfred Spraul), dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010113011957.A29757@unternet.org> from "Frank de Lange" at Jan 13, 2001 01:19:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HEZN-0005Kh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The spin_lock_irqsave() is absolutely my preferred fix, and if I remember
> > correctly this is in fact how some early 2.1.x code fixed the ne2000
> > driver when the original irq scalability stuff happened (for some time
> > during development we did not have a working "disable_irq()" AT ALL
> > because the irq-disabling counters etc logic hadn't been done).
> 
> And that's the patch I meant... Manfred's
> spin_lock_irqsave/spin_unlock_irqrestore based one, not my
> (spin_lock_irq/spin_unlock_irq) based patch. That is also the one I'm running
> now.

The old code did it with #ifdef __SMP__ tests so it only screwed up SMP boxes,
which at the time was quite acceptable because real people didnt have them
and certainly at the price didnt put ne2000's in them 8)

The basic problem is that you cannot allow

	-	set multicast list
	-	open/close
	-	irq
	-	transmit

to occur except when serialized because of the indirection and register
gunge on the chip. The copies are slow and long enough that they prevent
28.8 modem sessions being usable.

I'd have to check the chip manual to be sure you even disable the irqs
without corrupting an in progress transfer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
