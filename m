Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVCLRAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVCLRAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVCLRAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:00:41 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:32905 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261972AbVCLRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:00:08 -0500
Date: Sat, 12 Mar 2005 10:01:43 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: about interrupt latency
In-Reply-To: <875fe4a505030906438a76cb5@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503120952390.2166@montezuma.fsmlabs.com>
References: <875fe4a50503081039328ffede@mail.gmail.com> 
 <Pine.LNX.4.61.0503081156360.30824@montezuma.fsmlabs.com>
 <875fe4a505030906438a76cb5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Francesco Oppedisano wrote:

> On Tue, 8 Mar 2005 12:09:58 -0700 (MST), Zwane Mwaikambo
> <zwane@arm.linux.org.uk> wrote:
> 
> > At some cpu frequency point on i386 the main cause of your interrupt
> > service latency will be in the interrupt controller and how long from irq
> > assertion to the signal being recognised, resultant vector being
> > dispatched to the processor and the necessary interrupt controller
> > acknowledge steps required. This is also helped by the fact that the
> > Linux/i386 interrupt vector stubs are very small and fast, so there isn't
> > all that much code to execute to reach the ISR from the vector table. I'm
> > not sure if you've tested this, but you may notice that timer interrupt
> > via Local APIC will have lower dispatch latency than timer interrupt via
> > i8259 only. But that's all at the lower end of the latency graph, you will
> > most likely run into other sources on a busy system.
> > 
> >         Zwane
> > 
> Very interesting zwane....i haven't tested the local APIC....do you
> think this dispatch time can vary with the system I/O load (many
> pending interrupts in the PIC)?

The PIC/i386 setup cannot really pend interrupts so i would say no i don't 
think the dispatch time would be affected.

> I think the interrupt latency is influenced even by the code inside
> the kernel: if a lot of code is running with interrupts disabled then
> the interrupt latency will grow. Am i right?

Yes that's correct, in fact this will be your major/main cause of 
interrupt latency.

> So probably we can state that the factors influencing the interrupt latency are:
> 1)Dispatching time in the PIC 
> 2)Waiting time on the PIC (if there are pending interrupt of lower vector)

With APIC/i386 this is more possible, if you're really interested you 
should try and calculate the dispatch time using the same system (must 
have an IOAPIC) and testing with the following combinations;

PIC only (noapic, nolapic)
PIC + LAPIC (noapic)
IOAPIC + LAPIC

You will probably find that the IOAPIC + LAPIC has the lowest dispatch 
time. Also worth noting that the LAPIC can queue upto 2 vectors (on P4), 
this allows for more interrupts to be ready for dispatch.

> 3)fetching ISR from main memory
> 4)wait time when CPU is running with disabled interrupt
> 
> Do U agree?

A bit more on (4)

4a) wait time when CPU is running firmware (e.g. SMI/SMM, VGA BIOSes etc)

Otherwise, yes i agree, good luck with your research.

	Zwane
