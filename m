Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVCaTtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVCaTtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCaTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:49:47 -0500
Received: from ida.rowland.org ([192.131.102.52]:21252 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261677AbVCaTtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:49:41 -0500
Date: Thu, 31 Mar 2005 14:49:40 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503311000510.7249-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0503311431390.1927-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Patrick Mochel wrote:

> > > > 	Whenever usb_register() in the USB core calls driver_register()
> > > > 	and the call filters down to driver_attach(), that routine
> > > > 	should lock dev->parent->sem before calling driver_probe_device()
> > > > 	(and unlock it afterward, of course).

> > > Why can't you just lock it in ->probe() and ->remove() yourself?
> >
> > Aha!  There you go...  This explains why you need explicit locking rules.
> >
> > When probe() and remove() are called, the driver-model core already owns
> > the device's lock.  If the driver then tried to lock the parent, it would
> > mean acquiring locks in the wrong order.  This could easily lead to
> > deadlock.
> 
> I should have been more clear. From what I understand, when some devices
> are probed they also want to probe and add their children. It *seems* like
> this is essentially true with USB devices and interfaces, though I could
> be wrong.

For USB devices and their interfaces that's generally wrong.  But it is 
right for lots of other devices (including USB host controllers).

> What I meant was that when the parent device's ->probe() method is called,
> the parent's semaphore could be taken before the children are discovered
> and added. This would keep the parent locked while all the fiddling is
> going on with the children. Right?

The parent's semaphore _would_ be taken before its probe() method is
called and the children are discovered, since the semaphore is held during
every driver callback.  However that's not what I was getting at above.

The problem with USB comes in at the level of drivers for interfaces.  
Occasionally these drivers need to do something during their probe() that
affects the entire USB device (as opposed to just their interface), such
as resetting the device.  For this to work safely it requires that the
driver own the lock for the entire device, not just the lock for the
interface.

Often this works out okay because the driver's probe() is called when the
interface is registered by the USB core.  At that time the core already
owns the device lock, so driver->probe() inherits the lock.

The problem arises when driver->probe() is called because the driver was
just insmod'ed.  At such times the USB core does not own any locks on any
USB devices.  The only way for driver->probe() to inherit the device lock
is for the driver-model core to acquire it beforehand -- it's not possible
for the USB core or the driver to lock the device.  That's why I asked for
driver_attach() to lock dev->parent->sem around the call to
driver_probe_device().

Alan Stern

