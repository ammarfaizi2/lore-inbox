Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUBWOa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUBWOaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:30:55 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:8075 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261878AbUBWOao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:30:44 -0500
Subject: 2.6.3 oops at kobject_unregister, alsa & aic7xxx
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077546633.362.28.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 15:30:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens at shutdown when alsa is to close down. I'm running debian
sid. NOTE: I recently removed my aic7xxx out of the motherboard, so the
driver obviously can't find it. But if I remove aic7xxx from the modules
list, this oops does _not_ happen.
I only had 2.6.3-rc1 available, and it behaved the same way.

alex@testme:~$ cat /etc/modules
3c59x
snd-emu10k1
aha152x io=0x340 irq=9 reconnect=1
sd_mod
aic7xxx
st


testme:~# Unable to handle kernel paging request at virtual address
e09e16dc
 printing eip:
c01c0c43
*pde = 1fe87067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01c0c43>]    Not tainted
EFLAGS: 00010246
EIP is at unlink+0x33/0x70
eax: e089c4f8   ebx: e089c4dc   ecx: c02bfed8   edx: e09e16d8
esi: c02b7e20   edi: c02b2238   ebp: 00000000   esp: df7b7f1c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 445, threadinfo=df7b6000 task=de5c8720)
Stack: e089c4dc c02b7e20 c01c0f43 e089c4dc e089c4c4 c01eacce e089c4dc
e089c4c4
       00000080 c01eb0c3 e089c4c4 e089d040 c01c62e2 e089c4c4 e0895baf
e089c4a0
       c012d609 e089d040 0804e320 0000003b 00000000 5f646e73 31756d65
00316b30
Call Trace:
 [<c01c0f43>] kobject_unregister+0x13/0x30
 [<c01eacce>] bus_remove_driver+0x5e/0x80
 [<c01eb0c3>] driver_unregister+0x13/0x28
 [<c01c62e2>] pci_unregister_driver+0x12/0x20
 [<e0895baf>] alsa_card_emu10k1_exit+0xf/0x35 [snd_emu10k1]
 [<c012d609>] sys_delete_module+0x139/0x1b0
 [<c013f1eb>] do_munmap+0x11b/0x150
 [<c0108c9f>] syscall_call+0x7/0xb
 
Code: 89 4a 04 89 11 89 40 04 89 43 1c 8b 43 28 8b 30 8d 4e 48 89
  
alex@boxen:/home/devel/fixme$ dec.pl 89 4a 04 89 11 89 40 04 89 43 1c 8b
43 28 8b 30 8d 4e 48 89
(gdb) disass dme
Dump of assembler code for function dme:
0x08049470 <dme+0>:     mov    %ecx,0x4(%edx)
0x08049473 <dme+3>:     mov    %edx,(%ecx)
0x08049475 <dme+5>:     mov    %eax,0x4(%eax)
0x08049478 <dme+8>:     mov    %eax,0x1c(%ebx)
0x0804947b <dme+11>:    mov    0x28(%ebx),%eax
0x0804947e <dme+14>:    mov    (%eax),%esi
0x08049480 <dme+16>:    lea    0x48(%esi),%ecx
0x08049483 <dme+19>:    mov    %eax,(%eax)
0x08049485 <dme+21>:    add    %al,(%eax)
0x08049487 <dme+23>:    add    %al,(%eax)
End of assembler dump.
(gdb) q



alex@testme:~$ dmesg
Linux version 2.6.3 (alex@testme) (gcc version 3.3.3 20040125
(prerelease) (Debian)) #2 Thu Feb 19 23:37:37 CET 2004
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
Built 1 zonelists
Kernel command line: root=/dev/hda2 console=tty0 console=ttyS0,19200
console=ttyS1,9600
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1400.299 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515768k/524224k available (1494k kernel code, 7692k reserved,
463k data, 388k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 2752.51 BogoMIPS
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
..... CPU clock speed is 1399.0810 MHz.
..... host bus clock speed is 266.0630 MHz.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f ->
09
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
spurious 8259A interrupt: IRQ7.
Machine check exception polling timer started.
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:0f.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
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
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39179952 sectors (20060 MB) w/2048KiB Cache, CHS=38869/16/63,
UDMA(100)
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 388k freed
Adding 488368k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
PCI: Found IRQ 11 for device 0000:00:0f.0
PCI: Sharing IRQ 11 with 0000:00:0d.0
SCSI subsystem initialized
aha152x: BIOS test: passed, 1 controller(s) configured
aha152x: resetting bus...
aha152x0: vital data: rev=1, io=0x340 (0x340/0x340), irq=9, scsiid=7,
reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000,
extended translation=disabled
aha152x0: trying software interrupt, ok.
scsi0 : Adaptec 152x SCSI driver; $Revision: 2.7 $
st: Version 20040122, fixed bufsize 32768, s/g segs 256
nfs warning: mount version older than kernel



alex@testme:~$ lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
        Subsystem: ABIT Computer Corp. KT7/KT7-RAID/KT7A/KT7A-RAID
Mainboard
        Flags: bus master, medium devsel, latency 8
        Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        Capabilities: <available only to root>
 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device 0000
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>
 
00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: <available only to root>

 
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d400 [size=32]
        Capabilities: <available only to root>
 
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800 [size=32]
        Capabilities: <available only to root>
 
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 11
        Capabilities: <available only to root>
 
00:09.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 01) (prog-if 00 [VGA])
        Flags: stepping, medium devsel, IRQ 5
        Memory at de000000 (32-bit, non-prefetchable) [disabled]
[size=16K]
        Memory at df000000 (32-bit, prefetchable) [disabled] [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=128]
        Memory at e1000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>
 
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)
        Subsystem: Creative Labs: Unknown device 8066
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e000 [size=32]
        Capabilities: <available only to root>
 
00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at e400 [size=8]
        Capabilities: <available only to root>
 
01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2
GTS/Pro] (rev a3) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc. WinFast GeForce2 GTS with TV
output
        Flags: bus master, VGA palette snoop, 66Mhz, medium devsel,
latency 32, IRQ 10
        Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>
 




