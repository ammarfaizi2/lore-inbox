Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTAPUm2>; Thu, 16 Jan 2003 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTAPUm1>; Thu, 16 Jan 2003 15:42:27 -0500
Received: from fmr02.intel.com ([192.55.52.25]:6119 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267259AbTAPUmE>; Thu, 16 Jan 2003 15:42:04 -0500
Subject: Re: [Pcihpd-discuss] Re: [BUG][2.5]deadlock on cpci hot insert
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Scott Murray <scottm@somanetworks.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <1042700689.1153.15.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301160014250.20085-100000@rancor.yyz.somanetworks.com> 
	<1042700689.1153.15.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Jan 2003 12:42:42 -0800
Message-Id: <1042749763.1535.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-15 at 23:04, Rusty Lynch wrote:
> On Wed, 2003-01-15 at 21:33, Scott Murray wrote:
> > PS: Any word on whether my ZT5550 driver patch from last Friday fixes
> >     your ZT5084 chassis issues?
> 
> Oh yea, that's the other thing I was going to do.  I just built and
> installed the patched kernel with no problems, but I will be able to say
> more after I have physical access to my lab tomorrow.
> 
>     --rustyl

The cpcihp_zt5550 patch you sent last Friday does not work on my 
ZT5084 chassis because it does not detect any active cpci busses,
and therefore doesn't register any cpci busses, and eventually
gives up when cpci_hp_start fails (since slots == 0).

>From my dmesg, I can see:
cpcihp_zt5550: HCF_HCS = 0x0000003b

I added a couple of debug messages before calling cpci_hp_start.
dbg("Bus #1 is %s", hcf_hcs & HCS_BUS1_ACTIVE ? "active":"not active");
dbg("Bus #2 is %s", hcf_hcs & HCS_BUS2_ACTIVE ? "active":"not active");

which end up in dmesg as:
cpcihp_zt5550: Bus #1 is not active
cpcihp_zt5550: Bus #2 is not active

BTW, I went ahead and forced the two busses to be registered just
to see how the rest of the code works.  Everything appears to be
fine for at least booting the system board with the peripherals already
inserted.  Here is what I am seeing with a board plugged into the left
bus and a board plugged into the right bus:

cat /proc/iomem ==>
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000c9fff : Extension ROM
000ca000-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-0031050d : Kernel code
  0031050e-003e1d67 : Kernel data
f4000000-f4000fff : PCI device 1138:5550 (Ziatech Corporation)
  f4000000-f4000fff : cpcihp_zt5550
f4001000-f40013ff : Digital Equipment Co DECchip 21142/43
  f4001000-f40013ff : tulip
f4001400-f40017ff : Digital Equipment Co DECchip 21142/43 (#2)
  f4001400-f40017ff : tulip
f5000000-f5ffffff : PCI Bus #01
  f5000000-f5ffffff : Chips and Technologi F69000 HiQVideo
f6000000-f61fffff : PCI Bus #02
  f6000000-f60fffff : Digital Equipment Co DECchip 21554
  f6100000-f6100fff : Digital Equipment Co DECchip 21554
  f6101000-f6101fff : Digital Equipment Co DECchip 21554
f6200000-f63fffff : PCI Bus #03
  f6200000-f62fffff : Digital Equipment Co DECchip 21554 (#2)
  f6300000-f6300fff : Digital Equipment Co DECchip 21554 (#2)
  f6301000-f6301fff : Digital Equipment Co DECchip 21554 (#2)
f8000000-fbffffff : Intel Corp. 440BX/ZX/DX - 82443B
fffc0000-ffffffff : reserved

cat /proc/ioports ==>

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00e1-00e1 : ENUM# hotswap signal register
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-103f : Intel Corp. 82371AB/EB/MB PIIX4 
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 
1060-107f : Intel Corp. 82371AB/EB/MB PIIX4 
1080-10ff : Digital Equipment Co DECchip 21142/43
  1080-10ff : tulip
1400-147f : Digital Equipment Co DECchip 21142/43 (#2)
  1400-147f : tulip
1480-149f : PCI device 1138:5550 (Ziatech Corporation)
14a0-14af : Intel Corp. 82371AB/EB/MB PIIX4 
2000-2fff : PCI Bus #02
  2000-20ff : Digital Equipment Co DECchip 21554
  2400-24ff : Digital Equipment Co DECchip 21554
3000-3fff : PCI Bus #03
  3000-30ff : Digital Equipment Co DECchip 21554 (#2)
  3400-34ff : Digital Equipment Co DECchip 21554 (#2)

dmesg ==>

Linux version 2.5.58 (rusty@penguin) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #55 SMP Thu Jan 16 12:05:18 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
On node 0 totalpages: 65536
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Unable to locate RSDP
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=hack ro BOOT_FILE=/boot/hack console=ttyS1,115200n8 console=tty0
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 498.563 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 985.08 BogoMIPS
Memory: 255408k/262144k available (2113k kernel code, 5996k reserved, 838k data, 120k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 730.93 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd89e, last bus=3
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
ACPI: System description tables not found
    ACPI-0065: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
    ACPI-0115: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
Linux Plug and Play Support v0.94 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Cannot allocate resource region 4 of device 00:07.1
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized r128 2.3.0 20021029 on minor 0
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 11 for device 00:05.0
PCI: Sharing IRQ 11 with 02:0d.0
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip0:  Index #2 - Media 10base2 (#1) described by a 21142 Serial PHY (2) block.
tulip0:  Index #3 - Media AUI (#2) described by a 21142 Serial PHY (2) block.
tulip0:  Index #4 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0x1080, 00:80:50:02:73:75, IRQ 11.
PCI: Found IRQ 10 for device 00:06.0
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip1:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip1:  Index #2 - Media 10base2 (#1) described by a 21142 Serial PHY (2) block.
tulip1:  Index #3 - Media AUI (#2) described by a 21142 Serial PHY (2) block.
tulip1:  Index #4 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #0 config 1000 status 782d advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0x1400, 00:80:50:02:73:76, IRQ 10.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IBM-DJSA-210, ATA DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=19485/16/63
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
pci_hotplug: pci_hotplug_init: registering filesystem.
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.3
cpcihp_zt5550: hc_dev = cff66400
cpcihp_zt5550: pci resource start f4000000
cpcihp_zt5550: pci resource len 1000
cpcihp_zt5550: HCF_HCS = 0x0000003b
cpcihp_zt5550: disabling host control, fault and serial interrupts
cpcihp_zt5550: disabled host control, fault and serial interrupts
cpcihp_zt5550: disabling timer0, timer1 and ENUM# interrupts
cpcihp_zt5550: disabled timer0, timer1 and ENUM# interrupts
cpcihp_zt5550: returned from zt5550_hc_config
cpci_hotplug: cpci_hp_register_controller - acquired controller irq 9
cpcihp_zt5550: registered controller
cpcihp_zt5550: Bus #1 is not active
cpcihp_zt5550: Bus #2 is not active
cpci_hotplug: attempting to register PCI Bus #02 bus from slot 10 to 15
cpci_hotplug: initializing slot 02:0a
cpci_hotplug: registering slot 02:0a
pci_hotplug: get_mount: pcihpfs_mount_count = 1
pci_hotplug: fs_create_file: creating file '02:0a'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 02:0a to the list
cpci_hotplug: initializing slot 02:0b
cpci_hotplug: registering slot 02:0b
pci_hotplug: get_mount: pcihpfs_mount_count = 2
pci_hotplug: fs_create_file: creating file '02:0b'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 02:0b to the list
cpci_hotplug: initializing slot 02:0c
cpci_hotplug: registering slot 02:0c
pci_hotplug: get_mount: pcihpfs_mount_count = 3
pci_hotplug: fs_create_file: creating file '02:0c'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 02:0c to the list
cpci_hotplug: initializing slot 02:0d
cpci_hotplug: registering slot 02:0d
pci_hotplug: get_mount: pcihpfs_mount_count = 4
pci_hotplug: fs_create_file: creating file '02:0d'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 02:0d to the list
cpci_hotplug: initializing slot 02:0e
cpci_hotplug: registering slot 02:0e
pci_hotplug: get_mount: pcihpfs_mount_count = 5
pci_hotplug: fs_create_file: creating file '02:0e'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 02:0e to the list
cpci_hotplug: initializing slot 02:0f
cpci_hotplug: registering slot 02:0f
pci_hotplug: get_mount: pcihpfs_mount_count = 6
pci_hotplug: fs_create_file: creating file '02:0f'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 02:0f to the list
cpcihp_zt5550: registered bus 2
cpci_hotplug: attempting to register PCI Bus #03 bus from slot 10 to 15
cpci_hotplug: initializing slot 03:0a
cpci_hotplug: registering slot 03:0a
pci_hotplug: get_mount: pcihpfs_mount_count = 7
pci_hotplug: fs_create_file: creating file '03:0a'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 03:0a to the list
cpci_hotplug: initializing slot 03:0b
cpci_hotplug: registering slot 03:0b
pci_hotplug: get_mount: pcihpfs_mount_count = 8
pci_hotplug: fs_create_file: creating file '03:0b'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 03:0b to the list
cpci_hotplug: initializing slot 03:0c
cpci_hotplug: registering slot 03:0c
pci_hotplug: get_mount: pcihpfs_mount_count = 9
pci_hotplug: fs_create_file: creating file '03:0c'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 03:0c to the list
cpci_hotplug: initializing slot 03:0d
cpci_hotplug: registering slot 03:0d
pci_hotplug: get_mount: pcihpfs_mount_count = 10
pci_hotplug: fs_create_file: creating file '03:0d'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 03:0d to the list
cpci_hotplug: initializing slot 03:0e
cpci_hotplug: registering slot 03:0e
pci_hotplug: get_mount: pcihpfs_mount_count = 11
pci_hotplug: fs_create_file: creating file '03:0e'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 03:0e to the list
cpci_hotplug: initializing slot 03:0f
cpci_hotplug: registering slot 03:0f
pci_hotplug: get_mount: pcihpfs_mount_count = 12
pci_hotplug: fs_create_file: creating file '03:0f'
pci_hotplug: fs_create_file: creating file 'power'
pci_hotplug: fs_create_file: creating file 'attention'
pci_hotplug: fs_create_file: creating file 'latch'
pci_hotplug: fs_create_file: creating file 'adapter'
pci_hotplug: pci_hp_register: Added slot 03:0f to the list
cpcihp_zt5550: registered bus 3
cpci_hotplug: cpci_hp_start - enter
cpci_hotplug: init_slots - enter
cpci_hotplug: init_slots - looking at slot 03:0f
cpci_hotplug: init_slots - looking at slot 03:0e
cpci_hotplug: init_slots - looking at slot 03:0d
cpci_hotplug: init_slots - looking at slot 03:0c
cpci_hotplug: init_slots - cleared INS for slot 03:0c
cpci_hotplug: init_slots - looking at slot 03:0b
cpci_hotplug: init_slots - looking at slot 03:0a
cpci_hotplug: init_slots - looking at slot 02:0f
cpci_hotplug: init_slots - looking at slot 02:0e
cpci_hotplug: init_slots - looking at slot 02:0d
cpci_hotplug: init_slots - cleared INS for slot 02:0d
cpci_hotplug: init_slots - looking at slot 02:0c
cpci_hotplug: init_slots - looking at slot 02:0b
cpci_hotplug: init_slots - looking at slot 02:0a
cpci_hotplug: init_slots - exit
cpci_hotplug: Our thread pid = 10
cpci_hotplug: cpci_hp_start - thread started
cpci_hotplug: cpci_hp_start - enabling irq
cpci_hotplug: cpci_hp_start - exit
cpcihp_zt5550: started cPCI hotplug system
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cpci_hotplug: event_thread - event thread started
cpci_hotplug: event thread sleeping
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 120k freed
spurious 8259A interrupt: IRQ7.
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
Adding 514072k swap on /dev/hda3.  Priority:-1 extents:1
eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.
eth1: Setting full-duplex based on MII#0 link partner capability of 01e1.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?

lspci -vvv ==>
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f5000000-f5ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 165 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1080 [size=128]
	Region 1: Memory at f4001000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 165 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1400 [size=128]
	Region 1: Memory at f4001400 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 14a0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1060 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f6000000-f61fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:0b.0 Class ff00: Ziatech Corporation: Unknown device 5550 (rev 03)
	Subsystem: Ziatech Corporation: Unknown device 5550
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1480 [size=32]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]

00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=68
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f6200000-f63fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:00.0 VGA compatible controller: Chips and Technologies F69000 HiQVideo (rev 64) (prog-if 00 [VGA])
	Subsystem: Chips and Technologies F69000 HiQVideo
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:0d.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)
	Subsystem: Ziatech Corporation: Unknown device 5541
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f6101000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 2400 [size=256]
	Region 2: I/O ports at 2000 [size=256]
	Region 3: Memory at f6000000 (32-bit, non-prefetchable) [size=1M]
	Region 4: Memory at f6100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 0
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00
	Capabilities: [ec] #06 [0000]

03:0c.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)
	Subsystem: Ziatech Corporation: Unknown device 5541
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f6301000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3400 [size=256]
	Region 2: I/O ports at 3000 [size=256]
	Region 3: Memory at f6200000 (32-bit, non-prefetchable) [size=1M]
	Region 4: Memory at f6300000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 0
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00
	Capabilities: [ec] #06 [0000]




