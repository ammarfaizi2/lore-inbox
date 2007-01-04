Return-Path: <linux-kernel-owner+w=401wt.eu-S964804AbXADMM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbXADMM7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 07:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbXADMM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 07:12:59 -0500
Received: from ppp136-210.adsl.forthnet.gr ([62.1.127.210]:15473 "EHLO
	ppp1-100.the.forthnet.gr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964804AbXADMM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 07:12:57 -0500
X-Greylist: delayed 785 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 07:12:55 EST
From: Stefanos Harhalakis <v13@it.teithe.gr>
To: linux-kernel@vger.kernel.org
Subject: slow system and bogus bogomips
Date: Thu, 4 Jan 2007 13:59:49 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041359.51826.v13@it.teithe.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

  On some boots the system is very slow. A reboot may or may not fix the 
problem. I traced this as far as I could and found the following:

  * On 'fast boots' the 'migration_cost' is low, while on 'slow boots' it is 
high, but it varies:

migration_cost=71 (fast)
migration_cost=96 (fast) 
migration_cost=482 (slow)

 * Some programs run *a lot* slower. Using strace i found out that the 
nanosleep() call takes too long. Using a simple program (attached bellow), 
the last 'slow boot' had 1/20 slower nanosleep() calls. The time of the 
current (fast) boot is about 4000 usec, while the last (slow) boot had 80000.

 * The diff of the dmesg doesn't show many differences (older slow/fast 
boots). The (-) is fast and the (+) is slow. Other differences exists but 
they happen latter, after module loading:

-Detected 3211.471 MHz processor.
+Detected 3211.603 MHz processor.

-Calibrating delay using timer specific routine.. 6428.36 BogoMIPS 
(lpj=12856730)
+Calibrating delay using timer specific routine.. 6428.39 BogoMIPS 
(lpj=12856780)

-Calibrating delay using timer specific routine.. 6423.25 BogoMIPS 
(lpj=12846518)
+Calibrating delay using timer specific routine.. 6423.21 BogoMIPS 
(lpj=12846428)

-Total of 2 processors activated (12851.62 BogoMIPS).
+Total of 2 processors activated (12851.60 BogoMIPS).

-migration_cost=96
+migration_cost=482

  * The bogomips calculations may not be correct:
Total of 2 processors activated (12851.62 BogoMIPS). (fast)
Total of 2 processors activated (12851.60 BogoMIPS). (slow - no change)
Total of 2 processors activated (110265.57 BogoMIPS). (current - fast)

The bogus bogomips (:-) seems to happen because of the CPU#1 calculation:
Calibrating delay using timer specific routine.. 6428.32 BogoMIPS 
(lpj=12856647)
Initializing CPU#1
Calibrating delay using timer specific routine.. 103837.25 BogoMIPS 
(lpj=207674508)

  * No cpu frequency scaling is done, no cpu overheating, CPU clock is always 
3.2GHz.

  * Before the problem occurred, I had another installation that did not had 
the same problem. I was using custom made 2.6.18 without problem. When i 
changed to debian (using 2.6.17) the problem occurred. The current kernel is 
a custom made 2.6.19.1, having almost everything as module.

  All of the above have been tested using 2.6.17 (debian), 2.6.18 (debian), 
2.6.19 (custom), 2.6.19.1 (custom). The current 'bogus bogompis' may be a 
result of kernel configuration and recompilation changes and may not be 
related to the fast/slow boots (you know better)

  I've searched for other posts but didn't find anything... 

  I'd appreciate CCs since I'm watching lkml through the newsgroup...

Thanks in advance...

<<V13>>

Extra information:

The simple test program:
-----
#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <string.h>

int main()
{
  struct timeval  tv1, tv2;

  while(1)
  {
    gettimeofday(&tv1, NULL);
    usleep(0);
    gettimeofday(&tv2, NULL);
    printf("\r%d", tv2.tv_usec-tv1.tv_usec + 
        (1000000 * (tv2.tv_sec-tv1.tv_sec)));
    fflush(stdout);
  }
}
-----

The current /proc/cpuinfo:

----
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 4
cpu MHz		: 3200.000
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni 
monitor ds_cpl cid xtpr
bogomips	: 6428.32

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 4
cpu MHz		: 3200.000
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni 
monitor ds_cpl cid xtpr
bogomips	: 103837.25
----

dmesg head:
----
Linux version 2.6.19.1-v2-v (root@hell) (gcc version 4.1.2 20061028 
(prerelease) (Debian 4.1.1-19)) #1 SMP Thu Dec 21 11:03:48 EET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 262064) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262064
early_node_map[1] active PFN ranges
    0:        0 ->   262064
On node 0 totalpages: 262064
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 255 pages used for memmap
  HighMem zone: 32433 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fb040
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000606 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000606 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x02000606 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000606 MSFT 0x00000097) @ 0x3ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x02000606 MSFT 0x00000097) @ 0x3ffb6e20
ACPI: DSDT (v001  A0085 A0085009 0x00000009 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
Detected 3211.631 MHz processor.
Built 1 zonelists.  Total pages: 260017
Kernel command line: root=/dev/md/5 ro log_buf_len=64k 
log_buf_len: 65536
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031616k/1048256k available (1767k kernel code, 15996k reserved, 635k 
data, 212k init, 130752k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc035f000 - 0xc0394000   ( 212 kB)
      .data : 0xc02b9cf8 - 0xc0358af4   ( 635 kB)
      .text : 0xc0100000 - 0xc02b9cf8   (1767 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6428.32 BogoMIPS 
(lpj=12856647)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000441d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 103837.25 BogoMIPS 
(lpj=207674508)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
0000441d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000441d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Total of 2 processors activated (110265.57 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=71
checking if image is initramfs... it is
Freeing initrd memory: 3885k freed
----

cpuid:
----
 eax in    eax      ebx      ecx      edx
00000000 00000005 756e6547 6c65746e 49656e69
00000001 00000f34 01020800 0000441d bfebfbff
00000002 605b5001 00000000 00000000 007c7040
00000003 00000000 00000000 00000000 00000000
00000004 00004121 01c0003f 0000001f 00000000
00000005 00000040 00000040 00000000 00000000
80000000 80000008 00000000 00000000 00000000
80000001 00000000 00000000 00000000 00000000
80000002 20202020 20202020 20202020 6e492020
80000003 286c6574 50202952 69746e65 52286d75
80000004 20342029 20555043 30322e33 007a4847
80000005 00000000 00000000 00000000 00000000
80000006 00000000 00000000 04006040 00000000
80000007 00000000 00000000 00000000 00000000
80000008 00002024 00000000 00000000 00000000

Vendor ID: "GenuineIntel"; CPUID level 5

Intel-specific functions:
Version 00000f34:
Type 0 - Original OEM
Family 15 - Pentium 4
Extended family 0
Model 3 - 
Stepping 4
Reserved 0

Extended brand string: "              Intel(R) Pentium(R) 4 CPU 3.20GHz"
CLFLUSH instruction cache line size: 8
Initial APIC ID: 1
Hyper threading siblings: 2

Feature flags bfebfbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
CLFSH  CFLUSH instruction
DS     Debug store
ACPI   Thermal Monitor and Clock Ctrl
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
SSE    Streaming SIMD Extensions instruction set
SSE2   SSE2 extensions
SS     Self Snoop
HT     Hyper Threading
TM     Thermal monitor
31     reserved

TLB and cache info:
50: Instruction TLB: 4KB and 2MB or 4MB pages, 64 entries
5b: Data TLB: 4KB and 4MB pages, 64 entries
60: unknown TLB/cache descriptor
40: No 2nd-level cache, or if 2nd-level cache exists, no 3rd-level cache
70: Trace cache: 12K-micro-op, 4-way set assoc
7c: 2nd-level cache: 1MB, 8-way set assoc, sectored, 64 byte line size
Processor serial: XXXX
----

Motherboard is Asus P5AD2 with ICH6. lspci:
----
00:00.0 Host bridge: Intel Corporation 82925X/XE Memory Controller Hub (rev 
04)
00:01.0 PCI bridge: Intel Corporation 82925X/XE PCI Express Root Port (rev 04)
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
High Definition Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 3 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface 
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 03)
01:00.0 Ethernet controller: Marvell Technology Group Ltd. 88W8310 and 
88W8000G [Libertas] 802.11g client chipset (rev 07)
01:03.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer 
Controller (rev 01)
01:04.0 Mass storage controller: <pci_lookup_name: buffer too small> (rev 13)
01:09.0 Network controller: Cologne Chip Designs GmbH ISDN network controller 
[HFC-PCI] (rev 02)
01:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
01:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
01:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
01:0b.1 Input device controller: Creative Labs SB Live! Game Port (rev 0a)
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E 
Gigabit Ethernet Controller (rev 15)
03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E 
Gigabit Ethernet Controller (rev 15)
05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev 
a2)
----
