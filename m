Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRDWWRc>; Mon, 23 Apr 2001 18:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132387AbRDWWR0>; Mon, 23 Apr 2001 18:17:26 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:3130 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S132413AbRDWWMl>; Mon, 23 Apr 2001 18:12:41 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E265@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Cc: dougg@torque.net, alan@lxorguk.ukuu.org.uk, jlundell@pobox.com
Subject: RE: [RFC][PATCH] adding PCI bus information to SCSI layer
Date: Mon, 23 Apr 2001 17:06:10 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone for your input.

Doug Gilbert said:
> SANE (and probably some other applications) parses the
> output of 'cat /proc/scsi/scsi' so any change to its
> format may trip SANE up. How about another entry in
> the /proc/scsi directory that has a more parsable format
> (e.g. xml :-) ).

This makes a lot of sense, but I don't want to fan the war over what kind of
information should be presented in /proc. :-)  Perhaps this can wait for
scsimon changes.

Doug Gilbert said: 
> Also ISA adapters are not the only non-PCI adapters,
> there are the growing band of pseudo adapters that
> may or may not have a PCI bus at the bottom of some
> other protocol stack.

Alan said:
> An ioctl might be better. We already have an ioctl for 
> querying the lun
> information for a disk. We could also return the bus 
> information for its
> controller(s) [remember multipathing]

If I understand multipathing properly, a /dev/mdX device is composed of
several block devices, and there are IOCTLs available to list the individual
devices that compose a block device.  Each multipath component shows up as
both /dev/sda and /dev/sdb, but you mount /dev/md0 for your I/Os.  BIOSs
don't know about multipath devices, they just see the same disk twice and
don't know it's really only one disk.  Hopefully BIOS only reads the boot
sector and jumps, so this is fine.

I've proposed a SCSI ioctl that returns PCI bus, slot, function, primary and
subsystem vendor and device IDs.  Equivalent /dev/hdX information is
available in /proc/ide/ide0, but not as an IOCTL.  It could then be a
user-space problem to decompose a mdX into component sdX or hdX devices, and
query them appropriately.

I'm still not sure if/how to handle:
1) non-PCI-bus devices

Here I'm going to need some help.  My original design was based on the
information presented by EDD 3.0 Rev 5a (www.t13.org), which only presents
x86 int13-type devices, and shows them to be either ISA or PCI-based, with
the goal of telling the OS which device BIOS thinks is the boot device.
Booting off, say, a parallel-port ZIP drive isn't really handled in EDD.  


2) Devices like i2o scsi disks
	The i2o controller can be on any bus type (though I expect most are
PCI).  The i2o_controller struct has an i2o_hrt member, which does have bus
information, but the PCI struct doesn't include subsystem vendor and device
fields yet.  We'd need to add an IOCTL to retrieve this information,
possibly one at a generic i2o level.   The EDD 3.0 spec shows that a PCI i2o
device returns us a 64-bit Identity Tag, which I'm guessing is the same as a
32-bit target device ID and possibly the TID of the controller too.

3) other block devices (non-SCSI, i2o, or IDE).  I haven't investigated
these.


Doug suggested looking at extending scsimon.  This is a fine idea, and I've
made proposed changes available at http://domsch.com/linux/scsi/.  (Doug may
want to clean this up).  However, this, like my earlier changes to
/proc/scsi/scsi, doesn't actually show the relationship between /dev/sda and
a particular PCI controller and SCSI channel,bus,lun tuple.


I'd like to see the the PCI device information added to the Scsi_Host
structure, the ioctl, and the various PCI SCSI driver changes I mentioned
last week.  I've removed the changes to /proc/scsi/scsi and rebuilt it
against 2.4.4-pre6, available at
http://domsch.com/linux/scsi/linux-2.4.4-pre6-scsi-pci-info-noproc.patch

If/when this goes in, I'll also request the assistance of all of the SCSI
driver maintainers.  I've changed quite a few drivers, but couldn't easily
see how to change a few others.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


