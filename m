Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263164AbSJHWoi>; Tue, 8 Oct 2002 18:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJHWn4>; Tue, 8 Oct 2002 18:43:56 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20361 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263164AbSJHWnV>; Tue, 8 Oct 2002 18:43:21 -0400
Date: Tue, 8 Oct 2002 17:48:56 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, Patrick Mochel <mochel@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210081510550.1226-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210081726540.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Linus Torvalds wrote:

> Right. But that's a driver bug, and it's because this whole thing is 
> fairly new.
> 
> There aren't that many things that actually play with these things (mainly 
> the PCI and the USB layer, and individual drivers shouldn't care, it's 
> just the bus layer that does all of this), so we should be able to fix the 
> cases cleanly.

It'd be nice if things were so easy, but I don't think so. Of course, 
"struct device" objects are created by the bus drivers, and as such there 
are not that many (currently only PCI, ISAPnP, USB, as you said, but I 
think eventually, we may want to have our representation of IDE, SCSI, 
ISDN, sound, ethernet, whatever there as well).

USB may be modular today, and so are many of the other potential users, so 
we need to deal with that. But it's not only bus drivers, anyway. 
New-style PCI drivers use pci_register_driver, where struct pci_driver 
embeds struct device_driver. And the problems are exactly the same.

Today, we expect that we can kfree(&my_driver_struct) after 
pci_unregister_driver(&my_driver_struct). Actually, the common case is 
rather the my_driver_struct is statically allocated in a module, which 
will be unloaded after pci_unregister_driver() returns, but that's 
basically exactly the same thing.

I'm pretty sure we do not want to change that API to have every driver out 
there specify a destructor for my_driver_struct. It'd be simple, it'd just 
do MOD_DEC_USE_COUNT, though. Except for that this whole thing does not 
work at all then, since we call pci_unregister_driver () from 
module_exit(), which can only be called when the use count is already 
zero.

In addition, even if we went the long way and found a solution for the 
above problem, it still meant that we could only unload the module after 
all references to struct device_driver are gone. Which can take forever 
when someone holds open /driversfs/my_driver/something. That's a DoS we do 
not want to have, either, I think.

I agree with Al Viro, the only sensible solution seems to make struct
device and struct device_driver separately allocated (one could possibly
do the separation and another level, like between struct driver and struct
driverfs_dir_entry, but above seems the cleanest). So they can stay around
long after a module which registered them initially is gone. Of course, we
need to have some mechanism to make sure callbacks into the module are
not made after a certain point, since .text may be gone, or driver
specific part (struct usb_driver), which is why we need some kind of
mark_dead(), which I'd rather call device_unregister(struct device *) /
driver_unregister(struct device_driver *). The actual driverfs object may
still stay around after that point, but its ->priv pointer, which pointed
to the usb_device / usb_driver is invalidated and will not be dereferenced
anymore, neither the callbacks into driver-specific code.

This way, the API for things like PCI device drivers can remain the same,
the API for bus drivers changes slightly, the driver core needs major 
changes, but at least it should work and be safe this way.

--Kai


