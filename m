Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUFCD13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUFCD13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbUFCD13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:27:29 -0400
Received: from saturn.opentools.org ([66.250.40.202]:39308 "EHLO
	saturn.opentools.org") by vger.kernel.org with ESMTP
	id S265482AbUFCD1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:27:00 -0400
Date: Wed, 2 Jun 2004 23:31:37 -0400 (EDT)
From: Aaron Mulder <ammulder@alumni.princeton.edu>
X-X-Sender: ammulder@saturn.opentools.org
To: linux-kernel@vger.kernel.org
Subject: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
Message-ID: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm working with a Dell Inspiron 8200 laptop, and I've tried SuSE
9.1 Pro (2.6.4-54.5) and Fedora Core 2 (2.6.5-x I think, but I'm on SuSE
now).  The laptop has 2 normal PCMCIA slots, and a Dell TrueMobile 1150
mini-PCI card, which is apparently implemented as a PCMCIA card in a 3rd
PCMCIA slot (handled by the orinoco_cs driver).

	The problem is that once I configure the card in the OS and
reboot, it isn't found any more.  The hardware detection routines seem to
see it, but if you try to "ifup" the interface, is says that there's no
such interface ("eth1" has disappeared).  When that happens, if I look in
/var/lib/pcmcia/stab, it shows only 2 PCMCIA slots (the 2 on the side of
the machine), and the /var/log/messages output says something along the
lines of "cardmgr: watching 2 sockets".  In other words, it's not just the
eth1 interface that's disappeared, but the whole 3rd PCMCIA slot is gone.  
If I then run "dump_cis" it shows all 3 slots, including the "Dell
TrueMobile 1150 Series PC Card" text, and the Yenta: lines of dmesg still
printed output related to the 3rd slot, so clearly some things see it and 
some things don't.

	In both distros, the problem seems to be caused by loading the
orinoco_cs module before loading PCMCIA (and perhaps specifically before
loading yenta_socket).  Fedora puts an alias for eth1 as orinoco_cs in
/etc/modprobe.conf (and that results in orinoco_cs loading first), while
SuSE puts a MODULE='orinoco_cs' in /etc/sysconfig/hardware/hwcfg-static-0
which is loaded by coldplug (again before PCMCIA starts).

	If I change the configuration so that orinico_cs is not loaded
before PCMCIA, then the card works fine and the 3rd PCMCIA slot is handled
correctly.  For Fedora, I removed the line from /etc/modprobe.conf, and
for SuSE, I removed the line from /etc/sysconfig/hardware/hwcfg-static-0.

	I guess I'm assuming that this is a kernel bug and that it
shouldn't matter if the orinoco_cs module is loaded before PCMCIA and/or
yenta_socket.  But I guess it could be a distro bug if the module behavior
is intentional.

Thanks,
	Aaron


lspci -v

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
        Flags: bus master, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP 
Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: d8000000-e7ffffff
        Expansion ROM at 0000c000 [disabled] [size=4K]

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) 
(prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4541
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at bf80 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) 
(prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4541
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at bf20 [size=32]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) 
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
        I/O behind bridge: 0000e000-0000ffff
        Memory behind bridge: f4000000-fbffffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 4541
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at bfa0 [size=16]
        [virtual] Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 
Audio Controller (rev 02)
        Subsystem: Cirrus Logic: Unknown device 5959
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at d800
        I/O ports at dc80 [size=64]

0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 
02) (prog-if 00 [Generic])
        Subsystem: Conexant MD56ORD V.92 MDC Modem
        Flags: medium devsel, IRQ 11
        I/O ports at d400
        I/O ports at dc00 [size=128]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 
440 Go] (rev a3) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00d4
        Flags: bus master, VGA palette snoop, 66Mhz, medium devsel, 
latency 32, IRQ 11
        Memory at fc000000 (32-bit, non-prefetchable) [size=80000000]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Memory at dff80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

0000:02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
        Subsystem: Dell Computer Corporation: Unknown device 00d4
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at ec80 [size=f9000000]
        Memory at f8fffc00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 2

0000:02:01.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus 
Controller
        Subsystem: Dell Computer Corporation: Unknown device 00d4
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 40001000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 40400000-407ff000 (prefetchable)
        Memory window 1: 40800000-40bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus 
Controller
        Subsystem: Dell Computer Corporation: Unknown device 00d4
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 40002000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 40c00000-40fff000 (prefetchable)
        Memory window 1: 41000000-413ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

0000:02:01.2 FireWire (IEEE 1394): Texas Instruments PCI4451 IEEE-1394 
Controller (prog-if 10 [OHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d4
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at f8fff000 (32-bit, non-prefetchable)
        Memory at f8ff8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:02:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 01)
        Subsystem: Lucent Technologies: Unknown device ab01
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 40003000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=0b, subordinate=0e, sec-latency=176
        Memory window 0: 41400000-417ff000 (prefetchable)
        Memory window 1: 41800000-41bff000
        I/O window 0: 00005000-000050ff
        I/O window 1: 00005400-000054ff
        16-bit legacy interface ports at 0001


dump_cis

Socket 0:
  no CIS present

Socket 1:
  no CIS present

Socket 2:
  dev_info
    NULL 0ns, 512b
  attr_dev_info
    SRAM 500ns, 1kb
  vers_1 5.0, "Dell", "TrueMobile 1150 Series PC Card", "Version 01.01",
    ""
  manfid 0x0156, 0x0002
  funcid network_adapter
  lan_technology wireless
  lan_speed 1 mb/sec
  lan_speed 2 mb/sec
  lan_speed 5 mb/sec
  lan_speed 11 mb/sec
  lan_media 2.4_GHz
  lan_node_id 00 02 2d 6d a5 be
  lan_connector Closed connector standard
  config base 0x03e0 mask 0x0001 last_index 0x01
  cftable_entry 0x01 [default]
    Vcc Vnom 3300mV Vmin 3V Vmax 3600mV Iavg 300mA
    Ipeak 300mA Idown 10mA
    io 0x0000-0x003f [lines=6] [16bit]
    irq mask 0xffff [level] [pulse]


/var/lib/pcmcia/stab (when working):

Socket 0: empty
Socket 1: empty
Socket 2: Intersil PRISM2 11 Mbps Wireless Adapter
2       network orinoco_cs      0       eth1


/var/lib/pcmcia/stab (when not working):

Socket 0: empty
Socket 1: empty


dmesg (when working; otherwise no eth1 lines come out but the Yenta 
output still includes the lines related to the 3rd socket):


Linux version 2.6.4-54.5-default (geeko@buildhost) (gcc version 3.3.3 
(SuSE Linux)) #1 Fri May 7 21:43:10 UTC 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffe2800 (usable)
 BIOS-e820: 000000003ffe2800 - 0000000040000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
128MB vmalloc/ioremap area available.
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262114
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32738 pages, LIFO batch:7
DMI 2.3 present.
Built 1 zonelists
Kernel command line: root=/dev/hda5 vga=0x317 desktop resume=/dev/hda3 
splash=silent acpi=off
bootsplash: silent mode.
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
CKRM Initialized
Detected 1894.806 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 1034868k/1048456k available (1970k kernel code, 12652k reserved, 
677k data, 212k init, 130952k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Calibrating delay loop... 3743.74 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security 
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Looking for DSDT in initrd ...No customized DSDT found in initrd!
Freeing initrd memory: 1116k freed
CPU:     After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.90GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
do_initcalls
init_elf_binfmt
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
 ... the first call_usermodehelper: pci_bus
Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:00.0
vesafb: framebuffer at 0xe0000000, mapped to 0xf8800000, size 32768k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:f200
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initial HugeTLB pages allocated: 0
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
bootsplash 3.1.6-2004/03/31: looking for picture.... silentjpeg size 37245 
bytes, found (1024x768, 17142 bytes, v3).
Console: switching to colour frame buffer device 118x41
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:00:1f.5
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:00.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
hdb: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITA CD-RW UJDA360, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, 
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
Resume Machine: resuming from /dev/hda3
Resuming from device hda3
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max trans 
age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 212k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
subfs 0.9
Adding 1052248k swap on /dev/hda3.  Priority:42 extents:1
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:02:01.2
PCI: Sharing IRQ 11 with 0000:02:03.0
Yenta: CardBus bridge found at 0000:02:01.0 [1028:00d4]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:02:01.2
PCI: Sharing IRQ 11 with 0000:02:03.0
Yenta: CardBus bridge found at 0000:02:01.1 [1028:00d4]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:02:03.0
PCI: Sharing IRQ 11 with 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:02:01.2
Yenta: CardBus bridge found at 0000:02:03.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: excluding 0x828-0x837 0x840-0x84f 
0x860-0x877 0x880-0x88f 0x898-0x89f 0x8a8-0x8cf 0x8e0-0x8ff
cs: IO port probe 0x0800-0x080f: excluding 0x800-0x80f
cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and 
others)
eth1: Station identity 001f:0001:0008:000a
eth1: Looks like a Lucent/Agere firmware version 8.10
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:6D:A5:BE
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
NET: Registered protocol family 17
eth1: New link status: Connected (0001)
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xe8000000
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000bf80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.4-54.5-default uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.0
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000bf20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.4-54.5-default uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci1394: $Rev: 1193 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 11 for device 0000:02:01.2
PCI: Sharing IRQ 11 with 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:02:03.0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  
MMIO=[f8fff000-f8fff7ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[354fc00017cae021]
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03545c0(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device f7789800(sit0)
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 78494 usecs
intel8x0: clocking to 48000
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Non-volatile memory driver v1.2
eth1: no IPv6 routers present
hdb: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache
SCSI subsystem initialized
st: Version 20040318, fixed bufsize 32768, s/g segs 256
BIOS EDD facility v0.13 2004-Mar-09, 1 devices found
end_request: I/O error, dev fd0, sector 0
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[354fc00017cae021]
