Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161466AbWJTFQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbWJTFQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbWJTFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:16:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:18836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161465AbWJTFQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:16:29 -0400
Date: Thu, 19 Oct 2006 21:44:54 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] Add device addition/removal notifier
Message-ID: <20061020044454.GA8627@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain> <20061020032624.GA7620@kroah.com> <1161318564.10524.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161318564.10524.131.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:29:24PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-10-19 at 20:26 -0700, Greg KH wrote:
> > On Fri, Oct 20, 2006 at 11:55:50AM +1000, Benjamin Herrenschmidt wrote:
> > > @@ -608,12 +615,14 @@ void device_del(struct device * dev)
> > >  	device_remove_groups(dev);
> > >  	device_remove_attrs(dev);
> > >  
> > > +	bus_remove_device(dev);
> > >  	/* Notify the platform of the removal, in case they
> > >  	 * need to do anything...
> > >  	 */
> > >  	if (platform_notify_remove)
> > >  		platform_notify_remove(dev);
> > > -	bus_remove_device(dev);
> > > +	blocking_notifier_call_chain(&device_notifier, DEVICE_NOTIFY_DEL_DEV,
> > > +				     dev);
> > 
> > Why did you move the call to bus_remove_device() to be before the
> > platform_notify_remove() and notifier is called?
> 
> I sent a mail about that a couple of days ago. The current behaviour is
> bogus imho. (mail subjet was [PATCH/RFC] Call platform_notify_remove
> later, and Len Brown who uses that hook in ACPI agreed).
> 
> Basically, we notify the platform of insertion before we bind devices to
> busses & drivers (so the platform can do fixups, allocate auxilliary
> data structures, whatever else...) and thus we should notify the
> platform of removal -after- we unbind from the bus and driver where it
> will then destroy those data structures). 
> 
> In my case, I need to hookup the DMA ops pointers. It would be very
> bogus to destroy those before the driver remove() has been called.

Ok, as long as you all agree that this does change the behavior, it's
fine with me :)

> > And I don't think this is really going to work well.  You have created a
> > notifier for all devices in the system, right?  How do you know what
> > type of struct device is being passed to your notifier callback?  At
> > least with the platform callback, you knew it was a platform device :)
> 
> No I didn't. The platform_notify callback was called for any device as
> is my notifier :)
> 
> All I did was to add a notifier chain in addition to the old function
> pointer with the intend of deprecating the function pointer :)
> 
> You can know what type of device you are called for by comparing the
> device->bus to the address of the bus type data structure. That's the
> only way to do so but it works pretty fine. (There are actually some
> severe issues with the device model and with PCI around that area that
> I'm hitting trying to clean up some of the powerpc mess but let's handle
> one problem at a time).
> 
> On PowerPC, for example, I'll use that notifier in at least 2 different
> places: For PCI, I need to use the "delete" callback to destroy the
> auxilliary data structure containing the DMA ops (it's currently created
> by some PCI fixup code, but I might also migrate that to the "add"
> callback. The other place is for platforms like Cell that are now
> growing DMA capable non-PCI devices, that I'm catching in the cell
> specific iommu code via that notifier, to hook them up to the right DMA
> ops.

Ok, then perhaps you just want a bus specific callback for the devices
on that bus?  That would be much simpler and keep you from having to do
that mess with the different tests of bus type.

Actually, that's the only thing that really makes sense here, now that I
think about it, the platform_notify doesn't really make any sense...

thanks,

greg k-h
