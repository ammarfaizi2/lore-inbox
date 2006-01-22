Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWAVXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWAVXng (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWAVXng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 18:43:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:43928 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964790AbWAVXng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 18:43:36 -0500
Subject: uevent buffer overflow in input layer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 10:43:41 +1100
Message-Id: <1137973421.4907.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current -git as of today does this on an x86 box with a logitech USB
keyboard:

(the $$$ is debug stuff I added to print_modalias(), size is the size
passed in and "Total len" is the value of "len" before returning). We
end up overflowing, thus we pass a negative size to snprintf which
causes the WARN_ON. Bumping the uevent buffer size in lib/kobject_uevent.c
from 1024 to 2048 seems to fix the oops and /dev/input/mice is now properly
created and works (it doesn't without the fix, X fails and we end up back
in console with a dead keyboard).

I'm not sure it's the correct solution as I'm not too familiar with the
uevent code though, so I'll let you guys decide on the proper approach.

$$$ print_modalias, size: 652
input:b0003v046DpC505e1711-Total len: 167
input: Logitech USB Receiver as /class/input/input0
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1d.7-1.1
$$$ print_modalias, size: 610
input:b0003v046DpC505e1711-Badness in vsnprintf at lib/vsprintf.c:279
 [<c01ff955>] vsnprintf+0x625/0x630
 [<c01ff689>] vsnprintf+0x359/0x630
 [<c01ff9cb>] snprintf+0x2b/0x30
 [<c02a9214>] print_modalias_bits+0x94/0xb0
 [<c02a9301>] print_modalias+0xd1/0x210
 [<c02a9a8e>] input_dev_uevent+0x23e/0x4a0
 [<c02a9850>] input_dev_uevent+0x0/0x4a0
 [<c026ade4>] class_uevent+0x194/0x220
 [<c026ac50>] class_uevent+0x0/0x220
 [<c01fcc58>] kobject_uevent+0x1e8/0x4b0
 [<c026a989>] class_device_add+0x199/0x320
 [<c01ff9cb>] snprintf+0x2b/0x30
 [<c02aad7c>] input_register_device+0x11c/0x2e0
 [<c02a7288>] hidinput_connect+0x298/0x1cb0
 [<c02a4aa6>] hid_probe+0x9d6/0xeb0
 [<c032ae9a>] __mutex_unlock_slowpath+0x5a/0x170
 [<c019de26>] sysfs_create_link+0xe6/0x150
 [<c028ee9f>] usb_probe_interface+0x6f/0xb0
 [<c0269764>] driver_probe_device+0x54/0xf0
 [<c0269880>] __driver_attach+0x0/0x70
 [<c02698e7>] __driver_attach+0x67/0x70
 [<c0268b3d>] bus_for_each_dev+0x5d/0x80
 [<c02695e5>] driver_attach+0x25/0x30
 [<c0269880>] __driver_attach+0x0/0x70
 [<c0268f0c>] bus_add_driver+0x8c/0x180
 [<c0269cdb>] driver_register+0x4b/0x90
 [<c028ecf0>] usb_register_driver+0x60/0xf0
 [<c03f15a5>] hiddev_init+0x15/0x20
 [<c03f1558>] hid_init+0x28/0x60
 [<c010030e>] init+0x8e/0x220
 [<c0100280>] init+0x0/0x220
 [<c0101005>] kernel_thread_helper+0x5/0x10
Total len: 613
input: Logitech USB Receiver as /class/input/input1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.7-1.1
$$$ print_modalias, size: 688
input:b0003v045Ep0084e0000-Total len: 60
input: Microsoft Basic Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Microsoft Basic Optical Mouse] on usb-0000:00:1d.7-1.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Jan 22 2006
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 PEX0 PEX1 PEX2 PEX3 HUB0 UAR1 USB0 USB1 USB2 USB3 USBE AC97 AZAL 
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
$$$ print_modalias, size: 652
input:b0003v046DpC505e1711-Total len: 167
$$$ print_modalias, size: 610
input:b0003v046DpC505e1711-Total len: 613
$$$ print_modalias, size: 688
input:b0003v045Ep0084e0000-Total len: 60
Real Time Clock Driver v1.12ac
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915G Chipset.
agpgart: AGP aperture is 256M @ 0x0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
$$$ print_modalias, size: 779
input:b0010v001Fp0001e0100-Total len: 45
input: PC Speaker as /class/input/input3
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v0.13 addr 0xd8020000 irq 169 Yukon-EC (0xb6) rev 1
sky2 eth0: addr 00:30:1b:b7:61:d8
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 233
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
ieee1394: Initialized config rom entry `ip1394'
8139too Fast Ethernet driver 0.9.27
hda: PIONEER DVD-RW DVR-109, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...
ACPI: PCI Interrupt 0000:04:0a.0[A] -> GSI 18 (level, low) -> IRQ 233
PCI: Via IRQ fixup for 0000:04:0a.0, from 5 to 9
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[233]  MMIO=[d8101000-d81017ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:04:09.0[A] -> GSI 17 (level, low) -> IRQ 177
eth1: RealTek RTL8139 at 0xd000, 00:40:95:0b:6c:2b, IRQ 177
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00301bb70000623c]
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Adding 3068372k swap on /dev/sda6.  Priority:-1 extents:1 across:3068372k
EXT3 FS on sda7, internal journal
  Vendor: USB2.0    Model: CF  CardReader    Rev: 9144
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:0: Attached scsi removable disk sdb
  Vendor: USB2.0    Model: CBO CardReader    Rev: 9144
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 4:0:0:1: Attached scsi removable disk sdc
usb-storage: device scan complete
Probing IDE interface ide1...
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hw_random: RNG not detected
sky2 eth0: enabling interface
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (45 C)
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both


