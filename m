Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266421AbRGFLlT>; Fri, 6 Jul 2001 07:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266422AbRGFLlK>; Fri, 6 Jul 2001 07:41:10 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.121.85]:20190 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266421AbRGFLkv>; Fri, 6 Jul 2001 07:40:51 -0400
Date: Fri, 6 Jul 2001 04:40:46 -0700
From: "Daniel A. Nobuto" <ramune@bigfoot.com>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: natsemi.c failure in 2.4.6
Message-ID: <20010706044046.A864@bigfoot.com>
In-Reply-To: <3B459958.F25665A8@stud.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B459958.F25665A8@stud.uni-saarland.de>; from masp0008@stud.uni-sb.de on Fri, Jul 06, 2001 at 10:56:24AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Could you try what happens without any special options? Default MAC
> address, without mii-diag.

Okay, I ripped mii-diag out of the bootup scripts.

> >  I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
> >    Advertising no additional info pages.
> >    IEEE 802.3 CSMA/CD protocol.
> >  Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx
> >    10baseT-FD. 10baseT.  Negotiation  completed.
> 
> Something is wrong.
> Are you sure it's a hub? The link partner ability says FullDuplex
> capable, it's either a switch or the negotiation produced wrong results.

I just checked, it looks like a switch.  Sorry for the confusion, but it was
advertised as a hub when I bought it, so I didn't check to see which it was.
(Until now).

> The natsemi nic advertises 5e1, but the speed is fixed at 100 mbps.
> Probably a forced renegotiation after mii-diag changes is missing, and
> the forced settings aren't used properly.

Yup, it was forced to 10baseT-HD during bootup.  It didn't work and a few
tcpdumps later, I changed it to 100baseTx-FD via mii-diag to see if it would
make a difference.  That's when I got the mii-diag output I put in my mail.

I just booted with it disabled and tried it, but I'm still getting the same
symptoms, though the first time I tried to ping, I got *one* reply from the
NetBSD box.

Anything else I can do to help?

-- DN
Daniel

==========================================================
>From the Linux box:
start continuous ping

>From the NetBSD box:
ramune@stoli:$ sudo tcpdump -enli le0
tcpdump: listening on le0
04:35:19.832480 0:a0:cc:a1:67:71 8:0:20:76:94:16 0800 98: 192.168.0.3 > 192.168.0.1: icmp: echo request (DF)
04:35:19.832657 8:0:20:76:94:16 0:a0:cc:a1:67:71 0800 98: 192.168.0.1 > 192.168.0.3: icmp: echo reply (DF)
<ad infinitum>

==========================================================
/sbin/ip -s link ls dev eth0
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:a0:cc:a1:67:71 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    158        2        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    2786       29       0       0       0       0      
==========================================================
/var/log/kern.log:

Jul  6 04:25:06 zippo kernel: eth0: Something Wicked happened! 18000.
==========================================================
mii-diag -vvva eth0:

Using the default interface 'eth0'.
mii-diag.c:v2.00 4/19/2000  Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #1 transceiver registers:
   3100 786d 2000 5c21 05e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   0615 0002 0000 0001 0000 0000 0000 4000
   4f48 189c 0860 00b7 0010 5040 1084 0023.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
 MII PHY #1 transceiver registers:
   3100 786d 2000 5c21 05e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   0615 0002 0000 0001 0000 0000 0000 4000
   4f48 189c 0860 00b7 0010 5040 1084 0023.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x786d ... 786d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 08:00:17:--:--:--, model 2 rev. 1.
   No specific information is known about this transceiver type.
 I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Negotiation  completed.
==========================================================
dmesg with init=/bin/sh (some of it was truncated, but I think everything
needed is here):

r init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 5 for device 00:07.2
PCI: Sharing IRQ 5 with 00:09.0
PCI: Sharing IRQ 5 with 00:11.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Coda Kernel/Venus communications, v5.3.14, coda@cs.cmu.edu
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x4094)
matroxfb: framebuffer at 0xE8000000, mapped to 0xd0805000, size 8388608
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 169290kB/56430kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: JTS Corp. PALLADIUM Model P1000-2AF, ATA DISK drive
hdb: TOSHIBA CD-ROM XM-6502B, ATAPI CD/DVD-ROM drive
hdc: Maxtor 82160D2, ATA DISK drive
hdd: Maxtor 51024U2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1957536 sectors (1002 MB) w/32KiB Cache, CHS=971/32/63, DMA
hdc: 4219592 sectors (2160 MB) w/256KiB Cache, CHS=4465/15/63, UDMA(33)
hdd: 20010816 sectors (10246 MB) w/2048KiB Cache, CHS=19852/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2
 hdc: hdc1
 hdd: hdd1 hdd2 hdd3 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >
loop: loaded (max 8 devices)
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.7, May 18, 2001  Jeff Garzik, Tjeerd Mulder)
PCI: Found IRQ 11 for device 00:0f.0
eth0: NatSemi DP83815 at 0xd1006000, 00:a0:cc:a1:67:71, IRQ 11.
eth0: Transceiver status 0x7869 advertising 05e1.
[snip -- to save bandwith, since some ppl are on metered connections.]
