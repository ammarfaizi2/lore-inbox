Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWBBQnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWBBQnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWBBQnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:43:04 -0500
Received: from mail.ccur.com ([66.10.65.12]:32135 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S932152AbWBBQnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:43:03 -0500
Message-ID: <43E23692.5040807@ccur.com>
Date: Thu, 02 Feb 2006 11:42:58 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, bugsy@ccur.com
Subject: Re: CONFIG_K8_NUMA x86_64 no-memory node bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2006 16:42:59.0435 (UTC) FILETIME=[B9DE4BB0:01C62817]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > >> I would like to mention a bug with the x86_64 CONFIG_K8_NUMA support.
 > >>
 > >> We have a 4 CPU AMD Opteron (processor 846 -- no dual core) system 
that
 > >> boots up with a 2.6.15.2-based kernel with NUMA enabled if all the 
numa
 > >> nodes are populated with memory modules.
 > >>
 > >> If we then pull out the memory module for the 3rd CPU/node, then the
 > >> kernel will no longer boot.
 > >>
 > >> In this configuration, after the grub 'boot' command is entered, no
 > >> output is seen, and the system appears to be hung.
 > >>
 > >> While this is admittedly a 'degraded' configuration, it would be nice
 > >> if the kernel could handle having a middle numbered node without 
memory.
 > >>
 > >> I believe that removing the 4th CPU's memory module so that only the
 > >> last CPU/node is without memory, then the system boots up fine.
 > >>
 > >> It seems that having a middle node without memory is what causes this
 > >> problem to occur.
 >
 >
 > Does it boot with numa=noacpi?
 >
 > If yes then I likely already fixed the bug. But send boot log of
 > the failure anyways.
 >
 > -Andi

Hi Andi,

Thanks for the reply.

I tried booting the 2.6.15.2 kernel with numa=noacpi.

It didn't help.
With 4 cpus, where the 3rd (next to last) cpu/node is without memory:
---------------------------------------------------------------------
grub> kernel /bzImage-jrb root=/dev/sda2 console=ttyS0,115200 
numa=noacpi
    [Linux-bzImage, setup=0x1400, size=0x34699a]
grub> boot
--------------------------------------------------------------------
Nothing else comes out to the console after the above boot command
is entered.

No /var/log/dmesg, boot.log, or messages file output is seen either.
---------------------------------------------------------------------

I don't know if this helps... but if I add the little kludge below
to acpi_scan_nodes(), then the kernel boots up, even though we
'lied' about which node is lacking memory.  And it seems to
setup just 3 nodes, 0 and 1.

For what ever it's worth, I also include the console output
when this kludge is in the kernel.  (Yeah, this probably doesn't
help much.)


--- /home/linux/kernels/2.6.15/linux-2.6.15/arch/x86_64/mm/srat.c 
2006-01-02 22:21:10.000000000 -0500
+++ ./srat.c	2006-02-02 11:20:47.000000000 -0500
@@ -177,6 +177,11 @@
  	if (acpi_numa <= 0)
  		return -1;

+	nodes[2].start = nodes[3].start;
+	nodes[2].end = nodes[3].end;
+	nodes[3].start = 0;
+	nodes[3].end = 0;
+
  	/* First clean up the node list */
  	for_each_node_mask(i, nodes_parsed) {
  		cutoff_node(i, start, end);


--------------------------------------------------------------------
--------------------------------------------------------------------
grub> kernel /bzImage-jrb root=/dev/sda2 console=ttyS0,115200 

    [Linux-bzImage, setup=0x1400, size=0x346995]

grub> boot

Bootdata ok (command line is root=/dev/sda2 console=ttyS0,115200)
Linux version 2.6.15.2 (johnb@kong) (gcc version 3.4.4 20050721 (Red Hat 
3.4.4-2)) #2 SMP PREEMPT Thu Feb 2 11:14:12 EST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
  BIOS-e820: 00000000bff70000 - 00000000bff7f000 (ACPI data)
  BIOS-e820: 00000000bff7f000 - 00000000bff80000 (ACPI NVS)
  BIOS-e820: 00000000bff80000 - 00000000d0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: RSDP (v002 PTLTD                                 ) @ 
0x00000000000f7850
ACPI: XSDT (v001 PTLTD  	 XSDT   0x06040000  LTP 0x00000000) @ 
0x00000000bff7b3e9
ACPI: FADT (v003 AMD    HAMMER   0x06040000 PTEC 0x000f4240) @ 
0x00000000bff7b535
ACPI: SSDT (v001 AMD-K8 AMD-ACPI 0x06040000  AMD 0x00000001) @ 
0x00000000bff7ec94
ACPI: SSDT (v001 AMD-K8 AMD-ACPI 0x06040000  AMD 0x00000001) @ 
0x00000000bff7ed31
ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 
0x00000000bff7edce
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 
0x00000000bff7ef06
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 
0x00000000bff7efb0
ACPI: DSDT (v001 AMD-K8  AMDACPI 0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-40000000
SRAT: Node 1 PXM 1 40000000-80000000
SRAT: Node 3 PXM 3 80000000-c0000000
SRAT: Node 3 PXM 3 80000000-180000000
Using 30 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-0000000080000000
On node 0 totalpages: 255416
   DMA zone: 1904 pages, LIFO batch:0
   DMA32 zone: 253512 pages, LIFO batch:31
   Normal zone: 0 pages, LIFO batch:0
   HighMem zone: 0 pages, LIFO batch:0
On node 1 totalpages: 257536
   DMA zone: 0 pages, LIFO batch:0
   DMA32 zone: 257536 pages, LIFO batch:31
   Normal zone: 0 pages, LIFO batch:0
   HighMem zone: 0 pages, LIFO batch:0
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
ACPI: IOAPIC (id[0x05] address[0xee200000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xee200000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xee201000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xee201000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xee203000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xee203000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xee205000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xee205000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d4000000 (gap: d0000000:2ec00000)
Checking aperture...
CPU 0: aperture @ c0000000 size 256 MB
CPU 1: aperture @ c0000000 size 256 MB
CPU 2: aperture @ c0000000 size 256 MB
CPU 3: aperture @ c0000000 size 256 MB
Built 2 zonelists
Kernel command line: root=/dev/sda2 console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1993.264 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2048356k/6291456k available (4391k kernel code, 3193540k 
reserved, 2889k data, 268k init)
Calibrating delay using timer specific routine.. 3993.70 BogoMIPS 
(lpj=7987411)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
  tbxface-0109 [02] load_tables           : ACPI Tables successfully 
acquired
Parsing all Control 
Methods:.......................................................................................................................................
Table [DSDT](id 0007) - 369 Objects with 49 Devices 135 Methods 18 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 1 Objects with 0 Devices 0 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 1 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root ffffffff80856a40
evxfevnt-0091 [03] enable                : Transition to ACPI mode 
successful
Using local APIC timer interrupts.
Detected 12.457 MHz APIC timer.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3986.92 BogoMIPS 
(lpj=7973847)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 846 stepping 08
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 880 cycles)
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 3986.69 BogoMIPS 
(lpj=7973382)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 846 stepping 08
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 904 cycles)
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 3986.69 BogoMIPS 
(lpj=7973388)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 846 stepping 08
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -5 cycles, maxerr 1518 cycles)
Brought up 4 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on 
int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 2 Wake, Enabled 2 
Runtime GPEs in this block
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 10 to 2F [_GPE] 4 regs on 
int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 4 Wake, Enabled 2 
Runtime GPEs in this block
Completing Region/Field/Buffer/Package 
initialization:.........................................................
Initialized 18/18 Regions 0/0 Fields 22/22 Buffers 17/23 Packages (380 
nodes)
Executing all Device _STA and_INI 
methods:.......................................................
55 Devices found containing: 55 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:04.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.TP2P._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G0PB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G1PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G1PB._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ c0000000 size 262144 KB
PCI-DMA: Reserving 256MB of IOMMU area in the AGP aperture
pnp: 00:04: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:04: ioport range 0x1100-0x117f has been reserved
pnp: 00:04: ioport range 0x1180-0x11ff has been reserved
pnp: 00:05: ioport range 0xca2-0xca3 has been reserved
PCI: Bridge: 0000:00:06.0
   IO window: 2000-2fff
   MEM window: ec000000-edffffff
   PREFETCH window: d4000000-d40fffff
PCI: Bridge: 0000:08:01.0
   IO window: 4000-4fff
   MEM window: f1000000-f10fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:08:02.0
   IO window: 5000-5fff
   MEM window: f1100000-f11fffff
   PREFETCH window: d4100000-d43fffff
PCI: Bridge: 0000:08:03.0
   IO window: 6000-6fff
   MEM window: ef000000-efffffff
   PREFETCH window: f4000000-f7ffffff
PCI: Bridge: 0000:08:04.0
   IO window: 3000-3fff
   MEM window: f0000000-f0ffffff
   PREFETCH window: f8000000-fbffffff
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:08:03.0[A] -> GSI 32 (level, low) -> IRQ 169
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:08:04.0[A] -> GSI 36 (level, low) -> IRQ 177
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.3)
SGI XFS with realtime, large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
tg3.c:v3.47 (Dec 28, 2005)
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:0e:03.0[A] -> GSI 31 (level, low) -> IRQ 185
eth0: Tigon3 [partno(BCM95704) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 
10/100/1000BaseT Ethernet 00:00:1a:19:1c:71
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
eth0: dma_rwctrl[769f4000]
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:0e:03.1[B] -> GSI 28 (level, low) -> IRQ 193
eth1: Tigon3 [partno(BCM95704) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 
10/100/1000BaseT Ethernet 00:00:1a:19:1c:72
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
eth1: dma_rwctrl[769f4000]
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.48.
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 16 (level, low) -> IRQ 201
eth2: AMD-8111e Driver Version: 3.0.5
eth2: [ Rev 3 ] PCI 10/100BaseT Ethernet 00:00:1a:19:1c:70
eth2: Found MII PHY ID 0x00225521 at address 0x01
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: DV-28E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
iscsi: registered transport (tcp)
Adaptec aacraid driver (1.1-4 Feb  2 2006 08:27:22)
megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
3ware 9000 Storage Controller device driver for Linux v2.26.02.004.
libata version 1.20 loaded.
Fusion MPT base driver 3.03.04
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.04
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:0e:01.0[A] -> GSI 29 (level, low) -> IRQ 209
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator,Target}
scsi0 : ioc0: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=209
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:0e:01.1[B] -> GSI 30 (level, low) -> IRQ 217
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator,Target}
scsi1 : ioc1: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=217
   Vendor: SEAGATE   Model: ST336753LC        Rev: 0006
   Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
   Vendor: SDR       Model: GEM318P           Rev: 1
   Type:   Processor                          ANSI SCSI revision: 02
  1:0:9:0: Attached scsi generic sg1 type 3
Fusion MPT FC Host driver 3.03.04
Fusion MPT SAS Host driver 3.03.04
aoe: aoe_init: AoE v2.6-14 initialised.
usbmon: debugfs is not available
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
GSI 23 sharing vector 0xE1 and IRQ 23
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 225
ohci_hcd 0000:01:00.0: OHCI Host Controller
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 225, io mem 0xec000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 225
ohci_hcd 0000:01:00.1: OHCI Host Controller
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 225, io mem 0xec001000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v2.3
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
    generic_sse:  4834.000 MB/sec
raid5: using function: generic_sse (4834.000 MB/sec)
raid6: int64x1   1864 MB/s
raid6: int64x2   2473 MB/s
raid6: int64x4   2386 MB/s
raid6: int64x8   1647 MB/s
raid6: sse2x1    1617 MB/s
raid6: sse2x2     401 MB/s
raid6: sse2x4    3493 MB/s
raid6: using algorithm sse2x4 (3493 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 
13:30:21 2005 UTC).
ALSA device list:
   No soundcards found.
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
TCP westwood registered
TCP highspeed registered
TCP hybla registered
TCP htcp registered
TCP vegas registered
TCP scalable registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 268k freed
EXT3 FS on sda2, internal journal
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert 
it to SG_IO
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 7341696k swap on /dev/sda3.  Priority:-1 extents:1 across:7341696k

