Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTLJRZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTLJRZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:25:41 -0500
Received: from ida.rowland.org ([192.131.102.52]:7428 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263785AbTLJRZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:25:38 -0500
Date: Wed, 10 Dec 2003 12:25:38 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       <mfedyk@matchmail.com>, <zwane@holomorphy.com>,
       <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <20031210153056.GA7087@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0312101212480.850-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Greg, I'm having trouble understanding if you're agreeing with me or 
disagreeing :-) ...

On Wed, 10 Dec 2003, Greg KH wrote:

> On Tue, Dec 09, 2003 at 10:43:23PM -0500, Alan Stern wrote:
> > 
> > I looked at both the UHCI and OHCI drivers.  In their module_exit routines
> > they call pci_unregister_driver().  Without knowing how the PCI subsystem
> > works, I would assume this behaves like any other "deregister" routine in
> > the driver model and returns without waiting for any reference count to go
> > to 0 -- that's what release callbacks are for.
> 
> No, the pci core calls the release() function in the pci driver that is
> bound to that device.  It waits for that release() call to return before
> continuing on.  You can sleep for however long you want in that
> function, but once you return from there, the pci structures for that
> device will be cleaned up.

I looked through the call tree for pci_unregister_driver().  There doesn't 
appear to be any place where it calls a release function.  In fact, struct 
pci_driver doesn't even _contain_ a release function!  Maybe you're 
thinking of the "remove" function.  But pci_unregister_driver() doesn't 
wait for that; it will return immediately even if the reference count is 
still > 0.

> 
> > However, the module_exit routines _don't_ wait for the release callbacks.  
> 
> Not true.

Here's the entire source for the UHCI module_exit routine:


static void __exit uhci_hcd_cleanup(void) 
{
	pci_unregister_driver(&uhci_pci_driver);
	
	if (kmem_cache_destroy(uhci_up_cachep))
		printk(KERN_INFO "uhci: not all urb_priv's were freed\n");

#ifdef CONFIG_PROC_FS
	remove_proc_entry("driver/uhci", 0);
#endif

	if (errbuf)
		kfree(errbuf);
}


Where in there does it wait for a release callback?

> 
> > They just go right on ahead and exit.  Result: when the reference count 
> > eventually does go to 0 (when usbfs drops its last reference), the 
> > hcd_free routine is no longer present and you get an oops.
> 
> Hm, this could be easily tested by sleeping until usb_host_release() is
> called when you unregister a device.  The i2c, pcmcia, and network
> subsytems do this.  I think we now have a helper function in the driver
> core to do this for us, so we don't have to declare our own completion
> variable...

Or sleeping until the actual release function (struct hc_driver->hcd_free) 
is called.  But you have to make sure it was called for the host you are 
trying to deregister, not some other host.

Of course, if all you want to do is unload the module then it doesn't 
matter which host is which.  You just have to wait until they are all 
gone.

Alan Stern

