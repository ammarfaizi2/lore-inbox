Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUKCLwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUKCLwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUKCLv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 06:51:59 -0500
Received: from the.earth.li ([193.201.200.66]:29331 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S261559AbUKCLvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 06:51:42 -0500
Date: Wed, 3 Nov 2004 11:51:42 +0000
From: Jonathan McDowell <noodles@earth.li>
To: David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: KC2190 support for usbnet.
Message-ID: <20041103115142.GZ31945@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds support for the KC2190 usb-to-usb networking
device; the version I have reports itself as:

Bus 001 Device 003: ID 050f:0190 KC Technology, Inc.

I was under the impression that support for this had been added a long
time ago, but searching through old kernel versions all I could find was
a comment about the chip, with no support. Patch is against 2.6.9 but is
pretty minimal.

I don't have a Windows box around to test interoperability with that
driver, but the patch appears to make it work perfectly between 2 Linux
boxes.

J.

Signed-off-by: Jonathan McDowell <noodles@earth.li>

--------
diff -u linux-2.6.9.orig/drivers/usb/net/Kconfig linux-2.6.9/drivers/usb/net/Kconfig
--- linux-2.6.9.orig/drivers/usb/net/Kconfig	2004-06-16 06:19:43.000000000 +0100
+++ linux-2.6.9/drivers/usb/net/Kconfig	2004-11-03 11:06:06.000000000 +0000
@@ -185,6 +185,14 @@
 	  Choose this option if you're using a host-to-host cable
 	  with one of these chips.
 
+config USB_KC2190
+	boolean "KT Technology KC2190 based cables (InstaNet)"
+	default y
+	depends on USB_USBNET && EXPERIMENTAL
+	help
+	  Choose this option if you're using a host-to-host cable
+	  with one of these chips.
+
 comment "Intelligent USB Devices/Gadgets"
 	depends on USB_USBNET
 
diff -u linux-2.6.9.orig/drivers/usb/net/usbnet.c linux-2.6.9/drivers/usb/net/usbnet.c
--- linux-2.6.9.orig/drivers/usb/net/usbnet.c	2004-10-11 17:37:08.000000000 +0100
+++ linux-2.6.9/drivers/usb/net/usbnet.c	2004-11-03 11:42:25.000000000 +0000
@@ -31,6 +31,7 @@
  *	- GeneSys GL620USB-A
  *	- NetChip 1080 (interoperates with NetChip Win32 drivers)
  *	- Prolific PL-2301/2302 (replaces "plusb" driver)
+ *	- KC Technology KC2190
  *
  *   + Smart USB devices can support such links directly, using Internet
  *     standard protocols instead of proprietary host-to-device links.
@@ -106,6 +107,7 @@
  * 22-aug-2003	AX8817X support (Dave Hollis).
  * 14-jun-2004  Trivial patch for AX8817X based Buffalo LUA-U2-KTX in Japan
  *		(Neil Bortnak)
+ * 03-nov-2004	Trivial patch for KC2190 (KC-190) chip. (Jonathan McDowell)
  *
  *-------------------------------------------------------------------------*/
 
@@ -134,7 +136,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 
-#define DRIVER_VERSION		"25-Aug-2003"
+#define DRIVER_VERSION		"03-Nov-2004"
 
 
 /*-------------------------------------------------------------------------*/
@@ -2159,6 +2161,13 @@
 
 #endif /* CONFIG_USB_PL2301 */
 
+
+#ifdef CONFIG_USB_KC2190
+#define HAVE_HARDWARE
+static const struct driver_info kc2190_info = {
+	.description =  "KC Technology KC-190",
+};
+#endif /* CONFIG_USB_KC2190 */
 
 
 #ifdef	CONFIG_USB_ARMLINUX
@@ -3292,6 +3301,13 @@
 },
 #endif
 
+#ifdef CONFIG_USB_KC2190
+{
+	USB_DEVICE (0x050f, 0x0190),	// KC-190
+	.driver_info =	(unsigned long) &kc2190_info,
+},
+#endif
+
 #ifdef	CONFIG_USB_RNDIS
 {
 	/* RNDIS is MSFT's un-official variant of CDC ACM */
--------

-- 
/-\                             |  If I, um, err. Yeah, it probably
|@/  Debian GNU/Linux Developer |    rounds down. -- Simon Huggins
\-                              |
