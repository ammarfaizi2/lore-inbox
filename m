Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSDCWDt>; Wed, 3 Apr 2002 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312314AbSDCWDk>; Wed, 3 Apr 2002 17:03:40 -0500
Received: from 213-98-219-83.uc.nombres.ttd.es ([213.98.219.83]:40322 "EHLO
	pantuflo.bluepotato.org") by vger.kernel.org with ESMTP
	id <S312238AbSDCWDb>; Wed, 3 Apr 2002 17:03:31 -0500
Message-ID: <3CAB7C24.58E63B12@unex.es>
Date: Thu, 04 Apr 2002 00:03:16 +0200
From: Alfonso Gazo <agazo@unex.es>
Organization: Universidad de Extremadura
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: es,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.18] /proc/stat does not show disk_io stats for all IDE disks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

After installing noflushd daemon, I noticed it couldn't access the
disk_io stats for all IDE disks attached to my system, but only the
attached to the motherboard IDE controller. The ones that doesn't appear
in /proc/stat are the disks attached to a Promise Ultra66 PCI IDE card.
I reproduced this problem with 2.4.18, 2.4.17 and 2.4.7 kernels.

The dmesg log says:

[snip]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
PDC20262: IDE controller on PCI bus 00 dev 60
PCI: Found IRQ 11 for device 00:0c.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0xe6000000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:DMA
hda: WDC AC26400R, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 8200a, ATAPI CD/DVD-ROM drive
hdd: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
hde: FUJITSU MPF3204AT, ATA DISK drive
hdf: SAMSUNG SV1363D, ATA DISK drive
hdg: ST34321A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
ide3 at 0xd400-0xd407,0xd802 on irq 11
hda: 12594960 sectors (6449 MB) w/512KiB Cache, CHS=784/255/63, UDMA(33)

hde: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=39714/16/63,
UDMA(66)
hdf: 26704944 sectors (13673 MB) w/472KiB Cache, CHS=26493/16/63,
UDMA(66)
hdg: 8404830 sectors (4303 MB) w/128KiB Cache, CHS=8894/15/63, UDMA(33)
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [2491/255/63] p1 p2
 /dev/ide/host2/bus0/target1/lun0: [PTBL] [1662/255/63] p1
 /dev/ide/host2/bus1/target0/lun0: [PTBL] [523/255/63] p1
[snip]



and /proc/stat:

cpu  236858 1312 135141 11160152
cpu0 236858 1312 135141 11160152
page 3543213 3135617
swap 960 6548
intr 15247980 11533463 5 0 2317048 9 0 6 2 13 38 685775 131102 17694 0
562825 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (3,0):(563528,191285,4274540,372243,5517288)
ctxt 20869017
btime 1017755929
processes 449083


Is there any patch that could be applied to the 2.4.x kernel series to
get this thing working?

Thanks in advance,

--
Alfonso

