Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316073AbSEJRTk>; Fri, 10 May 2002 13:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316075AbSEJRTj>; Fri, 10 May 2002 13:19:39 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:22483 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316073AbSEJRTh>;
	Fri, 10 May 2002 13:19:37 -0400
From: "Kosta Porotchkin" <kporotchkin@gmx.net>
To: "Linux Kernel mailing List \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: PCI bus interrupts problem on dual Xeon SMP system
Date: Fri, 10 May 2002 12:19:33 -0600
Message-ID: <000701c1f84f$602fe160$a396a8c0@compaq12xl510a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Platform:  SuperMicro P4DP6 motherboard (Intel E7500 chipset) with two Intel
Xeon Processors (512 Kb L2 cache @ 2.2 GHz), 1 Gb PC2100 RAM. Phoenix BIOS
1.1a (latest available for this board). Hyper threading enabled, ACPI
enabled.
Two onboard LAN controllers (Intel i82557/i82558), 6 PCI/PCI-X slots (in PCI
mode). Onboard SCSI controller disabled.

Kernel:    2.4.17_mvl21-x330 (MontaVista 2.1) + LKCD patch and IRQ routing
patch (from Ingo Molnar), SMP enabled.

Problem Description:
The system boots kernel using Etherboot. When using onboard LAN controller,
everything is OK. I wanted to check all the PCI buses (64 bit) using Intel
10/100 LAN card (32 bit PCI). The system can boot from any bus, download and
run the kernel. The problem is discovered during the root (NFS) file system
mount (NFS server timeout, - looks like no interrupts are coming from the
Ethernet card after kernel initialization). The only fully working PCI slots
are #4 and #5. When the Ethernet card is inserted in one of them I got the
following messages (everything is working, boot and NFS mount are OK):

****************From the IO-APIC testing procedure:******************

IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ72 -> 3:0 		(for PCI slot #4)
OR
IRQ24 -> 1:0 		(for PCI slot #5)

********************Then from PCI discovery procedure*****************

PCI: PCI BIOS revision 2.10 entry at 0xfd885, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 10 [IRQ]
PCI: Discovered primary peer bus 11 [IRQ]
PCI: Discovered primary peer bus 12 [IRQ]
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B6,I1,P0) -> 72            (for PCI slot #4)
OR
PCI->APIC IRQ transform: (B3,I1,P0) -> 24            (for PCI slot #5)
PCI->APIC IRQ transform: (B7,I1,P0) -> 16
PCI->APIC IRQ transform: (B7,I2,P0) -> 17
PCI->APIC IRQ transform: (B7,I3,P0) -> 18

**************************************************************************
The IDE controller driver is not working (probably this chipset is not
supported yet),
but all the Ethernet cards are looking good:
**************************************************************************

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=248b
PCI: Device 00:1f.1 not available because of resource collisions
PCI_IDE: error while enabling PCI device
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.1 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: PCI device 8086:1030, 00:03:47:B2:39:74, IRQ 72.   (for PCI slot #4)
OR
eth0: PCI device 8086:1030, 00:03:47:B2:39:74, IRQ 24.   (for PCI slot #5)
  Board assembly 742252-003, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:30:48:12:1E:6C, IRQ 17.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
eth2: OEM i82557/i82558 10/100 Ethernet, 00:30:48:12:2B:24, IRQ 18.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).

**************************************************************************
For the rest of PCI slots I got the following (all messages are the same,
except that
I cannot see the IO-APIC testing messages, as the system is not finishing
booting):

PCI->APIC IRQ transform: (B5,I3,P0) -> 104           (slot #1)
PCI->APIC IRQ transform: (B5,I2,P0) -> 100           (slot #2)
PCI->APIC IRQ transform: (B5,I1,P0) -> 96            (slot #3)
PCI->APIC IRQ transform: (B2,I1,P0) -> 48            (slot #6)

Every time, the above interrupt is assigned to the Ethernet controller.

As we can see, the problem is discovered on buses B2 and B5 only.
It does not looks like HW IRQ conflict as no one else is sitting on B2 and
B5 buses
(see the PCI bus devices list at the end of this message).
Maybe this problem is coming from IO APIC re-programming?.
Any help will be greatly appreciated.

Thanks

Kosta Porotchkin

**************************************************************************
PCI devices list:

00:00.0 Host bridge: Intel Corporation: Unknown device 2540 (rev 02)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, fast devsel, latency 0

00:00.1 Class ff00: Intel Corporation: Unknown device 2541 (rev 02)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: fast devsel

00:02.0 PCI bridge: Intel Corporation: Unknown device 2543 (rev 02) (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fc100000-fc3fffff

00:03.0 PCI bridge: Intel Corporation: Unknown device 2545 (rev 02) (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
	Memory behind bridge: fc400000-fc4fffff

00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at 1400 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 1420 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 1440 [size=32]

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev
42) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc500000-fdffffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2480 (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02)
(prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, medium devsel, latency 0
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at 1460 [size=16]
	Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 02)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: medium devsel
	I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20
[IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

01:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	Capabilities: [50] #07 [0083]

01:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20
[IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

01:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=48
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fc200000-fc3fffff
	Capabilities: [50] #07 [0003]

03:01.0 Ethernet controller: Intel Corporation 82559 InBusiness 10/100 (rev
08)
	Subsystem: Intel Corporation 82559 InBusiness 10/100
	Flags: bus master, medium devsel, latency 66, IRQ 24
	Memory at fc300000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 2000 [size=64]
	Memory at fc200000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

04:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20
[IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at fc400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

04:1d.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
	Capabilities: [50] #07 [0003]

04:1e.0 PIC: Intel Corporation: Unknown device 1461 (rev 03) (prog-if 20
[IO(X)-APIC])
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at fc401000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] #07 [0000]

04:1f.0 PCI bridge: Intel Corporation: Unknown device 1460 (rev 03) (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=48
	Capabilities: [50] #07 [0003]

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 16
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 3000 [size=256]
	Memory at fc500000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2

07:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at fc501000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3400 [size=64]
	Memory at fc520000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2

07:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Flags: bus master, medium devsel, latency 64, IRQ 18
	Memory at fc502000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3440 [size=64]
	Memory at fc540000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2


---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.361 / Virus Database: 199 - Release Date: 5/7/2002


