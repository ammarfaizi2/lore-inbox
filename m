Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVCZQxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVCZQxs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCZQxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:53:47 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59399 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S261174AbVCZQxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:53:39 -0500
Date: Sat, 26 Mar 2005 11:53:38 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: klists and struct device semaphores
Message-ID: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat:

Your recent series of driver model patches naturally divides up into
two parts: those involved with implementing and using klists, and
those involved with adding a semaphore to struct device.  Let's
consider these parts separately.

The klist stuff embodies a good idea: safe traversal of lists while
nodes are added and removed.  Your klist library is intended for
generic use and hence it necessarily is not tightly integrated with
the data type of the list objects.  This can lead to problems, as
discussed below.  I'll start with the least important issues and work
up to some big ones.

    (1)	Your structures contain more fields than I would have used.
	klist_node.n_klist isn't really needed; it only gets used
	when removing a klist_node from a klist, and at such times
	the caller could easily pass the klist directly.  Also,
	klist_iter.i_head isn't needed because it's easily derivable
	from klist_iter.i_klist.  (Doesn't really matter because
	there never are very many iterators in existence.)

    (2)	Likewise I'm not so sure about klist_node.n_removed.  Waiting
	for removal operations to complete is generally a bad idea;
	in the driver-model core it's important only when deregistering
	a driver.  The only other scenario I can think of where you
	would need to wait is when you remove an object from a klist
	and then want to put it on another (see also (5)).  While this
	might be necessary for general-purpose usage, the driver-model
	core doesn't do it.  It also means that moving an object from
	one klist to another can't be carried out in_interrupt.  (Not
	to mention you're adding a lot of struct completions all over
	the place, most of which shouldn't need to be used.)

    (3)	Your iteratators don't allow for some simple optimizations.
	For example, a bus's driver<->device matching routine should
	be able to run while retaining the klist's spinlock.

    (4)	You don't have any way of marking klist_nodes that have been
	removed from their klist.  So an iterator will return these
	nodes instead of skipping right past them, as one would expect.
	This can have unpleasant consequences, such as probing a new
	device against a driver that has been unregistered.  The
	klist_node's container will be forced to have its own "deleted"
	marker, and callers will have to skip deleted entries by hand.

    (5)	Most importantly, klist_nodes aren't protected against their
	containers being deallocated.  Or rather, the way in which
	you've set up the protection is inappropriate.  Right now
	you force a caller to wait until list-removal is complete,
	and only later is it allowed to deallocate the container
	object.  This is a violation of the principles underlying the
	reference-counting approach; instead a klist_node should take
	a reference to its container.  But your generic library-based
	approach doesn't allow that, at least, not without some
	awkward coding.  This also means that iterating through a
	klist requires acquiring and releasing two references at each
	step: one for the klist_node and one for the container.

Some of these weaknesses are unavoidable (they're also present in the
outline Dmitry proposed).


Let's move on to consider the new struct device.sem.  You've
recognized, like other people, that such a thing is necessary to
protect drivers against simultaneous callbacks.  But things aren't as
simple as just sticking the semaphore into the structure and acquiring
it for each callback!  It requires much more careful thought.

    (6)	Your code doesn't solve the race between driver_unregister and
	device_add.  What happens if a driver is unregistered at the
	same time as it's being probed for a new device?  Maybe I
	missed something, but it looks like you might end up with the
	device bound to a non-existent driver.  (And what about the
	other way 'round, where a device is unregistered at the same
	time as it's being probed by a new driver?  That's easier to
	get right but I haven't checked it.)

    (7)	Adding lots of semaphores also adds lots of new possibilities
	for deadlock.  You haven't provided any rules for locking
	multiple semaphores.  Here are a few potentially troublesome
	scenarios:

		A driver being probed for newly-discovered hardware
		registers a child device (e.g., a SCSI adapter driver
		registers its SCSI host).

		Autoresume of child device requires the parent to be
		resumed as well.

		During remove a driver wants to suspend or resume its
		device.

	There's also a possibility for deadlock with respect to some
	lock private to a subsystem.  Of course such things can't be
	solved in the core; the subsystem has to take care of them.

    (8)	A subsystem driver might want to retain control over a new
	device around the device_add call -- it might want to hold the
	device's semaphore itself the whole time.  There need to be
	entry points in which the caller holds the necessary
	semaphores.

    (9)	Your scheme doesn't allow any possibility for complete
	enumeration of all children of a device; new children can be
	added at any time.  So for example, checking that all the
	children are suspended (and preventing any from being
	resumed!) while suspending a device becomes very difficult.

To solve this last problem, my thought has always been that adding a
device to the list of its parent's children should require holding the
parent's lock.  There's room for disagreement.  But note that there's
code in the kernel which does tree-oriented device traversals; by
locking each node in turn the traversal could be protected against
unwelcome changes in the device tree.


The final issue I have is more complex; it has to do with the peculiar
requirements of the USB subsystem.  In case you're not familiar with
the details of how USB works (and for the benefit of anyone else
reading this message), here's a capsule description:

A USB device can have multiple functional units, called "interfaces"
for some strange unknown reason.  It's the interfaces that do the
actual work; each one gets its own struct device (in addition to the
struct device allocated for the USB device itself) and its own driver.
While most actions are local to a single interface, there are a few
that affect the entire device including all the interfaces.  The most
obvious ones are suspend, resume, and device-reset.  More important
and harder to deal with is the Set-Configuration command, which
destroys all the current interfaces and creates a whole set of new
ones.

For proper protection, the USB subsystem requires that the overall
device be locked during suspend, resume, reset, and Set-Config.  This
also involves locking the device during any call to a driver callback
-- but now the struct device being locked is the _parent_ of the one
bound to the driver (i.e., the interface's parent).

At the moment this locking is handled internally by the subsystem.
But in one respect it conflicts badly with the operation of the
driver-model core: when a driver is registered or unregistered.  At
such times the subsystem isn't in control of which devices are probed
or unbound.  I ended up "solving" this by adding a second layer of
locking, which effectively permits _all_ the USB devices to be locked
during usb_register and usb_deregister.  It's awkward and it would
benefit from better support from the driver-model core.

Such support would have to take the form of locking a device's parent
as well as the device itself, minimally when probing a new driver and
unbinding a deregistered driver, possibly at other times as well.  As
far as I know, USB is the only subsystem to require this and it's
probably something you don't want to do if you don't have to.  I don't
know what the best answer is.  It was a struggle to get where we are
now and we only had to worry about locking USB devices; locking the
interfaces too adds a whole new dimension.

Alan Stern

