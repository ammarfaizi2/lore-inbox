Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWDMVyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWDMVyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWDMVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:54:07 -0400
Received: from mga03.intel.com ([143.182.124.21]:20032 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964991AbWDMVyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:54:03 -0400
X-IronPort-AV: i="4.04,118,1144047600"; 
   d="scan'208"; a="22959290:sNHT88403630"
Date: Thu, 13 Apr 2006 14:53:58 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060413215358.GA15957@agluck-lia64.sc.intel.com>
References: <20060412232036.18862.84118.sendpatchset@skynet> <20060413095207.GA4047@skynet.ie> <20060413171942.GA15047@agluck-lia64.sc.intel.com> <20060413173008.GA19402@skynet.ie> <20060413174720.GA15183@agluck-lia64.sc.intel.com> <20060413191402.GA20606@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413191402.GA20606@skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 08:14:02PM +0100, Mel Gorman wrote:
> When you get around to it later, there is one case you may hit that Bob
> Picco encountered and fixed for me. It's where a "new" range is registered
> that is inside an existing area; e.g.
> 
> add_active_range:    0->10000
> add_active_range: 9800->10000
> 
> It ends up merging incorrectly and you end up with one region from
> 9800-10000. The fix is below. 

I applied that fix on top of all the others and re-built and booted
a "generic" kernel (using arch/ia64/defconfig) and a "sparse" kernel
(based on arch/ia64/configs/gensparse_defconfig).

Both booted just fine on my tiger, the memory amounts looked
a bit suspicious though ... as if you are reporting *all* the
memory in range for the zone, rather than the usable parts.

Diffing console log from the boot of a 2.6.17-rc1 generic
kernel against one with your patches the relevent bit is:

< On node 0 totalpages: 259873
<   DMA zone: 128931 pages, LIFO batch:7
<   Normal zone: 130942 pages, LIFO batch:7
---
> On node 0 totalpages: 262144
>   DMA zone: 131072 pages, LIFO batch:7
>   Normal zone: 131072 pages, LIFO batch:7

That's a very precise 4G total, split exactly 2G+2G between
DMA and normal zones.  Same thing for the sparse kernel
(though I didn't check what an unpatched kernel prints).

At the end I've put the console logs from a generic boot, a
generic boot with your patch, and finally a generic-sparse
boot with your patch.

-Tony


::::::::::::::
dmesg-gen
::::::::::::::
Linux version 2.6.17-rc1-generic-smp (aegl@linux-t10) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #1 SMP Thu Apr 13 14:28:18 PDT 2006
EFI v1.10 by INTEL: SALsystab=0x7fe54980 ACPI=0x7ff84000 ACPI 2.0=0x7ff83000 MPS=0x7ff82000 SMBIOS=0xf0000
booting generic kernel on platform dig
Early serial console at I/O port 0x2f8 (options '115200')
ACPI: RSDP (v002 INTEL                                 ) @ 0x000000007ff83000
ACPI: XSDT (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83090
ACPI: FADT (v003 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83138
ACPI: MADT (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83230
ACPI: DSDT (v001  Intel SR870BN4 0x00000000 MSFT 0x0100000d) @ 0x0000000000000000
Initial ramdisk at: 0xe0000001fedf7000 (1303563 bytes)
SAL 3.20: Intel Corp                       SR870BN4                         version 3.0
SAL Platform features: BusLock IRQ_Redirection
SAL: AP wakeup using external interrupt vector 0xf0
No logical to physical processor mapping available
iosapic_system_init: Disabling PC-AT compatible 8259 interrupts
ACPI: Local APIC address c0000000fee00000
PLATFORM int CPEI (0x3): GSI 22 (level, low) -> CPU 0 (0xc618) vector 30
register_intr: changing vector 39 from IO-SAPIC-edge to IO-SAPIC-level
4 CPUs available, 4 CPUs total
MCA related initialization done
Virtual mem_map starts at 0xa0007ffffe400000
On node 0 totalpages: 259873
  DMA zone: 128931 pages, LIFO batch:7
  Normal zone: 130942 pages, LIFO batch:7
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-generic-smp.gz  root=LABEL=/ console=uart,io,0x2f8 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
CPU 0: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.255MHz
Console: colour VGA+ 80x25
Placing software IO TLB between 0x4c00000 - 0x8c00000
Memory: 4011344k/4157968k available (6923k code, 160256k reserved, 3388k data, 384k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0xc618
Fixed BSP b0 value from CPU 1
CPU 1: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 1: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.255MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
CPU 2: synchronized ITC with CPU 0 (last diff 10 cycles, maxerr 593 cycles)
CPU 2: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.255MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
CPU 3: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 3: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.255MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
Brought up 4 CPUs
Total of 4 processors activated (10158.08 BogoMIPS).
migration_cost=9899
checking if image is initramfs... it is
Freeing initrd memory: 1264kB freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0c00-0c7f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.H2PB._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.P2PB._PRT]
ACPI: PCI Root Bridge [PCI3] (0000:09)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3.P2PB._PRT]
ACPI: PCI Root Bridge [PCI4] (0000:0f)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4.P2PB._PRT]
ACPI: Device [CSFF] status [00000008]: functional but not present; setting present
ACPI: PCI Root Bridge [CSFF] (0000:ff)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
initcall at 0xa0000001007dc640: init_autofs4_fs+0x0/0x40(): returned with error code -16
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
EFI Time Services Driver v0.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 44) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 45) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
Copyright (c) 1999-2005 Intel Corporation.
GSI 18 (level, low) -> CPU 0 (0xc618) vector 48
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 48
e1000: 0000:01:00.0: e1000_probe: (PCI:33MHz:32-bit) 00:03:47:fd:bb:42
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
netconsole: not configured, aborting
initcall at 0xa0000001007dfe60: init_netconsole+0x0/0x140(): returned with error code -22
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Device 0000:00:1f.1 not available because of resource collisions
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
ICH4: BIOS configuration fixed.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
hdb: LS-120/240 00 UHD Floppy, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 34
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
hdb: No disk in drive
hdb: 234752kB, 262/32/56 CHS, 2995 kBps, 512 sector size, 1500 rpm
libata version 1.20 loaded.
Fusion MPT base driver 3.03.08
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.08
GSI 28 (level, low) -> CPU 1 (0xc218) vector 49
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 28 (level, low) -> IRQ 49
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=49
  Vendor: QUANTUM   Model: ATLAS IV 9 SCA    Rev: 0B0B
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:0: Beginning Domain Validation
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
sda: Write Protect is off
sda: Mode Sense: e3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
sda: Write Protect is off
sda: Mode Sense: e3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
  Vendor: SEAGATE   Model: ST318406LC        Rev: 010A
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:1: Beginning Domain Validation
 target0:0:1: Ending Domain Validation
 target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: 9f 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: 9f 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: Attached scsi disk sdb
  Vendor: ESG-SHV   Model: SCA HSBP M17      Rev: 1.0D
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:6: Beginning Domain Validation
 target0:0:6: Ending Domain Validation
 target0:0:6: asynchronous
GSI 29 (level, low) -> CPU 2 (0xc418) vector 50
ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 29 (level, low) -> IRQ 50
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
scsi1 : ioc1: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=50
mice: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 6, 1048576 bytes)
TCP established hash table entries: 524288 (order: 9, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Adding console on ttyS1 at I/O port 0x2f8 (options '115200')
Freeing unused kernel memory: 384kB freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
 0:0:6:0: Attached scsi generic sg2 type 3
usbcore: registered new driver usbfs
usbcore: registered new driver hub
GSI 23 (level, low) -> CPU 3 (0xc018) vector 51
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 51
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: slot 0000:00:1d.7 has incorrect PCI cache line size of 0 bytes, correcting to 128
ehci_hcd 0000:00:1d.7: irq 51, io mem 0xf9ff0000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
GSI 16 (level, low) -> CPU 0 (0xc618) vector 52
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 52
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 52, io base 0x00004cc0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 19 (level, low) -> CPU 1 (0xc218) vector 53
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 53
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 53, io base 0x00004ce0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: SOLIDTEK USB Composite Keyboard as /class/input/input0
input: USB HID v1.10 Keyboard [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: SOLIDTEK USB Composite Keyboard as /class/input/input1
input: USB HID v1.10 Device [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: HID 04b3:310b as /class/input/input2
input: USB HID v1.00 Mouse [HID 04b3:310b] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ACPI: Power Button (FF) [PWRF]
EXT3 FS on sda2, internal journal
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
hdb: No disk in drive
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1700816k swap on /dev/sda3.  Priority:-1 extents:1 across:1700816k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
::::::::::::::
dmesg-mel-generic
::::::::::::::
Linux version 2.6.17-rc1-generic-smp (aegl@linux-t10) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #1 SMP Thu Apr 13 13:43:50 PDT 2006
EFI v1.10 by INTEL: SALsystab=0x7fe54980 ACPI=0x7ff84000 ACPI 2.0=0x7ff83000 MPS=0x7ff82000 SMBIOS=0xf0000
booting generic kernel on platform dig
Early serial console at I/O port 0x2f8 (options '115200')
ACPI: RSDP (v002 INTEL                                 ) @ 0x000000007ff83000
ACPI: XSDT (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83090
ACPI: FADT (v003 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83138
ACPI: MADT (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83230
ACPI: DSDT (v001  Intel SR870BN4 0x00000000 MSFT 0x0100000d) @ 0x0000000000000000
Initial ramdisk at: 0xe0000001fedf7000 (1303561 bytes)
SAL 3.20: Intel Corp                       SR870BN4                         version 3.0
SAL Platform features: BusLock IRQ_Redirection
SAL: AP wakeup using external interrupt vector 0xf0
No logical to physical processor mapping available
iosapic_system_init: Disabling PC-AT compatible 8259 interrupts
ACPI: Local APIC address c0000000fee00000
PLATFORM int CPEI (0x3): GSI 22 (level, low) -> CPU 0 (0xc618) vector 30
register_intr: changing vector 39 from IO-SAPIC-edge to IO-SAPIC-level
4 CPUs available, 4 CPUs total
MCA related initialization done
add_active_range(0, 0, 4096): New
add_active_range(0, 0, 131072): Merging forward
add_active_range(0, 0, 131072): Existing
add_active_range(0, 393216, 523264): New
add_active_range(0, 393216, 523264): Existing
add_active_range(0, 393216, 524288): Merging forward
add_active_range(0, 393216, 524288): Existing
Virtual mem_map starts at 0xa0007ffffe400000
free_area_init_nodes(262144, 262144, 524288, 524288)
free_area_init_nodes(): find_min_pfn = 0
Dumping sorted node map
entry 0: 0  0 -> 131072
entry 1: 0  393216 -> 524288
Hole found index 1: 131072 -> 262144
Hole found index 1: 262144 -> 393216
On node 0 totalpages: 262144
Hole found index 1: 131072 -> 262144
  DMA zone: 131072 pages, LIFO batch:7
Hole found index 1: 262144 -> 393216
  Normal zone: 131072 pages, LIFO batch:7
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-generic-smp.gz  root=LABEL=/ console=uart,io,0x2f8 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
CPU 0: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.254MHz
Console: colour VGA+ 80x25
Placing software IO TLB between 0x4c00000 - 0x8c00000
Memory: 4011344k/4157968k available (6923k code, 160256k reserved, 3388k data, 400k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0xc618
Fixed BSP b0 value from CPU 1
CPU 1: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 1: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.254MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
CPU 2: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 2: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.254MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
CPU 3: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 3: base freq=199.441MHz, ITC ratio=17/2, ITC freq=1695.254MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
Brought up 4 CPUs
Total of 4 processors activated (10158.08 BogoMIPS).
migration_cost=9881
checking if image is initramfs... it is
Freeing initrd memory: 1264kB freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0c00-0c7f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.H2PB._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.P2PB._PRT]
ACPI: PCI Root Bridge [PCI3] (0000:09)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3.P2PB._PRT]
ACPI: PCI Root Bridge [PCI4] (0000:0f)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4.P2PB._PRT]
ACPI: Device [CSFF] status [00000008]: functional but not present; setting present
ACPI: PCI Root Bridge [CSFF] (0000:ff)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
initcall at 0xa0000001007dd660: init_autofs4_fs+0x0/0x40(): returned with error code -16
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
EFI Time Services Driver v0.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 44) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 45) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
Copyright (c) 1999-2005 Intel Corporation.
GSI 18 (level, low) -> CPU 0 (0xc618) vector 48
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 48
e1000: 0000:01:00.0: e1000_probe: (PCI:33MHz:32-bit) 00:03:47:fd:bb:42
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
netconsole: not configured, aborting
initcall at 0xa0000001007e0e70: init_netconsole+0x0/0x140(): returned with error code -22
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Device 0000:00:1f.1 not available because of resource collisions
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
ICH4: BIOS configuration fixed.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
hdb: LS-120/240 00 UHD Floppy, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 34
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
hdb: No disk in drive
hdb: 234752kB, 262/32/56 CHS, 2995 kBps, 512 sector size, 1500 rpm
libata version 1.20 loaded.
Fusion MPT base driver 3.03.08
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.08
GSI 28 (level, low) -> CPU 1 (0xc018) vector 49
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 28 (level, low) -> IRQ 49
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=49
  Vendor: QUANTUM   Model: ATLAS IV 9 SCA    Rev: 0B0B
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:0: Beginning Domain Validation
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
sda: Write Protect is off
sda: Mode Sense: e3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
sda: Write Protect is off
sda: Mode Sense: e3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
  Vendor: SEAGATE   Model: ST318406LC        Rev: 010A
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:1: Beginning Domain Validation
 target0:0:1: Ending Domain Validation
 target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: 9f 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: 9f 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: Attached scsi disk sdb
  Vendor: ESG-SHV   Model: SCA HSBP M17      Rev: 1.0D
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:6: Beginning Domain Validation
 target0:0:6: Ending Domain Validation
 target0:0:6: asynchronous
GSI 29 (level, low) -> CPU 2 (0xc218) vector 50
ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 29 (level, low) -> IRQ 50
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
scsi1 : ioc1: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=50
mice: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 6, 1048576 bytes)
TCP established hash table entries: 524288 (order: 9, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Adding console on ttyS1 at I/O port 0x2f8 (options '115200')
Freeing unused kernel memory: 400kB freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
 0:0:6:0: Attached scsi generic sg2 type 3
usbcore: registered new driver usbfs
usbcore: registered new driver hub
GSI 23 (level, low) -> CPU 3 (0xc418) vector 51
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 51
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: slot 0000:00:1d.7 has incorrect PCI cache line size of 0 bytes, correcting to 128
ehci_hcd 0000:00:1d.7: irq 51, io mem 0xf9ff0000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
GSI 16 (level, low) -> CPU 0 (0xc618) vector 52
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 52
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 52, io base 0x00004cc0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 19 (level, low) -> CPU 1 (0xc018) vector 53
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 53
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 53, io base 0x00004ce0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
ACPI: Power Button (FF) [PWRF]
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: SOLIDTEK USB Composite Keyboard as /class/input/input0
input: USB HID v1.10 Keyboard [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: SOLIDTEK USB Composite Keyboard as /class/input/input1
input: USB HID v1.10 Device [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: HID 04b3:310b as /class/input/input2
input: USB HID v1.00 Mouse [HID 04b3:310b] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
EXT3 FS on sda2, internal journal
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
hdb: No disk in drive
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1700816k swap on /dev/sda3.  Priority:-1 extents:1 across:1700816k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
::::::::::::::
dmesg-mel-gensparse
::::::::::::::
Linux version 2.6.17-rc1-generic-sparse (aegl@linux-t10) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #1 SMP Thu Apr 13 13:48:09 PDT 2006
EFI v1.10 by INTEL: SALsystab=0x7fe54980 ACPI=0x7ff84000 ACPI 2.0=0x7ff83000 MPS=0x7ff82000 SMBIOS=0xf0000
booting generic kernel on platform dig
Early serial console at I/O port 0x2f8 (options '115200')
ACPI: RSDP (v002 INTEL                                 ) @ 0x000000007ff83000
ACPI: XSDT (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83090
ACPI: FADT (v003 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83138
ACPI: MADT (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x000000007ff83230
ACPI: DSDT (v001  Intel SR870BN4 0x00000000 MSFT 0x0100000d) @ 0x0000000000000000
Initial ramdisk at: 0xe0000001fedf7000 (1303578 bytes)
SAL 3.20: Intel Corp                       SR870BN4                         version 3.0
SAL Platform features: BusLock IRQ_Redirection
SAL: AP wakeup using external interrupt vector 0xf0
No logical to physical processor mapping available
iosapic_system_init: Disabling PC-AT compatible 8259 interrupts
ACPI: Local APIC address c0000000fee00000
PLATFORM int CPEI (0x3): GSI 22 (level, low) -> CPU 0 (0xc618) vector 30
register_intr: changing vector 39 from IO-SAPIC-edge to IO-SAPIC-level
4 CPUs available, 4 CPUs total
MCA related initialization done
add_active_range(0, 0, 4096): New
add_active_range(0, 0, 131072): Merging forward
add_active_range(0, 0, 131072): Existing
add_active_range(0, 393216, 523264): New
add_active_range(0, 393216, 523264): Existing
add_active_range(0, 393216, 524288): Merging forward
add_active_range(0, 393216, 524288): Existing
free_area_init_nodes(262144, 262144, 524288, 524288)
free_area_init_nodes(): find_min_pfn = 0
Dumping sorted node map
entry 0: 0  0 -> 131072
entry 1: 0  393216 -> 524288
Hole found index 1: 131072 -> 262144
Hole found index 1: 262144 -> 393216
On node 0 totalpages: 262144
Hole found index 1: 131072 -> 262144
  DMA zone: 131072 pages, LIFO batch:7
Hole found index 1: 262144 -> 393216
  Normal zone: 131072 pages, LIFO batch:7
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-generic-sparse.gz  root=LABEL=/ console=uart,io,0x2f8 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
CPU 0: base freq=199.442MHz, ITC ratio=17/2, ITC freq=1695.257MHz
Console: colour VGA+ 80x25
Placing software IO TLB between 0x4c14000 - 0x8c14000
Memory: 4011232k/4157888k available (6984k code, 160368k reserved, 3394k data, 400k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0xc618
Fixed BSP b0 value from CPU 1
CPU 1: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 1: base freq=199.442MHz, ITC ratio=17/2, ITC freq=1695.257MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
CPU 2: synchronized ITC with CPU 0 (last diff 10 cycles, maxerr 593 cycles)
CPU 2: base freq=199.442MHz, ITC ratio=17/2, ITC freq=1695.257MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
CPU 3: synchronized ITC with CPU 0 (last diff -10 cycles, maxerr 611 cycles)
CPU 3: base freq=199.442MHz, ITC ratio=17/2, ITC freq=1695.257MHz
Calibrating delay loop... 2539.52 BogoMIPS (lpj=5079040)
Brought up 4 CPUs
Total of 4 processors activated (10158.08 BogoMIPS).
migration_cost=9992
checking if image is initramfs... it is
Freeing initrd memory: 1264kB freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0c00-0c7f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.H2PB._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.P2PB._PRT]
ACPI: PCI Root Bridge [PCI3] (0000:09)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3.P2PB._PRT]
ACPI: PCI Root Bridge [PCI4] (0000:0f)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4.P2PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4.P2PB._PRT]
ACPI: Device [CSFF] status [00000008]: functional but not present; setting present
ACPI: PCI Root Bridge [CSFF] (0000:ff)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
initcall at 0xa0000001007ed860: init_autofs4_fs+0x0/0x40(): returned with error code -16
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
EFI Time Services Driver v0.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 44) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 45) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
Copyright (c) 1999-2005 Intel Corporation.
GSI 18 (level, low) -> CPU 0 (0xc618) vector 48
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 48
e1000: 0000:01:00.0: e1000_probe: (PCI:33MHz:32-bit) 00:03:47:fd:bb:42
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
netconsole: not configured, aborting
initcall at 0xa0000001007edaf0: init_netconsole+0x0/0x140(): returned with error code -22
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Device 0000:00:1f.1 not available because of resource collisions
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
ICH4: BIOS configuration fixed.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
hdb: LS-120/240 00 UHD Floppy, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 34
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
hdb: No disk in drive
hdb: 234752kB, 262/32/56 CHS, 2995 kBps, 512 sector size, 1500 rpm
libata version 1.20 loaded.
Fusion MPT base driver 3.03.08
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.08
GSI 28 (level, low) -> CPU 1 (0xc018) vector 49
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 28 (level, low) -> IRQ 49
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=49
  Vendor: QUANTUM   Model: ATLAS IV 9 SCA    Rev: 0B0B
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:0: Beginning Domain Validation
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
sda: Write Protect is off
sda: Mode Sense: e3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
sda: Write Protect is off
sda: Mode Sense: e3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
  Vendor: SEAGATE   Model: ST318406LC        Rev: 010A
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:1: Beginning Domain Validation
 target0:0:1: Ending Domain Validation
 target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: 9f 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: Write Protect is off
sdb: Mode Sense: 9f 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: Attached scsi disk sdb
  Vendor: ESG-SHV   Model: SCA HSBP M17      Rev: 1.0D
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:6: Beginning Domain Validation
 target0:0:6: Ending Domain Validation
 target0:0:6: asynchronous
GSI 29 (level, low) -> CPU 2 (0xc218) vector 50
ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 29 (level, low) -> IRQ 50
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
scsi1 : ioc1: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=50
mice: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 6, 1048576 bytes)
TCP established hash table entries: 524288 (order: 9, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Adding console on ttyS1 at I/O port 0x2f8 (options '115200')
Freeing unused kernel memory: 400kB freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
 0:0:6:0: Attached scsi generic sg2 type 3
usbcore: registered new driver usbfs
usbcore: registered new driver hub
GSI 23 (level, low) -> CPU 3 (0xc418) vector 51
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 51
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: slot 0000:00:1d.7 has incorrect PCI cache line size of 0 bytes, correcting to 128
ehci_hcd 0000:00:1d.7: irq 51, io mem 0xf9ff0000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
GSI 16 (level, low) -> CPU 0 (0xc618) vector 52
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 52
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 52, io base 0x00004cc0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 19 (level, low) -> CPU 1 (0xc018) vector 53
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 53
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 53, io base 0x00004ce0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
ACPI: Power Button (FF) [PWRF]
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: SOLIDTEK USB Composite Keyboard as /class/input/input0
input: USB HID v1.10 Keyboard [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: SOLIDTEK USB Composite Keyboard as /class/input/input1
input: USB HID v1.10 Device [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: HID 04b3:310b as /class/input/input2
input: USB HID v1.00 Mouse [HID 04b3:310b] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
EXT3 FS on sda2, internal journal
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
hdb: No disk in drive
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1700816k swap on /dev/sda3.  Priority:-1 extents:1 across:1700816k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
