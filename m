Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWJPO7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWJPO7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWJPO7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:59:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56079 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932109AbWJPO73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:59:29 -0400
Date: Mon, 16 Oct 2006 10:59:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
In-Reply-To: <20061016125613.16c9f667@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610161040570.7103-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Cornelia Huck wrote:

> On Mon, 16 Oct 2006 11:13:30 +0200,
> Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
> 
> > There may have been a similar problem with
> > USB locking, since there too probe was expecting a lock to be held that might
> > not be held when called from the kthread:
> > 
> > 	 * This function must be called with @dev->sem held.  When called for a
> > 	 * USB interface, @dev->parent->sem must be held as well.
> > 	 */
> > 	int driver_probe_device(struct device_driver * drv, struct device * dev)
> 
> But as we don't know we're probing an usb interface, we have no chance
> of ensuring that dev->parent->sem is taken in the multithreaded case
> (meaning we couldn't do multithreaded probe for usb).

That's not quite true.  You could acquire dev->parent->sem always, just to
be certain.  However USB shouldn't use this form of multithreaded probing
in any case; it should instead use multiple threads for khubd.

> (Any idea why the
> parent's sem must be taken for usb interfaces?)

It's a peculiarity of the way USB works that some commands (Set
Configuration and port reset) affect the entire device, even though they
may be needed only by a driver for a single interface.  Some interface
drivers do need to issue these commands when they are probed.  The only
safe way to do it is to insure that their probe routines are called with
both the device and the interface semaphores held.

> > Also, what about device removal racing with probe?  Is it possible for someone to
> > attempt to remove a device in the gap between the call to device_attach and the
> > kthread actually running and doing the probe?  That would result in remove and
> > probe being called in the wrong order...
> 
> ->probe won't be called if the device is already being removed,

Because driver_probe_device() checks device_is_registered(dev) before 
doing anything else.

>  but
> that still results in bus->remove being called without a prior ->probe
> (but not drv->probe since dev->driver is not set at that time).

How so?  We shouldn't call bus->remove if a driver isn't bound.

Some other things were left out of the patch.  Since we can no longer know 
whether any drivers will get bound at all, device_attach() should now 
return void.  This means that bus_attach_device() can be simplified and 
should also return void.

Alan Stern

