Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUEBL2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUEBL2p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 07:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUEBL2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 07:28:45 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:53255 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S262961AbUEBL2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 07:28:09 -0400
Date: Sun, 2 May 2004 13:27:56 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc3-mm1: some sort of deadlock occurs under heavy i/o
Message-ID: <20040502112756.GA1463@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do a _lot_ of I/O in 2.6.6-rc3-mm1, I've seen some sort of
deadlock multiple times now. pinging from outside still works, num-lock
turns the led on/off, I can switch consoles but otherwise, nothing
works. The lot of I/O is for example: expiring two large newsspools, and
reading a large folder in mutt. This worked fine in 2.6.6-rc2-mm2 and
kernels before that (except that pdflush sometimes started using 100%
cpu. I've not seen that this time, but this is worse, unfortunately).

This is a single P4, using hyperthreading. In use are reiserfs and ext3,
raid-1 and linear raid. Alt-sysreq-t produced a large list of processes,
where the last 3 each had:

schedule_timeout+0x65
io_schedule_timeout+0x29
blk_congestion_wait+0x71
__alloc_pages+0x26e
__get_free_pages+0x27

2 out of 3 went further like this:

cache_grow
cache_alloc_refill
kmem_cache_alloc

and the third had:

proc_File_read
vfs_read
sys_read

Below is my .config, the dmesg output, output of mount and /proc/mdstat.

Let me know if I can do anything else?

Thanks,
Jurriaan

/dev/md3 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/md4 on /usr type ext3 (rw,errors=remount-ro)
/dev/md2 on /var type ext3 (rw,errors=remount-ro)
sysfs on /devices type sysfs (rw)
/dev/md5 on /vmware type reiserfs (rw)
/dev/md0 on /home type reiserfs (rw)
/dev/md1 on /var/spool/news_binary type reiserfs (rw)
/dev/hde1 on /space1 type reiserfs (rw,noexec,nosuid,nodev)
/dev/hdk1 on /space2 type reiserfs (rw,noexec,nosuid,nodev)
/dev/hdg1 on /space3 type reiserfs (rw,noexec,nosuid,nodev)

Personalities : [linear] [raid0] [raid1] [raid5] 
md3 : active raid1 hdc1[0] hda1[1]
      497856 blocks [2/2] [UU]
md4 : active raid1 hdc3[0] hda3[1]
      8008320 blocks [2/2] [UU]
md2 : active raid1 hdc5[0] hda5[1]
      16008640 blocks [2/2] [UU]
md5 : active raid1 hdc6[0] hda6[1]
      8008256 blocks [2/2] [UU]
md1 : active linear hdi1[2] hdc7[1] hda7[0]
      76909568 blocks 64k rounding
md0 : active raid1 hdc8[0] hda8[1]
      62645312 blocks [2/2] [UU]
      
unused devices: <none>

Linux version 2.6.6-rc3-mm1 (jurriaan@middle) (gcc version 3.3.3 (Debian 20040401)) #2 SMP Fri Apr 30 12:59:10 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5900
On node 0 totalpages: 786416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 557040 pages, LIFO batch:16
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7370
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0xbfff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0xbfff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0xbfff73c0
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-32@85 softrepeat=1
CPU 0 irqstacks, hard=c063d000 soft=c063b000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 3068.557 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 3113912k/3145664k available (3645k kernel code, 30604k reserved, 1172k data, 512k init, 2228160k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6062.08 BogoMIPS
Dentry cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 1462.81 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c063e000 soft=c063c000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 6127.61 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Total of 2 processors activated (12189.69 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3067.0834 MHz.
..... host bus clock speed is 255.0652 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:  online
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb960, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.............................................................................................................................................................
Table [DSDT](id F004) - 563 Objects with 54 Devices 157 Methods 34 Regions
ACPI Namespace successfully loaded at root c0668dbc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000000428 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 8 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:................................................................................
Initialized 34/34 Regions 9/9 Fields 21/21 Buffers 16/16 Packages (572 nodes)
Executing all Device _STA and_INI methods:.........................................................
57 Devices found containing: 57 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:1f[C] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:1f[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:02:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:02:08[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:02:08[C] -> 2-22 -> IRQ 22
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B9
 12 003 03  1    1    0   1   0    1    1    B1
 13 003 03  1    1    0   1   0    1    1    C1
 14 003 03  1    1    0   1   0    1    1    D1
 15 003 03  1    1    0   1   0    1    1    D9
 16 003 03  1    1    0   1   0    1    1    E1
 17 003 03  1    1    0   1   0    1    1    C9
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
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon If  DDR SGRAM 128 MB
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
highmem bounce pool size: 64 pages
NTFS driver 2.1.8-WIP [Flags: R/O].
udf: registering filesystem
SGI XFS with no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (41 C)
Console: switching to colour frame buffer device 133x54
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: RNG not detected
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 2925M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Technologies Inc Radeon RV250 If [Radeon 9000]
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xf9854000, 00:10:a7:0b:35:1c, IRQ 23
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L120AVV207-1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L120AVV207-1, ATA DISK drive
hdd: _NEC DVD_RW ND-1300A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT374: IDE controller at PCI slot 0000:02:00.0
HPT374: chipset revision 7
HPT37X: using 33MHz PCI clock
HPT374: 100% native mode on irq 16
    ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:DMA, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x9400-0x9407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x9408-0x940f, BIOS settings: hdk:DMA, hdl:pio
hde: WDC WD800JB-00CRA1, ATA DISK drive
ide2 at 0x7000-0x7007,0x7402 on irq 16
hdg: WDC WD2000JB-32EVA0, ATA DISK drive
ide3 at 0x7800-0x7807,0x7c02 on irq 16
hdi: Maxtor 33073H3, ATA DISK drive
ide4 at 0x8400-0x8407,0x8802 on irq 16
hdk: WDC WD800JB-00CRA1, ATA DISK drive
ide5 at 0x8c00-0x8c07,0x9002 on irq 16
hda: max request size: 1024KiB
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdc: max request size: 1024KiB
hdc: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hde: hde1
hdg: max request size: 1024KiB
hdg: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
 hdg: hdg1
hdi: max request size: 128KiB
hdi: 60032448 sectors (30736 MB) w/2048KiB Cache, CHS=59556/16/63, UDMA(100)
 hdi: hdi1
hdk: max request size: 128KiB
hdk: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hdk: hdk1
hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
sym0: <860> rev 0x13 at pci 0000:02:05.0 irq 21
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi(0:0:1:0): Beginning Domain Validation
sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
scsi(0:0:1:0): Domain Validation skipping write tests
scsi(0:0:1:0): Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi(0:0:2:0): Beginning Domain Validation
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
scsi(0:0:2:0): Domain Validation skipping write tests
scsi(0:0:2:0): Ending Domain Validation
st: Version 20040403, fixed bufsize 32768, s/g segs 256
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg1 at scsi0, channel 0, id 2, lun 0,  type 5
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f985e000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000cc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000c000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000c400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000c800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2292.000 MB/sec
   8regs_prefetch:  1932.000 MB/sec
   32regs    :  1248.000 MB/sec
   32regs_prefetch:  1084.000 MB/sec
   pIII_sse  :  3176.000 MB/sec
   pII_mmx   :  3168.000 MB/sec
   p5_mmx    :  3220.000 MB/sec
raid5: using function: pIII_sse (3176.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 1.0.4 (Tue Mar 30 08:19:30 2004 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49384 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH5 at 0xf4002000, irq 17
  #1: Sound Blaster Live! (rev.7) at 0x9800, irq 18
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdi1 ...
md:  adding hdi1 ...
md: hdc8 has different UUID to hdi1
md:  adding hdc7 ...
md: hdc6 has different UUID to hdi1
md: hdc5 has different UUID to hdi1
md: hdc3 has different UUID to hdi1
md: hdc1 has different UUID to hdi1
md: hda8 has different UUID to hdi1
md:  adding hda7 ...
md: hda6 has different UUID to hdi1
md: hda5 has different UUID to hdi1
md: hda3 has different UUID to hdi1
md: hda1 has different UUID to hdi1
md: created md1
md: bind<hda7>
md: bind<hdc7>
md: bind<hdi1>
md: running: <hdi1><hdc7><hda7>
md: considering hdc8 ...
md:  adding hdc8 ...
md: hdc6 has different UUID to hdc8
md: hdc5 has different UUID to hdc8
md: hdc3 has different UUID to hdc8
md: hdc1 has different UUID to hdc8
md:  adding hda8 ...
md: hda6 has different UUID to hdc8
md: hda5 has different UUID to hdc8
md: hda3 has different UUID to hdc8
md: hda1 has different UUID to hdc8
md: created md0
md: bind<hda8>
md: bind<hdc8>
md: running: <hdc8><hda8>
raid1: raid set md0 active with 2 out of 2 mirrors
md: considering hdc6 ...
md:  adding hdc6 ...
md: hdc5 has different UUID to hdc6
md: hdc3 has different UUID to hdc6
md: hdc1 has different UUID to hdc6
md:  adding hda6 ...
md: hda5 has different UUID to hdc6
md: hda3 has different UUID to hdc6
md: hda1 has different UUID to hdc6
md: created md5
md: bind<hda6>
md: bind<hdc6>
md: running: <hdc6><hda6>
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering hdc5 ...
md:  adding hdc5 ...
md: hdc3 has different UUID to hdc5
md: hdc1 has different UUID to hdc5
md:  adding hda5 ...
md: hda3 has different UUID to hdc5
md: hda1 has different UUID to hdc5
md: created md2
md: bind<hda5>
md: bind<hdc5>
md: running: <hdc5><hda5>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering hdc3 ...
md:  adding hdc3 ...
md: hdc1 has different UUID to hdc3
md:  adding hda3 ...
md: hda1 has different UUID to hdc3
md: created md4
md: bind<hda3>
md: bind<hdc3>
md: running: <hdc3><hda3>
raid1: raid set md4 active with 2 out of 2 mirrors
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md3
md: bind<hda1>
md: bind<hdc1>
md: running: <hdc1><hda1>
raid1: raid set md3 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md3: warning: allocator defaults = [00001420]

EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: md3: orphan cleanup on readonly fs
kjournald starting.  Commit interval 5 seconds
ext3_orphan_cleanup: deleting unreferenced inode 120837
EXT3-fs: md3: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 512k freed
Adding 2008116k swap on /dev/hda2.  Priority:-1 extents:1
Adding 2008116k swap on /dev/hdc2.  Priority:-2 extents:1
EXT3 FS on md3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md5: warning: allocator defaults = [00001420]

ReiserFS: md5: found reiserfs format "3.6" with standard journal
ReiserFS: md5: using ordered data mode
ReiserFS: md5: journal params: device md5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md5: checking transaction log (md5)
ReiserFS: md5: Using r5 hash to sort names
ReiserFS: md0: warning: allocator defaults = [00001420]

ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
ReiserFS: md1: warning: allocator defaults = [00001420]

ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
ReiserFS: hde1: warning: allocator defaults = [00001420]

ReiserFS: hde1: found reiserfs format "3.6" with standard journal
ReiserFS: hde1: using ordered data mode
ReiserFS: hde1: journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde1: checking transaction log (hde1)
ReiserFS: hde1: Using r5 hash to sort names
ReiserFS: hdk1: warning: allocator defaults = [00001420]

ReiserFS: hdk1: found reiserfs format "3.6" with standard journal
ReiserFS: hdk1: using ordered data mode
ReiserFS: hdk1: journal params: device hdk1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdk1: checking transaction log (hdk1)
ReiserFS: hdk1: Using r5 hash to sort names
ReiserFS: hdg1: warning: allocator defaults = [00001420]

ReiserFS: hdg1: found reiserfs format "3.6" with standard journal
ReiserFS: hdg1: using ordered data mode
ReiserFS: hdg1: journal params: device hdg1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdg1: checking transaction log (hdg1)
ReiserFS: hdg1: Using r5 hash to sort names
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

.config:
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
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
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_SYN_COOKIES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_TIGON3=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_HW_RANDOM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_DRM_MGA=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ISA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_EEPROM=m
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_3DFX=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_EMU10K1=y
CONFIG_SND_CMIPCI=y
CONFIG_SND_INTEL8X0=y
CONFIG_SND_VIA82XX=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_XFS_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_FRAME_POINTER=y
CONFIG_4KSTACKS=y
CONFIG_SCHEDSTATS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y
-- 
Are your cookies made with real Girl Scouts?
        Addams Family I
Debian (Unstable) GNU/Linux 2.6.6-rc3-mm1 2x6062 bogomips 0.37 0.36
