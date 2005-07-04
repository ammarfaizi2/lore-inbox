Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVGDJzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVGDJzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 05:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVGDJzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 05:55:12 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:7396 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261591AbVGDJvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 05:51:23 -0400
Date: Mon, 4 Jul 2005 11:49:51 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes: s/menu/menuconfig/
In-Reply-To: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041134410.3798@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2: The USB menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

This patch is designed for 2.6.12; the patch for .13-rc1 will be posted
as a reply.



--- a/./drivers/usb/net/Kconfig	2005-06-19 14:17:06.000000000 +0200
+++ b/./drivers/usb/net/Kconfig	2005-07-04 11:27:11.000000000 +0200
@@ -2,10 +2,13 @@
 # USB Network devices configuration
 #
 comment "Networking support is needed for USB Network Adapter support"
-	depends on USB && !NET
+	depends on !NET
 
-menu "USB Network Adapters"
-	depends on USB && NET
+menuconfig USB_NET_DEVICES
+	bool "USB Network Adapters"
+	depends on NET
+
+if USB_NET_DEVICES
 
 config USB_CATC
 	tristate "USB CATC NetMate-based Ethernet device support (EXPERIMENTAL)"
@@ -308,4 +311,4 @@ config USB_ZD1201
 	  To compile this driver as a module, choose M here: the
 	  module will be called zd1201.
 
-endmenu
+endif
--- a/./drivers/usb/input/Kconfig	2005-05-02 02:25:51.000000000 +0200
+++ b/./drivers/usb/input/Kconfig	2005-07-04 11:16:26.000000000 +0200
@@ -2,11 +2,9 @@
 # USB Input driver configuration
 #
 comment "USB Input Devices"
-	depends on USB
 
 config USB_HID
 	tristate "USB Human Interface Device (full HID) support"
-	depends on USB
 	---help---
 	  Say Y here if you want full HID support to connect keyboards,
 	  mice, joysticks, graphic tablets, or any other HID based devices
--- a/./drivers/usb/Kconfig	2005-06-19 14:17:02.000000000 +0200
+++ b/./drivers/usb/Kconfig	2005-07-04 11:43:31.000000000 +0200
@@ -2,8 +2,6 @@
 # USB device configuration
 #
 
-menu "USB support"
-
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
 # NOTE:  SL-811 option should be board-specific ...
@@ -29,9 +27,12 @@ config USB_ARCH_HAS_OHCI
 	# more:
 	default PCI
 
+comment "USB (host side) may require PCI"
+	depends on !USB_ARCH_HAS_HCD && !PCI
+
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
-config USB
-	tristate "Support for Host-side USB"
+menuconfig USB
+	tristate "USB (host side)"
 	depends on USB_ARCH_HAS_HCD
 	---help---
 	  Universal Serial Bus (USB) is a specification for a serial bus
@@ -65,6 +66,8 @@ config USB
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbcore.
 
+if USB
+
 source "drivers/usb/core/Kconfig"
 
 source "drivers/usb/host/Kconfig"
@@ -84,11 +87,10 @@ source "drivers/usb/net/Kconfig"
 source "drivers/usb/mon/Kconfig"
 
 comment "USB port drivers"
-	depends on USB
 
 config USB_USS720
 	tristate "USS720 parport driver"
-	depends on USB && PARPORT
+	depends on PARPORT
 	select PARPORT_NOT_PC
 	---help---
 	  This driver is for USB parallel port adapters that use the Lucent
@@ -121,7 +123,7 @@ source "drivers/usb/misc/Kconfig"
 
 source "drivers/usb/atm/Kconfig"
 
-source "drivers/usb/gadget/Kconfig"
+endif
 
-endmenu
+source "drivers/usb/gadget/Kconfig"
 
--- a/./drivers/usb/gadget/Kconfig	2005-06-19 14:17:04.000000000 +0200
+++ b/./drivers/usb/gadget/Kconfig	2005-07-04 11:26:11.000000000 +0200
@@ -12,10 +12,8 @@
 # With help from a special transceiver and a "Mini-AB" jack, systems with
 # both kinds of controller can also support "USB On-the-Go" (CONFIG_USB_OTG).
 #
-menu "USB Gadget Support"
-
-config USB_GADGET
-	tristate "Support for USB Gadgets"
+menuconfig USB_GADGET
+	tristate "USB Gadgets (device side)"
 	help
 	   USB is a master/slave protocol, organized with one master
 	   host (such as a PC) controlling up to 127 peripheral devices.
@@ -385,5 +383,3 @@ config USB_G_SERIAL
 # - none yet
 
 endchoice
-
-endmenu
--- a/./drivers/usb/serial/Kconfig	2005-07-04 11:10:43.000000000 +0200
+++ b/./drivers/usb/serial/Kconfig	2005-07-04 11:19:53.000000000 +0200
@@ -4,7 +4,6 @@
 
 menuconfig USB_SERIAL
 	tristate "USB Serial Converter support"
-	depends on USB
 	---help---
 	  Say Y here if you have a USB device that provides normal serial
 	  ports, or acts like a serial device, and you want to connect it to
-- 
Top 100 things you don't want the sysadmin to say:
39. It is only a minor upgrade, the system should be back up in
    a few hours.  ( This is said on a monday afternoon.)
