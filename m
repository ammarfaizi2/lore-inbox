Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFCXdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFCXdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCXdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:33:08 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:50048
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261173AbVFCX2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:28:30 -0400
Date: Sat, 4 Jun 2005 01:28:28 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de, torvalds@osdl.org
Subject: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Greg K-H suggested I distribute this more widely]

Hello all,

there appear to be difficulties correctly mapping addresses behind a
PCI Express-to-PCI bridge in kernel 2.6.12-rc5. 

Specifically, this occurs on my Acer Travelmate 8100 notebook (Pentium
M, Intel 915M chipset) when it is connected via PCI Express to the
ezDock docking station.

While all of the USB and FireWire devices are visible using config
space reads, they cannot be accessed correctly (all normal reads
appear to return 0xff).  After checking the dmesg logs, I find

	PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
	PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0

This would confirm my hypothesis, since reads go the route of

  Processor
  Intel 82801xx ICH6 southbridge 
  PCI Express port 3             0000:00:1c.2
  Intel 6702PXH PCIE-PCI bridge  0000:02:00.0
  ezDock-internal PCI bus        0000:03:xx.x
    USB
    Firewire
    ...

Since the PCIE-PCI bridge cannot be memory-mapped, the devices behind it
cannot be accessed correctly.

I am no expert on debugging this part of the kernel, but I will gladly
provide additional info to resolve this problem.

For your reference, I have attached a dmesg log with PCI debugging info,
two lspci outputs (-vvt and -vvx), and a dump of /proc/iomem.

Many thanks,
  Andreas Koch  

OUTPUT OF dmesg *****************************************************************

Linux version 2.6.12-rc5 (root@grima) (gcc version 3.3.5-20050130 (Gentoo Linux 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #8 Thu Jun 2 23:14:25 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe80000 (usable)
 BIOS-e820: 000000007fe80000 - 000000007fe89000 (ACPI data)
 BIOS-e820: 000000007fe89000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 523904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294528 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f68d0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7fe80e14
ACPI: FADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88e8a
ACPI: MADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88efe
ACPI: HPET (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88f64
ACPI: MCFG (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88f9c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7fe88fd8
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030224) @ 0x7fe81249
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x7fe81071
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x7fe80e58
ACPI: DSDT (v001 INTEL  ALVISO   0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec20000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec20000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: root=/dev/ram0 lvm2root=/dev/vg0/root
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec20000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1995.414 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069408k/2095616k available (3325k kernel code, 24912k reserved, 1527k data, 216k init, 1178112k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3932.16 BogoMIPS (lpj=1966080)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2061k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd6ce, last bus=8
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node c20da160 start_node c20da160 return_node 00000000
    ACPI-0352: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node c20dada0 start_node c20dada0 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/2590] 000600 00
PCI: Calling quirk c0271990 for 0000:00:00.0
PCI: Calling quirk c0271f50 for 0000:00:00.0
PCI: Calling quirk c03c29a0 for 0000:00:00.0
PCI: Calling quirk c03c2b80 for 0000:00:00.0
PCI: Calling quirk c03c2d70 for 0000:00:00.0
PCI: Found 0000:00:01.0 [8086/2591] 000604 01
PCI: Calling quirk c0271990 for 0000:00:01.0
PCI: Calling quirk c0271f50 for 0000:00:01.0
PCI: Calling quirk c03c29a0 for 0000:00:01.0
PCI: Calling quirk c03c2b80 for 0000:00:01.0
PCI: Calling quirk c03c2d70 for 0000:00:01.0
PCI: Found 0000:00:1b.0 [8086/2668] 000403 00
PCI: Calling quirk c0271990 for 0000:00:1b.0
PCI: Calling quirk c0271f50 for 0000:00:1b.0
PCI: Calling quirk c03c29a0 for 0000:00:1b.0
PCI: Calling quirk c03c2b80 for 0000:00:1b.0
PCI: Calling quirk c03c2d70 for 0000:00:1b.0
PCI: Found 0000:00:1c.0 [8086/2660] 000604 01
PCI: Calling quirk c0271990 for 0000:00:1c.0
PCI: Calling quirk c0271f50 for 0000:00:1c.0
PCI: Calling quirk c03c29a0 for 0000:00:1c.0
PCI: Calling quirk c03c2b80 for 0000:00:1c.0
PCI: Calling quirk c03c2d70 for 0000:00:1c.0
PCI: Found 0000:00:1c.1 [8086/2662] 000604 01
PCI: Calling quirk c0271990 for 0000:00:1c.1
PCI: Calling quirk c0271f50 for 0000:00:1c.1
PCI: Calling quirk c03c29a0 for 0000:00:1c.1
PCI: Calling quirk c03c2b80 for 0000:00:1c.1
PCI: Calling quirk c03c2d70 for 0000:00:1c.1
PCI: Found 0000:00:1c.2 [8086/2664] 000604 01
PCI: Calling quirk c0271990 for 0000:00:1c.2
PCI: Calling quirk c0271f50 for 0000:00:1c.2
PCI: Calling quirk c03c29a0 for 0000:00:1c.2
PCI: Calling quirk c03c2b80 for 0000:00:1c.2
PCI: Calling quirk c03c2d70 for 0000:00:1c.2
PCI: Found 0000:00:1d.0 [8086/2658] 000c03 00
PCI: Calling quirk c0271990 for 0000:00:1d.0
PCI: Calling quirk c0271f50 for 0000:00:1d.0
PCI: Calling quirk c03c29a0 for 0000:00:1d.0
PCI: Calling quirk c03c2b80 for 0000:00:1d.0
PCI: Calling quirk c03c2d70 for 0000:00:1d.0
PCI: Found 0000:00:1d.1 [8086/2659] 000c03 00
PCI: Calling quirk c0271990 for 0000:00:1d.1
PCI: Calling quirk c0271f50 for 0000:00:1d.1
PCI: Calling quirk c03c29a0 for 0000:00:1d.1
PCI: Calling quirk c03c2b80 for 0000:00:1d.1
PCI: Calling quirk c03c2d70 for 0000:00:1d.1
PCI: Found 0000:00:1d.2 [8086/265a] 000c03 00
PCI: Calling quirk c0271990 for 0000:00:1d.2
PCI: Calling quirk c0271f50 for 0000:00:1d.2
PCI: Calling quirk c03c29a0 for 0000:00:1d.2
PCI: Calling quirk c03c2b80 for 0000:00:1d.2
PCI: Calling quirk c03c2d70 for 0000:00:1d.2
PCI: Found 0000:00:1d.3 [8086/265b] 000c03 00
PCI: Calling quirk c0271990 for 0000:00:1d.3
PCI: Calling quirk c0271f50 for 0000:00:1d.3
PCI: Calling quirk c03c29a0 for 0000:00:1d.3
PCI: Calling quirk c03c2b80 for 0000:00:1d.3
PCI: Calling quirk c03c2d70 for 0000:00:1d.3
PCI: Found 0000:00:1d.7 [8086/265c] 000c03 00
PCI: Calling quirk c0271990 for 0000:00:1d.7
PCI: Calling quirk c0271f50 for 0000:00:1d.7
PCI: Calling quirk c03c29a0 for 0000:00:1d.7
PCI: Calling quirk c03c2b80 for 0000:00:1d.7
PCI: Calling quirk c03c2d70 for 0000:00:1d.7
PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
PCI: Calling quirk c0271990 for 0000:00:1e.0
PCI: Calling quirk c0271f50 for 0000:00:1e.0
PCI: Calling quirk c03c29a0 for 0000:00:1e.0
PCI: Calling quirk c03c2b80 for 0000:00:1e.0
PCI: Calling quirk c03c2d70 for 0000:00:1e.0
PCI: Found 0000:00:1f.0 [8086/2641] 000601 00
PCI: Calling quirk c0271990 for 0000:00:1f.0
PCI: Calling quirk c0271f50 for 0000:00:1f.0
PCI: Calling quirk c03c29a0 for 0000:00:1f.0
PCI: Calling quirk c03c2b80 for 0000:00:1f.0
PCI: Calling quirk c03c2d70 for 0000:00:1f.0
PCI: Found 0000:00:1f.2 [8086/2653] 000101 00
PCI: Calling quirk c0271990 for 0000:00:1f.2
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Calling quirk c0271f50 for 0000:00:1f.2
PCI: Calling quirk c03c29a0 for 0000:00:1f.2
PCI: Calling quirk c03c2b80 for 0000:00:1f.2
PCI: Calling quirk c03c2d70 for 0000:00:1f.2
PCI: Found 0000:00:1f.3 [8086/266a] 000c05 00
PCI: Calling quirk c0271990 for 0000:00:1f.3
PCI: Calling quirk c0271f50 for 0000:00:1f.3
PCI: Calling quirk c03c29a0 for 0000:00:1f.3
PCI: Calling quirk c03c2b80 for 0000:00:1f.3
PCI: Calling quirk c03c2d70 for 0000:00:1f.3
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [1002/5653] 000300 00
PCI: Calling quirk c0271990 for 0000:01:00.0
PCI: Calling quirk c0271f50 for 0000:01:00.0
PCI: Calling quirk c03c29a0 for 0000:01:00.0
PCI: Calling quirk c03c2d70 for 0000:01:00.0
Boot video device is 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 090900, pass 0
PCI: Scanning bus 0000:09
PCI: Fixups for bus 0000:09
PCI: Bus scan for 0000:09 returning with max=09
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 0a0a00, pass 0
PCI: Scanning bus 0000:0a
PCI: Fixups for bus 0000:0a
PCI: Bus scan for 0000:0a returning with max=0a
PCI: Scanning behind PCI bridge 0000:00:1c.2, config 040200, pass 0
PCI: Scanning bus 0000:02
PCI: Found 0000:02:00.0 [8086/032c] 000604 01
PCI: Calling quirk c0271990 for 0000:02:00.0
PCI: Calling quirk c0271f50 for 0000:02:00.0
PCI: Calling quirk c03c29a0 for 0000:02:00.0
PCI: Calling quirk c03c2b80 for 0000:02:00.0
PCI: Calling quirk c03c2d70 for 0000:02:00.0
PCI: Fixups for bus 0000:02
PCI: Scanning behind PCI bridge 0000:02:00.0, config 040302, pass 0
PCI: Scanning bus 0000:03
PCI: Found 0000:03:02.0 [1106/3038] 000c03 00
PCI: Calling quirk c0271990 for 0000:03:02.0
PCI: Calling quirk c0271a80 for 0000:03:02.0
PCI: Calling quirk c0271f50 for 0000:03:02.0
PCI: Calling quirk c03c29a0 for 0000:03:02.0
PCI: Calling quirk c03c2d70 for 0000:03:02.0
PCI: Found 0000:03:02.1 [1106/3038] 000c03 00
PCI: Calling quirk c0271990 for 0000:03:02.1
PCI: Calling quirk c0271a80 for 0000:03:02.1
PCI: Calling quirk c0271f50 for 0000:03:02.1
PCI: Calling quirk c03c29a0 for 0000:03:02.1
PCI: Calling quirk c03c2d70 for 0000:03:02.1
PCI: Found 0000:03:02.2 [1106/3104] 000c03 00
PCI: Calling quirk c0271990 for 0000:03:02.2
PCI: Calling quirk c0271a80 for 0000:03:02.2
PCI: Calling quirk c0271f50 for 0000:03:02.2
PCI: Calling quirk c03c29a0 for 0000:03:02.2
PCI: Calling quirk c03c2d70 for 0000:03:02.2
PCI: Found 0000:03:03.0 [1106/3038] 000c03 00
PCI: Calling quirk c0271990 for 0000:03:03.0
PCI: Calling quirk c0271a80 for 0000:03:03.0
PCI: Calling quirk c0271f50 for 0000:03:03.0
PCI: Calling quirk c03c29a0 for 0000:03:03.0
PCI: Calling quirk c03c2d70 for 0000:03:03.0
PCI: Found 0000:03:03.1 [1106/3038] 000c03 00
PCI: Calling quirk c0271990 for 0000:03:03.1
PCI: Calling quirk c0271a80 for 0000:03:03.1
PCI: Calling quirk c0271f50 for 0000:03:03.1
PCI: Calling quirk c03c29a0 for 0000:03:03.1
PCI: Calling quirk c03c2d70 for 0000:03:03.1
PCI: Found 0000:03:03.2 [1106/3104] 000c03 00
PCI: Calling quirk c0271990 for 0000:03:03.2
PCI: Calling quirk c0271a80 for 0000:03:03.2
PCI: Calling quirk c0271f50 for 0000:03:03.2
PCI: Calling quirk c03c29a0 for 0000:03:03.2
PCI: Calling quirk c03c2d70 for 0000:03:03.2
PCI: Found 0000:03:04.0 [104c/8023] 000c00 00
PCI: Calling quirk c0271990 for 0000:03:04.0
PCI: Calling quirk c0271f50 for 0000:03:04.0
PCI: Calling quirk c03c29a0 for 0000:03:04.0
PCI: Calling quirk c03c2d70 for 0000:03:04.0
PCI: Found 0000:03:05.0 [104c/ac50] 000607 02
PCI: Calling quirk c0271990 for 0000:03:05.0
PCI: Calling quirk c0271f50 for 0000:03:05.0
PCI: Calling quirk c03c29a0 for 0000:03:05.0
PCI: Calling quirk c03c2d70 for 0000:03:05.0
PCI: Found 0000:03:06.0 [10ec/8197] 000703 00
PCI: Calling quirk c0271990 for 0000:03:06.0
PCI: Calling quirk c0271f50 for 0000:03:06.0
PCI: Calling quirk c03c29a0 for 0000:03:06.0
PCI: Calling quirk c03c2d70 for 0000:03:06.0
PCI: Fixups for bus 0000:03
PCI: Scanning behind PCI bridge 0000:03:05.0, config 040403, pass 0
PCI: Scanning behind PCI bridge 0000:03:05.0, config 040403, pass 1
PCI: Bus scan for 0000:03 returning with max=07
PCI: Scanning behind PCI bridge 0000:02:00.0, config 040302, pass 1
PCI: Bus scan for 0000:02 returning with max=07
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 080600, pass 0
PCI: Scanning bus 0000:06
PCI: Found 0000:06:03.0 [8086/4223] 000280 00
PCI: Calling quirk c0271990 for 0000:06:03.0
PCI: Calling quirk c0271f50 for 0000:06:03.0
PCI: Calling quirk c03c29a0 for 0000:06:03.0
PCI: Calling quirk c03c2b80 for 0000:06:03.0
PCI: Calling quirk c03c2d70 for 0000:06:03.0
PCI: Found 0000:06:06.0 [14e4/169c] 000200 00
PCI: Calling quirk c0271990 for 0000:06:06.0
PCI: Calling quirk c0271f50 for 0000:06:06.0
PCI: Calling quirk c03c29a0 for 0000:06:06.0
PCI: Calling quirk c03c2d70 for 0000:06:06.0
PCI: Found 0000:06:07.0 [104c/8026] 000c00 00
PCI: Calling quirk c0271990 for 0000:06:07.0
PCI: Calling quirk c0271f50 for 0000:06:07.0
PCI: Calling quirk c03c29a0 for 0000:06:07.0
PCI: Calling quirk c03c2d70 for 0000:06:07.0
PCI: Found 0000:06:09.0 [1217/7223] 000607 02
PCI: Calling quirk c0271990 for 0000:06:09.0
PCI: Calling quirk c0271f50 for 0000:06:09.0
PCI: Calling quirk c03c29a0 for 0000:06:09.0
PCI: Calling quirk c03c2d70 for 0000:06:09.0
PCI: Found 0000:06:09.1 [1217/7223] 000607 02
PCI: Calling quirk c0271990 for 0000:06:09.1
PCI: Calling quirk c0271f50 for 0000:06:09.1
PCI: Calling quirk c03c29a0 for 0000:06:09.1
PCI: Calling quirk c03c2d70 for 0000:06:09.1
PCI: Found 0000:06:09.2 [1217/7110] 000880 00
PCI: Calling quirk c0271990 for 0000:06:09.2
PCI: Calling quirk c0271f50 for 0000:06:09.2
PCI: Calling quirk c03c29a0 for 0000:06:09.2
PCI: Calling quirk c03c2d70 for 0000:06:09.2
PCI: Found 0000:06:09.3 [1217/7223] 000607 02
PCI: Calling quirk c0271990 for 0000:06:09.3
PCI: Calling quirk c0271f50 for 0000:06:09.3
PCI: Calling quirk c03c29a0 for 0000:06:09.3
PCI: Calling quirk c03c2d70 for 0000:06:09.3
PCI: Fixups for bus 0000:06
PCI: Transparent bridge - 0000:00:1e.0
PCI: Scanning behind PCI bridge 0000:06:09.0, config 070706, pass 0
PCI: Scanning behind PCI bridge 0000:06:09.1, config 080806, pass 0
PCI: Scanning behind PCI bridge 0000:06:09.3, config 000000, pass 0
PCI: Scanning behind PCI bridge 0000:06:09.0, config 070706, pass 1
PCI: Scanning behind PCI bridge 0000:06:09.1, config 080806, pass 1
PCI: Scanning behind PCI bridge 0000:06:09.3, config 000000, pass 1
PCI: Bus scan for 0000:06 returning with max=12
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 090900, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 0a0a00, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.2, config 040200, pass 1
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 080600, pass 1
PCI: Bus scan for 0000:00 returning with max=12
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
  got res [80000000:80000fff] bus [80000000:80000fff] flags 200 for BAR 0 of 0000:06:09.3
PCI: moved device 0000:06:09.3 resource 0 (200) to 80000000
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1117747355.222:0): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
PCI: Calling quirk c0271840 for 0000:00:00.0
PCI: Calling quirk c0271fa0 for 0000:00:00.0
PCI: Calling quirk c0271840 for 0000:00:01.0
PCI: Calling quirk c0271fa0 for 0000:00:01.0
PCI: Calling quirk c0271840 for 0000:00:1b.0
PCI: Calling quirk c0271fa0 for 0000:00:1b.0
PCI: Calling quirk c0271840 for 0000:00:1c.0
PCI: Calling quirk c0271fa0 for 0000:00:1c.0
PCI: Calling quirk c0271840 for 0000:00:1c.1
PCI: Calling quirk c0271fa0 for 0000:00:1c.1
PCI: Calling quirk c0271840 for 0000:00:1c.2
PCI: Calling quirk c0271fa0 for 0000:00:1c.2
PCI: Calling quirk c0271840 for 0000:00:1d.0
PCI: Calling quirk c0271fa0 for 0000:00:1d.0
PCI: Calling quirk c0271840 for 0000:00:1d.1
PCI: Calling quirk c0271fa0 for 0000:00:1d.1
PCI: Calling quirk c0271840 for 0000:00:1d.2
PCI: Calling quirk c0271fa0 for 0000:00:1d.2
PCI: Calling quirk c0271840 for 0000:00:1d.3
PCI: Calling quirk c0271fa0 for 0000:00:1d.3
PCI: Calling quirk c0271840 for 0000:00:1d.7
PCI: Calling quirk c0271fa0 for 0000:00:1d.7
PCI: Calling quirk c0271840 for 0000:00:1e.0
PCI: Calling quirk c0271fa0 for 0000:00:1e.0
PCI: Calling quirk c0271840 for 0000:00:1f.0
PCI: Calling quirk c0271fa0 for 0000:00:1f.0
PCI: Calling quirk c0271840 for 0000:00:1f.2
PCI: Calling quirk c0271fa0 for 0000:00:1f.2
PCI: Calling quirk c0271840 for 0000:00:1f.3
PCI: Calling quirk c0271fa0 for 0000:00:1f.3
PCI: Calling quirk c0271840 for 0000:01:00.0
PCI: Calling quirk c0271840 for 0000:02:00.0
PCI: Calling quirk c0271fa0 for 0000:02:00.0
PCI: Calling quirk c0271840 for 0000:03:02.0
PCI: Calling quirk c0271840 for 0000:03:02.1
PCI: Calling quirk c0271840 for 0000:03:03.0
PCI: Calling quirk c0271840 for 0000:03:03.1
PCI: Calling quirk c0271840 for 0000:03:02.2
PCI: Calling quirk c0271840 for 0000:03:03.2
PCI: Calling quirk c0271840 for 0000:03:04.0
PCI: Calling quirk c0271840 for 0000:03:05.0
PCI: Calling quirk c0271840 for 0000:03:06.0
PCI: Calling quirk c0271840 for 0000:06:03.0
PCI: Calling quirk c0271fa0 for 0000:06:03.0
PCI: Calling quirk c0271840 for 0000:06:06.0
PCI: Calling quirk c0271840 for 0000:06:07.0
PCI: Calling quirk c0271840 for 0000:06:09.0
PCI: Calling quirk c0271840 for 0000:06:09.1
PCI: Calling quirk c0271840 for 0000:06:09.3
PCI: Calling quirk c0271840 for 0000:06:09.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Enabling bus mastering for device 0000:00:1c.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Enabling bus mastering for device 0000:00:1c.1
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Enabling bus mastering for device 0000:00:1c.2
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (49 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 32 (level, low) -> IRQ 32
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
tg3.c:v3.29 (May 23, 2005)
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Enabling bus mastering for device 0000:06:06.0
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
libata version 1.10 loaded.
ahci version 1.00
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci: probe of 0000:00:1f.2 failed with error -12
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Enabling bus mastering for device 0000:00:1f.2
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18A0 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7d09 84:4003 85:3469 86:3c09 87:4003 88:203f
ata1: dev 0 ATA, max UDMA/100, 195371568 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: ST9100823A        Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18A8 irq 15
ata2: dev 0 cfg 49:0f00 82:421c 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: HL-DT-ST  Model: DVDRAM GMA-4080N  Rev: 0H35
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 30 (level, low) -> IRQ 30
PCI: Enabling bus mastering for device 0000:03:04.0
ohci1394: fw-host0: Remapped memory spaces reg 0xf8834800
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: ffffffff
ohci1394: fw-host0: 32 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: ffffffff
ohci1394: fw-host0: 32 iso transmit contexts available
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 165.165 (PCI): IRQ=[30]  MMIO=[c8304800-c8304fff]  Max Packet=[65536]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Losing some ticks... checking if CPU frequency changed.
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Serial EEPROM has suspicious values, attempting to setting max_packet_size to 512 bytes
ohci1394: fw-host0:     EEPROM Present: 1
ohci1394: fw-host0:     EEPROM 00: ff
ohci1394: fw-host0:     EEPROM 01: ff
ohci1394: fw-host0:     EEPROM 02: ff
ohci1394: fw-host0:     EEPROM 03: ff
ohci1394: fw-host0:     EEPROM 04: ff
ohci1394: fw-host0:     EEPROM 05: ff
ohci1394: fw-host0:     EEPROM 06: ff
ohci1394: fw-host0:     EEPROM 07: ff
ohci1394: fw-host0:     EEPROM 08: ff
ohci1394: fw-host0:     EEPROM 09: ff
ohci1394: fw-host0:     EEPROM 0a: ff
ohci1394: fw-host0:     EEPROM 0b: ff
ohci1394: fw-host0:     EEPROM 0c: ff
ohci1394: fw-host0:     EEPROM 0d: ff
ohci1394: fw-host0:     EEPROM 0e: ff
ohci1394: fw-host0:     EEPROM 0f: ff
ohci1394: fw-host0:     EEPROM 10: ff
ohci1394: fw-host0:     EEPROM 11: ff
ohci1394: fw-host0:     EEPROM 12: ff
ohci1394: fw-host0:     EEPROM 13: ff
ohci1394: fw-host0:     EEPROM 14: ff
ohci1394: fw-host0:     EEPROM 15: ff
ohci1394: fw-host0:     EEPROM 16: ff
ohci1394: fw-host0:     EEPROM 17: ff
ohci1394: fw-host0:     EEPROM 18: ff
ohci1394: fw-host0:     EEPROM 19: ff
ohci1394: fw-host0:     EEPROM 1a: ff
ohci1394: fw-host0:     EEPROM 1b: ff
ohci1394: fw-host0:     EEPROM 1c: ff
ohci1394: fw-host0:     EEPROM 1d: ff
ohci1394: fw-host0:     EEPROM 1e: ff
ohci1394: fw-host0:     EEPROM 1f: ff
ieee1394: CSR: setting expire to 98, HZ=1000
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Enabling bus mastering for device 0000:06:07.0
ohci1394: fw-host1: Remapped memory spaces reg 0xf8846000
ohci1394: fw-host1: Soft reset finished
ohci1394: fw-host1: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host1: 4 iso receive contexts available
ohci1394: fw-host1: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host1: 8 iso transmit contexts available
ohci1394: fw-host1: Receive DMA ctx=0 initialized
ohci1394: fw-host1: Receive DMA ctx=0 initialized
ohci1394: fw-host1: Transmit DMA ctx=0 initialized
ohci1394: fw-host1: Transmit DMA ctx=1 initialized
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[c8415000-c84157ff]  Max Packet=[2048]
ieee1394: CSR: setting expire to 98, HZ=1000
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
yenta 0000:03:05.0: no resource of type 100 available, trying to continue...
yenta 0000:03:05.0: no resource of type 100 available, trying to continue...
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:05.0, mfunc 0x00521d22, devctl 0x66
Yenta TI: socket 0000:03:05.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:03:05.0 falling back to parallel PCI interrupts
Yenta TI: socket 0000:03:05.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: ffffffff
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
Yenta O2: res at 0x94/0xD4: ea/00
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.1 [1025:0070]
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host1: IntEvent: 00020010
ohci1394: fw-host1: irq_handler: Bus reset requested
ohci1394: fw-host1: Cancel request received
ohci1394: fw-host1: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host1: Single packet rcv'd
ohci1394: fw-host1: Got phy packet ctx=0 ... discarded
ohci1394: fw-host1: IntEvent: 00010000
ohci1394: fw-host1: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host1: SelfID packet 0x807f8842 received
ieee1394: Including SelfID 0x42887f80
ohci1394: fw-host1: SelfID for this node is 0x807f8842
ohci1394: fw-host1: SelfID complete
ohci1394: fw-host1: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_1
PCI: Enabling device 0000:06:09.3 (0080 -> 0082)
ACPI: PCI Interrupt 0000:06:09.3[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.3 [1025:0070]
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000410
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 a07b0404
ieee1394: received packet: ffc00160 ffc00000 00000000 a07b0404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 32a264e0
ieee1394: received packet: ffc00960 ffc00000 00000000 32a264e0
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 009fc000
ieee1394: received packet: ffc00d60 ffc00000 00000000 009fc000
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 1cd13800
ieee1394: received packet: ffc01160 ffc00000 00000000 1cd13800
ieee1394: send packet local: ffc01550 ffc0ffff f0000400 04000000
ieee1394: received packet: ffc01550 ffc0ffff f0000400 04000000
ieee1394: send packet local: ffc01570 ffc00000 00000000 04000000
ieee1394: received packet: ffc01570 ffc00000 00000000 04000000
ieee1394: NodeMgr: raw=0xe064a232 irmc=1 cmc=1 isc=1 bmc=0 pmc=0 cyc_clk_acc=100 max_rec=2048 max_rom=1024 gen=3 lspd=2
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[00c09f000038d11c]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394: fw-host1: Inserting packet for node 1-63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394: fw-host1: Starting transmit DMA ctx=0
ohci1394: fw-host1: IntEvent: 00000001
ohci1394: fw-host1: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host1: Packet sent to node 63 tcode=0x0 tLabel=0 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
usbmon: debugs is not available
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: capability 0001 at 68
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xc8004000
ehci_hcd 0000:00:1d.7: reset command 080022 (park)=0 ithresh=8 Async period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
usb usb1: Manufacturer: Linux 2.6.12-rc5 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
ACPI: PCI Interrupt 0000:03:02.2[C] -> GSI 26 (level, low) -> IRQ 26
PCI: Enabling bus mastering for device 0000:03:02.2
ehci_hcd 0000:03:02.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:03:02.2: reset hcs_params 0xffffffff dbg=15 ind cc=15 pcc=15 ports=15
ehci_hcd 0000:03:02.2: reset portroute 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 
ehci_hcd 0000:03:02.2: reset hcc_params ffffffff caching frame 256/512/1024 park 64 bit addr
ehci_hcd 0000:03:02.2: capability c2125a00 at ff
ehci_hcd 0000:03:02.2: illegal capability!
ehci_hcd 0000:03:02.2: ...powerdown ports...
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
ehci_hcd 0000:03:02.2: bogus port configuration: cc=15 x pcc=15 < ports=15
ehci_hcd 0000:03:02.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:03:02.2: irq 26, io mem 0xc8304000
ehci_hcd 0000:03:02.2: reset command ffffffff park=3 ithresh=63 LReset IAAD Async Periodic period=?? R
ehci_hcd 0000:03:02.2: startup error -19
ehci_hcd 0000:03:02.2: USB bus 2 deregistered
ehci_hcd 0000:03:02.2: init 0000:03:02.2 fail, -19
ACPI: PCI Interrupt 0000:03:03.2[C] -> GSI 29 (level, low) -> IRQ 29
PCI: Enabling bus mastering for device 0000:03:03.2
ehci_hcd 0000:03:03.2: VIA Technologies, Inc. USB 2.0 (#2)
ehci_hcd 0000:03:03.2: reset hcs_params 0xffffffff dbg=15 ind cc=15 pcc=15 ports=15
ehci_hcd 0000:03:03.2: reset portroute 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 
ehci_hcd 0000:03:03.2: reset hcc_params ffffffff caching frame 256/512/1024 park 64 bit addr
ehci_hcd 0000:03:03.2: capability c2125a00 at ff
ehci_hcd 0000:03:03.2: illegal capability!
ehci_hcd 0000:03:03.2: ...powerdown ports...
ehci_hcd 0000:03:03.2: bogus port configuration: cc=15 x pcc=15 < ports=15
ehci_hcd 0000:03:03.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:03:03.2: irq 29, io mem 0xc8304400
ehci_hcd 0000:03:03.2: reset command ffffffff park=3 ithresh=63 LReset IAAD Async Periodic period=?? R
ehci_hcd 0000:03:03.2: startup error -19
ehci_hcd 0000:03:03.2: USB bus 2 deregistered
ehci_hcd 0000:03:03.2: init 0000:03:03.2 fail, -19
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
usb usb2: Manufacturer: Linux 2.6.12-rc5 uhci_hcd
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
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
usb usb3: Manufacturer: Linux 2.6.12-rc5 uhci_hcd
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
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
usb usb4: Manufacturer: Linux 2.6.12-rc5 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
uhci_hcd 0000:00:1d.3: detected 2 ports
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
usb usb5: Manufacturer: Linux 2.6.12-rc5 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: hotplug
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 24 (level, low) -> IRQ 24
uhci_hcd 0000:03:02.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:03:02.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:02.0: irq 24, io base 0x00003040
uhci_hcd 0000:03:02.0: detected 8 ports
uhci_hcd 0000:03:02.0: port count misdetected? forcing to 2 ports
uhci_hcd 0000:03:02.0: USBCMD_HCRESET timed out!
uhci_hcd 0000:03:02.0: startup error -110
uhci_hcd 0000:03:02.0: USB bus 6 deregistered
uhci_hcd 0000:03:02.0: init 0000:03:02.0 fail, -110
uhci_hcd: probe of 0000:03:02.0 failed with error -110
ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 25 (level, low) -> IRQ 25
uhci_hcd 0000:03:02.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:03:02.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:02.1: irq 25, io base 0x00003060
uhci_hcd 0000:03:02.1: detected 8 ports
uhci_hcd 0000:03:02.1: port count misdetected? forcing to 2 ports
uhci_hcd 0000:03:02.1: USBCMD_HCRESET timed out!
uhci_hcd 0000:03:02.1: startup error -110
uhci_hcd 0000:03:02.1: USB bus 6 deregistered
uhci_hcd 0000:03:02.1: init 0000:03:02.1 fail, -110
uhci_hcd: probe of 0000:03:02.1 failed with error -110
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 27 (level, low) -> IRQ 27
uhci_hcd 0000:03:03.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:03:03.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:03.0: irq 27, io base 0x00003080
uhci_hcd 0000:03:03.0: detected 8 ports
uhci_hcd 0000:03:03.0: port count misdetected? forcing to 2 ports
uhci_hcd 0000:03:03.0: USBCMD_HCRESET timed out!
uhci_hcd 0000:03:03.0: startup error -110
uhci_hcd 0000:03:03.0: USB bus 6 deregistered
uhci_hcd 0000:03:03.0: init 0000:03:03.0 fail, -110
uhci_hcd: probe of 0000:03:03.0 failed with error -110
ACPI: PCI Interrupt 0000:03:03.1[B] -> GSI 28 (level, low) -> IRQ 28
uhci_hcd 0000:03:03.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:03:03.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:03.1: irq 28, io base 0x000030a0
uhci_hcd 0000:03:03.1: detected 8 ports
uhci_hcd 0000:03:03.1: port count misdetected? forcing to 2 ports
uhci_hcd 0000:03:03.1: USBCMD_HCRESET timed out!
uhci_hcd 0000:03:03.1: startup error -110
uhci_hcd 0000:03:03.1: USB bus 6 deregistered
uhci_hcd 0000:03:03.1: init 0000:03:03.1 fail, -110
uhci_hcd: probe of 0000:03:03.1 failed with error -110
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usbcore: registered new driver auerswald
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
AZAL RP01 RP02 RP04 USB1 USB2 USB3 USB4 USB7 LANC 
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
input: AT Translated Set 2 keyboard on isa0060/serio0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
uhci_hcd 0000:00:1d.0: suspend_hc
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.3: suspend_hc
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
Adding 2097144k swap on /dev/vg0/swap.  Priority:-1 extents:1
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

OUTPUT OF lspci -vvx *********************************************************

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
  Latency: 0
  Capabilities: [e0] #09 [2109]
00: 86 80 90 25 06 01 90 20 03 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 08
  Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
  I/O behind bridge: 00002000-00002fff
  Memory behind bridge: c8100000-c81fffff
  Prefetchable memory behind bridge: d0000000-d7ffffff
  Expansion ROM at 00002000 [disabled] [size=4K]
  BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
  Capabilities: [88] #0d [0000]
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
    Address: 00000000  Data: 0000
  Capabilities: [a0] #10 [0141]
00: 86 80 91 25 07 00 10 00 03 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 20 20 00 20
20: 10 c8 10 c8 00 d0 f0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 0a 01 0c 00

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 08
  Interrupt: pin A routed to IRQ 16
  Region 0: Memory at c8000000 (64-bit, non-prefetchable)
  Capabilities: [50] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
    Address: 0000000000000000  Data: 0000
  Capabilities: [70] #10 [0091]
00: 86 80 68 26 06 00 10 00 04 00 03 04 08 00 00 00
10: 04 00 00 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
  Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 08
  Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
  I/O behind bridge: 00000000-00000fff
  Memory behind bridge: 00000000-000fffff
  Prefetchable memory behind bridge: 0000000000000000-0000000000000000
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
  Capabilities: [40] #10 [0141]
  Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
    Address: 00000000  Data: 0000
  Capabilities: [90] #0d [0000]
  Capabilities: [a0] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 60 26 04 00 10 00 04 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 09 09 00 00 00 00 20
20: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 04 00

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
  Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 08
  Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
  I/O behind bridge: 00000000-00000fff
  Memory behind bridge: 00000000-000fffff
  Prefetchable memory behind bridge: 0000000000000000-0000000000000000
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
  Capabilities: [40] #10 [0141]
  Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
    Address: 00000000  Data: 0000
  Capabilities: [90] #0d [0000]
  Capabilities: [a0] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 62 26 04 00 10 00 04 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 0a 0a 00 00 00 00 20
20: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 04 00

0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04) (prog-if 00 [Normal decode])
  Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 08
  Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
  I/O behind bridge: 00000000-00000fff
  Memory behind bridge: 00000000-000fffff
  Prefetchable memory behind bridge: 0000000000000000-0000000000000000
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
  Capabilities: [40] #10 [0141]
  Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
    Address: 00000000  Data: 0000
  Capabilities: [90] #0d [0000]
  Capabilities: [a0] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 64 26 04 00 10 00 04 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 04 00 00 00 00 20
20: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 03 04 00

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Interrupt: pin A routed to IRQ 23
  Region 4: I/O ports at 1800 [size=32]
00: 86 80 58 26 05 00 80 02 04 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Interrupt: pin B routed to IRQ 19
  Region 4: I/O ports at 1820 [size=32]
00: 86 80 59 26 05 00 80 02 04 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Interrupt: pin C routed to IRQ 18
  Region 4: I/O ports at 1840 [size=32]
00: 86 80 5a 26 05 00 80 02 04 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Interrupt: pin D routed to IRQ 16
  Region 4: I/O ports at 1860 [size=32]
00: 86 80 5b 26 05 00 80 02 04 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Interrupt: pin A routed to IRQ 23
  Region 0: Memory at c8004000 (32-bit, non-prefetchable)
  Capabilities: [50] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [58] #0a [20a0]
00: 86 80 5c 26 06 00 90 02 04 20 03 0c 00 00 00 00
10: 00 40 00 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Bus: primary=00, secondary=06, subordinate=08, sec-latency=32
  Memory behind bridge: c8400000-c84fffff
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
  Capabilities: [50] #0d [0000]
00: 86 80 48 24 07 00 10 00 d4 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 06 08 20 f0 00 80 22
20: 40 c8 40 c8 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 04 00

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
00: 86 80 41 26 07 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04) (prog-if 80 [Master])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0
  Interrupt: pin B routed to IRQ 19
  Region 0: I/O ports at <unassigned>
  Region 1: I/O ports at <unassigned>
  Region 2: I/O ports at <unassigned>
  Region 3: I/O ports at <unassigned>
  Region 4: I/O ports at 18a0 [size=16]
  Capabilities: [70] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 53 26 05 00 b0 02 04 80 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 18 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 70 00 00 00 00 00 00 00 ff 02 00 00

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin B routed to IRQ 11
  Region 4: I/O ports at 18e0 [size=32]
00: 86 80 6a 26 01 00 80 02 04 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 18 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5653 (prog-if 00 [VGA])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 08
  Interrupt: pin A routed to IRQ 10
  Region 0: Memory at d0000000 (32-bit, prefetchable)
  Region 1: I/O ports at 2000 [size=256]
  Region 2: Memory at c8100000 (32-bit, non-prefetchable) [size=64K]
  Capabilities: [50] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [58] #10 [0001]
  Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
    Address: 0000000000000000  Data: 0000
00: 02 10 53 56 07 00 10 00 00 00 00 03 08 00 00 00
10: 08 00 00 d0 01 20 00 00 00 00 10 c8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

0000:02:00.0 PCI bridge: Intel Corporation 6702PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 0, cache line size 10
  Bus: primary=02, secondary=03, subordinate=04, sec-latency=48
  I/O behind bridge: 00003000-00003fff
  Memory behind bridge: c8200000-c83fffff
  Expansion ROM at 00003000 [disabled] [size=4K]
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
  Capabilities: [44] #10 [0071]
  Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
    Address: 0000000000000000  Data: 0000
  Capabilities: [6c] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [d8] 00: 86 80 2c 03 07 00 10 00 09 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 02 03 04 30 30 30 a0 22
20: 20 c8 30 c8 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 04 00

0000:03:02.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
  Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin A routed to IRQ 24
  Region 4: I/O ports at 3040 [size=32]
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 13 00 10 02 61 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 30 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 00 00

0000:03:02.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
  Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin B routed to IRQ 25
  Region 4: I/O ports at 3060 [size=32]
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 13 00 10 02 61 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 30 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 02 00 00

0000:03:02.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63) (prog-if 20 [EHCI])
  Subsystem: VIA Technologies, Inc. USB 2.0
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin C routed to IRQ 26
  Region 0: Memory at c8304000 (32-bit, non-prefetchable)
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 13 00 10 02 63 20 03 0c 08 20 80 00
10: 00 40 30 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 03 00 00

0000:03:03.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
  Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin A routed to IRQ 27
  Region 4: I/O ports at 3080 [size=32]
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 13 00 10 02 61 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 30 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 00 00

0000:03:03.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
  Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin B routed to IRQ 28
  Region 4: I/O ports at 30a0 [size=32]
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 13 00 10 02 61 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 30 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 02 00 00

0000:03:03.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63) (prog-if 20 [EHCI])
  Subsystem: VIA Technologies, Inc. USB 2.0
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin C routed to IRQ 29
  Region 0: Memory at c8304400 (32-bit, non-prefetchable)
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 13 00 10 02 63 20 03 0c 08 20 80 00
10: 00 44 30 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 03 00 00

0000:03:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
  Subsystem: Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 32 (500ns min, 1000ns max), cache line size 08
  Interrupt: pin A routed to IRQ 30
  Region 0: Memory at c8304800 (32-bit, non-prefetchable)
  Region 1: Memory at c8300000 (32-bit, non-prefetchable) [size=16K]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 23 80 16 00 10 02 00 10 00 0c 08 20 00 00
10: 00 48 30 c8 00 00 30 c8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4c 10 23 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 02 04

0000:03:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
  Subsystem: Texas Instruments PCI1410 PC card Cardbus Controller
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 168, cache line size 10
  Interrupt: pin A routed to IRQ 31
  Region 0: Memory at c8305000 (32-bit, non-prefetchable)
  Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
  Memory window 0: c8200000-c823f000 (prefetchable)
  Memory window 1: c8240000-c827f000
  I/O window 1: 00000000-00000003
  BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
  16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 02 00 07 06 10 a8 02 00
10: 00 50 30 c8 a0 00 00 02 03 04 07 b0 00 00 20 c8
20: 00 f0 23 c8 00 00 24 c8 00 f0 27 c8 00 f0 ff ff
30: fc 0f 00 00 00 00 00 00 00 00 00 00 ff 01 c0 05
40: 4c 10 50 ac 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:03:06.0 Modem: Realtek Semiconductor Co., Ltd. SmartLAN56 56K Modem (prog-if 00 [Generic])
  Subsystem: AMBIT Microsystem Corp.: Unknown device 3006
  Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin A routed to IRQ 32
  Region 0: I/O ports at 3000
  Capabilities: [48] Power Management version 2
    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 97 81 01 00 90 02 00 00 03 07 00 20 00 00
10: 01 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 68 14 06 30
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 01 00 00

0000:06:03.0 Network controller: Intel Corporation PRO/Wireless 2915ABG MiniPCI Adapter (rev 05)
  Subsystem: Intel Corporation: Unknown device 1001
  Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin A routed to IRQ 11
  Region 0: Memory at c8414000 (32-bit, non-prefetchable)
  Capabilities: [dc] Power Management version 2
    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 23 42 12 00 90 02 05 00 80 02 08 20 00 00
10: 00 40 41 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 01 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 03 18

0000:06:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet (rev 03)
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 32 (16000ns min), cache line size 08
  Interrupt: pin A routed to IRQ 16
  Region 0: Memory at c8400000 (32-bit, non-prefetchable)
  Capabilities: [48] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=1 PME-
  Capabilities: [50] Vital Product Data
  Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
    Address: 05e6c4342c7ffffc  Data: fffb
00: e4 14 9c 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 00 00 40 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 25 10 70 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 40 00

0000:06:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 32 (750ns min, 1000ns max), cache line size 08
  Interrupt: pin A routed to IRQ 19
  Region 0: Memory at c8415000 (32-bit, non-prefetchable)
  Region 1: Memory at c8410000 (32-bit, non-prefetchable) [size=16K]
  Capabilities: [44] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME+
00: 4c 10 26 80 16 00 10 02 00 10 00 0c 08 20 00 00
10: 00 50 41 c8 00 00 41 c8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 04

0000:06:09.0 CardBus bridge: O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus Controller
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 168
  Interrupt: pin A routed to IRQ 18
  Region 0: Memory at c8416000 (32-bit, non-prefetchable)
  Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
  Memory window 0: 80400000-807ff000 (prefetchable)
  Memory window 1: 80800000-80bff000
  I/O window 0: 00004000-000040ff
  I/O window 1: 00004400-000044ff
  BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
  16-bit legacy interface ports at 0001
00: 17 12 23 72 87 00 10 04 00 00 07 06 00 a8 82 00
10: 00 60 41 c8 a0 00 00 02 06 07 0a b0 00 00 40 80
20: 00 f0 7f 80 00 00 80 80 00 f0 bf 80 01 40 00 00
30: fd 40 00 00 01 44 00 00 fd 44 00 00 0b 01 80 05
40: 25 10 70 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:06:09.1 CardBus bridge: O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus Controller
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 168
  Interrupt: pin A routed to IRQ 18
  Region 0: Memory at c8417000 (32-bit, non-prefetchable)
  Bus: primary=06, secondary=0b, subordinate=0e, sec-latency=176
  Memory window 0: 80c00000-80fff000 (prefetchable)
  Memory window 1: 81000000-813ff000
  I/O window 0: 00004800-000048ff
  I/O window 1: 00004c00-00004cff
  BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
  16-bit legacy interface ports at 0001
00: 17 12 23 72 87 00 10 04 00 00 07 06 00 a8 82 00
10: 00 70 41 c8 a0 00 00 02 06 0b 0e b0 00 00 c0 80
20: 00 f0 ff 80 00 00 00 81 00 f0 3f 81 01 48 00 00
30: fd 48 00 00 01 4c 00 00 fd 4c 00 00 0a 01 80 05
40: 25 10 70 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:06:09.2 System peripheral: O2 Micro, Inc. OZ711Mx 4-in-1 MemoryCardBus Accelerator
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin A routed to IRQ 11
  Region 0: Memory at c8418000 (32-bit, non-prefetchable)
  Capabilities: [a0] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 12 10 71 03 00 10 04 00 00 80 08 08 20 80 00
10: 00 80 41 c8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 70 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0b 01 00 00

0000:06:09.3 CardBus bridge: O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus Controller
  Subsystem: Acer Incorporated [ALI]: Unknown device 0070
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 168
  Interrupt: pin A routed to IRQ 18
  Region 0: Memory at 80000000 (32-bit, non-prefetchable)
  Bus: primary=06, secondary=0f, subordinate=12, sec-latency=176
  Memory window 0: 81400000-817ff000 (prefetchable)
  Memory window 1: 81800000-81bff000
  I/O window 0: 00005000-000050ff
  I/O window 1: 00005400-000054ff
  BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
  16-bit legacy interface ports at 0001
00: 17 12 23 72 87 00 10 04 00 00 07 06 00 a8 82 00
10: 00 00 00 80 a0 00 00 02 06 0f 12 b0 00 00 40 81
20: 00 f0 7f 81 00 00 80 81 00 f0 bf 81 01 50 00 00
30: fd 50 00 00 01 54 00 00 fd 54 00 00 00 01 80 05
40: 25 10 70 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

OUTPUT OF lspci -vvt ***********************************************************

-[00]-+-00.0  Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller
      +-01.0-[01]----00.0  ATI Technologies Inc: Unknown device 5653
      +-1b.0  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller
      +-1c.0-[09]--
      +-1c.1-[0a]--
      +-1c.2-[02-04]----00.0-[03-04]--+-02.0  VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
      |                               +-02.1  VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
      |                               +-02.2  VIA Technologies, Inc. USB 2.0
      |                               +-03.0  VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
      |                               +-03.1  VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
      |                               +-03.2  VIA Technologies, Inc. USB 2.0
      |                               +-04.0  Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
      |                               +-05.0  Texas Instruments PCI1410 PC card Cardbus Controller
      |                               \-06.0  Realtek Semiconductor Co., Ltd. SmartLAN56 56K Modem
      +-1d.0  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
      +-1d.1  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
      +-1d.2  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
      +-1d.3  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
      +-1d.7  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
      +-1e.0-[06-08]--+-03.0  Intel Corporation PRO/Wireless 2915ABG MiniPCI Adapter
      |               +-06.0  Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet
      |               +-07.0  Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
      |               +-09.0  O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus Controller
      |               +-09.1  O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus Controller
      |               +-09.2  O2 Micro, Inc. OZ711Mx 4-in-1 MemoryCardBus Accelerator
      |               \-09.3  O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus Controller
      +-1f.0  Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge
      +-1f.2  Intel Corporation 82801FBM (ICH6M) SATA Controller
      \-1f.3  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller

/proc/iomem *******************************************************************

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cdfff : Video ROM
000ce000-000cffff : reserved
000f0000-000fffff : System ROM
00100000-7fe7ffff : System RAM
  00100000-0043f68e : Kernel code
  0043f68f-005bd2ff : Kernel data
7fe80000-7fe88fff : ACPI Tables
7fe89000-7fefffff : ACPI Non-volatile Storage
7ff00000-7fffffff : reserved
80000000-80000fff : 0000:06:09.3
  80000000-80000fff : yenta_socket
80400000-807fffff : PCI CardBus #07
80800000-80bfffff : PCI CardBus #07
80c00000-80ffffff : PCI CardBus #0b
81000000-813fffff : PCI CardBus #0b
81400000-817fffff : PCI CardBus #0f
81800000-81bfffff : PCI CardBus #0f
a0000000-a0000fff : pcmcia_socket3
c8000000-c8003fff : 0000:00:1b.0
  c8000000-c8003fff : ICH HD audio
c8004000-c80043ff : 0000:00:1d.7
  c8004000-c80043ff : ehci_hcd
c8100000-c81fffff : PCI Bus #01
  c8100000-c810ffff : 0000:01:00.0
c8304800-c8304fff : ohci1394
c8305000-c8305fff : yenta_socket
c8400000-c840ffff : 0000:06:06.0
  c8400000-c840ffff : tg3
c8410000-c8413fff : 0000:06:07.0
c8414000-c8414fff : 0000:06:03.0
c8415000-c84157ff : 0000:06:07.0
  c8415000-c84157ff : ohci1394
c8416000-c8416fff : 0000:06:09.0
  c8416000-c8416fff : yenta_socket
c8417000-c8417fff : 0000:06:09.1
  c8417000-c8417fff : yenta_socket
c8418000-c8418fff : 0000:06:09.2
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
e0000000-f0005fff : reserved
f0008000-f000bfff : reserved
fed20000-fed8ffff : reserved
ff000000-ffffffff : reserved
