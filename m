Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSFTURI>; Thu, 20 Jun 2002 16:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSFTURH>; Thu, 20 Jun 2002 16:17:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63126 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S314748AbSFTURD>;
	Thu, 20 Jun 2002 16:17:03 -0400
Date: Thu, 20 Jun 2002 13:12:08 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <3D12032C.7040105@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0206201230190.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But:
> 
> 1. There was the mistake of using different major numbers
> for SCSI and IDE/ATAPI devices. (disk and CD-ROM are the most striking).
> 
> 2. Then came devfs along and promised to slove this problem.
>     But people still complained about not beeing ablve to boot, after
>     I changed the registration name for IDE devices from "ide" to "ata".
>     This showed nicely that devfs doesn't cut it. It's useless for
>     the purpose of unification of access methods apparently.
> 
> 3. Now comes driverfs, which is basically a Solaris driver tree clone and
>     *repeats* the same errors as 1. and 2.:

driverfs is not a Solaris driver tree clone. Sure, it's similar, but I 
assure no inspiaration was derived from Solaris. The same is true for the 
Windows Driver Model (though bits of inspiration may have filtered into 
the initial driver tree from WDM via the ACPI people).

driverfs does not care about major and minor numbers (yet). 

driverfs does not attempt to replace the /dev hierarchy.

That said, driverfs will use major/minor numbers in the future, but it
will not care about what they are or who owns them. It will also offer a
solution to the device naming problem (like devfs), and provide a 
mechanism for maintaining /dev compatability. But, I'm foreshadowing. 

>   ./
> ./bus
> ./bus/usb
> ./bus/usb/drivers
> ./bus/usb/devices
> ./bus/usb/devices/002001
> ...
> ./bus/usb/devices/001000
> ./bus/pci
> ./bus/pci/drivers
> ./bus/pci/drivers/parport_pc
> ..
> ./bus/pci/drivers/usb-uhci-hcd
> ./bus/pci/drivers/e100
> ./bus/pci/devices
> ./bus/pci/devices/00:0c.1
> ...
> ./bus/pci/devices/00:00.0
> 
> 1. The /drivers information is useless. modutils are maintining they
> own information. For some jet unknow reason they manage to
> maintain te hierarchy entierly in user space.

You mean e.g. ./bus/pci/drivers/ ? I don't think it's useless at all. It 
provides a mechanism for drivers to export attributes specific to the 
drivers themselves (and not specific to a particular device). For example, 
if you want to turn on debugging on the fly in the e100 driver, it could 
export a 'debug' file, which the user could toggle. It would turn on 
debugging for the entire driver on the fly. 

It likely has a module parameter to do the same thing. But, that parameter 
is not available if you statically compile it into the kernel. And, module 
parameters are not tweakable on the fly. 

Rusty and I are talking at the kernel workshop on Monday about parameters.  
One of the topics is where module parameters leave off and driverfs starts
up. It would be really really nice to unify the representation of these
types of parameters. 

Plus, something that is easy to do is create symlinks in the drivers' 
directory to the devices in the physical hierarchy for the devices it's 
driving. 

> The bus suffix. is useless for any purpose I can imagine.
> Which kind of view is the above supposed to present?

It's the 'bus' view. Each bus should have a struct bus_type object that it 
registers on startup. (See the documentation I sent out a couple of weeks 
ago). It's then inserted into a flat list of bus types. 

Each bus keeps a list of devices and drivers. These lists are moved to the 
struct bus_type for centralized management. 

Everything is exported via driverfs because it's easy to do so, and 
because it can potentially be very useful. 

> ./root
> 
> 2. What is this root prefix good for?!

Every system has the concept of a 'root' device. It's a virtual device 
that doresn't physically exist. It's the start of the device tree. 

> ./root/pci0
>
> 3. Solaris is separating the name and enumeration part by @ for
> good reaons.

'pci0' is the bus ID of the first PCI bridge. Devices that exist on the 
board itself and not on a peripheral bus don't have a standard for bus 
IDs. So, I went with <canonical name><instance number>. I thought it was 
pretty clear what it meant...

> ./root/pci0/00:0c.1
> ./root/pci0/00:0c.1/resources
> 
> 4. resources? What is the semantics of this supposed to be?
> IO ranges, memmory mappings? Whatever. This is jet another
> ASCI view for data which is too specific and should be only
> maintained by the drivers itself internaly as it is.
> Since it's not used now it will open jet another room
> for arbitrary formating and random useless entires problems in the future.
> Much like the mess in /proc only repeated for every single device on the
> system.

I think just the opposite is true. The resources file is added by the PCI 
layer and exports the BARs of the device. Every PCI device has this data. 
The formatting of this file is handled by the PCI layer. Yes, it may be 
specific to PCI devices, but it is standard for each PCI device. 

If we ever move the resources array to struct device, we can move the 
creation and the formatting of the resources file to the core. Then, it's 
standard for every device. 

I don't want driverfs to end up like procfs with the random formatting
problem. I want driverfs files to be ASCII-only files with one value per
file. This cannot be programmatically enforced, so we must rely on social
engineering to enforce it. 

[ Also, the resources file also violates the second rule, since it's an 
array of information, but I don't know any better way to represent this. ]

driverfs files are named attribute pairs, where the name of the attribute 
is the name of the file, and the value is the contents. I've talked with 
people before about making them even easier to create, read, and write, in 
ways that enforce one value of a specific type to be exported. (I.e. 
making them very restrictive). Someday...

> ./root/pci0/00:0c.1/irq
> 
> 5. This is showing that the resources file above is useless, becouse
> I would rather love to consider irq as a resource.

Sure, but it's a separate field. 

> ./root/pci0/00:0c.1/power
> ./root/pci0/00:0c.1/name
> 
> 6. The /name is entierly redundant logically to the fact that we
> have already a unique path to the device. For "pretty" printing
> we have userspace. For PCI it's for example repeating the
> ID info found already by lspci.

Sure. But, we already have the information in struct device. Instead of 
using lspci, lsusb, lsfoo to ascertain the name, you can just cat the name 
file for any device on the system. (Though, I basically agree with the 
premise that that information doesn't need to be in the kernel in the 
first place)

> ./root/pci0/00:07.2/usb_bus
> 
> 7. What is the _bus? suffix good for? How does this releate
> to the /bus hierarchy?

It says that it's a USB hub. I believe the information is redundant, and 
there should be a patch to remove it. Greg? :)

> ./root/pci0/00:07.2/usb_bus/00
> 
> 9. Contrary to PCI we enumerate the busses apparently
> by one dir level and not a suffix on the usb prefix.

Yes, the directory names are bus-specific identifiers for the device. It's 
up to the bus enumerator to determine what they are, and really don't make 
any sense outside of the bus context. 

> ./root/pci0/00:07.1/ata@00
> ./root/pci0/00:07.1/ata@00/sd@0,0
> ./root/pci0/00:07.1/ata@00/sd@0,0/power
> ./root/pci0/00:07.1/ata@00/sd@0,0/name
> ./root/pci0/00:07.1/ata@00/power
> ./root/pci0/00:07.1/ata@00/name
> 
> Here I'm trying to fit the whole in some kind of
> physical view. I did sneak in the sd instead of
> hd in the futile hope that SCSI will pick up the same
> name. And I buy in to the idea of separating
> the enumeratin for the naming by a @.
> This way one has only to enumerate the
> dir only and no room for possible ambiguity is present.

ata@00 is the controller, right? And sd@0,0 is the first disk on the first
channel?? You don't need the former. It's already present as PCI device
00:07.1, and you shouldn't have a duplicate entry. 

sd@0,0 can simply be 0,0 (though I don't personally like commas). You 
don't really _need_ any more context in there, since it's implied by your 
location in the tree.

> But it was entierly behind me how to fit this
> in to the sheme other sd@4,0:h,raw
> OS-es are using. And finally how would one fit this in to the
> partitioning shemes? For the system aprtitions are simply
> block devices hanging off the corresponding block device.

Partitions are purely logical entities on a physical disk. They have no 
presence in the physical device tree. 

> However we can see that the driver filesystem is
> inconsistant on the kind of enumeration it should
> provide. See the colon in sd@0,0 and the whole subdir
> crazyness... So do we distingish different devices by a subdir?
> Or do we do it by an unique enumeration suffix?

I don't understand your question. Yes enumeration is inconsistent, because 
it's dependent on the bus-supplied ID. 

> And last but not least: I still don't see any kind
> of abstraction there which would allow to easly enumerate
> for example all disks in the system.

It doesn't exist yet. Disks are a device class. When a disk driver 
discovers a disk, it will register it with the disk class. The class 
will then enumerate the disk. 

> However a simple major number range for disks 1 to 16000 would
> be ideal. And I bet that at some (not too distant) day we will
> simple have to reassign those numbers and be done.

Sure. Once device class supports materializes, classes will register and
can be assigned a dynamic major number even (if they don't already have
one). As devices (and partitions) are discovered, we can assign minor
numbers (dynamically!), and call /sbin/hotplug to notify userspace of the
discovery. It can use that information to create device nodes based on 
user-defined policy. 

[ Yes, that is similar to what devfs does, but there are several distinct 
differences... ]

I imagine we'll have a lot to discuss in Ottawa...

	-pat

