Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTLJWIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLJWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:08:18 -0500
Received: from ida.rowland.org ([192.131.102.52]:4100 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264129AbTLJWIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:08:13 -0500
Date: Wed, 10 Dec 2003 17:08:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       <mfedyk@matchmail.com>, <zwane@holomorphy.com>,
       <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <20031210204621.GA8566@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0312101647480.645-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Greg KH wrote:

> Sorry, the pci driver has a remove() function, that's what I ment.
> 
> But anyway, yes, it does get called.  It looks like it is time to help
> explain the driver core...
> 
> When pci_unregister_driver() gets called, here is what happens:
> 	- pci_unregister_driver calls driver_unregister() with a pointer
> 	  to the pci_driver->driver field.
> 	- That pci_driver->driver field is set up when
> 	  pci_register_driver() is called, and contains pointers to the
> 	  pci_device_remove function.
> 	- driver_unregister() calls bus_remove_driver()
> 	- bus_remove_driver() locks some locks and calls
> 	  driver_detach().
> 	- driver_detach() walks the list of all devices that this driver
> 	  is attached to, and calls device_release_driver() on every
> 	  device.

That's about as far as I had followed it.  I should have kept going... but 
it wouldn't have made any difference.

> 	- device_release_driver() unlinks some sysfs files, does some
> 	  power management stuff, and then calls the remove() function
> 	  that is associated with that driver.  That remove function for
> 	  a pci driver is pci_device_remove()
> 	- pci_device_remove() then calls down to the pci_driver's remove
> 	  function, which in our case for a USB PCI Host controller
> 	  driver would be usb_hcd_pci_remove()
> 	- I think you can follow what usb_hcd_pci_remove() does.  After
> 	  it is finished, the call stack is unwound, and eventually
> 	  returns back to the caller of pci_unregister_driver().
> 
> Now grasshopper, are you wise in the ways of the driver core or are you
> wishing you never asked?  :)

Both, I think.  I still don't see where pci_unregister_driver() ends up
waiting for the reference count to drop to 0.  In fact, I think maybe you
agree that it _doesn't_ wait.  Which was my earlier point.


> > Or sleeping until the actual release function (struct hc_driver->hcd_free) 
> > is called.  But you have to make sure it was called for the host you are 
> > trying to deregister, not some other host.
> 
> That is done by the following logic (yeah, it's a maze of twisty
> paths...)
> 
> 	- in usb_hcd_pci_remove() we call usb_deregister_bus() to
> 	  unregister the bus structure.
> 	- usb_deregister_bus() calls class_device_unregister() with a
> 	  pointer to the bus's class device structure.  That class
> 	  device structure was previously reigstered to the
> 	  usb_host_class.  The usb_host_class's release function is the
> 	  usb_host_release() call.  That release function will be called
> 	  when the last reference on the class device is release.
> 	- usb_host_release() calls the release() function of the usb_bus
> 	  structure, which points back to how to clean up the memory for
> 	  that specific usb bus driver.  Now for all host controllers
> 	  that use the hcd framework, that points to the
> 	  hcd_pci_release() function.  Which will then call the
> 	  hcd_free() function for that specific hcd driver.
> 
> Does that help?  Or does your head hurt even more now?

I had already figured that much out for myself.  So
pci_unregister_driver() will follow this all the way down to
class_device_unregister(), which will decrement a reference count and
return immediately without calling usb_host_release() if the count isn't
0, which it wasn't in this case.

As a result pci_unregister_driver() returns immediately and the module is 
unloaded.  Later on when usb_host_release() does get called -- BOOM!

> So, if we wait for the class_device_unregister() function to actually
> free the memory (wait for the usb_host_release() function to complete)
> then we know it is absolutely safe for the driver to be removed from the
> system.
> 
> > Of course, if all you want to do is unload the module then it doesn't 
> > matter which host is which.  You just have to wait until they are all 
> > gone.
> 
> Exactly, and that will happen, if we wait on that
> class_device_unregister() call.  An example of how to do that can be
> seen in the i2c_del_adapter() function in drivers/i2c/i2c-core.c.

In the absence of the class_device_unregister_wait() function, the patch
you have created appears to be necessary.

As Pat LaVarre would say, I think we're agreeing violently.

Alan Stern



