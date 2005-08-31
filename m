Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVHaMOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVHaMOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVHaMOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:14:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:49566 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932506AbVHaMOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:14:10 -0400
X-Authenticated: #1725425
Date: Wed, 31 Aug 2005 14:12:02 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, gregkh@suse.de
Subject: Re: 2.6.13-rc6-mm2 - breaks USB unplug
Message-Id: <20050831141202.019edc99.Ballarin.Marc@gmx.de>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
References: <20050822213021.1beda4d5.akpm@osdl.org>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

-rc6-mm2 breaks USB unplug for me. Happens with every USB device,
gcc-3.3.5 and gcc-3.4.4 as well as preempt and non-preempt and is 100%
reproducible.
-rc6-mm1 seems fine.

Reverting the following part of
driver-core-fix-bus_rescan_devices-race.patch
fixes this for me:

diff -puN drivers/base/dd.c~driver-core-fix-bus_rescan_devices-race drivers/base/dd.c
--- devel/drivers/base/dd.c~driver-core-fix-bus_rescan_devices-race     2005-08-22 17:44:11.000000000 -0700
+++ devel-akpm/drivers/base/dd.c        2005-08-22 17:44:11.000000000 -0700
@@ -127,10 +127,9 @@ int device_attach(struct device * dev)
        int ret = 0;

        down(&dev->sem);
-       if (dev->driver) {
-               device_bind_driver(dev);
+       if (dev->driver)
                ret = 1;
-       } else
+       else
                ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
        up(&dev->sem);
        return ret;

dmesg and OOPS below (-laptop is just CONFIG_LOCALVERSION):

Linux version 2.6.13-rc6-mm2-laptop (marc@mocktop) (gcc-Version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 PREEMPT Wed Aug 31 12:05:38 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fee0000 (usable)
 BIOS-e820: 000000002fee0000 - 000000002feec000 (ACPI data)
 BIOS-e820: 000000002feec000 - 000000002ff00000 (ACPI NVS)
 BIOS-e820: 000000002ff00000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
766MB LOWMEM available.
On node 0, present: 196320, spanned: 196320
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192224 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                  ) @ 0x000f62c0
ACPI: RSDT (v001 ACER   Kestrel  0x20021012  LTP 0x00000000) @ 0x2fee6205
ACPI: FADT (v001 ACER   Kestrel  0x20021012 PTL  0x00000050) @ 0x2feebf2c
ACPI: HPET (v001 ACER   Kestrel  0x20021012 PTL  0x00000000) @ 0x2feebfa0
ACPI: BOOT (v001 ACER   Kestrel  0x20021012  LTP 0x00000001) @ 0x2feebfd8
ACPI: DSDT (v001 ACER   Kestrel  0x20021012 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: HPET id: 0x8086a201 base: 0x0
Allocating PCI resources starting at 30000000 (gap: 30000000:cec10000)
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Test-Kernel ro root=306 lapic ec_polling usb-handoff init 2
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1599.324 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774328k/785280k available (1963k kernel code, 10488k reserved, 741k data, 460k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3198.86 BogoMIPS (lpj=1599431)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0440)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd782, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050729
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *6)
ACPI: PCI Interrupt Link [LNKD] (IRQs *6)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-00004fff
  IO window: 00005000-00005fff
  PREFETCH window: 30000000-31ffffff
  MEM window: 34000000-35ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: d0200000-d05fffff
  PREFETCH window: 30000000-32ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:02:06.0 (0104 -> 0107)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
pnp: 00:03: ioport range 0x164e-0x164f has been reserved
Simple Boot Flag at 0x37 set to 0x1
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 6 (level, low) -> IRQ 6
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=450.00 Mhz, System=210.00 MHz
radeonfb: PLL min 20000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
radeonfb: panel ID string: QDS                     
radeonfb: detected LVDS panel size from BIOS: 1280x800
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 160x50
radeonfb (0000:01:00.0): ATI Radeon NP 
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (57 C)
Real Time Clock Driver v1.12
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOU2] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 6 (level, low) -> IRQ 6
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard on isa0060/serio0
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITAUJ-831D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
 hda1: <netbsd:bad subpartition - ignored
bad subpartition - ignored
bad subpartition - ignored
bad subpartition - ignored
 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
perfctr: driver 2.7.17, cpu type Intel P6 at 1599324 kHz
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 460k freed
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
cdrom: open failed.
EXT3 FS on hda6, internal journal
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 6 (level, low) -> IRQ 6
[drm] Initialized radeon 1.17.0 20050311 on minor 0: 
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 6 (level, low) -> IRQ 6
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: check_and_reset_hc: legsup = 0x2f00
uhci_hcd 0000:00:1d.0: Performing full reset
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 6, io base 0x00001800
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.13-rc6-mm2-laptop uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0000
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 6 (level, low) -> IRQ 6
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: check_and_reset_hc: legsup = 0x2f00
uhci_hcd 0000:00:1d.1: Performing full reset
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 6, io base 0x00001820
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.13-rc6-mm2-laptop uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
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
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:1d.1: port 2 portsc 01ab,00
hub 2-0:1.0: port 2, status 0301, change 0003, 1.5 Mb/s
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 6 (level, low) -> IRQ 6
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: detected 2 ports
uhci_hcd 0000:00:1d.2: check_and_reset_hc: legsup = 0x2000
uhci_hcd 0000:00:1d.2: Performing full reset
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 6, io base 0x00001840
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.13-rc6-mm2-laptop uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
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
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: capability 0001 at 68
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xd0000000
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: unable to enable MWI - not fatal.
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.13-rc6-mm2-laptop ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
uhci_hcd 0000:00:1d.1: port 2 portsc 0082,00
b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKD] -> GSI 6 (level, low) -> IRQ 6
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:72:89:d4
base: 0x18    alert: 0x20
i2c-acpi-ec.c: ACPI EC SMBus adapter at 0x18
ACPI: Smart Battery System [SBS0]
hub 2-0:1.0: debounce: port 2: total 125ms stable 100ms status 0x100
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.2: port 2 portsc 008a,00
hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
ACPI: Smart Battery Charger [SBC]
ACPI: Smart Battery Selector [SBSEL]
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0000
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001403 POWER sig=k CSC CONNECT
hub 4-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 4 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 003002 POWER OWNER sig=se0 CSC
hub 4-0:1.0: port_wait_reset: err = -107
ehci_hcd 0000:00:1d.7: GetStatus port 6 status 001403 POWER sig=k CSC CONNECT
hub 4-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 6 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 6 status 003002 POWER OWNER sig=se0 CSC
hub 4-0:1.0: port_wait_reset: err = -107
hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0000
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.1: port 2 portsc 01a3,00
hub 2-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
usb 2-2: new low speed USB device using uhci_hcd and address 2
usb 2-2: skipped 1 descriptor after interface
usb 2-2: default language 0x0409
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2: Product: Optical USB Mouse
usb 2-2: Manufacturer: Logitech
usb 2-2: hotplug
usb 2-2: adding 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.2: port 2 portsc 01a3,00
hub 3-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
uhci_hcd 0000:00:1d.0: suspend_rh (auto-stop)
usb 3-2: new low speed USB device using uhci_hcd and address 2
usb 3-2: skipped 1 descriptor after interface
usb 3-2: skipped 1 descriptor after interface
usb 3-2: default language 0x0409
usb 3-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-2: Product: Logitech USB Keyboard
usb 3-2: Manufacturer: Logitech
usb 3-2: hotplug
usb 3-2: adding 3-2:1.0 (config #1, interface 0)
usb 3-2:1.0: hotplug
usb 3-2: adding 3-2:1.1 (config #1, interface 1)
usb 3-2:1.1: hotplug
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0004
ACPI: Smart Battery Slot [SB0] (battery present)
ACPI: Smart Battery Slot [SB1] (battery absent)
acpi-cpufreq: CPU0 - ACPI performance management activated.
loop: loaded (max 8 devices)
usbcore: registered new driver hiddev
usbhid 2-2:1.0: usb_probe_interface
usbhid 2-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.1-2
usbhid 3-2:1.0: usb_probe_interface
usbhid 3-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.2-2
usbhid 3-2:1.1: usb_probe_interface
usbhid 3-2:1.1: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1d.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
cdrom: open failed.
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
NTFS driver 2.1.23 [Flags: R/W MODULE].
Adding 524280k swap on /.swapfile.  Priority:-1 extents:276 across:1008812k
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50287 usecs
intel8x0: clocking to 48000
==================	UNPLUG MOUSE HERE ==================	
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.1: port 2 portsc 008a,00
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
usb 2-2: USB disconnect, address 2
usb 2-2: usb_disable_device nuking all URBs
usb 2-2: unregistering interface 2-2:1.0
usb 2-2:1.0: hotplug
usb 2-2: unregistering device
BUG: atomic counter underflow at:
 [<c01c7cd1>] kref_put+0x51/0xa0
 [<c0195789>] sysfs_hash_and_remove+0x59/0x102
 [<c02e7a7b>] klist_remove+0x1b/0x40
 [<c023a333>] __device_release_driver+0x43/0xa0
 [<c023a3a6>] device_release_driver+0x16/0x30
 [<c0239b9f>] bus_remove_device+0x4f/0x60
 [<c0238b74>] device_del+0x24/0x60
 [<c0238bb8>] device_unregister+0x8/0x10
 [<f08660e2>] hub_port_connect_change+0x362/0x4f0 [usbcore]
 [<f0862328>] clear_port_feature+0x48/0x50 [usbcore]
 [<f086663f>] hub_events+0x3cf/0x5e0 [usbcore]
 [<c012d940>] autoremove_wake_function+0x0/0x50
 [<f0866875>] hub_thread+0x25/0x120 [usbcore]
 [<c02e810d>] schedule+0x32d/0x6b0
 [<c012d940>] autoremove_wake_function+0x0/0x50
 [<c012d940>] autoremove_wake_function+0x0/0x50
 [<f0866850>] hub_thread+0x0/0x120 [usbcore]
 [<c012d3f6>] kthread+0x96/0xe0
 [<c012d360>] kthread+0x0/0xe0
 [<c0100fa5>] kernel_thread_helper+0x5/0x10
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02e85db
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
last sysfs file: /class/vc/vcsa4/dev
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc ntfs vfat fat reiserfs usbhid loop acpi_cpufreq acpi_sbs i2c_acpi_ec b44 mii ehci_hcd uhci_hcd usbcore radeon drm intel_agp agpgart psmouse
CPU:    0
EIP:    0060:[<c02e85db>]    Not tainted VLI
EFLAGS: 00010002   (2.6.13-rc6-mm2-laptop) 
EIP is at wait_for_completion+0x5b/0xf0
eax: ef12689c   ebx: ee890000   ecx: ee891e80   edx: 00000000
esi: ef126898   edi: ee890000   ebp: ee891ea0   esp: ee891e54
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5192, threadinfo=ee890000 task=ef0b6030)
Stack: 00000000 ef0b6030 c0115320 00000000 00000000 ef126894 c02e79d0 f087dc60 
       00000001 ef0b6030 c0115320 ef12689c c0195789 ef5f6ac0 ef4695a8 ee890000 
       ef1268c4 ef126864 f087dc60 ef5f6ac0 c023a333 ef126864 ef786064 00000002 
Call Trace:
 [<c0115320>] default_wake_function+0x0/0x10
 [<c02e79d0>] klist_release+0x0/0x50
 [<c0115320>] default_wake_function+0x0/0x10
 [<c0195789>] sysfs_hash_and_remove+0x59/0x102
 [<c023a333>] __device_release_driver+0x43/0xa0
 [<c023a3a6>] device_release_driver+0x16/0x30
 [<c0239b9f>] bus_remove_device+0x4f/0x60
 [<c0238b74>] device_del+0x24/0x60
 [<c0238bb8>] device_unregister+0x8/0x10
 [<f08660e2>] hub_port_connect_change+0x362/0x4f0 [usbcore]
 [<f0862328>] clear_port_feature+0x48/0x50 [usbcore]
 [<f086663f>] hub_events+0x3cf/0x5e0 [usbcore]
 [<c012d940>] autoremove_wake_function+0x0/0x50
 [<f0866875>] hub_thread+0x25/0x120 [usbcore]
 [<c02e810d>] schedule+0x32d/0x6b0
 [<c012d940>] autoremove_wake_function+0x0/0x50
 [<c012d940>] autoremove_wake_function+0x0/0x50
 [<f0866850>] hub_thread+0x0/0x120 [usbcore]
 [<c012d3f6>] kthread+0x96/0xe0
 [<c012d360>] kthread+0x0/0xe0
 [<c0100fa5>] kernel_thread_helper+0x5/0x10
Code: e0 89 df 8b 13 c7 45 bc 20 53 11 c0 83 c8 01 89 45 d4 8d 46 04 89 55 b8 89 55 d8 c7 45 dc 20 53 11 c0 8b 50 04 89 45 e0 89 48 04 <89> 0a 89 55 e4 8b 07 c7 00 02 00 00 00 fb ff 4f 14 8b 47 08 a8 
 <3>BUG: khubd[5192] exited with nonzero preempt_count 1!
uhci_hcd 0000:00:1d.1: suspend_rh (auto-stop)
