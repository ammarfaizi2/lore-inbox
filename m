Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946309AbWJTE3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946309AbWJTE3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946316AbWJTE3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:29:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:9408 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1946309AbWJTE3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:29:39 -0400
Subject: Re: [PATCH] Add device addition/removal notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20061020032624.GA7620@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
	 <20061020032624.GA7620@kroah.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 14:29:24 +1000
Message-Id: <1161318564.10524.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 20:26 -0700, Greg KH wrote:
> On Fri, Oct 20, 2006 at 11:55:50AM +1000, Benjamin Herrenschmidt wrote:
> > @@ -608,12 +615,14 @@ void device_del(struct device * dev)
> >  	device_remove_groups(dev);
> >  	device_remove_attrs(dev);
> >  
> > +	bus_remove_device(dev);
> >  	/* Notify the platform of the removal, in case they
> >  	 * need to do anything...
> >  	 */
> >  	if (platform_notify_remove)
> >  		platform_notify_remove(dev);
> > -	bus_remove_device(dev);
> > +	blocking_notifier_call_chain(&device_notifier, DEVICE_NOTIFY_DEL_DEV,
> > +				     dev);
> 
> Why did you move the call to bus_remove_device() to be before the
> platform_notify_remove() and notifier is called?

I sent a mail about that a couple of days ago. The current behaviour is
bogus imho. (mail subjet was [PATCH/RFC] Call platform_notify_remove
later, and Len Brown who uses that hook in ACPI agreed).

Basically, we notify the platform of insertion before we bind devices to
busses & drivers (so the platform can do fixups, allocate auxilliary
data structures, whatever else...) and thus we should notify the
platform of removal -after- we unbind from the bus and driver where it
will then destroy those data structures). 

In my case, I need to hookup the DMA ops pointers. It would be very
bogus to destroy those before the driver remove() has been called.
 
> And I don't think this is really going to work well.  You have created a
> notifier for all devices in the system, right?  How do you know what
> type of struct device is being passed to your notifier callback?  At
> least with the platform callback, you knew it was a platform device :)

No I didn't. The platform_notify callback was called for any device as
is my notifier :)

All I did was to add a notifier chain in addition to the old function
pointer with the intend of deprecating the function pointer :)

You can know what type of device you are called for by comparing the
device->bus to the address of the bus type data structure. That's the
only way to do so but it works pretty fine. (There are actually some
severe issues with the device model and with PCI around that area that
I'm hitting trying to clean up some of the powerpc mess but let's handle
one problem at a time).

On PowerPC, for example, I'll use that notifier in at least 2 different
places: For PCI, I need to use the "delete" callback to destroy the
auxilliary data structure containing the DMA ops (it's currently created
by some PCI fixup code, but I might also migrate that to the "add"
callback. The other place is for platforms like Cell that are now
growing DMA capable non-PCI devices, that I'm catching in the cell
specific iommu code via that notifier, to hook them up to the right DMA
ops.

Ben.

> 
> 
> >  	device_pm_remove(dev);
> >  	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
> >  	kobject_del(&dev->kobj);
> > @@ -836,3 +845,15 @@ int device_rename(struct device *dev, ch
> >  
> >  	return error;
> >  }
> > +
> > +int register_device_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&device_notifier, nb);
> > +}
> > +EXPORT_SYMBOL(register_device_notifier);
> > +
> > +int unregister_device_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_unregister(&device_notifier, nb);
> > +}
> > +EXPORT_SYMBOL(unregister_device_notifier);
> 
> All driver core exports should be _GPL() please.
> 
> thanks,
> 
> greg k-h

