Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132925AbRASUjK>; Fri, 19 Jan 2001 15:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRASUjB>; Fri, 19 Jan 2001 15:39:01 -0500
Received: from front1m.grolier.fr ([195.36.216.51]:45757 "EHLO
	front1m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132587AbRASUiv> convert rfc822-to-8bit; Fri, 19 Jan 2001 15:38:51 -0500
Date: Fri, 19 Jan 2001 20:37:57 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Bob Frey <bfrey@turbolinux.com.cn>
cc: Stephen Kitchener <stephen@g6dzj.demon.co.uk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Scanning problems - machine lockups
In-Reply-To: <20010119094130.A7816@bfrey.dev.cn.tlan>
Message-ID: <Pine.LNX.4.10.10101192006260.1579-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Bob Frey wrote:

> On Thu, Jan 18, 2001 at 11:24:54PM +0000, Stephen Kitchener wrote:
> > The only thing that might be odd is that the scanner's scsi card and the 
> > display card are using the same IRQ, but I thought that IRQ sharing was ok in 
> > the new kernels. The display card is an AGP type and the scsi card is pci.
> >
> > As you might have guessed, I am at a loss as to what to do next. Any help 
> > appriciated, even suggestions as to how I can track down what I haven't done 
> > (yet!)
> Sharing interrupts could be the problem. Interrupt sharing is supported
> in the kernel as far as two different drivers being able to register a
> handler for the same interrupt, but not much beyond that. From studying
> the code I don't find any handling of unclaimed or spurious interrupts.
> 
> Some drivers (like video cards) do not register a handler for their card's
> interrupt. So when another driver (like the advansys driver) shares an
> interrupt with this card's "unregistered" interrupt there is no one left
> to handle the interrupt. The system will loop taking an interrupt from
> the card. I've observed this using the frame buffer driver. Note: this
> problem is unnoticed if the (video) card does not share an interrupt with
> another driver, because (at least on x86) Linux does not enable the
> PIC IRQ bit for IRQs that do not have registered interrupted handlers.
> 
> For Linux I think the right way to handle this is to have each (SA_SHIRQ)
> sharing capable interrupt handler return a TRUE or FALSE value indicating
> whether the interrupt belongs to the driver. In kernel/irq.c:handle_IRQ_event()
> check the return value. If after one pass through all of the interrupt
> (action) handlers no one has claimed the inerrupt then log a warning message
> (spurious interrupt) and clear the interrupt. The difficult/painstaking
> problem is that all SA_SHIRQ drivers need to be changed to return a return
> value to make this work.

There is no ordering of interrupts with respect to transactions in PCI.
As a result, getting interrupts that does not match a pending interrupt
condition as seen by driver can happen, without the interrupt being
spurious.

As a result, the 2 following assertions:
- All interrupts in PCI are spurious
- No interrupt is PCI is spurious
Are less wrong than asserting that some interrupts in PCI are relevant and
some are spurious. :-)

And btw, some hardwares, notably Intel ones, seems to ensure coherency
prior to deliver interrupts. This is a useless work when the IRQ is
actually shared and does only make sense for ISA or ISA-like PCI devices
and in situations where the IRQ is not actually shared.

> Anyway the simplest solution for you is probably if you can is to put
> assign the video card its own interrupt. Putting the two advansys cards
> on the same interrupt is fine. I have used interrupt sharing between
> multiple advansys cards and and ethernet cards without a problem.

In theory, the O/S should warn _loudly_ if any PCI device hasn't a
software driver attached, for the reason there is no generic way to
actually quiesce completely a PCI device. As a result, loading drivers
after boot or just loading drivers with interrupt enabled at boot is
unsafe with PCI devices. This shall be considered, even if the risk of a
breakage is generally very low.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
