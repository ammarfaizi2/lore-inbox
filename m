Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTIIN74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTIIN74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:59:56 -0400
Received: from main.gmane.org ([80.91.224.249]:56461 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264123AbTIIN7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:59:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: [BUG] 2.4.22 hard lock-up with sii3112 and aic7xxx
Date: 9 Sep 2003 13:34:00 GMT
Organization: none
Message-ID: <bjkks8$k6l$1%proserpine.haus@yggdrasl.demon.co.uk>
X-Complaints-To: usenet@sea.gmane.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've just migrated my system from a set of U160 SCSI disks to a new
SATA drive, and I've run into a nasty system lock-up.  I've tried
the SysRq key and the NMI watchdog, but have had no luck getting a
panic message or an oops with either, unfortunately - the system is
totally wedged.

The lock-up appears to be caused when an access is made to the SATA
drive using DMA simultaneously with an access to the SCSI card.
Disabling IDE DMA made the system certainly stable enough to copy
all 30GB of my filesystems off the old disks onto the new one.

I've since changed to booting from the SATA drive, with the SCSI
disks disconnected, and everything seems fine.  However, if I try to
access either the DVD-ROM or CD-RW which remain on the SCSI channel,
I get the same hang.  It's trivially reproducible, even in single-
user mode with no other processes running.

The SATA card is a generic SiI3112 board, and the SCSI card is an
Adaptec 29160.  My motherboard is an EpoX 8KHA+ (VIA KT266A) with an
Athlon XP 1800+ and 768MB RAM.

I've tried running with and without acpi=nopci, and no joy either
way.  The system is currently running with nopci set.  I admit
to normally using the NVidia binary driver, but I've reproduced
this easily without it ever having loaded (never modprobed in the
first place), and can do so again.

Has anyone else experienced similar issues?  I've attached all the
relevant details I can think of below:


lspci -vvv:
-----------

00:0c.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	BIST result: 00
	Region 0: I/O ports at cc00 [disabled] [size=256]
	Region 1: Memory at eb003000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Unknown mass storage controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 01)
	Subsystem: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 01
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at d400 [size=4]
	Region 2: I/O ports at d800 [size=8]
	Region 3: I/O ports at dc00 [size=4]
	Region 4: I/O ports at e000 [size=16]
	Region 5: Memory at eb004000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


/proc/interrupts:
-----------------

           CPU0       
  0:   66133725          XT-PIC  timer
  1:     188479          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:       7740          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:    1085004          XT-PIC  ide0, EMU10K1, usb-uhci, usb-uhci, usb-uhci
 12:    2339816          XT-PIC  PS/2 Mouse
 14:     591507          XT-PIC  eth0
 15:   56315050          XT-PIC  aic7xxx, bttv, btaudio
NMI:     661320 
LOC:   66133656 
ERR:          0
MIS:          0


hdparm -I /dev/hda:
-------------------

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST380013AS                              
	Serial Number:      3JV2PGA1            
	Firmware Revision:  3.05    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  156301488
	LBA48  user addressable sectors:  156301488
	device size with M = 1024*1024:       76319 MBytes
	device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct


dmesg:
------

Linux version 2.4.22 (root@samael) (gcc version 2.95.3 20010315 (release)) #13 Thu Aug 28 06:45:43 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f70d0
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=linux ro root=301 pci=noacpi hdc=none nmi_watchdog=2
ide_setup: hdc=none
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1536.849 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3067.08 BogoMIPS
Memory: 775688k/786368k available (1031k kernel code, 10292k reserved, 451k data, 80k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1536.8471 MHz.
..... host bus clock speed is 267.2776 MHz.
cpu: 0, clocks: 2672776, slice: 1336388
CPU0<T0:2672768,T1:1336368,D:12,S:1336388,C:2672776>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3099] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 00:0d.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: ST380013AS, ATA DISK drive
blk: queue c02b67a0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0xf0806080-0xf0806087,0xf080608a on irq 11
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63
Partition check:
 hda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 hda1 hda2 < hda5 hda6 hda7 hda8 hda9 > hda3 hda4
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 80k freed
Adding Swap: 995988k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
lp0: using parport0 (interrupt-driven).
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (50 C)
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
inserting floppy driver for 2.4.22
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
i2c-algo-bit.o: i2c bit algorithm module
lirc_dev: IR Remote Control driver registered, at major 61 
i2c-core.o: driver i2c ir driver registered.
Linux video capture interface: v1.00
bttv: driver version 0.7.107 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 00:0a.0, irq: 15, latency: 32, mmio: 0xeb001000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
i2c-dev.o: Registered 'bt848 #0' as minor 0
lirc_i2c: chip found @ 0x18 (Hauppauge IR)
i2c-core.o: client [Hauppauge IR] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=61324, tuner=Philips FI1216 MK2 (5), radio=no
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video0
bttv0: registered device vbi0
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3415D-B3 +nicam +simple
msp3410: daemon started
i2c-core.o: client [MSP3415D-B3] registered to adapter [bt848 #0](pos. 1).
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
i2c-core.o: client [Philips PAL_BG (FI1216 and comp] registered to adapter [bt848 #0](pos. 2).
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 00:0a.1, irq: 15, latency: 32, mmio: 0xeb002000
btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
i2c-core.o: driver tv card mixer driver registered.
tvmixer: MSP3415D-B3 (bt848 #0) registered with minor 32
via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xeb000000, 00:05:5d:a1:9d:83, IRQ 14.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link 45e1.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 06:43:09 Aug 28 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
udf: registering filesystem
NTFS driver v1.1.22 [Flags: R/O MODULE]
usb.c: registered new driver irda-usb
USB IrDA support registered
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
IrCOMM protocol (Dag Brattli)
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub.c: new USB device 00:11.3-2, assigned address 2
usb-uhci.c: interrupt, status 3, frame# 657
input: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder Precision Pro (USB)] on usb2:2.0
eth0: Setting full-duplex based on MII #8 link partner capability of 45e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("Can someone explain the Enid Blighton bit?"                       )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

