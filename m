Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVGRMNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVGRMNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGRMNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 08:13:11 -0400
Received: from colo.lackof.org ([198.49.126.79]:27279 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261696AbVGRMNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 08:13:06 -0400
Date: Mon, 18 Jul 2005 06:17:44 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050718121744.GD8775@colo.lackof.org>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050705174617.GB21933@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705174617.GB21933@tuxdriver.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 01:46:20PM -0400, John W. Linville wrote:
> On Sat, Jul 02, 2005 at 01:29:54AM -0600, Grant Grundler wrote:
> > On Thu, Jun 30, 2005 at 10:26:37PM -0400, John W. Linville wrote:
> 
> > > +	/* Some devices lose PCI config header data during D3hot->D0
> > 
> > Can you name some of those devices here?
> > I just want to know what sort of devices need to be tested 
> > if this code changes in the future.
> 
> I don't really have a list.  The devices that brought this issue to
> my attention are a 3c905B and a 3c556B, both covered by the 3c59x
> driver.

John,
apologies for the late reply - been offline the past two weeks on holiday.

Just listing the two devices in a comment would be sufficient.

> According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT INTERFACE
> SPECIFICATION, REV. 1.2", a device transitioning from D3hot to D0
> _may_ perform an internal reset, thereby going to "D0 Uninitialized"
> rather than "D0 Initialized".

Including the above paragraph in a comment would be a good thing.
I don't know if this spec is publicly available. But even if it is,
typically only a handful of people will be familiar enough with it
to know where to look in it.

> Since this behaviour is ratified by
> the spec, I think we need to accomodate it.

Yes - sounds reasonable to me too.

> A bit in the PMCSR register indicates how a device will behave in
> this regard.  We could have a test to only execute the BAR restoration
> for those devices that seem to need it.  I left that out because it
> seemed to add needless complexity.  In the meantime the patch has
> gotten bigger and more complex, so maybe that code doesn't make it
> any worse.  Do you want me to add that?

I think I'd keep it simpler until someone proves we need it.
I've read the rest of the thread and don't recall any such proof.

> 
> > 
> > > +	   transition.	Since some firmware leaves devices in D3hot
> > > +	   state at boot, this information needs to be restored.
> > 
> > Again, which firmware?
> > Examples are good since it makes it possible to track down
> > the offending devices for testing.
> 
> The Thinkpad T21 does this.  I don't know of any others specifically,
> but it seems like something laptop BIOSes would be likely to do.

That's fine - just listing the Thinkpad T21 in a comment is helpful.
If you happen to know the firmware version too, that would be even better.

> > The following chunk looks like it will have issues with 64-bit BARs:
> 
> As RMK pointed-out, this code is inspired by setup-res.c; specifically
> that in pci_update_resource.  I'd prefer not to blaze any new trails
> regarding 64-bit BAR support ATM... :-)

After thinking about this more, I'm convinced it's broken if a 64-bit BAR
is present on the PCI device. It doesn't matter if the MMIO value is
greater than 4GB or not. The problem is pci_dev->resource[i] does NOT
map 1:1 with PCI_BASE_ADDRESS_0+(i*4).

> So, is the current patch acceptable?

I don't think so. 64-bit BARs are just too common today.
One solution is to use a seperate variable to track the offset into
PCI config space. ie use "i" to walk through pci_dev->resource[]
and add "unsigned int pcibar_offset" to keep track of 32 vs 64-bit BARs.

> Or shall I add the check for the "no soft reset" bit in the PMCSR register?

I don't see why that's necessary.

thanks,
grant
