Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVGEXfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVGEXfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVGEXfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:35:22 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:61586 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262015AbVGEXfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:35:01 -0400
Date: Wed, 6 Jul 2005 03:34:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050706033454.A706@den.park.msu.ru>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050702090913.B1506@flint.arm.linux.org.uk> <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk> <20050705224620.B15292@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050705224620.B15292@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jul 05, 2005 at 10:46:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 10:46:20PM +0100, Russell King wrote:
> On Tue, Jul 05, 2005 at 09:05:55PM +0100, Matthew Wilcox wrote:
> > 64-bit BARs work fine on 64-bit machines.  I'm ambivalent whether we
> > ought to support 64-bit BARs on 32-bit machines.
> 
> This only occurs because the problematical functions (eg,
> pci_update_resource) probably aren't called on 64-bit machines - if
> they were, they'd zero the upper 32-bits.  Maybe 64-bit machines are
> happy with that anyway?

Why problematical? It's just the way how linux has always dealt with
64-bit BARs - put everything below 4G in the bus address space, on *any*
architecture. I'd be quite surprised if some firmware doesn't do the same
thing - so far I haven't heard any complaints.
Eventually we'll have to support MMIO above 4G, but I suspect this won't
be necessary at least in a next couple of years. Anyway, there are no
fundamental changes required for the generic PCI layer to handle that,
just some tweaks here and there - almost all non-trivial stuff will be
arch-specific.

> Rather than reimplementing the internals of pci_update_resource() it
> may be worth splitting the common stuff out so it gets fixed for both
> pci_update_resource() and pci_enable_device().

Just use pci_update_resource().

John, I'd also suggest following changes to the patch:
- move the code to pci_set_power_state(), where it belongs to;
- explicitly check for D3hot->D0 transition *and* for the
  No_Soft_Reset bit, to avoid unnecessary config space accesses;
- add a quote from PCI spec (as a comment) explaining why is it needed.

Ivan.
