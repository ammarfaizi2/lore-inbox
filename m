Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVHIMRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVHIMRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVHIMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 08:17:51 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:63916 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932519AbVHIMRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 08:17:49 -0400
Date: Tue, 9 Aug 2005 12:16:54 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
In-Reply-To: <91888D455306F94EBD4D168954A9457C037B0557@nacos172.co.lsil.com>
Message-ID: <Pine.LNX.4.61.0508091126350.18591@praktifix.dwd.de>
References: <91888D455306F94EBD4D168954A9457C037B0557@nacos172.co.lsil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Moore, Eric Dean wrote:

> On Sunday, August 07, 2005 8:30 AM, James Bottomley wrote:
>
>> On Sun, 2005-08-07 at 05:59 +0000, Holger Kiehl wrote:
>>> Thanks, removing those it compiles fine. This patch also
>> solves my problem,
>>> here the output of dmesg:
>>
>> Well ... the transport class was supposed to help diagnose the problem
>> rather than fix it.
>>
>> However, what it shows is that the original problem is in the fusion
>> internal domain validation somewhere, but that we still don't know
>> where...
>>
>> James
>>
>
>
> I was corresponding to Mr Holger Hiehl in private email.
> What I understood the problem to be was when he compiled the drivers into
> the kernel, instead of as modules, we would get some drives negotiating as
> asyn narrow on the 2nd channel.
>
It's always the first channel that has the problem. There are four disks
and the first always negotiated as wide and has the full speed. Disk 2 to
4 are always narrow and give me only 2MB/s. On the 2nd channel everything
is always ok, here all 4 disks have the full speed.

> What I was trying to do was reproduce the
> issue here, and I was unable to.    Has Mr Holger Hiehl tried compiling
> your patch with the drivers compiled statically into the kernel, instead
> of modules?
>
It was compilled in statically into the kernel.

> Anyways - My last suggesting was that he change the scsi cable, and reset
> the parameters in  the bios configuration utility.  I don't believe
> that fixed it.
>
No. I exchanged cables still always the same results. Also on a second
system that has identical hardware, as soon as I put kernel 2.6.13-rc1
I get the same problem.

> Here's my next suggestion.  Recompile the driver with domain validation
> debugging enabled.  Then send me the output dmesg so I can analyze it.
>
This brings us closer to the root of the problem, I think. With domain
validation debugging enabled, this problem is no longer reliably reproducable.
I once even saw that only the forth disk on the first channel had the slow
performance. Booting several times, gave me most the time full speed for
all four disk on the first channel. But the results where not stable.
I then took out some unused drivers (hardware watchdog and IPMI) and the
system would always come up with all four disk at full speed. I then
removed domain validation debugging but then the problem was there again.
So I put in a msleep(2000) in ./drivers/block/elevator.c just after it prints
out what elevator it used and enabled domain validation debugging again.
Booting with this kernel I managed to capture the debugging output with
disk 2 to 4 having only 2MB/s. So I think there is some timing problem,
somewhere.

I also have the output without the msleep(), that is with all four disk
having full speed on the first channel. Please tell me if this is of
intrest, then I will post it as well.

Thanks,
Holger
---



Bootdata ok (command line is ro root=/dev/md0)
Linux version 2.6.13-rc5-git3 (root@helena.dwd.de) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #6 SMP Tue Aug 9 11:14:17 GMT 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
  BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000d2000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000f7f70000 (usable)
  BIOS-e820: 00000000f7f70000 - 00000000f7f76000 (ACPI data)
  BIOS-e820: 00000000f7f76000 - 00000000f7f80000 (ACPI NVS)
  BIOS-e820: 00000000f7f80000 - 00000000f8000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
ACPI: RSDP (v002 PTLTD                                 ) @ 0x00000000000f6a70
ACPI: XSDT (v001 PTLTD  	 XSDT   0x06040000  LTP 0x00000000) @ 0x00000000f7f72e3b
ACPI: FADT (v003 AMD    HAMMER   0x06040000 PTEC 0x000f4240) @ 0x00000000f7f72f97
ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x00000000f7f75904
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x00000000f7f75a3c
ACPI: HPET (v001 AMD    HAMMER   0x06040000 PTEC 0x00000000) @ 0x00000000f7f75dac
ACPI: SSDT (v001 AMD-K8 AMD-ACPI 0x06040000  AMD 0x00000001) @ 0x00000000f7f75de4
ACPI: SSDT (v001 AMD-K8 AMD-ACPI 0x06040000  AMD 0x00000001) @ 0x00000000f7f75e81
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x00000000f7f75f1e
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x00000000f7f75fb0
ACPI: DSDT (v001 AMD-K8  AMDACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> CPU 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> CPU 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> CPU 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> CPU 3 -> Node 3
SRAT: Node 0 PXM 0 0-9ffff
SRAT: Node 0 PXM 0 0-7fffffff
SRAT: Node 1 PXM 1 80000000-f7ffffff
SRAT: Node 2 PXM 2 100000000-17fffffff
SRAT: Node 3 PXM 3 180000000-1ffffffff
Using 26 for the hash shift. Max adder is 1ffffffff 
Bootmem setup node 0 0000000000000000-000000007fffffff
Bootmem setup node 1 0000000080000000-00000000f7ffffff
Bootmem setup node 2 0000000100000000-000000017fffffff
Bootmem setup node 3 0000000180000000-00000001ffffffff
On node 0 totalpages: 524287
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 520191 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 491519
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 491519 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 524287
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 524287 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 524287
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 524287 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0xc008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfc000000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfc000000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfc001000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfc001000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x102282a0 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f8000000 (gap: f8000000:6c00000)
Checking aperture...
CPU 0: aperture @ 0 size 256 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 4000000
Built 4 zonelists
Kernel command line: ro root=/dev/md0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 2205.357 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 8061336k/8388608k available (2219k kernel code, 0k reserved, 1120k data, 208k init)
Calibrating delay using timer specific routine.. 4415.21 BogoMIPS (lpj=22076074)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.530 MHz APIC timer.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4410.04 BogoMIPS (lpj=22050240)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 848 stepping 0a
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/4 APIC 0x2
CPU 1: synchronized TSC with CPU 0 (last diff -131 cycles, maxerr 941 cycles)
Initializing CPU#2
Calibrating delay using timer specific routine.. 4410.04 BogoMIPS (lpj=22050228)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
AMD Opteron(tm) Processor 848 stepping 0a
CPU 2: Syncing TSC to CPU 0.
Booting processor 3/4 APIC 0x3
CPU 2: synchronized TSC with CPU 0 (last diff -127 cycles, maxerr 932 cycles)
Initializing CPU#3
Calibrating delay using timer specific routine.. 4410.14 BogoMIPS (lpj=22050706)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
AMD Opteron(tm) Processor 848 stepping 0a
CPU 3: Syncing TSC to CPU 0.
Brought up 4 CPUs
CPU 3: synchronized TSC with CPU 0 (last diff -171 cycles, maxerr 1594 cycles)
time.c: Using HPET based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:01:06.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.TP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.G0PB._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:06.0
   IO window: 2000-2fff
   MEM window: fc100000-fdffffff
   PREFETCH window: f8000000-f80fffff
PCI: Bridge: 0000:00:0a.0
   IO window: 3000-3fff
   MEM window: fe000000-fe0fffff
   PREFETCH window: f8100000-f82fffff
PCI: Bridge: 0000:03:01.0
   IO window: 4000-4fff
   MEM window: fe100000-fe1fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
   IO window: 4000-4fff
   MEM window: fe100000-fe1fffff
   PREFETCH window: disabled.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 32-bit timers
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 4000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:04: ioport range 0x4d0-0x4d1 has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 18 (level, low) -> IRQ 169
atyfb: using auxiliary register aperture
atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
atyfb: 8M SDRAM (2:1) (32-bit), 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: CPU2 (power states: C1[C1])
ACPI: CPU3 (power states: C1[C1])
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0xC000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 29 (level, low) -> IRQ 177
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:04:04.1[B] -> GSI 30 (level, low) -> IRQ 185
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 31 (level, low) -> IRQ 193
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:04:06.1[B] -> GSI 28 (level, low) -> IRQ 201
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:DMA
     ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hdb: DV-W28EW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 19 (level, low) -> IRQ 209
ata1: SATA max UDMA/100 cmd 0xFFFFC20000010080 ctl 0xFFFFC2000001008A bmdma 0xFFFFC20000010000 irq 209
ata2: SATA max UDMA/100 cmd 0xFFFFC200000100C0 ctl 0xFFFFC200000100CA bmdma 0xFFFFC20000010008 irq 209
ata3: SATA max UDMA/100 cmd 0xFFFFC20000010280 ctl 0xFFFFC2000001028A bmdma 0xFFFFC20000010200 irq 209
ata4: SATA max UDMA/100 cmd 0xFFFFC200000102C0 ctl 0xFFFFC200000102CA bmdma 0xFFFFC20000010208 irq 209
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
   Vendor: ATA       Model: ST3250823AS       Rev: 3.01
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3250823AS       Rev: 3.01
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3 sdb4 < >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.02
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 217
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator,Target}
scsi4 : ioc0: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=217
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=0!
MPT_SCSICFG_NEGOTIATE on id=0!
writeSDP1: id=0 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc0: WriteSDP1 (mf=ffff810002c82660, id=0, req=0xff00, cfg=0x0)
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 0
SCSI device sdc: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
SCSI device sdc: drive cache: write back
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 0
SCSI device sdc: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
SCSI device sdc: drive cache: write back
  sdc: set_dvflags: id=0 lun=0 negoNvram=0 cmd=28
  sdc1
Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=1!
MPT_SCSICFG_NEGOTIATE on id=1!
writeSDP1: id=1 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc0: WriteSDP1 (mf=ffff810002c82b40, id=1, req=0xff00, cfg=0x0)
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 1
SCSI device sdd: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
SCSI device sdd: drive cache: write back
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 1
SCSI device sdd: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
SCSI device sdd: drive cache: write back
  sdd: set_dvflags: id=1 lun=0 negoNvram=0 cmd=28
  sdd1
Attached scsi disk sdd at scsi4, channel 0, id 1, lun 0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=2!
MPT_SCSICFG_NEGOTIATE on id=2!
writeSDP1: id=2 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc0: WriteSDP1 (mf=ffff810002c83020, id=2, req=0xff00, cfg=0x0)
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 2
SCSI device sde: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
SCSI device sde: drive cache: write back
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 2
SCSI device sde: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
SCSI device sde: drive cache: write back
  sde: set_dvflags: id=2 lun=0 negoNvram=0 cmd=28
  sde1
Attached scsi disk sde at scsi4, channel 0, id 2, lun 0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=3!
MPT_SCSICFG_NEGOTIATE on id=3!
writeSDP1: id=3 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc0: WriteSDP1 (mf=ffff810002c83500, id=3, req=0xff00, cfg=0x0)
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 3
SCSI device sdf: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
SCSI device sdf: drive cache: write back
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 3
SCSI device sdf: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
SCSI device sdf: drive cache: write back
  sdf: set_dvflags: id=3 lun=0 negoNvram=0 cmd=28
mptscsih: ioc0: DV started: bus=0, id=0 dv @ ffff810081ab3dd8
mptscsih: ioc0: Getting NVRAM:  id=0 width=1 factor=8 offset=7f flags=0
mptscsih: ioc0: DV: Start Basic test on id=0
mptscsih: ioc0: Setting Min: Setting Min: id=0 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=0 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc0: Sending Command 0x12 for (0:0:0)
  sdf1
Attached scsi disk sdf at scsi4, channel 0, id 3, lun 0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=a0
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83920,mr=0000000000000000,idx=67)
mptscsih: ioc0: Sending Command 0x12 for (0:0:0)
  set_dvflags: id=4 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c839e0,mr=0000000000000000,idx=69)
mptscsih: ioc0: Setting Max: Setting Max: id=0 width=1 factor=8 offset=7f negoFlags=0 request=207f0807 config=0
id=0 width=1 factor=8 offset=7f flags=0 request=207f0807 configuration=0
mptscsih: ioc0: Sending Command 0x12 for (0:0:0)
  set_dvflags: id=5 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=6 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83b00,mr=0000000000000000,idx=72)
mptscsih: ioc0: Updating with SDP0 Data: id=0 width=1 factor=8 offset=7f flags=0
mptscsih: ioc0: DV:Inquiry compared id=0, calling initTarget
mptscsih: ioc0: DV: Basic test on id=0 completed OK.
mptscsih: ioc0: Sending Command 0x0 for (0:0:0)
  set_dvflags: id=8 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83c80,mr=0000000000000000,idx=76)
mptscsih: ioc0: Sending Command 0x3c for (0:0:0)
  set_dvflags: id=9 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83d40,mr=0000000000000000,idx=78)
ReadBuffer Comp Code 0  buff: 1 0 1 fc
mptscsih: ioc0: Sending Command 0x3c for (0:0:0)
  set_dvflags: id=10 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83e00,mr=0000000000000000,idx=80)
ReadBuffer Comp Code 0  buff: 2 73 d0 0
mptscsih: ioc0: Echo Buffer Capacity 508
Pattern 0
mptscsih: ioc0: Sending Command 0x16 for (0:0:0)
  set_dvflags: id=11 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83ec0,mr=0000000000000000,idx=82)
mptscsih: ioc0: Sending Command 0x3b for (0:0:0)
  set_dvflags: id=12 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c83f80,mr=0000000000000000,idx=84)
mptscsih: ioc0: Sending Command 0x3c for (0:0:0)
  set_dvflags: id=13 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c84040,mr=0000000000000000,idx=86)
Pattern 1
mptscsih: ioc0: Sending Command 0x3b for (0:0:0)
  set_dvflags: id=14 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c84100,mr=0000000000000000,idx=88)
mptscsih: ioc0: Sending Command 0x3c for (0:0:0)
  set_dvflags: id=15 lun=0 negoNvram=0 cmd=12
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c841c0,mr=0000000000000000,idx=90)
Pattern 2
mptscsih: ioc0: Sending Command 0x3b for (0:0:0)
ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, low) -> IRQ 225
mptscsih: ioc0: ScanDvComplete (mf=ffff810002c84280,mr=0000000000000000,idx=92)
mptbase: Initiating ioc1 bringup
mptscsih: ioc0: WARNING - No msg frames!
mptscsih: ioc0: WARNING - No msg frames!
mptscsih: ioc0: DV: Release failed. id 0<5>mptscsih: ioc0: Saving to Target structure: id=0 width=1 factor=8 offset=127 flags=0
mptscsih: ioc0: DV Done id=0
mptscsih: ioc0: DV started: bus=0, id=1 dv @ ffff810081ab3dd8
mptscsih: ioc0: Getting NVRAM:  id=1 width=1 factor=8 offset=7f flags=0
mptscsih: ioc0: DV: Start Basic test on id=1
mptscsih: ioc0: Setting Min: Setting Min: id=1 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=1 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc0: Saving to Target structure: id=1 width=0 factor=0 offset=0 flags=0
mptscsih: ioc0: DV Done id=1
mptscsih: ioc0: DV started: bus=0, id=2 dv @ ffff810081ab3dd8
mptscsih: ioc0: Getting NVRAM:  id=2 width=1 factor=8 offset=7f flags=0
mptscsih: ioc0: DV: Start Basic test on id=2
mptscsih: ioc0: Setting Min: Setting Min: id=2 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=2 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc0: Saving to Target structure: id=2 width=0 factor=0 offset=0 flags=0
mptscsih: ioc0: DV Done id=2
mptscsih: ioc0: DV started: bus=0, id=3 dv @ ffff810081ab3dd8
mptscsih: ioc0: Getting NVRAM:  id=3 width=1 factor=8 offset=7f flags=0
mptscsih: ioc0: DV: Start Basic test on id=3
mptscsih: ioc0: Setting Min: Setting Min: id=3 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=3 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc0: Saving to Target structure: id=3 width=0 factor=0 offset=0 flags=0
mptscsih: ioc0: DV Done id=3
ioc1: 53C1030: Capabilities={Initiator,Target}
scsi5 : ioc1: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=225
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=0!
MPT_SCSICFG_NEGOTIATE on id=0!
writeSDP1: id=0 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc1: WriteSDP1 (mf=ffff81007fe02660, id=0, req=0xff00, cfg=0x0)
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 0
SCSI device sdg: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
SCSI device sdg: drive cache: write back
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 0
SCSI device sdg: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 0
SCSI device sdg: drive cache: write back
  sdg: set_dvflags: id=0 lun=0 negoNvram=0 cmd=28
  sdg1
Attached scsi disk sdg at scsi5, channel 0, id 0, lun 0
  set_dvflags: id=0 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=1!
MPT_SCSICFG_NEGOTIATE on id=1!
writeSDP1: id=1 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc1: WriteSDP1 (mf=ffff81007fe02b40, id=1, req=0xff00, cfg=0x0)
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 1
SCSI device sdh: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
SCSI device sdh: drive cache: write back
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 1
SCSI device sdh: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 1
SCSI device sdh: drive cache: write back
  sdh: set_dvflags: id=1 lun=0 negoNvram=0 cmd=28
  sdh1
Attached scsi disk sdh at scsi5, channel 0, id 1, lun 0
  set_dvflags: id=1 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=2!
MPT_SCSICFG_NEGOTIATE on id=2!
writeSDP1: id=2 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc1: WriteSDP1 (mf=ffff81007fe03020, id=2, req=0xff00, cfg=0x0)
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 2
SCSI device sdi: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
SCSI device sdi: drive cache: write back
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 2
SCSI device sdi: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 2
SCSI device sdi: drive cache: write back
  sdi: set_dvflags: id=2 lun=0 negoNvram=0 cmd=28
  sdi1
Attached scsi disk sdi at scsi5, channel 0, id 2, lun 0
  set_dvflags: id=2 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=12
   Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
   Type:   Direct-Access                      ANSI SCSI revision: 03
Enabling QAS due to byte56=0f on id=3!
MPT_SCSICFG_NEGOTIATE on id=3!
writeSDP1: id=3 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
mptscsih: ioc1: WriteSDP1 (mf=ffff81007fe03500, id=3, req=0xff00, cfg=0x0)
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 3
SCSI device sdj: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
SCSI device sdj: drive cache: write back
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=25
NEED_DV set for visible disk id 3
SCSI device sdj: 143552136 512-byte hdwr sectors (73499 MB)
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=1a
NEED_DV set for visible disk id 3
SCSI device sdj: drive cache: write back
  sdj: set_dvflags: id=3 lun=0 negoNvram=0 cmd=28
  sdj1
Attached scsi disk sdj at scsi5, channel 0, id 3, lun 0
  set_dvflags: id=3 lun=0 negoNvram=0 cmd=a0
  set_dvflags: id=4 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=5 lun=0 negoNvram=0 cmd=12
  set_dvflags: id=6 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: DV started: bus=0, id=0 dv @ ffff810081ab3dd8
mptscsih: ioc1: Getting NVRAM:  id=0 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV: Start Basic test on id=0
mptscsih: ioc1: Setting Min: Setting Min: id=0 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=0 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc1: Sending Command 0x12 for (0:0:0)
  set_dvflags: id=8 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03aa0,mr=0000000000000000,idx=71)
mptscsih: ioc1: Sending Command 0x12 for (0:0:0)
  set_dvflags: id=9 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03b60,mr=0000000000000000,idx=73)
mptscsih: ioc1: Setting Max: Setting Max: id=0 width=1 factor=8 offset=7f negoFlags=0 request=207f0807 config=0
id=0 width=1 factor=8 offset=7f flags=0 request=207f0807 configuration=0
mptscsih: ioc1: Sending Command 0x12 for (0:0:0)
  set_dvflags: id=10 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03c80,mr=0000000000000000,idx=76)
mptscsih: ioc1: Updating with SDP0 Data: id=0 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV:Inquiry compared id=0, calling initTarget
mptscsih: ioc1: DV: Basic test on id=0 completed OK.
mptscsih: ioc1: Sending Command 0x0 for (0:0:0)
  set_dvflags: id=11 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03da0,mr=0000000000000000,idx=79)
mptscsih: ioc1: Sending Command 0x3c for (0:0:0)
  set_dvflags: id=12 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03e60,mr=0000000000000000,idx=81)
ReadBuffer Comp Code 0  buff: 1 0 1 fc
mptscsih: ioc1: Sending Command 0x3c for (0:0:0)
  set_dvflags: id=13 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03f20,mr=0000000000000000,idx=83)
ReadBuffer Comp Code 0  buff: 2 73 d0 0
mptscsih: ioc1: Echo Buffer Capacity 508
Pattern 0
mptscsih: ioc1: Sending Command 0x16 for (0:0:0)
  set_dvflags: id=14 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe03fe0,mr=0000000000000000,idx=85)
mptscsih: ioc1: Sending Command 0x3b for (0:0:0)
  set_dvflags: id=15 lun=0 negoNvram=0 cmd=12
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe040a0,mr=0000000000000000,idx=87)
mptscsih: ioc1: Sending Command 0x3c for (0:0:0)
mice: PS/2 mouse device common for all mice
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04160,mr=0000000000000000,idx=89)
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
Pattern 1
mptscsih: ioc1: Sending Command 0x3b for (0:0:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe041c0,mr=0000000000000000,idx=90)
mptscsih: ioc1: Sending Command 0x3c for (0:0:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04220,mr=0000000000000000,idx=91)
Pattern 2
mptscsih: ioc1: Sending Command 0x3b for (0:0:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04280,mr=0000000000000000,idx=92)
mptscsih: ioc1: Sending Command 0x3c for (0:0:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe042e0,mr=0000000000000000,idx=93)
Pattern 3
mptscsih: ioc1: Sending Command 0x3b for (0:0:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04340,mr=0000000000000000,idx=94)
mptscsih: ioc1: Sending Command 0x3c for (0:0:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe043a0,mr=0000000000000000,idx=95)
mptscsih: ioc1: Sending Command 0x17 for (0:0:0)
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04400,mr=0000000000000000,idx=96)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
logips2pp: Detected unknown logitech mouse model 1
NET: Registered protocol family 1
NET: Registered protocol family 17
mptscsih: ioc1: Saving to Target structure: id=0 width=1 factor=8 offset=127 flags=0
mptscsih: ioc1: DV Done id=0
powernow-k8: Found 4 AMD Athlon 64 / Opteron processors (version 1.50.3)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xe, vid 0x2
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xe, vid 0x2
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xe, vid 0x2
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xe, vid 0x2
mptscsih: ioc1: DV started: bus=0, id=1 dv @ ffff810081ab3dd8
mptscsih: ioc1: Getting NVRAM:  id=1 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV: Start Basic test on id=1
mptscsih: ioc1: Setting Min: Setting Min: id=1 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=1 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc1: Sending Command 0x12 for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe044c0,mr=0000000000000000,idx=98)
mptscsih: ioc1: Sending Command 0x12 for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04520,mr=0000000000000000,idx=99)
mptscsih: ioc1: Setting Max: Setting Max: id=1 width=1 factor=8 offset=7f negoFlags=0 request=207f0807 config=0
id=1 width=1 factor=8 offset=7f flags=0 request=207f0807 configuration=0
mptscsih: ioc1: Sending Command 0x12 for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe045e0,mr=0000000000000000,idx=101)
mptscsih: ioc1: Updating with SDP0 Data: id=1 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV:Inquiry compared id=1, calling initTarget
mptscsih: ioc1: DV: Basic test on id=1 completed OK.
mptscsih: ioc1: Sending Command 0x0 for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe046a0,mr=0000000000000000,idx=103)
mptscsih: ioc1: Sending Command 0x3c for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04700,mr=0000000000000000,idx=104)
ReadBuffer Comp Code 0  buff: 1 0 1 fc
mptscsih: ioc1: Sending Command 0x3c for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04760,mr=0000000000000000,idx=105)
ReadBuffer Comp Code 0  buff: 2 73 d0 0
mptscsih: ioc1: Echo Buffer Capacity 508
Pattern 0
mptscsih: ioc1: Sending Command 0x16 for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe047c0,mr=0000000000000000,idx=106)
mptscsih: ioc1: Sending Command 0x3b for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04820,mr=0000000000000000,idx=107)
mptscsih: ioc1: Sending Command 0x3c for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04880,mr=0000000000000000,idx=108)
Pattern 1
mptscsih: ioc1: Sending Command 0x3b for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe048e0,mr=0000000000000000,idx=109)
mptscsih: ioc1: Sending Command 0x3c for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04940,mr=0000000000000000,idx=110)
Pattern 2
mptscsih: ioc1: Sending Command 0x3b for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe049a0,mr=0000000000000000,idx=111)
mptscsih: ioc1: Sending Command 0x3c for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04a00,mr=0000000000000000,idx=112)
Pattern 3
mptscsih: ioc1: Sending Command 0x3b for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04a60,mr=0000000000000000,idx=113)
mptscsih: ioc1: Sending Command 0x3c for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04ac0,mr=0000000000000000,idx=114)
mptscsih: ioc1: Sending Command 0x17 for (0:1:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04b20,mr=0000000000000000,idx=115)
mptscsih: ioc1: Saving to Target structure: id=1 width=1 factor=8 offset=127 flags=0
mptscsih: ioc1: DV Done id=1
mptscsih: ioc1: DV started: bus=0, id=2 dv @ ffff810081ab3dd8
mptscsih: ioc1: Getting NVRAM:  id=2 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV: Start Basic test on id=2
mptscsih: ioc1: Setting Min: Setting Min: id=2 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=2 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc1: Sending Command 0x12 for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04be0,mr=0000000000000000,idx=117)
mptscsih: ioc1: Sending Command 0x12 for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04c40,mr=0000000000000000,idx=118)
mptscsih: ioc1: Setting Max: Setting Max: id=2 width=1 factor=8 offset=7f negoFlags=0 request=207f0807 config=0
id=2 width=1 factor=8 offset=7f flags=0 request=207f0807 configuration=0
mptscsih: ioc1: Sending Command 0x12 for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04d00,mr=0000000000000000,idx=120)
mptscsih: ioc1: Updating with SDP0 Data: id=2 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV:Inquiry compared id=2, calling initTarget
mptscsih: ioc1: DV: Basic test on id=2 completed OK.
mptscsih: ioc1: Sending Command 0x0 for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04dc0,mr=0000000000000000,idx=122)
mptscsih: ioc1: Sending Command 0x3c for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04e20,mr=0000000000000000,idx=123)
ReadBuffer Comp Code 0  buff: 1 0 1 fc
mptscsih: ioc1: Sending Command 0x3c for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04e80,mr=0000000000000000,idx=124)
ReadBuffer Comp Code 0  buff: 2 73 d0 0
mptscsih: ioc1: Echo Buffer Capacity 508
Pattern 0
mptscsih: ioc1: Sending Command 0x16 for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04ee0,mr=0000000000000000,idx=125)
mptscsih: ioc1: Sending Command 0x3b for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04f40,mr=0000000000000000,idx=126)
mptscsih: ioc1: Sending Command 0x3c for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe04fa0,mr=0000000000000000,idx=127)
Pattern 1
mptscsih: ioc1: Sending Command 0x3b for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05000,mr=0000000000000000,idx=128)
mptscsih: ioc1: Sending Command 0x3c for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05060,mr=0000000000000000,idx=129)
Pattern 2
mptscsih: ioc1: Sending Command 0x3b for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe050c0,mr=0000000000000000,idx=130)
mptscsih: ioc1: Sending Command 0x3c for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05120,mr=0000000000000000,idx=131)
Pattern 3
mptscsih: ioc1: Sending Command 0x3b for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05180,mr=0000000000000000,idx=132)
mptscsih: ioc1: Sending Command 0x3c for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe051e0,mr=0000000000000000,idx=133)
mptscsih: ioc1: Sending Command 0x17 for (0:2:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05240,mr=0000000000000000,idx=134)
mptscsih: ioc1: Saving to Target structure: id=2 width=1 factor=8 offset=127 flags=0
mptscsih: ioc1: DV Done id=2
mptscsih: ioc1: DV started: bus=0, id=3 dv @ ffff810081ab3dd8
mptscsih: ioc1: Getting NVRAM:  id=3 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV: Start Basic test on id=3
mptscsih: ioc1: Setting Min: Setting Min: id=3 width=0 factor=ff offset=0 negoFlags=0 request=ff00 config=0
id=3 width=0 factor=ff offset=0 request=ff00 config=0 negoFlags=0
mptscsih: ioc1: Sending Command 0x12 for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05300,mr=0000000000000000,idx=136)
mptscsih: ioc1: Sending Command 0x12 for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05360,mr=0000000000000000,idx=137)
mptscsih: ioc1: Setting Max: Setting Max: id=3 width=1 factor=8 offset=7f negoFlags=0 request=207f0807 config=0
id=3 width=1 factor=8 offset=7f flags=0 request=207f0807 configuration=0
mptscsih: ioc1: Sending Command 0x12 for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05420,mr=0000000000000000,idx=139)
mptscsih: ioc1: Updating with SDP0 Data: id=3 width=1 factor=8 offset=7f flags=0
mptscsih: ioc1: DV:Inquiry compared id=3, calling initTarget
mptscsih: ioc1: DV: Basic test on id=3 completed OK.
mptscsih: ioc1: Sending Command 0x0 for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe054e0,mr=0000000000000000,idx=141)
mptscsih: ioc1: Sending Command 0x3c for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05540,mr=0000000000000000,idx=142)
ReadBuffer Comp Code 0  buff: 1 0 1 fc
mptscsih: ioc1: Sending Command 0x3c for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe055a0,mr=0000000000000000,idx=143)
ReadBuffer Comp Code 0  buff: 2 73 d0 0
mptscsih: ioc1: Echo Buffer Capacity 508
Pattern 0
mptscsih: ioc1: Sending Command 0x16 for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05600,mr=0000000000000000,idx=144)
mptscsih: ioc1: Sending Command 0x3b for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05660,mr=0000000000000000,idx=145)
mptscsih: ioc1: Sending Command 0x3c for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe056c0,mr=0000000000000000,idx=146)
Pattern 1
mptscsih: ioc1: Sending Command 0x3b for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05720,mr=0000000000000000,idx=147)
mptscsih: ioc1: Sending Command 0x3c for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05780,mr=0000000000000000,idx=148)
Pattern 2
mptscsih: ioc1: Sending Command 0x3b for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe057e0,mr=0000000000000000,idx=149)
mptscsih: ioc1: Sending Command 0x3c for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05840,mr=0000000000000000,idx=150)
Pattern 3
mptscsih: ioc1: Sending Command 0x3b for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe058a0,mr=0000000000000000,idx=151)
mptscsih: ioc1: Sending Command 0x3c for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05900,mr=0000000000000000,idx=152)
mptscsih: ioc1: Sending Command 0x17 for (0:3:0)
mptscsih: ioc1: ScanDvComplete (mf=ffff81007fe05960,mr=0000000000000000,idx=153)
mptscsih: ioc1: Saving to Target structure: id=3 width=1 factor=8 offset=127 flags=0
mptscsih: ioc1: DV Done id=3
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdj1 ...
md:  adding sdj1 ...
md: sdi1 has different UUID to sdj1
md: sdh1 has different UUID to sdj1
md: sdg1 has different UUID to sdj1
md:  adding sdf1 ...
md: sde1 has different UUID to sdj1
md: sdd1 has different UUID to sdj1
md: sdc1 has different UUID to sdj1
md: sdb3 has different UUID to sdj1
md: sdb2 has different UUID to sdj1
md: sdb1 has different UUID to sdj1
md: sda3 has different UUID to sdj1
md: sda2 has different UUID to sdj1
md: sda1 has different UUID to sdj1
md: created md6
md: bind<sdf1>
md: bind<sdj1>
md: running: <sdj1><sdf1>
raid1: raid set md6 active with 2 out of 2 mirrors
md: considering sdi1 ...
md:  adding sdi1 ...
md: sdh1 has different UUID to sdi1
md: sdg1 has different UUID to sdi1
md:  adding sde1 ...
md: sdd1 has different UUID to sdi1
md: sdc1 has different UUID to sdi1
md: sdb3 has different UUID to sdi1
md: sdb2 has different UUID to sdi1
md: sdb1 has different UUID to sdi1
md: sda3 has different UUID to sdi1
md: sda2 has different UUID to sdi1
md: sda1 has different UUID to sdi1
md: created md5
md: bind<sde1>
md: bind<sdi1>
md: running: <sdi1><sde1>
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering sdh1 ...
md:  adding sdh1 ...
md: sdg1 has different UUID to sdh1
md:  adding sdd1 ...
md: sdc1 has different UUID to sdh1
md: sdb3 has different UUID to sdh1
md: sdb2 has different UUID to sdh1
md: sdb1 has different UUID to sdh1
md: sda3 has different UUID to sdh1
md: sda2 has different UUID to sdh1
md: sda1 has different UUID to sdh1
md: created md4
md: bind<sdd1>
md: bind<sdh1>
md: running: <sdh1><sdd1>
raid1: raid set md4 active with 2 out of 2 mirrors
md: considering sdg1 ...
md:  adding sdg1 ...
md:  adding sdc1 ...
md: sdb3 has different UUID to sdg1
md: sdb2 has different UUID to sdg1
md: sdb1 has different UUID to sdg1
md: sda3 has different UUID to sdg1
md: sda2 has different UUID to sdg1
md: sda1 has different UUID to sdg1
md: created md3
md: bind<sdc1>
md: bind<sdg1>
md: running: <sdg1><sdc1>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
md: created md2
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2193kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 209
ohci_hcd 0000:01:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 209, io mem 0xfc100000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 209
ohci_hcd 0000:01:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 209, io mem 0xfc101000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 15631160k swap on /dev/md2.  Priority:-1 extents:1

