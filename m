Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312384AbSC3KjV>; Sat, 30 Mar 2002 05:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312386AbSC3KjM>; Sat, 30 Mar 2002 05:39:12 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:7041 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S312384AbSC3Ki6>;
	Sat, 30 Mar 2002 05:38:58 -0500
Message-ID: <005401c1d7d7$20d53a30$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <linux-kernel@vger.kernel.org>
Subject: PDC20269 error handling problem
Date: Sat, 30 Mar 2002 11:38:33 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004D_01C1D7DF.6C610120"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_004D_01C1D7DF.6C610120
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I run into hard system hangs with my promise controller (kernel:
2.4.19-pre4-ac3)

Background:

* Harddisk with bad sectors.
* reading from one of the bad sectors usually causes error messages, but
sooner or later the kernel falls back from UDMA to pio.
* obviously pio doesn't work either, and ide_error is called.
* the fallback works if the harddisk is connected to a via VT82C686
south bridge.
* the fallback causes a total system hang if the drive is connected to
the promise controller.
* it hangs on the "rep;insw;" instruction in ata_input_data(), called by
try_to_flush_leftover_data().

Before someone replies that I should not try to read bad sectors: The
harddisk was used in a headless server, and I did not expect that sector
errors cause system crashes. And the crash defeats the purpose of
software raid1.

Any idea where I should continue to search? It seems that the pdc20269
controller doesn't handle the error fallback to pio. If I boot with
"ide=nodma", then pio works.

I've attached lspci and dmesg. If you have further questions, please
ask. I have a test setup with kdb.

--
    Manfred

------=_NextPart_000_004D_01C1D7DF.6C610120
Content-Type: text/plain;
	name="lspci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci.txt"

00:0a.0 Unknown mass storage controller: Promise Technology, Inc.: =
Unknown device 4d69 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 12
	I/O ports at 6300 [size=3D8]
	I/O ports at 6400 [size=3D4]
	I/O ports at 6500 [size=3D8]
	I/O ports at 6600 [size=3D4]
	I/O ports at 6700 [size=3D16]
	Memory at e1000000 (32-bit, non-prefetchable) [size=3D16K]
	Expansion ROM at <unassigned> [disabled] [size=3D16K]
	Capabilities: [60] Power Management version 1
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 63 00 00 01 64 00 00 01 65 00 00 01 66 00 00
20: 01 67 00 00 00 00 00 e1 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0c 01 04 12


------=_NextPart_000_004D_01C1D7DF.6C610120
Content-Type: text/plain;
	name="out.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="out.txt"

klogd 1.4-0, log source =3D /proc/kmsg started.
Inspecting /boot/System.map-2.4.19-pre4-ac3
Loaded 16316 symbols from /boot/System.map-2.4.19-pre4-ac3.
Symbols match kernel version 2.4.19.
No module symbols loaded.
Linux version 2.4.19-pre4-ac3 (manfred@clmsdev.localdomain) (gcc version =
2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #21 SMP Fri Mar 29 21:32:52 =
CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D301 =
BOOT_FILE=3D/boot/vmlinuz
No local APIC present or hardware disabled
Initializing CPU#0
Console: colour VGA+ 80x25
Calibrating delay loop... 119.60 BogoMIPS
Memory: 45256k/49152k available (1262k kernel code, 3512k reserved, 839k =
data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
kdb version 2.1 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights =
Reserved
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Enabling CPUID on Cyrix processor.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Cyrix ARR
CPU0: Cyrix 6x86L 2x Core/Bus Clock stepping 02
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
PCI: PCI BIOS revision 2.10 entry at 0xfb610, last bus=3D0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
block: 80 slots per queue, batch=3D20
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 2
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
VP_IDE: VIA vt82c586 (rev 02) IDE MWDMA16 controller on pci00:07.1
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:pio, hdd:pio
PDC20269: IDE controller on PCI bus 00 dev 50
PDC20269: chipset revision 2
PDC20269: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0x6700-0x6707, BIOS settings: hde:pio, hdf:pio
reset_proc is 0h.
    ide3: BM-DMA at 0x6708-0x670f, BIOS settings: hdg:pio, hdh:pio
reset_proc is 0h.
hda: IBM-DCAA-34330, ATA DISK drive
hde: Maxtor 4G160J8, ATA DISK drive
hdg: Maxtor 4G160J8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x6300-0x6307,0x6402 on irq 12
ide3 at 0x6500-0x6507,0x6602 on irq 12
hda: 8467200 sectors (4335 MB) w/96KiB Cache, CHS=3D527/255/63, DMA
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=3D19929/255/63, =
UDMA(33)
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=3D19929/255/63, =
UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
 hde: hde1
 hdg: hdg1
loop: loaded (max 8 devices)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0x6200, IRQ 10, 00:00:1C:30:58:85.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
ide-floppy driver 0.99.newide
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 313256k swap-space (priority -1)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=3D0x01 { AddrMarkNotFound }, LBAsect=3D43141736, =
high=3D2, low=3D9587304, sector=3D43141736
hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=3D0x01 { AddrMarkNotFound }, LBAsect=3D43141736, =
high=3D2, low=3D9587304, sector=3D43141736
hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=3D0x01 { AddrMarkNotFound }, LBAsect=3D43141736, =
high=3D2, low=3D9587304, sector=3D43141736
hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=3D0x01 { AddrMarkNotFound }, LBAsect=3D43141736, =
high=3D2, low=3D9587304, sector=3D43141736
hde: DMA disabled
ide2: reset: success

SYSTEM hang!!!
I don't have the remaining lines, they were something like

ide2: MULTI-READ assume all data transfered is bad status=3D??
hde: task_mulin_intr: ...
hde: task_mulin_intr: ...
/// And now =
try_to_flush_leftover_data()->ata_input_data()->'rep;insw;'->hang.


------=_NextPart_000_004D_01C1D7DF.6C610120--

