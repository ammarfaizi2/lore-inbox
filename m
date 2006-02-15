Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWBOKap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWBOKap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWBOKap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:30:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:42894 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750984AbWBOKao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:30:44 -0500
Date: Wed, 15 Feb 2006 11:30:41 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Roger Leigh <rleigh@whinlatter.ukfsn.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
Message-ID: <20060215103041.GA570@suse.de>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org> <1139779983.5247.39.camel@localhost.localdomain> <87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org> <1139870065.5237.26.camel@localhost.localdomain> <17394.48045.253033.885865@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <17394.48045.253033.885865@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

 On Wed, Feb 15, Paul Mackeras wrote:

> Benjamin Herrenschmidt writes:
> 
> > Ok, does not using NTP fixes it ?
> 
> Try this patch.  With this the values from gettimeofday() or the VDSO
> should stay exactly in sync with xtime even if NTP is adjusting the
> clock.
> 
> This patch still has quite a few debugging printks in it, so it's not
> final by any means.  I'll be interested to hear how it goes, and in
> particular whether or not you see any "oops, time got ahead" messages.

This fixes my hang during boot.

--- bad.txt	2006-02-03 12:01:24.000000000 +0100
+++ good.txt	2006-02-03 11:47:59.000000000 +0100
@@ -34,12 +34,20 @@
 GMT Delta read from XPRAM: 120 minutes, DST: on
 time_init: decrementer frequency = 33.290001 MHz
 time_init: processor frequency   = 466.666665 MHz
+HZ = 250 tb_freq = 33290001 tick_nsec = 4000000
+tb_to_xs = 810448dc5c2ca70 (old way)
+ticklen_to_xs = 0 10e9155d07742ee3
+tb_to_xs = 8104491d617e483 (new way)
 Console: colour dummy device 80x25
 pmac_zilog: i2c-modem detected, id: 1
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
+oops, time got ahead: 1138967190.003999 > 1138959990.000000000
+  xtime was 0.000000000 tb was 0 tick 909725147
+  tlen 0x3d0900000 tb now 909726490 tpj 133160
+  gtod tbstamp 909591987 xsec 0x43e3429600000 t2x 0x8104491d617e483
 High memory: 0k
-Memory: 251768k/262144k available (3416k kernel code, 10064k reserved, 556k data, 467k bss, 196k init)
+Memory: 251768k/262144k available (3420k kernel code, 10072k reserved, 556k data, 467k bss, 196k init)
 Calibrating delay loop... 66.30 BogoMIPS (lpj=132608)
 Security Framework v1.0.0 initialized
 Mount-cache hash table entries: 512
@@ -71,7 +79,7 @@
 TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
 Thermal assist unit using timers, shrink_timer: 500 jiffies
 audit: initializing netlink socket (disabled)
-audit(1138960784.708:1): initialized
+audit(1138959990.708:1): initialized
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Initializing Cryptographic API
@@ -198,8 +206,8 @@
 ide-floppy driver 0.99.newide
 hdd: No disk in drive
 hdd: 0kB, 0/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
-device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
-dm-netlink version 0.0.2 loaded
+hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, (U)DMA
+Uniform CD-ROM driver Revision: 3.20
 USB Universal Host Controller Interface driver v2.3
 PCI: Enabling device 0001:10:12.0 (0014 -> 0015)
 PCI: Via IRQ fixup for 0001:10:12.0, from 52 to 4
@@ -241,34 +249,36 @@
 usb usb5: configuration #1 chosen from 1 choice
 hub 5-0:1.0: USB hub found
 hub 5-0:1.0: 4 ports detected
-hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, (U)DMA
-Uniform CD-ROM driver Revision: 3.20
 8139too Fast Ethernet driver 0.9.27
+sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
 PCI: Enabling device 0001:10:14.0 (0004 -> 0007)
-eth0: RealTek RTL8139 at 0xd106e000, 00:50:fc:76:65:12, IRQ 54
+eth0: RealTek RTL8139 at 0xd105a000, 00:50:fc:76:65:12, IRQ 54
 eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
-8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
-sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
 PHY ID: 206053, addr: 0
+eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:f3:4c:ae 
+eth1: Found BCM5401 PHY
+8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
 ieee1394: Initialized config rom entry `ip1394'
+JBD: barrier-based sync failed on hda13 - disabling barriers
 PCI: Enabling device 0001:10:12.3 (0090 -> 0093)
 PCI: Via IRQ fixup for 0001:10:12.3, from 52 to 4
 ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[52]  MMIO=[80084000-800847ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
-eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:f3:4c:ae 
-eth1: Found BCM5401 PHY
 ohci1394: fw-host1: Unexpected PCI resource length of 1000!
 ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
-JBD: barrier-based sync failed on hda13 - disabling barriers
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006685]
-ieee1394: Host added: ID:BUS[1-00:1023]  GUID[003065fffef34cae]
 eth1: Link is up at 100 Mbps, full-duplex.
+ieee1394: Host added: ID:BUS[1-00:1023]  GUID[003065fffef34cae]
+device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
+dm-netlink version 0.0.2 loaded
+hdd: No disk in drive
 loop: loaded (max 8 devices)
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hda14, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 AppArmor: AppArmor (version 2.0-19.43r6152) initialized
-audit(1138960811.468:2): AppArmor (version 2.0-19.43r6152) initialized
+audit(1138960018.908:2): AppArmor (version 2.0-19.43r6152) initialized
 
+do_settimeofday(1138963619.000000000)
 eth1: Link is up at 100 Mbps, full-duplex.
 eth1: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
 NET: Registered protocol family 10

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="good.txt"

Total memory = 256MB; using 512kB for hash table (at cff80000)
Linux version 2.6.16-rc3-git3-20060215_bug149895-default (geeko@buildhost) (gcc version 4.1.0 20060210 (prerelease) (SUSE Linux)) #1 Wed Feb 15 00:20:20 UTC 2006
Found initrd at 0xc0a00000:0xc0c2a000
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerMac G4 Silver
Using native/NAP idle loop
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=348, gen1=347
nvram: Active bank is: 0
nvram: OF partition at 0x210
nvram: XP partition at 0x1220
nvram: NR partition at 0x1320
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:15
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: root=/dev/hda13  quiet video=aty128fb:1024x768@85 sysrq=1 
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
PID hash table entries: 2048 (order: 11, 32768 bytes)
GMT Delta read from XPRAM: 120 minutes, DST: on
time_init: decrementer frequency = 33.290001 MHz
time_init: processor frequency   = 466.666665 MHz
HZ = 250 tb_freq = 33290001 tick_nsec = 4000000
tb_to_xs = 810448dc5c2ca70 (old way)
ticklen_to_xs = 0 10e9155d07742ee3
tb_to_xs = 8104491d617e483 (new way)
Console: colour dummy device 80x25
pmac_zilog: i2c-modem detected, id: 1
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
oops, time got ahead: 1138967190.003999 > 1138959990.000000000
  xtime was 0.000000000 tb was 0 tick 909725147
  tlen 0x3d0900000 tb now 909726490 tpj 133160
  gtod tbstamp 909591987 xsec 0x43e3429600000 t2x 0x8104491d617e483
High memory: 0k
Memory: 251768k/262144k available (3420k kernel code, 10072k reserved, 556k data, 467k bss, 196k init)
Calibrating delay loop... 66.30 BogoMIPS (lpj=132608)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
device-tree: property "l2-cache" name conflicts with node in /cpus/PowerPC,G4@0
checking if image is initramfs... it is
Freeing initrd memory: 2216k freed
NET: Registered protocol family 16
KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
 channel 0 bus <multibus>
PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000
 channel 1 bus <multibus>
 channel 2 bus <multibus>
Installing base platform functions...
Installing MMIO functions for macio /pci@f2000000/mac-io@17
Installing GPIO functions for macio /pci@f2000000/mac-io@17
Calling initial GPIO functions for macio /pci@f2000000/mac-io@17
Installing functions for UniN /uni-n@f8000000
All base functions installed
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 4 of device 0001:10:12.0
PCI: Cannot allocate resource region 4 of device 0001:10:12.1
PCI: Cannot allocate resource region 1 of device 0001:10:12.3
PCI: Cannot allocate resource region 0 of device 0001:10:14.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Thermal assist unit using timers, shrink_timer: 500 jiffies
audit: initializing netlink socket (disabled)
audit(1138959990.708:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Invalid ROM signature 1111 should  be 0xaa55
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 PF PRO AGP [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Internal modem
ttyS1 at MMIO 0x80013000 (irq = 50) is a Z85c30 ESCC - Serial port
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
MacIO PCI driver attached to Keylargo chipset
input: Macintosh mouse button emulation as /class/input/input0
apm_emu: APM Emulation 0.5 initialized.
adb: starting probe task...
adb: finished probe task...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: Maxtor 33073H3 B, ATA DISK drive
hda: Enabling Ultra DMA 4
ide0 at 0xd1024000-0xd1024007,0xd1024160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: Enabling MultiWord DMA 2
ide1 at 0xd1026000-0xd1026007,0xd1026160 on irq 20
ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
Probing IDE interface ide2...
Probing IDE interface ide2...
hda: max request size: 128KiB
hda: 60032448 sectors (30736 MB) w/2048KiB Cache, CHS=59556/16/63, UDMA(66)
hda: cache flushes not supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0001:10:18.0 (0000 -> 0002)
ohci_hcd 0001:10:18.0: OHCI Host Controller
ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:10:18.0: irq 27, io mem 0x80083000
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc3-git3-20060215_bug149895-default ohci_hcd
usb usb1: SerialNumber: 0001:10:18.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:19.0 (0000 -> 0002)
ohci_hcd 0001:10:19.0: OHCI Host Controller
ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:10:19.0: irq 28, io mem 0x80082000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc3-git3-20060215_bug149895-default ohci_hcd
usb usb2: SerialNumber: 0001:10:19.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using ohci_hcd and address 2
usb 1-1: new device found, idVendor=05ac, idProduct=1001
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: Hub in Apple USB Keyboard
usb 1-1: Manufacturer: Alps Electric
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
usb 1-1.1: new low speed USB device using ohci_hcd and address 3
usb 1-1.1: new device found, idVendor=05ac, idProduct=0202
usb 1-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.1: Product: Apple USB Keyboard
usb 1-1.1: Manufacturer: Alps Electric
usb 1-1.1: configuration #1 chosen from 1 choice
usb 1-1.3: new low speed USB device using ohci_hcd and address 4
usb 1-1.3: new device found, idVendor=05ac, idProduct=0307
usb 1-1.3: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.3: Product: Apple Optical USB Mouse
usb 1-1.3: Manufacturer: Logitech
usb 1-1.3: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Alps Electric Apple USB Keyboard as /class/input/input1
input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:10:18.0-1.1
input: Logitech Apple Optical USB Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:18.0-1.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus uni-n 1 registered
PowerMac i2c bus uni-n 0 registered
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP westwood registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 196k init
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 131064k swap on /dev/hda12.  Priority:-1 extents:1 across:131064k
EXT3 FS on hda13, internal journal
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple UniNorth 1.5 chipset
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 0kB, 0/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
USB Universal Host Controller Interface driver v2.3
PCI: Enabling device 0001:10:12.0 (0014 -> 0015)
PCI: Via IRQ fixup for 0001:10:12.0, from 52 to 4
uhci_hcd 0001:10:12.0: UHCI Host Controller
uhci_hcd 0001:10:12.0: new USB bus registered, assigned bus number 3
uhci_hcd 0001:10:12.0: irq 52, io base 0x00010000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-rc3-git3-20060215_bug149895-default uhci_hcd
usb usb3: SerialNumber: 0001:10:12.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:12.1 (0014 -> 0015)
PCI: Via IRQ fixup for 0001:10:12.1, from 52 to 4
uhci_hcd 0001:10:12.1: UHCI Host Controller
uhci_hcd 0001:10:12.1: new USB bus registered, assigned bus number 4
uhci_hcd 0001:10:12.1: irq 52, io base 0x00010020
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-rc3-git3-20060215_bug149895-default uhci_hcd
usb usb4: SerialNumber: 0001:10:12.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:12.2 (0014 -> 0016)
PCI: Via IRQ fixup for 0001:10:12.2, from 52 to 4
ehci_hcd 0001:10:12.2: EHCI Host Controller
ehci_hcd 0001:10:12.2: new USB bus registered, assigned bus number 5
ehci_hcd 0001:10:12.2: irq 52, io mem 0x80081000
ehci_hcd 0001:10:12.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: EHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.16-rc3-git3-20060215_bug149895-default ehci_hcd
usb usb5: SerialNumber: 0001:10:12.2
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
8139too Fast Ethernet driver 0.9.27
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PCI: Enabling device 0001:10:14.0 (0004 -> 0007)
eth0: RealTek RTL8139 at 0xd105a000, 00:50:fc:76:65:12, IRQ 54
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
PHY ID: 206053, addr: 0
eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:f3:4c:ae 
eth1: Found BCM5401 PHY
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ieee1394: Initialized config rom entry `ip1394'
JBD: barrier-based sync failed on hda13 - disabling barriers
PCI: Enabling device 0001:10:12.3 (0090 -> 0093)
PCI: Via IRQ fixup for 0001:10:12.3, from 52 to 4
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[52]  MMIO=[80084000-800847ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
ohci1394: fw-host1: Unexpected PCI resource length of 1000!
ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006685]
eth1: Link is up at 100 Mbps, full-duplex.
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[003065fffef34cae]
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
dm-netlink version 0.0.2 loaded
hdd: No disk in drive
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
AppArmor: AppArmor (version 2.0-19.43r6152) initialized
audit(1138960018.908:2): AppArmor (version 2.0-19.43r6152) initialized

do_settimeofday(1138963619.000000000)
eth1: Link is up at 100 Mbps, full-duplex.
eth1: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
JBD: barrier-based sync failed on hda13 - disabling barriers
JBD: barrier-based sync failed on hda13 - disabling barriers

--ikeVEW9yuYc//A+q--
