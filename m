Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTLMPNd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 10:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTLMPNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 10:13:32 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:672 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S265071AbTLMPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 10:13:20 -0500
Subject: Oops on module insertion of 3c509/3c95x
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031120231749.7cc3f245.akpm@osdl.org>
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp>
	 <20031120231749.7cc3f245.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1071328388.388.14.camel@llhosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Dec 2003 16:13:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a problem in 2.6.0-test10 and now tested with 2.6-test11-bk8 
aswell which shows itself as I accidently
tried to modprobe the wrong module (3c509) for my NIC which is:
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
And after it modprobed 3c59x.
This does NOT seem to happen with other modules, nor any other module
in the 3cxxx series other than 3c509. This happens with pci=noacpi
aswell.

The impact of this is that the module's used counter "starts" at 1, 
which makes it impossible (ok, maybe with force) to unload it.
(I cut the oops out of dmesg if anyone wonders.)
---------------------------------------------------------------

storage:~#modprobe 3c509
FATAL: Error inserting 3c509
(/lib/modules/2.6.0-test10/kernel/drivers/net/3c509.ko): No such device

storage:~# modprobe 3c59x
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
Unable to handle kernel paging request at virtual address e082cb58
 printing eip:
c0250b3f
*pde = 1ff6d067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0250b3f>]    Not tainted
EFLAGS: 00010296
EIP is at kobject_add+0x6f/0x110
eax: c039a200   ebx: e087ca5c   ecx: e082cb58   edx: e087ca78
esi: c039a208   edi: 00000000   ebp: e087ca44   esp: de5b9f04
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 347, threadinfo=de5b8000 task=defb3980)
Stack: c039a208 e087ca60 e087ca5c e087ca5c ffffffea 00000000 c0250c08
e087ca5c
       e087ca5c c039a1a0 e087ca5c c039a1a0 c0294b9a e087ca5c e0878928
00000000
       00000001 c0386bd8 c0386bd8 c029501f e087ca44 e087cb84 e0878928
c0386bf0
Call Trace:
 [<c0250c08>] kobject_register+0x28/0x60
 [<c0294b9a>] bus_add_driver+0x4a/0xa0
 [<c029501f>] driver_register+0x2f/0x40
 [<c02cf869>] eisa_driver_register+0x19/0x30
 [<e082a01f>] vortex_eisa_init+0x1f/0x80 [3c59x]
 [<e082af44>] vortex_init+0x24/0x7f [3c59x]
 [<c012f685>] sys_init_module+0x105/0x1d0
 [<c0108f1f>] syscall_call+0x7/0xb

Code: 89 11 89 4a 04 8b 43 28 8b 38 8d 4f 48 89 c8 ba ff ff 00 00
 Segmentation fault

storage:~#

---------------------------------------------------------------

storage:~# cat /proc/modules
3c59x 38472 1 - Loading 0xe0875000
rtc 11768 0 - Live 0xe0864000
ide_cd 40580 0 - Live 0xe0814000
cdrom 34656 1 ide_cd, Live 0xe0820000

---------------------------------------------------------------

storage:~# dmesg
Linux version 2.6.0-test10 (root@storage) (gcc version 3.3.2 (Debian))
#1 Mon Nov 24 18:45:56 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 VT8371                                    ) @
0x000f7890
ACPI: RSDT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x1fff3000
ACPI: FADT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x1fff3040
ACPI: DSDT (v001 VT8371 AWRDACPI 0x00001000 MSFT 0x0100000c) @
0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux-2.6-10 ro root=301
console=ttyS0,9600 console=tty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1050.212 MHz processor.
Console: colour VGA+ 80x25
Memory: 514800k/524224k available (2265k kernel code, 8676k reserved,
615k data, 392k init, 0k highmem)
Calibrating delay loop... 2068.48 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000
00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000
00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1049.0942 MHz.
..... host bus clock speed is 199.0989 MHz.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f ->
09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
SGI XFS for Linux with ACLs, realtime, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 32M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV2001H, ATA DISK drive
hdb: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39179952 sectors (20060 MB) w/2048KiB Cache, CHS=38869/16/63,
UDMA(100)
 hda: hda1 hda2
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 392k freed
EXT3 FS on hda1, internal journal
hdb: ATAPI 52X CD-ROM drive, 192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 327672k swap on /dev/vg00/swap.  Priority:-1 extents:1
Real Time Clock Driver v1.12

---------------------------------------------------------------

storage:/usr/src# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
        Subsystem: ABIT Computer Corp. KT7/KT7-RAID/KT7A/KT7A-RAID
Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ea000000-ebffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at dc00 [size=128]
        Region 1: Memory at ed000000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 SCSI storage controller: Adaptec AHA-2940UW Pro / AIC-788x (rev
01)
        Subsystem: Adaptec 2940UW Pro Ultra-Wide SCSI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at ed001000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2
GTS/Pro] (rev a3) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc. WinFast GeForce2 GTS with TV
output
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ea000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

---------------------------------------------------------------

storage:/usr/src# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1050.262
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2068.48

---------------------------------------------------------------

storage:/usr/src# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
d000-d00f : 0000:00:07.1
  d000-d007 : ide0
  d008-d00f : ide1
dc00-dc7f : 0000:00:0d.0
  dc00-dc7f : 0000:00:0d.0
e000-e0ff : 0000:00:11.0

---------------------------------------------------------------

storage:/usr/src# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000cc7ff : Extension ROM
000cd000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-003377a1 : Kernel code
  003377a2-003d153f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
e8000000-e9ffffff : 0000:00:00.0
ea000000-ebffffff : PCI Bus #01
  ea000000-eaffffff : 0000:01:00.0
ed000000-ed00007f : 0000:00:0d.0
ed001000-ed001fff : 0000:00:11.0
ffff0000-ffffffff : reserved


