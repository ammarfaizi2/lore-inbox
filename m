Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135912AbRAMAgj>; Fri, 12 Jan 2001 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbRAMAg3>; Fri, 12 Jan 2001 19:36:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6928 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135912AbRAMAgO>; Fri, 12 Jan 2001 19:36:14 -0500
Date: Fri, 12 Jan 2001 16:35:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <E14HDbX-0005E0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101121631250.8097-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Alan Cox wrote:

> > interrupt controllers (io-apic definitely included).  Drivers would
> > generally be better off if they disabled their own chip from sending
> > interrupts, rather than disabling the interrupt line the chip is on. 
> 
> That doesn't work very well because the device irq can arrive a measurable
> number of clocks after you disable it on the source and there is no way to
> say 'and be sure the stupid thing has propogated the apic bus'

I agree. Asynchronous buses are nasty that way. However, if your "locking"
is based on device state, you can still do it: you just have to have an
internal device protocol. The simplest example of this is:

	interrupt_handler()
	{
		status = readl(dev->status);
		if (status & MY_IRQ_DISABLE)
			return;

	}


	{
		status = readl(dev->status);
		writel(dev->status, status | MY_IRQ_DISABLE);
		spin_lock();
		.. critical region ..
		spin_unlock();
		writel(dev->status, status);
	}


Notice how the above does NOT guarantee that the physical interrupt might
not be "in flight". It does, however, synchronize other ways, simply by
virtue of using the _synchronous_ bus (PCI, in this case) to figure out
when the asynchronous bus (interrupts) has a bogus event.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
