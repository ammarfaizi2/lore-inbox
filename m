Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTEQCaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTEQCaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:30:19 -0400
Received: from mail.casabyte.com ([209.63.254.226]:53766 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261151AbTEQCaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:30:14 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Greg KH" <greg@kroah.com>, "Oliver Neukum" <oliver@neukum.org>
Cc: "Manuel Estrada Sainz" <ranty@debian.org>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Simon Kelley" <simon@thekelleys.org.uk>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, <jt@hpl.hp.com>,
       "Pavel Roskin" <proski@gnu.org>
Subject: RE: request_firmware() hotplug interface, third round.
Date: Fri, 16 May 2003 19:42:45 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEAACMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030517000338.GA17466@kroah.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Not to throw in two-cents you didn't ask for but...

[Quick Disclaimer: The following is extemporaneous thought based on god
knows what all, but it *sounds* reasonable to me just now... 8-)]

I have a custom device with a set of FPGAs (Field Programmable Gate Arrays)
on it, that have to have their firmware written into them after each power
on (etc.)

My solution was rather more direct than those listed below.

Firmware loading, exclusivity, and correctness is best (and quite usefully)
thought of as a one-writer-many-readers lock, which can be implemented
completely and deterministically in the (various) open routines.

Consider the following two example nodes: (I will not use sysfs specific
speak because I am not familiar enough with sysfs to avoid putting noise in
my signal)

/devfsnodething/device/user-access
/devfsnodething/device/firmware-programming

if you want to "cat my-firmware-image
>/devfsnodething/device/firmware-programming" it only makes sense for the
open-for-write to succeed if two assertions are met:

1) nobody else is writing the firmware
2) nobody else is already using the user-access point.

There is also a list of "things firmware does to a device" and similar
realities that can be deterministically known about any device.  This list
isn't exhaustive, but it is nearly so.  Consider these as candidate flags
and entry points suitable for framing in a driver_info like structure of
pointers to functions (etc):

FIRMWARE_FLASHABLE == set in any module to indicate that the system should
produce/use/honor a firmware-programming device node.

FIRMWARE_FLASH_DEVICE == set on any device_info structure for the access
point for loading a firmware image.  (User-access points don't have this
flag set.)

atomic(FIRMWARE_NEEDS_FLASH) == set in a device that is FLASHABLE and
doesn't have a currently valid flash image in place.  Acts as the guardians
against opens of the user-access device(s).

FIRMWARE_FLASH_WAIT == open of firmware-programming device should block,
waiting for a chance to flash the device until other flash writers or
user-access users are done.  Non-Blocking opens will not block if this is
set.  Blocking opens will wait if this is set.  If this is not set, any
other node in the device being open will make the open of the
firmware-programming device return EBUSY.

dev_Can_Program() == Called during open of firmware-programming device file,
Tells you if the device can be flashed (now|again).  Implements checks for
re-programmability (do you have to power-off or remove and reinsert device
in order to change the firmware, has the firmware already been flashed to
the device, etc.)  Returns READY (0), EFAIL, EAGAIN (maybe others?).  Non
ready returns will cause the open to fail.  Blocking of the open happens in
this routine if it is going to happen at all.

dev_Invalidate_Device() == called during open, or first write operation, to
dismantle user-access devices and list the firmware image as incomplete or
unstable (etc).  If the firmware is being "rewritten" this routine is
responsible for clearing the old firmware.  It is also responsible for
removing user-access devices from the devfs file system and

dev_Check_Program() == Called during close (?) of the firmware-programming
device file to validate that the firmware was accepted by the device.
Returns OK or not.

dev_Enumerate_Device() == Called during close (?) for the firmware
programming device file (or maybe a kernel tasklet etc) after
dev_Check_Program() to give the driver a chance to create the user-access
nodes.  (This is useful, for instance, when the firmware will "create"
within the device, a variable set of user access points.

So, the above covers almost all variations of the cases where a device
needs/may want a firmware file via different combinations of the flags and
routines.  (I am sure I may have missed some cases, but you get the point.)
It does get rid of the whole "echo 1 >" nonsense as a separate action.
(which is good, because the non-script versions of such activities gets
annoying, and you don't want to activate a device with detectably bad
firmware image in it under any circumstances.)

So What Rob Would Do(tm) (all rights [to the phrase] reserved) 8-):

1) Define a firmware_ops structure with the necessary entry points and data
items in it.

2) Add a (normally null) pointer to same to the sysfs_thingy, file_ops,
device_info, and module_info structures.  (I really haven't thought about
where this pointer will go.)

3) Consider any sysfs/device/module/file_info with a pointer to the same
instance of this structure as under the exclusive-open (readers/writer)
protections (giving you a nice, safe, and universally detectable place to
deal with status inquiries, locks, and whatnot for the devices, of the "oh
look, that pointer is non-null, we need to be careful" variety.]  (So only
one FIRMWARE_FLASH_DEVICE with a particular firmware_ops structure can be
opened at one time.  A non FIRMWARE_FLASH_DEVICE may not be opened if a non
FIRMWARE_FLASH_DEVICE is opened which has the same firmware_info pointer.
As many non FIRMWARE_FLASH_DEVICES as you choose may be opened at one time.
(hence the readers/writer like interface)

4) Take a step back, realize that this is all really a "lets make a
meta-device coordinator" pointer/dependency-system and see if the work has
already been (mostly?) done elsewhere, or if the consideration should be
broadened just a hair beyond actual firmware.

=====

What I have done to "fake all this" on my little embedded box using only
pre-hotplug-support facilities:

/etc/modules.conf:
post-install cpld /opt/casabyte/bin/do_flash
above tequal0 cpld

/opt/casabyte/bin/do_flash:
modprobe fpgaflash
cat firmware >/dev/FPGAFlash/ALL
rmmod fpgaflash


The "cpld" (Complex Programable Logic Device) is the thing that lets me
"see" the pins on the FPGA(s) and this driver creates and owns the region of
memory and IO necessary to both flash the device and operate whatever image
is placed into the flash.  "Attaching" and "Detaching" from the cpld driver
acts as an exclusion primitive (lock) and only one lower-level driver can be
attached.

The fpgaflash is a lower level driver that can only flash the FPGAs and has
all the checks and such to make sure that any given FPGA is flashed once.
It handles all the clearing and whatnot.  (Since the cpld can flash all of
the FPGAs at once if you want, the driver dynamically creates
/dev/FPGAFLASH/1 through 4, and "ALL").  When it is removed, those devices
obviously disappear.

The tequal0 driver is the real point, it will fail to load if at least one
FPGA hasn't been successfully flashed.  It dynamically allocates the devices
based on the information it gets from cpld about what is flashed with what.

Now all that is done, with "well designed" drivers, with clear dependencies,
and six lines of script/configuration.

This would be directly analogous to just having the flashing of firmware
(start and finish) re-invoke the hotplug system as the "character of the
flashable device" changes from "dumb thing that needs an image" as one
device, and "smart thing ready to serve" exists in sequence.

=====

In short (I know, too late), I think about moving firmware into my FPGAs as
a first cousin to formatting a ram-disk-buffer.  It is a
nearly-deterministic strict-dependency activity that uses one (almost
always) character device as a latch that creates/activates or
removes/deactivates one-or-more dependent devices.

This is true simply because of the before and after nature of a programmable
device.

If you feel you must codify the idea of these dependencies into the kernel
(as opposed to the dirver(s) and the(ir) configurations) then don't do it by
half measures.  Third-level manipulations (the echo(s) below) are *NOT* your
friend.  Transform the device presentation (in the devfs or the sysfs) as
the device changes.  These file systems are dynamic for a reason.

The case of, say a USB root hub with a built in serial port who's controller
needs to be flashed.  If the controller hasn't been flashed (correctly) or
is being re-flashed the serial port just doesn't really exist until that
operation completes successfully.  If the controller can not be re-flashed,
then the device representing the opportunity to flash the controller becomes
meaningless (and should probably disappear) when a successful flash has been
completed.  If the serial port is opened, the flash device should be
blocked.

It's simple logical exclusion, and we have primitives for all that if you
want to leave the invalid devices visible while they are invalid.  Agree on
a place in the abstract, or hard-wire the exclusion into the mechanism (via
the shared info structure?), but oh-god-please don't put the in-kernel
exclusion into the user-space runtime domain.

All other considerations aside, (e.g. the new binary interface just merged
in etc.) it isn't the open-ness and close-ness that matters, it's the
programmable-device-ready-or-not-ness.  Irregular termination close == bad
firmware.  Programmable device not ready == bad firmware. (and so on).  The
writer of any particular driver *should* already be looking for the un-ready
and the illegal-simultaneous-access cases (both in the firmware-flasher and
the user-access parts) or the driver is going to oops anyway.

Pardon my rant... 8-)

Rob.

P.S.  I "improperly" use "flash" to talk about the "load" of program code
and data into devices which wont retain that information permanently.  It's
morally wrong, but I work with a bunch of people who don't know the
difference and aggressively use the improper term.  I live with hearing that
day-in and day-out from the management level here.  I took no effort to
correct that idiomatic mistake in the above as I have aggressively fostered
a blind-spot in my head on this topic to keep my sanity 8-).  Sorry if
anybody was confused.  I will not entertain "we are not talking about
flashing, we are talking about loading runtime firmware" responses.  The non
persistent "load" case is covered by default, but the "reload" of non
persistent images, and the "(re)flash" of persistent images are both covered
by the proper intersection of the set of cases discussed above.

So ptptpth.... 8-)


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Greg KH
Sent: Friday, May 16, 2003 5:04 PM
To: Oliver Neukum
Cc: Manuel Estrada Sainz; LKML; Simon Kelley; Alan Cox; Downing, Thomas;
jt@hpl.hp.com; Pavel Roskin
Subject: Re: request_firmware() hotplug interface, third round.


On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
>
> > > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> >
> > Nice, but can't you get rid of the loading file by just relying on
> > open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
> > looks like you need that info.  But does the new binary interface in
> > sysfs that just got merged into the tree provide that info for you?
>
> But what if the close() is due to irregular termination?
> If the script is killed, do you download half a firmware?

Good point.  Actually I don't think that the binary interface for sysfs
passes open and close down to the lower levels, so it's a moot point.

echo... works for me.

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

