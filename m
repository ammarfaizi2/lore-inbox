Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbSJHCMN>; Mon, 7 Oct 2002 22:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJHCMN>; Mon, 7 Oct 2002 22:12:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51861 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262619AbSJHCMM>;
	Mon, 7 Oct 2002 22:12:12 -0400
Date: Mon, 7 Oct 2002 22:17:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210071601050.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210072126380.29030-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Oct 2002, Patrick Mochel wrote:

> 
> > > It's the desctrutor for the device object. ->release() is the last thing 
> > > called when the last reference to the device goes away. That's the only 
> > > time it's called. 
> > 
> > ???
> > 
> > Details, please.  When can it happen and what normally holds that object
> > pinned?
> 
> get_device()/put_device(). When struct device::refcount hits 0, it's 
> cleaned up. c.f. drivers/base/core.c::put_device(). 
> 
> The bus type that the device belongs to always owns it, and could easily
> be put in struct bus_type. Basically, it tells the bus that it's finally
> ok to free the structure. That's not done by the driver core, since the 
> struct device is (so far) always embedded in a bus-specific structure. 
> 
> Thoughts? Suggestions?

Lots and almost none of them printable.

_ALL_ buses that have driverfs support (IDE, SCSI, USB, PCI) have their
own rules for lifetimes of their structures.  And that's not likely to
change - these objects belong to drivers and in some cases (IDE) are
not even allocated dynamically - they are reused if nothing is holding
them.

Note that all cases I've mentioned have oopsable races in the situations
when somebody keeps a reference to driverfs object longer than driver
keeps the object it's embedded into (in case of IDE you have no put_device()
calls at all, so there you happily re-register same node again and again).

Situation is very different from that for filesystems - there you have no
own lifetime rules for private part of inode; everything is controlled by
VFS.

I don't believe that you can massage the code in drivers into form where
freeing objects would be controlled by driverfs (and it's not just a matter
of postponing kfree(); if driverfs methods want to access something else,
they'll need that something also preserved).  Feel free to prove me wrong,
but I'll believe it when I see it.  Notice that ->release() has nothing
to any possible solution - the problem happens when we _don't_ call it
for too long (== retain reference after driver had dropped its own).
We'll need either "wait until all remaining references are gone" or "make sure
that no new references are about to appear and check reference counts of all
my nodes" - we need _some_ way for driver to decide when it's safe to get rid
of data structures.

Alternatively, we could go for separate allocation of struct device and
try to reduce the area where driverfs needs something beyond the contents
of struct device.  Then we could simply take rwsem around it - exclusive
around "remove that node" and shared around every other area.  Then drivers
would need to call something like
	device_gone(dev);
	put_device(dev);
with device_gone() doing
	down_write(&dev->sem);
	dev->dead = 1;
	up_write(&dev->sem);
and all other accesses to the guts would do
	down_read(&dev->sem);
	if (!dev->dead)
		...
	up_read(&dev->sem);
- all the while holding a reference to dev, obviously.

I think that it's easier than messing with lifetime rules for driver objects;
whether we can tolerate overhead or not is a different question.  It certainly
appears to have lower fuckup potential.

As it is, driverfs code has oopsable races for every bus that has driverfs
support, so something has to be done.  Comments?

Al, liking driverfs less and less...

