Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUHQIw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUHQIw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHQIw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:52:26 -0400
Received: from mail7.mclink.it ([195.110.128.94]:15378 "EHLO mail7.mclink.it")
	by vger.kernel.org with ESMTP id S268164AbUHQIt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:49:56 -0400
Message-ID: <4121C969.5080206@arpacoop.it>
Date: Tue, 17 Aug 2004 11:01:29 +0200
From: Carlo Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: File corruption with SATA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently added a Seagate 200GB SATA disk model ST3200822AS
to my PC, conected to the second SATA channel. On the first channel
I already have a Maxtor 6Y160M0 160 GB disk (XFS).
The motherboard is a Abit NF7-S rev 2 (NForce2 based), the SATA
controller is a SiI3112 integrated on the MB. See boot.msg below for
details.
I'm running SuSE 9.1 with kernel 2.6.7 (see .config below) with the IDE Sata
driver, but today I installed kernel 2.6.8.1 and libata driver with the same
results.
The problem: I copied about 85GB of files (ranging from 500 to 1800MB in
size each)  from the Maxtor disk to the Seagate disk, configured with three
partitions (two data, one swap) and LVM+XFS.
All files ( I mean ALL) were corrupted. Running cmp on the original and
the copied files revealed hundreds of bytes changed for each file.
Fortunately I hadn't moved the files, just copied......
I partitioned the disk without LVM and formatted with Reiserfs, no change.

Things I tested:
- RAM is OK, memtest revealed no errors
- Seagate test tool found no errors
- Disabling DMA with hdparm  -d0 cured the problem (but performance is
2-3 MB/s on writes instead of 40-50)
- Setting the disk to other udma levels made no difference, could not
set the disk to PIO mode
- Files copied from another disk connected to the NForce PATA controller
tested OK
- Swapped channels (and cables), booted from Suse 9.1 DVD in rescue mode
and copied
files from Maxtor to Seagate: even more errors
- Copying from Seagate to Seagate is OK, from Seagate to Maxtor is OK as
well.

Then I noticed that small files are not affected.
I created files of increasing sizes with:
dd ibs=1024 count=XXXk if=/dev/zero of=test
copied and compared the test file.
Up to XXX=300 (307200kB) no errors at all,
at 350-400 sometimes, at 500 (512000kB) the corruption always occurs.

I performed this test by creating the file on the Maxtor, then I copied it
to the Seagate and compared them. If I created the file on the Seagate,
copied
to the Maxtor and compared the file, all was fine.

It seems that copying large files from a Sata disk to a Seagate (I hope
only this model) on the other Sata channel leads to badly corrupted data.

I hope someone can fix it. Until then DON'T DO IT.

	Carlo Scarfoglio

This is an excerpt from a run of cmp on a test file created with
dd ibs=1024 count=500k if=/dev/zero of=test (512000KB)
There are 13131 errors
   1460723   0 102
   1460724   0  33
   1460726   0  20
   1460730   0  20
   1460731   0 102
   1460732   0  33
   1460734   0  20
   3489274   0  20
   3489275   0 142
   3489276   0  33
   3489278   0  20
   3517550   0 300
   3517551   0 144
   3517552   0  33
   3517554   0  20
   3517558   0 320
   3517559   0 144
   3517560   0  33
   3517562   0  20
   3806958   0 100
   3806959   0 155
   3806960   0  33
   3806962   0  20
   3967122   0 100
   3967123   0 164
   3967124   0  33
   3967126   0  20
   3967130   0 120
   3967131   0 164
   3967132   0  33
   3967134   0  20
   3971578   0 320
   3971579   0 164
   3971580   0  33
   3971582   0  20
   3974802   0 100
   3974803   0 165
   3974804   0  33
   3974806   0  20
   3974810   0 120
   3974811   0 165
   3974812   0  33
   3974814   0  20
   4199406   0 100
   4199407   0 170
   4199408   0  33
   4199410   0  20
   4199414   0 120
   4199415   0 170
   4199416   0  33
   4201102   0 200
   4201103   0 170
   4201104   0  33
   4201106   0  20
   4303350   0 320
   4303351   0 174
   4303352   0  33
   4303354   0  20
   4404370   0 200
   4404372   0  33
   4404374   0  20
   4404378   0 220
   4404380   0  33
   4404382   0  20
   4501135   0   2
   4501136   0  33
   4501138   0  20
   4755214   0 300
   4755215   0  10
   4755216   0  33
   4755218   0  20
   4845202   0 200
   4845203   0  14
   4845204   0  33
   4845206   0  20
   4845210   0 220
   4845211   0  14
   4845212   0  33
   4845214   0  20
...
345815834   0 360
345815835   0 351
345815836   0  34
345815838   0  20
347737075   0 203
347737076   0  34
347737078   0  20
347737082   0  20
347737083   0 203
347737084   0  34
347737086   0  20
348322802   0  60
348322803   0 225
348322804   0  74
348322806   0  20
348322811   0 240
348322812   0  76
348322814   0  20
348329682   0 220
348329683   0 312
348329684   0  72
348329686   0  20
348329690   0 240
348329691   0 312
348329692   0  72
348405234   0 340
348405235   0 222
348405236   0  34
348405238   0  20
348405242   0 360
348405243   0 222
348405244   0  34
348405246   0  20
358103023   0 125
358103024   0  34
358103026   0  20
358103030   0  20
358103031   0 125
358103032   0  34
358103034   0  20
358800370   0 160
358800371   0  72
358800372   0  72
358800374   0  20
358800378   0 300
358800379   0  72
358800380   0  72
358800382   0  20
358803442   0 120
358803443   0  51
358803444   0  72
358803446   0  20
358803450   0 300
358803451   0  51
358803452   0  72
358803454   0  20
359480818   0 100
359480819   0 132
359480820   0  34
359480822   0  20
359480826   0 120
359480827   0 132
359480828   0  34
359480830   0  20
375385586   0 120
375385587   0  14
375385588   0  34
375385590   0  20
375385594   0 140
375385595   0  14
375385596   0  34
375385598   0  20




boot.msg

Cannot find map file.
No module symbols loaded - kernel modules not enabled.

Cannot build symbol table - disabling symbol lookups
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.8.1 (root@linux) (gcc version 3.3.3 (SuSE Linux))
#5 Sun Aug 15 08:12:04 CEST 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
<4> BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
<4> BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>127MB HIGHMEM available.
<5>896MB LOWMEM available.
<7>On node 0 totalpages: 262128
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 225280 pages, LIFO batch:16
<7>  HighMem zone: 32752 pages, LIFO batch:7
<6>DMI 2.2 present.
<6>ACPI: RSDP (v000 Nvidia                                    ) @
0x000f6b60
<6>ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3000
<6>ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3040
<6>ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff79c0
<6>ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @
0x00000000
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 6:10 APIC version 16
<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
<6>IOAPIC[0]: Assigned apic_id 2
<4>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<6>Using ACPI (MADT) for SMP configuration information
<4>Built 1 zonelists
<4>Kernel command line: root=/dev/sda1 splash=silent
<6>Initializing CPU#0
<4>PID hash table entries: 4096 (order 12: 32768 bytes)
<4>Detected 2079.620 MHz processor.
<6>Using tsc for high-res timesource
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<6>Memory: 1033316k/1048512k available (3313k kernel code, 14288k
reserved, 1261k data, 180k init, 131008k highmem)
<4>Checking if this processor honours the WP bit even in supervisor
mode... Ok.
<4>Calibrating delay loop... 4112.38 BogoMIPS
<6>Security Scaffold v1.0.0 initialized
<6>SELinux:  Initializing.
<6>SELinux:  Starting in enforcing mode
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
<7>CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 512K (64 bytes/line)
<7>CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: AMD Athlon(tm) XP 2800+ stepping 00
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>ENABLING IO-APIC IRQs
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=-1
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ...  failed.
<6>...trying to set up timer as Virtual Wire IRQ... failed.
<6>...trying to set up timer as ExtINT IRQ... works.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2079.0300 MHz.
<4>..... host bus clock speed is 332.0688 MHz.
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20040326
<4> tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
<4>Parsing all Control
Methods:............................................................................................................................................................................................................................................................................ 



<4>Table [DSDT](id F004) - 782 Objects with 75 Devices 268 Methods 32
Regions
<4>ACPI Namespace successfully loaded at root c05cf7bc
<4>evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
<4>evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs
at 0000000000004020 on int 9
<4>evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 10
Runtime GPEs in this block
<4>evgpeblk-0867 [06] ev_create_gpe_block   : GPE 32 to 95 [_GPE] 8 regs
at 00000000000044A0 on int 9
<4>evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0
Runtime GPEs in this block
<4>Completing Region/Field/Buffer/Package
initialization:................................................................................................ 



<4>Initialized 32/32 Regions 9/9 Fields 29/29 Buffers 26/26 Packages
(791 nodes)
<4>Executing all Device _STA and_INI
methods:............................................................................. 



<4>77 Devices found containing: 77 _STA, 2 _INI methods
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
<4>ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
<4>ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
<4>ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
<4>ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.
<4>ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
<4>ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
<4>ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
<5>SCSI subsystem initialized
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>PCI: Using ACPI for IRQ routing
<4>ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
<6>ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 23 (level, high) -> IRQ 23
<4>ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
<4>ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
<6>ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
<4>ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
<6>ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
<4>ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
<6>ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
<4>ACPI: PCI Interrupt Link [APCI] enabled at IRQ 21
<6>ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 21 (level, high) -> IRQ 21
<4>ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
<6>ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 20 (level, high) -> IRQ 20
<4>ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
<6>ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 22 (level, high) -> IRQ 22
<4>ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
<6>ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
<4>ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
<6>ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
<6>ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 18 (level, high) -> IRQ 18
<4>ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
<6>ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
<7>number of MP IRQ sources: 15.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00170011
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 001 01  0    0    0   0   0    1    1    41
<7> 04 001 01  0    0    0   0   0    1    1    49
<7> 05 001 01  0    0    0   0   0    1    1    51
<7> 06 001 01  0    0    0   0   0    1    1    59
<7> 07 001 01  1    0    0   0   0    1    1    61
<7> 08 001 01  0    0    0   0   0    1    1    69
<7> 09 001 01  0    1    0   0   0    1    1    71
<7> 0a 001 01  0    0    0   0   0    1    1    79
<7> 0b 001 01  0    0    0   0   0    1    1    81
<7> 0c 001 01  0    0    0   0   0    1    1    89
<7> 0d 001 01  0    0    0   0   0    1    1    91
<7> 0e 001 01  0    0    0   0   0    1    1    99
<7> 0f 001 01  0    0    0   0   0    1    1    A1
<7> 10 001 01  1    1    0   0   0    1    1    D1
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 001 01  1    1    0   0   0    1    1    C9
<7> 13 001 01  1    1    0   0   0    1    1    D9
<7> 14 001 01  1    1    0   0   0    1    1    C1
<7> 15 001 01  1    1    0   0   0    1    1    B9
<7> 16 001 01  1    1    0   0   0    1    1    B1
<7> 17 001 01  1    1    0   0   0    1    1    A9
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ21 -> 0:21
<7>IRQ22 -> 0:22
<7>IRQ23 -> 0:23
<6>.................................... done.
<6>Machine check exception polling timer started.
<4>highmem bounce pool size: 64 pages
<6>NTFS driver 2.1.15 [Flags: R/O].
<5>udf: registering filesystem
<6>SGI XFS with no debug enabled
<6>Initializing Cryptographic API
<4>
<4>testing md5
<4>test 1:
......
<4>testing michael_mic
<4>failed to load transform for michael_mic
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Fan [FAN] (on)
<6>ACPI: Processor [CPU0] (supports C1)
<6>ACPI: Thermal Zone [THRM] (51 C)
<6>lp: driver loaded but no devices found
<6>Real Time Clock Driver v1.12
<6>Linux agpgart interface v0.100 (c) Dave Jones
<6>agpgart: Detected NVIDIA nForce2 chipset
<6>agpgart: Maximum main memory to use for agp memory: 941M
<6>agpgart: AGP aperture is 256M @ 0xc0000000
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
<6>parport0: irq 7 detected
<6>lp0: using parport0 (polling).
<4>Using anticipatory io scheduler
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>loop: loaded (max 8 devices)
<6>forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
<6>ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
<7>PCI: Setting latency timer of device 0000:00:04.0 to 64
<6>eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
<6>PPP generic driver version 2.4.2
<6>PPP Deflate Compression module registered
<6>PPP BSD Compression module registered
<6>NET: Registered protocol family 24
<6>8139too Fast Ethernet driver 0.9.27
<6>ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
<6>eth1: RealTek RTL8139 at 0xf8872000, 00:10:a7:14:6f:68, IRQ 18
<7>eth1:  Identified 8139 chip type 'RTL-8139C'
<6>Linux video capture interface: v1.00
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
<6>NFORCE2: IDE controller at PCI slot 0000:00:09.0
<6>NFORCE2: chipset revision 162
<6>NFORCE2: not 100%% native mode: will probe irqs later
<6>NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
<6>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
<6>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
<4>hdc: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
<4>hdd: TOSHIBA DVD-ROM SD-R5002, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<7>libata version 1.02 loaded.
<7>sata_sil version 0.54
<6>ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 18 (level, high) -> IRQ 18
<6>ata1: SATA max UDMA/100 cmd 0xF8874080 ctl 0xF887408A bmdma
0xF8874000 irq 18
<6>ata2: SATA max UDMA/100 cmd 0xF88740C0 ctl 0xF88740CA bmdma
0xF8874008 irq 18
<7>ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01
87:4003 88:207f
<6>ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : sata_sil
<7>ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01
87:4003 88:207f
<6>ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
<6>ata2: dev 0 configured for UDMA/100
<6>scsi1 : sata_sil
<5>  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
<5>SCSI device sdb: drive cache: write back
<6> sdb: sdb1 sdb2
<5>Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
<5>Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
<5>Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
<6>ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
<6>ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
<7>PCI: Setting latency timer of device 0000:00:02.2 to 64
<6>ehci_hcd 0000:00:02.2: irq 20, pci mem f8876000
<6>ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
<7>PCI: cache line size of 64 is not supported by device 0000:00:02.2
<6>ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 6 ports detected
<7>ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
<7>ohci_hcd: block sizes: ed 64 td 64
<6>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
<6>ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
<7>PCI: Setting latency timer of device 0000:00:02.0 to 64
<6>ohci_hcd 0000:00:02.0: irq 22, pci mem f8878000
<6>ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 3 ports detected
<6>ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
<6>ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
<7>PCI: Setting latency timer of device 0000:00:02.1 to 64
<6>ohci_hcd 0000:00:02.1: irq 21, pci mem f887a000
<6>ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 3 ports detected
<6>USB Universal Host Controller Interface driver v2.2
<6>usbcore: registered new driver usblp
<6>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>usbcore: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>usbcore: registered new driver hiddev
<6>usbcore: registered new driver usbhid
<6>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
<6>mice: PS/2 mouse device common for all mice
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>i2c /dev entries driver
<6>i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5000
<6>i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5100
<6>device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
<6>Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17
14:31:44 2004 UTC).
<6>ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
<4>Consumer PCM code does not work well at the moment --jk
<4>AC'97 0 does not respond - RESET
<3>AC'97 0 access is not valid [0xffffffff], removing mixer.
<4>ice1712: cannot initialize ac97 for consumer, skipped
<6>ALSA device list:
<6>  #0: TerraTec DMX6Fire at 0xa400, irq 16
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 8192 buckets, 64Kbytes
<6>TCP: Hash tables configured (established 262144 bind 65536)
<4>ip_conntrack version 2.1 (8191 buckets, 65528 max) - 296 bytes per
conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<4>arp_tables: (C) 2002 David S. Miller
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<4>UDF-fs: No VRS found
<5>XFS mounting filesystem sda1
<5>Starting XFS recovery on filesystem: sda1 (dev: sda1)
<6>usb 2-1: new low speed USB device using address 2
<6>input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with
IntelliEye] on usb-0000:00:02.0-1
<5>Ending XFS recovery on filesystem: sda1 (dev: sda1)
<4>VFS: Mounted root (xfs filesystem) readonly.
<6>Freeing unused kernel memory: 180k freed
<6>Adding 2104504k swap on /dev/sdb2.  Priority:42 extents:1
<5>XFS mounting filesystem sda2
<7>Ending clean XFS mount for filesystem: sda2
<5>ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
<5>ReiserFS: sdb1: using ordered data mode
<5>ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
<5>ReiserFS: sdb1: checking transaction log (sdb1)
<5>ReiserFS: sdb1: Using r5 hash to sort names
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.


# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=16
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC7XXX_OLD=y
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=y
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_ARP_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
CONFIG_FORCEDETH=y
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_ICE1712=y
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_POSIX is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SELINUX=y
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
# CONFIG_SECURITY_SELINUX_DISABLE is not set
# CONFIG_SECURITY_SELINUX_DEVELOP is not set
# CONFIG_SECURITY_SELINUX_MLS is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_TEST=y

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

