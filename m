Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTELSgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTELSgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:36:16 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:1991 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S262416AbTELSgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:36:13 -0400
Date: Mon, 12 May 2003 11:48:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Matt Porter <mporter@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, davem@redhat.com
Subject: Re: Message Signalled Interrupt support?
Message-ID: <20030512114851.B23510@home.com>
References: <20030512163249.GF27111@gtf.org> <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk> <20030512104300.A23510@home.com> <20030512182023.GA29534@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030512182023.GA29534@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, May 12, 2003 at 07:20:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 07:20:23PM +0100, Matthew Wilcox wrote:
> On Mon, May 12, 2003 at 10:43:00AM -0700, Matt Porter wrote:
> > I've also done some thought for PPC440xx's PCI MSI support.  It isn't
> > strictly necessary to have a new request_msi() if the kernel "does
> > the right thing".  request_irq() already hooks using an interrupt
> > value that is virtual on many platforms.
> 
> Yes, but ideally this kludge would go away...

Well, with respect to MSI, yes it could.  Interrupt values are
still a Linux fabrication regardless on many platforms with
cascaded PICs.
 
> > In that case, the PCI
> > subsystem would only need to provide an interface to provide
> > the architecture/platform specific inbound MSI location.  The PCI
> > subsystem would then find all MSI capable PCI devices, and assign
> > the appropriate number of unique messages and inbound MSI address
> > to each device via the speced PCI MSI interface.  The PCI subsystem
> > would also be responsible for maintaining a correspondence between
> > virtual Linux interrupt values and MSI values.
> > 
> > Software specific to the PCI MSI capable "Northbridge", will then
> > route general MSI interrupt events to some PCI subsystem helper
> > functions to verify which MSI has occurred and thus which Linux
> > virtual interrupt. 
> 
> That sounds like a lot of overhead.  In particular it means we keep
> converting to and from `virtual IRQs'.  I would hope the MSI work would
> allow us to tie in at a lower level than virtual interrupts.  I was
> thinking an interface would look something like:

Yes, it's a bit.  Just pointing out that one *could* do it that way,
not really that we *should* do it that way.  I would personally
prefer to see native msi support.  However, most of the functionality
I mentioned are things the PCI subsystem needs to do specific to
PCI MSI anyway.

> void *request_msi(struct device *dev,
> 		irqreturn_t (*handler)(int, void *, struct pt_regs *),
> 		unsigned long irqflags,
>                 void *dev_id)
> 
> You need a struct device to figure out which interrupt controller it
> needs.

request_msi() needs an additional parameter to specify which MSI
it is hooking.  A device can implement many messages in order to
clarify which one of many events on a device has occurred.  It
may be desired to hook a separate handler for each of those to
avoid another read of a status register.

Regards,
-- 
Matt Porter
mporter@kernel.crashing.org
