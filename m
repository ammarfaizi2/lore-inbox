Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTELRaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTELRaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:30:24 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:32657 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262196AbTELRaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:30:22 -0400
Date: Mon, 12 May 2003 10:43:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, davem@redhat.com
Subject: Re: Message Signalled Interrupt support?
Message-ID: <20030512104300.A23510@home.com>
References: <20030512163249.GF27111@gtf.org> <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, May 12, 2003 at 05:53:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 05:53:31PM +0100, Matthew Wilcox wrote:
> On Mon, May 12, 2003 at 12:32:49PM -0400, Jeff Garzik wrote:
> > Has anybody done any work, or put any thought, into MSI support?
> 
> Work -- no.  Thought?  A little.  Seems to me that MSIs need to be treated
> as a third form of interrupts (level/edge/message).  The address that
> the MSI will write to is clearly architecture dependent (may even be
> irq-controller-dependent, depending on your architecture).  request_irq()
> is an insufficient function to deal with this -- request_msi() may be
> needed instead.  It'll need to return an address to pass to the card.
> (We need a mechanism to decide whether it's a 32-bit or 64-bit address).

I've also done some thought for PPC440xx's PCI MSI support.  It isn't
strictly necessary to have a new request_msi() if the kernel "does
the right thing".  request_irq() already hooks using an interrupt
value that is virtual on many platforms.  In that case, the PCI
subsystem would only need to provide an interface to provide
the architecture/platform specific inbound MSI location.  The PCI
subsystem would then find all MSI capable PCI devices, and assign
the appropriate number of unique messages and inbound MSI address
to each device via the speced PCI MSI interface.  The PCI subsystem
would also be responsible for maintaining a correspondence between
virtual Linux interrupt values and MSI values.

Software specific to the PCI MSI capable "Northbridge", will then
route general MSI interrupt events to some PCI subsystem helper
functions to verify which MSI has occurred and thus which Linux
virtual interrupt. 

Perhaps request_irq() just needs to be explicitly abstracted if
an unsigned int is not sufficient for the entire message space or
if we want messages unique only on a per-space basis i.e. PCI MSIs
can be dups of RapidIO MSIs, etc.

> Oh, and don't make this too PCI-specific -- native PARISC interrupts
> are MSI and you can see how handled it in arch/parisc/kernel/irq.c.

FWIW, another interconnect that natively uses MSI is RapidIO.  It's
all in-band doorbell messages, no out-of-band discrete interrupts like
PCI.

Regards,
-- 
Matt Porter
mporter@kernel.crashing.org
