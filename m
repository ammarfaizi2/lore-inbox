Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSKGGpb>; Thu, 7 Nov 2002 01:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266380AbSKGGpb>; Thu, 7 Nov 2002 01:45:31 -0500
Received: from web14102.mail.yahoo.com ([216.136.172.132]:36913 "HELO
	web14102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266379AbSKGGp2>; Thu, 7 Nov 2002 01:45:28 -0500
Message-ID: <20021107065208.91462.qmail@web14102.mail.yahoo.com>
Date: Wed, 6 Nov 2002 22:52:08 -0800 (PST)
From: Helmut Apfelholz <helmutapfel@yahoo.com>
Subject: IDE and possibly ext3 problems
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to report a problem with IDE that I see both
with AC kernel (2.4.20pre10ac2) and with 2.4.20rc1
kernel.

I this in logs:

b3 kernel: hdm: timeout waiting for DMA
b3 kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
b3 kernel: hdm: status timeout: status=0xd0 { Busy }
b3 kernel: hdm: drive not ready for command
Nov  

and the server start to generate increasingly higher
loads as it waits for the disk. With ac kernel we were
forced to reset the machine. After it came up, we've
noticed in the logs:

b3 kernel: 09:08: rw=0, want=1160335696,
limit=78129984
b3 kernel: attempt to access beyond end of device
b3 kernel: 09:08: rw=0, want=1160335696,
limit=78129984

At that moment we replaced the hdm disk with the new
one. (it was part of the RAID1 set with hdo device)
We successfully sync'ed the disk while machine was
idle.

One day later the machine crashed with the same errors
and the filesystem on the partition on that device was
corrupted we had to manually run fsck, about 80
directories were moved to lost+found. (the offending
disk was /dev/hdm being in RAID1 set with /dev/hdo).
The hdm disk was not imported to the array and stayed
offline. We replaced the kernel with 2.4.20pre11 and
didn't try to import the device into the array.
We havent seen any errors in that situation for
several days, and the machine was under normal load.

Tonight we changed the kernel to the 2.4.20rc1 and
tried to import the device into the array. This
resulted in the exact ide timeout errors as before, we
immidiatelly tried to reboot the machine, and it
finally rebooted after several minutes of waiting for
the device. Now we are running with hdm device offline
and see no errors. Ah, it looks like hdm disk isn't in
the dmesg output anymore:

2.40.20rc1 before importing hdm:

b3 kernel: ServerWorks CSB5: IDE controller on PCI bus
00 dev 79
b3 kernel: ServerWorks CSB5: chipset revision 147
b3 kernel: ServerWorks CSB5: not 100%% native mode:
will probe irqs later
b3 kernel: ServerWorks CSB5: ATA-66/100 forced bit set
(WARNING)!!
b3 kernel:     ide0: BM-DMA at 0x24a0-0x24a7, BIOS
settings: hda:DMA, hdb:pio
b3 kernel: ServerWorks CSB5: ATA-66/100 forced bit set
(WARNING)!!
b3 kernel:     ide1: BM-DMA at 0x24a8-0x24af, BIOS
settings: hdc:DMA, hdd:pio
b3 kernel: PDC20267: IDE controller on PCI bus 00 dev
48
b3 kernel: PDC20267: chipset revision 2
b3 kernel: PDC20267: not 100%% native mode: will probe
irqs later
b3 kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary
PCI Mode Secondary PCI Mode.
b3 kernel:     ide2: BM-DMA at 0x2440-0x2447, BIOS
settings: hde:DMA, hdf:pio
b3 kernel:     ide3: BM-DMA at 0x2448-0x244f, BIOS
settings: hdg:DMA, hdh:DMA
b3 kernel: CMD649: IDE controller on PCI bus 00 dev 40
b3 kernel: CMD649: chipset revision 2
b3 kernel: CMD649: not 100%% native mode: will probe
irqs later
b3 kernel:     ide4: BM-DMA at 0x2490-0x2497, BIOS
settings: hdi:pio, hdj:pio
b3 kernel:     ide5: BM-DMA at 0x2498-0x249f, BIOS
settings: hdk:pio, hdl:pio
b3 kernel: CMD649: IDE controller on PCI bus 00 dev 38
b3 kernel: CMD649: chipset revision 2
b3 kernel: CMD649: not 100%% native mode: will probe
irqs later
b3 kernel:     ide6: BM-DMA at 0x2480-0x2487, BIOS
settings: hdm:pio, hdn:pio
b3 kernel:     ide7: BM-DMA at 0x2488-0x248f, BIOS
settings: hdo:pio, hdp:pio
b3 kernel: hda: ST380021A, ATA DISK drive
b3 kernel: hdc: ST380021A, ATA DISK drive
b3 kernel: hde: ST380021A, ATA DISK drive
b3 kernel: hdg: ST380021A, ATA DISK drive
b3 kernel: hdi: ST380021A, ATA DISK drive
b3 kernel: hdk: ST380021A, ATA DISK drive
b3 kernel: hdm: ST380021A, ATA DISK drive
b3 kernel: hdo: ST380021A, ATA DISK drive
b3 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
b3 kernel: ide1 at 0x170-0x177,0x376 on irq 15
b3 kernel: ide2 at 0x24f0-0x24f7,0x24e6 on irq 7
b3 kernel: ide3 at 0x24e8-0x24ef,0x24e2 on irq 7
b3 kernel: ide4 at 0x24d8-0x24df,0x24ce on irq 10
b3 kernel: ide5 at 0x24d0-0x24d7,0x24ca on irq 10
b3 kernel: ide6 at 0x24c0-0x24c7,0x24b6 on irq 9
b3 kernel: ide7 at 0x24b8-0x24bf,0x24b2 on irq 9

after the import, errors and reboot the same kernel:

b3 kernel: ServerWorks CSB5: IDE controller on PCI bus
00 dev 79
b3 kernel: ServerWorks CSB5: chipset revision 147
b3 kernel: ServerWorks CSB5: not 100%% native mode:
will probe irqs later
b3 kernel: ServerWorks CSB5: ATA-66/100 forced bit set
(WARNING)!!
b3 kernel:     ide0: BM-DMA at 0x24a0-0x24a7, BIOS
settings: hda:DMA, hdb:pio
b3 kernel: ServerWorks CSB5: ATA-66/100 forced bit set
(WARNING)!!
b3 kernel:     ide1: BM-DMA at 0x24a8-0x24af, BIOS
settings: hdc:DMA, hdd:pio
b3 kernel: PDC20267: IDE controller on PCI bus 00 dev
48
b3 kernel: PDC20267: chipset revision 2
b3 kernel: PDC20267: not 100%% native mode: will probe
irqs later
b3 kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary
PCI Mode Secondary PCI Mode.
b3 kernel:     ide2: BM-DMA at 0x2440-0x2447, BIOS
settings: hde:DMA, hdf:pio
b3 kernel:     ide3: BM-DMA at 0x2448-0x244f, BIOS
settings: hdg:DMA, hdh:DMA
b3 kernel: CMD649: IDE controller on PCI bus 00 dev 40
b3 kernel: CMD649: chipset revision 2
b3 kernel: CMD649: not 100%% native mode: will probe
irqs later
b3 kernel:     ide4: BM-DMA at 0x2490-0x2497, BIOS
settings: hdi:pio, hdj:pio
b3 kernel:     ide5: BM-DMA at 0x2498-0x249f, BIOS
settings: hdk:pio, hdl:pio
b3 kernel: CMD649: IDE controller on PCI bus 00 dev 38
b3 kernel: CMD649: chipset revision 2
b3 kernel: CMD649: not 100%% native mode: will probe
irqs later
b3 kernel:     ide6: BM-DMA at 0x2480-0x2487, BIOS
settings: hdm:pio, hdn:pio
b3 kernel:     ide7: BM-DMA at 0x2488-0x248f, BIOS
settings: hdo:pio, hdp:pio
b3 kernel: hda: ST380021A, ATA DISK drive
b3 kernel: hdc: ST380021A, ATA DISK drive
b3 kernel: hde: ST380021A, ATA DISK drive
b3 kernel: hdg: ST380021A, ATA DISK drive
b3 kernel: hdi: ST380021A, ATA DISK drive
b3 kernel: hdk: ST380021A, ATA DISK drive
b3 kernel: hdo: ST380021A, ATA DISK drive
b3 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
b3 kernel: ide1 at 0x170-0x177,0x376 on irq 15
b3 kernel: ide2 at 0x24f0-0x24f7,0x24e6 on irq 7
b3 syslog: klogd startup succeeded
b3 kernel: ide3 at 0x24e8-0x24ef,0x24e2 on irq 7
b3 kernel: ide4 at 0x24d8-0x24df,0x24ce on irq 10
b3 kernel: ide5 at 0x24d0-0x24d7,0x24ca on irq 10
b3 kernel: ide7 at 0x24b8-0x24bf,0x24b2 on irq 9

hdm is missing.
This is SAI2 mobo with CSB5 onboard (had to force
ata100 on them, but works ok.), 1 promise and 2 cmd
based ata cards attached. Disks are 80Gb Barrakuda IV.
We are running ext3 on that partition in writeback
mode. RH 7.3 with updates applied.

Please advise what should we do to access hdm safely.
Thank you in advance.

Helmut



__________________________________________________
Do you Yahoo!?
U2 on LAUNCH - Exclusive greatest hits videos
http://launch.yahoo.com/u2
