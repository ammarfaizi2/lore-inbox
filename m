Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTLJPcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTLJPcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:32:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:55785 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263244AbTLJPcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:32:13 -0500
Date: Wed, 10 Dec 2003 07:30:56 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031210153056.GA7087@kroah.com>
References: <3FD64BD9.1010803@pacbell.net> <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 10:43:23PM -0500, Alan Stern wrote:
> On Tue, 9 Dec 2003, David Brownell wrote:
> 
> > Various folk have reported similar problems on system shutdown
> > before, and the simple fix has been not to clean up so aggressively.
> > 
> > What puzzled me was that a normal "rmmod" wouldn't give the
> > same symptoms -- but the same codepaths could oops in certain
> > system shutdown scenarios.
> 
> In an earlier message I wrote that the HC driver couldn't unload so long
> as the device usbfs was using held a reference to its bus.  I just did
> some checking, and guess what: It can!
> 
> I looked at both the UHCI and OHCI drivers.  In their module_exit routines
> they call pci_unregister_driver().  Without knowing how the PCI subsystem
> works, I would assume this behaves like any other "deregister" routine in
> the driver model and returns without waiting for any reference count to go
> to 0 -- that's what release callbacks are for.

No, the pci core calls the release() function in the pci driver that is
bound to that device.  It waits for that release() call to return before
continuing on.  You can sleep for however long you want in that
function, but once you return from there, the pci structures for that
device will be cleaned up.

> However, the module_exit routines _don't_ wait for the release callbacks.  

Not true.

> They just go right on ahead and exit.  Result: when the reference count 
> eventually does go to 0 (when usbfs drops its last reference), the 
> hcd_free routine is no longer present and you get an oops.

Hm, this could be easily tested by sleeping until usb_host_release() is
called when you unregister a device.  The i2c, pcmcia, and network
subsytems do this.  I think we now have a helper function in the driver
core to do this for us, so we don't have to declare our own completion
variable...

> The proper fix would be to have each HC driver keep track of how many 
> instances are allocated.  The module_exit routine must wait for that 
> number to drop to 0 before returning.

That's what my proposal 1 paragraph up would do.  If I get the chance
this afternoon, I'll try to implement it if no one beats me to it...

thanks,

greg k-h
