Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280762AbRKBSTs>; Fri, 2 Nov 2001 13:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280763AbRKBSSl>; Fri, 2 Nov 2001 13:18:41 -0500
Received: from pop.gmx.net ([213.165.64.20]:38165 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280762AbRKBSS3>;
	Fri, 2 Nov 2001 13:18:29 -0500
Date: Fri, 2 Nov 2001 20:18:17 +0200 (IST)
From: Dan Aloni <da-x@gmx.net>
X-X-Sender: <da-x@callisto.yi.org>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] IDE Auto Geometry Resizing fix
Message-ID: <Pine.LNX.4.32.0111021959010.12567-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IDE Auto Geometry Resizing code, which was brought from the Linus-
tree into -ac, didn't work on my system, so I examined the differences
between the version of the code in 2.4.13-ac6 and the older version of
the code that I have been using. Then I produced the following patch
which fixes the problem.


--- linux-2.4.13-ac6/drivers/ide/ide-disk.c	Fri Nov  2 17:47:27 2001
+++ linux-2.4.13-ac6/drivers/ide/ide-disk.c	Fri Nov  2 19:14:46 2001
@@ -807,7 +807,9 @@
 	ide_task_t args;
 	unsigned long addr = 0;

-	if (!(drive->id->cfs_enable_2 & 0x0100))
+	if (!(drive->id->command_set_1 & 0x0400)
+	    &&
+	    !(drive->id->cfs_enable_2 & 0x0100))
 		return addr;

 	/* Create IDE/ATA command request structure */


I hope this further helps finding out why the original code didn't work:
(NOTE: this commands were ran *after* I applied the patch to the kernel)

# hdparm -I /dev/hdc

/dev/hdc:

 Model=BI-MTDAL3-7040 5                        , FwRev=XTO65AC0, SerialNo=
Y 0MMY8L6434
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=1916kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=2(fast)
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes
 LBA CHS=1023/256/63 Remapping, LBA=yes, LBAsects=90069840
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2


(This hdparm dump looks suspicious, what's the junk in the first line?


# lspci -xxx

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 22)
00: 06 11 91 06 06 00 90 a2 22 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fc cd c8 00 00 00 30 30 88 80 08 08 10 10 20 30
60: 3f aa 00 20 d4 d4 d4 ee 21 00 65 01 40 27 a8 6f
70: 40 08 ec 00 08 80 80 00 00 f0 00 00 00 00 00 00
80: 0f 41 00 00 c0 00 00 00 03 00 fb 17 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 07 00 00 00 00 48 02 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 00 00
20: 00 e4 f0 e5 00 e6 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
40: e8 dc 50 22 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 09)
00: 06 11 96 05 87 00 00 02 09 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 01 00 00 00 80 60 ee 05 01 c4 00 00 00 00 f3
50: 24 00 00 00 00 b0 00 a0 00 06 f6 00 40 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 01 00 00 00 00 00 80 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00: 06 11 71 05 07 00 80 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 0b 02 09 3a 6c 13 c0 00 a8 20 21 a8 d3 00 20 20
50: 03 e0 03 03 00 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 f0 ff 17 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
00: 06 11 50 30 00 00 80 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 60 84 00 00 f8 70 00 0e 01 40 00 00 d0 00 00 00
50: 00 ff ff 88 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 50 00 00 07 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Ethernet controller: Macronix, Inc. MX987x5 (rev 20)
00: d9 10 31 05 87 02 90 02 20 00 00 02 08 20 00 00
10: 01 e8 00 00 00 00 00 e9 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 e8 44 00 00 00 00 00 00 00 0b 01 08 38
40: 00 00 00 00 01 00 11 92 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Multimedia audio controller: Ensoniq ES1371 (rev 06)
00: 74 12 71 13 05 00 10 04 06 00 01 04 00 40 00 00
10: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 71 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0c 80
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 31 6c
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Nvidia Corporation: Unknown device 002d (rev 15)
00: de 10 2d 00 07 00 b0 02 15 00 00 03 00 f8 00 00
10: 00 00 00 e4 08 00 00 e6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 24 10
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 05 01
40: 02 11 24 10 02 00 20 00 03 00 00 1f 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 01 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Linux version 2.4.13-ac6 (karrde@callisto.yi.org) (gcc version 2.95.3 20010315 (release)) #8 Fri Nov 2 19:09:05 IST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=2.4.13-ac6 ro root=1603
Initializing CPU#0
Detected 451.029 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 384724k/393216k available (868k kernel code, 8108k reserved, 238k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 451.0669 MHz.
..... host bus clock speed is 100.2369 MHz.
cpu: 0, clocks: 1002369, slice: 501184
CPU0<T0:1002368,T1:501184,D:0,S:501184,C:1002369>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: Card '33600 bps FAX/Voice Internal Modem'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at port 0x03e8 (irq = 5) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: queued sectors max/low 255397kB/124325kB, 768 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596a (rev 09) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdc: IBM-DTLA-307045, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(33)
hdb: ATAPI 24X CD-ROM drive, 120kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hdc: [PTBL] [5606/255/63] hdc1 hdc2 hdc3 hdc4 < hdc5 >
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 322M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 136544k swap-space (priority -1)
PCI: Found IRQ 10 for device 00:0b.0
Linux Tulip driver version 0.9.15-pre8 (Oct 11, 2001)
PCI: Found IRQ 11 for device 00:08.0
eth0: Macronix 98715 PMAC rev 32 at 0xe800, 00:80:AD:00:DB:BE, IRQ 11.
ip_tables: (c)2000 Netfilter core team
ip_conntrack (3072 buckets, 24576 max)

