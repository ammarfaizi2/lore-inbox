Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277047AbRJVQmH>; Mon, 22 Oct 2001 12:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277048AbRJVQls>; Mon, 22 Oct 2001 12:41:48 -0400
Received: from mout03.kundenserver.de ([195.20.224.218]:26987 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277047AbRJVQlj>; Mon, 22 Oct 2001 12:41:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: linux-kernel@vger.kernel.org
Subject: 2nd promise Ultra100 TX2 runs degraded
Date: Mon, 22 Oct 2001 18:41:57 +0200
X-Mailer: KMail [version 1.3]
Cc: Andre Hedrick <andre@linuxdiskcert.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011022164201.D0B50F9E@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

while trying to set up a software raid 5 with 60gb ide drives,
i've encountered following problem:
the performance on the second promise controller is really bad.
HW: Tyan K7 Thunder, 2 * XP1700, 2GB, 2 * Promise Ultra100 TX2
    4 * 60GB IBM IDE
SW: Linux 2.4.12

boot.msg:
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>AMD7411: IDE controller on PCI bus 00 dev 39
<4>AMD7411: chipset revision 1
<4>AMD7411: not 100%% native mode: will probe irqs later
<4>AMD7411: disabling single-word DMA support (revision < C4)
<4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
<4>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
<4>PDC20268: IDE controller on PCI bus 00 dev 40
<4>PDC20268: chipset revision 2
<4>PDC20268: not 100%% native mode: will probe irqs later
<4>PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
<4>PDC20268: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
<4>    ide2: BM-DMA at 0x2010-0x2017, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0x2018-0x201f, BIOS settings: hdg:pio, hdh:pio
<4>PDC20268: IDE controller on PCI bus 00 dev 48
<4>PDC20268: chipset revision 2
<4>PDC20268: not 100%% native mode: will probe irqs later
<4>PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary MASTER Mode.
<4>PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
<4>    ide4: BM-DMA at 0x2020-0x2027 -- ERROR, PORT ADDRESSES ALREADY IN USE
<4>    ide5: BM-DMA at 0x2028-0x202f -- ERROR, PORT ADDRESSES ALREADY IN USE
<4>hde: IC35L060AVER07-0, ATA DISK drive
<4>hdg: IC35L060AVER07-0, ATA DISK drive
<4>hdi: IC35L060AVER07-0, ATA DISK drive
<4>hdk: IC35L060AVER07-0, ATA DISK drive
<4>ide2 at 0x2048-0x204f,0x2042 on irq 3
<4>ide3 at 0x2038-0x203f,0x2036 on irq 3
<4>ide4 at 0x2060-0x2067,0x205a on irq 10
<4>ide5 at 0x2050-0x2057,0x2046 on irq 10
<6>hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, 
UDMA(100)
<6>hdg: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, 
UDMA(100)
<6>hdi: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
<6>hdk: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63

There seem to be some problems with the ioports of the secondary.
Therefore the relevant parts of /proc/ioports:

2010-201f : Promise Technology, Inc. 20268
  2010-2017 : ide2
  2018-201f : ide3
2020-202f : Promise Technology, Inc. 20268 (#2)
  2020-202f : PDC20268
2030-2033 : PCI device 1022:700c (Advanced Micro Devices [AMD])
2034-2037 : Promise Technology, Inc. 20268
  2036-2036 : ide3
2038-203f : Promise Technology, Inc. 20268
  2038-203f : ide3
2040-2043 : Promise Technology, Inc. 20268
  2042-2042 : ide2
2044-2047 : Promise Technology, Inc. 20268 (#2)
  2046-2046 : ide5
2048-204f : Promise Technology, Inc. 20268
  2048-204f : ide2
2050-2057 : Promise Technology, Inc. 20268 (#2)
  2050-2057 : ide5
2058-205b : Promise Technology, Inc. 20268 (#2)
  205a-205a : ide4
2060-2067 : Promise Technology, Inc. 20268 (#2)
  2060-2067 : ide4
f000-f00f : Advanced Micro Devices [AMD] AMD-765 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1

Although the driver claims problems with 0x2020-0x202f,
they're assigned to the promise driver.

The result of this:

tyrex:~ # for i in hde hdg hdi hdk; do hdparm -tT /dev/$i; done

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.47 seconds =272.34 MB/sec
 Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec

/dev/hdg:
 Timing buffer-cache reads:   128 MB in  0.48 seconds =266.67 MB/sec
 Timing buffered disk reads:  64 MB in  1.66 seconds = 38.55 MB/sec

/dev/hdi:
 Timing buffer-cache reads:   128 MB in  0.48 seconds =266.67 MB/sec
 Timing buffered disk reads:  64 MB in 23.07 seconds =  2.77 MB/sec

/dev/hdk:
 Timing buffer-cache reads:   128 MB in  0.49 seconds =261.22 MB/sec
 Timing buffered disk reads:  64 MB in 24.30 seconds =  2.63 MB/sec

Is there any chance to get the 2nd controller running like the first?

Hopefully y'rs,
Hans-Peter
