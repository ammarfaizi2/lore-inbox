Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSHOQfw>; Thu, 15 Aug 2002 12:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHOQfw>; Thu, 15 Aug 2002 12:35:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24792 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317191AbSHOQfu>;
	Thu, 15 Aug 2002 12:35:50 -0400
Date: Thu, 15 Aug 2002 09:44:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Adam Belay <ambx1@netscape.net>
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: Re: driverfs: [PATCH] remove bus and improve driver management
 (2.5.30)
In-Reply-To: <3D5B885E.5000407@netscape.net>
Message-ID: <Pine.LNX.4.44.0208150915380.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> a possibility for my tree when drivers that need it convert to my 
> changes  and the driver model in general:
> /driverfs/driver/
> /driverfs/driver/pci
> /driverfs/driver/pci/agpgart
> /driverfs/driver/pci/cardbus
> /driverfs/driver/pci/parport_pc
> /driverfs/driver/pci/parport_pc/lp
> /driverfs/driver/pci/usb
> /driverfs/driver/pci/usb/hid
> 
> * I am not saying that usb has to be done this way but if you notice in 
> the first diagram (the old implementation) usb does not have any driver 
> representation with pci or if it does it is not displayed.  The lp 
> driver is significant because it is imposible to cleanly implement 3 
> levels of drivers in the current Driver Model.

You're missing the point of the bus driver structure. It is simply there 
to group all the devices on all the instances of that particular bus in 
the system. It doesn't care about hierarchy, and what you're doing makes 
absolutely no sense in anything but a typical PC:

- Not all PCI bridges are Host/PCI bridges. They may exist on some other 
  proprietary bus. 

- In some embedded systems, USB controllers are sometimes root devices

- There are such things as PCI->Cardbus->USB->PCI bridge device 
  pathologies

AFAICT, your model assumes that there is only one bus of each type in the 
system, and the hierarchical relationship always holds. It doesn't. And, 
in order to get the relationship right, it seems way more complicated than 
what exists now. 


You're also missing the distinction between bus drivers and device 
drivers. Device drivers control a particular device. This includes bridge 
devices from one bus type to another, like USB host controllers. These are 
currently represented in the current model:

[mochel@cherise mochel]$ tree -d /sys/bus/pci/
/sys/bus/pci/
|-- devices
|   |-- 00:00.0 -> ../../../root/pci0/00:00.0
|   |-- 00:01.0 -> ../../../root/pci0/00:01.0
|   |-- 00:02.0 -> ../../../root/pci0/00:02.0
|   |-- 00:1e.0 -> ../../../root/pci0/00:1e.0
|   |-- 00:1f.0 -> ../../../root/pci0/00:1f.0
|   |-- 00:1f.1 -> ../../../root/pci0/00:1f.1
|   |-- 00:1f.2 -> ../../../root/pci0/00:1f.2
|   |-- 00:1f.3 -> ../../../root/pci0/00:1f.3
|   |-- 00:1f.5 -> ../../../root/pci0/00:1f.5
|   |-- 01:00.0 -> ../../../root/pci0/00:01.0/01:00.0
|   |-- 02:1f.0 -> ../../../root/pci0/00:02.0/02:1f.0
|   |-- 03:00.0 -> ../../../root/pci0/00:02.0/02:1f.0/03:00.0
|   `-- 04:04.0 -> ../../../root/pci0/00:1e.0/04:04.0
`-- drivers
    |-- Intel ICH
    |-- Intel ICH Joystick
    |-- agpgart
    |-- e100
    |-- matroxfb
    |-- serial
    `-- uhci-hcd
        ^^^^^^^^

Note also the above. The symlinks have every PCI device on every PCI bus 
(all 3 of them) in my system, in a flat namespace. It also has every PCI 
driver in a flat namespace. As you can see in device_attach() and 
driver_attach(), we exploit these flat namespaces to bind drivers to 
devices, regardless of wherever the device resides.

That's it. Nothing fancy, and completely agnostic of where we found a 
particular bus. 


As far as the lp driver goes: fix it. It's been on my list for sometime, 
but I havne't had a chance to get to it. But, I'm not going to change the 
driver model to special case legacy devices. 

>     As you can now see in my new diagrams the problem I am trying to 
> solve is not how devices are represented but rather how drivers are 
> represented.  Sorry I wasn't clear.  I have completely removed bus and 
> replaced it with a driver interface.  This is better because a bus does 
> not deserve special implementations as it is a driver too.  My more 
> scaleable interface can handle both buses and drivers.

But, that's a _bad_ thing. Bus drivers and device drivers are completely 
separate entities, with completely separate semantics. Why munge them 
together? That only convolutes the model and the code. 

> >>   `This patch also provides user level driver management support 
> >>through the advanced features of the new interface.  It creates a file 
> >>entry named "driver" for each device.
> >>To attach a driver simply echo the name of the driver you want to 
> >>attach.  For example:
> >>#cd ./root/pci0/00:00.0
> >>#echo "agpgart" > driver

man 8 modprobe

> This feature is well designed, if a driver doesn't want to bind to the 
> device the request will fail.  Check the code yourself.  This is simply 
> a userspace override for the Driver Model.  This is useful because it 
> provides the user with more control over driver management.  If two 
> drivers can support the same device and the driver model selects one the 
> user doesn't want to use the user can change it.  This could even happen 
> now with ALSA and Open Sound.  Since it calls both probe and match it is 
> also a great debugging tool.  I'm currently working on a user level 
> utility that will take full advantage of this and other driver 
> management features.

man 5 modules.conf

> >>To remove a driver simply echo remove to the driver file while a driver 
> >>is loaded.  For example:
> >>#echo "remove" > driver

man 8 rmmod

> >>If you read the driver file you will get the name of the loaded driver 
> >>if a driver is loaded.  For example:
> >>#cat driver
> >>output: agpgart
> >>
> >
> >Now this is a nice idea.  But I was thinking of moving the symlink from
> >the bus/pci/devices to be under the specific driver in
> >bus/pci/drivers/foo_driver.  That would show you at a simple glance
> >which driver is bound to which device.  But putting the name in the
> >device entry in the /root tree would be good enough too.

I've been meaning to do both for sometime. I'll consider a patch that does 
that (and just that).

	-pat

