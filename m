Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTELSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTELSOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:14:35 -0400
Received: from fmr01.intel.com ([192.55.52.18]:41947 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262543AbTELSOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:14:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Message Signalled Interrupt support?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Mon, 12 May 2003 11:26:47 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401E44FE9@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Message Signalled Interrupt support?
Thread-Index: AcMYrQv05PGwk5IkQiKGtFAsatj/cQABou5Q
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Matt Porter" <mporter@kernel.crashing.org>,
       "Matthew Wilcox" <willy@debian.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, <davem@redhat.com>
X-OriginalArrivalTime: 12 May 2003 18:26:52.0062 (UTC) FILETIME=[0EF4F3E0:01C318B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree. We did not change arch/i386/kernel/irq.c, for example. 

Thanks,
Jun

> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]
> Sent: Monday, May 12, 2003 10:43 AM
> To: Matthew Wilcox
> Cc: Jeff Garzik; linux-kernel@vger.kernel.org; Ivan Kokshaysky;
> davem@redhat.com
> Subject: Re: Message Signalled Interrupt support?
> 
> On Mon, May 12, 2003 at 05:53:31PM +0100, Matthew Wilcox wrote:
> > On Mon, May 12, 2003 at 12:32:49PM -0400, Jeff Garzik wrote:
> > > Has anybody done any work, or put any thought, into MSI support?
> >
> > Work -- no.  Thought?  A little.  Seems to me that MSIs need to be
> treated
> > as a third form of interrupts (level/edge/message).  The address that
> > the MSI will write to is clearly architecture dependent (may even be
> > irq-controller-dependent, depending on your architecture).
> request_irq()
> > is an insufficient function to deal with this -- request_msi() may be
> > needed instead.  It'll need to return an address to pass to the card.
> > (We need a mechanism to decide whether it's a 32-bit or 64-bit address).
> 
> I've also done some thought for PPC440xx's PCI MSI support.  It isn't
> strictly necessary to have a new request_msi() if the kernel "does
> the right thing".  request_irq() already hooks using an interrupt
> value that is virtual on many platforms.  In that case, the PCI
> subsystem would only need to provide an interface to provide
> the architecture/platform specific inbound MSI location.  The PCI
> subsystem would then find all MSI capable PCI devices, and assign
> the appropriate number of unique messages and inbound MSI address
> to each device via the speced PCI MSI interface.  The PCI subsystem
> would also be responsible for maintaining a correspondence between
> virtual Linux interrupt values and MSI values.
> 
> Software specific to the PCI MSI capable "Northbridge", will then
> route general MSI interrupt events to some PCI subsystem helper
> functions to verify which MSI has occurred and thus which Linux
> virtual interrupt.
> 
> Perhaps request_irq() just needs to be explicitly abstracted if
> an unsigned int is not sufficient for the entire message space or
> if we want messages unique only on a per-space basis i.e. PCI MSIs
> can be dups of RapidIO MSIs, etc.
> 
> > Oh, and don't make this too PCI-specific -- native PARISC interrupts
> > are MSI and you can see how handled it in arch/parisc/kernel/irq.c.
> 
> FWIW, another interconnect that natively uses MSI is RapidIO.  It's
> all in-band doorbell messages, no out-of-band discrete interrupts like
> PCI.
> 
> Regards,
> --
> Matt Porter
> mporter@kernel.crashing.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
