Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315932AbSEGSdN>; Tue, 7 May 2002 14:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315935AbSEGSdL>; Tue, 7 May 2002 14:33:11 -0400
Received: from air-2.osdl.org ([65.201.151.6]:11663 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S315932AbSEGSdD>;
	Tue, 7 May 2002 14:33:03 -0400
Date: Tue, 7 May 2002 11:29:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <20020507171946.29430@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.33.0205071053070.6307-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 May 2002 benh@kernel.crashing.org wrote:

> >	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> >
> >and it wouldn't be impossible (or even necessarily very hard) to make an
> >IDE controller export the "IDE device tree" the same way a USB controller
> >now exports the "USB device tree".
> >
> >For things like hotplug etc, I think driverfs is eventually the only way
> >to go, simply because it gives you the full (and unambiguous) path to
> >_any_ device, and is completely bus-agnostic.
> >
> >But there is definitely a potential backwards-compatibility-issue.
> 
> One interesting thing here would be to have some optional link between
> the bus-oriented device tree and the function-oriented tree (ie. devfs
> or simply /dev). For example, an IDE node in driverfs could eventually
> hold symlinks to the entries it provides in /dev when using devfs (or
> just provide major/minor when not using devfs).

I agree with such a concept, but as Linus said, it should go the other 
way, from the functional interface to physical interface. There are many 
details involved in doing such a thing, but it should work something like 
this:

The logical subystems (ide disks, networking, etc) would register with the 
device model core and get a directory in driverfs:

/driverfs/class/ide/

Devices would be discovered and get a driverfs directory representing the 
physical location of the device:

/driverfs/root/pci0/07.2/

Note that no drivers have been bound to the device. When the driver is 
bound, it registers the device with the subsystem, passing in a 
subsystem-specific structure. These can be made to point in some way to 
the generic struct device of the device (from which the physical path can 
be inferred).

When this happens, the subsystem creates a directory underneath its 
driverfs directory, so you get:

/driverfs/class/ide/0/

And, a symlink is created to point to the directory in the physical path. 
As the driver discovers partitions on the device, it can create special 
nodes in its class directory. 

At this point, userspace can be notified (via /sbin/hotplug). That can 
create symlinks in /dev to the nodes that were just created, emulating 
current /dev behavior. 

So, what does this do? To an extent, it reengineers the funtionality of 
devfs. I'll be the first to admit it. However, it centers less around the 
filesystem, and more on the device model core. 

Most devices already register with their subsystems, so having the 
subsystesm pass device info onto the core is relatively easy. 

As partitions are discovered, you get paths like:

/driverfs/class/ide/0/2

Which gives you a default name for the device. With /sbin/hotplug, simple 
userspace policy, and symlinks in /dev, you can emulate the current device 
hierarchy. So, you get a device naming solution that gives you only the 
device names for the devices you have. 

This approach also de-emphasizes the dependency on major and minor 
numbers. If device nodes are created in kernel space initially, userspace 
doesn't need to know what the major/minor is for a particular device. The 
symlink to the device node is all that's need to operate on the device. 

Without the need to coordinate between kernel and userspace, at least some 
majors/minors can be dynamically allocated as the subsystems and devices 
are registered with the core. (These can then be exported via files in 
driverfs). (This is similar to the dynamic allocation of minor numbers in 
the USB subsystem that showed up recently...)

Oh, and it's with a modern, clean filesystem, 1/5 the size of devfs. 

Thoughts? Comments? Flames?

	-pat


