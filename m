Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSLSU52>; Thu, 19 Dec 2002 15:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSLSU52>; Thu, 19 Dec 2002 15:57:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266161AbSLSU5Z>;
	Thu, 19 Dec 2002 15:57:25 -0500
Date: Thu, 19 Dec 2002 14:37:07 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: bus_type and device_class merge (or partial merge)
In-Reply-To: <200212191936.LAA06204@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0212191355370.1286-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	If there is a more specific mailing list than lkml for discussing
> the generic driver model, please feel free to redirect me.

No, the kernel list is right. I'm a lazy bastard that travels a lot, so 
response latency is often higher than it should be. 

> 	I'm thinking about trying to embed struct device_class into
> struct bus_type or perhaps just eliminate the separate struct
> bus_type.  The two structures are almost identical, especially
> considering that device_class.devnum appears not to be used by
> anything.

Someone else tried to do this a while back, and my argument was the same 
as this is going to be: they are very distinct objects that describe 
different things. 

It is true that classes are not used much in the current kernel. The last
six months have not afforded enough time to convert as much code to use
them as I would have preferred. As a result, the class and interface code
is the least mature (and the least personally liked) of the driver model
code. 

If you're interested, I've finished a paper for linux.conf.au on the 
driver model that should describe the various objects and purposes (much 
better than the Ottawa paper did). You can find it at: 

http://kernel.org/pub/linux/kernel/people/mochel/doc/lca/driver-model-lca2003.tar.gz

Hopefully, you will find it useful. Feel free to send me comments on it, 
as it may just be completely crappy. 

> 	At first appearance, a bus_type (PCI, USB, etc.) and a
> device_class (network devices, input, block devices), may seem like
> opposite ends of the device driver abstraction, but really I think
> these are basically the same, and, more importantly, there can be many
> layers of these interfaces, and the decision about which are bus_types
> and which are device_classes is causing unnecessary coplexity.  For
> example, SCSI defines both.  SCSI can be a hardware bus, bus it also
> needs device_class so that scsi_debug (and eventually scsi generic) can
> use the struct interface mechanism.

They're not the same, though. They may be similar, but they are 
fundamentally different. 

A bus describes a physical transport. It defines semantics for 
communicating with resident devices, independent of the functionality they 
ultimately serve. 

A class is the flipside. It describes the function a device is designed 
to perform, independent of its underlying transport. 

The interfaces that communicate with devices of a particular class are the 
canonical entities that give devices meaning to users and userspace 
programs. 

Consider audio devices. The only things I care about are /dev/mixer and
/dev/dsp, which map to devices registered with the audio subsystem.
Actually, what is registered are not devices. They are objects allocated 
by the driver for my sound card that describe the device in the context of 
the audio subsystem. This object is independent of the bus the device 
resides on. Communication from userspace to the device passes through the 
driver, which formats the class requests to bus and device-specific ones 
to actaully talk to the physical device. Something like this:

Me -> device node -> kernel intf -> audio subsys -> driver -> bus -> device


Some buses allow communication to devices on their bus type, regardless of
the devices' function. SCSI does this, as you mention, and so does PCI and
USB, via /proc/bus/*. Functionality is limited to what can generically be
done, and what the bus type allows you to do. They are not classes,
though. The interfaces they correspond to are specific to the underlying
transport.

SCSI is wrong about creating a device class. They are overloading 
constructs for their own, twisted purposes. It's partly my fault, as I 
know they could use a mechanism for registering and exporting interfaces 
to bus-specific devices. It hasn't happened mainly because of time 
constraints. 

> 	Also, merging device_class and bus_type could also enable a
> little more consolidation between struct device_interface and struct
> device_driver (as with device_class.devnum, device_interface.devnum
> does not appear to be used currently).
> 
> 	Anyhow, I think this could shrink the drivers/base a bit and
> make it slightly more understandable.  I'd be interested in knowing if
> anyone else is contemplating or developing this or wants to point out
> issues to watch out for.

Consolidation is possible, but I would not recommend doing it by merging
the structures. Look for other ways to create common objects that the two
can share. The distinction between the object types is important,
conceptually, if nothing else. Especially during the continuing evolution
of the model. At least for now, and for probably a very long time, I will 
not consider patches to consolidate the two object types.


	-pat

