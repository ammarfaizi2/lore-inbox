Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUANX2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUANXZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:25:32 -0500
Received: from fmr06.intel.com ([134.134.136.7]:25492 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265165AbUANXOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:14:15 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Wed, 14 Jan 2004 15:13:39 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Thread-Index: AcPa7M0cUqQKAgGrTuWsVba6Z9DMeAAAmM0Q
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "James Cleverdon" <jamesclv@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Chris McDermott" <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
X-OriginalArrivalTime: 14 Jan 2004 23:13:44.0456 (UTC) FILETIME=[0E601880:01C3DAF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tend to agree. I think the confusing part is the range of the IRQs on
that machine. Assuming that irq_vector[NR_IRQ_VECTORS = 1024] requires
more entries, then the IRQs should take that range, because
IO_APCI_VECTOR(irq) is just irq_vector[irq], for example. If NR_IRQS is
still 224, how can do_IRQ() can get the correct IRQ (i.e. >= 224) ? So
in that case, the IRQ should be smaller than 224, then irq_vector[]
should be smaller.

> >  #else
> >  #ifdef CONFIG_X86_IO_APIC
> >  #define NR_IRQS 224
> > -# if (224 >= 32 * NR_CPUS)
> > -# define NR_IRQ_VECTORS NR_IRQS
> > +/*
> > + * For Summit or generic (i.e. installer) kernels, we have lots of
I/O
> > APICs, + * even with uni-proc kernels, so use a big array.
> > + */
> > +# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
> > +# define NR_IRQ_VECTORS 1024
> >  # else
> >  # define NR_IRQ_VECTORS (32 * NR_CPUS)
> >  # endif

Jun

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk]
> Sent: Wednesday, January 14, 2004 2:21 PM
> To: Nakajima, Jun
> Cc: James Cleverdon; Andrew Morton; linux-kernel@vger.kernel.org;
Linus
> Torvalds; Chris McDermott; Martin J. Bligh
> Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic
> subarch UP installer kernels
> 
> On Wed, 14 Jan 2004, Nakajima, Jun wrote:
> 
> > assign_irq_vector() is okay, and it simply returns vectors
> > (FIRST_DEVICE_VECTOR <= vector < FIRST_SYSTEM_VECTOR). That means
those
> > IRQs will eventually share the same vector(s). Look at the code.
> 
> Ok so you have different irqs sharing vectors, how does this work with
the
> following (where $vector really means $irq of course)?
> 
> .data
> ENTRY(interrupt)
> .text
> 
> vector=0
> ENTRY(irq_entries_start)
> .rept NR_IRQS
>         ALIGN
> 1:      pushl $vector-256
>         jmp common_interrupt
> 
> Also i was thinking about when you exhaust all 200 odd
> spare vectors and then end up doing set_intr_gate twice on the same
> vector? I may be missing something really obvious here.
> 
> Thanks

