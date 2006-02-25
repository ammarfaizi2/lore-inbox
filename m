Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWBYLeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWBYLeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWBYLeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:34:08 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:59109 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1030220AbWBYLeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:34:06 -0500
Message-ID: <440040B4.8030808@dgreaves.com>
Date: Sat, 25 Feb 2006 11:34:12 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
In-Reply-To: <200602141300.37118.lkml@rtr.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

>On Tuesday 14 February 2006 12:12, Justin Piszcz wrote:
>  
>
>>I would like to try the patch too, if available.
>>    
>>
>
>Something like this:  (for 2.6.16-rc3-git2, but should be okay on 2.6.15 also).
>
>Untested:  include the original SCSI opcode in printk's for libata SCSI errors,
>to help understand where the errors are coming from.
>
>Signed-Off-By:  Mark Lord <mlord@pobox.com>
>  
>
Thanks Mark - I've finally gotten this patch applied.

With smartd disabled and no smart commands issued, a readonly badblocks
scan of /dev/sdb2 shows no problems and now gives:
Feb 25 10:38:31 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Feb 25 10:38:32 haze kernel: ata2: no sense translation for op=0x28
status: 0x51
Feb 25 10:38:32 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Feb 25 10:38:35 haze kernel: ata2: no sense translation for op=0x28
status: 0x51
hundreds of times.

and during boot I can get:
ata2: no sense translation for op=0x28 status: 0x51
ata2: translated op=0x28 ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ata2: no sense translation for op=0x28 status: 0x51
ata2: translated op=0x28 ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x28 status: 0x51
ata2: translated op=0x28 ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }

Subsequently a
 smartclt -data -a /dev/sdb
shows no errors.
So could this be a faulty disk that smart shows is OK and shows no read
or write errors?

The other problem I noticed was that
 smartctl -o on -data /dev/sda
still just gives:
Feb 25 10:51:47 haze kernel: ata1: PIO error
Feb 25 10:51:47 haze kernel: ata1: status=0x51 { DriveReady SeekComplete
Error }
Feb 25 10:51:47 haze kernel: ata1: error=0x04 { DriveStatusError }
Feb 25 10:51:47 haze kernel: ata1: PIO error
Feb 25 10:51:47 haze kernel: ata1: status=0x51 { DriveReady SeekComplete
Error }
Feb 25 10:51:47 haze kernel: ata1: error=0x04 { DriveStatusError }
Feb 25 10:51:47 haze kernel: ata1: PIO error
many times.

I get similar problems for all the drives under both sata_sil and sata_via.


Linux haze 2.6.15patchsata #6 PREEMPT Fri Feb 24 19:15:07 UTC 2006 i686
GNU/Linux


libata version 1.20 loaded.
sata_sil 0000:00:0a.0: version 0.9
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 16 (level, low) -> IRQ 17
ata1: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A bmdma 0xF8804000
irq 17
ata2: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA bmdma 0xF8804008
irq 17
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4043 85:7869 86:3c01 87:4043
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063
88:007f
ata2: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
sata_via 0000:00:0f.0: routed to hard irq line 0
ata3: SATA max UDMA/133 cmd 0x9800 ctl 0x9402 bmdma 0x8400 irq 16
ata4: SATA max UDMA/133 cmd 0x9000 ctl 0x8802 bmdma 0x8408 irq 16
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3468 86:3c01 87:4003
88:407f
ata3: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_via
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c68 86:3e01 87:4063
88:407f
ata4: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_via
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0



David

-- 

