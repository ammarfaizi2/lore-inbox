Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRDBCjB>; Sun, 1 Apr 2001 22:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDBCiw>; Sun, 1 Apr 2001 22:38:52 -0400
Received: from Sarah.SomeSites.com ([208.44.57.7]:28676 "HELO
	Sarah.SomeSites.com") by vger.kernel.org with SMTP
	id <S132605AbRDBCii>; Sun, 1 Apr 2001 22:38:38 -0400
Message-ID: <003201c0bb1d$e88240f0$0100a8c0@SomeSites.com>
Reply-To: "James Turinsky (LKML)" <lkml@SomeSites.com>
From: "James Turinsky (LKML)" <lkml@SomeSites.com>
To: <linux-kernel@vger.kernel.org>
Subject: IDE DMA Problem? (or at least behavior change) 2.2/2.4
Date: Sun, 1 Apr 2001 22:37:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi esteemed kernel hackers!

For some time now I've been encountering the following problem:

1) background info:

Hard drive is

/dev/hda:

 Model=IBM-DTTA-371010, FwRev=T77OA73A, SerialNo=WL0WLF36394
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=465kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19746720
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2

IDE controllers are

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80 [Master])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Region 4: I/O ports at fc90 [size=16]

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20262
(rev 01)
Subsystem: Promise Technology, Inc.: Unknown device 4d33
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at f4f0 [size=8]
Region 1: I/O ports at fc88 [size=4]
Region 2: I/O ports at f4f8 [size=8]
Region 3: I/O ports at fc8c [size=4]
Region 4: I/O ports at fcc0 [size=64]
Region 5: Memory at fcfe0000 (32-bit, non-prefetchable) [size=128K]
Expansion ROM at <unassigned> [disabled] [size=64K]
Capabilities: [58] Power Management version 1
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

This is an IBM Deskstar 10GXP (7200rpm 10GB) UDMA/33? drive which I've
either had on the PIIX3 or Promise Ultra66 controller (unhacked with
latest BIOS).

2) The problem itself:

I manually run hdparm -c1 -d1 -k1 -K1 -m16 on /dev/hda (currently on
Ultra66 but same on PIIX3).
The drive uses DMA fine for a while, and then at some point the
following happens (from dmesg):

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success

I don't remember if this is exactly how the message was in 2.2.x but
ide0 did reset.

In 2.2.x I could re-issue hdparm -d1 /dev/hda and the drive would go
back to using DMA.  Now, in 2.4.x, it barfs out the same error as above
(and pauses for several seconds) if say "sync" or "updatedb" commands
are issued.  Apparently short of rebooting I can't re-enable DMA.

One of the things I have noticed but I don't know is related is that the
buffers part of "free" seems to be really small around the time this
happens:

             total       used       free     shared    buffers
cached
Mem:        126820      79548      47272          0       2680
34220
-/+ buffers/cache:      42648      84172
Swap:       262576         36     262540

Otherwise, the drive seems to do work fine in DMA or non-DMA modes.  I'm
not doing anything particularly disk-intensive...

[root@Sarah hda]# cat /proc/interrupts
           CPU0
  0:   19754320          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          9          XT-PIC  serial
  4:          9          XT-PIC  serial
  8:          5          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
 10:     165521          XT-PIC  eth0
 11:      88076          XT-PIC  ide0, ide1
 12:          0          XT-PIC  PS/2 Mouse
NMI:          0
ERR:          0

System just handles my mail (l-k and a few other messages a day), serves
out a few 404's an hour with Apache, and runs SETI@Home.

Is this a bug, glitch, or normal behavior?

Below please find additional info which hopefully answers some questions
before you ask them.

Thanks.
JT

--begin diagnostic stuff--

(Linux-Mandrake 7.2)

uptime:
  1:20am  up 2 days,  6:57,  1 user,  load average: 1.00, 1.00, 0.93

dmesg:
Linux version 2.4.3 () (gcc version 2.95.3 19991030 (prerelease)) #1 Fri
Mar 30 17:21:54 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f820a - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff820a - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: auto BOOT_IMAGE=linux ro root=302 ide=reverse
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
Detected 398.625 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 126612k/131072k available (1054k kernel code, 4068k reserved,
379k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfda2e, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7000] at 00:07.0
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Card 'OPL3-SA2 Sound Board'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
atyfb: mach64VT (ATI264VT) [0x5654 rev 0x40] 2M EDO, 14.31818 MHz XTAL,
200 MHz PLL, 63 Mhz MCLK
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI
Detected PS/2 Mouse Port.
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
pty: 256 Unix98 ptys configured
block: queued sectors max/low 84016kB/28005kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20262: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 11 for device 00:11.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdc:DMA, hdd:pio
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xfc90-0xfc97, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTTA-371010, ATA DISK drive
hdc: NEC CD-ROM DRIVE:282, ATAPI CD/DVD-ROM drive
ide0 at 0xf4f0-0xf4f7,0xfc8a on irq 11
ide1 at 0xf4f8-0xf4ff,0xfc8e on irq 11
hda: 19746720 sectors (10110 MB) w/465KiB Cache, CHS=19590/16/63,
UDMA(33)
hdc: ATAPI 8X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ
DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:07.2
uhci.c: USB UHCI at I/O 0xfca0, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 208k freed
uhci.c: suspend_hc
Adding Swap: 262576k swap-space (priority -1)
PCI: Found IRQ 10 for device 00:13.0
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xfc00,  00:10:4b:32:1b:4e,
IRQ 10
  product code 4e42 rev 00.0 date 01-30-98
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled
eth0: using NWAY device table, not 8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
keyboard: Timeout - AT keyboard not present?
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success

hdparm /dev/hda:
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 19590/16/63, sectors = 19746720, start = 0


hdparm -iI:
/dev/hda:

 Model=IBM-DTTA-371010, FwRev=T77OA73A, SerialNo=WL0WLF36394
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=465kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19746720
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2

 Model=BI-MTDAT3-1710 0                        , FwRev=7TO77AA3,
SerialNo=        W 0LLW3F3649
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=465kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19746720
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2

lspci -vv:

00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX]
(rev 02)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80 [Master])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Region 4: I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB
[Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Interrupt: pin D routed to IRQ 9
Region 4: I/O ports at fca0 [size=32]

00:08.0 VGA compatible controller: ATI Technologies Inc 264VT [Mach64
VT] (rev 40) (prog-if 00 [VGA])
Subsystem: ATI Technologies Inc Mach64VT Reference
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping+ SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
Region 1: I/O ports at f800 [size=256]
Expansion ROM at <unassigned> [disabled] [size=64K]

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20262
(rev 01)
Subsystem: Promise Technology, Inc.: Unknown device 4d33
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at f4f0 [size=8]
Region 1: I/O ports at fc88 [size=4]
Region 2: I/O ports at f4f8 [size=8]
Region 3: I/O ports at fc8c [size=4]
Region 4: I/O ports at fcc0 [size=64]
Region 5: Memory at fcfe0000 (32-bit, non-prefetchable) [size=128K]
Expansion ROM at <unassigned> [disabled] [size=64K]
Capabilities: [58] Power Management version 1
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 80 (2500ns min, 2500ns max), cache line size 08
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at fc00 [size=128]
Region 1: Memory at fcfdfc00 (32-bit, non-prefetchable) [size=128]
Expansion ROM at <unassigned> [disabled] [size=128K]
Capabilities: [dc] Power Management version 1
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

/proc/ide/pdc202xx:

                                PDC20262 Chipset.
------------------------------- General
Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 4 mA
Status Polling Period                : 6
Interrupt Check Status Polling Delay : 12
--------------- Primary Channel ---------------- Secondary
Channel -------------
                enabled                          enabled
66 Clocking     disabled                         disabled
           Mode PCI                         Mode PCI
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               yes             yes               no
DMA Mode:       UDMA 4           NOTSET          NOTSET
NOTSET
PIO Mode:       PIO 4            NOTSET           NOTSET
NOTSET

/proc/ide/piix:
                                Intel PIIX3 Chipset.
--------------- Primary Channel ---------------- Secondary
Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               no              no                no
UDMA enabled:   no               no              no                no
UDMA enabled:   X                X               X                 X
UDMA
DMA
PIO

