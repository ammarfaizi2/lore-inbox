Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVA1T7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVA1T7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVA1TzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:55:05 -0500
Received: from colo.lackof.org ([198.49.126.79]:63957 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262787AbVA1TdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:33:05 -0500
Date: Fri, 28 Jan 2005 12:33:20 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128193320.GB32135@colo.lackof.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com> <20050128173222.GC30791@colo.lackof.org> <200501281041.42016.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501281041.42016.jbarnes@sgi.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 10:41:41AM -0800, Jesse Barnes wrote:
> > Eh?! there can only be *one* legacy I/O space.
> > We can support multipl IO port spaces, but only one can be the "legacy".
> 
> What do you mean?  If you define legacy I/O space to be 
> 0x0000000000000000-0x000000000000ffff, then yes of course you're right.

Yes - exactly.

> But 
> if you mean being able to access legacy ports at all, then no.  On SGI 
> machines, there's a per-bus base address that can be used as the base for 
> port I/O, which is what I was getting at.

Ok - my point was "0x3fc" will get routed to exactly one of those
IO port address spaces.

> > If it is intended to work with multiple IO Port address spaces,
> > then it needs to use the pci_dev->resource[] and mangle that appropriately.
> 
> There is no resource for some of the I/O port space that cards respond to.

Yes - I've heard several graphics cards are horrible broken WRT address
decoding.  Are PCI quirks supposed to handle that sort of thing?

Another example was Xf86 was poking around in MMIO space 
to determine if such broken cards are installed.

> I can set the I/O BAR of my VGA card to 0x400 and it'll still respond to 
> accesses at 0x3bc for example.  That's what I mean by legacy space--space 
> that cards respond to but don't report in their PCI resources.

Can't PCI quirks fix up the resources to reflect this?

I think one needs to fix up PCI IO Port resources to adjust
for "The One" legacy IO port space getting routed to a different
PCI segment - assuming no one submits a patch to change current
behavior of using hard coded addresses.

HP parisc and ia64 platforms implement seperate PCI segments under
each PCI host bus controller. Linux PCI "BIOS" support provides
the illusion it's all in one PCI segment on most (not all) platforms.
Some HP chipsets also provide a "Legacy" IO Port space that gets
routed to a chosen PCI Host bus controller.

parisc PCI BIOS adds the controller instance number to the IO port space
resource to help "inb()" generate the IO port cycle on the right
PCI segment. This needs to be fixed up if we decide a different
PCI segment should be segment 0 (and thus get references to 0x3fc).
I expect other arches with multi-segment support to do similar
fix ups.

Am I making more sense now?

thanks,
grant
