Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRCUDtf>; Tue, 20 Mar 2001 22:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRCUDt0>; Tue, 20 Mar 2001 22:49:26 -0500
Received: from dentin.eaze.net ([216.228.128.151]:36881 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S131157AbRCUDtP>;
	Tue, 20 Mar 2001 22:49:15 -0500
Date: Tue, 20 Mar 2001 21:48:06 -0600
From: SodaPop <soda@xirr.com>
Message-Id: <200103210348.VAA24013@xirr.com>
To: linux-kernel@vger.kernel.org
Subject: Only 10 MB/sec with via 82c686b chipset?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only 10 MB/sec with via 82c686b chipset?

I have an IWill KK-266R motherboard with an athlon-c 1200
processor in it, and for the life of me I can't get more than
10 MB/sec through the on-board ide controller.  Yes, all the
appropriate support is turned on in the kernel to enable dma
and specific chipset support, and yes, I think I have all
relevant patches and a reasonable kernel.

I started out with stock kernel 2.4.2.  I later added Hedrick's
ide.2.4.3-p4.all.03132001.patch, which did not change the
behaviour other than to include messages in the dmesg output. I
have even tried removing the via-specific chipset support from
the kernel, only to find that enabling dma with generic support
leaves me at the same 10 MB/sec as the specific support does.

I noted a number of other interesting things;  one, that -X33,
-X34, and -X64 through -X69 all have the same 10 MB/sec transfer
rate, and two, that the 10 MB/sec transfer rate can be linearly
increased to 12 MB/sec by raising the system bus from 100 mhz to
120 mhz (all components are safely rated at 133, no overclocking
involved.)

It is also quite strange that I have been able to run 'hdparm
-t /dev/hda' and 'hdparm -t /dev/hdb' concurrently and can still
get the full 10 MB/sec on both, for a sum total of 20 MB/sec. I
would have expected that the drives would clobber each other
given that they are on the same ide bus.

>From the /proc data and other information below, it seems to me
that this is some kind of screwball tuning issue between linux and
the chipset, not the chipset and the drives.  As near as I can
tell, the chipset is talking to the drives at a much higher data
rate than 10 MB/sec, but for some reason linux isn't able to
process the data any faster than that.  Running hdparm -t in
parallel and observing a speed increase from raising the cpu
clock leads me in that direction.  (Also note that hdparm -t only
uses a few percent of cpu.  It's not like the machine doesn't
have enough processing power.)

I'm really baffled at this point.  I can't rule out that I have
done something dumb, but for the life of me I can't think of
anything else.  I've been to a number of web pages, but the
general consensus seems to be that this chipset should just work,
and work beautifully without any trouble.  There aren't any
fixes because I seem to be the only one having this problem.

Does anyone have any other ideas?

-dennis T





Misc hardware information:
----------------------------------------------------
The board has raid hardware on it, but its currently disabled with
jumpers.  Cables are high quality 80 wire/40 pin cables.  Both
drives are the same, but currently hdb has the 32 gig clip jumper
attached.  Putting the drives on separate ide busses does not
change the 10 MB/sec throughput.  Removing hdb from the chain
does not raise the throughput of hda.  Both drives are rated at
37 MB/sec continuous DTR.  Hdd is a cheap 8x cdrom.

Hdb, when installed in a nearby machine, has a 17 MB/sec data
rate.  The machine is an AMD K6-II 500, 100 MHz bus, with via
82c586 chipset, running kernel 2.4.1 (via chipset support
enabled.)




Various miscellaneous data, and dmesg output:
----------------------------------------------------

root@gurney:~# cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
BM-DMA base:                        0xd000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       PIO       PIO
Address Setup:       30ns      30ns     120ns      60ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns      90ns     330ns     240ns
Data Recovery:       30ns      30ns     270ns     240ns
Cycle Time:          20ns      20ns      50ns      90ns
Transfer Rate:  100.0MB/s 100.0MB/s  40.0MB/s  22.2MB/s

----------------------------------------------------
root@gurney:~# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5606/255/63, sectors = 90069840, start = 0

----------------------------------------------------
root@gurney:~# hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DTLA-307045, FwRev=TX6OA60A, SerialNo=YMEYMNF7564
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

----------------------------------------------------
root@gurney:~# hdparm -T /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.88 seconds =145.45 MB/sec

----------------------------------------------------
root@gurney:~# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  6.11 seconds = 10.47 MB/sec

----------------------------------------------------
root@gurney:~# dmesg
Linux version 2.4.2 (root@gurney) (gcc version 2.95.2 19991024 (release)) #4 Tue Mar 20 18:02:16 CST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.2 ro root=304
Initializing CPU#0
Detected 898.848 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 1789.13 BogoMIPS
Memory: 255656k/262080k available (903k kernel code, 6036k reserved, 337k data,
192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Bus master read caching disabled
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169880kB/56626kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hdb: IBM-DTLA-307045, ATA DISK drive
hdd: HITACHI CDR-7930, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(100)
hdb: 66055248 sectors (33820 MB) w/1916KiB Cache, CHS=65531/16/63, UDMA(100)
hdd: ATAPI 8X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb: hdb1 hdb2
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
8139too Fast Ethernet driver 0.9.13 loaded
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:0f.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0800000, 00:e0:7d:95:af:a6, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:04) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding Swap: 530136k swap-space (priority -1)
hda: Write Cache SUCCESSED Flushing!<6>hda: Write Cache SUCCESSED Flushing!<6>usb.c: registered new driver usbdevfs
usb.c: registered new driver hub



