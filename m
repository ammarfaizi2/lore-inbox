Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271660AbRHQOTl>; Fri, 17 Aug 2001 10:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271661AbRHQOTb>; Fri, 17 Aug 2001 10:19:31 -0400
Received: from wnt006.gsi.de ([140.181.106.209]:10770 "EHLO WNTMAILSV.gsi.de")
	by vger.kernel.org with ESMTP id <S271660AbRHQOTT>;
	Fri, 17 Aug 2001 10:19:19 -0400
Message-ID: <A41E00BDCD32D31192830000F81F88A901642C00@wntmailsv.gsi.de>
From: "Koenig Dr. Wolfgang" <W.Koenig@gsi.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Promise Ultra100(20268) address conflict with ServerWorks IDE
Date: Fri, 17 Aug 2001 16:18:07 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We installed a Promise Ultra100TX2 IDE controller (20268 chipset, not raid)
in order to attach additional IDE disks to a box with ServerWorks
motherboard (Intel).
We got an address conflict between the Promise controller
and the onboard IDE controller.
The result was that both were using some generic driver without DMA
and 1.5MB/s (16 bit) or 2.5MB/s (32 bit transfer) (hdparm -t ...).

Kernel 2.4.9pre4 was used (originally it was a RedHat 7.1 installation).
Even so the addresses allocated to the devices do not overlap,
the ServerWorks IDE controller produces an error message:
'Port addresses already in use'.

If an additional 20268 controller is attached,
it is working nicely (35MB/s). Without any 20268 attached,
onboard IDE is ok (20 MB/s).

Part of the address space of the ServerWorks IDE controller
is located in a gap in the address space of the 20268.
It seems that either the 20268 responds, if this gap in its address space
is addressed or the kernel forgot about the gap ??
(see cat /proc/ioports below).

Note that the address space for the 20268 (Device 00:08) is allocated
before that of the ServerWorks IDE chip (device 00:0F).
If it would be opposite, the onboard chipset could not
sneak into the gap (because it does not exist yet).
Most likely the latter is the case for more standard onboard IDE chipsets
and could explain why the problem seems to be related to the ServerWorks
IDE chipset (e.g. on other boxes with standard Intel South/Northbridge
we found onboard IDE at 00:04).

In the following listing comments starting with // were added by us.

Wolfgang and Joern ( W.Koenig@gsi.de , J.Wuestenfeld@gsi.de )
Please CC any answer to one of us, we did not subscribe.

lspci -v

00:08.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 4d68 (rev 01) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 24
        I/O ports at 5470 [size=8]
        I/O ports at 5464 [size=4]
        I/O ports at 5468 [size=8]
        I/O ports at 5460 [size=4]
        I/O ports at 5440 [size=16]

// notice the gap at 5450-545F.
// It will be allocated for the Serverworks IDE controller later.
// This gap is only real, if size=16 is a true statement

        Memory at fb000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
        Subsystem: ServerWorks OSB4
        Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8e [Master 
SecP SecO PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 0170 [size=8]
        I/O ports at 0374
        I/O ports at 5450 [size=16]

// here the gap in the address space of the Promise controller
// is allocated to the Serverworks controller.

cat /proc/ioports

//first 8 lines cut out)

0170-0177 : ServerWorks OSB4 IDE Controller
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ServerWorks OSB4 IDE Controller
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
5400-543f : Intel Corporation 82557 [Ethernet Pro 100]
  5400-543f : eepro100
5440-544f : Promise Technology, Inc. 20268
  5440-5447 : ide2
  5448-544f : ide3
5450-545f : ServerWorks OSB4 IDE Controller
  5450-545f : PDC20268

//Above, the address space previously allocated to the Serverworks
controller
//is identified as belonging to the Promise controller even so it does not.

5460-5463 : Promise Technology, Inc. 20268
  5462-5462 : ide3
5464-5467 : Promise Technology, Inc. 20268
  5466-5466 : ide2
5468-546f : Promise Technology, Inc. 20268
  5468-546f : ide3
5470-5477 : Promise Technology, Inc. 20268
  5470-5477 : ide2
5800-58ff : Adaptec 7899P
6000-60ff : Adaptec 7899P (#2)

dmesg

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller on PCI bus 00 dev 40
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20268: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
    ide2: BM-DMA at 0x5440-0x5447, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x5448-0x544f, BIOS settings: hdg:pio, hdh:pio
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
//
    ide0: BM-DMA at 0x5450-0x5457 -- ERROR, PORT ADDRESSES ALREADY IN USE
    ide1: BM-DMA at 0x5458-0x545f -- ERROR, PORT ADDRESSES ALREADY IN USE
//
hda: IC35L020AVER07-0, ATA DISK drive
hdb: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307075, ATA DISK drive
hdg: IBM-DTLA-307075, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x5470-0x5477,0x5466 on irq 24
ide3 at 0x5468-0x546f,0x5462 on irq 24
hda: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=2501/255/63
hde: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63,
UDMA(100)
hdg: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63,
UDMA(100)
...
