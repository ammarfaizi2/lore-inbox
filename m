Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVC1V67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVC1V67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 16:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVC1V67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 16:58:59 -0500
Received: from ida.rowland.org ([192.131.102.52]:10244 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262087AbVC1V6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 16:58:51 -0500
Date: Mon, 28 Mar 2005 16:58:49 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0503281448190.1185-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Patrick Mochel wrote:

> The only race I see is the klist_remove() in bus_remove_driver() racing
> with the iteration of the klist in device_attach(). The former will block
> until the driver.knode_bus reference count reaches 0, which will happen
> when the ->probe() is over and the iteration stops. The klist_remove()
> will finish, then each device attached to the driver will be removed.
> That's less than ideal, but it should work.

You're right.  Instead of a race that needs to be resolved, you have a
potential for an extra sleep in bus_remove_driver().  It's not a problem.


> >     (7) Adding lots of semaphores also adds lots of new possibilities
> > 	for deadlock.  You haven't provided any rules for locking
> > 	multiple semaphores.  Here are a few potentially troublesome
> > 	scenarios:

> For now, I'm willing to punt on those and consider them subsystem-specific
> until more is known about those situations' characteristics. As it
> currently stands, the core will not lock more than 1 device at a time.

That's absolutely not true.  Whenever a probe() routine registers a new 
device, the core will acquire nested locks.  This happens in a number of 
places.  Likewise when a remove() routine unregisters a child device.

You need to formalize the locking rule: Never lock a device while holding 
one of its descendants' locks.


> >     (8) A subsystem driver might want to retain control over a new
> > 	device around the device_add call -- it might want to hold the
> > 	device's semaphore itself the whole time.  There need to be
> > 	entry points in which the caller holds the necessary
> > 	semaphores.
> 
> Out of curiosity, why would a subsystem want to do this? Would it be
> something like this:
> 
> 	create device
> 	lock device
> 	device_add(dev);
> 	do other stuff
> 	unlock device (and let other things happen to it)
> 
> ?

Yes, that's what I meant.

> If so, what do you want to protect against, suspend/resume? In cases
> like this, do you still want to do driver probing, or do you know a priori
> what the driver is?

The case I had in mind was adding a new USB device.  The USB core wants to
retain control of the device at least through the point where it chooses
and sets a new configuration -- otherwise userspace might do so first.  
We ought to be able to work around this by locking the device after
calling device_add() and before usb_create_sysfs_dev_files().  In this
case the driver is known a priori.


> >     (9) Your scheme doesn't allow any possibility for complete
> > 	enumeration of all children of a device; new children can be
> > 	added at any time.  So for example, checking that all the
> > 	children are suspended (and preventing any from being
> > 	resumed!) while suspending a device becomes very difficult.
> 
> Are you talking about two different things here? First, what is wrong with
> children being adding at any time? We can't prevent that.

That's right; your scheme can't prevent it.

> Secondly, I don't understand the suspend/resume requirement. Perhaps you
> could elaborate more.

Look at what happens when a driver wants to suspend a device.  If there
are any unsuspended children it will lead to trouble.  (Note this
concerns runtime PM only; for system PM we already know that all the
children are suspended.)  So the driver loops through all the children
first, making sure each one is already suspended (if not then the suspend
request must fail).  At the end it knows it can safely suspend the device.

But!  What if another child is added in the interim, so the loop misses
it?  And there's a related problem: What if one of the existing children
gets resumed after it was checked but before the parent can be suspended?

The first problem could be solved at the driver level, by using an
additional private semaphore to block attempts at adding new children.  
On the other hand, if the core always locked the parent while adding a
child then a separate private semaphore wouldn't be needed.  The driver 
could simply use the pre-existing device->sem.

The second problem can be solved in a couple of ways.  The most obvious is
for the driver to lock all the children while checking that they are
already suspended, then unlock all of them after suspending the parent.
Alternatively the resume pathway could be changed, so that to resume a
device both it and its parent have to be locked.  (The alternative might
not work as well in practice, because drivers are likely to resume devices
on demand directly, without detouring through the core routines.  Even 
if the core was careful always to lock the parent before a resume, drivers 
might not be so careful when bypassing the core.)


> > To solve this last problem, my thought has always been that adding a
> > device to the list of its parent's children should require holding the
> > parent's lock.  There's room for disagreement.  But note that there's
> > code in the kernel which does tree-oriented device traversals; by
> > locking each node in turn the traversal could be protected against
> > unwelcome changes in the device tree.
> 
> Holding the lock over the lifetime of the device? Or just for an
> operation?

Just for the time it takes to iterate through the traversal.


> > For proper protection, the USB subsystem requires that the overall
> > device be locked during suspend, resume, reset, and Set-Config.  This
> > also involves locking the device during any call to a driver callback
> > -- but now the struct device being locked is the _parent_ of the one
> > bound to the driver (i.e., the interface's parent).
> >
> > At the moment this locking is handled internally by the subsystem.
> > But in one respect it conflicts badly with the operation of the
> > driver-model core: when a driver is registered or unregistered.  At
> > such times the subsystem isn't in control of which devices are probed
> > or unbound.  I ended up "solving" this by adding a second layer of
> > locking, which effectively permits _all_ the USB devices to be locked
> > during usb_register and usb_deregister.  It's awkward and it would
> > benefit from better support from the driver-model core.
> 
> > Such support would have to take the form of locking a device's parent
> > as well as the device itself, minimally when probing a new driver and
> > unbinding a deregistered driver, possibly at other times as well.  As
> > far as I know, USB is the only subsystem to require this and it's
> > probably something you don't want to do if you don't have to.  I don't
> > know what the best answer is.  It was a struggle to get where we are
> > now and we only had to worry about locking USB devices; locking the
> > interfaces too adds a whole new dimension.
> 
> How is this related to (8) above? Do you need some sort of protected,
> short path through the core to add the device, but not bind it or add it
> to the PM core?

At this point I'm not clear on exactly what's needed.  I'll have to get 
back to you on this; more thought is required.  Maybe David will have 
some ideas to contribute as well.

Alan Stern

