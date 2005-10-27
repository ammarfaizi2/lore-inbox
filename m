Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVJ0RKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVJ0RKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVJ0RKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:10:20 -0400
Received: from smtp.rol.ru ([194.67.1.9]:46484 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S1751300AbVJ0RKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:10:18 -0400
Message-ID: <436109ED.30105@rol.ru>
Date: Thu, 27 Oct 2005 21:10:05 +0400
From: Eugene Crosser <crosser@rol.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Lazarenko <vlad@lazarenko.net>
CC: Jens Axboe <axboe@suse.de>, Brett Russ <russb@emc.com>,
       linux-ide@vger.kernel.org, multiman@rol.ru,
       linux-kernel@vger.kernel.org
Subject: Re: Status of Marvell SATA driver (was Re: Trying latest sata_mv
 - and getting freeze)
References: <435F8AFF.3030404@rol.ru> <435F9737.3050409@emc.com> <435FA5D8.2090406@rol.ru> <20051027111650.GO4774@suse.de> <4360E3A0.70501@rol.ru> <4360E4D5.9070505@lazarenko.net>
In-Reply-To: <4360E4D5.9070505@lazarenko.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBB21269C39A8001C1BF27E31"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB21269C39A8001C1BF27E31
Content-Type: multipart/mixed;
 boundary="------------020307050706060303060107"

This is a multi-part message in MIME format.
--------------020307050706060303060107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vladimir Lazarenko wrote:
>>>>>> My hardware is SMP Supermicro with 6 disks on
>>>>>> Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
>>>>>> and the sata_mv.c is version 0.25 dated 22 Oct 2005
>>>>>>
>>>>>> The thing works with "old" mvsata340 driver, but the "new" kernel
>>>>>> with
>>>>>> your driver freezes when it starts to probe disks.  Even Magic SysRq
>>>>>> does not work.  The last lines I see on screen are like this:
>>>>>>
>>>>>> sata_mv version 0.25
>>>>>> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
>>>>>> sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
>>>>>> ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
>>>>>> ata2: .... <same things>            0xF8C24120 ...
>>>>>> ...
>>>>>> ata8: .... <same thing>             0xF8C38120 ...
>>>>>> ATA: abnormal status 0x80 on port 0xF8C2211C
>>>>>> ... <five more lines identical to the above>
>>>>>> ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
>>>>>>
>>>>>> - and at this point it freezes hard.
>>>>>> Any suggestions for me?  Any information I can collect to help
>>>>>> troubleshooting?
>>>>
>>>>
>>>> [...]
>>>>
>>>>
>>>>> In the meantime, try turning off SMP and seeing if that makes a
>>>>> difference.  There still might be a problem with the spinlocks and
>>>>> if so
>>>>> it should go away in uniprocessor mode.
>>>>
>>>>
>>>> 'nosmp' makes no difference.
>>>
>>>
>>>
>>> Booting with nosmp isn't enough, you need to compile the kernel with
>>> CONFIG_SMP turned off. Otherwise the spinlocks will still be used and
>>> could cause a hard hang.
>>
>>
>>
>> Yeah, that was it!  It boots with the kernel compiled for UP.
>> (did not yet have a chance to check how it works).
>> Any chance that somebody competent would fix the driver for SMP?
> 
> 
> Umm, that sounds freakingly familiar to what I just had with sata_nv...
> Try "noapic" in smp mode, will that help?

Yesterday, I tried it and it did not help.

> And just in case, did you try 2.6.14-rc5? That was the kernel that fixed
> my similar problem "out-of-the-box".

I pulled up todays's git version (yesterdays's claimed to be 'rc5' as
well), and all of a sudden it booted in SMP mode, without any magic from
my side.  So, the freeze problem is apparently fixed now.

Now I ran into next problem.  I have the controller with 8 channels, and
first 6 of them have disks connected.  Disks are identical, and
mvsata340 driver recognizes them all.  But sata_mv attaches first two
disks, then fails to recognize the next two, then successfully attaches
the last two.  So I end up with 4 disks online, out of 6.  I am
attaching relevant excerpts from dmesg, and similar portion from syslog
of 2.6.11.12 kernel with mvsata340 driver.  (The latter does attach all
six disks).

Any suggestions?
Eugene

--------------020307050706060303060107
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

libata version 1.12 loaded.
sata_mv version 0.25
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 21
sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8CA2120 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8CA4120 bmdma 0x0 irq 21
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8CA6120 bmdma 0x0 irq 21
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8CA8120 bmdma 0x0 irq 21
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8CB2120 bmdma 0x0 irq 21
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8CB4120 bmdma 0x0 irq 21
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8CB6120 bmdma 0x0 irq 21
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8CB8120 bmdma 0x0 irq 21
ATA: abnormal status 0x80 on port 0xF8CA211C
ATA: abnormal status 0x80 on port 0xF8CA211C
ATA: abnormal status 0x80 on port 0xF8CA211C
ATA: abnormal status 0x80 on port 0xF8CA211C
ATA: abnormal status 0x80 on port 0xF8CA211C
ATA: abnormal status 0x80 on port 0xF8CA211C
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ATA: abnormal status 0x80 on port 0xF8CA411C
ATA: abnormal status 0x80 on port 0xF8CA411C
ATA: abnormal status 0x80 on port 0xF8CA411C
ATA: abnormal status 0x80 on port 0xF8CA411C
ATA: abnormal status 0x80 on port 0xF8CA411C
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_mv
ATA: abnormal status 0x80 on port 0xF8CA611C
ATA: abnormal status 0x80 on port 0xF8CA611C
ATA: abnormal status 0x80 on port 0xF8CA611C
ATA: abnormal status 0x80 on port 0xF8CA611C
ATA: abnormal status 0x80 on port 0xF8CA611C
ATA: abnormal status 0x80 on port 0xF8CA611C
ata3: PIO error, drv_stat 0x50
ata3: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata3: no dma
ata3: dev 0 not supported, ignoring
scsi2 : sata_mv
ATA: abnormal status 0x80 on port 0xF8CA811C
ATA: abnormal status 0x80 on port 0xF8CA811C
ATA: abnormal status 0x80 on port 0xF8CA811C
ATA: abnormal status 0x80 on port 0xF8CA811C
ATA: abnormal status 0x80 on port 0xF8CA811C
ATA: abnormal status 0x80 on port 0xF8CA811C
ata4: PIO error, drv_stat 0x50
ata4: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata4: no dma
ata4: dev 0 not supported, ignoring
scsi3 : sata_mv
ATA: abnormal status 0x80 on port 0xF8CB211C
ATA: abnormal status 0x80 on port 0xF8CB211C
ATA: abnormal status 0x80 on port 0xF8CB211C
ATA: abnormal status 0x80 on port 0xF8CB211C
ATA: abnormal status 0x80 on port 0xF8CB211C
ATA: abnormal status 0x80 on port 0xF8CB211C
ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata5: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_mv
ATA: abnormal status 0x80 on port 0xF8CB411C
ATA: abnormal status 0x80 on port 0xF8CB411C
ATA: abnormal status 0x80 on port 0xF8CB411C
ATA: abnormal status 0x80 on port 0xF8CB411C
ATA: abnormal status 0x80 on port 0xF8CB411C
ATA: abnormal status 0x80 on port 0xF8CB411C
ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata6: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata6: dev 0 configured for UDMA/133
scsi5 : sata_mv
ata7: no device found (phy stat 00000000)
scsi6 : sata_mv
ata8: no device found (phy stat 00000000)
scsi7 : sata_mv
  Vendor: ATA       Model: ST3400832AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3400832AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3400832AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3400832AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
Attached scsi disk sdd at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi5, channel 0, id 0, lun 0,  type 0
[...]
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 228k freed
Assertion failed! 0 == (sg_len & ~MV_DMA_BOUNDARY),drivers/scsi/sata_mv.c,mv_fill_sg,line=799
[... many lines identical to the above ...]

--------------020307050706060303060107
Content-Type: text/plain;
 name="mvsata"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mvsata"

mv_sata: module license 'Marvell' taints kernel.
Core Driver (ERROR)  0 : disable pci conventional features when working in PCI-X. pciCommand original value:0x0107e371. new value: 0x0107e011.
Core Driver (ERROR)  0  : PCI-X Master Write combine enable rejected
Core Driver (ERROR)  0 3: SStatusRegs = 121 ; retrying communication...Core Driver (ERROR)  0 3: in Channel Hard Reset SATA communication not established.
Core Driver (ERROR)  0 3: New SStatus is 123
Core Driver (ERROR) 0 3: Edma Error Reg 0x38
Core Driver (ERROR) 0 3: Edma Error Reg 0x20 still set!!!!!!!!
Core Driver (ERROR)  0 3: in Channel Hard Reset SATA communication not established.
Oct 27 20:33:05 snfs2 last message repeated 2 times
Core Driver (ERROR) 0 3: Edma Error Reg 0x30
Core Driver (ERROR) 0 3: Edma Error Reg 0x20 still set!!!!!!!!
Core Driver (ERROR) 0 3: Flush DMA, type=CALLBACK, commands 0 (on EDMA 0)
Linux IAL (ERROR) : retry command host=0, bus=0 SCpnt = f7d1f200
Linux IAL (ERROR) : retry command host=0, bus=0 SCpnt = f7d1f200
SAL (ERROR) mvExecuteScsiCommand: ERROR: Unsupported command A0
SAL (ERROR)  0 0 0 :Scsi command completed. pScb f7cbed00, ScsiStatus 2 completionStatus MV_SCSI_COMPLETION_BAD_SCSI_COMMAND
SAL (ERROR) CDB:a0 0 0 0 0 0 0 0 10 0 0 0 
SAL (ERROR) Sense Data:70 0 5 0 0 0 0 a 0 0 0 0 20 0 0 0 0 0 
Linux IAL (ERROR) : retry command host=1, bus=1 SCpnt = f7d1f200
Linux IAL (ERROR) : retry command host=1, bus=1 SCpnt = f7d1f200
SAL (ERROR) mvExecuteScsiCommand: ERROR: Unsupported command A0
SAL (ERROR)  0 1 0 :Scsi command completed. pScb f7cbea80, ScsiStatus 2 completionStatus MV_SCSI_COMPLETION_BAD_SCSI_COMMAND
SAL (ERROR) CDB:a0 0 0 0 0 0 0 0 10 0 0 0 
SAL (ERROR) Sense Data:70 0 5 0 0 0 0 a 0 0 0 0 20 0 0 0 0 0 
Linux IAL (ERROR) : retry command host=2, bus=2 SCpnt = f7d1f200
Linux IAL (ERROR) : retry command host=2, bus=2 SCpnt = f7d1f200
SAL (ERROR) mvExecuteScsiCommand: ERROR: Unsupported command A0
SAL (ERROR)  0 2 0 :Scsi command completed. pScb f7cbe800, ScsiStatus 2 completionStatus MV_SCSI_COMPLETION_BAD_SCSI_COMMAND
SAL (ERROR) CDB:a0 0 0 0 0 0 0 0 10 0 0 0 
SAL (ERROR) Sense Data:70 0 5 0 0 0 0 a 0 0 0 0 20 0 0 0 0 0 
Linux IAL (ERROR) : retry command host=3, bus=3 SCpnt = f7d1f200
Linux IAL (ERROR) : retry command host=3, bus=3 SCpnt = f7d1f200
SAL (ERROR) mvExecuteScsiCommand: ERROR: Unsupported command A0
SAL (ERROR)  0 3 0 :Scsi command completed. pScb f7cbe600, ScsiStatus 2 completionStatus MV_SCSI_COMPLETION_BAD_SCSI_COMMAND
SAL (ERROR) CDB:a0 0 0 0 0 0 0 0 10 0 0 0 
SAL (ERROR) Sense Data:70 0 5 0 0 0 0 a 0 0 0 0 20 0 0 0 0 0 
Linux IAL (ERROR) : retry command host=4, bus=4 SCpnt = f7d1f200
Linux IAL (ERROR) : retry command host=4, bus=4 SCpnt = f7d1f200
SAL (ERROR) mvExecuteScsiCommand: ERROR: Unsupported command A0
SAL (ERROR)  0 4 0 :Scsi command completed. pScb f7cbe380, ScsiStatus 2 completionStatus MV_SCSI_COMPLETION_BAD_SCSI_COMMAND
SAL (ERROR) CDB:a0 0 0 0 0 0 0 0 10 0 0 0 
SAL (ERROR) Sense Data:70 0 5 0 0 0 0 a 0 0 0 0 20 0 0 0 0 0 
Linux IAL (ERROR) : retry command host=5, bus=5 SCpnt = f7d1f200
Linux IAL (ERROR) : retry command host=5, bus=5 SCpnt = f7d1f200
SAL (ERROR) mvExecuteScsiCommand: ERROR: Unsupported command A0
SAL (ERROR)  0 5 0 :Scsi command completed. pScb f7cbe100, ScsiStatus 2 completionStatus MV_SCSI_COMPLETION_BAD_SCSI_COMMAND
SAL (ERROR) CDB:a0 0 0 0 0 0 0 0 10 0 0 0 
SAL (ERROR) Sense Data:70 0 5 0 0 0 0 a 0 0 0 0 20 0 0 0 0 0 

--------------020307050706060303060107--

--------------enigBB21269C39A8001C1BF27E31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYQnxtQFsU5rTNjcRAiQnAJ9fG2RmUKRPJyWpU1aVqfBY2+coPQCdEqW5
50SG0EACIEvI+VoaF9cLFzo=
=gT1m
-----END PGP SIGNATURE-----

--------------enigBB21269C39A8001C1BF27E31--
