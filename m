Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTFPRkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTFPRkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:40:42 -0400
Received: from ida.rowland.org ([192.131.102.52]:46852 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263279AbTFPRkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:40:41 -0400
Date: Mon, 16 Jun 2003 13:54:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Russell King <rmk@arm.linux.org.uk>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030616182003.D13312@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L0.0306161349360.1350-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Russell King wrote:

> On Mon, Jun 16, 2003 at 10:08:26AM -0700, Greg KH wrote:
> > Then don't let your module unload until _all_ instances of your
> > structures are gone.  You can tell if this is true or not, it's just up
> > to the implementor :)
> 
> Greg, I believe Alan does have a valid concern.  Eg, how is the following
> handled?
> 
> - PCI device driver module is loaded
> - device driver gets handed a pci device
> - device driver attaches a file to the struct device corresponding to the
>   PCI device.
> - userspace opens new file (this does not increment the device drivers
>   use count.)
> - device driver is rmmod'd
> - device driver removes its references to the pci device
> - device driver unloads
> - user reads from opened file.

Thank you, that was exactly my point.  Opening the file increments the 
device's refcount but not the driver's.

> > Look at the new pcmcia code for just such an example.
> 
> In the pcmcia case, we effectively own the object (class device) we're
> attaching the files to, so we can ensure that the module is not unloaded
> until the class device files are closed and all references to the object
> are gone.
> 
> IMO, if you don't own the object (and therefore don't know its lifetime),
> you shouldn't be adding sysfs or device model attributes of any kind to
> that object.

That's not practical.  How else can a device driver provide 
device-specific configuration options or information in sysfs?  In many 
cases the device is owned by the bus, not the device driver.

By the way, both the EHCI and OHCI host controller drivers do this.  It's 
easy to cause an oops by delaying a read of (for example) the "periodic" 
file they create until after the driver is unloaded.

Alan Stern

