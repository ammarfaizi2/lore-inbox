Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283818AbRK3Vn1>; Fri, 30 Nov 2001 16:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283816AbRK3VnT>; Fri, 30 Nov 2001 16:43:19 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:10112 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283823AbRK3VnL>; Fri, 30 Nov 2001 16:43:11 -0500
Message-ID: <3C080BD3.62EA9CC7@t-online.de>
Date: Fri, 30 Nov 2001 23:44:35 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, nitrax@giron.wox.org
CC: root@chaos.analogic.com
Subject: Re: 'spurious 8259A interrupt: IRQ7' -> read the 8259 datasheet !
In-Reply-To: <Pine.LNX.3.95.1011130142654.2054A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 30 Nov 2001, Gunther Mayer wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > On Wed, 28 Nov 2001, Chris Meadors wrote:
> > >
> > > > On Wed, 28 Nov 2001, Martin Eriksson wrote:
> >
> > ...
> > ... rumours deleted (e.g. "printer status bits are all ORed into irq7")
> > ...
> >
> > >From "Harris Semiconductor 82C59A Interrupt Controller Datasheet":
> >   If no interrupt request is present at step 4 of either sequence
> >   (i.e., the request was too short in duration), the 82C59A will
> >   issue an interrupt level 7.
> >
> > 1. The irq controller sees an interrupt.
> > 2. The irq controller signals "there is _some_ interrupt" to the cpu.
> > 3. The CPU acks via INTA
> > 4. The irq controller looks if the irq is still there
> >    (and signals IRQ7 if the line is no longer active).
> >
> > You have some device which doesn't keep the IRQ raised long enough !
> > (or the CPU doesn't service the irq for a too long time and the
> >  edge triggered irq is de-asserted or even serviced by a polling routine)
> > -
> 
> In the first place I HAVE not only read the data-sheet, but probably
> was one of the first to report the affect when first observed in
> the days of XT machines, before there was a second cascaded controller.
> 
> If the effect was caused by the transient condition you describe, then
> the second controller would also suffer from the same problem, i.e.,
> its "IRQ7" is really IRQ15 when cascaded.

The slave could ignore T3-T7 when it detects a spurious irq and
signal IRQ7 to the CPU nevertheless !

> 
> The problems with "spurious IRQ7" reared its head when the new
> boards and cards became available with CMOS inputs with weak and/or
> no pull-ups. If you leave a connector off the printer port, the
> status bits will float and generate interrupts on IRQ7. You can
> stop this, as previously taught, by disabling the IRQ enable
> by writing bit 4 of the control-port (offset 1) to zero. You do
> this on all known printer ports and you no longer get the kernel
> messages.
> 
> So, before you issue another "rumors deleted" know-it-all retort,
> observe that you can "mysteriously" stop the problem by mucking
> with the printer control port. This certainly seems to disprove
> your INTA theory.

Get some data sheet about the parallel port to see:
"Bit 4: A 1 in this position allows an interrupt to occur when nACK changes from low to high."
So the status bits are _not_ ORed.

I agree, a floating nACK would provoke IRQ7 (or IRQ5 when configured for this).

On the parport list a user reports he gets some spurious irq7 on probing a PCI
card configured to IRQ12 ! So this card seems to trigger the 8259 generated IRQ7,
which proves the case described in the 8259 datasheet happens in reality.

In summary IRQ7 can be raised:
a) by parallel port due to floating nACK
b) by 8259 itself on some transient condition (this could be further be proved by
   suspending INTA and forcefully raising and releasing an irq, don't know if this is feasible)

Your proposition to set Bit4=0 would allow to rule out case b), of course.
It seems the inital reporter can reproduce the conditions ...
