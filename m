Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262936AbSJGIxP>; Mon, 7 Oct 2002 04:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262938AbSJGIxP>; Mon, 7 Oct 2002 04:53:15 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:55052 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S262936AbSJGIxJ>; Mon, 7 Oct 2002 04:53:09 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: mremap() pte allocation atomicity error (2.5.40 too)
Date: Mon, 7 Oct 2002 08:58:17 +0000 (UTC)
Organization: Cistron
Message-ID: <anrib9$mg5$1@ncc1701.cistron.net>
References: <20020928052813.GY22942@holomorphy.com> <3D95442E.C0959F4A@digeo.com> <20020928060450.GW3530@holomorphy.com> <3D9547BC.432C018@digeo.com>
Reply-To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1033981097 23045 62.216.29.67 (7 Oct 2002 08:58:17 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D9547BC.432C018@digeo.com>,
Andrew Morton  <akpm@digeo.com> wrote:
>William Lee Irwin III wrote:
>> 
>> On Fri, Sep 27, 2002 at 10:54:54PM -0700, Andrew Morton wrote:
>> > A simple fix would be to drop the atomic kmap of the source pte
>> > and take it again after the alloc_one_pte_map() call.
>> > Can you think of a more efficient way?
>> 
>OK.   kmap_atomics are pretty darn quick, but it might be better
>to take a peek to see if the pgd and pmd are present, and only
>drop the kmap if not.
>
>Care to eyeball this?  I haven't tested it yet.
>
> mm/mremap.c |   25 +++++++++++++++++++++++++
> 1 files changed, 25 insertions(+)

I see this got into 2.5.40, but I see a similar problem here:

Debug: sleeping function called from illegal context at page_alloc.c:325
f75a3ea8 c0116234 c0275640 c027aba7 00000145 00000000 c0136100 c027aba7 
       00000145 f75a2000 da7b6658 f766f8a0 00000000 f75a3f64 00000000 000001d0 
       00000000 c0112631 f75a2000 da7b6658 f766f8a0 56d25000 c01292da f766f8a0 
Call Trace:
 [<c0116234>]__might_sleep+0x54/0x58
 [<c0136100>]__alloc_pages+0x24/0x224
 [<c0112631>]pte_alloc_one+0x21/0xbc
 [<c01292da>]pte_alloc_map+0x3a/0x138
 [<c0130e78>]move_one_page+0x118/0x1c0
 [<c0130f4d>]move_page_tables+0x2d/0x74
 [<c0131575>]do_mremap+0x5e1/0x774
 [<c013175b>]sys_mremap+0x53/0x74
 [<c01071ff>]syscall_call+0x7/0xb


I saw a few more during boot, all originated from kernel_thread_helper,
not sure if they have been reported already so I'll just include
the bootup log here:

Loading 2.5.40........................
Linux version 2.5.40 (root@wormhole) (gcc version 2.95.4 20011006 (Debian prerelease)) #3 SMP Sun Oct 6 17:26:15 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb460
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 262144
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 32768 pages
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at: 0xFEE00000
Processor #0 6:7 APIC version 17
Processor #1 6:7 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.5.40 root=801 ioapic_level=9,10,15 rootfstype=ext2 panic=30 console=tty0 console=ttyS0,9600n8
IO-APIC-level enabling for IRQ9 IRQ10 IRQ15
Initializing CPU#0
Detected 449.246 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 884.73 BogoMIPS
Memory: 1033200k/1048576k available (1448k kernel code, 14988k reserved, 749k data, 108k init, 131072k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU0: Intel Pentium III (Katmai) stepping 02
per-CPU timeslice cutoff: 1461.26 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 897.02 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU1: Intel Pentium III (Katmai) stepping 02
Total of 2 processors activated (1781.76 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
, 2-11<7>Forcing IRQ15 to level
, 2-16, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 449.0186 MHz.
..... host bus clock speed is 99.0818 MHz.
cpu: 0, clocks: 99818, slice: 3024
CPU0<T0:99808,T1:96784,D:0,S:3024,C:99818>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 99818, slice: 3024
CPU1<T0:99808,T1:93760,D:0,S:3024,C:99818>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Debug: sleeping function called from illegal context at sched.c:1166
c1b6bf18 c0116234 c0275640 c02754c2 0000048e c1b6bf78 c011499b c02754c2 
       0000048e 00000000 c1b6a000 c034a4a0 c1b6bf64 c1b6bfa4 c1b70000 c1b6bf64 
       c034a4a0 00000001 00000001 00000286 c1b6bf78 c01139ab c1b6f040 00000000 
Call Trace:
 [<c0116234>]__might_sleep+0x54/0x58
 [<c011499b>]wait_for_completion+0x1b/0x114
 [<c01139ab>]wake_up_process+0xb/0x10
 [<c0115e16>]set_cpus_allowed+0x14a/0x16c
 [<c0115e88>]migration_thread+0x50/0x33c
 [<c0115e38>]migration_thread+0x0/0x33c
 [<c0105501>]kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
c1b6bf00 c01143d1 c02754a0 c1b6a000 c1b6bf70 c1b6bf78 c1b6bf18 c0116234 
       c0275640 c02754c2 0000048e c1b6bf78 c1b6a000 c1b6bf78 c0114a35 00000000 
       c1b6a000 c034a4a0 c1b6a000 c1b6bfa4 00000000 c1b6e060 c01147dc 00000000 
Call Trace:
 [<c01143d1>]schedule+0x3d/0x404
 [<c0116234>]__might_sleep+0x54/0x58
 [<c0114a35>]wait_for_completion+0xb5/0x114
 [<c01147dc>]default_wake_function+0x0/0x34
 [<c01147dc>]default_wake_function+0x0/0x34
 [<c0115e16>]set_cpus_allowed+0x14a/0x16c
 [<c0115e88>]migration_thread+0x50/0x33c
 [<c0115e38>]migration_thread+0x0/0x33c
 [<c0105501>]kernel_thread_helper+0x5/0xc

CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfdac1, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20020918
ACPI: System description tables not found
    ACPI-0066: *** Error: Acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
    ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI->APIC IRQ transform: (B0,I16,P0) -> 17
PCI->APIC IRQ transform: (B2,I12,P0) -> 10
PCI->APIC IRQ transform: (B2,I12,P1) -> 15
PCI->APIC IRQ transform: (B2,I13,P0) -> 9
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 44
Journalled Block Device driver loaded
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
hda: CD-ROM 36X/AKW, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
c1b79e9c c0116234 c0275640 c0279fb7 0000055e 00000000 c0132dee c0279fb7 
       0000055e c03ee5f4 c03ee5bc f7d13d40 00000000 00000046 c01ce570 f7d17cf8 
       000001d0 c03ee5bc c03ee5ac f7d13d40 00000000 00000000 c01ce601 c03ee5bc 
Call Trace:
 [<c0116234>]__might_sleep+0x54/0x58
 [<c0132dee>]kmem_cache_alloc+0x22/0x18c
 [<c01ce570>]blk_init_free_list+0x4c/0xd0
 [<c01ce601>]blk_init_queue+0xd/0xe8
 [<c01d9c50>]ide_init_queue+0x28/0x68
 [<c01e0404>]do_ide_request+0x0/0x18
 [<c01d9f3d>]init_irq+0x2ad/0x374
 [<c01da2a6>]hwif_init+0x112/0x258
 [<c01d9b7c>]probe_hwif_init+0x1c/0x6c
 [<c01ea58d>]ide_setup_pci_device+0x3d/0x68
 [<c01d8c1f>]piix_init_one+0x37/0x40
 [<c01050ab>]init+0x47/0x1bc
 [<c0105064>]init+0x0/0x1bc
 [<c0105501>]kernel_thread_helper+0x5/0xc

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 36X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
sym.2.12.1: setting PCI_COMMAND_PARITY...
sym.2.12.0: setting PCI_COMMAND_PARITY...
sym0: <896> rev 0x1 on pci bus 2 device 12 function 1 irq 15
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <896> rev 0x1 on pci bus 2 device 12 function 0 irq 10
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
scsi1 : sym-2.1.16a
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0707
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 4.
  Vendor: SEAGATE   Model: ST118202LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST118202LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST118202LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST118202LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym1:0:0: tagged command queuing enabled, command queue depth 4.
sym1:1:0: tagged command queuing enabled, command queue depth 4.
sym1:2:0: tagged command queuing enabled, command queue depth 4.
sym1:3:0: tagged command queuing enabled, command queue depth 4.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 1, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 2, lun 0
Attached scsi disk sde at scsi1, channel 0, id 3, lun 0
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sym1:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 15)
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
sym1:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 15)
SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
 sdc: sdc1 sdc2 sdc3 sdc4
sym1:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 15)
SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
 sdd: sdd1 sdd2 sdd3 sdd4
sym1:3: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 15)
SCSI device sde: 35566480 512-byte hdwr sectors (18210 MB)
 sde: sde1 sde2 sde3 sde4
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   744.000 MB/sec
   32regs    :   572.000 MB/sec
   pIII_sse  :   880.000 MB/sec
   pII_mmx   :  1012.000 MB/sec
   p5_mmx    :  1036.000 MB/sec
raid5: using function: pIII_sse (880.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
802.1Q VLAN Support v1.7 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 108k freed
INIT: version 2.83 booting

