Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSJHSg6>; Tue, 8 Oct 2002 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSJHSg6>; Tue, 8 Oct 2002 14:36:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55465 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261439AbSJHSgJ>;
	Tue, 8 Oct 2002 14:36:09 -0400
Date: Tue, 8 Oct 2002 11:43:29 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: torvalds@transmeta.com, <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.GSO.4.21.0210072126380.29030-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210081005320.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh fun. 

> _ALL_ buses that have driverfs support (IDE, SCSI, USB, PCI) have their
> own rules for lifetimes of their structures.  And that's not likely to
> change - these objects belong to drivers and in some cases (IDE) are
> not even allocated dynamically - they are reused if nothing is holding
> them.

The problem only exists when a device is hotpluggable. And, if a device is
hotpluggable, the controlling bus should dynamically allocate the
structures for that device. Anything else seems buggy. Regardless of 
driver model structures, it seems there is an implicit race between 
removing a device, cleaning up that structure, and inserting a new device. 

> Note that all cases I've mentioned have oopsable races in the situations
> when somebody keeps a reference to driverfs object longer than driver
> keeps the object it's embedded into (in case of IDE you have no put_device()
> calls at all, so there you happily re-register same node again and again).

The absence of put_device() in IDE is a bug. 

> Situation is very different from that for filesystems - there you have no
> own lifetime rules for private part of inode; everything is controlled by
> VFS.
> 
> I don't believe that you can massage the code in drivers into form where
> freeing objects would be controlled by driverfs (and it's not just a matter
> of postponing kfree(); if driverfs methods want to access something else,
> they'll need that something also preserved).  Feel free to prove me wrong,

The driver core is not controlling the lifetime of the objects. It's 
managing the reference counts on the shared objects. It's still the 
allocator that frees the device. It just can't do it whenever it wants, 
because it's shared and may be accessed by other entities. The release() 
method is the notification that it's kosher to do so. 

[ Note that I'm not trying to be a smart ass. I know you have much more 
experience with this stuff; I'm just trying to grasp all the angles. ]

> but I'll believe it when I see it.  Notice that ->release() has nothing
> to any possible solution - the problem happens when we _don't_ call it
> for too long (== retain reference after driver had dropped its own).

The only timing issue is when the device structures are reused. And, it 
seems that that is inherently racy anyway with hotpluggable devices. 

> We'll need either "wait until all remaining references are gone" or "make sure
> that no new references are about to appear and check reference counts of all
> my nodes" - we need _some_ way for driver to decide when it's safe to get rid
> of data structures.
> 
> Alternatively, we could go for separate allocation of struct device and
> try to reduce the area where driverfs needs something beyond the contents
> of struct device.  Then we could simply take rwsem around it - exclusive
> around "remove that node" and shared around every other area.  Then drivers
> would need to call something like
> 	device_gone(dev);
> 	put_device(dev);
> with device_gone() doing
> 	down_write(&dev->sem);
> 	dev->dead = 1;
> 	up_write(&dev->sem);
> and all other accesses to the guts would do
> 	down_read(&dev->sem);
> 	if (!dev->dead)
> 		...
> 	up_read(&dev->sem);
> - all the while holding a reference to dev, obviously.

I agree that we need some sort of device_unregister() (or device_gone()),
which could also detach the device from the bus and driver it belongs to,
and remove the driverfs entries. This would prevent it from gaining any
new references before the remaining extant references went away. I'll also
modify driverfs to do get()/put() in read(2) and write(2), instead of
open(2) and close(2).

I don't see how dynamically allocating the device structures is
necessarily going to help. It seems that it would be a step backwards from
what we currently have. We'll still need reference counting on the
bus-specific objects, and separate handlers for them, to decide when its
ok to free them (since someone could independently be holding a reference
to a bus object when the device goes away). 

struct device was an attempt to consolidate the constructs and methods to
deal with them. The easiest way to do this is to embed the generic object
in the bus-specific object. Do you see anyway to make this work?

Thanks,

	-pat


