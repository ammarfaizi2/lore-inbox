Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVJNMuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVJNMuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 08:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVJNMuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 08:50:20 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:23301 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750726AbVJNMuT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 08:50:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051014121423.GA21209@vrfy.org>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <20051014121423.GA21209@vrfy.org>
X-OriginalArrivalTime: 14 Oct 2005 12:49:53.0695 (UTC) FILETIME=[C5DD7AF0:01C5D0BD]
Content-class: urn:content-classes:message
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Date: Fri, 14 Oct 2005 08:49:52 -0400
Message-ID: <Pine.LNX.4.61.0510140839290.16066@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 0/8] Nesting class_device patches that actually work
Thread-Index: AcXQvcXn4IykK0WYTVCHf/yKEcsUvg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kay Sievers" <kay.sievers@vrfy.org>
Cc: <dtor_core@ameritech.net>, "Greg KH" <gregkh@suse.de>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "Hannes Reinecke" <hare@suse.de>,
       "Patrick Mochel" <mochel@digitalimplant.org>, <airlied@linux.ie>,
       <linux-kernel@vger.kernel.org>, "Adam Belay" <ambx1@neo.rr.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Oct 2005, Kay Sievers wrote:

> On Fri, Oct 14, 2005 at 10:45:54AM +0200, Kay Sievers wrote:
>> On Thu, Oct 13, 2005 at 04:35:25PM -0500, Dmitry Torokhov wrote:
>>> On 10/13/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
>>>>
>>>> The nesting classes implement a fraction of a device hierarchy in
>>>> /sys/class. It moves arbitrary relation information into the class
>>>> directory, where nothing else than device classification belongs.
>>>> What is the rationale behind sticking device trees into class?
>>>>
>>>> Instead of that, I propose a unification of "/sys/devices-devices"
>>>> and "class-devices". The differentiation of both does not make sense
>>>> in a wold where we can't really tell if a device is hardware or virtual.
>>>>
>>>> We should model _all_ devices with its actual realationship in
>>>> /sys/devices and /sys/class should only be a pinter to the actual
>>>> devices in that place. Device like "mice", which have no parent, would
>>>> sit at the top level of /sys/devices. All devices in /sys/class are
>>>> only symlinks and never devices by itself.
>>>> That way userspace can read all device relation at _one_ place in a sane
>>>> way, and we keep the clean class interface to have easy access to all
>>>> devices of a specific group.
>>>> It gives us the right abstraction and is future proof, cause
>>>> the class interface will not change when the relation between devices
>>>> changes. The destinction between classes and buses would no longer be
>>>> needed, and as we see in the "input" case never made sense anyway.
>>>>
>>>> /sys/class/block would look exactly like /sys/block today. The only
>>>> difference is that there are symlinks to follow instead of class devices
>>>> on its own. With every device creation we will get the whole dependency
>>>> path of the device in the DEVPATH and a "classsification symlink" in
>>>> /sys/class. The input devices are all clearly modeled in its hierarchy,
>>>> in /sys/devices but we also get clean class interfaces:
>>>>
>>>
>>> Kay eased my task by enumerating all issues I have with Greg's
>>> approach. Not all the world is udev and not all class devices have
>>> "/dev" represetation so haveing one program being able to understand
>>> new sysfs hierarchy is not enough IHMO.
>>>
>>> However I do not think that "moving" class devices into /sys/devices
>>> hierarchy is the right solution either because one physical device
>>> could easily end up belonging to several classes.
>>
>> Sure, than that physical (while that distinction is silly by itself)
>> will just have several child devices. Look at the mouse0 and event0 in
>> the ascii drawing.
>>
>>> I recenty got an
>>> e-mail from Adam Belay (whom I am pulling into the discussion)
>>> regarding his desire to rearrange net/wireless representation. I think
>>> it would be quite natural to have /sys/class/net/interfaces and
>>> /sys/class/net/wireless /sys/class/net/irda, and /sys/class/net/wired
>>> subclasses where "interfaces" would enumerate _all_ network interfaces
>>> in the system, and the rest would show only devices of their class.
>>
>> That solution would keep a better device separation, sure. But it
>> is completely incompatible with everything we ever had in sysfs and
>> nobody wants to rewrite _all_ userspace programs.
>>
>> It invents artificial subclass names below a "master" class, which
>> is absolutely not needed.
>>
>> It creates the magic "interfaces" directory, which is confusing, cause
>> it classifies devices by itself.
>>
>> It doesn't represent any relationship and hierarchy of devices and
>> adding a forest of magic symlinks and "device" pointers is a very
>> bad design. The proposed "inter-class" symlinks make it even harder
>> to understand sysfs as it already is.
>>
>> The biggest problem with current sysfs is that the driver hacker has to
>> decide if the device is "hardware" or "virtual" which in a lot of
>> cases just can't tell and this distiction doesn't make any sense today.
>>
>> All the more complex subsystems use "virtual buses" and an unconnected
>> bunch of class-devices to model its sysfs represention, which is just
>> to work around a major design flaw in sysfs!
>> We really should get _one_ device tree with its natural hierarchy, get
>> rid of the stupid "device"-link, the PHYSDEVPATH and the unconnected
>> class devices. Every device should just carry its dependency tree in
>> it _own_ devpath!
>>
>> I'm very sure, we want a unified tree in /sys/devices, regardless of the type
>> of device, to represent the global hierarchy wich is exactly what you want to
>> know from a device tree!
>> That way we stack "virtual" _and_ "physical" in a sane manner and at the same
>> time get very clean class interfaces. We would stop to mix up "hierarchy" and
>> "classes" all over the tree.
>
> Sorry, my previous drawing wasn't correct for the input devices.
>
> Here is a new picture of the:
>  - all classes are unique and flat and will stay the same,
>    even when the hierarchy of the devices changes
>  - all hierarchy is _only_ in /sys/devices
>  - virtual and physical devices are both in /sys/devices
> proposal.
>
> /sys
> |-- class
> |   |-- block
> |   |   `-- sda -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda
> |   |-- block_partition
> |   |   |-- sda1 -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1
> |   |   `-- sda2 -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda2
> |   |-- pci
> |   |   `-- 0000:00:1f.2 -> ../../devices/pci0000:00/0000:00:1f.2
> |   |-- input
> |   |   |-- mice -> ../../devices/mice
> |   |   |-- mouse0 -> ../../devices/platform/i8042/serio0/input0/mouse0
> |   |   `-- event0 -> ../../devices/platform/i8042/serio0/input0/event0
> |   |-- input_device
> |   |   `-- input0 -> ../../devices/platform/i8042/serio0/input0
> |   `-- tty
> |       `-- console -> ../../devices/console
> |
> |
> |-- devices
> |   |-- pci0000:00
> |   |   `-- 0000:00:1f.2
> |   |       |-- class -> ../../../class/pci
> |   |       |-- config
> |   |       |-- device
> |   |       |-- host0
> |   |       |   `-- target0:0:0
> |   |       |       |-- 0:0:0:0
> |   |       |       |   |-- sda
> |   |       |       |   |   |-- dev
> |   |       |       |   |   |-- range
> |   |       |       |   |   |-- removable
> |   |       |       |   |   |-- sda1
> |   |       |       |   |   |   |-- dev
> |   |       |       |   |   |   |-- size
> |   |       |       |   |   |   |-- start
> |   |       |       |   |   |   `-- stat
> |   |       |       |   |   |-- sda2
> |   |       |       |   |   |   |-- dev
> |   |       |       |   |   |   |-- size
> |   |       |       |   |   |   |-- start
> |   |       |       |   |   |   `-- stat
> |   |       |       |   |   |-- size
> |   |       |       |   |    `-- stat
> |   |       |       |   |-- model
> |   |       |       |   |-- type
> |   |       |       |   `-- vendor
> |   |       |       `-- power
> |   |       |           `-- state
> |   |       |-- modalias
> |   |       |-- resource
> |   |       |-- subsystem_device
> |   |       |-- subsystem_vendor
> |   |       `-- vendor
> |   |-- platform
> |   |   `-- i8042
> |   |       `-- serio0
> |   |            `-- input0
> |   |                 |-- event0
> |   |                 |   `-- dev
> |   |                 |-- mouse0
> |   |                 |   `-- dev
> |   |                 |-- bind_mode
> |   |                 |-- description
> |   |                 |-- id
> |   |                 |   |-- extra
> |   |                 |   |-- id
> |   |                 |   |-- proto
> |   |                 |   `-- type
> |   |                 |-- modalias
> |   |                 |-- protocol
> |   |                 |-- rate
> |   |                 |-- resetafter
> |   |                 `-- resolution
> |   |-- mice
> |   |   `-- dev
> ...
>
> Thanks,
> Kay

I have a great deal of bad experience attempting to perform
emergency mounts on Sun Workstations that have this same
general scheme of un-typable:

../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1

People need to enter this stuff without the help of cut-and-pase or
even a back-space that works. Are you trying to replace "/dev/sda1"
with the monster above? If so, you have way too much time on your
hands.

Of course if this is just some more stuff to be bloated into the
kernel and you don't even intend to use it, I shouldn't be
concerned, should I? Just keep that stuff away from "/dev". We
need to retain a sane interface.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
