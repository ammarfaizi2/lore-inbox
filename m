Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTLJUsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTLJUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:47:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:8930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263946AbTLJUrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:47:43 -0500
Date: Wed, 10 Dec 2003 12:46:21 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031210204621.GA8566@kroah.com>
References: <20031210153056.GA7087@kroah.com> <Pine.LNX.4.44L0.0312101212480.850-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0312101212480.850-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 12:25:38PM -0500, Alan Stern wrote:
> Sorry Greg, I'm having trouble understanding if you're agreeing with me or 
> disagreeing :-) ...

Heh, I don't really know either, just trying to state what is really
happening in the pci code.

> On Wed, 10 Dec 2003, Greg KH wrote:
> 
> > On Tue, Dec 09, 2003 at 10:43:23PM -0500, Alan Stern wrote:
> > > 
> > > I looked at both the UHCI and OHCI drivers.  In their module_exit routines
> > > they call pci_unregister_driver().  Without knowing how the PCI subsystem
> > > works, I would assume this behaves like any other "deregister" routine in
> > > the driver model and returns without waiting for any reference count to go
> > > to 0 -- that's what release callbacks are for.
> > 
> > No, the pci core calls the release() function in the pci driver that is
> > bound to that device.  It waits for that release() call to return before
> > continuing on.  You can sleep for however long you want in that
> > function, but once you return from there, the pci structures for that
> > device will be cleaned up.
> 
> I looked through the call tree for pci_unregister_driver().  There doesn't 
> appear to be any place where it calls a release function.  In fact, struct 
> pci_driver doesn't even _contain_ a release function!  Maybe you're 
> thinking of the "remove" function.  But pci_unregister_driver() doesn't 
> wait for that; it will return immediately even if the reference count is 
> still > 0.

Sorry, the pci driver has a remove() function, that's what I ment.

But anyway, yes, it does get called.  It looks like it is time to help
explain the driver core...

When pci_unregister_driver() gets called, here is what happens:
	- pci_unregister_driver calls driver_unregister() with a pointer
	  to the pci_driver->driver field.
	- That pci_driver->driver field is set up when
	  pci_register_driver() is called, and contains pointers to the
	  pci_device_remove function.
	- driver_unregister() calls bus_remove_driver()
	- bus_remove_driver() locks some locks and calls
	  driver_detach().
	- driver_detach() walks the list of all devices that this driver
	  is attached to, and calls device_release_driver() on every
	  device.
	- device_release_driver() unlinks some sysfs files, does some
	  power management stuff, and then calls the remove() function
	  that is associated with that driver.  That remove function for
	  a pci driver is pci_device_remove()
	- pci_device_remove() then calls down to the pci_driver's remove
	  function, which in our case for a USB PCI Host controller
	  driver would be usb_hcd_pci_remove()
	- I think you can follow what usb_hcd_pci_remove() does.  After
	  it is finished, the call stack is unwound, and eventually
	  returns back to the caller of pci_unregister_driver().

Now grasshopper, are you wise in the ways of the driver core or are you
wishing you never asked?  :)

> > > However, the module_exit routines _don't_ wait for the release callbacks.  
> > 
> > Not true.
> 
> Here's the entire source for the UHCI module_exit routine:
> 
> 
> static void __exit uhci_hcd_cleanup(void) 
> {
> 	pci_unregister_driver(&uhci_pci_driver);

This call does all the cleanups we need.

> 	
> 	if (kmem_cache_destroy(uhci_up_cachep))
> 		printk(KERN_INFO "uhci: not all urb_priv's were freed\n");
> 
> #ifdef CONFIG_PROC_FS
> 	remove_proc_entry("driver/uhci", 0);
> #endif
> 
> 	if (errbuf)
> 		kfree(errbuf);
> }
> 
> 
> Where in there does it wait for a release callback?

In pci_unregister_driver().

> > > They just go right on ahead and exit.  Result: when the reference count 
> > > eventually does go to 0 (when usbfs drops its last reference), the 
> > > hcd_free routine is no longer present and you get an oops.
> > 
> > Hm, this could be easily tested by sleeping until usb_host_release() is
> > called when you unregister a device.  The i2c, pcmcia, and network
> > subsytems do this.  I think we now have a helper function in the driver
> > core to do this for us, so we don't have to declare our own completion
> > variable...
> 
> Or sleeping until the actual release function (struct hc_driver->hcd_free) 
> is called.  But you have to make sure it was called for the host you are 
> trying to deregister, not some other host.

That is done by the following logic (yeah, it's a maze of twisty
paths...)

	- in usb_hcd_pci_remove() we call usb_deregister_bus() to
	  unregister the bus structure.
	- usb_deregister_bus() calls class_device_unregister() with a
	  pointer to the bus's class device structure.  That class
	  device structure was previously reigstered to the
	  usb_host_class.  The usb_host_class's release function is the
	  usb_host_release() call.  That release function will be called
	  when the last reference on the class device is release.
	- usb_host_release() calls the release() function of the usb_bus
	  structure, which points back to how to clean up the memory for
	  that specific usb bus driver.  Now for all host controllers
	  that use the hcd framework, that points to the
	  hcd_pci_release() function.  Which will then call the
	  hcd_free() function for that specific hcd driver.

Does that help?  Or does your head hurt even more now?

So, if we wait for the class_device_unregister() function to actually
free the memory (wait for the usb_host_release() function to complete)
then we know it is absolutely safe for the driver to be removed from the
system.

> Of course, if all you want to do is unload the module then it doesn't 
> matter which host is which.  You just have to wait until they are all 
> gone.

Exactly, and that will happen, if we wait on that
class_device_unregister() call.  An example of how to do that can be
seen in the i2c_del_adapter() function in drivers/i2c/i2c-core.c.

greg k-h
