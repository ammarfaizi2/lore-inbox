Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132300AbQK3ANJ>; Wed, 29 Nov 2000 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132315AbQK3AM7>; Wed, 29 Nov 2000 19:12:59 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:57101 "EHLO
        mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
        id <S132300AbQK3AMo>; Wed, 29 Nov 2000 19:12:44 -0500
Date: Thu, 30 Nov 2000 00:41:24 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: USB doesn't work with 440MX chipset, PCI IRQ problem?
Message-ID: <20001130004123.B1327@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got a new laptop with an Intel 440MX chipset, and USB doesn't work at
all. I tried both the UHCI drivers, but none of them works. The drivers
load OK, the USB hardware is detected, but as soon as I plug in a USB
device, I get the following debug messages (this is with a Logitech USB
mouse):

  hub.c: port 1 connection change
  hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
  hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
  hub.c: USB new device connect on bus1/1, assigned device number 19
  usb_control/bulk_msg: timeout
  usb.c: USB device not accepting new address=19 (error=-110)
  hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
  hub.c: USB new device connect on bus1/1, assigned device number 20
  usb_control/bulk_msg: timeout
  usb.c: USB device not accepting new address=20 (error=-110)

I think the timeouts have something to do with interrupts not coming
through because the interrupt counter for the USB port is not
increasing:

             CPU0       
    0:    1415829          XT-PIC  timer
    1:      10361          XT-PIC  keyboard
    2:          0          XT-PIC  cascade
    3:      70687          XT-PIC  serial
    5:          0          XT-PIC  Intel ICH
    9:       3134          XT-PIC  3c574_cs
   11:          1          XT-PIC  Ricoh Co Ltd RL5c475, usb-uhci
   12:      18847          XT-PIC  PS/2 Mouse
   14:     146954          XT-PIC  ide0
  NMI:          0 
  ERR:          0

Some information about the laptop: Asus P8300, Celeron 500, 128MB,
Intel 440MX chipset, running SuSE 7.0 and linux-2.4.0-test12-pre3.

Here is the output from lspci -vv:


00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
	Subsystem: Asustek Computer, Inc.: Unknown device 1063
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at f800 [size=256]
	Region 1: I/O ports at fc00 [size=64]

00:02.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev a2) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1332
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at fca0 [size=32]

00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fedffc00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at fc88 [size=8]
	Region 2: I/O ports at f400 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


I also enabled PCI debugging in arc/i386/kernel/pci-i386.h and got some
debug messages at boot:


Linux version 2.4.0-test12 (root@arthur) (gcc version 2.95.2 19991024 (release)) #1 Wed Nov 29 19:33:28 CET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f400 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000c00 @ 000000000009f400 (reserved)
 BIOS-e820: 0000000000017000 @ 00000000000e9000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000007fffc00 (ACPI NVS)
 BIOS-e820: 0000000000017000 @ 00000000fffe9000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f400 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: BOOT_IMAGE=2.4.0t12 ro root=301
Initializing CPU#0
Detected 501.146 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 127064k/131008k available (926k kernel code, 3556k reserved, 61k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00f6bf0
PCI: BIOS32 Service Directory entry at 0xfd762
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfd987, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf50
00:07 slot=00 0:00/def8 1:00/def8 2:00/def8 3:63/0800
00:09 slot=00 0:62/0800 1:00/def8 2:00/def8 3:00/def8
01:04 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
01:08 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
00:0a slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
00:02 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
00:00 slot=00 0:00/def8 1:61/08e0 2:00/def8 3:00/def8
PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
PCI: IRQ fixup
00:0a.0: ignoring bogus IRQ 255
IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 60, mask 0800, excl 0000 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0a.0
PCI: The same IRQ used for device 00:02.0
PCI: Allocating resources
PCI: Resource 0000f800-0000f8ff (f=101, d=0, p=0)
PCI: Resource 0000fc00-0000fc3f (f=101, d=0, p=0)
PCI: Resource f8000000-fbffffff (f=200, d=0, p=0)
PCI: Resource 0000fc90-0000fc9f (f=101, d=0, p=0)
PCI: Resource 0000fca0-0000fcbf (f=101, d=0, p=0)
PCI: Resource fedffc00-fedffcff (f=200, d=0, p=0)
PCI: Resource 0000fc88-0000fc8f (f=109, d=0, p=0)
PCI: Resource 0000f400-0000f4ff (f=101, d=0, p=0)
  got res[10000000:10000fff] for resource 0 of Ricoh Co Ltd RL5c475
PCI: Sorting device list...
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:pio
hda: IBM-DARA-212000, ATA DISK drive
hdb: CD-224E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=1559/240/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 136072k swap-space (priority -1)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.249 $ time 19:44:27 Nov 29 2000
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xfca0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c7ca78e0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: fca0
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7ca78e0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: registered new driver hid
usb.c: registered new driver wacom
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x398-0x39f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
irda_init()
irlmp_init()
IrDA: Registered device irda0
irlmp_register_client()
irtty_net_open()
irlap_change_speed(), setting speed to 9600
PCI: Setting latency timer of device 00:00.1 to 64


I'll be glad to supply more information on request.



Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
