Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVBIVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVBIVGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVBIVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:06:31 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:54997 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261917AbVBIVG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:06:27 -0500
Subject: Re: [PATCH] [SERIAL] add TP560 data/fax/modem support
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <Pine.LNX.4.61.0502080710230.27765@chaos.analogic.com>
References: <1107805182.8074.35.camel@piglet>
	 <Pine.LNX.4.61.0502071508130.24378@chaos.analogic.com>
	 <1107809856.8074.50.camel@piglet>
	 <Pine.LNX.4.61.0502080710230.27765@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 14:06:19 -0700
Message-Id: <1107983179.27371.79.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 07:25 -0500, linux-os wrote:
> On Mon, 7 Feb 2005, Bjorn Helgaas wrote:
> 
> > On Mon, 2005-02-07 at 15:12 -0500, linux-os wrote:
> >> I thought somebody promised to add a pci_route_irq(dev) or some
> >> such so that the device didn't have to be enabled before
> >> the IRQ was correct.
> >>
> >> I first reported this bad IRQ problem back in December of 2004.
> >> Has the new function been added?
> >
> > That's a completely different problem.  The point here is that
> > the serial driver currently doesn't do anything with the TP560
> > (no pci_enable_device(), no pci_route_irq(), no nothing).  Then
> > when setserial comes along and force-feeds the driver with the
> > IO and IRQ info, there's nothing at that point that does anything
> > to enable the device or route its interrupt either.
> >
> > I did raise the idea of adding a pci_route_irq() interface, but
> > to be honest, I was never convinced of its general usefulness.
> 
> There  have been two PCI drivers in the past three days where
> users have reported that the IRQ was wrong.

If you've got pointers to these two reports, please provide them.

> One patch was
> provided to enable the device before requesting the IRQ, this
> being inherently dangerous. So, if you are the one who
> re-wrote the PCI stuff so that the IRQ is wrong when the
> device is claimed, then I think you have a duty to fix the
> code that you have broken.

Most drivers in the tree call pci_enable_device() before
request_irq().  That was the case even before my changes.
Dangerous?  Maybe, but I didn't make it more so.

> The correct way to fix the broken code is to make sure that
> the IRQ, reported in the structure, is correct. Alternate
> methods might be a pci_route_irq() function.

Or perhaps, the IRQ could be routed in pci_setup_device().
But, by the principle of "if you don't use it, don't touch
it", there *is* something to be said for the fact that the
current code doesn't touch IRQ routing unless a driver
actually claims the device.

> The existing PCI code is broken. The fact that an invalid
> IRQ is reported in the structure is PROOF that it is broken
> and requires no further discussion.

Then I'm sure your patch to fix it will be accepted without
much dissent.

> Many of us have to
> use this stuff in a professional environment, we can't
> enable devices without an interrupt handler in place
> because it is not allowed in code that is subject to
> peer review. We also can't use code when such problems
> as invalid values in returned data are discovered.

Nobody's forcing you to use "this stuff."

> Two months ago I discovered this problem and reported it, hoping
> that the person who broke existing code would fix it. It has
> not been fixed.

The fact is, yours is the only report of an issue with the
structure of the new code.  And it apparently only concerns
an out-of-tree driver.  Still, I agree that it might be good
to do something about it.  But you haven't provided pointers
to the hardware specs or driver involved.  So I'm not going to
go too much out of my way to fix it.

