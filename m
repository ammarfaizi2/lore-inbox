Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUAPCf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUAPCf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:35:57 -0500
Received: from fmr05.intel.com ([134.134.136.6]:15061 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265161AbUAPCfb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:35:31 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Thu, 15 Jan 2004 18:35:03 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173618848@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Thread-Index: AcPbuL9y5oXJP5CQS2C0OM9y8rrZmgAHQhiQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "James Cleverdon" <jamesclv@us.ibm.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Chris McDermott" <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
X-OriginalArrivalTime: 16 Jan 2004 02:35:04.0135 (UTC) FILETIME=[58D69570:01C3DBD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happens first is you will see kernel data corruption as irq exceeds
224 (NR_IRQS). 

In setup_IO_APIC_irqs(), for example, we do 
	if (IO_APIC_IRQ(irq)) {
             vector = assign_irq_vector(irq);
             entry.vector = vector;
             ioapic_register_intr(irq, vector, IOAPIC_AUTO);

             if (!apic && (irq < 16))
                    disable_8259A_irq(irq);
      }

Then ioapic_register_intr() does:
      if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
                trigger == IOAPIC_LEVEL)
                        irq_desc[irq].handler = &ioapic_level_type;
                else
                        irq_desc[irq].handler = &ioapic_edge_type;
                set_intr_gate(vector, interrupt[irq]);

Now of course irq_desc_t irq_desc[NR_IRQS], and same with interrupt[]. 

I think we need to add checking in IO_APIC_IRQ(irq) like from
#define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs)) to

#define IO_APIC_IRQ(x) (((x) < NR_IRQS) && ((x) >= 16) || ((1<<(x)) &
io_apic_irqs))

Jun


> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk]
> Sent: Thursday, January 15, 2004 2:41 PM
> To: James Cleverdon
> Cc: Nakajima, Jun; Andrew Morton; Linux Kernel; Linus Torvalds; Chris
> McDermott; Martin J. Bligh
> Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic
> subarch UP installer kernels
> 
> On Thu, 15 Jan 2004, James Cleverdon wrote:
> 
> > > In my opinion we should be breaking after we've exceeded the
maximum
> > > external vectors we can install. This will of course mean less
than
> > > the number of RTEs. James have you actually managed to use the
devices
> > > connected to the high (over ~224) RTEs?
> >
> > No, I haven't exceeded the available vectors, but wli has on a large
> NUMA-Q
> > box.
> 
> Yes i believe the 8 node NUMA-Qs do this easily.
> 
> > The x440 and x445's problems are pre-reserving lots of bus numbers
in
> the
> > BIOS, more than one per PCI slot.  They must be anticipating PCI
cards
> with
> > bridge chips on them.
> 
> For some odd reason i thought we had dynamic allocated MP busses.
> 
> > I believe that the reason for irq_vector being so large is to allow
IRQ
> (and
> > eventually vector) sharing.  The array is to map from RTE to vector.
> 
> What i'm trying to say is that the current code will behave badly when
you
> actually do encounter a system with that many RTEs, the actual array
> being that large isn't a problem, the problem is what's going on in
> assign_irq_vector() and later on with set_intr_gate(). By that i mean;
> 
> - The interrupt[] stub in entry.S is written with 256 irqs in mind so
it
> wouldn't be able to pass higher irq numbers to do_IRQ in it's current
> state.
> 
> - "Wrapping" in assign_irq_vector means that you overrite previously
> assigned vector entries in the IDT with whatever interrupt[irq] you
happen
> to be installing at the time. To avoid this you should not be allowing
> more than ~224 vectors to be handed out by assign_irq_vector(), with
the
> patch and the current code, this is possible.
> 
> Lastly i think we should avoid sharing vectors, going the IA64 route
and
> setting up irq handling domains of sorts would allow for easier
scaling
> both up and down.
> 
> Thanks,
> 	Zwane
