Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbUCSNqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbUCSNqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:46:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62606 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262994AbUCSNqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:46:46 -0500
Date: Fri, 19 Mar 2004 08:48:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Robert_Hentosh@Dell.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious 8259A interrupt
In-Reply-To: <20040319130609.GE2650@mail.shareable.org>
Message-ID: <Pine.LNX.4.53.0403190825070.929@chaos>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
 <20040319130609.GE2650@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Jamie Lokier wrote:

> Robert_Hentosh@Dell.com wrote:
> > >  IRQ10 asserted
> > >  INTACK cycle lets PIC deliver vector to processor
> > >  processor masks IRQ10 in PIC
> > >  processor sends EOI command to PIC
> > >  processor reads a status register in the NIC, which causes IRQ10 to be
> > >  deasserted
> > >  processor unmasks IRQ10 in PIC
>
> > The PIC defaults to IRQ7 because of its design, when IRQ10 was already
> > cleared. Sticking delays in is not viable in a generic ISR routing.  A
> > possible fix to this issue would be to issue the EOI after the read to
> > the status register on the NIC, and I see some documentation on the PIC
> > that actually suggests that this is the way to service an interrupt.
> > This seemed like a risky change, since sending the EOI and using the
> > mask has been in use for some time and the change would effect all
> > devices using interrupts.
>
> That reminds me: why does Linux mask the IRQ anyway?
>
> Why doesn't it simply call the handler functions, and then send EOI to
> the PIC with no unmasking?
>
> For those rare occasions when an interrupt handler wants to re-enable
> interrupts (sti), _then_ it could mask the interrupt that called the handler.
>
> Why wouldn't that work?

It would work. However, the driver would then have to "know"
if the interrupt came from IO-APIC or from the 8259. It also
would have to "know" what IRQ it was actually using, etc.,
not just at configuration time, but forever. So, all the
dirty details were put in the kernel code so that the
ISR only needs to know it was called as a result of an
interrupt.

There is no problem with masking ON/OFF the interrupt
input to the 8259, In fact, this can be used to generate
another (unreliable) edge if the IRQ line is still asserted.

The IRQ7 spurious is usually an artifact of a crappy motherboard
design where the CPU "thinks" it was interrupted, but the
controller didn't wiggle the CPUs INT line. Once the INT
cycle starts, it must complete or the CPU would hang forever
waiting for the vector. Therefore, if the controller gets
the vector request from the CPU and it didn't actually interrupt,
the controller puts the IRQ7 vector on the bus, that ISR gets
called, and you get a "spurious interrupt". If you are
looking at the programming of the 8259, you are looking in
the wrong place. You need to look at the hardware timing on
the motherboard. That's where the problem originates. The
8259 is just doing its job, keeping the CPU running after
this spurious event.

FYI, the motherboards in the cheapie Dell machines we have
been getting (Optiplex GX260) are attrocious in this respect.
To prevent the error logs from getting filled up with
the "Spurious interrupt" messages, they need to be commented
out in kernels that run on these machines. Otherwise, we
get such messages about 50 or 60 times per hour. I note
that the original question came from somebody at Dell. They
really need to check their own back-yard before investigating
software.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


