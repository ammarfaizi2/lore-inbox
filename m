Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbTLKQrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265174AbTLKQrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:47:00 -0500
Received: from main.aitcom.net ([208.234.1.35]:10963 "EHLO ait.com")
	by vger.kernel.org with ESMTP id S265167AbTLKQpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:45:11 -0500
Message-ID: <3FD89EF5.30101@nova.org>
Date: Thu, 11 Dec 2003 11:44:37 -0500
From: Ken <ken@nova.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ken@nova.org
Subject: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
Content-Type: multipart/mixed;
 boundary="------------020002010408040109080805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020002010408040109080805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am a long time Linux user who has observed a behavior in recent 2.4.x 
kernels that I consider undesirable.  I have read the FAQ, 
'googled'/searched the LKML archives, "lurked" on the list via archives, 
and contacted the Maintainer directly prior to posting.  Since Marcelo 
has announced the freezing of 2.4, I believe this is the appropriate 
time/forum to raise this issue.  This issue may be related to other 
recent threads with similar subjects, but has not been addressed IMHO.


I have found that each kernel in 2.4.[19|20|21|22|23] detects my Dual 
(2) Xeon HT CPUs and maps hardware IRQs, but does not distribute 
interrupts from the IRQs across the 4 logical CPUs.  All interrupts seem 
to be handled by CPU0 except for LOC, which is per CPU.  In each case, I 
have corrected the behavior by applying Ingo's 
"linux-2.4.18-irqbalance.patch" which I found in an archive.  Thank you, 
Ingo, for posting it -- it has been a lifesaver. ;-)  I've found that it 
now exists by other names in various places.

For example, I have an Intel SR2300 based on an Intel SE7501-WV2 MB with 
  two Xeon 2.4G (HT) CPUs and E7500 (Plumas) chip set.  Booting the 
vanilla kernel results in this:

# `cat /proc/interrupts` from 2.4.23 (essentially vanilla)

            CPU0       CPU1       CPU2       CPU3
   0:      23147          0          0          0    IO-APIC-edge  timer
   1:         49          0          0          0    IO-APIC-edge  keyboard
   2:          0          0          0          0          XT-PIC  cascade
   8:          1          0          0          0    IO-APIC-edge  rtc
  15:          4          1          0          0    IO-APIC-edge  ide1
  16:          0          0          0          0   IO-APIC-level  usb-uhci
  19:          0          0          0          0   IO-APIC-level  usb-uhci
  24:     247647          0          0          0   IO-APIC-level  eth3
  27:          6          0          0          0   IO-APIC-level  eth2
  31:       1509          0          0          0   IO-APIC-level  eth0
  48:       2663          0          0          0   IO-APIC-level  dpti0
NMI:          0          0          0          0
LOC:      22996      22929      22995      22994
ERR:          0
MIS:          0



However, if I use Ingo's irq_balance patch, I get this:

# `cat /proc/interrupts` on 2.4.23 w/ irq-balancing patch

            CPU0       CPU1       CPU2       CPU3
   0:      67879      87331      67921      86498    IO-APIC-edge  timer
   1:          1          0          0          1    IO-APIC-edge  keyboard
   2:          0          0          0          0          XT-PIC  cascade
   8:          1          0          0          0    IO-APIC-edge  rtc
  15:          4          0          0          1    IO-APIC-edge  ide1
  16:          0          0          0          0   IO-APIC-level  usb-uhci
  19:          0          0          0          0   IO-APIC-level  usb-uhci
  24:   14524668   17990352   14614712   17901660   IO-APIC-level  eth3
  27:        341        431        341        421   IO-APIC-level  eth2
  31:      10656      13555      10724      14244   IO-APIC-level  eth0
  48:       2483       2997       2603       2874   IO-APIC-level  dpti0
NMI:          0          0          0          0
LOC:     309474     309472     309472     309405
ERR:          0
MIS:          0


It is my understanding that Ingo's patch implements a "Brownian motion" 
of the interrupts.  While I'm unqualified to comment on the mathematical 
theory, I will confirm that I perceive a real improvement in 
performance.  The CPU activity reported by 'top' definitely shows better 
balance across logical CPUs.  The dmesg output for both scenarios is 
also attached.

I get similar results on all my Dell 2650 servers which have the Server 
Works chip set (specs at support.dell.com).  Also, there doesn't seem to 
  be any difference in behavior by selecting/deselecting full/ht/off 
ACPI support, if that is relevant.  I know that ACPI is used to scan the 
tables regardless -- you'll note proper detection and sibling mapping in 
both.  Furthermore, I note that if I disable HT in BIOS, I can get the 
two CPU balancing of interrupts seen on any non-HT SMP box, e.g., dual 
PIII on i440GX chip set.

But, as of 2.4.23 Ingo's patch doesn't apply cleanly, so I modified it. 
It is attached for your review -- NOTA BENE:  it works and I'm running 
it in production with moderate to heavy loads, but I don't know if I've 
introduced a bug somewhere else.  I've only tested it on the hardware 
mentioned above.

I have attempted user space alternatives -- irq_balance-0.06 and 
smp_affinity via sysctrl.  The former seems to "blindly" affine an IRQ 
to a single logical CPU, which in my case, puts the timer and eth3 on 
CPU0 and it gets "overloaded" while the others are mostly idle.  Using a 
mask with the latter results in the low number sibling handling the 
interrupts and the other sibling doing nothing/little.  Specifically, I 
use a mask of 0x03 on, say, IRQ 24 in an effort to use logical CPUs 0-1 
and only CPU0 shows activity via /proc/interrupts.  Likewise, a mask of 
0x0C on, say, IRQ 48 in an effort to use logical CPUs 2-3 and only CPU2 
shows activity.  The perceived performance in both cases is much less 
than using the patch.

Also, I noticed that Nitin Kamble had submitted a possible alternative 
patch to 2.5.  In offline discussion with him, he preferred a discussion 
here prior to doing a back port.

I ask that Ingo's, Nitin's, or somebody's work be considered for 
inclusion in the 2.4 mainline kernel to address this issue.  It doesn't 
seem intrusive, it doesn't break anything I can find, and it "fixes" 
part of an existing "feature".  I'm willing to test what I can or 
provide what I can.  I don't have the skills to be a kernel programmer, 
but I can follow instructions.

Thank you for your time and effort on this issue.  Please reply by CC 
and post since I am not subscribed.  I follow LKML by archive and Kernel 
Traffic (thanks - KT).

Regards,
Ken Beaty

--------------020002010408040109080805
Content-Type: text/plain;
 name="boot.log.2423ht.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.log.2423ht.txt"

# dmesg output from 2.4.23 (essentially vanilla)

Linux version 2.4.23 (root@scythe) (gcc version 3.2.2) #2 SMP Tue Dec 9 10:30:24 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
 BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: RSDP (v000 INTEL                                     ) @ 0x000ff9b0
ACPI: RSDT (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff0000
ACPI: FADT (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff0030
ACPI: MADT (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff00b0
ACPI: OEMR (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff0140
ACPI: DSDT (v001  INTEL    SWV20 0x00000100 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x3] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: SWV20        APIC at: 0xFEE00000
I/O APIC #8 Version 32 at 0xFEC00000.
I/O APIC #9 Version 32 at 0xFEC81000.
I/O APIC #10 Version 32 at 0xFEC81400.
Enabling APIC mode: Flat.	Using 3 I/O APICs
Processors: 4
Kernel command line: auto BOOT_IMAGE=BBFKernel ro root=801 idebus=33 acpi=ht
ide_setup: idebus=33
Initializing CPU#0
Detected 2392.994 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 2068636k/2097088k available (2045k kernel code, 28044k reserved, 646k data, 116k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/6 eip 3000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/7 eip 3000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (19123.40 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
Setting 9 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 9 ... ok.
Setting 10 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 10 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-18, 8-20, 8-21, 8-22, 8-23, 9-1, 9-2, 9-4, 9-5, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 9-16, 9-17, 9-18, 9-19, 9-20, 9-21, 9-22, 9-23, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15, 10-16, 10-17, 10-18, 10-19, 10-20, 10-21, 10-22, 10-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 25.
number of IO-APIC #8 registers: 24.
number of IO-APIC #9 registers: 24.
number of IO-APIC #10 registers: 24.
testing the IO APIC.......................

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  0    0    0   0   0    1    1    51
 06 00F 0F  0    0    0   0   0    1    1    59
 07 00F 0F  0    0    0   0   0    1    1    61
 08 00F 0F  0    0    0   0   0    1    1    69
 09 00F 0F  0    0    0   0   0    1    1    71
 0a 00F 0F  0    0    0   0   0    1    1    79
 0b 00F 0F  0    0    0   0   0    1    1    81
 0c 00F 0F  0    0    0   0   0    1    1    89
 0d 00F 0F  0    0    0   0   0    1    1    91
 0e 00F 0F  0    0    0   0   0    1    1    99
 0f 00F 0F  0    0    0   0   0    1    1    A1
 10 00F 0F  1    1    0   1   0    1    1    A9
 11 00F 0F  1    1    0   1   0    1    1    B1
 12 000 00  1    0    0   0   0    0    0    00
 13 00F 0F  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 09000000
.......     : arbitration: 09
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 00F 0F  1    1    0   1   0    1    1    C1
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  1    1    0   1   0    1    1    C9
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  1    1    0   1   0    1    1    D1
 07 00F 0F  1    1    0   1   0    1    1    D9
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

IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0A000000
.......     : arbitration: 0A
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 00F 0F  1    1    0   1   0    1    1    E1
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
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ27 -> 1:3
IRQ30 -> 1:6
IRQ31 -> 1:7
IRQ48 -> 2:0
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2393.0461 MHz.
..... host bus clock speed is 99.7100 MHz.
cpu: 0, clocks: 997100, slice: 199420
CPU0<T0:997088,T1:797664,D:4,S:199420,C:997100>
cpu: 1, clocks: 997100, slice: 199420
cpu: 2, clocks: 997100, slice: 199420
cpu: 3, clocks: 997100, slice: 199420
CPU2<T0:997088,T1:398800,D:28,S:199420,C:997100>
CPU3<T0:997088,T1:199408,D:0,S:199420,C:997100>
CPU1<T0:997088,T1:598240,D:8,S:199420,C:997100>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfdb85, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
PCI: Unable to handle 64-bit address space for 
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B4,I8,P0) -> 48
PCI->APIC IRQ transform: (B3,I7,P0) -> 30
PCI->APIC IRQ transform: (B3,I7,P1) -> 31
PCI->APIC IRQ transform: (B3,I8,P0) -> 24
PCI->APIC IRQ transform: (B3,I9,P0) -> 27
PCI->APIC IRQ transform: (B1,I12,P0) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eth1: Intel(R) PRO/1000 Network Connection
eth2: Intel(R) PRO/1000 Network Connection
eth3: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:DMA, hdd:pio
hdc: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 irq=48
     BAR0 f8891000 - size= 100000
     BAR1 f8992000 - size= 1000000
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001    
TID 009  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001    
TID 517  Vendor: ESG-SHV S    Device: SCA HSBP M20 Rev: 0.050       
TID 522  Vendor: ADAPTEC R    Device: RAID-5       Rev: 380ED       
scsi0 : Vendor: Adaptec  Model: 2000S            FW:380E
  Vendor: ADAPTEC   Model: RAID-5            Rev: 380E
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ESG-SHV   Model: SCA HSBP M20      Rev: 0.05
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 1, id 0, lun 0
SCSI device sda: 215494656 512-byte hdwr sectors (110333 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Attached scsi generic sg1 at scsi0, channel 1, id 6, lun 0,  type 3
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Ebtables v2.0 registered
NET4: Ethernet Bridge 008 for NET4.0
Bridge firewalling registered
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
usb-uhci.c: $Revision: 1.275 $ time 14:18:13 Dec  2 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x3020, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x3000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-i801 version 2.8.0 (20030714)
i2c-proc.o version 2.8.0 (20030714)
adm1021.o version 2.8.0 (20030714)

--------------020002010408040109080805
Content-Type: text/plain;
 name="boot.log.2423irqb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.log.2423irqb.txt"

# dmesg output from 2.4.23 w/ irq-balancing patch

Linux version 2.4.23 (root@scythe) (gcc version 3.2.2) #1 SMP Tue Dec 9 11:13:31 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
 BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: RSDP (v000 INTEL                                     ) @ 0x000ff9b0
ACPI: RSDT (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff0000
ACPI: FADT (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff0030
ACPI: MADT (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff00b0
ACPI: OEMR (v001 INTEL  SWV20    0x00000001 MSFT 0x01000000) @ 0x7fff0140
ACPI: DSDT (v001  INTEL    SWV20 0x00000100 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x3] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: SWV20        APIC at: 0xFEE00000
I/O APIC #8 Version 32 at 0xFEC00000.
I/O APIC #9 Version 32 at 0xFEC81000.
I/O APIC #10 Version 32 at 0xFEC81400.
Enabling APIC mode: Flat.	Using 3 I/O APICs
Processors: 4
Kernel command line: auto BOOT_IMAGE=BBFKernel ro root=801 idebus=33 acpi=ht
ide_setup: idebus=33
Initializing CPU#0
Detected 2392.984 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 2068756k/2097088k available (1935k kernel code, 27924k reserved, 618k data, 112k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (19123.40 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
Setting 9 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 9 ... ok.
Setting 10 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 10 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-18, 8-20, 8-21, 8-22, 8-23, 9-1, 9-2, 9-4, 9-5, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 9-16, 9-17, 9-18, 9-19, 9-20, 9-21, 9-22, 9-23, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15, 10-16, 10-17, 10-18, 10-19, 10-20, 10-21, 10-22, 10-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 25.
number of IO-APIC #8 registers: 24.
number of IO-APIC #9 registers: 24.
number of IO-APIC #10 registers: 24.
testing the IO APIC.......................

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  0    0    0   0   0    1    1    51
 06 00F 0F  0    0    0   0   0    1    1    59
 07 00F 0F  0    0    0   0   0    1    1    61
 08 00F 0F  0    0    0   0   0    1    1    69
 09 00F 0F  0    0    0   0   0    1    1    71
 0a 00F 0F  0    0    0   0   0    1    1    79
 0b 00F 0F  0    0    0   0   0    1    1    81
 0c 00F 0F  0    0    0   0   0    1    1    89
 0d 00F 0F  0    0    0   0   0    1    1    91
 0e 00F 0F  0    0    0   0   0    1    1    99
 0f 00F 0F  0    0    0   0   0    1    1    A1
 10 00F 0F  1    1    0   1   0    1    1    A9
 11 00F 0F  1    1    0   1   0    1    1    B1
 12 000 00  1    0    0   0   0    0    0    00
 13 00F 0F  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 09000000
.......     : arbitration: 09
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 00F 0F  1    1    0   1   0    1    1    C1
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  1    1    0   1   0    1    1    C9
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  1    1    0   1   0    1    1    D1
 07 00F 0F  1    1    0   1   0    1    1    D9
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

IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0A000000
.......     : arbitration: 0A
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 00F 0F  1    1    0   1   0    1    1    E1
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
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ27 -> 1:3
IRQ30 -> 1:6
IRQ31 -> 1:7
IRQ48 -> 2:0
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2392.9287 MHz.
..... host bus clock speed is 99.7052 MHz.
cpu: 0, clocks: 997052, slice: 199410
CPU0<T0:997040,T1:797616,D:14,S:199410,C:997052>
cpu: 1, clocks: 997052, slice: 199410
cpu: 2, clocks: 997052, slice: 199410
cpu: 3, clocks: 997052, slice: 199410
CPU1<T0:997040,T1:598208,D:12,S:199410,C:997052>
CPU2<T0:997040,T1:398800,D:10,S:199410,C:997052>
CPU3<T0:997040,T1:199392,D:8,S:199410,C:997052>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb85, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
PCI: Unable to handle 64-bit address space for 
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B4,I8,P0) -> 48
PCI->APIC IRQ transform: (B3,I7,P0) -> 30
PCI->APIC IRQ transform: (B3,I7,P1) -> 31
PCI->APIC IRQ transform: (B3,I8,P0) -> 24
PCI->APIC IRQ transform: (B3,I9,P0) -> 27
PCI->APIC IRQ transform: (B1,I12,P0) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eth1: Intel(R) PRO/1000 Network Connection
eth2: Intel(R) PRO/1000 Network Connection
eth3: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:DMA, hdd:pio
hdc: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 irq=48
     BAR0 f8891000 - size= 100000
     BAR1 f8992000 - size= 1000000
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001    
TID 009  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001    
TID 517  Vendor: ESG-SHV S    Device: SCA HSBP M20 Rev: 0.050       
TID 522  Vendor: ADAPTEC R    Device: RAID-5       Rev: 380ED       
scsi0 : Vendor: Adaptec  Model: 2000S            FW:380E
  Vendor: ADAPTEC   Model: RAID-5            Rev: 380E
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ESG-SHV   Model: SCA HSBP M20      Rev: 0.05
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 1, id 0, lun 0
SCSI device sda: 215494656 512-byte hdwr sectors (110333 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Attached scsi generic sg1 at scsi0, channel 1, id 6, lun 0,  type 3
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Ebtables v2.0 registered
NET4: Ethernet Bridge 008 for NET4.0
Bridge firewalling registered
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
usb-uhci.c: $Revision: 1.275 $ time 14:18:13 Dec  2 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x3020, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x3000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-i801 version 2.8.0 (20030714)
i2c-proc.o version 2.8.0 (20030714)
adm1021.o version 2.8.0 (20030714)

--------------020002010408040109080805
Content-Type: application/gzip;
 name="irq_balance-2.4.23.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="irq_balance-2.4.23.patch.gz"

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
1zTOc4NYClvdBthrkBsZbvH+DxR0bMfTFQAA
--------------020002010408040109080805--

