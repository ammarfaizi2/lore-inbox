Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWBWWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWBWWPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWBWWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:15:55 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:62066 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751791AbWBWWPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:15:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=LSmj0+5BtnxLmdXhN+yDlTH6M94OXqGe5juuRL5pB+NWANBnU+G5fdRo3ISMXvtQMyNQHiiMCTlQZhcXLk5WqU1wmjCqnzOJvfs/ef0/WEXSf9edip1gzOjQb1k0bp0uLVxmrPoDOyZRR6bD3uISlhhcC4MDFwl8efexBETDFm8=
Subject: Re: Kernel panic when compiling with SMP support
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602230134_MC3-1-B90B-65B0@compuserve.com>
References: <200602230134_MC3-1-B90B-65B0@compuserve.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 14:15:49 -0800
Message-Id: <1140732949.5733.13.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 01:30 -0500, Chuck Ebbert wrote: 
> In-Reply-To: <1140587779.5511.14.camel@shogun.daga.dyndns.org>
> 
> On Tue, 21 Feb 2006 at 21:56:19 -0800, Chris Largret wrote:
> > I have that path out to /sys/devices/system/cpu/cpuN/. I've tried
> > enabling several power options in the kernel config to get cpufreq/, but
> > still don't have it. Do you know which option it is off the top of your
> > head?
> 
> Is PowerNow loading?  I have:
> 
>  powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
>  powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
>  powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x16 (1000 mV)

Seems too have been. dmesg reported:

powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV) 

> Try:
> 
> CONFIG_CPU_FREQ=y
<snip>
> And if it doesn't work try enabling CONFIG_CPU_FREQ_DEBUG

That created cpu[01]/cpufreq/scaling_governor and several other pseudo-files. I'm trying that out now.

While tinkering with this the last couple days, I've started to notice
that the infamous OOM killer is running loose when I enable SMP. dmesg
is filled with messages like this (this is from the boot-up scripts and
I should have more than enough memory):


oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:44
cpu 0 cold: high 62, batch 15 used:6
cpu 1 hot: high 186, batch 31 used:179
cpu 1 cold: high 62, batch 15 used:2
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843224kB (0kB HighMem)
Active:10513 inactive:38896 dirty:43 writeback:0 unstable:0 free:710806
slab:4713 mapped:2155 pagetables:146
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843180kB min:7008kB low:8760kB high:10512kB active:42052kB
inactive:155584kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 971*4kB 546*8kB 247*16kB 68*32kB 28*64kB 0*128kB 1*256kB 1*512kB
0*1024kB 0*2048kB 690*4096kB = 2843180kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
10220 pages shared
0 pages swap cached
Out of Memory: Killed process 4885 (dbus-daemon).


----------------------------------------------------------------------
I'm sure that this is the cause of some of the Oopses. I'll post another
panic or two once I capture them. I feel like a n00b with kernel
hacking. Oh well, here's the full dmesg output:

Bootdata ok (command line is BOOT_IMAGE=Linux-Serial ro root=802
console=tty0 console=ttyS0,57600n8)
Linux version 2.6.16-rc4-daga (root@shogun) (gcc version 3.4.4) #7 SMP
Thu Feb 23 13:46:39 PST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @
0x00000000000f8f70
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @
0x00000000bfff7b80
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff7ac0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
On node 0 totalpages: 775557
  DMA zone: 3932 pages, LIFO batch:0
  DMA32 zone: 771625 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
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
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-Serial ro root=802 console=tty0
console=ttyS0,57600n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2210.801 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3075672k/3145664k available (2436k kernel code, 69372k reserved,
1281k data, 208k init)
Calibrating delay using timer specific routine.. 4426.25 BogoMIPS
(lpj=8852513)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Using local APIC timer interrupts.
result 12561392
Detected 12.561 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4421.83 BogoMIPS
(lpj=8843674)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 10 cycles, maxerr 591
cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
migration_cost=229
DMI 2.2 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:0b.0
  IO window: a000-afff
  MEM window: f9000000-faffffff
  PREFETCH window: e8000000-efffffff
PCI: Bridge: 0000:00:0e.0
  IO window: 9000-9fff
  MEM window: fb000000-fcffffff
  PREFETCH window: fdf00000-fdffffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xe8000000, mapped to 0xffffc20000100000, using
3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
fb1: VGA16 VGA frame buffer device
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin
is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: ST3160023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: max request size: 512KiB
hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63,
UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.20 loaded.
sata_nv 0000:00:09.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 23 (level,
high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xD000 irq 177
ata2: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xD008 irq 177
ata1: SATA link down (SStatus 0)
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level,
high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xB800 irq 185
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xB808 irq 185
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:7c6b 83:5b09 84:4063 85:7c69 86:1a01 87:4063
88:407f
ata3: dev 0 ATA-7, max UDMA/133, 195813072 sectors: LBA
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
  Vendor: ATA       Model: Maxtor 6L100M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 195813072 512-byte hdwr sectors (100256 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 195813072 512-byte hdwr sectors (100256 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
usbmon: debugfs is not available
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb 21 2006
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 288 bytes per
conntrack
input: AT Translated Set 2 keyboard as /class/input/input0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xe, vid 0xa
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
Write protecting the kernel read-only data: 439k
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1 across:498004k
Adding 979956k swap on /dev/sda1.  Priority:-2 extents:1 across:979956k
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 21 (level,
high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 193, io mem 0xfe02d000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: Using r5 hash to sort names
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level,
high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 201, io mem 0xfe02f000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 23 (level,
high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 177, io mem 0xfe02e000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usb 2-3: new full speed USB device using ohci_hcd and address 2
usb 2-3: configuration #1 chosen from 1 choice
usb 3-3: new low speed USB device using ohci_hcd and address 2
usb 3-3: configuration #1 chosen from 1 choice
input: USBPS2 as /class/input/input1
input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:02.1-3
input: USBPS2 as /class/input/input2
input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:02.1-3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0
alt 1 proto 2 vid 0x03F0 pid 0x1D17
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.49.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 22 (level,
high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
eth0: no link during initialization.
eth0: link up.
Linux video capture interface: v1.00
cx2388x v4l2 driver version 0.0.5 loaded
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 209
CORE cx88[0]: subsystem: 1002:00f8, board: ATI TV Wonder Pro
[card=4,autodetected]
TV tuner 44 at 0x1fe, Radio tuner -1 at 0x1fe
cx88[0]/0: found at 0000:02:07.0, rev: 5, irq: 209, latency: 32, mmio:
0xfb000000
tuner 2-0060: All bytes are equal. It is not a TEA5767
tuner 2-0060: chip found @ 0xc0 (cx88[0])
tuner 2-0060: type set to 44 (Philips 4 in 1 (ATI TV Wonder
Pro/Conexant))
tda9887 2-0043: chip found @ 0x86 (cx88[0])
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
set_control id=0x980900 reg=0x310110 val=0x00 (mask 0xff)
set_control id=0x980901 reg=0x310110 val=0x3f00 (mask 0xff00)
set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
set_control id=0x980902 reg=0x310114 val=0x5a7f (mask 0xffff)
set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
set_control id=0x980906 reg=0x320598 val=0x40 (mask 0x7f) [shadowed]
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [APC4] -> GSI 19 (level,
low) -> IRQ 217
gameport: EMU10K1 is pci0000:02:09.1/gameport0, io 0x9800, speed 1179kHz
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level,
low) -> IRQ 217
PCI: Via IRQ fixup for 0000:02:0c.0, from 10 to 9
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[217]
MMIO=[fcfff000-fcfff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
GSI 22 sharing vector 0xE1 and IRQ 22
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC5] -> GSI 16 (level,
low) -> IRQ 225
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffc200017ca000, 00:11:09:c2:7f:66, IRQ 225
r8169: eth1: link down
USB Universal Host Controller Interface driver v2.3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc000099e850]
ip_tables: (C) 2000-2006 Netfilter Core Team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:94
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:167
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2842964kB (0kB HighMem)
Active:10564 inactive:38867 dirty:42 writeback:0 unstable:0 free:710741
slab:4693 mapped:2241 pagetables:150
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2842920kB min:7008kB low:8760kB high:10512kB active:42256kB
inactive:155468kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1080*4kB 499*8kB 241*16kB 87*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2842920kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
10367 pages shared
0 pages swap cached
Out of Memory: Killed process 4842 (dbus-daemon).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:94
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:177
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843212kB (0kB HighMem)
Active:10521 inactive:38866 dirty:44 writeback:0 unstable:0 free:710803
slab:4679 mapped:2174 pagetables:143
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843168kB min:7008kB low:8760kB high:10512kB active:42084kB
inactive:155464kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1142*4kB 499*8kB 241*16kB 87*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2843168kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
10163 pages shared
0 pages swap cached
Out of Memory: Killed process 4256 (rpc.portmap).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:94
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:132
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843708kB (0kB HighMem)
Active:10449 inactive:38865 dirty:44 writeback:0 unstable:0 free:710927
slab:4679 mapped:2103 pagetables:136
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843664kB min:7008kB low:8760kB high:10512kB active:41796kB
inactive:155460kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1210*4kB 513*8kB 248*16kB 87*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2843664kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
10097 pages shared
0 pages swap cached
Out of Memory: Killed process 4858 (hald-addon-acpi).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:94
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:91
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843840kB (0kB HighMem)
Active:10464 inactive:38866 dirty:45 writeback:0 unstable:0 free:710960
slab:4680 mapped:2113 pagetables:134
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843796kB min:7008kB low:8760kB high:10512kB active:41856kB
inactive:155464kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1237*4kB 516*8kB 248*16kB 87*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2843796kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
10033 pages shared
0 pages swap cached
Out of Memory: Killed process 4877 (hald-addon-stor).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:94
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:127
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843848kB (0kB HighMem)
Active:10446 inactive:38866 dirty:46 writeback:0 unstable:0 free:710962
slab:4680 mapped:2099 pagetables:128
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843804kB min:7008kB low:8760kB high:10512kB active:41784kB
inactive:155464kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1237*4kB 517*8kB 248*16kB 87*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2843804kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
9915 pages shared
0 pages swap cached
Out of Memory: Killed process 4643 (atd).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:94
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:147
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843832kB (0kB HighMem)
Active:10428 inactive:38865 dirty:45 writeback:0 unstable:0 free:710958
slab:4680 mapped:2068 pagetables:127
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843788kB min:7008kB low:8760kB high:10512kB active:41712kB
inactive:155460kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1237*4kB 515*8kB 248*16kB 87*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2843788kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
9910 pages shared
0 pages swap cached
Out of Memory: Killed process 4851 (hald).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:165
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:166
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2845080kB (0kB HighMem)
Active:10163 inactive:38774 dirty:46 writeback:0 unstable:0 free:711270
slab:4680 mapped:1488 pagetables:106
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2845036kB min:7008kB low:8760kB high:10512kB active:40652kB
inactive:155096kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1339*4kB 556*8kB 266*16kB 94*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2845036kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
9344 pages shared
0 pages swap cached
Out of Memory: Killed process 4845 (S91hal).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:165
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:126
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2845096kB (0kB HighMem)
Active:10201 inactive:38775 dirty:46 writeback:0 unstable:0 free:711274
slab:4680 mapped:1537 pagetables:108
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2845052kB min:7008kB low:8760kB high:10512kB active:40804kB
inactive:155100kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1339*4kB 558*8kB 266*16kB 94*32kB 17*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2845052kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
9520 pages shared
0 pages swap cached
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:177
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:159
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2845560kB (0kB HighMem)
Active:10055 inactive:38776 dirty:48 writeback:0 unstable:0 free:711390
slab:4681 mapped:1389 pagetables:92
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2845516kB min:7008kB low:8760kB high:10512kB active:40220kB
inactive:155104kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1317*4kB 565*8kB 275*16kB 99*32kB 20*64kB 1*128kB 2*256kB 0*512kB
0*1024kB 0*2048kB 690*4096kB = 2845516kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
8982 pages shared
0 pages swap cached
Out of Memory: Killed process 4628 (cupsd).
oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58}
<ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48}
<ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open
+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open
+40}
       <ffffffff81069fea>{__dentry_open+230}
<ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51}
<ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open
+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:177
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:164
cpu 1 cold: high 62, batch 15 used:11
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2846800kB (0kB HighMem)
Active:9826 inactive:38722 dirty:49 writeback:0 unstable:0 free:711700
slab:4683 mapped:982 pagetables:75
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2846756kB min:7008kB low:8760kB high:10512kB active:39304kB
inactive:154888kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 1363*4kB 601*8kB 305*16kB 100*32kB 24*64kB 1*128kB 2*256kB
0*512kB 0*1024kB 0*2048kB 690*4096kB = 2846756kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
8561 pages shared
0 pages swap cached
Out of Memory: Killed process 4580 (sshd).
Out of Memory: Killed process 1048 (rc.M).
Out of Memory: Killed process 4895 (udev).
Out of Memory: Killed process 4903 (default.hotplug).
Out of Memory: Killed process 4880 (hald-addon-stor).
Out of Memory: Killed process 4641 (crond).
Out of Memory: Killed process 4898 (udev).
Out of Memory: Killed process 4906 (udev).
Out of Memory: Killed process 4917 (default.hotplug).
Out of Memory: Killed process 4259 (rpc.statd).
Out of Memory: Killed process 1056 (syslogd).
Out of Memory: Killed process 4921 (udev).
Out of Memory: Killed process 4924 (udev).
Out of Memory: Killed process 4938 (default.hotplug).
Out of Memory: Killed process 4925 (udev).
Out of Memory: Killed process 4929 (udev).
Out of Memory: Killed process 4946 (default.hotplug).
Out of Memory: Killed process 4949 (udev).
Out of Memory: Killed process 4960 (udev).
Out of Memory: Killed process 4973 (udev).
Out of Memory: Killed process 4978 (default.hotplug).
Out of Memory: Killed process 4972 (udev).
Out of Memory: Killed process 4975 (udev).
Out of Memory: Killed process 5003 (default.hotplug).
Out of Memory: Killed process 5010 (default.hotplug).
Out of Memory: Killed process 5012 (default.hotplug).
Out of Memory: Killed process 5006 (default.hotplug).
Out of Memory: Killed process 5002 (default.hotplug).
Out of Memory: Killed process 4887 (hald-probe-pc-f).


--
Chris Largret <http://daga.dyndns.org>

