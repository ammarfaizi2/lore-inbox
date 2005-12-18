Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965301AbVLRXLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbVLRXLx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 18:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVLRXLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 18:11:52 -0500
Received: from mx1.rowland.org ([192.131.102.7]:19723 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S965301AbVLRXLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 18:11:52 -0500
Date: Sun, 18 Dec 2005 18:11:48 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
In-Reply-To: <200512181258.47030.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0512181759480.26925-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2005, David Brownell wrote:

> > It's never been mandatory so far for all drivers of all connected
> > devices to have a suspend method... didn't we decide back then that
> > disconneting those was the right way to go ?
> 
> Right, but the system never stopped self-deadlocking when we did the
> disconnect at suspend time.  My notes say "driver core suspend()
> calls are made with dev->sem held, so usb_driver_release_interface()
> always deadlocks when they try to claim the same lock" and presumably
> that's still true.
> 
> I guess I didn't realize the consequence of not fixing that as part
> of the other PM updates, once I found that the "most natural" fix
> was (still?) not possible.

There hasn't been a lot of discussion about this.  You know, it probably 
wouldn't be all that hard to add an entry point in the driver core for 
unbinding drivers while the caller holds dev->sem.  In fact, such a 
routine already exists (__device_release_driver) but it's not exported.

There is the little problem that when a USB driver is unbound from an
interface, the USB device's semaphore is supposed to be locked as well as
the interface's.  Fortunately, I think the only driver for which this
matters is the hub driver, which _does_ have a suspend method.


> > Any reason we are rejecting the sleep process for these currently ? A
> > locking issue that makes disconnecting not yet feasible ? What changed
> > from the previous version where that worked ?
> 
> The current kernels tighten up the suspend processing and offloaded lots
> of stuff to the driver core.  Previous kernels didn't have code that
> could care about such stuff, at least without USB_SUSPEND enabled.

The way the failures actually occur is a little bizarre.  You would think
that things would go wrong as soon as the suspend method is found to be
missing.  But that's not what happens.  For some reason the suspend call
_succeeds_, but doesn't mark the interface as actually suspended.  Then
later on, when the whole USB device is getting suspended, usbcore sees
that there's still an active interface and fails the call.

> So the issue is now how to handle this error case.  I think it should
> be possible to just mark the device as disconnected right as soon as
> we notice it can't be suspended; resume processing will do the work,
> it already does so for real disconnect.  And disconnect paths in USB
> drivers are now pretty solid.

Do you think that might be a little drastic?  Disconnect an entire device 
just because one of its interfaces can't be suspended?

Admittedly, we haven't run across very many composite devices with 
independent drivers for various interfaces...  But still, the principle 
isn't good.

Alan Stern

