Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280933AbRKOQdV>; Thu, 15 Nov 2001 11:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280937AbRKOQdM>; Thu, 15 Nov 2001 11:33:12 -0500
Received: from air-1.osdl.org ([65.201.151.5]:3478 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S280933AbRKOQcz>;
	Thu, 15 Nov 2001 11:32:55 -0500
Date: Thu, 15 Nov 2001 08:35:12 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] races in access to pci_devices
In-Reply-To: <3BF37CA6.92CA12E7@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111150754140.21985-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Nov 2001, Andrew Morton wrote:

> Jeff Garzik wrote:
> >
> > I haven't looked at it in over a year, but from a quick look, all the
> > list access look like they can be protected by a simple spinlock.
>
> I don't think so?   We do things like calling driver probe methods
> in the middle of a driver list walk.

That's true. However, ->probe() and the rest of the struct pci_driver
methods are all called from the PCI layer. It seems that a per-device
rwsem would could protect competing calls from screwing things up (a
->remove() call during a ->probe() call).

> An rwsem _may_ be suitable, but I'm not sure that we don't do
> a nested walk in some circumstances, and AFAIK our rwsems
> still are not safe for the same thread to do a down_read() twice.

If the device was locked by the PCI layer before all calls down to the
driver, and it was documented in BIG bold letters, this _should_ prevent
drivers from doing silly things like locking itself again, right? ;)

> Then there's the bus list, and the order of its lock wrt the device
> list.
>
> One approach would be to use a spinlock and a per-device refcount.
> So something like:

It seems as though having two lists of devices complicates things quite a
bit. I was looking into trying to obviate the need for a global device
list yesterday, but it seems painful at best (and probably worthy of
another thread).

Suppose you didn't have a global device list, but you had a global bus
list (including all subordinate buses).

Could you do:

	struct pci_bus * bus;
	struct pci_dev * dev;

	for_each_bus(bus) {
		down_read(&bus->lock);
		for_each_child(bus,dev) {
			down_read(&dev->lock);
			dev->driver->foo();
			up_read(&dev->lock);
		}
		up_read(&bus->lock);
	}

[snip]

I started to implement proper locking for the new driver model a couple of
days ago. So, far it only touches the top-level device tree, but attempts
to deal with the same class of problems. (Though, I won't assert that it
is even close to the best solution).

The simple cases I've touched so far are registering and unregistering
devices in the tree. I don't want a device to be unregistered before its
completely done registering, and I don't want two register calls to stomp
on the same parent's list of children.

So, I do something like:

device_reigster(struct device * dev)
{
	down_write(&dev->lock);
	...
	down_write(&parent->lock);
	list_add_tail(&dev->node,&parent->devices);
	up_write(&parent->lock);
	...
	up_write(&dev->lock);
}

Is this right, or is there something better?

> I _think_ all this list traversal happens in process context now.
> Not sure about the PCI hotplug driver though.
>
> It's really sticky.  Which is why it isn't fixed :(
>
> Sigh.  Maybe go for an rwsem in 2.5, backport when it stops
> deadlocking?

I am more than willing to work on this, as I have a strong interest in
getting this right for the global device tree (just point me in the right
direction..)

	-pat

