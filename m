Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVDAQoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVDAQoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVDAQoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:44:06 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:14560 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262785AbVDAQni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:43:38 -0500
Date: Fri, 1 Apr 2005 18:43:21 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: dtor_core@ameritech.net
Cc: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Touchpad does not work anymore
Message-ID: <20050401164321.GN10278@ens-lyon.fr>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com> <20050331165007.GA29674@pern.dea.icai.upco.es> <200503311309.50165.dtor_core@ameritech.net> <40f323d0050401081423650536@mail.gmail.com> <d120d5000504010828152031a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <d120d5000504010828152031a@mail.gmail.com>
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2005 at 11:28:05AM -0500, Dmitry Torokhov wrote:
> On Apr 1, 2005 11:14 AM, Benoit Boissinot <bboissin@gmail.com> wrote:
> > On Mar 31, 2005 8:09 PM, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > It works, too. Which one is the best one?
> > > >
> > >
> > > Both of them are needed as they address two different problems.
> > >
> > I tried to boot with the 2 patches applied (and the patch which solves
> > noresume) and now touchpad/touchpoint no longer works (with this
> > kernel or with an older kernel).
> > 
> 
> Could you be more explicit - it is not recognized at all or it is
> recognized but mouse pointer does not move or something else? dmesg
> also might be interesting.
> 
It is recognized in dmesg (same message as before), but the mouse
pointer does not move (a `cat /dev/input/mice` doesn't do anything).

By the way, it is a dell D600.
> Also, the 2nd "patch" was never published, could you post what exactly
> you have applied?
> 
attached

> Thanks!
> 
> -- 
> Dmitry

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.12-rc1-mm4__alps_1.patch"

Input: serio - do not attempt to immediately disconnect port if
       resume failed, let kseriod take care of it. Otherwise we
       may attempt to unregister associated input devices which
       will generate hotplug events which are not handled well
       during swsusp.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |    1 -
 1 files changed, 1 deletion(-)

Index: dtor/drivers/input/serio/serio.c
===================================================================
--- dtor.orig/drivers/input/serio/serio.c
+++ dtor/drivers/input/serio/serio.c
@@ -779,7 +779,6 @@ static int serio_resume(struct device *d
 	struct serio *serio = to_serio_port(dev);
 
 	if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
-		serio_disconnect_port(serio);
 		/*
 		 * Driver re-probing can take a while, so better let kseriod
 		 * deal with it.

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.12-rc1-mm4__alps_2.patch"

--- ./drivers/input/mouse/alps.c.orig	2005-03-31 12:35:55.000000000 -0500
+++ ./drivers/input/mouse/alps.c	2005-03-31 12:36:50.000000000 -0500
@@ -341,6 +341,8 @@ static int alps_reconnect(struct psmouse
 	unsigned char param[4];
 	int version;
 
+	psmouse_reset(psmouse);
+
 	if (!(priv->i = alps_get_model(psmouse, &version)))
 		return -1;
 

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.12-rc1-mm4_noresume.patch"

--- clean/kernel/power/swsusp.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-04-01 00:23:15.000000000 +0200
@@ -1376,16 +1371,6 @@
 {
 	int error;
 
-	if (!swsusp_resume_device) {
-		if (!strlen(resume_file))
-			return -ENOENT;
-		swsusp_resume_device = name_to_dev_t(resume_file);
-		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
-	} else {
-		pr_debug("swsusp: Resume From Partition %d:%d\n",
-			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
-	}
-
 	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
--- clean/kernel/power/disk.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/power/disk.c	2005-04-01 00:23:09.000000000 +0200
@@ -233,6 +237,16 @@
 {
 	int error;
 
+	if (!swsusp_resume_device) {
+		if (!strlen(resume_file))
+			return -ENOENT;
+		swsusp_resume_device = name_to_dev_t(resume_file);
+		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
+	} else {
+		pr_debug("swsusp: Resume From Partition %d:%d\n",
+			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+	}
+
 	if (noresume) {
 		/**
 		 * FIXME: If noresume is specified, we need to find the partition


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.log"

0000:00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O Controller (rev 03)
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	Expansion ROM at 0000c000 [disabled] [size=4K]

0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bf80 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bf40 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bf20 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Dell: Unknown device 011d
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at f4fffc00 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: f6000000-fbffffff
	Expansion ROM at 0000d000 [disabled] [size=8K]

0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 01)
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at bfa0 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
	Subsystem: Dell: Unknown device 011d
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at b800
	I/O ports at bc40 [size=64]
	Memory at f4fff800 (32-bit, non-prefetchable) [size=512]
	Memory at f4fff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [FireGL 9000] (rev 02) (prog-if 00 [VGA])
	Subsystem: Dell: Unknown device 011d
	Flags: bus master, VGA palette snoop, stepping, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at e8000000 (32-bit, prefetchable)
	I/O ports at c000 [size=256]
	Memory at fcff0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M Gigabit Ethernet (rev 01)
	Subsystem: Dell: Unknown device 865d
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at faff0000 (64-bit, non-prefetchable)
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

0000:02:01.0 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controller (rev 20)
	Subsystem: Dell: Unknown device 011d
	Flags: slow devsel, IRQ 255
	Memory at f6000000 (32-bit, non-prefetchable) [disabled]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	16-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controller (rev 20)
	Subsystem: Dell: Unknown device 011d
	Flags: slow devsel, IRQ 255
	Memory at f6001000 (32-bit, non-prefetchable) [disabled]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	16-bit legacy interface ports at 0001

0000:02:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2722
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at fafef000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"

6
[   18.508803] PCI: Using configuration type 1
[   18.508807] mtrr: v2.0 (20020519)
[   18.509116] ACPI: Subsystem revision 20050309
[   18.526338] ACPI: Interpreter enabled
[   18.526343] ACPI: Using PIC for interrupt routing
[   18.527648] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   18.527653] PCI: Probing PCI hardware (bus 00)
[   18.527803] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[   18.527809] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   18.540094] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   18.540210] Boot video device is 0000:01:00.0
[   18.540547] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   18.556306] ACPI: Can't get handler for 0000:02:03.0
[   18.565831] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[   18.566113] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
[   18.566393] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[   18.566684] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
[   18.566950] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   18.567235] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   18.568597] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   18.569355] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[   18.570369] Linux Plug and Play Support v0.97 (c) Adam Belay
[   18.570379] pnp: PnP ACPI init
[   18.576224] ACPI: No ACPI bus support for 00:00
[   18.576295] ACPI: No ACPI bus support for 00:01
[   18.576355] ACPI: No ACPI bus support for 00:02
[   18.576416] ACPI: No ACPI bus support for 00:03
[   18.576484] ACPI: No ACPI bus support for 00:04
[   18.576545] ACPI: No ACPI bus support for 00:05
[   18.576607] ACPI: No ACPI bus support for 00:06
[   18.576673] ACPI: No ACPI bus support for 00:07
[   18.576735] ACPI: No ACPI bus support for 00:08
[   18.576794] ACPI: No ACPI bus support for 00:09
[   18.584348] ACPI: No ACPI bus support for 00:0a
[   18.595098] ACPI: No ACPI bus support for 00:0b
[   18.598177] pnp: PnP ACPI: found 12 devices
[   18.598293] SCSI subsystem initialized
[   18.598301] PCI: Using ACPI for IRQ routing
[   18.598305] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   18.604189] pnp: 00:01: ioport range 0x4d0-0x4d1 has been reserved
[   18.604195] pnp: 00:01: ioport range 0x800-0x805 could not be reserved
[   18.604200] pnp: 00:01: ioport range 0x808-0x80f could not be reserved
[   18.604206] pnp: 00:02: ioport range 0xf400-0xf4fe has been reserved
[   18.604211] pnp: 00:02: ioport range 0x806-0x807 has been reserved
[   18.604216] pnp: 00:02: ioport range 0x810-0x85f could not be reserved
[   18.604221] pnp: 00:02: ioport range 0x860-0x87f has been reserved
[   18.604225] pnp: 00:02: ioport range 0x880-0x8bf has been reserved
[   18.604230] pnp: 00:02: ioport range 0x8c0-0x8df has been reserved
[   18.604237] pnp: 00:07: ioport range 0x900-0x97f has been reserved
[   18.604717] inotify device minor=63
[   18.604788] Initializing Cryptographic API
[   18.604856] vesafb: framebuffer at 0xe8000000, mapped to 0xe0880000, using 3072k, total 32704k
[   18.604863] vesafb: mode is 1024x768x16, linelength=2048, pages=20
[   18.604868] vesafb: protected mode interface info at c000:57f3
[   18.604872] vesafb: scrolling: redraw
[   18.604877] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   18.623647] Console: switching to colour frame buffer device 128x48
[   18.623768] fb0: VESA VGA frame buffer device
[   18.623857] ACPI: No ACPI bus support for vesafb.0
[   18.633858] Real Time Clock Driver v1.12
[   18.633937] Linux agpgart interface v0.101 (c) Dave Jones
[   18.634062] agpgart: Detected an Intel 855PM Chipset.
[   18.641294] agpgart: AGP aperture is 128M @ 0xe0000000
[   18.641498] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   18.642088] ACPI: No ACPI bus support for i8042
[   18.645598] serio: i8042 AUX port at 0x60,0x64 irq 12
[   18.645901] serio: i8042 KBD port at 0x60,0x64 irq 1
[   18.645999] io scheduler noop registered
[   18.646097] io scheduler anticipatory registered
[   18.646194] io scheduler deadline registered
[   18.646290] io scheduler cfq registered
[   18.646435] ACPI: No ACPI bus support for serio0
[   18.646568] ACPI: No ACPI bus support for serio1
[   18.646888] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   18.647151] loop: loaded (max 8 devices)
[   18.650574] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   18.654035] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   18.657621] ICH4: IDE controller at PCI slot 0000:00:1f.1
[   18.661210] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   18.665048] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   18.668577] PCI: setting IRQ 11 as level-triggered
[   18.672066] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   18.675752] ICH4: chipset revision 1
[   18.679468] ICH4: not 100% native mode: will probe irqs later
[   18.683257]     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
[   18.687155]     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
[   18.691013] Probing IDE interface ide0...
[   18.954246] hda: TOSHIBA MK4026GAX, ATA DISK drive
[   19.569546] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   19.573502] ACPI: No ACPI bus support for 0.0
[   19.577513] Probing IDE interface ide1...
[   20.247950] hdc: SAMSUNG CDRW/DVD SN-324S, ATAPI CD/DVD-ROM drive
[   20.863727] ide1 at 0x170-0x177,0x376 on irq 15
[   20.867818] ACPI: No ACPI bus support for 1.0
[   20.872278] Probing IDE interface ide2...
[   21.384655] Probing IDE interface ide3...
[   21.896142] Probing IDE interface ide4...
[   22.407630] Probing IDE interface ide5...
[   22.919144] hda: max request size: 128KiB
[   22.971492] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[   22.975640] hda: cache flushes supported
[   22.979671]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   23.021608] mice: PS/2 mouse device common for all mice
[   23.025661] NET: Registered protocol family 2
[   23.039036] IP: routing cache hash table of 4096 buckets, 32Kbytes
[   23.043235] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[   23.047500] TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
[   23.051766] TCP: Hash tables configured (established 32768 bind 32768)
[   23.055960] NET: Registered protocol family 1
[   23.060127] NET: Registered protocol family 17
[   23.066215] input: AT Translated Set 2 keyboard on isa0060/serio0
[   23.077795] swsusp: Suspend partition has wrong signature?
[   23.082202] ACPI wakeup devices: 
[   23.086246]  LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
[   23.090435] ACPI: (supports S0 S1 S3 S4 S4bios S5)
[   23.110487] ReiserFS: hda5: found reiserfs format "3.6" with standard journal
[   23.484348] alps.c: Enabling hardware tapping
[   23.588753] input: PS/2 Mouse on isa0060/serio1
[   23.593089] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
[   23.973445] ReiserFS: hda5: using ordered data mode
[   23.990947] ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   24.000692] ReiserFS: hda5: checking transaction log (hda5)
[   24.066666] ReiserFS: hda5: Using r5 hash to sort names
[   24.071305] VFS: Mounted root (reiserfs filesystem) readonly.
[   24.076006] Freeing unused kernel memory: 176k freed
[   26.054531] Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1
[   31.144944] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   31.144952] Uniform CD-ROM driver Revision: 3.20
[   31.155207] Linux video capture interface: v1.00
[   31.162797] usbcore: registered new driver usbfs
[   31.163078] usbcore: registered new driver hub
[   31.168621] usbcore: registered new driver spca5xx
[   31.168626] /var/tmp/portage/spca5xx-20050328/work/spca5xx-20050328/drivers/usb/spca5xx.c: spca5xx driver 56.03.27 registered
[   31.177572] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
[   31.177577] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
[   31.177591] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   31.177596] ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
[   31.178108] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   31.178118] ehci_hcd 0000:00:1d.7: irq 11, io mem 0xf4fffc00
[   31.181997] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   31.182004] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[   31.182044] ACPI: No ACPI bus support for usb1
[   31.182331] hub 1-0:1.0: USB hub found
[   31.182338] hub 1-0:1.0: 6 ports detected
[   31.202827] ACPI: No ACPI bus support for 1-0:1.0
[   31.210909] USB Universal Host Controller Interface driver v2.2
[   31.211011] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   31.211025] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   31.211029] uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[   31.273036] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   31.273045] uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
[   31.273101] ACPI: No ACPI bus support for usb2
[   31.273369] hub 2-0:1.0: USB hub found
[   31.273375] hub 2-0:1.0: 2 ports detected
[   31.275752] ACPI: No ACPI bus support for 2-0:1.0
[   31.276264] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[   31.276267] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   31.276276] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   31.276280] uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[   31.337943] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   31.337949] uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
[   31.337991] ACPI: No ACPI bus support for usb3
[   31.338250] hub 3-0:1.0: USB hub found
[   31.338255] hub 3-0:1.0: 2 ports detected
[   31.340684] ACPI: No ACPI bus support for 3-0:1.0
[   31.341159] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   31.341162] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   31.341169] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   31.341173] uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[   31.402915] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   31.402921] uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
[   31.402966] ACPI: No ACPI bus support for usb4
[   31.403229] hub 4-0:1.0: USB hub found
[   31.403234] hub 4-0:1.0: 2 ports detected
[   31.405619] ACPI: No ACPI bus support for 4-0:1.0
[   31.413313] ACPI: AC Adapter [AC] (on-line)
[   31.690355] ACPI: Battery Slot [BAT0] (battery present)
[   31.690405] ACPI: Battery Slot [BAT1] (battery absent)
[   31.699185] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[   31.699192] ACPI: Processor [CPU0] (supports 8 throttling states)
[   31.703496] ACPI: Thermal Zone [THM] (51 C)
[   31.710386] ACPI: Lid Switch [LID]
[   31.710395] ACPI: Power Button (CM) [PBTN]
[   31.710401] ACPI: Sleep Button (CM) [SBTN]
[   31.916988] acpi-cpufreq: CPU0 - ACPI performance management activated.
[   36.041346] kjournald starting.  Commit interval 5 seconds
[   36.041358] EXT3-fs: mounted filesystem with ordered data mode.
[   36.069604] ReiserFS: hda6: found reiserfs format "3.6" with standard journal
[   38.155473] ReiserFS: hda6: using ordered data mode
[   38.180417] ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.181033] ReiserFS: hda6: checking transaction log (hda6)
[   38.221445] ReiserFS: hda6: Using r5 hash to sort names
[   42.687110] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[   42.687117] PCI: setting IRQ 5 as level-triggered
[   42.687121] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   42.687147] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   42.721904] ip_conntrack version 2.1 (4093 buckets, 32744 max) - 216 bytes per conntrack
[   42.773169] ip_tables: (C) 2000-2002 Netfilter core team
[   43.493021] intel8x0_measure_ac97_clock: measured 49457 usecs
[   43.493025] intel8x0: clocking to 48000
[   45.940689] tg3.c:v3.25 (March 24, 2005)
[   45.940715] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   45.971608] eth0: Tigon3 [partno(BCM95705A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0f:1f:ca:d7:a8
[   45.971616] eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   49.482779] mtrr: 0xe8000000,0x2000000 overlaps existing 0xe8000000,0x1000000
[   49.574873] [drm] Initialized drm 1.0.0 20040925
[   49.586525] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   49.594325] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon R250 Lf [FireGL 9000]
[   49.594807] mtrr: 0xe8000000,0x2000000 overlaps existing 0xe8000000,0x1000000
[   49.595102] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   49.595116] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[   49.595141] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[   49.897054] [drm] Loading R200 Microcode
[  263.594171] usbcore: registered new driver usbhid
[  263.594178] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[  272.002389] usb 3-1: new low speed USB device using uhci_hcd and address 2
[  272.128166] ACPI: No ACPI bus support for 3-1
[  272.149874] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
[  272.149886] ACPI: No ACPI bus support for 3-1:1.0
[  276.588418] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  276.588437] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  276.588472] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  276.588504] [drm] Loading R200 Microcode
[  289.241793] usb 3-1: USB disconnect, address 2
[  296.167837] usb 3-1: new low speed USB device using uhci_hcd and address 3
[  296.355719] ACPI: No ACPI bus support for 3-1
[  296.377779] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
[  296.377790] ACPI: No ACPI bus support for 3-1:1.0
[  345.764905] ieee80211_crypt: registered algorithm 'NULL'
[  345.771622] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.2
[  345.771627] ipw2200: Copyright(c) 2003-2004 Intel Corporation
[  345.772634] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[  345.772668] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[  354.982419] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  354.982437] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  354.982462] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  354.982493] [drm] Loading R200 Microcode
[ 1562.466229] usb 3-1: USB disconnect, address 3
[ 1581.879764] usb 3-1: new low speed USB device using uhci_hcd and address 4
[ 1582.067646] ACPI: No ACPI bus support for 3-1
[ 1582.089724] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
[ 1582.089737] ACPI: No ACPI bus support for 3-1:1.0

--ADZbWkCsHQ7r3kzd--
