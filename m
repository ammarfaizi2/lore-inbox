Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTLJDnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTLJDnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:43:25 -0500
Received: from netrider.rowland.org ([192.131.102.5]:5906 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262098AbTLJDnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:43:24 -0500
Date: Tue, 9 Dec 2003 22:43:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Duncan Sands <baldrick@free.fr>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <3FD64BD9.1010803@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, David Brownell wrote:

> Various folk have reported similar problems on system shutdown
> before, and the simple fix has been not to clean up so aggressively.
> 
> What puzzled me was that a normal "rmmod" wouldn't give the
> same symptoms -- but the same codepaths could oops in certain
> system shutdown scenarios.

In an earlier message I wrote that the HC driver couldn't unload so long
as the device usbfs was using held a reference to its bus.  I just did
some checking, and guess what: It can!

I looked at both the UHCI and OHCI drivers.  In their module_exit routines
they call pci_unregister_driver().  Without knowing how the PCI subsystem
works, I would assume this behaves like any other "deregister" routine in
the driver model and returns without waiting for any reference count to go
to 0 -- that's what release callbacks are for.

However, the module_exit routines _don't_ wait for the release callbacks.  
They just go right on ahead and exit.  Result: when the reference count 
eventually does go to 0 (when usbfs drops its last reference), the 
hcd_free routine is no longer present and you get an oops.

The proper fix would be to have each HC driver keep track of how many 
instances are allocated.  The module_exit routine must wait for that 
number to drop to 0 before returning.

Alan Stern

