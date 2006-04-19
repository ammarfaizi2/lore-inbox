Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDSHF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDSHF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWDSHF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:05:29 -0400
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:5765 "EHLO
	vitelus.com") by vger.kernel.org with ESMTP id S1750714AbWDSHF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:05:28 -0400
Date: Wed, 19 Apr 2006 00:05:22 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Very strange RAID failure
Message-ID: <20060419070522.GL10304@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came back to my machine a few days ago and noticed strange behavior,
and then found this in the logs:


Apr 16 07:02:50 annexia kernel: ata1: command 0x35 timeout, stat 0x51 host_stat 0x60
Apr 16 07:02:50 annexia kernel: ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 16 07:02:50 annexia kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Apr 16 07:02:50 annexia kernel: ata1: error=0x04 { DriveStatusError }
Apr 16 07:02:50 annexia kernel: sd 0:0:0:0: SCSI error: return code = 0x8000002
Apr 16 07:02:50 annexia kernel: sda: Current: sense key: Aborted Command
Apr 16 07:02:50 annexia kernel:     Additional sense: No additional sense information
Apr 16 07:02:50 annexia kernel: end_request: I/O error, dev sda, sector 625137194
Apr 16 07:02:50 annexia kernel: raid5: Disk failure on sda4, disabling device. Operation continuing on 3 devices
Apr 16 07:02:50 annexia kernel: RAID5 conf printout:
Apr 16 07:02:50 annexia kernel:  --- rd:4 wd:3 fd:1
Apr 16 07:02:50 annexia kernel:  disk 0, o:0, dev:sda4
Apr 16 07:02:50 annexia kernel:  disk 1, o:1, dev:sdd4
Apr 16 07:02:50 annexia kernel:  disk 2, o:1, dev:sdb4
Apr 16 07:02:50 annexia kernel:  disk 3, o:1, dev:sdc4
Apr 16 07:02:50 annexia kernel: RAID5 conf printout:
Apr 16 07:02:50 annexia kernel:  --- rd:4 wd:3 fd:1
Apr 16 07:02:50 annexia kernel:  disk 1, o:1, dev:sdd4
Apr 16 07:02:50 annexia kernel:  disk 2, o:1, dev:sdb4
Apr 16 07:02:50 annexia kernel:  disk 3, o:1, dev:sdc4
Apr 16 11:45:31 annexia kernel: ata3: command 0x35 timeout, stat 0x51 host_stat 0x0
Apr 16 11:45:31 annexia kernel: ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 16 11:45:31 annexia kernel: ata3: status=0x51 { DriveReady SeekComplete Error }
Apr 16 11:45:31 annexia kernel: ata3: error=0x04 { DriveStatusError }
Apr 16 11:45:31 annexia kernel: sd 2:0:0:0: SCSI error: return code = 0x8000002
Apr 16 11:45:31 annexia kernel: sdc: Current: sense key: Aborted Command
Apr 16 11:45:31 annexia kernel:     Additional sense: No additional sense information
Apr 16 11:45:31 annexia kernel: end_request: I/O error, dev sdc, sector 625137194
Apr 16 11:45:31 annexia kernel: raid5: Disk failure on sdc4, disabling device. Operation continuing on 2 devices
Apr 16 11:45:31 annexia kernel: RAID5 conf printout:
Apr 16 11:45:31 annexia kernel:  --- rd:4 wd:2 fd:2
Apr 16 11:45:31 annexia kernel:  disk 1, o:1, dev:sdd4
Apr 16 11:45:31 annexia kernel:  disk 2, o:1, dev:sdb4
Apr 16 11:45:31 annexia kernel:  disk 3, o:0, dev:sdc4
Apr 16 11:45:31 annexia kernel: RAID5 conf printout:
Apr 16 11:45:31 annexia kernel:  --- rd:4 wd:2 fd:2
Apr 16 11:45:31 annexia kernel:  disk 1, o:1, dev:sdd4
Apr 16 11:45:31 annexia kernel:  disk 2, o:1, dev:sdb4
Apr 16 11:45:32 annexia kernel: printk: 7 messages suppressed.
Apr 16 11:45:32 annexia kernel: Buffer I/O error on device md2, logical block 38349541
Apr 16 11:45:32 annexia kernel: lost page write due to I/O error on md2
....

Thankfully I was able to force sdc (the second failure) back into the
array and back up all my data. I ran read-write badblocks scans on
both sda and sdc, and found bad blocks on sda but none on sdc. Looking
back over the log, I realized that the same sector was referenced in
the errors for both drives. Isn't it extremely unlikely for two
different hard drives to fail due to bad sectors at the same address,
and within hours of each other? I suspect there might be some Linux
bug at fault here, especially since the two drives in question are on
different controllers! (at least I assume they are from the dmesg
output)

Architecture is x86_64. Here are some portions of dmesg that may be
relevant:


Linux version 2.6.15.3 (root@annexia) (gcc version 4.0.3 20060128 (prerelease) (Debian 4.0.2-8)) #2 SMP Wed Feb 8 00:19:16 PST 2006

...

ata1: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata1: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata2: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 22
PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 6
sata_via 0000:00:0f.0: routed to hard irq line 6
ata3: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 22
ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 22
ata3: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata3: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_via
ata4: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata4: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_via
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3 sdd4
sd 3:0:0:0: Attached scsi disk sdd


Partition table of each disk in sectors:


Disk /dev/sda: 320.0 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders, total 625142448 sectors
Units = sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1              63      996029      497983+  82  Linux swap / Solaris
/dev/sda2          996030     1188809       96390   fd  Linux raid autodetect
/dev/sda3         1188810    10956329     4883760   fd  Linux raid autodetect
/dev/sda4        10956330   625137344   307090507+  fd  Linux raid autodetect

I notice that the sector number given in the errors is almost at the
end of the device. Is this just a coincidence?
