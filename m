Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUANVw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUANVw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:52:29 -0500
Received: from fmr05.intel.com ([134.134.136.6]:9670 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262925AbUANVwZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:52:25 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Wed, 14 Jan 2004 13:50:54 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017361883B@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Thread-Index: AcPaPxIl+D1gy7YnSs+0+d5TS1285AAqLQpg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "James Cleverdon" <jamesclv@us.ibm.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Chris McDermott" <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
X-OriginalArrivalTime: 14 Jan 2004 21:50:55.0420 (UTC) FILETIME=[7C995FC0:01C3DAE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

assign_irq_vector() is okay, and it simply returns vectors
(FIRST_DEVICE_VECTOR <= vector < FIRST_SYSTEM_VECTOR). That means those
IRQs will eventually share the same vector(s). Look at the code.

Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Zwane Mwaikambo
> Sent: Tuesday, January 13, 2004 5:00 PM
> To: James Cleverdon
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; Linus Torvalds; Chris
> McDermott; Martin J. Bligh
> Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic
> subarch UP installer kernels
> 
> On Tue, 13 Jan 2004, James Cleverdon wrote:
> 
> > Problem:  Earlier I didn't consider the case of the generic sub-arch
and
> > uni-proc installer kernels used by a number of distros.  It
currently is
> > scaled by NR_CPUS.  The correct values should be big for summit and
> generic,
> > and can stay the same for all others.
> 
> This all looks strange, especially in assign_irq_vector() does this
> mean that you'll try and allocate up to 1024 vectors?
> 
> > diff -pru 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h
> > t1mm2/include/asm-i386/mach-default/irq_vectors.h
> > --- 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h
2004-01-08
> > 22:59:19.000000000 -0800
> > +++ t1mm2/include/asm-i386/mach-default/irq_vectors.h
2004-01-13
> > 13:43:56.000000000 -0800
> > @@ -90,8 +90,12 @@
> >  #else
> >  #ifdef CONFIG_X86_IO_APIC
> >  #define NR_IRQS 224
> > -# if (224 >= 32 * NR_CPUS)
> > -# define NR_IRQ_VECTORS NR_IRQS
> > +/*
> > + * For Summit or generic (i.e. installer) kernels, we have lots of
I/O
> APICs,
> > + * even with uni-proc kernels, so use a big array.
> > + */
> > +# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
> > +# define NR_IRQ_VECTORS 1024
> >  # else
> >  # define NR_IRQ_VECTORS (32 * NR_CPUS)
> >  # endif
