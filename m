Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbRDMVea>; Fri, 13 Apr 2001 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbRDMVeU>; Fri, 13 Apr 2001 17:34:20 -0400
Received: from smtp3.us.dell.com ([143.166.224.253]:13075 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S131887AbRDMVeI>; Fri, 13 Apr 2001 17:34:08 -0400
Date: Fri, 13 Apr 2001 16:34:06 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: <mdomsch@tux.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] adding PCI bus information to SCSI layer
Message-ID: <CDF99E351003D311A8B0009027457F1402FF5130-100000@ausxmrr501.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on an IA-64 user-space application to add a Linux entry to
the IA-64 boot manager.  To do so, I've got to uniquely identify a
disk by it's controller PCI address, SCSI channel,
ID, and LUN.  Essentially, I need to tie /dev/sda to an EFI device.  An
equivalent problem (with similar solution) exists with i386 where the
BIOS boot order is not necessarily the Linux driver load order.


BIOS Enhanced Disk Drive Services 3.0 provides a way to query BIOS for
what it thinks is it's device location and order.  IA-64 implements
EDD 3.0, and some i386 BIOS manufactures are adding this feature
also.  EDD 3.0 information is available at http://www.t13.org.

What I'd like to do is add the PCI location of the SCSI controller to
the information printed in /proc/scsi/scsi, as follows:

Attached devices:
Host: scsi0 Channel: 00 Id: 05 Lun: 00 PCI bus: 1 slot: 6 fn: 0
  Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00 PCI bus: 0 slot: 2 fn: 1
  Vendor: DELL     Model: PERCRAID RAID5   Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00 PCI bus: 0 slot: 2 fn: 1
  Vendor: DELL     Model: PERCRAID Stripe  Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 02


SCSI controllers which are not PCI devices would not display this
extra information.

IDE devices already provide PCI location information in
/proc/ide/ideX/config.

Furthermore, since reading /proc/scsi/scsi doesn't indicate which device
(say, /dev/sda) is which, I'd like an ioctl to query /dev/sda directly and
retrieve the PCI information.  An ioctl already exists to retrieve the
SCSI channel/id/lun information.


To do so, I propose the following:
1) Add a struct pci_dev *pci_dev member to struct Scsi_Host.
2) Add the printing function to scsi_proc.c, dependent on pci_dev != NULL.
3) Add an ioctl to scsi_ioctl.c for querying a device name like /dev/sda
directly for it's PCI information.
4) Add a line such as:
    		host = scsi_register (pHostTmpl, sizeof (mega_host_config));
 		if (!host)
 			goto err_unmap;
+		host->pci_dev = pdev;
  to each SCSI driver which is also a PCI device.


I've developed a proof-of-concept patch against 2.4.4-pre1, available at
http://domsch.com/linux/scsi/linux-2.4.4-pre1-scsi-pci-info-010413.patch,
in which I've modified a number of drivers.

Further work is required to change the non-trivial drivers.  By not
changing a driver, the information is simply not available, but causes no
other problems.  Drivers may be updated as time and need allow.

Additionally, on i386, I'd like to add the EDD 3.0 BIOS calls to
arch/i386/kernel/boot.S and make an edd
device driver to display such information in proc (similar to e820).

If this all works, we can remove lilo.conf guesswork like:
  bios=0x80
  disk=/dev/sda
  bios=0x81
  disk=/dev/hda
because we can query BIOS directly, and we can know exactly from
user-space, and we can actually get the SCSI driver load order
correct (assuming you trust BIOS to tell you the boot drive properly).


As always, I welcome your comments and feedback.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux




