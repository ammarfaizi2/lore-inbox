Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbTBDRPz>; Tue, 4 Feb 2003 12:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTBDRPz>; Tue, 4 Feb 2003 12:15:55 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:55207 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266693AbTBDRPx>; Tue, 4 Feb 2003 12:15:53 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 4 Feb 2003 09:25:17 -0800
Message-Id: <200302041725.JAA16768@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] Module alias and device table support.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
>Currently the kernel has two mechanisms to request a module (modprobe and 
>hotplug) and these also have different ways to map the request to a module 
>name.

	I don't know if I'm disagreeing with you, but I'd like to
bring up the following point.

	The kernel notifying the user level that a new device has been
plugged is a often a separate event from the kernel needing a module
for that device.

	When a USB disk is detected, the computer should update its
list of devices to check when an attempt it made to access an
undefined disk, put a new icon on the desktop, and see if there are
any user defined scripts for the event, which would probably include a
default script to update the desktop user interface with this
information.  There is not necessarily any need at that point to load
a module at that point as you don't know that the user is going to
actually access the disk (it may just have been attached when the USB
controller was detected, and might not be accessed at all before the
computer is shut down).

	When a program attempts to access an undefined disk, including
testing the existence of a partition, then the system should start
loading modules for the unbound devices that potentially may have disk
drives.

	It is also possible that the appropriate kernel module is
already compiled in or loaded, but the user interface should be
notified that a new device has been plugged in, say, to pop up a video
window by default whenever a USB camera is plugged in.

	Granted, some users may want a policy of immediately loading
all potentially relevant kernel modules when hardware is detected,
just for the user interface benefits of the kernel printk's and devfs
entries, and they should easily be able to set that, and that should
probably be the default policy for the case where a kernel module is
matched, but the hotplug system does not see that the device is of a
class that will automatically be loaded later by some subsequent
event such as a specific devfs lookup or an attempt to access an
undefined networking interface.

	For some devices, the events set in motion by hotplug may
never result in a kernel module being loaded.  For example, plugging
in a video card might result in invocation of an X server that just
maps in the card's IO registers and a memory window, or some USB devices
may be controlled by user level programs through /proc/bus/usb.

	That said, we could perhaps should shave a few lines from the
kernel by unifying the call_usermodehelper clients a bit more
(hotplug, request_module and my mini-devfs if and when that goes in),
but something like hotplug should be the surviving interface rather
than request_module, because hotplug passes other important
information, such as the type of event and the type of facility being
requested.

	The additional information in the hotplug interface makes it
much easier to write scripts that can do useful things for event types
or module types that haven't been written yet and can help security by
ensuring that only modules of the appropriate type are loaded (so that
a user cannot do something like "ifconfig scsi_debug" to get the kernel
to load an arbitrary module).  As an example of extensibility, imagine
that if we define a new "suspend" hotplug event for device type
"ieee1394", the hotplug handler might know enough to exec
"/usr/libexec/hotplug/drivers/ieee1934 suspend /proc/sys/ieee1394/dev2342",
or the user interface might know enough to recognized the "suspend"
event and change the color of some icon, even though it doesn't know
what ieee1394 is.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
