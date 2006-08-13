Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWHMJBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWHMJBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 05:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWHMJBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 05:01:45 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:23682 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750768AbWHMJBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 05:01:44 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: linux-kernel@vger.kernel.org
Subject: Fwd: APIC problem on Asus M2NPV-VM (MCP51) - acpi_skip_timer_override wrong?
Date: Sun, 13 Aug 2006 11:01:29 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3719982.jabRylBZOG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608131101.29861.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3719982.jabRylBZOG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[2nd try, ditching .config, dropping cc's as they probably got first messag=
e.]

Hi,

there already was another thread on the issue that the kernel (I tested
2.6.16.16 and 2.6.18-rc4) on x86_64 smp won't boot in APIC mode on above
mobo, but worked with noapic. (On 2.6.16 I complained with some error messa=
ge
and stopped, wheres 2.6.18-rc4 didn't comlain and botted further but then
hang.) I did some tests and first success for me was using no_timer_check.
Then the system booted but the timer was set to XT-PIC. Then I thought maybe
this board needs one NVidia quirk less and I seem to be right.

In arch/x86_64/kernel/io_apic.c I commented out

acpi_skip_timer_override =3D 1;
printk(KERN_INFO "Nvidia board "
    "detected. Ignoring ACPI "
    "timer override.\n");

and yes, the board booted w/o no_timer_check and my IRQs seem to look healt=
hy
too:

           CPU0       CPU1
  0:       3945    1105333    IO-APIC-edge  timer
  1:          7       2545    IO-APIC-edge  i8042
  7:          1          1    IO-APIC-edge  parport0
  8:          0          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:        136      32394    IO-APIC-edge  i8042
 14:          0         37    IO-APIC-edge  ide0
201:        172      69371   IO-APIC-level  ohci_hcd:usb2, eth0
209:        407     221300   IO-APIC-level  libata, HDA Intel
217:          0         57   IO-APIC-level  libata
225:          0         70   IO-APIC-level  ehci_hcd:usb1
233:        116      40647   IO-APIC-level  nvidia
NMI:        188        159
LOC:    1108993    1108922
ERR:          0
MIS:          0

Before anyone complains: The kernel used to hang before nvidia was even
 loaded and I really had the problems on vanilla kernel. This kernel
 (2.6.18-rc4) is now reiser4 patched.

I can't say how stable this is, as my system has only been up for 20 minutes
now, but it at least survived and fsck of a 300 GB ext3 partition. ;-) (In
noapic mode the system didn't crash for me, but proc/onterrrupts showed ERR
filling up and the usb drivers complained about some troubles getting IRQs
assigned...)

I think it might be wise to get this fixed before 2.6.18 ships, if above is
the correct fix. I knew nforce2 needed above quirk, but nforce430 seems to =
be
adversely affected. Perhaps some Nvidia dev wants to sched some light here?


I wasn't sure whether Len or Ingo was the correct one to mail to...

Some infos you might want:

dmesg
Bootdata ok (command line is root=3D/dev/sda2 snd-hda-intel.position_fix=3D1
snd-hda-intel.model=3D3stack report_lost_ticks)
Linux version 2.6.18-rc4 (light@graviton) (gcc-Version 4.1.1 (Gentoo 4.1.1))
#8 SMP PREEMPT Sun Aug 13 09:46:55 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007bef0000 (usable)
 BIOS-e820: 000000007bef0000 - 000000007bef3000 (ACPI NVS)
 BIOS-e820: 000000007bef3000 - 000000007bf00000 (ACPI data)
 BIOS-e820: 000000007c000000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f74=
f0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007bef3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007bef30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @
0x000000007befb240
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007befb480
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007befb180
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
On node 0 totalpages: 498950
  DMA zone: 2298 pages, LIFO batch:0
  DMA32 zone: 496652 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
Built 1 zonelists.  Total pages: 498950
Kernel command line: root=3D/dev/sda2 snd-hda-intel.position_fix=3D1
snd-hda-intel.model=3D3stack report_lost_ticks
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2004.214 MHz processor.
time.c: Lost 1310 timer tick(s)! rip console_init+0x0/0x2e)
Console: colour VGA+ 80x25
time.c: Lost 5 timer tick(s)! rip release_console_sem+0x198/0x21b)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ b7d4000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 1992144k/2030528k available (3352k kernel code, 37648k reserved,
 1449k data, 200k init)
Calibrating delay using timer specific routine.. 4011.14 BogoMIPS
(lpj=3D2005573)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
=46reeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
time.c: Lost 1 timer tick(s)! rip acpi_os_write_port+0x19/0x38)
Using local APIC timer interrupts.
result 12526356
Detected 12.526 MHz APIC timer.
time.c: Lost 49 timer tick(s)! rip setup_boot_APIC_clock+0x11a/0x11d)
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4007.76 BogoMIPS
(lpj=3D2003883)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 501 cycles)
Brought up 2 CPUs
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xd5)
testing NMI watchdog ... OK.
migration_cost=3D242
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000
PCI: No mmconfig possible on device 0:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:05.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a
 report PCI-DMA: Disabling IOMMU.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
pnp: 00:01: ioport range 0x2000-0x207f has been reserved
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: a000-afff
  MEM window: fd800000-fd8fffff
  PREFETCH window: fd700000-fd7fffff
PCI: Bridge: 0000:00:03.0
  IO window: 8000-8fff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:04.0
  IO window: b000-bfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: fd900000-fd9fffff
PCI: Bridge: 0000:00:10.0
  IO window: 9000-9fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fda00000-fdafffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Loading Reiser4. See www.namesys.com for a description of Reiser4.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.7)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
time.c: Lost 11 timer tick(s)! rip __do_softirq+0x53/0xd5)
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[02fc:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
Using specific hotkey driver
ACPI: Thermal Zone [THRM] (40 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0 soft_margin=3D60=
 sec
(nowayout=3D 0)
Linux agpgart interface v0.101 (c) Dave Jones
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xd5)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
floppy0: no floppy controllers found
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
GSI 16 sharing vector 0xC9 and IRQ 16
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 23 (level, low) ->
IRQ 201
PCI: Setting latency timer of device 0000:00:14.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01043:816a bound to 0000:00:14.0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf408-0xf40f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: NU DVDRW DDW-081, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 2.00 loaded.
sata_nv 0000:00:0e.0: version 2.0
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
GSI 17 sharing vector 0xD1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 22 (level, low) ->
IRQ 209
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 209
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 209
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 1
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 1
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7V300F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 18 sharing vector 0xD9 and IRQ 18
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 21 (level, low) ->
IRQ 217
PCI: Setting latency timer of device 0000:00:0f.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xCC00 irq 217
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xCC08 irq 217
scsi2 : sata_nv
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata3.00: ata3: dev 0 multi count 1
ata3.00: configured for UDMA/133
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x967
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 > sdb3
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 145226112 512-byte hdwr sectors (74356 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 145226112 512-byte hdwr sectors (74356 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 < sdc5 >
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
GSI 19 sharing vector 0xE1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 20 (level, low) ->
IRQ 225
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 225, io mem 0xfe02e000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 23 (level, low) ->
IRQ 201
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0b.0: irq 201, io mem 0xfe02f000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
usb 1-1.3: new full speed USB device using ehci_hcd and address 3
usb 1-1.3: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 22 (level, low) ->
IRQ 209
PCI: Setting latency timer of device 0000:00:10.1 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
ALSA device list:
  #0: HDA NVidia at 0xfe024000 irq 209
oprofile: using NMI interrupt.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
 processors (version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0xa
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xc
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 200k freed
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
GSI 20 sharing vector 0xE9 and IRQ 20
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APC7] -> GSI 16 (level, low) ->
IRQ 233
PCI: Setting latency timer of device 0000:00:05.0 to 64
NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8762  Mon May 15
 13:58:14 PDT 2006
EXT3 FS on sda2, internal journal
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for chips

lspci -vvv -xxx
00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=3D0 UnitCnt=3D15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut-
LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOutEn-
                Link Control 1: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=3D0 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 1: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut-
 LWI=3D8bit DwFcInEn- LWO=3D8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 1.0GHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA-
UIDRD-
                Link Frequency 1: 800MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz+ 300MHz+ 400MHz+ 500MHz+
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE-
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping
00: de 10 f0 02 06 00 b0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 c0 81 08 e0 e0 01 22 00 11 11 22 20 11 00
50: 23 06 7f 80 03 05 7f 80 00 00 03 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 06 15 05 00
70: 44 44 41 00 d0 09 00 00 11 00 00 00 11 11 88 00
80: 23 99 88 00 1f 00 64 0c 03 00 00 00 7f 00 00 00
90: 78 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 01 01 01 01 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 61 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 00 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 10
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR+ <PERR-
00: de 10 fa 02 00 01 20 40 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 10 00 21 21 14 00 11 11 00 00 03 00 00 00
60: 21 88 13 02 de 8f e1 1f 08 72 4e 10 02 3f 00 20
70: 10 32 54 0a 10 00 00 00 a0 00 00 00 20 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 50 3f 90 3f 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 01 00 00 00 80 f9 fd 00
e0: 00 00 c9 fe 00 00 00 00 00 fc ff ff 00 00 00 00
f0: 00 00 00 00 c7 02 32 00 00 00 00 00 00 00 00 00

00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 fe 02 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 43 10 c0 81 1f 20 1c 20 1f 20 c0 21 00 00 00 00
50: 36 00 38 c9 01 00 00 00 37 00 39 c9 02 1f 1c 80
60: 02 1f 1c 00 00 00 00 00 02 10 1c a0 02 0c 1c 90
70: 02 10 1c 90 02 14 1c 90 02 0c 1c 80 02 10 1c 80
80: 02 14 1c 80 02 18 1c 80 02 1c 1c 80 01 10 1c 80
90: 02 14 1c 80 11 00 11 00 32 01 00 00 00 00 00 00
a0: c2 00 40 61 10 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 41 23 05 08
c0: fd ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 f8 02 00 00 a0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 c0 81 00 00 00 00 02 10 1c 80 02 10 1c a0
50: 02 0c 1c 90 02 10 1c 90 02 14 1c 90 02 0c 1c 80
60: 02 10 1c 80 02 14 1c 80 02 18 1c 80 02 1c 1c 80
70: 01 10 1c 80 1f 20 c0 81 00 00 00 00 3e 30 40 c9
80: 01 00 00 00 46 30 48 c9 02 1f 1c 80 70 20 00 00
90: 89 da 01 09 00 00 00 00 11 00 10 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 08 00 00 00 5a 1c 00 00 10 00 02 00 40 00 40 00
c0: 00 00 00 00 00 00 00 00 01 01 00 05 00 00 00 00
d0: 00 00 f0 03 00 04 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 60 ea 10 10 18 00 00 20 00 00 00 00 00 00 00 00

00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: de 10 f9 02 06 00 a0 00 a2 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: ef dd 7b 2f f7 de 7b 2f f7 de 7b 2f f7 02 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00
70: 0a 00 00 00 03 00 00 00 25 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 05 00 00 00 04 00 00 00
90: 03 04 00 00 01 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] #00 [00fe]
        Capabilities: [fc] #00 [0000]
00: de 10 ff 02 06 00 b0 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 17 00 00 00 00 fe fe 00 00 fe fe 00 00 fe fe 00
50: 00 fe fe 00 00 fe fe 00 00 fe fe 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 7f 02 02 01 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 08 00 00 00 00 00 00 00 00 80 cb fe 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 7e 02 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 43 10 c0 81 11 00 00 00 75 08 00 00 11 00 00 00
50: 75 07 00 00 00 00 00 00 40 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00 04
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00 04
b0: ff ff 03 00 10 11 00 00 ac 10 20 00 30 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fd800000-fd8fffff
        Prefetchable memory behind bridge: 00000000fd700000-00000000fd700000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable+
                Address: 00000000fee00000  Data: 40b1
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTa=
g-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpis=
e-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [100] Virtual Channel
00: de 10 fc 02 07 04 10 00 a1 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 a1 a1 00 00
20: 80 fd 80 fd 71 fd 71 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 04 00
40: 0d 48 00 00 de 10 00 00 01 50 02 f8 00 00 00 00
50: 05 60 83 00 00 00 e0 fe 00 00 00 00 b1 40 00 00
60: 08 80 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 41 01 c0 04 00 00 10 28 00 00 11 3c 11 02
90: 00 00 11 10 00 00 00 00 c0 01 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fde00000-fdefffff
        Prefetchable memory behind bridge: 00000000fdd00000-00000000fdd00000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable+
                Address: 00000000fee00000  Data: 40b9
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTa=
g-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpis=
e-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [100] Virtual Channel
00: de 10 fd 02 07 04 10 00 a1 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 81 81 00 00
20: e0 fd e0 fd d1 fd d1 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 04 00
40: 0d 48 00 00 de 10 00 00 01 50 02 f8 00 00 00 00
50: 05 60 83 00 00 00 e0 fe 00 00 00 00 b9 40 00 00
60: 08 80 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 41 01 c0 04 00 00 10 28 00 00 11 3c 11 01
90: 00 00 11 10 00 00 00 00 c0 01 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fdc00000-fdcfffff
        Prefetchable memory behind bridge: 00000000fd900000-00000000fd900000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1
Enable+
                Address: 00000000fee00000  Data: 40c1
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTa=
g-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port=
 0
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpis=
e-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [100] Virtual Channel
00: de 10 fb 02 07 04 10 00 a1 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 b1 b1 00 00
20: c0 fd c0 fd 91 fd 91 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 04 00
40: 0d 48 00 00 de 10 00 00 01 50 02 f8 00 00 00 00
50: 05 60 83 00 00 00 e0 fe 00 00 00 00 c1 40 00 00
60: 08 80 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 41 01 c0 04 00 00 10 28 00 00 01 3d 11 00
90: 00 00 01 11 00 00 00 00 c0 01 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 VGA compatible controller: nVidia Corporation C51PV [GeForce 6150]
(rev a2) (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81cd
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 233
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=3D16M]
        Region 1: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
        Region 3: Memory at fb000000 (64-bit, non-prefetchable) [size=3D16M]
        [virtual] Expansion ROM at 88000000 [disabled] [size=3D128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/0
Enable-
                Address: 0000000000000000  Data: 0000
00: de 10 40 02 07 00 b0 00 a2 00 00 03 00 00 00 00
10: 00 00 00 fc 0c 00 00 e0 00 00 00 00 04 00 00 fb
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 cd 81
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 01 00 00
40: 43 10 cd 81 00 00 00 00 01 50 02 00 00 00 00 00
50: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 00 00 04 00 00 00 00 00 00 00 01 00 00 00
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 00 00 f8 00 00 00 00 04 00 00 00 00 ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=3D9 UnitCnt=3D15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=3D0 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 0: MLWI=3D8bit DwFcIn- MLWO=3D8bit DwFcOut- LWI=
=3D8bit
DwFcInEn- LWO=3D8bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+
<CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=3D8bit DwFcIn- MLWO=3D8bit DwFcOut- LWI=
=3D8bit
DwFcInEn- LWO=3D8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA-
UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz-
600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE-
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping
00: de 10 70 02 06 00 b0 00 a2 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 c0 81 08 e0 e9 01 22 20 00 00 d0 00 00 00
50: 23 05 7f 80 03 00 00 00 00 00 03 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 06 15 05 00
70: 44 44 44 00 d0 09 00 00 11 00 00 00 11 11 55 00
80: 23 55 55 00 fa 00 64 0c 03 00 00 00 7f 00 00 00
90: 78 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 01 01 01 01 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 00 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: de 10 60 02 0f 00 a0 00 a3 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 c0 81 00 f0 ff fe fa 3e ff 00 fa 3e ff 00
50: fa 3e ff 00 00 5a 62 02 00 00 00 01 00 00 ff ff
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 ff
70: 10 00 ff ff c5 00 00 00 00 00 45 19 00 00 00 03
80: 09 80 00 2d 01 21 00 00 c0 00 00 01 00 00 00 00
90: 00 00 00 00 00 00 00 00 21 47 65 b7 ef cd 00 00
a0: 03 00 30 c1 00 00 00 00 00 00 00 00 00 00 00 00
b0: 90 02 ef 02 00 08 5f 08 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 4: I/O ports at 4c00 [size=3D64]
        Region 5: I/O ports at 4c40 [size=3D64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 64 02 01 00 b0 00 a3 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 4c 00 00 41 4c 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 00 00
40: 43 10 c0 81 01 00 02 c0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 40 00 00 01 44 00 00 01 48 00 00 00 00 00 00
70: 01 00 00 00 00 00 c8 fe 00 00 fe fe 01 20 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: d4 30 80 01 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 10 04 00 00 a0 00 00 80 30 00 00 41 44 44 11
f0: 5a ff 5f bf 00 00 00 c0 10 00 00 00 00 00 00 00

00:0a.2 RAM memory: nVidia Corporation MCP51 Memory Controller 0 (rev a3)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 72 02 00 04 a0 00 a3 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 10 00 00 10 00 00 10 10
50: 10 10 10 10 00 00 00 00 00 00 00 00 00 00 00 00
60: 02 03 00 00 12 00 00 00 02 00 00 00 10 01 12 00
70: 32 33 00 00 03 00 00 00 00 00 00 00 12 01 00 00
80: 10 00 00 00 00 00 00 00 00 00 00 00 30 02 00 00
90: 00 00 00 00 01 20 00 00 01 00 00 00 00 09 00 00
a0: 01 02 00 00 00 10 00 00 05 00 00 00 01 00 00 00
b0: 00 10 00 80 01 00 00 80 00 00 00 00 02 00 00 00
c0: 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 6d 02 07 00 b0 00 a3 10 03 0c 00 00 80 00
10: 00 f0 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01
40: 43 10 c0 81 01 00 02 fe 00 00 00 00 00 00 00 00
50: 00 00 00 00 1d 47 40 00 10 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
(prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 225
        Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 6e 02 06 00 b0 00 a3 20 03 0c 00 00 80 00
10: 00 e0 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 02 03 01
40: 43 10 c0 81 0a 80 98 20 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 01 00 00 60 18 85 03 3c 0a 01 00 00 00 00
70: 00 00 08 05 00 10 20 80 89 3d b6 22 77 25 44 00
80: 01 00 02 fe 00 00 00 00 00 00 00 00 15 16 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 00 00 00 00 08 c0 00 00 00 00 00 00 00 00
b0: 00 11 22 33 00 00 00 00 ff 00 00 00 00 00 00 00
c0: 10 10 2d 0d 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1) (prog-if 8a
[Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f400 [size=3D16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 65 02 05 00 b0 00 a1 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f4 00 00 00 00 00 00 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
40: 43 10 c0 81 01 00 02 00 00 00 00 00 00 00 00 00
50: 03 f0 01 00 00 00 00 00 a8 a8 a8 20 2a 00 99 20
60: 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev
 a1) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at 09f0 [size=3D8]
        Region 1: I/O ports at 0bf0 [size=3D4]
        Region 2: I/O ports at 0970 [size=3D8]
        Region 3: I/O ports at 0b70 [size=3D4]
        Region 4: I/O ports at e000 [size=3D16]
        Region 5: Memory at fe02d000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=3D0/2
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [cc] HyperTransport: MSI Mapping
00: de 10 66 02 07 00 b0 00 a1 85 01 01 00 00 00 00
10: f1 09 00 00 f1 0b 00 00 71 09 00 00 71 0b 00 00
20: 01 e0 00 00 00 d0 02 fe 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01
40: 43 10 c0 81 01 b0 02 00 00 00 00 00 00 00 00 00
50: 03 00 00 00 00 00 00 00 a8 a8 a8 20 6a 00 99 20
60: 00 00 00 c0 51 0c 00 00 00 0f 06 42 00 00 00 00
70: 2c 78 c4 40 01 10 00 00 01 10 00 00 20 00 20 00
80: 00 00 00 c0 00 c0 d2 3a 00 00 38 90 00 94 a4 79
90: 00 00 08 b0 00 00 00 00 06 00 06 10 00 00 01 01
a0: 14 10 00 2d 00 00 00 00 00 00 00 00 33 33 00 02
b0: 05 cc 84 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 0a 00 0a 00 08 00 02 a8
d0: 01 00 02 6b 42 00 00 00 00 00 00 00 00 00 40 80
e0: 01 00 02 6b 42 00 00 00 00 00 00 00 00 00 20 e0
f0: 00 00 00 00 00 00 00 00 00 00 0c 00 00 00 00 00

00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev
 a1) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 217
        Region 0: I/O ports at 09e0 [size=3D8]
        Region 1: I/O ports at 0be0 [size=3D4]
        Region 2: I/O ports at 0960 [size=3D8]
        Region 3: I/O ports at 0b60 [size=3D4]
        Region 4: I/O ports at cc00 [size=3D16]
        Region 5: Memory at fe02c000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=3D0/2
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [cc] HyperTransport: MSI Mapping
00: de 10 67 02 07 00 b0 00 a1 85 01 01 00 00 00 00
10: e1 09 00 00 e1 0b 00 00 61 09 00 00 61 0b 00 00
20: 01 cc 00 00 00 c0 02 fe 00 00 00 00 43 10 c0 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01
40: 43 10 c0 81 01 b0 02 00 00 00 00 00 00 00 00 00
50: 03 00 00 00 00 00 00 00 a8 a8 a8 20 6a 00 99 20
60: 00 00 00 c0 51 0c 00 00 00 0f 06 42 00 00 00 00
70: 2c 78 c4 40 01 10 00 00 01 10 00 00 20 00 20 00
80: 00 00 00 40 00 40 22 7a 00 00 28 80 2d 26 12 ea
90: 00 00 04 1b 00 00 00 00 06 00 06 10 00 00 01 01
a0: 14 10 00 24 00 00 00 00 00 00 00 00 33 33 00 02
b0: 05 cc 84 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 0a 00 0a 00 08 00 02 a8
d0: 01 00 02 6b 42 00 00 00 00 00 00 00 a8 01 01 80
e0: 01 00 02 6b 42 00 00 00 00 00 00 00 00 00 80 07
f0: 00 00 00 00 00 00 00 00 00 00 0c 00 00 00 00 00

00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2) (prog-if 01
[Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D=
128
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fdb00000-fdbfffff
        Prefetchable memory behind bridge: fda00000-fdafffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [b8] #0d [0000]
        Capabilities: [8c] HyperTransport: MSI Mapping
00: de 10 6f 02 07 00 b0 00 a2 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 80 90 90 80 02
20: b0 fd b0 fd a0 fd a0 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 b8 00 00 00 00 00 00 00 ff 00 04 02
40: 00 00 03 00 01 00 02 00 07 00 00 00 00 00 44 00
50: 00 00 fe 7f 00 00 00 00 ff 1f ff 1f 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 a8
90: 00 00 e0 fe 00 00 00 00 00 00 00 00 00 00 00 00
a0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 ff ff 00 00 0d 8c 00 00 00 00 00 00
c0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a=
2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81cb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin B routed to IRQ 209
        Region 0: Memory at fe024000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] HyperTransport: MSI Mapping
00: de 10 6c 02 06 00 b0 00 a2 00 03 04 00 00 80 00
10: 00 40 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 cb 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 02 02 05
40: 43 10 cb 81 01 50 02 c0 00 00 00 00 01 01 0f 00
50: 05 6c 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 0f 00 00 00 08 00 02 a8
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 46 00 29 00 00 00 00 00 00

00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc. Unknown device 816a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at fe02b000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at c800 [size=3D8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME-
00: de 10 69 02 07 00 b0 00 a3 00 80 06 00 00 00 00
10: 00 b0 02 fe 01 c8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 6a 81
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 01 14
40: 43 10 6a 81 01 00 02 fe 00 01 00 00 0b 00 00 10
50: 05 6c 84 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 0f 00 00 00 08 00 02 a8
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 11 00 00 00 42 01 00 00 00 00 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=3D0
                Link Config: MLWI=3D16bit MLWO=3D16bit LWI=3D16bit LWO=3D16=
bit
                Revision ID: 1.02
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 01 00 e4 00 00 00 20 c8 00 0f 0c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 06 75 80 02 00 00 00
90: 56 04 51 02 00 00 04 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 7f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 03 0a 00 00 00 0b 00 00 00 00 00 00 00 00 00 00
90: 03 00 80 00 00 ff ef 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 03 00 f4 00 00 02 fe 00
b0: 03 00 f0 00 80 4f f0 00 00 00 00 00 00 00 00 00
c0: 13 80 00 00 00 f0 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 01 00 00 00 01 01 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 e0 3e 78 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 46 00 00 00 00 00 00 00
80: 20 00 00 00 00 00 00 00 24 c2 6a 0c 20 13 83 00
90: 10 0c 01 00 6a 80 10 67 24 00 00 80 20 22 20 00
a0: ed 02 00 0c 00 00 00 00 00 00 00 00 00 00 00 00
b0: 43 ae d2 bb c5 00 00 00 08 3a 87 c9 20 39 5a 06
c0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 7e 3a 0a 42 80 74 b1 a3 69 4a 07 d9 a2 63 12 14
e0: 8a 1e 65 41 40 70 50 29 29 87 4e 4b 9c 35 c4 0e
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [f0] #0f [0010]
00: 22 10 03 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 04 00 44 00 10 0a 00 00 00 00 00 00 00 00
50: e0 35 74 07 30 00 00 00 00 00 00 00 00 80 62 00
60: 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 32 51 21 40 70 50 00 2a 00 08 17 21 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 00 00 00 00 ea 5b 00 00 40 80 01 29 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 a7 0d 00 00 00 80 08 25 25 25 00
e0: 00 00 00 00 20 1b 55 00 19 17 00 00 00 00 00 00
f0: 0f 00 10 00 00 00 00 00 00 00 00 00 b2 0f 04 00

04:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fdbff000 (32-bit, non-prefetchable) [size=3D2K]
        Region 1: Memory at fdbf8000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 4c 10 23 80 06 00 10 02 00 10 00 0c 08 20 00 00
10: 00 f0 bf fd 00 80 bf fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 8b 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 02 04
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 88 00 00 00
f0: 10 00 00 00 82 10 00 00 43 10 8b 80 00 00 01 01
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3719982.jabRylBZOG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE3uppxU2n/+9+t5gRAmV+AKDlTwl08q+Oxs0yKrfn4XaLP3MHFQCg92qi
zw7mimUHixwLl09ulfZilZc=
=tmG+
-----END PGP SIGNATURE-----

--nextPart3719982.jabRylBZOG--
