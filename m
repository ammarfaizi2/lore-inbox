Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274862AbTGaTu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269036AbTGaTu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:50:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:22987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274876AbTGaTuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:50:50 -0400
Date: Thu, 31 Jul 2003 12:50:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Charles Lepple" <clepple@ghz.cc>, Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reorganize USB submenu's
Message-Id: <20030731125032.785ffba1.shemminger@osdl.org>
In-Reply-To: <23979.216.12.38.216.1059672599.squirrel@www.ghz.cc>
References: <20030731101144.32a3f0d7.shemminger@osdl.org>
	<23979.216.12.38.216.1059672599.squirrel@www.ghz.cc>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here is a second try.
	- Devices in submenus
	- Gadget sub-menu fixed now independent of USB
	  and has correct exposing.
	- Gadget was using choice incorrectly, there were cases were if
	  gadget was not a module it would only let you choose one menu item.
	- USB serial debugging can be enabled if module

This is against 2.6.0-test2

diff -urN -X dontdiff linux-2.5/drivers/usb/gadget/Kconfig usb/drivers/usb/gadget/Kconfig
--- linux-2.5/drivers/usb/gadget/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/gadget/Kconfig	2003-07-31 12:45:04.000000000 -0700
@@ -35,9 +35,6 @@
 #
 # USB Peripheral Controller Support
 #
-choice
-	prompt "USB Peripheral Controller Support"
-	depends on USB_GADGET
 
 config USB_NET2280
 	tristate "NetChip 2280 USB Peripheral Controller"
@@ -54,21 +51,23 @@
 	   dynamically linked module called "net2280" and force all
 	   gadget drivers to also be dynamically linked.
 
-endchoice
 
 #
 # USB Gadget Drivers
 #
-choice
-	prompt "USB Gadget Drivers"
+menu "USB Gadget Drivers"
 	depends on USB_GADGET
-	default USB_ETH
 
-# FIXME want a cleaner dependency/config approach for drivers.
+config USB_GADGET_CONTROL
+	bool
+	default y if USB_GADGET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA250 || USB_SA1100)
+
+comment "USB Gadgets need peripheral controller"
+	depends on !USB_GADGET_CONTROL
 
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
-	depends on USB_GADGET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA250 || USB_SA1100)
+	depends on USB_GADGET_CONTROL
 	help
 	  Gadget Zero is a two-configuration device.  It either sinks and
 	  sources bulk data; or it loops back a configurable number of
@@ -110,7 +109,7 @@
 
 config USB_ETH
 	tristate "Ethernet Gadget"
-	depends on USB_GADGET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA250 || USB_SA1100)
+	depends on USB_GADGET_CONTROL
 	help
 	  This driver implements the "Communication Device Class" (CDC)
 	  Ethernet Control Model.  That protocol is often avoided with pure
@@ -147,6 +146,6 @@
 	depends on USB_ETH && USB_SA1100
 	default y
 
-endchoice
+endmenu
 
 # endmenuconfig
diff -urN -X dontdiff linux-2.5/drivers/usb/image/Kconfig usb/drivers/usb/image/Kconfig
--- linux-2.5/drivers/usb/image/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/image/Kconfig	2003-07-31 12:10:51.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Imageing devices configuration
 #
-comment "USB Imaging devices"
+menu "USB Imaging devices"
 	depends on USB
 
 config USB_MDC800
@@ -53,3 +53,4 @@
 	  The scanner will be accessible as a SCSI device.
 	  This can be compiled as a module, called hpusbscsi.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/input/Kconfig usb/drivers/usb/input/Kconfig
--- linux-2.5/drivers/usb/input/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/input/Kconfig	2003-07-31 12:36:02.000000000 -0700
@@ -1,7 +1,8 @@
 #
 # USB Input driver configuration
 #
-comment "USB Human Interface Devices (HID)"
+
+menu "USB Input devices"
 	depends on USB
 
 config USB_HID
@@ -90,12 +91,9 @@
 
 	  If unsure, say Y.
 
-menu "USB HID Boot Protocol drivers"
-	depends on USB!=n && USB_HID!=y
-
 config USB_KBD
 	tristate "USB HIDBP Keyboard (simple Boot) support"
-	depends on USB && INPUT
+	depends on USB && INPUT && USB_HID!=y
 	---help---
 	  Say Y here only if you are absolutely sure that you don't want
 	  to use the generic HID driver for your USB keyboard and prefer
@@ -113,7 +111,7 @@
 
 config USB_MOUSE
 	tristate "USB HIDBP Mouse (simple Boot) support"
-	depends on USB && INPUT
+	depends on USB && INPUT && USB_HID!=y
 	---help---
 	  Say Y here only if you are absolutely sure that you don't want
 	  to use the generic HID driver for your USB keyboard and prefer
@@ -129,8 +127,6 @@
 
 	  If even remotely unsure, say N.
 
-endmenu
-
 config USB_AIPTEK
 	tristate "Aiptek 6000U/8000U tablet support"
 	depends on USB && INPUT
@@ -205,3 +201,4 @@
 	  The module will be called xpad.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/media/Kconfig usb/drivers/usb/media/Kconfig
--- linux-2.5/drivers/usb/media/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/media/Kconfig	2003-07-31 11:48:11.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Multimedia device configuration
 #
-comment "USB Multimedia devices"
+menu "USB Multimedia devices"
 	depends on USB
 
 config USB_DABUSB
@@ -194,3 +194,4 @@
 	  The module will be called stv680. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/misc/Kconfig usb/drivers/usb/misc/Kconfig
--- linux-2.5/drivers/usb/misc/Kconfig	2003-06-05 10:04:41.000000000 -0700
+++ usb/drivers/usb/misc/Kconfig	2003-07-31 11:48:39.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Miscellaneous driver configuration
 #
-comment "USB Miscellaneous drivers"
+menu "USB Miscellaneous drivers"
 	depends on USB
 
 config USB_EMI26
@@ -117,4 +117,4 @@
 
 	  See <http://www.linux-usb.org/usbtest> for more information,
 	  including sample test device firmware and "how to use it".
-
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/net/Kconfig usb/drivers/usb/net/Kconfig
--- linux-2.5/drivers/usb/net/Kconfig	2003-06-20 09:49:37.000000000 -0700
+++ usb/drivers/usb/net/Kconfig	2003-07-31 12:45:59.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Network devices configuration
 #
-comment "USB Network adaptors"
+menu "USB Network adaptors"
 	depends on USB
 
 comment "Networking support is needed for USB Networking device support"
@@ -266,3 +266,4 @@
 	  IEEE 802 "local assignment" bit is set in the address, a "usbX"
 	  name is used instead.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/serial/Kconfig usb/drivers/usb/serial/Kconfig
--- linux-2.5/drivers/usb/serial/Kconfig	2003-06-05 10:04:41.000000000 -0700
+++ usb/drivers/usb/serial/Kconfig	2003-07-31 12:38:57.000000000 -0700
@@ -2,10 +2,7 @@
 # USB Serial device configuration
 #
 
-menu "USB Serial Converter support"
-	depends on USB!=n
-
-config USB_SERIAL
+menuconfig  USB_SERIAL
 	tristate "USB Serial Converter support"
 	depends on USB
 	---help---
@@ -24,7 +21,7 @@
 
 config USB_SERIAL_DEBUG
 	bool "USB Serial Converter verbose debug"
-	depends on USB_SERIAL=y
+	depends on USB_SERIAL
 	help
 	  Say Y here if you want verbose debug messages from the USB Serial
 	  Drivers sent to the kernel debug log.
@@ -438,8 +435,7 @@
 
 config USB_EZUSB
 	bool
-	depends on USB_SERIAL_KEYSPAN_PDA || USB_SERIAL_XIRCOM || USB_SERIAL_KEYSPAN || USB_SERIAL_WHITEHEAT
+	depends on USB_SERIAL && (USB_SERIAL_KEYSPAN_PDA || USB_SERIAL_XIRCOM || USB_SERIAL_KEYSPAN || USB_SERIAL_WHITEHEAT)
 	default y
 
-endmenu
-
+# endmenuconfig
diff -urN -X dontdiff linux-2.5/drivers/usb/storage/Kconfig usb/drivers/usb/storage/Kconfig
--- linux-2.5/drivers/usb/storage/Kconfig	2003-06-05 10:04:41.000000000 -0700
+++ usb/drivers/usb/storage/Kconfig	2003-07-31 12:42:01.000000000 -0700
@@ -1,10 +1,11 @@
 #
 # USB Storage driver configuration
 #
+
 comment "SCSI support is needed for USB Storage"
 	depends on USB && SCSI=n
 
-config USB_STORAGE
+menuconfig USB_STORAGE
 	tristate "USB Mass Storage support"
 	depends on USB && SCSI
 	---help---
@@ -92,3 +93,4 @@
 	  Say Y here to include additional code to support the Lexar Jumpshot
 	  USB CompactFlash reader.
 
+# endmenuconfig
