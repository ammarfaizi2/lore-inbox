Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSIZQIe>; Thu, 26 Sep 2002 12:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSIZQIe>; Thu, 26 Sep 2002 12:08:34 -0400
Received: from ausadmmsrr502.aus.amer.dell.com ([143.166.83.89]:60940 "HELO
	AUSADMMSRR502.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261404AbSIZQI3>; Thu, 26 Sep 2002 12:08:29 -0400
X-Server-Uuid: 586817ae-3c88-41be-85af-53e6e1fe1fc5
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8C5@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: greg@kroah.com, mdharm-usb@one-eyed-alien.net
cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: devicefs requests
Date: Thu, 26 Sep 2002 11:13:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 118DEDBC1002516-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are you trying to walk all of the USB devices for?  What would you
> do if you found a USB mass storage device that matched something in the
> EDD tables?

My goal is simple, my approach may be flawed. :-)
x86 BIOS decides somehow what disk to boot from.  In a single disk system,
that's a pretty simple choice.  In a multi-disk system, BIOSs (either
on-board or add-in cards) enumerate devices and hook them to the int13
vector, and the system boots from device 80h, the first hard disk detected
and hooked to that vector.  Problem is, Linux doesn't have a way to know
which disk BIOS thinks is the boot disk.  Think installing onto a brand new
system with no data on any of its 8 internal disks, split across multiple
SCSI controllers, with an add-in RAID controller connecting a pile of
external storage.  The Linux installer (at least) needs to know on which
disk to put lilo/grub in order to boot, and would like a hint as to where to
put /boot and / file systems, and right now that requires human intervention
and guesses - it's entirely possible to install on to such a system, reboot,
and the boot loader didn't get placed where BIOS goes to look for it.  I've
got to restrict our factory preload configurations because of this.


EDD 3.0 is supposed to help solve this.  We query BIOS early in the boot
process before switching to protected mode and store away the device path
information on a per-disk basis.  I want to use this device path information
(PCI bus:dev.fn, {SCSI bus,id,lun; IDE controller,dev; USB - spec says
serial number); ...})  to compare against what the devices themselves
believe they're at under Linux, and provide a symlink in driverfs from a
BIOS device item to the Linux device item.  Userspace hotplug will create
/dev/sdX by getting information from driverfs, and userspace tools like boot
loader installers could follow the symlink, get the kdev, make a temporary
device node, and operate on the right disk.  (Temporary because it could
change on next boot if controllers or disks are are added/removed).

What I'm picturing is something like this (feedback welcome!):

/driverfs/
|-- bus
|   |-- scsi
|   |   |-- devices
|   |   |   |-- 0:0:0:0 -> ../../../root/pci2/02:06.0/scsi0/0:0:0:0
|   |   |   |-- 0:0:0:0:disc ->
../../../root/pci2/02:06.0/scsi0/0:0:0:0/0:0:0:0:disc
|   |   |   `-- 2:0:5:0 -> ../../../root/pci0/00:02.0/01:06.0/scsi2/2:0:5:0
|   |   |   `-- 2:0:5:0:disc ->
../../../root/pci0/00:02.0/01:06.0/scsi2/2:0:5:0:disc
|   |   `-- drivers
|   |       `-- sd
`-- root
    |-- BIOS_int13
    |   |-- 80
    |   |   |-- disc -> ../../pci2/02:06.0/scsi0/0:0:0:0/0:0:0:0:disc/kdev
    |   |   `-- info
    |   |-- 81
    |   |   |-- disc -> ../../pci2/02:06.0/scsi0/2:0:5:0/2:0:5:0:disc/kdev
    |   |   `-- info
    |-- pci2
    |   |-- 02:06.0
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   |-- resource
    |   |   `-- scsi0
    |   |       |-- 0:0:0:0
    |   |       |   |-- 0:0:0:0:disc
    |   |       |   |   |-- kdev


The only reason I'm doing even this much in driverfs is because I thought
the symlink idea would be nice.  I could just as easily export two files per
BIOS device: interface_path and device_path, and make userspace read those
and walk the driverfs tree looking for the match.  I was hoping that
driverfs could display this relationship between devices as it already does
for PCI {SCSI,IDE,...} devices.  If I can't walk the list of devices from
inside the kernel looking for a match, I'll do it in userspace.

So far I've focused on SCSI because that's the type that can be most easily
constructed into really wierd controller and disk configurations, and what
we sell most of in our servers.  Once SCSI works, I think IDE will follow
pretty easily.  The EDD spec allows for a wide variety of interface paths:
ISA, PCI, PCI-X, InfiniBand, PCI Express, HyperTransport; and device paths:
ATA, ATAPI, SCSI, USB, 1394, Fibre, I2O, RAID, SATA.  

> It seems that this spec is oriented toward storage devices.  The USB
> device structure if for all types of devices.

Yes, the EDD spec is all about storage devices, particularly x86 BIOS int13
devices.  I'm less worried about non-disk devices right now, I'm concerned
about being able to boot from disk devices.

> As for USB storage devices, I don't know if they all contain serial
> numbers that are unique, you might want to go ask the author of the
> usb-storage driver, Matt Dharm.

So the USB device structure isn't the right thing to look at, but us_data
which keeps the GUID probably is.  It's got a pointer to the Scsi_Host,
which has its PCI information.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

