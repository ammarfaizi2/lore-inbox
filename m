Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbTA3RPL>; Thu, 30 Jan 2003 12:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTA3RPL>; Thu, 30 Jan 2003 12:15:11 -0500
Received: from n198ber.planetcomm.net ([64.4.122.98]:34220 "EHLO
	paul.wright.house") by vger.kernel.org with ESMTP
	id <S267550AbTA3RPH>; Thu, 30 Jan 2003 12:15:07 -0500
Subject: [PATCH] USB HardDisk Booting 2.4.20
From: Wesley Wright <wewright@verizonmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Fdp7LEyonpPzyzsYK074"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Jan 2003 12:27:37 -0500
Message-Id: <1043947657.7725.32.camel@steven>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fdp7LEyonpPzyzsYK074
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I recently acquired a USB HardDisk and it seems that the drivers for USB
load after attempts to mount the root partition.  I saw one patch that
just put the root mount code into an endless loop, but didn't like this
solution.

What I've done here is add another kernel config option which indicates
if you have a USB device you with to boot.  If you do then it changes
the module_init's in drivers/usb/usb.c and drivers/usb/storage/usb.c to
__initcall's.  The config option is only enabled when you've selected
"Y" for the USB Mass Storage Device.

My tests show that it seems to work, and I haven't noticed any odd side
affects by initcall-ing the usb devices (concern over this topic is why
I enabled it for static USB MSD only).

Does this seem a reasonable solution, or does anyone have something more
elegant?

-- Wes



--=-Fdp7LEyonpPzyzsYK074
Content-Disposition: attachment; filename=README
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-readme; name=README; charset=ISO-8859-1

This patch adds a config option that, if static USB Mass Storage is selecte=
d,
enabled telling the kernel that you have a bootable USB device (like a Hard
Disk).  It will then try to load the USB device and Mass Storage code
earlier in the boot process so you can mount root USB devices.

Wesley Wright
wewright@verizonmail.com

--=-Fdp7LEyonpPzyzsYK074
Content-Disposition: attachment; filename=usbboot-2.4.20.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=usbboot-2.4.20.patch; charset=ISO-8859-1

diff -urN linux-2.4.20/arch/alpha/defconfig linux-2.4.20-usbboot/arch/alpha=
/defconfig
--- linux-2.4.20/arch/alpha/defconfig	2001-11-19 18:19:42.000000000 -0500
+++ linux-2.4.20-usbboot/arch/alpha/defconfig	2003-01-30 12:18:13.000000000=
 -0500
@@ -690,6 +690,7 @@
 # CONFIG_USB_BLUETOOTH is not set
 # CONFIG_USB_STORAGE is not set
 # CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_BOOT is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
diff -urN linux-2.4.20/arch/i386/defconfig linux-2.4.20-usbboot/arch/i386/d=
efconfig
--- linux-2.4.20/arch/i386/defconfig	2002-11-28 18:53:09.000000000 -0500
+++ linux-2.4.20-usbboot/arch/i386/defconfig	2003-01-30 12:18:13.000000000 =
-0500
@@ -776,6 +776,7 @@
 # CONFIG_USB_BLUETOOTH is not set
 CONFIG_USB_STORAGE=3Dy
 # CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_BOOT is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
diff -urN linux-2.4.20/arch/ia64/defconfig linux-2.4.20-usbboot/arch/ia64/d=
efconfig
--- linux-2.4.20/arch/ia64/defconfig	2002-11-28 18:53:09.000000000 -0500
+++ linux-2.4.20-usbboot/arch/ia64/defconfig	2003-01-30 12:18:13.000000000 =
-0500
@@ -848,6 +848,7 @@
 # CONFIG_USB_BLUETOOTH is not set
 # CONFIG_USB_STORAGE is not set
 # CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_BOOT is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
diff -urN linux-2.4.20/arch/parisc/defconfig linux-2.4.20-usbboot/arch/pari=
sc/defconfig
--- linux-2.4.20/arch/parisc/defconfig	2002-11-28 18:53:10.000000000 -0500
+++ linux-2.4.20-usbboot/arch/parisc/defconfig	2003-01-30 12:18:13.00000000=
0 -0500
@@ -772,6 +772,7 @@
 # CONFIG_USB_BLUETOOTH is not set
 # CONFIG_USB_STORAGE is not set
 # CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_BOOT is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
diff -urN linux-2.4.20/arch/ppc/defconfig linux-2.4.20-usbboot/arch/ppc/def=
config
--- linux-2.4.20/arch/ppc/defconfig	2002-11-28 18:53:11.000000000 -0500
+++ linux-2.4.20-usbboot/arch/ppc/defconfig	2003-01-30 12:18:13.000000000 -=
0500
@@ -934,6 +934,7 @@
 # CONFIG_USB_MIDI is not set
 # CONFIG_USB_STORAGE is not set
 # CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_BOOT is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
 # CONFIG_USB_STORAGE_ISD200 is not set
diff -urN linux-2.4.20/arch/sparc64/defconfig linux-2.4.20-usbboot/arch/spa=
rc64/defconfig
--- linux-2.4.20/arch/sparc64/defconfig	2002-11-28 18:53:12.000000000 -0500
+++ linux-2.4.20-usbboot/arch/sparc64/defconfig	2003-01-30 12:18:13.0000000=
00 -0500
@@ -779,6 +779,7 @@
 CONFIG_USB_MIDI=3Dm
 CONFIG_USB_STORAGE=3Dm
 # CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_BOOT is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 CONFIG_USB_STORAGE_FREECOM=3Dy
 CONFIG_USB_STORAGE_ISD200=3Dy
diff -urN linux-2.4.20/Documentation/Configure.help linux-2.4.20-usbboot/Do=
cumentation/Configure.help
--- linux-2.4.20/Documentation/Configure.help	2002-11-28 18:53:08.000000000=
 -0500
+++ linux-2.4.20-usbboot/Documentation/Configure.help	2003-01-30 12:18:13.0=
00000000 -0500
@@ -24374,6 +24374,13 @@
   brave people.  System crashes and other bad things are likely to occur i=
f
   you use this driver.  If in doubt, select N.
=20
+USB Boot Device Support
+CONFIG_USB_STORAGE_BOOT
+  This option will load the USB controller and USB storage device drivers
+  earlier in the boot process.  This enables systems which want to boot
+  off of a USB device (like a USB HardDisk) to detect the device before
+  trying to mount root, thus avoiding a kernel panic.
+
 Winbond W83977AF IrDA Device Driver
 CONFIG_WINBOND_FIR
   Say Y here if you want to build IrDA support for the Winbond
diff -urN linux-2.4.20/drivers/usb/Config.in linux-2.4.20-usbboot/drivers/u=
sb/Config.in
--- linux-2.4.20/drivers/usb/Config.in	2002-11-28 18:53:14.000000000 -0500
+++ linux-2.4.20-usbboot/drivers/usb/Config.in	2003-01-30 12:18:13.00000000=
0 -0500
@@ -39,6 +39,9 @@
    fi
    dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_US=
B $CONFIG_SCSI
       dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DE=
BUG $CONFIG_USB_STORAGE
+      if [ "$CONFIG_USB_STORAGE" =3D "y" ] ; then
+         dep_mbool '    USB Boot Device Support' CONFIG_USB_STORAGE_BOOT $=
CONFIG_USB_STORAGE
+      fi
       dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_=
USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_=
FREECOM  $CONFIG_USB_STORAGE
       dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_IS=
D200 $CONFIG_USB_STORAGE
diff -urN linux-2.4.20/drivers/usb/storage/usb.c linux-2.4.20-usbboot/drive=
rs/usb/storage/usb.c
--- linux-2.4.20/drivers/usb/storage/usb.c	2002-11-28 18:53:15.000000000 -0=
500
+++ linux-2.4.20-usbboot/drivers/usb/storage/usb.c	2003-01-30 12:18:13.0000=
00000 -0500
@@ -1164,5 +1164,10 @@
 	}
 }
=20
-module_init(usb_stor_init);
-module_exit(usb_stor_exit);
+#ifdef CONFIG_USB_STORAGE_BOOT
+   __initcall(usb_stor_init);
+#else
+   module_init(usb_stor_init);
+   module_exit(usb_stor_exit);
+#endif
+	   =20
diff -urN linux-2.4.20/drivers/usb/usb.c linux-2.4.20-usbboot/drivers/usb/u=
sb.c
--- linux-2.4.20/drivers/usb/usb.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4.20-usbboot/drivers/usb/usb.c	2003-01-30 12:18:13.000000000 -0=
500
@@ -2373,8 +2373,12 @@
 	usb_hub_cleanup();
 }
=20
-module_init(usb_init);
-module_exit(usb_exit);
+#ifdef CONFIG_USB_STORAGE_BOOT
+   __initcall(usb_init);
+#else
+   module_init(usb_init);
+   module_exit(usb_exit);
+#endif
=20
 /*
  * USB may be built into the kernel or be built as modules.

--=-Fdp7LEyonpPzyzsYK074--

