Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSFTW3Z>; Thu, 20 Jun 2002 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFTW3Y>; Thu, 20 Jun 2002 18:29:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36616 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315709AbSFTW3T> convert rfc822-to-8bit; Thu, 20 Jun 2002 18:29:19 -0400
Message-ID: <3D125735.7000805@evision-ventures.com>
Date: Fri, 21 Jun 2002 00:29:09 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
References: <Pine.LNX.4.33.0206201230190.654-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Patrick Mochel napisa³:
>>But:
>>
>>1. There was the mistake of using different major numbers
>>for SCSI and IDE/ATAPI devices. (disk and CD-ROM are the most striking).
>>
>>2. Then came devfs along and promised to slove this problem.
>>    But people still complained about not beeing ablve to boot, after
>>    I changed the registration name for IDE devices from "ide" to "ata".
>>    This showed nicely that devfs doesn't cut it. It's useless for
>>    the purpose of unification of access methods apparently.
>>
>>3. Now comes driverfs, which is basically a Solaris driver tree clone and
>>    *repeats* the same errors as 1. and 2.:
> 
> 
> driverfs is not a Solaris driver tree clone. Sure, it's similar, but I 
> assure no inspiaration was derived from Solaris. The same is true for the 
> Windows Driver Model (though bits of inspiration may have filtered into 
> the initial driver tree from WDM via the ACPI people).

Yes that's the pitty :-).

> driverfs does not care about major and minor numbers (yet). 
> 
> driverfs does not attempt to replace the /dev hierarchy.
> 
> That said, driverfs will use major/minor numbers in the future, but it
> will not care about what they are or who owns them. It will also offer a
> solution to the device naming problem (like devfs), and provide a 
> mechanism for maintaining /dev compatability. But, I'm foreshadowing. 

Irony by someone remembering the days devfs wasn't in the main
kernel tree and who was against it:
I tought devfs already solves those problems...


> You mean e.g. ./bus/pci/drivers/ ? I don't think it's useless at all. It 
> provides a mechanism for drivers to export attributes specific to the 
> drivers themselves (and not specific to a particular device). For example, 
> if you want to turn on debugging on the fly in the e100 driver, it could 
> export a 'debug' file, which the user could toggle. It would turn on 
> debugging for the entire driver on the fly. 

Interface on the heap phenomena. If someone writing a driver wished to have
this he could have registered some sysctl already. Becouse
this is precisely the interface fitting the purpose you describe.

> It likely has a module parameter to do the same thing. But, that parameter 
> is not available if you statically compile it into the kernel. And, module 
> parameters are not tweakable on the fly. 

See above - sysctl.

> Rusty and I are talking at the kernel workshop on Monday about parameters.  
> One of the topics is where module parameters leave off and driverfs starts
> up. It would be really really nice to unify the representation of these
> types of parameters. 

Indeed yes but it doesn't have to be done under the umbrella of
driverfs.

> Plus, something that is easy to do is create symlinks in the drivers' 
> directory to the devices in the physical hierarchy for the devices it's 
> driving. 

??


>>The bus suffix. is useless for any purpose I can imagine.
>>Which kind of view is the above supposed to present?
> 
> 
> It's the 'bus' view. Each bus should have a struct bus_type object that it 
> registers on startup. (See the documentation I sent out a couple of weeks 
> ago). It's then inserted into a flat list of bus types. 
> 
> Each bus keeps a list of devices and drivers. These lists are moved to the 
> struct bus_type for centralized management. 
> 
> Everything is exported via driverfs because it's easy to do so, and 
> because it can potentially be very useful. 
> 
> 
>>./root
>>
>>2. What is this root prefix good for?!
> 
> 
> Every system has the concept of a 'root' device. It's a virtual device 
> that doresn't physically exist. It's the start of the device tree. 

That's called /. BTW. If anything I'm missing there is the
representation of the very first BUS out there: CPU!!!

>>./root/pci0
>>
>>3. Solaris is separating the name and enumeration part by @ for
>>good reaons.
> 
> 
> 'pci0' is the bus ID of the first PCI bridge. Devices that exist on the 
> board itself and not on a peripheral bus don't have a standard for bus 
> IDs. So, I went with <canonical name><instance number>. I thought it was 
> pretty clear what it meant...

Yes and the *@* should be there to separate naming from enumeration part.
However I see in the above hierarchy no clear mandate for
where enumeration does happen - dir name subdirs named 0, 1, 2, 3,

>>./root/pci0/00:0c.1
>>./root/pci0/00:0c.1/resources

> I don't want driverfs to end up like procfs with the random formatting
> problem. I want driverfs files to be ASCII-only files with one value per
> file. This cannot be programmatically enforced, so we must rely on social
> engineering to enforce it. 

Forget it. I have warned against those problems even before /proc
became mandatory. You see now where we are. You are just moving
the arbitrary part away from the content to the fs name level.

> [ Also, the resources file also violates the second rule, since it's an 
> array of information, but I don't know any better way to represent this. ]

You see: ascii files are *evil* not just due to buffer overrun attacks.

> driverfs files are named attribute pairs, where the name of the attribute 
> is the name of the file, and the value is the contents. I've talked with 
> people before about making them even easier to create, read, and write, in 
> ways that enforce one value of a specific type to be exported. (I.e. 
> making them very restrictive). Someday...
> 
> 
>>./root/pci0/00:0c.1/irq
>>
>>5. This is showing that the resources file above is useless, becouse
>>I would rather love to consider irq as a resource.
> 
> 
> Sure, but it's a separate field. 
> 
> 
>>./root/pci0/00:0c.1/power
>>./root/pci0/00:0c.1/name
>>
>>6. The /name is entierly redundant logically to the fact that we
>>have already a unique path to the device. For "pretty" printing
>>we have userspace. For PCI it's for example repeating the
>>ID info found already by lspci.
> 
> 
> Sure. But, we already have the information in struct device. Instead of 
> using lspci, lsusb, lsfoo to ascertain the name, you can just cat the name 
> file for any device on the system. (Though, I basically agree with the 
> premise that that information doesn't need to be in the kernel in the 
> first place)

Argument frequently enough repeated by the advertisers of
the /proc mess... The kernel should be what it's name says -
just the kernel of the things and not the all for everything.

>>./root/pci0/00:07.2/usb_bus
>>
>>7. What is the _bus? suffix good for? How does this releate
>>to the /bus hierarchy?
> 
> 
> It says that it's a USB hub. I believe the information is redundant, and 
> there should be a patch to remove it. Greg? :)
> 
> 
>>./root/pci0/00:07.2/usb_bus/00
>>
>>9. Contrary to PCI we enumerate the busses apparently
>>by one dir level and not a suffix on the usb prefix.

You see I understood that pci0 is for the first bridge.
And you see that in comparision to /proc you are moving
the "arbitrary" part just from the file level to the directory
level.

Once reason I advertize for short names is the fact
that they will prevent people psychologicall from inventing
names like:

/devices/pci0/..../my_beloved_toy_device_which_....


> Yes, the directory names are bus-specific identifiers for the device. It's 
> up to the bus enumerator to determine what they are, and really don't make 
> any sense outside of the bus context. 
> 
> 
>>./root/pci0/00:07.1/ata@00
>>./root/pci0/00:07.1/ata@00/sd@0,0
>>./root/pci0/00:07.1/ata@00/sd@0,0/power
>>./root/pci0/00:07.1/ata@00/sd@0,0/name
>>./root/pci0/00:07.1/ata@00/power
>>./root/pci0/00:07.1/ata@00/name
>>
>>Here I'm trying to fit the whole in some kind of
>>physical view. I did sneak in the sd instead of
>>hd in the futile hope that SCSI will pick up the same
>>name. And I buy in to the idea of separating
>>the enumeratin for the naming by a @.
>>This way one has only to enumerate the
>>dir only and no room for possible ambiguity is present.
> 
> 
> ata@00 is the controller, right? And sd@0,0 is the first disk on the first
> channel?? You don't need the former. It's already present as PCI device
> 00:07.1, and you shouldn't have a duplicate entry. 
> 
> sd@0,0 can simply be 0,0 (though I don't personally like commas). You 
> don't really _need_ any more context in there, since it's implied by your 
> location in the tree.

I would love to distingish between device types sd - disk
sr - -CD-ROM DVD or whatever.
Please note that you have only one single PCI device but from
the physical perspecitve two buses hanging down from it called
channels (The ribbon between the disk and controller).
So a ATA host chip controller is basically even in reality
a PCI to ISA bus bridge. For example it's quite common
in notebooks to use the second ATA channel precisely as a bridge
between the host PCI and ISA on the expander....
Just forget that there is usually only a master and slave
on this bus please.

> Partitions are purely logical entities on a physical disk. They have no 
> presence in the physical device tree. 

Device drivers are purely logical entities of the kernel. They have
no presence in the physical device tree.

But they have a presence in /dev/ and are the entity we act on.

>>However we can see that the driver filesystem is
>>inconsistant on the kind of enumeration it should
>>provide. See the colon in sd@0,0 and the whole subdir
>>crazyness... So do we distingish different devices by a subdir?
>>Or do we do it by an unique enumeration suffix?

> I imagine we'll have a lot to discuss in Ottawa...

Yeep. I'm looking forward to it. Let's count the ARM CPUs attached
to my notebook after some real beer :-).

