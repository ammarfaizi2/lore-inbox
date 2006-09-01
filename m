Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWIAQFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWIAQFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWIAQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:05:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:63187 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932289AbWIAQFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:05:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hrZn3f+EZtO1OgBjB+2bctLJ9+oJQpor6LKWKX+EidcbpQ8Qw08YSBbsxAmXSfuxyNvH6/zsr8Smq90Mbmj7sdoaEtvBmZ/ytphGoX63svlWMRPUMV0O/swJ2V4MJi9TJWQ02Lj4Xu6MEBKEgrOOH/9HM/nFn/5B8Bv/xAwJIVA=
Message-ID: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
Date: Fri, 1 Sep 2006 09:05:12 -0700
From: Ethan <thesyntheticsophist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: File corruption with 2940U2 SCSI card and aic7xxx driver.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed an Adaptec 2940U2 controller and two disks in my
Debian Sarge system, kernel version 2.6.8.  Prior to this
installation, the system
had been a rock-solid IDE only system.  The card and drives are correctly
detected and identified by the kernel at boot.  Unfortunately, I am
experiencing consistent corruption on large files written to the SCSI
drives.  For example, if I copy a file from the old, stable IDE drive
to one of the SCSI disks using dd:

>dd if=alphabet of=/dev/sda1
205200+0 records in
205200+0 records out
105062400 bytes transferred in 5.480344 seconds (19170767 bytes/sec)

Then copy the file back:

>dd if=/dev/sda1 of=alphabet_ver2 count=205200
205200+0 records in
205200+0 records out
105062400 bytes transferred in 5.840856 seconds (17987500 bytes/sec)

The md5sums are different:

>md5sum alphabet alphabet_ver2
5a96c70a890ff479568f75c54abb82a8  alphabet
e507a5b662b5f528bb6aa3a489a0e04e  alphabet_ver2

The original file, "alphabet", contains the line
"abcdefghijklmnopqrstuvwxyz" repeated many times; however the file
read from the SCSI drive, "alphabet_ver2", contains a number lines
like "abcdefghijklmnopqrstubcdefghijklmnopqrstuvwxyz" and
"abcdopqrstuvwxyz" --- all the correct characters, just out of order.
Curiously, all of the corruption appears to occur when writing the
file to the disk, as reading the data from the disk a second time
yields the same corrupt data:

>dd if=/dev/sda1 of=alphabet_ver3 count=205200
205200+0 records in
205200+0 records out
105062400 bytes transferred in 5.840856 seconds (17987500 bytes/sec)
>md5sum alphabet alphabet_ver2 alphabet_ver3
5a96c70a890ff479568f75c54abb82a8  alphabet
e507a5b662b5f528bb6aa3a489a0e04e  alphabet_ver2
e507a5b662b5f528bb6aa3a489a0e04e  alphabet_ver3

The corruption on write appears to be different each time:

>dd if=alphabet of=/dev/sda1;\
dd if=/dev/sda1 of=alphabet_ver4 count=205200;md5sum alphabet*
205200+0 records in
205200+0 records out
105062400 bytes transferred in 5.488071 seconds (19143775 bytes/sec)
205200+0 records in
205200+0 records out
105062400 bytes transferred in 5.776168 seconds (18188944 bytes/sec)
5a96c70a890ff479568f75c54abb82a8  alphabet
e507a5b662b5f528bb6aa3a489a0e04e  alphabet_ver2
e507a5b662b5f528bb6aa3a489a0e04e  alphabet_ver3
40a369cb78d68f9b6d293dfd5012c87f  alphabet_ver4

You'll note that I've given up trying to create a filesystem on the
SCSI disk since the filesystem was always corrupted quickly and
fatally.  I have exhausted my ideas for troubleshooting this problem.
I would greatly appreciate any ideas for further troubleshooting.
Here is a brief list of what I have tried:

- Copying data to and from the other SCSI disk, sdb.
- Changing PCI slots and SCSI cables.
- The 2940 card does not share an interrupt with any other card.
- Trying the aic7xxx_old driver.
- Trying the new version of the aic7xxx driver with a 2.6.16 kernel.
- Disabling write caching on the drives.
- Enabling the debug information in the aic7xxx driver module (see
below for transcript).  There is no indication of problems from the
debug output.

In all cases, I get the same results.  This set of card, cable, and
drives worked flawlessly when it was removed from another computer
(which ran Windows and SUSE Linux).

A few relevant system details:

- Debian version 3.1 (Sarge)
- kernel-image-2.6.8-3-686 ver. 2.6.8-16sarge4 (primarily) and
linux-image-2.6.16-1-686 ver. 2.6.16-11bpo1 from backports.org
- Pentium III 500 MHz with 640 MB memory, VIA Apollo Pro 133 chipset

The relevant kernel messages during boot with full aic7xxx debug:

PCI: Found IRQ 11 for device 0000:00:0c.0
aic7xxx: PCI Device 0:12:0 failed memory mapped test.  Using PIO.
ahc_pci:0:12:0: Reading SEEPROM...done.
ahc_pci:0:12:0: BIOS eeprom is present
ahc_pci:0:12:0: Secondary High byte termination Enabled
ahc_pci:0:12:0: Secondary Low byte termination Enabled
ahc_pci:0:12:0: Primary Low Byte termination Enabled
ahc_pci:0:12:0: Primary High Byte termination Enabled
ahc_pci:0:12:0: Downloading Sequencer Program... 423 instructions downloaded
ahc_pci:0:12:0: Features 0x56f6, Bugs 0x6, Flags 0x20485440
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: Slave Alloc 0
(scsi0:A:0:0): Sending WDTR 1
(scsi0:A:0:0): Received WDTR 1 filtered to 1
(scsi0:A:0): 1.960MB/s transfers (0.980MHz , offset 255, 16bit)
scsi0: target 0 using 16bit transfers
(scsi0:A:0:0): Sending SDTR period a, offset 7f
(scsi0:A:0:0): Received SDTR period a, offset 7f
        Filtered to period a, offset 7f
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
scsi0: target 0 synchronous at 40.0MHz, offset = 0x7f
  Vendor: QUANTUM   Model: ATLAS10K2-TY367L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: Slave Configure 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
scsi0: Slave Alloc 1
scsi0: Slave Destroy 1
scsi0: Slave Alloc 2
scsi0: Slave Destroy 2
scsi0: Slave Alloc 3
scsi0: Slave Destroy 3
scsi0: Slave Alloc 4
scsi0: Slave Destroy 4
scsi0: Slave Alloc 5
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
scsi0: Slave Destroy 5
scsi0: Slave Alloc 6
(scsi0:A:6:0): Sending WDTR 1
(scsi0:A:6:0): Received WDTR 1 filtered to 1
(scsi0:A:6): 1.960MB/s transfers (0.980MHz, offset 255, 16bit)
scsi0: target 6 using 16bit transfers
(scsi0:A:6:0): Sending SDTR period a, offset 7f
(scsi0:A:6:0): Received SDTR period a, offset 3f
        Filtered to period a, offset 3f
(scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
scsi0: target 6 synchronous at 40.0MHz, offset = 0x3f
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: Slave Configure 6
(scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
scsi0:A:6:0: Tagged Queuing enabled.  Depth 8
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target6/lun0: p1 p2
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
scsi0: Slave Alloc 8
scsi0: Slave Destroy 8
scsi0: Slave Alloc 9
scsi0: Slave Destroy 9
scsi0: Slave Alloc 10
scsi0: Slave Destroy 10
scsi0: Slave Alloc 11
scsi0: Slave Destroy 11
scsi0: Slave Alloc 12
scsi0: Slave Destroy 12
scsi0: Slave Alloc 13
scsi0: Slave Destroy 13
scsi0: Slave Alloc 14
scsi0: Slave Destroy 14
scsi0: Slave Alloc 15
scsi0: Slave Destroy 15

The aic7xxx driver does not emit any further kernel messages.  The
aic7xxx module
is loaded with the following flags:  verbose,debug:0xffff,pci_parity

Please CC me directly with any comments or ideas you have.  Thanks for
your time.

--Ethan
