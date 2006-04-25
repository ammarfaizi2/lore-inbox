Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWDYRC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWDYRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWDYRC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:02:29 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:304 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932265AbWDYRC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:02:28 -0400
Message-ID: <444E5620.50404@atipa.com>
Date: Tue, 25 Apr 2006 12:02:24 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 16:54:21.0167 (UTC) FILETIME=[E615D7F0:01C66888]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have several machines configured (10+) with K8N-DRE motherboards,
which have Nvidia CK804 chipsets and Sata controllers, all seem to
exhibit this behavior.   All machines have 16GB of ram, and are
running x86_64 versions.

With one disk running everything is fine, and there are no problems,
so if I do "dd if=/dev/sda of=/dev/null bs=64k" everything works,
if I background the command and start a second dd on sdb the io rate
about doubles (to 130k was about 65k) for about 1-2 seconds and then
goes to 0 and the machine hangs up (the dd's can be killed with alt-sysrq
keys or issuing a kill against the processes-but the processes are
in disk wait so it takes 10-30 seconds before the kill actually does
its job).   After the kill completes everything seems ok again, it
looks like access to the disks is completely blocked when this happens,
I cannot get anything that accesses the disks to run once the
dd's hang up.

I get these messages from dmesg when the event happens on 2.6.16:

ata1: command 0x25 timeout, stat 0x50 host_stat 0x24
ata2: command 0x25 timeout, stat 0x50 host_stat 0x24

On 2.6.17-rc2 the messages look slightly different:


ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
ata1: status=0x50 { DriveReady SeekComplete }
sda: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x3481ff
ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x166ff
ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
ata1: status=0x50 { DriveReady SeekComplete }
sda: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x3482ff
ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key: No Sense
     Additional sense: No additional sense information
Info fld=0x167ff
ata1: command 0xca timeout, stat 0x50 host_stat 0x24
ata1: status=0x50 { DriveReady SeekComplete }


The bootup messages for the disks look like this:

SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xF000 ctl 0xEC02 bmdma 0xE000 irq 7
ata2: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xE008 irq 7
logips2pp: Detected unknown logitech mouse model 1
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/100
scsi0 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113)
input: PS/2 Logitech Mouse as /class/input/input1
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata2: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata2: dev 0 configured for UDMA/100
scsi1 : sata_nv
   Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
  sda1
sd 0:0:0:0: Attached scsi disk sda
   Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is offsdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
  sdb1
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
sd 1:0:0:0: Attached scsi disk sdb
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xCC00 irq 5
ata4: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xCC08 irq 5
ata3: SATA link down (SStatus 0)
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv

I have not been able (so far) to get these messages only running
one disk at a time.  And it appears that I can run either disk by
itself with no issues.

I tested with 2 different FC5 2.6.16 variants, and with 2.6.17-rc2,
and both exhibit the same behavior.

What can I try to debug this?

                      Roger Heflin
