Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTCERTw>; Wed, 5 Mar 2003 12:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTCERTU>; Wed, 5 Mar 2003 12:19:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266939AbTCERS0>;
	Wed, 5 Mar 2003 12:18:26 -0500
Date: Wed, 5 Mar 2003 11:05:04 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Dominik Brodowski <linux@brodo.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: sys/fs and sys/block
In-Reply-To: <20030305083932.GA792@brodo.de>
Message-ID: <Pine.LNX.4.33.0303051035100.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm a bit surprised to find yet another top-level directory in sysfs --
> "fs". Wouldn't it be a bit more driver-model-conforming if there'd be a
> "bus_type block_bus_type" with devices like "hda", "fd0", "loop0", and each
> such block device registers a device like "hda1" for partitions of "bus_type
> filesystem_bus_type" (or "partition_bus_type"). And the device drivers for 
> these devices are then the filesystems. 

Ah, but sysfs is not just for driver model objects. It's for exporting any 
object hierarchy. Its roots are in the driver model, and it just so 
happens that the only other things to be represented in sysfs are closely 
related to devices. 

I will admit that the block and net subsystems should be redone as device 
classes, since they clearly describe a type of device. I haven't had time 
to make such a change, though. 

> A few example on how this could look like in sysfs:
> 
> sys/devices/pci0/00:07.1/ide0/hda/hda1
> sys/devices/platform/fd0/fd0

A while back we explicitly decided that this was a bad idea, since we were 
trying to keep only physical (and some virtual) devices in that tree, and 
partitions are clearly a different object type. However, there are other 
object types starting to show up as children to the devices themselves. 

This is completley valid given the semantics of the model, but it won't
work for at least block devices and partitions. Their lifetime is about
the same as the physical devices, but not tied directly to it. Therefore,
they need to be treated as such, with separate objects.

So, they get put in a different hierarchy. This could just as easily be 
under the class/ directly as under the sysfs root. 

Note that other class objects may need similar treatment. This also works
nicely, since it places all the objects related to the conceptual (class)
object under class/*, and leaves only devices under devices/.

> ? sys/devices/virtual/loop0  (a new "virtual" bus would allow us to register
> 				"virtual" and "dummy" devices)

This has come up before, and I'm still not ready to commit to a way for 
doing this. It requires some more time and investigation that I'm not 
able to dedicate right now. However, I will consider patches ;)

> sys/bus/filesystem/devices/hda1
> sys/bus/filesystem/devices/fd0
> 
> sys/bus/filesystem/drivers/xfs

No! Filesystems are not buses. It's a completely different subsystem, and 
should be treated as such. It's worse to overload the existing objects to 
represent something they're clearly not than to just create new objects.

> Oh, and is the kobj in super_block (which was added in the same sys/fs
> patch) used anywhere?

>From the original author: 

"Also, struct kobject is embedded into struct super_block. It is
naturally file system responsibility to register it (and may be some
other kobject's) at mount, and unregister at umount."

I wonder if it can, and should, be done automatically. Or, if we can just 
use symlinks to point to the partitions, instead of creating a new object 
at all. 

Thanks for the questions,


	-pat

