Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUCCRUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 12:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUCCRUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 12:20:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:25807 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262520AbUCCRUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 12:20:04 -0500
Date: Wed, 3 Mar 2004 09:19:49 -0800
From: Greg KH <greg@kroah.com>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] USB_GADGET depends on USB
Message-ID: <20040303171947.GA27070@kroah.com>
References: <20040303135756.GH7223@gruby.cs.net.pl> <20040303152738.GH25687@kroah.com> <20040303154547.GK7223@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303154547.GK7223@gruby.cs.net.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 04:45:47PM +0100, Jakub Bogusz wrote:
> On Wed, Mar 03, 2004 at 07:27:40AM -0800, Greg KH wrote:
> > On Wed, Mar 03, 2004 at 02:57:56PM +0100, Jakub Bogusz wrote:
> > > Up to current cset it's possible to select USB_GADGET even if USB is
> > > disabled (causing only compilation errors). This patch adds depends
> > > rules to disallow USB_GADGET if USB is not enabled (similar to those
> > > found in other drivers/usb/*/Kconfig files).
> > 
> > But why would you want to do that?  You can have a box with USB gadget
> > support but not USB "host" support on it just fine.
> > 
> > This patch is not correct, nor needed.
> 
> Now I know, David Brownell already explained it to me.
> 
> It was because make (old)config) asks questions about USB_GADGET,
> USB_ETH, USB_FILE_STORAGE, USB_G_SERIAL, USB_ZERO, USB_GADGETFS even on
> platforms where no USB peripheral controller is available (like sparc32) -
> which make no sense as none of them can be built without any
> CONFIG_USB_GADGET_*.
> These options could be omitted on such platforms...

Hm, does the following patch help this any?  I don't see that it should,
but who knows...

thanks,

greg k-h

# USB Gadget: clean up the Kconfig dependancies a bit more.

diff -Nru a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
--- a/drivers/usb/gadget/Kconfig	Wed Mar  3 09:17:12 2004
+++ b/drivers/usb/gadget/Kconfig	Wed Mar  3 09:17:12 2004
@@ -42,7 +42,7 @@
 
 config USB_GADGET_NET2280
 	boolean "NetChip 2280"
-	depends on PCI
+	depends on USB_GADGET && PCI
 	help
 	   NetChip 2280 is a PCI based USB peripheral controller which
 	   supports both full and high speed USB 2.0 data transfers.  
@@ -62,7 +62,7 @@
 
 config USB_GADGET_PXA2XX
 	boolean "PXA 2xx or IXP 42x"
-	depends on ARCH_PXA || ARCH_IXP425
+	depends on USB_GADGET && (ARCH_PXA || ARCH_IXP425)
 	help
 	   Intel's PXA 2xx series XScale ARM-5TE processors include
 	   an integrated full speed USB 1.1 device controller.  The
@@ -91,7 +91,7 @@
 
 config USB_GADGET_GOKU
 	boolean "Toshiba TC86C001 'Goku-S'"
-	depends on PCI
+	depends on USB_GADGET && PCI
 	help
 	   The Toshiba TC86C001 is a PCI device which includes controllers
 	   for full speed USB devices, IDE, I2C, SIO, plus a USB host (OHCI).
@@ -111,7 +111,7 @@
 # this could be built elsewhere (doesn't yet exist)
 config USB_GADGET_SA1100
 	boolean "SA 1100"
-	depends on ARCH_SA1100
+	depends on USB_GADGET && ARCH_SA1100
 	help
 	   Intel's SA-1100 is an ARM-4 processor with an integrated
 	   full speed USB 1.1 device controller.
@@ -139,7 +139,7 @@
 
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
-	depends on EXPERIMENTAL
+	depends on USB_GADGET && EXPERIMENTAL
 	help
 	  Gadget Zero is a two-configuration device.  It either sinks and
 	  sources bulk data; or it loops back a configurable number of
@@ -164,7 +164,7 @@
 
 config USB_ETH
 	tristate "Ethernet Gadget"
-	depends on NET
+	depends on USB_GADGET && NET
 	help
 	  This driver implements Ethernet style communication, in either
 	  of two ways:
@@ -192,7 +192,7 @@
 
 config USB_GADGETFS
 	tristate "Gadget Filesystem (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on USB_GADGET && EXPERIMENTAL
 	help
 	  This driver provides a filesystem based API that lets user mode
 	  programs implement a single-configuration USB device, including
@@ -206,7 +206,7 @@
 config USB_FILE_STORAGE
 	tristate "File-backed Storage Gadget (DEVELOPMENT)"
 	# we don't support the SA1100 because of its limitations
-	depends on USB_GADGET_SA1100 = n
+	depends on USB_GADGET && USB_GADGET_SA1100 = n
 	help
 	  The File-backed Storage Gadget acts as a USB Mass Storage
 	  disk drive.  As its storage repository it can use a regular
@@ -228,6 +228,7 @@
 
 config USB_G_SERIAL
 	tristate "Serial Gadget"
+	depends on USB_GADGET
 	help
 	  The Serial Gadget talks to the Linux-USB generic serial driver.
 
