Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTKWRYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 12:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTKWRYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 12:24:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25594 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263173AbTKWRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 12:24:03 -0500
Date: Sun, 23 Nov 2003 18:23:56 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: [2.6 patch] improce USB Gadget Kconfig
Message-ID: <20031123172356.GB16828@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains small changes to the USB Gadget Kconfig.

The main change is that multiple modular peripheral controllers are no 
longer allowed (currently only one is there, but this may change).

cu
Adrian

--- linux-2.6.0-test9-mm4/drivers/usb/gadget/Kconfig.old	2003-11-23 17:17:51.000000000 +0100
+++ linux-2.6.0-test9-mm4/drivers/usb/gadget/Kconfig	2003-11-23 17:52:24.000000000 +0100
@@ -3,10 +3,9 @@
 #    (a) a peripheral controller, and
 #    (b) the gadget driver using it.
 #
-# for 2.5 kbuild, drivers/usb/gadget/Kconfig
 # source this at the end of drivers/usb/Kconfig
 #
-menuconfig USB_GADGET
+config USB_GADGET
 	tristate "Support for USB Gadgets"
 	depends on EXPERIMENTAL
 	help
@@ -32,16 +31,24 @@
 	   If in doubt, say "N" and don't enable these drivers; most people
 	   don't have this kind of hardware (except maybe inside Linux PDAs).
 
+menu "USB Gadget options"
+	depends on USB_GADGET!=n
+
 #
 # USB Peripheral Controller Support
 #
+
+#
+# only one gadget controller driver, linked statically or as a module
+# (depending on whether USB_GADGET is y or m)
+#
+
 choice
 	prompt "USB Peripheral Controller Support"
-	depends on USB_GADGET
 
-config USB_NET2280
-	tristate "NetChip 2280 USB Peripheral Controller"
-	depends on PCI && USB_GADGET
+config USB_TMP_NET2280
+	bool "NetChip 2280 USB Peripheral Controller"
+	depends on PCI
 	help
 	   NetChip 2280 is a PCI based USB peripheral controller which
 	   supports both full and high speed USB 2.0 data transfers.  
@@ -56,19 +63,28 @@
 
 endchoice
 
+config USB_NET2280
+	tristate
+	default USB_TMP_NET2280 && USB_GADGET
+
+
 #
 # USB Gadget Drivers
 #
+
+#
+# at most one gadget driver statically linked,
+# OR any number of gadget drivers, linked as modules
+#
+
 choice
 	prompt "USB Gadget Drivers"
 	depends on USB_GADGET
 	default USB_ETH
 
-# FIXME want a cleaner dependency/config approach for drivers.
-
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
-	depends on USB_GADGET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100)
+	depends on USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100
 	help
 	  Gadget Zero is a two-configuration device.  It either sinks and
 	  sources bulk data; or it loops back a configurable number of
@@ -110,7 +126,7 @@
 
 config USB_ETH
 	tristate "Ethernet Gadget"
-	depends on USB_GADGET && NET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100)
+	depends on NET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100)
 	help
 	  This driver implements Ethernet style communication, in either
 	  of two ways:
@@ -155,7 +171,7 @@
 
 config USB_GADGETFS
 	tristate "Gadget Filesystem (EXPERIMENTAL)"
-	depends on USB_GADGET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX) && EXPERIMENTAL
+	depends on (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX) && EXPERIMENTAL
 	help
 	  This driver provides a filesystem based API that lets user mode
 	  programs implement a single-configuration USB device, including
@@ -179,4 +195,4 @@
 
 endchoice
 
-# endmenuconfig
+endmenu
