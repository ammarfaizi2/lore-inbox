Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267205AbSLED7Q>; Wed, 4 Dec 2002 22:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbSLED7Q>; Wed, 4 Dec 2002 22:59:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267205AbSLED7O>;
	Wed, 4 Dec 2002 22:59:14 -0500
Date: Wed, 4 Dec 2002 21:50:25 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] bus notifiers for the generic device model
In-Reply-To: <20021204222938.GA29519@kroah.com>
Message-ID: <Pine.LNX.4.33.0212042135420.924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, Greg KH wrote:

> On Wed, Dec 04, 2002 at 01:35:00PM -0600, James Bottomley wrote:
> > greg@kroah.com said:
> > > Why not have a call in the driver that notifies the bus specific core
> > > of this?  Or just check the status of the return value of your "probe"
> > > function that the bus provides.  See usb_device_probe() and
> > > pci_device_probe() for examples of this. 
> > 
> > Well, I did do it this way for parisc.  However, I assumed from reading the 
> > driver model docs that we were transitioning to using the generic driver probe 
> > rather than doing probe interceptions like this.
> > 
> > Doing it like this just seems rather clumsy.  wouldn't it be better to 
> > deprecate bus specific registrations in favour of the generic one?
> 
> I don't know.  Then for every bus specific driver, they would have to do
> the "dereference the structure" logic before they can start to determine
> if they should bind to this specific device.  That's all the PCI and USB
> code really does, strip out the proper structures that are relevant to
> the specific bus type, and then call the driver.
> 
> So in the end you would probably have a lot of duplicated code that
> would be better off being in one place, like it is today :)

I tend to agree with Greg, though this exposes one of the great tradeoffs 
of the driver model. We can consolidate data structures and operations on 
them into common ones, but sooner or later, we have to call down to the 
bus (or class)-specific objects, necessitating a conversion to the 
relevant object. 

The current infrastructure was designed the way it is to provide seamless 
transition while features of the generic model evolved. This is precisely 
why the bus drivers provide intermediate calls for the generic struct 
device_driver. The thought was that one day we could hopefully convert 
everything to the generic way and everything would be fantastic. 

Along they way, we've found several things stand in the way of making this 
a smooth transition, so the plan is to stick with the bus intermediaries 
until the infrastructure matures enough to tackle those problems more 
easily. 

> > There is another advantage to notifiers: they can be chained.  Certain bus 
> > architectures need to do additional setup for things like pci devices.  They 
> > would be able to do this by attaching a notifier.

[ Replying to James... ]

I don't see how your patch adresses chaining; there is only one notifier 
per bus type.

On the other hand, I've considered implementing something like before 
(Most recently in the last couple of days). Essentially, one could have 
components register with a subsystem (e.g. bus type), that are called when 
a device is added or removed. 

This would make conditional features and extensions easy to call. For
example, drivers/pci/proc.c could register with the PCI bus to be called 
each time a device was added. This would eliminate uglies like:

int pci_proc_attach_device(struct pci_dev *dev);

#ifdef CONFIG_PROC_FS
        pci_proc_attach_device(dev);
#endif

Ditto for usbfs. 

It would also provide a means to eliminate the power management 
information in struct device, as PM could be an extension of the top-level 
device subsystem, only called if CONFIG_PM is set. 

However, there are a few details that are kinda nasty (like associating 
data between the extension and the device), and I've shelved the idea 
again..

	-pat

