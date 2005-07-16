Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVGPEyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVGPEyn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 00:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVGPEym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 00:54:42 -0400
Received: from panda.sul.com.br ([200.219.150.4]:44046 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262221AbVGPEw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 00:52:56 -0400
Date: Sat, 16 Jul 2005 01:52:48 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: madwifi-users@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: oz6812, yenta_socket and madwifi
Message-ID: <20050716045248.GB22383@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
	for some time I was unable to use Atheros based cards on my
	notebook (O2Micro oz6812 Cardbus controller) because of lots
	of rx packets getting dropped by frame errors. running ping I got
	this: (~1m from access point)

PING 192.168.67.1 (192.168.67.1): 56 data bytes
64 bytes from 192.168.67.1: icmp_seq=0 ttl=64 time=1.5 ms
wrong data byte #20 should be 0x14 but was 0x0
        0 10 18 1 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29
2a 2b 2c 2d 2e 2f 30 31 32 33
        34 35 36 37 0 0 0 0 84 dc 5 8 ff ff ff ff
64 bytes from 192.168.67.1: icmp_seq=4 ttl=64 time=1.3 ms
wrong data byte #20 should be 0x14 but was 0x0
        0 10 18 1 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29
2a 2b 2c 2d 2e 2f 30 31 32 33
        34 35 36 37 0 0 0 0 84 dc 5 8 ff ff ff ff

	after playing a bit with yenta_socket I came to this patch which
makes both cards work flawlessly:

--- 2.6.orig/drivers/pcmcia/o2micro.h	2005-07-15 23:43:42.556540296 -0400
+++ 2.6/drivers/pcmcia/o2micro.h	2005-07-16 00:23:16.552638032 -0400
@@ -138,6 +138,8 @@
 		printk(KERN_INFO "Yenta O2: res at 0x94/0xD4: %02x/%02x\n", a, b);
 
 		switch (socket->dev->device) {
+		case PCI_DEVICE_ID_O2_6812:
+			config_writeb(socket, 0xD4, 0);
 		case PCI_DEVICE_ID_O2_6832:
 			printk(KERN_INFO "Yenta O2: old bridge, not enabling read prefetch / write burst\n");
 			break;

in oz6812 datasheet there's nothing about read prefetch and write burst
which o2micro_override() enables (and hey, if 6832 is an old bridge, I
guess 6812 is even older :).
while playing with the only control2 register bit described in datasheet
(14th, SCLK_ENABLE) I discovered that zeroing the first byte made the
driver work with both cards (the first 13 bits are described as reserved
for diagnostic test mode).

anyone (perhaps from O2Micro) knows what those bits are exactly or has a
better clue of what's going on here?

(if anyone finds useful, dmesg, ifconfig, /proc/interrupts, lspci -vvv
are attached)

--
Aristeu


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.11.6-pinguim2 (aris@frankie) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #6 Sun Apr 3 17:34:27 GMT+2 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: RSDP (v000 Acer                                  ) @ 0x000fe030
ACPI: RSDT (v001 Acer   AN340    0x00000001 Acer 0x00000000) @ 0x0fff0000
ACPI: FADT (v001 Acer   AN340    0x00000001 Acer 0x00000000) @ 0x0fff0054
ACPI: BOOT (v001 Acer   AN340    0x00000001 Acer 0x00000000) @ 0x0fff002c
ACPI: DSDT (v001   Acer   AN340  0x00001000 MSFT 0x0100000c) @ 0x00000000
Allocating PCI resources starting at 10000000 (gap: 10000000:efff0000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro vga=787 resume=/dev/hda3
__iounmap: bad address c00fffd9
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 499.589 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255172k/262080k available (2076k kernel code, 6336k reserved, 1159k data, 264k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 985.08 BogoMIPS (lpj=492544)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0620)
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [PILA] (IRQs 1 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 *9 11)
ACPI: PCI Interrupt Link [PILC] (IRQs 1 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 1 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 1 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 10)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: 00:0a: ioport range 0xf100-0xf13f could not be reserved
pnp: 00:0a: ioport range 0xf140-0xf15f has been reserved
pnp: 00:0a: ioport range 0x1060-0x106f has been reserved
pnp: 00:0a: ioport range 0x40b-0x40b has been reserved
Simple Boot Flag at 0x6e set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1121472137.967:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0x80800000, mapped to 0xd0880000, using 1875k, total 2560k
vesafb: mode is 800x600x16, linelength=1600, pages=1
vesafb: protected mode interface info at c000:68a2
vesafb: scrolling: redraw
vesafb: Truecolor: size=1:5:5:5, shift=15:10:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:06' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [PILC] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:06.1[A] -> GSI 9 (level, low) -> IRQ 9
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ACPI: PCI interrupt 0000:00:0f.0[A]: no GSI - using IRQ 15
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7090-0x7097, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7098-0x709f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ST94011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63, (U)DMA
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 6
Cannot allocate resource for EISA slot 7
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
KBC0 OBMO USB0  LID 
ACPI: (supports S0 S1 S4 S4bios S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 264k freed
ide0: Speed warnings UDMA 3/4/5 is not functional.
Adding 257032k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
apm: BIOS version 1.2 Flags 0x0f (Driver version 1.16ac)
apm: overridden by ACPI.
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0x81400000, irq 9, MAC addr 00:D0:59:0E:ED:1B
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ACPI: PCI Interrupt Link [PILD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Thermal Zone [THR2] (34 C)
NET: Registered protocol family 23
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Found dongle: Sharp RY5HD01
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected ALi M???? chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe0000000
solo1: version v0.20 time 17:19:58 Apr  3 2005
ali1535_smbus 0000:00:11.0: SMB device not enabled - upgrade BIOS?
ali1535_smbus 0000:00:11.0: ALI1535 not detected, module not inserted.
ali15x3_smbus 0000:00:11.0: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr
ali15x3_smbus 0000:00:11.0: ALI15X3 not detected, module not inserted.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [PILB] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:00:13.0 [1025:1009]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0c90, PCI irq 9
Socket status: 30000821
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [PILE] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:14.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:14.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:14.0: irq 10, pci mem 0x81a00000
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:14.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:14.0: enabling initreset quirk
ohci_hcd 0000:00:14.0: OHCI controller state
ohci_hcd 0000:00:14.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:14.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:14.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:14.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:14.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:14.0: hcca frame #0003
ohci_hcd 0000:00:14.0: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci_hcd 0000:00:14.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:14.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:14.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:14.0: roothub.portstatus [1] 0x00000100 PPS
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: ALi Corporation USB 1.1 Controller
usb usb1: Manufacturer: Linux 2.6.11.6-pinguim2 ohci_hcd
usb usb1: SerialNumber: 0000:00:14.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
ohci_hcd 0000:00:14.0: created debug files
hub 1-0:1.0: state 5 ports 2 chg 0006 evt 0007
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
input: PC Speaker
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:08' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
nfs warning: mount version older than kernel
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03b1540(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
wlan: 0.8.6.0 (EXPERIMENTAL)
ath_rate_sample: 1.2
ath_pci: 0.9.6.0 (EXPERIMENTAL)
PCI: Enabling device 0000:02:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
Build date: Jul 14 2005
Debugging version (IEEE80211)
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: turboA rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: H/W encryption support: WEP AES AES_CCM TKIP
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: Use hw queue 1 for WME_AC_BE traffic
ath0: Use hw queue 0 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Use hw queue 8 for CAB traffic
ath0: Use hw queue 9 for beacons
Debugging version (ATH)
ath0: Atheros 5212: mem=0x10800000, irq=9

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ifconfig

ath0      Link encap:Ethernet  HWaddr 00:0F:CB:F9:1C:80  
          inet6 addr: fe80::20f:cbff:fef9:1c80/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:30 errors:42 dropped:0 overruns:0 frame:42
          TX packets:30 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:200 
          RX bytes:4260 (4.1 KiB)  TX bytes:4220 (4.1 KiB)
          Interrupt:9 Memory:d0ca0000-d0cb0000 


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=interrupts

           CPU0       
  0:     332143          XT-PIC  timer
  1:        659          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ES1938
  7:          1          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:      27349          XT-PIC  acpi, yenta, eth0, ath0
 10:          1          XT-PIC  ohci_hcd
 12:      14042          XT-PIC  i8042
 14:       2411          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

0000:00:00.0 Host bridge: ALi Corporation M1621 (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=33 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1

0000:00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80500000-810fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0440
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 81400000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 90c0 [size=64]
	Region 2: Memory at 81500000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

0000:00:06.1 Serial controller: Lucent Microelectronics LT WinModem (prog-if 00 [8250])
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0440
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 9400 [size=8]
	Region 1: Memory at 81800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev 0a)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1009
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

0000:00:08.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 02)
	Subsystem: ESS Technology: Unknown device 8898
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9000 [size=64]
	Region 1: I/O ports at 9050 [size=16]
	Region 2: I/O ports at 9070 [size=16]
	Region 3: I/O ports at 9090 [size=4]
	Region 4: I/O ports at 90a4 [size=4]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev 20) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1009
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 4: I/O ports at 7090 [size=16]

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU] (rev 09)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1009
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:13.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1009
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 81a00000 (32-bit, non-prefetchable) [size=4K]

0000:01:00.0 VGA compatible controller: Trident Microsystems Cyber 9525 (rev 49) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1009
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 80800000 (32-bit, non-prefetchable) [size=4M]
	Region 1: Memory at 80500000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at 80c00000 (32-bit, non-prefetchable) [size=4M]
	Expansion ROM at 80520000 [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 Ethernet controller: 3Com Corporation: Unknown device 0013 (rev 01)
	Subsystem: 3Com Corporation: Unknown device 1026
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10800000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


--FL5UXtIhxfXey3p5--
