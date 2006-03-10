Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWCJIde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWCJIde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWCJIde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:33:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23569 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932636AbWCJIde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:33:34 -0500
Date: Fri, 10 Mar 2006 08:33:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060310083324.GA25092@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302193441.GG28895@flint.arm.linux.org.uk> <20060310021009.GA2506@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310021009.GA2506@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:10:10PM -0500, Adam Belay wrote:
> On Thu, Mar 02, 2006 at 07:34:41PM +0000, Russell King wrote:
> > I have another question (brought up by someone working on a series of
> > ARM machines which make heavy use of MMIO.)
> > 
> > Why isn't pci_enable_device_bars() sufficient - why do we have to
> > have another interface to say "we don't want BARs XXX" ?
> > 
> > Let's say that we have a device driver which does this sequence (with,
> > of course, error checking):
> > 
> > 	pci_enable_device_bars(dev, 1<<1);
> > 	pci_request_regions(dev);
> > 
> > (a) should PCI remember that only BAR 1 has been requested to be enabled,
> >     and as such shouldn't pci_request_regions() ignore BAR 0?
> > 
> > (b) should the PCI driver pass into pci_request_regions() (or even
> >     pci_request_regions_bars()) a bitmask of the BARs it wants to have
> >     requested, and similarly for pci_release_regions().
> > 
> > Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
> > any business requesting it from the resource tree?
> 
> I understand the point you're making, but I think this misrepresents what
> is actually happening.  From my understanding of the spec, it's not possible
> to disable individual bars (with the exception of the expansion ROM).  Rather
> there is one bit for IO enable and one bit for IOMMU enable.  Therefore, we
> can enable or disable all I/O ports, but there's really no in between.  If
> the device uses even one I/O port, it's still a huge loss because of the
> potential bridge window dependency.  Also, if a device has several I/O ports
> but the driver only wants to use one, all of the others must still be
> assigned.

Agreed, but despite claiming that you understand my point, I don't
think you actually do.

1. It is already the case that drivers need to know the type of each BAR
   which the device presents - eg, most, if not all drivers take the start
   address of BAR0, throw that directly at ioremap, or use inb etc on it
   directly without first checking whether it's a MMIO or IO resource.

   So, if a driver knows that BAR0 is IO and BAR1 is MMIO, it can use
   pci_enable_device_bars(dev, BAR1) to only enable MMIO access.

2. pci_enable_device_bars() (which pre-exists for dealing with IDE) when
   passed the appropriate BAR mask, can be used to "enable" (or setup,
   program, or whatever, see below) only all MMIO or all IO BARs.

3. It is defined by the PCI subsystem that, for drivers, PCI resources
   are not valid prior to pci_enable_device*() being called, and are
   valid immediately after this call returns - pci_enable_device*()
   might be used by a PCI subsystem implementation to assign or
   reassign, and program PCI resources.

   Therefore, if you request pci_enable_device() (or pci_enable_device_bars
   with a full-bar mask) it is expected that _all_ BARs (or those
   requested) will become valid.  Adding this "no_io" device flag
   breaks this expectation.

4. I'm not suggesting that pci_enable_device_bars() should be (or can be)
   used to "selectively enable BARs" which I think is how you're reading
   this.  Yes, it does apparantly have the capacity to do this (and is
   used like this for IDE) but inappropriate use like that is a driver
   bug, and is already a driver bug *today*.

I'm merely suggesting using an established interface which has some
agreed appropriate driver expectations for the purpose of solving
this new problem.  It fits perfectly, it's clean, it doesn't add lots
of complexity, and there's no reason what so ever not to use it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
