Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314650AbSEFSNe>; Mon, 6 May 2002 14:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314651AbSEFSNd>; Mon, 6 May 2002 14:13:33 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:57940 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314650AbSEFSN1>;
	Mon, 6 May 2002 14:13:27 -0400
From: "Kosta Porotchkin" <kporotchkin@gmx.net>
To: <linux-kernel@vger.kernel.org>
Cc: <kporotchkin@gmx.net>
Subject: Wrong IRQ distribution on Dual Xeon SMP system (2.4.17).
Date: Mon, 6 May 2002 13:13:21 -0600
Message-ID: <003901c1f532$4116fcc0$a396a8c0@compaq12xl510a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:  Wrong interrupts distribution between processors, as a result of
IO APIC configuration errors

Platform:  SuperMicro P4DP6 motherboard (Intel E7500 chipset) with two Intel
Xeon Processors (512 Kb L2 cache @ 2.2 GHz), 1 Gb PC2100 RAM. Phoenix BIOS
1.1a (latest available for this board). Hyper threading enabled, ACPI
enabled.

Kernel:    2.4.17 Sherman-x330 (MontaVista) - SMP enabled.

Problem Description:

After booting the /proc/interrupts files reads as follows:

           CPU0       CPU1       CPU2       CPU3
  0:      23794          0          0          0    IO-APIC-edge  timer
  1:       1900          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  4:          0          0          0          0    IO-APIC-edge  KGDB-stub
  9:          0          0          0          0    IO-APIC-edge  acpi
 17:       4718          0          0          0   IO-APIC-level  eth0
NMI:      23672      23672      23672      23672
LOC:      23649      23648      23648      23646
ERR:          0
MIS:          0
****************************************************************************
**
Some entries from dmesg output:
****************************************************************************
**
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fefc000 (ACPI data)
 BIOS-e820: 000000003fefc000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
found SMP MP-table at 000f6710
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:2] APIC version 20
Processor #6 Unknown CPU [15:2] APIC version 20
Processor #1 Unknown CPU [15:2] APIC version 20
Processor #7 Unknown CPU [15:2] APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
I/O APIC #5 Version 32 at 0xFEC81000.
I/O APIC #8 Version 32 at 0xFEC81400.
Processors: 4

**********************************************************************
Each logical processor has its own LAPIC.
This board has two Intel PCI/PCI-X Hubs (P64H2), each of them has two I/O
APICs (one for primary and one for secondary bus).
The following is delivered from Intel E7500 specification (paragraph 4.1.4 -
I/O APIC Memory Space):
Two I/O APICs a (I/OAPIC1 (HI_B)) are located in memory region 0xFEC80000 -
0xFEC80FFF, the next two (I/OAPIC2 (HI_C)) in memory region 0xFEC81000 -
0xFEC81FFF.
The fifth I/O APIC is coming from I/O Controller hub (ICH3) - I/O APIC #2 in
the above printout or I/O APIC0 (HI_A) according to the Intel E7500 chipset
Memory Range Address Map.
The addresses reported by Linux setup procedure are falling in the above
noted ranges. I tried to force kernel to use the ACPI tables instead of MP
table in order to see if the last one is correct. The addresses of I/O APICs
from the ACPI table were exactly the same as in MP table. For me this is
indication that there is no error in MP table (Am I wrong?).
As part of kernel initialization process, all the I/O APIC IDs were updated:
**********************************************************************
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23, 3-0,
3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14,
3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-0, 4-1, 4-2, 4-3,
4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16,
4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6,
5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15, 5-16, 5-17, 5-18, 5-19,
5-20, 5-21, 5-22, 5-23, 8-0, 8-1, 8-2, 8-3, 8-4, 8-5, 8-6, 8-7, 8-8, 8-9,
8-10, 8-11, 8-12, 8-13, 8-14, 8-15, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21,
8-22, 8-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
number of IO-APIC #5 registers: 24.
number of IO-APIC #8 registers: 24.
*************************************************************************
The problems starts to appear during the I/O APIC tests. The I/O Controller
Hub I/O APIC shows 0x020080000, which is wrong according to the I/O APIC
specification (should be 0x02000000 in my case), which cause kernel to print
a warning message.
Both I/O APICS of first P64H2 reported the same physical ID. The same
situation is for second P64H2:
*************************************************************************
IO APIC #2......
.... register #00: 02008000
.......    : physical APIC id: 02
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  0    0    0   0   0    1    1    51
 07 00F 0F  0    0    0   0   0    1    1    59
 08 00F 0F  0    0    0   0   0    1    1    61
 09 00F 0F  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    71
 0d 00F 0F  0    0    0   0   0    1    1    79
 0e 00F 0F  0    0    0   0   0    1    1    81
 0f 00F 0F  0    0    0   0   0    1    1    89
 10 00F 0F  1    1    0   1   0    1    1    91
 11 00F 0F  1    1    0   1   0    1    1    99
 12 00F 0F  1    1    0   1   0    1    1    A1
 13 00F 0F  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #5......
.... register #00: 08000000
.......    : physical APIC id: 08
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
***************************************************************************
Do someone has any suggestions to solve this problem?
Any help will be greatly appreciated.

Kosta Porotchkin

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.351 / Virus Database: 197 - Release Date: 4/19/2002


