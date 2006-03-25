Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWCYHwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWCYHwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 02:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWCYHwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 02:52:49 -0500
Received: from mx2.mail.ru ([194.67.23.122]:3718 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750815AbWCYHwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 02:52:47 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-ide@vger.kernel.org
Subject: IDE sysfs corrupted (second IDE channel parent lost) after resume from STR
Date: Sat, 25 Mar 2006 10:51:10 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251051.12152.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This can be reproduced both in 2.6.15.6 and 2.6.16. Toshiba with Ali chipset, 
driver compiled in as module. After system resumed from suspend-to-ram, 
second channel of IDE controller loses its parent.

Before suspend:

total 0
lrwxrwxrwx  1 root root 0 Mar 25 10:38 0.0 
- -> ../../../devices/pci0000:00/0000:00:04.0/ide0/0.0/
lrwxrwxrwx  1 root root 0 Mar 25 10:38 1.0 
- -> ../../../devices/pci0000:00/0000:00:04.0/ide1/1.0/

After resume:

total 0
lrwxrwxrwx  1 root root 0 Mar 25 10:38 0.0 
- -> ../../../devices/pci0000:00/0000:00:04.0/ide0/0.0/
lrwxrwxrwx  1 root root 0 Mar 25 10:41 1.0 -> ../../../devices/ide1/1.0/

I include dmesg output from 2.6.16; it can be seen that at least for second 
channel probe_hwif() is called but apparently at this time it does not have 
proper ->pci_dev set; I could find call chain that would have lead to this.

Please let me know if more information (like config or lspci) are needed. 
Kernel does not contain binary drivers :)

Regards

- -andreyLinux version 2.6.16-2avb (bor@cooker.home.net) (gcc version 4.0.3 
(4.0.3-1mdk for Mandriva Linux release 2006.1)) #4 Tue Mar 21 22:26:51 MSK 
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ef60000 (usable)
 BIOS-e820: 000000001ef60000 - 000000001ef70000 (ACPI data)
 BIOS-e820: 000000001ef70000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126816
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 122720 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0090
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60000
ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60054
ACPI: DSDT (v001 TOSHIB 4000     0x20020417 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 pinit hdc=ide-cd resume=/dev/hda1 
splash=silent elevator=cfq vga=791
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (013e2000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 747.770 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 498992k/507264k available (1885k kernel code, 7628k reserved, 565k 
data, 196k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1498.62 BogoMIPS 
(lpj=2997249)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 324k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfe5ae, last bus=5
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region ee00-ee3f claimed by ali7101 ACPI
PCI quirk: region ef00-ef1f claimed by ali7101 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f7f00000-fdffffff
  PREFETCH window: 3c000000-3c0fffff
PCI: Bus 2, cardbus bridge: 0000:00:10.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:11.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 10, cardbus bridge: 0000:00:11.1
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 38000000-39ffffff
  MEM window: 3a000000-3bffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
audit: initializing netlink socket (disabled)
audit(1143268855.064:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xfc000000, mapped to 0xdf880000, using 3072k, total 
16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:775e
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
swsusp: Resume From Partition /dev/hda1
PM: Checking swsusp image.
swsusp: Error -6 check for resume file
PM: Resume from disk failed.
ACPI wakeup devices: 
 COM USB1 ASND VIY0 VIY1  LAN MPC0 MPC1 NOV0  LID 
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:04.0
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATDA04-0, ATA DISK drive
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
Freeing unused kernel memory: 196k freed
Write protecting the kernel read-only data: 266k
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:10.0 [12a3:ab01]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:10.0, mfunc 0x01000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000059
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
wlags49_h1_cs v7.18 for PCMCIA, 03/31/2004 14:31:00 by Agere Systems, 
http://www.agere.com
*** Modified for kernel 2.6 by Andrey Borzenkov <arvidjaar@mail.ru> $Revision: 
19 $
*** Station Mode (STA) Support: YES
*** Access Point Mode (AP) Support: YES
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ts: Compaq touchscreen protocol output
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1644 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (49 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
Adding 500432k swap on /dev/hda1.  Priority:-1 extents:1 across:500432k
loop: loaded (max 8 devices)
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
NET: Registered protocol family 17
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect 
breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html 
for details.
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Adapter hung, retrying after reset
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Adapter hung, retrying after reset
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Adapter hung, retrying after reset
========== suspend start ======================
ACPI: PCI interrupt for device 0000:00:06.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
pccard: card ejected from slot 0
PM: Preparing system for mem sleep
Stopping tasks: 
==================================================================================|
pnp: Device 00:09 disabled.
ACPI: PCI interrupt for device 0000:00:11.1 disabled
ACPI: PCI interrupt for device 0000:00:11.0 disabled
ACPI: PCI interrupt for device 0000:00:10.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
ACPI: PCI interrupt for device 0000:00:02.0 disabled
PM: Entering mem sleep
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
Debug: sleeping function called from invalid context 
at /home/bor/src/linux-git/mm/slab.c:2729
in_atomic():0, irqs_disabled():1
 [<c0104213>] show_trace+0x13/0x20
 [<c010423e>] dump_stack+0x1e/0x20
 [<c0116032>] __might_sleep+0xa2/0xc0
 [<c015c533>] kmem_cache_alloc+0x53/0x70
 [<c01f2a53>] acpi_os_acquire_object+0x11/0x41
 [<c020843f>] acpi_ut_allocate_object_desc_dbg+0xf/0x44
 [<c02084cb>] acpi_ut_create_internal_object_dbg+0x16/0x6a
 [<c0204807>] acpi_rs_set_srs_method_data+0x40/0xb9
 [<c0203f05>] acpi_set_current_resources+0x23/0x2e
 [<c020bd7b>] acpi_pci_link_set+0xff/0x17b
 [<c020be2e>] irqrouter_resume+0x37/0x56
 [<c0236b8a>] __sysdev_resume+0x1a/0x90
 [<c0236c47>] sysdev_resume+0x47/0x70
 [<c023c648>] device_power_up+0x8/0x10
 [<c0138b7a>] enter_state+0x1ba/0x220
 [<c0138c77>] state_store+0x97/0xb0
 [<c01a188e>] subsys_attr_store+0x2e/0x30
 [<c01a1e63>] sysfs_write_file+0xb3/0x100
 [<c015fe57>] vfs_write+0xa7/0x190
 [<c0160867>] sys_write+0x47/0x70
 [<c0102f07>] sysenter_past_esp+0x54/0x75
PM: Finishing wakeup.
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
pnp: Failed to activate device 00:05.
pnp: Failed to activate device 00:06.
pnp: Device 00:09 activated.
usb usb1: root hub lost power or was reset
Restarting tasks... done
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEJPZvR6LMutpd94wRAoLqAJ0UxvE3WGtDsreVeql2xhAmpmKHbgCgxiDh
kspfyJ6bWdSfXrfsLuyGAC0=
=vbuO
-----END PGP SIGNATURE-----
