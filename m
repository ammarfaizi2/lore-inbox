Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSJMEqL>; Sun, 13 Oct 2002 00:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJMEqL>; Sun, 13 Oct 2002 00:46:11 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:43957 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261425AbSJMEqI>; Sun, 13 Oct 2002 00:46:08 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Matt Domsch'" <Matt_Domsch@Dell.com>
Cc: "'Linux Kernel Development List'" <linux-kernel@vger.kernel.org>
Subject: RE: [CFT][PATCH 2.5] x86 BIOS Enhanced Disk Drive services
Date: Sat, 12 Oct 2002 23:51:46 -0500
Message-ID: <001d01c27274$42da70e0$b7261c43@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68A3E27C-100000@AUSXMPC122.aus.amer.dell.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure!  Will I get paid?  Cause I sure as hell am not working for free.

This sounds like one of those cases where you want us to do your work
for you Mr. "Sr. Software Engineer, Lead Engineer, Architect" of Dell
Computer Corporation.

You've got a bigger budget for software and hardware testing than we do.

(The nerve of some people.)

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Matt Domsch
Sent: Saturday, October 12, 2002 10:55 PM
To: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH 2.5] x86 BIOS Enhanced Disk Drive services

Call For Testers - x86 BIOS Enhanced Disk Drive Services

x86 systems suffer from a disconnect between what BIOS believes is the
boot disk, and what Linux thinks BIOS thinks is the boot disk.  This
manifests itself in multi-disk systems - it's quite possible to
install a distribution, only to fail on reboot - the disk installed to
is not the disk BIOS is booting from.

BIOS Enhanced Disk Device Services (EDD) 3.0 provides the ability for
disk adapter BIOSs to tell the OS what it believes is the boot disk.
While this isn't widely implemented in BIOSs yet, it's time that Linux
received support to be ready as BIOSs with this feature do become
available.  At a minimum, LSI MegaRAID cards support this properly
today.  I'm taking reports of success/failure at
http://domsch.com/linux/edd30/results.html.

EDD works by providing the bus (PCI, PCI-X, ISA, InfiniBand, PCI
Express, or HyperTransport) location (e.g. PCI 02:01.0) and interface
(ATAPI, ATA, SCSI, USB, 1394, FibreChannel, I2O, RAID, SATA) location
(e.g. SCSI ID 5 LUN 0) information for each BIOS int13 device.

The patch below creates CONFIG_EDD, that when defined, makes the real
mode BIOS int13 calls (setup.S) to retrieve and store this information.
The
data is copied to a safe place (setup.c), and the edd module exports
it via driverfs.  This currently makes symlinks for PCI controllers
and SCSI disks - IDE disks will be added once their driverfs changes
settle down a bit (you can still get the disk info, just no symlinks.)


*** Call for Testers ***
I'd like to see this included in 2.5.x, and need some testers.  I
believe it to be safe and stable, though I know there are BIOSs that
either:
a) claim to support this and do it right (excellent!)
b) don't claim to support this (fine, they get ignored),
c) claim to support this but do so incorrectly (these are the ones
I've heard concerns about)

In all cases I've tried, the real mode int13 calls succeeded (none
locked a machine), and the expected amount of data was returned.  When
displaying the data, all cases of incorrect data I've come across are
flagged with warnings or errors when printing the 'raw_data' file for
the particular device.  When the data appears to be good, and referrs
to a PCI controller, a symlink in driverfs is made for that.  If it's
good and a SCSI disk, a symlink is made for that as well.  So far, no
tools (e.g. distro installers) make use of these symlinks or any of
the other reported data, so regardless what BIOS returns, there can be
no harm because we're only displaying it, not relying on it.  I'm
counting on human-generated reports to tell if this can generally be
useful, and which BIOS vendors I need to go flog.

Please try the patch, enable CONFIG_EDD=m, and load the 'edd' module.
You should see a 'bios' top-level directory in /driverfs, with each
BIOS-handled device listed under there.  Please see
http://domsch.com/linux/edd30/results.html for success/failure
reports, and send your own reports as described there.
*** Call for Testers ***


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
|       |-- disc ->
../../root/pci2/02:0c.0/03:00.0/04:00.0/scsi4/4:0:0:0
|       |-- sectors
|       `-- version
|-- bus
|   |-- scsi
|   |   |-- devices
|   |   |   |-- 4:0:0:0 ->
../../../root/pci2/02:0c.0/03:00.0/04:00.0/scsi4/4:0:0:0
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

The 'raw_data' file contains the full set of information returned by
BIOS with extra error reporting.  This exists for vendor BIOS
debugging purposes.  This is what I'm most interested in.

The 'host-bus' file contains the PCI (or ISA, HyperTransport, ...)
identifying information, as BIOS knows it.

The 'interface' file contains the SCSI (or IDE, USB, ...) identifying
information, as BIOS knows it.

The 'version' file lists the EDD version.  To have device path
information, this must be 0x30 or above.  Earlier EDD versions exist
without the device path - as much information as is available is
presented.

At most 6 BIOS devices are reported. In general you only care about
device
80h, though for software RAID1 knowing what 81h is might be useful also.


Known issues:
- edd module unload leaves a directory around.  Seems related to
  creating symlinks in that directory.  Seen on kernel 2.5.41.

TODO:
- Add IDE and USB disk device symlinks
- refcounting of struct device objects could be improved.
- when driverfs model of discs and partitions changes,
  update symlink accordingly.
- Get symlink creator helper functions exported from
  drivers/base instead of duplicating them here.
- move edd.[ch] to better locations if/when one is decided

The patch changes these files:

Documentation/i386/zero-page.txt |    2 
arch/i386/Config.help            |    8 
arch/i386/boot/setup.S           |   47 +
arch/i386/config.in              |    4 
arch/i386/defconfig              |    1 
arch/i386/kernel/Makefile        |    1 
arch/i386/kernel/edd.c           |  984
+++++++++++++++++++++++++++++++++++++
arch/i386/kernel/i386_ksyms.c    |    6 
arch/i386/kernel/setup.c         |   18 
include/asm-i386/edd.h           |  168 ++++++
include/asm-i386/setup.h         |    2 
11 files changed, 1241 insertions

BK:
  http://mdomsch.bkbits.net/linux-2.5-edd-tolinus
  EDD: x86 BIOS Enhanced Disk Drive support   <Matt_Domsch@dell.com>
(02/10/09 1.714.7.1)

Patch (against 2.5.{41,42}) (was also sent to l-k on 2002-10-09):
       http://domsch.com/linux/edd30/edd-driverfs-6.patch
       http://domsch.com/linux/edd30/edd-driverfs-6.patch.sign


Thanks for testing!
-Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

