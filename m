Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVCaCNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVCaCNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVCaCNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:13:17 -0500
Received: from digitalimplant.org ([64.62.235.95]:37794 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262481AbVCaCM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:12:56 -0500
Date: Wed, 30 Mar 2005 18:12:47 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0503281448190.1185-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.50.0503301215510.767-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503281448190.1185-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Mar 2005, Alan Stern wrote:

> > For now, I'm willing to punt on those and consider them subsystem-specific
> > until more is known about those situations' characteristics. As it
> > currently stands, the core will not lock more than 1 device at a time.
>
> That's absolutely not true.  Whenever a probe() routine registers a new
> device, the core will acquire nested locks.  This happens in a number of
> places.  Likewise when a remove() routine unregisters a child device.

Let me re-phrase that: The driver core will never explicitly take more
than 1 lock. It will lock a device during calls to the driver routines,
which the drivers should be aware of when re-entering the driver model via
those functions.

> You need to formalize the locking rule: Never lock a device while holding
> one of its descendants' locks.

That's a good rule, but definitely sub-system specific (like for those
that re-enter the driver model).

> > If so, what do you want to protect against, suspend/resume? In cases
> > like this, do you still want to do driver probing, or do you know a priori
> > what the driver is?
>
> The case I had in mind was adding a new USB device.  The USB core wants to
> retain control of the device at least through the point where it chooses
> and sets a new configuration -- otherwise userspace might do so first.
> We ought to be able to work around this by locking the device after
> calling device_add() and before usb_create_sysfs_dev_files().  In this
> case the driver is known a priori.

How is this a driver model problem if it can be fixed locally?

> > Are you talking about two different things here? First, what is wrong with
> > children being adding at any time? We can't prevent that.
>
> That's right; your scheme can't prevent it.

I don't see the need nor desire to prevent it. Any device that goes to
sleep automatically should be awakened when it receives a request. If a
bridge/hub/controller goes to sleep and a child device is
inserted/hotplugged, then it should be awakened.

I agree that there has to be synchronization *while* those calls are being
made, but that can be solved with the device semaphore. It's held across a
parent's suspend. If a child device is added then, the request to add it
should block on that semaphore. It should actually try resume the device,
which will automatically block, then re-awaken the device once the lock is
dropped by the suspend process.

> > Secondly, I don't understand the suspend/resume requirement. Perhaps you
> > could elaborate more.
>
> Look at what happens when a driver wants to suspend a device.  If there
> are any unsuspended children it will lead to trouble.  (Note this
> concerns runtime PM only; for system PM we already know that all the
> children are suspended.)  So the driver loops through all the children
> first, making sure each one is already suspended (if not then the suspend
> request must fail).  At the end it knows it can safely suspend the device.
>
> But!  What if another child is added in the interim, so the loop misses
> it?  And there's a related problem: What if one of the existing children
> gets resumed after it was checked but before the parent can be suspended?
>
> The first problem could be solved at the driver level, by using an
> additional private semaphore to block attempts at adding new children.
> On the other hand, if the core always locked the parent while adding a
> child then a separate private semaphore wouldn't be needed.  The driver
> could simply use the pre-existing device->sem.

We can lock the parent while adding a child, like I mentioned above. When
we're adding a child we must make sure that the parent is awakened anyway.

> The second problem can be solved in a couple of ways.  The most obvious is
> for the driver to lock all the children while checking that they are
> already suspended, then unlock all of them after suspending the parent.
> Alternatively the resume pathway could be changed, so that to resume a
> device both it and its parent have to be locked.  (The alternative might
> not work as well in practice, because drivers are likely to resume devices
> on demand directly, without detouring through the core routines.  Even
> if the core was careful always to lock the parent before a resume, drivers
> might not be so careful when bypassing the core.)

I don't like the idea of locking every single child just to check if
they're suspended. Sounds messy.

How about we just add a counter to the parent for all of the running (not
suspended) children. When a child is suspended, this counter is
decremented. When the counter reaches 0, the parent can suspend. This
makes the check simple when a parent is directed to suspend.

We can have the counter modifications block on the semaphore, so if there
is an update to it while the parent is doing something, it will be queued
up appropriately. Incrementing this past 0 should automatically resume the
parent (or at least check that it's resumed). This will guarantee that the
parent is woken up for any children that are added.

In fact, we probably want to add a counter to every device for all "open
connections" so the device doesn't try to automatically sleep while a
device node is open. Once it reaches 0, we can have it enter a
pre-configured state, which should save us a bit of power for very little
pain.


	Pat
