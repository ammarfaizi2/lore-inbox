Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266167AbUFIQAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUFIQAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUFIQAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:00:32 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:50563 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S266167AbUFIP60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:58:26 -0400
Message-ID: <40C733A0.8080700@revicon.com>
Date: Wed, 09 Jun 2004 17:58:24 +0200
From: Lars Knudsen <gandalf@revicon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI configuration failure
Content-Type: multipart/mixed;
 boundary="------------060404060807050109020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060404060807050109020008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have encountered a problem with a box with many PCI devices. During 
boot the kernel reports "PCI: Cannot allocate resource region 0 of 
device xx:yy:zz" as can be seen in the attached dmesg.

Analyzing the output of lspci it seems that the problem is due to lack 
of I/O space. A lot
of I/O space is used by the stuff on the mainboard and each PCI bridge 
is allocated 8k
of I/O space so by the time I reach PCI bridge number 4 no further I/O 
ports can be
found.

I have read that PCI bridge I/O space must be allocated in 4k blocks so 
it seems it should
be possible to cut space used by each bridge in half, provided that the 
I/O ranges behind
the bridge will fit in 4k. In this case I have 4 devices and a total of 
6 I/O ranges behind
each bridge with two of the ranges 16 bytes long and 4 32 bytes long. 
These are configured
at 1k intervals and hence the need for 8k on the bridge instead of 4k.

I have tried to use setpci to remap the devices by taking the devices 
behind one of the
correctly configured bridges and remapping the 6 I/O ranges at 256byte 
intervals instead of
1k and then shrinking the I/O region for the bridge to 4k. I have also 
assigned the I/O space
freed by the previous operation to one of the incorrectly configured 
bridges and mapped the
I/O ranges for the devices behind this bridge to 256byte intervals. This 
approach seems at
least somewhat successfull, but it causes other problems since changing 
the bridge and
device configuration with setpci does not change the kernel structures 
representing the
pci devices - this causes problems when loading a driver for the modules.

Any suggestions on how to fix this problem are highly appreciated.

\Lars Knudsen


--------------060404060807050109020008
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.26 (root@pluto) (gcc version 3.3.3 (Debian 20040422)) #13 Mon Jun 7 13:21:22 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f62a0
ACPI: RSDT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7V600   0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Using ACPI (MADT) for SMP configuration information
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
Initializing CPU#0
Detected 1916.507 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3827.30 BogoMIPS
Memory: 515268k/524272k available (1903k kernel code, 8616k reserved, 679k data, 120k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1916.4887 MHz.
..... host bus clock speed is 333.3022 MHz.
cpu: 0, clocks: 3333022, slice: 1666511
CPU0<T0:3333008,T1:1666496,D:1,S:1666511,C:3333022>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xa9 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xc1 -> IRQ 17 Mode:1 Active:1)
00:00:0c[C] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:00:0f[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 0CF 0F  1    0    0   0   0    1    2    27
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    B9
 11 001 01  1    1    0   1   0    1    1    C1
 12 001 01  1    1    0   1   0    1    1    A9
 13 001 01  1    1    0   1   0    1    1    B1
 14 001 01  1    1    0   1   0    1    1    C9
 15 001 01  1    1    0   1   0    1    1    D1
 16 001 01  1    1    0   1   0    1    1    D9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 0 of device 06:06.0
PCI: Cannot allocate resource region 2 of device 06:06.0
PCI: Cannot allocate resource region 2 of device 06:06.1
PCI: Cannot allocate resource region 0 of device 06:07.0
PCI: Cannot allocate resource region 0 of device 06:08.0
PCI: Failed to allocate resource 0(0-1f) for 06:06.0
PCI: Failed to allocate resource 2(0-1f) for 06:06.0
PCI: Failed to allocate resource 0(0-1f) for 06:06.1
PCI: Failed to allocate resource 2(0-1f) for 06:06.1
PCI: Failed to allocate resource 0(0-f) for 06:07.0
PCI: Failed to allocate resource 0(0-f) for 06:08.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS04 at port 0xc800 (irq = 18) is a 16C950/954
ttyS05 at port 0xc808 (irq = 18) is a 16C950/954
ttyS06 at port 0xc810 (irq = 18) is a 16C950/954
ttyS07 at port 0xc818 (irq = 18) is a 16C950/954
ttyS08 at port 0xc000 (irq = 19) is a 16450
ttyS09 at port 0xc008 (irq = 19) is a 16450
ttyS10 at port 0xc010 (irq = 19) is a 16450
ttyS11 at port 0xc018 (irq = 19) is a 16450
ttyS12 at port 0xa800 (irq = 17) is a 16C950/954
ttyS13 at port 0xa808 (irq = 17) is a 16C950/954
ttyS14 at port 0xa810 (irq = 17) is a 16C950/954
ttyS15 at port 0xa818 (irq = 17) is a 16C950/954
ttyS16 at port 0xa000 (irq = 18) is a 16450
ttyS17 at port 0xa008 (irq = 18) is a 16450
ttyS18 at port 0xa010 (irq = 18) is a 16450
ttyS19 at port 0xa018 (irq = 18) is a 16450
ttyS20 at port 0x8800 (irq = 18) is a 16C950/954
ttyS21 at port 0x8808 (irq = 18) is a 16C950/954
ttyS22 at port 0x8810 (irq = 18) is a 16C950/954
ttyS23 at port 0x8818 (irq = 18) is a 16C950/954
ttyS24 at port 0x8000 (irq = 19) is a 16450
ttyS25 at port 0x8008 (irq = 19) is a 16450
ttyS26 at port 0x8010 (irq = 19) is a 16450
ttyS27 at port 0x8018 (irq = 19) is a 16450
ttyS28 at port 0x6800 (irq = 19) is a 16C950/954
ttyS29 at port 0x6808 (irq = 19) is a 16C950/954
ttyS30 at port 0x6810 (irq = 19) is a 16C950/954
ttyS31 at port 0x6818 (irq = 19) is a 16C950/954
ttyS32 at port 0x6000 (irq = 16) is a 16450
ttyS33 at port 0x6008 (irq = 16) is a 16450
ttyS34 at port 0x6010 (irq = 16) is a 16450
ttyS35 at port 0x6018 (irq = 16) is a 16450
PCI: Device 06:06.0 not available because of resource collisions
PCI: Device 06:06.1 not available because of resource collisions
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: unable to determine aperture size.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.7.0 20020828 on minor 1
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci00:0f.1
    ide0: BM-DMA at 0x2800-0x2807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2808-0x280f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 5A300J0, ATA DISK drive
blk: queue c03d4160, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 585940320 sectors (300001 MB) w/2048KiB Cache, CHS=36473/255/63, UDMA(133)
Partition check:
 hda: hda1 hda2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
es1371: version v0.32 time 13:19:09 Jun  7 2004
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding Swap: 498004k swap-space (priority -1)
3C2000: 3Com Gigabit NIC Driver Version A11
Copyright (C) 2003 3Com Corporation.
Copyright (C) 2003 Marvell.
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    scatter-gather:  enabled

--------------060404060807050109020008
Content-Type: text/plain;
 name="orig_pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="orig_pci"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Flags: bus master, 66MHz, medium devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2
00: 06 11 89 31 06 00 30 a2 80 00 00 06 00 00 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 7f 80
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: [80] Power Management version 2
00: 06 11 98 b1 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 00
20: f0 f7 e0 f7 00 f8 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
	Memory at f7000000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at d800 [size=256]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
00: b7 10 00 17 17 00 b0 02 12 00 00 02 08 20 00 00
10: 00 00 00 f7 01 d8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 eb 80
30: 00 00 00 00 48 00 00 00 00 00 00 00 0c 01 17 1f

0000:00:0a.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: f3000000-f6ffffff
	Capabilities: [dc] Power Management version 2
00: 86 80 52 b1 07 00 90 02 00 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 b1 c1 80 22
20: 00 f3 f0 f6 01 f8 f1 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 00

0000:00:0b.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: ef000000-f2ffffff
	Capabilities: [dc] Power Management version 2
00: 86 80 52 b1 07 00 90 02 00 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 20 91 a1 80 22
20: 00 ef f0 f2 01 f8 f1 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 00

0000:00:0c.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at f7ff0000 [disabled] [size=64K]
00: 33 53 01 8a 07 00 00 02 01 00 00 03 00 20 00 00
10: 00 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 53 01 8a
30: 00 00 ff f7 00 00 00 00 00 00 00 00 05 01 04 ff

0000:00:0d.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	I/O behind bridge: 00007000-00008fff
	Memory behind bridge: e4000000-e7ffffff
	Capabilities: [dc] Power Management version 2
00: 86 80 52 b1 07 00 90 02 00 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 71 81 80 22
20: 00 e4 f0 e7 f1 f7 e1 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 00

0000:00:0e.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 00005000-00006fff
	Memory behind bridge: e0000000-e3ffffff
	Capabilities: [dc] Power Management version 2
00: 86 80 52 b1 07 00 90 02 00 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 05 05 20 51 61 80 22
20: 00 e0 f0 e3 f1 f7 e1 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 00

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at 4800 [size=8]
	I/O ports at 4400 [size=4]
	I/O ports at 4000 [size=8]
	I/O ports at 3800 [size=4]
	I/O ports at 3400 [size=16]
	I/O ports at 3000 [size=256]
	Capabilities: [c0] Power Management version 2
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 48 00 00 01 44 00 00 01 40 00 00 01 38 00 00
20: 01 34 00 00 01 30 00 00 00 00 00 00 43 10 ed 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 02 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at 2800 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 28 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:13.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	Memory behind bridge: db800000-df7fffff
	Capabilities: [dc] Power Management version 2
00: 86 80 52 b1 07 00 90 02 00 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 06 06 20 f1 01 80 22
20: 80 db 70 df f1 f7 e1 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 00

0000:02:06.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 18
	I/O ports at c800 [size=32]
	Memory at f6800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c400 [size=32]
	Memory at f6000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 01 95 03 00 90 02 00 06 00 07 00 00 80 00
10: 01 c8 00 00 00 00 80 f6 01 c4 00 00 00 00 00 f6
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0c 01 00 00

0000:02:06.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 1
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 19
	I/O ports at c000 [size=32]
	Memory at f5800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at b800 [size=32]
	Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 11 95 03 00 90 02 00 00 80 06 00 00 80 00
10: 01 c0 00 00 00 00 80 f5 01 b8 00 00 00 00 00 f5
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 02 00 00

0000:02:07.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at b400 [size=16]
	Memory at f4800000 (32-bit, non-prefetchable) [size=4K]
	Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 b4 00 00 00 00 80 f4 00 00 00 f4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 ff 01

0000:02:08.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at b000 [size=16]
	Memory at f3800000 (32-bit, non-prefetchable) [size=4K]
	Memory at f3000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 b0 00 00 00 00 80 f3 00 00 00 f3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 ff 01

0000:03:06.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 17
	I/O ports at a800 [size=32]
	Memory at f2800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at a400 [size=32]
	Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 01 95 03 00 90 02 00 06 00 07 00 00 80 00
10: 01 a8 00 00 00 00 80 f2 01 a4 00 00 00 00 00 f2
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00

0000:03:06.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 1
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 18
	I/O ports at a000 [size=32]
	Memory at f1800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 9800 [size=32]
	Memory at f1000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 11 95 03 00 90 02 00 00 80 06 00 00 80 00
10: 01 a0 00 00 00 00 80 f1 01 98 00 00 00 00 00 f1
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0c 02 00 00

0000:03:07.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at 9400 [size=16]
	Memory at f0800000 (32-bit, non-prefetchable) [size=4K]
	Memory at f0000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 94 00 00 00 00 80 f0 00 00 00 f0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 ff 01

0000:03:08.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at 9000 [size=16]
	Memory at ef800000 (32-bit, non-prefetchable) [size=4K]
	Memory at ef000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 90 00 00 00 00 80 ef 00 00 00 ef 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 ff 01

0000:04:06.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 18
	I/O ports at 8800 [size=32]
	Memory at e7800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 8400 [size=32]
	Memory at e7000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 01 95 03 00 90 02 00 06 00 07 00 00 80 00
10: 01 88 00 00 00 00 80 e7 01 84 00 00 00 00 00 e7
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0c 01 00 00

0000:04:06.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 1
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 19
	I/O ports at 8000 [size=32]
	Memory at e6800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 7800 [size=32]
	Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 11 95 03 00 90 02 00 00 80 06 00 00 80 00
10: 01 80 00 00 00 00 80 e6 01 78 00 00 00 00 00 e6
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 02 00 00

0000:04:07.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at 7400 [size=16]
	Memory at e5800000 (32-bit, non-prefetchable) [size=4K]
	Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 74 00 00 00 00 80 e5 00 00 00 e5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 ff 01

0000:04:08.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at 7000 [size=16]
	Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
	Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 70 00 00 00 00 80 e4 00 00 00 e4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 ff 01

0000:05:06.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 19
	I/O ports at 6800 [size=32]
	Memory at e3800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 6400 [size=32]
	Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 01 95 03 00 90 02 00 06 00 07 00 00 80 00
10: 01 68 00 00 00 00 80 e3 01 64 00 00 00 00 00 e3
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00

0000:05:06.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 1
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 16
	I/O ports at 6000 [size=32]
	Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 5800 [size=32]
	Memory at e2000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 11 95 03 00 90 02 00 00 80 06 00 00 80 00
10: 01 60 00 00 00 00 80 e2 01 58 00 00 00 00 00 e2
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 02 00 00

0000:05:07.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at 5400 [size=16]
	Memory at e1800000 (32-bit, non-prefetchable) [size=4K]
	Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 54 00 00 00 00 80 e1 00 00 00 e1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 ff 01

0000:05:08.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at 5000 [size=16]
	Memory at e0800000 (32-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 50 00 00 00 00 80 e0 00 00 00 e0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 ff 01

0000:06:06.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 16
	I/O ports at <ignored> [size=32]
	Memory at df000000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at <ignored> [size=32]
	Memory at de800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 01 95 03 00 90 02 00 06 00 07 00 00 80 00
10: 01 08 00 00 00 00 00 df 01 04 00 00 00 00 80 de
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00

0000:06:06.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 1
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	Flags: medium devsel, IRQ 17
	I/O ports at <unassigned> [size=32]
	Memory at de000000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at <ignored> [size=32]
	Memory at dd800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
00: 15 14 11 95 03 00 90 02 00 00 80 06 00 00 80 00
10: 01 00 00 00 00 00 00 de 01 f8 ff ff 00 00 80 dd
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 00 00

0000:06:07.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at <ignored> [size=16]
	Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
	Memory at dc800000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 f4 ff ff 00 00 00 dd 00 00 80 dc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 ff 01

0000:06:08.0 Multimedia video controller: Winbond Electronics Corp: Unknown device 9921 (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at <ignored> [size=16]
	Memory at dc000000 (32-bit, non-prefetchable) [size=4K]
	Memory at db800000 (32-bit, non-prefetchable) [size=4K]
00: 50 10 21 99 07 00 80 02 03 00 00 04 00 20 00 00
10: 01 f0 ff ff 00 00 00 dc 00 00 80 db 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 ff 01


--------------060404060807050109020008--

