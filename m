Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWCCXSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWCCXSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWCCXSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:18:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:61090
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932353AbWCCXSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:18:14 -0500
Date: Fri, 3 Mar 2006 15:18:07 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060303231807.GA28055@kroah.com>
References: <20060303220741.GA22298@kroah.com> <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:39:52PM -0600, Kumar Gala wrote:
> On Fri, 3 Mar 2006, Greg KH wrote:
> 
> > On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
> > > I was wondering what the proper way to assign and setup a single PCI  
> > > device that comes into existence after the system has booted.  I have  
> > > an FPGA that we load from user space at which time it shows up on the  
> > > PCI bus.
> > 
> > Idealy your BIOS would set up this information :)
> 
> How would my BIOS know about a device that didn't exist when it booted.  

According to the PCI Hotplug spec, your BIOS needs to take that into
consideration at boot time.  Yeah, it's a wierd thing, I agree, but is
how this works for x86 systems.  The space and resources are reserved
at boot time by the pci hotplug controller in anticipation of a device
being added sometime in the future.

Other arches do this differently (ppc64 has the stuff reserverd by the
hypervisor), and then compat pci does it by just plain guessing.  It
sounds like your situation is just like this one.

> Or do you mean my BIOS would load the FPGA as well so it existed.

No, see above.

> > > It has a single BAR and I need to assign it at a fixed address in PCI  
> > > MMIO space.
> > > 
> > > All of the exported interfaces I see have to do with having the  
> > > kernel assign the BAR automatically for me.
> > > 
> > > the following looks like what I want to do:
> > > 
> > > bus = pci_find_bus(0, 3);
> > > dev = pci_scan_single_device(bus, devfn);
> > > pci_bus_alloc_resource(...);
> > > pci_update_resource(dev, dev->resource[0], 0);
> > > pci_bus_add_devices(bus);
> > > 
> > > However, pci_update_resource() is not an exported symbol, so I could  
> > > replace that code with the need updates to the actual BAR.
> > > 
> > > Is this the "right" way to go about this or is there a better  
> > > mechanism to do this.
> > 
> > Take a look at how the compat pci hotplug driver does this, you probably
> > just need to do the same as it.
> 
> I'll take a look.  How about something like the following patch:

Hm, I don't think this is needed, see how the cpcihp drivers do it in
drivers/pci/hotplug/cpcihp*.c.  I think you can do things the same way.

But if not, I don't have any objection to adding this patch, you just
need to prove you really need it :)

thanks,

greg k-h
