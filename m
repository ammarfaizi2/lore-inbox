Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312867AbSCVWLF>; Fri, 22 Mar 2002 17:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312868AbSCVWK5>; Fri, 22 Mar 2002 17:10:57 -0500
Received: from elin.scali.no ([62.70.89.10]:26123 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S312867AbSCVWKk>;
	Fri, 22 Mar 2002 17:10:40 -0500
Message-ID: <3C9BAB3D.C66B7AAE@scali.com>
Date: Fri, 22 Mar 2002 23:07:57 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Interrupts lost on Intel Plumas chipset
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List readers,

I have a SuperMicro P4DPR+ system here with Dual Intel Xeon 1.7GHz. This board utilizes the Intel
E7500 (Plumas) chipset. The chipset is configured with two P64H2 (PCI-X) Hubs, one which is
connected to the onboard dual Adaptec AIC7899P controller, and the other to a open slot where I put
my high speed SCI card (a 64bit 66MHz capable card). If I boot this system with RedHat 7.2
kernel-2.4.9-21smp (and I've also tried a stock 2.4.17 kernel), interrupts from the SCI card never
gets detected by the system, here's the /proc/interrupts info  (ssci is the driver for the SCI card)
:

[root@gcle1 root]# cat /proc/interrupts 
           CPU0       CPU1       
  0:      56200          0    IO-APIC-edge  timer
  1:          3          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:       1748          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
 15:          2          0    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  usb-uhci
 17:       1992          0   IO-APIC-level  eth0
 18:          0          0   IO-APIC-level  usb-uhci
 19:          0          0   IO-APIC-level  usb-uhci
 28:       4716          0   IO-APIC-level  aic7xxx
 29:         30          0   IO-APIC-level  aic7xxx
 48:          0          0   IO-APIC-level  ssci
NMI:          0          0 
LOC:      55764      55754 
ERR:          0
MIS:          0

As a side notice I also see the "bug" reported by others which have Dual Xeon systems, all
interrupts are handeled by CPU0. Is there any patch for this yet ?

The real problem is that interrupt #48 (from the SCI card) is never triggered even though I've
checked that the SCI card has issued an interrupt (I go in and read some status registers on the
card). If I boot with "noapic", the SCI card shares a  interrupt line with the aic7xxx controllers
and everything works fine :

           CPU0       CPU1       
  0:       7518          0          XT-PIC  timer
  1:          3          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  4:        313          0          XT-PIC  serial
  5:       3760          0          XT-PIC  aic7xxx, aic7xxx, ssci
  7:          0          0          XT-PIC  usb-uhci
  8:          1          0          XT-PIC  rtc
  9:          0          0          XT-PIC  acpi
 10:          0          0          XT-PIC  usb-uhci
 11:        189          0          XT-PIC  usb-uhci, eth0
 15:          4          0          XT-PIC  ide1
NMI:          0          0 
LOC:       7177       7240 
ERR:          0
MIS:          0

For reference, here's the most important parts of my 'dmesg' output when running a 2.4.17 kernel
with the APIC's enabled (I noticed that almost all IO-APICS was "unknown", maybe that has something
to do with it ?) :

Linux version 2.4.17-3smp (root@ane.office.scali.no) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 SMP Thu Mar 21 17:50:38 MET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfef0000 (usable)
 BIOS-e820: 00000000bfef0000 - 00000000bfefc000 (ACPI data)
 BIOS-e820: 00000000bfefc000 - 00000000bff00000 (ACPI NVS)
 BIOS-e820: 00000000bff00000 - 00000000bff80000 (usable)
 BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
found SMP MP-table at 000f7030
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 786304
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 556928 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:2] APIC version 20
Processor #6 Unknown CPU [15:2] APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux2417 ro root=806 BOOT_FILE=/boot/vmlinuz-2.4.17-3smp
console=ttyS0
Initializing CPU#0
Detected 1796.979 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 3092024k/3145216k available (1403k kernel code, 52740k reserved, 979k data, 252k init,
2227648k highmem)
kdb version 2.1 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights Reserved
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
per-CPU timeslice cutoff: 1462.93 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/6 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3591.37 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
Total of 2 processors activated (7169.63 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-7, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 3-6, 3-8,
3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23, 4-1, 4-2,
4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20,
4-21, 4-22, 4-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

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
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 003 03  1    1    0   1   0    1    1    99
 12 003 03  1    1    0   1   0    1    1    A1
 13 003 03  1    1    0   1   0    1    1    A9
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
 00 003 03  1    1    0   1   0    1    1    C9
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  1    1    0   1   0    1    1    B1
 05 003 03  1    1    0   1   0    1    1    B9
 06 000 00  1    0    0   0   0    0    0    00
 07 003 03  1    1    0   1   0    1    1    C1
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
 00 003 03  1    1    0   1   0    1    1    C9
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  1    1    0   1   0    1    1    B1
 05 003 03  1    1    0   1   0    1    1    B9
 06 000 00  1    0    0   0   0    0    0    00
 07 003 03  1    1    0   1   0    1    1    C1
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
IRQ5 -> 0:5
IRQ6 -> 0:6
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
IRQ28 -> 1:4
IRQ29 -> 1:5
IRQ31 -> 1:7
IRQ48 -> 2:0
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1796.8611 MHz.
..... host bus clock speed is 99.8256 MHz.
cpu: 0, clocks: 998256, slice: 332752
CPU0<T0:998256,T1:665504,D:0,S:332752,C:998256>
cpu: 1, clocks: 998256, slice: 332752
CPU1<T0:998256,T1:332752,D:0,S:332752,C:998256>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd8c5, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Discovered primary peer bus 06 [IRQ]
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B2,I1,P0) -> 48
PCI->APIC IRQ transform: (B3,I2,P0) -> 28
PCI->APIC IRQ transform: (B3,I2,P1) -> 29
PCI->APIC IRQ transform: (B3,I4,P0) -> 31
PCI->APIC IRQ transform: (B4,I1,P0) -> 16
PCI->APIC IRQ transform: (B4,I2,P0) -> 17
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured


Clues anyone ?

Thanks in advance,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
