Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbUKYDY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbUKYDY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUKYDYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:24:06 -0500
Received: from [205.240.79.3] ([205.240.79.3]:48827 "HELO
	construct.tekvizion.com") by vger.kernel.org with SMTP
	id S262954AbUKYDW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:22:58 -0500
Message-ID: <33175.24.1.49.23.1101346598.squirrel@webmail.tekvizion.com>
Date: Wed, 24 Nov 2004 19:36:38 -0600 (CST)
Subject: pdc202xx_old & Quantum Fireball LM10.2
From: "Chase Venters" <chase@tekvizion.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I've got a PDC20262 (FastTrak66). I've recently ditched Win2k for
Linux as my primary desktop. Linux is installed on a new HD on my
motherboard's IDE controller. I'm trying to mount my NTFS RAID0 in
order to transfer my e-mail archives and other data. My kernel version
is 2.6.9.

    The userland tool dmraid does not detect any PDC RAID on my 4-disk
stripe. I understand this list is for kernel discussion, so let me get
to the point. I've been doing as much diagnostics as possible, and
I've noticed a few things:

The CHS of my drives are 4996/255/63. Linux detects this wrong:

bash-2.05b# hdparm -i /dev/hde

 /dev/hde:

  Model=QUANTUM FIREBALLP LM10.2, FwRev=A35.0700, SerialNo=182004255484
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
  BuffType=DualPortCache, BuffSize=1900kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=20066251
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 *udma4
  AdvancedPM=no WriteCache=enabled
  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:

  * signifies the current active mode

Setting the CHS manually on the kernel arguments list does set the Logical
CHS, but does not allow the userland tool to detect my RAID partition.

I tried using FDISK to see what it would see in the partition table, but
fdisk /dev/hde reports "Unable to seek" - with and without manual CHS
specification. Interestingly enough, fdisk does not complain about this
for hdf-hdh (the other 3 disks in my stripe).

The disks are Quantum FireballP LM10.2's, so I tried adding the model
string to the pci_quirks table in the pdc202xx_old.h file. I'm not sure
that this would have anything to do with it, but regardless, no change in
behavior.

Here's the dmesg output of pdc202xx_old (with debugging enabled):

PDC20262: IDE controller at PCI slot 0000:00:05.0
 ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
 PDC20262: chipset revision 1
 PDC20262: ROM enabled at 0xdffc0000
 PDC20262: 100% native mode on irq 16
 PDC20262: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
     ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
 Probing IDE interface ide2...
 hde: QUANTUM FIREBALLP LM10.2, ATA DISK drive
 hdf: QUANTUM FIREBALLP LM10.2, ATA DISK drive
 hde: PIO 4 drive0 0x004123f0 0x004124f1
 hde: UDMA 4 drive0 0x004124f1 0x004124f1
 hdf: PIO 4 drive1 0x004123f0 0x004124f1
 hdf: UDMA 4 drive1 0x004124f1 0x004124f1
 ide2 at 0xe800-0xe807,0xe402 on irq 16
 hde: max request size: 128KiB
 hde: 20066251 sectors (10273 MB) w/1900KiB Cache, CHS=19906/16/63, UDMA(66)
 hde: cache flushes not supported
  hde: hde1 hde2 < >
 hdf: max request size: 128KiB
 hdf: 20066251 sectors (10273 MB) w/1900KiB Cache, CHS=19906/16/63, UDMA(66)
 hdf: cache flushes not supported
  hdf: unknown partition table
 Probing IDE interface ide3...
 hdg: QUANTUM FIREBALLP LM10.2, ATA DISK drive
 hdh: QUANTUM FIREBALLP LM10.2, ATA DISK drive
 hdg: PIO 4 drive2 0x004123f0 0x004124f1
 hdg: UDMA 4 drive2 0x004124f1 0x004124f1
 hdh: PIO 4 drive3 0x004123f0 0x004124f1
 hdh: UDMA 4 drive3 0x004124f1 0x004124f1
 ide3 at 0xe000-0xe007,0xdc02 on irq 16
 hdg: max request size: 128KiB
 hdg: 20066251 sectors (10273 MB) w/1900KiB Cache, CHS=19906/16/63, UDMA(66)
 hdg: cache flushes not supported
  hdg: unknown partition table
 hdh: max request size: 128KiB
 hdh: 20066251 sectors (10273 MB) w/1900KiB Cache, CHS=19906/16/63, UDMA(66)
 hdh: cache flushes not supported
  hdh: unknown partition table


Interestingly enough, the driver sees two partitions on hde where fdisk
refuses to seek.

Any ideas? Am I on the right track with my diagnostics? I'm going to pitch
this fakeraid controller when I finish my transition, but I'm trying to
get my data at the moment.

Please carbon-copy me (chase@tekvizion.com) on replies as I'm not a
linux-kernel member at this time.

Thanks,
Chase Venters


