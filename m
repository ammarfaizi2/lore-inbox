Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVFTCD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVFTCD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 22:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFTCD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 22:03:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:52178 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261381AbVFTCDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 22:03:08 -0400
From: Marcel Naziri <silent@zwobbl.de>
Organization: FB Mathematik - =?iso-8859-15?q?Universit=E4t?= Mainz
To: linux-kernel@vger.kernel.org
Subject: sata_promise KERNEL_BUG on 2.6.12
Date: Mon, 20 Jun 2005 04:02:52 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506200402.55229.silent@zwobbl.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:545ea3034f044b93d4367384da2b15f2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is my first posting to the LKML and I have to report a problem with the 
sata_promise driver:
I've installed a Promise SATAII-150 TX4 with two Samsung drives. One drive is 
native SATA, the other is adapted via some Silicon Image SATA-PATA-bridge.

$ cat /proc/version
Linux version 2.6.12 (root@Carter) (gcc version 4.0.1 20050522 (prerelease) 
(Debian 4.0.0-9)) #1 Mon Jun 20 01:27:35 CEST 2005

Now, when I connect the drives to port 1 & 2 of the controller, booting up 
stops with this:
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8802380 ctl 0xF88023B8 bdma 0x0 irq 17
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
------------[ cut here ]------------
kernel BUG at drivers/scsi/libata-core.c:2077!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c025f60f>]     Not tainted VLI
EFLAGS: 00010246   (2.6.12)
EIP is at ata_dev_set_xfermode+0xcf/0xf0
eax: 00000000   ebx: c1bdea7c   ecx: 00000000   edx: 00000000
esi: c1bdea7c   edi: c1bdea00   ebp: c193fe2c   esp: c193fe24
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c193e000 task=c18f6a20)
Stack: c1bdea00 c1bdea7c 00000000 c193fe30 c193fe30 c1bdea7c c1bdea7c c1bdea00
       00000001 c025e813 c1bdea00 c1bdea7c 0000003f c1bdea00 c1bdea00 c1bdea7c
       00000440 c025eabd c1bdea00 c1bdea7c 00000000 00000000 45000001 c1bdea00
Call Trace:
 [<c025e813>] ata_dev_set_mode+0x53/0x110
 [<c025eabd>] ata_set_mode+0x7d/0xd0
 [<c025e5f8>] ata_bus_probe+0xb8/0xd0
 [<c0261605>] ata_device_add+0x215/0x2d0
 [<c02644e3>] pdc_ata_init_one+0x223/0x2e0
 [<c01cf605>] pci_device_probe_static+0x45/0x50
 [<c01cf64b>] __pci_device_probe+0x3b/0x60
 [<c01cf69c>] pci_device_probe+0x2c/0x50
 [<c022638f>] driver_probe_device+0x2f/0x80
 [<c0226509>] driver_attach+0x59/0x90
 [<c02269e8>] bus_add_driver+0x98/0xe0
 [<c01cf915>] pci_register_driver+0x55/0x90
 [<c03da70f>] pdc_ata_init+0xf/0x20
 [<c03bc948>] do_initcalls+0x58/0xd0
 [<c01002b0>] init+0x0/0x120
 [<c01002df>] init+0x2f/0x120
 [<c0101334>] kernel_thread_helper+0x0/0xc
 [<c0101339>] kernel_thread_helper+0x5/0xc
Code: 8b 74 24 18 8b 7c 24 1c 8b 6c 24 20 83 c4 24 c3 89 e8 e8 05 c5 08 00 8b 
5c 24 14 8b 74 24 18 8b 7c 24 1c 8b 6c 24 20 83 c4 24 c3 <0f> 0b 1d 08 16 fc 
30 c0
 e9 6d ff ff ff e8 0f c4 08 00 eb ad 8d
 <0>Kernel panic - not syncing: Attempted to kill init!

When I connect the drives on port 3 & 4 of the controller, kernel gets 
running:
libata version 1.11 loaded.
sata_promise version 1.01
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8802380 ctl 0xF88023B8 bmdma 0x0 irq 17
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 
88:80ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 
88:203f
ata3: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SV1604N   Rev: TR10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0

Can it deal with the fact, that the drives are not scanned in port order of 
the controller? They seem to be mapped like
port 1 > ata4
port 2 > ata2
port 3 > ata1
port 4 > ata3

With Promise ulsata driver on 2.4.x kernels i have no problems with drives 
connected on port 1 & 2.
What can I do? If more info is needed, please bug me... :)

Thanks for help!
     zwobbl
