Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286693AbRL1CdR>; Thu, 27 Dec 2001 21:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286695AbRL1CdB>; Thu, 27 Dec 2001 21:33:01 -0500
Received: from e120116.upc-e.chello.nl ([213.93.120.116]:25870 "EHLO
	stempel.dhs.org") by vger.kernel.org with ESMTP id <S286693AbRL1Cci>;
	Thu, 27 Dec 2001 21:32:38 -0500
Date: Fri, 28 Dec 2001 03:32:34 +0100 (CET)
From: Edward Stempel <eazstempel@cal009001.student.utwente.nl>
To: linux-kernel mailinglist <linux-kernel@vger.kernel.org>
cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: DMA conflicts with soundcard for ide driver via82cxxx
Message-ID: <Pine.LNX.4.21.0112280046560.1948-100000@nieuw3.stempel.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Asus a7v266 mother board and an Ensoniq sound card in it. 
The ide chipset is a VIA VT8233 that is capable of UDMA100. So I built a
kernel with the es1371 sound driver and the via82cxxx ide driver
configured in it. Actually I tried the kernel 2.4.17 first, and the latest
I tried is 4.5.1 with the latest patch (patch-2.5.2-pre3) applied to it.
I also tried the kernel 2.5.1 with Vojtech  patch (via-3.33.diff from
his email dated 2001-12-23 23:20:48) applied to it, with the same
(negative) results.

The good thing is that hdparm reports appr. 40 MB/sec when using DMA and
about 6 MB/sec when not using DMA.
Unfortunately using DMA for ide results in some ugly distortion of the
sound from my soundcard whenever some IO to the disk is done.  :((

I have assigned different interrupts to the PCI-cards (ide is 
on-board) and I even changed the sound card's PCI slot, so it shared
its interrupt with another device (acpi instead of USB). It did not solve
the problem. Because the problem only occurs when switching on using_dma
on the ide driver, I think it is a DMA problem with the ide driver. It may
be the es1371 driver as well off course, but I suspect it is the ide
driver (or chipset).
  
Reading the list archive from linux-kernel, I discovered there have been
more problems with DMA using this chipset, but I did not find anyone
having the same problem as I have now.

Has someone also dealt with these problems, or can someone help me
solving this problem? Please help!  

Below are some outputs using kernel 5.1 with patch-2.5.2-pre3.


Edward



hdparm -vi /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 9732/255/63, sectors = 156355584, start = 0

 Model=MAXTOR 6L080J4, FwRev=A93.0500, SerialNo=664128115851
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=156355584
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
ATA-4 ATA-5

cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.33
South Bridge:                       VIA vt8233
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xb800
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          20ns     600ns     120ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s  16.6MB/s   3.3MB/s

cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xf8000000 [0xf80000ff].
  Bus  0, device  14, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(#2) (rev 16).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xd400 [0xd4ff].
      Non-prefetchable 32 bit memory at 0xf7800000 [0xf78000ff].
  Bus  0, device  15, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xd000 [0xd03f].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xb800 [0xb80f].
  Bus  0, device  17, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 27).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0xb400 [0xb41f].
  Bus  0, device  17, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 27).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0xb000 [0xb01f].
  Bus  0, device  17, function  4:
    USB Controller: VIA Technologies, Inc. UHCI USB (#3) (rev 27).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0xa800 [0xa81f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xfa000000 [0xfbffffff].
      Non-prefetchable 32 bit memory at 0xf9000000 [0xf9003fff].
      Non-prefetchable 32 bit memory at 0xf8800000 [0xf8ffffff].

dmesg:
Linux version 2.5.2-pre3 (edward@snel) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #1 Fri Dec 28 01:05:33 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ffec000 (usable)
 BIOS-e820: 000000005ffec000 - 000000005ffef000 (ACPI data)
 BIOS-e820: 000000005ffef000 - 000000005ffff000 (reserved)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
On node 0 totalpages: 393196
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 163820 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=linux-2-04 ro root=308
BOOT_FILE=/mnt2/boot/bzImage-2.5.1-snel-04
Initializing CPU#0
Detected 1410.245 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2811.49 BogoMIPS
Memory: 1545668k/1572784k available (1242k kernel code, 26728k reserved,
383k data, 216k init, 655280k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1410.1515 MHz.
..... host bus clock speed is 268.6001 MHz.
cpu: 0, clocks: 2686001, slice: 1343000
CPU0<T0:2686000,T1:1342992,D:8,S:1343000,C:2686001>
PCI: PCI BIOS revision 2.10 entry at 0xf1780, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/3074] at 00:11.0
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
kmod: failed to exec /sbin/modprobe -s -k parport_lowlevel, errno = 2
lp: driver loaded but no devices found
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.32
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L080J4, ATA DISK drive
hdc: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02ffc64, I/O limit 4095Mb (mask 0xffffffff)
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63,
UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.22
PCI: Enabling device 00:0d.0 (0004 -> 0007)
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
eth0: RealTek RTL8139 Fast Ethernet at 0xf8800000, 00:50:fc:3b:4d:69, IRQ
11
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Enabling device 00:0e.0 (0004 -> 0007)
PCI: Assigned IRQ 5 for device 00:0e.0
eth1: RealTek RTL8139 Fast Ethernet at 0xf8802000, 00:50:fc:44:99:35, IRQ
5
eth1:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 32M @ 0xfc000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xfc000000 32MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
es1371: version v0.30 time 01:07:01 Dec 28 2001
PCI: Enabling device 00:0f.0 (0004 -> 0005)
PCI: Assigned IRQ 9 for device 00:0f.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xd000 irq 9
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 10 for device 00:11.2
PCI: Sharing IRQ 10 with 00:11.3
PCI: Sharing IRQ 10 with 00:11.4
uhci.c: USB UHCI at I/O 0xb400, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:11.3
PCI: Sharing IRQ 10 with 00:11.2
PCI: Sharing IRQ 10 with 00:11.4
uhci.c: USB UHCI at I/O 0xb000, IRQ 10
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:11.4
PCI: Sharing IRQ 10 with 00:11.2
PCI: Sharing IRQ 10 with 00:11.3
uhci.c: USB UHCI at I/O 0xa800, IRQ 10
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Adding Swap: 136512k swap-space (priority -1)
spurious 8259A interrupt: IRQ7.
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability
41e1.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.



