Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTELSJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbTELSHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:07:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62622 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262437AbTELSHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:07:43 -0400
Date: Mon, 12 May 2003 19:20:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, davem@redhat.com
Subject: Re: Message Signalled Interrupt support?
Message-ID: <20030512182023.GA29534@parcelfarce.linux.theplanet.co.uk>
References: <20030512163249.GF27111@gtf.org> <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk> <20030512104300.A23510@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512104300.A23510@home.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:43:00AM -0700, Matt Porter wrote:
> I've also done some thought for PPC440xx's PCI MSI support.  It isn't
> strictly necessary to have a new request_msi() if the kernel "does
> the right thing".  request_irq() already hooks using an interrupt
> value that is virtual on many platforms.

Yes, but ideally this kludge would go away...

> In that case, the PCI
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

That sounds like a lot of overhead.  In particular it means we keep
converting to and from `virtual IRQs'.  I would hope the MSI work would
allow us to tie in at a lower level than virtual interrupts.  I was
thinking an interface would look something like:

void *request_msi(struct device *dev,
		irqreturn_t (*handler)(int, void *, struct pt_regs *),
		unsigned long irqflags,
                void *dev_id)

You need a struct device to figure out which interrupt controller it
needs.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
