Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVCXLCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVCXLCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVCXLB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:01:59 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60298 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262412AbVCXLBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:01:35 -0500
Date: Thu, 24 Mar 2005 12:01:02 +0100
From: Peter Baumann <waste.manager@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] invalid mac address after rebooting (kernel 2.6.11.5)
Message-ID: <20050324110102.GA30711@faui00u.informatik.uni-erlangen.de>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <20050323185225.11097185.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323185225.11097185.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> >
> > 
> > I'm hitting an annoying bug in kernel 2.6.11.5
> > 
> > Every time I _reboot_ (warmstart) my pc my two network cards won't get
> > recognized any longer.
> > 
> > Following error message appears on my screen:
> > 
> > PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> > ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> > PCI: Setting latency timer of device 0000:00:0b.0 to 64
> > *** EEPROM MAC address is invalid.
> > 3c59x: vortex_probe1 fails.  Returns -22
> > 3c59x: probe of 0000:00:0b.0 failed with error -22
> > PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
> > ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
> > 0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
> > PCI: Setting latency timer of device 0000:00:0d.0 to 64
> > *** EEPROM MAC address is invalid.
> > 3c59x: vortex_probe1 fails.  Returns -22
> > 3c59x: probe of 0000:00:0d.0 failed with error -22
> > 
> > This doesn't happen with older kernels (especially with 2.6.10) and so
> > I've done a binary search and narrowed it down to 2.6.11-rc5 where it
> > first hits me.
> > 
> > My config, lspci output and the dmesg output of the working and non-working
> > version can be found at [1]
> > 
> > Feel free to ask if any information is missing or if I am supposed to try
> > a patch.
> 
> Thanks for doing the bsearch - it helps.
> 
> There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
> 
> The only PCI change I see is
> 
> --- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> +++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> @@ -268,7 +268,7 @@
>                 return -EIO; 
>  
>         pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> -       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> +       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
>                 printk(KERN_DEBUG
>                        "PCI: %s has unsupported PM cap regs version (%u)\n",
>                        dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> 
> and you're not getting that message (are you?)
> 

Reverting the above patch solved it. But _now_ I get the message.
(dmesg output with above patch reverted at the end of the mail)

> Nothing much in arch/i386..
> 
> There were some ACPI changes, which is always a worry ;) Does that machine
> run OK without ACPI support?  If so, could you determine whether disabling
> ACPI fixes things up?
>
Hm. I tried it with 2.6.11.5 by appending  acpi=off  at the cmdline but
as I remember it hasn't changed anything. Or do I have to specify
someting else at the commandline to deactivate acpi?

Greetings,
  Peter Baumann


Linux version 2.6.11-rc5-revert (peter@xp) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #2 Thu Mar 24 11:44:28 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f59e0
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 KT400                                 ) @ 0x000f7410
ACPI: RSDT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff71c0
ACPI: DSDT (v001 KT400  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=/dev/md2 ro ide4=noprobe ide5=noprobe debug 
ide_setup: ide4=noprobe
ide_setup: ide5=noprobe
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1537.147 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515240k/524224k available (2052k kernel code, 8424k reserved, 1060k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3022.84 BogoMIPS (lpj=1511424)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x5000-0x500f has been reserved
Initializing Cryptographic API
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 32M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G400 AGP
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xac00. Vers LK1.1.19
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT370A: IDE controller at PCI slot 0000:00:08.0
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 16
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 16
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800BB-00CAA0, ATA DISK drive
ide0 at 0x9000-0x9007,0x9402 on irq 16
Probing IDE interface ide1...
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:DMA
Probing IDE interface ide2...
hde: WDC WD1200JB-00EVA0, ATA DISK drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide3...
hdg: WDC WD1200JB-00EVA0, ATA DISK drive
hdh: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
ide3 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda4 < hda5 hda6 hda7 hda8 hda9 >
hde: max request size: 1024KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 hde4 < hde5 hde6 hde7 hde8 hde9 >
hdg: max request size: 1024KiB
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1 hdg2 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 >
hdh: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
input: PC Speaker
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4180.000 MB/sec
raid5: using function: pIII_sse (4180.000 MB/sec)
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 LAN0 UAR1 ECP1 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on hda1
md: hda1 has invalid sb, not importing!
md: autorun ...
md: considering hdg8 ...
md:  adding hdg8 ...
md: hdg7 has different UUID to hdg8
md: hdg6 has different UUID to hdg8
md: hdg1 has different UUID to hdg8
md:  adding hde8 ...
md: hde7 has different UUID to hdg8
md: hde6 has different UUID to hdg8
md: hde1 has different UUID to hdg8
md:  adding hda8 ...
md: hda7 has different UUID to hdg8
md: hda6 has different UUID to hdg8
md: created md4
md: bind<hda8>
md: bind<hde8>
md: bind<hdg8>
md: running: <hdg8><hde8><hda8>
raid5: device hdg8 operational as raid disk 2
raid5: device hde8 operational as raid disk 1
raid5: device hda8 operational as raid disk 0
raid5: allocated 3154kB for md4
raid5: raid level 5 set md4 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hda8
 disk 1, o:1, dev:hde8
 disk 2, o:1, dev:hdg8
md: considering hdg7 ...
md:  adding hdg7 ...
md: hdg6 has different UUID to hdg7
md: hdg1 has different UUID to hdg7
md:  adding hde7 ...
md: hde6 has different UUID to hdg7
md: hde1 has different UUID to hdg7
md:  adding hda7 ...
md: hda6 has different UUID to hdg7
md: created md3
md: bind<hda7>
md: bind<hde7>
md: bind<hdg7>
md: running: <hdg7><hde7><hda7>
raid5: device hdg7 operational as raid disk 2
raid5: device hde7 operational as raid disk 1
raid5: device hda7 operational as raid disk 0
raid5: allocated 3154kB for md3
raid5: raid level 5 set md3 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hda7
 disk 1, o:1, dev:hde7
 disk 2, o:1, dev:hdg7
md: considering hdg6 ...
md:  adding hdg6 ...
md: hdg1 has different UUID to hdg6
md:  adding hde6 ...
md: hde1 has different UUID to hdg6
md:  adding hda6 ...
md: created md2
md: bind<hda6>
md: bind<hde6>
md: bind<hdg6>
md: running: <hdg6><hde6><hda6>
raid5: device hdg6 operational as raid disk 2
raid5: device hde6 operational as raid disk 1
raid5: device hda6 operational as raid disk 0
raid5: allocated 3154kB for md2
raid5: raid level 5 set md2 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hda6
 disk 1, o:1, dev:hde6
 disk 2, o:1, dev:hdg6
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdg1>
md: running: <hdg1><hde1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: 0000:00:09.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:00:0a.0, irq: 18, latency: 32, mmio: 0xe8000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom: Hauppauge: model = 61344, rev = D421, serial# = 3911831
tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
tveeprom: audio_processor = MSP3415 (type = 6)
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3415D-A2 +nicam +simple mode=simple
msp3410: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
ACPI: PCI interrupt 0000:00:0a.1[A] -> GSI 18 (level, low) -> IRQ 18
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xb400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xb800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xbc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 21, pci mem 0xe8004000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (39 C)
lp0: using parport0 (interrupt-driven).
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
