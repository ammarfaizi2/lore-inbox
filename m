Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318992AbSHSTSb>; Mon, 19 Aug 2002 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318993AbSHSTSb>; Mon, 19 Aug 2002 15:18:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30603 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318992AbSHSTS2>;
	Mon, 19 Aug 2002 15:18:28 -0400
Date: Mon, 19 Aug 2002 12:28:20 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Kristian Hogsberg <hogsberg@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs and ieee1394
In-Reply-To: <m34re7zxtu.fsf@dhcp-17-1.bang-olufsen.dk>
Message-ID: <Pine.LNX.4.44.0208191150190.1048-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi. Sorry about the long delay in getting back to you. 

> I've been reading through your driverfs and device model code, and
> trying to change the ieee1394 subsystem over to use it.  The ieee1394
> subsystem has some bus and device management functionality which works
> much like the general device model code, and I think we could replace
> much of this in the end.  But for now, I was just trying to hook it up
> to the driverfs and use this to expose the subsystem status.

Excellent. I'll be very interested in seeing what things can do fall out. 

> I looked briefly at the usb solution, and it seems that they register
> programming interfaces as subdevices of the actual device.  This has
> the advantage of letting the general code do the work of iterating
> through the interfaces, but it doesn't seem like the right way to use
> the driverfs.  Another approach is to not register the actual devices
> but only the interfaces like dev0:if0, dev0:if1, dev1:if0, etc. but
> this doesn't express the structure of the bus in the directory
> structure.  Finally, you could choose not to expose the interfaces at
> all, and let the bus' match callback iterate through the supported
> interfaces for drivers and devices, as is the case with the PCI
> subsystem.

The core mainly cares about device interfaces right now, for the purpose 
of binding drivers to them. Though, there may be attributes about the 
device themselves that you want to express. 

If there is, I would recommend doing what the USB subsystem does. If not, 
go the PCI route, with a flat namespace for all devices and functions on a 
particular bus.

If you choose the former, look how the USB code handles devices. They set 
the driver to a default, benign one, so the core doesn't call the bus's 
match function to bind a driver to it. You probably want to do something 
like that. 

> Anyway, for now I'll just implement the interface matching in the
> match callback for the bus, and I plan to expose the interfaces of a
> device by using the device_attribute mechanism.  In the ieee1394
> subsystem, a device has a list of structs attached, each representing
> an programming interface.  To implement a device_attribute entry per
> interface in the directory for the device the show callback needs to
> know which interface it is supposed to show.  As I see it, there are
> basically two ways to do this and they both break the current API: 1)
> include a void *user_data field in the device_attribute struct and
> pass this as an extra argument to the show() and store() callbacks or
> 2) pass the pointer to the device_attribute struct to the callbacks
> and let the callbacks use container_of() to figure out what they're
> contained in.  I prefer the last solution, since you save the pointer
> and I plan to embed the device_attribute structs in the struct
> representing the interface anyway.  It requires only minimal changes
> to the device model code but it breaks the API:

Again, I would say expose the device interfaces by wrapping them around a
struct device and registering them in the device tree. Internally, it 
makes sense, since that is the object with the most meaning to us. 
Externally, there are most likely many attributes of the interfaces that 
you want to expose. Having a directory for each gives you this ability 
easily. 

> Another issue is device naming (bus_id) - what's the convention?  I
> can see from the PCI names that they use bus position, but this is
> probably a bad idea for ieee1394.  Devices on the ieee1394 bus are
> enumerated by a tree traversal algorithm, and hotplug events change or
> even re-root the tree (the linux box isn't necessarily the root), and
> thus, the bus addresses change.  Instead I was planning to using the
> extended unique id (EUI) of the devices as device names.  The EUI is a
> 64 bit globally unique number, much like the MAC address of ethernet
> cards.  However, there's only allocated 16 chars for the
> bus_id... could you make it 20 chars, or do you have another
> suggestion for device naming?

The bus_id is simply the position on the bus of the device. It's relative 
to the local bus only, and does not have global significance. [1]. It's 
equivalent to struct pci_dev::slot_name. [2]

Unique identifiers are a different entity, and will eventually make their 
way into the driver model core. But, you don't necessarily need the unique 
IDs to ascertain the topology of the system, which was the first goal of 
the bus_id.

	-pat

[1] Ok, I'm lying. We have a flat namespace of all devices on all
instances of a particular bus type. This makes iterating over the devices 
when attaching drivers much easier. This namespace is exposed in 
bus/$bus_type/devices/ in driverfs via symlinks to the devices directory 
in the physical hierarchy. The name of the symlink is the bus_id field. 

In order to avoid conflicts, you want a bus_id that is something like <bus
number><device number><interface number>. They don't have to be UUIDs, and
it's ok for them to change via hotplug events.

[2] Yes, I've considered changing the names of bus_id and name to
something like 'slot' and 'description'. Dave Brownell, I hear you
calling....

