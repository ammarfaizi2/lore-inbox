Return-Path: <linux-kernel-owner+w=401wt.eu-S1030270AbXAKKtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbXAKKtx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXAKKtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:49:53 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:43760 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030264AbXAKKts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:49:48 -0500
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 05:49:47 EST
From: Faik Uygur <faik@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: linux-kernel@vger.kernel.org
Subject: ahci_softreset prevents acpi_power_off
Date: Thu, 11 Jan 2007 12:31:26 +0200
User-Agent: KMail/1.9.5
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111231.26819.faik@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a Sony PCG-6H1M laptop. It started failing to poweroff with our switch 
from 2.6.16 stable series kernels to 2.6.18 stable series. Rebooting works.

While searching for the cause, I have found these reported bug reports in the 
kernel bugzilla which may be related to this bug:

http://bugzilla.kernel.org/show_bug.cgi?id=6982
http://bugzilla.kernel.org/show_bug.cgi?id=7447

According to git bisect, this is the first bad commit:

4658f79bec0b51222e769e328c2923f39f3bda77 is first bad commit
commit 4658f79bec0b51222e769e328c2923f39f3bda77
Author: Tejun Heo <htejun@gmail.com>
Date:   Wed Mar 22 21:07:03 2006 +0900

    [PATCH] ahci: add softreset

    Now that libata is smart enought to handle both soft and hard resets,
    add softreset method.

    Signed-off-by: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

:040000 040000 ba0a16d0ef82b6577bb61cfb18e6d9df9ee0984e 
d0fc78d8f9bbe238f98ac8964562a33e64b30605 M      drivers

With v2.6.20-rc4 from git, it is still failing to poweroff. By not compiling 
CONFIG_SCSI_SATA_AHCI, it successfully powers off.

Also with CONFIG_SCSI_SATA_AHCI, reverting this patch manually by setting 
softreset to NULL in ata_do_eh calls in ahci.c makes the machine poweroff.

I have attached the dmesg output with defined ATA_DEBUG, ATA_VERBOSE_DEBUG
if it helps. Also you may find lspci output attached. 

Please let me know if anything else is needed.

Regards,
- Faik

Linux version 2.6.20-rc4 (root@pardus) (gcc version 3.4.6) #56 SMP Thu Jan 11 
11:38:37 EET 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 
000000000009f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 
00000000000a0000 type: 2
copy_e820_map() start: 00000000000d8000 size: 0000000000028000 end: 
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fd90000 end: 
000000001fe90000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fe90000 size: 000000000000d000 end: 
000000001fe9d000 type: 3
copy_e820_map() start: 000000001fe9d000 size: 0000000000063000 end: 
000000001ff00000 type: 4
copy_e820_map() start: 000000001ff00000 size: 0000000000100000 end: 
0000000020000000 type: 2
copy_e820_map() start: 00000000e0000000 size: 0000000010006000 end: 
00000000f0006000 type: 2
copy_e820_map() start: 00000000f0008000 size: 0000000000004000 end: 
00000000f000c000 type: 2
copy_e820_map() start: 00000000fed20000 size: 0000000000070000 end: 
00000000fed90000 type: 2
copy_e820_map() start: 00000000ff000000 size: 0000000001000000 end: 
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fe90000 (usable)
 BIOS-e820: 000000001fe90000 - 000000001fe9d000 (ACPI data)
 BIOS-e820: 000000001fe9d000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
510MB LOWMEM available.
Entering add_active_range(0, 0, 130704) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   130704
  HighMem    130704 ->   130704
early_node_map[1] active PFN ranges
    0:        0 ->   130704
On node 0 totalpages: 130704
  DMA zone: 52 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4044 pages, LIFO batch:0
  Normal zone: 1607 pages used for memmap
  Normal zone: 125001 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6780
ACPI: RSDT (v001   Sony       V0 0x20051108 PTL  0x00000000) @ 0x1fe97449
ACPI: FADT (v002   Sony       V0 0x20051108 PTL  0x00000050) @ 0x1fe9ce78
ACPI: MADT (v001   Sony       V0 0x20051108 PTL  0x00000050) @ 0x1fe9cefc
ACPI: BOOT (v001   Sony       V0 0x20051108 PTL  0x00000001) @ 0x1fe9cfd8
ACPI: MCFG (v001   Sony       V0 0x20051108 PTL  0x0000005f) @ 0x1fe9cf9c
ACPI: SSDT (v001   Sony       V0 0x20051108 PTL  0x20030224) @ 0x1fe983aa
ACPI: SSDT (v001   Sony       V0 0x20051108 PTL  0x20030224) @ 0x1fe97d0e
ACPI: SSDT (v001   Sony       V0 0x20051108 PTL  0x20030224) @ 0x1fe978c9
ACPI: SSDT (v001   Sony       V0 0x20051108 PTL  0x20030224) @ 0x1fe976aa
ACPI: SSDT (v001   Sony       V0 0x20051108 PTL  0x20030224) @ 0x1fe97491
ACPI: DSDT (v001   Sony       V0 0x20051108 PTL  0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1729.210 MHz processor.
Built 1 zonelists.  Total pages: 129045
Kernel command line: root=/dev/sda1 mudur=language:tr init=/bin/bash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1064 kB
 per task-struct memory footprint: 1200 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 510364k/522816k available (1530k kernel code, 11928k reserved, 704k 
data, 172k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfe90000   ( 510 MB)
      .init : 0xc0334000 - 0xc035f000   ( 172 kB)
      .data : 0xc027eb6d - 0xc032ed18   ( 704 kB)
      .text : 0xc0100000 - 0xc027eb6d   (1530 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3461.30 BogoMIPS 
(lpj=1730652)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00002040 00000180 
00000000 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 7k freed
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 000A) - 649 Objects with 60 Devices 190 Methods 21 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 10 Objects with 3 Devices 4 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 11 Objects with 3 Devices 5 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0006) - 5 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0007) - 1 Objects with 0 Devices 1 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0008) - 10 Objects with 0 Devices 2 Methods 0 Regions
ACPI Namespace successfully loaded at root c05a54b0
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) M processor 1.73GHz stepping 08
Total of 1 processors activated (3461.30 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 
0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 2 Runtime 
GPEs in this block
Completing Region/Field/Buffer/Package 
initialization:.............................................................
Initialized 21/21 Regions 0/0 Fields 27/27 Buffers 13/21 Packages (695 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:..
Executed 2 _INI methods requiring 1 _STA executions (examined 71 objects)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
Boot video device is 0000:01:00.0
PCI: Firmware left 0000:06:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) 
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *3
ACPI: PCI Interrupt Link [LNKG] (IRQs *10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
SCSI subsystem initialized
libata version 2.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: 90000000-afffffff
  PREFETCH window: c0000000-cfffffff
PCI: Bus 7, cardbus bridge: 0000:06:05.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 34000000-37ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: b0000000-b00fffff
  PREFETCH window: 30000000-33ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 21 (level, low) -> IRQ 17
Simple Boot Flag at 0x36 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: MATSHITAUJ-832D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
st: Version 20061107, fixed bufsize 32768, s/g segs 256
SCSI Media Changer driver v0.25 
ahci_init_one: ENTER
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 18
ahci 0000:00:1f.2: PORTS_IMPL is zero, forcing 0xf
ahci_host_init: cap 0xc6127f03  port_map 0x5  n_ports 4
ahci_setup_port: ENTER, base==0xe081a400, port_idx 0
ahci_setup_port: base now==0xe081a500
ahci_setup_port: EXIT
ahci_setup_port: ENTER, base==0xe081a400, port_idx 1
ahci_setup_port: base now==0xe081a580
ahci_setup_port: EXIT
ahci_setup_port: ENTER, base==0xe081a400, port_idx 2
ahci_setup_port: base now==0xe081a600
ahci_setup_port: EXIT
ahci_setup_port: ENTER, base==0xe081a400, port_idx 3
ahci_setup_port: base now==0xe081a680
ahci_setup_port: EXIT
ahci_init_controller: PORT_SCR_ERR 0x4050000
ahci_init_controller: PORT_IRQ_STAT 0x0
ahci_init_controller: PORT_SCR_ERR 0x0
ahci_init_controller: PORT_IRQ_STAT 0x0
ahci_init_controller: PORT_SCR_ERR 0x0
ahci_init_controller: PORT_IRQ_STAT 0x0
ahci_init_controller: PORT_SCR_ERR 0x0
ahci_init_controller: PORT_IRQ_STAT 0x0
ahci_init_controller: HOST_CTL 0x80000000
ahci_init_controller: HOST_CTL 0x80000002
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part 
ata_device_add: ENTER
ata_port_add: ENTER
ata1: SATA max UDMA/133 cmd 0xE081A500 ctl 0x0 bmdma 0x0 irq 18
__ata_port_freeze: ata1 port frozen
ata_port_add: ENTER
ata2: SATA max UDMA/133 cmd 0xE081A580 ctl 0x0 bmdma 0x0 irq 18
__ata_port_freeze: ata2 port frozen
ata_port_add: ENTER
ata3: SATA max UDMA/133 cmd 0xE081A600 ctl 0x0 bmdma 0x0 irq 18
__ata_port_freeze: ata3 port frozen
ata_port_add: ENTER
ata4: SATA max UDMA/133 cmd 0xE081A680 ctl 0x0 bmdma 0x0 irq 18
__ata_port_freeze: ata4 port frozen
ata_device_add: probe begin
scsi0 : ahci
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ahci_softreset: ENTER
ata_dev_classify: found ATA device by sig
ahci_softreset: EXIT, class=1
ata_std_postreset: ENTER
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1.00: ata_dev_read_id: ENTER, host 1, dev 0
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: ENTER, host 1, dev 0
ata1.00: ata_dev_configure: cfg 49:2f00 82:346b 83:7f09 84:6063 85:3469 
86:bf09 87:6063 88:203f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f  
ata_dump_id: 80==0x00f8  81==0x0021  82==0x346b  83==0x7f09  84==0x6063  
ata_dump_id: 88==0x203f  93==0x0000
ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: ata_dev_configure: EXIT, drv_stat = 0x50
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_dev_set_xfermode: set features - xfer mode
ahci_interrupt: ENTER
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata_dev_set_xfermode: EXIT, err_mask=0
ata1.00: ata_dev_read_id: ENTER, host 1, dev 0
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: ENTER, host 1, dev 0
ata1.00: ata_dev_configure: cfg 49:2f00 82:346b 83:7f09 84:6063 85:3469 
86:bf09 87:6063 88:203f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f  
ata_dump_id: 80==0x00f8  81==0x0021  82==0x346b  83==0x7f09  84==0x6063  
ata_dump_id: 88==0x203f  93==0x0000
ata1.00: ata_dev_configure: EXIT, drv_stat = 0x50
ata_dev_set_mode: xfer_shift=12, xfer_mode=0x45
ata1.00: configured for UDMA/100
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
scsi1 : ahci
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata2: ata_port_flush_task: flush #2
ata2: ata_port_flush_task: EXIT
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata2 port frozen
ahci_softreset: ENTER
ahci_softreset: PHY reports no device
ata_std_postreset: ENTER
ata2: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT, no device
ata_eh_thaw_port: ata2 port thawed
ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
scsi2 : ahci
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata3: ata_port_flush_task: flush #2
ata3: ata_port_flush_task: EXIT
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata3 port frozen
ahci_softreset: ENTER
ahci_softreset: PHY reports no device
ata_std_postreset: ENTER
ata3: SATA link down (SStatus 0 SControl 300)
ata_std_postreset: EXIT, no device
ata_eh_thaw_port: ata3 port thawed
ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
scsi3 : ahci
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata4: ata_port_flush_task: flush #2
ata4: ata_port_flush_task: EXIT
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata4 port frozen
ahci_softreset: ENTER
ahci_softreset: PHY reports no device
ata_std_postreset: ENTER
ata4: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT, no device
ata_eh_thaw_port: ata4 port thawed
ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_device_add: host probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 cc
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 cc
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2080B 0000 PQ: 0 ANSI: 5
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 cc
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
 sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata_device_add: EXIT, returning 4
piix_init: pci_register_driver
piix_init: done
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 41 00 00 02
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 3f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 47 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 57 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 6f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 10 97 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 10 6f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 74 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 74 10 5f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 02 b4 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 02 b4 10 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 30 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 30 10 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 30 02 b7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c1 07 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 10 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 02 27 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 02 3f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 3a 1f 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c1 67 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c5 8f 00 00 90
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 18 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 18 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 3a 4f 00 00 38
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 7 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 7 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 3a 87 00 00 58
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 11 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 11 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 3a 3f 00 00 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 2 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 2 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 10 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c1 27 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c1 2f 00 00 38
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 7 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c1 6f 00 00 a0
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 20 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 7 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 20 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 05 1f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 62 80 5f 00 00 28
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 5 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 62 81 57 00 00 40
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 8 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 5 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 8 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 62 81 97 00 00 a0
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 20 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 20 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 02 17 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 6a 57 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 6a 77 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 6a 7f 00 00 40
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 8 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 8 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 6a bf 00 02 18
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 67 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 67 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 62 82 37 00 00 38
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 7 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 7 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 3c 37 00 00 18
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 3 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 3 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 79 57 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 79 77 00 00 28
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 5 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2e 57 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 5 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2e 77 00 04 00
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 128 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 32 77 00 02 a0
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 84 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 37 3f 00 02 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 66 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 128 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 84 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 66 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c4 b7 00 00 d8
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 27 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 27 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 e0 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 e0 10 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 74 10 6f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c2 f7 00 01 00
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 32 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 32 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c3 f7 00 00 b0
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 22 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 22 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c2 0f 00 00 c8
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 25 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 25 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 06 c7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 00 67 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 82 2f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 02 1f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 02 37 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2e 17 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2e 37 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 72 f7 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 73 17 00 00 18
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 3 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 1e 67 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 3 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2a f7 00 00 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 2 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 2 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2b 07 00 00 30
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 6 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 6 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 78 87 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1d 78 a7 00 00 28
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 5 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 5 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1c 02 2f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2d cf 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 2d ef 00 00 28
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 5 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 5 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 01 ff 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 62 c0 d7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c2 d7 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 01 b7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 31 5f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 31 97 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 31 9f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 44 03 37 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 46 40 6f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 00 af 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 12 df 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 31 c4 a7 00 00 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 2 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 2 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b0 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b0 10 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 d4 01 e7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 d4 c1 27 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 d4 01 ef 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 d4 c1 7f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 d4 c1 87 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b0 00 7f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b0 1f ef 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 3b 8f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b0 00 77 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b0 19 a7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b2 48 37 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b4 f1 0f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b4 f9 97 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 05 0f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 09 3f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 09 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 11 a7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 22 9f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b5 3f 27 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b8 76 37 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 b9 9e 5f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c1 d7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c1 e7 00 00 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 2 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c1 ff 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 2 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 07 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 17 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 27 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 57 00 00 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 2 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 2 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 67 00 00 18
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 3 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 3 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 29 67 00 00 20
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 4 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 29 87 00 00 18
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 3 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 3 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 1e 29 9f 00 00 18
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 3 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 3 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 01 cf 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 61 03 a7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 01 c7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 62 c0 3f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 00 3f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
EXT3 FS on sda1, internal journal
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 00 47 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 06 a7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 60 00 3f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 10 97 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 04 60 aa 87 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 10 9f 00 00 48
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 9 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 9 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 10 e7 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 04 32 c2 bf 00 00 10
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 2 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 2 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 84 00 47 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 84 00 4f 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT


00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express 
Processor to DRAM Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 81b7
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root 
Port (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 90000000-afffffff
	Prefetchable memory behind bridge: c0000000-cfffffff
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
High Definition Audio Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 81cc
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0, IRQ 217
	I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0, IRQ 225
	I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at 1840 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0, IRQ 217
	I/O ports at 1860 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0, IRQ 209
	Memory at 80004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3) 
(prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=0a, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b0000000-b00fffff
	Prefetchable memory behind bridge: 0000000030000000-0000000031f00000
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge 
(rev 03)
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: bus master, medium devsel, latency 0, IRQ 201
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1880 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 
03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Sony Corporation Unknown device 81ba
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 201
	I/O ports at 18c0 [size=8]
	I/O ports at 18b8 [size=4]
	I/O ports at 18b0 [size=8]
	I/O ports at 1894 [size=4]
	I/O ports at 18a0 [size=16]
	Memory at 80004400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 03)
	Subsystem: Sony Corporation Unknown device 81b9
	Flags: medium devsel
	I/O ports at 18e0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce Go 6200 
TurboCache] (rev a1) (prog-if 00 [VGA])
	Subsystem: Sony Corporation Unknown device 81eb
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at a0000000 (32-bit, non-prefetchable) [size=16M]
	Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at 91000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

06:05.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
	Subsystem: Sony Corporation Unknown device 818f
	Flags: bus master, medium devsel, latency 168, IRQ 177
	Memory at b0008000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 32000000-33fff000
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	16-bit legacy interface ports at 0001

06:05.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI 
Two-Port PHY/Link-Layer Controller (prog-if 10 [OHCI])
	Subsystem: Sony Corporation Unknown device 818f
	Flags: bus master, medium devsel, latency 32, IRQ 233
	Memory at b0004000 (32-bit, non-prefetchable) [size=2K]
	Memory at b0000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

06:05.3 Mass storage controller: Texas Instruments PCI7420/7620 Combo CardBus, 
1394a-2000 OHCI and SD/MS-Pro Controller
	Subsystem: Sony Corporation Unknown device 8190
	Flags: bus master, medium devsel, latency 57, IRQ 10
	Memory at b0005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

06:08.0 Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100 VE 
(LOM) Ethernet Controller Mobile (rev 03)
	Subsystem: Sony Corporation Unknown device 81d0
	Flags: bus master, medium devsel, latency 66, IRQ 233
	Memory at b0006000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 2000 [size=64]
	Capabilities: [dc] Power Management version 2

06:0b.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network 
Connection (rev 05)
	Subsystem: Intel Corporation Unknown device 2753
	Flags: bus master, medium devsel, latency 32, IRQ 50
	Memory at b0007000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

