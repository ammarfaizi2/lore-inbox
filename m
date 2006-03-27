Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWC0USM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWC0USM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWC0USM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:18:12 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:42636 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751122AbWC0USL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:18:11 -0500
Date: Mon, 27 Mar 2006 22:17:43 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] PS/2-mouse not found in 2.6.16
Message-ID: <Pine.LNX.4.58.0603272148050.2266@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.6.16, my Logitech mouse is no longer detected (not reported 
in dmesg, not working).

The config was created using make oldconfig, and all relevant symbols seem 
to be set: $ grep -i mouse .config
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_USB_IDMOUSE is not set

The only additional patch is moving a sg ioctl to scsi.
The last known working kernel is 2.6.15.4. None inbetween was tested.

Trimmed lspci output (2.6.15.4):
--------------------------------------------------------------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
[...]

dmesg from 2.6.16 (no mouse):
---------------------------------------------------------------------------------
[...]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
PCI quirk: region 5000-500f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[...]
Applying VIA southbridge workaround.
[...]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport_pc: VIA parallel port: io=0x378, irq=7
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
[...]
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 2F040L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

.oO(Shouldn't ide0 be found before hda?)
[...]
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usbhid
/home/7eggert/l/linux/2.6.16/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
/home/7eggert/l/linux/2.6.16/drivers/usb/serial/usb-serial.c: USB Serial Driver core
/home/7eggert/l/linux/2.6.16/drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new driver pl2303
/home/7eggert/l/linux/2.6.16/drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
[...]
input: Multisystem joystick (2 fire) as /class/input/input2
[...]

diff -u to the working (2.6.15.4) kernel dmesg output, also trimmed:
-------------------------------------------------------------------------------------
--- nomouse	2006-03-27 21:38:27.000000000 +0200
+++ mouse	2006-03-27 21:42:58.000000000 +0200
@@ -68,16 +77,16 @@
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
 agpgart: AGP aperture is 64M @ 0xe0000000
-[drm] Initialized drm 1.0.1 20051102
+[drm] Initialized drm 1.0.0 20040925
 PCI: Found IRQ 9 for device 0000:00:09.0
 PCI: Sharing IRQ 9 with 0000:00:0d.0
-[drm] Initialized tdfx 1.0.0 20010216 on minor 0
-[drm] Initialized radeon 1.22.0 20051229 on minor 1
+[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 
+[drm] Initialized radeon 1.19.0 20050911 on minor 1: 
 Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
 Hangcheck: Using monotonic_clock().
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
-Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
+Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 parport_pc: VIA 686A/8231 detected
@@ -204,32 +201,32 @@
[...]
 mice: PS/2 mouse device common for all mice
-input: AT Translated Set 2 keyboard as /class/input/input0
-input: PC Speaker as /class/input/input1
+input: PC Speaker as /class/input/input0
 i2c /dev entries driver
-device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
+input: AT Translated Set 2 keyboard as /class/input/input1
+input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
[...]
@@ -293,7 +289,7 @@
 bttv: Overlay support disabled.
 bttv0: registered device video0
 bttv0: registered device vbi0
-input: Multisystem joystick (2 fire) as /class/input/input2
+input: Multisystem joystick (2 fire) as /class/input/input3
 process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
 hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
 hdd: drive_cmd: error=0x04 { AbortedCommand }

-- 
Funny quotes:
14. Eagles may soar, but weasels don't get sucked into jet engines.
