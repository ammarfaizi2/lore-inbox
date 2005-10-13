Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVJMK63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVJMK63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 06:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVJMK63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 06:58:29 -0400
Received: from soundwarez.org ([217.160.171.123]:17066 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750909AbVJMK62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 06:58:28 -0400
Date: Thu, 13 Oct 2005 12:58:26 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051013105826.GA11155@vrfy.org>
References: <20051013020844.GA31732@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:08:44PM -0700, Greg KH wrote:
> Ok, finally.  Here's a set of _working_ patches that properly implement
> nesting class_device structures, and the follow-on patches to move the
> input subsystem to use them.  Hotplug and release functions work
> properly now, and this will let us move /sys/block/ to use class and
> class_device structures soon.

Sorry, I completely changed my head about the "class nesting". I don't
like it anymore and think it's a wrong design to spread fractions of
the device relation tree over /sys/class. That breaks the whole idea
of "class" to provide easy access to devices of the same kind.

> The input patches are on top of almost all of Dmitry's input patches.
> All of them are together in one series in my public patches at:
> 	kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
> and should show up in the next -mm release.
> 
> The sysfs tree looks the same as it did last time, but now hotplug works
> properly for addition and removal, and we actually free the memory used
> :)
> 
> For those that don't remember, here's the sysfs tree on my desktop:
> $ tree /sys/class/input/ -d
> /sys/class/input/
> |-- input0
> |   |-- capabilities
> |   |-- event0
> |   `-- id
> |-- input1
> |   |-- capabilities
> |   |-- device -> ../../../devices/platform/i8042/serio1
> |   |-- event1
> |   |   `-- device -> ../../../../devices/platform/i8042/serio1
> |   `-- id
> |-- input3
> |   |-- capabilities
> |   |-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> |   |-- event2
> |   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> |   |-- id
> |   |-- mouse0
> |   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> |   `-- ts0
> |       `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> `-- mice
> 
> To answer the remaining questions from the last thread:
> 
> Q: how are you going to determine what is really a class_dev and what
>    isn't, as there's no way to tell.
> A: Who cares?

Me at least! :) As we can't distinguish between the type of class device
which is nested. And that information is lost.

>    Seriously, tools like udev will watch for the "dev" file
>    to be able create the required device node, and it will be the one
>    getting the hotplug event.  attribute groups do not generate hotplug
>    events, and you should not be having a file called "dev" in your
>    attribute group anyway.

Sure, that works for the "device node" case but stuff like HAL wants to
build a meaningful tree from sysfs which does not only care about a "dev"
file.
I looked at supporting stacked classes in HAL and that model doesn't
fit.

> Q: why does event2, mouse0, and input3 in the above tree all have the
>    same "device" symlink?
> A: userspace tools expect that symlink there.  They do not know that if
>    you traverse up a directory, and look at the symlink there, that's
>    what the subdirectory points to too.  That would be a mess.  And, as
>    those different class_device structures really are all bound to that
>    same struct device, that is the proper representation of this.
> 
> Q: How can you determine between input interfaces and input devices?
> A: input devices have a "dev" file.  And what really does userspace need
>    to know here?

Sure, we really need to know this! We could only hardcode names and match
against this to get meaningful information out of that.

> Q: Wait, what about nesting struct class instead?  That would work,
>    right?
> A: No, nesting classes is not going to happen.  Classes are "major"
>    things, and aren't related to each other (well, some are by their
>    name only, like the different "scsi*" classes, but to the user, they
>    are separate.)
>    Also, we can't emulate /sys/block with nested classes.  And no, we
>    can't change this to be /sys/class/block/partitions and
>    /sys/class/block/devices without almost every sysfs user complaining
>    loudly.  That's not the real representation of the devices, and we
>    need to really try to keep backward compatibility where we possibly
>    can.

Well, actually this proposal creates two complete different class devices
below one class. That may not be *implemented* as "class nesting", but it is
*represented* as that to userspace.
I really think it is wrong to have the input hardware abstraction "input0"
at the same level as "mice", which is a _completely_ different animal.

> Ok, I think that covers everything.

No, I really don't like that random mix of devices. A class is a simple
collection of devices with the same interface and should never nest or
combine different things.

> Oh, one final thing.  I really don't think that input should be a class.
> It looks like a "bus" and acts like a "bus" (you have different devices
> that have different drivers bind to them, and you want to load those
> drivers with the hotplug mechanism.)  The only thing keeping this from
> being a bus is the fact that we can't bind multiple drivers to a single
> device these days, and I can't see a way to move this code to that
> model, so oh well...

The nesting classes implement a fraction of a device hierarchy in
/sys/class. It moves arbitrary relation information into the class
directory, where nothing else than device classification belongs.
What is the rationale behind sticking device trees into class?

Instead of that, I propose a unification of "/sys/devices-devices"
and "class-devices". The differentiation of both does not make sense
in a wold where we can't really tell if a device is hardware or virtual.

We should model _all_ devices with its actual realationship in
/sys/devices and /sys/class should only be a pinter to the actual
devices in that place. Device like "mice", which have no parent, would
sit at the top level of /sys/devices. All devices in /sys/class are
only symlinks and never devices by itself.
That way userspace can read all device relation at _one_ place in a sane
way, and we keep the clean class interface to have easy access to all
devices of a specific group.
It gives us the right abstraction and is future proof, cause
the class interface will not change when the relation between devices
changes. The destinction between classes and buses would no longer be
needed, and as we see in the "input" case never made sense anyway.

/sys/class/block would look exactly like /sys/block today. The only
difference is that there are symlinks to follow instead of class devices
on its own. With every device creation we will get the whole dependency
path of the device in the DEVPATH and a "classsification symlink" in
/sys/class. The input devices are all clearly modeled in its hierarchy,
in /sys/devices but we also get clean class interfaces:

/sys
|-- class
|   |-- block
|   |   `-- sda -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda
|   |-- block_partition
|   |   |-- sda1 -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1
|   |   `-- sda2 -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda2
|   |-- pci
|   |   `-- 0000:00:1f.2 -> ../../devices/pci0000:00/0000:00:1f.2
|   |-- input
|   |   |-- mice -> ../../devices/mice
|   |   |-- mouse0 -> ../../devices/platform/i8042/serio0/mouse0
|   |   `-- event0 -> ../../devices/platform/i8042/serio0/event0
|   |-- input_device
|   |   `-- inputdev0 -> ../../devices/platform/i8042/serio0
|   `-- tty
|       `-- console -> ../../devices/console
|
|
|-- devices
|   |-- pci0000:00
|   |   `-- 0000:00:1f.2
|   |       |-- class -> ../../../class/pci
|   |       |-- config
|   |       |-- device
|   |       |-- host0
|   |       |   `-- target0:0:0
|   |       |       |-- 0:0:0:0
|   |       |       |   |-- sda
|   |       |       |   |   |-- dev
|   |       |       |   |   |-- range
|   |       |       |   |   |-- removable
|   |       |       |   |   |-- sda1
|   |       |       |   |   |   |-- dev
|   |       |       |   |   |   |-- size
|   |       |       |   |   |   |-- start
|   |       |       |   |   |   `-- stat
|   |       |       |   |   |-- sda2
|   |       |       |   |   |   |-- dev
|   |       |       |   |   |   |-- size
|   |       |       |   |   |   |-- start
|   |       |       |   |   |   `-- stat
|   |       |       |   |   |-- size
|   |       |       |   |    `-- stat
|   |       |       |   |-- delete
|   |       |       |   |-- device_blocked
|   |       |       |   |-- model
|   |       |       |   |-- type
|   |       |       |   `-- vendor
|   |       |       `-- power
|   |       |           `-- state
|   |       |-- modalias
|   |       |-- resource
|   |       |-- subsystem_device
|   |       |-- subsystem_vendor
|   |       `-- vendor
|   |-- platform
|   |   `-- i8042
|   |       |-- class -> ../../../class/platform
|   |       `-- serio0
|   |           |-- event0
|   |           |   `-- dev
|   |           |-- mouse0
|   |           |   `-- dev
|   |           |-- bind_mode
|   |           |-- class-> ../../../../class/serio
|   |           |-- description
|   |           |-- id
|   |           |   |-- extra
|   |           |   |-- id
|   |           |   |-- proto
|   |           |   `-- type
|   |           |-- modalias
|   |           |-- protocol
|   |           |-- rate
|   |           |-- resetafter
|   |           `-- resolution
|   |-- mice
|   |   `-- dev
...


Thanks,
Kay
