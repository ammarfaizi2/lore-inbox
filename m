Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbSJJDXJ>; Wed, 9 Oct 2002 23:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJJDXJ>; Wed, 9 Oct 2002 23:23:09 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:24244 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S263035AbSJJDXH>; Wed, 9 Oct 2002 23:23:07 -0400
Date: Wed, 9 Oct 2002 22:28:47 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@tux.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, <davej@suse.de>, <alan@redhat.com>
Subject: [PATCH] x86 BIOS Enhanced Disk Drive services
Message-ID: <Pine.LNX.4.44.0210092219120.9033-100000@tux.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd-tolinus

This will update the following files:

 Documentation/i386/zero-page.txt |    2 
 arch/i386/Config.help            |    8 
 arch/i386/boot/setup.S           |   47 +
 arch/i386/config.in              |    4 
 arch/i386/defconfig              |    1 
 arch/i386/kernel/Makefile        |    1 
 arch/i386/kernel/edd.c           |  984 +++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/i386_ksyms.c    |    6 
 arch/i386/kernel/setup.c         |   18 
 include/asm-i386/edd.h           |  168 ++++++
 include/asm-i386/setup.h         |    2 
 11 files changed, 1241 insertions

through these ChangeSets:

<Matt_Domsch@dell.com> (02/10/09 1.714.7.1)
   EDD: x86 BIOS Enhanced Disk Drive support
   
   The major changes implemented in this patch:
   arch/i386/boot/setup.S - int13 real mode calls store results in empty_zero_page
   arch/i386/kernel/setup.c - copy results from empty_zero_page to local storage
   arch/i386/kernel/edd.c - module exports results via driverfs
   
   x86 systems suffer from a disconnect between what BIOS believes is the
   boot disk, and what Linux thinks BIOS thinks is the boot disk.  This
   manifests itself in multi-disk systems - it's quite possible to
   install a distribution, only to fail on reboot - the disk installed to
   is not the disk BIOS is booting from.  Dell restricts our possible
   standard factory installed Linux offerings to "disks on no more than
   one controller" to avoid this problem, but mechanisms now exist to
   solve it and allow such configurations.
   
   BIOS Enhanced Disk Device Services (EDD) 3.0 provides the ability for
   disk adapter BIOSs to tell the OS what it believes is the boot disk.
   While this isn't widely implemented in BIOSs yet, it's time that Linux
   received support to be ready as BIOSs with this feature do become
   available.  At a minimum, LSI MegaRAID cards support this today.
   
   EDD works by providing the bus (PCI, PCI-X, ISA, InfiniBand, PCI
   Express, or HyperTransport) location (e.g. PCI 02:01.0) and interface
   (ATAPI, ATA, SCSI, USB, 1394, FibreChannel, I2O, RAID, SATA) location
   (e.g. SCSI ID 5 LUN 0) information for each BIOS int13 device.
   
   The patch below creates CONFIG_EDD, that when defined, makes the
   BIOS int13 calls to retrieve and store this information.  The data is
   copied to a safe place in setup.c, and exported via driverfs.
   
   Here's a sample driverfs tree with two BIOS int13 devices - dev 80 has
   incorrect PCI bus information, thus no symlinks are made, but as much
   info as possible is presented.  Dev 81 has correct PCI and SCSI
   information, thus symlinks are made to the actual disc device.
   
   /driverfs
   |-- bios
   |   |-- int13_dev80
   |   |   |-- extensions
   |   |   |-- host_bus
   |   |   |-- info_flags
   |   |   |-- interface
   |   |   |-- raw_data
   |   |   |-- sectors
   |   |   `-- version
   |   `-- int13_dev81
   |       |-- extensions
   |       |-- host_bus
   |       |-- info_flags
   |       |-- interface
   |       |-- pci_dev -> ../../root/pci2/02:0c.0/03:00.0/04:00.0
   |       |-- raw_data
   |       |-- disc -> ../../root/pci2/02:0c.0/03:00.0/04:00.0/scsi4/4:0:0:0
   |       |-- sectors
   |       `-- version
   |-- bus
   |   |-- scsi
   |   |   |-- devices
   |   |   |   |-- 4:0:0:0 -> ../../../root/pci2/02:0c.0/03:00.0/04:00.0/scsi4/4:0:0:0
   `-- root
       |-- pci2
       |   |-- 02:0c.0
       |   |   |-- 03:00.0
       |   |   |   |-- 04:00.0
       |   |   |   |   `-- scsi4
       |   |   |   |       |-- 4:0:0:0

   
   
   (Yes, the 'bios' top-level directory isn't the right place,
    and Patrick has promised to make something there in the future,
    at which point this can be moved.)
   
   The 'raw_data' file contains the full set of information returned by BIOS
   with extra error reporting.  This exists for vendor BIOS debugging purposes.
   
   The 'host-bus' file contains the PCI (or ISA, HyperTransport, ...)
   identifying information, as BIOS knows it.
   
   The 'interface' file contains the SCSI (or IDE, USB, ...) identifying
   information, as BIOS knows it.
   
   The 'extensions' file lists the BIOS EDD extensions per spec.
   The 'info_flags' file lists the BIOS EDD device information flags per spec.
   The 'sectors' file reports the number of sectors BIOS believes this
   device has.
   The 'version' file lists the EDD version.  To have device path
   information, this must be 0x30 or above.  Earlier EDD versions exist
   without the device path - as much information as is available is presented.
   
   At most 6 BIOS devices are reported, as that fills the space that's
   left in the empty_zero_page.  In general you only care about device
   80h, though for software RAID1 knowing what 81h is might be useful also.
   
   
   
   Known issues:
   - module unload leaves a directory around.  Seems related to
     creating symlinks in that directory.  Seen on kernel 2.5.41.
   - refcounting of struct device objects could be improved.
   
   TODO:
   - Add IDE and USB disk device support
   - when driverfs model of discs and partitions changes,
     update symlink accordingly.
   - Get symlink creator helper functions exported from
     drivers/base instead of duplicating them here.
   - move edd.[ch] to better locations if/when one is decided
   
   I'd also like to acknowledge the help and comments received from Greg
   KH and Patrick Mochel.  This isn't something driverfs was originally
   conceived to handle, their assistance has been invaluable.
   
   Also available as a patch (against 2.5.41+BK-current):
       http://domsch.com/linux/edd30/edd-driverfs-6.patch
       http://domsch.com/linux/edd30/edd-driverfs-6.patch.sign
   
Thanks,
Matt
 
-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


