Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWGYTB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWGYTB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWGYTB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:01:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26255 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750854AbWGYTB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:01:27 -0400
Date: Tue, 25 Jul 2006 20:54:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060725185449.GA8074@elte.hu>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_99 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	4.0 BAYES_99               BODY: Bayesian spam probability is 99 to 100%
	[score: 1.0000]
	-1.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> The current -git tree will complain about some of the more obvious 
> problems. If you see a "Lukewarm IQ" message, it's a sign of somebody 
> re-taking a cpu lock that is already held.

testing on my latest-rawhide laptop (kernel-2.6.17-1.2445.fc6 and later 
rpms have this change) seems to have pushed the problem over to another 
lock:

  S06cpuspeed/1580 is trying to acquire lock:
   (&policy->lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

  but task is already holding lock:
   (cpu_bitmask_lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

  which lock already depends on the new lock.

and we also get the:

  Lukewarm IQ detected in hotplug locking

message :-| Find the full bootlog below. And i dont understand the 
cpufreq code well enough to fix this. In fact, does anyone understand 
it? :-/

	Ingo

------------>
Linux version 2.6.17-1.2445.fc6 (brewbuilder@hs20-bc2-2.build.redhat.com) (gcc version 4.1.1 20060718 (Red Hat 4.1.1-9)) #1 SMP Mon Jul 24 22:43:31 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003dee0000 (usable)
 BIOS-e820: 000000003dee0000 - 000000003deec000 (ACPI data)
 BIOS-e820: 000000003deec000 - 000000003df00000 (ACPI NVS)
 BIOS-e820: 000000003df00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
94MB HIGHMEM available.
895MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 253664
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225279 pages, LIFO batch:31
  HighMem zone: 24289 pages, LIFO batch:3
DMI present.
Using APIC driver default
ACPI: RSDP (v000 HP                                    ) @ 0x000f6560
ACPI: RSDT (v001 HP     3084     0x06040000  LTP 0x00000000) @ 0x3dee66d9
ACPI: FADT (v001 HP     3084     0x06040000 PTL  0x00000050) @ 0x3deebed2
ACPI: BOOT (v001 HP     3084     0x06040000  LTP 0x00000001) @ 0x3deebfd8
ACPI: SSDT (v001 HP     3084     0x00000001 INTL 0x20030224) @ 0x3dee6b10
ACPI: SSDT (v001 HP     3084     0x00002000 INTL 0x20030224) @ 0x3dee670d
ACPI: DSDT (v001 HP     3084     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
Detected 1596.087 MHz processor.
Built 1 zonelists.  Total pages: 253664
Kernel command line: ro root=/dev/VolGroup00/LogVol00 quiet selinux=0 3
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (017d3000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0802000 soft=c07e2000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 997324k/1014656k available (2092k kernel code, 16724k reserved, 1113k data, 240k init, 97156k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3194.92 BogoMIPS (lpj=6389854)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f1bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c20)
CPU0: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=568 bytes
sizeof(dentry)=160 bytes
sizeof(ext3inode)=804 bytes
sizeof(buffer_head)=52 bytes
sizeof(skbuff)=172 bytes
checking if image is initramfs... it is
Freeing initrd memory: 1970k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9a2, last bus=2
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:00.1
PM: Adding info for pci:0000:00:00.3
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:02:05.0
PM: Adding info for pci:0000:02:07.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *11)
ACPI: Embedded Controller [H_EC] (gpe 29) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
pnp: PnP ACPI: found 7 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 3, cardbus bridge: 0000:02:05.0
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: e0200000-e02fffff
  PREFETCH window: 50000000-51ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1153861090.720:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (63 C)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 32636K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23FA-40, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4243N, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:02:05.0 [103c:3084]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:05.0, mfunc 0x01111112, devctl 0x64
Yenta: ISA IRQ mask 0x04d8, PCI irq 11
Socket status: 30000010
Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PSM1] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Adding info for serio:serio1
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 395k
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0xe0200000-0xe02fffff: excluding 0xe0200000-0xe020ffff
pcmcia: registering new device pcmcia0.0
PM: Adding info for pcmcia:0.0
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: dm-0: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 5763820
ext3_orphan_cleanup: deleting unreferenced inode 5765620
ext3_orphan_cleanup: deleting unreferenced inode 5762038
EXT3-fs: dm-0: 3 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
eth0: Hardware identity 0001:0001:0004:0002
eth0: Station identity  001f:0001:0008:000a
eth0: Firmware determined as Lucent/Agere 8.10
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:02:A5:2D:84:BE
eth0: Station name "HERMES I"
eth0: ready
eth0: orinoco_cs at 0.0, irq 3, io 0x3100-0x313f
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[e0204000-e02047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp 0000:02:00.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp 0000:02:00.0: Try the "8139too" driver instead.
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PM: Adding info for No Bus:i2c-0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xe0100000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
8139too Fast Ethernet driver 0.9.27
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001820
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
input: PC Speaker as /class/input/input2
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001840
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
PM: Adding info for No Bus:usbdev3.1
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001860
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
PM: Adding info for No Bus:usbdev4.1
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
eth1: RealTek RTL8139 at 0xf89a4800, 00:c0:9f:63:51:51, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
usb 2-2: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
Intel 82802 RNG detected
PM: Adding info for usb:2-2
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-2:1.0
input: HID 0461:4d03 as /class/input/input3
input: USB HID v1.00 Mouse [HID 0461:4d03] on usb-0000:00:1d.0-2
PM: Adding info for No Bus:usbdev2.2_ep81
PM: Adding info for No Bus:usbdev2.2
intel8x0_measure_ac97_clock: measured 53458 usecs
intel8x0: clocking to 48000
PM: Adding info for ac97:0-0:unknown codec
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
PM: Adding info for ieee1394:00c09f00002e3893
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00002e3893]
PM: Adding info for ieee1394:00c09f00002e3893-0
MC'97 0 converters and GPIO not ready (0x1)
PM: Adding info for ac97:1-0:unknown codec
floppy0: no floppy controllers found
lp: driver loaded but no devices found
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: multipath: version 1.0.4 loaded
loop: loaded (max 8 devices)
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
S06cpuspeed/1580 is trying to acquire lock:
 (&policy->lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

but task is already holding lock:
 (cpu_bitmask_lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (cpu_bitmask_lock){--..}:
       [<c043bf43>] lock_acquire+0x4b/0x6c
       [<c060748a>] __mutex_lock_slowpath+0xbc/0x20a
       [<c06075f9>] mutex_lock+0x21/0x24
       [<c043f25a>] lock_cpu_hotplug+0x64/0x6f
       [<c05a22f8>] __cpufreq_driver_target+0x15/0x6d
       [<c05a3258>] cpufreq_governor_userspace+0x199/0x1cc
       [<c05a1d9f>] __cpufreq_governor+0x57/0xd8
       [<c05a1fb7>] __cpufreq_set_policy+0x197/0x1a9
       [<c05a1ff6>] cpufreq_set_policy+0x2d/0x6f
       [<c05a29d1>] cpufreq_add_dev+0x31a/0x496
       [<c054bf9c>] sysdev_driver_register+0x5c/0x9b
       [<c05a1c98>] cpufreq_register_driver+0x9e/0x14e
       [<c07ab22b>] centrino_init+0x9b/0xa2
       [<c0400454>] init+0x180/0x2fe
       [<c0402005>] kernel_thread_helper+0x5/0xb

-> #1 (userspace_mutex){--..}:
       [<c043bf43>] lock_acquire+0x4b/0x6c
       [<c060748a>] __mutex_lock_slowpath+0xbc/0x20a
       [<c06075f9>] mutex_lock+0x21/0x24
       [<c05a3112>] cpufreq_governor_userspace+0x53/0x1cc
       [<c05a1d9f>] __cpufreq_governor+0x57/0xd8
       [<c05a1f5d>] __cpufreq_set_policy+0x13d/0x1a9
       [<c05a1ff6>] cpufreq_set_policy+0x2d/0x6f
       [<c05a29d1>] cpufreq_add_dev+0x31a/0x496
       [<c054bf9c>] sysdev_driver_register+0x5c/0x9b
       [<c05a1c98>] cpufreq_register_driver+0x9e/0x14e
       [<c07ab22b>] centrino_init+0x9b/0xa2
       [<c0400454>] init+0x180/0x2fe
       [<c0402005>] kernel_thread_helper+0x5/0xb

-> #0 (&policy->lock){--..}:
       [<c043bf43>] lock_acquire+0x4b/0x6c
       [<c060748a>] __mutex_lock_slowpath+0xbc/0x20a
       [<c06075f9>] mutex_lock+0x21/0x24
       [<c05a2158>] store_scaling_governor+0x120/0x15b
       [<c05a17f0>] store+0x37/0x48
       [<c04a8cd4>] sysfs_write_file+0xab/0xd1
       [<c0471f33>] vfs_write+0xab/0x157
       [<c0472578>] sys_write+0x3b/0x60
       [<c0403faf>] syscall_call+0x7/0xb

other info that might help us debug this:

1 lock held by S06cpuspeed/1580:
 #0:  (cpu_bitmask_lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

stack backtrace:
 [<c04051ea>] show_trace_log_lvl+0x54/0xfd
 [<c04057a6>] show_trace+0xd/0x10
 [<c04058bf>] dump_stack+0x19/0x1b
 [<c043b030>] print_circular_bug_tail+0x59/0x64
 [<c043b843>] __lock_acquire+0x808/0x997
 [<c043bf43>] lock_acquire+0x4b/0x6c
 [<c060748a>] __mutex_lock_slowpath+0xbc/0x20a
 [<c06075f9>] mutex_lock+0x21/0x24
 [<c05a2158>] store_scaling_governor+0x120/0x15b
 [<c05a17f0>] store+0x37/0x48
 [<c04a8cd4>] sysfs_write_file+0xab/0xd1
 [<c0471f33>] vfs_write+0xab/0x157
 [<c0472578>] sys_write+0x3b/0x60
 [<c0403faf>] syscall_call+0x7/0xb
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug() (Not tainted)
 [<c04051ea>] show_trace_log_lvl+0x54/0xfd
 [<c04057a6>] show_trace+0xd/0x10
 [<c04058bf>] dump_stack+0x19/0x1b
 [<c043f23f>] lock_cpu_hotplug+0x49/0x6f
 [<c043384f>] __create_workqueue+0x52/0x116
 [<f8af2337>] cpufreq_governor_dbs+0x9f/0x2d7 [cpufreq_ondemand]
 [<c05a1d9f>] __cpufreq_governor+0x57/0xd8
 [<c05a1f5d>] __cpufreq_set_policy+0x13d/0x1a9
 [<c05a2165>] store_scaling_governor+0x12d/0x15b
 [<c05a17f0>] store+0x37/0x48
 [<c04a8cd4>] sysfs_write_file+0xab/0xd1
 [<c0471f33>] vfs_write+0xab/0x157
 [<c0472578>] sys_write+0x3b/0x60
 [<c0403faf>] syscall_call+0x7/0xb
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug() (Not tainted)
 [<c04051ea>] show_trace_log_lvl+0x54/0xfd
 [<c04057a6>] show_trace+0xd/0x10
 [<c04058bf>] dump_stack+0x19/0x1b
 [<c043f23f>] lock_cpu_hotplug+0x49/0x6f
 [<f8af250d>] cpufreq_governor_dbs+0x275/0x2d7 [cpufreq_ondemand]
 [<c05a1d9f>] __cpufreq_governor+0x57/0xd8
 [<c05a1fb7>] __cpufreq_set_policy+0x197/0x1a9
 [<c05a2165>] store_scaling_governor+0x12d/0x15b
 [<c05a17f0>] store+0x37/0x48
 [<c04a8cd4>] sysfs_write_file+0xab/0xd1
 [<c0471f33>] vfs_write+0xab/0x157
 [<c0472578>] sys_write+0x3b/0x60
 [<c0403faf>] syscall_call+0x7/0xb
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (7927 buckets, 63416 max) - 228 bytes per conntrack
eth1: New link status: Connected (0001)
audit(1153853928.095:2): audit_pid=1809 old=0 by auid=4294967295
DLM (built Jul 24 2006 22:44:14) installed
Bluetooth: Core ver 2.10
PM: Adding info for platform:bluetooth
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
PM: Removing info for ac97:1-0:unknown codec
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
eth1: no IPv6 routers present
