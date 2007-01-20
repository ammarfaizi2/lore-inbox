Return-Path: <linux-kernel-owner+w=401wt.eu-S965310AbXATRVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbXATRVH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 12:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965321AbXATRVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 12:21:07 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:53099 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965310AbXATRVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 12:21:04 -0500
From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: linux-kernel@vger.kernel.org
Subject: Abysmal disk performance, how to debug?
Date: Sat, 20 Jan 2007 19:20:53 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701201920.54620.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I own a Sony Vaio VGN-FS285B and disk performance to say at least is very very 
slow. Writing 1 GB data makes the laptop unresponsive. Here is some data 
identifying the drive. Hope someone can tell me how to debug and find out 
whats the problem.

FWIW since 2.6.16 the problem is same and I didn't test with 2.4 kernels. Here 
is some data. And I tested with xfs & ext3. Both slow slow disk writes.

vaio cartman # hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 156301488, start = 0
vaio cartman # hdparm -i /dev/hda

/dev/hda:

 Model=FUJITSU MHV2080AT, FwRev=00000096, SerialNo=NS56T58270LE
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  ATA/ATAPI-2 
ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6

 * signifies the current active mode


vaio cartman # hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   1576 MB in  2.00 seconds = 788.18 MB/sec
 Timing buffered disk reads:   74 MB in  3.01 seconds =  24.55 MB/sec


[~]> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1,1 GB) copied, 77,2809 s, 13,9 MB/s

real    1m17.482s
user    0m0.003s
sys     0m2.350s


dmesg follows:


 PTL  0x0000005f) @ 0x1f6e9e78
ACPI: FADT (v002   Sony       J1 0x20050311 PTL  0x0000005f) @ 0x1f6e9ee0
ACPI: BOOT (v001   Sony       J1 0x20050311 PTL  0x00000001) @ 0x1f6e9fd8
ACPI: MCFG (v001   Sony       J1 0x20050311 PTL  0x0000005f) @ 0x1f6e9f9c
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x1f6e618f
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x1f6e5d4a
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x1f6e5b2f
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x1f6e5916
ACPI: DSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1792.955 MHz processor.
Built 1 zonelists.  Total pages: 127731
Kernel command line: root=/dev/hda1 vga=791 mudur=language:tr
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 506696k/514944k available (2242k kernel code, 7824k reserved, 734k 
data, 176k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffeb000 - 0xfffff000   (  80 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0000000 - 0xff7fe000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdf6e0000   ( 502 MB)
      .init : 0xc03ec000 - 0xc0418000   ( 176 kB)
      .data : 0xc033099f - 0xc03e850c   ( 734 kB)
      .text : 0xc0100000 - 0xc033099f   (2242 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3462.00 BogoMIPS 
(lpj=5768004)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00002040 00000180 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1.73GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0cb8)
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Firmware left 0000:06:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) 
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 *4 5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 7, cardbus bridge: 0000:06:03.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 38000000-3bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: b0100000-b01fffff
  PREFETCH window: 30000000-33ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:06:03.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:06:03.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1169299806.936:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, security attributes, no debug enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xc0000000, mapped to 0xe0080000, using 3072k, total 
7872k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
ACPI: Video Device [NGFX] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (54 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 3 (level, low) -> 
IRQ 3
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: FUJITSU MHV2080AT, ATA DISK drive
hdb: MATSHITAUJ-840D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
input: PS/2 Mouse as /class/input/input4
input: AlpsPS/2 ALPS GlidePoint as /class/input/input5
input: PC Speaker as /class/input/input6
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
UDF-fs: No VRS found
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
ACPI Sony Notebook Control Driver successfully installed
fuse init (API version 7.8)
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Adding 614392k swap on /.swap.  Priority:-1 extents:1 across:614392k
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: CHECK for good STATUS
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:06:03.2[C] -> Link [LNKC] -> GSI 3 (level, low) -> 
IRQ 3
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[3]  MMIO=[b0104000-b01047ff]  
Max Packet=[2048]  IR/IT contexts=[4/8]
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:06:08.0[A] -> Link [LNKE] -> GSI 7 (level, low) -> 
IRQ 7
e100: eth0: e100_probe: addr 0xb0107000, irq 7, MAC addr 00:01:4A:C0:6C:0C
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKH] -> GSI 5 (level, low) -> 
IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xb0004000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKH] -> GSI 5 (level, low) -> 
IRQ 5
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 5, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 3 (level, low) -> 
IRQ 3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 3, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 10, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI config is deprecated.
 Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.
intel_rng: FWH not detected
usb 2-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Logitech USB Receiver as /class/input/input7
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301e6fd1a]
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Yenta: CardBus bridge found at 0000:06:03.0 [104d:818f]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:06:03.0, mfunc 0x01001b22, devctl 0x64
Yenta: ISA IRQ mask 0x0050, PCI irq 10
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#06) from #07 to #0a
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0xb0100000 - 0xb01fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kmprq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt 0000:06:04.0[A] -> Link [LNKG] -> GSI 10 (level, low) -> 
IRQ 10
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
NET: Registered protocol family 17
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
[drm] Initialized i915 1.6.0 20060119 on minor 0
usb 2-1: USB disconnect, address 2
usb 2-1: new low speed USB device using uhci_hcd and address 3
usb 2-1: configuration #1 chosen from 1 choice
input: Logitech USB Receiver as /class/input/input8
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
usb 2-1: USB disconnect, address 3
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
input: Logitech USB Receiver as /class/input/input9
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.1-1
