Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVCaQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVCaQTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCaQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:19:08 -0500
Received: from ida.rowland.org ([192.131.102.52]:4100 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261539AbVCaQS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:18:58 -0500
Date: Thu, 31 Mar 2005 11:18:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503301215510.767-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Patrick Mochel wrote:

> Let me re-phrase that: The driver core will never explicitly take more
> than 1 lock. It will lock a device during calls to the driver routines,
> which the drivers should be aware of when re-entering the driver model via
> those functions.

Okay.

> > You need to formalize the locking rule: Never lock a device while holding
> > one of its descendants' locks.
> 
> That's a good rule, but definitely sub-system specific (like for those
> that re-enter the driver model).

It should be mentioned somewhere in the kerneldoc, maybe near the
declaration of your new device_lock() routine.  You might also want to
mention explicitly that a probe() routine shouldn't call through the
driver core to suspend its device because it would deadlock; it should
simply do the suspend directly.


> > The case I had in mind was adding a new USB device.  The USB core wants to
> > retain control of the device at least through the point where it chooses
> > and sets a new configuration -- otherwise userspace might do so first.
> > We ought to be able to work around this by locking the device after
> > calling device_add() and before usb_create_sysfs_dev_files().  In this
> > case the driver is known a priori.
> 
> How is this a driver model problem if it can be fixed locally?

It isn't a problem.  Forget I brought it up -- if anything ends up going
wrong I'll let you know.


> I agree that there has to be synchronization *while* those calls are being
> made, but that can be solved with the device semaphore. It's held across a
> parent's suspend. If a child device is added then, the request to add it
> should block on that semaphore. It should actually try resume the device,
> which will automatically block, then re-awaken the device once the lock is
> dropped by the suspend process.

> We can lock the parent while adding a child, like I mentioned above. When
> we're adding a child we must make sure that the parent is awakened anyway.

Yes.  I realized this yesterday; drivers or subsystems can use the 
device lock themselves to synchronize addition/removal of children.  
There's no need for the core to do anything special.

In fact, the core had better _not_ try to lock the parent while adding a 
child.  The subsystem may already own the lock!  Should this be made a
general requirement of device_add() -- that the caller must have locked 
the parent?


> I don't like the idea of locking every single child just to check if
> they're suspended. Sounds messy.
> 
> How about we just add a counter to the parent for all of the running (not
> suspended) children. When a child is suspended, this counter is
> decremented. When the counter reaches 0, the parent can suspend. This
> makes the check simple when a parent is directed to suspend.
> 
> We can have the counter modifications block on the semaphore, so if there
> is an update to it while the parent is doing something, it will be queued
> up appropriately. Incrementing this past 0 should automatically resume the
> parent (or at least check that it's resumed). This will guarantee that the
> parent is woken up for any children that are added.
> 
> In fact, we probably want to add a counter to every device for all "open
> connections" so the device doesn't try to automatically sleep while a
> device node is open. Once it reaches 0, we can have it enter a
> pre-configured state, which should save us a bit of power for very little
> pain.

By "open connections", do you mean something more than unsuspended 
children?

Are you proposing to add these counters to struct device?  If so, would 
they be used and maintained by the core or by the driver/subsystem?  I 
should think the core wouldn't know enough about the requirements of 
different devices to do anything useful.  But then if the core doesn't use 
the counters they should be stored in a private data structure, not in 
struct device.

Alan Stern

