Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVBMFHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVBMFHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 00:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBMFHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 00:07:17 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:56193 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261247AbVBMFE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 00:04:56 -0500
Message-ID: <420EDFF4.90403@ribosome.natur.cuni.cz>
Date: Sun, 13 Feb 2005 06:04:52 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050126
X-Accept-Language: en, en-us, cs
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: HIGHMEM slows down 2.6.11-rc3-bk7 machine
Content-Type: multipart/mixed;
 boundary="------------000207020300040303000401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207020300040303000401
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcello and other gurus!
  I have just bough 4GB of RAM into my machine. Immediately, I have noticed
the machine is terribly slow on bootup. After inspecting all BIOS related
possibilities I found that the problem goes off with highmem=off. I should
note I don't see this slowdown when I have only 2 or 3GB RAM while using the
same kernel.

  The MB is ASUS P4C800-E-Deluxe with i875P chipset and ICH5R. It should
support fully 4GB, but docs say ICH5R controller might allocate something
for itself, so one should expect "less". :(
Hmm, at the best I get 3557MB of RAM when almost everything is
disabled in BIOS, mainly USB/NET/FIREWIRE/SATA stuff. Grrr.
I tested latest beta and release of bios too, but no luck.


root=/dev/sdb2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66 highmem=off

$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 256MB: write-back, count=1
reg03: base=0xd0000000 (3328MB), size= 128MB: write-back, count=1
reg04: base=0xd8000000 (3456MB), size=  64MB: write-back, count=1
reg05: base=0xdc000000 (3520MB), size=  32MB: write-back, count=1
reg06: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=2
reg07: base=0xfe800000 (4072MB), size=   4MB: write-combining, count=1
$
$ cat /mtrr-with-highmem 
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 256MB: write-back, count=1
reg03: base=0xd0000000 (3328MB), size= 128MB: write-back, count=1
reg04: base=0xd8000000 (3456MB), size=  64MB: write-back, count=1
reg05: base=0xdc000000 (3520MB), size=  32MB: write-back, count=1
reg06: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=2
reg07: base=0xfe800000 (4072MB), size=   4MB: write-combining, count=1
$

Please not that at the moment, BIOS says only 3555MB are available, so am
a bit surprised linux sees anything above 3456MB (expect that to be somehow used by the ICH5R beast).

see attached dmesg 2.6.11-rc3-bk7 for the cases when no highmem was/wasn't enabled


Here is the diff of both:

--- /dm 2005-02-13 05:27:12.328500335 +0100
+++ /dm-with-highmem    2005-02-13 05:44:13.106978275 +0100
@@ -8,13 +8,13 @@
  BIOS-e820: 00000000de240000 - 00000000de2f0000 (ACPI NVS)
  BIOS-e820: 00000000de2f0000 - 00000000de300000 (reserved)
  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
-0MB HIGHMEM available.
+2658MB HIGHMEM available.
 896MB LOWMEM available.
 found SMP MP-table at 000ff780
-On node 0 totalpages: 229376
+On node 0 totalpages: 909872
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
-  HighMem zone: 0 pages, LIFO batch:1
+  HighMem zone: 680496 pages, LIFO batch:16
 DMI 2.3 present.
 ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e30
 ACPI: XSDT (v001 A M I  OEMXSDT  0x10000426 MSFT 0x00000097) @ 0xde230100
@@ -37,19 +37,19 @@
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Built 1 zonelists
-Kernel command line: root=/dev/sda2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66 highmem=off
+Kernel command line: root=/dev/sda2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66
 ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
 ide_setup: idebus=66
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 3075.740 MHz processor.
+Detected 3075.443 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 902348k/917504k available (3380k kernel code, 14644k reserved, 1649k data, 224k init, 0k highmem)
+Memory: 3602700k/3639488k available (3380k kernel code, 35972k reserved, 1649k data, 224k init, 2721984k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
 Calibrating delay loop... 6094.84 BogoMIPS (lpj=3047424)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
@@ -130,6 +130,7 @@
 pnp: 00:07: ioport range 0x290-0x297 has been reserved
 Machine check exception polling timer started.
 IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
+highmem bounce pool size: 64 pages
 devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
 devfs: boot_options: 0x1
 SGI XFS with no debug enabled
@@ -257,15 +258,15 @@
 ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
 AC'97 0 analog subsections not ready
-intel8x0_measure_ac97_clock: measured 49507 usecs
+intel8x0_measure_ac97_clock: measured 50508 usecs
 intel8x0: clocking to 48000
 ALSA device list:
   #0: Intel ICH5 with AD1985 at 0xfe7ff800, irq 17
 NET: Registered protocol family 2
-IP: routing cache hash table of 4096 buckets, 64Kbytes
-TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
+IP: routing cache hash table of 16384 buckets, 256Kbytes
+TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
 TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
-TCP: Hash tables configured (established 131072 bind 65536)
+TCP: Hash tables configured (established 262144 bind 65536)
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
@@ -274,8 +275,9 @@
 ACPI: (supports S0 S1 S3 S4 S5)
 BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
 UDF-fs: No VRS found
-XFS mounting filesystem sdb2
-Ending clean XFS mount for filesystem: sdb2
+XFS mounting filesystem sda2
+Starting XFS recovery on filesystem: sda2 (dev: sda2)
+Ending XFS recovery on filesystem: sda2 (dev: sda2)
 VFS: Mounted root (xfs filesystem) readonly.
 Mounted devfs on /dev
 Freeing unused kernel memory: 224k freed
@@ -287,7 +289,7 @@
 e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
 Linux agpgart interface v0.100 (c) Dave Jones
 agpgart: Detected an Intel i875 Chipset.
-agpgart: Maximum main memory to use for agp memory: 816M
+agpgart: Maximum main memory to use for agp memory: 3399M
 agpgart: AGP aperture is 4M @ 0xfe800000
 [drm] Initialized drm 1.0.0 20040925
 ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16


Please Cc: me in replies.
Martin

--------------000207020300040303000401
Content-Type: text/plain;
 name="dm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm"

Linux version 2.6.11-rc3-bk7 (root@aquarius) (gcc version 3.3.5 (Gentoo Linux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #1 SMP Fri Feb 11 09:28:08 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000de230000 (usable)
 BIOS-e820: 00000000de230000 - 00000000de240000 (ACPI data)
 BIOS-e820: 00000000de240000 - 00000000de2f0000 (ACPI NVS)
 BIOS-e820: 00000000de2f0000 - 00000000de300000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e30
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000426 MSFT 0x00000097) @ 0xde230100
ACPI: FADT (v003 A M I  OEMFACP  0x10000426 MSFT 0x00000097) @ 0xde230290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000426 MSFT 0x00000097) @ 0xde230390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000426 MSFT 0x00000097) @ 0xde240040
ACPI: DSDT (v001  P4CED P4CED106 0x00000106 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/sdb2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66 highmem=off
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
ide_setup: idebus=66
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3075.740 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 902348k/917504k available (3380k kernel code, 14644k reserved, 1649k data, 224k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6094.84 BogoMIPS (lpj=3047424)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................................................................................................
Table [DSDT](id F004) - 511 Objects with 48 Devices 150 Methods 14 Regions
ACPI Namespace successfully loaded at root c066a5a0
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.89 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (6094.84 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 1
  groups: 1
  domain 1: span 1
   groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:................................................................................................................
Initialized 13/14 Regions 42/42 Fields 41/41 Buffers 16/16 Packages (520 nodes)
Executing all Device _STA and_INI methods:....................................................
52 Devices found containing: 52 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:07: ioport range 0x680-0x6ff has been reserved
pnp: 00:07: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with no debug enabled
Initializing Cryptographic API
radeonfb_pci_register BEGIN
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: probed DDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Setting up default mode based on panel info
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2	   hsync_strt_wid = 0xe052a
v_total_disp = 0x3ff0429	   vsync_strt_wid = 0x30400
pixclock = 9259
freq = 10800
freq = 10800, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 21600
post div = 0x1
fb_div = 0x60
ppll_div_3 = 0x10060
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon Ya  DDR SGRAM 128 MB
radeonfb_pci_register END
ACPI: Power Button (FF) [PWRF]
acpi_processor-0484 [06] acpi_processor_get_inf: Error getting cpuindex for acpiid 0x2
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: DVD RW DRU-510A   Rev: 1.1a
  Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:047f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi1 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:007f
ata2: dev 0 ATA, max UDMA/133, 586072368 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi2 : ata_piix
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300831AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host2/bus0/target0/lun0: p1 p2
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
padlock: VIA PadLock not detected.
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 49507 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH5 with AD1985 at 0xfe7ff800, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
UDF-fs: No VRS found
XFS mounting filesystem sdb2
Ending clean XFS mount for filesystem: sdb2
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 224k freed
Adding 8032492k swap on /dev/sda3.  Priority:-1 extents:1
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 4M @ 0xfe800000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.14.0 20050125 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfe7ffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
usb usb1: Manufacturer: Linux 2.6.11-rc3-bk7 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 5 ports 8 chg 01fe evt 01ff
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001403 POWER sig=k  CSC CONNECT
hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 3 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003002 POWER OWNER sig=se0  CSC
hub 1-0:1.0: port 4, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 5, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 6, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 7, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 8, status 0100, change 0000, 12 Mb/s
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xef40
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
usb usb2: Manufacturer: Linux 2.6.11-rc3-bk7 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: state 5 ports 2 chg 0006 evt 0007
hub 2-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0xef80
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
usb usb3: Manufacturer: Linux 2.6.11-rc3-bk7 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: state 5 ports 2 chg 0006 evt 0007
uhci_hcd 0000:00:1d.1: port 1 portsc 01a3,00
hub 3-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: skipped 1 descriptor after interface
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: default language 0x0409
usb 3-1: Product: USB-PS/2 Optical Mouse
usb 3-1: Manufacturer: Logitech
usb 3-1: hotplug
usb 3-1: adding 3-1:1.0 (config #1, interface 0)
usb 3-1:1.0: hotplug
usbhid 3-1:1.0: usb_probe_interface
usbhid 3-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
hub 3-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0002
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
uhci_hcd 0000:00:1d.0: suspend_hc
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
process `named' is using obsolete setsockopt SO_BSDCOMPAT
microcode: CPU0 already at revision 0x2e (current=0x2e)
microcode: No new microcode data for CPU0
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 3998 using kernel context 0
EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2



--------------000207020300040303000401
Content-Type: text/plain;
 name="dm-with-highmem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-with-highmem"

Linux version 2.6.11-rc3-bk7 (root@aquarius) (gcc version 3.3.5 (Gentoo Linux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #1 SMP Fri Feb 11 09:28:08 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000de230000 (usable)
 BIOS-e820: 00000000de230000 - 00000000de240000 (ACPI data)
 BIOS-e820: 00000000de240000 - 00000000de2f0000 (ACPI NVS)
 BIOS-e820: 00000000de2f0000 - 00000000de300000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
2658MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 909872
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 680496 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e30
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000426 MSFT 0x00000097) @ 0xde230100
ACPI: FADT (v003 A M I  OEMFACP  0x10000426 MSFT 0x00000097) @ 0xde230290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000426 MSFT 0x00000097) @ 0xde230390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000426 MSFT 0x00000097) @ 0xde240040
ACPI: DSDT (v001  P4CED P4CED106 0x00000106 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/sda2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792 idebus=66
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
ide_setup: idebus=66
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3075.443 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3602700k/3639488k available (3380k kernel code, 35972k reserved, 1649k data, 224k init, 2721984k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6094.84 BogoMIPS (lpj=3047424)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................................................................................................
Table [DSDT](id F004) - 511 Objects with 48 Devices 150 Methods 14 Regions
ACPI Namespace successfully loaded at root c066a5a0
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.89 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (6094.84 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 1
  groups: 1
  domain 1: span 1
   groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:................................................................................................................
Initialized 13/14 Regions 42/42 Fields 41/41 Buffers 16/16 Packages (520 nodes)
Executing all Device _STA and_INI methods:....................................................
52 Devices found containing: 52 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:07: ioport range 0x680-0x6ff has been reserved
pnp: 00:07: ioport range 0x290-0x297 has been reserved
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with no debug enabled
Initializing Cryptographic API
radeonfb_pci_register BEGIN
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: probed DDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Setting up default mode based on panel info
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2	   hsync_strt_wid = 0xe052a
v_total_disp = 0x3ff0429	   vsync_strt_wid = 0x30400
pixclock = 9259
freq = 10800
freq = 10800, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 21600
post div = 0x1
fb_div = 0x60
ppll_div_3 = 0x10060
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon Ya  DDR SGRAM 128 MB
radeonfb_pci_register END
ACPI: Power Button (FF) [PWRF]
acpi_processor-0484 [06] acpi_processor_get_inf: Error getting cpuindex for acpiid 0x2
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: DVD RW DRU-510A   Rev: 1.1a
  Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:047f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi1 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:007f
ata2: dev 0 ATA, max UDMA/133, 586072368 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi2 : ata_piix
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300831AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host2/bus0/target0/lun0: p1 p2
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
padlock: VIA PadLock not detected.
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 50508 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH5 with AD1985 at 0xfe7ff800, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
UDF-fs: No VRS found
XFS mounting filesystem sda2
Starting XFS recovery on filesystem: sda2 (dev: sda2)
Ending XFS recovery on filesystem: sda2 (dev: sda2)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 224k freed
Adding 8032492k swap on /dev/sda3.  Priority:-1 extents:1
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 3399M
agpgart: AGP aperture is 4M @ 0xfe800000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.14.0 20050125 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfe7ffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
usb usb1: Manufacturer: Linux 2.6.11-rc3-bk7 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 5 ports 8 chg 01fe evt 01ff
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001403 POWER sig=k  CSC CONNECT
hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 3 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003002 POWER OWNER sig=se0  CSC
hub 1-0:1.0: port 4, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 5, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 6, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 7, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 8, status 0100, change 0000, 12 Mb/s
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xef40
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
usb usb2: Manufacturer: Linux 2.6.11-rc3-bk7 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: state 5 ports 2 chg 0006 evt 0007
hub 2-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0xef80
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
usb usb3: Manufacturer: Linux 2.6.11-rc3-bk7 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: state 5 ports 2 chg 0006 evt 0007
uhci_hcd 0000:00:1d.1: port 1 portsc 01a3,00
hub 3-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
uhci_hcd 0000:00:1d.0: suspend_hc
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: skipped 1 descriptor after interface
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: default language 0x0409
usb 3-1: Product: USB-PS/2 Optical Mouse
usb 3-1: Manufacturer: Logitech
usb 3-1: hotplug
usb 3-1: adding 3-1:1.0 (config #1, interface 0)
usb 3-1:1.0: hotplug
usbhid 3-1:1.0: usb_probe_interface
usbhid 3-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
hub 3-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0002
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
process `named' is using obsolete setsockopt SO_BSDCOMPAT
microcode: CPU0 already at revision 0x2e (current=0x2e)
microcode: No new microcode data for CPU0
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 3899 using kernel context 0

--------------000207020300040303000401--
