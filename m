Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVC1R6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVC1R6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVC1R5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:57:31 -0500
Received: from digitalimplant.org ([64.62.235.95]:10641 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261971AbVC1Ro7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:44:59 -0500
Date: Mon, 28 Mar 2005 09:44:56 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Mar 2005, Alan Stern wrote:

> Let's move on to consider the new struct device.sem.  You've
> recognized, like other people, that such a thing is necessary to
> protect drivers against simultaneous callbacks.  But things aren't as
> simple as just sticking the semaphore into the structure and acquiring
> it for each callback!  It requires much more careful thought.
>
>     (6)	Your code doesn't solve the race between driver_unregister and
> 	device_add.  What happens if a driver is unregistered at the
> 	same time as it's being probed for a new device?  Maybe I
> 	missed something, but it looks like you might end up with the
> 	device bound to a non-existent driver.  (And what about the
> 	other way 'round, where a device is unregistered at the same
> 	time as it's being probed by a new driver?  That's easier to
> 	get right but I haven't checked it.)

The only race I see is the klist_remove() in bus_remove_driver() racing
with the iteration of the klist in device_attach(). The former will block
until the driver.knode_bus reference count reaches 0, which will happen
when the ->probe() is over and the iteration stops. The klist_remove()
will finish, then each device attached to the driver will be removed.
That's less than ideal, but it should work.

To help that a bit, we could add a get_driver()/put_driver() pair to
__device_attach(), which would prevent the driver from being removed while
we're calling ->probe().

>     (7) Adding lots of semaphores also adds lots of new possibilities
> 	for deadlock.  You haven't provided any rules for locking
> 	multiple semaphores.  Here are a few potentially troublesome
> 	scenarios:
>
> 		A driver being probed for newly-discovered hardware
> 		registers a child device (e.g., a SCSI adapter driver
> 		registers its SCSI host).
>
> 		Autoresume of child device requires the parent to be
> 		resumed as well.
>
> 		During remove a driver wants to suspend or resume its
> 		device.
>
> 	There's also a possibility for deadlock with respect to some
> 	lock private to a subsystem.  Of course such things can't be
> 	solved in the core; the subsystem has to take care of them.

For now, I'm willing to punt on those and consider them subsystem-specific
until more is known about those situations' characteristics. As it
currently stands, the core will not lock more than 1 device at a time.
The subsystems can know that and lock devices appropriately.

>     (8) A subsystem driver might want to retain control over a new
> 	device around the device_add call -- it might want to hold the
> 	device's semaphore itself the whole time.  There need to be
> 	entry points in which the caller holds the necessary
> 	semaphores.

Out of curiosity, why would a subsystem want to do this? Would it be
something like this:

	create device
	lock device
	device_add(dev);
	do other stuff
	unlock device (and let other things happen to it)

? If so, what do you want to protect against, suspend/resume? In cases
like this, do you still want to do driver probing, or do you know a priori
what the driver is?

>     (9) Your scheme doesn't allow any possibility for complete
> 	enumeration of all children of a device; new children can be
> 	added at any time.  So for example, checking that all the
> 	children are suspended (and preventing any from being
> 	resumed!) while suspending a device becomes very difficult.

Are you talking about two different things here? First, what is wrong with
children being adding at any time? We can't prevent that.

Secondly, I don't understand the suspend/resume requirement. Perhaps you
could elaborate more.

> To solve this last problem, my thought has always been that adding a
> device to the list of its parent's children should require holding the
> parent's lock.  There's room for disagreement.  But note that there's
> code in the kernel which does tree-oriented device traversals; by
> locking each node in turn the traversal could be protected against
> unwelcome changes in the device tree.

Holding the lock over the lifetime of the device? Or just for an
operation?

> For proper protection, the USB subsystem requires that the overall
> device be locked during suspend, resume, reset, and Set-Config.  This
> also involves locking the device during any call to a driver callback
> -- but now the struct device being locked is the _parent_ of the one
> bound to the driver (i.e., the interface's parent).
>
> At the moment this locking is handled internally by the subsystem.
> But in one respect it conflicts badly with the operation of the
> driver-model core: when a driver is registered or unregistered.  At
> such times the subsystem isn't in control of which devices are probed
> or unbound.  I ended up "solving" this by adding a second layer of
> locking, which effectively permits _all_ the USB devices to be locked
> during usb_register and usb_deregister.  It's awkward and it would
> benefit from better support from the driver-model core.

> Such support would have to take the form of locking a device's parent
> as well as the device itself, minimally when probing a new driver and
> unbinding a deregistered driver, possibly at other times as well.  As
> far as I know, USB is the only subsystem to require this and it's
> probably something you don't want to do if you don't have to.  I don't
> know what the best answer is.  It was a struggle to get where we are
> now and we only had to worry about locking USB devices; locking the
> interfaces too adds a whole new dimension.

How is this related to (8) above? Do you need some sort of protected,
short path through the core to add the device, but not bind it or add it
to the PM core?

Thanks,


	Pat
